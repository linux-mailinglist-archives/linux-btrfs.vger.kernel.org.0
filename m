Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDAFCBF13C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 13:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfIZLYY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 07:24:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:42638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbfIZLYY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 07:24:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D98CBAE0C;
        Thu, 26 Sep 2019 11:24:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E5AE9DA7D9; Thu, 26 Sep 2019 13:24:41 +0200 (CEST)
Date:   Thu, 26 Sep 2019 13:24:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5 5/7] btrfs-progs: add xxhash64 to mkfs
Message-ID: <20190926112441.GN2751@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190925133728.18027-1-jthumshirn@suse.de>
 <20190925133728.18027-6-jthumshirn@suse.de>
 <24e53bb4-7dd0-7016-8e06-ba271cdeb6c1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24e53bb4-7dd0-7016-8e06-ba271cdeb6c1@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 26, 2019 at 12:06:53PM +0200, Johannes Thumshirn wrote:
> On 25/09/2019 15:37, Johannes Thumshirn wrote:
> > Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> > ---
> >  Makefile                  |  3 ++-
> >  cmds/inspect-dump-super.c |  1 +
> >  crypto/hash.c             | 17 +++++++++++++++++
> >  crypto/hash.h             | 10 ++++++++++
> >  ctree.h                   |  3 ++-
> >  disk-io.c                 |  3 +++
> >  mkfs/main.c               |  3 +++
> >  7 files changed, 38 insertions(+), 2 deletions(-)
> >  create mode 100644 crypto/hash.c
> >  create mode 100644 crypto/hash.h
> > 
> > diff --git a/Makefile b/Makefile
> > index 370e0c37ff65..45530749e2b9 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -151,7 +151,8 @@ cmds_objects = cmds/subvolume.o cmds/filesystem.o cmds/device.o cmds/scrub.o \
> >  	       mkfs/common.o check/mode-common.o check/mode-lowmem.o
> >  libbtrfs_objects = send-stream.o send-utils.o kernel-lib/rbtree.o btrfs-list.o \
> >  		   kernel-lib/crc32c.o common/messages.o \
> > -		   uuid-tree.o utils-lib.o common/rbtree-utils.o
> > +		   uuid-tree.o utils-lib.o common/rbtree-utils.o \
> > +		   crypto/hash.o crypto/xxhash.o
> >  libbtrfs_headers = send-stream.h send-utils.h send.h kernel-lib/rbtree.h btrfs-list.h \
> >  	       kernel-lib/crc32c.h kernel-lib/list.h kerncompat.h \
> >  	       kernel-lib/radix-tree.h kernel-lib/sizes.h kernel-lib/raid56.h \
> > diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
> > index bf380ad2b56a..73e986ed8ee8 100644
> > --- a/cmds/inspect-dump-super.c
> > +++ b/cmds/inspect-dump-super.c
> > @@ -315,6 +315,7 @@ static bool is_valid_csum_type(u16 csum_type)
> >  {
> >  	switch (csum_type) {
> >  	case BTRFS_CSUM_TYPE_CRC32:
> > +	case BTRFS_CSUM_TYPE_XXHASH:
> >  		return true;
> >  	default:
> >  		return false;
> > diff --git a/crypto/hash.c b/crypto/hash.c
> > new file mode 100644
> > index 000000000000..58a3890bd467
> > --- /dev/null
> > +++ b/crypto/hash.c
> > @@ -0,0 +1,17 @@
> > +#include "crypto/hash.h"
> > +#include "crypto/xxhash.h"
> > +
> > +int hash_xxhash(const u8 *buf, size_t length, u8 *out)
> > +{
> > +	XXH64_hash_t hash;
> > +
> > +	hash = XXH64(buf, length, 0);
> > +	/*
> > +	 * NOTE: we're not taking the canonical form here but the plain hash to
> > +	 * be compatible with the kernel implementation!
> > +	 */
> > +	memcpy(out, &hash, 8);
> > +
> > +	return 0;
> > +}
> > +
> > diff --git a/crypto/hash.h b/crypto/hash.h
> > new file mode 100644
> > index 000000000000..45c1ef17bc57
> > --- /dev/null
> > +++ b/crypto/hash.h
> > @@ -0,0 +1,10 @@
> > +#ifndef CRYPTO_HASH_H
> > +#define CRYPTO_HASH_H
> > +
> > +#include "../kerncompat.h"
> > +
> > +#define CRYPTO_HASH_SIZE_MAX	32
> > +
> > +int hash_xxhash(const u8 *buf, size_t length, u8 *out);
> > +
> > +#endif
> > diff --git a/ctree.h b/ctree.h
> > index f70271dc658e..144c89eb4a36 100644
> > --- a/ctree.h
> > +++ b/ctree.h
> > @@ -166,7 +166,8 @@ struct btrfs_free_space_ctl;
> >  
> >  /* csum types */
> >  enum btrfs_csum_type {
> > -	BTRFS_CSUM_TYPE_CRC32   = 0,
> > +	BTRFS_CSUM_TYPE_CRC32	= 0,
> > +	BTRFS_CSUM_TYPE_XXHASH	= 1,
> >  };
> >  
> >  #define BTRFS_EMPTY_DIR_SIZE 0
> > diff --git a/disk-io.c b/disk-io.c
> > index 72c672919cf9..59e297e2039c 100644
> > --- a/disk-io.c
> > +++ b/disk-io.c
> > @@ -34,6 +34,7 @@
> >  #include "print-tree.h"
> >  #include "common/rbtree-utils.h"
> >  #include "common/device-scan.h"
> > +#include "crypto/hash.h"
> >  
> >  /* specified errno for check_tree_block */
> >  #define BTRFS_BAD_BYTENR		(-1)
> > @@ -149,6 +150,8 @@ int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len)
> >  		crc = crc32c(crc, data, len);
> >  		put_unaligned_le32(~crc, out);
> >  		return 0;
> > +	case BTRFS_CSUM_TYPE_XXHASH:
> > +		return hash_xxhash(data, len, out);
> >  	default:
> >  		fprintf(stderr, "ERROR: unknown csum type: %d\n", csum_type);
> >  		ASSERT(0);
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index 04509e788a52..da40e958fe0a 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -393,6 +393,9 @@ static enum btrfs_csum_type parse_csum_type(const char *s)
> >  {
> >  	if (strcasecmp(s, "crc32c") == 0) {
> >  		return BTRFS_CSUM_TYPE_CRC32;
> > +	} else if (strcasecmp(s, "xxhash64") == 0 ||
> > +		   strcasecmp(s, "xxhash") == 0) {
> > +		return BTRFS_CSUM_TYPE_XXHASH;
> >  	} else {
> >  		error("unknown csum type %s", s);
> >  		exit(1);
> > 
> 
> This one lost this hunk in ctree.c:
> 
> diff --git a/ctree.c b/ctree.c
> index 5ad291d0f4ac..91d685ff90a4 100644
> --- a/ctree.c
> +++ b/ctree.c
> @@ -43,6 +43,7 @@ static const struct btrfs_csum {
>         const char name[14];
>  } btrfs_csums[] = {
>         [BTRFS_CSUM_TYPE_CRC32] = { 4, "crc32c" },
> +       [BTRFS_CSUM_TYPE_XXHASH] = { 8, "xxhash64" },
>  };
> 
>  u16 btrfs_super_csum_size(const struct btrfs_super_block *sb)

Folded to the patch and lightly tested. Thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7263E9EAAB
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 16:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfH0OQf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 10:16:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:49060 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727064AbfH0OQe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 10:16:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3DF4ACC1
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 14:16:32 +0000 (UTC)
Subject: Re: [PATCH v2 10/11] btrfs-progs: add xxhash64 as checksum algorithm
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190826114853.14860-1-jthumshirn@suse.de>
 <20190826114853.14860-11-jthumshirn@suse.de>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8fcda19d-bb77-5ad4-da05-723995c3a039@suse.com>
Date:   Tue, 27 Aug 2019 17:16:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826114853.14860-11-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26.08.19 г. 14:48 ч., Johannes Thumshirn wrote:
> From: David Sterba <dsterba@suse.com>
> 
> Add xxhash64 as another checksumming algorithm.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  Makefile                  |  3 ++-
>  cmds/inspect-dump-super.c | 25 ++++++++++++++++---------
>  convert/common.c          |  2 +-
>  convert/main.c            |  2 +-
>  crypto/hash.c             | 16 ++++++++++++++++
>  crypto/hash.h             | 10 ++++++++++
>  crypto/xxhash.c           |  2 +-
>  ctree.h                   | 18 +++++++++++++-----
>  disk-io.c                 |  7 +++++--
>  image/main.c              |  5 +++--
>  mkfs/common.c             | 14 +++++++-------
>  mkfs/main.c               |  6 +++++-
>  12 files changed, 80 insertions(+), 30 deletions(-)
>  create mode 100644 crypto/hash.c
>  create mode 100644 crypto/hash.h
> 
> diff --git a/Makefile b/Makefile
> index 82417d19a9f8..1982e6f5d70e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -151,7 +151,8 @@ cmds_objects = cmds/subvolume.o cmds/filesystem.o cmds/device.o cmds/scrub.o \
>  	       mkfs/common.o check/mode-common.o check/mode-lowmem.o
>  libbtrfs_objects = send-stream.o send-utils.o kernel-lib/rbtree.o btrfs-list.o \
>  		   kernel-lib/crc32c.o common/messages.o \
> -		   uuid-tree.o utils-lib.o common/rbtree-utils.o
> +		   uuid-tree.o utils-lib.o common/rbtree-utils.o \
> +		   crypto/hash.o crypto/xxhash.o
>  libbtrfs_headers = send-stream.h send-utils.h send.h kernel-lib/rbtree.h btrfs-list.h \
>  	       kernel-lib/crc32c.h kernel-lib/list.h kerncompat.h \
>  	       kernel-lib/radix-tree.h kernel-lib/sizes.h kernel-lib/raid56.h \
> diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
> index 58bf82b0bbd3..1001c8aa5c85 100644
> --- a/cmds/inspect-dump-super.c
> +++ b/cmds/inspect-dump-super.c
> @@ -311,6 +311,17 @@ static void print_readable_super_flag(u64 flag)
>  				     super_flags_num, BTRFS_SUPER_FLAG_SUPP);
>  }
>  
> +static bool is_valid_csum_type(u16 csum_type)
> +{
> +	switch (csum_type) {
> +	case BTRFS_CSUM_TYPE_CRC32:
> +	case BTRFS_CSUM_TYPE_XXHASH:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static void dump_superblock(struct btrfs_super_block *sb, int full)
>  {
>  	int i;
> @@ -326,15 +337,11 @@ static void dump_superblock(struct btrfs_super_block *sb, int full)
>  	csum_type = btrfs_super_csum_type(sb);
>  	csum_size = BTRFS_CSUM_SIZE;
>  	printf("csum_type\t\t%hu (", csum_type);
> -	if (csum_type >= ARRAY_SIZE(btrfs_csum_sizes)) {
> +	if (csum_type >= ARRAY_SIZE(btrfs_csums)) {
Why not is_valid_csum_type ?

>  		printf("INVALID");
>  	} else {
> -		if (csum_type == BTRFS_CSUM_TYPE_CRC32) {
> -			printf("crc32c");
> -			csum_size = btrfs_csum_sizes[csum_type];
> -		} else {
> -			printf("unknown");
> -		}
> +		printf("%s", btrfs_csums[csum_type].name);
> +		csum_size = btrfs_csums[csum_type].size;
>  	}
>  	printf(")\n");
>  	printf("csum_size\t\t%llu\n", (unsigned long long)csum_size);
> @@ -342,8 +349,8 @@ static void dump_superblock(struct btrfs_super_block *sb, int full)
>  	printf("csum\t\t\t0x");
>  	for (i = 0, p = sb->csum; i < csum_size; i++)
>  		printf("%02x", p[i]);
> -	if (csum_type != BTRFS_CSUM_TYPE_CRC32 ||
> -	    csum_size != btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32])
> +	if (!is_valid_csum_type(csum_type) ||
> +	    csum_size != btrfs_csums[csum_type].size)

That second check - can it ever trigger? If the csum_type >= ARRAY_SIZE
goes into the else branch then csum_size == btrfs_csums[csum_type].size
so this check is guaranteed to never fail. OTOH, if we print invalid
above then csum_type is guaranteed to be above ARRAY_SIZE(btrfs_csums)
and I thin this guarantees that !is_valid_csum_type(csum_type) is going
to be true e.g. we will print UNKNOWN CSUM type. So I guess a simple

'if (!is_valid_csum_type(csum_type)' will suffice here?


>  		printf(" [UNKNOWN CSUM TYPE OR SIZE]");
>  	else if (check_csum_sblock(sb, csum_size, csum_type))
>  		printf(" [match]");
> diff --git a/convert/common.c b/convert/common.c
> index 8f5fdbf507a4..e479d70f4e9e 100644
> --- a/convert/common.c
> +++ b/convert/common.c
> @@ -223,7 +223,7 @@ static inline int write_temp_extent_buffer(int fd, struct extent_buffer *buf,
>  {
>  	int ret;
>  
> -	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
> +	csum_tree_block_size(buf, btrfs_csums[cfg->csum_type].size, 0,
>  			     cfg->csum_type);
>  
>  	/* Temporary extent buffer is always mapped 1:1 on disk */
> diff --git a/convert/main.c b/convert/main.c
> index 5e6b12431f59..5eb2a59fb68a 100644
> --- a/convert/main.c
> +++ b/convert/main.c
> @@ -1058,7 +1058,7 @@ static int migrate_super_block(int fd, u64 old_bytenr)
>  	BUG_ON(btrfs_super_bytenr(super) != old_bytenr);
>  	btrfs_set_super_bytenr(super, BTRFS_SUPER_INFO_OFFSET);
>  
> -	csum_tree_block_size(buf, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32], 0,
> +	csum_tree_block_size(buf, btrfs_csums[BTRFS_CSUM_TYPE_CRC32].size, 0,
>  			     btrfs_super_csum_type(super));
>  	ret = pwrite(fd, buf->data, BTRFS_SUPER_INFO_SIZE,
>  		BTRFS_SUPER_INFO_OFFSET);
> diff --git a/crypto/hash.c b/crypto/hash.c
> new file mode 100644
> index 000000000000..fda7fc4e9f23
> --- /dev/null
> +++ b/crypto/hash.c
> @@ -0,0 +1,16 @@
> +#include "crypto/hash.h"
> +#include "crypto/xxhash.h"
> +
> +int hash_xxhash(const u8 *buf, size_t length, u8 *out)
> +{
> +	XXH64_hash_t hash;
> +
> +	hash = XXH64(buf, length, 0);
> +	/* NOTE: we're not taking the canonical form here but the plain hash to
> +	 * be compatible with the kernel implementation!
> +	 */
> +	memcpy(out, &hash, 8);
> +
> +	return 0;
> +}
> +
> diff --git a/crypto/hash.h b/crypto/hash.h
> new file mode 100644
> index 000000000000..45c1ef17bc57
> --- /dev/null
> +++ b/crypto/hash.h
> @@ -0,0 +1,10 @@
> +#ifndef CRYPTO_HASH_H
> +#define CRYPTO_HASH_H
> +
> +#include "../kerncompat.h"
> +
> +#define CRYPTO_HASH_SIZE_MAX	32
> +
> +int hash_xxhash(const u8 *buf, size_t length, u8 *out);
> +
> +#endif
> diff --git a/crypto/xxhash.c b/crypto/xxhash.c
> index af9d02795ac6..7f381c8b56a0 100644
> --- a/crypto/xxhash.c
> +++ b/crypto/xxhash.c
> @@ -1018,7 +1018,7 @@ XXH_PUBLIC_API XXH64_hash_t XXH64_hashFromCanonical(const XXH64_canonical_t* src
>  *  New generation hash designed for speed on small keys and vectorization
>  ************************************************************************ */
>  
> -#include "xxh3.h"
> +/* #include "xxh3.h" */

Does that mean progs compilation is broken by the previous patch since
it includes a file which cannot be found?


>  
>  
>  #endif  /* XXH_NO_LONG_LONG */


<snip>

> diff --git a/mkfs/main.c b/mkfs/main.c
> index 075e7e331ab4..c78481da50c2 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -385,6 +385,9 @@ static enum btrfs_csum_type parse_csum_type(const char *s)
>  {
>  	if (strcasecmp(s, "crc32c") == 0) {
>  		return BTRFS_CSUM_TYPE_CRC32;
> +	} else if (strcasecmp(s, "xxhash64") == 0 ||
> +		   strcasecmp(s, "xxhash") == 0) {

Don't we want to be very explicit about only supporting xxhash64, and
not aliasing xxhash to mean xxhash64? I.e remove the xxhash comparison
and consider it invalid.

> +		return BTRFS_CSUM_TYPE_XXHASH;
>  	} else {
>  		error("unknown csum type %s", s);
>  		exit(1);
> @@ -1370,7 +1373,8 @@ raid_groups:
>  			pretty_size(allocation.system));
>  		printf("SSD detected:       %s\n", ssd ? "yes" : "no");
>  		btrfs_parse_features_to_string(features_buf, features);
> -		printf("Incompat features:  %s", features_buf);
> +		printf("Incompat features:  %s\n", features_buf);
> +		printf("Checksum:           %s", btrfs_csums[csum_type].name);
>  		printf("\n");
>  
>  		list_all_devices(root);
> 

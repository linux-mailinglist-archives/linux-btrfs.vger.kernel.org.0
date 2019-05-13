Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 641BE1B692
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 15:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfEMNBN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 09:01:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:42088 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727850AbfEMNBN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 09:01:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02C91AF94
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2019 13:01:12 +0000 (UTC)
Date:   Mon, 13 May 2019 15:01:11 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     dsterba@suse.cz,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 14/17] btrfs: directly call into crypto framework for
 checsumming
Message-ID: <20190513130111.GD18838@x250.microfocus.com>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190510111547.15310-15-jthumshirn@suse.de>
 <20190513130003.GD20156@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190513130003.GD20156@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 13, 2019 at 03:00:03PM +0200, David Sterba wrote:
> On Fri, May 10, 2019 at 01:15:44PM +0200, Johannes Thumshirn wrote:
> > Currently btrfs_csum_data() relied on the crc32c() wrapper around the crypto
> > framework for calculating the CRCs.
> > 
> > As we have our own crypto_shash structure in the fs_info now, we can
> > directly call into the crypto framework without going trough the wrapper.
> > 
> > Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> > ---
> >  fs/btrfs/disk-io.c | 28 ++++++++++++++++++++++++++--
> >  1 file changed, 26 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index fb0b06b7b9f6..0c9ac7b45ce8 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -253,12 +253,36 @@ struct extent_map *btree_get_extent(struct btrfs_inode *inode,
> >  u32 btrfs_csum_data(struct btrfs_fs_info *fs_info, const char *data,
> >  		    u32 seed, size_t len)
> >  {
> > -	return crc32c(seed, data, len);
> > +	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
> > +	u32 *ctx = (u32 *)shash_desc_ctx(shash);
> > +	u32 retval;
> > +	int err;
> > +
> > +	shash->tfm = fs_info->csum_shash;
> > +	shash->flags = 0;
> > +	*ctx = seed;
> > +
> > +	err = crypto_shash_update(shash, data, len);
> > +	ASSERT(err);
> > +
> > +	retval = *ctx;
> > +	barrier_data(ctx);
> > +
> > +	return retval;
> 
> I unfortunatelly had a dive into the crypto API calls and since then I'm
> biased against using it (too much indirection and extra memory
> references). So my idea of this function is:
> 
> switch (fs_info->csum_type) {
> case CRC32:
> 	... calculate crc32c;
> 	break;
> case SHA256:
> 	... calculate sha56;
> 	break;
> }
> 
> with direct calls to the hash primitives rather than thravelling trough
> the shash.

well at least the crc3c2() call we use does nothing else (from
lib/libcrc32c.c):

u32 crc32c(u32 crc, const void *address, unsigned int length)
{
	SHASH_DESC_ON_STACK(shash, tfm);
	u32 ret, *ctx = (u32 *)shash_desc_ctx(shash);
	int err;

	shash->tfm = tfm;
	shash->flags = 0;
	*ctx = crc;

	err = crypto_shash_update(shash, address, length);
	BUG_ON(err);

	ret = *ctx;
	barrier_data(ctx);
	return ret;
}

EXPORT_SYMBOL(crc32c);


-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

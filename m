Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9321B3D8482
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 02:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhG1AMu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 20:12:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:41821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232731AbhG1AMu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 20:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627431167;
        bh=QqJwv8ZePxAvs18rBsaFP6LH3hC+3ug8eLHEErLCiJ4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=P/meSK/Y13O1FtEjZtoNwcP4+VpgDWhQb1V6DE0DryO0JqloIR3S5zIdP2E7JgZSY
         5T+CNdifKgMM+vc477sm/QUFzCvYFAGakh4LaRbmb0cSVjolVhQ6nvSp/J56mSsIl0
         0hnE8rvMhpyDp38tBwvIvdR8X0oEB0ib7kme63lY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MD9X9-1mHZjL1hIX-0096I5; Wed, 28
 Jul 2021 02:12:47 +0200
Subject: Re: [PATCH v2 10/10] btrfs: add and use simple page/bio to
 inode/fs_info helpers
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com
References: <4d3594dcca4dd8a8e58b134409922c2787b6a757.1627300614.git.dsterba@suse.com>
 <20210727150302.21604-1-dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d9072e93-629c-57b9-e857-0cb5495230c5@gmx.com>
Date:   Wed, 28 Jul 2021 08:12:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210727150302.21604-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FiZJ6JmvOfCfS8NQe0IQ5Lw2+rEGJZADHRosRNl/wzTYne9yS6L
 5RQWx1e+BmagZNJZn+/a+MAsrFXoUT5FzfgEO1AiuhVRj5TSqOA1XiBtdhK0DrBGgrA6jXk
 oWI/+PrhqKrxmSnrt15uC9nWgzbAAAorU/Wa+iEjSXEZLQ86e4mLFQWVb9LBLl0OFExYg+q
 g/ekf7IWWMPrJmzLEG/cw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0+1hKn6PRU4=:jwnNYBv+nxPKSaEMxFtlfP
 XN5nJxSQ3PRTREp6jYIFzNoxsuvzX3wlyjLA06oc7ORmLuwVLYt4FIJNJobXOvTHVRDDdNpg9
 CLO3F6aD53r/KcO9tqSzkuxCrueykFK2Cz/0bYez/Jx+vrzIoYp9S4d2IbwK21PXWyd/PbDsF
 Wx6QjHi4PtuaptPa2mTxV1OvJkmNi/Ym0TD+H2Y2I6r3hSNUjXNvY7XF7Rcif9Lr9mjDSrf4u
 EZ2IvX7hbagInnkVersDO2x7UJqw5eWO0OWkpDTUMVSoAoN0Lyoyg4lIb2YocwaL+nOiTczZ+
 mQD4KYQoIokMtMdAurZPgtAYKXsVDGxb+PpKKmoEkgT5Y/luaFoku+m2/JbQkNZat7Eo2fsBD
 /lbOhz33UL++vz5Nowy1TxlM88+dq699wM3QWXHi/+zlUMIQyKe6jhj4tgFdjbNOnGn6tlUn5
 Bh/oeGFwmicXaimvSZIwrbUQNnDrJWupBYUTEj8BgwhsoZ00CJPLtwLUBl8k96gnAYNa6U99K
 VfqFlIaL7iFQ4wg2uLdU+PpjIwpd29kOaKlZ2rtuoI0BBJQn+YUU/cN03gc0mJn32mKgCCana
 MIrQJzHgFXMQQhL8wbL+MpKon+S35Z+7wedP4rOo6M1ujTQ/AdoiH9phq/y9OUaQFAx2qvNRP
 NJfJ2FzU6LVRnh4vhtDRKW9i+t2aknZjvuDw3lJwAvKkKpfHhnMXq/z1iE/1tRCPembkTqGpM
 IiQMJY7kwHswoCqqVwp5c2FVR/+xXRdraokGFPjnIj2MV/5x6uiKlWxq6HSRQ915KP9KXYIql
 VsI4UURGOgM8RoE8GTyBeuVBayl3g/YCF4BUIQFzOi8W6CBgTOSiOwsl6VGJTMI0lIcJpp7Es
 zVk6PmX/cy1cM84DvQqGsXxNgiz9WkfWYAOKLFQzSQLHpo/X45nltQDr+FRpRkk3Tanz2swYn
 ZH+KjF+J27YapqmltqBg8KdSIqQjYBiFjfre8+Vf91nFe1zzJr8y26dk84wqhFoejqK0buxjc
 NFDkUSwuJyzRJtL3KFcSsY01kpbtaTeVlEUSz9I3v0sT3Xvt9dS4uo1JRmxWfIC0YIGoM4bJL
 NiKymysHaRLH9DCzsfoob0oyqiA70Q2ukTBmwOyGSLrBVY+DGOvJoDsPg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/27 =E4=B8=8B=E5=8D=8811:03, David Sterba wrote:
> We have lots of places where we want to obtain inode from page, fs_info
> from page and open code the pointer chains.
>
> Add helpers for the most common actions where the types match. There are
> still unconverted cases that don't have btrfs_inode and need this
> conversion first.
>
> The assertion is supposed to catch unexpected pages without mapping.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>
> v2:
>
> - add page->mapping assertion
>
>   fs/btrfs/disk-io.c   | 24 +++++++++++++-----------
>   fs/btrfs/extent_io.c | 33 ++++++++++++++++-----------------
>   fs/btrfs/inode.c     |  4 ++--
>   fs/btrfs/misc.h      | 10 ++++++++++
>   4 files changed, 41 insertions(+), 30 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b117dd3b8172..cdb7791b00d7 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -19,6 +19,7 @@
>   #include <linux/sched/mm.h>
>   #include <asm/unaligned.h>
>   #include <crypto/hash.h>
> +#include "misc.h"
>   #include "ctree.h"
>   #include "disk-io.h"
>   #include "transaction.h"
> @@ -633,7 +634,7 @@ static int validate_extent_buffer(struct extent_buff=
er *eb)
>   static int validate_subpage_buffer(struct page *page, u64 start, u64 e=
nd,
>   				   int mirror)
>   {
> -	struct btrfs_fs_info *fs_info =3D btrfs_sb(page->mapping->host->i_sb);
> +	struct btrfs_fs_info *fs_info =3D page_to_fs_info(page);
>   	struct extent_buffer *eb;
>   	bool reads_done;
>   	int ret =3D 0;
> @@ -693,7 +694,7 @@ int btrfs_validate_metadata_buffer(struct btrfs_io_b=
io *io_bio,
>
>   	ASSERT(page->private);
>
> -	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
> +	if (page_to_fs_info(page)->sectorsize < PAGE_SIZE)
>   		return validate_subpage_buffer(page, start, end, mirror);
>
>   	eb =3D (struct extent_buffer *)page->private;
> @@ -876,14 +877,14 @@ blk_status_t btrfs_wq_submit_bio(struct inode *ino=
de, struct bio *bio,
>   static blk_status_t btree_csum_one_bio(struct bio *bio)
>   {
>   	struct bio_vec *bvec;
> -	struct btrfs_root *root;
>   	int ret =3D 0;
>   	struct bvec_iter_all iter_all;
>
>   	ASSERT(!bio_flagged(bio, BIO_CLONED));
>   	bio_for_each_segment_all(bvec, bio, iter_all) {
> -		root =3D BTRFS_I(bvec->bv_page->mapping->host)->root;
> -		ret =3D csum_dirty_buffer(root->fs_info, bvec);
> +		struct btrfs_fs_info *fs_info =3D page_to_fs_info(bvec->bv_page);
> +
> +		ret =3D csum_dirty_buffer(fs_info, bvec);
>   		if (ret)
>   			break;
>   	}
> @@ -1010,11 +1011,13 @@ static void btree_invalidatepage(struct page *pa=
ge, unsigned int offset,
>   				 unsigned int length)
>   {
>   	struct extent_io_tree *tree;
> -	tree =3D &BTRFS_I(page->mapping->host)->io_tree;
> +	struct btrfs_inode *inode =3D page_to_inode(page);
> +
> +	tree =3D &inode->io_tree;
>   	extent_invalidatepage(tree, page, offset);
>   	btree_releasepage(page, GFP_NOFS);
>   	if (PagePrivate(page)) {
> -		btrfs_warn(BTRFS_I(page->mapping->host)->root->fs_info,
> +		btrfs_warn(inode->root->fs_info,
>   			   "page private not zero on page %llu",
>   			   (unsigned long long)page_offset(page));
>   		detach_page_private(page);
> @@ -1024,7 +1027,7 @@ static void btree_invalidatepage(struct page *page=
, unsigned int offset,
>   static int btree_set_page_dirty(struct page *page)
>   {
>   #ifdef DEBUG
> -	struct btrfs_fs_info *fs_info =3D btrfs_sb(page->mapping->host->i_sb);
> +	struct btrfs_fs_info *fs_info =3D page_to_fs_info(page);
>   	struct btrfs_subpage *subpage;
>   	struct extent_buffer *eb;
>   	int cur_bit =3D 0;
> @@ -4437,14 +4440,13 @@ int btrfs_buffer_uptodate(struct extent_buffer *=
buf, u64 parent_transid,
>   			  int atomic)
>   {
>   	int ret;
> -	struct inode *btree_inode =3D buf->pages[0]->mapping->host;
> +	struct btrfs_inode *inode =3D page_to_inode(buf->pages[0]);
>
>   	ret =3D extent_buffer_uptodate(buf);
>   	if (!ret)
>   		return ret;
>
> -	ret =3D verify_parent_transid(&BTRFS_I(btree_inode)->io_tree, buf,
> -				    parent_transid, atomic);
> +	ret =3D verify_parent_transid(&inode->io_tree, buf, parent_transid, at=
omic);
>   	if (ret =3D=3D -EAGAIN)
>   		return ret;
>   	return !ret;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 19ba5b03b2df..cb4020ce6419 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2682,7 +2682,7 @@ int btrfs_repair_one_sector(struct inode *inode,
>
>   static void end_page_read(struct page *page, bool uptodate, u64 start,=
 u32 len)
>   {
> -	struct btrfs_fs_info *fs_info =3D btrfs_sb(page->mapping->host->i_sb);
> +	struct btrfs_fs_info *fs_info =3D page_to_fs_info(page);
>
>   	ASSERT(page_offset(page) <=3D start &&
>   	       start + len <=3D page_offset(page) + PAGE_SIZE);
> @@ -2783,7 +2783,7 @@ void end_extent_writepage(struct page *page, int e=
rr, u64 start, u64 end)
>   	int ret =3D 0;
>
>   	ASSERT(page && page->mapping);
> -	inode =3D BTRFS_I(page->mapping->host);
> +	inode =3D page_to_inode(page);
>   	btrfs_writepage_endio_finish_ordered(inode, page, start, end, uptodat=
e);
>
>   	if (!uptodate) {
> @@ -2815,8 +2815,8 @@ static void end_bio_extent_writepage(struct bio *b=
io)
>   	ASSERT(!bio_flagged(bio, BIO_CLONED));
>   	bio_for_each_segment_all(bvec, bio, iter_all) {
>   		struct page *page =3D bvec->bv_page;
> -		struct inode *inode =3D page->mapping->host;
> -		struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> +		struct btrfs_inode *inode =3D page_to_inode(page);
> +		struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>   		const u32 sectorsize =3D fs_info->sectorsize;
>
>   		/* Our read/write should always be sector aligned. */
> @@ -2833,7 +2833,7 @@ static void end_bio_extent_writepage(struct bio *b=
io)
>   		end =3D start + bvec->bv_len - 1;
>
>   		if (first_bvec) {
> -			btrfs_record_physical_zoned(inode, start, bio);
> +			btrfs_record_physical_zoned(&inode->vfs_inode, start, bio);
>   			first_bvec =3D false;
>   		}
>
> @@ -3306,7 +3306,7 @@ static int submit_extent_page(unsigned int opf,
>   	int ret =3D 0;
>   	struct bio *bio;
>   	size_t io_size =3D min_t(size_t, size, PAGE_SIZE);
> -	struct btrfs_inode *inode =3D BTRFS_I(page->mapping->host);
> +	struct btrfs_inode *inode =3D page_to_inode(page);
>   	struct extent_io_tree *tree =3D &inode->io_tree;
>   	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>
> @@ -3334,7 +3334,7 @@ static int submit_extent_page(unsigned int opf,
>   	bio_add_page(bio, page, io_size, pg_offset);
>   	bio->bi_end_io =3D end_io_func;
>   	bio->bi_private =3D tree;
> -	bio->bi_write_hint =3D page->mapping->host->i_write_hint;
> +	bio->bi_write_hint =3D inode->vfs_inode.i_write_hint;
>   	bio->bi_opf =3D opf;
>   	if (wbc) {
>   		struct block_device *bdev;
> @@ -3410,8 +3410,7 @@ int set_page_extent_mapped(struct page *page)
>   	if (PagePrivate(page))
>   		return 0;
>
> -	fs_info =3D btrfs_sb(page->mapping->host->i_sb);
> -
> +	fs_info =3D page_to_fs_info(page);
>   	if (fs_info->sectorsize < PAGE_SIZE)
>   		return btrfs_attach_subpage(fs_info, page, BTRFS_SUBPAGE_DATA);
>
> @@ -3428,7 +3427,7 @@ void clear_page_extent_mapped(struct page *page)
>   	if (!PagePrivate(page))
>   		return;
>
> -	fs_info =3D btrfs_sb(page->mapping->host->i_sb);
> +	fs_info =3D page_to_fs_info(page);
>   	if (fs_info->sectorsize < PAGE_SIZE)
>   		return btrfs_detach_subpage(fs_info, page);
>
> @@ -3670,7 +3669,7 @@ static inline void contiguous_readpages(struct pag=
e *pages[], int nr_pages,
>   					struct btrfs_bio_ctrl *bio_ctrl,
>   					u64 *prev_em_start)
>   {
> -	struct btrfs_inode *inode =3D BTRFS_I(pages[0]->mapping->host);
> +	struct btrfs_inode *inode =3D page_to_inode(pages[0]);
>   	int index;
>
>   	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
> @@ -4258,7 +4257,7 @@ static void end_bio_subpage_eb_writepage(struct bi=
o *bio)
>   	struct bio_vec *bvec;
>   	struct bvec_iter_all iter_all;
>
> -	fs_info =3D btrfs_sb(bio_first_page_all(bio)->mapping->host->i_sb);
> +	fs_info =3D bio_to_fs_info(bio);
>   	ASSERT(fs_info->sectorsize < PAGE_SIZE);
>
>   	ASSERT(!bio_flagged(bio, BIO_CLONED));
> @@ -4480,7 +4479,7 @@ static int submit_eb_subpage(struct page *page,
>   			     struct writeback_control *wbc,
>   			     struct extent_page_data *epd)
>   {
> -	struct btrfs_fs_info *fs_info =3D btrfs_sb(page->mapping->host->i_sb);
> +	struct btrfs_fs_info *fs_info =3D page_to_fs_info(page);
>   	int submitted =3D 0;
>   	u64 page_start =3D page_offset(page);
>   	int bit_start =3D 0;
> @@ -4586,7 +4585,7 @@ static int submit_eb_page(struct page *page, struc=
t writeback_control *wbc,
>   	if (!PagePrivate(page))
>   		return 0;
>
> -	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
> +	if (page_to_fs_info(page)->sectorsize < PAGE_SIZE)
>   		return submit_eb_subpage(page, wbc, epd);
>
>   	spin_lock(&mapping->private_lock);
> @@ -5122,7 +5121,7 @@ int try_release_extent_mapping(struct page *page, =
gfp_t mask)
>   	struct extent_map *em;
>   	u64 start =3D page_offset(page);
>   	u64 end =3D start + PAGE_SIZE - 1;
> -	struct btrfs_inode *btrfs_inode =3D BTRFS_I(page->mapping->host);
> +	struct btrfs_inode *btrfs_inode =3D page_to_inode(page);
>   	struct extent_io_tree *tree =3D &btrfs_inode->io_tree;
>   	struct extent_map_tree *map =3D &btrfs_inode->extent_tree;
>
> @@ -7080,7 +7079,7 @@ static struct extent_buffer *get_next_extent_buffe=
r(
>
>   static int try_release_subpage_extent_buffer(struct page *page)
>   {
> -	struct btrfs_fs_info *fs_info =3D btrfs_sb(page->mapping->host->i_sb);
> +	struct btrfs_fs_info *fs_info =3D page_to_fs_info(page);
>   	u64 cur =3D page_offset(page);
>   	const u64 end =3D page_offset(page) + PAGE_SIZE;
>   	int ret;
> @@ -7152,7 +7151,7 @@ int try_release_extent_buffer(struct page *page)
>   {
>   	struct extent_buffer *eb;
>
> -	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
> +	if (page_to_fs_info(page)->sectorsize < PAGE_SIZE)
>   		return try_release_subpage_extent_buffer(page);
>
>   	/*
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d31aba370632..159cb2d6a69e 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8348,7 +8348,7 @@ static int btrfs_fiemap(struct inode *inode, struc=
t fiemap_extent_info *fieinfo,
>
>   int btrfs_readpage(struct file *file, struct page *page)
>   {
> -	struct btrfs_inode *inode =3D BTRFS_I(page->mapping->host);
> +	struct btrfs_inode *inode =3D page_to_inode(page);
>   	u64 start =3D page_offset(page);
>   	u64 end =3D start + PAGE_SIZE - 1;
>   	struct btrfs_bio_ctrl bio_ctrl =3D { 0 };
> @@ -8443,7 +8443,7 @@ static int btrfs_migratepage(struct address_space =
*mapping,
>   static void btrfs_invalidatepage(struct page *page, unsigned int offse=
t,
>   				 unsigned int length)
>   {
> -	struct btrfs_inode *inode =3D BTRFS_I(page->mapping->host);
> +	struct btrfs_inode *inode =3D page_to_inode(page);
>   	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>   	struct extent_io_tree *tree =3D &inode->io_tree;
>   	struct extent_state *cached_state =3D NULL;
> diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
> index 6461ebc3a1c1..9a94ee8dd47b 100644
> --- a/fs/btrfs/misc.h
> +++ b/fs/btrfs/misc.h
> @@ -10,6 +10,16 @@
>
>   #define in_range(b, first, len) ((b) >=3D (first) && (b) < (first) + (=
len))
>
> +#define page_to_inode(page)						\
> +({									\
> +	struct address_space *page_mapping =3D (page)->mapping;		\
> +	ASSERT(page_mapping);						\
> +	BTRFS_I(page_mapping->host);					\
> +})
> +
> +#define page_to_fs_info(page)	(page_to_inode(page)->root->fs_info)
> +#define bio_to_fs_info(bio)	(page_to_fs_info(bio_first_page_all(bio)))
> +
>   static inline void cond_wake_up(struct wait_queue_head *wq)
>   {
>   	/*
>

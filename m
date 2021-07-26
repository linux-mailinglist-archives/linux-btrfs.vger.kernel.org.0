Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A0C3D59AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 14:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhGZMBe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 08:01:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:38865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233754AbhGZMBd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 08:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627303320;
        bh=vhn8A8Xairmk1qI0+exkxxsz7haGr8UVBsGpykaa/0w=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Ox5cCehnf68qjvTdln5eiCtfeuAlE/DqZY0lJgsvGawgoFjKiYXI3OpdHZ9rOa4O+
         k2bS+KdoMYWN2tQwESUiOvVJun5ee5Ks0nFofNj49BV8Z5V9wR5PcBTKh/0ViBsn5K
         y3mT210g5uLZzCJT7tjO0qRA6+5XQUMm2WFfF7Wk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MjjCL-1lNLWG30eJ-00lCW7; Mon, 26
 Jul 2021 14:42:00 +0200
Subject: Re: [PATCH 10/10] btrfs: add and use simple page/bio to inode/fs_info
 helpers
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1627300614.git.dsterba@suse.com>
 <4d3594dcca4dd8a8e58b134409922c2787b6a757.1627300614.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <6cac34b2-39ba-f344-d601-b78a3f0c7698@gmx.com>
Date:   Mon, 26 Jul 2021 20:41:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <4d3594dcca4dd8a8e58b134409922c2787b6a757.1627300614.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q0vUOBIuGbi+09jd+60o4rax14FfLP1xL8QtyIqYAUasJRG6/Rq
 JjUqqhx2llogS+t6q7EZpbhEyGhKtk+SjCGFkOoPp8+GemTq/YhR6NCrJPr+jaKzqSmtFiQ
 I+vL2KOeLG3qzafwMeMrwv11Qq3cldKqO3+CyS2t3dQ6DnrQAIjfanpIga1UzFVWgbxdHwX
 wTKlSFR9A8Bur1WV0flFg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:P155t1sopO8=:fiQmRHKnBC9gspLEyGHvIv
 4/K44McnrYCbQgeOnbyRdUc95Uq6jzO+kkO+ge180c/SsKrJyhc1XbpUtAmDj60OKhwEknbuc
 VBi686wvzmS5fLvH7Y6dKI9g3HHwIHKbbhdmRIVtlj2t9Rh39WVICaDiTfm+On4UpCPBOKA8Z
 Ef7okcPUrnsJ6uNU9yZ4kMB5T4jVaFlx96pV3HYAWz21tKsq8pw9zITq0cm3Vbe9Un3DjvCQ4
 qpNoh90paka7BCPflPYs/nHHN5AQkAMqZvyMTCMFKCoKfvYQvlQ6cp4u+Pc46bQq7D3sl/enU
 g1QTCDWWPQoWmZFV1jLOLTTO/20CfSVQIDbbzkyCncDCwT4GM48jmuZ3YKDc3KULXovcWzcwa
 yo4y0gLZlJgiKN7zLp5Ro9N3zoMDlpNIQ2ZZfPL6f8XvFD0Ry50ynoAk/KIC8IB5LmVMu6nPP
 Xpoqhp50MoRM9t2v7xE8S0vw77jEPwz+cmulb/JYw9gn7h+TMK6MgjYSgYCNnIZVEhFyLdTW1
 aAJOx1HepsOloR08ztugKF+L7VihGEtkrrjezGBvp8MrPgYCsD8GV1fDUCERMkN+NLWipxfpl
 7gVkBBw+3SSucayOUx2Cia9Cv/GMGp38D4P4aGfF5oiiHZzLk7MQP4AyLaCadCVszzjJASms4
 LC/0NqhZOvCvcASW7A9NJHv5um03orCzSlkuczH4z0XfF67ylXm8kiHCSslqz4IC6If9ZhFPn
 XtHBRSA7qWgyMjNMm4239peijOyn55j3rVVX9uDusMFpu0SRCqso3TaKzceLAwRqaOf3PMfGc
 U7ptHsi1iCxGjxMN1ccuo/ZnN7Xdmb6Zk4Rj+fRFPd+9axWYGGmMoWDpc1WwO4NdAT4aWk6uK
 31zvH3bJinMOFqmJSxTH+OWEBNVLKwBUrx3xiek4bo0libBKEzczIyoyXNCpdiTaxagGyRHDI
 h1rSGl+cgTgf1WNumaYk6RwJe/copwAxRtVKHNrVfygUMhUnLbpTeNFWCJtPD44q2bRydb2Fo
 cOyFZR1r8wY7YtJBnb5W1SBUtqP72g0pzQRTDoEIBBFH/j9bl+KnlmnE2OPLJlHn2CaVGcGz6
 7TZPSd4s5fQgIB6mh0lxyg0SKcxJgDA53tBKBFoS1Wze2pktfaOf5dmYg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/26 =E4=B8=8B=E5=8D=888:15, David Sterba wrote:
> We have lots of places where we want to obtain inode from page, fs_info
> from page and open code the pointer chains.

All those inode/fs_info grabbing from just a page is dangerous.

If an anonymous page is passed in unintentionally, it can easily crash
the system.

Thus at least some ASSERT() here is a must to me.

Thanks,
Qu

>
> Add helpers for the most common actions where the types match. There are
> still unconverted cases that don't have btrfs_inode and need this
> conversion first.
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/disk-io.c   | 24 +++++++++++++-----------
>   fs/btrfs/extent_io.c | 33 ++++++++++++++++-----------------
>   fs/btrfs/inode.c     |  4 ++--
>   fs/btrfs/misc.h      |  4 ++++
>   4 files changed, 35 insertions(+), 30 deletions(-)
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
> index f7e58c304fc9..d8ce7588de77 100644
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
> @@ -4259,7 +4258,7 @@ static void end_bio_subpage_eb_writepage(struct bi=
o *bio)
>   	struct bio_vec *bvec;
>   	struct bvec_iter_all iter_all;
>
> -	fs_info =3D btrfs_sb(bio_first_page_all(bio)->mapping->host->i_sb);
> +	fs_info =3D bio_to_fs_info(bio);
>   	ASSERT(fs_info->sectorsize < PAGE_SIZE);
>
>   	ASSERT(!bio_flagged(bio, BIO_CLONED));
> @@ -4481,7 +4480,7 @@ static int submit_eb_subpage(struct page *page,
>   			     struct writeback_control *wbc,
>   			     struct extent_page_data *epd)
>   {
> -	struct btrfs_fs_info *fs_info =3D btrfs_sb(page->mapping->host->i_sb);
> +	struct btrfs_fs_info *fs_info =3D page_to_fs_info(page);
>   	int submitted =3D 0;
>   	u64 page_start =3D page_offset(page);
>   	int bit_start =3D 0;
> @@ -4587,7 +4586,7 @@ static int submit_eb_page(struct page *page, struc=
t writeback_control *wbc,
>   	if (!PagePrivate(page))
>   		return 0;
>
> -	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
> +	if (page_to_fs_info(page)->sectorsize < PAGE_SIZE)
>   		return submit_eb_subpage(page, wbc, epd);
>
>   	spin_lock(&mapping->private_lock);
> @@ -5123,7 +5122,7 @@ int try_release_extent_mapping(struct page *page, =
gfp_t mask)
>   	struct extent_map *em;
>   	u64 start =3D page_offset(page);
>   	u64 end =3D start + PAGE_SIZE - 1;
> -	struct btrfs_inode *btrfs_inode =3D BTRFS_I(page->mapping->host);
> +	struct btrfs_inode *btrfs_inode =3D page_to_inode(page);
>   	struct extent_io_tree *tree =3D &btrfs_inode->io_tree;
>   	struct extent_map_tree *map =3D &btrfs_inode->extent_tree;
>
> @@ -7081,7 +7080,7 @@ static struct extent_buffer *get_next_extent_buffe=
r(
>
>   static int try_release_subpage_extent_buffer(struct page *page)
>   {
> -	struct btrfs_fs_info *fs_info =3D btrfs_sb(page->mapping->host->i_sb);
> +	struct btrfs_fs_info *fs_info =3D page_to_fs_info(page);
>   	u64 cur =3D page_offset(page);
>   	const u64 end =3D page_offset(page) + PAGE_SIZE;
>   	int ret;
> @@ -7153,7 +7152,7 @@ int try_release_extent_buffer(struct page *page)
>   {
>   	struct extent_buffer *eb;
>
> -	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
> +	if (page_to_fs_info(page)->sectorsize < PAGE_SIZE)
>   		return try_release_subpage_extent_buffer(page);
>
>   	/*
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ba0bba9f5505..19db7f18da42 100644
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
> index 6461ebc3a1c1..cb6dc975a159 100644
> --- a/fs/btrfs/misc.h
> +++ b/fs/btrfs/misc.h
> @@ -10,6 +10,10 @@
>
>   #define in_range(b, first, len) ((b) >=3D (first) && (b) < (first) + (=
len))
>
> +#define page_to_fs_info(page)	(BTRFS_I((page)->mapping->host)->root->fs=
_info)
> +#define page_to_inode(page)	(BTRFS_I((page)->mapping->host))
> +#define bio_to_fs_info(bio)	(page_to_fs_info(bio_first_page_all(bio)))
> +
>   static inline void cond_wake_up(struct wait_queue_head *wq)
>   {
>   	/*
>

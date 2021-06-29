Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0F33B71A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 13:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhF2L7I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 07:59:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:42975 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232556AbhF2L7I (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 07:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624967799;
        bh=O2MZgR67qBsKI3doZjZyMnU7nI8T25nYxw5bHfNY9Ms=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=K3fuGG2TAcdTcU9hM3D3PE+rHm5QIW+t8/mPOEnHzGUIOXK7oTr3h/P8U9UzJsHmX
         RW+gxISHtJotuFJSeLLPzPPfoE+0BmDNHegDUts1SrFAIegk2E2oDxw2NbkktyMXT9
         RBh7wPVXQkMPA3RfuCJhV4J78oUqtoJ6tcZseyWM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N2DxE-1lEmlM0EVq-013dqr; Tue, 29
 Jun 2021 13:56:39 +0200
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210628150609.2833435-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: Stop kmalloc'ing btrfs_path in
 btrfs_lookup_bio_sums
Message-ID: <06554f93-68e1-b706-07be-62f6cdbf150e@gmx.com>
Date:   Tue, 29 Jun 2021 19:56:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628150609.2833435-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bAJBmcDGH7yylPNN+EQ9MMAIQIoOH1qZjoxx9h6ABcPLQoMREQY
 +GeKalbHC7bQu58Faxyj2DPiHcaUwqipBPDPORGsjyc+knZhgXy1kZM9LXNEXMITPKCmo2O
 Pi4+ZOiQ8yV7O3wzKVX92iwby2eeWItP6vpS+u+zlJfB3hToNq5EOJV06xsGsNKfFG4LKBE
 ygnS+HcQokIZiIh8SlgqA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Uqtomec2clY=:e3rkSibN2U0/ZtGjwQ8p+H
 VqTMQUSjKQhd5iHj46iGqw9CIt3KwLW2wO3OucGvwww6/TvdGbemQyH1jTXnTnIxEhobFgvd0
 txQzlL4qOk5X/XsOCoDOqHanYovdfdWgMjPNEtG7IjW+432VIyvp7L7g0XosEp4vt/xcn/VNa
 HbdfOgetup/0d/h8SrYfBbgvQITVY2GdDb0BxkI1ma4jhKb/0XeeB9jfLIWr17L1qNvNoeAL2
 24jba0m+H6AhbvifMrysj4rJ6cjSoHAB33CWyekqPe8oZHAttjsisNg3ImHhbsSMYOkd6/0zJ
 LiL9zPSC4gvgYnPrZp1Ay2XaWA95Yu9dq+Pn0fLcGRb6hi5Yh4/EUE8ALdXShXFXruPNWXDAP
 DYhz66ZDE4yn0SDv+/Uc9bb/gUFGJP9zklW1Ju3iv4FVg3oPJL2uTMxcLvbMUKS54SenA3KCQ
 cGO/Z1NkjmMHzynsqLQblUhOlL7/vB3Ax4iEOwEpFaTPrQru/EUJ5y8I1YDCPmTjJ6tlLg3Zd
 asxgYEvBMqA5uhkMNynWqT7xm2+b+ewtcHETeFMzYao9Vn7igX5jEd7Ch+MS+/1AhXJ4+KC4U
 uV/0ETU1rvm0vTA2o7MAYjJCIKwtMp2vuMy9HcwPG/fGK4UvZdeiryyXbviX85IiXRXFaEknW
 EEGxvsyVREoybz1DwLOMHWLA8eeqF6dVQHoo3QMTsNqMiQHKYwbR7fOpHGks7m1jDVB0qgnfR
 8uL/8dhqsvQeVLRepd2gUxmgoVcQMj2IxN9IvPDqG5Ca1ebwXK58s+xuawnAST8ZRcujE8evg
 XrSK1K55kv66GxyYEvWUSF82NBRhQGDs7ho3Nc4nhvAhKB/234tMQVF/DtI8SqVIJfdXXXHqc
 Db2gWBUSSqQUbgl7XmCPSW96CtaVXyRDPIyoxGzgBYzaNz+ldP5/zI7KH6nWd0JO6PcXIHwmu
 zSF/Ww942lJIvgyHbbulV1Mi97lAikcik1E68eolMd5+5PYmH2zBeRPC0iNurYzsAo5WmVr11
 wOgzJHqJv0sbEWevDXCLzsLfz5yCCjHiIqE+NqkCCIxmFRtMwc4x1cCMpcV1UCujP7fKvkSzx
 K2WzzycOrcKhuxbdTjKlZlNOT5QlpY/wNkgoOlbT5wKLYAcg4Ot/1UT7Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/28 =E4=B8=8B=E5=8D=8811:06, Nikolay Borisov wrote:
> While doing some performance characterization of a workoad reading ~80g
> split among 4mb files via DIO I observed that btrfs_lookup_bio_sums was
> using rather excessive cpu cycles:
>
> 95.97%--ksys_pread64
> 95.96%--new_sync_read
> 95.95%--iomap_dio_rw
> 95.89%--iomap_apply
> 72.25%--iomap_dio_bio_actor
> 55.19%--iomap_dio_submit_bio
> 55.13%--btrfs_submit_direct
> 20.72%--btrfs_lookup_bio_sums
> 7.44%-- kmem_cache_alloc
>
> Timing the workload yielded:
> real 4m41.825s
> user 0m14.321s
> sys 10m38.419s
>
> Turns out this kmem_cache_alloc corresponds to the btrfs_path allocation
> that happens in btrfs_lookup_bio_sums. Nothing in btrfs_lookup_bio_sums
> warrants having the path be heap allocated. Just turn this allocation
> into a stack based one. After the change performance changes
> accordingly:
>
> real 4m21.742s
> user 0m13.679s
> sys 9m8.889s
>
> All in all there's a 20 seconds (~7%) reductino in real run time as well
> as the time spent in the kernel is reduced by 1:30 minutes (~14%). And
> btrfs_lookup_bio_sums ends up accounting for only 7.91% of cycles rather
> than 20% before.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

I'm surprised that btrfs_path in kernel no longer needs any initialization=
.

I guess we can do a lot of more such conversion to use stack btrfs_path,
just like what we did in btrfs-progs.

But I'm not that sure if 112 bytes stack memory usage increase is OK or
not for other locations.

But since this one get a pretty good performance increase, and this
function itself doesn't have much stack memory usage anyway, it looks ok
to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/file-item.c | 19 +++++++------------
>   1 file changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index df6631eefc65..0358ca0a69c8 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -367,7 +367,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *ino=
de, struct bio *bio, u8 *dst
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   	struct extent_io_tree *io_tree =3D &BTRFS_I(inode)->io_tree;
> -	struct btrfs_path *path;
> +	struct btrfs_path path =3D {};
>   	const u32 sectorsize =3D fs_info->sectorsize;
>   	const u32 csum_size =3D fs_info->csum_size;
>   	u32 orig_len =3D bio->bi_iter.bi_size;
> @@ -393,9 +393,6 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *ino=
de, struct bio *bio, u8 *dst
>   	 *   directly.
>   	 */
>   	ASSERT(bio_op(bio) =3D=3D REQ_OP_READ);
> -	path =3D btrfs_alloc_path();
> -	if (!path)
> -		return BLK_STS_RESOURCE;
>
>   	if (!dst) {
>   		struct btrfs_io_bio *btrfs_bio =3D btrfs_io_bio(bio);
> @@ -403,10 +400,8 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *in=
ode, struct bio *bio, u8 *dst
>   		if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
>   			btrfs_bio->csum =3D kmalloc_array(nblocks, csum_size,
>   							GFP_NOFS);
> -			if (!btrfs_bio->csum) {
> -				btrfs_free_path(path);
> +			if (!btrfs_bio->csum)
>   				return BLK_STS_RESOURCE;
> -			}
>   		} else {
>   			btrfs_bio->csum =3D btrfs_bio->csum_inline;
>   		}
> @@ -420,7 +415,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *ino=
de, struct bio *bio, u8 *dst
>   	 * kick the readahead for csum tree.
>   	 */
>   	if (nblocks > fs_info->csums_per_leaf)
> -		path->reada =3D READA_FORWARD;
> +		path.reada =3D READA_FORWARD;
>
>   	/*
>   	 * the free space stuff is only read when it hasn't been
> @@ -429,8 +424,8 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *ino=
de, struct bio *bio, u8 *dst
>   	 * between reading the free space cache and updating the csum tree.
>   	 */
>   	if (btrfs_is_free_space_inode(BTRFS_I(inode))) {
> -		path->search_commit_root =3D 1;
> -		path->skip_locking =3D 1;
> +		path.search_commit_root =3D 1;
> +		path.skip_locking =3D 1;
>   	}
>
>   	for (cur_disk_bytenr =3D orig_disk_bytenr;
> @@ -453,7 +448,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *ino=
de, struct bio *bio, u8 *dst
>   				fs_info->sectorsize_bits;
>   		csum_dst =3D csum + sector_offset * csum_size;
>
> -		count =3D search_csum_tree(fs_info, path, cur_disk_bytenr,
> +		count =3D search_csum_tree(fs_info, &path, cur_disk_bytenr,
>   					 search_len, csum_dst);
>   		if (count <=3D 0) {
>   			/*
> @@ -489,7 +484,7 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *ino=
de, struct bio *bio, u8 *dst
>   		}
>   	}
>
> -	btrfs_free_path(path);
> +	btrfs_release_path(&path);
>   	return BLK_STS_OK;
>   }
>
> --
> 2.25.1
>

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649FA5302FE
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 May 2022 14:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbiEVMWD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 May 2022 08:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiEVMWC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 May 2022 08:22:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E893BBD6
        for <linux-btrfs@vger.kernel.org>; Sun, 22 May 2022 05:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653222112;
        bh=+wInEZWHFluXT+WVBlyvh1pSOwDWYFyWniYOp4xNNcs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=KoN2wPT4pKohDFNgUupbGLPsxKGGZB0OZWMOKRFRtQP71WNyOA5S7oJ+oAukRl4xy
         P50C2kWnlhuxouSeudjKQLrQgnaPMAP34HX7tgOwqHbg+6rwvQdFa9E7iI7kvbZopL
         CPzGhzEoOE9juyGIRplNnfdxMK1i4bOC8At4qWNY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEm6L-1o3Rps3Ak7-00GJy1; Sun, 22
 May 2022 14:21:52 +0200
Message-ID: <d3065bfe-c7ae-5182-84de-17101afbd39e@gmx.com>
Date:   Sun, 22 May 2022 20:21:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 8/8] btrfs: use btrfs_bio_for_each_sector in
 btrfs_check_read_dio_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220522114754.173685-1-hch@lst.de>
 <20220522114754.173685-9-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220522114754.173685-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pM0fm3l2nfAn9myH9HNbhYcZH7/sQRBw+ym/pUYmi7ej3L4Y/16
 Kxw1CFvp3zEqQOpyvpti5MyFoCc8zRkS25xHJrTFj37r3b2e16NZYbaKVw6maOLgXzg4m5z
 wj5te+jsfG/kxs91PJVysSvVT3K1Eo1GDyCmBJpD80JQtrPy6dIW5sEmwaGiribjcVL2CWF
 AmM0RIijuhGxmh8O9Ikug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uaX67Gv1obk=:ItN3dKT5gaEU+YJzkf7xub
 b3pVCpqeH+KStWNHziaLqytEqOaVP5WZ4cxT9WDMIdLs/ZKtxIonk9nBx1Kg2aiNa/nVEtOFP
 FILzWOzPlhP7OA13AP+56wOU6Q1YYJyBzGeRy51ZOp7Swhsmn1i8TjHnfiDXNUTKu597+zT0T
 qViPytjcLnJhAheW5A306/K6QcBLqRa8cuAab++yK3iMOfPtSS3AM2ROgidi5T6n3rF2ZTrBS
 yXzctLNK8EDiPLf1Rr9osg6hnMAMnLcsORRy5gkgZ18qDINKaHSxOwumtN2qZrJzWn3aNCtvX
 pipwd7CJo78+ci36HULiI6P+3U9MHfVa8SqVQzlhLp8kOm73M2SNZjt5vYg2+u+eQl/VVq/pW
 gTSqJScywUwjncb9syrELY2nOHKWfbfg0miiFYGGA5uCMHgR6Sr6xr4o2e/Cr+o4wxdBbwPRH
 49lhTIEC5RE8j9tBhQT8i/kQIo2X/hlkWLJOFW3BR23gkXDJwaBYRT94+VMyKote20Sc3ZBk3
 Y0bdjJQM0mwMDWcPJ9Pvh9OqRLnZquFWekWoq1F1I+oEKVDOegLxzyDSUwMK3NYU8ASuomgwK
 /S8jreTlKWinuVjLXKRJTScUfglIkWzhSWAQc3ugd3mdpZZzK9LeoXhY+ES3huSDpX+Ktr6RA
 ld8RfJ5THFX4ThQo0B1Fr9IomfYBGaAZGV3mDZAmAtdvZhmN8IFZMzkVHph75WVFq5ObXYhQm
 eLmxw9qXBdGU1vRawKuZKs+yZXUfYOw4nl/+UFafsah908hanfH3CY9llZvZoahk4+40vdU2D
 KUKiJNZcnbHasm6q+Mh4yZTtSjClGYNVyDeTqqe8+3HxDBLIcu7Qgsaqi71rZ4S7LHo9tRg9i
 dYvbDJYeK5V/ZbTJE/irYsbbdcHoKq2qeRATPAStArxdKq6C6ciTLpPSuJtinVOLq/Ue5A0YY
 X8DJdpgdbRSwEoXuamQNs56yCn0s5xTr+JNyg4xDHHmUaebf4Yrg73J7+7lhRKyiUukufks9z
 w+IZ9VhQVJkimHUrU2A+KlJG+mjGeNAt46fExOoHuttiDjUGSVyvJc5cFbt9nBFu6EYjG0XAZ
 He3EPGF7gq7N1GIWZSW6Qfv/rb2lBW5zNA0OPHCm5rK5F+aMVsrcrlNIg==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/22 19:47, Christoph Hellwig wrote:
> Use the new btrfs_bio_for_each_sector iterator to simplify
> btrfs_check_read_dio_bio.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

In fact, in my version I also want to convert the buffered read endio to
use the helper, and get rid of the error bitmap thing.

But you're so fast sending out the patchset...

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 56 +++++++++++++++++++-----------------------------
>   1 file changed, 22 insertions(+), 34 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 095632977a798..34466b543ed97 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7886,47 +7886,35 @@ static blk_status_t btrfs_check_read_dio_bio(str=
uct btrfs_dio_private *dip,
>   {
>   	struct inode *inode =3D dip->inode;
>   	struct btrfs_fs_info *fs_info =3D BTRFS_I(inode)->root->fs_info;
> -	const u32 sectorsize =3D fs_info->sectorsize;
>   	struct extent_io_tree *failure_tree =3D &BTRFS_I(inode)->io_failure_t=
ree;
>   	struct extent_io_tree *io_tree =3D &BTRFS_I(inode)->io_tree;
>   	const bool csum =3D !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
> -	struct bio_vec bvec;
> -	struct bvec_iter iter;
> -	u32 bio_offset =3D 0;
>   	blk_status_t err =3D BLK_STS_OK;
> +	struct bvec_iter iter;
> +	struct bio_vec bv;
> +	u32 offset;
> +
> +	btrfs_bio_for_each_sector(fs_info, bv, bbio, iter, offset) {
> +		u64 start =3D bbio->file_offset + offset;
> +
> +		if (uptodate &&
> +		    (!csum || !check_data_csum(inode, bbio, offset, bv.bv_page,
> +				bv.bv_offset, start))) {
> +			clean_io_failure(fs_info, failure_tree, io_tree, start,
> +					 bv.bv_page, btrfs_ino(BTRFS_I(inode)),
> +					 bv.bv_offset);
> +		} else {
> +			int ret;
>
> -	__bio_for_each_segment(bvec, &bbio->bio, iter, bbio->iter) {
> -		unsigned int i, nr_sectors, pgoff;
> -
> -		nr_sectors =3D BTRFS_BYTES_TO_BLKS(fs_info, bvec.bv_len);
> -		pgoff =3D bvec.bv_offset;
> -		for (i =3D 0; i < nr_sectors; i++) {
> -			u64 start =3D bbio->file_offset + bio_offset;
> -
> -			ASSERT(pgoff < PAGE_SIZE);
> -			if (uptodate &&
> -			    (!csum || !check_data_csum(inode, bbio,
> -						       bio_offset, bvec.bv_page,
> -						       pgoff, start))) {
> -				clean_io_failure(fs_info, failure_tree, io_tree,
> -						 start, bvec.bv_page,
> -						 btrfs_ino(BTRFS_I(inode)),
> -						 pgoff);
> -			} else {
> -				int ret;
> -
> -				ret =3D btrfs_repair_one_sector(inode, &bbio->bio,
> -						bio_offset, bvec.bv_page, pgoff,
> -						start, bbio->mirror_num,
> -						submit_dio_repair_bio);
> -				if (ret)
> -					err =3D errno_to_blk_status(ret);
> -			}
> -			ASSERT(bio_offset + sectorsize > bio_offset);
> -			bio_offset +=3D sectorsize;
> -			pgoff +=3D sectorsize;
> +			ret =3D btrfs_repair_one_sector(inode, &bbio->bio, offset,
> +					bv.bv_page, bv.bv_offset, start,
> +					bbio->mirror_num,
> +					submit_dio_repair_bio);
> +			if (ret)
> +				err =3D errno_to_blk_status(ret);
>   		}
>   	}
> +
>   	return err;
>   }
>

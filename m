Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A9752AE45
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 00:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiEQWrg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 18:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiEQWre (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 18:47:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9106B4ECC3
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 15:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652827645;
        bh=KLi3KJ4yRyCXiSwUbs/8KTpqhRQpllVkLIVAUrIxKx4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Fuu6FvPMwS/LaD0hqtaFuxBdwAJyqxVuCKQy19rfzjXKRLverXcCqUaZU6Lkb3XGM
         0/zjplPLDenZSCV5hVkMcsaIwYGkEEI1ogctVqkhxpGtNvHXryn5KTQzMlWPD0vEPh
         S37sHATu9A/0SxH4ONUouPfJ5AdGWqJq1iSIVyj4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCKFu-1o0Pd80xLW-009MXq; Wed, 18
 May 2022 00:47:24 +0200
Message-ID: <f77498f0-2fab-431c-5598-c85863e6a234@gmx.com>
Date:   Wed, 18 May 2022 06:47:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 11/15] btrfs: set ->file_offset in end_bio_extent_readpage
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-12-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220517145039.3202184-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JJcOatKECqR0NMLHBswYk1iymp1w/5TOBnaYK3Bb/WRdPWn/nF1
 jxIvN6i/IpWnlq3V+Ho2iW1WRDMTGv8UTYnsIe3tSy2o2Cg2v0KsN2HxFAzAfjaRR712FIV
 XCjhejE78Mz8v9kokapmq+0FQRR+yL+17rPuMpqZRc5p7q2Kiw/F5B8Vl3BN+GOGYQ8OwS5
 Irrfnw8C8zBBVfeAMBYBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lzeXN2r9QhQ=:G2Kx4exTKNvB6GZzoN7bGu
 UVdN1qzZcdf40ffzSYByX9oxpLcDJO9x25JDl155xErCMkvJn8fDo7dg+bPH+kffNopFmARc+
 Ltwdlg2/mSDk3VJpMkNHgQFG8e/WnV3P2Hb+DQ+UynQPs6CwnuM+mLAWfnlRuK8EpbK4TB7bS
 dX4ltWo4Z0iWL0DV011++oz2wIUbaeDF3zhodujDnF9h0UPLarmUT5LtMA1lYlOJO+8Hqd0i7
 +zVdibfdPNo1HbjF7Jeq35ZzaT8Qkpz8LeUrOy4NXgCTHQA8YmJnQhSkTBTXsKExgiSJ0/Nee
 qcr2P9yjC+UjYYmmQS63YimjZY1fgovS6ZBA++61Pt+HVr7bxDfub7t3/viXoNdiXPjIY7yn3
 xMZIJNvWan0Fdz64uTswpFSgHnul93UoWZj6Z2UPhwnZ5iUBFZuTxS2QT7kbGurYzqJhpD+dJ
 uIx3tPTFD0H6M3AarbQbkg+b3Qxx8jDVmdUQ5lbHr/8j9JuBsMEt6maJnYZ+46JXq4jChS+ML
 7bJ55N7m91QXHYD7H48N3qn2/BSkA9QD7BShZ2k4iGLgsw1nJ1yQm9SXob+/O0NPAny0BFdQ+
 xwH6d+z+A3fxiTtd4GZ/sJDXTqLz8Hq/6Wc23a8NPQAVKwPam1cVDOOZtwIEDiQYyz4rWzdHE
 uZFrJQ+jGBvvL28imOWH2qs1ccD34u7lv0rO4CjEPXSCgScNMOJTylxli9QhwsgAUVdiXt2Kd
 9ej0WbnN3rk50rxqFn2+TsnClG3Bfs8Z2ObnYH+CPtT+hG3kY4GyaftnRDQQVqJgzGnJ0XuFN
 gKCBKz/wiBAjm18dEGsnebAglveX+O74BF7RIckDGYtYROGCh9BI5QG+tVHgyeiBdXqNZLuQO
 jYpGYctCKI3egfpRPhMjDgIEdAzy0gsv/mNYRt9NOibs904mIPxbsAFu8ED4mewzhmEZ+KhRZ
 i1Xtv9QzStijJMzUo0NdHxQzSmcTkJelRA5HtSRSoqaAG/IMQ1rqurDvoSvJ3d37KqqPXY2Ng
 tReGDv+lMvYedvANv5Fnvu+V+BccOFImd56uaHB6HB+qiZfWIUz4lBAtzug8H18oYas33wW5e
 h9gEM1foFmySGCgWyf66addjshY6aTl6PmKUPx2lElqseTLUa/z6Bnj+Q==
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/17 22:50, Christoph Hellwig wrote:
> The new repair code expects ->file_offset to be set for all bios.  Set
> it just after entering end_bio_extent_readpage.  As that requires lookin=
g
> at the first vector before the first loop iteration also use that
> opportunity to set various file-wide variables just once instead of once
> per loop iteration.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1ba2d4b194f2e..cbe3ab24af9e5 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3018,25 +3018,30 @@ static struct extent_buffer *find_extent_buffer_=
readpage(
>    */
>   static void end_bio_extent_readpage(struct bio *bio)
>   {
> +	struct bio_vec *first_vec =3D bio_first_bvec_all(bio);
> +	struct inode *inode =3D first_vec->bv_page->mapping->host;
> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> +	const u32 sectorsize =3D fs_info->sectorsize;
>   	struct bio_vec *bvec;
>   	struct btrfs_bio *bbio =3D btrfs_bio(bio);
> -	struct extent_io_tree *tree, *failure_tree;
> +	int mirror =3D bbio->mirror_num;
> +	struct extent_io_tree *tree =3D &BTRFS_I(inode)->io_tree;
> +	struct extent_io_tree *failure_tree =3D &BTRFS_I(inode)->io_failure_tr=
ee;
> +	bool uptodate =3D !bio->bi_status;
>   	struct processed_extent processed =3D { 0 };
>   	/*
>   	 * The offset to the beginning of a bio, since one bio can never be
>   	 * larger than UINT_MAX, u32 here is enough.
>   	 */
>   	u32 bio_offset =3D 0;
> -	int mirror;
>   	struct bvec_iter_all iter_all;
>
> +	btrfs_bio(bio)->file_offset =3D
> +		page_offset(first_vec->bv_page) + first_vec->bv_offset;
> +
>   	ASSERT(!bio_flagged(bio, BIO_CLONED));
>   	bio_for_each_segment_all(bvec, bio, iter_all) {
> -		bool uptodate =3D !bio->bi_status;
>   		struct page *page =3D bvec->bv_page;
> -		struct inode *inode =3D page->mapping->host;
> -		struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> -		const u32 sectorsize =3D fs_info->sectorsize;
>   		unsigned int error_bitmap =3D (unsigned int)-1;
>   		bool repair =3D false;
>   		u64 start;
> @@ -3046,9 +3051,7 @@ static void end_bio_extent_readpage(struct bio *bi=
o)
>   		btrfs_debug(fs_info,
>   			"end_bio_extent_readpage: bi_sector=3D%llu, err=3D%d, mirror=3D%u",
>   			bio->bi_iter.bi_sector, bio->bi_status,
> -			bbio->mirror_num);
> -		tree =3D &BTRFS_I(inode)->io_tree;
> -		failure_tree =3D &BTRFS_I(inode)->io_failure_tree;
> +			mirror);
>
>   		/*
>   		 * We always issue full-sector reads, but if some block in a
> @@ -3071,7 +3074,6 @@ static void end_bio_extent_readpage(struct bio *bi=
o)
>   		end =3D start + bvec->bv_len - 1;
>   		len =3D bvec->bv_len;
>
> -		mirror =3D bbio->mirror_num;
>   		if (likely(uptodate)) {
>   			if (is_data_inode(inode)) {
>   				error_bitmap =3D btrfs_verify_data_csum(bbio,

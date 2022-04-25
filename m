Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0398250DC17
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 11:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbiDYJKo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 05:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241529AbiDYJK0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 05:10:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C403F895
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 02:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650877596;
        bh=D8oXB36kZF9PVaxwFhAZQAuqv0Wxt7mDcXQukie8/1o=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=F8SID85ldZe8Zlj1lI8CIsaWoQmbwT6eua8EZ7Tc11LFLA8Z9/BJQjFx5JffGepSi
         wJRX40hfUSyB2k6Q+6GVL+oPI2OSrVzRUvUV7RhHRq4Es4cU211duKSyQnvCzFiEjd
         1TGjfCC779cObcmkxFQ4je6Y+bynzaHYb54eXinY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhlGk-1oMfGt1hzc-00dmfC; Mon, 25
 Apr 2022 11:06:36 +0200
Message-ID: <f9de0b38-0f9d-2e42-f3ab-a87b9404aea5@gmx.com>
Date:   Mon, 25 Apr 2022 17:06:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 07/10] btrfs: centralize setting REQ_META
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20220425075418.2192130-1-hch@lst.de>
 <20220425075418.2192130-8-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220425075418.2192130-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6j2pz2R8ip3U03iuVS9pTkYJMscM/ysnB6p9fbbj4x2CsuPr2nW
 M7iZMojt3BfmiwKsh/8yaKpfNUA+16CnH1Hpq7jJeoBen+gn9Vt0LW+JRjStksb2PRbrWjz
 WgP1puiGFJLRvheeh3S23QJm+Xk4q4duv3uNXxt8YFLPPRLScJLQKDTIpQrVdHIvOR80KkH
 rJ6+iGbMdMc+GtK4G3Hyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rITAhB0PL3k=:zRm/QaY3pAlgvJCw8QVaHB
 oA/O9kkC9VwkcICGIPXtr5emPsZb5jLbsQLYnPd234Q+/t+vXaSmNcAfSClZb9lYp+4Ky5SGJ
 oLzQqO8ROSxDwh5WbYBUEGMoFIMjdPyFN+vEzR1yW4uTglyE3jc/gB0yZVLMTmuIPffg0lHSC
 EvmKeqb6KuXuEohAQgbRixUfTHYeszJBEMTHhBVHXecQcgQHZYjU1xG7uWzk8/LwEKEH0AD4F
 UZ2n5UPGFRYuKKpUdNqLMZvSKKhs4MvFRDALb4hwhm1balwdvok2F5X7koTDGTK5N0rbI6D+n
 xcCDRPdfHeSEij96Kx19Av2gU9jsUQsbH0L0ifzlTgycInxiju9NDno8SNALeg5gBsm0XoD0v
 5GGZYF25HX9pMobEOzNAnnsd6XOx7dyXlOSEIFGXI2ILUrxvn/wTDQBj6OPOl76wNPdlxVv4i
 Rb7MF2nILAiFyDNyEvKEmJ72IGdL/4urRwOHkTaCLfCgQCRf8I5v0ICEcINGMu00WhvcQNQWe
 qjF+rY9htCQTZkyU/kKPEntJP2Cs0ijz3do0xA4XPKi+dDAYCv1E828kneUmYAw037JPZ4ldD
 qJUklq53sqRVaMYmEMa/GJfsOpBCCbAoXeZepaUtw1ehM8X6c48OAkqQdzxfFAcfbL24pmr4Z
 RRKHfyXoCXQ5LFYL4OqU2GXRJapetU0Lb5CLA3z+EadtGf9hVIIiomaM/INMcN9mWmDV6FHcZ
 sfvJVmAs40HOB7hQJIUi3t6kgcIyGMGdLE1BkbIVSt8zFizoli1g6f7omNcjkNYq0Lvp+4e8H
 E2ACVlGiUg+xM5eAkv15cJFCt/EeKyq0yv5acLaR9wwcjA05b/AJ36slXXtT9JsLgHJP3rt7u
 OR2L5w1tdSkrkr3BwYE2kgCyoRZYfI+MbPjNWr7EovvOLYc8X3cZ+2t2HE6wGqFPFCGi8v0Ys
 6BURHHR6bma/Txg6q5ASgNwgM9PwGb95QOsy045h4tPfXcLT6D1dMFZBk4nLSQ93Ed2iBHY/o
 E+LxzqmijwmAGIrXI+mlUfHAPS4zByDxWQrw+U6mVX3B9s/0hoBprqsYLuHW0eKf27j5BLZtk
 zD4d2KofeoJ41c=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/25 15:54, Christoph Hellwig wrote:
> Set REQ_META in btrfs_submit_metadata_bio instead of the various callers=
.
> We'll start relying on this flag inside of btrfs in a bit, and this
> ensures it is always set correctly.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

I tried to iterate through all the corner cases in my head, it looks fine.

As we use inode to determine if it's metadata, which is fine.
The only metadata that doesn't go through this is the super block, and
has its own function handling it.

Thanks,
Qu
> ---
>   fs/btrfs/disk-io.c   | 2 ++
>   fs/btrfs/extent_io.c | 8 ++++----
>   2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 1e6ee7f1a375d..65e680895e628 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -915,6 +915,8 @@ void btrfs_submit_metadata_bio(struct inode *inode, =
struct bio *bio, int mirror_
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   	blk_status_t ret;
>
> +	bio->bi_opf |=3D REQ_META;
> +
>   	if (btrfs_op(bio) !=3D BTRFS_MAP_WRITE) {
>   		/*
>   		 * called for a read, do the setup so that checksum validation
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 80b4482c477c6..a14ed9b9dc2d0 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4589,7 +4589,7 @@ static int write_one_subpage_eb(struct extent_buff=
er *eb,
>   {
>   	struct btrfs_fs_info *fs_info =3D eb->fs_info;
>   	struct page *page =3D eb->pages[0];
> -	unsigned int write_flags =3D wbc_to_write_flags(wbc) | REQ_META;
> +	unsigned int write_flags =3D wbc_to_write_flags(wbc);
>   	bool no_dirty_ebs =3D false;
>   	int ret;
>
> @@ -4634,7 +4634,7 @@ static noinline_for_stack int write_one_eb(struct =
extent_buffer *eb,
>   {
>   	u64 disk_bytenr =3D eb->start;
>   	int i, num_pages;
> -	unsigned int write_flags =3D wbc_to_write_flags(wbc) | REQ_META;
> +	unsigned int write_flags =3D wbc_to_write_flags(wbc);
>   	int ret =3D 0;
>
>   	prepare_eb_write(eb);
> @@ -6645,7 +6645,7 @@ static int read_extent_buffer_subpage(struct exten=
t_buffer *eb, int wait,
>   	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
>
>   	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
> -	ret =3D submit_extent_page(REQ_OP_READ | REQ_META, NULL, &bio_ctrl,
> +	ret =3D submit_extent_page(REQ_OP_READ, NULL, &bio_ctrl,
>   				 page, eb->start, eb->len,
>   				 eb->start - page_offset(page),
>   				 end_bio_extent_readpage, mirror_num, 0,
> @@ -6752,7 +6752,7 @@ int read_extent_buffer_pages(struct extent_buffer =
*eb, int wait, int mirror_num)
>   			}
>
>   			ClearPageError(page);
> -			err =3D submit_extent_page(REQ_OP_READ | REQ_META, NULL,
> +			err =3D submit_extent_page(REQ_OP_READ, NULL,
>   					 &bio_ctrl, page, page_offset(page),
>   					 PAGE_SIZE, 0, end_bio_extent_readpage,
>   					 mirror_num, 0, false);

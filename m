Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81995324EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 10:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiEXIH5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 04:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiEXIHz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 04:07:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9734EA09
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 01:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653379666;
        bh=7zqidLSNiEjYwM+v2gqdQ5BubKRkDk30NzU0UbTq4dk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=M6jhTDAx3jEqhKW9fpkr+eyd9bN98JbS/3AMpFokZNzlrmfDydxsfs/zKZTOfJdaR
         /fzxvuKeXSg845bdUTdlnGXlWTbeHaoj/91L9dKCD/BULCkvJaTUTG4Ks6GDRhcHX6
         DT3XGzdjTCWr8o3tcqMfL8IU4CZf3yJx7cPIxbAc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtOKc-1nZ0Nr3BJW-00uutt; Tue, 24
 May 2022 10:07:46 +0200
Message-ID: <6423b926-c5b2-612c-ccac-0cb9ee29984f@gmx.com>
Date:   Tue, 24 May 2022 16:07:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/8] btrfs: introduce a pure data checksum checking helper
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <20220522114754.173685-1-hch@lst.de>
 <20220522114754.173685-3-hch@lst.de>
 <d459113f-7325-ebe9-77de-6639c646f0df@gmx.com>
 <20220524072458.GA26145@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220524072458.GA26145@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ITaDp/QrQJGAogapdcWWnG9zoV3BRBnI19CLve6yDdttWJESQp7
 bPzW1muoZf13VYw/u8SwfiDuCpxMa9nMwCcTfbrJek/wdoVlzqL9+0XVXEzat3/RLz6WEKQ
 jdBItRIqa1aR9aC/5UUxp6UY7KF43y57+uS9LOUPNWigSfxaL0Gl2RPG2Fi2sKVhyiAejGi
 SYZj8hFgR02GEkY5X4POw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/xaUIcQJpd0=:kYKAsktxxd38hHSRSvNG81
 Tv30+BAMc7YI9Qj8iWAftxa5ZsYmG5kEmbIoQ5oRNGPeXzjB3j3IyXBnRkGTuOon73t0784Af
 HBe0lTq9VAw2u3K60jk3VPq5acdSOYDxJ7YG0pldUzjdMXEWzfmcMwnxpn0jgGr874eaOpXfQ
 o+0eHqrvbUXGiUTZlGuaiGgVxNDsL1X5N1ux+tQHzYPsKcr1va1zW8585WQLxutRYe5qaW/AS
 S87ICU4UFK2OyxbTwlanvNZFeeePHwTTftjQCBjtWlA1VLtNaJk/gSGjUG4f/Dtu/eYHhaZJK
 3u3XnoG2VOVRCkB1S2K+RVK2+5HvkB/DdyUVr/rYxRH/EvqE2y7UMqOHVLWNdkHqusAVi8Zbc
 ctYS1mkJqK8OZhgfBri8NI9ZaU/FfnJ1wApvJo7x8pSEu5gonL4qx7T9ohI5vbx5uLiv3HQG3
 mpwH+wjjfxoKhC3uxYOf59CxiXJ2GpIloOQUjz9CrRSsm60esI42tLCgI69PtYP8RJYQ3N+Sm
 EL5DzkdM9M0RWyY77evjUEK3Ahz/DK3tCZbk64/ENjL0JqiCSC58tl1IXhy3RTNMnTQw/sIri
 GS0OJwkQEEurVWNtGkdPIteP2RLzSTtZL6BpELSLySMTLejVseMORe4Rc+88JbXUQn0FUr/yM
 4ni62D/zPSaW8sle4+ofES3+/OjKgMDi21GXLvk7cn+C2Bv5qYyl2gkBq6IeEXKMaSNNLp48h
 Fw+j0YnC5tzmNyGoB69oq0NPngUSMm2WyP+P5JF6RQGzoKfOpTZFM3PFBDFuLY2ha491G22Nj
 xUnptzMHQDuZ1uvmTHe0x3zaKojUJXE37fPj0G1Tvl/ruoBCMbBov+TSiHunWuE0lAgue9an6
 4SdReuV7AvDlS1cmagcRt8lKpryF8Vla+mn7Wl8z4yleiSw1LiRDo85k5ooon2maaftSWx12Q
 2EaIdmQgc+p8H74/9zL1z1w0QUF5ztq52Jj9uZViY4Fjuj2YhgcP8Jt0xj38OTW0CvwjwojaZ
 xo5ycN2qYfkynR99apFjccn0Zxcx01kWCvHpyOyIuev/aM5SrCh02rx25vu2wSNJU6tp/8SsJ
 3OlkUlr/rM42gUTcLnCXpwkR7uwKsBHlrwqZ5G/OItcwdaaoKR5AZUZ9w==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/24 15:24, Christoph Hellwig wrote:
> On Mon, May 23, 2022 at 08:38:13AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/5/22 19:47, Christoph Hellwig wrote:
>>> From: Qu Wenruo <wqu@suse.com>
>>>
>>> Although we have several data csum verification code, we never have a
>>> function really just to verify checksum for one sector.
>>>
>>> Function check_data_csum() do extra work for error reporting, thus it
>>> requires a lot of extra things like file offset, bio_offset etc.
>>>
>>> Function btrfs_verify_data_csum() is even worse, it will utizlie page
>>> checked flag, which means it can not be utilized for direct IO pages.
>>>
>>> Here we introduce a new helper, btrfs_check_sector_csum(), which reall=
y
>>> only accept a sector in page, and expected checksum pointer.
>>>
>>> We use this function to implement check_data_csum(), and export it for
>>> incoming patch.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> [hch: keep passing the csum array as an arguments, as the callers want
>>>         to print it, rename per request]
>>
>> Mind to constify the @csum_expected parameter?
>
> This would be the incremental diff, if Dave cares deeply he can fold
> it in:
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index d982ea62c521b..f01ce82af8ca9 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3262,7 +3262,7 @@ u64 btrfs_file_extent_end(const struct btrfs_path =
*path);
>   void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
>   			   int mirror_num, enum btrfs_compression_type compress_type);
>   int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page=
 *page,
> -			    u32 pgoff, u8 *csum, u8 *csum_expected);
> +			    u32 pgoff, u8 *csum, u8 * const csum_expected);

Shouldn't it be "const u8 *" instead?

Anyway, normally David will handle it manually if needed.

I'm talking about this one just because my version is passing "const u8
*" for its csum_expected pointer, and caused warning here.

Thanks,
Qu

>   unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
>   				    u32 bio_offset, struct page *page,
>   				    u64 start, u64 end);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index bfc0b0035b03c..c344ed0e057ac 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3330,7 +3330,7 @@ void btrfs_writepage_endio_finish_ordered(struct b=
trfs_inode *inode,
>    * depend on the type of I/O.
>    */
>   int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page=
 *page,
> -			    u32 pgoff, u8 *csum, u8 *csum_expected)
> +			    u32 pgoff, u8 *csum, u8 * const csum_expected)
>   {
>   	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>   	char *kaddr;

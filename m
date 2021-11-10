Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B32644CDFF
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 00:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhKJXuw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 18:50:52 -0500
Received: from mout.gmx.net ([212.227.15.15]:34209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234005AbhKJXuv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 18:50:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636588075;
        bh=hFZEda4jT6qK2iwx4Zd6aOTn+Vq4l11Q+5u4SkV+Wts=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Sc67zSKoen4DipDXfWW1k5rQcGPVO809jMl+z+wZtZmxmuRg7eb/pDLhqzZDw6Vcl
         2H9KNnKN5h77BVzYrSbWy0u1JMyEN1iTgMKTsyLb8PmQeCpgctap01I9Dipbx/0P2E
         bvMsZ0lXtmcK4p9MvhaKXf4hq2E5thC62uwxlIw8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mz9Un-1mYdIn3aDr-00wAOh; Thu, 11
 Nov 2021 00:47:55 +0100
Message-ID: <9717059f-cbd3-3dc3-90a2-f9ef7c32b8d9@gmx.com>
Date:   Thu, 11 Nov 2021 07:47:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] btrfs: make 1-bit bit-fields unsigned int
Content-Language: en-US
To:     Colin Ian King <colin.i.king@googlemail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211110192008.311901-1-colin.i.king@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211110192008.311901-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fyaJGUPyE1oNaAC5f4f7jc3gueg3Ub582k9Vp+FYWRJebtb/FYV
 7cjrAMkzfaRTZ7jsSAdledCunV4lKFUMALec6QwQI8J5um+7938JZnAjkDPJLpfphxcdQSF
 pqkSR7rkke/+7P3Mlf3zHNI+kEWytDLiPqiUGmx0Kmn/deOhgtI2urPa9oeC36bUVRvuzZf
 iLBlddTPbHM+NTL0XyOLA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iOmM1IkaDQM=:VcNPISPAQzrA64Dl4Wznr4
 Bc2Xl1lPcJ5Zc4tR+exRZrEs6lrvErNv2xdJ+4UwUo3O6J8OwEU3diVXxUAkYbuocMeN0Ub0c
 1ZmCHWc6ngI/Yc5KvBITdqssAnzPoyQaYbupoDC1JHvLPAnUWdr0HTgqk5rV9dXRUEtEPAIxg
 P6TBh9NGRV9y8cz6c1kgBZDxVZ/MzIqtxLOnucY22/n8g5uoRyitTYTPi8GUL3D8Nc0FwDbAQ
 fgYRrBEK2cFYOv04sYRmPyvj5kqW7+rXtvH5T9lh+HZ+SUwsXiX7I7KJX9D/4jYtUtOH5YglT
 pyT36qSsuT8KZ3H59hLMLkfhe5+SVnIqgChbqZQAlL7WziOLRc6NLFas1dyG4B7dy2kLy5fYP
 USx5ivyBFg3fdhxuhw5cqGhKhkfyN0C/uwELL/2LEQ78yVrPs0xbsjATmXP/9tXz+IwA+JWrB
 yPfsQ1rMPCzE6caUeU5DJ2sRCfPasklL7Jlar7E+jCeNvFM1gJjnD21sqhsLY0XsgaBU1Z5ZB
 1qVLKt1HyhfwtNu9AF/V5OS24pQ7xlw98XuJiFXlbznkb48nTHauGDhWi1LLm2gq1AEvhtozl
 j27wacA7/7DFSLjcTqqNpcBvtd/H3rNozF+izioESf4e5UUHSz3RmFBCsUtsojmT49QjWc00f
 AHYMeCinEMKwZF3Sdnr7QIEWnPSkyiwpsv8ML2HFnyXSotKfLDXJB/C+Xp70NYxSllyEX3ufU
 WrRYuriHBaCYM1q1Aoz2cLQmsYQ+gDbz+Rjt9o5fA0GtyF3y0yBPl3MCuoDUF+ZK/QC/mnD6F
 8fvsWfKy3sCN9C0WZUPs3AAComYklSJvRTJOVxzHnYRzg9+AMODuEaUpwNEC4PgHmtI/N/vxZ
 buua1P73F9bKtvkcPaIuv6nXIQnuCk++w8vWIimyg49KL+YdcUyCh90l4Nimy6+2fDrwiVWsq
 +1EcN5Y4TVbkAh6+YiuZpysXddQ5Bp/JUu/nCLcJ+YNkv+HAqUdxL+rfY+DiO5+fgPh9v/VQ/
 2BOOuILYPn6CQZ/hDbghUoaxzmvh3w0+NbZH/IQcDD5QNm0LOfwg/EE4jzDzU5CPRZeYrD9Pf
 cR+hLce2aj2YJg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/11 03:20, Colin Ian King wrote:
> The bitfields have_csum and io_error are currently signed which is
> not recommended as the representation is an implementation defined
> behaviour. Fix this by making the bit-fields unsigned ints.
>
> Fixes: 2c36395430b0 ("btrfs: scrub: remove the anonymous structure from =
scrub_page")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/scrub.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index cf82ea6f54fb..8f6ceea33969 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -73,8 +73,8 @@ struct scrub_page {
>   	u64			physical_for_dev_replace;
>   	atomic_t		refs;
>   	u8			mirror_num;
> -	int			have_csum:1;
> -	int			io_error:1;
> +	unsigned int		have_csum:1;
> +	unsigned int		io_error:1;
>   	u8			csum[BTRFS_CSUM_SIZE];
>
>   	struct scrub_recover	*recover;
>

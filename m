Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF85649998
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 08:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiLLHgD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 02:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiLLHgC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 02:36:02 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BBB64D2
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Dec 2022 23:36:00 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0X8o-1ohJbZ1WM8-00wR5N; Mon, 12
 Dec 2022 08:35:54 +0100
Message-ID: <4723739c-490c-d890-0e42-5e653b4f5d2c@gmx.com>
Date:   Mon, 12 Dec 2022 15:35:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/3] btrfs: cleanup rmw_rbio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20221212070611.5209-1-hch@lst.de>
 <20221212070611.5209-3-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221212070611.5209-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zwMAPd3hRgVeCWdc/H/fa+OTIOPAenzDQ+ujZ00+SJXQDoMyvXy
 bNTPVuUEQu6bbM5YX0D+nOcvP7TZTnHFgwl5UfYQ0br8ZwxWFa+lIAKFsNz5HJa8qYMc65j
 mN+I2D1zI+tMOx9+BbdoPJYa/lP90iNYsFuyxA2GK6u6XFjc4X5kWzVuBZFk1NneLvRATRn
 swIspSZ1EjFcxNfYHjXvA==
UI-OutboundReport: notjunk:1;M01:P0:MN7XTms7Tbg=;vMI0qHFHf9zkY6meosmp4211jz+
 A4ksStqPwbp2pLqr3fcFxVwN4AdpPtI0EgtJ+4SnAeqJESPUTe9DhLBBl6gJSzgejVge5s8EF
 acqYw4nxd8iUFPpeIYpDhQTPxm4LnM13k0mEVo4t515PfFpRLR1tn/RV865AePYaQzZS/MuGT
 V5DQMyUO67XsprnTEuKBSI6aJw9/zuyF7XJEw0bOFl5oMPETi3bKC+GMDpp8w0bhZRLeajWlX
 Ro1fBnWqncJir4zFyfLex2/Qdh+xxs1LtGfL7MYJRMeab+LB6+jf7Q3txhWFuku+AJR5rtoRt
 iMgNVbr6ZyV0XOmPHWcScbocu4uvkVzmHcQUx8rs2ogNECQMpUOqM41BV9arqpPtC/+TrNln4
 To9+u7+R2dyEjcbakVKm3WY2r8W/bjXOuFgBYFzUxR7ccRhF50pFBHGD4S1i3hNa282ThEQLq
 Bu+xTOKf/zlaKM3P0z2iXF30SwoSLOUQtUFRzBJ2DZ1buP3VlsQ40EMl4vslLdjVefcwobf2g
 X7he/MjYSedcgkPulChmBmEpPkefFt1lmFx2Mb6akwa9cmS93LIlWPqS7UbYnZR1/+OJFHzig
 3ICB6kLe0hXpoDPktLhPCTa3/RHmnzt67sBafTL/8OXzlXpxKwDRAHEm0HjY0O+bIuhbw1acE
 J2eBgSwLOF6gbGssRqo1ci/3sx/rFCs+RzncHcPstL++eww/VeyzmZHoLaw5X2jYK+q+2xFGt
 go74Yli8k8BAPvH3Qt2ZcMSt6MnVO+0U8IPklwpiMoEi+bOexjb+Afcv+C2fILfrzh2XNM3ZI
 Jukpn2KgCNAKz5XotDq6bO7Cc5zps3cVTxjK1SXedjoYwPxy7UGqIt06Pw/cWpOHXLkorBEqC
 vy6lC5Lhpr3+RA+ry0oj2C2O4K2710t0U0YG/94NRnxNZWPq8BSEjvkuJuzVaNpiUrmPZk6GX
 h7zj6igl5WNK3qOgUky4ZmuDk+0=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/12 15:06, Christoph Hellwig wrote:
> Remove the write goto label by moving the data page allocation and data
> read into the branch.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/raid56.c | 28 +++++++++++++---------------
>   1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 5603ba1af55584..5035e2b20a5e02 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -2293,24 +2293,22 @@ static int rmw_rbio(struct btrfs_raid_bio *rbio)
>   	 * Either full stripe write, or we have every data sector already
>   	 * cached, can go to write path immediately.
>   	 */
> -	if (rbio_is_full(rbio) || !need_read_stripe_sectors(rbio))
> -		goto write;
> -
> -	/*
> -	 * Now we're doing sub-stripe write, also need all data stripes to do
> -	 * the full RMW.
> -	 */
> -	ret = alloc_rbio_data_pages(rbio);
> -	if (ret < 0)
> -		return ret;
> +	if (!rbio_is_full(rbio) && need_read_stripe_sectors(rbio)) {
> +		/*
> +		 * Now we're doing sub-stripe write, also need all data stripes
> +		 * to do the full RMW.
> +		 */
> +		ret = alloc_rbio_data_pages(rbio);
> +		if (ret < 0)
> +			return ret;
>   
> -	index_rbio_pages(rbio);
> +		index_rbio_pages(rbio);
>   
> -	ret = rmw_read_wait_recover(rbio);
> -	if (ret < 0)
> -		return ret;
> +		ret = rmw_read_wait_recover(rbio);
> +		if (ret < 0)
> +			return ret;
> +	}
>   
> -write:
>   	/*
>   	 * At this stage we're not allowed to add any new bios to the
>   	 * bio list any more, anyone else that wants to change this stripe

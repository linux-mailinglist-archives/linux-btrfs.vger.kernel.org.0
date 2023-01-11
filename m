Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1489C6654DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 07:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbjAKGvJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 01:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbjAKGut (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 01:50:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E41FD2E
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 22:50:47 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mv31c-1oxy5o41ei-00r0P1; Wed, 11
 Jan 2023 07:50:41 +0100
Message-ID: <0df9ef38-8c98-3c1a-6398-3f548b26af05@gmx.com>
Date:   Wed, 11 Jan 2023 14:50:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 10/10] btrfs: call rbio_orig_end_io from scrub_rbio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20230111062335.1023353-1-hch@lst.de>
 <20230111062335.1023353-11-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230111062335.1023353-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:R1PMZcp3vQuddqE7KRFWGRGcH28Du0aK4BMxR17WTB7P8v7sb5E
 uQUZ5NwhDY3DtvPI5Vdi3tkLzcbIiAvFZUSzotWNfuTEbHSgpV5OtRyyBnZI1ONEmBeyMPC
 DmR4/gavJaKC5SZZn5z4M2YI90bmWLjJgJn5JuUw7hNBbHdcuaGpJsFTfzXrtXGGJePHdyy
 jizamLOwT0l00yagB7dxw==
UI-OutboundReport: notjunk:1;M01:P0:xxg3ztOQS90=;v3Tqb+zL9KxOxmvTcIP5Df5E5nv
 i+8ttdS+1M7s1ochlHtHiHWXIBpao9rbV0kJK9PSbFIZ+i+/bHrz+3tQNmfEMKwRfd+9BJ68g
 P/cbEw5Xgj7CEYMX7O/WLxGci5DcnPTzFJLxMhXOw5p5kSeNiYswfVZHgdNcbrAqHXFHY9PcO
 g7eqVvetMxCDlOLUWkasvXcbRdXzlz2cM7ip733WMMWl0go0+nAw16Wz/HaHd1iVomP+Rf1PU
 CPP4i4Z2WRtZoI4kARj1OahQmEPhYNWtD/YV2O+EuP+X0kZL7E+qK67pNB8y6z/QfJgIPwd9J
 7pQvd1j8KY955iiIxE4I+2OBihax/zUhFpz66tHbZNvQ4uCvFF+IhCculPftQXviUHSkiiy3+
 6bsf7dAwiaJTZ60Gyw0bdRueo5l34xO/Lb3GxsPd9/oGE+fwEwWsGk3xZAQJMOLloX4zxah/P
 6UOP54z4DFsY8s2SUdQs4JBisvUViUkX7kt+0VVXYvrrknxlsfGohXflbkH4LLgEy+QNmzg3e
 pbXoodaKcDZbvTNJnP9coCvnNvG4AjWEo2sr+dZAGC+4sDY2pWY/IPZcFIajkxz3Rmn0h7Msd
 rsGs5z7Y0TqiTgQGs2auaX4YcbcHt4xNCdAe4DyRPOW70qw20BjFb11ZncsVIbPyAB8bLB7+T
 8+Jppw6uE6lj5hWQAu1SJWhvHbT0apkM5L9lZQqU+nlRIHpM36cO77iwxgzhN/a24iJG3k80i
 5obPKA0eywEVxxqTY3V08o+ar5LayRzVxgfZXxFtlW5U1mCJ6pDuWYw9JgSNxCm6gKu3nosNB
 AWhig0vJi9dW9NnikYUUWmEy0w4hOpHff7UpGmJFbA76VfYi1ak6RYTjR8+0Pvreb7Ww+M5wL
 At0AJDcufKVdwfbDTpPY1GUgL1yMPj5JXSUSxByT0U9/aUcnKh/VSPzcg/mUnCCo811/QgPOn
 YqXUAF2+dAnyeS62pEGknDmDa6E=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/11 14:23, Christoph Hellwig wrote:
> The only caller of scrub_rbio calls rbio_orig_end_io right after it,
> move it into scrub_rbio to match the other work item helpers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/raid56.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index c007992bf4426c..d8dd25a8155a52 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -2695,7 +2695,7 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio)
>   	return 0;
>   }
>   
> -static int scrub_rbio(struct btrfs_raid_bio *rbio)
> +static void scrub_rbio(struct btrfs_raid_bio *rbio)
>   {
>   	bool need_check = false;
>   	int sector_nr;
> @@ -2703,18 +2703,18 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
>   
>   	ret = alloc_rbio_essential_pages(rbio);
>   	if (ret)
> -		return ret;
> +		goto out;
>   
>   	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
>   
>   	ret = scrub_assemble_read_bios(rbio);
>   	if (ret < 0)
> -		return ret;
> +		goto out;
>   
>   	/* We may have some failures, recover the failed sectors first. */
>   	ret = recover_scrub_rbio(rbio);
>   	if (ret < 0)
> -		return ret;
> +		goto out;
>   
>   	/*
>   	 * We have every sector properly prepared. Can finish the scrub
> @@ -2731,17 +2731,13 @@ static int scrub_rbio(struct btrfs_raid_bio *rbio)
>   			break;
>   		}
>   	}
> -	return ret;
> +out:
> +	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
>   }
>   
>   static void scrub_rbio_work_locked(struct work_struct *work)
>   {
> -	struct btrfs_raid_bio *rbio;
> -	int ret;
> -
> -	rbio = container_of(work, struct btrfs_raid_bio, work);
> -	ret = scrub_rbio(rbio);
> -	rbio_orig_end_io(rbio, errno_to_blk_status(ret));
> +	scrub_rbio(container_of(work, struct btrfs_raid_bio, work));
>   }
>   
>   void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio)

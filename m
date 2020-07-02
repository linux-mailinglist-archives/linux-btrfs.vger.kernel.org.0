Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CE621246B
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgGBNSt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgGBNSt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:18:49 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCFFC08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 06:18:49 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id m8so8400984qvk.7
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 06:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2s/cx7U8YtDPZU8C1gPDdYcMJ+ItbkTP/JLFZ5VJNZQ=;
        b=MCqY5pnfhwFpsto7dNtNRaVbbOSpD2FilQYzZ/MiY7EnQtW/yny2bG5+abjU2ftkos
         b/gTRSEI98SUt4otJFvderk9sPITzZv8KBjtjQw0z7Vq0n9ecQc7RHmdcZ1NTyg2YZMX
         ih9kgGmJHW9aQjcHRhHa5TyzXcBNWfWBgR5SQ5BrD+iJsUSufGWQv/N/8zecwNznNL17
         4LbGsAEShvqdHp1BsPoLOblKd1eJmRR6uyZ02YDYXczfrm3ecQwbw7ht4zkG6RQyTuGT
         YXsCx3lD1MGvdBjr585B6sv+6+W1fXZrwI9QKLcg+RkqTSaPl5UdkbB0tDYeL2y7xQFb
         lYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2s/cx7U8YtDPZU8C1gPDdYcMJ+ItbkTP/JLFZ5VJNZQ=;
        b=hUGE6t0fTfDLkA6+cCk0XIgdTDsoFlDVRSVzyCHFMoarL1hS2kRmUv8YKCz3BhWMsM
         hEIX+UhG1I/mRRlyfDi0dbGcEzAjD9/8IdbIrYN62S96fImnLP1DQArmlYuL4WDIu9bn
         BoyP19pYJojSIJN8qWX3BJDxvOgr6hkY7Sax4xe/fSXrSA11foHrO5odZWgUdh4ir0B8
         c7X53y8uK9YULb5EHiCxC3wP1W/Hr9chGej0SIPQGPi++G7QidKh9neKNWWCk/8frpvp
         MNsKyBE9yTiVmxQjsbZDEevx6UuAesf2Ju2wQUeQZDrho52GlVKQ1aPwMLr0YKUrxdoW
         +JIA==
X-Gm-Message-State: AOAM5326R8yd3BFefqzr1LBNQSTQpXBypO9o8V4kpXvFTMgoM7nexexn
        kJ5ATlVzrWmS3lXb8SppEHkg0EDbrt5r2Q==
X-Google-Smtp-Source: ABdhPJzYm9dtp8jQvmwalbEtI+HY169w/cXHe8IYYXdzSrBTc85gEOokE+fkWR1lh24q9r4P1lsdpQ==
X-Received: by 2002:a0c:d7d0:: with SMTP id g16mr25469443qvj.190.1593695927902;
        Thu, 02 Jul 2020 06:18:47 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h16sm763619qkg.8.2020.07.02.06.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:18:47 -0700 (PDT)
Subject: Re: [PATCH 5/8] btrfs: Increment device corruption error in case of
 checksum error
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200702122335.9117-1-nborisov@suse.com>
 <20200702122335.9117-6-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f673c83d-5776-a187-a438-6867b87599c6@toxicpanda.com>
Date:   Thu, 2 Jul 2020 09:18:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702122335.9117-6-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/2/20 8:23 AM, Nikolay Borisov wrote:
> Now that btrfs_io_bio have access to btrfs_device we can safely
> increment the device corruption counter on error. There is one notable
> exception - repair bios for raid. Since those don't go through the
> normal submit_stripe_bio callpath but through raid56_parity_recover thus
> repair bios won't have their device set.
> 
> Link: https://lore.kernel.org/linux-btrfs/4857863.FCrPRfMyHP@liv/
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/inode.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index e7600b0fd9b5..c6824d0ce59d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2822,6 +2822,9 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
>   zeroit:
>   	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected,
>   				    io_bio->mirror_num);
> +	if (io_bio->dev)
> +		btrfs_dev_stat_inc_and_print(io_bio->dev,
> +					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
>   	memset(kaddr + pgoff, 1, len);
>   	flush_dcache_page(page);
>   	kunmap_atomic(kaddr);
> --
> 2.17.1
> 

I had to go look this up to see if we were double counting, but no, we only do 
BTRFS_DEV_STAT_CORRUPTION_ERRS for data with scrub, which goes through a 
different IO path than the normal reads.  Just in case anybody else is as 
confused as I was

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

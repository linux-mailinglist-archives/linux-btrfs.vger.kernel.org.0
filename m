Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6652FD42C
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 16:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390573AbhATPfD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 10:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390243AbhATO4E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 09:56:04 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FCAC061757
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 06:55:22 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id c7so25554943qke.1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 06:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UXayqbGKSt+XJm4OnVgYugLuxd/qis3TbbHy3gP+Keo=;
        b=BZ0tYPOaylm8CTtfq0tCUUQbsJ4SiwYMDuzwE56/DDDUYjdgRCH+wpvzbRdvbLaVXm
         /G+L2mZhl9xT1n5dkpVHeYChExyDiTdRn3ZnYTuBDrt1rxffeLRQ3dlrT574ck099xSi
         tA5mfC7L2Lr0zqn3uGtVuXTr5IA/aEDTYW/6ay2WdY1Rvb8joPynTMo2KSWWZm/uvFEp
         4YaUQXjpRI9PF0qO955GGZm6eTOykrk/K5Wx2k3NzHYjp/gjszhYCN9rFPVIoU5Ppiqv
         JayN4gRfn/mp9/vPI6cgkTpRGZi9qV1nU6eGx3tSph0lmBKN0WOYihbIaAqg/wRNdL4+
         wGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UXayqbGKSt+XJm4OnVgYugLuxd/qis3TbbHy3gP+Keo=;
        b=kC8Y8mfGHVguUGoVssDzTdu+DmaDlwcSo+oqc5vP4XGYaLKdMMvkNWQw8THW1dgJ9X
         244kJuDygkTP92ic/laN+gMRmxfVKoH1zSHZRR2NrI2aC4zb7aKbBv7Oa/rs+KvKR9CL
         9D+H0E4wd3f18AoJziW3T4aAx7MlL0wlHVOr9dx4+R2U2KQkbZaA3MiHA2zc3mee8oSt
         d9FXLQambyDSIAJMUBgS1TD4GQQ6wz2L09mprUOWHVIzgdlzT/TlO9s4e+P5Quv2B56c
         HegRbHL2hpOViOwyXgt/3+L1hzPG3Ij45LCk0QleFbpctjTgbofDF3CsHifwQqcHAGb/
         JU0g==
X-Gm-Message-State: AOAM531DTX+sojZPPIT13itpVgUCEmKTdYNLcNdprlB1s+p1yoxJGBN7
        aza/g5PnREUjJ565RVpIvtbiCpZ3zEKfZhm0eOU=
X-Google-Smtp-Source: ABdhPJygEEkWf7yeHSTE5BszNZbKCobK8CI+4y7V1KAvdnYtBy3cOF/SeUyTEyKYoNH+y6pLQSQG4w==
X-Received: by 2002:a37:ad0d:: with SMTP id f13mr9797783qkm.355.1611154521353;
        Wed, 20 Jan 2021 06:55:21 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l38sm1256120qte.88.2021.01.20.06.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 06:55:20 -0800 (PST)
Subject: Re: [PATCH v4 08/18] btrfs: introduce helper for subpage uptodate
 status
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-9-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <65d45aa9-5a84-9885-2e05-77435161cbbc@toxicpanda.com>
Date:   Wed, 20 Jan 2021 09:55:19 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210116071533.105780-9-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/16/21 2:15 AM, Qu Wenruo wrote:
> This patch introduce the following functions to handle btrfs subpage
> uptodate status:
> - btrfs_subpage_set_uptodate()
> - btrfs_subpage_clear_uptodate()
> - btrfs_subpage_test_uptodate()
>    Those helpers can only be called when the range is ensured to be
>    inside the page.
> 
> - btrfs_page_set_uptodate()
> - btrfs_page_clear_uptodate()
> - btrfs_page_test_uptodate()
>    Those helpers can handle both regular sector size and subpage without
>    problem.
>    Although caller should still ensure that the range is inside the page.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/subpage.h | 115 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 115 insertions(+)
> 
> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
> index d8b34879368d..3373ef4ffec1 100644
> --- a/fs/btrfs/subpage.h
> +++ b/fs/btrfs/subpage.h
> @@ -23,6 +23,7 @@
>   struct btrfs_subpage {
>   	/* Common members for both data and metadata pages */
>   	spinlock_t lock;
> +	u16 uptodate_bitmap;
>   	union {
>   		/* Structures only used by metadata */
>   		bool under_alloc;
> @@ -78,4 +79,118 @@ static inline void btrfs_page_end_meta_alloc(struct btrfs_fs_info *fs_info,
>   int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
>   void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page *page);
>   
> +/*
> + * Convert the [start, start + len) range into a u16 bitmap
> + *
> + * E.g. if start == page_offset() + 16K, len = 16K, we get 0x00f0.
> + */
> +static inline u16 btrfs_subpage_calc_bitmap(struct btrfs_fs_info *fs_info,
> +			struct page *page, u64 start, u32 len)
> +{
> +	int bit_start = offset_in_page(start) >> fs_info->sectorsize_bits;
> +	int nbits = len >> fs_info->sectorsize_bits;
> +
> +	/* Basic checks */
> +	ASSERT(PagePrivate(page) && page->private);
> +	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
> +	       IS_ALIGNED(len, fs_info->sectorsize));
> +
> +	/*
> +	 * The range check only works for mapped page, we can
> +	 * still have unampped page like dummy extent buffer pages.
> +	 */
> +	if (page->mapping)
> +		ASSERT(page_offset(page) <= start &&
> +			start + len <= page_offset(page) + PAGE_SIZE);

Once you gate the helpers on UNMAPPED you'll always have page->mapping set and 
you can drop the if statement.  Thanks,

Josef

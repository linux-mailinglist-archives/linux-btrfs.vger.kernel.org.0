Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C9C12E898
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 17:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgABQS2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 11:18:28 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:42772 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgABQS1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 11:18:27 -0500
Received: by mail-qv1-f65.google.com with SMTP id dc14so15165447qvb.9
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 08:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8VfjohvsgAc2a4DI0sCVK0MgXjWFu+59Tt2fV//tIrc=;
        b=lkMtKPpqsbfLOZilwpoyn0vHDdekee+kPCgpD4QytRRbdpvMJ47twwyjDt+xIZKG6f
         p9SU0cpqmxq7gPrzA4LIX9eV/QClJZIOqrc56oNai10Ym+WifK6bVMXxQz58RrSfDj2X
         v6AwdJCGPntGPCoSmhgtHHo6qVjMklAKuj9mLDYFOfFb5TEtLuKX3jGLDuDFMdhNFdZP
         Mk2+fyNxNlIgB9gIY7vXr8ZC97o108r3Vk/P3GkDkOOlAtCAjJc6ql1oAPrMWHui/UOR
         dFyqmwcUJuMiA8ujC/eSKBa8pBX3MdC0mPKA/WteYBc6BG/8fbMwrsxRJZobF1TUYLLz
         ZaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8VfjohvsgAc2a4DI0sCVK0MgXjWFu+59Tt2fV//tIrc=;
        b=OiqvlCyCdkelYS3ZpJqp01i4nuwaRxcWlQc7XlvqmlLS7brGRuWUF7GfEopchGGJjd
         pPAp2SKd/VbCywnBYbp92aJUYzT/DUwg+GcUG8jpXI1Txl0wH6rHZhSSyxscpE6pAu7I
         vbDJf7G40UouWLCZXY2H95r3HYoIUoXqyVZ8sL+qsP0KgsJN0uDsC5Rd3adZcmdvurJV
         +LYQbOugmF/TSZtPDY5D8+p2mS6s9gd+OeJ4mfu3V7inSfu4VGv9oq8yb2rd45X6GMmi
         VESOg/f/RjgglRroJShLRvn8MF2LwFujSd8vBgoy6dHducRV+WQAemVEkEhWO7JWSWp9
         eoIg==
X-Gm-Message-State: APjAAAVIj0kIVFyViLv+WZGup7G5DqTRFQ7Q0swF7W+FjThAmrrWbDTi
        mnU66A6/qQi8XL6xeWaspSTFCA==
X-Google-Smtp-Source: APXvYqwBy6f5yD+LiIATKnZAiLUmwnx7qyQTnqY/mXbutSU1I1cAsC5M7rU4jiDO2qeQG29aWDTcIg==
X-Received: by 2002:a05:6214:14b3:: with SMTP id bo19mr63154864qvb.93.1577981906802;
        Thu, 02 Jan 2020 08:18:26 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::be95])
        by smtp.gmail.com with ESMTPSA id 200sm15226725qkn.79.2020.01.02.08.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 08:18:26 -0800 (PST)
Subject: Re: [PATCH v2 3/4] btrfs: space-info: Use per-profile available space
 in can_overcommit()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Marc Lehmann <schmorp@schmorp.de>
References: <20200102112746.145045-1-wqu@suse.com>
 <20200102112746.145045-4-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <16e4a6d7-23d0-697d-8f2d-69766bd6384c@toxicpanda.com>
Date:   Thu, 2 Jan 2020 11:18:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200102112746.145045-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/2/20 6:27 AM, Qu Wenruo wrote:
> For the following disk layout, can_overcommit() can cause false
> confidence in available space:
> 
>    devid 1 unallocated:	1T
>    devid 2 unallocated:	10T
>    metadata type:	RAID1
> 
> As can_overcommit() simply uses unallocated space with factor to
> calculate the allocatable metadata chunk size.
> 
> can_overcommit() believes we still have 5.5T for metadata chunks, while
> the truth is, we only have 1T available for metadata chunks.
> This can lead to ENOSPC at run_delalloc_range() and cause transaction
> abort.
> 
> Since factor based calculation can't distinguish RAID1/RAID10 and DUP at
> all, we need proper chunk-allocator level awareness to do such estimation.
> 
> Thankfully, we have per-profile available space already calculated, just
> use that facility to avoid such false confidence.
> 
> Reported-by: Marc Lehmann <schmorp@schmorp.de>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I don't expect this will change much as you mess with the other code, so you can 
go ahead and add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

To this one, thanks,

Josef

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6B32B24C9
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 20:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgKMTnD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 14:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgKMTnD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 14:43:03 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77782C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 11:43:03 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id r7so9935294qkf.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 11:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/XKwhcC9VkUKYEEaFO5+j9WKlC5szpTLVk/8mVfiGyU=;
        b=POdOVmRXhT/TKKJf4vWUNpEIamdaRWnH3wghN6e+JZPedOpUvpCboyuF5dp87Bs3nD
         9hB92AB7/xDy7R21HSCYGpWXb3hdm3Kxy8lyEOQtE/P7wjUYvMwsGNFFVRVKPsX3O6K+
         bEIqwMvI45Wrl6qXO/QsUkfYqqGML1Qq/A8pi5l66CCFpptYGJBZC/cSeMHeuDTSp/7K
         ge/RN7W0Kj792Dhol+dhgR4GltKEoMXMEeOKpW7w0nyrnfBv4s5aP//oWM6DsS3n8Rc7
         sRXTfV2eQXaR4B/GQXMCk6djzZ7w87ysDBEVEe1FkSGskZN3qZvLZcIUwS8ovfuklCLb
         OaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/XKwhcC9VkUKYEEaFO5+j9WKlC5szpTLVk/8mVfiGyU=;
        b=hk7C5jvN6ICJcN+qoL/655mstz4HKNHZXfWo+gOWMC5yIqEdIlC074GpIwmStRNcE7
         UtohSzVPpiEiHP95ky8xQC+VriucGlC5vaRBGEfIGqJd3M4cQ3tZ243GZ+9eKtyke5VE
         lX9kLaIcTbRsLJUOy2C2FjtUH4DLC1tpJkj5iL0yeVH0a4LsG7FL/qZzOFvJWXrYquE7
         +Qm+Vo9Wk/LLEgVgSU+Z2bp3KmmmeMuQExHIHruuX2nIk3CBIbU6f1IcKBXcFyjvlr8A
         qqcx/KuN4SFRBN739aXHUYthcMOgPoejKHhFBt2F6rpNB1qicL23ivPoJKgHJ634XTWC
         mpWQ==
X-Gm-Message-State: AOAM531Zwsm0A6KfoFsarF8As3pJZwnFW8xn8n11aKJ9Bx9b8lTE7Kyz
        jaFqeer12wP18gO2CjVVThocNA==
X-Google-Smtp-Source: ABdhPJwtsp/ABG+jV1/5xyJe1oXRkXszHpl2B4Z7FB7qQpfAL2MTC1LLN3Q/q/hz253eqPyGk9nUDA==
X-Received: by 2002:a37:6fc1:: with SMTP id k184mr3627658qkc.183.1605296581649;
        Fri, 13 Nov 2020 11:43:01 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t133sm7604650qke.82.2020.11.13.11.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 11:43:00 -0800 (PST)
Subject: Re: [PATCH v2 08/24] btrfs: inode: make btrfs_verify_data_csum()
 follow sector size
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-9-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <110796ff-1f05-4887-3db4-e01d25b3ffaa@toxicpanda.com>
Date:   Fri, 13 Nov 2020 14:43:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201113125149.140836-9-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/13/20 7:51 AM, Qu Wenruo wrote:
> Currently btrfs_verify_data_csum() just pass the whole page to
> check_data_csum(), which is fine since we only support sectorsize ==
> PAGE_SIZE.
> 
> To support subpage, we need to properly honor per-sector
> checksum verification, just like what we did in dio read path.
> 
> This patch will do the csum verification in a for loop, starts with
> pg_off == start - page_offset(page), with sectorsize increasement for
> each loop.
> 
> For sectorsize == PAGE_SIZE case, the pg_off will always be 0, and we
> will only finish with just one loop.
> 
> For subpage case, we do the loop to iterate each sector and if we found
> any error, we return error.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef


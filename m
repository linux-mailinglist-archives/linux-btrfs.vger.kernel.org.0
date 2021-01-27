Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB8930611F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 17:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhA0QhK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 11:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbhA0QgK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 11:36:10 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1ECC0613D6
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:35:29 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id n7so2296913qkc.4
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IZ3e4ZNyWjInugbKP8rgk2TOYZ9rSI32VBGWEa5ifrs=;
        b=QIk6CnXMzwfirTkgSJja95odV7lv1/BC2/lOw9747y0jE19G1B4Dx4pXzmoKCbhDhk
         RWC0EevB2FnuyG2M1eUtvgOUs2prGJay2Lwb0LHmBoJ91amWthke+7ksiFf/sZs8/f+x
         FX3YBZLQ8AUfh3TzLx+G1jvxO7Y3Kpt1YQ+Httx0Dn8m12DKmu+i4zM4AgJhMArrpG5v
         UEuRRIpo7G1u+7ewRlyUjX2BgNeQtBitJ1aVGNWZyJU409MjmLjZwL4Rdnd6f2l6pCQP
         kAL2cz6a0tMZ5Da8Rm2Y3pydzI6jAdz7oOxIQSAs9GpbUP09bZbLvXMKHPLNT5S94tDy
         1Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IZ3e4ZNyWjInugbKP8rgk2TOYZ9rSI32VBGWEa5ifrs=;
        b=aYbiosTMjzR+1YEwCo/P3ARAKF4KYxGjTvUVpPhMeaCEdr0c0nH0Cu7koUPgWns5xS
         ZYec6EpNLmKeU5qyOQ5h/EoMiCkAKLOVyyjdfScI90kUHmfZB/bba6SlXpnb9QWSHi6P
         GWrMHHhjxdgS0LwuQqdLA6ZE3SNL2F8Boi9i/MithT8yHRpB7+9q/EJwOKK/CTAwfS1Q
         farytXJ9dCd1vpq9+BUPArG9DBXlIfNMwA1SKYwjSNQQ26mJ0zRUwS9T2LeO9B576kHS
         C+urWsTbMWfzyB/cT/60UAZ3n/u8MFy2VmHI9qladtb/ZQDFSY3SB/aPJSWiSDpmIi9x
         CkQA==
X-Gm-Message-State: AOAM533+VCiI2+ldvY9NjlYlLo8eEw5IoIdNSWW6VuUwBmP14g5DRAvQ
        yYbDbz8DOB6NA1zepSw8nPrLkPfpkihV2A+t
X-Google-Smtp-Source: ABdhPJw1XvlEaGnASUaWMb0ZpMQ7XNZeeRe/gEADVXcmRuMsGK+Qh0oVMSTYHwii2550PZCz+nagCw==
X-Received: by 2002:a37:8b81:: with SMTP id n123mr11614711qkd.242.1611765328974;
        Wed, 27 Jan 2021 08:35:28 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j21sm1524614qtr.74.2021.01.27.08.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 08:35:28 -0800 (PST)
Subject: Re: [PATCH v5 10/18] btrfs: support subpage in
 set/clear_extent_buffer_uptodate()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
 <20210126083402.142577-11-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <66795dd0-a9b9-4535-1a86-2c6ba3412d51@toxicpanda.com>
Date:   Wed, 27 Jan 2021 11:35:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126083402.142577-11-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/21 3:33 AM, Qu Wenruo wrote:
> To support subpage in set_extent_buffer_uptodate and
> clear_extent_buffer_uptodate we only need to use the subpage-aware
> helpers to update the page bits.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

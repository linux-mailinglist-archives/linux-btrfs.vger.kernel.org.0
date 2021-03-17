Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D410B33F505
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 17:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhCQQG1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 12:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhCQQFz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 12:05:55 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F4AC06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Mar 2021 09:05:55 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id c6so1799802qtc.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Mar 2021 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=727DeB6qw5yjA3Fg1TvNxOFCNoi6AqTXsVoRgzYlGSo=;
        b=UXvlQygvFZurg5JhF0JrHOGGb+vh8SlMrd+omJcRX7u+beK1wGNsc9hf89qtAopVm+
         +Z3F5WMy6+UlsN1bJnfNjDq5u/htsKIcj4zgUxv2ggIt75L1QktFEliWILIz8nhRDFDa
         W8YmnjLElml3BNIcnhXEN2aT2QZWgbve4njsLwb97TFb37Z2DWVDMI+LeChrI92lNJX4
         vtwFFkvyhaefV4kcDIgBLLGt8fArqG3xEGfj5EVtGP2uxkJqkLyw4S0gtAdijdOCCWH7
         /+u4uDCa+er5JljWUOOBxdqwIaAk5PrsuuspQ43qMmZK4/bm2WC7UyQt7G6A/SAMxVqT
         ZJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=727DeB6qw5yjA3Fg1TvNxOFCNoi6AqTXsVoRgzYlGSo=;
        b=SL6+/U+PIELQIMmawr47QH2cYVLRNA6FOqCmMMUEndfF9QVQeZYWmse1gWJr3YM3xT
         KbtFrdQR44NEqjXN1OkkPDo0+SMFEzPL6PWdp0VrcbQX4k+GuXKOiqxR4vpseVzOvZrR
         4b8MnXe7rkKL9vVPsNkcGBhbZDCnpmcvDrW++5vGFWp7oy2mCkAKYADQOxHKm1zOQVh+
         yqbC6jTrugmZ9Np+modQwNvQ4cP9RZ6Yt8SjwPD4h0Se6ujCFcgUelmyiMc9GdgxTNG3
         TByFasKtsBKyz/UX/BLRIA0HuZf8F4mWjnvxmu8cLgt86+BlGILRckeBXAy27PdPYsIY
         w1Kw==
X-Gm-Message-State: AOAM533pWHrYR9UaB0v4gqYrDcsByz3QAKHjxn4QRMdTmLMkUVH3RKFa
        20bkFqk6Bje3XJdM/cYy65seAwRYwGdza824
X-Google-Smtp-Source: ABdhPJz0IlEUx0G9g32/OqDa1RCRqhC39v+C4P7g6+J3r1wicpAn6gnFhH2M+C3VLSy0+nCg/OaRnQ==
X-Received: by 2002:ac8:5cc4:: with SMTP id s4mr4549795qta.214.1615994932343;
        Wed, 17 Mar 2021 08:28:52 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c13sm17289575qkc.99.2021.03.17.08.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 08:28:51 -0700 (PDT)
Subject: Re: [PATCH] btrfs: zoned: automatically reclaim zones
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
References: <321e2ff322469047563dfce030814d58a8632a60.1615977471.git.johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0467cd28-efb8-cf31-89dc-3094cb02d96c@toxicpanda.com>
Date:   Wed, 17 Mar 2021 11:28:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <321e2ff322469047563dfce030814d58a8632a60.1615977471.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/17/21 6:38 AM, Johannes Thumshirn wrote:
> When a file gets deleted on a zoned file system, the space freed is no
> returned back into the block group's free space, but is migrated to
> zone_unusable.
> 
> As this zone_unusable space is behind the current write pointer it is not
> possible to use it for new allocations. In the current implementation a
> zone is reset once all of the block group's space is accounted as zone
> unusable.
> 
> This behaviour can lead to premature ENOSPC errors on a busy file system.
> 
> Instead of only reclaiming the zone once it is completely unusable,
> kick off a reclaim job once the amount of unusable bytes exceeds a user
> configurable threshold between 51% and 100%.
> 
> Similar to reclaiming unused block groups, these dirty block groups are
> added to a to_reclaim list and then on a transaction commit, the reclaim
> process is triggered but after we deleted unused block groups, which will
> free space for the relocation process.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

I think this is generally useful, but we should indicate to the user that it's 
happening via automatic cleanup and not because of somebody using btrfs balance 
start.

As for doing it on non-zoned, I'm still hesitant to do this simply because I 
haven't been able to finish working on the relocation stuff.  Once my current 
set of patches get merged I'll pick it back up, but there still remains some 
pretty unpleasant side-effects of balance.

Chris and I have been discussing your RAID5/6 plan, and we both really, really 
like the idea of the stripe root from the point of view that it makes relocation 
insanely straightforward and simple.  I think once we have that in place I'd 
feel a lot more comfortable running relocation automatically everywhere, as 
it'll be a much faster and less error prone operation.  Thanks,

Josef

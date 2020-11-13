Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875912B2517
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 21:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgKMUGC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 15:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgKMUGB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 15:06:01 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BD8C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 12:06:01 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id ek7so5218739qvb.6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 12:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FAwEL4UzI74aqnA+xdkcFGyXbmWRZM69/9foDyh2z2U=;
        b=XpWT5UF8YWpijG+yloA8SH4RCbEAA/XyrY9PcMRm0d9ftJbD50Dz9k4KqlWVs8PVwi
         3NAvNVMm0RTiFH9Lb8U610zIuB3H9pAMJcTiYv6vK68CWekokXN4fZsGk9ApxpG9u3UB
         Mz2t32JLMvY5NKv2tTV3Y7RlKUugSXoXBhQm+gbJGJku6y/IWwkUOrLfaqwTUipIhfie
         q9HA8KXhK9nNPo7tGiYSRvKQII6zVxL+bnWn55A8oX0e7EgUAITgMCVkzsJS2CtGOTeu
         BdjBG/2MpqFt7M1CUIibOdeqaQBSYl+n+nDpOWqAkeHvtCflCvLWu/ZxUNZR6CViajwA
         kXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FAwEL4UzI74aqnA+xdkcFGyXbmWRZM69/9foDyh2z2U=;
        b=GMOv0OKKJm7yW00oQQZd1W8DHjOZ41rutYPSS398OrWaw8IdG7iv3e4qsydSoL7tRs
         kmRIToCBfdAWCwDAW3X3WIxpTdUl/20OHGSlyEb42CdcIfy0LyM5w94qAPzmsaqSmFi1
         eOxQtdhBWw2ySUgBqsNalNAb/MUol1wVfoNkHnnRxI6xVxR+l/C2UvL9lC9f+8irkzHs
         vzg5y+C9luM6LotJ88FWEZVOCpLBs/8yJAtg3rRSpVygPEf7cBvdIBJBKQfv5UDza7cv
         p+JabLY3NfYx2jSHPYdsHpErfGx4S31mP5nYneOX2IlXY7n49cSVrv1hFNjd8/O57zA9
         MrpQ==
X-Gm-Message-State: AOAM530PBfwIwyBfmFTLTKNUnIciooAkVJFXnEWkfOi9F5dIoxwhzt3M
        2BkXrUMt1yWkrVPlMIqqiLfbDncFMC8Yrw==
X-Google-Smtp-Source: ABdhPJxvaQ/zb5KWnv6RSFFsNhi/9zs3D1XNCBcBW8AEA4q/cMUpQsRabVufR0uCdpLt4Fl809cZDQ==
X-Received: by 2002:a0c:fc52:: with SMTP id w18mr4211523qvp.48.1605297960569;
        Fri, 13 Nov 2020 12:06:00 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y24sm6826867qtv.76.2020.11.13.12.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 12:05:59 -0800 (PST)
Subject: Re: [PATCH v2 00/24] btrfs: preparation patches for subpage support
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201113125149.140836-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <aa91547f-5b78-b149-e435-1bca63f4aa13@toxicpanda.com>
Date:   Fri, 13 Nov 2020 15:05:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201113125149.140836-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/13/20 7:51 AM, Qu Wenruo wrote:
> This is the rebased preparation branch for all patches not yet merged into
> misc-next.
> 
> It can be fetched from github (with RO mount support using page->private)
> https://github.com/adam900710/linux/tree/subpage
> 
> This patchset includes all the unmerged preparation patches for subpage
> support.
> 
> The patchset is sent without the main core for subpage support, as
> myself has proven that, big patchset bombarding won't really make
> reviewers happy, but only make the author happy (for a very short time).
> 
> Thanks for the hard work from David, there are only 24 patches unmerged.
> 
> Patch 01:	Special hotfix, for selftests. Should be folded into the
> 		offending patch.
> Patch 02:	Fix to remove invalid test cases for 64K sector size.
> Patch 03~08:	Refactors around endio functions (both data and
> 		metadata)
> Patch 09~14:	Update metadata related handling to support subpage.

Sorry Dave, should have just done it this way, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

for 1-14.  Thanks,

Josef

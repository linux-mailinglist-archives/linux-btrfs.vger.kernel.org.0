Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49B3241FE0
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 20:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgHKSpT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 14:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgHKSpS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 14:45:18 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD82FC06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:45:18 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v22so10201672qtq.8
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BPZLP2vL8uKKtwIafPnAITshkihOWpnvPEHrJuFaC68=;
        b=OR+X2onISf2XCHI9v1sa+PmWtzEld0lMBHfiRiXlH0GaJlvfWkSxi2zGevBT3GQAAD
         RN6A/+Bw/LC4kZB3g4HJwa/V6j0OIpnob767YJW42hNSziwrOIKxAkL/ARBgM7mO7CC3
         klbUzdLi4pwRTmZhPwxJASUuOB5zsH9q4lL/Y997QdzsITK5tV4qofjiiByGTCN9syEB
         lPinal3GTgDhtaJwyDfr4kkJCxq5XvDeA06bOehh4LdDeDOAnJWgU0a8QAXtMSyWhj9Z
         dDO5l9eABxeVbh/QGm6lzkotlv1lGRb5Oy/xe+s9S6mQS6CS1rLBDaFGWT5m4lxmm9Pq
         f8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BPZLP2vL8uKKtwIafPnAITshkihOWpnvPEHrJuFaC68=;
        b=jJ/dkHSIzzs2SCsWqUDojIBiR9Pb1+G5JEb5mwondjq4LG59IAOlsNMgYQUHy1GprB
         WzSpUjIUXIeabRGh9x2zcIztN4NBV68KHgnAj7yN6+qRWw+SDSmkqvQw5VV0I4OaXZLi
         u3ZfdbHxXsDNZ4DC+GYQl+wnAHehroULoREqQQ/WZiuJsT7lEFtI5EdQmVtLeXatm4Ov
         cCFv/0g8p/YG+WFBv3F2hUAtjcZ1J300N7n0RGLk26JTyVFq+/sCcX8O3mDq3bl2rXa5
         jofYr+59MmmfRFAj0y+5+skyQ27bPMSWOABJVQhpA2viBOzPE7WOD5G4hdyqRNcB0tMi
         UWbw==
X-Gm-Message-State: AOAM5315NVJnChhoSK7uR+LLaEXNOSny7MikUH2xfXC+4n0kgqThCWkD
        3g6i31HTUmjEVT6Ox0BK+1xIjw==
X-Google-Smtp-Source: ABdhPJzcwkDiVfPZ/H+H3hdF5vYhvW53JoKkcSHy8GNTv7REpgfw0X4IaXJbVSOLl9SNrDVSG5Sv3A==
X-Received: by 2002:aed:27d5:: with SMTP id m21mr2633084qtg.4.1597171517871;
        Tue, 11 Aug 2020 11:45:17 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t25sm20279248qtp.22.2020.08.11.11.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 11:45:17 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] btrfs: extent-tree: Kill BUG_ON() in
 __btrfs_free_extent() and do better comment
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
References: <20200809120919.85271-1-wqu@suse.com>
 <20200809120919.85271-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <858916ad-f295-33fc-e0e5-ca5399417242@toxicpanda.com>
Date:   Tue, 11 Aug 2020 14:45:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200809120919.85271-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/9/20 8:09 AM, Qu Wenruo wrote:
> __btrfs_free_extent() is one of the best cases to show how optimization
> could make a function hard to read.
> 
> In fact __btrfs_free_extent() is only doing two major works:
> 1. Reduce the refs number of an extent backref
>     Either it's an inlined extent backref (inside EXTENT/METADATA item) or
>     a keyed extent backref (SHARED_* item).
>     We only need to locate that backref line, either reduce the number or
>     remove the backref line completely.
> 
> 2. Update the refs count in EXTENT/METADATA_ITEM
> 
> But in real world, we do it in a complex but somewhat efficient way.
> During step 1), we will try to locate the EXTENT/METADATA_ITEM without
> triggering another btrfs_search_slot() as fast path.
> 
> Only when we failed to locate that item, we will trigger another
> btrfs_search_slot() to get that EXTENT/METADATA_ITEM after we
> updated/deleted the backref line.
> 
> And we have a lot of restrict check on things like refs_to_drop against
> extent refs and special case check for single ref extent.
> 
> All of these results:
> - 7 BUG_ON()s in a single function
>    Although all these BUG_ON() are doing correct check, they're super
>    easy to get triggered for fuzzed images.
>    It's never a good idea to piss the end user.
> 
> - Near 300 lines without much useful comments but a lot of hidden
>    conditions
>    I believe even the author needs several minutes to recall what the
>    code is doing
>    Not to mention a lot of BUG_ON() conditions needs to go back tens of
>    lines to find out why.
> 
> This patch address all these problems by:
> - Introduce two examples to show what __btrfs_free_extent() is doing
>    One inlined backref case and one keyed case.
>    Should cover most cases.
> 
> - Kill all BUG_ON()s with proper error message and optional leaf dump
> 
> - Add comment to show the overall workflow
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202819
> [ The report triggers one BUG_ON() in __btrfs_free_extent() ]
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

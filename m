Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E252B1990
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 12:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgKMLGE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 06:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgKMLEN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 06:04:13 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C9EC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 03:03:42 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id t5so6373050qtp.2
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 03:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0llzJQu+tJV10GGIQ4cpE+w3ySUdYCHsopB9jRCnEcw=;
        b=F1LE3QXBMIFfKhSTZE/4/Hrdcil2GZxLa5kbisRYMIikI06KVWm2pifRKycbqIVnaP
         UsQYRu45WJCVzOlpML4f6g/dc17KjCSPKPBFkaeqCZCHqNF3p1tdi7v2hh0IKdMjdM8I
         rc5aKsIoJW+CSLLsJ+OBE+yOa5CB9LvtCPYwQHSBk4R6Di27xnoOpQ2DcxYPDlv2d9y3
         UUYdiHfGnTNYCb6Eej/ry5okP1m2NXKqLPrBsAyd31Tf+6zLjcKQnBblzbRFxuexPLEP
         ywMCYTxp03K4K3XeX5UP5HNzUTNo60/DgcUsYbQehfFCKCI8mEQWNuUrjfJ/WQ0HD6dY
         htug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0llzJQu+tJV10GGIQ4cpE+w3ySUdYCHsopB9jRCnEcw=;
        b=lE2AwP1LjVA/C2DhKBZCaennQpI3sg8NpdPAveXdeoVE2iHP36jWhZH6YL0fjec6JE
         7SBg0lXGihhdujspQaIyw9AOk0iqRFgFkr6wPjoXs82O9YSvwtE0cxSxn7DxFtvXcfR1
         llgr2MH1v53aH9EPTTO5MSIBP2Mlzjs/L3/99G5I55oS/L3e9p2ip1Q9Y3rNj+Ouw8Sw
         qk/mEzj24l++m3aEqAq1VBLqmTQUJ4BpMnxRcf9XND/9tnlyAHTLrM7HBCznLaizOFpm
         xqb9fNgZ0p4QxaacBO8lRgpGvTrlbLB3KHL3wQLN0tHI6bknKnMsG5uRTkxOv7rFy6hY
         zpSw==
X-Gm-Message-State: AOAM531ZGRg5mKWnVr9CqcE3biYQXRuxY3XjQZAQsd2tObHHQ4vt/dXh
        CPIxpEAUMVlvibYKOctW50PVs7EXxqEWZQ==
X-Google-Smtp-Source: ABdhPJx6ciWp8nFV8/fkkq1ZL3Vgb6h9P5CkKyoJ0jx+puREVr/Q/1u2bhqltEP1b63iv7/Q2eiJbQ==
X-Received: by 2002:a05:622a:1:: with SMTP id x1mr1289372qtw.229.1605265421388;
        Fri, 13 Nov 2020 03:03:41 -0800 (PST)
Received: from localhost.localdomain (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r89sm702730qtd.16.2020.11.13.03.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:03:40 -0800 (PST)
Subject: Re: [PATCH 00/42] Cleanup error handling in relocation
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1605215645.git.josef@toxicpanda.com>
 <20201113035342.GB31381@hungrycats.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1658d318-3434-3e27-bcf5-00060233f10c@toxicpanda.com>
Date:   Fri, 13 Nov 2020 06:03:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113035342.GB31381@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/12/20 10:53 PM, Zygo Blaxell wrote:
> On Thu, Nov 12, 2020 at 04:18:27PM -0500, Josef Bacik wrote:
>> Hello,
>>
>> Relocation is the last place that is not able to handle errors at all, which
>> results in all sorts of lovely panics if you encounter corruptions or IO errors.
>> I'm going to start cleaning up relocation, but before I move code around I want
>> the error handling to be somewhat sane, so I'm not changing behavior and error
>> handling at the same time.
>>
>> These patches are purely about error handling, there is no behavior changing
>> other than returning errors up the chain properly.  There is a lot of room for
>> follow up cleanups, which will happen next.  However I wanted to get this series
>> done today and out so we could get it merged ASAP, and then the follow up
>> cleanups can happen later as they are less important and less critical.
>>
>> The only exception to the above is the patch to add the error injection sites
>> for btrfs_cow_block and btrfs_search_slot, and a lockdep fix that I discovered
>> while running my tests, those are the first two patches in the series.
>>
>> I tested this with my error injection stress test, where I keep track of all
>> stack traces that have been tested and only inject errors when we have a new
>> stack trace, which means I should have covered all of the various error
>> conditions.  With this patchset I'm no longer panicing while stressing the error
>> conditions.  Thanks,
> 
> I just threw this patch set on top of kdave/for-next
> (a12315094469d573e41fe3eee91c99a83cec02df) and I got something that
> looks like runaway balances:
> 

Yup I hit this with my xfstests run that I started after I sent these 
out, I got a little happy with deleting things for one of the patches, 
this time I'm running xfstests _before_ I send the next version.  Thanks,

Josef

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7733192B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 20:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhBKTBj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 14:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhBKS7f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 13:59:35 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D6BC061756
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Feb 2021 10:58:55 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id e11so4935597qtg.6
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Feb 2021 10:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XpmCa1VoSqmY4wAuO7YPh11fxvte3bshexmzsAVGzg0=;
        b=Z6FvDtP8hbEOmHdthgfVxt10PSBNqX0XqvtsnrVtERkj1HyUIkBS+xPe3jLNAOx1mD
         8MhtEGPsSnDQEtZsQwiJvUCMHqlBobo7GzdnPP3dVUgGJm52ETFqmzO8cFnjKfSeM0cg
         Ndt4zS9Ai/0F6BFGf3La78EAmcEzTsvvBtjdq+t5swXzAtuT1wFDx4+RxQOsyihQCj6O
         +ytaezird+gM1DLhy9vPcvRNhaXhE0DZH18dwYShQl8HIR+p8NTQCwqF8UlnB5yhkV3H
         ydUPY/Z4loaA1lIC4vuGwLFdSMNa850mn3OS4CAO/ZcrETLMD4x6WiRvKgMuM5d71I5W
         Eb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XpmCa1VoSqmY4wAuO7YPh11fxvte3bshexmzsAVGzg0=;
        b=HCz3Xdjrs/DuzHnlLJGfQbXTrqDeXjf2AlBCbcToSwRFQE978Z6b+yln1fKwHrs9H7
         3wGgiRlWG+fGPiYqnB1mqURJ6sLCxBSTWghuhr1aQw9Ng5JgsI7dQKtpqEDFGfIP1J4b
         /FTP15wz1lYIWOVaC9rxWIy1I6U1Qs+l08mJQAcLdGvK0yFukYSBucwA1oj2sySxThXa
         caKfMt2QUdoFdvgPwkFEvQpPFKJ9iI2guItpbJeyaP3nNiAR0IW2ST+IhzfBQCq8kHeW
         oQ2R0YoF/dud6fHdWvXFz6csSHa3UQtCxEkp2Kmk/5v6WyiYExnmgJR8CTjUsRabTSnl
         01qA==
X-Gm-Message-State: AOAM533NOKKsQ3/Ej+Q/b6eIS02aEq/pTAnvZJgJEjpv8IdYN7ugwH15
        wKard16+JQ3rJg/68/o0GxWSKptZTjVZX6t1
X-Google-Smtp-Source: ABdhPJxfg71NJ66Y9dyrxNLCTTW6NZzIFgL33LYOYOd1wRf0ti2830s+cFcgdfOd7LoaxCgl15BBMA==
X-Received: by 2002:ac8:7546:: with SMTP id b6mr8442477qtr.219.1613069934113;
        Thu, 11 Feb 2021 10:58:54 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d9::11de? ([2620:10d:c091:480::1:47af])
        by smtp.gmail.com with ESMTPSA id l137sm4661215qke.6.2021.02.11.10.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 10:58:53 -0800 (PST)
Subject: Re: [RFC][PATCH V6] btrfs: allocation_hint mode
To:     kreijack@inwind.it, linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <20210201212820.64381-1-kreijack@libero.it>
 <df7f0dd3-d648-ea9f-2856-7034a6833a51@toxicpanda.com>
 <d21f9fec-6ed3-c49c-e274-4879166d9d57@libero.it>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1214cd91-bb4f-19dc-5520-6cb1fe072931@toxicpanda.com>
Date:   Thu, 11 Feb 2021 13:58:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <d21f9fec-6ed3-c49c-e274-4879166d9d57@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/11/21 1:47 PM, Goffredo Baroncelli wrote:
> On 2/10/21 5:04 PM, Josef Bacik wrote:
>> On 2/1/21 4:28 PM, Goffredo Baroncelli wrote:
>>>
>>> Hi all,
>>>
>>> the previous V5 serie was called "btrfs: preferred_metadata: preferred device
>>> for metadata".
>>>
>>
>> A few general points up front, first I'd highly recommend reading our patch 
>> submission guidelines
>>
>> https://github.com/btrfs/btrfs-workflow/blob/master/patch-submission.md
>>
>> specifically the 'Git config options' section, as it tells you how to apply 
>> our git hooks to your local repo.  This will check your patches for all the 
>> automatic formatting things we'll complain about, that way you don't have to 
>> get bogged down in those style of comments in the review.  For example as soon 
>> as I started applying your patches I was getting a ton of whitespace warnings, 
>> these are better caught before sending them along.
>>
> ok
>> Also try to develop on Dave's misc-next branch.  I realize this is a moving 
>> target, so I'm fine with massaging patches so I can review, but again 
>> everything needed massaging.
>>
> ok
>> And finally for a new feature we're going to need an xfstest or two in order 
>> to merge them.  I realize we're still working out the details, but the further 
>> you get into this it would be good to go ahead and have a test that validates 
>> everything.  Thanks,
> 
> Definitely I have to do it. Unfortunately the last time I tried I found complex 
> to setup it. Do you have some link for an "xfstest beginner" ?

I do not, I'll write one and put it in our developer workflow repo.  I'll let 
you know when it's in place.

Josef


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9D831D2A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 23:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhBPW2a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 17:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhBPW2Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 17:28:25 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9601C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 14:27:44 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id x14so11079247qkm.2
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 14:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2H2oj51oiq12eYkxVKpq8a38wU2DluY7cEJYuEExCfo=;
        b=qJoy+uO6JJYOLo/A7HqkOdr6Yj+onnw06XdgyMHKWXT0TfDp+ikKyDG7yyTK1jMWW2
         ajTTE3i11ZXz1DqUbL6IXxx6ClNz9OeDaIWptWvXVBfNBEdPptqahLNUZY+5evoYTLzQ
         p11W4N+WbDZnppK4C/e4AbNYielpCsSThSpwcFF5uzOjVKHlKdoZn6PKIhksKDB9iSjE
         8YLBNFeXXxJAIMWcZ54GzMlg9CMz1VBiau4cAAPpY0hjdOnoTfdZnOq5lNXVQk2AIvWk
         wj9YXDMdjOX3pERsAejECWgT4p9SMVsJqeKjzG5BWkkOZKaHuHc+YS+cufoIcE5hCI9O
         Ys0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2H2oj51oiq12eYkxVKpq8a38wU2DluY7cEJYuEExCfo=;
        b=m2laFH6MJX5iQ/UJPP6s7eqHGwBIL3mg2i07n0kmm3eVtTOtnkI6+cMuRJWAslfm9E
         /RXrPKxOpvZ4B0CVC0TBBA/3qQ6yvjjs16ImOmcNOnS7J9EMEC9ulpyYj8GlXlG6FxtU
         nJPFxydbMUxLdQJlR3BCJhpvZm3EX+VYcVZbMQPvRk5s5P5KsJo5GqX84JXuoBTG46xy
         10E5EokgvyS+EueOAB0puP/JZCTVtWX0PQDygNyPPSPhkD1kU/xL02L53qGM6bS7SMje
         ve3K8/5EAHP4Q5T1U47RgTfK016sdLzgSc/O8B9RIyWir72t+3PlBMRbHaGeqjzkMgUQ
         cuYA==
X-Gm-Message-State: AOAM5311/s6vpLlL8czGZO7qV+F1WV+thzIFBuyV+4gVn8qDyTPtIg3d
        NXjCcCwwNi3OrG0gDEcAyDExKSP8Bzrwm/na
X-Google-Smtp-Source: ABdhPJyxqwKdibgT3XTW1JYbqi5w+n9y2GahzV7ZHPpusmTmzZPD7QhH+mBiq9Msg0fmRQco0zETmg==
X-Received: by 2002:a37:4242:: with SMTP id p63mr21863801qka.396.1613514463699;
        Tue, 16 Feb 2021 14:27:43 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g10sm7755416qto.90.2021.02.16.14.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 14:27:43 -0800 (PST)
Subject: Re: [RFC][PATCH V6] btrfs: allocation_hint mode
To:     kreijack@inwind.it, linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <20210201212820.64381-1-kreijack@libero.it>
 <df7f0dd3-d648-ea9f-2856-7034a6833a51@toxicpanda.com>
 <d21f9fec-6ed3-c49c-e274-4879166d9d57@libero.it>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <11614dfe-f4a5-95ac-093e-838e19330e43@toxicpanda.com>
Date:   Tue, 16 Feb 2021 17:27:42 -0500
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

Sorry this took me longer to get to than I wanted, you can check it out here

https://github.com/btrfs/btrfs-workflow/blob/master/using-fstests.md

let me know if anything doesn't make sense, at this point it's hard for me to 
realize what doesn't make sense in fstests.  Thanks,

Josef

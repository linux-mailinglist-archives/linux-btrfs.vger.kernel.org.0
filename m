Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A8619C8C2
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 20:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbgDBS2f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 14:28:35 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:35211 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388164AbgDBS2f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Apr 2020 14:28:35 -0400
Received: by mail-qv1-f67.google.com with SMTP id q73so2243353qvq.2
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Apr 2020 11:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=j09ssaYOquqRpkovOIG0oKmuENtUCqVLkzDQcm51ew0=;
        b=ZBKbiivuYanuWaxsFWC5yBeNiA/DmVa3EeG0iiotbvDn70ZZ0aADzaGhrQwk2WOZfi
         TyKMXpM1j3vHtKIJW73NEl/oFs15kNCQYS6dZizpiLUgioe+UCos+VhHY8yryhIqIiTW
         yoQviCa5X0QZ+nEfqcWwBdiQts5o1nenipVRbDYNEv5Dyo6NGFMU3Jz+za5kjX8hd0AN
         hwlGLZ9wqntRhcHhqPWVUZYpbqeNEuJOkHteBxmxbpLJvGBBf/+OruUlY8P4e19hQUjp
         FacOtOh1Nky8YvnvKq/Y/cl+keJDnh/ixWDXeRUaPwUdd0WUrzjm3fLfcz9iba4FnxFt
         FW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j09ssaYOquqRpkovOIG0oKmuENtUCqVLkzDQcm51ew0=;
        b=ieGe0rD29pgLQuWg8lObmBfCK/Y6TletVHGSPaRZ30EM639qK8FjzhttLFjzcTWkBC
         LIq0W7uloljlvGCMcNop5yV3Nrf17sYM/0ZtP04spKKwbcs+EcWglrvsiV2gq1bI2rhI
         RfDMarfH20nP2GIwfvH1Z+PD8FWclULNVsagKmZOFlV5fLOZGDrfLC1WMVjYdV3M5BfI
         kRgW3EZFeSQ0yLbY702be+E6NQRfPka73Oi/VQK4zHU3+97LbM/7sxFpUwy43Se/K1TN
         4k+DH/i2iiqk1dsymRrxoh3Nr+2f+bTUxbpzkiE+fMxU7+qrR0ZtBBeERt0q9vIvKnC2
         enwg==
X-Gm-Message-State: AGi0PuYBbPJ0s/aktgvSyuiwKU7rTGd2qv8YKSRQlZzEfMIKvoEw7WNP
        6JDjF6PfeGyup2ImI9HJ/V62Dx8tEbccMw==
X-Google-Smtp-Source: APiQypK5n41+HbjUhzY5/Ptk1Qzq8XJeJyBIbN5/mWHatJznzpjUbZic+gy8tfP8Xc7No4+9hCnSVw==
X-Received: by 2002:a0c:c251:: with SMTP id w17mr4467426qvh.95.1585852112971;
        Thu, 02 Apr 2020 11:28:32 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q24sm4350586qtk.45.2020.04.02.11.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 11:28:32 -0700 (PDT)
Subject: Re: Btrfs transid corruption
To:     Christoph Anton Mitterer <calestyo@scientia.net>,
        linux-btrfs@vger.kernel.org
References: <800B6BF0-64AA-45F5-A539-9D2868C2835C@scientia.net>
 <a8a1e614-d5f0-d4b6-2f0b-626a34761758@toxicpanda.com>
 <2FA13CAC-C259-41BF-BA9E-F9032DFA185C@scientia.net>
 <c0e5cc1b-ddfa-270e-2934-a6470584193e@toxicpanda.com>
 <360ca434f26ced5eca6821294719c463a2dcd910.camel@scientia.net>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <96081d73-5426-0b4e-0fd8-9eac83b06b1b@toxicpanda.com>
Date:   Thu, 2 Apr 2020 14:28:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <360ca434f26ced5eca6821294719c463a2dcd910.camel@scientia.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/1/20 9:56 PM, Christoph Anton Mitterer wrote:
> Hey Josef, et al.
> 
> 
> First, many thanks for the quick help before. :-)
> 
> 
> On Wed, 2020-04-01 at 16:40 -0400, Josef Bacik wrote:
>> btrfs rescue zero-log /dev/whatever
> 
> This worked nicely and at the very first glance (though I haven't
> diffed any of the data with backups nor did I run scrub, yet) it seems
> to be mostly all there.
> 
> 
> I have a number of questions though...
> 
> 
> 1) Could this be a bug?
> Yes I know I had a freeze but, here's what happened.
> - few days ago I've upgraded from 5.2 respectively 5.4 to 5.5.13
>    the system ran already for one day without issues, "before" it
>    suddenly froze, Magic-SysRq wasn't working and I had to power-off
> - I then booted from a rescue USB stick with some kernel 5.4 and btrfs
>    tools 5.4.1
> 
> - did a --mode=normal fsck of the fs, no errors !!
> 
> - then I did a --clear-space-cache v1
>    Every now and then I see some free space warnings in the kernel log,
>    and so I do clear the cache from time to time when I have the
>    filesystem offline
> 
> - I didn't to another fsck directly afterwards unfortunately...
>    if I had done (and saw errors already by then, we'd now know for sure
>    there must be some bug)
> 
> - then I rebooted in the the normal system and there it failed to mount
>    (i.e. the root fs)
> 
> 
> So I mean I could understand that something would have gotten damaged
> right after the freeze, but the fsck there seemed fine,...
> Any ideas?
> 

This was just a corruption of the log tree, so it won't affect your actual data 
thankfully.

As for how this happened, well we had a very long standing problem that I fixed 
in 5.4 where we could mistakenly update the tree log with the wrong block and 
thus get transid mismatches.  But if this happened while on a 5.5 kernel then I 
don't know what went wrong.  I'll go poke around and see if there's any other 
related ways we could make the same mistake.

> 
> 
> 
> 2) What's the tree log doing? Is it like kind of a journal? And
> basically everything that was in it and not yet fully commited to the
> fs is now lost?
> 

It's the fsync log, so if you fsync something between transaction commits (every 
30 seconds) then that's where the data goes.  So assume you lost anything in the 
last 30 seconds of the life of the fs.

> 
> 3) Based on the generation (I assume 1453260 and 1452480 are generation
> numbers?), can one tell how much data is lost, like in the sense of the
> time span?
> parent transid verify failed on 425230336 wanted 1453260 found 1452480
> 
> And can one tell what is pointed to by 425230336?
> 

No way to know really, like I said it's just the fsync log, so you likely didn't 
lose anything you care about.

> 
> 4) The open_ctree failed error one saw on the screenshot... was this
> then just a follow up error from the failure of replaying the log?
> 

Yup, can't replay the log, open_ctree fails.

> 
> 5) Was some backup superblock used now and thus some further
> data/metadata-lost?
> 

Nope, we just told it to ignore the log, everything before is all fine.

> 
> And most importantly:
> 
> 
> 6) Can one expect now, that everything which is now there/seen is still
> valid? Or could there be any file internal corruptions (respectively is
> this likely or not)?
>

Nothing should be corrupt, everything should be a-ok.

> I mean this is what I'd more or less expect from a CoW fs... if it
> crashes some data might be gone, but what's still there is 100% valid?
> 
> 
> 7) Am I advised to re-create the filesystem? Like could there be still
> any hidden errors that fsck doesn't see and that sooner or later build
> up and make it explode again?
> Or is the whole thing just a minor issue and a well known/understood
> clean up procedure from a previous freeze?
> 

This is probably the safest form of failure, I wouldn't expect anything else to 
be wrong.

> Setting it up again (with the recovery) would be just work (not that I
> can access the data again)... so if it's advisable I'd rather go for
> that.
> 
> 
> 8) Any other checks I could/should make, like scrub?
> 

You can if you like, but as I've said, the core of the file system remains 
intact.  Thanks,

Josef

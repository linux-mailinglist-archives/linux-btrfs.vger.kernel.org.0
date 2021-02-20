Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C6A32031F
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Feb 2021 03:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBTCVg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 21:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhBTCV0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 21:21:26 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E47C06178A
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Feb 2021 18:20:46 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id z68so6490464pgz.0
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Feb 2021 18:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gSTCCB0fzNTUP1l+5eYx31ofwbtI5AXxGEPYjYPLSqA=;
        b=i4hJ1oPfMsNGEpOwMcRdyKUOZ8Imrz6W57beqIyvRorlQNlSRp5TIegxzzzoyfMYtJ
         /35I0JBScWDTvlLw1fHrRR4rIupYZbRsXuSK5zm6Vx+5DogidTVEM66IUciQfQIpkljj
         8GPgcuYyxxWQg8+2wqJL8eS1zNp1OhokMMZWbV4GFGN2Ssn0K5/YtR80MBAwHovtWn64
         tW2AC09UPYpNnJF+JHqrGRnlrGhH7pj1bEYdpD7Ue7F0UECA8lN9O67P7NQsSJ059JBd
         je2JYOrU2bpIa6AdaARwf+O5cV4T+nP83h2sibxkBkF2VLYIbDyKq1004otPv58oa1Da
         MV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gSTCCB0fzNTUP1l+5eYx31ofwbtI5AXxGEPYjYPLSqA=;
        b=P5i5idHiNnIMf7RQkhwJDEeKdRfgx7yUdu5CtxB0yKBnWAsT8ZzShS3XsQbVeGhhNl
         9HuzG8So2im+yKN+DLEULIFj9nHA47Qc9E+Io+9X51jcPPVztg6Gv9LHYwEjYFeKGd+D
         IiLoJe87PHZ3sBWdxzudMG64ivJGU3ksWzyAOxb9UZ2McGxp2kK2rCEF23pEXgM87w6O
         FyRb6Yw0Try+xP2El4FDJNNAufjU7ZETlXyGC0rq541NzrXcSLVG5/V8tHVg1rFwPHgC
         6wdS2UZImVKyAQ6uh46XpskRnxazqVABMA2ZhkT3Nx8VobW1P5xsJDoxGjPNcWRSI5xG
         TTlQ==
X-Gm-Message-State: AOAM53194u0rgj0XwJC+loyZYDDAaHy2xKrte++0Wn94c9xiL+9sLEeN
        3BlxqKPhp1wg4eJryBFBeqK1/MfPtpQEp+YJVwE=
X-Google-Smtp-Source: ABdhPJwhhv5MyxWhhSmcx+037umRXGPAy3f+jBiftsaIqSY5aDj2aQRjU/MwDHaUvGYzW2eKoYUjuA==
X-Received: by 2002:a63:cd08:: with SMTP id i8mr11017284pgg.425.1613787645282;
        Fri, 19 Feb 2021 18:20:45 -0800 (PST)
Received: from [10.64.183.147] (static-198-54-131-136.cust.tzulo.com. [198.54.131.136])
        by smtp.gmail.com with ESMTPSA id x9sm10976293pfc.114.2021.02.19.18.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Feb 2021 18:20:44 -0800 (PST)
Subject: Re: page->index limitation on 32bit system?
To:     Theodore Ts'o <tytso@mit.edu>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com>
 <20210218121503.GQ2858050@casper.infradead.org>
 <af1aac2f-e7dc-76f3-0b3a-4cb36b22247f@gmx.com>
 <20210218133954.GR2858050@casper.infradead.org>
 <e0faf229-ce7f-70b8-8998-ed7870c702a5@gmx.com> <YC/jYW/K9krbfnfl@mit.edu>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Message-ID: <a79562ac-1b87-8761-05a6-43b911e093a0@rkjnsn.net>
Date:   Fri, 19 Feb 2021 18:20:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YC/jYW/K9krbfnfl@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/19/21 8:12 AM, Theodore Ts'o wrote:
> On Fri, Feb 19, 2021 at 08:37:30AM +0800, Qu Wenruo wrote:
>> So it means the 32bit archs are already 2nd tier targets for at least
>> upstream linux kernel?
> 
> At least as far as btrfs is concerned, anyway....
> 
>> Or would it be possible to make it an option to make the index u64?
>> So guys who really wants large file support can enable it while most
>> other 32bit guys can just keep the existing behavior?
> 
> I think if this is going to be done at all, it would need to be a
> compile-time CONFIG option to make the index be 64-bits.  That's
> because there are a huge number of low-end Android devices (retail
> price ~$30 USD in India, for example --- this set of customers is
> sometimes called "the next billion users" by some folks) that are
> using 32-bit ARM systems.  And they will be using ext4 or f2fs, and it
> would be massively unfortunate/unfair/etc. to impose that performance
> penalty on them.

A CONFIG option would certainly work for my use case. I was also 
wondering (and I ask this as and end user with admittedly no knowledge 
whatsoever about how the page cache works) whether it might be possible 
to treat the top bit as a kind of "extended address" bit, with some kind 
of additional side table that handles indexes more than 31 bits. That 
way, filesystems that are 8TB or less wouldn't lose any performance, 
while still supporting those larger than 16TB.

I assume the 4KiB entry size in the page cache is fundamental, and can't 
be, e.g., increased to 16KiB to allow addressing up to 64TiB of storage?

> It sounds like what Willy is saying is that supporting a 64-bit page
> index on 32-bit platforms is going to be have a lot of downsides, and
> not just the performance / memory overhead issue.  It's also a code
> mainteinance concern, and that tax would land on the mm developers.
> And if it's not well-maintained, without regular testing, it's likely
> to be heavily subject to bitrot.  (Although I suppose if we don't mind
> doubling the number of configs that kernelci has to test, this could
> be mitigated.)
> 
> In contrast, changing btrfs to not depend on a single address space
> for all of its metadata might be a lot of work, but it's something
> which lands on the btrfs developers, as opposed to a another (perhaps
> more central) kernel subsystem.  Managing at this tradeoff is
> something that is going to be between the mm developers and the btrfs
> developers, but as someone who doesn't do any work on either of these
> subsystems, it seems like a pretty obvious choice.
> 
> The final observation I'll make is that if we know which NAS box
> vendor can (properly) support volumes > 16 TB, we can probably find
> the 64-bit page index patch.  It'll probably be against a fairly old
> kernel, so it might not all _that_ helpful, but it might give folks a
> bit of a head start.
> 
> I can tell you that the NAS box vendor that it _isn't_ is Synology.
> Synology boxes uses btrfs, and on 32-bit processors, they have a 16TB
> volume size limit, and this is enforced by the Synology NAS
> software[1].  However, Synology NAS boxes can support multiple
> volumes; until today, I never understood why, since it seemed to be
> unnecessary complexity, but I suspect the real answer was this was how
> Synology handled storage array sizes > 16TB on their older systems.
> (All of their new NAS boxes use 64-bit processors.)
> 
> [1] https://www.reddit.com/r/synology/comments/a62xrx/max_volume_size_of_16tb/
> 
> Cheers,
> 
> 					- Ted
> 

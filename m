Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8A7AFC15
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 14:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfIKMCr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 08:02:47 -0400
Received: from mail-yw1-f44.google.com ([209.85.161.44]:39173 "EHLO
        mail-yw1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfIKMCq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 08:02:46 -0400
Received: by mail-yw1-f44.google.com with SMTP id n11so7710861ywn.6
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 05:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kk5dAnKTj+Qc1sUQptQ2wthgUbnWawKjTy/AoVBEqIw=;
        b=vbIlleAgXzGeY8VZmThC25nOZ1RV9vnhRXIUUVnuOXGL+xFEz8QXKAlxrDqOI1ix8h
         UvAyWgWG3VOD430c7IoJPAGWSgpFqgDLwzJ1zMu0bC2w9YL+h/yplbkvPb+WYQ11p4Ql
         B0/td1BjiW+tJ/fpjyZV9O0Yva14ue3Smck1uLRhEtamnkgNwi9QpJHW1DFPELWlPJgU
         kudnlgPt4SPlQVhMDrKGrBQrNxqba9zrcqyhPJ8O9nPJ+HiZBKIRgfFvQ5jPKe5/mIQe
         /dwTjVXHiRNqeLqzBdN4uF/7MbHtbbJGSUC81rK9PPmvcnSDx59zNJJmiz4VDHwIaAS2
         NmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kk5dAnKTj+Qc1sUQptQ2wthgUbnWawKjTy/AoVBEqIw=;
        b=XMnsjHb1nq7ceaGV3wWUod1UYV4RCGWJF0saSjDnLojjyBxsH+1gQTet3pkJ9ISdCs
         sVMDlmkgrbH2d4MjLHamWM/ARuM7Te5ABFRGoHEwaXuThFGib+CLhIVhH2IhjXq7kDDP
         zISSa+wpVV3KB1nbhNxxJApSVMd3mHNJ6OLC5LY4CJlRnLGCifw/Mox9RyjtxfFK8Dj9
         HwNZQarptTO4IhlPPFBqV6JBveTOKkagf5+teeNn54Az1g/CbKMx4eCAiFWKEk16AvGx
         PsvMwQoHECaomszhuGFVxnqktFy2CoTNupScgjrOkCwskQzGcAspI5DH5Tb2EjUp86mE
         jQmQ==
X-Gm-Message-State: APjAAAWv2aF5jAGcBBReIr/ck1zN+mRcOqbu6Fs/O5aK3u0K4izG/8Su
        OFW3tp0/p/IMTMpK2np13PlQQVNGes8=
X-Google-Smtp-Source: APXvYqyersIa770Ia/tGda0nZ0sjJsiymBgDmPoK2bo5LQXAzcHQ1jBGAyMyUVY44FhALJdbq3SRBQ==
X-Received: by 2002:a81:3583:: with SMTP id c125mr23401425ywa.278.1568203364067;
        Wed, 11 Sep 2019 05:02:44 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id g40sm4415025ywk.14.2019.09.11.05.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 05:02:43 -0700 (PDT)
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     webmaster@zedlx.com
Cc:     linux-btrfs@vger.kernel.org
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
 <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
 <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
Date:   Wed, 11 Sep 2019 08:02:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-09-10 19:32, webmaster@zedlx.com wrote:
> 
> Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
> 
> 
>>> Defrag may break up extents. Defrag may fuse extents. But it shouln't 
>>> ever unshare extents.
> 
>> Actually, spitting or merging extents will unshare them in a large 
>> majority of cases.
> 
> Ok, this point seems to be repeated over and over without any proof, and 
> it is illogical to me.
> 
> About merging extents: a defrag should merge extents ONLY when both 
> extents are shared by the same files (and when those extents are 
> neighbours in both files). In other words, defrag should always merge 
> without unsharing. Let's call that operation "fusing extents", so that 
> there are no more misunderstandings.
And I reiterate: defrag only operates on the file it's passed in.  It 
needs to for efficiency reasons (we had a reflink aware defrag for a 
while a few years back, it got removed because performance limitations 
meant it was unusable in the cases where you actually needed it). 
Defrag doesn't even know that there are reflinks to the extents it's 
operating on.

Now factor in that _any_ write will result in unsharing the region being 
written to, rounded to the nearest full filesystem block in both 
directions (this is mandatory, it's a side effect of the copy-on-write 
nature of BTRFS, and is why files that experience heavy internal 
rewrites get fragmented very heavily and very quickly on BTRFS).

Given this, defrag isn't willfully unsharing anything, it's just a 
side-effect of how it works (since it's rewriting the block layout of 
the file in-place).
> 
> === I CHALLENGE you and anyone else on this mailing list: ===
> 
>   - Show me an exaple where splitting an extent requires unsharing, and 
> this split is needed to defrag.
> 
> Make it clear, write it yourself, I don't want any machine-made outputs.
> 
Start with the above comment about all writes unsharing the region being 
written to.

Now, extrapolating from there:

Assume you have two files, A and B, each consisting of 64 filesystem 
blocks in single shared extent.  Now assume somebody writes a few bytes 
to the middle of file B, right around the boundary between blocks 31 and 
32, and that you get similar writes to file A straddling blocks 14-15 
and 47-48.

After all of that, file A will be 5 extents:

* A reflink to blocks 0-13 of the original extent.
* A single isolated extent consisting of the new blocks 14-15
* A reflink to blocks 16-46 of the original extent.
* A single isolated extent consisting of the new blocks 47-48
* A reflink to blocks 49-63 of the original extent.

And file B will be 3 extents:

* A reflink to blocks 0-30 of the original extent.
* A single isolated extent consisting of the new blocks 31-32.
* A reflink to blocks 32-63 of the original extent.

Note that there are a total of four contiguous sequences of blocks that 
are common between both files:

* 0-13
* 16-30
* 32-46
* 49-63

There is no way to completely defragment either file without splitting 
the original extent (which is still there, just not fully referenced by 
either file) unless you rewrite the whole file to a new single extent 
(which would, of course, completely unshare the whole file).  In fact, 
if you want to ensure that those shared regions stay reflinked, there's 
no way to defragment either file without _increasing_ the number of 
extents in that file (either file would need 7 extents to properly share 
only those 4 regions), and even then only one of the files could be 
fully defragmented.

Such a situation generally won't happen if you're just dealing with 
read-only snapshots, but is not unusual when dealing with regular files 
that are reflinked (which is not an uncommon situation on some systems, 
as a lot of people have `cp` aliased to reflink things whenever possible).

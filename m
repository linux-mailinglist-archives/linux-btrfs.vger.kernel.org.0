Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 232E7168B24
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 01:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgBVAnp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 19:43:45 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:40408 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgBVAno (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 19:43:44 -0500
Received: by mail-qt1-f180.google.com with SMTP id v25so2638710qto.7
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2020 16:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nav9J8qEw9aytb/VBR/YRvrz3HdtUWMLgcHjhZiU4dI=;
        b=grII5WJsCqO+v9nGlEYi65CeRdx8V84ZlUpDr2SkJM7GlRRTT4AVutMfh8SJCkhyw3
         cxA19QgzsYwa8bt6YrGbVeKeOJE1v6ZNiyYx97uz/gHWUK8kPthybrLxo5snb5pCr+U+
         yNKRSE8ldVAWqOwIqd1L1hUROjlnD/nXC1gjA7VZzzgLZUdtBMn1UzbJ51EjehB5+u7p
         dfbYsfm40VE+cWG7t8/TRWRil7aEEmOLa8w2tvegFKS6kSj3TEQz4+WW4s645htkLD+D
         oeCl0SVb8OosoGs5Boi0vpVOT8PCNuHHoAjd/2VrRpLHiT6ZgFPFT9V9aT6FL4Np+Gno
         9xPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nav9J8qEw9aytb/VBR/YRvrz3HdtUWMLgcHjhZiU4dI=;
        b=cCGK5/2B7Z950mkUgc3CR8TwTuAhLRcvQGhM8g9DHHcuCTgeHaH4D0u2TAECCznR6+
         i9vKS5I4P8LHEhQ6yIXXSGZWOAItS0KG+f5Itm0JHflx7VjuF/OxMdf7riJt/uU4e7re
         tgoeMB6dXjjgkf3pmgT+VAR73VvB/ibwUge9S05D5C22gvs3U7wAKFrSgV4cnSi4EdP5
         cZg1ayNlS3ugDvJM7t628MKi1wqbTqwu7VEJTD1+ov8SI4OCOe+skVHI1eHgBEsu9CjN
         i8HsthBtXAbksvyHb3x25jHEpMgLeJoV35GjgKSmgERsrYQvQjTYfXAnXGSrA6o7rrJ+
         KzPw==
X-Gm-Message-State: APjAAAVhbi+AsofUFKo3gKx7krJkpRy63g9+3ZjdLt90vEcQpYAI1Dv5
        r44ykFjUFa+hmjDROk5F0v36VWIADzI=
X-Google-Smtp-Source: APXvYqy9XCfR5oXi5KEZ4t3CuBtC3+hEpEWdYm26YYsFahWb43/BXA2Y478E77jJhMbVys+H3kRMRg==
X-Received: by 2002:ac8:4e46:: with SMTP id e6mr35132599qtw.9.1582332222186;
        Fri, 21 Feb 2020 16:43:42 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::174d])
        by smtp.gmail.com with ESMTPSA id l19sm2304895qkl.3.2020.02.21.16.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 16:43:41 -0800 (PST)
Subject: Re: btrfs filled up dm-thin and df%: shows 8.4TB of data used when
 I'm only using 10% of that.
To:     Marc MERLIN <marc@merlins.org>
Cc:     Roman Mamedov <rm@romanrm.net>, dsterba@suse.cz,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <2656316.bop9uDDU3N@merkaba> <20200219225051.39ca1082@natsu>
 <20200219153652.GA26873@merlins.org> <20200220214649.GD26873@merlins.org>
 <20200221053804.GA7869@merlins.org> <20200221104545.6335cbd1@natsu>
 <20200221230740.GQ19481@merlins.org>
 <3e94351d-6f32-1036-ab24-0dc1b843c969@toxicpanda.com>
 <20200222000142.GA31491@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7fdbfa87-61dd-3b37-b9b5-6d755517f368@toxicpanda.com>
Date:   Fri, 21 Feb 2020 19:43:40 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200222000142.GA31491@merlins.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/21/20 7:01 PM, Marc MERLIN wrote:
> On Fri, Feb 21, 2020 at 06:43:45PM -0500, Josef Bacik wrote:
>>> Well, carap, see how 'used' went from 445.73GiB to 8.42TiB after balance?
>>
>> Wtf?  Can you do btrfs filesystem usage on that fs?  I'd like to see the
>> breakdown.  I'm super confused about what's happening there.
> 
> You and me both :)
> gargamel:/mnt/btrfs_pool2/backup/ubuntu# btrfs fi df .
> Data, single: total=8.40TiB, used=8.40TiB
> System, DUP: total=8.00MiB, used=912.00KiB
> Metadata, DUP: total=17.00GiB, used=16.33GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> Looks like used is back to 8.4TB there too.

Man this is bizarre, does fsck say anything useful?  I wonder if the block 
groups are messed up and saying the wrong value for used.  You said du shows 
only ~400gib of space actually used right?  I'm curious to see what fsck says. 
If it comes back clean I'll write something up to go and figure out where the 
space is.

> 
> 
> 
>>> And now for extra points, this also damaged a 2nd of my filesystems on the same VG :(
>>> [64723.601630] BTRFS error (device dm-17): bad tree block start, want 5782272294912 have 0
>>> [64723.628708] BTRFS error (device dm-17): bad tree block start, want 5782272294912 have 0
>>> [64897.028176] BTRFS error (device dm-13): parent transid verify failed on 22724608 wanted 10005 found 10001
>>> [64897.080355] BTRFS error (device dm-13): parent transid verify failed on 22724608 wanted 10005 found 10001
>>
>> This will happen if the transaction aborts, does it still happen after you
>> unmount and remount?  Thanks,
> 
> the problematic filesystem mounts fine, but that doesn't mean it's
> clean.
> the one that I'd like very much not to be damaged, I'm not touching it
> until I can get my VG back to having it's 50% of free space it needs to
> have, with 99.9x%, it's not safe to use anything on it.
> But thanks for the heads up that my other filesystem may be ok. I'll run
> a btrfs check on it later when it's safe.
> 
> Back to dm-13, it's now hung on umount, I'm getting a string of these:
> [67980.657803] BTRFS info (device dm-13): the free space cache file (4344624709632) is invalid, skip it
> [67991.562812] BTRFS info (device dm-13): the free space cache file (4447703924736) is invalid, skip it
> [67991.755262] BTRFS info (device dm-13): the free space cache file (4448777666560) is invalid, skip it
> [68000.379059] BTRFS info (device dm-13): the free space cache file (4518570885120) is invalid, skip it
> [68013.462077] BTRFS info (device dm-13): the free space cache file (4574405459968) is invalid, skip it
> [68015.286730] BTRFS info (device dm-13): the free space cache file (4589437845504) is invalid, skip it
> [68015.318239] BTRFS info (device dm-13): the free space cache file (4589437845504) is invalid, skip it
> [68016.212246] BTRFS info (device dm-13): the free space cache file (4596954038272) is invalid, skip it
> [68016.730826] BTRFS info (device dm-13): the free space cache file (4602322747392) is invalid, skip it
> [68020.547135] BTRFS info (device dm-13): the free space cache file (4634535002112) is invalid, skip it
> [68021.812820] BTRFS info (device dm-13): the free space cache file (4646346162176) is invalid, skip it
> [68037.173441] BTRFS info (device dm-13): the free space cache file (4768752730112) is invalid, skip it
> [68039.559383] BTRFS info (device dm-13): the free space cache file (4778416406528) is invalid, skip it
> [68040.531083] BTRFS info (device dm-13): the free space cache file (4781637632000) is invalid, skip it
> [68050.184300] BTRFS info (device dm-13): the free space cache file (4843914657792) is invalid, skip it
> [68074.134080] BTRFS info (device dm-13): the free space cache file (4988869804032) is invalid, skip it
> [68078.943126] BTRFS info (device dm-13): the free space cache file (5015713349632) is invalid, skip it
> [68099.512978] BTRFS info (device dm-13): the free space cache file (5151004819456) is invalid, skip it
> [68100.575692] BTRFS info (device dm-13): the free space cache file (5160668495872) is invalid, skip it
> [68100.689222] BTRFS info (device dm-13): the free space cache file (5161742237696) is invalid, skip it
> 
> I knew that filling up a btrfs filesystem was bad, but filling it the
> normal way makes it slow down enough that you usually know and fix it.
> Filling it by having an underlying dm-thin deny writes, is much worse (I expected
> it wouldn't be pretty though, which is why I had a cronjob to catch this before it
> happened, but I missed it due to the df bug).
> 

Yeah I'm curious about this too, it was my understanding that thinp would just 
return an error, which should trigger a transaction abort and then you should 
come back to a completely valid file system.

I sort of wonder if there's a different failure case that allowed some writes to 
complete and let others not, which resulted in this bad file system state.  I'll 
put it on my list of things to investigate, because if that's the case we're 
likely missing some error condition that doesn't trigger a transaction abort 
properly.

We for sure bang the hell out of the "disk starts throwing errors" path, there's 
several xfstests for it and I've spent the last month running a bunch of them in 
a loop, so I know for full failures we're doing the right thing.  Thanks,

Josef

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAACAF1CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 21:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfIJTWJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 15:22:09 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:36583 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfIJTWJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 15:22:09 -0400
Received: by mail-io1-f54.google.com with SMTP id b136so40226347iof.3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2019 12:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QWY/a85omGFRTZSjLBK9oAy0ghb78NiGv/9/WBVzfgA=;
        b=uxZBgSnVOrMyfrfsVpRbCyWkjZ39v1TvhICBdUdGGUpNs+mgMosk26O9TFJLEAWR7U
         RIzStRHcZJWYjKOVovLCLfTOYhiMjOGSOs94PmoGjcWAYA+FmfkRzesVz4V67MUYOuRd
         WQmUJREtvSAlc//yTv67DkiggpbaEYpOlfGVMJNUlCIzU98qMP045zYHKN5Ws/90FynR
         EXZnXKZSBgaEj/h/5wXWK5MurT6miQPQ90+XBRRCV1goYf90X43+mGGH3ZiAkZoWpLQS
         Lz+Ud//rtY/ua4Zcvax2ue+jRy2xELzlDsGRVhZRLHdNjft+uHaxQltH3TozEjqTXYgx
         mQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QWY/a85omGFRTZSjLBK9oAy0ghb78NiGv/9/WBVzfgA=;
        b=WWFqUWzcVITzSY3CQF+k1WrJewi/rVi5Uchh8sRTU4O8Mh+FNggBVA+klYim07Ts6l
         BUvlhoXNZ8q03tDVh4Phbb6kyHqNaRqLOG6atkXoyi+EHDPVvXyQHyCxcQPNibIWSLI8
         aWkMuGi/Wgtwj5odC42wWE2BhEmhtjvO1V0Qi7rvBcoBMXU3icWpwwDU4BiAxhn0AK9Q
         1BA5YEpW/zGjIMCW0K/TgmOu1w5dmBXAHjM+s0Hri5gL06sMUoGWCJrUtNLI1Q3xpMUV
         brsDOTMmYoTBE18btI4tdRomLR3h4MmsK96umIFttrricXBwcg+K70flSHn33tzvzoQI
         TffQ==
X-Gm-Message-State: APjAAAUW1A5qKmc49gJ3NMy3FFGHEXlJIT2Iv1s5TNxJu0mUWLahUAlw
        qtV1VIB4AkUTVi2IU3IEBxfIfskg+5g=
X-Google-Smtp-Source: APXvYqwgz51e6H1D4kW+flZvQoAH7ANTNgvMByOMh0Kfcx/NxljabkOlnh29cQzUFvT9RRUbsF4PIQ==
X-Received: by 2002:a6b:5a09:: with SMTP id o9mr1920005iob.45.1568143327684;
        Tue, 10 Sep 2019 12:22:07 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id k11sm7823153ioa.20.2019.09.10.12.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2019 12:22:07 -0700 (PDT)
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     webmaster@zedlx.com, linux-btrfs@vger.kernel.org
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
Date:   Tue, 10 Sep 2019 15:22:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-09-09 15:26, webmaster@zedlx.com wrote:
> This post is a reply to Remi Gauvin's post, but the email got lost so I 
> can't reply to him directly.
> 
> Remi Gauvin wrote on 2019-09-09 17:24 :
>>
>> On 2019-09-09 11:29 a.m., Graham Cobb wrote:
>>
>>>  and does anyone really care about
>>> defrag any more?).
>>>
>>
>>
>> Err, yes, yes absolutely.
>>
>> I don't have any issues with the current btrfs defrag implementions, but
>> it's *vital* for btrfs. (which works just as the OP requested, as far as
>> I can tell, recursively for a subvolume)
>>
>> Just booting Windows on a BTRFS virtual image, for example, will create
>> almost 20,000 file fragments.  Even on SSD's, you get into problems
>> trying to work with files that are over 200,000 fragments.
>>
>> Another huge problem is rsync --inplace.  which is perfect backup
>> solution to take advantage of BTRFS snapshots, but fragments larges
>> files into tiny pieces (and subsequently creates files that are very
>> slow to read.).. for some reason, autodefrag doesn't catch that one 
>> either.
>>
>> But the wiki could do a beter job of trying to explain that the snapshot
>> duplication of defrag only affects the fragmented portions.  As I
>> understand, it's really only a problem when using defrag to change
>> compression.
> 
> 
> Ok, a few things.
> 
> First, my defrag suggestion doesn't EVER unshare extents. The defrag 
> should never unshare, not even a single extent. Why? Because it violates 
> the expectation that defrag would not decrease free space.
No, it should by default not unshare, but still allow the possibility of 
unsharing extents.  Sometimes completely removing all fragmentation is 
more important than space usage.
> 
> Defrag may break up extents. Defrag may fuse extents. But it shouln't 
> ever unshare extents.
Actually, spitting or merging extents will unshare them in a large 
majority of cases.
> 
> Therefore, I doubt that the current defrag does "just as the OP 
> requested". Nonsense. The current implementation does the unsharing all 
> the time.
> 
> Second, I never used btrfs defrag in my life, despite mananging at least 
> 10 btrfs filesystems. I can't. Because, all my btrfs volumes have lot of 
> subvolumes, so I'm afraid that defrag will unshare much more than I can 
> tolerate. In my subvolumes, over 90% of data is shared. If all 
> subvolumes were to be unshared, the disk usage would likely increase 
> tenfold, and that I cannot afford.
> 
> I agree that btrfs defrag is vital. But currently, it's unusable for 
> many use cases.
> 
> Also, I don't quite understand what the poster means by "the snapshot 
> duplication of defrag only affects the fragmented portions". Possibly it 
> means approximately: if a file wasn't modified in the current (latest) 
> subvolume, it doesn't need to be unshared. But, that would still unshare 
> all the log files, for example, even all files that have been appended, 
> etc... that's quite bad. Even if just one byte was appended to a log 
> file, then defrag will unshare the entire file (I suppose).
> 
What it means is that defrag will only ever touch a file if that file 
has extents that require defragmentation, and will then only touch 
extents that are smaller than the target extent size (32M by default, 
configurable at run-time with the `-t` option for the defrag command) 
and possibly those directly adjacent to such extents (because it might 
merge the small extents into larger neighbors, which will in turn 
rewrite the larger extent too).

This, in turn, leads to a couple of interesting behaviors:

* If you have a subvolume with snapshots , it may or may not break 
reflinks between that subvolume and it's snapshots, but will not break 
any of the reflinks between the snapshots themselves.
* When dealing with append-only files that are significantly larger than 
the target extent size which are defragmented regularly, only extents 
near the end of the file are likely to be unshared by the operation.
* If you fully defragment a subvolume, then snapshot it, then defrag it 
again, the second defrag will not unshare anything unless you were 
writing to the subvolume or snapshot while the second defrag was running.
* There's almost no net benefit to not defragmenting when dealing with 
very large files that mostly see internal rewrites (VM disk images, 
large databases, etc) because every internal rewrite will implicitly 
unshare extents anyway.

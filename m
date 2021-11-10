Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D2A44B9FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 02:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhKJBlI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 20:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhKJBlI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Nov 2021 20:41:08 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBC7C061764
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Nov 2021 17:38:21 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id f20-20020a17090a639400b001a772f524d1so225999pjj.5
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Nov 2021 17:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=1Y9lvAGRXvBy+6rX0yMbVUMUsFaw/EF0/sXCIxyS+fc=;
        b=No0wo8tjfEx6vpjBHTT/NgHemZ2YinLmPxbcsOvjar3KKVVtIfaPov8mGx9w7eVZu7
         XjsqM4DqleyUdnALNVB6/K4HtCcm+3BeU9Q8nw3jCpChzXXSec5zH7u67IDtFXRfTHR5
         sSu7hsIswhW/pgTn5bkZ+ZgxQOmZggcWOTCghyDjVThcPwyJ2h0YRuFTzqNdyeq4OdNk
         iwlAukHG2VCT7gOYacwx9q9VD/5PC+b1ob2wsmtUJDX6U2tZrI/tlX3VXMIFizQwD49B
         u7CwKGFQoKBcyFjpdHhUNwIJYFR3wIMMT6Ryn7ZQdEfNfMKBSAHHbOeSeZq/stk4OKq9
         dd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1Y9lvAGRXvBy+6rX0yMbVUMUsFaw/EF0/sXCIxyS+fc=;
        b=nBIP0pNnWbpqdmSk+0Yi+OhmJ6nh0yXYBkNVA3R0MbfqXYWwu9L3sMpGGca8jO+28K
         X+JjRJ48I/aQItr6emrzUjwmEgk7pge8Mu9GWrQbFxeXGSVwrFqjmKxc8YHR3MUgNP0U
         OJpzh7YwYx0zSZm11hBjE09nDXEeKHFSOLdejNJL8HEdw82uhLZlYA389MmAIjxkifuX
         wCB4NQqDQK1lNm4B+zZaGJiIXWNCWVSGP8Jcg52k3xNlSgH38PBjbSbBydDGNsOM+Vtk
         k5iIdNKVEqvdrlZVqR9TDvSfD0tf/mfWob2UxTD4tg0f6AbJD5RjXBYLFTWiooq3+iUT
         Np9A==
X-Gm-Message-State: AOAM530mlhmvgX7yp7TVCQOculVyqbACQ1K/Jzo4uG1DXvrx6zkUhoy7
        nYtdyoatVvFx1pL3o/Hvha8US75yg0VzQw==
X-Google-Smtp-Source: ABdhPJzOnwXEakWKV5rhkv1ckS0oyMxJyfnXid1yBNRllpdVTf8scXXhmIuQIYcemSVOm13nIyhZIQ==
X-Received: by 2002:a17:90a:4d0c:: with SMTP id c12mr12657067pjg.151.1636508300391;
        Tue, 09 Nov 2021 17:38:20 -0800 (PST)
Received: from [192.168.178.23] (124-148-225-225.tpgi.com.au. [124.148.225.225])
        by smtp.gmail.com with ESMTPSA id w7sm16455041pgo.56.2021.11.09.17.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 17:38:19 -0800 (PST)
Subject: Re: Serious issues with scrub and raid56
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Thiago Ramon <thiagoramon@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAO1Y9wqaEkE1XLjtFj0siLD4JMqTmJZfWJFNcQ26DOu7iir3Bg@mail.gmail.com>
 <4f247bfd-95d6-484b-73a6-3829aa4931c0@gmail.com>
 <6b48c313-0c86-d96e-a575-5f1d87d38b03@gmx.com>
From:   DanglingPointer <danglingpointerexception@gmail.com>
Message-ID: <fe29e99e-3602-3979-3740-84b14d537eef@gmail.com>
Date:   Wed, 10 Nov 2021 12:38:16 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6b48c313-0c86-d96e-a575-5f1d87d38b03@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks Qu!



On 10/11/21 10:59 am, Qu Wenruo wrote:
>
>
> On 2021/11/9 21:25, DanglingPointer wrote:
>> Why has no one offered to help Thiago Ramon with his problem?  Or at the
>> very least give some advice.
>>
>> What's in the road-map for once and for all fixing/sorting out RAID56?
>> Surely there is a significant amount of Small-Medium-Businesses and home
>> users that are interested in the RAID56 use-case!  Why don't those
>> responsible for BTRFS do several sprints to sort it out in a kernel
>> release?
>>
>>
>> On 6/8/21 8:40 am, Thiago Ramon wrote:
>>> I've been discussing this in IRC at #btrfs for a while now, but I've
>>> done enough testing that it's past time I've brought it to the list.
>>>
>>> First the problems, then I'll give some background on my configuration:
>>>
>>> 1 - The current scrub procedure completely ignores p/q stripes unless
>>> the data csum has problems and it's trying to recover them. This means
>>> scrub is completely useless for recovering from bitrot on the p/q
>>> stripes, and given enough time/bad luck, even a single device loss can
>>> bring down raid5/6. This is not really a bug, more of a design
>>> oversight that I'm surprised nobody mentioned/noticed so far.
>
> Nope, just do a very basic tests:
>
> # mkfs.btrfs  -f -d raid5 /dev/test/scratch[12] -R space-cache-tree
> # mount /dev/test/scratch1 /mnt/btrfs
> # xfs_io -f -c "pwrite 0 64k" /mnt/btrfs/file
> # umount /mnt/btrfs/
>
> # btrfs ins dump-tree -t 5 /dev/test/scratch1 | grep EXTENT_DATA -A 3
>
> And grab the bytenr, 298844160 in my case.
>
> # btrfs-map-logical -l 298844160 /dev/test/scratch1
> mirror 1 logical 298844160 physical 298844160 device
> /dev/mapper/test-scratch1
> mirror 2 logical 298844160 physical 277872640 device
> /dev/mapper/test-scratch2
>
> The first mirror is the data stripe, while the send stripe is parity.
>
> Verify the content of both mirror:
>
> $ od -x -j 298844160 -N 65536 /dev/mapper/test-scratch1
> 2164000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
> *
> 2164200000
>
> $ od -x -j 277872640 -N 65536 /dev/mapper/test-scratch2
> 2044000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
> *
> 2044200000
>
> All correct.
>
> Then corrupted the parity manually:
>
> $ xfs_io -f -c "pwrite -S 0x00 277872640 64K" /dev/test/scratch2
>
> Now mount and scrub:
>
> # mount /dev/test/scratch1 /mnt/btrfs/
> # btrfs scrub start -B /mnt/btrfs/
>
> Although it will report no errors found, but that's because all reported
> error are for logical bytenr, but parity has no logical bytenr, as it's
> hidden to logical address space.
>
> But after scrub, you can re-check the parity manually:
>
> $ od -x -j 277872640 -N 65536 /dev/mapper/test-scratch2
> 2044000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
> *
> 2044200000
>
> It's back to correct values.
>
> Thanks,
> Qu
>>>
>>> 2 - Some weird condition is causing scrub to miss csum errors. I
>>> currently have 156 files (out of about 30M) with unrecoverable csum
>>> errors (found by checking every file), after scrubbing every disk in
>>> the array twice, the last pass which didn't detect any corruption.
>>> Those files were damaged from deleting and overwriting other
>>> uncorrectable files that were sharing the stripes with them, and now
>>> have the p/q stripes consistent with the csum errors. I've tried
>>> replicating this situation on a test fs and scrub worked fine, so it's
>>> something else. The scrubs have an unusually high number of
>>> no_csum/csum_discards, so I imagine it's something related to that,
>>> though I can query the csums of the files without any problems through
>>> the python btrfs library. Any ideas on what I could try to diagnose
>>> what's going on are welcome.
>>>
>>> I have a raid1c4 metadata and raid6 data array with 12 8TB disks,
>>> currently running kernel 5.12.12, and in the last few months I had 2
>>> (not simultaneous) disk hardware failures. First disk died while I was
>>> scrubbing it after it started showing errors, the replace had some
>>> rebuild failures and afterwards I've had scrub recovering errors all
>>> over the disks. I have since replaced memory and a SAS controller on
>>> the machine, but I don't know if either had any issues or it was just
>>> accumulated errors on the disks (I wasn't scrubbing the disks). I left
>>> about 1k uncorrectable files linger for too long, and got hit by
>>> another disk failure, which caused another ~1.5k  files to get
>>> uncorrectably damaged, mostly files nearby the previous damaged ones
>>> (which had been deleted/overwritten by then, and possibly helped
>>> corrupt their neighbors).
>>> Scrubbing the disks after deleting that last batch of files still
>>> uncovered a few more uncorrectable files, but after deleting those
>>> (~4) the uncorrectable csum errors stopped showing up. Last round of
>>> scrubs repaired a bit over 100 csum errors, but the 156 files
>>> mentioned above remain, and undetectable by scrub. I haven't seen any
>>> corrected reads in dmesg while scanning the files, so I think I
>>> probably won't damage anything else after cleaning up this last batch
>>> of files, but I might just fix their csums instead, and do a data
>>> rebalance afterwards to rebuild the possibly damaged p/q stripes that
>>> scrub isn't checking. But before that I'd like to try to find out why
>>> scrub is failing to see those.
>>>
>>> Thanks,
>>> Thiago Ramon

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBE31012E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 06:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfKSFSf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 00:18:35 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40119 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfKSFSf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 00:18:35 -0500
Received: by mail-qk1-f193.google.com with SMTP id z16so16737724qkg.7
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 21:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=W94kOPHAim1nobgO54HxcYuZSdixN8A9NQEcOMSUFs0=;
        b=rJUNkJqRRtp2gFyf4EmTVghfWj974S0HBp5exkOyAyODJ6QbNntypucfywjC0X7o68
         6iZezwfekcJX9y0I2+h9vumlYdNnW53+jIC34C++V8nZ8+UQY/ZpIBpH5DE+oMiloJx6
         T0Eat33Q8WPKVHoyW1iTB5IaaytiFIvlExUtuEuRe0tU+ecNl10mL8eWTll7aVq9kqpz
         naUOhxg7wmq7CZypgXVsYKea2VlyauWPxNnYIGYF01m8OHBQbVcAmVzMwXSd+azcoOPy
         14VHC24EJ6T9Ux/Dglh929Jv3wACWFAiRIJ03E5lGlU6/p/7Tv42AzEFK48lwFBjQqV4
         p3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=W94kOPHAim1nobgO54HxcYuZSdixN8A9NQEcOMSUFs0=;
        b=pDZrVqOUxMCOKrlpdkGVZkXpMOwXXS/R18BzF5leizq6FSh6OrCTqwWmu8ReX6n1kJ
         9gaq2L4mEJU/0ULM5f5JhPijIYeDVC3joP1OZzjArSZg5wGsmjCCPXPq4Emu498f8aQT
         Gg0ivZ1KL9nGvxNcQtl8sAUFJhBFPPXJwaTFkfdkARCuTWWPFSJ19s8m9hgWjNHhm40W
         Brtvmv/j1b2k7u9AWg9qgqsEstBo6pXPS129fmQGKyD6XwpA1hU+m3Q12Lb0VeHF3TWt
         VE/P43dcUNpBTjSAuMkuhbytCSPgW5X8TDZ6PYIkQjhs0s3nRFwyv6uU4YpErmhXYvwl
         YStw==
X-Gm-Message-State: APjAAAXcPQhnlsejTtyqLdlxfMgzMV/POenSvWz0ZdMVU7e/KB9HzJGR
        Cc0Wb5I9uVdqBO/p7i3uKCo7vk4/1xo=
X-Google-Smtp-Source: APXvYqyY6/yLKeAV6X1Lkc2r7illVdurFp35Nooo+/Ja3emPhhcrbOI65HJk/djdC/iyuMsPdITmlQ==
X-Received: by 2002:a37:a5d3:: with SMTP id o202mr25486309qke.283.1574140714174;
        Mon, 18 Nov 2019 21:18:34 -0800 (PST)
Received: from [192.168.8.171] ([184.75.223.211])
        by smtp.gmail.com with ESMTPSA id h37sm12142542qth.78.2019.11.18.21.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2019 21:18:33 -0800 (PST)
Subject: Re: [PATCH 0/3] btrfs: More intelligent degraded chunk allocator
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
References: <20191107062710.67964-1-wqu@suse.com>
 <20191118201834.GN3001@twin.jikos.cz>
 <f6dfede7-c65c-2321-ab8f-ba16a6a3c71f@gmx.com>
From:   Alberto Bursi <bobafetthotmail@gmail.com>
Message-ID: <f8602f1e-7401-dfd7-0274-48609e3804b1@gmail.com>
Date:   Tue, 19 Nov 2019 13:18:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <f6dfede7-c65c-2321-ab8f-ba16a6a3c71f@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 19/11/19 07:32, Qu Wenruo wrote:
>
> On 2019/11/19 上午4:18, David Sterba wrote:
>> On Thu, Nov 07, 2019 at 02:27:07PM +0800, Qu Wenruo wrote:
>>> This patchset will make btrfs degraded mount more intelligent and
>>> provide more consistent profile keeping function.
>>>
>>> One of the most problematic aspect of degraded mount is, btrfs may
>>> create unwanted profiles.
>>>
>>>   # mkfs.btrfs -f /dev/test/scratch[12] -m raid1 -d raid1
>>>   # wipefs -fa /dev/test/scratch2
>>>   # mount -o degraded /dev/test/scratch1 /mnt/btrfs
>>>   # fallocate -l 1G /mnt/btrfs/foobar
>>>   # btrfs ins dump-tree -t chunk /dev/test/scratch1
>>>          item 7 key (FIRST_CHUNK_TREE CHUNK_ITEM 1674575872) itemoff 15511 itemsize 80
>>>                  length 536870912 owner 2 stripe_len 65536 type DATA
>>>   New data chunk will fallback to SINGLE or DUP.
>>>
>>>
>>> The cause is pretty simple, when mounted degraded, missing devices can't
>>> be used for chunk allocation.
>>> Thus btrfs has to fall back to SINGLE profile.
>>>
>>> This patchset will make btrfs to consider missing devices as last resort if
>>> current rw devices can't fulfil the profile request.
>>>
>>> This should provide a good balance between considering all missing
>>> device as RW and completely ruling out missing devices (current mainline
>>> behavior).
>> Thanks. This is going to change the behaviour with a missing device, so
>> the question is if we should make this configurable first and then
>> switch the default.
> Configurable then switch makes sense for most cases, but for this
> degraded chunk case, IIRC the new behavior is superior in all cases.
>
> For 2 devices RAID1 with one missing device (the main concern), old
> behavior will create SINGLE/DUP chunk, which has no tolerance for extra
> missing devices.
>
> The new behavior will create degraded RAID1, which still lacks tolerance
> for extra missing devices.
>
> The difference is, for degraded chunk, if we have the device back, and
> do proper scrub, then we're completely back to proper RAID1.
> No need to do extra balance/convert, only scrub is needed.
>
> So the new behavior is kinda of a super set of old behavior, using the
> new behavior by default should not cause extra concern.


I think most users will see this as a bug fix, as the current behavior 
of creating

SINGLE chunks is very annoying and can cause confusion as it is NOT an

expected behavior for a classic (mdadm or hardware) degraded RAID array.


-Alberto


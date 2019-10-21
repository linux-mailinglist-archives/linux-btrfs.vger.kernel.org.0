Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A461EDEB51
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 13:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfJULr0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 07:47:26 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:45833 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbfJULr0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 07:47:26 -0400
Received: by mail-il1-f193.google.com with SMTP id u1so11661751ilq.12
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 04:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FFfaDxccbem2wTYSKk2E/RVZtMjwMU6ch5S7iOSpJKE=;
        b=QVQeTnbG5ZENpPaoKo4VuUyKAFyQPbUMB5jld6iSJOD9cZ2lPpJgwHpRQ2iGosjhZs
         NtjYbwBkEDzvn187unoyoM6UQTOrELgDKwqO3PrFS99aLYm1MuWqvt6gvkhb+FHcloqo
         hdgUQXMnrlfGARj+buR5v7uJSL+riziSZBPNv9C7sxOpnDJpzrQ4jQINoO6GKre6eqwe
         wRnWXuSXqyQlY1EJzWOt0Y3FHrfxfb3K4i9dNKGr6yROOyG2jdS4MFcT3Li4PMldFRc2
         lL5cIxeu6Kl+y02+vzJsqQxrSGnvpLHD8hdiwrtM2T5C6mHJegwQuBkgv3WpfYJ8mOFy
         wHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FFfaDxccbem2wTYSKk2E/RVZtMjwMU6ch5S7iOSpJKE=;
        b=TBD3eUnkaoYgSqAfeKunP18+AbINqTFExI2Ixg+O9P0IDxrhpdgRX3TW5ohBXNonG+
         wKHGbcmYGJGCfvfoUDG9i0YMIVGL2moZ1663QaYrZiyYj086dCi6I6LSsCAEhWn46BXh
         04B6/ZOqQ96I9cmyWPEMqBHvoSQQU2V53OaK77nILsy+WK1GsHZBTgwdR8D1d0xsX0ul
         uT6GQ0LzqFqolzsMEBbO9shV10Mss/QSQ5OqchYQjFk8DVpUFDSqOvM69+DKRgSGkz8y
         nX/b05cM/53LgFvFw0Q8GnKu0ZAMa3T21BH3jf97/BXqfbMNveXS6tYOypObpqvg9sA1
         dssA==
X-Gm-Message-State: APjAAAWayQEqxs5LKV5wa8X1N7ME1jJyIKA4SygE+SQLy8JkamH2YFHq
        cu7G0z8sphGTzDzdVKmxaSYAq8xAaG8=
X-Google-Smtp-Source: APXvYqzySfHW2RJ22bZKH2eIbZ7yHidxnO5XAmDhMs9nMt3UJyEOARUK9/+IhRzBXXTVgdRkmYtnCA==
X-Received: by 2002:a92:458f:: with SMTP id z15mr24178278ilj.34.1571658444688;
        Mon, 21 Oct 2019 04:47:24 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id s19sm4464340iob.81.2019.10.21.04.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 04:47:24 -0700 (PDT)
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Christian Pernegger <pernegger@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com>
 <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com>
 <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
 <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
 <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com>
 <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <e0c57aba-9baf-b375-6ba3-1201131a2844@gmail.com>
Date:   Mon, 21 Oct 2019 07:47:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-10-21 06:47, Christian Pernegger wrote:
> [Please CC me, I'm not on the list.]
> 
> Am So., 20. Okt. 2019 um 12:28 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>> Question: Can I work with the mounted backup image on the machine that
>>> also contains the original disc? I vaguely recall something about
>>> btrfs really not liking clones.
>>
>> If your fs only contains one device (single fs on single device), then
>> you should be mostly fine. [...] mostly OK.
> 
> Should? Mostly? What a nightmare-inducing, yet pleasantly Adams-esqe
> way of putting things ... :-)
> 
> Anyway, I have an image of the whole disk on a server now and am
> feeling all the more adventurous for it. (The first try failed a
> couple of MB from completion due to spurious network issues, which is
> why I've taken so long to reply.)
I've done stuff like this dozens of times on single-device volumes with 
exactly zero issues.  The only time you're likely to see problems is if 
the kernel thinks (either correctly or incorrectly) that the volume 
should consist of multiple devices.

Ultimately, the issue is that the kernel tries to use all devices it 
knows of with the same volume UUID when you mount the volume, without 
validating the number of devices and that there are no duplicate device 
UUID's in the volume, so it can accidentally pull in multiple instances 
of the same 'device' when mounting.
> 
>>> You wouldn't happen to know of a [suitable] bootable rescue image [...]?
>>
>> Archlinux iso at least has the latest btrfs-progs.
> 
> I'm on the Ubuntu 19.10 live CD (btrfs-progs 5.2.1, kernel 5.3.0)
> until further notice. Exploring other options (incl. running your
> rescue kernel on another machine and serving the disk via nbd) in
> parallel.
> 
>> I'd recommend the following safer methods before trying --init-extent-tree:
>>
>> - Dump backup roots first:
>>    # btrfs ins dump-super -f <dev> | grep backup_treee_root
>>    Then grab all big numbers.
> 
> # btrfs inspect-internal dump-super -f /dev/nvme0n1p2 | grep backup_tree_root
> backup_tree_root:    284041969664    gen: 58600    level: 1
> backup_tree_root:    284041953280    gen: 58601    level: 1
> backup_tree_root:    284042706944    gen: 58602    level: 1
> backup_tree_root:    284045410304    gen: 58603    level: 1
> 
>> - Try backup_extent_root numbers in btrfs check first
>>    # btrfs check -r <above big number> <dev>
>>    Use the number with highest generation first.
> 
> Assuming backup_extent_root == backup_tree_root ...
> 
> # btrfs check --tree-root 284045410304 /dev/nvme0n1p2
> Opening filesystem to check...
> checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000
> checksum verify failed on 284041084928 found E4E3BDB6 wanted 00000000
> bad tree block 284041084928, bytenr mismatch, want=284041084928, have=0
> ERROR: cannot open file system
> 
> # btrfs check --tree-root 284042706944 /dev/nvme0n1p2
> Opening filesystem to check...
> checksum verify failed on 284042706944 found E4E3BDB6 wanted 00000000
> checksum verify failed on 284042706944 found E4E3BDB6 wanted 00000000
> bad tree block 284042706944, bytenr mismatch, want=284042706944, have=0
> Couldn't read tree root
> ERROR: cannot open file system
> 
> # btrfs check --tree-root 284041953280 /dev/nvme0n1p2
> Opening filesystem to check...
> checksum verify failed on 284041953280 found E4E3BDB6 wanted 00000000
> checksum verify failed on 284041953280 found E4E3BDB6 wanted 00000000
> bad tree block 284041953280, bytenr mismatch, want=284041953280, have=0
> Couldn't read tree root
> ERROR: cannot open file system
> 
> # btrfs check --tree-root 284041969664 /dev/nvme0n1p2
> Opening filesystem to check...
> checksum verify failed on 284041969664 found E4E3BDB6 wanted 00000000
> checksum verify failed on 284041969664 found E4E3BDB6 wanted 00000000
> bad tree block 284041969664, bytenr mismatch, want=284041969664, have=0
> Couldn't read tree root
> ERROR: cannot open file system
> 
>>    If all backup fails to pass basic btrfs check, and all happen to have
>>    the same "wanted 00000000" then it means a big range of tree blocks
>>    get wiped out, not really related to btrfs but some hardware wipe.
> 
> Doesn't look good, does it? Any further ideas at all or is this the
> end of the line? TBH, at this point, I don't mind having to re-install
> the box so much as the idea that the same thing might happen again --
> either to this one, or to my work machine, which is very similar. If
> nothing else, I'd really appreciate knowing what exactly happened here
> and why -- a bug in the GPU and/or its driver shouldn't cause this --;
> and an avoidance strategy that goes beyond-upgrade-and-pray.
There are actually two possible ways I can think of a buggy GPU driver 
causing this type of issue:

* The GPU driver in some way caused memory corruption, which in turn 
caused other problems.
* The GPU driver confused the GPU enough that it issued a P2P transfer 
on the PCI-e bus to the NVMe device, which in turn caused data 
corruption on the NVMe device.

Both are reasonably unlikely, but definitely possible.  Your best option 
for mitigation (other than just not using that version of that GPU 
driver) is to ensure that your hardware has an IOMMU (as long as it's 
not a super-cheap CPU or MB, and both are relatively recent, you 
_should_ have one) and ensure it's enabled in firmware (on Intel 
platforms, it's usually labeled as 'VT-d' in firmware configuration, AMD 
platforms typically just call it an IOMMU).

However, there's also the possibility that you may have hardware issues. 
  Any of your RAM, PSU, MB, or CPU being bad could easily cause both the 
data corruption you're seeing as well as the GPU issues, so I'd suggest 
double checking your hardware if you haven't already.

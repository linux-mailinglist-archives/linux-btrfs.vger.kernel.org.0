Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDE83D46E9
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 11:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbhGXJEI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 05:04:08 -0400
Received: from a4-1.smtp-out.eu-west-1.amazonses.com ([54.240.4.1]:55117 "EHLO
        a4-1.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234867AbhGXJEC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 05:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=vbsgq4olmwpaxkmtpgfbbmccllr2wq3g; d=urbackup.org; t=1627119873;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=8W59Q6/D+UFPwY1VIEoSmtq4BnEJFGilYLOYpR2tNmI=;
        b=EGWb5OgQoa9EaYD47jLeUCyJnyO4Xn462QInxkyGvvDEGW8h8hcyUYFgufMgi8Lb
        ewWD1rW5Ifxy/mzH+ZU5qikqjAqUXOldknAp1R4PXUjhpxp5jSPk3huvSByzcJo2dSM
        mGiITS0x4o518SBSTgN6DyPvFWl0pz3YOdHbV7o8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1627119873;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=8W59Q6/D+UFPwY1VIEoSmtq4BnEJFGilYLOYpR2tNmI=;
        b=SAKcpl3wgRjISWFxoLABq4OFPqakpB+zPnQbfIkqcda51TIRj7/0xoryBFQbHIQy
        cFeaYJuwJ3rgHtc77iKXM8f0yxuv9Ci5dN80U2B9xE4c6Q16XFkzgRQyXe4XiiiWsuy
        l5ukN1gY7amF2i/HV7J1Nl1bJ3jspgEgQCrcrLsM=
Subject: Re: On the issue of direct I/O and csum warnings
To:     Jonas Aaberg <cja@lithops.se>
Cc:     linux-btrfs@vger.kernel.org
References: <20210723165517.2614d1b4@poirot.localdomain>
 <0102017ad4affb63-e12c8463-8971-4b1c-b271-ee880969fa5b-000000@eu-west-1.amazonses.com>
 <20210724083037.463fb0d5@poirot.localdomain>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102017ad7e6ee78-b824b182-71e2-4f18-ba52-931711706630-000000@eu-west-1.amazonses.com>
Date:   Sat, 24 Jul 2021 09:44:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210724083037.463fb0d5@poirot.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2021.07.24-54.240.4.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24.07.2021 08:30 Jonas Aaberg wrote:
> On Fri, 23 Jul 2021 18:45:40 +0000
> Martin Raiber <martin@urbackup.org> wrote:
>
>> On 23.07.2021 16:55 Jonas Aaberg wrote:
>>> Hi,
>>>
>>> I use btrfs on dm-crypt. About two months ago, I started to get:
>>>
>>> --
>>> BTRFS warning (device dm-0): csum failed root 257 ino 1068852 off
>>> 25690112 csum 0xa27faf9a expected csum 0x4c266278 mirror 1 BTRFS
>>> error (device dm-0): bdev /dev/mapper/disk0 errs: wr 0, rd 0, flush
>>> 0, corrupt 349, gen 0
>>> --
>>>
>>> kind of warning/errors on my laptop. I went a bought a new NVME disk
>>> because I'm rather found of my data, eventhough most is backup-ed
>>> up.
>>>
>>> A week later, I started to get the same kind of warning/error
>>> message on my new NVME. After half a day of memtest86, resulted in
>>> no memory errors found, I gave up on my otherwise stable laptop and
>>> started to use an old laptop that I've been to lazy to sell instead
>>> while looking out for a decent pre-owned newer laptop.
>>>
>>> Now I'm just about to install and move over to a newly bought
>>> laptop, when today my old laptop started to show the same
>>> warning/errors. My old laptop does not share a single part with the
>>> laptop which I previous got the "checksum failure" warnings on.
>>> Therefore I have a hard time to believe that I've gotten the same
>>> hardware failure twice.
>>>
>>> Then I found:
>>> <https://btrfs.wiki.kernel.org/index.php/Gotchas> and "Direct I/O
>>> and CRCs".
>>>
>>> Which I believe is what I've ran into. One of the affect files is
>>> a log file from syncthing on both computers.  
>> I wouldn't be certain about the conclusion that it is the direct I/O
>> csum issue. Are you sure syncthing is writing to logs via direct I/O?
>> That would be bad e.g. because it disables btrfs compression and log
>> files compress really well. So I'd say report additional information
>> like kernel version (and if it is a vanilla kernel), how your btrfs
>> is setup (metadata RAID1), etc.
> No, I've not checked syncthing and its dependencies. But I'll do that.
> Just to be sure we're talking about the same thing, "direct" means
> O_DIRECT on syscall open()?
Yes.
>
> I use archlinux, with their stock "linux-lts" kernel which has been
> on 5.10 since winter/spring. I'm sure that the two last checksum errors
> have occurred on 5.10.x - unsure about exactly which version. Currently
> the computer runs 5.10.52, but it was after a system update and a
> restart that I noticed the checksum error. So the checksum error
> probably occurred on a previous kernel version in the 5.10 range.
>
> regarding mount options:
>
> /dev/mapper/disk0 on / type btrfs
> (rw,relatime,compress=zstd:3,ssd,space_cache,autodefrag,subvolid=256,subvol=/__current/ROOT)
> /dev/mapper/disk0 on /home type btrfs
> (rw,relatime,compress=zstd:3,ssd,space_cache,autodefrag,subvolid=257,subvol=/__current/home)
> /dev/mapper/disk0 on /var/log type btrfs
> (rw,relatime,compress=zstd:3,ssd,space_cache,autodefrag,subvolid=258,subvol=/__current/log)
>
> No raid. Just btrfs upon dmcrypt.
>
> The file with faulty checksum is in the subvolume=/__current/home.
> (/home//jonas/.config/syncthing/index-v0.14.0.db/007197.log)

That looks like a leveldb log file. I looked at rocksdb and that has options to use O_DIRECT, but it uses https://github.com/syndtr/goleveldb and I can see no hint of it using O_DIRECT there...

>
> If I recall right, I did correct the checksum errors on the first nvme
> disk where it occurred. The second NVME is left as it is when it
> occurred, and the error is still present on my SSD. So I can maybe get
> some history if needed.
>
> Any more information that you would like to have?
>
>>> I have just one humble request, please do something about this
>>> checksum error message. Just add printk with a link to:
>>> <https://btrfs.wiki.kernel.org/index.php/Gotchas> and the issue of
>>> "Direct I/O and CRCs".  
>> The problem is nothing can be done without impacting performance and
>> direct I/O is used for performance.
> Understood. I was talking about making the print less alarming.
It can't really distinguish the case where the buffer changed between write-out and checksumming and the case where data changed on disk either (without impacting performance).
>
>> IMO it should be disabled by
>> default (i.e. it just pretends to do direct I/O like ZFSOnLinux) and
>> be able to be enabled via mount option.
> Sounds like a good idea.
>
>>> Maybe update the wiki with:
>>> `find <mountpoint> -inum <ino-number-from-warning-message>`
>>> would be a helpful as well.  
>> btrfs inspect-internal inode-resolve
>> <ino-number-from-warning-message> <fs>
>>
>> is faster.
> Thanks!
>
> BR,
>  Jonas Aaberg
>
>


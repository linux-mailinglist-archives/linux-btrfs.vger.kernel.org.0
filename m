Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2561275FA5
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 20:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgIWSUQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 14:20:16 -0400
Received: from mail.xmyslivec.cz ([83.167.247.77]:45720 "EHLO
        mail.xmyslivec.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgIWSUP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 14:20:15 -0400
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 14:20:13 EDT
Received: from [172.23.0.68] (mh1-fw.logicworks.mh.etn.cz [82.113.58.199])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.xmyslivec.cz (Postfix) with ESMTPSA id D1D2B400AC;
        Wed, 23 Sep 2020 20:14:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xmyslivec.cz;
        s=master; t=1600884862;
        bh=GSdXzZqbXOFTSRQ0gLecV8HKtGw0/5fBbpzLb0FPYWo=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=oB6glo8koQ7zpTmior9MYkJs9/wCePEF2hEiVNU9cPpbnQZq7gZF06bNV9RUikB2O
         kK2iw17rajYNqzzEK71rKr8SjI7zvJQL5nACVUXeZbeK1syCQmJpTuO8bhetlwGoOB
         Cv8gHsohpmzVIO5jOs+YA6DoItZK0Ywdiuv4Vg2mYziMi9CzRAbr1kMgGmtmZdz2aK
         L7oM7fzBnY7aYrlEySpZEfLMsbghqXHOkJ2Q28D7a+HkvOnoRRFCtwSnmBgQv4Nsgi
         40KPqo0PWIzLJhfSJjfh8Qa6bHDiUZ69M0c/E8gltKtdHzi8ou4lhKy/5RM8i+pvbX
         B9tt3b6EYVBzw==
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Michal Moravec <michal.moravec@logicworks.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>
References: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz>
 <CAJCQCtSfz+b38fW3zdcHwMMtO1LfXSq+0xgg_DaKShmAumuCWQ@mail.gmail.com>
 <29509e08-e373-b352-d696-fcb9f507a545@xmyslivec.cz>
 <CAJCQCtRx7NJP=-rX5g_n5ZL7ypX-5z_L6d6sk120+4Avs6rJUw@mail.gmail.com>
 <695936b4-67a2-c862-9cb6-5545b4ab3c42@xmyslivec.cz>
 <CAJCQCtQWNSd123OJ_Rp8NO0=upY2Mn+SE7pdMqmyizJP028Yow@mail.gmail.com>
 <2f2f1c21-c81b-55aa-6f77-e2d3f32d32cb@xmyslivec.cz>
 <CAJCQCtTQN60V=DEkNvDedq+usfmFB+SQP2SBezUaSeUjjY46nA@mail.gmail.com>
 <4b0dd0aa-f77b-16c8-107b-0182378f34e6@xmyslivec.cz>
 <CAJCQCtQWh2JBAL_SDRG-gMd9Z1TXad7aKjZVUGdY1Akj7fn5Qg@mail.gmail.com>
 <5e79d1f8-7632-48ef-de56-9e79cba87434@xmyslivec.cz>
 <CAJCQCtTR1JZTLr+xTEZxrwh8xSfb+zpKjc+_S2tJGFofVMUdSQ@mail.gmail.com>
From:   Vojtech Myslivec <vojtech@xmyslivec.cz>
Autocrypt: addr=vojtech@xmyslivec.cz; prefer-encrypt=mutual; keydata=
 mDMEXDk3FBYJKwYBBAHaRw8BAQdAxYGS4sOZd1kASDXgtvBZa7SMJqicmc0FaSpmSZh9S420
 J1ZvanRlY2ggTXlzbGl2ZWMgPHZvanRlY2hAeG15c2xpdmVjLmN6PoiZBBMWCABBAhsDBQkD
 wmcABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEcy0E0v45eOJcDrwyzG9czj6y/JMFAlw8
 uhkCGQEACgkQzG9czj6y/JMKtQD9Fe633NqvTgifhCogsl3u6nYbOprbqyH9YVPniWhBRioB
 APNejTQYM1gvWAWhtV0rtDjER8i1tIHwq4sJUw594HQDuDgEXDk3FBIKKwYBBAGXVQEFAQEH
 QDR6xHA2ZcMD6DRi7xqX5spgU+7EJJI03zmAE6936SJtAwEIB4h+BBgWCAAmFiEEcy0E0v45
 eOJcDrwyzG9czj6y/JMFAlw5NxQCGwwFCQPCZwAACgkQzG9czj6y/JPF6wEAz8Um0I7iFLGI
 kxHnWDeYKFgnkRyQgShZWm0/xmBToCYA/iT0Ug9beOLu/pbptwA9V5QQ//78SZ7R0PoXwxTf
 MqIIuDMEXDy4fRYJKwYBBAHaRw8BAQdAsd+asyPI2WagjyIEmoDI7mjcy45kZs3LEU0LgXeG
 4IKI9QQYFggAJhYhBHMtBNL+OXjiXA68MsxvXM4+svyTBQJcPLh9AhsCBQkDwmcAAIEJEMxv
 XM4+svyTdiAEGRYIAB0WIQTRAYeGgCc08YdlVnm4uGCQpsyH1wUCXDy4fQAKCRC4uGCQpsyH
 106rAQDZjQVT6qDwg5WNk4DTZmbzg4usw7Q08gs0hDazIz0H9AEAmEj8bg68fvjJUMO3GYY0
 HzfSH0m6wiJpNrPPbQunhQ1vpwEAwkISc77KHnx3pKeZ6Ilx5O6w5S8uJetnQIiNuUZkkcMB
 AIXDxrKP3h8c416yo4gjtRH4bdtsMkgv8jtRXXSty+YA
Subject: Re: Linux RAID with btrfs stuck and consume 100 % CPU
Message-ID: <0c792470-6ee9-8254-dd57-a7a90ac95bcd@xmyslivec.cz>
Date:   Wed, 23 Sep 2020 20:14:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTR1JZTLr+xTEZxrwh8xSfb+zpKjc+_S2tJGFofVMUdSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 17. 09. 20 19:08, Chris Murphy wrote:
>
> On Wed, Sep 16, 2020 at 3:42 AM Vojtech Myslivec wrote:
>>
>> Description of the devices in iostat, just for recap:
>> - sda-sdf: 6 HDD disks
>> - sdg, sdh: 2 SSD disks
>>
>> - md0: raid1 over sdg1 and sdh1 ("SSD RAID", Physical Volume for LVM)
>> - md1: our "problematic" raid6 over sda-sdf ("HDD RAID", btrfs
>>        formatted)
>>
>> - Logical volumes over md0 Physical Volume (on SSD RAID)
>>     - dm-0: 4G  LV for SWAP
>>     - dm-1: 16G LV for root file system (ext4 formatted)
>>     - dm-2: 1G  LV for md1 journal
>
> It's kindof a complicated setup. When this problem happens, can you
> check swap pressure?
>
> /sys/fs/cgroup/memory.stat
>
> pgfault and maybe also pgmajfault - see if they're going up; or also
> you can look at vmstat and see how heavy swap is being used at the
> time. The thing is.
>
> Because any heavy eviction means writes to dm-0->md0 raid1->sdg+sdh
> SSDs, which are the same SSDs that you have the md1 raid6 mdadm
> journal going to. So if you have any kind of swap pressure, it very
> likely will stop the journal or at least substantially slow it down,
> and now you get blocked tasks as the pressure builds more and more
> because now you have a ton of dirty writes in Btrfs that can't make it
> to disk.
>
> If there is minimal swap usage, then this hypothesis is false and
> something else is going on. I also don't have an explanation why your
> work around works.

On 17. 09. 20 19:20, Chris Murphy wrote:
> The iostat isn't particularly revealing, I don't see especially high
> %util for any device. SSD write MB/s gets up to 42 which is
> reasonable.

On 17. 09. 20 19:43, Chris Murphy wrote:
> [Mon Aug 31 15:31:55 2020] sysrq: Show Blocked State
> [Mon Aug 31 15:31:55 2020]   task                        PC stack   pid father
> 
> [Mon Aug 31 15:31:55 2020] md1_reclaim     D    0   806      2 0x80004000
> [Mon Aug 31 15:31:55 2020] Call Trace:
> ...
> 
> *shrug*
> 
> These SSDs should be able to handle > 500MB/s. And > 130K IOPS. Swap
> would have to be pretty heavy to slow down journal writes.
> 
> I'm not sure I have any good advise. My remaining ideas involve
> changing configuration just to see if the problem goes away, rather
> than actually understanding the cause of the problem.

OK, I see.

This is a physical server with 32 GB RAM and dedicated to backup tasks.
Our monitoring shows there is (almost) no swap usage all the time. So I
hope this should not be the problem. However, I would look for the stats
you mentioned and, for start, I would disable the swap for some several
days. It's there only as a "backup" for any case, and it is not used at
all most of the time.

Sadly, I am not able to _disable the journal_ if I do - just by removing
the device from the array - the MD device instantly fails and btrfs
volume remounts read-only. I can not find any other way how to disable
the journal, it seems it is not supported. I can see only
`--add-journal` option and no corresponding `--delete-journal` one.

I welcome any advice how to exchange write-journal with internal bitmap.

Any other possible changes that comes to my mind are:
- Enlarge write-journal
- Move write-journal to physical sdg/sdh SSDs (out from md0 raid1
  device).

I find the later a bit risky, as the write-journal is not redundant
then. That's the reason we choose write journal on RAID device.

Vojtech

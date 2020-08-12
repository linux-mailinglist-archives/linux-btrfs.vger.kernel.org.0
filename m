Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C17242B36
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 16:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgHLOTq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 10:19:46 -0400
Received: from mail.xmyslivec.cz ([83.167.247.77]:36572 "EHLO
        mail.xmyslivec.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgHLOTo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 10:19:44 -0400
Received: from [172.23.0.68] (mh1-fw.logicworks.mh.etn.cz [82.113.58.199])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail.xmyslivec.cz (Postfix) with ESMTPSA id 18076404E4;
        Wed, 12 Aug 2020 16:19:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xmyslivec.cz;
        s=master; t=1597241973;
        bh=8lnx4EO2LvaFHBeCglUQLd1icvILsO25H32w51Gbo4g=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=FhGWa0/lyP9rmFevWWE7AOs9Iu8fRTmm6X0n5rgCIP++b2AAKCaEGJ+jRNYvje83Q
         nX6E7C6RWziN8IbYGvCDAIuG5+X6LJosfR4NLl5Mk4C8YQpymsaJSg7oYVIZ+IweFA
         H7s5MwH44uSwgLbMkdtIhFW95C+VLlwbaOMGRvMNC8un4hRJkigghanUbrNkkgxP+a
         Gzqyp96vETgtTWGst1IPm/FbM4NQ9laVD98LtNJDJjcbmTJ3kDF8iFgQSAukpYaCe/
         SlmAyCLLFTMHAvcAOLAMvhbiGra01Fmclp9vhfVvgYFL9TstXmFO05fkJjJ7yAkTKh
         Pz0bsLCBmBIPg==
To:     Chris Murphy <lists@colorremedies.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        Michal Moravec <michal.moravec@logicworks.cz>,
        Song Liu <songliubraving@fb.com>
References: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz>
 <a070c45a-0509-e900-e3f3-98d20267c8c9@cloud.ionos.com>
 <CAJCQCtQAHr91wEwvFmh_-UB3Cd3UecSjjy6w7nOeqUktrn4UzQ@mail.gmail.com>
From:   Vojtech Myslivec <vojtech@xmyslivec.cz>
Autocrypt: addr=vojtech@xmyslivec.cz; prefer-encrypt=mutual; keydata=
 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
 w3Ijsg1m
Subject: Re: Linux RAID with btrfs stuck and consume 100 % CPU
Message-ID: <442d5127-11f0-80ca-5914-1a561bb2c292@xmyslivec.cz>
Date:   Wed, 12 Aug 2020 16:19:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQAHr91wEwvFmh_-UB3Cd3UecSjjy6w7nOeqUktrn4UzQ@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------57103BF7AD3DB5087083F2D0"
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------57103BF7AD3DB5087083F2D0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit



On 29. 07. 20 23:48, Chris Murphy wrote:
> On Wed, Jul 29, 2020 at 3:06 PM Guoqing Jiang
> <guoqing.jiang@cloud.ionos.com> wrote:
>> On 7/22/20 10:47 PM, Vojtech Myslivec wrote:
>>> 1. What should be the cause of this problem?
>>
>> Just a quick glance based on the stacks which you attached, I guess it
>> could be
>> a deadlock issue of raid5 cache super write.
>>
>> Maybe the commit 8e018c21da3f ("raid5-cache: fix a deadlock in superblock>> write") didn't fix the problem completely.  Cc Song.
> 
> That references discards, and it make me relook at mdadm -D which
> shows a journal device:
> 
>        0     253        2        -      journal   /dev/dm-2
> 
> Vojtech, can you confirm this device is an SSD? There are a couple
> SSDs that show up in the dmesg if I recall correctly.

I tried to explain this in my first post. It's logical volume in a
volume group over RAID 1 over 2 SSDs.

My colleague replied to with more details:

On 05. 08. 2020 Michal Moravec wrote:
>> On 29 Jul 2020, Chris Murphy wrote:
>> Vojtech, can you confirm this device is an SSD? There are a couple
>> SSDs that show up in the dmesg if I recall correctly.
>
> Yes. We have a pair (sdg, sdh) of INTEL D3-S4610 240 GB SSDs
> (SSDSC2KG240G8).
> We use them for OS and the raid6 journal.
> They are configured as raid md0 array with LVM on top of it.
> Logical volume vg0-journal_md1 (of 1G size) is used as journal device
> for md1 array (where are problem with proccess md1_raid6 consuming
> 100%
> CPU and blocking btrfs operation is happening)


>> What is the default discard hinting for this SSD when it's used as
>> a journal device for mdadm?
>
> What do you mean by discard hinting?
> We have a issue_discards = 1 configuration in /etc/lvm/lvm.conf


>> And what is the write behavior of the journal?
>
> That would be journal_mode set to write-through, right?


>> I'm not familiar with this feature at all, whether it's treated as a
>> raw block device for the journal or if the journal resides on a file
>> system.
>
> From lsblk output I see no filesystem on vg0-journal_md1. It looks
> like plain logical volume to me.

[my comment]: yes, it's LV block device, no filesystem here.


>> So I get kinda curious what might happen long term if this is a very
>> busy file system, very busy raid5/6 journal on this SSD, without any
>> discard hints?
>> Is it possible the SSD runs out of ready-to-write erase blocks, and
>> the firmware has become super slow doing erasure/garbage collection
>> on demand?
>> And the journal is now having a hard time flushing?
>
> What kind of information could we gather to verify/reject any of these
> ideas?


[my question]: Is LVM configuration (above) enough? Sadly, there are not
much information about RAID 6 journaling at kernel wiki. There are some
info in mdadm(8), but nothing about discards/trim operation.

--------------57103BF7AD3DB5087083F2D0
Content-Type: text/plain; charset=UTF-8;
 name="lsblk-output.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="lsblk-output.txt"

TkFNRSAgICAgICAgICAgICAgICAgIE1BSjpNSU4gUk0gICBTSVpFIFJPIFRZUEUgIE1PVU5U
UE9JTlQKc2RnICAgICAgICAgICAgICAgICAgICAgODo5NiAgIDEgMjIzLDZHICAwIGRpc2sg
IArilJzilIBzZGcxICAgICAgICAgICAgICAgICAgODo5NyAgIDEgIDM3LDNHICAwIHBhcnQg
IArilIIg4pSU4pSAbWQwICAgICAgICAgICAgICAgICA5OjAgICAgMCAgMzcsMkcgIDAgcmFp
ZDEgCuKUgiAgIOKUnOKUgHZnMC1zd2FwICAgICAgICAyNTM6MCAgICAwICAgMyw3RyAgMCBs
dm0gICBbU1dBUF0K4pSCICAg4pSc4pSAdmcwLXJvb3QgICAgICAgIDI1MzoxICAgIDAgIDE0
LDlHICAwIGx2bSAgIC8K4pSCICAg4pSU4pSAdmcwLWpvdXJuYWxfbWQxIDI1MzoyICAgIDAg
ICAgIDFHICAwIGx2bSAgIArilIIgICAgIOKUlOKUgG1kMSAgICAgICAgICAgICA5OjEgICAg
MCAgMjksMVQgIDAgcmFpZDYgL21udC9kYXRhCuKUnOKUgHNkZzIgICAgICAgICAgICAgICAg
ICA4Ojk4ICAgMSAgICAgMUsgIDAgcGFydCAgCuKUlOKUgHNkZzUgICAgICAgICAgICAgICAg
ICA4OjEwMSAgMSAxODYsM0cgIDAgcGFydCAgCnNkaCAgICAgICAgICAgICAgICAgICAgIDg6
MTEyICAxIDIyMyw2RyAgMCBkaXNrICAK4pSc4pSAc2RoMSAgICAgICAgICAgICAgICAgIDg6
MTEzICAxICAzNywzRyAgMCBwYXJ0ICAK4pSCIOKUlOKUgG1kMCAgICAgICAgICAgICAgICAg
OTowICAgIDAgIDM3LDJHICAwIHJhaWQxIArilIIgICDilJzilIB2ZzAtc3dhcCAgICAgICAg
MjUzOjAgICAgMCAgIDMsN0cgIDAgbHZtICAgW1NXQVBdCuKUgiAgIOKUnOKUgHZnMC1yb290
ICAgICAgICAyNTM6MSAgICAwICAxNCw5RyAgMCBsdm0gICAvCuKUgiAgIOKUlOKUgHZnMC1q
b3VybmFsX21kMSAyNTM6MiAgICAwICAgICAxRyAgMCBsdm0gICAK4pSCICAgICDilJTilIBt
ZDEgICAgICAgICAgICAgOToxICAgIDAgIDI5LDFUICAwIHJhaWQ2IC9tbnQvZGF0YQrilJzi
lIBzZGgyICAgICAgICAgICAgICAgICAgODoxMTQgIDEgICAgIDFLICAwIHBhcnQgIArilJTi
lIBzZGg1ICAgICAgICAgICAgICAgICAgODoxMTcgIDEgMTg2LDNHICAwIHBhcnQgIAo=
--------------57103BF7AD3DB5087083F2D0--

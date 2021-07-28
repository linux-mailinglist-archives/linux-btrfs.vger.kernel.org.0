Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B17C3D951C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 20:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhG1SRQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 14:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhG1SRL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 14:17:11 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619CFC061757
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 11:17:08 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b21so4121021ljo.13
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kiB9JvEBUH/hBkdkOhLQgD2lAzxo1e3IW3TqBHw9h5Q=;
        b=kfMorhrpRen/1mBKlY7cL+PDmMzPZ3SacnKpVcz1arZ5jfeZD78uUjrZBwq9AFdxQT
         iJQIOS7Es5Y9ge7+GIaDehzv/1IsTQHCrzfnJF4eVtGDdCakIH9ZKcQSHxJm5OP39ptx
         9jgM9l+Li4nB+RrRYz6wwwuRXK8ET5CB4c8WueY7DFtlu1GRvoeKnaNDpPy6Kyo6miA7
         X5oBaT1KpO3L8YsO2uR3T7dY9xd2dV89RAKGpuF9Gjx3cFqNUEv1j4HQ9xypYNS5tu+p
         EPXa84MI+b97wU0JJBdtszmPpz6kqvJbjaIqBwq4fWaRzArRBDJ1jLSHtQnwZeVn/llX
         y/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kiB9JvEBUH/hBkdkOhLQgD2lAzxo1e3IW3TqBHw9h5Q=;
        b=NX3xXCpCF8LYc14TN7kQVBdNBwnlxt/53CdNdi3ECEcSHUHcB4AaThZ+Qpippb87pq
         PANXqz2i+S7KFT0mfx5QmxmlJfvNpLX2W1QRtFMYPtAEqmTg/KTl/DV+MyJlUzr8HJxw
         Al3ApVsR9RXYaUSN/tURMdiatY4W7bzfgpFMrw7HXPBN0Ate8YxoyG8L5xzi+HyfxVmU
         HCRQ9V0QcOaKBL58TmtXstB2m7CnSNhP25PLnNQpHnJhez5/YVNVdugqVkJ91ZB5qGLi
         ML6AI/k0y7nyYrX391mMZ/afbftA4aloST4ouhQ6QqcEJ9kbPCRYsJwjddfweMMDU/kD
         ipeQ==
X-Gm-Message-State: AOAM530B/xLhVHbPJyZAT0uQL8i1F3eZndbN+EMFSFTFyH82VUtT7eXh
        06WVeNwjUQaXgWXNFWW67jjl7/vLS/pimob5
X-Google-Smtp-Source: ABdhPJz4TSLmq2zKIgyJCjHS/O70Spoy4ZjUPnMzt+qDXNhs1TATAzucBywQSW2d2kjqZjmYcju/Hg==
X-Received: by 2002:a2e:a54b:: with SMTP id e11mr580789ljn.503.1627496226398;
        Wed, 28 Jul 2021 11:17:06 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:2c6:9453:c31a:df0e:37f0? ([2a00:1370:812d:2c6:9453:c31a:df0e:37f0])
        by smtp.gmail.com with ESMTPSA id u2sm66505lfd.43.2021.07.28.11.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 11:17:05 -0700 (PDT)
Subject: Re: BTRFS scrub reports an error but check doesn't find any errors.
To:     Dave T <davestechshop@gmail.com>
Cc:     ce3g8jdj@umail.furryterror.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB5YL40HiF9E0RxCdO96MS7tKg1=CRPT2YSe+vR3eGZUgQ@mail.gmail.com>
 <20210727214049.GH10170@hungrycats.org>
 <CAGdWbB61NtG5roK3RUSWRN8i8Zo6qMno0LXhE6zaDLHSWhH3RA@mail.gmail.com>
 <9b64bb41-dcae-8571-0b92-1f0cffc97792@gmail.com>
 <CAGdWbB7vQOA-DvfFzGmPxca23uPd=hzssKO-zvMc4Uy2PpH+UA@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <caf3c3d6-71cf-9f2c-4925-b8ea82f9d981@gmail.com>
Date:   Wed, 28 Jul 2021 21:17:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAGdWbB7vQOA-DvfFzGmPxca23uPd=hzssKO-zvMc4Uy2PpH+UA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28.07.2021 19:21, Dave T wrote:
> On Wed, Jul 28, 2021 at 12:11 PM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>>
>> On 28.07.2021 18:15, Dave T wrote:
>> ...
>>>
>>> Jul 27 21:54:39 server kernel: ata10.00: exception Emask 0x0 SAct
>>> 0xffffffff SErr 0x0 action 0x0
>>> Jul 27 21:54:39 server kernel: ata10.00: irq_stat 0x40000008
>>> Jul 27 21:54:39 server kernel: ata10.00: failed command: READ FPDMA QUEUED
>>> Jul 27 21:54:39 server kernel: ata10.00: cmd
>>> 60/00:90:98:2f:9f/03:00:a4:00:00/40 tag 18 ncq dma 393216 in
>>>                                          res
>>> 41/40:00:20:32:9f/00:03:a4:00:00/00 Emask 0x409 (media error) <F>
>>> Jul 27 21:54:39 server kernel: ata10.00: status: { DRDY ERR }
>>> Jul 27 21:54:39 server kernel: ata10.00: error: { UNC }
>>> Jul 27 21:54:39 server kernel: ata10.00: configured for UDMA/133
>>> Jul 27 21:54:39 server kernel: sd 9:0:0:0: [sde] tag#18 FAILED Result:
>>> hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=3s
>>> Jul 27 21:54:39 server kernel: sd 9:0:0:0: [sde] tag#18 Sense Key :
>>> Medium Error [current]
>>> Jul 27 21:54:39 server kernel: sd 9:0:0:0: [sde] tag#18 Add. Sense:
>>> Unrecovered read error - auto reallocate failed
>>> Jul 27 21:54:39 server kernel: sd 9:0:0:0: [sde] tag#18 CDB: Read(16)
>>> 88 00 00 00 00 00 a4 9f 2f 98 00 00 03 00 00 00
>>> Jul 27 21:54:39 server kernel: blk_update_request: I/O error, dev sde,
>>> sector 2761896480 op 0x0:(READ) flags 0x0 phys_seg 15 prio class 0
>>> Jul 27 21:54:39 server kernel: ata10: EH complete
>>> Jul 27 21:54:45 server kernel: ata10.00: exception Emask 0x0 SAct
>>> 0x4000000 SErr 0x0 action 0x0
>>> Jul 27 21:54:45 server kernel: ata10.00: irq_stat 0x40000008
>>> Jul 27 21:54:45 server kernel: ata10.00: failed command: READ FPDMA QUEUED
>>> Jul 27 21:54:45 server kernel: ata10.00: cmd
>>> 60/08:d0:20:32:9f/00:00:a4:00:00/40 tag 26 ncq dma 4096 in
>>>                                          res
>>> 41/40:08:20:32:9f/00:00:a4:00:00/00 Emask 0x409 (media error) <F>
>>> Jul 27 21:54:45 server kernel: ata10.00: status: { DRDY ERR }
>>> Jul 27 21:54:45 server kernel: ata10.00: error: { UNC }
>>> Jul 27 21:54:45 server kernel: ata10.00: configured for UDMA/133
>>> Jul 27 21:54:45 server kernel: sd 9:0:0:0: [sde] tag#26 FAILED Result:
>>> hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=4s
>>> Jul 27 21:54:45 server kernel: sd 9:0:0:0: [sde] tag#26 Sense Key :
>>> Medium Error [current]
>>> Jul 27 21:54:45 server kernel: sd 9:0:0:0: [sde] tag#26 Add. Sense:
>>> Unrecovered read error - auto reallocate failed
>>> Jul 27 21:54:45 server kernel: sd 9:0:0:0: [sde] tag#26 CDB: Read(16)
>>> 88 00 00 00 00 00 a4 9f 32 20 00 00 00 08 00 00
>>> Jul 27 21:54:45 server kernel: blk_update_request: I/O error, dev sde,
>>> sector 2761896480 op 0x0:(READ) flags 0x800 phys_seg 1 prio class 0
>>> Jul 27 21:54:45 server kernel: ata10: EH complete
>>> Jul 27 21:54:45 server kernel: BTRFS warning (device dm-2): i/o error
>>> at logical 1567691653120 on dev /dev/mapper/userluks, physical
>>> 1414087852032, root 19911, inode 624993, offset 5717954560, length
>>> 4096, links 1 (path: path/to/file/filename.ext)
>>> Jul 27 21:54:45 server kernel: BTRFS warning (device dm-2): i/o error
>>> at logical 1567691653120 on dev /dev/mapper/userluks, physical
>>> 1414087852032, root 19989, inode 624993, offset 5717954560, length
>>> 4096, links 1 (path: path/to/file/filename.ext)
>>> Jul 27 21:54:45 server kernel: BTRFS warning (device dm-2): i/o error
>>> at logical 1567691653120 on dev /dev/mapper/userluks, physical
>>> 1414087852032, root 20199, inode 624993, offset 5717954560, length
>>> 4096, links 1 (path: path/to/file/filename.ext)
>>> Jul 27 21:54:45 server kernel: BTRFS error (device dm-2): bdev
>>> /dev/mapper/userluks errs: wr 0, rd 2, flush 0, corrupt 0, gen 0
>>> Jul 27 21:54:45 server kernel: BTRFS error (device dm-2): unable to
>>> fixup (regular) error at logical 1567691653120 on dev
>>> /dev/mapper/userluks
>>> Jul 27 21:55:42 server kernel: BTRFS info (device dm-2): scrub:
>>> finished on devid 1 with status: 0
>>>
>> ...>
>>> The volume is a 3TB disk, model ST3000DM001-1CH166 (Seagate Barracuda
>>> SATA HDD).
>>>
>>> Is there a way to mark sectors on the disk as bad? If so, is it
>>
>> Directly overwriting sector may "fix" it (of course, data is still lost)
>> or trigger sector replacement. hdparm has --write-sector command
>> although I do not have any experience with it. Or simple dd may suffice.
>> Difference is that hdparm will bypass any kernel block layer recovery.
>> If you had redundant data profile, btrfs scrub would likely have fixed
>> it for you.
> 
> I never knew BTRFS could duplicate data without RAID. This looks like
> a great feature for my situation. I think I may upgrade this disk to a
> larger one and enable DUP for data.
> 
> Is this a good tutorial to follow?
> https://zejn.net/b/2017/04/30/single-device-data-redundancy-with-btrfs/
> 
> Should I expect my data to take twice as much space after enabling DUP?
> 

Yes, of course. Your data will be stored twice.

>>
>>> advisable to keep using this physical disk?
>>>
>>
>> Well, this happens, if this is just one sector so far I would say yes.
>> You probably need to keep an eye on it though.
> 
> Thanks. My guess is that this is an isolated issue. It doesn't seem to
> be growing, but I will watch it.
> 


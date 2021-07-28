Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293DE3D92EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 18:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbhG1QLn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 12:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbhG1QLi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 12:11:38 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F267DC061757
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 09:11:35 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id x7so3687872ljn.10
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G6RrrEA02RMvq9tOx/3DLIhZ5AAID5g6UsRidsLjlrs=;
        b=gZhgIVP+RL3ppdGtvzTjX28qd1A9BJScjuN5Pr+DY5dSbBrrO3tKJZYQCQcE0o8g5v
         raBIaanSgm9I5MhDL5T6ILGsLeWENhT3wUPPkCMulyjMA+JKT3Ei31zSCJUH+aAPUHVZ
         eZARHGzkUAHVBlxxJf71asBB53WHZy4Fq7n8+XCQvnb71FXiyITGBGIOUDFZE0MfuKuL
         k3Q0atNOlp3Y24fM0TvB99h1TikdCTPl4y2yY9JzKBDkxew/kyS0QmlE3/IO2itlaxW7
         GerGcfSIUaFxZk2cIIKpxad02iHvzrOk8r964NQXxGG5Lkdv1NOg9nBS9Wuikz5TRRfj
         /yxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G6RrrEA02RMvq9tOx/3DLIhZ5AAID5g6UsRidsLjlrs=;
        b=IiqcF9D3ebVW4bakMUJitZNFUcxYkYCZAVSDj4tWixBPLHaembLDn+VkzLNCOX3CLs
         5D6N1QH1lcWNPlkgavotJl6u/AE7ssZG1w3r26nw1nSJIOaFyL9j1bjr2r2kdOSPKXTM
         iUbG1vJJVP/UXKk3tZid8lN659GrH5U/eGs9zoWMz+UHLSex6m0ajk54r3k+mQ23eZOO
         Ne3/ISdUxJkh2J5iS2dv6XxL+QEKnDv6HgwR75tl0YuOX6xAFenYdJMt3U4u1/9F3M11
         Blh4VLgo/WVvpw4hjL69WjVTCtFo7dVewCzbTiqQ9HJbUHw3Ehmv2XOtMXcbwKXPelwv
         967A==
X-Gm-Message-State: AOAM530mqYAgCnbQ1FSUSMgIV03PqSxzbrD5RfIP1tGhVjj5z9kwmazi
        Xkm0cuUg10oUxcCiRU5dYg8DR8x1ItXokTfs
X-Google-Smtp-Source: ABdhPJwcbok0loCgOhIf9NM/br1znsbZfJz8WCS0tndisf05vTsIhP/BEZj3H1uIEWhQRfP8Efi2DQ==
X-Received: by 2002:a2e:2f05:: with SMTP id v5mr373408ljv.66.1627488694050;
        Wed, 28 Jul 2021 09:11:34 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:2c6:9453:c31a:df0e:37f0? ([2a00:1370:812d:2c6:9453:c31a:df0e:37f0])
        by smtp.gmail.com with ESMTPSA id v10sm39677lfo.175.2021.07.28.09.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 09:11:33 -0700 (PDT)
Subject: Re: BTRFS scrub reports an error but check doesn't find any errors.
To:     Dave T <davestechshop@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB5YL40HiF9E0RxCdO96MS7tKg1=CRPT2YSe+vR3eGZUgQ@mail.gmail.com>
 <20210727214049.GH10170@hungrycats.org>
 <CAGdWbB61NtG5roK3RUSWRN8i8Zo6qMno0LXhE6zaDLHSWhH3RA@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <9b64bb41-dcae-8571-0b92-1f0cffc97792@gmail.com>
Date:   Wed, 28 Jul 2021 19:11:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAGdWbB61NtG5roK3RUSWRN8i8Zo6qMno0LXhE6zaDLHSWhH3RA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28.07.2021 18:15, Dave T wrote:
...
> 
> Jul 27 21:54:39 server kernel: ata10.00: exception Emask 0x0 SAct
> 0xffffffff SErr 0x0 action 0x0
> Jul 27 21:54:39 server kernel: ata10.00: irq_stat 0x40000008
> Jul 27 21:54:39 server kernel: ata10.00: failed command: READ FPDMA QUEUED
> Jul 27 21:54:39 server kernel: ata10.00: cmd
> 60/00:90:98:2f:9f/03:00:a4:00:00/40 tag 18 ncq dma 393216 in
>                                          res
> 41/40:00:20:32:9f/00:03:a4:00:00/00 Emask 0x409 (media error) <F>
> Jul 27 21:54:39 server kernel: ata10.00: status: { DRDY ERR }
> Jul 27 21:54:39 server kernel: ata10.00: error: { UNC }
> Jul 27 21:54:39 server kernel: ata10.00: configured for UDMA/133
> Jul 27 21:54:39 server kernel: sd 9:0:0:0: [sde] tag#18 FAILED Result:
> hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=3s
> Jul 27 21:54:39 server kernel: sd 9:0:0:0: [sde] tag#18 Sense Key :
> Medium Error [current]
> Jul 27 21:54:39 server kernel: sd 9:0:0:0: [sde] tag#18 Add. Sense:
> Unrecovered read error - auto reallocate failed
> Jul 27 21:54:39 server kernel: sd 9:0:0:0: [sde] tag#18 CDB: Read(16)
> 88 00 00 00 00 00 a4 9f 2f 98 00 00 03 00 00 00
> Jul 27 21:54:39 server kernel: blk_update_request: I/O error, dev sde,
> sector 2761896480 op 0x0:(READ) flags 0x0 phys_seg 15 prio class 0
> Jul 27 21:54:39 server kernel: ata10: EH complete
> Jul 27 21:54:45 server kernel: ata10.00: exception Emask 0x0 SAct
> 0x4000000 SErr 0x0 action 0x0
> Jul 27 21:54:45 server kernel: ata10.00: irq_stat 0x40000008
> Jul 27 21:54:45 server kernel: ata10.00: failed command: READ FPDMA QUEUED
> Jul 27 21:54:45 server kernel: ata10.00: cmd
> 60/08:d0:20:32:9f/00:00:a4:00:00/40 tag 26 ncq dma 4096 in
>                                          res
> 41/40:08:20:32:9f/00:00:a4:00:00/00 Emask 0x409 (media error) <F>
> Jul 27 21:54:45 server kernel: ata10.00: status: { DRDY ERR }
> Jul 27 21:54:45 server kernel: ata10.00: error: { UNC }
> Jul 27 21:54:45 server kernel: ata10.00: configured for UDMA/133
> Jul 27 21:54:45 server kernel: sd 9:0:0:0: [sde] tag#26 FAILED Result:
> hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=4s
> Jul 27 21:54:45 server kernel: sd 9:0:0:0: [sde] tag#26 Sense Key :
> Medium Error [current]
> Jul 27 21:54:45 server kernel: sd 9:0:0:0: [sde] tag#26 Add. Sense:
> Unrecovered read error - auto reallocate failed
> Jul 27 21:54:45 server kernel: sd 9:0:0:0: [sde] tag#26 CDB: Read(16)
> 88 00 00 00 00 00 a4 9f 32 20 00 00 00 08 00 00
> Jul 27 21:54:45 server kernel: blk_update_request: I/O error, dev sde,
> sector 2761896480 op 0x0:(READ) flags 0x800 phys_seg 1 prio class 0
> Jul 27 21:54:45 server kernel: ata10: EH complete
> Jul 27 21:54:45 server kernel: BTRFS warning (device dm-2): i/o error
> at logical 1567691653120 on dev /dev/mapper/userluks, physical
> 1414087852032, root 19911, inode 624993, offset 5717954560, length
> 4096, links 1 (path: path/to/file/filename.ext)
> Jul 27 21:54:45 server kernel: BTRFS warning (device dm-2): i/o error
> at logical 1567691653120 on dev /dev/mapper/userluks, physical
> 1414087852032, root 19989, inode 624993, offset 5717954560, length
> 4096, links 1 (path: path/to/file/filename.ext)
> Jul 27 21:54:45 server kernel: BTRFS warning (device dm-2): i/o error
> at logical 1567691653120 on dev /dev/mapper/userluks, physical
> 1414087852032, root 20199, inode 624993, offset 5717954560, length
> 4096, links 1 (path: path/to/file/filename.ext)
> Jul 27 21:54:45 server kernel: BTRFS error (device dm-2): bdev
> /dev/mapper/userluks errs: wr 0, rd 2, flush 0, corrupt 0, gen 0
> Jul 27 21:54:45 server kernel: BTRFS error (device dm-2): unable to
> fixup (regular) error at logical 1567691653120 on dev
> /dev/mapper/userluks
> Jul 27 21:55:42 server kernel: BTRFS info (device dm-2): scrub:
> finished on devid 1 with status: 0
> 
...>
> The volume is a 3TB disk, model ST3000DM001-1CH166 (Seagate Barracuda
> SATA HDD).
> 
> Is there a way to mark sectors on the disk as bad? If so, is it

Directly overwriting sector may "fix" it (of course, data is still lost)
or trigger sector replacement. hdparm has --write-sector command
although I do not have any experience with it. Or simple dd may suffice.
Difference is that hdparm will bypass any kernel block layer recovery.
If you had redundant data profile, btrfs scrub would likely have fixed
it for you.

> advisable to keep using this physical disk?
> 

Well, this happens, if this is just one sector so far I would say yes.
You probably need to keep an eye on it though.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842CB229FD3
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 21:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgGVTHF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 15:07:05 -0400
Received: from mailrelay4-3.pub.mailoutpod1-cph3.one.com ([46.30.212.13]:58767
        "EHLO mailrelay4-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbgGVTHF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 15:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:to:subject:from;
        bh=c+88PcL6pQ2r7Jv38nfoSeqx8K4m2gA2kxO9zWsTc9Y=;
        b=LyQK9FRpeMaB1Vm43hd104QI9R9mee1dwUuOBYe2NGuykT++MtHQALv2clKfKZ3K+9LmH0O5UGQCJ
         Uo2uDKnimUfpgCnS+GXRFuQRTLnSxjNqwGXb8SCrclVTz8ooXPnaK3f4aUEvC4PV01Bd2Dw0E86U6b
         u8mK8oc6iYegqQ56WRFXmnqwhXnditaUT5mBs0XReKHNlcPhoFYNPVO4HAXbSzu18N0p08EBPk14lv
         Q3zG2D+KFKkzoWQi8Llx7+lj4n6FF/d6EE61pxYCyXUsTJKO1PtkufuTiPmcEWUbeonm64hNwBmgZO
         Qd6Lcj06pm/qee0l9e7WQS4lMCbUsaw==
X-HalOne-Cookie: 2dfdcfdb2b668f0b0a7fe70975429c4290f40682
X-HalOne-ID: 85eb8d90-cc4e-11ea-9b1d-d0431ea8bb10
Received: from [10.0.88.22] (unknown [98.128.186.72])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 85eb8d90-cc4e-11ea-9b1d-d0431ea8bb10;
        Wed, 22 Jul 2020 19:07:01 +0000 (UTC)
Subject: Re: Understanding "Used" in df
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org
References: <3225288.0drLW0cIUP@merkaba>
From:   A L <mail@lechevalier.se>
Message-ID: <f60f14e1-1650-66f3-8e65-4c5166f16193@lechevalier.se>
Date:   Wed, 22 Jul 2020 21:07:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3225288.0drLW0cIUP@merkaba>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 2020-07-22 17:10, Martin Steigerwald wrote:
> I have:
>
> % LANG=en df -hT /home
> Filesystem            Type   Size  Used Avail Use% Mounted on
> /dev/mapper/sata-home btrfs  300G  175G  123G  59% /home
>
> And:
>
> merkaba:~> btrfs fi sh /home
> Label: 'home'  uuid: […]
>          Total devices 2 FS bytes used 173.91GiB
>          devid    1 size 300.00GiB used 223.03GiB path /dev/mapper/sata-home
>          devid    2 size 300.00GiB used 223.03GiB path /dev/mapper/msata-home
>
> merkaba:~> btrfs fi df /home
> Data, RAID1: total=218.00GiB, used=171.98GiB
> System, RAID1: total=32.00MiB, used=64.00KiB
> Metadata, RAID1: total=5.00GiB, used=1.94GiB
> GlobalReserve, single: total=490.48MiB, used=0.00B
>
> As well as:
>
> merkaba:~> btrfs fi usage -T /home
> Overall:
>      Device size:                 600.00GiB
>      Device allocated:            446.06GiB
>      Device unallocated:          153.94GiB
>      Device missing:                  0.00B
>      Used:                        347.82GiB
>      Free (estimated):            123.00GiB      (min: 123.00GiB)
>      Data ratio:                       2.00
>      Metadata ratio:                   2.00
>      Global reserve:              490.45MiB      (used: 0.00B)
>      Multiple profiles:                  no
>
>                            Data      Metadata System
> Id Path                   RAID1     RAID1    RAID1    Unallocated
> -- ---------------------- --------- -------- -------- -----------
>   1 /dev/mapper/sata-home  218.00GiB  5.00GiB 32.00MiB    76.97GiB
>   2 /dev/mapper/msata-home 218.00GiB  5.00GiB 32.00MiB    76.97GiB
> -- ---------------------- --------- -------- -------- -----------
>     Total                  218.00GiB  5.00GiB 32.00MiB   153.94GiB
>     Used                   171.97GiB  1.94GiB 64.00KiB
>
>
> I think I understand all of it, including just 123G instead of
> 300 - 175 = 125 GiB "Avail" in df -hT.
>
> But why 175 GiB "Used" in 'df -hT' when just 173.91GiB (see 'btrfs fi sh')
> is allocated *within* the block group / chunks?
>
> Does this have something to do with that global reserve thing?
>
> Thank you,
Hi,

I do not think global reserve should be counted in 'df' output, but it 
does count all unallocated space, even if some of that space will be 
used up by metadata chunks. Isn't the discrepancy the metadata allocated 
vs used?

I made a post a little while ago on this subject, on how to improve the 
space calculations if any one if interested in picking this up? I 
believe the space calculation is wrong in all of the df/btrfs df/btrfs 
us tools.

https://lore.kernel.org/linux-btrfs/ddb33661-2d71-5046-7b6a-4a601dc2df44@lechevalier.se/ 


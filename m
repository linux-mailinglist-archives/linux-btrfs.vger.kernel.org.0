Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C97D247253
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jun 2019 00:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfFOWFQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jun 2019 18:05:16 -0400
Received: from atlantic.aurorasky.eu ([80.241.214.27]:33528 "EHLO
        atlantic.aurorasky.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfFOWFQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jun 2019 18:05:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by atlantic.aurorasky.eu (Postfix) with ESMTP id 520368C08A4;
        Sun, 16 Jun 2019 00:05:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=winca.de; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject; s=default; t=1560636311; x=
        1562450712; bh=VBpvwCPUvkOMCTW9OY8JKu9fxPd9tQNiSoB7DIex1+M=; b=o
        Rlrn4yk5TocyaqPnUkwa5szk+bq5LTSGvIoHpktaFBfb2P25l0w6MQGKmkdcgATB
        xZC8knFwRuwrI8xfXBAEpHB2V9ga6zA0ewcgJNozqP2DSH+An5m2N+XHm3G+xP+L
        C+xa3fqHwh3dZvXMhAUJxbcOaqIYISQlz5HfvsXbQQ=
X-Virus-Scanned: Debian amavisd-new at aurorasky.eu
Received: from atlantic.aurorasky.eu ([127.0.0.1])
        by localhost (vmd14184.contabo.host [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ia4W9mjxVpVm; Sun, 16 Jun 2019 00:05:11 +0200 (CEST)
Received: from [192.168.4.12] (p5B0D86D4.dip0.t-ipconnect.de [91.13.134.212])
        (Authenticated sender: claudius@winca.de)
        by atlantic.aurorasky.eu (Postfix) with ESMTPSA id BFF638C02FD;
        Sun, 16 Jun 2019 00:05:11 +0200 (CEST)
Subject: Re: BTRFS recovery not possible
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <75a6f0280fb5829b0701f42c24a2356e@winca.de>
 <6a72487a-4f21-2c58-df50-b0f5c3aef856@gmx.com>
From:   Claudius Winkel <claudius@winca.de>
Message-ID: <0c136862-4b3c-2459-62c6-44b8e92b2815@winca.de>
Date:   Sun, 16 Jun 2019 00:05:21 +0200
MIME-Version: 1.0
In-Reply-To: <6a72487a-4f21-2c58-df50-b0f5c3aef856@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
X-BitDefender-Spam: No (0)
X-Junk-Score: 0 []
X-BitDefender-SpamStamp: Build: [Engines: 2.15.8.1169, Dats: 591306, Stamp: 3], Multi: [Enabled, t: (0.000033,0.009226)], BW: [Enabled, t: (0.000021), whitelisted: *@winca.de], total: 0(675)
X-BitDefender-CF-Stamp: none
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for the Help

I get my data back.

But now I`m thinking... how did it come so far?

Was it luks the dm-crypt?

What did i do wrong? Old Ubuntu Kernel? ubuntu 18.04

What should I do now ... to use btrfs safely? Should i not use it with=20
DM-crypt

Or even use ZFS instead...

Am 11/06/2019 um 15:02 schrieb Qu Wenruo:
>
> On 2019/6/11 =E4=B8=8B=E5=8D=886:53, claudius@winca.de wrote:
>> HI Guys,
>>
>> you are my last try. I was so happy to use BTRFS but now i really hate
>> it....
>>
>>
>> Linux CIA 4.15.0-51-generic #55-Ubuntu SMP Wed May 15 14:27:21 UTC 201=
9
>> x86_64 x86_64 x86_64 GNU/Linux
>> btrfs-progs v4.15.1
> So old kernel and old progs.
>
>> btrfs fi show
>> Label: none=C2=A0 uuid: 9622fd5c-5f7a-4e72-8efa-3d56a462ba85
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes u=
sed 4.58TiB
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 =
size 7.28TiB used 4.59TiB path /dev/mapper/volume1
>>
>>
>> dmesg
>>
>> [57501.267526] BTRFS info (device dm-5): trying to use backup root at
>> mount time
>> [57501.267528] BTRFS info (device dm-5): disk space caching is enabled
>> [57501.267529] BTRFS info (device dm-5): has skinny extents
>> [57507.511830] BTRFS error (device dm-5): parent transid verify failed
>> on 2069131051008 wanted 4240 found 5115
> Some metadata CoW is not recorded correctly.
>
> Hopes you didn't every try any btrfs check --repair|--init-* or anythin=
g
> other than --readonly.
> As there is a long exiting bug in btrfs-progs which could cause similar
> corruption.
>
>
>
>> [57507.518764] BTRFS error (device dm-5): parent transid verify failed
>> on 2069131051008 wanted 4240 found 5115
>> [57507.519265] BTRFS error (device dm-5): failed to read block groups:=
 -5
>> [57507.605939] BTRFS error (device dm-5): open_ctree failed
>>
>>
>> btrfs check /dev/mapper/volume1
>> parent transid verify failed on 2069131051008 wanted 4240 found 5115
>> parent transid verify failed on 2069131051008 wanted 4240 found 5115
>> parent transid verify failed on 2069131051008 wanted 4240 found 5115
>> parent transid verify failed on 2069131051008 wanted 4240 found 5115
>> Ignoring transid failure
>> extent buffer leak: start 2024985772032 len 16384
>> ERROR: cannot open file system
>>
>>
>>
>> im not able to mount it anymore.
>>
>>
>> I found the drive in RO the other day and realized somthing was wrong
>> ... i did a reboot and now i cant mount anmyore
> Btrfs extent tree must has been corrupted at that time.
>
> Full recovery back to fully RW mountable fs doesn't look possible.
> As metadata CoW is completely screwed up in this case.
>
> Either you could use btrfs-restore to try to restore the data into
> another location.
>
> Or try my kernel branch:
> https://github.com/adam900710/linux/tree/rescue_options
>
> It's an older branch based on v5.1-rc4.
> But it has some extra new mount options.
> For your case, you need to compile the kernel, then mount it with "-o
> ro,rescue=3Dskip_bg,rescue=3Dno_log_replay".
>
> If it mounts (as RO), then do all your salvage.
> It should be a faster than btrfs-restore, and you can use all your
> regular tool to backup.
>
> Thanks,
> Qu
>
>>
>> any help

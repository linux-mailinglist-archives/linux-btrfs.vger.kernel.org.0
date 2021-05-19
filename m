Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D95038881E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 09:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbhESH1D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 03:27:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:38483 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230292AbhESH1D (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 03:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621409142;
        bh=wMFGX6lSYx/XxcpiXpNSHHdGa8dStqpK1LhrTFgxzR0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FR5kJkiTFzjZaJmLu+DmG66l9HFcFnMLfJuyhqCCpkuBOs8S/87ZegpwxouK3Gjsv
         mWbQLBO178HeJRNaITN5b4X8ei/36PAmaVPdfjYbAvthpcxM8CfWmkufGxoXWXDrX8
         WpO9o4jb/ViXHresf9UgDiRjwUNVVo7BHvZcAMoE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmlXK-1l0Xtj41FW-00joMt; Wed, 19
 May 2021 09:25:42 +0200
Subject: Re: System freeze with BTRFS corruption on 4 systems with kernel 5.12
 (MANJARO)
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <a924147d-1403-369b-85d5-a5ba5be662d8@petaramesh.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <31eea3fb-926e-ce69-95bc-5ade744100d3@gmx.com>
Date:   Wed, 19 May 2021 15:25:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <a924147d-1403-369b-85d5-a5ba5be662d8@petaramesh.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yBGYrmNkjYQZk5cTuWgr2ArEg7MERHCWQ852Cfo46oiUeAFLVHa
 YfTDvijoHidfX1Fn1lJFq1rIBo4il5S287rxMNXixWPO7VWt8gkUYS9kW0io60WABHLfhhs
 /zZD7mdQpHM5adc3jaTSvdOhU7E7p5TDkqq1UNbjOTSlhU881hxNsUS4VuzFdZXHGswoQfm
 apttR+0csuzCtcsUMxD0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H45AZJWEgac=:zLpUk2ATtPqc5TQTSW7rpD
 YbFB+fBFdiobDg7MNPNyxv4QMmaWA5uAuflXBZhUKtBMSTJWIE8TI4ud/rWGz6RyWJR0AQo5b
 Q9W6zzweamkK0T/vbO1+5zIArhoI/04L6PkKIhi7iLWsud014MC+f+ruJy8iFzp4lwwn8b4pN
 bWsUv1sXzhjnl+ueK5sgK0tNRewRphygq0WUorNePTpl7LNftgUeiLXB9mqtnlTcYMqgmtN67
 wWMCDsvTza/NajQEnmwtmiySb8UeT7jIHWd8j4mJrxt0xkZ/1/muJu7WI9e5dmvVrZcOkhnl/
 jcLWkRrG0Ut0PdQIgmCOy2XKZb1it3tLmCUS+DqK5s1KPGla/I46V8X0OS50nwUXatkNsfGZY
 Zw5iuWRoSejA5P1JHe/Y9md45Px3WxeGSHRzMwYvxk4YvayhJ8FEvuaOiFIXm8ce3oOaNhAJK
 Yl0sZgevDr8wSCBUwq/fJvRXUOJIFx1Vr6dGG2PQks+P4Gwo/A2Au9YjB21HYLwpF1y9Z1fci
 a96sVEosGYFgxv6G05VZ/OIsqjHEmMlXMDrI0c7gInIxu7jMs9tDPPx+HzeEfIIzJ92Qb42A6
 K6PM+tzjJfJvdCrgRZ/Xp39kv57bR5tVoMakadqSdJphFZvqg08F24rJfbU+wPIseBIuZGknc
 PnTb3PVuMp1OgyLZhriVO/UvPY0eMFY6yujjrP7ZA8zzc1xP7L7/BIGzVvj/SssksJRjZe+Rj
 0c+zvP5Cqk/0mjft1X18loB/NaGBx+FFGKwoDCbi8cxjxE5Xv5H1X/McgAj9jaJtEJD8IVHwq
 Apf/6GU/bbyUg5eAzEoC5dbXIDrbqosPXvNhtuh7Qm7G79bpUJW2/aMgVjHO/3HdxVCDv5Tby
 tkS8SjMf34X5bqv8PnjPgAd4k/7rP7Nzx6cgUgG8ev+vw7POlXd9zoQ64apAnp1KDs8VOKKna
 mm8jmY8itSn3xpnmkZ0TSJl6NLdXTZLZ56fx8f4RY9mAD2QJ9JJDuV2MAqHa7tOt7PnWkMuqz
 2ytNETI/KmOm6Zy8rF+ckcdyq+YTMe1StZiNXGj35teXpFPxGwTefqFkLyjh//3VnvhssI1rS
 6+WnO8UO0ryLhRMDwZO/ZSAeaYjmqwPNVPlFoSg8dxwgpQOsJdCOIrq/tdnTudY7glN2kab1d
 QZQrc60xcQnXWkl8xoR9xdryGmZ9VOyf+iq4e9GIqHSlsMUMQrC1vTp66kvy2rnXyg3shFGY9
 32aPuGDvF6pSjiNj+
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/19 =E4=B8=8B=E5=8D=881:39, Sw=C3=A2mi Petaramesh wrote:
> Hi list,
>
> (Please CC: me on replies, I'm not currently susbscribed to the list)
>
> This is to report a bug with Manjaro Linux 5.12.1-2 kernel that
> immediately affected 4 different, usually stable machines after update
> to kernel 5.12 from 5.11 or 5.10, and went away after reverting back to
> either 5.10 or 5.11.
>
> Kernel affected : Linux 5.12.1-2-MANJARO
> (Not sure if I tried Manjaro Linux 5.12.1-1-MANJARO)
>
> Kernel not affected : All previous versions up to 5.11.18-1-MANJARO
>
> Symptoms : Under heavy disk usage (such as performing a system backup
> onto external USB HD) the machine soon completely freezes and only a
> hard power cycle can get it out of it.

Any dying message?

>
> After reboot, systems on which BTRFS is built over bcache may show heavy
> filesystem corruption.

Which kind of corruption? Just data csum mismatch?

Does `btrfs check` reports other problems?

Thanks,
Qu
>
> Happened on :
>
> - HP Laptop 1 (Intel Atom) : BTRFS over LUKS on SSD : System freeze, no
> BTRFS corruption after reboot.
>
> - Dell Laptop 1 (Intel Core2 duo) : BTRFS over LUKS on SSD : System
> freeze, no BTRFS corruption after reboot.
>
> - HP Laptop 2 : One BTRFS FS over LUKS on SSD, and one BTRFS over bcache
> over LUKS on HD+SSD : System freeze, SSD BTRFS was not corrupt but BTRFS
> over bcache was severely corrupt, beyond repair and had to be rebuilt
> and restored from backups.
>
> - Asus old desktop with AMD Athlon 64 X2 : BTRFS RAID-1 over bcache over
> LUKS on 2 HD + SSD : System freeze, heavy BTRFS corruption that could
> however be fixed by simply running a =E2=80=9Cbtrfs scrub=E2=80=9D after=
 reverting back
> to a 5.10 Manjaro kernel.
>
>
> To be thorough, I also have to report an Arch Linux Intel Celeron
> machine running 5.12.4-arch1-2 kernel, BTRFS over LUKS on SSD, that has
> been running for a while without showing any such symptom.
>
>
> Hope these reports can be useful.
>
> Best regards.
>
> =E0=A5=90
>

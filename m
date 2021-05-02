Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D372D37096C
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 May 2021 02:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhEBApK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 May 2021 20:45:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:35199 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231655AbhEBApJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 May 2021 20:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619916257;
        bh=hh0KM4ffe6lRpZgJsTUfZ08hOb8zW0u0EAH+cT1nFlc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Ixq2T2a6JltlpeFZKAzRtUh6RomZWrWJGRfz2afqW9l+kQB+ikN3PoHKDSQrKbsK4
         dacetsfEQfLLk/5d5fdBi3EJCGeJvXnF0Sjdeg22VD1BNd0+JRwxDpiRrHzKZfRZmp
         eCEkz1mBiJFCvp7N2wVpvSJ22ekFIgJB1aIElzdk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAwXr-1ljIfh2t5d-00BMDi; Sun, 02
 May 2021 02:44:17 +0200
Subject: Re: "btrfs replace" ERROR: checking status of targetdev
To:     Yan Li <elliot.li.tech@gmail.com>, linux-btrfs@vger.kernel.org
References: <CALc-jWxqFtRDGtdpPLeYw2+bb5rvB6pm=camqyAQ6nOjO5wE3A@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <63953997-7b50-0daa-4a16-d78309136b81@gmx.com>
Date:   Sun, 2 May 2021 08:44:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CALc-jWxqFtRDGtdpPLeYw2+bb5rvB6pm=camqyAQ6nOjO5wE3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7RaBd5GNATziurUtbRMIRePkRI+T6fFbQIlIC/cgojt9DJq6+w0
 lGFH2eDOEH11dSfvGsxK+CnmTujLqMZNh0iz8Mi847fSEbOtrU9s9YS3k1KAI+aUGWk7WAl
 QhfUFB8TIHoZxowjckZ+DdBXXskF5ucXbFgRrqzljKYHoGsDMGA6euOLryYJpli7LYY7ko4
 c/JslEQiCTfSVo7aJ9brw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:g/fDumiKhZM=:IiwlxTA3VU/V0OqHdqzTVL
 olFT620QWLgJR79FJyvwKmRzBtLfbCZLJWPqHWU0mbxXGNtZ7tBQXB9DuFgqb8H23oBYU60lC
 Gk1eVyVjNp5p5aNAkd5aiP92gjbhQFGeWgSOYgRIIIIs4e7yJAJiy8hPHolKL3TdxUY3uStio
 n1cuur/OOMjRw+NIfyslUIrQKO5VsJyWDu/cesKUXXkaAxKs/rYatGO8tthXGjL8mBupaZJcm
 XGCqlN5E7cr6F2Vq3KzEvt4DMB4TYhdtrGauHbwT+UhZcWMUYbIisgoH0P9PM+NHSNcb8Z2iW
 kejkNImeNf9dIC/Zijc9WWpu+E6aIyQEt/HmiMSEDIQt6cUIiGsSUH2uGiCksmZIOCifxHynO
 gBC/WIWVLIC4jck+y/d33MQbU5oCbcCXuHBTOaDZ9Xj1HcGyg3e2rquYM4RlqzbA6g3oi5oLd
 RJMmaJM/C9qX0rgywD6MUUUqFn01/VdJ/L45AGo9XwfAIirtwO4nwOcyIDl7SI+esyrxnEZJY
 y/Rr4I4qK2euu+3MQKHWkmimoFhthMg461CsjH4+HBP6QnvHP9YxLFilTiD7w60dpWgzxI6f2
 pq+K/rom8otATqTdOhi7vndhGo2+/J26/b64BeiAxdLNzJ0s2juxBl2R5hTrNfKni6rkHZ1xR
 UXOzou7nEb+kGlp3X0GqmbhoG2Ad63OMCI3+wm+aZ4JIGseBwMJ5B7iAyiW9FWSxwzydThr7Y
 6r0Jrm41IqM3laH/CLOQdYYxhMJr0AJo3XVc8Almr1UrBL8mQB6B/7wGlADOu88XB38uaR0NT
 qbJ6vlOeemEUu7Ja1qMvKVl3fBdT+5T+Idiy/x1l/OPMubuuXCrK5TEUfDE7TdKMM1P5CGUgV
 vShuFIEeA6njueWfQl8vsgXG80oCCMi8M1upwo63y0tpGI3pzwFnbBSWBszbVT3U96IwTnYkw
 gYKaSXm+0Ic6YznQvNcbEUrHbrbMTo/SNMzY1ntO1uwzYpzo0qtTlYfjL2DAyGsZGsDQ2fT5/
 FxCDZ9bRhITGl1TvfLFaUIj9PLrVFsCaCibY4ZYWvYZYPDBLcb5PzTq4SLVBrJGtkj6P+kVKg
 FhcVuFAsttpKLG5OtiQbtFQPclMLKe6Iqw+x+MvQIvrAaI/UgZv4ggLac85fYsi+i3lBbl1km
 2AvtSZTX2vFh0P9+5lokZZJFvmCIXoPxnkwa8IdVizB8Rh0fY/RU8KDWSSHpE11LrBeN7BjIa
 tu4npLwlMvt1ocKil
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/2 =E4=B8=8A=E5=8D=885:39, Yan Li wrote:
> Hi!
>
> I have a raid1 btrfs with one device missing:
> $ sudo mount -o compress-force=3Dzstd:9,relatime,space_cache=3Dv2,degrad=
ed
> /dev/mapper/open_offsite_bak1 /mnt/offsite_bak
> $ sudo btrfs fi show /mnt/offsite_bak
> Label: none  uuid: 99acc0da-127f-4034-8d53-07851cbbccba
> Total devices 4 FS bytes used 8.75TiB
> devid    1 size 4.55TiB used 3.53TiB path dm-11
> devid    2 size 12.73TiB used 8.76TiB path dm-12
> devid    4 size 3.64TiB used 2.62TiB path dm-14
> *** Some devices missing
>
> Now I'm trying to replace it with another drive according to the
> instructions on the wiki
> (https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devic=
es#Using_btrfs_replace):
>
> $ sudo btrfs replace start -r 3 /dev/mapper/open_offsite_bak5 /mnt/offsi=
te_bak/
> ERROR: checking status of dm-13: No such file or directory
>
> /dev/mapper/open_offsite_bak5 indeed is a link to /dev/dm-13.
> $ sudo btrfs replace start -r 3 /dev/dm-13 /mnt/offsite_bak/
> shows exactly the same error.
>
> The device is fine if I try:
> sudo dd if=3D/dev/dm-13 of=3D/dev/null count=3D1
>
> There's no error message in dmesg.
>
> What could be the problem? I feel like it should be a stupid error on
> my part but I just can't figure out. "btrfs replace" doesn't support
> using a devicemapper device?
>
> Kernel: 5.11.0-16-generic
> btrfs-progs: 5.10.1-1build1

It looks like a bug in btrfs-progs.

Fixed in v5.11 btrfs-progs.

Would you please try to use v5.11 btrfs-progs to see if it solves your
problem.

Thanks,
Qu
> Both from Ubuntu 21.04 with latest updates.
>
> Thanks!
>
> --
> Yan
>

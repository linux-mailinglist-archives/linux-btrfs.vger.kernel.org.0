Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14FC22522D
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jul 2020 16:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgGSONg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jul 2020 10:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgGSONg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jul 2020 10:13:36 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9986BC0619D2
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jul 2020 07:13:35 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id y10so15519760eje.1
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jul 2020 07:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liland-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=07SUhLpC7kfdN+bYu5mpdTtc0rlBITRQeh0j41XKtgM=;
        b=wCdLE3rRfia4HO7fV0G6kVuiIABpYGbZfe9BWkRZpLMmfI9KyvDs55Iz6f6yVbg8bG
         ei/apkPUbvhoZvYwrnJ5eEJhw89qZ+Rn6LueDGManZ8hNATlNP+NrWw0C7Go2h+c5yQH
         kvKggvJBfcBteovjXpzSCh6cpwBei/5lDNUQY6DLs6Bg3JNQvg0ZppKQxDU1CBfTznwi
         FCljNIo+5EVBmGC3EYco/CICZPPHukCIm6xZ1rjgZIOO27gzTrvBgJJ/9e8NQvIce9Bd
         Djz0YTCRfLbLpmn4OlvXmxoW50E6CDWydz7m5kkNNX5bq86DPA6fVcC0rgbtC2uluvt7
         FiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=07SUhLpC7kfdN+bYu5mpdTtc0rlBITRQeh0j41XKtgM=;
        b=R9kZL1o4WIrUzy8B+2LWX5yZjwOhn2GS1aVXr9Tsq/acZUsXCME48F7aQrLJr8kAwY
         9D7YYbB9rFjS9YV8gpMtwNJCgCRfdkU7gUbTbjK7Ki9MwlKMC3jhQF4NV3WSfc8iOsRb
         71YBnpxmf8JoWdtSduPdpjpse1yebJC62se3wrPBdnVFv9nWljR82VRbhwXrcYZxadON
         QLJK6LRhQfniueLprKyZr5pmQs/2NcpuLhbkyM8Vo2tzvSbnNIMAjiBvws/ez1NaMLyE
         h45m5QdFsBj2I/HeQQy40bA2opKlNVTPhcpuGyuv1oNodlUGIYaOCdNJQkED16bxS/Xn
         LgsQ==
X-Gm-Message-State: AOAM533tnYkIIwJXLIJY5YZ7aVPdKOm/H4jg2r1fk5lKdka2cFRvWZJ6
        eeoWvKfcmql5QrCKUvZ85RwVaIQXTfrWLllY2KHvNbiuyJGZfdXKlIWUQyCZFvVbq+XnV4H+bGV
        HmpVM17KJw2Zj3np07MZn2n/Y
X-Google-Smtp-Source: ABdhPJwMDRho93aR4ovli+ICUXjbepvQ/Ga7lpYex3E8sybaVAotdshiq/fDsOiZEoT/2CEXbb3Xlg==
X-Received: by 2002:a17:906:1596:: with SMTP id k22mr16686022ejd.509.1595168013741;
        Sun, 19 Jul 2020 07:13:33 -0700 (PDT)
Received: from [192.168.42.1] (84-112-118-202.cable.dynamic.surfer.at. [84.112.118.202])
        by smtp.gmail.com with ESMTPSA id b6sm13509482eds.64.2020.07.19.07.13.32
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2020 07:13:32 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Edmund Urbani <edmund.urbani@liland.com>
Subject: Troubles removing missing device from RAID 6
Message-ID: <23712d34-1787-058d-b49a-6b3e78969920@liland.com>
Date:   Sun, 19 Jul 2020 16:13:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello everyone,

after having RMA'd a faulty HDD from my RAID6 and having received the=20
replacement, I added the new disk to the filesystem. At that point the=20
missing device was still listed and I went ahead to remove it like so:

btrfs device delete missing /mnt/shared/

After a few hours that command aborted with an I/O error and the logs=20
revealed this problem:

[284564.279190] BTRFS info (device sda1): relocating block group=20
51490279391232 flags data|raid6
[284572.319649] btrfs_print_data_csum_error: 75 callbacks suppressed
[284572.319656] BTRFS warning (device sda1): csum failed root -9 ino 433=20
off 386727936 csum 0x791e44cc expected csum 0xbd1725d0 mirror 2
[284572.320165] BTRFS warning (device sda1): csum failed root -9 ino 433=20
off 386732032 csum 0xec5f6097 expected csum 0x9114b5fa mirror 2
[284572.320211] BTRFS warning (device sda1): csum failed root -9 ino 433=20
off 386736128 csum 0x4d2fa4b9 expected csum 0xf8a923f9 mirror 2
[284572.320225] BTRFS warning (device sda1): csum failed root -9 ino 433=20
off 386740224 csum 0xcad08362 expected csum 0xa9361ed3 mirror 2
[284572.320266] BTRFS warning (device sda1): csum failed root -9 ino 433=20
off 386744320 csum 0x469ac192 expected csum 0xb1e94692 mirror 2
[284572.320279] BTRFS warning (device sda1): csum failed root -9 ino 433=20
off 386748416 csum 0x69759c1f expected csum 0xb3b9aa86 mirror 2
[284572.320290] BTRFS warning (device sda1): csum failed root -9 ino 433=20
off 386752512 csum 0xd3a7c5d5 expected csum 0xd351862f mirror 2
[284572.320465] BTRFS warning (device sda1): csum failed root -9 ino 433=20
off 386756608 csum 0x1264af83 expected csum 0x3a2c0ed5 mirror 2
[284572.320480] BTRFS warning (device sda1): csum failed root -9 ino 433=20
off 386760704 csum 0x260a13ef expected csum 0xb3b4aec0 mirror 2
[284572.320492] BTRFS warning (device sda1): csum failed root -9 ino 433=20
off 386764800 csum 0x6b615cd9 expected csum 0x99eaf560 mirror 2

I ran a long SMART self-test on the drives in the array which found no=20
problem. Currently I am running scrub to attempt and fix the block group.

scrub status:

UUID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 9c3c3f8d-a601-4bd3-8871-d068dd500a15

Scrub started:=C2=A0=C2=A0=C2=A0 Fri Jul 17 07:52:06 2020
Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 running
Duration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14:47:07
Time left:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 202:05:46
ETA:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Tue Jul 28 00:07:36 2020
Total to scrub:=C2=A0=C2=A0 16.80TiB
Bytes scrubbed:=C2=A0=C2=A0 1.14TiB
Rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 22.56MiB/s
Error summary:=C2=A0=C2=A0=C2=A0 read=3D295132162
 =C2=A0 Corrected:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
 =C2=A0 Uncorrectable:=C2=A0 295132162
 =C2=A0 Unverified:=C2=A0=C2=A0=C2=A0=C2=A0 0

device stats:

Label: none=C2=A0 uuid: 9c3c3f8d-a601-4bd3-8871-d068dd500a15
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 5 FS bytes used 1=
6.80TiB
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 3 size =
9.09TiB used 8.76TiB path /dev/sda1
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 4 size =
9.09TiB used 8.76TiB path /dev/sdb1
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 5 size =
9.09TiB used 8.74TiB path /dev/sdd1
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 6 size =
9.09TiB used 498.53GiB path /dev/sdc1
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *** Some devices missing

Is there anything else I can do to try and specifically fix that one=20
block group rather than scrubbing the entire filesytem? Also, is it=20
"normal" that scrub stats would show a huge number of "uncorrectable"=20
errors when a device is missing or should I be worried about that?

Kind regards,
 =C2=A0Edmund


--=20
Auch Liland ist in der Krise f=C3=BCr Sie da! #WirBleibenZuhause und liefer=
n=20
Ihnen trotzdem weiterhin hohe Qualit=C3=A4t und besten Service.=C2=A0
Unser Support=20
<mailto:support@liland.com> steht weiterhin wie gewohnt zur Verf=C3=BCgung.
Ihr=20
Team LILAND
*
*
*Liland IT GmbH*


Ferlach =E2=97=8F Wien =E2=97=8F M=C3=BCnchen
Tel: +43 463=20
220111
Tel: +49 89 458 15 940
office@Liland.com
https://Liland.com=20
<https://Liland.com>=C2=A0
 <https://twitter.com/lilandit>=C2=A0=20
<https://www.instagram.com/liland_com/>=C2=A0=20
<https://www.facebook.com/LilandIT/>

Copyright =C2=A9 2020 Liland IT GmbH=C2=A0


Diese Mail enthaelt vertrauliche und/oder rechtlich geschuetzte=C2=A0
Informationen.=C2=A0
Wenn Sie nicht der richtige Adressat sind oder diese Email=20
irrtuemlich=C2=A0erhalten haben, informieren Sie bitte sofort den Absender =
und=20
vernichten=C2=A0Sie diese Mail. Das unerlaubte Kopieren sowie die unbefugte=
=20
Weitergabe=C2=A0dieser Mail ist nicht gestattet.=C2=A0

This email may contain=20
confidential and/or privileged information.=C2=A0
If you are not the intended=20
recipient (or have received this email in=C2=A0error) please notify the sen=
der=20
immediately and destroy this email. Any=C2=A0unauthorised copying, disclosu=
re or=20
distribution of the material in this=C2=A0email is strictly forbidden.

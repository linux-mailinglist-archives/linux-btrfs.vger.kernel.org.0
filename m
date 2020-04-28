Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412C21BB762
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Apr 2020 09:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgD1HWY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Apr 2020 03:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgD1HWY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Apr 2020 03:22:24 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8CFC03C1A9
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Apr 2020 00:22:23 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n16so9872932pgb.7
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Apr 2020 00:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:autocrypt:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=HE8i9mdh761YpJw84xxMUQIXtxyRaErQD4EvbUKob40=;
        b=p9jmt4Lu2Km6A8pSwlHzSlEQaDaEnKowpyEquM9OvfcIQ+xGjlzj+r5h0xub9lq3Mu
         DG1pIsSxaHhfV1L2MrRNu8FYBCzjtaoms9aAvfXpqnUniTo3p0RMQhdccragjgctj9Yx
         Rv3ifdoJwahonq5fLrYPzRan5FF3ySEC0lpFeRxLNUnJT7S0rAwWHnZNwiat7u0oTE7v
         5ZXMcU+RSrEewTowFXAi5DSKMYIncVAmUxm79XJoH1+hkfJ88QLULH8y7mCY9HF9Nasd
         hfGH8YcPtFfdXOCtThzqqU+JkOvNFm8/OEGhG5WJsQL2wzLDVnQEqjUnwDb8IyEkdg47
         2kPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:autocrypt:subject:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=HE8i9mdh761YpJw84xxMUQIXtxyRaErQD4EvbUKob40=;
        b=hxhT//7hdA5VtkYW6xj48rnyD4LNDfPMCRNk1Psmu/3YU3ONAdjNGxpz0m8jS9ExhF
         AM3t2H6bIcxUsGHGK1EdUVikIkPXUxwkRQk0Dbsr7WUEOCZX2ketgLIWB0UbA18KcFvT
         6Z5WfGXCTQRBQLuRHbuJZsJ40iehpiyrN4JM27yN206dIEkqtfV3bJKWMKQm8LgdIslB
         lYaBPHkNRzAvgt4cbxGewI+8dc2bAp5E+L1Sh7qeX5AlVSq7DgBHA80K4UMOCEDOanx6
         Q+gyYH2r3zJnOjFppmb4Q0LwrMBezMgg3hM/fG1MM2QrRYPFVcW8nVHP6Q3jXGLYFugU
         S6vQ==
X-Gm-Message-State: AGi0PuZ/xkGdJUYfQVhhvHlQtcU/Cm86YXCyO3LqBbG41k+PSmgOHHED
        vbC8rlCPCIyBnPWwYU+Fs9q17A==
X-Google-Smtp-Source: APiQypJJUMfAY4Wr2a+bckbEJf7zLwo43A06GQqJ06aSIowmun1xMhKRblF6av108NYz5Av2bUQ5Sw==
X-Received: by 2002:a62:1549:: with SMTP id 70mr26871893pfv.43.1588058543365;
        Tue, 28 Apr 2020 00:22:23 -0700 (PDT)
Received: from selma.local ([2605:e000:1c0e:43f7:2543:a594:4e32:2f52])
        by smtp.gmail.com with ESMTPSA id a30sm12180928pgm.44.2020.04.28.00.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 00:22:22 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Phil Karn <karn@ka9q.net>
Autocrypt: addr=karn@ka9q.net; keydata=
 mQENBEw2mJ4BCADELiPsLFHDwapoSU7d2xNHxmwzzrFUCZWhO34kM6G5+o9GUNmGgMQ0BmXp
 I6hx77HHnrj9FC6kWh/bxBt3+o8HW+NTWzJSvf6kW7ThaNt7v9iewkS23JOMarAZs4qy6MhT
 1RW1/yWY7RimWxrmkKPTKKa0Ad4CWT6fcP3t+doqGslSQIeoTh0C33ZT+LY59Wcr224iXohN
 4Uu/nFe4yAHjtA+4Sesveo3Tyi8cbOgkcO6vij+pXesCcuhtGMlnE2dxRqbenrfVGLUVxNug
 LkQdLWezaGGm+dcjWYk1xjtaDnsCpVaYCMsfYNADQPJAjAFu37pVdoXhseVXfzOUN2EXABEB
 AAG0GVBoaWwgS2FybiA8a2FybkBrYTlxLm5ldD6JATgEEwECACIFAkw2mJ4CGwMGCwkIBwMC
 BhUIAgkKCwQWAgMBAh4BAheAAAoJEPFOQ1TtRjRGU98H/Atsb/N4lNbzNdzdIRcHD9XgCEa1
 UdR4mxgjwvLxS1nYRNdHwfTxvA5nxWfMx/0CB26VaNFdI3lkg/S0vYsSUu6M7l8Zb8v4JMyU
 4B4yvkFHZ3II5oilzIMa3e2cMfDz7TSwO1JcXyI5y9vHnvH65/LQF+QojDgzf3vXKiNdTXJp
 3nEa5IgMAB0rcSNsXFx8xbHi8s5niL9+1I7XTPvVMeXrMe8h4AG1nM/dK96WwmV+tLyXKYXn
 xVeb9F4X9CNQbkn/xAH+egvKHHT3V7K9cAhrDfu9Qwpo7zKk/akBpLWG2kmkTOfhXjm3UQhv
 MVgDmpeQIYa1HgAsKrsDQMzrIFm5AQ0ETDaYngEIAJmFdm0MmENzLEosD1FvGPJleWDYb0ah
 8dOk4XUug1RhW40f7AsugT75pKs9PolXt92920GdU727X3Jpgdj4kLDtIQA0KZrOXiEOZjIZ
 WcROAyvTGyMs/P7Um1AGNM161Ga6/Wtlc076FN7EUQtzPbthH26M3lGWUX0Ccls/8Ep4qbnF
 IrMRBxjaxKbqfKPTeU10pDykzA7s5hiNe7qaegvqD6YLseZ+6FqCn988YnLiIaFeNbWxUY5G
 spjAsfesnAmpn5vhUqAGiizkNlAMIN31xvpLd93oM4/vORszIuN1UP2RlxL3s30BncZl2XOd
 Mk1/59Sy70zVqF1ANyMrA18AEQEAAYkBHwQYAQIACQUCTDaYngIbDAAKCRDxTkNU7UY0Rszt
 B/9ZPH9xw47lPkVJRbhgf0G7fdsxsyiuouAqOKklUNFSy4+qeGomjwE6YvdMybwGtaUGla7t
 2mDzrva+7Gzb0inXIgmahQPmM16F3GVxGoFL+QJ+7gD8Hco6e0/2kju7ZREDE7SOEwKb3lhD
 eNLccfX2AqAHfCT/LVLbgBpMRmwUJQThM+33Z2L9BqIM3awj2mOTmeDumpxiDfroU90mGc9c
 pXe4YrNIkL/N8eMzLe1bpu+mpPCiIrEO+dFA7N8jjVcOCQ4Lr8sU6cOsEdkaACZiNFKT99eb
 NkKigK8sEkDZc/AKhPCEsnaZpwBZPScOL88LLi7FHj9Osznt+uhWfbLe
Subject: Extremely slow device removals
Message-ID: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
Date:   Tue, 28 Apr 2020 00:22:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've been running btrfs in RAID1 mode on four 6TB drives for years. They
have 35+K hours (4 years) of running time, and while they're still
passing SMART scans I I wanted to stop tempting fate. They were also
starting to get full (about 92%) and performance was beginning to suffer.=


My plan: replace them with two new 16TB EXOS (Enterprise) drives from
Seagate.

My first false start was a "device add" of one of the new drives
followed by a "device remove" on an old one. (I'd been a while, and I'd
forgotten "device replace"). This went extremely slowly, and by morning
it had bombed with a message in the kernel log about running out of
space on (I think) the *old* drive. This seemed odd since the new drive
was still mostly empty.

The filesystem also refused to remount right away, but given the furious
drive activity I decided to be patient. The file system mounted by
itself an hour or so later. There were plenty of "task hung" messages in
the kernel log, but they all seemed to be warnings. No lost data. Whew.

By now I remembered "device replace". But I'd already done "device add"
on the first new 16 TB drive. That gave me 5 drives online and no spare
slot for the second new drive.

I didn't want to repeat the "device remove" for fear of another
out-of-space failure. So I took a gamble.=C2=A0 I pulled one of the old 6=
TB
drives to make room for the second new 16TB drive, brought the array up
in degraded mode and started a "device replace missing" operation onto
the second new drive. 'iostat' showed just what I expected: a burst of
reads from one or more of the three old drives alternating with big
writes to the new drive. The data rates were reasonably consistent with
the I/O bandwidth limitations of my 10-year-old server. When it finished
the next day I pulled the old 6TB drive and replaced it with the second
new 16 TB drive. So far so good.

I then began another "device replace". Since I wasn't forced to degrade
the array this time, I didn't. It's been several days, and it's nowhere
near half done. As far as I can tell, it's only making headway of maybe
100-200 GB/day so at this rate it might finish in several weeks!
Moreover, when I run 'iostat' I see lots of writes **to** the drive
being replaced, usually in parallel with the same amount of data going
to one of the other drives.

I'd expect lots of *reads from* the drive being replaced, but why are
there any writes to it at all? Is this just to keep the filesystem
consistent in case of a crash?

I'd already run data and metadata balance operations up to about 95%.

I hesitate to tempt fate by forcing the system down to do another
"device replace missing" operation. Can anyone explain why replacing a
missing device is so much faster than replacing an existing device? Is
it simply because, without no redundancy left against a drive loss, less
work needs to (or can) be done to protect against a crash?

Thanks.

Phil Karn

Here's some current system information.

Linux homer.ka9q.net 4.19.0-8-rt-amd64 #1 SMP PREEMPT RT Debian
4.19.98-1 (2020-01-26) x86_64 GNU/Linux

btrfs-progs v4.20.1

Label: 'homer-btrfs'=C2=A0 uuid: 0d090428-8af8-4d23-99da-92f7176f82a7

Total devices 5 FS bytes used 9.89TiB
=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 5.46TiB used 3.81TiB pa=
th /dev/sdd3
=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 size 0.00B used 2.72TiB path=
 /dev/sde3 [device currently
being replaced]
=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 4 size 5.46TiB used 5.10TiB pa=
th /dev/sdc3
=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 5 size 14.32TiB used 6.08TiB p=
ath /dev/sdb4
=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 6 size 14.32TiB used 2.08TiB p=
ath /dev/sda4

Data, RAID1: total=3D9.84TiB, used=3D9.84TiB
System, RAID1: total=3D32.00MiB, used=3D1.73MiB
Metadata, RAID1: total=3D52.00GiB, used=3D48.32GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B




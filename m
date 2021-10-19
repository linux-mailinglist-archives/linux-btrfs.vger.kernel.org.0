Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED864333D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 12:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbhJSKvW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 06:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbhJSKvS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 06:51:18 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036B2C06161C
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 03:49:05 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u18so47102374wrg.5
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 03:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=L8W0T2N4hoQ6YukrM4ppKFMX/P3rY/h53FlLojZOPaA=;
        b=gWuzQOljEfCrDgi2KqFZ8YGPneR17UgLQUSAjYp+SGRhOCzwzTZzG03V0EIs8AcqLX
         OsHwcXEKZG12t3OtwGpbyMEkAH1340A1qRVnWJQYGWqZPPPFbrdquaMLKlpZZR2bkT7R
         ZNwl8wtdBQhIt62RbBYSldD60j9Sm9difA7bRmIn8JQqzLLcOv0m10d9owzrLpi8BpiY
         Y1y/fnjfvcW9nAxuJlpTinWtx/b4Ag6SfISAdDZIKckWFcYdmH+IHc6q8d0K6ggK1ADi
         jdJupYBqLXsk0QxdxNftn5nbMwGKyepmZXhRAg34Qt9bXTGuywnO+qHPZ8wLqikbxT17
         6agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=L8W0T2N4hoQ6YukrM4ppKFMX/P3rY/h53FlLojZOPaA=;
        b=dLe11PLGys69aM3JcvYXeU9ueOkK/MLgzCNoOOv1+jTjIcS5/iBByFGVDYOJ4C4EZW
         /ij7fMUL1guEeC78j1kgQsWf7sE4vqhN7LY896/A92tMAp27HBWRaVx+7SD+FWMgZQ3c
         0hmQc/wyYlKU8za1EG5vyeu/eP8sUmr2EsolrrSfHY7H2jsmiMDGsi5YRv1iybc7ZZoH
         snU1o3E4avThuE2Io71bw19G7WB346vBWWn+ZPl+758kKV91NW3zBRHIOy5dAl7sgzgf
         PhNSIQp82G4x/itiyw7vgwXNoZTQueWpCm5wj6T30PfLgtlT4uww4EOhVbDqKjq9ytiA
         r+2g==
X-Gm-Message-State: AOAM530iPpAhbdYhOKGudZzloRg9UqSTvFy1oNcSMbXhJrbrb9pSF/Ns
        LV8lI4JGibq1wX8v+6371OKyJUR/ykY=
X-Google-Smtp-Source: ABdhPJwUy7a18dT/2UZEOyRFf/iIlGukkmtNQMfAeWg05+dzi+iQGUU02JZ/yYbmjh2EUJbuj+PVTg==
X-Received: by 2002:adf:ab03:: with SMTP id q3mr45507932wrc.396.1634640543528;
        Tue, 19 Oct 2021 03:49:03 -0700 (PDT)
Received: from [127.0.0.1] (p5796730c.dip0.t-ipconnect.de. [87.150.115.12])
        by smtp.gmail.com with ESMTPSA id p8sm1849325wmg.15.2021.10.19.03.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 03:49:03 -0700 (PDT)
Date:   Tue, 19 Oct 2021 10:49:06 +0000 (UTC)
From:   Emil Heimpel <broetchenrackete@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <297b21db-4a67-469d-9ae1-54b1043dac31@gmail.com>
In-Reply-To: <47f76535-12c3-996e-3306-0bf0f4eed57e@gmx.com>
References: <ed4a7a10-d5a4-4b62-8e67-0b971487a74a@gmail.com> <47f76535-12c3-996e-3306-0bf0f4eed57e@gmx.com>
Subject: Re: Errors after successful disk replace
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <297b21db-4a67-469d-9ae1-54b1043dac31@gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Oct 19, 2021 07:35:54 Qu Wenruo <quwenruo.btrfs@gmx.com>:

>
>
> On 2021/10/19 11:54, Emil Heimpel wrote:
>> Hi all,
>>
>> One of my drives of a raid 5 btrfs array failed (was dead completely) so=
 I installed an identical replacement drive. The dead drive was devid 1 and=
 the new drive /dev/sde. I used the following to replace the missing drive:
>>
>> sudo btrfs replace start -B 1 /dev/sde1 /mnt/btrfsrepair/
>>
>> and it completed successfully without any reported errors (took around 2=
 weeks though...).
>>
>> I then tried to see my array with filesystem show, but it hung (or took =
longer than I wanted to wait), so I did a reboot.
>
> Any dmesg of that time?
>

Nothing after the replace finished:

1634463961.245751 BlueQ kernel: BTRFS error (device sdb1): failed to rebuil=
d valid logical 17663044222976 for dev (efault)
1634463961.255819 BlueQ kernel: BTRFS error (device sdb1): failed to rebuil=
d valid logical 17663045795840 for dev (efault)
1634463961.275815 BlueQ kernel: BTRFS error (device sdb1): failed to rebuil=
d valid logical 17663046582272 for dev (efault)
1634463961.275922 BlueQ kernel: BTRFS error (device sdb1): failed to rebuil=
d valid logical 17663047368704 for dev (efault)
1634463961.339074 BlueQ kernel: BTRFS error (device sdb1): failed to rebuil=
d valid logical 17663048155136 for dev (efault)
1634463961.339248 BlueQ kernel: BTRFS error (device sdb1): failed to rebuil=
d valid logical 17663048941568 for dev (efault)
1634475910.611261 BlueQ kernel: sd 9:0:2:0: attempting task abort!scmd(0x00=
00000046fead3f), outstanding for 7120 ms & timeout 7000 ms
1634475910.615126 BlueQ kernel: sd 9:0:2:0: [sdd] tag#840 CDB: ATA command =
pass through(16) 85 08 2e 00 00 00 01 00 00 00 00 00 00 00 ec 00
1634475910.615429 BlueQ kernel: scsi target9:0:2: handle(0x000b), sas_addre=
ss(0x4433221105000000), phy(5)
1634475910.615691 BlueQ kernel: scsi target9:0:2: enclosure logical id(0x59=
0b11c022f3fb00), slot(6)
1634475910.787911 BlueQ kernel: sd 9:0:2:0: task abort: SUCCESS scmd(0x0000=
000046fead3f)
1634475910.807083 BlueQ kernel: sd 9:0:2:0: Power-on or device reset occurr=
ed
1634475949.877998 BlueQ kernel: sd 9:0:2:0: Power-on or device reset occurr=
ed
1634525944.213931 BlueQ kernel: perf: interrupt took too long (3138 > 3137)=
, lowering kernel.perf_event_max_sample_rate to 63600
1634533791.168760 BlueQ kernel: BTRFS error (device sdb1): failed to rebuil=
d valid logical 22996545634304 for dev (efault)
1634552685.203559 BlueQ kernel: BTRFS error (device sdb1): failed to rebuil=
d valid logical 23816815706112 for dev (efault)
1634558977.979621 BlueQ kernel: BTRFS info (device sdb1): dev_replace from =
<missing disk> (devid 1) to /dev/sde1 finished
1634560793.132731 BlueQ kernel: zram0: detected capacity change from 326108=
64 to 0
1634560793.169379 BlueQ kernel: zram: Removed device: zram0
1634560883.549481 BlueQ kernel: watchdog: watchdog0: watchdog did not stop!
1634560883.556038 BlueQ systemd-shutdown[1]: Syncing filesystems and block =
devices.
1634560883.572840 BlueQ systemd-shutdown[1]: Sending SIGTERM to remaining p=
rocesses...




>>
>> It showed up after a reboot as followed:
>>
>> Label: 'BlueButter'=C2=A0 uuid: 7e3378e6-da46-4a60-b9b8-1bcc306986e3
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 6 FS bytes used=
 20.96TiB
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 0 siz=
e 7.28TiB used 5.46TiB path /dev/sde1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 siz=
e 7.28TiB used 5.46TiB path /dev/sdb1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 3 siz=
e 2.73TiB used 2.73TiB path /dev/sdg1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 4 siz=
e 2.73TiB used 2.73TiB path /dev/sdd1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 5 siz=
e 7.28TiB used 4.81TiB path /dev/sdf1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 6 siz=
e 7.28TiB used 5.33TiB path /dev/sdc1
>>
>> I then tried to mount it, but it failed, so I run a readonly check and i=
t reported the following problem:
>
> And dmesg for the failed mount?
>

Oops, I must have missed that it failed because of missing devid 1 too...

1634562944.145383 BlueQ kernel: BTRFS info (device sde1): flagging fs with =
big metadata feature
1634562944.145529 BlueQ kernel: BTRFS info (device sde1): force zstd compre=
ssion, level 2
1634562944.145650 BlueQ kernel: BTRFS info (device sde1): using free space =
tree
1634562944.145697 BlueQ kernel: BTRFS info (device sde1): has skinny extent=
s
1634562944.148709 BlueQ kernel: BTRFS error (device sde1): devid 1 uuid 516=
45efd-bf95-458d-b5ae-b31623533abb is missing
1634562944.148764 BlueQ kernel: BTRFS error (device sde1): failed to read c=
hunk tree: -2
1634562944.185369 BlueQ kernel: BTRFS error (device sde1): open_ctree faile=
d

> Thanks,
> Qu
>>
>> [...]
>> [2/7] checking extents
>> ERROR: super total bytes 38007432437760 smaller than real device(s) size=
 46008994590720
>> ERROR: mounting this fs may fail for newer kernels
>> ERROR: this can be fixed by 'btrfs rescue fix-device-size'
>> [3/7] checking free space tree
>> [...]
>>
>> So I followed that advice but got the following error:
>>
>> sudo btrfs rescue fix-device-size /dev/sde1
>> ERROR: devid 1 is missing or not writeable
>> ERROR: fixing device size needs all device(s) to be present and writeabl=
e
>>
>> So it seems something went wrong or didn't complete fully.
>> What can I do to fix this problem?
>>
>> uname -a
>> Linux BlueQ 5.14.12-arch1-1 #1 SMP PREEMPT Wed, 13 Oct 2021 16:58:16 +00=
00 x86_64 GNU/Linux
>>
>> btrfs --version
>> btrfs-progs v5.14.2
>>
>> Regards,
>> Emil
>>
>> P.S.: Yes, I know, raid5 isn't stable but it works good enough for me ;)
>> Metadata is raid1 btw...
>>


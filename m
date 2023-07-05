Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D52747B98
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jul 2023 04:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjGECoL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jul 2023 22:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGECoL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Jul 2023 22:44:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F4D10F2
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jul 2023 19:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1688525046; x=1689129846; i=quwenruo.btrfs@gmx.com;
 bh=sOFUDMGkA2OXu/M/GYXzaloNZgjuOK7RtXhazJCQewc=;
 h=X-UI-Sender-Class:Date:From:To:References:Subject:In-Reply-To;
 b=bE3qQTTrPry7IQZcbfAJrfic6yhuSz4TUDVkMgiwZzx7/BYXEcWrZ4ErN98YQ29WPeGiOaz
 LOGurVafmE8Kwtnso7wulkmU94rjNYA7/+cYHOGTi5cb02vjiJ+bi/25SiumNuhQaktgtv6s5
 5OKLKpCxVR4svCdaEiJhXvdgLUgdiibR1YtDFbdnb36DjuoiWvZKFAIN7+VV7AeEJjpOb2c7L
 h8/Yhqb+e37r1LECp/2OX3plgXPDQ0guCYXbViTCS3i0WC+MNy+x3d3MtfaK0zyIkQ6gIJv0g
 aIvpJVRM1cDrtKbEAxajjEmh8sOIf1YjRoamQv2QK4LA1hhrTaGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mz9Yv-1q4Hag14z5-00wDDt; Wed, 05
 Jul 2023 04:44:05 +0200
Message-ID: <a371b46e-dce1-833f-2068-d9d8c11902ac@gmx.com>
Date:   Wed, 5 Jul 2023 10:44:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Tim Cuthbertson <ratcheer@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
 <c30a0d54-dd57-06d7-92e5-1a0fea98fea5@gmx.com>
Subject: Re: Scrub of my nvme SSD has slowed by about 2/3
In-Reply-To: <c30a0d54-dd57-06d7-92e5-1a0fea98fea5@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EIEd1X8Bvih3Wmk2RCGEDsAaqNekH/B4wMiIUOjILfAD0DKDyWa
 Ci/oxu0BT1gRoyAg9yHmzjFgQoef6yKXQE0Ta+oOPqQLUYDOU6wJ/PVr4at7wgNEmC8FlaB
 JqFQ0i1Oj4jxf9Y9DxgwMhxmMuksJYoIxnKz1J/vC5hdNq9vRGLf7swSI2k/bzNtlHKZveS
 58QrFLg9OZlvg+kU7hb/A==
UI-OutboundReport: notjunk:1;M01:P0:rxqTUCvZpL4=;QlNjXymig+HLqP6wWTSawO7wm3n
 1067GmUqASoA2v3mNLbVjEzwIeopVUZqzVlKiTb6PeGnMH/m8AJwPDZThWS2kVW1hY+KNm6Fq
 Ic+pXd6C1RURmEfSoxmOKBhMrzCSTrY8VW7/ejhCw5kI5bEuAfTMa1Zj6kk6Opn1QIkA4r+hj
 LDj0EFmKHw12g2VwbsvGHdxcfcpTttho2yHJeWx+ySKZpmNw80Lnp+6qZti37kjaJTmSWd5N5
 NEJ4Z5PKzRS1gFCyx7aZYTNof3VfAv6RTfzRkAHu5nvAMW/PW43qCIUJyRRxYZuIkoMTWN0PD
 Y9eoH4elzVE9DmM2e8/HNUqRvXI0wp0UtRP4ck8KgtJ/aOjEfWXYm84Lt/DnMt03TuccCRaPI
 xk/Y4XnuQ6OiYPSxIj5zkrvCb763OaxMgz+OAzvEa4PXxUl4psJ6xyFoTekXrpkyOrkSBV/FJ
 oytb8gtQWR8zWdeuXnTI6lGZxZ6jzuTtYYWXhkBkY6RNsYG0nIji4kd/zhSuXd4N3SKv7eVaS
 5TrdwGqVXWC3OV4Mqv7jwF89pnKSdLBNITYq1XHwJIYoSrHIXlxoJnq8ZV/TPALmE2q0G95O9
 QHWagYDf3tIYbv4hvgzLxG2PuSdRuGGRS8dVA3uvGbqYePl2CaKwGZsK5T5Y80Jj+9Q6f7oex
 aRlFXuLBvz1N8/bcQKR6n9IxvJaCZInOx6/GgYWUio7GOFNBxBNZTuchOYl6823CWzpIKTKL2
 QlgUv2CBn3lkThzlZbikX0P1s+G4sZFpe2xDOFU4tpHLWNqHPOOd2kS2jEtkXsWq2IXfJB3/1
 mJq1OWpo5BrraHXrkV2mNeBKRVJisM7zvqj4YRqe5MhOhBTqg6pO1iTcdhtpsmZlvOO963zQC
 +KZqArNHFN3D1YK1xG8CeZuC1XoVhRR8H9QCm7EanKuTkzjUM07psNkg3aDdOOduZYvAQIN24
 HysMDtQ2JnfPSjADcbwG67ep+4E=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/4 07:49, Qu Wenruo wrote:
>
>
> On 2023/7/4 04:19, Tim Cuthbertson wrote:
>> Yesterday, I noticed that a scrub of my main system filesystem has
>> slowed from about 2.9 gb/sec to about 949 mb/sec. My scrub used to run
>> in about 12 seconds, now it is taking 51 seconds. I had just installed
>> Linux kernel 6.4.1 on Arch Linux, upgrading from 6.3.9. At first I
>> suspected the new kernel, but now I am not so sure.
>
> Well, the v6.4 kernel has introduced a new scrub implementation, which
> has a completely different way of handling IOs.

In fact, I'm considering doing the old way of checksum verification, one
thread per-block, to address the performance problem.

If you're fine compiling a custom kernel, I can craft a branch for you
to test.

My educated guess shows, it seems possible that performance regression
is caused by the behavior change.

Currently we read one stripe, do the verification in a single thread.
Your disk read can read 3GB/s, while your CPU can only do CRC32
verification around 2GB/s.

In that case, csum verification is the bottle neck, resulting a
theocratic performance around 1.2GB/s, near your observed performance.

But if we allow the multi-thread verification, we can do 16 threads,
that results something around 2.7GB/s, also matches your old kernel
observation.

Thanks,
Qu
>
> In my initial tests, the new scrub should lead to less IOPS while higher
> throughput.
> But it doesn't look good at all for your case.
>
> Have you tried to roll the kernel back to 6.3.x and re-test?
>
> One of the new behavior change is in how csum is verified.
> Previously the csum is verified one thread per-sector (4K block), but
> now it's changed to one thread per stripe (64K block).
> But with a much larger block size to reduce IOPS.
>
> All the changes should lead to a better performance on slower disks, but
> with your blazing fast devices, the csum verification may be a
> bottleneck instead.
>
> If it's really the case, mind to also monitor your CPU usage during
> scrub and compare the CPU usage between v6.4 and v6.3 kernels?
>
> Thanks,
> Qu
>>
>> I have btrfs-progs v 6.3.2-1. It was last upgraded on June 23.
>>
>> Here are the results of a recent scrub:
>>
>> btrfs scrub status /mnt/nvme0n1p3/
>> UUID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 20db1fe2-60a4-4eb7-87ac-1953a55dda16
>> Scrub started:=C2=A0=C2=A0=C2=A0 Sun Jul=C2=A0 2 19:19:53 2023
>> Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fin=
ished
>> Duration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0:00:51
>> Total to scrub:=C2=A0=C2=A0 47.28GiB
>> Rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 948.61MiB/s
>> Error summary:=C2=A0=C2=A0=C2=A0 no errors found
>>
>> Here is hdparm performance output of the drive:
>>
>> /dev/nvme0n1:
>> =C2=A0 Timing O_DIRECT cached reads:=C2=A0=C2=A0 3744 MB in=C2=A0 2.00 =
seconds =3D 1871.94
>> MB/sec
>> =C2=A0 Timing O_DIRECT disk reads: 9180 MB in=C2=A0 3.00 seconds =3D 30=
59.63 MB/sec
>>
>> Here is an attempt at describing my system:
>> inxi -F
>> System:
>>
>> =C2=A0=C2=A0 Host: tux Kernel: 6.4.1-arch1-1 arch: x86_64 bits: 64 Cons=
ole: pty
>> pts/2 Distro: Arch Linux
>> Machine:
>> =C2=A0=C2=A0 Type: Desktop Mobo: ASUSTeK model: TUF GAMING X570-PLUS (W=
I-FI) v:
>> Rev X.0x
>> =C2=A0=C2=A0=C2=A0=C2=A0 serial: 200771405807421 UEFI: American Megatre=
nds v: 4602 date:
>> 02/23/2023
>> CPU:
>> =C2=A0=C2=A0 Info: 12-core model: AMD Ryzen 9 3900X bits: 64 type: MT M=
CP cache:
>> L2: 6 MiB
>> =C2=A0=C2=A0 Speed (MHz): avg: 2666 min/max: 2200/4672 cores: 1: 3800 2=
: 2200 3:
>> 2200 4: 2200 5: 2200
>> =C2=A0=C2=A0=C2=A0=C2=A0 6: 3800 7: 2200 8: 3800 9: 2200 10: 2200 11: 3=
800 12: 2200 13:
>> 3800 14: 2200 15: 2200 16: 2200
>> =C2=A0=C2=A0=C2=A0=C2=A0 17: 2200 18: 2200 19: 2200 20: 2200 21: 3800 2=
2: 2200 23: 2200
>> 24: 3800
>> Graphics:
>> =C2=A0=C2=A0 Device-1: NVIDIA TU104 [GeForce RTX 2060] driver: nvidia v=
: 535.54.03
>> =C2=A0=C2=A0 Display: server: X.org v: 1.21.1.8 driver: X: loaded: nvid=
ia
>> unloaded: modesetting gpu: nvidia
>> =C2=A0=C2=A0=C2=A0=C2=A0 tty: 273x63
>> =C2=A0=C2=A0 API: OpenGL Message: GL data unavailable in console and gl=
xinfo
>> missing.
>> Audio:
>> =C2=A0=C2=A0 Device-1: NVIDIA TU104 HD Audio driver: snd_hda_intel
>> =C2=A0=C2=A0 Device-2: AMD Starship/Matisse HD Audio driver: snd_hda_in=
tel
>> =C2=A0=C2=A0 API: ALSA v: k6.4.1-arch1-1 status: kernel-api
>> Network:
>> =C2=A0=C2=A0 Device-1: Intel Wireless-AC 9260 driver: iwlwifi
>> =C2=A0=C2=A0 IF: wlan0 state: up mac: cc:d9:ac:3a:b4:9d
>> =C2=A0=C2=A0 Device-2: Realtek RTL8111/8168/8411 PCI Express Gigabit Et=
hernet
>> driver: r8169
>> =C2=A0=C2=A0 IF: enp5s0 state: down mac: 24:4b:fe:96:38:f9
>> Bluetooth:
>> =C2=A0=C2=A0 Device-1: N/A driver: btusb type: USB
>> =C2=A0=C2=A0 Report: rfkill ID: hci0 rfk-id: 0 state: down bt-service: =
disabled
>> rfk-block: hardware: no
>> =C2=A0=C2=A0=C2=A0=C2=A0 software: no address: see --recommends
>> Drives:
>> =C2=A0=C2=A0 Local Storage: total: 7.73 TiB used: 378.62 GiB (4.8%)
>> =C2=A0=C2=A0 ID-1: /dev/nvme0n1 vendor: Western Digital model: WDBRPG00=
10BNC-WRSN
>> size: 931.51 GiB
>> =C2=A0=C2=A0 ID-2: /dev/sda vendor: Samsung model: SSD 860 EVO 500GB si=
ze:
>> 465.76 GiB
>> =C2=A0=C2=A0 ID-3: /dev/sdb vendor: Seagate model: ST2000DM008-2FR102 s=
ize: 1.82
>> TiB
>> =C2=A0=C2=A0 ID-4: /dev/sdc vendor: Western Digital model: WD50NDZW-11B=
GSS1 size:
>> 4.55 TiB type: USB
>> Partition:
>> =C2=A0=C2=A0 ID-1: / size: 915.26 GiB used: 47.37 GiB (5.2%) fs: btrfs =
dev:
>> /dev/nvme0n1p3
>> =C2=A0=C2=A0 ID-2: /boot size: 252 MiB used: 92.1 MiB (36.5%) fs: vfat =
dev:
>> /dev/nvme0n1p1
>> =C2=A0=C2=A0 ID-3: /home size: 915.26 GiB used: 47.37 GiB (5.2%) fs: bt=
rfs dev:
>> /dev/nvme0n1p3
>> Swap:
>> =C2=A0=C2=A0 ID-1: swap-1 type: partition size: 16 GiB used: 0 KiB (0.0=
%) dev:
>> /dev/nvme0n1p2
>> Sensors:
>> =C2=A0=C2=A0 System Temperatures: cpu: 27.5 C mobo: 26.0 C gpu: nvidia =
temp: 32 C
>> =C2=A0=C2=A0 Fan Speeds (RPM): fan-1: 847 fan-2: 1074 fan-3: 0 fan-4: 0=
 fan-5:
>> 1002 fan-6: 0 fan-7: 782
>> Info:
>> =C2=A0=C2=A0 Processes: 407 Uptime: 23m Memory: available: 31.25 GiB us=
ed: 1.54
>> GiB (4.9%) Init: systemd
>> =C2=A0=C2=A0 Shell: Bash inxi: 3.3.27

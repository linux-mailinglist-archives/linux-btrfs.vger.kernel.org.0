Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E428274663D
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jul 2023 01:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjGCXtt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 19:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCXts (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 19:49:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22740180
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 16:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1688428185; x=1689032985; i=quwenruo.btrfs@gmx.com;
 bh=3CObK3/nxCMH082AIMrHiG7sHRP0SNpIEvLTuRjei9M=;
 h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
 b=QDWOORZ6Nv6biash7qtdcmMoijoj8JZIszhY61l00m5WjDHN9zsyQXKgJ2+KaNL+T+dTiBO
 mM8LSo6FrDc/HduFTjL3arhqHaDM2Ws1VoSevmd5iOKsNyz34wG4xw8HHwc2ce88XY+Ioydsc
 lpnMflV+I8RA7Aj049CCVc+As4EKMT1GegDRY47fG/d3DtrmqvWNSS7enKMaoW2i8sKqx+lX2
 E6HJJz96IuMPkzKg7zl+QzlBUBVEVKnINh7xGKMCx+gk6+ZPlIvE3AyOLAetGQNqURTFO7MvH
 emJXcqOCSjDPmlmu4RWMvlw5okBBwvYs6StKyokYBKEvYW8XvxfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7zBb-1ptjUR13j9-0150nb; Tue, 04
 Jul 2023 01:49:44 +0200
Message-ID: <c30a0d54-dd57-06d7-92e5-1a0fea98fea5@gmx.com>
Date:   Tue, 4 Jul 2023 07:49:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Tim Cuthbertson <ratcheer@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Scrub of my nvme SSD has slowed by about 2/3
In-Reply-To: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:538mlTzSjVJEPrzwGmh9CnH7F3r/0kJQNprvF0Kv8/CGHMo8mDW
 Lr6rSFnXG/4KhIr4eFK+XbS7tYkuQUkSHZ07pdoZJ4rsI9P9KipXZ4NR4fnrVZqZeeZ9jVk
 5bLKst2/fUTQFFQbLJ2x10d7ARi0PJO1ijfSn/5z6cnsKK7lDrnTzKifhwJzDOv3xCrj27p
 4f97ykD+WrOJhF79/Vrjw==
UI-OutboundReport: notjunk:1;M01:P0:FrpKmeWLZw0=;jevCwI4q1uRSLLOREwnFebyIXWC
 H/Sizg30TAT+vhp1xbveOWfTUAYH/KTGKOawkf4vKQKAlA8RQof66+Z9YICmUkfPcTLNc3+ff
 qnNwD/ktIMf3mpE0seR155rXBcG5WaQYxv13Dncmrzy9oBwHX8e1EUYtZxnDX3KnvyCcEekcl
 73qq0ZYS/XhQ75z1psLpn7FdgenT0pu8bNneM2PFGD9ASAB/gCPUSHMWCqKheR8zMpqy5nNYb
 GIZ20swKP1/o0zcSk2FCa18gzWKIgHhf+vKmuUmkaVVl+dbD31Fq4oYyKujnBReu+u6EhwC07
 vG4wjkXBBQRpbyEhEMqmJq8Pkdr4/iilUqUteC5POS/zXLwp8nyE8ngyf6gRPaiZI9gQs/FD/
 JcnjmppvKkV6Sbzx6YVqLDffv01MWSVXjKPL8j/izSNoK0WbF0dlxqegp7syTirVMJqPL/d74
 GxGJhGtirWkPWsgHTTKsLW6xjiQf/1DL3syqI2uIXGCmBUzQjo+thPFIkj4ePNkyIIh5Eu03U
 r34f9dMPiM7d6kNrjqrZDreq3Cem+FphCdGny4RHxoZHMyc4+AOsCLm4oZATPpIkFKqlm7LTH
 4vOJhHGb4dEyiPhUdOgf4hvtJU+Bv6xMAb8dCR4vxaTdUja7cnR5iwCkpiKz5yNu3xagCCmEP
 BS8qvKhXOvTund6tThLDq5QcX1fJE1AT7xNs0BRDv8npafu5oCNN/VharPKxqwz8IDCOp3A1X
 VRffzgjN4f81j9Er7WB+rMgvHEBdO65uX7AUjwDULiOWkz07mPXZyotIjrpMCnOigdL1tJDRP
 2XxSclgYiS/wSdqMmzh2aX/7+xBB243JkkRFLOsd8wi8XMKSMfgiC/bxrw+SIrM6JrQ3oatoo
 1gzQoCGCw8/n9T7ykNvKTlklYopXyY3o5g1TIN5UBaGMUt3K6u4tFN3CWKaqZLhskt9WMq5Vw
 eW9Vd7h5NoN+7Jve+qJYa/+8KjM=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/4 04:19, Tim Cuthbertson wrote:
> Yesterday, I noticed that a scrub of my main system filesystem has
> slowed from about 2.9 gb/sec to about 949 mb/sec. My scrub used to run
> in about 12 seconds, now it is taking 51 seconds. I had just installed
> Linux kernel 6.4.1 on Arch Linux, upgrading from 6.3.9. At first I
> suspected the new kernel, but now I am not so sure.

Well, the v6.4 kernel has introduced a new scrub implementation, which
has a completely different way of handling IOs.

In my initial tests, the new scrub should lead to less IOPS while higher
throughput.
But it doesn't look good at all for your case.

Have you tried to roll the kernel back to 6.3.x and re-test?

One of the new behavior change is in how csum is verified.
Previously the csum is verified one thread per-sector (4K block), but
now it's changed to one thread per stripe (64K block).
But with a much larger block size to reduce IOPS.

All the changes should lead to a better performance on slower disks, but
with your blazing fast devices, the csum verification may be a
bottleneck instead.

If it's really the case, mind to also monitor your CPU usage during
scrub and compare the CPU usage between v6.4 and v6.3 kernels?

Thanks,
Qu
>
> I have btrfs-progs v 6.3.2-1. It was last upgraded on June 23.
>
> Here are the results of a recent scrub:
>
> btrfs scrub status /mnt/nvme0n1p3/
> UUID:             20db1fe2-60a4-4eb7-87ac-1953a55dda16
> Scrub started:    Sun Jul  2 19:19:53 2023
> Status:           finished
> Duration:         0:00:51
> Total to scrub:   47.28GiB
> Rate:             948.61MiB/s
> Error summary:    no errors found
>
> Here is hdparm performance output of the drive:
>
> /dev/nvme0n1:
>   Timing O_DIRECT cached reads:   3744 MB in  2.00 seconds =3D 1871.94 M=
B/sec
>   Timing O_DIRECT disk reads: 9180 MB in  3.00 seconds =3D 3059.63 MB/se=
c
>
> Here is an attempt at describing my system:
> inxi -F
> System:
>
>    Host: tux Kernel: 6.4.1-arch1-1 arch: x86_64 bits: 64 Console: pty
> pts/2 Distro: Arch Linux
> Machine:
>    Type: Desktop Mobo: ASUSTeK model: TUF GAMING X570-PLUS (WI-FI) v: Re=
v X.0x
>      serial: 200771405807421 UEFI: American Megatrends v: 4602 date: 02/=
23/2023
> CPU:
>    Info: 12-core model: AMD Ryzen 9 3900X bits: 64 type: MT MCP cache: L=
2: 6 MiB
>    Speed (MHz): avg: 2666 min/max: 2200/4672 cores: 1: 3800 2: 2200 3:
> 2200 4: 2200 5: 2200
>      6: 3800 7: 2200 8: 3800 9: 2200 10: 2200 11: 3800 12: 2200 13:
> 3800 14: 2200 15: 2200 16: 2200
>      17: 2200 18: 2200 19: 2200 20: 2200 21: 3800 22: 2200 23: 2200 24: =
3800
> Graphics:
>    Device-1: NVIDIA TU104 [GeForce RTX 2060] driver: nvidia v: 535.54.03
>    Display: server: X.org v: 1.21.1.8 driver: X: loaded: nvidia
> unloaded: modesetting gpu: nvidia
>      tty: 273x63
>    API: OpenGL Message: GL data unavailable in console and glxinfo missi=
ng.
> Audio:
>    Device-1: NVIDIA TU104 HD Audio driver: snd_hda_intel
>    Device-2: AMD Starship/Matisse HD Audio driver: snd_hda_intel
>    API: ALSA v: k6.4.1-arch1-1 status: kernel-api
> Network:
>    Device-1: Intel Wireless-AC 9260 driver: iwlwifi
>    IF: wlan0 state: up mac: cc:d9:ac:3a:b4:9d
>    Device-2: Realtek RTL8111/8168/8411 PCI Express Gigabit Ethernet driv=
er: r8169
>    IF: enp5s0 state: down mac: 24:4b:fe:96:38:f9
> Bluetooth:
>    Device-1: N/A driver: btusb type: USB
>    Report: rfkill ID: hci0 rfk-id: 0 state: down bt-service: disabled
> rfk-block: hardware: no
>      software: no address: see --recommends
> Drives:
>    Local Storage: total: 7.73 TiB used: 378.62 GiB (4.8%)
>    ID-1: /dev/nvme0n1 vendor: Western Digital model: WDBRPG0010BNC-WRSN
> size: 931.51 GiB
>    ID-2: /dev/sda vendor: Samsung model: SSD 860 EVO 500GB size: 465.76 =
GiB
>    ID-3: /dev/sdb vendor: Seagate model: ST2000DM008-2FR102 size: 1.82 T=
iB
>    ID-4: /dev/sdc vendor: Western Digital model: WD50NDZW-11BGSS1 size:
> 4.55 TiB type: USB
> Partition:
>    ID-1: / size: 915.26 GiB used: 47.37 GiB (5.2%) fs: btrfs dev: /dev/n=
vme0n1p3
>    ID-2: /boot size: 252 MiB used: 92.1 MiB (36.5%) fs: vfat dev: /dev/n=
vme0n1p1
>    ID-3: /home size: 915.26 GiB used: 47.37 GiB (5.2%) fs: btrfs dev:
> /dev/nvme0n1p3
> Swap:
>    ID-1: swap-1 type: partition size: 16 GiB used: 0 KiB (0.0%) dev:
> /dev/nvme0n1p2
> Sensors:
>    System Temperatures: cpu: 27.5 C mobo: 26.0 C gpu: nvidia temp: 32 C
>    Fan Speeds (RPM): fan-1: 847 fan-2: 1074 fan-3: 0 fan-4: 0 fan-5:
> 1002 fan-6: 0 fan-7: 782
> Info:
>    Processes: 407 Uptime: 23m Memory: available: 31.25 GiB used: 1.54
> GiB (4.9%) Init: systemd
>    Shell: Bash inxi: 3.3.27

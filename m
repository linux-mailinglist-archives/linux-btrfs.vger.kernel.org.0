Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5393B285E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2019 20:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbfEWS27 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 May 2019 14:28:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:59075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731107AbfEWS27 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 May 2019 14:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558636136;
        bh=oHTma6PhGFIgdj7CAt9cvcGAJw571ECwEiCeM39TRh8=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=kp044XLJV9KpaunInGyV5MXuUyRQmlP3wMs0o9F6aGI6L7Ub8DWX4qZb3O3yi9XDv
         vvwL1lUh2jnTjJcxWg1mC+dqiB1Tx85xQz/TPDJ7xltt/2FPwex6rImQ1z1rngEuNg
         018jaT2geKJyE34Pp4aw+hLVsyPHTuJPX/6oXbDI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.24] ([77.10.35.125]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQMuR-1hGu1B1juL-00MLiL for
 <linux-btrfs@vger.kernel.org>; Thu, 23 May 2019 20:28:56 +0200
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=toralf.foerster@gmx.de; prefer-encrypt=mutual; keydata=
 xsPuBFKhflgRDADrUSTZ9WJm+pL686syYr9SrBnaqul7zWKSq8XypEq0RNds0nEtAyON96pD
 xuMj26LNztqsEA0sB69PQq4yHno0TxA5+Fe3ulrDxAGBftSPgo/rpVKB//d6B8J8heyBlbiV
 y1TpPrOh3BEWzfqw6MyRwzxnRq6LlrRpiCRa/qAuxJXZ9HTEOVcLbeA6EdvLEBscz5Ksj/eH
 9Q3U97jr26sjFROwJ8YVUg+JKzmjQfvGmVOChmZqDb8WZJIE7yV6lJaPmuO4zXJxPyB3Ip6J
 iXor1vyBZYeTcf1eiMYAkaW0xRMYslZzV5RpUnwDIIXs4vLKt9W9/vzFS0Aevp8ysLEXnjjm
 e88iTtN5/wgVoRugh7hG8maZCdy3ArZ8SfjxSDNVsSdeisYQ3Tb4jRMlOr6KGwTUgQT2exyC
 2noq9DcBX0itNlX2MaLL/pPdrgUVz+Oui3Q4mCNC8EprhPz+Pj2Jw0TwAauZqlb1IdxfG5fD
 tFmV8VvG3BAE2zeGTS8sJycBAI+waDPhP5OptN8EyPGoLc6IwzHb9FsDa5qpwLpRiRcjDADb
 oBfXDt8vmH6Dg0oUYpqYyiXx7PmS/1z2WNLV+/+onAWV28tmFXd1YzYXlt1+koX57k7kMQbR
 rggc0C5erweKl/frKgCbBcLw+XjMuYk3KbMqb/wgwy74+V4Fd59k0ig7TrAfKnUFu1w40LHh
 RoSFKeNso114zi/oia8W3Rtr3H2u177A8PC/A5N34PHjGzQz11dUiJfFvQAi0tXO+WZkNj3V
 DSSSVYZdffGMGC+pu4YOypz6a+GjfFff3ruV5XGzF3ws2CiPPXWN7CDQK54ZEh2dDsAeskRu
 kE/olD2g5vVLtS8fpsM2rYkuDjiLHA6nBYtNECWwDB0ChH+Q6cIJNfp9puDxhWpUEpcLxKc+
 pD4meP1EPd6qNvIdbMLTlPZ190uhXYwWtO8JTCw5pLkpvRjYODCyCgk0ZQyTgrTUKOi/qaBn
 ChV2x7Wk5Uv5Kf9DRf1v5YzonO8GHbFfVInJmA7vxCN3a4D9pXPCSFjNEb6fjVhqqNxN8XZE
 GfpKPBMMAIKNhcutwFR7VMqtB0YnhwWBij0Nrmv22+yXzPGsGoQ0QzJ/FfXBZmgorA3V0liL
 9MGbGMwOovMAc56Zh9WfqRM8gvsItEZK8e0voSiG3P/9OitaSe8bCZ3ZjDSWm5zEC2ZOc1Pw
 VO1pOVgrTGY0bZ+xaI9Dx1WdiSCm1eL4BPcJbaXSNjRza2KFokKj+zpSmG5E36Kdn13VJxhV
 lWySzJ0x6s4eGVu8hDT4pkNpQUJXjzjSSGBy5SIwX+fNkDiXEuLLj2wlV23oUfCrMdTIyXu9
 Adn9ECc+vciNsCuSrYH4ut7gX0Rfh89OJj7bKLmSeJq2UdlU3IYmaBHqTmeXg84tYB2gLXaI
 MrEpMzvGxuxPpATNLhgBKf70QeJr8Wo8E0lMufX7ShKbBZyeMdFY5L3HBt0I7e4ev+FoLMzc
 FA9RuY9q5miLe9GJb7dyb/R89JNWNSG4tUCYcwxSkijaprBOsoMKK4Yfsz9RuNfYCn1HNykW
 1aC2Luct4lcLPtg44M01VG9yYWxmIEbDtnJzdGVyIChteSAybmQga2V5KSA8dG9yYWxmLmZv
 ZXJzdGVyQGdteC5kZT7CgQQTEQgAKQUCUqF+WAIbIwUJEswDAAcLCQgHAwIBBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEMTqzd4AdulO06EBAIBfWzAIRkMwpCEhY4ZHexa4Ge8C/ql/sBiW8+na
 FxbZAP9z0OgF2zcorcfdttWw0aolhmUBlOf14FWXYDEkHKrmlc7DTQRSoX5YEBAA2tKn0qf0
 kVKRPxCs8AledIwNuVcTplm9MQ+KOZBomOQz8PKru8WXXstQ6RA43zg2Q2WU//ly1sG9WwJN
 Mzbo5d+8+KqgBD0zKKM+sfTLi1zIH3QmeplEHzyv2gN6fe8CuIhCsVhTNTFgaBTXm/aEUvTI
 zn7DIhatKmtGYjSmIwRKP8KuUDF/vQ1UQUvKVJX3/Z0bBXFY8VF/2qYXZRdj+Hm8mhRtmopQ
 oTHTWd+vaT7WqTnvHqKzTPIm++GxjoWjchhtFTfYZDkkF1ETc18YXXT1aipZCI3BvZRCP4HT
 hiAC5Y0aITZKfHtrjKt13sg7KTw4rpCcNgo67IQmyPBOsu2+ddEUqWDrem/zcFYQ360dzBfY
 tJx2oSspVZ4g8pFrvCccdShx3DyVshZWkwHAsxMUES+Bs2LLgFTcGUlD4Z5O9AyjRR8FTndU
 7Xo9M+sz3jsiccDYYlieSDD0Yx8dJZzAadFRTjBFHBDA7af1IWnGA6JY07ohnH8XzmRNbVFB
 /8E6AmFA6VpYG/SY02LAD9YGFdFRlEnN7xIDsLFbbiyvMY4LbjB91yBdPtaNQokYqA+uVFwO
 inHaLQVOfDo1JDwkXtqaSSUuWJyLkwTzqABNpBszw9jcpdXwwxXJMY6xLT0jiP8TxNU8EbjM
 TeC+CYMHaJoMmArKJ8VmTerMZFsAAwUQAJ3vhEE+6s+wreHpqh/NQPWL6Ua5losTCVxY1snB
 3WXF6y9Qo6lWducVhDGNHjRRRJZihVHdqsXt8ZHz8zPjnusB+Fp6xxO7JUy3SvBWHbbBuheS
 fxxEPaRnWXEygI2JchSOKSJ8Dfeeu4H1bySt15uo4ryAJnZ+jPntwhncClxUJUYVMCOdk1PG
 j0FvWeCZFcQ+bapiZYNtju6BEs9OI73g9tiiioV1VTyuupnE+C/KTCpeI5wAN9s6PJ9LfYcl
 jOiTn+037ybQZROv8hVJ53jZafyvYJ/qTUnfDhkClv3SqskDtJGJ84BPKK5h3/U3y06lWFoi
 wrE22plnEUQDIjKWBHutns0qTF+HtdGpGo79xAlIqMXPafJhLS4zukeCvFDPW2PV3A3RKU7C
 /CbgGj/KsF6iPQXYkfF/0oexgP9W9BDSMdAFhbc92YbwNIctBp2Trh2ZEkioeU0ZMJqmqD3Z
 De/N0S87CA34PYmVuTRt/HFSx9KA4bAWJjTuq2jwJNcQVXTrbUhy2Et9rhzBylFrA3nuZHWf
 4Li6vBHn0bLP/8hos1GANVRMHudJ1x3hN68TXU8gxpjBkZkAUJwt0XThgIA3O8CiwEGs6aam
 oxxAJrASyu6cKI8VznuhPOQ9XdeAAXBg5F0hH/pQ532qH7zL9Z4lZ+DKHIp4AREawXNxwmYE
 GBEIAA8FAlKhflgCGwwFCRLMAwAACgkQxOrN3gB26U7PNwEAg6z1II04TFWGV6m8lR/0ZsDO
 15C9fRjklQTFemdCJugA+PvUpIsYgyqSb3OVodAWn4rnnVxPCHgDsANrWVgTO3w=
Subject: BTRFS tells after unmount "Device or resource busy"
Message-ID: <ca047e78-0ad1-90cc-3d30-1a1ea1ebb944@gmx.de>
Date:   Thu, 23 May 2019 20:28:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xmaz2KYIvNDO5XVz5MrqkUK/9MyAY28yjdgRdvWDCAkbBp1lRTI
 uaRMT7uG+S+Xqdh+p2OTTwg6KfZDejuwc0zVwJhmXhreH74pFvEU/IOHptaG3CdnNkQnVsu
 EXeiLsfR2N7sw32GfD5fVe8cz7Wbm3vk3W8FxEkGkhRr2yl3dpZyyoI6etDfDSlOHbRQetg
 bmCkRVuPgkV9PN0ANfg0w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DIoAscJY+D0=:EGgkaotGJBbN6yaFrkZA/p
 gQdbAzpsWMHbo3lXEow7w8vV9MqjSsqV+yV/ZVveZ5yUIOrfSh41BS3WWb22WVrsIGJlcZtLp
 BKo29Kk6IuEcn8RLS7WchrseQuMh4SeaqZmssE08DmXtdqX2rZyS12wXvDMwL/QpBUg6GhjfH
 kQHFjwA/Eqq+5XMDGExr8CxI+1HFOhR/0D5UtH/KWBYfYKOk7Biw6tcdURQGm7NaRS+cDy0KM
 6i6Jovwu1d1akoIX3HD0xJzcsVTTrcUrxcOMYexCI2YK3T9Sr1FkZhFhuVZbzx+uwLyXXCIYZ
 UIa04yI4sZoq7kAsI3P00rf9EhMlND1zT5XgjXYfdfDzbHDg5e7Dt1hzJ0UyJ9muU9hW/aOr0
 /2wBEhLQc1ULKf4rQD+Knocab/BBwjQqPwg0cexRRpAROiA5T4XPzxnPXL+psr1KmSqO5aSwc
 1U7//g+v/6RpVir8INksX2X3lbBjoxzuNj5tw1fvIQKh/CC4pF1x0nSSdUwKtaytIwyhpZMmF
 gSffkEhSk/2A/WfqTV1sbp/teVuDh1uiuJYjrJHc70nyAbyAi899vR133h7WMq+BmqmPlIe+7
 EoiCOGBOj2s9GEeFXe82tnnpWT2TNN+I/uJORaOMjJAeM9xYLJZhONcjVyiGj1EYbRhP1CpA2
 F9n/rLmE/RFG7wfZeu+QBV+BPLAhSbmq3aCxrBv7VERwRM7MIYnwviJINe2tsrYOsDMQmtpC9
 RuR+MnV+f83NBOV1qSxOJp2OxIMGTmbOLe8B3+vBW1NiN2cdFXNqrZt8b6bSdQbko9olTyH1b
 A4uXTch5Q68J16ykCYTFqKz5HfSPFvWjYVuU/eZz5jrNF+rWBrwqmWqI2CKoDQPzGdLJ2Z3DW
 NM2qNQw6UfO7CM0sT1057nnEyANOnuVWOIYGoemNO3t0WDkIXWsp63funyhe1Bz43Fab9stW/
 5w8ZnEdnd+WjUvylXirw7EOdulQMJOvWy9mmPQptyeAiSG13XUZmj
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

At a stable hardened Gentoo Linux server (kernel 5.1, same for 4.19) I do =
have 2 BTRFS file systems, ./img1 and ./img2. I do write data to either of=
 it for about 1 month, then I do switch the symlink ./img from ./img1 to .=
/img2 or vice versa.

	# grep img /etc/fstab
	/dev/vg0/lvol0  /home/tinderbox/img1    btrfs           auto,noatime    0=
 0
	/dev/vg0/lvol1  /home/tinderbox/img2    btrfs           auto,noatime    0=
 0

	# vgs
	  VG  #PV #LV #SN Attr   VSize  VFree
	  vg0   2   3   0 wz--n- <3.58t    0

	# pvs
	  PV         VG  Fmt  Attr PSize  PFree
	  /dev/sda5  vg0 lvm2 a--  <1.76t    0
	  /dev/sdb1  vg0 lvm2 a--  <1.82t    0

	# lvs
	  LV    VG  Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Syn=
c Convert
	  lvol0 vg0 -wi-ao----   1.56t
	  lvol1 vg0 -wi-ao----   1.56t
	  lvol2 vg0 -wi-ao---- 461.02g


FWIW I do prefer "mkfs" over "rm -rf" due to the large size of the FS (1.6=
 TB). But I run regularly into this problem:


# mount /home/tinderbox/img1

# umount /home/tinderbox/img1

# btrfs check -p /dev/vg0/lvol0
Opening filesystem to check...
ERROR: cannot open device '/dev/vg0/lvol0': Device or resource busy
ERROR: cannot open file system

# mkfs.btrfs -f /dev/mapper/vg0-lvol0
btrfs-progs v5.1
See http://btrfs.wiki.kernel.org for more information.

ERROR: unable to open /dev/mapper/vg0-lvol0: Device or resource busy


A reboot helps, but after 1 or 2 days or so I run into the same situation =
even if I do not write files to it. I rebooted the system 24 hours ago and=
 wrote not into ./img1, but do still suffer from the situation above. Neit=
her lsof nor fuser show anything suspicious althought I do not understand =
the fuser output after the unmount:

	# mount /home/tinderbox/img1

	# df -h /home/tinderbox/img1
	Filesystem             Size  Used Avail Use% Mounted on
	/dev/mapper/vg0-lvol0  1.6T  1.4T  166G  90% /home/tinderbox/img1

	# fuser -mv /home/tinderbox/img1
        	             USER        PID ACCESS COMMAND
	/home/tinderbox/img1:
        	             root     kernel mount /home/tinderbox/img1

	# umount /home/tinderbox/img1

	# fuser -mv /home/tinderbox/img1
                     USER        PID ACCESS COMMAND
/home/tinderbox/img1:
                     root     kernel mount /
                     root          1 .rce. init
                     root          2 .rc.. kthreadd
                     root          3 .rc.. rcu_gp
                     root          4 .rc.. rcu_par_gp
                     root          6 .rc.. kworker/0:0H-kbl
                     root          8 .rc.. mm_percpu_wq
                     root          9 .rc.. ksoftirqd/0
                     root         10 .rc.. rcu_sched
                     root         11 .rc.. migration/0
                     root         12 .rc.. cpuhp/0
                     root         13 .rc.. cpuhp/1
                     root         14 .rc.. migration/1
                     root         15 .rc.. ksoftirqd/1
                     root         17 .rc.. kworker/1:0H-kbl
                     root         18 .rc.. cpuhp/2
                     root         19 .rc.. migration/2
                     root         20 .rc.. ksoftirqd/2
                     root         22 .rc.. kworker/2:0H-kbl
                     root         23 .rc.. cpuhp/3
                     root         24 .rc.. migration/3
                     root         25 .rc.. ksoftirqd/3
                     root         27 .rc.. kworker/3:0H-kbl
                     root         28 .rc.. cpuhp/4
                     root         29 .rc.. migration/4
                     root         30 .rc.. ksoftirqd/4
                     root         32 .rc.. kworker/4:0H-kbl
                     root         33 .rc.. cpuhp/5
                     root         34 .rc.. migration/5
                     root         35 .rc.. ksoftirqd/5
                     root         37 .rc.. kworker/5:0H-kbl
                     root         38 .rc.. cpuhp/6
                     root         39 .rc.. migration/6
                     root         40 .rc.. ksoftirqd/6
                     root         42 .rc.. kworker/6:0H-kbl
                     root         43 .rc.. cpuhp/7
                     root         44 .rc.. migration/7
                     root         45 .rc.. ksoftirqd/7
                     root         47 .rc.. kworker/7:0H-kbl
                     root         48 .rc.. cpuhp/8
                     root         49 .rc.. migration/8
                     root         50 .rc.. ksoftirqd/8
                     root         52 .rc.. kworker/8:0H-kbl
                     root         53 .rc.. cpuhp/9
                     root         54 .rc.. migration/9
                     root         55 .rc.. ksoftirqd/9
                     root         57 .rc.. kworker/9:0H-kbl
                     root         58 .rc.. cpuhp/10
                     root         59 .rc.. migration/10
                     root         60 .rc.. ksoftirqd/10
                     root         62 .rc.. kworker/10:0H-kb
                     root         63 .rc.. cpuhp/11
                     root         64 .rc.. migration/11
                     root         65 .rc.. ksoftirqd/11
                     root         67 .rc.. kworker/11:0H-kb
                     root         69 .rc.. netns
                     root         72 .rc.. oom_reaper
                     root         73 .rc.. writeback
                     root         74 .rc.. kcompactd0
                     root         75 .rc.. khugepaged
                     root         76 .rc.. crypto
                     root         77 .rc.. kintegrityd
                     root         78 .rc.. kblockd
                     root         81 .rc.. edac-poller
                     root         87 .rc.. kswapd0
                     root        114 .rc.. kthrotld
                     root        115 .rc.. irq/25-aerdrv
                     root        116 .rc.. irq/27-aerdrv
                     root        121 .rc.. acpi_thermal_pm
                     root        122 .rc.. scsi_eh_0
                     root        123 .rc.. scsi_tmf_0
                     root        124 .rc.. scsi_eh_1
                     root        125 .rc.. scsi_tmf_1
                     root        126 .rc.. scsi_eh_2
                     root        127 .rc.. scsi_tmf_2
                     root        128 .rc.. scsi_eh_3
                     root        129 .rc.. scsi_tmf_3
                     root        130 .rc.. scsi_eh_4
                     root        131 .rc.. scsi_tmf_4
                     root        132 .rc.. scsi_eh_5
                     root        133 .rc.. scsi_tmf_5
                     root        140 .rc.. ipv6_addrconf
                     root        168 .rc.. jbd2/sda4-8
                     root        169 .rc.. ext4-rsv-conver
                     root        173 .rc.. kworker/6:1H-eve
                     root        613 .rce. udevd
                     root        738 .rc.. kworker/9:1H-eve
                     root        742 .rc.. kworker/8:1H-kbl
                     root        758 .rc.. kworker/10:1H-ev
                     root        768 .rc.. kdmflush
                     root        770 .rc.. kdmflush
                     root        771 .rc.. kdmflush
                     root        858 .rc.. kworker/3:1-even
                     root        885 .rc.. kdmflush
                     root        886 .rc.. kcryptd_io/254:
                     root        887 .rc.. kcryptd/254:3
                     root        888 .rc.. dmcrypt_write/2
                     root        897 .rc.. kworker/0:1H-kbl
                     root        932 .rce. lvmetad
                     root       1011 .rc.. kworker/5:1H-eve
                     root       1042 .rc.. kworker/u24:9-bt
                     root       1046 .rc.. kworker/4:1H-eve
                     root       1047 .rc.. kworker/2:1H-eve
                     root       1110 frce. watch.sh
                     root       1111 frce. watch.sh
                     root       1112 frce. watch.sh
                     root       1113 frce. watch.sh
                     root       1114 frce. watch.sh
                     root       1115 .rce. tail
                     root       1116 .rce. grep
                     root       1117 .rce. watch.sh
                     root       1118 frce. tail
                     root       1119 frce. tail
                     root       1120 .rce. grep
                     root       1121 .rce. grep
                     root       1122 .rce. watch.sh
                     root       1123 .rce. tail
                     root       1124 .rce. grep
                     root       1125 .rce. watch.sh
                     root       1126 .rce. watch.sh
                     root       1127 frce. tail
                     root       1128 .rce. grep
                     root       1129 .rce. watch.sh
                     root       1154 .rc.. btrfs-worker
                     root       1155 .rc.. btrfs-worker-hi
                     root       1156 .rc.. btrfs-delalloc
                     root       1157 .rc.. btrfs-flush_del
                     root       1158 .rc.. btrfs-cache
                     root       1159 .rc.. btrfs-submit
                     root       1160 .rc.. btrfs-fixup
                     root       1161 .rc.. btrfs-endio
                     root       1162 .rc.. btrfs-endio-met
                     root       1163 .rc.. btrfs-endio-met
                     root       1164 .rc.. btrfs-endio-rai
                     root       1165 .rc.. btrfs-endio-rep
                     root       1166 .rc.. btrfs-rmw
                     root       1167 .rc.. btrfs-endio-wri
                     root       1168 .rc.. btrfs-freespace
                     root       1169 .rc.. btrfs-delayed-m
                     root       1170 .rc.. btrfs-readahead
                     root       1171 .rc.. btrfs-qgroup-re
                     root       1172 .rc.. btrfs-extent-re
                     root       1173 .rc.. btrfs-cleaner
                     root       1174 .rc.. btrfs-transacti
                     root       1175 .rc.. btrfs-worker
                     root       1176 .rc.. btrfs-worker-hi
                     root       1178 .rc.. btrfs-delalloc
                     root       1179 .rc.. btrfs-flush_del
                     root       1180 .rc.. btrfs-cache
                     root       1181 .rc.. btrfs-submit
                     root       1182 .rc.. btrfs-fixup
                     root       1183 .rc.. btrfs-endio
                     root       1184 .rc.. btrfs-endio-met
                     root       1185 .rc.. btrfs-endio-met
                     root       1186 .rc.. btrfs-endio-rai
                     root       1187 .rc.. btrfs-endio-rep
                     root       1188 .rc.. btrfs-rmw
                     root       1189 .rc.. btrfs-endio-wri
                     root       1190 .rc.. btrfs-freespace
                     root       1191 .rc.. btrfs-delayed-m
                     root       1192 .rc.. btrfs-readahead
                     root       1193 .rc.. btrfs-qgroup-re
                     root       1194 .rc.. btrfs-extent-re
                     root       1195 .rc.. btrfs-cleaner
                     root       1196 .rc.. btrfs-transacti
                     root       1198 .rc.. btrfs-worker
                     root       1199 .rc.. btrfs-worker-hi
                     root       1200 .rc.. btrfs-delalloc
                     root       1201 .rc.. btrfs-flush_del
                     root       1202 .rc.. btrfs-cache
                     root       1203 .rc.. btrfs-submit
                     root       1204 .rc.. btrfs-fixup
                     root       1205 .rc.. btrfs-endio
                     root       1206 .rc.. btrfs-endio-met
                     root       1207 .rc.. btrfs-endio-met
                     root       1208 .rc.. btrfs-endio-rai
                     root       1209 .rc.. btrfs-endio-rep
                     root       1210 .rc.. btrfs-rmw
                     root       1211 .rc.. btrfs-endio-wri
                     root       1212 .rc.. btrfs-freespace
                     root       1213 .rc.. btrfs-delayed-m
                     root       1214 .rc.. btrfs-readahead
                     root       1215 .rc.. btrfs-qgroup-re
                     root       1216 .rc.. btrfs-extent-re
                     root       1217 .rc.. btrfs-cleaner
                     root       1218 .rc.. btrfs-transacti
                     root       1515 .rc.. kworker/3:1H-kbl
                     root       1590 .rce. syslog-ng
                     root       1591 Fr.e. syslog-ng
                     root       1625 .rce. acpid
                     at         1653 .rce. atd
                     root       1743 .rce. timer_entropyd
                     root       2024 .rc.. kworker/1:1H-kbl
                     dnsmasq    2064 .rce. dnsmasq
                     root       2124 .rce. crond
                     root       2153 .rce. crond
                     root       2156 .rce. haveged
                     root       2167 frce. catch_load.sh
                     root       2228 .rce. ntpd
                     root       2258 .rce. rngd
                     root       2293 .rce. smartd
                     root       2325 .rce. sshd
                     root       2430 frce. restart_service
                     root       2431 frce. restart_service
                     root       2432 frce. restart_service
                     root       2507 .rce. agetty
                     root       2508 .rce. agetty
                     root       2509 .rce. agetty
                     root       2510 .rce. agetty
                     root       2511 .rce. agetty
                     root       2512 .rce. agetty
                     root       2666 .rc.. kworker/7:1H-kbl
                     root       2804 .rc.. kworker/11:1H-kb
                     root       2912 Frce. sudo
                     root       2915 Frce. chr.sh
                     root       2973 F.... su
                     root       3022 Frce. sudo
                     root       3025 Frce. chr.sh
                     root       3047 F.... bash
                     root       3071 F.... su
                     root       3074 Frce. sudo
                     root       3077 Frce. chr.sh
                     root       3124 F.... su
                     root       3127 Frce. sudo
                     root       3130 Frce. chr.sh
                     root       3164 Frce. sudo
                     root       3167 Frce. chr.sh
                     root       3183 F.... su
                     root       3192 F.... bash
                     root       3236 F.... su
                     root       3238 Frce. sudo
                     root       3241 Frce. chr.sh
                     root       3261 F.... bash
                     root       3286 F.... su
                     root       3289 Frce. sudo
                     root       3292 Frce. chr.sh
                     tinderbox   3315 frce. logcheck.sh
                     root       3323 F.... bash
                     root       3336 F.... su
                     root       3339 F.... bash
                     root       3373 F.... bash
                     root       3387 F.... bash
                     root       3959 .rc.. kworker/4:0
                     root       4307 Frce. sudo
                     root       4310 Frce. chr.sh
                     root       4905 F.... su
                     root       4906 F.... bash
                     root       4994 .rc.. kworker/u25:0-bt
                     root       5069 .rc.. kworker/9:0-even
                     tor        6675 Frce. tor
                     root       7714 .rc.. kworker/10:1-mm_
                     root       7802 .rc.. kworker/0:0-even
                     root       8348 .rc.. kworker/11:1-eve
                     root       8375 .rc.. kworker/11:3-eve
                     root       8879 .rc.. kworker/u24:2-bt
                     root       8905 .rc.. kworker/3:0-even
                     root       9188 .rc.. kworker/5:1-mm_p
                     root       9403 .rc.. kworker/2:2-cgro
                     root       9851 .rc.. kworker/11:2-rcu
                     root      10023 .rc.. kworker/7:2-even
                     root      11092 .rc.. kworker/u24:4-bt
                     root      11103 Frce. sudo
                     root      11108 Frce. chr.sh
                     root      11283 .rc.. kworker/10:2-eve
                     root      11483 F.... su
                     root      11485 F.... bash
                     root      11730 .rce. sshd
                     tfoerste  11805 .rce. sshd
                     tfoerste  11829 .rce. bash
                     root      11898 .rc.. kworker/4:1-cgro
                     root      11941 .rc.. kworker/u24:7-bt
                     root      11960 .rc.. kworker/u24:8-bt
                     root      12026 .rc.. kworker/6:2-even
                     root      12079 .rce. sudo
                     root      12081 .rce. su
                     root      12083 .rce. bash
                     root      12337 .rc.. kworker/u25:1-bt
                     root      13106 .rc.. kworker/5:0
                     root      13568 .rc.. kworker/u24:11-b
                     root      13991 .rc.. kworker/3:3-mm_p
                     root      15022 .rc.. kworker/5:2-even
                     root      15087 .rc.. kworker/2:0-mm_p
                     root      15283 .rc.. kworker/2:1-cgro
                     root      15939 .rc.. kworker/10:0-eve
                     root      16963 .rce. sleep
                     root      17018 .rc.. kworker/7:3-mm_p
                     root      17139 .rc.. kworker/4:3-cgro
                     root      17147 .rce. sleep
                     root      17177 .rc.. kworker/0:1-cgro
                     root      17423 .rc.. kworker/8:0-mm_p
                     root      17644 .rc.. kworker/0:2-cgro
                     root      17802 .rce. sleep
                     root      18468 .rc.. kworker/10:3-cgr
                     root      18869 .rce. sleep
                     tinderbox  19031 .rce. sleep
                     root      19062 .rc.. kworker/6:0-mm_p
                     root      20813 .rc.. kworker/7:1-rcu_
                     root      20932 .rc.. kworker/u24:0-bt
                     root      21045 .rc.. kworker/11:0-mm_
                     root      21178 .rc.. kworker/8:2-cgro
                     root      21441 .rc.. kworker/9:1-cgro
                     root      22857 .rc.. kworker/1:3-even
                     root      23358 .rc.. kworker/u24:1-ev
                     root      23359 .rc.. kworker/u24:3-bt
                     root      23821 .rc.. kworker/1:2-rcu_
                     root      23854 .rc.. kworker/8:1-even
                     root      26148 .rc.. kworker/7:0-even
                     root      26178 .rc.. kworker/5:4-even
                     root      28450 .rc.. kworker/3:2-even
                     root      28571 .rc.. kworker/9:3-even
                     root      28640 .rc.. kworker/6:1
                     tor       29097 Frce. tor
                     root      31539 .rc.. kworker/0:3-even
                     root      31954 .rc.. kworker/8:3
                     root      32727 .rc.. kworker/1:1+even

=2D-
Toralf
PGP C4EACDDE 0076E94E


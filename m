Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48417130852
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 14:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgAENki (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 08:40:38 -0500
Received: from ms11p00im-qufo17281801.me.com ([17.58.38.55]:52864 "EHLO
        ms11p00im-qufo17281801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726192AbgAENki (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Jan 2020 08:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1578231634;
        bh=QwxZZnh29wAwwjH7MsU+JD/xDDdh528Hdm9ASbG0FfY=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=RoD59C6sZofG/GPM0p3XFGoN01j7lewhVEPX8bVEhHvjbr8RqJzfbEcZxI0XoqNUi
         +qPGmrAxHP+Ft21gSRp8Bf5Ff36s2dX0ZeMKYlf/MF1fem2dOVdp7U+y55fe+dNQKC
         kWkBvcz5u1B3GbThIJMEkMOwIOmT6AfXUS4iU4mKfHp7WVAlVf6cgUIiZe41lFGPei
         U4CxQ+d7cbNCRVzMhVDUF61XQu+yywuPh+yIxGhPgUxuhVTnMVyX0HYIyBV6VvbnnG
         cZ6JzWhwP0SHG2xQRlF6hEON9Kt/iFblvfUGmljQ0TTDUHtkiGIsilhlhV/t0s3xrX
         rab9MTVl4vqPw==
Received: from [192.168.15.23] (unknown [177.76.36.47])
        by ms11p00im-qufo17281801.me.com (Postfix) with ESMTPSA id 9EB271009A5;
        Sun,  5 Jan 2020 13:40:33 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: 12 TB btrfs file system on virtual machine broke again
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <CAJCQCtQmvHS8+Z7=B_8panSzo=Bfo0ymVU+cr_tR5z1uw+Ejug@mail.gmail.com>
Date:   Sun, 5 Jan 2020 10:40:29 -0300
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE5FDD33-F072-40EE-9ED7-66D5F7F2A5FA@icloud.com>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com>
 <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <CAJCQCtQmvHS8+Z7=B_8panSzo=Bfo0ymVU+cr_tR5z1uw+Ejug@mail.gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-05_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2001050128
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Chris,



> On 5. Jan 2020, at 01:03, Chris Murphy <lists@colorremedies.com> =
wrote:
>=20
> On Sat, Jan 4, 2020 at 10:07 AM Christian Wimmer
> <telefonchris@icloud.com> wrote:
>>=20
>> Hi guys,
>>=20
>> I run again in a problem with my btrfs files system.
>> I start wondering if this filesystem type is right for my needs.
>> Could you please help me in recovering my 12TB partition?
>=20
> If you're having recurring problems, there's a decent chance it's
> hardware related and not Btrfs, because Btrfs is pretty stable on
> stable hardware. Btrfs is actually fussier than other file systems
> because everything is checksummed.
>=20

I think I can exclude hardware problems. Everything is brand new and =
well tested.
The biggest chance for being the source of errors is the Parallels =
Virtual machine where Linux (Suse 15.1) is running in.
In this Virtual Machine I specify a =E2=80=9Cgrowing hard disc" that is =
actually a file on my 32 TB Promise Pegasus Storage.
I just can not understand why it runs fine for almost 1 month (and =
actually more for other growing hard discs of smaller size) and then =
shows this behaviour.
As soon as you =E2=80=9Care sure" that btrfs is not the problem I will =
switch to different kind of hard discs.


>=20
>> What happened?
>> -> This time I was just rebooting normally my virtual machine. I =
discovered during the past days that the system hangs for some seconds =
so I thought it would be a good idea to reboot my SUSE Linux after 14 =
days of working. The machine powered off normally but when starting it =
run into messages like the pasted ones.
>=20
> A complete dmesg leading up to the problem would be useful. Kernel
> messages at the last moments it was working, and also messages for the
> first mount attempt that failed. And kernel versions for both (sounds
> like 5.4 series).

I have one System with Suse 15.1 where the error happened. The =
btrfs-progs is of version 4.19.1.
The other system is 5.3.12-1-MANJARO with btrfs-progs version 5.4. Here =
I try to repair the broken file system.

>=20
> And also `btrfs check` output, no repair.

Here the output:

btrfs-progs-5.4]# ./btrfs check /dev/sdb1
Opening filesystem to check...
checksum verify failed on 3181912915968 found 000000A9 wanted 00000064
checksum verify failed on 3181912915968 found 00000071 wanted 00000066
checksum verify failed on 3181912915968 found 000000A9 wanted 00000064
bad tree block 3181912915968, bytenr mismatch, want=3D3181912915968, =
have=3D4908658797358025935
checksum verify failed on 2688623902720 found 00000029 wanted 00000026
checksum verify failed on 2688623902720 found 000000E4 wanted 0000006F
checksum verify failed on 2688623902720 found 00000029 wanted 00000026
bad tree block 2688623902720, bytenr mismatch, want=3D2688623902720, =
have=3D256465382155451
ERROR: failed to read block groups: Input/output error
ERROR: cannot open file system
btrfs-progs-5.4]#=20


Chris


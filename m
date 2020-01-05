Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD530130864
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 15:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgAEORY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 09:17:24 -0500
Received: from ms11p00im-qufo17281501.me.com ([17.58.38.52]:37671 "EHLO
        ms11p00im-qufo17281501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726188AbgAEORY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Jan 2020 09:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1578233841;
        bh=gmGhzsXehFGOXNqH6HoRUse9yqFy5IoC8msbht1wvRg=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=xLxy8a76DtmytqrpeoT4lT4ItfVf+m/lGAUT0Uo1pBV8xmuc5aVl+AXWfnL9oT5xu
         qLCGo1NKX/RB4NNKh90GS3OFICD9fNV33C2qKcPiLJJ2I6Oi2fp+CZ2C9CpWh94N/E
         C/SLxlCPvI1d6JO2D40fjI+T1d0zxgIkkxNopwgy702UhU+CxPRYs2kj+pKUcsQ5op
         tFkLv/Qy/+1q+ZLS6EDOxzlPqfb1+m8n9dWKIHDKJuNcATu55ij8dYxQ6+7F0ikB2l
         RJRH35xbLRUlVUYWjyQEBiU22Ze+ZnSuP77gnyJHwAm1B03c3Ebk6QcYTq7ZKp2PNx
         0qXoDeicKANsA==
Received: from [192.168.15.23] (unknown [177.76.36.47])
        by ms11p00im-qufo17281501.me.com (Postfix) with ESMTPSA id 91D37B406B0;
        Sun,  5 Jan 2020 14:17:20 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: 12 TB btrfs file system on virtual machine broke again
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com>
Date:   Sun, 5 Jan 2020 11:17:18 -0300
Cc:     Qu WenRuo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com>
 <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2001050134
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,


> On 5. Jan 2020, at 01:25, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
>=20
>=20
> On 2020/1/5 =E4=B8=8A=E5=8D=881:07, Christian Wimmer wrote:
>> Hi guys,=20
>>=20
>> I run again in a problem with my btrfs files system.
>> I start wondering if this filesystem type is right for my needs.
>> Could you please help me in recovering my 12TB partition?
>>=20
>> What happened?=20
>> -> This time I was just rebooting normally my virtual machine. I =
discovered during the past days that the system hangs for some seconds =
so I thought it would be a good idea to reboot my SUSE Linux after 14 =
days of working. The machine powered off normally but when starting it =
run into messages like the pasted ones.
>>=20
>> I immediately powered off again and started my Arch Linux where I =
have btrfs-progs version 5.4 installed.
>> I tried one of the commands that you gave me in the past (restore) =
and I got following messages:
>>=20
>>=20
>> btrfs-progs-5.4]# ./btrfs restore -l /dev/sdb1
>> checksum verify failed on 3181912915968 found 000000A9 wanted =
00000064
>> checksum verify failed on 3181912915968 found 00000071 wanted =
00000066
>> checksum verify failed on 3181912915968 found 000000A9 wanted =
00000064
>> bad tree block 3181912915968, bytenr mismatch, want=3D3181912915968, =
have=3D4908658797358025935
>=20
> All these tree blocks are garbage. This doesn't look good at all.
>=20
> The weird found csum pattern make no sense at all.
>=20
> Are you using fstrim or discard mount option? If so, there could be =
some
> old bug causing the problem.


Seems that I am using fstrim (I did not know this, what is it?):

BTW, sda2 is here my root partition which is practically the same =
configuration (just smaller) than the 12TB hard disc

2020-01-03T11:30:47.479028-03:00 linux-ze6w kernel: [1297857.324177] =
sda2: rw=3D2051, want=3D532656128, limit=3D419430400
2020-01-03T11:30:47.479538-03:00 linux-ze6w kernel: [1297857.324658] =
BTRFS warning (device sda2): failed to trim 1 device(s), last error -5
2020-01-03T11:30:48.376543-03:00 linux-ze6w fstrim[27910]: fstrim: /opt: =
FITRIM ioctl failed: Input/output error
2020-01-03T11:30:48.378998-03:00 linux-ze6w kernel: [1297858.223675] =
attempt to access beyond end of device
2020-01-03T11:30:48.379012-03:00 linux-ze6w kernel: [1297858.223677] =
sda2: rw=3D3, want=3D421570540, limit=3D419430400
2020-01-03T11:30:48.379013-03:00 linux-ze6w kernel: [1297858.223678] =
attempt to access beyond end of device
2020-01-03T11:30:48.379013-03:00 linux-ze6w kernel: [1297858.223678] =
sda2: rw=3D3, want=3D429959147, limit=3D419430400
2020-01-03T11:30:48.379014-03:00 linux-ze6w kernel: [1297858.223679] =
attempt to access beyond end of device
2020-01-03T11:30:48.379014-03:00 linux-ze6w kernel: [1297858.223679] =
sda2: rw=3D3, want=3D438347754, limit=3D419430400
2020-01-03T11:30:48.379014-03:00 linux-ze6w kernel: [1297858.223680] =
attempt to access beyond end of device

Could this be the problem?


Suse Kernel version is 4.12.14-lp151.28.13-default #1 SMP



Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F36A6130B89
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 02:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgAFBco (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 20:32:44 -0500
Received: from ms11p00im-qufo17291301.me.com ([17.58.38.42]:58676 "EHLO
        ms11p00im-qufo17291301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727222AbgAFBco (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Jan 2020 20:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1578274363;
        bh=QlshdoLhueHCne7q6Ibt3lMqI9tgN9JyAxnNzB0BMBY=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=eMuT5Y2zmN1N3yPxlMAly1DSCEMn6JCB0ozfP21SbGDW2OH9eS8P4+W0Q+REFo0yQ
         ihIpHpLcXYyNMXmFMeNCCQyn1NVIBQGudvZRAttS8davJMXO5Gf5Cy/0DrKqI5m/S/
         1+Z2sARmdZ5r6ElJz8mNKKnGpkMyud7l3cm1WMAD7NShhQ3P3JtLVOiN8m1rqQUKR2
         ru5ImeJ2KwgJ9dUWa7M4SKsOHhstRyEk/pxkjk9y9j4D0S6zc+Vracq2ch/Yy/XQx/
         bz1/3imEVwmsoX3JfbOoX+u6+16CtxcDM9Tk6bIRJdLX3Tjc9RawO60jp/PBwetgYn
         DPJ5NGSXFM+SQ==
Received: from [192.168.15.23] (unknown [177.76.36.47])
        by ms11p00im-qufo17291301.me.com (Postfix) with ESMTPSA id 3948F100464;
        Mon,  6 Jan 2020 01:32:42 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: 12 TB btrfs file system on virtual machine broke again
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <bd42525b-5eb7-a01d-b908-938cfd61de8c@gmx.com>
Date:   Sun, 5 Jan 2020 22:32:41 -0300
Cc:     Qu WenRuo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B5EB0E99-178B-4B17-A4B0-BC151AA40998@icloud.com>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com>
 <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com>
 <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
 <bd42525b-5eb7-a01d-b908-938cfd61de8c@gmx.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2001060013
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 5. Jan 2020, at 20:50, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
>=20
>=20
> On 2020/1/5 =E4=B8=8B=E5=8D=8810:17, Christian Wimmer wrote:
>> Hi Qu,
>>=20
>>=20
>>> On 5. Jan 2020, at 01:25, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>=20
>>>=20
>>>=20
>>> On 2020/1/5 =E4=B8=8A=E5=8D=881:07, Christian Wimmer wrote:
>>>> Hi guys,=20
>>>>=20
>>>> I run again in a problem with my btrfs files system.
>>>> I start wondering if this filesystem type is right for my needs.
>>>> Could you please help me in recovering my 12TB partition?
>>>>=20
>>>> What happened?=20
>>>> -> This time I was just rebooting normally my virtual machine. I =
discovered during the past days that the system hangs for some seconds =
so I thought it would be a good idea to reboot my SUSE Linux after 14 =
days of working. The machine powered off normally but when starting it =
run into messages like the pasted ones.
>>>>=20
>>>> I immediately powered off again and started my Arch Linux where I =
have btrfs-progs version 5.4 installed.
>>>> I tried one of the commands that you gave me in the past (restore) =
and I got following messages:
>>>>=20
>>>>=20
>>>> btrfs-progs-5.4]# ./btrfs restore -l /dev/sdb1
>>>> checksum verify failed on 3181912915968 found 000000A9 wanted =
00000064
>>>> checksum verify failed on 3181912915968 found 00000071 wanted =
00000066
>>>> checksum verify failed on 3181912915968 found 000000A9 wanted =
00000064
>>>> bad tree block 3181912915968, bytenr mismatch, want=3D3181912915968, =
have=3D4908658797358025935
>>>=20
>>> All these tree blocks are garbage. This doesn't look good at all.
>>>=20
>>> The weird found csum pattern make no sense at all.
>>>=20
>>> Are you using fstrim or discard mount option? If so, there could be =
some
>>> old bug causing the problem.
>>=20
>>=20
>> Seems that I am using fstrim (I did not know this, what is it?):
>>=20
>> BTW, sda2 is here my root partition which is practically the same =
configuration (just smaller) than the 12TB hard disc
>>=20
>> 2020-01-03T11:30:47.479028-03:00 linux-ze6w kernel: [1297857.324177] =
sda2: rw=3D2051, want=3D532656128, limit=3D419430400
>> 2020-01-03T11:30:47.479538-03:00 linux-ze6w kernel: [1297857.324658] =
BTRFS warning (device sda2): failed to trim 1 device(s), last error -5
>> 2020-01-03T11:30:48.376543-03:00 linux-ze6w fstrim[27910]: fstrim: =
/opt: FITRIM ioctl failed: Input/output error
>=20
> That's the cause. The older kernel had a bug where btrfs can trim
> unrelated data, causing data loss.
>=20
> And I'm afraid that bug trimmed some of your tree blocks, screwing up
> the whole fs.
>=20
>=20
>> 2020-01-03T11:30:48.378998-03:00 linux-ze6w kernel: [1297858.223675] =
attempt to access beyond end of device
>> 2020-01-03T11:30:48.379012-03:00 linux-ze6w kernel: [1297858.223677] =
sda2: rw=3D3, want=3D421570540, limit=3D419430400
>> 2020-01-03T11:30:48.379013-03:00 linux-ze6w kernel: [1297858.223678] =
attempt to access beyond end of device
>> 2020-01-03T11:30:48.379013-03:00 linux-ze6w kernel: [1297858.223678] =
sda2: rw=3D3, want=3D429959147, limit=3D419430400
>> 2020-01-03T11:30:48.379014-03:00 linux-ze6w kernel: [1297858.223679] =
attempt to access beyond end of device
>> 2020-01-03T11:30:48.379014-03:00 linux-ze6w kernel: [1297858.223679] =
sda2: rw=3D3, want=3D438347754, limit=3D419430400
>> 2020-01-03T11:30:48.379014-03:00 linux-ze6w kernel: [1297858.223680] =
attempt to access beyond end of device
>>=20
>> Could this be the problem?
>>=20
>>=20
>> Suse Kernel version is 4.12.14-lp151.28.13-default #1 SMP
> I can't find any source tag matching your version. So I can't be 100%
> sure about the bug, but that error message still shows the same =
symptom.


As far as I remember I just downloaded Suse 15.1. Maybe I run 'zypper =
up=E2=80=99 after this once.

>=20
> I recommend to check updates about your distro.

I will check if I can update anyhow.

Chris


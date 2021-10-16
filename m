Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6E74303F4
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Oct 2021 19:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244437AbhJPRcY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Oct 2021 13:32:24 -0400
Received: from st43p00im-ztbu10073601.me.com ([17.58.63.184]:53360 "EHLO
        st43p00im-ztbu10073601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244444AbhJPRcA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Oct 2021 13:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1634405384;
        bh=+52m3SmvVqSVku0A0OuocG5YbalAmsiPRKUAytXJAt0=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=CInGT4KFOWaMcyqH//C3fcPO/m08U0aU4AAX92k1NrqCpm6tQLc5KPuAJBCOyl0jr
         ZhnxzbSd5OB9VLSZmA/JIvfsiJdABrzKU79uM0UBhwX2TwXOvE2f9sjL9Z4CfdjD34
         nK6XPwSQj7f6H/ON7vmLdx7r2VxogjVIxvovfDU3k3fvxpVVqzbf3fyZ8dL+BoFED5
         WHlA4TH6JwGTAiZ+b2itk+V6YMyLxrjQ91oNL1feAdoyH7ZamCUpdjSdnsZjhRTIKO
         Pb1uktyrjt0oygs/vizJh8096aFSCTnZz3zhJI5x5g8URQ+oQTZwYjJYxDXAtYVKqg
         NKmLfZZDibeaA==
Received: from smtpclient.apple (unknown [152.249.37.238])
        by st43p00im-ztbu10073601.me.com (Postfix) with ESMTPSA id 60FC78206D9;
        Sat, 16 Oct 2021 17:29:43 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: need help in a broken 2TB BTRFS partition
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <4d075e71-be3c-cc41-bbf4-51d255e25b2b@gmx.com>
Date:   Sat, 16 Oct 2021 14:29:40 -0300
Cc:     Qu WenRuo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <867E9DE5-055F-4385-822F-6EA83A6E8914@icloud.com>
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
 <12FE29EC-3C8F-4C33-8EF3-BD084781C459@icloud.com>
 <4d075e71-be3c-cc41-bbf4-51d255e25b2b@gmx.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-10-16=5F05:2021-10-14=5F02,2021-10-16=5F05,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2110160119
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

>>=20
>> I already run the command btrfs restore /dev/sdd1 . and could restore =
90% of the data but not the important last 10%.
>=20
> Using newer kernel like v5.14, you can using "-o ro,rescue=3Dall" =
mount
> option, which would act mostly like btrfs-restore, and you may have a
> chance to recover the lost 10%.

Very nice! I updated to 5.14 and mounted with "-o ro,rescue=3Dall=E2=80=9D=
 and yes, I can see all data now.
I guess this is just for data recovery, not a permanent mount option, =
right?
I should rescue the data and format the disc again, right?

>=20
>>=20
>> My system is:
>>=20
>> Suse Tumbleweed inside Parallels Desktop on a Mac Mini
>>=20
>> Mac Min: Big Sur
>> Parallels Desktop: 17.1.0
>> Suse: Linux Suse_Tumbleweed 5.13.2-1-default #1 SMP Thu Jul 15 =
03:36:02 UTC 2021 (89416ca) x86_64 x86_64 x86_64 GNU/Linux
>>=20
>> Suse_Tumbleweed:~ # btrfs --version
>> btrfs-progs v5.13
>>=20
>> The disk /dev/sdd1 is one of several 2TB partitions that reside on a =
NAS attached to the Mac Mini like
>=20
> /dev/sdd1 is directly mapped into the VM or something else?
>=20
> Or a file in remote filesystem (like NFS) then mapped into the VM?

It is a file on a SAS External Physical Volume that is formatted in Mac =
OS Extended and attached to the Parallels as an additional disc, then =
formatted inside linux with btrfs


BTW, I think now I know exactly what I did wrong to get to this stage.
I suspended my Virtual Machine with all discs still mounted. Then I =
started a new Virtual machine with the same discs attached and  this =
confused the discs.
Should avoid this.


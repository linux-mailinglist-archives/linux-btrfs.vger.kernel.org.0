Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4913B130862
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 15:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgAEOOp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 09:14:45 -0500
Received: from ms11p00im-qufo17282101.me.com ([17.58.38.58]:47262 "EHLO
        ms11p00im-qufo17282101.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726188AbgAEOOo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Jan 2020 09:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1578233682;
        bh=trt05mGMbjdpZdhBGfy6JGrWWFoI/MF/EY0VoEKBJcY=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=mfLbNWUnkVZiI8f0Cw/dhIC8b41mSPByMO2S98VB8QthmG7CkTrCQjeB9aig1MGed
         ipf5pjF4PMr6+3q2Qkk2zJMWYouVVOWP7rUcEvm9h+R5p1VTJFw18w5Su6tIQa6blh
         Tcin0R4xi+plhJcTMfTpi8YWFM25XtwfSa1SVF5IGXnzFQwOhnqJZDekQ9SgOrOByT
         FzFBqb2xeBn7dLHTxjVT3FwDmzUmSZPm2UMzdJv5mpZG9SGeE/vbSJFRuess/SccOk
         3X79U2ohOgdV3zOSrh7nv4g8XcKbn/Di4RweYsqL7mgVWyaQwHQTAwn21HIfKVkCfh
         3N6djZ3Y992fQ==
Received: from [192.168.15.23] (unknown [177.76.36.47])
        by ms11p00im-qufo17282101.me.com (Postfix) with ESMTPSA id C4B1E780784;
        Sun,  5 Jan 2020 14:14:40 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: 12 TB btrfs file system on virtual machine broke again
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <0102016f76081d01-72e2a7ca-3d8e-4238-b578-898fbe7d7bc3-000000@eu-west-1.amazonses.com>
Date:   Sun, 5 Jan 2020 11:14:38 -0300
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4BB63A89-98D3-4990-9970-8D8258F66E11@icloud.com>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com>
 <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <CAJCQCtQmvHS8+Z7=B_8panSzo=Bfo0ymVU+cr_tR5z1uw+Ejug@mail.gmail.com>
 <CE5FDD33-F072-40EE-9ED7-66D5F7F2A5FA@icloud.com>
 <0102016f76081d01-72e2a7ca-3d8e-4238-b578-898fbe7d7bc3-000000@eu-west-1.amazonses.com>
To:     Martin Raiber <martin@urbackup.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2001050133
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 5. Jan 2020, at 11:07, Martin Raiber <martin@urbackup.org> wrote:
>=20
> On 05.01.2020 14:40 Christian Wimmer wrote:
>>> On 5. Jan 2020, at 01:03, Chris Murphy <lists@colorremedies.com> =
wrote:
>>>=20
>>> On Sat, Jan 4, 2020 at 10:07 AM Christian Wimmer
>>> <telefonchris@icloud.com> wrote:
>>>> Hi guys,
>>>>=20
>>>> I run again in a problem with my btrfs files system.
>>>> I start wondering if this filesystem type is right for my needs.
>>>> Could you please help me in recovering my 12TB partition?
>>> If you're having recurring problems, there's a decent chance it's
>>> hardware related and not Btrfs, because Btrfs is pretty stable on
>>> stable hardware. Btrfs is actually fussier than other file systems
>>> because everything is checksummed.
>>>=20
>> I think I can exclude hardware problems. Everything is brand new and =
well tested.
>> The biggest chance for being the source of errors is the Parallels =
Virtual machine where Linux (Suse 15.1) is running in.
>> In this Virtual Machine I specify a =E2=80=9Cgrowing hard disc" that =
is actually a file on my 32 TB Promise Pegasus Storage.
>> I just can not understand why it runs fine for almost 1 month (and =
actually more for other growing hard discs of smaller size) and then =
shows this behaviour.
>>=20
> Does the host machine use ECC-RAM?

The host is a Mac Mini 2018 where I took of the 8GB memory from Apple =
and put:

Samsung 2x 32GB =3D 64GB KIT DDR4 RAM PC4-21300 2666MHz SO-DIMM =
Herstellerartikelnummer: M471A4G43MB1-CTD

I bought at: Mac Speichershop Andr=C3=A9 Estel Steinbecker Dorfstr. 10 =
19399 Goldberg


>=20
> That Promise Pegasus Storage looks like a simple harware RAID without
> integrity protection (like a btrfs RAID1/RAID6 or something like ceph
> would give you).

It is a Pegasus Promise3 R8 running in RAID 5.=20




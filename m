Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F3C13099B
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 20:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgAETS0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 14:18:26 -0500
Received: from ms11p00im-qufo17281901.me.com ([17.58.38.56]:36122 "EHLO
        ms11p00im-qufo17281901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726092AbgAETS0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Jan 2020 14:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1578251903;
        bh=9uEYBaS8HarQvaDxoR6DGAfTAOV7oa87LVk3lmryREk=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=H2llhwFlTgNc9FaWwJra7NiIbDZ0Lp220M1C+u2euLo7ZlYUhoMkr1SXjTPnMzdzj
         5l7DywoToaE1bswNugYNS/oJZFto5gX8ZTpAKDKyM7AJfOWvZCNXLzk15jkWK4ClkD
         /QEJiGVYpt01Tz4qfvx8puiEs/7xvCIAswto0xhgz9WDZj2gByGS+4SzFkG1U0y/7v
         29OtVihYIrRcfQVQaCECAeZkQYfc5ZA88nuDmgWsXQOJtMKQy3dMquGnysn0BQi/bI
         tbUKxhb5P9X2/cqjhCHq2WfM/bF49HypadzQJnktkFVCtKsHLsSn4O7UwoIcGnRYJF
         tECJZQQKINIfQ==
Received: from [192.168.15.23] (unknown [177.76.36.47])
        by ms11p00im-qufo17281901.me.com (Postfix) with ESMTPSA id 3C2AD74052D;
        Sun,  5 Jan 2020 19:18:22 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: 12 TB btrfs file system on virtual machine broke again
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <CAJCQCtQAFRdutyVOt7JALtVsn-EeXhzNYYjdKpmS1Ts_6-6nMA@mail.gmail.com>
Date:   Sun, 5 Jan 2020 16:18:19 -0300
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC877460-A434-408F-B47D-5FAD0B03518C@icloud.com>
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
 <CAJCQCtQAFRdutyVOt7JALtVsn-EeXhzNYYjdKpmS1Ts_6-6nMA@mail.gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-05_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2001050178
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 5. Jan 2020, at 15:50, Chris Murphy <lists@colorremedies.com> =
wrote:
>=20
> On Sun, Jan 5, 2020 at 7:17 AM Christian Wimmer =
<telefonchris@icloud.com> wrote:
>>=20
>> Seems that I am using fstrim (I did not know this, what is it?):
>=20
> Frees unused blocks from underlying storage: in the case of sparse
> files it punches holds, for thin provisioning it frees logical extents
> back to the pool, and for real physical SSDs it informs the firmware
> those blocks are no longer used and can be garbage collected.
>=20
> Most bugs in this area have either been fixed by firmware updates by
> manufacturers for the SSD, or they've been blacklisted in the kernel
> so that FITRIM is a no op.
>=20
>=20
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
>> 2020-01-03T11:30:48.378998-03:00 linux-ze6w kernel: [1297858.223675] =
attempt to access beyond end of device
>> 2020-01-03T11:30:48.379012-03:00 linux-ze6w kernel: [1297858.223677] =
sda2: rw=3D3, want=3D421570540, limit=3D419430400
>=20
> Yeah that's a problem. That may not be *the* problem, but there is
> confusion here. What is /dev/sda?

/dev/sda is the hard disc file that holds the =10Linux:

#fdisk -l
Disk /dev/sda: 256 GiB, 274877906944 bytes, 536870912 sectors
Disk model: Suse 15.1-0 SSD=20
Units: sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt
Disk identifier: 186C0CD6-F3B8-471C-B2AF-AE3D325EC215

Device         Start       End   Sectors  Size Type
/dev/sda1       2048     18431     16384    8M BIOS boot
/dev/sda2      18432 419448831 419430400  200G Linux filesystem
/dev/sda3  532674560 536870878   4196319    2G Linux swap


This file is located on the SSD of my MAC Mini. /dev/sda2 is formatted =
with btrfs.

> This is a virtual drive inside the
> guest VM? And is backed by a file on the Promise storage? What about
> /dev/sdb? Same thing? You're only having a problem with /dev/sdb,
> which contains a Btrfs file system.

Actually I have only a problem with the /dev/sdb which is a hard disc =
file on my Promise storage. The sda2 complains but boots normally.

Regarding any logs. Which log files I should look at and how to display =
them?
I looked at the /var/log/messages but did not find any related =
information.

Chris


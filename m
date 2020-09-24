Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103E3277BA9
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Sep 2020 00:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgIXWgY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 18:36:24 -0400
Received: from st43p00im-ztbu10073601.me.com ([17.58.63.184]:33186 "EHLO
        st43p00im-ztbu10073601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbgIXWgY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 18:36:24 -0400
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 18:36:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1600986539;
        bh=TBUNQYUgQZdYN3QmHV+XPtClJG7mGdryY/C51meLC8s=;
        h=From:Content-Type:Mime-Version:Subject:Date:To:Message-Id;
        b=0LeYCjxCW5YWSQFTCoTava+kbj/3yOPPu7r17QZNMsW/X6WXHJfKA7K0/A5tGcJoU
         lw47Mu+1L9IEodOFVdFjOXtw6cGxt7gPscrpzECOVczfI+8pDV0ogeieI7BhhplJXU
         SNwrOJyp8MI9nCKB/6beazlDSLyyfBhXO46QV93ue8tNAEDkD3C+E3xfHIlIHkcSRR
         0hqsF6ZS1oRxp/TURjTfosDgvYw8mvOWRwZc98fdzfjnBZqlh6zUqG9hp0Weaq8mYH
         fIe4+aKVGjAv1JvpTWpOI0xGN1RzjlPBUjNlh7Mmi8i4hQ1nnXba8Gl5hm9QEminAQ
         WtKTm8FJKKlFw==
Received: from [192.168.10.109] (108-230-77-122.lightspeed.chtnsc.sbcglobal.net [108.230.77.122])
        by st43p00im-ztbu10073601.me.com (Postfix) with ESMTPSA id C0E2E82084D
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Sep 2020 22:28:59 +0000 (UTC)
From:   J J <j333111@icloud.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: Drive won't mount, please help
Date:   Thu, 24 Sep 2020 18:28:58 -0400
References: <91595165-FA0C-4BFB-BA8F-30BEAE6281A3@icloud.com>
 <fff0f71b-0db7-cbfc-5546-ea87f9bbf838@gmx.com>
To:     linux-btrfs@vger.kernel.org
In-Reply-To: <fff0f71b-0db7-cbfc-5546-ea87f9bbf838@gmx.com>
Message-Id: <C83FF9DC-77A2-4D21-A26A-4C2AE5255A20@icloud.com>
X-Mailer: Apple Mail (2.3445.104.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_18:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=620 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2009240162
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for your help Qu.
So is the data lost? Should I follow the procedure to recover what I can =
to another disk?
Any other suggestions for next steps?

> On Sep 14, 2020, at 4:34 AM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
>=20
>=20
> On 2020/9/14 =E4=B8=8A=E5=8D=884:56, J J wrote:
>> I=E2=80=99m new to a lot of this, just trying to use a NAS at home, =
single usb external disk, not RAID. Was working great for a few months, =
I=E2=80=99m not sure what changed today when it stopped mounting. Any =
advice appreciated.
>=20
> Transid mismatch, and the expected transid is newer than the on-disk
> transid.
>=20
> This means, either btrfs has some bug that causes metadata writeback =
not
> following COW, or the disk controller/disk itself ignores Flush/FUA
> commands.
>=20
> Considering it's usb external disk, I doubt the later case.
>=20
> In that case, any fs would experience similar problem if a sudden =
power
> loss or cable loss happened.
>=20
> You may workaround such problem by disabling the writecache, but I =
doubt
> if the USB->Sata convert would follow the request.
>=20
> Thanks,
> Qu
>>=20
>> Dmesg log attached
>>=20
>>=20
>> uname -a
>> Linux rock64 4.4.190-1233-rockchip-ayufan-gd3f1be0ed310 #1 SMP Wed =
Aug 28 08:59:34 UTC 2019 aarch64 GNU/Linux
>>=20
>>=20
>>=20
>> btrfs --version
>> btrfs-progs v4.7.3
>>=20
>>=20
>>=20
>> btrfs fi show
>> Label: '3TBRock64'  uuid: 71eda2e3-384c-4868-b5d4-683f222865e6
>> 	Total devices 1 FS bytes used 2.48TiB
>> 	devid    1 size 2.73TiB used 2.59TiB path /dev/mapper/sda-crypt
>>=20
>>=20
>> btrfs fi df /dev/mapper/sda-crypt
>> ERROR: not a btrfs filesystem: /dev/mapper/sda-crypt
>>=20
>>=20
>> btrfs inspect-internal dump-super /dev/mapper/sda-crypt=20
>> superblock: bytenr=3D65536, device=3D/dev/mapper/sda-crypt
>> ---------------------------------------------------------
>> csum_type		0 (crc32c)
>> csum_size		4
>> csum			0x9e8b0c33 [match]
>> bytenr			65536
>> flags			0x1
>> 			( WRITTEN )
>> magic			_BHRfS_M [match]
>> fsid			71eda2e3-384c-4868-b5d4-683f222865e6
>> label			3TBRock64
>> generation		395886
>> root			2638934654976
>> sys_array_size		129
>> chunk_root_generation	377485
>> root_level		1
>> chunk_root		20971520
>> chunk_root_level	1
>> log_root		2638952366080
>> log_root_transid	0
>> log_root_level		0
>> total_bytes		3000556847104
>> bytes_used		2729422221312
>> sectorsize		4096
>> nodesize		16384
>> leafsize		16384
>> stripesize		4096
>> root_dir		6
>> num_devices		1
>> compat_flags		0x0
>> compat_ro_flags		0x0
>> incompat_flags		0x161
>> 			( MIXED_BACKREF |
>> 			  BIG_METADATA |
>> 			  EXTENDED_IREF |
>> 			  SKINNY_METADATA )
>> cache_generation	395886
>> uuid_tree_generation	395886
>> dev_item.uuid		b7f4386a-18e0-437b-9588-6064ff483fd5
>> dev_item.fsid		71eda2e3-384c-4868-b5d4-683f222865e6 =
[match]
>> dev_item.type		0
>> dev_item.total_bytes	3000556847104
>> dev_item.bytes_used	2843293515776
>> dev_item.io_align	4096
>> dev_item.io_width	4096
>> dev_item.sector_size	4096
>> dev_item.devid		1
>> dev_item.dev_group	0
>> dev_item.seek_speed	0
>> dev_item.bandwidth	0
>>=20
>>=20
>> dev_item.generation	0
>>=20
>=20


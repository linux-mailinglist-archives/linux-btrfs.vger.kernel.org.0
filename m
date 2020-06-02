Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828F61EB327
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jun 2020 03:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgFBBwC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 21:52:02 -0400
Received: from mail-bn8nam11olkn2037.outbound.protection.outlook.com ([40.92.20.37]:8434
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbgFBBwB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 21:52:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPkBHXCpArCYECzVClGRVb9vK2EE3O+ilSzZEN6lcAOJJxx/4j01h1Fwk0ZLGJczbShWjHUSxrS0l186qXBZs6NsE+NuVmSlYRzloTQBryke8N7Vbuq16FzxdnUcf4V69h4dkXqXwTTYOKV39dhcjm+KbhHBMAP00AZ7k4est08j43KfUies3+xVu5GfyRE9Ynw9fq+H6nmZ4x1FRXeHJ/uGJjJu9d6SiLamQL6oP/2Iet3+l9OhO8TA913DqLBkkowlk26YSFD4XuUKG2eWT4qk/J3Wh+gg6DenNtmah64kFMhhqGMDsgGBLkcuMO9BOlSnopHzAerHmcfydxoJIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YI8axj+xOjIbR/H02FuGu6OQMPWEgadMu0hHOvSDsk8=;
 b=H5iYltBrnfwIMlCtwxej/xWFbBn1Vq7QnQ6Xg+/ksL6jAqhWPfU9fb9D4dJLFOVQAtcejbpOL9FxVVe2KKlRvvSPApkzj9e5apobI/j7P/EZRDghsZU3Xkx81bO/fvb7TZq3ok4Dd1DBf8jRLN+czvqJzE8mY/Sa+ZSp/ihJ5N8URw4RaCPxYXZ8rMeGhod3sC7+5DgOJRwLb/oEC2IfTgiGBkjxVL6HIWS9dUUqYr9wfJJtews2LK5fVlsFt3tf/kiJzfcu5636Na/JELa59QuzClX80VQmpyZ9z6tDln3KYTAsi3gwRM1cKUYhrD+gLhm+kvupi+eFWZaz0eGueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4d::52) by
 DM6NAM11HT018.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4d::412)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.22; Tue, 2 Jun
 2020 01:51:59 +0000
Received: from DM6PR02MB4427.namprd02.prod.outlook.com
 (2a01:111:e400:fc4d::4f) by DM6NAM11FT042.mail.protection.outlook.com
 (2a01:111:e400:fc4d::421) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.22 via Frontend
 Transport; Tue, 2 Jun 2020 01:51:59 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:400C994A9EFAFB020886F7F610E574EFB618B73A5B47282E778BB0E024193F92;UpperCasedChecksum:AE87ADFF476A93BBBCB6BB5F1016CF3856E47F7A148C75F6BDCB0DFB6D4B3FC1;SizeAsReceived:8987;Count:47
Received: from DM6PR02MB4427.namprd02.prod.outlook.com
 ([fe80::1910:a162:220e:24e8]) by DM6PR02MB4427.namprd02.prod.outlook.com
 ([fe80::1910:a162:220e:24e8%3]) with mapi id 15.20.3045.022; Tue, 2 Jun 2020
 01:51:59 +0000
Message-ID: <DM6PR02MB4427F7962A6FD26BC147B4B2C98B0@DM6PR02MB4427.namprd02.prod.outlook.com>
Subject: Re: Massive filesystem corruption, potentially related to
 eCryptfs-on-btrfs
From:   Xuanrui Qi <me@xuanruiqi.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date:   Tue, 02 Jun 2020 10:51:51 +0900
In-Reply-To: <bf3629ad-730d-3808-38e5-8c42eccbaf5e@gmx.com>
References: <DM6PR02MB44274C6B16F173291A82C4A8C98A0@DM6PR02MB4427.namprd02.prod.outlook.com>
         <bf3629ad-730d-3808-38e5-8c42eccbaf5e@gmx.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-F29bPi3kAQlMkF2E/crl"
User-Agent: Evolution 3.36.3 
X-ClientProxiedBy: OS0PR01CA0032.jpnprd01.prod.outlook.com
 (2603:1096:604:25::19) To DM6PR02MB4427.namprd02.prod.outlook.com
 (2603:10b6:5:29::20)
X-Microsoft-Original-Message-ID: <2c02048a4fcb253effd86da9818954d6ada603b1.camel@xuanruiqi.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xuanruiwork (2402:6b00:36b2:c000:215b:c82d:e923:cf02) by OS0PR01CA0032.jpnprd01.prod.outlook.com (2603:1096:604:25::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Tue, 2 Jun 2020 01:51:57 +0000
X-Microsoft-Original-Message-ID: <2c02048a4fcb253effd86da9818954d6ada603b1.camel@xuanruiqi.com>
X-TMN:  [bay/BwvF5NPBfPli8sX1oUWJjdBniZhxPoUSKT6Vunb+Mc/JsvZwHiLAUNXpHTubykM0xLW47Io=]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 9fb33e97-b82f-4836-72ac-08d80697892d
X-MS-TrafficTypeDiagnostic: DM6NAM11HT018:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQn5RS9vkh4RlIahj5nupWo3ZY09KV7VOh3rFlHy/gWcmFLU+0rVp5ijIFaKigF29GGMPplqG+aJWesdha+wYge1QtnEL5OkDmNZDpYho5+fwXw2vX08Nx6FQfzFPM0nroU/CPr5cYH7eQMFvZrZvYXko/OHGua9L83DFGpOKJL8utE9RbwXBo6cnUTPOeUf6k3lvPsa0qgtuiVTTpn62A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB4427.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: zyiLf8SmuEj1ylPabx+hTv7xFSteLtDrgfZaK4ltFZPkzmovz84o4YsJ69BSRUnTq7PpeezRCr2XT1KTAU7DXHjWnD2T0x1wVSRL1j/EykKyDn9RGjCbw3s764kRJvQfTNLELbKXZzQARJMB94nMVMtOqhd3v1qhzH21uNvs5IsVc0yxTH21VlUQUeoQ0sju+8iV24kr5QJ/y1XUb0WKiQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb33e97-b82f-4836-72ac-08d80697892d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 01:51:59.1606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM11HT018
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=-F29bPi3kAQlMkF2E/crl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Wenruo (and all),

> Any log on `btrfs check` without --repair?

This was all after I reformatted the partition, so it might not be as
useful. But as you see, `dmesg` reports 14 corruption errors on
/dev/sda1 (which has been functioning correctly) but `btrfs scrub` does
not report any problems. I'll do a btrfs check when I boot from a live
USB.

> But normally, csum read shouldn't lead to RO, thus I believe there
> are more problems of that previous failure.

I think there are other problems indeed, not just csum mismatch. I got
lots of I/O errors, but now after reformatting my partition they just
disappeared. Particularly, writing to the filesystem could randomly
crash the filesystem. It could be a hardware issue, but now it seems
more likely to be software-related.

Best,
Xuanrui

On Tue, 2020-06-02 at 09:18 +0800, Qu Wenruo wrote:
>=20
> On 2020/6/2 =E4=B8=8A=E5=8D=885:08, Xuanrui Qi wrote:
> > Hello all,
> >=20
> > I have just recovered from a massive filesystem corruption problem
> > which turned out to be a total nightmare, and I have strong reason
> > to
> > suspect that it is related to eCryptfs-encrypted folders on btrfs.
> >=20
> > I run Arch Linux and have my /home directory as a btrfs partition.
> > My
> > user's home directory (/home/xuanrui) is encrypted using eCryptFS.
> >=20
> > I ran into a massive filesystem corrpution issue a while ago. When
> > reading certain files or occasionally writing to files, I encounter
> > FS
> > errors (mainly checksum errors, but also other I/O errors). Then my
> > file system becomes read-only because errors were encountered.
>=20
> It's a pity we won't get the dmesg of that incident, what would be
> super
> useful to debug.
>=20
> > A `btrfs scrub` identified a dozen of checksum errors which were
> > "not
> > correctable", and `btrfs check --repair` (and `btrfs check --repair=20
> > --
> > init-csum-tree`)
>=20
> Not recommended, but the output may still help.
>=20
> > also failed to fix anything. The former crashed in a
> > segfault, and the latter refused to write anything because of an
> > "I/O
> > error".
> >=20
> > Unfortunately, I don't have any logs because I had to nuke (wipe &
> > re-
> > make) my filesystem as the solution. However, after the
> > reformatting I
> > gave up using eCryptFs, and the file corruption bugs have not
> > reappeared since.
>=20
> That's a little strange. I guess there is some buffered IO mixed with
> direct IO, which is known to cause csum mismatch, while other fs just
> can't detect such data corruption and pretend nothing happened.
>=20
> But normally, csum read shouldn't lead to RO, thus I believe there
> are
> more problems of that previous failure.
>=20
> > Initially I suspected that it was a hardware issue,
> > but I did a SMART test and no errors were detected; I strongly
> > suspect
> > that it is related to eCryptFS.
> >=20
> > System info:
> >=20
> > uname -a:
> >=20
> > Linux xuanruiwork 5.6.15-3-clear #1 SMP Sun, 31 May 2020 19:57:42
> > +0000
> > x86_64 GNU/Linux
> >=20
> > btrfs --version:
> > btrfs-progs v5.6.1
> >=20
> > (the rest is from after the reformat, but the setup is identical to
> > before the reformat sans eCryptFS)
> >=20
> > btrfs fi show:
> > Label: none  uuid: 823961e1-6b9e-4ab8-b5a7-c17eb8c40d64
> > 	Total devices 1 FS bytes used 57.58GiB
> > 	devid    1 size 332.94GiB used 60.02GiB path /dev/sda3
> >=20
> > btrfs fi df /home:
> > Data, single: total=3D59.01GiB, used=3D57.26GiB
> > System, single: total=3D4.00MiB, used=3D16.00KiB
> > Metadata, single: total=3D1.01GiB, used=3D328.25MiB
> > GlobalReserve, single: total=3D75.17MiB, used=3D0.00B
> >=20
> > Some output from dmesg (note that /dev/sda1 is not the corrupted
> > filesystem; these corruptions seem to have been self-corrected by
> > btrfs):
> >=20
> > [    3.434351] BTRFS: device fsid 823961e1-6b9e-4ab8-b5a7-
> > c17eb8c40d64
> > devid 1 transid 79 /dev/sda3 scanned by systemd-udevd (519)
> > [    3.440896] BTRFS: device fsid a3892669-1ad8-4ff3-9747-
> > 0f8c405c0e6a
> > devid 1 transid 4769881 /dev/sda1 scanned by systemd-udevd (487)
> > [    3.461539] BTRFS info (device sda1): disk space caching is
> > enabled
> > [    3.461540] BTRFS info (device sda1): has skinny extents
> > [    3.464079] BTRFS info (device sda1): bdev /dev/sda1 errs: wr 0,
> > rd
> > 0, flush 0, corrupt 14, gen 0
>=20
> Corruption count 14 doesn't seem good.
>=20
> > [    3.510991] BTRFS info (device sda1): enabling ssd optimizations
> > [    5.938153] BTRFS info (device sda1): disk space caching is
> > enabled
> > [    7.072974] BTRFS info (device sda3): enabling ssd optimizations
> > [    7.072977] BTRFS info (device sda3): disk space caching is
> > enabled
> > [    7.072978] BTRFS info (device sda3): has skinny extents
> > [ 3710.968433] BTRFS warning (device sda3): qgroup rescan init
> > failed,
> > qgroup is not enabled
>=20
> And btrfs is trying to init qgroup rescan while qgroup is not
> enabled?
> That's doesn't sound good either.
>=20
> > [ 7412.459332] BTRFS info (device sda1): scrub: started on devid 1
> > [ 7545.641724] BTRFS info (device sda1): scrub: finished on devid 1
> > with status: 0
> > [ 8244.846830] BTRFS info (device sda3): scrub: started on devid 1
> > [ 8369.651774] BTRFS info (device sda3): scrub: finished on devid 1
> > with status: 0
>=20
> Any log on `btrfs check` without --repair?
>=20
> Thanks,
> Qu
> > If anyone could look into the issue, it would be greatly
> > appreciated.
> >=20
> > Best,
> > Xuanrui
> >=20

--=-F29bPi3kAQlMkF2E/crl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEyHoeIkwnsd2PnV57h/kAAm4G+8gFAl7VsLcACgkQh/kAAm4G
+8gY0ggAjcmoAIsszDaJCTkR12R/HyYmFjDjMR5wbfPm/Zaqce+yNf4GnBJS8v/d
C+l77IzYWia0q29+rZohtwpPSQYKI3ie6/VKXxL2gc2TJSL1ISn1S+3D/JOItEnW
Am90jWuGkeyBMymWkYxDuNH07XpVBJHAtVdlyxfHTLQhVKFUA569lYZOeuvVbi1L
xwSdmkpLXZYNT5lOJSh/atFoYbS3RaNAChT8hOjbHy2RgkNxesqGP9tBmRaYsG5+
JqO2YYL6HhPAaACW2eIMX53F4BarRTm/JAE9Ec+eFy2sJl0lKU3cbqK40mSnDVtR
uuUzpkozxY0r9dICCvVVdfSeSQXpSA==
=GV1K
-----END PGP SIGNATURE-----

--=-F29bPi3kAQlMkF2E/crl--

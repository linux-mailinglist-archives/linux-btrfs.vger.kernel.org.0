Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F83158791B
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 10:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbiHBIfW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 04:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbiHBIfV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 04:35:21 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-oln040092075046.outbound.protection.outlook.com [40.92.75.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4455FB9
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 01:35:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ippFEgo9cd6kwX9pXiE9dgbVm0xXrmbbkUgEgBrcvJ1UEpc0DZJr9hBVvUtyd8n39elV7t7S24Vk7siFRe7j0HElJZxF4cCWV5+sFoWQpiLtUR7Lyn3sBVjxJsYfgxgHtQJ7xlvbKsuRVE71MfN1WcMr3W9+jJhN4b/hLk/+nrJRSZC6lu7TDkfUn4OCw8F0Mvi9zKyuhdVoHJLj6vSJ6uw14GdHhmy0gf3JHr4JM7CIkhFj5cCctrYNbjGtNs5on2W7sjx5MUeoX41AFlWEN/efulJz4sRPEiT6vh4DWnh13vChBQ+J3Pd4MkaRvJxrAcZ0vm+BMrzKgDsqDwJtkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uT2I7O9phBZfQraFP9a6M2+dkZ2QqTMNfvn7XkU510Q=;
 b=jfpthUvnwkzkN7iB0e9BXQgU/UeSb8JfesCaCTE9kVrEiUl/mdqPqoz22t+Jq3xLEIp+dsuVJk7gz7crjTXBC5tLwAk9w+at+MAr8LT2O9PaxK/skhuqzLpU0NhKyT6gcIpOez0Jml4HaP7j2KZ+xB8WhQqTE0fCx1U3uXeHNqFq86fsorfKJ4HIlg8wUpJTx0n+FLgFfz1kMFUgbU8RpAmpmCJ6ZzJYQANoQ7XMlruAyBVvhgMqKYOowDIaLEbfTF22W+D1SyPtCYOB8dWnZxaHo4eh0wQLjjBYBKqUQc7W2v4Sovc0zqoZ7nz6naSatgv/VTlYcGVNVWARQ3p+eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uT2I7O9phBZfQraFP9a6M2+dkZ2QqTMNfvn7XkU510Q=;
 b=HxDr5JQA7dPMQdO7zGlzYUI0ne/1ZkZ03zAG4tEUXfGpxYPx3PNDjsw+Feqv8sZPt2HyK+N1pM48n1bbhL8WzWvbXSFj1ItkSN3UvIhVEX57p8BSHvsbMSQll1Nb6FvwbLrT9hw3ohYBBtoJ/0yv9Z9Vi+15w0t9hj1zqDg2vfqdsLi7AeXLgHFK55FZ8jNRBkFdHP4kdOvheqGfoqpmxd+nSFQsXK4MCXmsfDVXdE61BJ/X9FCG0aJlw4AfHuONw22Mo3k3fUBAMaCx+firh1i0npEEAMiXLRyKZSvJm5hYVFbR8Xis49MD5VXpXrPyDqC3VzSv3RggthXY6D5ceg==
Received: from DB9P192MB1195.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:29f::21)
 by DB6P192MB0086.EURP192.PROD.OUTLOOK.COM (2603:10a6:4:bc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.15; Tue, 2 Aug 2022 08:35:17 +0000
Received: from DB9P192MB1195.EURP192.PROD.OUTLOOK.COM
 ([fe80::796c:df27:1508:58e5]) by DB9P192MB1195.EURP192.PROD.OUTLOOK.COM
 ([fe80::796c:df27:1508:58e5%8]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 08:35:17 +0000
From:   Martin Edelius <martin.edelius@outlook.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: "parent transid verify failed" on raid5 array
Thread-Topic: "parent transid verify failed" on raid5 array
Thread-Index: AdiktAWlp735W6lMS1yLNYDL/IgFHABXMlaAAA5gN0A=
Date:   Tue, 2 Aug 2022 08:35:17 +0000
Message-ID: <DB9P192MB11956452AD57F3D0BDB36CD5989D9@DB9P192MB1195.EURP192.PROD.OUTLOOK.COM>
References: <DB9P192MB119500EDD9CD8A59B250AFE7989B9@DB9P192MB1195.EURP192.PROD.OUTLOOK.COM>
 <1bcfc031-2bc5-20f2-bebe-1b1f2baa56e7@gmx.com>
In-Reply-To: <1bcfc031-2bc5-20f2-bebe-1b1f2baa56e7@gmx.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ecca9737-3fb7-4a23-a452-5fd2dddae788_ActionId=3a5f0e2f-6e62-4357-8f2e-29d5fb59b96f;MSIP_Label_ecca9737-3fb7-4a23-a452-5fd2dddae788_ContentBits=0;MSIP_Label_ecca9737-3fb7-4a23-a452-5fd2dddae788_Enabled=true;MSIP_Label_ecca9737-3fb7-4a23-a452-5fd2dddae788_Method=Standard;MSIP_Label_ecca9737-3fb7-4a23-a452-5fd2dddae788_Name=Internal;MSIP_Label_ecca9737-3fb7-4a23-a452-5fd2dddae788_SetDate=2022-08-02T08:31:50Z;MSIP_Label_ecca9737-3fb7-4a23-a452-5fd2dddae788_SiteId=76431109-ff89-42c2-8781-a07ca07a2d57;
x-tmn:  [IspRTYiMyLe5YJwKH8Z+3PWdmfTQkCch]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c299240-bfbf-418d-4531-08da7461edb8
x-ms-traffictypediagnostic: DB6P192MB0086:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mW1t5vCufzBwCpWH6Av5o5nMkloKbHS8hJZdzYwNoFQpBayw4Sei/L7TGlm7wmEOFZC0Y8ydkn6+V/6g/+jwi/Dwy1/Xyrvo/pAjbLLBj++CdCS/7ax4UKCbI07rUYyZbKYEjnlCBA+NSkBN3lRlQbby2yaSv5B3/LPXY2aECVWhonIsblxkeOJANxA8kbKF0G4MowT8zOzRu1KC8uSXoYJX0a3L/Z342g14H/TrV8iRCdRp5UI/M5j4tCFWzLBCdtM8e80CHRCVgGIoZVEBMAmKru6gA3kEnW5DSAbo49bTXyXKfRqzUgdTFo+idemWL/0H81nvH548sw2i2t0KMyeG5JwFm26l0fYAHVrf2nMcAwz9cYwVLrndda96Me1oy7zzuBJptI5CJLWAsehrmkimwepVen/iSVIEP29dKMv2vLnSuYGLzyBjuLwzPQVvUpHKT+6qsT5/USkiRThqMnfqe5KzNjxOByQbs/5UqhT6Pbe5kbBf6Znl4TNtPVPBBjdbmf2GpKGUC4k23htjwSLSPsamXzDC3NKLKuV/p52MAxx7HvioqWKFYVrh3VoQdZSOs5Mgw8e1HKHK56JNxo2YdUBfSfdDeNSr6yHEO3beLzyLkDtACWkN/1njjil77BEeaYlR9+tyiFveKz253Rk5XnFXEqJtUd5kYyXknshCtUeGBMenKTxP8s/yIHnS
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qketczAr41MQIQPx1VhkOVw3vKoSP2SGlk+AAyw761lSVDrya+xsKn3Rs8il?=
 =?us-ascii?Q?tQ3s0xhetPcjfTnYzYFh4Pa+3OU9UQ8iqvpb7S26rDJXCu5CAlhAR/sIOADw?=
 =?us-ascii?Q?x3iMn3UjZdQOo21Z+B/JKRGkfKAvoaXy1N81gCYlbgqeBAZ3vA9IH32fgzFC?=
 =?us-ascii?Q?gCezmLxRDgiBP9ccu/2hpykaLVf9agOfckD+8hdRMQzShYJFw/SoUiuc8PSP?=
 =?us-ascii?Q?M+i2CqoKF96oQXz0uylt3uPl2Rh2Z+wxkf0zS/hN9tP9Q1SKjMoX6zPpaHrf?=
 =?us-ascii?Q?yZ3h7ZwV5L0fQZ/6sEc1etS3ArG+xPWigLyGKxnlokPFO+9+oe2J5BibYPd4?=
 =?us-ascii?Q?UuW+lNJoHgUiY7DHwD+M1LBuKeSDoLJ79nfLzjIb9XjJWr497Ms00L+1CBvm?=
 =?us-ascii?Q?Gfx5eo9YiZLA+NNDTDLbdQloZjXaalg8k7xS55ZstIHHgj9IfgvInoic7hhF?=
 =?us-ascii?Q?Np0Q1iRccqIWTAG5+A+kEO8YdkxqTxTUgJcbFS/gIg2Lzjg2NmULb5vBZ4Ky?=
 =?us-ascii?Q?dtroyV4zPpFTvdJmjaAxyU5hmPFHi+hDCAgszeuRFdPebT3zroDqVAZie5yB?=
 =?us-ascii?Q?fcIQrkNsuhTEVgV6Rp7SPOztc+MylAT//gNFGJRruCfZxQ/BH2bxIDeQDAyX?=
 =?us-ascii?Q?rF27H2JYDn8bIwZ2NxV04MhaZpA0GYbXMUV6Ry22mm0cL3BUAmEkO4W16EIZ?=
 =?us-ascii?Q?PN8iWG1TgPAVahJ/w3qPSwd8vu6ydkOyjNNd4310wX1ul7TcKcPxO5v4fVhd?=
 =?us-ascii?Q?XEFNVMLZu2oSgGDxFtgPRypCiK5sDlWW8VoydNggcnaHAqIYsb+rJi5h3rPZ?=
 =?us-ascii?Q?pUYc4CX5ZviAs6H8ReMo+Irpm/I4LZVi4CmK3WN2qlufLwOoqYK1OgcODDuX?=
 =?us-ascii?Q?BTvKxExmp4LuLCz8rYxWGgkyEW03WMlFJv11R4i5KtsWAj83inppJUCuZRQf?=
 =?us-ascii?Q?gN1OWkCvQiz3vJQSrysEC5g1k3DcqeAqfmUaawkjWd7tCCEvcjhwtQAlE7uX?=
 =?us-ascii?Q?dvAcdIu+7awnq/lD8lr2e5NSeErI8d7WayB4FXdpM6MFfSnKqMfPrBbd16WX?=
 =?us-ascii?Q?iitWnM+dc4kAuYK0v1AOfgCAlTWqZjJZ91JKP8tC54SBQKyNxKZcuIFJLq6M?=
 =?us-ascii?Q?DQ85ZsAIFYX6d0f4N+oUHSGLjSRt4Dn4hXqw785pxkVnBSlIkwdmotXCE4Cq?=
 =?us-ascii?Q?fHQ2uDDjLGPypy0awxT/SDq0Eyt24W39QRh/M3mWS4WlSGmYHKsBvZkTaBDC?=
 =?us-ascii?Q?M+qzudMGCiyoFSClukvfVtpvLWrWMpE6oHM5JItc+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB1195.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c299240-bfbf-418d-4531-08da7461edb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 08:35:17.4959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6P192MB0086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu.

Thanks for a detailed answer.

Yeah, I know raid5 isn't recommended for production but I didn't understand=
 it could go this bad.

Here's the output for the 'btrfs fi df /mnt2/HDD' command:
Data, single: total=3D8.54GiB, used=3D5.22GiB
System, single: total=3D32.00MiB, used=3D16.00KiB
Metadata, single: total=3D232.00MiB, used=3D100.09MiB
GlobalReserve, single: total=3D13.64MiB, used=3D0.00B

I'll try a liveCD and see how much I can recover.

Again, thanks for the help.


Brg,
Martin

-----Original Message-----
From: Qu Wenruo <quwenruo.btrfs@gmx.com>=20
Sent: den 2 augusti 2022 03:40
To: Martin Edelius <martin.edelius@outlook.com>; linux-btrfs@vger.kernel.or=
g
Subject: Re: "parent transid verify failed" on raid5 array



On 2022/7/31 16:40, Martin Edelius wrote:
> Hi all!
>
> I've been looking around for a solution to my problematic raid5 array=20
> and although there's quite a bit of useful information I also see the=20
> advice to not try and fix this error myself and instead consult this=20
> mailing list. (As a side note, I did search this list for a potential=20
> fix but got 3000+ results so I resorted to starting a new thread.)

Unfortunately, RAID56 from btrfs is not recommended.

The main problem is, even without power loss, recovery for btrfs RAID5 has =
its problems, mostly related to its cached raid56 data.

Furthermore due to a bad design in P/Q update during a RMW, even if we didn=
't touch any data in a vertical stripe, the P/Q of that vertical stripe wil=
l still be calculated and written to disk.

Combined with above cached usage, btrfs RAID5 has a very bad behavior to ca=
use more corruption, if one data stripe has some corruption already.

This behavior will be at least greatly improve in the incoming v5.20 kernel=
, but unfortunately these fixes are not yet backported, thus your
v5.4 kernel will be affected by this.

>
> I was away for a couple of days and came home to this problem so I'm not =
entirely sure what happened. As there are no signs of power outages my gues=
s is that it's just a faulty disk (/dev/sdb). The SMART info says that it's=
 been online for a little over a year so IMHO it should last a lot longer b=
ut I guess it didn't.

Exactly the worst case, a faulty disk, then newer writes will easily spread=
 the corruption into other devices.

>
> I'm running the Rockstor NAS and do my best to keep everything updated on=
 a regular basis.
>
> So far I've only tried mounting the filesystem as degraded and read-only =
(and with the usebackuproot option as a sort of last resort) but keep getti=
ng the same error:
> mount: /mnt2: wrong fs type, bad option, bad superblock on /dev/sdb, miss=
ing codepage or helper program, or other error.
>
> I have other disks I can swap in but I've had mixed results previously=20
> (when the array broke the first time) using the recommended commands=20
> (btrfs replace for example) and I have data on this array I haven't=20
> backed up yet (rookie mistake, I know) so I'd rather ask you for=20
> guidance before I start potentially making things worse. :)
>
> Here's the info requested:
>
> Rockstor:/mnt2 # uname -a
> Linux Rockstor 5.3.18-lp152.106-default #1 SMP Mon Nov 22 08:38:17 UTC=20
> 2021 (52078fe) x86_64 x86_64 x86_64 GNU/Linux
>
> Rockstor:/mnt2 # btrfs --version
> btrfs-progs v4.19.1
>
> Rockstor:/mnt2 # btrfs fi show
> Label: 'ROOT'  uuid: cd444c07-dfe0-4813-9a71-6833c48d1cab
>          Total devices 1 FS bytes used 5.32GiB
>          devid    1 size 109.75GiB used 8.80GiB path /dev/sda4
>
> Label: 'SDD'  uuid: 3d0e1b45-666a-46c6-9c83-e2f16a73b79e
>          Total devices 4 FS bytes used 257.92GiB
>          devid    1 size 465.76GiB used 89.00GiB path /dev/sdc
>          devid    2 size 465.76GiB used 89.00GiB path /dev/sdi
>          devid    3 size 465.76GiB used 89.00GiB path /dev/sdh
>          devid    4 size 465.76GiB used 89.00GiB path /dev/sdd
>
> Label: 'HDD'  uuid: 0aae387e-2847-44a5-8db7-0635421d80af
>          Total devices 8 FS bytes used 11.41TiB
>          devid    1 size 2.73TiB used 1.64TiB path /dev/sdb
>          devid    2 size 2.73TiB used 1.64TiB path /dev/sdj
>          devid    3 size 1.82TiB used 1.64TiB path /dev/sdl
>          devid    4 size 1.82TiB used 1.64TiB path /dev/sdg
>          devid    5 size 3.64TiB used 1.64TiB path /dev/sdf
>          devid    6 size 3.64TiB used 1.64TiB path /dev/sde
>          devid    7 size 3.64TiB used 1.64TiB path /dev/sdm
>          devid    8 size 3.64TiB used 1.64TiB path /dev/sdk
>
> Rockstor:/mnt2 # btrfs fi df /mnt2
> Data, single: total=3D8.54GiB, used=3D5.22GiB System, single:=20
> total=3D32.00MiB, used=3D16.00KiB Metadata, single: total=3D232.00MiB,=20
> used=3D100.03MiB GlobalReserve, single: total=3D13.61MiB, used=3D0.00B

Fs in /mnt2 is not using RAID5 at all, all pure single, so I guess it's the=
 ROOT fs.


>
> The dmesg log is approximately 258 kb so I placed it in my OneDrive inste=
ad: https://nam12.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F1dr=
v.ms%2Fu%2Fs!AsKRbODiURBmrMdN3oEHLQqlLqxujA%3Fe%3DOIo05V&amp;data=3D05%7C01=
%7C%7Cd048b4991ecf4f64a02808da7427f459%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7=
C1%7C0%7C637950012199349857%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ=
QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DeOx=
zFMC1ezG3E4jborTa69kQ6tqf6B%2F4q9A4CVaUbRU%3D&amp;reserved=3D0 (let me know=
 if you want me to provide it through some other means).

According to the dmesg, the error is from sdb/sdl, thus the HDD fs, which I=
 believe should be RAID5.

Mind to share the `btrfs fi df` output of that HDD fs?


Another thing is, it really looks like some RAID5 destructive RMW:

   BTRFS error (device sdb): parent transid verify failed on
11190780739584 wanted 192504 found 191675
   BTRFS error (device sdb): bad tree block start, want 11190780739584 have=
 0

The first line mostly means it's from the data stripe, and it's bad.
That's fine since it's a fault disk.

Then the 2nd line is worse, it should be rebuilt from P and other data stri=
pes.
However the rebuilt data are just all zero, and failed to even pass basic t=
ree block check.

This looks exactly the destructive RMW caused by fault disk.

Unfortunately, what we can do is only to salvage data.

If possible, try to use some liveCD with kernel >=3D v5.15, then mount the =
HDD fs with "rescue=3Dall,ro", if lucky enough, you may be able to mount th=
e fs and grab whatever you have.

Thanks,
Qu

>
> Thanks.
>
>
> Brg,
> Martin
>

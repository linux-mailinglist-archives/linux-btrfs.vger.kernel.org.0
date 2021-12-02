Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BED2466A7D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 20:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357697AbhLBThA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 14:37:00 -0500
Received: from mail-mw2nam12on2095.outbound.protection.outlook.com ([40.107.244.95]:57569
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235481AbhLBTg7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Dec 2021 14:36:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gykzjd98XLqkqks1toALghe8S2z+oJAXniySjIT2hyA0Hn6vHVLpsUFZ63FRbeARjSSRq9afPS58kXugXvl387uhtTS3wTW295ze88sBJeclzIs9h1PP4kwoG/U0N7F8Bz0JGqWXX3eGxNSZzhZuhT5dP1loM94zP6yE7s1LHV3HZxsomw6q7u8ILqv8GCMDG59ZsRrv/XeOIGriYGK6hOfDEYH6VrFd8oVWKsloTbM7tpA1IDiYvIuc2EHKFJrwwvWWiOW8nCPaNlgR0jd17Ddcu4Daak/UMk44QLwovuz7c1FWKVH449cr9+qRSA6Dn1MzVOArR9/4l8lwwfebJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QW7xJEpKNXDjwNBIcZqjsNZfsYYs4wVwWsP4oYCXPuE=;
 b=W1wf+lPB9Zxxt0aYbRfZAxVuVVZK6ae1MY+MH+snm69x+kF6SQuUA0uZjCOhK5KzdSLQljbOUPu72Ets5PnhJxFd6nBCSmL9K9MyVHeiISGDmQuQTqM8KvOImNVO8ixP6Unk2F2afpBTjDzh87AmcVsIBx3HkfMkBYGLFmM49ROLN5faMqjobapM+izfLJMshb1QdKws7BRt1ty9WUwIS1cuqM34JDz92F77ac8NKF2qv95vXBgKF+BGpT1hsy5ll17bZc8GlSUqUusCr4i7Cfo4qNKfPtcRjoCe8urHBza+1pe4m9JNUO37cMZkwWLq0dZSuDyC97eCU11CTzWESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rollins.edu; dmarc=pass action=none header.from=rollins.edu;
 dkim=pass header.d=rollins.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rollins.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QW7xJEpKNXDjwNBIcZqjsNZfsYYs4wVwWsP4oYCXPuE=;
 b=kYQxC5fyy0yo/xz6JR8XOPSicj7fQ3zBVOB8ZWBMc+IkccgMKGslRtQGvIoZgVCvht9RUhhnvxzZlno/q3jWsbBJF09fS9hmwrdzzZxMCzMhhuuu0s5drWN6vPZwkkOOCThovwgqFR6dLPYG3l/YN0KfMtHCHoVVRblVJcOnma4=
Received: from DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:32::12) by
 DM8P220MB0424.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22; Thu, 2 Dec 2021 19:33:34 +0000
Received: from DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7488:5485:739b:c303]) by DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7488:5485:739b:c303%9]) with mapi id 15.20.4734.028; Thu, 2 Dec 2021
 19:33:34 +0000
From:   Charlie Lin <CLIN@Rollins.edu>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Unable to Mount Btrfs Partition used on Both Funtoo and Windows
Thread-Topic: Unable to Mount Btrfs Partition used on Both Funtoo and Windows
Thread-Index: AQHX57E0wYb8FBkHpkeQ/RB6UCwO5g==
Date:   Thu, 2 Dec 2021 19:33:34 +0000
Message-ID: <DM8P220MB03421444D486BBC29023BE74C1699@DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 220d82f8-e027-ba1b-5ef8-64f454019446
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Rollins.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f060242-957d-497e-4f71-08d9b5caa13e
x-ms-traffictypediagnostic: DM8P220MB0424:
x-microsoft-antispam-prvs: <DM8P220MB04240A9804DC82943FBF4E3FC1699@DM8P220MB0424.NAMP220.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nkg1dH9iBmtX8x96YwbgPmphsVRjd3/IFHsi3TIICpq+Pm+8vZoFWZ0ryEL3u+phR8Tpc7E90t3GQV6VJK7mjUxrKsReu4TdrdToyO4rrviAEGrfJ1hUHgm0+NrDlWEKHTL8ltsEJmovCtW1SLcwRZCANrN3PMQEiMWtAkacuKYGgs+e6F3S0EimcicTGeN9a44tfTtgYbb8LdbvgI/heIFVHKsE8kHV+RNRErUnomU3VCiIcJa6W7LBL+h9ZcOg6lNIXy4STDvE8jmlgDvGYraqoC4vn9eipttSQ6wJertotG2dyXIAQKyOckhS7/i6Q1r3qbd5yjWKrAAN9rHaDxYFQnJB0iXx09lbakjG9Jf0LKr75772X2CpivS7++24/fiWeVnrhb6uEBLJ2VGKHqwQyx4r4tusYtDC0XS4VVdgfKUJFT0qGc2gxpZv/zjx32/D0qW1zdKNwJo9i6fLPHE62Eljr61C4RCJxGR7npe8RKWvFFx6I/HzxWaA/rk3yc78EjxsxCxvNyxEktVMVVj1Hh/yUCR3GrYHQPoR+Y0gI0Q+Tn1MTpG4PbvnTnM3wLqRLIIStZ/F+2iOg8orZOa09RwFjU2nSihwLL5GSD2PE3+VUYQvM2BUhYORpBHOrzme0kY2OMIx65MSj7lvzSfzlFGmPWVFT6gryEYJyr0G6apPgG0qxuQWsBNMMrrTRdUQDTOReI2pXExuXkc+6yHacWWVNuOkVsNyYli+6bRoHJVRIsPbHCg5E7qTlEskO1/zHIXbuVp7+O0TgCOZS602BUnnTOGsSmAeoVPBLBE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016003)(5660300002)(83380400001)(8676002)(6506007)(9686003)(8936002)(66556008)(6916009)(66476007)(64756008)(66446008)(966005)(38100700002)(86362001)(76116006)(30864003)(91956017)(75432002)(66946007)(38070700005)(33656002)(71200400001)(7696005)(786003)(508600001)(186003)(52536014)(26005)(122000001)(45080400002)(2906002)(316002)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FvEKbqEA3nP3ANuEIHC31zaW15D93b38rAW1yEulvrifmRXA6jkyXam1jM?=
 =?iso-8859-1?Q?5qhjBJQFrKHZ8TCFgCroyBuVr+E+kAoM9oLYWBzVfZffW+05bKZhCpgom/?=
 =?iso-8859-1?Q?FoxHk7n5pP2RUovD5a4hEpwFx+r5ZLIVcVf0WHgJjOD9pAukcIA+9I5rWP?=
 =?iso-8859-1?Q?0dtL9YApEhahhg63h4rqVn37B4qh97uZ1VVs8VK03gFW7tcmv1OOw283Ry?=
 =?iso-8859-1?Q?TodbpzK75uQvToHUdSyLZVgxoJNLq24WgVloetmEnfSfNdj6GiVlCYzxtQ?=
 =?iso-8859-1?Q?aaoiDzAXKepZnmzfTWe3hOpsPHQhnADr4n7a8FzG4yMXowtu27pVgRn2wV?=
 =?iso-8859-1?Q?zM4us9/cR8hP4XZvk1KYpoZuOEuQRrZSAn9Xk1cstKNEiks3u3TizLuZR3?=
 =?iso-8859-1?Q?ko0y/+avkik4SU8XIJCKej+DUmkuJWv+epb+bQjtEb1j3I4FnqvtUo+vBr?=
 =?iso-8859-1?Q?pvcoGUWDSMrr7HqMAhsQ33wA/pGshUT0yMQT7qFCmZzRXJwolWYV7B/rrX?=
 =?iso-8859-1?Q?1Lmf+EhQDUShP3ncdGhZXfNazUQYCYZ6z8KP9vaR6SwBCEjCsruqusrOgw?=
 =?iso-8859-1?Q?p7cpz+9+vCEhtz18jpo6oluuUlFnqLUHbUWtoUgixXd9O2ifmje+No6/N9?=
 =?iso-8859-1?Q?xpO7jx/tFiVGuaM+HH2KxweNBjiIHyp9e/2UNtp/MCD6EHjXTuaUETyuhx?=
 =?iso-8859-1?Q?6MLlydgmET/tovmGS4QfZaGt5RwZRGVVwEtw5M2gYNgm+f1oYQWG7p/r4L?=
 =?iso-8859-1?Q?N+8Fp8M4lL2yrYXH3R4mGMVdp+9b3sYJn99nI1Zonv5KOlaluUrLkbGpg4?=
 =?iso-8859-1?Q?z2aC0M2ZNKUjrehji3aWFmHuSKhnjdjVZ2ZkWR9452aUo2Lnb0+nX2YSES?=
 =?iso-8859-1?Q?JfJKUWR8VfZ+Un6rTditag+LsStgB/1bFVMkYa/qYJQEkbJtZ24DO5tjZy?=
 =?iso-8859-1?Q?82Xg5KnpC8Vx3zBqatVr64asbiB1oPnkPimdmPRdfZXzeaEHMGqx8/VnD9?=
 =?iso-8859-1?Q?HkkFNOIL47+UWVXR8Ak9eBpi0h84vnXxXua6t+TWe4V6PLqMiA13D0l5EG?=
 =?iso-8859-1?Q?XW89YBSTxxJI4ehhqvPdIgzAaGtkVb2FhPZJprrusebtmmySMbysOHbu4I?=
 =?iso-8859-1?Q?lze0NKVo6n6A86yeqFOzz3gMhGqDZ+ObpetpIAd+UYLjvhQLVr+Xm/xejl?=
 =?iso-8859-1?Q?imKrd4q3H9IBqKtrReYgD/FmloQzX75yQFQxMHZwtNAyRsjxd7vTw/qkzU?=
 =?iso-8859-1?Q?nZAcxu+ew07/sVOhn0IFBv2jBRThKWMWf64Bwbb259Lg1zyeSQLqiYmUng?=
 =?iso-8859-1?Q?zj83EWbpLAglm9ES65rleoWyB6GgKxBb2R94i+11MxIg0FqHCwWsHmi4C6?=
 =?iso-8859-1?Q?66DsysGnowAnhaovJqR5aNdVUEXxmvf+5ktG3VqZZtIrzRdTtcPZOEm4K3?=
 =?iso-8859-1?Q?o3L2V7ybq0S5HjKNmro4cK6yRjz30gGJYVS2UdNOr5rm8F9AQSGkouwp6r?=
 =?iso-8859-1?Q?hHndGnGxG+cum6nztOi19d7y/RqTtMENgguYOBGuTydTt8PPsGRT5Eu3Yb?=
 =?iso-8859-1?Q?5QUnviCo1m8IOOqRz3wNeH7jQDmyV0FA5kXLQsHh+nMbJXWVpnokRlkRA5?=
 =?iso-8859-1?Q?TZQV5edIKaFiSf5ewsnV1BN3pXEsfguHACJpY4uEm4LkUzENRuWbWQhg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: rollins.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f060242-957d-497e-4f71-08d9b5caa13e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 19:33:34.1438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b8e8d71a-947d-41dd-81dd-8401dcc51007
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 49k2+qIqlbGE3nfMwXJUzpVcUrj+9wOGOl8IHUjjtGVqWvCfi78PCQumSHcxqn98PkBScJkXJtE3P3mYwo7GKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8P220MB0424
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a partition, /dev/nvme0n1p8, that I can't mount on either Funtoo or =
Windows (using winbtrfs) (normally the partition is mounted on /home/shared=
). Interestingly btrfs fi show indicates that metadata is present on the pa=
rtition, but other than that, I'm stuck.=0A=
=0A=
Linux funtur 5.15.3_p1-debian-sources #1 SMP Mon Nov 22 22:10:28 -00 2021 x=
86_64 AMD Ryzen 7 4700U with Radeon Graphics AuthenticAMD GNU/Linux=0A=
=0A=
btrfs-progs v5.9 =0A=
=0A=
btrfs fi show:=0A=
Label: none  uuid: 198a8721-446d-4012-a0ce-533328c5b5f7=0A=
	Total devices 1 FS bytes used 12.79GiB=0A=
	devid    1 size 70.00GiB used 16.02GiB path /dev/nvme0n1p6=0A=
=0A=
Label: none  uuid: 3fa3cb95-582a-407c-864c-160b47b1f93d=0A=
	Total devices 1 FS bytes used 684.88MiB=0A=
	devid    1 size 100.00GiB used 2.02GiB path /dev/nvme0n1p7=0A=
=0A=
Label: none  uuid: b0a63a1a-7f19-4ada-97da-402534ed4ed1=0A=
	Total devices 1 FS bytes used 1.96GiB=0A=
	devid    1 size 548.32GiB used 3.02GiB path /dev/nvme0n1p8=0A=
=0A=
btrfs fi df /home:=0A=
Data, single: total=3D1.01GiB, used=3D673.34MiB=0A=
System, single: total=3D4.00MiB, used=3D16.00KiB=0A=
Metadata, single: total=3D1.01GiB, used=3D11.55MiB=0A=
GlobalReserve, single: total=3D3.73MiB, used=3D0.00B=0A=
=0A=
btrfs fi df /:=0A=
Data, single: total=3D15.01GiB, used=3D12.32GiB=0A=
System, single: total=3D4.00MiB, used=3D16.00KiB=0A=
Metadata, single: total=3D1.01GiB, used=3D486.73MiB=0A=
GlobalReserve, single: total=3D36.77MiB, used=3D0.00B=0A=
=0A=
Full dmesg:=0A=
[    0.000000] Linux version 5.15.3_p1-debian-sources (portage@localhost) (=
gcc (Funtoo 11.2.0) 11.2.0, GNU ld (Funtoo {version} patchset: https://dev.=
gentoo.org/~dilfridge/distfiles/binutils-2.36.1-patches-3.tar.xz) 2.36.1) #=
1 SMP Mon Nov 22 22:10:28 -00 2021=0A=
[    0.000000] Command line: BOOT_IMAGE=3D/kernel-debian-sources-x86_64-5.1=
5.3_p1 rootwait resume=3D/dev/nvme0n1p5 real_root=3D/dev/nvme0n1p6 real_roo=
tflags=3Dssd,space_cache,subvolid=3D5,subvol=3D/ rootfstype=3Dbtrfs rand_id=
=3DX9UJ3KA2=0A=
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'=0A=
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'=0A=
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'=0A=
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256=0A=
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 by=
tes, using 'compacted' format.=0A=
[    0.000000] signal: max sigframe size: 1776=0A=
[    0.000000] BIOS-provided physical RAM map:=0A=
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usabl=
e=0A=
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reser=
ved=0A=
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usabl=
e=0A=
[    0.000000] BIOS-e820: [mem 0x0000000009b00000-0x0000000009dfffff] reser=
ved=0A=
[    0.000000] BIOS-e820: [mem 0x0000000009e00000-0x0000000009efffff] usabl=
e=0A=
[    0.000000] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f0ffff] ACPI =
NVS=0A=
[    0.000000] BIOS-e820: [mem 0x0000000009f10000-0x00000000bab68fff] usabl=
e=0A=
[    0.000000] BIOS-e820: [mem 0x00000000bab69000-0x00000000bbd68fff] reser=
ved=0A=
[    0.000000] BIOS-e820: [mem 0x00000000bbd69000-0x00000000c9f7efff] usabl=
e=0A=
[    0.000000] BIOS-e820: [mem 0x00000000c9f7f000-0x00000000caf7efff] type =
20=0A=
[    0.000000] BIOS-e820: [mem 0x00000000caf7f000-0x00000000ccf7efff] reser=
ved=0A=
[    0.000000] BIOS-e820: [mem 0x00000000ccf7f000-0x00000000cdf7efff] ACPI =
NVS=0A=
[    0.000000] BIOS-e820: [mem 0x00000000cdf7f000-0x00000000cdffefff] ACPI =
data=0A=
[    0.000000] BIOS-e820: [mem 0x00000000cdfff000-0x00000000cdffffff] usabl=
e=0A=
[    0.000000] BIOS-e820: [mem 0x00000000ce000000-0x00000000ceffffff] reser=
ved=0A=
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reser=
ved=0A=
[    0.000000] BIOS-e820: [mem 0x00000000fde00000-0x00000000fdefffff] reser=
ved=0A=
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reser=
ved=0A=
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reser=
ved=0A=
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reser=
ved=0A=
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved=0A=
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000fff2ffff] reser=
ved=0A=
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000060f33ffff] usabl=
e=0A=
[    0.000000] BIOS-e820: [mem 0x000000060f340000-0x000000062fffffff] reser=
ved=0A=
[    0.000000] NX (Execute Disable) protection: active=0A=
[    0.000000] efi: EFI v2.70 by INSYDE Corp.=0A=
[    0.000000] efi: ACPI=3D0xcdffe000 ACPI 2.0=3D0xcdffe014 TPMFinalLog=3D0=
xcdf1d000 SMBIOS=3D0xcb70b000 SMBIOS 3.0=3D0xcb709000 ESRT=3D0xcb707a98 MEM=
ATTR=3D0xb649d018 =0A=
[    0.000000] secureboot: Secure boot could not be determined (mode 0)=0A=
[    0.000000] SMBIOS 3.2.0 present.=0A=
[    0.000000] DMI: Acer Aspire A515-44/Calla_RN, BIOS V1.12 03/15/2021=0A=
[    0.000000] tsc: Fast TSC calibration using PIT=0A=
[    0.000000] tsc: Detected 1996.229 MHz processor=0A=
[    0.000573] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved=0A=
[    0.000575] e820: remove [mem 0x000a0000-0x000fffff] usable=0A=
[    0.000580] last_pfn =3D 0x60f340 max_arch_pfn =3D 0x400000000=0A=
[    0.000750] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
  =0A=
[    0.001073] last_pfn =3D 0xce000 max_arch_pfn =3D 0x400000000=0A=
[    0.005041] esrt: Reserving ESRT space from 0x00000000cb707a98 to 0x0000=
0000cb707ad0.=0A=
[    0.005050] Using GB pages for direct mapping=0A=
[    0.005589] RAMDISK: [mem 0x36f45000-0x37799fff]=0A=
[    0.005595] ACPI: Early table checksum verification disabled=0A=
[    0.005598] ACPI: RSDP 0x00000000CDFFE014 000024 (v02 ACRSYS)=0A=
[    0.005601] ACPI: XSDT 0x00000000CDFC6188 000114 (v01 ACRSYS ACRPRDCT 00=
000002      01000013)=0A=
[    0.005605] ACPI: FACP 0x00000000CDFED000 00010C (v05 ACRSYS ACRPRDCT 00=
000002 1025 00040000)=0A=
[    0.005609] ACPI: DSDT 0x00000000CDFDF000 007701 (v01 ACRSYS ACRPRDCT 00=
000002 1025 00040000)=0A=
[    0.005612] ACPI: FACS 0x00000000CDF1A000 000040=0A=
[    0.005614] ACPI: UEFI 0x00000000CDF7E000 000236 (v01 ACRSYS ACRPRDCT 00=
000001 1025 00040000)=0A=
[    0.005616] ACPI: SSDT 0x00000000CDFF5000 007216 (v02 ACRSYS ACRPRDCT 00=
000002 1025 00040000)=0A=
[    0.005618] ACPI: IVRS 0x00000000CDFF4000 0001A4 (v02 ACRSYS ACRPRDCT 00=
000001 1025 00040000)=0A=
[    0.005620] ACPI: SSDT 0x00000000CDFF3000 000228 (v01 ACRSYS ACRPRDCT 00=
000001 1025 00040000)=0A=
[    0.005622] ACPI: SSDT 0x00000000CDFF2000 00046D (v01 ACRSYS ACRPRDCT 00=
001000 1025 00040000)=0A=
[    0.005624] ACPI: TPM2 0x00000000CDFF1000 000034 (v04 ACRSYS ACRPRDCT 00=
000002 1025 00040000)=0A=
[    0.005626] ACPI: MSDM 0x00000000CDFF0000 000055 (v03 ACRSYS ACRPRDCT 00=
000001 1025 00040000)=0A=
[    0.005628] ACPI: ASF! 0x00000000CDFEF000 0000A5 (v32 ACRSYS ACRPRDCT 00=
000002 1025 00040000)=0A=
[    0.005631] ACPI: BOOT 0x00000000CDFEE000 000028 (v01 ACRSYS ACRPRDCT 00=
000002 1025 00040000)=0A=
[    0.005633] ACPI: HPET 0x00000000CDFEC000 000038 (v01 ACRSYS ACRPRDCT 00=
000002 1025 00040000)=0A=
[    0.005635] ACPI: APIC 0x00000000CDFEB000 000138 (v03 ACRSYS ACRPRDCT 00=
000002 1025 00040000)=0A=
[    0.005637] ACPI: MCFG 0x00000000CDFEA000 00003C (v01 ACRSYS ACRPRDCT 00=
000002 1025 00040000)=0A=
[    0.005639] ACPI: WDAT 0x00000000CDFE8000 00017C (v01 ACRSYS ACRPRDCT 00=
000002 1025 00040000)=0A=
[    0.005641] ACPI: WDRT 0x00000000CDFE7000 000047 (v01 ACRSYS ACRPRDCT 00=
000002 1025 00040000)=0A=
[    0.005643] ACPI: SSDT 0x00000000CDFDE000 000080 (v01 ACRSYS ACRPRDCT 00=
000002 1025 00040000)=0A=
[    0.005645] ACPI: SSDT 0x00000000CDFD7000 006577 (v01 ACRSYS ACRPRDCT 00=
001000 1025 00040000)=0A=
[    0.005647] ACPI: VFCT 0x00000000CDFC9000 00D484 (v01 ACRSYS ACRPRDCT 00=
000001 1025 00040000)=0A=
[    0.005649] ACPI: SSDT 0x00000000CDFE9000 0000F8 (v01 ACRSYS ACRPRDCT 00=
001000 1025 00040000)=0A=
[    0.005652] ACPI: SSDT 0x00000000CDFC7000 001BF4 (v01 ACRSYS ACRPRDCT 00=
000001 1025 00040000)=0A=
[    0.005654] ACPI: CRAT 0x00000000CDFFD000 000F28 (v01 ACRSYS ACRPRDCT 00=
000001 1025 00040000)=0A=
[    0.005656] ACPI: CDIT 0x00000000CDFC5000 000029 (v01 ACRSYS ACRPRDCT 00=
000001 1025 00040000)=0A=
[    0.005658] ACPI: SSDT 0x00000000CDFC4000 000C78 (v01 ACRSYS ACRPRDCT 00=
000001 1025 00040000)=0A=
[    0.005660] ACPI: SSDT 0x00000000CDFC2000 0010A5 (v01 ACRSYS ACRPRDCT 00=
000001 1025 00040000)=0A=
[    0.005662] ACPI: SSDT 0x00000000CDFBE000 0030C8 (v01 ACRSYS ACRPRDCT 00=
000001 1025 00040000)=0A=
[    0.005664] ACPI: FPDT 0x00000000CDFBD000 000044 (v01 ACRSYS ACRPRDCT 00=
000002 1025 00040000)=0A=
[    0.005666] ACPI: WSMT 0x00000000CDFBB000 000028 (v01 ACRSYS ACRPRDCT 00=
000001 1025 00040000)=0A=
[    0.005668] ACPI: SSDT 0x00000000CDFBA000 00007D (v01 ACRSYS ACRPRDCT 00=
000001 1025 00040000)=0A=
[    0.005670] ACPI: SSDT 0x00000000CDFB9000 000517 (v01 ACRSYS ACRPRDCT 00=
000001 1025 00040000)=0A=
[    0.005672] ACPI: BGRT 0x00000000CDFBC000 000038 (v01 ACRSYS ACRPRDCT 00=
000001 1025 00040000)=0A=
[    0.005674] ACPI: Reserving FACP table memory at [mem 0xcdfed000-0xcdfed=
10b]=0A=
[    0.005675] ACPI: Reserving DSDT table memory at [mem 0xcdfdf000-0xcdfe6=
700]=0A=
[    0.005676] ACPI: Reserving FACS table memory at [mem 0xcdf1a000-0xcdf1a=
03f]=0A=
[    0.005677] ACPI: Reserving UEFI table memory at [mem 0xcdf7e000-0xcdf7e=
235]=0A=
[    0.005678] ACPI: Reserving SSDT table memory at [mem 0xcdff5000-0xcdffc=
215]=0A=
[    0.005679] ACPI: Reserving IVRS table memory at [mem 0xcdff4000-0xcdff4=
1a3]=0A=
[    0.005679] ACPI: Reserving SSDT table memory at [mem 0xcdff3000-0xcdff3=
227]=0A=
[    0.005680] ACPI: Reserving SSDT table memory at [mem 0xcdff2000-0xcdff2=
46c]=0A=
[    0.005681] ACPI: Reserving TPM2 table memory at [mem 0xcdff1000-0xcdff1=
033]=0A=
[    0.005682] ACPI: Reserving MSDM table memory at [mem 0xcdff0000-0xcdff0=
054]=0A=
[    0.005682] ACPI: Reserving ASF! table memory at [mem 0xcdfef000-0xcdfef=
0a4]=0A=
[    0.005683] ACPI: Reserving BOOT table memory at [mem 0xcdfee000-0xcdfee=
027]=0A=
[    0.005684] ACPI: Reserving HPET table memory at [mem 0xcdfec000-0xcdfec=
037]=0A=
[    0.005685] ACPI: Reserving APIC table memory at [mem 0xcdfeb000-0xcdfeb=
137]=0A=
[    0.005686] ACPI: Reserving MCFG table memory at [mem 0xcdfea000-0xcdfea=
03b]=0A=
[    0.005687] ACPI: Reserving WDAT table memory at [mem 0xcdfe8000-0xcdfe8=
17b]=0A=
[    0.005687] ACPI: Reserving WDRT table memory at [mem 0xcdfe7000-0xcdfe7=
046]=0A=
[    0.005688] ACPI: Reserving SSDT table memory at [mem 0xcdfde000-0xcdfde=
07f]=0A=
[    0.005689] ACPI: Reserving SSDT table memory at [mem 0xcdfd7000-0xcdfdd=
576]=0A=
[    0.005690] ACPI: Reserving VFCT table memory at [mem 0xcdfc9000-0xcdfd6=
483]=0A=
[    0.005691] ACPI: Reserving SSDT table memory at [mem 0xcdfe9000-0xcdfe9=
0f7]=0A=
[    0.005691] ACPI: Reserving SSDT table memory at [mem 0xcdfc7000-0xcdfc8=
bf3]=0A=
[    0.005692] ACPI: Reserving CRAT table memory at [mem 0xcdffd000-0xcdffd=
f27]=0A=
[    0.005693] ACPI: Reserving CDIT table memory at [mem 0xcdfc5000-0xcdfc5=
028]=0A=
[    0.005694] ACPI: Reserving SSDT table memory at [mem 0xcdfc4000-0xcdfc4=
c77]=0A=
[    0.005695] ACPI: Reserving SSDT table memory at [mem 0xcdfc2000-0xcdfc3=
0a4]=0A=
[    0.005696] ACPI: Reserving SSDT table memory at [mem 0xcdfbe000-0xcdfc1=
0c7]=0A=
[    0.005696] ACPI: Reserving FPDT table memory at [mem 0xcdfbd000-0xcdfbd=
043]=0A=
[    0.005697] ACPI: Reserving WSMT table memory at [mem 0xcdfbb000-0xcdfbb=
027]=0A=
[    0.005698] ACPI: Reserving SSDT table memory at [mem 0xcdfba000-0xcdfba=
07c]=0A=
[    0.005699] ACPI: Reserving SSDT table memory at [mem 0xcdfb9000-0xcdfb9=
516]=0A=
[    0.005700] ACPI: Reserving BGRT table memory at [mem 0xcdfbc000-0xcdfbc=
037]=0A=
[    0.005756] No NUMA configuration found=0A=
[    0.005756] Faking a node at [mem 0x0000000000000000-0x000000060f33ffff]=
=0A=
[    0.005765] NODE_DATA(0) allocated [mem 0x60f316000-0x60f33ffff]=0A=
[    0.006002] Zone ranges:=0A=
[    0.006003]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]=0A=
[    0.006004]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]=0A=
[    0.006005]   Normal   [mem 0x0000000100000000-0x000000060f33ffff]=0A=
[    0.006007]   Device   empty=0A=
[    0.006007] Movable zone start for each node=0A=
[    0.006009] Early memory node ranges=0A=
[    0.006010]   node   0: [mem 0x0000000000001000-0x000000000009efff]=0A=
[    0.006011]   node   0: [mem 0x0000000000100000-0x0000000009afffff]=0A=
[    0.006012]   node   0: [mem 0x0000000009e00000-0x0000000009efffff]=0A=
[    0.006013]   node   0: [mem 0x0000000009f10000-0x00000000bab68fff]=0A=
[    0.006014]   node   0: [mem 0x00000000bbd69000-0x00000000c9f7efff]=0A=
[    0.006014]   node   0: [mem 0x00000000cdfff000-0x00000000cdffffff]=0A=
[    0.006015]   node   0: [mem 0x0000000100000000-0x000000060f33ffff]=0A=
[    0.006017] Initmem setup node 0 [mem 0x0000000000001000-0x000000060f33f=
fff]=0A=
[    0.006020] On node 0, zone DMA: 1 pages in unavailable ranges=0A=
[    0.006045] On node 0, zone DMA: 97 pages in unavailable ranges=0A=
[    0.006267] On node 0, zone DMA32: 768 pages in unavailable ranges=0A=
[    0.011664] On node 0, zone DMA32: 16 pages in unavailable ranges=0A=
[    0.012143] On node 0, zone DMA32: 4608 pages in unavailable ranges=0A=
[    0.012286] On node 0, zone DMA32: 16512 pages in unavailable ranges=0A=
[    0.012612] On node 0, zone Normal: 8192 pages in unavailable ranges=0A=
[    0.012639] On node 0, zone Normal: 3264 pages in unavailable ranges=0A=
[    0.013044] ACPI: PM-Timer IO Port: 0x408=0A=
[    0.013050] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])=0A=
[    0.013052] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])=0A=
[    0.013052] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])=0A=
[    0.013053] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])=0A=
[    0.013054] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])=0A=
[    0.013054] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])=0A=
[    0.013055] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])=0A=
[    0.013056] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])=0A=
[    0.013057] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])=0A=
[    0.013057] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])=0A=
[    0.013058] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])=0A=
[    0.013059] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])=0A=
[    0.013059] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])=0A=
[    0.013060] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])=0A=
[    0.013061] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])=0A=
[    0.013061] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])=0A=
[    0.013074] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, GSI 0=
-23=0A=
[    0.013079] IOAPIC[1]: apic_id 34, version 33, address 0xfec01000, GSI 2=
4-55=0A=
[    0.013081] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)=0A=
[    0.013083] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)=
=0A=
[    0.013085] ACPI: Using ACPI (MADT) for SMP configuration information=0A=
[    0.013086] ACPI: HPET id: 0x10228210 base: 0xfed00000=0A=
[    0.013094] e820: update [mem 0xb58b8000-0xb59abfff] usable =3D=3D> rese=
rved=0A=
[    0.013103] smpboot: Allowing 16 CPUs, 8 hotplug CPUs=0A=
[    0.013126] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]=0A=
[    0.013128] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x000bffff]=0A=
[    0.013129] PM: hibernation: Registered nosave memory: [mem 0x000c0000-0=
x000fffff]=0A=
[    0.013130] PM: hibernation: Registered nosave memory: [mem 0x09b00000-0=
x09dfffff]=0A=
[    0.013132] PM: hibernation: Registered nosave memory: [mem 0x09f00000-0=
x09f0ffff]=0A=
[    0.013133] PM: hibernation: Registered nosave memory: [mem 0xb58b8000-0=
xb59abfff]=0A=
[    0.013135] PM: hibernation: Registered nosave memory: [mem 0xbab69000-0=
xbbd68fff]=0A=
[    0.013136] PM: hibernation: Registered nosave memory: [mem 0xc9f7f000-0=
xcaf7efff]=0A=
[    0.013137] PM: hibernation: Registered nosave memory: [mem 0xcaf7f000-0=
xccf7efff]=0A=
[    0.013138] PM: hibernation: Registered nosave memory: [mem 0xccf7f000-0=
xcdf7efff]=0A=
[    0.013138] PM: hibernation: Registered nosave memory: [mem 0xcdf7f000-0=
xcdffefff]=0A=
[    0.013140] PM: hibernation: Registered nosave memory: [mem 0xce000000-0=
xceffffff]=0A=
[    0.013140] PM: hibernation: Registered nosave memory: [mem 0xcf000000-0=
xf7ffffff]=0A=
[    0.013141] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0=
xfbffffff]=0A=
[    0.013142] PM: hibernation: Registered nosave memory: [mem 0xfc000000-0=
xfddfffff]=0A=
[    0.013142] PM: hibernation: Registered nosave memory: [mem 0xfde00000-0=
xfdefffff]=0A=
[    0.013143] PM: hibernation: Registered nosave memory: [mem 0xfdf00000-0=
xfebfffff]=0A=
[    0.013144] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xfec00fff]=0A=
[    0.013144] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0=
xfec0ffff]=0A=
[    0.013145] PM: hibernation: Registered nosave memory: [mem 0xfec10000-0=
xfec10fff]=0A=
[    0.013146] PM: hibernation: Registered nosave memory: [mem 0xfec11000-0=
xfed7ffff]=0A=
[    0.013147] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0=
xfed80fff]=0A=
[    0.013147] PM: hibernation: Registered nosave memory: [mem 0xfed81000-0=
xfedfffff]=0A=
[    0.013148] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]=0A=
[    0.013149] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xfeffffff]=0A=
[    0.013149] PM: hibernation: Registered nosave memory: [mem 0xff000000-0=
xfff2ffff]=0A=
[    0.013150] PM: hibernation: Registered nosave memory: [mem 0xfff30000-0=
xffffffff]=0A=
[    0.013151] [mem 0xcf000000-0xf7ffffff] available for PCI devices=0A=
[    0.013153] Booting paravirtualized kernel on bare hardware=0A=
[    0.013155] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 7645519600211568 ns=0A=
[    0.016170] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16 =
nr_node_ids:1=0A=
[    0.016792] percpu: Embedded 60 pages/cpu s208896 r8192 d28672 u262144=
=0A=
[    0.016801] pcpu-alloc: s208896 r8192 d28672 u262144 alloc=3D1*2097152=
=0A=
[    0.016802] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 1=
3 14 15 =0A=
[    0.016833] Built 1 zonelists, mobility grouping on.  Total pages: 60310=
33=0A=
[    0.016835] Policy zone: Normal=0A=
[    0.016836] Kernel command line: BOOT_IMAGE=3D/kernel-debian-sources-x86=
_64-5.15.3_p1 rootwait resume=3D/dev/nvme0n1p5 real_root=3D/dev/nvme0n1p6 r=
eal_rootflags=3Dssd,space_cache,subvolid=3D5,subvol=3D/ rootfstype=3Dbtrfs =
rand_id=3DX9UJ3KA2=0A=
[    0.016883] Unknown kernel command line parameters "BOOT_IMAGE=3D/kernel=
-debian-sources-x86_64-5.15.3_p1 real_root=3D/dev/nvme0n1p6 real_rootflags=
=3Dssd,space_cache,subvolid=3D5,subvol=3D/ rand_id=3DX9UJ3KA2", will be pas=
sed to user space.=0A=
[    0.020432] Dentry cache hash table entries: 4194304 (order: 13, 3355443=
2 bytes, linear)=0A=
[    0.022206] Inode-cache hash table entries: 2097152 (order: 12, 16777216=
 bytes, linear)=0A=
[    0.022251] mem auto-init: stack:off, heap alloc:on, heap free:off=0A=
[    0.054590] Memory: 3285128K/24507704K available (12299K kernel code, 29=
22K rwdata, 4668K rodata, 2692K init, 4656K bss, 606696K reserved, 0K cma-r=
eserved)=0A=
[    0.054598] random: get_random_u64 called from __kmem_cache_create+0x2a/=
0x4d0 with crng_init=3D0=0A=
[    0.054740] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D16, =
Nodes=3D1=0A=
[    0.054757] ftrace: allocating 40390 entries in 158 pages=0A=
[    0.065231] ftrace: allocated 158 pages with 5 groups=0A=
[    0.065356] rcu: Hierarchical RCU implementation.=0A=
[    0.065356] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D16.=0A=
[    0.065358] 	Rude variant of Tasks RCU enabled.=0A=
[    0.065358] 	Tracing variant of Tasks RCU enabled.=0A=
[    0.065359] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.=0A=
[    0.065360] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D16=0A=
[    0.068071] NR_IRQS: 524544, nr_irqs: 1096, preallocated irqs: 16=0A=
[    0.068420] random: crng done (trusting CPU's manufacturer)=0A=
[    0.068441] Console: colour dummy device 80x25=0A=
[    0.068637] printk: console [tty0] enabled=0A=
[    0.068657] ACPI: Core revision 20210730=0A=
[    0.068842] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 133484873504 ns=0A=
[    0.068861] APIC: Switch to symmetric I/O mode setup=0A=
[    0.069646] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, rdevid:160=0A=
[    0.069648] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, rdevid:160=0A=
[    0.069650] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, rdevid:160=0A=
[    0.069651] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, rdevid:160=0A=
[    0.069935] Switched APIC routing to physical flat.=0A=
[    0.070665] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1=0A=
[    0.088868] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x398c88a8177, max_idle_ns: 881590816232 ns=0A=
[    0.088879] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 3992.45 BogoMIPS (lpj=3D7984916)=0A=
[    0.088882] pid_max: default: 32768 minimum: 301=0A=
[    0.092921] LSM: Security Framework initializing=0A=
[    0.092939] Yama: disabled by default; enable with sysctl kernel.yama.*=
=0A=
[    0.092973] AppArmor: AppArmor initialized=0A=
[    0.092976] TOMOYO Linux initialized=0A=
[    0.093063] Mount-cache hash table entries: 65536 (order: 7, 524288 byte=
s, linear)=0A=
[    0.093130] Mountpoint-cache hash table entries: 65536 (order: 7, 524288=
 bytes, linear)=0A=
[    0.093385] x86/cpu: User Mode Instruction Prevention (UMIP) activated=
=0A=
[    0.093447] LVT offset 1 assigned for vector 0xf9=0A=
[    0.093555] LVT offset 2 assigned for vector 0xf4=0A=
[    0.093582] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512=0A=
[    0.093584] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0=
=0A=
[    0.093591] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization=0A=
[    0.093596] Spectre V2 : Mitigation: Full AMD retpoline=0A=
[    0.093598] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch=0A=
[    0.093601] Spectre V2 : Enabling Restricted Speculation for firmware ca=
lls=0A=
[    0.093604] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier=0A=
[    0.093607] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl and seccomp=0A=
[    0.097891] Freeing SMP alternatives memory: 36K=0A=
[    0.209384] smpboot: CPU0: AMD Ryzen 7 4700U with Radeon Graphics (famil=
y: 0x17, model: 0x60, stepping: 0x1)=0A=
[    0.209536] Performance Events: Fam17h+ core perfctr, AMD PMU driver.=0A=
[    0.209543] ... version:                0=0A=
[    0.209544] ... bit width:              48=0A=
[    0.209545] ... generic registers:      6=0A=
[    0.209546] ... value mask:             0000ffffffffffff=0A=
[    0.209547] ... max period:             00007fffffffffff=0A=
[    0.209549] ... fixed-purpose events:   0=0A=
[    0.209550] ... event mask:             000000000000003f=0A=
[    0.209602] rcu: Hierarchical SRCU implementation.=0A=
[    0.209938] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.=0A=
[    0.210094] smp: Bringing up secondary CPUs ...=0A=
[    0.210170] x86: Booting SMP configuration:=0A=
[    0.210172] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7=0A=
[    0.224930] smp: Brought up 1 node, 8 CPUs=0A=
[    0.224932] smpboot: Max logical packages: 2=0A=
[    0.224934] smpboot: Total of 8 processors activated (31939.66 BogoMIPS)=
=0A=
[    0.256921] node 0 deferred pages initialised in 32ms=0A=
[    0.258178] devtmpfs: initialized=0A=
[    0.258178] x86/mm: Memory block size: 128MB=0A=
[    0.258178] ACPI: PM: Registering ACPI NVS region [mem 0x09f00000-0x09f0=
ffff] (65536 bytes)=0A=
[    0.258178] ACPI: PM: Registering ACPI NVS region [mem 0xccf7f000-0xcdf7=
efff] (16777216 bytes)=0A=
[    0.258178] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns=0A=
[    0.258178] futex hash table entries: 4096 (order: 6, 262144 bytes, line=
ar)=0A=
[    0.258178] pinctrl core: initialized pinctrl subsystem=0A=
[    0.261221] NET: Registered PF_NETLINK/PF_ROUTE protocol family=0A=
[    0.261888] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic alloca=
tions=0A=
[    0.262578] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations=0A=
[    0.263280] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations=0A=
[    0.263298] audit: initializing netlink subsys (disabled)=0A=
[    0.263319] audit: type=3D2000 audit(1638454930.192:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1=0A=
[    0.263319] thermal_sys: Registered thermal governor 'fair_share'=0A=
[    0.263319] thermal_sys: Registered thermal governor 'bang_bang'=0A=
[    0.263319] thermal_sys: Registered thermal governor 'step_wise'=0A=
[    0.263319] thermal_sys: Registered thermal governor 'user_space'=0A=
[    0.263319] thermal_sys: Registered thermal governor 'power_allocator'=
=0A=
[    0.263319] cpuidle: using governor ladder=0A=
[    0.263319] cpuidle: using governor menu=0A=
[    0.263319] Simple Boot Flag at 0x44 set to 0x1=0A=
[    0.263319] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it=0A=
[    0.263319] ACPI: bus type PCI registered=0A=
[    0.263319] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5=0A=
[    0.263319] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000=
-0xfbffffff] (base 0xf8000000)=0A=
[    0.263319] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E82=
0=0A=
[    0.263319] PCI: Using configuration type 1 for base access=0A=
[    0.263319] Kprobes globally optimized=0A=
[    0.264900] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages=
=0A=
[    0.264900] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages=
=0A=
[    0.345003] ACPI: Added _OSI(Module Device)=0A=
[    0.345010] ACPI: Added _OSI(Processor Device)=0A=
[    0.345014] ACPI: Added _OSI(3.0 _SCP Extensions)=0A=
[    0.345018] ACPI: Added _OSI(Processor Aggregator Device)=0A=
[    0.345023] ACPI: Added _OSI(Linux-Dell-Video)=0A=
[    0.345026] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)=0A=
[    0.345030] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)=0A=
[    0.352062] ACPI: 13 ACPI AML tables successfully acquired and loaded=0A=
[    0.352797] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored=0A=
[    0.353834] ACPI: EC: EC started=0A=
[    0.353835] ACPI: EC: interrupt blocked=0A=
[    0.355435] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62=0A=
[    0.355438] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC used to handle tran=
sactions=0A=
[    0.355441] ACPI: Interpreter enabled=0A=
[    0.355451] ACPI: PM: (supports S0 S3 S4 S5)=0A=
[    0.355452] ACPI: Using IOAPIC for interrupt routing=0A=
[    0.355556] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug=0A=
[    0.355759] ACPI: Enabled 3 GPEs in block 00 to 1F=0A=
[    0.356370] ACPI: PM: Power Resource [WRST]=0A=
[    0.356807] ACPI: PM: Power Resource [P0S0]=0A=
[    0.356817] ACPI: PM: Power Resource [P3S0]=0A=
[    0.356872] ACPI: PM: Power Resource [P0S1]=0A=
[    0.356885] ACPI: PM: Power Resource [P3S1]=0A=
[    0.358890] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])=0A=
[    0.358896] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]=0A=
[    0.358969] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplu=
g LTR]=0A=
[    0.359035] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER =
PCIeCapability]=0A=
[    0.359037] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration=0A=
[    0.359047] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [=
bus 00-3f] only partially covers this bridge=0A=
[    0.359205] PCI host bridge to bus 0000:00=0A=
[    0.359207] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window=
]=0A=
[    0.359210] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window=
]=0A=
[    0.359212] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]=0A=
[    0.359214] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3ff=
f window]=0A=
[    0.359216] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7ff=
f window]=0A=
[    0.359218] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbff=
f window]=0A=
[    0.359220] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cfff=
f window]=0A=
[    0.359222] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3ff=
f window]=0A=
[    0.359224] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7ff=
f window]=0A=
[    0.359226] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbff=
f window]=0A=
[    0.359228] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dfff=
f window]=0A=
[    0.359229] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3ff=
f window]=0A=
[    0.359232] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7ff=
f window]=0A=
[    0.359233] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebff=
f window]=0A=
[    0.359235] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000efff=
f window]=0A=
[    0.359237] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xf7fffff=
f window]=0A=
[    0.359239] pci_bus 0000:00: root bus resource [mem 0xfc000000-0xfed3fff=
f window]=0A=
[    0.359241] pci_bus 0000:00: root bus resource [mem 0x650200000-0xfcffff=
ffff window]=0A=
[    0.359243] pci_bus 0000:00: root bus resource [bus 00-ff]=0A=
[    0.359261] pci 0000:00:00.0: [1022:1630] type 00 class 0x060000=0A=
[    0.359344] pci 0000:00:00.2: [1022:1631] type 00 class 0x080600=0A=
[    0.359419] pci 0000:00:01.0: [1022:1632] type 00 class 0x060000=0A=
[    0.359500] pci 0000:00:01.1: [1022:1633] type 01 class 0x060400=0A=
[    0.359647] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold=0A=
[    0.359790] pci 0000:00:01.2: [1022:1634] type 01 class 0x060400=0A=
[    0.359845] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold=0A=
[    0.359926] pci 0000:00:01.3: [1022:1634] type 01 class 0x060400=0A=
[    0.359981] pci 0000:00:01.3: PME# supported from D0 D3hot D3cold=0A=
[    0.360064] pci 0000:00:02.0: [1022:1632] type 00 class 0x060000=0A=
[    0.360130] pci 0000:00:02.1: [1022:1634] type 01 class 0x060400=0A=
[    0.360184] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold=0A=
[    0.360267] pci 0000:00:08.0: [1022:1632] type 00 class 0x060000=0A=
[    0.360335] pci 0000:00:08.1: [1022:1635] type 01 class 0x060400=0A=
[    0.360354] pci 0000:00:08.1: enabling Extended Tags=0A=
[    0.360382] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold=0A=
[    0.360452] pci 0000:00:08.2: [1022:1635] type 01 class 0x060400=0A=
[    0.360472] pci 0000:00:08.2: enabling Extended Tags=0A=
[    0.360499] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold=0A=
[    0.360584] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500=0A=
[    0.360695] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100=0A=
[    0.360810] pci 0000:00:18.0: [1022:1448] type 00 class 0x060000=0A=
[    0.360850] pci 0000:00:18.1: [1022:1449] type 00 class 0x060000=0A=
[    0.360889] pci 0000:00:18.2: [1022:144a] type 00 class 0x060000=0A=
[    0.360926] pci 0000:00:18.3: [1022:144b] type 00 class 0x060000=0A=
[    0.360970] pci 0000:00:18.4: [1022:144c] type 00 class 0x060000=0A=
[    0.361005] pci 0000:00:18.5: [1022:144d] type 00 class 0x060000=0A=
[    0.361041] pci 0000:00:18.6: [1022:144e] type 00 class 0x060000=0A=
[    0.361077] pci 0000:00:18.7: [1022:144f] type 00 class 0x060000=0A=
[    0.361163] pci 0000:00:01.1: PCI bridge to [bus 01]=0A=
[    0.361251] pci 0000:02:00.0: [1c5c:174a] type 00 class 0x010802=0A=
[    0.361267] pci 0000:02:00.0: reg 0x10: [mem 0xd0800000-0xd0803fff 64bit=
]=0A=
[    0.361276] pci 0000:02:00.0: reg 0x18: [mem 0xd0805000-0xd0805fff]=0A=
[    0.361284] pci 0000:02:00.0: reg 0x1c: [mem 0xd0804000-0xd0804fff]=0A=
[    0.361468] pci 0000:00:01.2: PCI bridge to [bus 02]=0A=
[    0.361472] pci 0000:00:01.2:   bridge window [mem 0xd0800000-0xd08fffff=
]=0A=
[    0.361518] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000=0A=
[    0.361535] pci 0000:03:00.0: reg 0x10: [io  0x2000-0x20ff]=0A=
[    0.361557] pci 0000:03:00.0: reg 0x18: [mem 0xd0704000-0xd0704fff 64bit=
]=0A=
[    0.361571] pci 0000:03:00.0: reg 0x20: [mem 0xd0700000-0xd0703fff 64bit=
]=0A=
[    0.361655] pci 0000:03:00.0: supports D1 D2=0A=
[    0.361657] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold=
=0A=
[    0.361753] pci 0000:00:01.3: PCI bridge to [bus 03]=0A=
[    0.361756] pci 0000:00:01.3:   bridge window [io  0x2000-0x2fff]=0A=
[    0.361759] pci 0000:00:01.3:   bridge window [mem 0xd0700000-0xd07fffff=
]=0A=
[    0.361919] pci 0000:04:00.0: [168c:003e] type 00 class 0x028000=0A=
[    0.362059] pci 0000:04:00.0: reg 0x10: [mem 0xd0000000-0xd01fffff 64bit=
]=0A=
[    0.362609] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold=0A=
[    0.363099] pci 0000:00:02.1: PCI bridge to [bus 04]=0A=
[    0.363103] pci 0000:00:02.1:   bridge window [mem 0xd0000000-0xd01fffff=
]=0A=
[    0.363162] pci 0000:05:00.0: [1002:1636] type 00 class 0x030000=0A=
[    0.363173] pci 0000:05:00.0: reg 0x10: [mem 0xfce0000000-0xfcefffffff 6=
4bit pref]=0A=
[    0.363181] pci 0000:05:00.0: reg 0x18: [mem 0xfcf0000000-0xfcf01fffff 6=
4bit pref]=0A=
[    0.363187] pci 0000:05:00.0: reg 0x20: [io  0x1000-0x10ff]=0A=
[    0.363192] pci 0000:05:00.0: reg 0x24: [mem 0xd0600000-0xd067ffff]=0A=
[    0.363200] pci 0000:05:00.0: enabling Extended Tags=0A=
[    0.363210] pci 0000:05:00.0: BAR 0: assigned to efifb=0A=
[    0.363246] pci 0000:05:00.0: PME# supported from D1 D2 D3hot D3cold=0A=
[    0.363324] pci 0000:05:00.1: [1002:1637] type 00 class 0x040300=0A=
[    0.363331] pci 0000:05:00.1: reg 0x10: [mem 0xd06c8000-0xd06cbfff]=0A=
[    0.363351] pci 0000:05:00.1: enabling Extended Tags=0A=
[    0.363377] pci 0000:05:00.1: PME# supported from D1 D2 D3hot D3cold=0A=
[    0.363426] pci 0000:05:00.2: [1022:15df] type 00 class 0x108000=0A=
[    0.363438] pci 0000:05:00.2: reg 0x18: [mem 0xd0500000-0xd05fffff]=0A=
[    0.363447] pci 0000:05:00.2: reg 0x24: [mem 0xd06cc000-0xd06cdfff]=0A=
[    0.363455] pci 0000:05:00.2: enabling Extended Tags=0A=
[    0.363533] pci 0000:05:00.3: [1022:1639] type 00 class 0x0c0330=0A=
[    0.363544] pci 0000:05:00.3: reg 0x10: [mem 0xd0400000-0xd04fffff 64bit=
]=0A=
[    0.363566] pci 0000:05:00.3: enabling Extended Tags=0A=
[    0.363594] pci 0000:05:00.3: PME# supported from D0 D3hot D3cold=0A=
[    0.363645] pci 0000:05:00.4: [1022:1639] type 00 class 0x0c0330=0A=
[    0.363655] pci 0000:05:00.4: reg 0x10: [mem 0xd0300000-0xd03fffff 64bit=
]=0A=
[    0.363677] pci 0000:05:00.4: enabling Extended Tags=0A=
[    0.363705] pci 0000:05:00.4: PME# supported from D0 D3hot D3cold=0A=
[    0.363758] pci 0000:05:00.5: [1022:15e2] type 00 class 0x048000=0A=
[    0.363765] pci 0000:05:00.5: reg 0x10: [mem 0xd0680000-0xd06bffff]=0A=
[    0.363785] pci 0000:05:00.5: enabling Extended Tags=0A=
[    0.363811] pci 0000:05:00.5: PME# supported from D0 D3hot D3cold=0A=
[    0.363859] pci 0000:05:00.6: [1022:15e3] type 00 class 0x040300=0A=
[    0.363867] pci 0000:05:00.6: reg 0x10: [mem 0xd06c0000-0xd06c7fff]=0A=
[    0.363887] pci 0000:05:00.6: enabling Extended Tags=0A=
[    0.363912] pci 0000:05:00.6: PME# supported from D0 D3hot D3cold=0A=
[    0.363967] pci 0000:00:08.1: PCI bridge to [bus 05]=0A=
[    0.363970] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]=0A=
[    0.363973] pci 0000:00:08.1:   bridge window [mem 0xd0300000-0xd06fffff=
]=0A=
[    0.363976] pci 0000:00:08.1:   bridge window [mem 0xfce0000000-0xfcf01f=
ffff 64bit pref]=0A=
[    0.364013] pci 0000:06:00.0: [1022:7901] type 00 class 0x010601=0A=
[    0.364039] pci 0000:06:00.0: reg 0x24: [mem 0xd0201000-0xd02017ff]=0A=
[    0.364048] pci 0000:06:00.0: enabling Extended Tags=0A=
[    0.364137] pci 0000:06:00.1: [1022:7901] type 00 class 0x010601=0A=
[    0.364164] pci 0000:06:00.1: reg 0x24: [mem 0xd0200000-0xd02007ff]=0A=
[    0.364172] pci 0000:06:00.1: enabling Extended Tags=0A=
[    0.364252] pci 0000:00:08.2: PCI bridge to [bus 06]=0A=
[    0.364256] pci 0000:00:08.2:   bridge window [mem 0xd0200000-0xd02fffff=
]=0A=
[    0.364537] ACPI: PCI: Interrupt link LNKA configured for IRQ 0=0A=
[    0.364540] ACPI: PCI: Interrupt link LNKA disabled=0A=
[    0.364582] ACPI: PCI: Interrupt link LNKB configured for IRQ 0=0A=
[    0.364583] ACPI: PCI: Interrupt link LNKB disabled=0A=
[    0.364614] ACPI: PCI: Interrupt link LNKC configured for IRQ 0=0A=
[    0.364615] ACPI: PCI: Interrupt link LNKC disabled=0A=
[    0.364657] ACPI: PCI: Interrupt link LNKD configured for IRQ 0=0A=
[    0.364658] ACPI: PCI: Interrupt link LNKD disabled=0A=
[    0.364695] ACPI: PCI: Interrupt link LNKE configured for IRQ 0=0A=
[    0.364697] ACPI: PCI: Interrupt link LNKE disabled=0A=
[    0.364726] ACPI: PCI: Interrupt link LNKF configured for IRQ 0=0A=
[    0.364727] ACPI: PCI: Interrupt link LNKF disabled=0A=
[    0.364756] ACPI: PCI: Interrupt link LNKG configured for IRQ 0=0A=
[    0.364757] ACPI: PCI: Interrupt link LNKG disabled=0A=
[    0.364786] ACPI: PCI: Interrupt link LNKH configured for IRQ 0=0A=
[    0.364787] ACPI: PCI: Interrupt link LNKH disabled=0A=
[    0.365173] ACPI: EC: interrupt unblocked=0A=
[    0.365175] ACPI: EC: event unblocked=0A=
[    0.365181] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62=0A=
[    0.365182] ACPI: EC: GPE=3D0x3=0A=
[    0.365183] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC initialization comp=
lete=0A=
[    0.365185] ACPI: \_SB_.PCI0.LPC0.EC0_: EC: Used to handle transactions =
and events=0A=
[    0.365224] iommu: Default domain type: Translated =0A=
[    0.365224] iommu: DMA domain TLB invalidation policy: lazy mode =0A=
[    0.365224] pci 0000:05:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dnone,locks=3Dnone=0A=
[    0.365224] pci 0000:05:00.0: vgaarb: bridge control possible=0A=
[    0.365224] pci 0000:05:00.0: vgaarb: setting as boot device=0A=
[    0.365224] vgaarb: loaded=0A=
[    0.366591] EDAC MC: Ver: 3.0.0=0A=
[    0.366718] Registered efivars operations=0A=
[    0.366718] NetLabel: Initializing=0A=
[    0.366718] NetLabel:  domain hash size =3D 128=0A=
[    0.366718] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO=0A=
[    0.366718] NetLabel:  unlabeled traffic allowed by default=0A=
[    0.366718] PCI: Using ACPI for IRQ routing=0A=
[    0.369489] PCI: pci_cache_line_size set to 64 bytes=0A=
[    0.369661] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]=0A=
[    0.369662] e820: reserve RAM buffer [mem 0x09b00000-0x0bffffff]=0A=
[    0.369663] e820: reserve RAM buffer [mem 0x09f00000-0x0bffffff]=0A=
[    0.369663] e820: reserve RAM buffer [mem 0xb58b8000-0xb7ffffff]=0A=
[    0.369664] e820: reserve RAM buffer [mem 0xbab69000-0xbbffffff]=0A=
[    0.369664] e820: reserve RAM buffer [mem 0xc9f7f000-0xcbffffff]=0A=
[    0.369665] e820: reserve RAM buffer [mem 0xce000000-0xcfffffff]=0A=
[    0.369666] e820: reserve RAM buffer [mem 0x60f340000-0x60fffffff]=0A=
[    0.369692] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0=0A=
[    0.369696] hpet0: 3 comparators, 32-bit 14.318180 MHz counter=0A=
[    0.371998] clocksource: Switched to clocksource tsc-early=0A=
[    0.375621] VFS: Disk quotas dquot_6.6.0=0A=
[    0.375639] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)=0A=
[    0.375734] AppArmor: AppArmor Filesystem Enabled=0A=
[    0.375750] pnp: PnP ACPI init=0A=
[    0.375878] system 00:00: [mem 0xfec00000-0xfec01fff] could not be reser=
ved=0A=
[    0.375884] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved=
=0A=
[    0.375886] system 00:00: [mem 0xfde00000-0xfdefffff] has been reserved=
=0A=
[    0.376012] system 00:03: [io  0x0400-0x04cf] has been reserved=0A=
[    0.376015] system 00:03: [io  0x04d0-0x04d1] has been reserved=0A=
[    0.376016] system 00:03: [io  0x04d6] has been reserved=0A=
[    0.376018] system 00:03: [io  0x0c00-0x0c01] has been reserved=0A=
[    0.376020] system 00:03: [io  0x0c14] has been reserved=0A=
[    0.376021] system 00:03: [io  0x0c50-0x0c52] has been reserved=0A=
[    0.376023] system 00:03: [io  0x0c6c] has been reserved=0A=
[    0.376025] system 00:03: [io  0x0c6f] has been reserved=0A=
[    0.376026] system 00:03: [io  0x0cd0-0x0cdb] has been reserved=0A=
[    0.376060] system 00:04: [mem 0x000e0000-0x000fffff] could not be reser=
ved=0A=
[    0.376062] system 00:04: [mem 0xff000000-0xffffffff] could not be reser=
ved=0A=
[    0.376357] pnp: PnP ACPI: found 5 devices=0A=
[    0.383971] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns=0A=
[    0.384064] NET: Registered PF_INET protocol family=0A=
[    0.384404] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)=0A=
[    0.385697] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6=
, 262144 bytes, linear)=0A=
[    0.386048] TCP established hash table entries: 262144 (order: 9, 209715=
2 bytes, linear)=0A=
[    0.386413] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes,=
 linear)=0A=
[    0.386479] TCP: Hash tables configured (established 262144 bind 65536)=
=0A=
[    0.386712] MPTCP token hash table entries: 32768 (order: 7, 786432 byte=
s, linear)=0A=
[    0.386831] UDP hash table entries: 16384 (order: 7, 524288 bytes, linea=
r)=0A=
[    0.386947] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, =
linear)=0A=
[    0.387035] NET: Registered PF_UNIX/PF_LOCAL protocol family=0A=
[    0.387040] NET: Registered PF_XDP protocol family=0A=
[    0.387055] pci 0000:00:01.1: bridge window [io  0x1000-0x0fff] to [bus =
01] add_size 1000=0A=
[    0.387059] pci 0000:00:01.1: bridge window [mem 0x00100000-0x000fffff 6=
4bit pref] to [bus 01] add_size 200000 add_align 100000=0A=
[    0.387062] pci 0000:00:01.1: bridge window [mem 0x00100000-0x000fffff] =
to [bus 01] add_size 200000 add_align 100000=0A=
[    0.387076] pci 0000:00:01.1: BAR 14: assigned [mem 0xd0900000-0xd0affff=
f]=0A=
[    0.387082] pci 0000:00:01.1: BAR 15: assigned [mem 0x650200000-0x6503ff=
fff 64bit pref]=0A=
[    0.387085] pci 0000:00:01.1: BAR 13: assigned [io  0x3000-0x3fff]=0A=
[    0.387088] pci 0000:00:01.1: PCI bridge to [bus 01]=0A=
[    0.387091] pci 0000:00:01.1:   bridge window [io  0x3000-0x3fff]=0A=
[    0.387097] pci 0000:00:01.1:   bridge window [mem 0xd0900000-0xd0afffff=
]=0A=
[    0.387100] pci 0000:00:01.1:   bridge window [mem 0x650200000-0x6503fff=
ff 64bit pref]=0A=
[    0.387107] pci 0000:00:01.2: PCI bridge to [bus 02]=0A=
[    0.387110] pci 0000:00:01.2:   bridge window [mem 0xd0800000-0xd08fffff=
]=0A=
[    0.387115] pci 0000:00:01.3: PCI bridge to [bus 03]=0A=
[    0.387117] pci 0000:00:01.3:   bridge window [io  0x2000-0x2fff]=0A=
[    0.387119] pci 0000:00:01.3:   bridge window [mem 0xd0700000-0xd07fffff=
]=0A=
[    0.387124] pci 0000:00:02.1: PCI bridge to [bus 04]=0A=
[    0.387127] pci 0000:00:02.1:   bridge window [mem 0xd0000000-0xd01fffff=
]=0A=
[    0.387133] pci 0000:00:08.1: PCI bridge to [bus 05]=0A=
[    0.387134] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]=0A=
[    0.387137] pci 0000:00:08.1:   bridge window [mem 0xd0300000-0xd06fffff=
]=0A=
[    0.387139] pci 0000:00:08.1:   bridge window [mem 0xfce0000000-0xfcf01f=
ffff 64bit pref]=0A=
[    0.387143] pci 0000:00:08.2: PCI bridge to [bus 06]=0A=
[    0.387146] pci 0000:00:08.2:   bridge window [mem 0xd0200000-0xd02fffff=
]=0A=
[    0.387152] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]=0A=
[    0.387153] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]=0A=
[    0.387155] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]=0A=
[    0.387157] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff windo=
w]=0A=
[    0.387158] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff windo=
w]=0A=
[    0.387160] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff windo=
w]=0A=
[    0.387161] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff wind=
ow]=0A=
[    0.387163] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff wind=
ow]=0A=
[    0.387164] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff wind=
ow]=0A=
[    0.387166] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff wind=
ow]=0A=
[    0.387168] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff wind=
ow]=0A=
[    0.387169] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff wind=
ow]=0A=
[    0.387171] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff wind=
ow]=0A=
[    0.387172] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff wind=
ow]=0A=
[    0.387174] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff wind=
ow]=0A=
[    0.387176] pci_bus 0000:00: resource 19 [mem 0xd0000000-0xf7ffffff wind=
ow]=0A=
[    0.387177] pci_bus 0000:00: resource 20 [mem 0xfc000000-0xfed3ffff wind=
ow]=0A=
[    0.387179] pci_bus 0000:00: resource 21 [mem 0x650200000-0xfcffffffff w=
indow]=0A=
[    0.387181] pci_bus 0000:01: resource 0 [io  0x3000-0x3fff]=0A=
[    0.387182] pci_bus 0000:01: resource 1 [mem 0xd0900000-0xd0afffff]=0A=
[    0.387184] pci_bus 0000:01: resource 2 [mem 0x650200000-0x6503fffff 64b=
it pref]=0A=
[    0.387186] pci_bus 0000:02: resource 1 [mem 0xd0800000-0xd08fffff]=0A=
[    0.387188] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]=0A=
[    0.387189] pci_bus 0000:03: resource 1 [mem 0xd0700000-0xd07fffff]=0A=
[    0.387191] pci_bus 0000:04: resource 1 [mem 0xd0000000-0xd01fffff]=0A=
[    0.387193] pci_bus 0000:05: resource 0 [io  0x1000-0x1fff]=0A=
[    0.387194] pci_bus 0000:05: resource 1 [mem 0xd0300000-0xd06fffff]=0A=
[    0.387196] pci_bus 0000:05: resource 2 [mem 0xfce0000000-0xfcf01fffff 6=
4bit pref]=0A=
[    0.387198] pci_bus 0000:06: resource 1 [mem 0xd0200000-0xd02fffff]=0A=
[    0.387369] pci 0000:05:00.1: D0 power state depends on 0000:05:00.0=0A=
[    0.387378] pci 0000:05:00.3: extending delay after power-on from D3hot =
to 20 msec=0A=
[    0.391033] pci 0000:05:00.4: extending delay after power-on from D3hot =
to 20 msec=0A=
[    0.410631] pci 0000:05:00.4: quirk_usb_early_handoff+0x0/0x720 took 191=
33 usecs=0A=
[    0.410649] PCI: CLS 64 bytes, default 64=0A=
[    0.410663] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters support=
ed=0A=
[    0.410711] Trying to unpack rootfs image as initramfs...=0A=
[    0.410712] pci 0000:00:00.2: can't derive routing for PCI INT A=0A=
[    0.410713] pci 0000:00:00.2: PCI INT A: not connected=0A=
[    0.410741] pci 0000:00:01.0: Adding to iommu group 0=0A=
[    0.410755] pci 0000:00:01.1: Adding to iommu group 1=0A=
[    0.410766] pci 0000:00:01.2: Adding to iommu group 2=0A=
[    0.410778] pci 0000:00:01.3: Adding to iommu group 3=0A=
[    0.410794] pci 0000:00:02.0: Adding to iommu group 4=0A=
[    0.410806] pci 0000:00:02.1: Adding to iommu group 5=0A=
[    0.410829] pci 0000:00:08.0: Adding to iommu group 6=0A=
[    0.410841] pci 0000:00:08.1: Adding to iommu group 6=0A=
[    0.410852] pci 0000:00:08.2: Adding to iommu group 6=0A=
[    0.410873] pci 0000:00:14.0: Adding to iommu group 7=0A=
[    0.410885] pci 0000:00:14.3: Adding to iommu group 7=0A=
[    0.410927] pci 0000:00:18.0: Adding to iommu group 8=0A=
[    0.410938] pci 0000:00:18.1: Adding to iommu group 8=0A=
[    0.410948] pci 0000:00:18.2: Adding to iommu group 8=0A=
[    0.410960] pci 0000:00:18.3: Adding to iommu group 8=0A=
[    0.410973] pci 0000:00:18.4: Adding to iommu group 8=0A=
[    0.410986] pci 0000:00:18.5: Adding to iommu group 8=0A=
[    0.410998] pci 0000:00:18.6: Adding to iommu group 8=0A=
[    0.411009] pci 0000:00:18.7: Adding to iommu group 8=0A=
[    0.411023] pci 0000:02:00.0: Adding to iommu group 9=0A=
[    0.411035] pci 0000:03:00.0: Adding to iommu group 10=0A=
[    0.411056] pci 0000:04:00.0: Adding to iommu group 11=0A=
[    0.411071] pci 0000:05:00.0: Adding to iommu group 6=0A=
[    0.411077] pci 0000:05:00.1: Adding to iommu group 6=0A=
[    0.411085] pci 0000:05:00.2: Adding to iommu group 6=0A=
[    0.411092] pci 0000:05:00.3: Adding to iommu group 6=0A=
[    0.411099] pci 0000:05:00.4: Adding to iommu group 6=0A=
[    0.411106] pci 0000:05:00.5: Adding to iommu group 6=0A=
[    0.411113] pci 0000:05:00.6: Adding to iommu group 6=0A=
[    0.411123] pci 0000:06:00.0: Adding to iommu group 6=0A=
[    0.411130] pci 0000:06:00.1: Adding to iommu group 6=0A=
[    0.414181] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40=0A=
[    0.414193] AMD-Vi: Extended features (0x206d73ef22254ade): PPR X2APIC N=
X GT IA GA PC GA_vAPIC=0A=
[    0.414199] AMD-Vi: Interrupt remapping enabled=0A=
[    0.414200] AMD-Vi: Virtual APIC enabled=0A=
[    0.414201] AMD-Vi: X2APIC enabled=0A=
[    0.414457] software IO TLB: tearing down default memory pool=0A=
[    0.415143] LVT offset 0 assigned for vector 0x400=0A=
[    0.415425] perf: AMD IBS detected (0x000003ff)=0A=
[    0.415434] amd_uncore: 4  amd_df counters detected=0A=
[    0.415438] amd_uncore: 6  amd_l3 counters detected=0A=
[    0.415897] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/b=
ank).=0A=
[    0.416440] Initialise system trusted keyrings=0A=
[    0.416462] Key type blacklist registered=0A=
[    0.416613] workingset: timestamp_bits=3D36 max_order=3D23 bucket_order=
=3D0=0A=
[    0.417409] zbud: loaded=0A=
[    0.417498] SGI XFS with ACLs, security attributes, realtime, quota, no =
debug enabled=0A=
[    0.418157] integrity: Platform Keyring initialized=0A=
[    0.418163] Key type asymmetric registered=0A=
[    0.418165] Asymmetric key parser 'x509' registered=0A=
[    0.418192] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 250)=0A=
[    0.418302] io scheduler mq-deadline registered=0A=
[    0.419862] pcieport 0000:00:01.1: PME: Signaling with IRQ 26=0A=
[    0.419895] pcieport 0000:00:01.1: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+=0A=
[    0.420251] pcieport 0000:00:01.2: PME: Signaling with IRQ 27=0A=
[    0.420380] pcieport 0000:00:01.3: PME: Signaling with IRQ 28=0A=
[    0.420476] pcieport 0000:00:02.1: PME: Signaling with IRQ 29=0A=
[    0.420574] pcieport 0000:00:08.1: PME: Signaling with IRQ 30=0A=
[    0.420795] pcieport 0000:00:08.2: PME: Signaling with IRQ 31=0A=
[    0.420897] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4=
=0A=
[    0.420988] Monitor-Mwait will be used to enter C-1 state=0A=
[    0.420993] ACPI: \_SB_.PLTF.C000: Found 3 idle states=0A=
[    0.421007] ACPI: FW issue: working around C-state latencies out of orde=
r=0A=
[    0.421096] ACPI: \_SB_.PLTF.C001: Found 3 idle states=0A=
[    0.421102] ACPI: FW issue: working around C-state latencies out of orde=
r=0A=
[    0.421297] ACPI: \_SB_.PLTF.C002: Found 3 idle states=0A=
[    0.421306] ACPI: FW issue: working around C-state latencies out of orde=
r=0A=
[    0.421483] ACPI: \_SB_.PLTF.C003: Found 3 idle states=0A=
[    0.421492] ACPI: FW issue: working around C-state latencies out of orde=
r=0A=
[    0.421586] ACPI: \_SB_.PLTF.C004: Found 3 idle states=0A=
[    0.421591] ACPI: FW issue: working around C-state latencies out of orde=
r=0A=
[    0.421780] ACPI: \_SB_.PLTF.C005: Found 3 idle states=0A=
[    0.421791] ACPI: FW issue: working around C-state latencies out of orde=
r=0A=
[    0.422244] ACPI: \_SB_.PLTF.C006: Found 3 idle states=0A=
[    0.422256] ACPI: FW issue: working around C-state latencies out of orde=
r=0A=
[    0.422575] ACPI: \_SB_.PLTF.C007: Found 3 idle states=0A=
[    0.422587] ACPI: FW issue: working around C-state latencies out of orde=
r=0A=
[    0.423206] thermal LNXTHERM:00: registered as thermal_zone0=0A=
[    0.423212] ACPI: thermal: Thermal Zone [TZ01] (55 C)=0A=
[    0.423448] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled=0A=
[    0.424766] Linux agpgart interface v0.103=0A=
[    0.446327] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>=
=0A=
[    0.447480] i8042: PNP: PS/2 Controller [PNP0303:KBC0] at 0x60,0x64 irq =
1=0A=
[    0.447491] i8042: PNP: PS/2 appears to have AUX port disabled, if this =
is incorrect please boot with i8042.nopnp=0A=
[    0.448611] serio: i8042 KBD port at 0x60,0x64 irq 1=0A=
[    0.448879] mousedev: PS/2 mouse device common for all mice=0A=
[    0.448941] rtc_cmos 00:01: RTC can wake from S4=0A=
[    0.449297] rtc_cmos 00:01: registered as rtc0=0A=
[    0.449342] rtc_cmos 00:01: setting system clock to 2021-12-02T14:22:11 =
UTC (1638454931)=0A=
[    0.449365] rtc_cmos 00:01: alarms up to one month, 114 bytes nvram, hpe=
t irqs=0A=
[    0.449706] ledtrig-cpu: registered to indicate activity on CPUs=0A=
[    0.449887] efifb: probing for efifb=0A=
[    0.449904] efifb: framebuffer at 0xfce0000000, using 1216k, total 1216k=
=0A=
[    0.449908] efifb: mode is 640x480x32, linelength=3D2560, pages=3D1=0A=
[    0.449912] efifb: scrolling: redraw=0A=
[    0.449914] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0=0A=
[    0.450968] Console: switching to colour frame buffer device 80x30=0A=
[    0.451385] fb0: EFI VGA frame buffer device=0A=
[    0.451537] NET: Registered PF_INET6 protocol family=0A=
[    0.456064] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input0=0A=
[    0.995420] Freeing initrd memory: 8532K=0A=
[    1.015885] Segment Routing with IPv6=0A=
[    1.016363] In-situ OAM (IOAM) with IPv6=0A=
[    1.017063] mip6: Mobile IPv6=0A=
[    1.017908] NET: Registered PF_PACKET protocol family=0A=
[    1.018452] mpls_gso: MPLS GSO support=0A=
[    1.019800] microcode: CPU0: patch_level=3D0x08600103=0A=
[    1.020435] microcode: CPU1: patch_level=3D0x08600103=0A=
[    1.020727] microcode: CPU2: patch_level=3D0x08600103=0A=
[    1.021013] microcode: CPU3: patch_level=3D0x08600103=0A=
[    1.021609] microcode: CPU4: patch_level=3D0x08600103=0A=
[    1.022370] microcode: CPU5: patch_level=3D0x08600103=0A=
[    1.023113] microcode: CPU6: patch_level=3D0x08600103=0A=
[    1.023829] microcode: CPU7: patch_level=3D0x08600103=0A=
[    1.024415] microcode: Microcode Update Driver: v2.2.=0A=
[    1.024723] resctrl: L3 allocation detected=0A=
[    1.025200] resctrl: MB allocation detected=0A=
[    1.025403] resctrl: L3 monitoring detected=0A=
[    1.025602] IPI shorthand broadcast: enabled=0A=
[    1.025807] sched_clock: Marking stable (1024353902, 609219)->(102858331=
3, -3620192)=0A=
[    1.026739] registered taskstats version 1=0A=
[    1.026934] Loading compiled-in X.509 certificates=0A=
[    1.027742] zswap: loaded using pool lzo/zbud=0A=
[    1.028968] Key type ._fscrypt registered=0A=
[    1.029169] Key type .fscrypt registered=0A=
[    1.029352] Key type fscrypt-provisioning registered=0A=
[    1.039010] Key type encrypted registered=0A=
[    1.039324] AppArmor: AppArmor sha1 policy hashing enabled=0A=
[    1.044414] integrity: Loading X.509 certificate: UEFI:db=0A=
[    1.044862] integrity: Loaded X.509 cert 'Microsoft Windows Production P=
CA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'=0A=
[    1.045671] integrity: Loading X.509 certificate: UEFI:db=0A=
[    1.046125] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA =
2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'=0A=
[    1.046514] integrity: Loading X.509 certificate: UEFI:db=0A=
[    1.046731] integrity: Loaded X.509 cert 'Acer Database: 84f00f5841571ab=
d2cc11a8c26d5c9c8d2b6b0b5'=0A=
[    1.047154] integrity: Loading X.509 certificate: UEFI:db=0A=
[    1.047796] alg: No test for pkcs1pad(rsa,sha1) (pkcs1pad(rsa-generic,sh=
a1))=0A=
[    1.048742] integrity: Loaded X.509 cert 'LINPUS: 967f81f2f4f5ac0f24fca5=
e42982e4ad1e56ddff'=0A=
[    1.049266] integrity: Loading X.509 certificate: UEFI:db=0A=
[    1.069165] integrity: Loaded X.509 cert 'Linpus: linpus.com: 2e092cab5e=
97a89f94a6e272ec7267c267cf4483'=0A=
[    1.069873] integrity: Loading X.509 certificate: UEFI:db=0A=
[    1.070505] integrity: Loaded X.509 cert 'Quanta NB4: 073d6a4c306ea5b949=
9e861c7ba55cde'=0A=
[    1.075460] ima: Allocated hash algorithm: sha256=0A=
[    1.434061] clocksource: timekeeping watchdog on CPU1: Marking clocksour=
ce 'tsc-early' as unstable because the skew is too large:=0A=
[    1.435504] clocksource:                       'hpet' wd_nsec: 483279020=
 wd_now: e40e0b wd_last: 7a780f mask: ffffffff=0A=
[    1.436124] clocksource:                       'tsc-early' cs_nsec: 8082=
70857 cs_now: 3ebeed8f8 cs_last: 38bc2e2a8 mask: ffffffffffffffff=0A=
[    1.436775] clocksource:                       'tsc-early' is current cl=
ocksource.=0A=
[    1.437445] tsc: Marking TSC unstable due to clocksource watchdog=0A=
[    1.437796] TSC found unstable after boot, most likely due to broken BIO=
S. Use 'tsc=3Dunstable'.=0A=
[    1.438487] sched_clock: Marking unstable (1437187159, 609219)<-(1441416=
600, -3620192)=0A=
[    1.439489] clocksource: Switched to clocksource hpet=0A=
[    1.444935] ima: No architecture policies found=0A=
[    1.445995] evm: Initialising EVM extended attributes:=0A=
[    1.446572] evm: security.selinux=0A=
[    1.446909] evm: security.SMACK64 (disabled)=0A=
[    1.447238] evm: security.SMACK64EXEC (disabled)=0A=
[    1.447564] evm: security.SMACK64TRANSMUTE (disabled)=0A=
[    1.447881] evm: security.SMACK64MMAP (disabled)=0A=
[    1.448190] evm: security.apparmor=0A=
[    1.448492] evm: security.ima=0A=
[    1.448781] evm: security.capability=0A=
[    1.449074] evm: HMAC attrs: 0x1=0A=
[    1.449757] Unstable clock detected, switching default tracing clock to =
"global"=0A=
               If you want to keep using the local clock, then add:=0A=
                 "trace_clock=3Dlocal"=0A=
               on the kernel command line=0A=
[    1.452110] Freeing unused decrypted memory: 2036K=0A=
[    1.452728] Freeing unused kernel image (initmem) memory: 2692K=0A=
[    1.473189] Write protecting the kernel read-only data: 20480k=0A=
[    1.474613] Freeing unused kernel image (text/rodata gap) memory: 2036K=
=0A=
[    1.475139] Freeing unused kernel image (rodata/data gap) memory: 1476K=
=0A=
[    1.475402] Run /init as init process=0A=
[    1.475644]   with arguments:=0A=
[    1.475645]     /init=0A=
[    1.475646]   with environment:=0A=
[    1.475646]     HOME=3D/=0A=
[    1.475647]     TERM=3Dlinux=0A=
[    1.475647]     BOOT_IMAGE=3D/kernel-debian-sources-x86_64-5.15.3_p1=0A=
[    1.475648]     real_root=3D/dev/nvme0n1p6=0A=
[    1.475648]     real_rootflags=3Dssd,space_cache,subvolid=3D5,subvol=3D/=
=0A=
[    1.475649]     rand_id=3DX9UJ3KA2=0A=
[    1.625676] xor: module verification failed: signature and/or required k=
ey missing - tainting kernel=0A=
[    1.626072] xor: automatically using best checksumming function   avx   =
    =0A=
[    1.709107] raid6: avx2x4   gen() 29162 MB/s=0A=
[    1.777162] raid6: avx2x4   xor()  6434 MB/s=0A=
[    1.844902] raid6: avx2x2   gen() 29027 MB/s=0A=
[    1.912903] raid6: avx2x2   xor() 24583 MB/s=0A=
[    1.980903] raid6: avx2x1   gen() 29191 MB/s=0A=
[    2.048904] raid6: avx2x1   xor() 19467 MB/s=0A=
[    2.117104] raid6: sse2x4   gen() 18716 MB/s=0A=
[    2.185106] raid6: sse2x4   xor()  6865 MB/s=0A=
[    2.253135] raid6: sse2x2   gen() 20352 MB/s=0A=
[    2.321240] raid6: sse2x2   xor() 12590 MB/s=0A=
[    2.388901] raid6: sse2x1   gen() 16113 MB/s=0A=
[    2.456903] raid6: sse2x1   xor()  9868 MB/s=0A=
[    2.456904] raid6: using algorithm avx2x1 gen() 29191 MB/s=0A=
[    2.456905] raid6: .... xor() 19467 MB/s, rmw enabled=0A=
[    2.456905] raid6: using avx2x2 recovery algorithm=0A=
[    2.478356] Btrfs loaded, crc32c=3Dcrc32c-generic, zoned=3Dyes, fsverity=
=3Dyes=0A=
[    2.561730] nvme 0000:02:00.0: platform quirk: setting simple suspend=0A=
[    2.561810] nvme nvme0: pci function 0000:02:00.0=0A=
[    2.644364] nvme nvme0: 16/0/0 default/read/poll queues=0A=
[    2.651208]  nvme0n1: p1 p2 p3 p4 p5 p6 p7 p8=0A=
[    2.674910] PM: Image not found (code -22)=0A=
[    2.676936] BTRFS: device fsid 198a8721-446d-4012-a0ce-533328c5b5f7 devi=
d 1 transid 2047 /dev/nvme0n1p6 scanned by mount (1329)=0A=
[    2.677222] BTRFS info (device nvme0n1p6): flagging fs with big metadata=
 feature=0A=
[    2.677225] BTRFS info (device nvme0n1p6): enabling ssd optimizations=0A=
[    2.677228] BTRFS info (device nvme0n1p6): disk space caching is enabled=
=0A=
[    2.677229] BTRFS info (device nvme0n1p6): has skinny extents=0A=
[    2.681455] BTRFS info (device nvme0n1p6): bdev /dev/nvme0n1p6 errs: wr =
0, rd 0, flush 0, corrupt 56, gen 0=0A=
[    2.697112] Not activating Mandatory Access Control as /sbin/tomoyo-init=
 does not exist.=0A=
[    3.552410] udevd[1955]: starting version 3.2.9=0A=
[    3.565965] udevd[1955]: starting eudev-3.2.9=0A=
[    3.599020] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1=0A=
[    3.599062] ACPI: button: Power Button [PWRB]=0A=
[    3.599129] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input2=0A=
[    3.599153] ACPI: button: Sleep Button [SLPB]=0A=
[    3.599188] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0=
D:00/input/input3=0A=
[    3.599200] ACPI: button: Lid Switch [LID0]=0A=
[    3.599234] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input4=0A=
[    3.599274] ACPI: button: Power Button [PWRF]=0A=
[    3.603415] ACPI: AC: AC Adapter [ACAD] (off-line)=0A=
[    3.603832] acpi_cpufreq: overriding BIOS provided _PSD data=0A=
[    3.605850] hid: raw HID events driver (C) Jiri Kosina=0A=
[    3.606491] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, re=
vision 0=0A=
[    3.606497] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port=
 selection=0A=
[    3.606720] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at=
 0xb20=0A=
[    3.608262] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  p=
ost: no)=0A=
[    3.608486] acpi device:0a: registered as cooling_device8=0A=
[    3.608527] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/device:09/LNXVIDEO:00/input/input5=0A=
[    3.609165] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver=0A=
[    3.609243] sp5100-tco sp5100-tco: Using 0xfed80b00 for watchdog MMIO ad=
dress=0A=
[    3.609814] sp5100-tco sp5100-tco: initialized. heartbeat=3D60 sec (nowa=
yout=3D0)=0A=
[    3.609924] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM=
 control=0A=
[    3.611779] input: Acer Wireless Radio Control as /devices/LNXSYSTM:00/L=
NXSYBUS:00/PNP0A08:00/device:27/10251229:00/input/input6=0A=
[    3.618995] ACPI: battery: Slot [BAT1] (battery present)=0A=
[    3.621953] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database=0A=
[    3.622157] cfg80211: Loaded X.509 cert 'benh@debian.org: 577e021cb980e0=
e820821ba7b54b4961b8b4fadf'=0A=
[    3.622332] cfg80211: Loaded X.509 cert 'romain.perier@gmail.com: 3abbc6=
ec146e09d1b6016ab9d6cf71dd233f0328'=0A=
[    3.622505] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'=
=0A=
[    3.623751] platform regulatory.0: firmware: direct-loading firmware reg=
ulatory.db=0A=
[    3.624093] platform regulatory.0: firmware: direct-loading firmware reg=
ulatory.db.p7s=0A=
[    3.626549] libphy: r8169: probed=0A=
[    3.626721] r8169 0000:03:00.0 eth0: RTL8168h/8111h, b4:a9:fc:a2:a7:1b, =
XID 541, IRQ 51=0A=
[    3.626724] r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]=0A=
[    3.632532] BTRFS: device fsid 3fa3cb95-582a-407c-864c-160b47b1f93d devi=
d 1 transid 750 /dev/nvme0n1p7 scanned by udevd (2010)=0A=
[    3.637157] BTRFS: device fsid b0a63a1a-7f19-4ada-97da-402534ed4ed1 devi=
d 1 transid 125 /dev/nvme0n1p8 scanned by udevd (2021)=0A=
[    3.641120] ccp 0000:05:00.2: enabling device (0000 -> 0002)=0A=
[    3.641308] ccp 0000:05:00.2: ccp: unable to access the device: you migh=
t be running a broken BIOS.=0A=
[    3.643059] ACPI: bus type USB registered=0A=
[    3.643081] usbcore: registered new interface driver usbfs=0A=
[    3.643086] usbcore: registered new interface driver hub=0A=
[    3.643097] usbcore: registered new device driver usb=0A=
[    3.651474] ccp 0000:05:00.2: tee enabled=0A=
[    3.651481] ccp 0000:05:00.2: psp enabled=0A=
[    3.672044] snd_rn_pci_acp3x 0000:05:00.5: enabling device (0000 -> 0002=
)=0A=
[    3.672216] xhci_hcd 0000:05:00.3: xHCI Host Controller=0A=
[    3.672223] xhci_hcd 0000:05:00.3: new USB bus registered, assigned bus =
number 1=0A=
[    3.672322] xhci_hcd 0000:05:00.3: hcc params 0x0268ffe5 hci version 0x1=
10 quirks 0x0000020000000410=0A=
[    3.672712] ath10k_pci 0000:04:00.0: enabling device (0000 -> 0002)=0A=
[    3.672731] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.15=0A=
[    3.672734] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1=0A=
[    3.672735] usb usb1: Product: xHCI Host Controller=0A=
[    3.672737] usb usb1: Manufacturer: Linux 5.15.3_p1-debian-sources xhci-=
hcd=0A=
[    3.672738] usb usb1: SerialNumber: 0000:05:00.3=0A=
[    3.673766] ath10k_pci 0000:04:00.0: pci irq msi oper_irq_mode 2 irq_mod=
e 0 reset_mode 0=0A=
[    3.674041] snd_hda_intel 0000:05:00.1: enabling device (0000 -> 0002)=
=0A=
[    3.674096] snd_hda_intel 0000:05:00.1: Handle vga_switcheroo audio clie=
nt=0A=
[    3.674142] snd_hda_intel 0000:05:00.6: enabling device (0000 -> 0002)=
=0A=
[    3.675366] hub 1-0:1.0: USB hub found=0A=
[    3.675378] hub 1-0:1.0: 4 ports detected=0A=
[    3.675748] xhci_hcd 0000:05:00.3: xHCI Host Controller=0A=
[    3.675751] xhci_hcd 0000:05:00.3: new USB bus registered, assigned bus =
number 2=0A=
[    3.675754] xhci_hcd 0000:05:00.3: Host supports USB 3.1 Enhanced SuperS=
peed=0A=
[    3.675769] usb usb2: We don't know the algorithms for LPM for this host=
, disabling LPM.=0A=
[    3.675788] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.15=0A=
[    3.675790] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1=0A=
[    3.675791] usb usb2: Product: xHCI Host Controller=0A=
[    3.675792] usb usb2: Manufacturer: Linux 5.15.3_p1-debian-sources xhci-=
hcd=0A=
[    3.675793] usb usb2: SerialNumber: 0000:05:00.3=0A=
[    3.675875] hub 2-0:1.0: USB hub found=0A=
[    3.675880] hub 2-0:1.0: 2 ports detected=0A=
[    3.676190] xhci_hcd 0000:05:00.4: xHCI Host Controller=0A=
[    3.676195] xhci_hcd 0000:05:00.4: new USB bus registered, assigned bus =
number 3=0A=
[    3.676293] xhci_hcd 0000:05:00.4: hcc params 0x0268ffe5 hci version 0x1=
10 quirks 0x0000020000000410=0A=
[    3.676628] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.15=0A=
[    3.676630] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1=0A=
[    3.676631] usb usb3: Product: xHCI Host Controller=0A=
[    3.676632] usb usb3: Manufacturer: Linux 5.15.3_p1-debian-sources xhci-=
hcd=0A=
[    3.676633] usb usb3: SerialNumber: 0000:05:00.4=0A=
[    3.676714] hub 3-0:1.0: USB hub found=0A=
[    3.676721] hub 3-0:1.0: 4 ports detected=0A=
[    3.677131] xhci_hcd 0000:05:00.4: xHCI Host Controller=0A=
[    3.677134] xhci_hcd 0000:05:00.4: new USB bus registered, assigned bus =
number 4=0A=
[    3.677136] xhci_hcd 0000:05:00.4: Host supports USB 3.1 Enhanced SuperS=
peed=0A=
[    3.677147] usb usb4: We don't know the algorithms for LPM for this host=
, disabling LPM.=0A=
[    3.677164] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.15=0A=
[    3.677165] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1=0A=
[    3.677166] usb usb4: Product: xHCI Host Controller=0A=
[    3.677167] usb usb4: Manufacturer: Linux 5.15.3_p1-debian-sources xhci-=
hcd=0A=
[    3.677168] usb usb4: SerialNumber: 0000:05:00.4=0A=
[    3.677289] hub 4-0:1.0: USB hub found=0A=
[    3.677293] hub 4-0:1.0: 2 ports detected=0A=
[    3.684203] SCSI subsystem initialized=0A=
[    3.686668] input: HD-Audio Generic HDMI/DP,pcm=3D3 as /devices/pci0000:=
00/0000:00:08.1/0000:05:00.1/sound/card0/input7=0A=
[    3.688964] libata version 3.00 loaded.=0A=
[    3.690958] ahci 0000:06:00.0: version 3.0=0A=
[    3.691167] ahci 0000:06:00.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x=
1 impl SATA mode=0A=
[    3.691169] ahci 0000:06:00.0: flags: 64bit ncq sntf ilck pm led clo onl=
y pmp fbs pio slum part deso sadm sds =0A=
[    3.691381] scsi host0: ahci=0A=
[    3.691449] ata1: SATA max UDMA/133 abar m2048@0xd0201000 port 0xd020110=
0 irq 78=0A=
[    3.691561] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC256: li=
ne_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker=0A=
[    3.691566] ahci 0000:06:00.1: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x=
1 impl SATA mode=0A=
[    3.691566] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)=0A=
[    3.691568] ahci 0000:06:00.1: flags: 64bit ncq sntf ilck pm led clo onl=
y pmp fbs pio slum part deso sadm sds =0A=
[    3.691569] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=3D1 (0x21/0x0/=
0x0/0x0/0x0)=0A=
[    3.691571] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=3D0x0=
=0A=
[    3.691572] snd_hda_codec_realtek hdaudioC1D0:    inputs:=0A=
[    3.691573] snd_hda_codec_realtek hdaudioC1D0:      Mic=3D0x12=0A=
[    3.691729] scsi host1: ahci=0A=
[    3.691767] ata2: SATA max UDMA/133 abar m2048@0xd0200000 port 0xd020010=
0 irq 80=0A=
[    3.731800] [drm] amdgpu kernel modesetting enabled.=0A=
[    3.733064] amdgpu: Virtual CRAT table created for CPU=0A=
[    3.733073] amdgpu: Topology: Add CPU node=0A=
[    3.733374] checking generic (fce0000000 130000) vs hw (fce0000000 10000=
000)=0A=
[    3.733377] fb0: switching to amdgpu from EFI VGA=0A=
[    3.733482] Console: switching to colour dummy device 80x25=0A=
[    3.733520] amdgpu 0000:05:00.0: vgaarb: deactivate vga console=0A=
[    3.733573] amdgpu 0000:05:00.0: enabling device (0006 -> 0007)=0A=
[    3.733631] [drm] initializing kernel modesetting (RENOIR 0x1002:0x1636 =
0x1025:0x1461 0xC2).=0A=
[    3.733633] amdgpu 0000:05:00.0: amdgpu: Trusted Memory Zone (TMZ) featu=
re enabled=0A=
[    3.734101] [drm] register mmio base: 0xD0600000=0A=
[    3.734102] [drm] register mmio size: 524288=0A=
[    3.734104] [drm] PCIE atomic ops is not supported=0A=
[    3.735352] [drm] add ip block number 0 <soc15_common>=0A=
[    3.735353] [drm] add ip block number 1 <gmc_v9_0>=0A=
[    3.735354] [drm] add ip block number 2 <vega10_ih>=0A=
[    3.735354] [drm] add ip block number 3 <psp>=0A=
[    3.735355] [drm] add ip block number 4 <smu>=0A=
[    3.735356] [drm] add ip block number 5 <gfx_v9_0>=0A=
[    3.735356] [drm] add ip block number 6 <sdma_v4_0>=0A=
[    3.735357] [drm] add ip block number 7 <dm>=0A=
[    3.735358] [drm] add ip block number 8 <vcn_v2_0>=0A=
[    3.735359] [drm] add ip block number 9 <jpeg_v2_0>=0A=
[    3.735374] amdgpu 0000:05:00.0: amdgpu: Fetched VBIOS from VFCT=0A=
[    3.735377] amdgpu: ATOM BIOS: 113-RENOIR-025=0A=
[    3.736134] amdgpu 0000:05:00.0: firmware: direct-loading firmware amdgp=
u/renoir_sdma.bin=0A=
[    3.736137] [drm] VCN decode is enabled in VM mode=0A=
[    3.736138] [drm] VCN encode is enabled in VM mode=0A=
[    3.736138] [drm] JPEG decode is enabled in VM mode=0A=
[    3.736160] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, f=
ragment size is 9-bit=0A=
[    3.736164] amdgpu 0000:05:00.0: amdgpu: VRAM: 512M 0x000000F400000000 -=
 0x000000F41FFFFFFF (512M used)=0A=
[    3.736166] amdgpu 0000:05:00.0: amdgpu: GART: 1024M 0x0000000000000000 =
- 0x000000003FFFFFFF=0A=
[    3.736167] amdgpu 0000:05:00.0: amdgpu: AGP: 267419648M 0x000000F800000=
000 - 0x0000FFFFFFFFFFFF=0A=
[    3.736172] [drm] Detected VRAM RAM=3D512M, BAR=3D512M=0A=
[    3.736172] [drm] RAM width 128bits DDR4=0A=
[    3.736206] [drm] amdgpu: 512M of VRAM memory ready=0A=
[    3.736206] [drm] amdgpu: 3072M of GTT memory ready.=0A=
[    3.736211] [drm] GART: num cpu pages 262144, num gpu pages 262144=0A=
[    3.736348] [drm] PCIE GART of 1024M enabled.=0A=
[    3.736349] [drm] PTB located at 0x000000F400900000=0A=
[    3.737040] amdgpu 0000:05:00.0: firmware: direct-loading firmware amdgp=
u/renoir_asd.bin=0A=
[    3.737447] amdgpu 0000:05:00.0: firmware: direct-loading firmware amdgp=
u/renoir_ta.bin=0A=
[    3.737458] amdgpu 0000:05:00.0: amdgpu: PSP runtime database doesn't ex=
ist=0A=
[    3.737580] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:08.=
1/0000:05:00.6/sound/card1/input8=0A=
[    3.737597] input: HD-Audio Generic Front Headphone as /devices/pci0000:=
00/0000:00:08.1/0000:05:00.6/sound/card1/input9=0A=
[    3.737846] amdgpu 0000:05:00.0: firmware: direct-loading firmware amdgp=
u/renoir_pfp.bin=0A=
[    3.738293] amdgpu 0000:05:00.0: firmware: direct-loading firmware amdgp=
u/renoir_me.bin=0A=
[    3.738575] amdgpu 0000:05:00.0: firmware: direct-loading firmware amdgp=
u/renoir_ce.bin=0A=
[    3.738926] amdgpu 0000:05:00.0: firmware: direct-loading firmware amdgp=
u/renoir_rlc.bin=0A=
[    3.739444] amdgpu 0000:05:00.0: firmware: direct-loading firmware amdgp=
u/renoir_mec.bin=0A=
[    3.740722] amdgpu 0000:05:00.0: firmware: direct-loading firmware amdgp=
u/renoir_dmcub.bin=0A=
[    3.740724] [drm] Loading DMUB firmware via PSP: version=3D0x01010019=0A=
[    3.741449] amdgpu 0000:05:00.0: firmware: direct-loading firmware amdgp=
u/renoir_vcn.bin=0A=
[    3.741455] [drm] Found VCN firmware Version ENC: 1.16 DEC: 5 VEP: 0 Rev=
ision: 3=0A=
[    3.741464] amdgpu 0000:05:00.0: amdgpu: Will use PSP to load VCN firmwa=
re=0A=
[    3.992516] ath10k_pci 0000:04:00.0: firmware: failed to load ath10k/pre=
-cal-pci-0000:04:00.0.bin (-2)=0A=
[    3.992524] firmware_class: See https://wiki.debian.org/Firmware for inf=
ormation about missing firmware=0A=
[    3.992548] ath10k_pci 0000:04:00.0: firmware: failed to load ath10k/cal=
-pci-0000:04:00.0.bin (-2)=0A=
[    3.994729] ath10k_pci 0000:04:00.0: firmware: direct-loading firmware a=
th10k/QCA6174/hw3.0/firmware-6.bin=0A=
[    3.994736] ath10k_pci 0000:04:00.0: qca6174 hw3.2 target 0x05030000 chi=
p_id 0x00340aff sub 11ad:0807=0A=
[    3.994738] ath10k_pci 0000:04:00.0: kconfig debug 0 debugfs 0 tracing 0=
 dfs 0 testmode 0=0A=
[    3.994986] ath10k_pci 0000:04:00.0: firmware ver WLAN.RM.4.4.1-00157-QC=
ARMSWPZ-1 api 6 features wowlan,ignore-otp,mfp crc32 90eebefb=0A=
[    4.005672] ata1: SATA link down (SStatus 0 SControl 300)=0A=
[    4.005675] ata2: SATA link down (SStatus 0 SControl 300)=0A=
[    4.059582] ath10k_pci 0000:04:00.0: firmware: direct-loading firmware a=
th10k/QCA6174/hw3.0/board-2.bin=0A=
[    4.059808] ath10k_pci 0000:04:00.0: board_file api 2 bmi_id N/A crc32 3=
18825bf=0A=
[    4.151980] ath10k_pci 0000:04:00.0: htt-ver 3.60 wmi-op 4 htt-op 3 cal =
otp max-sta 32 raw 0 hwcrypto 1=0A=
[    4.255573] ath: EEPROM regdomain: 0x6c=0A=
[    4.255579] ath: EEPROM indicates we should expect a direct regpair map=
=0A=
[    4.255582] ath: Country alpha2 being used: 00=0A=
[    4.255584] ath: Regpair used: 0x6c=0A=
[    4.380494] [drm] reserve 0x400000 from 0xf41f800000 for PSP TMR=0A=
[    4.410816] pstore: Using crash dump compression: deflate=0A=
[    4.410825] pstore: Registered efi as persistent store backend=0A=
[    4.415671] input: PC Speaker as /devices/platform/pcspkr/input/input10=
=0A=
[    4.442437] amdgpu 0000:05:00.0: amdgpu: RAS: optional ras ta ucode is n=
ot available=0A=
[    4.449899] amdgpu 0000:05:00.0: amdgpu: RAP: optional rap ta ucode is n=
ot available=0A=
[    4.449903] amdgpu 0000:05:00.0: amdgpu: SECUREDISPLAY: securedisplay ta=
 ucode is not available=0A=
[    4.450364] amdgpu 0000:05:00.0: amdgpu: SMU is initialized successfully=
!=0A=
[    4.451763] [drm] kiq ring mec 2 pipe 1 q 0=0A=
[    4.452647] [drm] Display Core initialized with v3.2.149!=0A=
[    4.453099] [drm] DMUB hardware initialized: version=3D0x01010019=0A=
[    4.482971] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 163840=
 ms ovfl timer=0A=
[    4.482979] RAPL PMU: hw unit of domain package 2^-16 Joules=0A=
[    4.483082] snd_hda_intel 0000:05:00.1: bound 0000:05:00.0 (ops amdgpu_d=
m_audio_component_bind_ops [amdgpu])=0A=
[    4.485336] cryptd: max_cpu_qlen set to 1000=0A=
[    4.488415] AVX2 version of gcm_enc/dec engaged.=0A=
[    4.488488] AES CTR mode by8 optimization enabled=0A=
[    4.488899] usb 3-4: new high-speed USB device number 2 using xhci_hcd=
=0A=
[    4.488908] usb 1-3: new full-speed USB device number 2 using xhci_hcd=
=0A=
[    4.573909] kvm: Nested Virtualization enabled=0A=
[    4.573912] SVM: kvm: Nested Paging enabled=0A=
[    4.573923] SVM: Virtual VMLOAD VMSAVE supported=0A=
[    4.573924] SVM: Virtual GIF supported=0A=
[    4.582017] MCE: In-kernel MCE decoding enabled.=0A=
[    4.637817] [drm] VCN decode and encode initialized successfully(under D=
PG Mode).=0A=
[    4.637841] [drm] JPEG decode initialized successfully.=0A=
[    4.640024] kfd kfd: amdgpu: Allocated 3969056 bytes on gart=0A=
[    4.640226] amdgpu: SRAT table not found=0A=
[    4.640228] amdgpu: Virtual CRAT table created for GPU=0A=
[    4.640510] amdgpu: Topology: Add dGPU node [0x1636:0x1002]=0A=
[    4.640515] kfd kfd: amdgpu: added device 1002:1636=0A=
[    4.640668] amdgpu 0000:05:00.0: amdgpu: SE 1, SH per SE 2, CU per SH 18=
, active_cu_number 27=0A=
[    4.643620] [drm] fb mappable at 0x610CD1000=0A=
[    4.643623] [drm] vram apper at 0x610000000=0A=
[    4.643624] [drm] size 8294400=0A=
[    4.643625] [drm] fb depth is 24=0A=
[    4.643627] [drm]    pitch is 7680=0A=
[    4.643828] fbcon: amdgpu (fb0) is primary device=0A=
[    4.655678] usb 3-4: New USB device found, idVendor=3D04f2, idProduct=3D=
b64f, bcdDevice=3D96.49=0A=
[    4.655686] usb 3-4: New USB device strings: Mfr=3D3, Product=3D1, Seria=
lNumber=3D2=0A=
[    4.655690] usb 3-4: Product: HD User Facing=0A=
[    4.655692] usb 3-4: Manufacturer: Chicony Electronics Co.,Ltd.=0A=
[    4.655694] usb 3-4: SerialNumber: 0001=0A=
[    4.664831] usb 1-3: New USB device found, idVendor=3D04ca, idProduct=3D=
3016, bcdDevice=3D 0.01=0A=
[    4.664838] usb 1-3: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0=0A=
[    4.700278] Console: switching to colour frame buffer device 240x67=0A=
[    4.719315] amdgpu 0000:05:00.0: [drm] fb0: amdgpu frame buffer device=
=0A=
[    4.749066] amdgpu 0000:05:00.0: amdgpu: ring gfx uses VM inv eng 0 on h=
ub 0=0A=
[    4.749075] amdgpu 0000:05:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 1 on hub 0=0A=
[    4.749079] amdgpu 0000:05:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 4 on hub 0=0A=
[    4.749081] amdgpu 0000:05:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 5 on hub 0=0A=
[    4.749083] amdgpu 0000:05:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 6 on hub 0=0A=
[    4.749085] amdgpu 0000:05:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 7 on hub 0=0A=
[    4.749087] amdgpu 0000:05:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 8 on hub 0=0A=
[    4.749089] amdgpu 0000:05:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 9 on hub 0=0A=
[    4.749092] amdgpu 0000:05:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 10 on hub 0=0A=
[    4.749094] amdgpu 0000:05:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng =
11 on hub 0=0A=
[    4.749097] amdgpu 0000:05:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on=
 hub 1=0A=
[    4.749100] amdgpu 0000:05:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 =
on hub 1=0A=
[    4.749102] amdgpu 0000:05:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4=
 on hub 1=0A=
[    4.749104] amdgpu 0000:05:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5=
 on hub 1=0A=
[    4.749106] amdgpu 0000:05:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6=
 on hub 1=0A=
[    4.751100] [drm] Initialized amdgpu 3.42.0 20150101 for 0000:05:00.0 on=
 minor 0=0A=
[    4.930688] input: SYNA7DB5:00 06CB:CD41 Mouse as /devices/platform/AMDI=
0010:00/i2c-0/i2c-SYNA7DB5:00/0018:06CB:CD41.0001/input/input11=0A=
[    4.930782] input: SYNA7DB5:00 06CB:CD41 Touchpad as /devices/platform/A=
MDI0010:00/i2c-0/i2c-SYNA7DB5:00/0018:06CB:CD41.0001/input/input12=0A=
[    4.930866] hid-generic 0018:06CB:CD41.0001: input,hidraw0: I2C HID v1.0=
0 Mouse [SYNA7DB5:00 06CB:CD41] on i2c-SYNA7DB5:00=0A=
[    4.931116] acer_wmi: Acer Laptop ACPI-WMI Extras=0A=
[    4.931143] acer_wmi: Function bitmap for Communication Button: 0x801=0A=
[    4.936822] input: Acer WMI hotkeys as /devices/virtual/input/input14=0A=
[    4.972177] BTRFS info (device nvme0n1p6): disk space caching is enabled=
=0A=
[    5.036352] intel_rapl_common: Found RAPL domain package=0A=
[    5.036355] intel_rapl_common: Found RAPL domain core=0A=
[    5.044974] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)=0A=
[    5.051401] Adding 8388604k swap on /dev/nvme0n1p5.  Priority:-2 extents=
:1 across:8388604k SSFS=0A=
[    5.065288] mc: Linux media interface: v0.10=0A=
[    5.077220] input: SYNA7DB5:00 06CB:CD41 Mouse as /devices/platform/AMDI=
0010:00/i2c-0/i2c-SYNA7DB5:00/0018:06CB:CD41.0001/input/input15=0A=
[    5.077377] input: SYNA7DB5:00 06CB:CD41 Touchpad as /devices/platform/A=
MDI0010:00/i2c-0/i2c-SYNA7DB5:00/0018:06CB:CD41.0001/input/input16=0A=
[    5.077561] hid-multitouch 0018:06CB:CD41.0001: input,hidraw0: I2C HID v=
1.00 Mouse [SYNA7DB5:00 06CB:CD41] on i2c-SYNA7DB5:00=0A=
[    5.134291] videodev: Linux video capture interface: v2.00=0A=
[    5.138240] BTRFS info (device nvme0n1p7): flagging fs with big metadata=
 feature=0A=
[    5.138245] BTRFS info (device nvme0n1p7): enabling ssd optimizations=0A=
[    5.138249] BTRFS info (device nvme0n1p7): disk space caching is enabled=
=0A=
[    5.138250] BTRFS info (device nvme0n1p7): has skinny extents=0A=
[    5.140819] BTRFS info (device nvme0n1p7): checking UUID tree=0A=
[    5.141173] usb 3-4: Found UVC 1.00 device HD User Facing (04f2:b64f)=0A=
[    5.141954] BTRFS info (device nvme0n1p8): flagging fs with big metadata=
 feature=0A=
[    5.141957] BTRFS info (device nvme0n1p8): enabling ssd optimizations=0A=
[    5.141960] BTRFS info (device nvme0n1p8): disk space caching is enabled=
=0A=
[    5.141961] BTRFS info (device nvme0n1p8): has skinny extents=0A=
[    5.142505] BTRFS error (device nvme0n1p8): bad tree block start, want 1=
064960 have 0=0A=
[    5.142515] BTRFS error (device nvme0n1p8): failed to read chunk root=0A=
[    5.142703] BTRFS error (device nvme0n1p8): open_ctree failed=0A=
[    5.149189] input: HD User Facing: HD User Facing as /devices/pci0000:00=
/0000:00:08.1/0000:05:00.4/usb3/3-4/3-4:1.0/input/input18=0A=
[    5.149283] usbcore: registered new interface driver uvcvideo=0A=
[    5.169296] BTRFS error (device nvme0n1p6): bad tree block start, want 2=
162049024 have 0=0A=
[    5.169315] BTRFS warning (device nvme0n1p6): csum hole found for disk b=
ytenr range [2573238272, 2573242368)=0A=
[    5.169404] BTRFS error (device nvme0n1p6): bad tree block start, want 2=
162049024 have 0=0A=
[    5.169421] BTRFS warning (device nvme0n1p6): csum hole found for disk b=
ytenr range [2573242368, 2573246464)=0A=
[    5.169480] BTRFS error (device nvme0n1p6): bad tree block start, want 2=
162049024 have 0=0A=
[    5.169485] BTRFS warning (device nvme0n1p6): csum hole found for disk b=
ytenr range [2573246464, 2573250560)=0A=
[    5.169533] BTRFS error (device nvme0n1p6): bad tree block start, want 2=
162049024 have 0=0A=
[    5.169538] BTRFS warning (device nvme0n1p6): csum hole found for disk b=
ytenr range [2573250560, 2573254656)=0A=
[    5.169731] BTRFS warning (device nvme0n1p6): csum failed root 5 ino 415=
94 off 0 csum 0x3bcfe7c0 expected csum 0x00000000 mirror 1=0A=
[    5.169736] BTRFS error (device nvme0n1p6): bdev /dev/nvme0n1p6 errs: wr=
 0, rd 0, flush 0, corrupt 57, gen 0=0A=
[    5.169746] BTRFS warning (device nvme0n1p6): csum failed root 5 ino 415=
94 off 4096 csum 0x80c92a82 expected csum 0x00000000 mirror 1=0A=
[    5.169748] BTRFS error (device nvme0n1p6): bdev /dev/nvme0n1p6 errs: wr=
 0, rd 0, flush 0, corrupt 58, gen 0=0A=
[    5.169753] BTRFS warning (device nvme0n1p6): csum failed root 5 ino 415=
94 off 8192 csum 0x96276691 expected csum 0x00000000 mirror 1=0A=
[    5.169755] BTRFS error (device nvme0n1p6): bdev /dev/nvme0n1p6 errs: wr=
 0, rd 0, flush 0, corrupt 59, gen 0=0A=
[    5.169760] BTRFS warning (device nvme0n1p6): csum failed root 5 ino 415=
94 off 12288 csum 0x9ce1a09d expected csum 0x00000000 mirror 1=0A=
[    5.169762] BTRFS error (device nvme0n1p6): bdev /dev/nvme0n1p6 errs: wr=
 0, rd 0, flush 0, corrupt 60, gen 0=0A=
[    5.169788] BTRFS error (device nvme0n1p6): bad tree block start, want 2=
162049024 have 0=0A=
[    5.169793] BTRFS warning (device nvme0n1p6): csum hole found for disk b=
ytenr range [2573238272, 2573242368)=0A=
[    5.169874] BTRFS warning (device nvme0n1p6): csum failed root 5 ino 415=
94 off 0 csum 0x3bcfe7c0 expected csum 0x00000000 mirror 1=0A=
[    5.169876] BTRFS error (device nvme0n1p6): bdev /dev/nvme0n1p6 errs: wr=
 0, rd 0, flush 0, corrupt 61, gen 0=0A=
[    5.169949] BTRFS error (device nvme0n1p6): bad tree block start, want 2=
162049024 have 0=0A=
[    5.169955] BTRFS warning (device nvme0n1p6): csum hole found for disk b=
ytenr range [2573238272, 2573242368)=0A=
[    5.170038] BTRFS warning (device nvme0n1p6): csum failed root 5 ino 415=
94 off 0 csum 0x3bcfe7c0 expected csum 0x00000000 mirror 1=0A=
[    5.170040] BTRFS error (device nvme0n1p6): bdev /dev/nvme0n1p6 errs: wr=
 0, rd 0, flush 0, corrupt 62, gen 0=0A=
[    5.221991] Bluetooth: Core ver 2.22=0A=
[    5.222023] NET: Registered PF_BLUETOOTH protocol family=0A=
[    5.222024] Bluetooth: HCI device and connection manager initialized=0A=
[    5.222027] Bluetooth: HCI socket layer initialized=0A=
[    5.222029] Bluetooth: L2CAP socket layer initialized=0A=
[    5.222032] Bluetooth: SCO socket layer initialized=0A=
[    5.225820] usbcore: registered new interface driver btusb=0A=
[    5.234942] bluetooth hci0: firmware: direct-loading firmware qca/rampat=
ch_usb_00000302.bin=0A=
[    5.234951] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000=
302.bin=0A=
[    5.234954] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware=
 rome 0x302 build 0x111=0A=
[    5.329021] elogind-daemon[2721]: New seat seat0.=0A=
[    5.329853] elogind-daemon[2721]: Watching system buttons on /dev/input/=
event4 (Power Button)=0A=
[    5.330107] elogind-daemon[2721]: Watching system buttons on /dev/input/=
event1 (Power Button)=0A=
[    5.330246] elogind-daemon[2721]: Watching system buttons on /dev/input/=
event3 (Lid Switch)=0A=
[    5.330300] elogind-daemon[2721]: Watching system buttons on /dev/input/=
event2 (Sleep Button)=0A=
[    5.330732] elogind-daemon[2721]: Watching system buttons on /dev/input/=
event0 (AT Translated Set 2 keyboard)=0A=
[    5.330786] elogind-daemon[2721]: Watching system buttons on /dev/input/=
event13 (Acer WMI hotkeys)=0A=
[    5.619785] bluetooth hci0: firmware: direct-loading firmware qca/nvm_us=
b_00000302.bin=0A=
[    5.619791] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin=0A=
[    5.757245] BTRFS error (device nvme0n1p6): bad tree block start, want 2=
162049024 have 0=0A=
[    5.757275] BTRFS warning (device nvme0n1p6): csum hole found for disk b=
ytenr range [2573238272, 2573242368)=0A=
[    5.757416] BTRFS warning (device nvme0n1p6): csum failed root 5 ino 415=
94 off 0 csum 0x3bcfe7c0 expected csum 0x00000000 mirror 1=0A=
[    5.757427] BTRFS error (device nvme0n1p6): bdev /dev/nvme0n1p6 errs: wr=
 0, rd 0, flush 0, corrupt 63, gen 0=0A=
[    5.757623] BTRFS error (device nvme0n1p6): bad tree block start, want 2=
162049024 have 0=0A=
[    5.757640] BTRFS warning (device nvme0n1p6): csum hole found for disk b=
ytenr range [2573238272, 2573242368)=0A=
[    5.757792] BTRFS warning (device nvme0n1p6): csum failed root 5 ino 415=
94 off 0 csum 0x3bcfe7c0 expected csum 0x00000000 mirror 1=0A=
[    5.757804] BTRFS error (device nvme0n1p6): bdev /dev/nvme0n1p6 errs: wr=
 0, rd 0, flush 0, corrupt 64, gen 0=0A=
[    5.854639] r8169 0000:03:00.0: firmware: direct-loading firmware rtl_ni=
c/rtl8168h-2.fw=0A=
[    5.885176] Generic FE-GE Realtek PHY r8169-0-300:00: attached PHY drive=
r (mii_bus:phy_addr=3Dr8169-0-300:00, irq=3DMAC)=0A=
[    6.049742] r8169 0000:03:00.0 eth0: Link is Down=0A=
[    7.016170] BTRFS error (device nvme0n1p6): bad tree block start, want 2=
162049024 have 0=0A=
[    7.016188] BTRFS warning (device nvme0n1p6): csum hole found for disk b=
ytenr range [2575118336, 2575122432)=0A=
[    7.016238] BTRFS warning (device nvme0n1p6): csum hole found for disk b=
ytenr range [2575122432, 2575126528)=0A=
[    7.016441] BTRFS warning (device nvme0n1p6): csum failed root 5 ino 416=
58 off 0 csum 0x413c7e41 expected csum 0x00000000 mirror 1=0A=
[    7.016448] BTRFS error (device nvme0n1p6): bdev /dev/nvme0n1p6 errs: wr=
 0, rd 0, flush 0, corrupt 65, gen 0=0A=
[    7.016466] BTRFS warning (device nvme0n1p6): csum failed root 5 ino 416=
58 off 4096 csum 0xffa7e36a expected csum 0x00000000 mirror 1=0A=
[    7.016471] BTRFS error (device nvme0n1p6): bdev /dev/nvme0n1p6 errs: wr=
 0, rd 0, flush 0, corrupt 66, gen 0=0A=
[    7.770761] elogind-daemon[2721]: New session 1 of user lightdm.=0A=
[   11.953107] elogind-daemon[2721]: Removed session 1.=0A=
[   11.971611] elogind-daemon[2721]: New session 2 of user cl.=0A=
[   26.340715] wlan0: authenticate with 34:fc:b9:78:b7:b2=0A=
[   26.393925] wlan0: send auth to 34:fc:b9:78:b7:b2 (try 1/3)=0A=
[   26.394854] wlan0: authenticated=0A=
[   26.404982] wlan0: associate with 34:fc:b9:78:b7:b2 (try 1/3)=0A=
[   26.406375] wlan0: RX AssocResp from 34:fc:b9:78:b7:b2 (capab=3D0x401 st=
atus=3D0 aid=3D2)=0A=
[   26.409567] wlan0: associated=0A=
[   26.410414] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready=

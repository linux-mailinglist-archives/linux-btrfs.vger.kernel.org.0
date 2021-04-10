Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B820535ADBA
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Apr 2021 15:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbhDJNjP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 10 Apr 2021 09:39:15 -0400
Received: from mail-fr2deu01on2120.outbound.protection.outlook.com ([40.107.135.120]:56896
        "EHLO DEU01-FR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234377AbhDJNjP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Apr 2021 09:39:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aq04sKvkXuy0ea+HayTUQX7F91fDPwRvwM6H6fVJGz/ezm6jpHfOWfsHunvV5KH9DIT6BgXZQzO4z+wE7zi5+pdHlu4BJeOrD1RK41aBR1QnIBY0yCoefQuBhu58YT0wt6TXfaofJFlKP600ojHVCktx8gi0mLYeQ7ut+RgmjC2lkZKT8ks/tB+ARz4fg+izeICSkxn1KfVINZqrZ4SD1hQyaeuosYPZnw+79Z4YUMfnHFvlG7519xENG03JeJDgxa1RqETtwr5jE7ERCjuPkLRD1dJviYh13hSncdGuWyeKVTZY0k3ZJ4dsVT5avQ2MfsjVS/rs0pwrBnLBzRoSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjWOc4Sb0qO0nw9b3grGM9Y45sFlpVwtsQBlig07yzc=;
 b=NkqLTZ2AnpAT/gTQ/evu7WR4Kn9FiEfv28ui9Pg7gJza1sM5DaSCisNTu5hu8w0CBAlnYNF5Rkl+G4ax05r9oakJIRq3WhXhCq/0I0uENpRVptQfxqAC9KXNNqNzz/thoaK4EKb4Kbhvt48wBOQW2VhjRHvX34oKP2O0Lg/PMmqaKYha2vpsfxXIaykitmePlmxQ6xHUhCjK7IhGmuYDgESyr1z3gu7MWiUQMXelehVZrmfT0Z2O9XeJknasRoDmVqlKYPIY5wfKvPTfOtCqshwfko3JDsscBSauYVcPchTnhjzxBW2C8X+XGk7/kCTxMy+/Uy64OKkg5dZIQlJ1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onlineschubla.de; dmarc=pass action=none
 header.from=onlineschubla.de; dkim=pass header.d=onlineschubla.de; arc=none
Received: from FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:45::10)
 by FR2P281MB0451.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6; Sat, 10 Apr
 2021 13:38:57 +0000
Received: from FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM
 ([fe80::cdcb:792e:c36:b5f5]) by FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM
 ([fe80::cdcb:792e:c36:b5f5%7]) with mapi id 15.20.4042.013; Sat, 10 Apr 2021
 13:38:57 +0000
From:   Paul Leiber <paul@onlineschubla.de>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Parent transid verify failed (and more): BTRFS for data storage in
 Xen VM setup
Thread-Topic: Parent transid verify failed (and more): BTRFS for data storage
 in Xen VM setup
Thread-Index: AdcuC0blJlFiU0MzRl+vvJbtaBo5jA==
Date:   Sat, 10 Apr 2021 13:38:57 +0000
Message-ID: <FRYP281MB058285E8F1BD4B521817F6CFB0729@FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=onlineschubla.de;
x-originating-ip: [2003:d2:1f49:6cf0:545e:be21:1922:e184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ed2c245-8ee5-40af-cea5-08d8fc25fdb2
x-ms-traffictypediagnostic: FR2P281MB0451:
x-microsoft-antispam-prvs: <FR2P281MB04515BE67249024F66014D0AB0729@FR2P281MB0451.DEUP281.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BssSEnd4hluQn6+mfilD22fqBIVkJq3Wt/dqjSJdDqBiP1gUC/c2L5mlp748/AUrjBEonSLFLlvpMbdL46bt6JAxHpHpJxJd3Nh50NKvWh9w9hU0SqrA1Nbu6oNEZSNZBeTPUXZMKbhyPZf640eHHmZG3okwKUehGzylWWlNlMsIhapzCekUhlGp70DYl21Cr9esRw/k4YIVJkocrEh2yV/j4mu/I1BBl11TSsYpp9rUr0LteAuRbiWCFgp6vYK+qawg3eLczPAMcHTvIzNCxQH3ocYxdVfqXGLxqF7/PtdwgQiLd4wR9l7S4etMHTB+v4LnRxHjVvY7y8FlKNOK+OH9p3PtSMlnp+a1itbk6+PvsU05rB2onIyubYMkFePRlHUW7runlSeW79clL9M7se+1T9jWrv+kcgOfU+n7awthMjkIyVZ2vnCNqc6g+M32tKRSDSVIDxs8NK9fWS3W5OiVUMlYk25bcaj8iBsmwhddTVT+ncl/oE4JebHDVntGbGDd4N5R1j8AOGMx64/adIgol463Lli/pmgGYXKoLnRF3v4tlfJ4P86WAcSm/Tyl9d3Fnc8BpOPBCo3ohHfbIG3jKpz81ZzznG18w/acn9BZvF5jVbigvVSuh/pLfoGgxolxFamslptwnVe4tNXD9A+FjamKn5qjGcqkO4yDVsU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(346002)(34096005)(396003)(366004)(136003)(376002)(55016002)(186003)(66446008)(66556008)(6916009)(52536014)(64756008)(9686003)(66476007)(6506007)(45080400002)(7696005)(30864003)(498600001)(38100700002)(5660300002)(15650500001)(86362001)(33656002)(8676002)(83380400001)(71200400001)(966005)(8936002)(38610400001)(586005)(2906002)(76116006)(66946007)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cgZqgs6MUV4pEdyYhKvwOOkuVqIebL8ShhBYb3uajoBBOz0iTRZWiBCWql1W?=
 =?us-ascii?Q?JhIjQxN0UsiXoSmKDZkKs2U38bm1B93nYddGEKYQq4TEMisuUq5PEodErKA5?=
 =?us-ascii?Q?6/85eNAflXw6BnQb7iPUiS+T3A0135/pqS1Y7ZV3q9+dWjPDGAGea3UI9ScZ?=
 =?us-ascii?Q?HOGa/cg1CsHXVxdUWyAbeNwoP4liaKNyqbnlMrSheHza5iYLCIiX/1GDfU/X?=
 =?us-ascii?Q?ZSLQDVojMJ59+GYEXzpHMzcWvKsYENLObnlrJTqOTw9GUtsJb1LPzyhLT0LT?=
 =?us-ascii?Q?nkglBBYEMCSS/7RZGwu1KTDoeRRl76pA5ibrFl86xn4ObRZ58Eo2ebheTQEU?=
 =?us-ascii?Q?HszpWQDzcfV2R+niJJn5ZuheuEXAu1F+Jb4G/A2HYOYjryuZUAiLTr0XDu/T?=
 =?us-ascii?Q?nKqKfpAb6/Up4UKJBnwKZU2RwzXcVVDJQjgpU4z+8TlY/OeR4h2is3cS/DuT?=
 =?us-ascii?Q?RsBl6s6965USFG6FeCeUNJ3/J5lGtNhSIM1AFwtw+TiDb6OvpKC7Vla53m2S?=
 =?us-ascii?Q?aE9ked1mAvLTjPn+w/UMfcdJ1hBZqb4GoHBxqk8Nusx/5gBDKlaYl3m1epmz?=
 =?us-ascii?Q?0gnFevSvYmUvfMn/OEbfTMZ/zn1uLJMR/Gefz+888rXUeKBwEG8DXehfh3Oj?=
 =?us-ascii?Q?BdtWuhbDZQzdaM7GYakvlvdw3UlQc1TMfWWiI54vk7i2h/HGYPcsULN5OXyv?=
 =?us-ascii?Q?dLK9MrtYr5UOT0YVTq1W7f2810KkVICuiWAnCzrDxIhCJshGCY6P7okVrUos?=
 =?us-ascii?Q?HJjLeX5znpR8DZTIsOGjeuBwQn5kkLGAyXvxE3atyKV4gadabHmwPlIDh5co?=
 =?us-ascii?Q?35/mgPrxMyR1LJc0QRt0XnS+755j9SUmDwo7Kdc+3P8X6tVSzvy2YnoNeEWg?=
 =?us-ascii?Q?1H3qfnCq9U+yEJQPrV3Xk6ptNHOsni8DZFU12apS1U/0z6zEt7MccB/Ba58B?=
 =?us-ascii?Q?JaaIcMfgvJKMYsZN9L5pIW6fszDTcFtFYdWXGJm5zXtIHv669GuQKtBDqXF1?=
 =?us-ascii?Q?K5wmvi0+mKA0Vwd9msLiBgu1FdjJjJlzIDtgX/A2rDIay8EpsvEmV8yd0tZA?=
 =?us-ascii?Q?YJtJTGAz9J1klepa/TIYvj4mFVyuH8/cuKBoX477McxjEgbcSiEG1rcLLmJo?=
 =?us-ascii?Q?4RqovQ9qnIH2Sf7RunR8De3Fb3MkQ6tzdnbbxjJBf6f90AErP/8vUAJ6odRT?=
 =?us-ascii?Q?giKkyiqw79TL44UtADWnUSNAr1axdPAbOzPhv57yeng1CejGHLVoETLyqSK8?=
 =?us-ascii?Q?jZmPM+B1RkGNENcqvss1gaJesn9HgNU+XIfqnl177nIkqzgVtaGalXA0EuOV?=
 =?us-ascii?Q?3zuBgvn8jB9jgvSSRwU2rTfvtAuauQ7IYzo4VJ/Wz4x7qWHm3SE7/STT/hl3?=
 =?us-ascii?Q?enztxb0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: onlineschubla.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed2c245-8ee5-40af-cea5-08d8fc25fdb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2021 13:38:57.2282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bfc8b046-4d00-4e98-8679-43c06bdec9db
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4MAw1FxTFt7SdpKnG/GFFMNVFpgdFKTBXVxMGuPn+e+ptVrrIn53f5EyYFIwN6iq16wZxFFNDBKadWkaYgdoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0451
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi everybody,

this is my first ever e-mail to a Linux mailing list, so please forgive me if I am making some stupid mistake (and, please, tell me how to behave better :-).

For my new home backend (AD, shares, tv server, etc.), I recently set up a couple of Linux (Debian Buster) VMs based on Xen hypervisor. Xen and the Dom0 and DomU VMs are located on a SSD with LVM. For data storage on a spinning hard drive (home directories, media, ...), I wanted to try out BTRFS, mainly because of the snapshot capabilities (and because I am curious). As my old hard drive was showing signs of decay, I bought a new SATA hard drive (Seagate IronWolf Pro 10 TB).

I connected the hard drive, booted up, logged into the Dom0, created a single partition on the drive, set up BTRFS in that partition, created some subvolumes, and copied my data from the old hard drive to the subvolumes. I then configured Xen to pass through the complete partition containing BTRFS to the VM with the file server (Samba). I then logged into the DomU containing the Samba server, mounted the subvolumes, and created the Samba shares. That went well without any problems.

After some time (one or two days), I started to notice parent transid failures wich grew in number. There was no hardware/power supply issue that I am aware of. Of course, I am concerned about my data, so I did some research but could not pinpoint a problem. With my limited knowledge about BTRFS, I had several suspects and tried to resolve resepctive issues:

a) Mistakes during initial setup of BTRFS: I did the BTRFS setup from scratch, copied the data again. Same result: After some time, there were parent transid failures again, this time associated with other errors (checksum).
b) Memory issues: I have ECC memory, so that seemed unlikely. I nevertheless did a Memtest86+ test without any memory issues detected in two passes.
c) I then thought that perhaps the Seagate harddrive was not getting along well with the setup (there were some older posts regarding write cache issues with certain types of drives/firmwares). SMART data of the harddrive was o.k. So I bought a different hard drive (Toshiba Enterprise Capacity, 12 TB) and did the BTRFS setup from scratch. Same result: Parent transid failures and ctree failed (see dmesg from Dom0 below).

This brings me to the current situation. I have no idea where these issues come from and what to do to prevent them. So far, there is no actual risk of data loss as I have all data backed up. If there is no solution for my problem, I am considering switching to LVM for data storage as well, but I am a little bit stubborn and want to give BTRFS a fair chance.

Some additional thoughts I had:
d) Perhaps the complete BTRFS setup (Xen, VMs, pass through the partition, Samba share) is flawed?
e) Perhaps it is wrong to mount the BTRFS root first in the Dom0 and then accessing the subvolumes in the DomU?

I have the following questions:

1. Where can these issues come from?
2. What can I do to prevent these issues?
3. If I can stick with BTRFS (in case question 1 and 2 can be answered), can I rescue the current setup (and how), or should I scrap it and start again?

I appreciate any advice.

Best regards,

Paul Leiber

---

System information:

Linux xxxxx 4.19.0-14-amd64 #1 SMP Debian 4.19.171-2 (2021-01-30) x86_64 GNU/Linux

btrfs-progs v4.20.1

Label: 'xxxxxxxx'  uuid: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
        Total devices 1 FS bytes used 3.54TiB
        devid    1 size 10.91TiB used 3.57TiB path /dev/sda1

Data, single: total=3.56TiB, used=3.53TiB
System, DUP: total=8.00MiB, used=400.00KiB
Metadata, DUP: total=5.00GiB, used=3.81GiB
GlobalReserve, single: total=512.00MiB, used=0.00B


dmesg from dom0 which controls the hardware (and the hard drive):
[    0.806054] pci 0000:00:17.0: reg 0x24: [mem 0xf7a37000-0xf7a377ff]
[    0.806223] pci 0000:00:17.0: PME# supported from D3hot
[    0.806487] pci 0000:00:1b.0: [8086:a169] type 01 class 0x060400
[    0.806831] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.806871] pci 0000:00:1b.0: Intel SPT PCH root port ACS workaround enabled
[    0.807091] pci 0000:00:1b.3: [8086:a16a] type 01 class 0x060400
[    0.807433] pci 0000:00:1b.3: PME# supported from D0 D3hot D3cold
[    0.807473] pci 0000:00:1b.3: Intel SPT PCH root port ACS workaround enabled
[    0.807706] pci 0000:00:1d.0: [8086:a118] type 01 class 0x060400
[    0.808048] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.808088] pci 0000:00:1d.0: Intel SPT PCH root port ACS workaround enabled
[    0.808324] pci 0000:00:1f.0: [8086:a149] type 00 class 0x060100
[    0.808781] pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000
[    0.808840] pci 0000:00:1f.2: reg 0x10: [mem 0xf7a30000-0xf7a33fff]
[    0.809252] pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500
[    0.809331] pci 0000:00:1f.4: reg 0x10: [mem 0xf7a36000-0xf7a360ff 64bit]
[    0.809422] pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
[    0.809669] pci 0000:00:1f.6: [8086:15b7] type 00 class 0x020000
[    0.809756] pci 0000:00:1f.6: reg 0x10: [mem 0xf7a00000-0xf7a1ffff]
[    0.810154] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    0.810569] pci 0000:01:00.0: [1131:7164] type 00 class 0x048000
[    0.810668] pci 0000:01:00.0: reg 0x10: [mem 0xf7400000-0xf77fffff 64bit]
[    0.810723] pci 0000:01:00.0: reg 0x18: [mem 0xf7000000-0xf73fffff 64bit]
[    0.811039] pci 0000:01:00.0: supports D1 D2
[    0.811039] pci 0000:01:00.0: PME# supported from D0 D1 D2
[    0.811126] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x1 link at 0000:00:1b.0 (capable of 4.000 Gb/s with 2.5 GT/s x2 link)
[    0.811290] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    0.811307] pci 0000:00:1b.0:   bridge window [mem 0xf7000000-0xf77fffff]
[    0.811511] pci 0000:02:00.0: [8086:10d3] type 00 class 0x020000
[    0.811596] pci 0000:02:00.0: reg 0x10: [mem 0xf79c0000-0xf79dffff]
[    0.811635] pci 0000:02:00.0: reg 0x14: [mem 0xf7900000-0xf797ffff]
[    0.811674] pci 0000:02:00.0: reg 0x18: [io  0xe000-0xe01f]
[    0.811712] pci 0000:02:00.0: reg 0x1c: [mem 0xf79e0000-0xf79e3fff]
[    0.811827] pci 0000:02:00.0: reg 0x30: [mem 0xf7980000-0xf79bffff pref]
[    0.812103] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.812398] pci 0000:00:1b.3: PCI bridge to [bus 02]
[    0.812407] pci 0000:00:1b.3:   bridge window [io  0xe000-0xefff]
[    0.812416] pci 0000:00:1b.3:   bridge window [mem 0xf7900000-0xf79fffff]
[    0.812601] pci 0000:03:00.0: [2646:500a] type 00 class 0x010802
[    0.812690] pci 0000:03:00.0: reg 0x10: [mem 0xf7800000-0xf7803fff 64bit]
[    0.813338] pci 0000:00:1d.0: PCI bridge to [bus 03]
[    0.813355] pci 0000:00:1d.0:   bridge window [mem 0xf7800000-0xf78fffff]
[    0.814231] xen: registering gsi 13 triggering 1 polarity 0
[    0.815627] ACPI: PCI Interrupt Link [LNKA] (IRQs 6 10 *11 12 14 15)
[    0.815680] ACPI: PCI Interrupt Link [LNKB] (IRQs 6 *10 11 12 14 15)
[    0.815733] ACPI: PCI Interrupt Link [LNKC] (IRQs 6 10 *11 12 14 15)
[    0.815787] ACPI: PCI Interrupt Link [LNKD] (IRQs 6 10 *11 12 14 15)
[    0.815839] ACPI: PCI Interrupt Link [LNKE] (IRQs 6 10 *11 12 14 15)
[    0.815892] ACPI: PCI Interrupt Link [LNKF] (IRQs 6 10 *11 12 14 15)
[    0.815944] ACPI: PCI Interrupt Link [LNKG] (IRQs 6 10 *11 12 14 15)
[    0.815995] ACPI: PCI Interrupt Link [LNKH] (IRQs 6 10 *11 12 14 15)
[    0.816469] xen:balloon: Initialising balloon driver
[    0.816655] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.816656] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.816659] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.816659] vgaarb: loaded
[    0.816703] pps_core: LinuxPPS API ver. 1 registered
[    0.816703] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.816705] PTP clock support registered
[    0.816709] EDAC MC: Ver: 3.0.0
[    0.816897] PCI: Using ACPI for IRQ routing
[    0.828142] PCI: pci_cache_line_size set to 64 bytes
[    0.828357] e820: reserve RAM buffer [mem 0x0009c000-0x0009ffff]
[    0.828358] e820: reserve RAM buffer [mem 0x40064000-0x43ffffff]
[    0.828758] clocksource: Switched to clocksource tsc-early
[    0.835674] VFS: Disk quotas dquot_6.6.0
[    0.835683] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.835695] hugetlbfs: disabling because there are no supported hugepage sizes
[    0.835743] AppArmor: AppArmor Filesystem Enabled
[    0.835754] pnp: PnP ACPI init
[    0.836028] system 00:00: [io  0x0a00-0x0a0f] has been reserved
[    0.836029] system 00:00: [io  0x0a10-0x0a1f] has been reserved
[    0.836030] system 00:00: [io  0x0a20-0x0a2f] has been reserved
[    0.836031] system 00:00: [io  0x0a30-0x0a3f] has been reserved
[    0.836034] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.836468] xen: registering gsi 5 triggering 1 polarity 0
[    0.836468] pnp 00:01: [dma 0 disabled]
[    0.836738] pnp 00:01: Plug and Play ACPI device, IDs PNP0400 (active)
[    0.837095] xen: registering gsi 4 triggering 1 polarity 0
[    0.837127] pnp 00:02: [dma 0 disabled]
[    0.837155] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.837511] xen: registering gsi 3 triggering 1 polarity 0
[    0.837543] pnp 00:03: [dma 0 disabled]
[    0.837569] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.837588] xen: registering gsi 1 triggering 1 polarity 0
[    0.837631] pnp 00:04: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
[    0.837661] xen: registering gsi 12 triggering 1 polarity 0
[    0.837705] pnp 00:05: Plug and Play ACPI device, IDs PNP0f03 PNP0f13 (active)
[    0.837817] system 00:06: [io  0x0400-0x041f] has been reserved
[    0.837818] system 00:06: [io  0x0680-0x069f] has been reserved
[    0.837819] system 00:06: [io  0xffff] has been reserved
[    0.837820] system 00:06: [io  0xffff] has been reserved
[    0.837821] system 00:06: [io  0xffff] has been reserved
[    0.837822] system 00:06: [io  0x1800-0x18fe] has been reserved
[    0.837823] system 00:06: [io  0x164e-0x164f] has been reserved
[    0.837825] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.837902] system 00:07: [io  0x0800-0x087f] has been reserved
[    0.837904] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.837909] xen: registering gsi 8 triggering 1 polarity 0
[    0.837949] pnp 00:08: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.837977] system 00:09: [io  0x1854-0x1857] has been reserved
[    0.837979] system 00:09: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.838187] system 00:0a: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.838188] system 00:0a: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.838189] system 00:0a: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.838190] system 00:0a: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.838190] system 00:0a: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.838191] system 00:0a: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.838192] system 00:0a: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.838193] system 00:0a: [mem 0xff000000-0xffffffff] has been reserved
[    0.838194] system 00:0a: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.838195] system 00:0a: [mem 0xf7fe0000-0xf7ffffff] has been reserved
[    0.838197] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.838237] system 00:0b: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.838238] system 00:0b: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.838239] system 00:0b: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.838240] system 00:0b: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    0.838240] system 00:0b: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.838241] system 00:0b: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.838242] system 00:0b: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.838244] system 00:0b: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.838549] system 00:0c: [io  0xff00-0xfffe] has been reserved
[    0.838551] system 00:0c: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.839689] xen: registering gsi 14 triggering 0 polarity 1
[    0.839739] system 00:0d: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    0.839740] system 00:0d: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    0.839741] system 00:0d: [mem 0xfdac0000-0xfdacffff] has been reserved
[    0.839743] system 00:0d: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.840251] system 00:0e: [io  0x0200] has been reserved
[    0.840254] system 00:0e: Plug and Play ACPI device, IDs FXY0815 PNP0c02 (active)
[    0.840329] pnp: PnP ACPI: found 15 devices
[    0.860189] PM-Timer failed consistency check  (0xffffff) - aborting.
[    0.860196] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    0.860210] pci 0000:00:1b.0:   bridge window [mem 0xf7000000-0xf77fffff]
[    0.860235] pci 0000:00:1b.3: PCI bridge to [bus 02]
[    0.860240] pci 0000:00:1b.3:   bridge window [io  0xe000-0xefff]
[    0.860253] pci 0000:00:1b.3:   bridge window [mem 0xf7900000-0xf79fffff]
[    0.860277] pci 0000:00:1d.0: PCI bridge to [bus 03]
[    0.860290] pci 0000:00:1d.0:   bridge window [mem 0xf7800000-0xf78fffff]
[    0.860315] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.860316] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.860317] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.860318] pci_bus 0000:00: resource 7 [mem 0xcf800000-0xf7ffffff window]
[    0.860319] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
[    0.860320] pci_bus 0000:01: resource 1 [mem 0xf7000000-0xf77fffff]
[    0.860320] pci_bus 0000:02: resource 0 [io  0xe000-0xefff]
[    0.860321] pci_bus 0000:02: resource 1 [mem 0xf7900000-0xf79fffff]
[    0.860322] pci_bus 0000:03: resource 1 [mem 0xf7800000-0xf78fffff]
[    0.860416] NET: Registered protocol family 2
[    0.860786] tcp_listen_portaddr_hash hash table entries: 512 (order: 1, 8192 bytes)
[    0.860814] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[    0.860869] TCP bind hash table entries: 8192 (order: 5, 131072 bytes)
[    0.860880] TCP: Hash tables configured (established 8192 bind 8192)
[    0.860906] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.860918] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.860951] NET: Registered protocol family 1
[    0.860954] NET: Registered protocol family 44
[    0.860979] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.861077] xen: registering gsi 16 triggering 0 polarity 1
[    0.861096] xen: --> pirq=16 -> irq=16 (gsi=16)
[    0.914587] pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x6d0 took 52342 usecs
[    0.914668] PCI: CLS 0 bytes, default 64
[    0.914695] Unpacking initramfs...
[    1.354592] Freeing initrd memory: 29840K
[    1.355270] Initialise system trusted keyrings
[    1.355276] Key type blacklist registered
[    1.355593] workingset: timestamp_bits=40 max_order=18 bucket_order=0
[    1.356496] zbud: loaded
[    1.477696] Key type asymmetric registered
[    1.477697] Asymmetric key parser 'x509' registered
[    1.477705] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    1.477762] io scheduler noop registered
[    1.477763] io scheduler deadline registered
[    1.477788] io scheduler cfq registered (default)
[    1.477789] io scheduler mq-deadline registered
[    1.478115] xen: registering gsi 18 triggering 0 polarity 1
[    1.478133] xen: --> pirq=18 -> irq=18 (gsi=18)
[    1.478312] pcieport 0000:00:1b.0: Signaling PME with IRQ 150
[    1.478543] xen: registering gsi 19 triggering 0 polarity 1
[    1.478555] xen: --> pirq=19 -> irq=19 (gsi=19)
[    1.478712] pcieport 0000:00:1b.3: Signaling PME with IRQ 151
[    1.478934] xen: registering gsi 16 triggering 0 polarity 1
[    1.478937] Already setup the GSI :16
[    1.479066] pcieport 0000:00:1d.0: Signaling PME with IRQ 152
[    1.479220] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.479230] intel_idle: MWAIT substates: 0x142120
[    1.479231] intel_idle: v0.4.1 model 0x5E
[    1.479233] intel_idle: intel_idle yielding to none
[    1.479446] Monitor-Mwait will be used to enter C-1 state
[    1.479472] Monitor-Mwait will be used to enter C-2 state
[    1.479496] Monitor-Mwait will be used to enter C-3 state
[    1.480125] Warning: Processor Platform Limit not supported.
[    1.480413] xen_mcelog: /dev/mcelog registered by Xen
[    1.480855] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.502532] 00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.524254] 00:03: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    1.524784] xen: registering gsi 19 triggering 0 polarity 1
[    1.524787] Already setup the GSI :19
[    1.546301] 0000:00:16.3: ttyS2 at I/O 0xf0a0 (irq = 19, base_baud = 115200) is a 16550A
[    1.546618] hpet_acpi_add: no address or irqs in _CRS
[    1.546639] Linux agpgart interface v0.103
[    1.546675] AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    1.546675] AMD IOMMUv2 functionality not available on this system
[    1.547195] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[    1.550619] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.550623] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.550855] mousedev: PS/2 mouse device common for all mice
[    1.550934] rtc_cmos 00:08: RTC can wake from S4
[    1.551566] rtc_cmos 00:08: registered as rtc0
[    1.551577] rtc_cmos 00:08: alarms up to one month, y3k, 242 bytes nvram
[    1.551782] ledtrig-cpu: registered to indicate activity on CPUs
[    1.552393] NET: Registered protocol family 10
[    1.570310] Segment Routing with IPv6
[    1.570328] mip6: Mobile IPv6
[    1.570329] NET: Registered protocol family 17
[    1.570388] mpls_gso: MPLS GSO support
[    1.570590] mce: Using 2 MCE banks
[    1.570602] sched_clock: Marking stable (1555998534, 14573061)->(1571484485, -912890)
[    1.571240] registered taskstats version 1
[    1.571240] Loading compiled-in X.509 certificates
[    1.598506] Loaded X.509 cert 'Debian Secure Boot CA: 6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419ea1'
[    1.598519] Loaded X.509 cert 'Debian Secure Boot Signer 2020: 00b55eb3b9'
[    1.598532] zswap: loaded using pool lzo/zbud
[    1.599297] AppArmor: AppArmor sha1 policy hashing enabled
[    1.600571] rtc_cmos 00:08: setting system clock to 2021-04-08 19:20:15 UTC (1617909615)
[    1.601993] Freeing unused kernel image memory: 1600K
[    1.636861] Write protecting the kernel read-only data: 16384k
[    1.650513] Freeing unused kernel image memory: 2028K
[    1.651091] Freeing unused kernel image memory: 772K
[    1.682682] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.682684] Run /init as init process
[    1.869442] ACPI BIOS Error (bug): Could not resolve [\_SB.PCI0.LPCB.HEC.ECAV], AE_NOT_FOUND (20180810/psargs-330)
[    1.869549] ACPI Error: Method parse/execution failed \_TZ.TZ00._TMP, AE_NOT_FOUND (20180810/psparse-516)
[    1.869826] ACPI BIOS Error (bug): Could not resolve [\_SB.PCI0.LPCB.HEC.ECAV], AE_NOT_FOUND (20180810/psargs-330)
[    1.869914] ACPI Error: Method parse/execution failed \_TZ.TZ00._TMP, AE_NOT_FOUND (20180810/psparse-516)
[    1.870057] ACPI BIOS Error (bug): Could not resolve [\_SB.PCI0.LPCB.HEC.ECAV], AE_NOT_FOUND (20180810/psargs-330)
[    1.870144] ACPI Error: Method parse/execution failed \_TZ.TZ01._TMP, AE_NOT_FOUND (20180810/psparse-516)
[    1.870281] ACPI BIOS Error (bug): Could not resolve [\_SB.PCI0.LPCB.HEC.ECAV], AE_NOT_FOUND (20180810/psargs-330)
[    1.870367] ACPI Error: Method parse/execution failed \_TZ.TZ01._TMP, AE_NOT_FOUND (20180810/psparse-516)
[    1.880172] SCSI subsystem initialized
[    1.882901] ACPI: bus type USB registered
[    1.882917] usbcore: registered new interface driver usbfs
[    1.882922] usbcore: registered new interface driver hub
[    1.882929] usbcore: registered new device driver usb
[    1.884930] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.884930] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.885061] xen: registering gsi 16 triggering 0 polarity 1
[    1.885066] Already setup the GSI :16
[    1.885272] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    1.887664] xen: registering gsi 16 triggering 0 polarity 1
[    1.887667] Already setup the GSI :16
[    1.887796] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    1.891040] nvme nvme0: pci function 0000:03:00.0
[    1.891112] xen: registering gsi 16 triggering 0 polarity 1
[    1.891115] Already setup the GSI :16
[    1.892718] libata version 3.00 loaded.
[    1.894028] xen: registering gsi 16 triggering 0 polarity 1
[    1.894031] Already setup the GSI :16
[    1.894101] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.894105] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    1.895191] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000001109810
[    1.897132] ahci 0000:00:17.0: version 3.0
[    1.900727] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    1.901123] xen: registering gsi 16 triggering 0 polarity 1
[    1.901127] Already setup the GSI :16
[    1.901347] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[    1.901348] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.901349] usb usb1: Product: xHCI Host Controller
[    1.901350] usb usb1: Manufacturer: Linux 4.19.0-14-amd64 xhci-hcd
[    1.901350] usb usb1: SerialNumber: 0000:00:14.0
[    1.901566] hub 1-0:1.0: USB hub found
[    1.901701] hub 1-0:1.0: 16 ports detected
[    1.904283] cryptd: max_cpu_qlen set to 1000
[    1.909676] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.909679] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    1.909681] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    1.909790] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
[    1.909791] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.909792] usb usb2: Product: xHCI Host Controller
[    1.909793] usb usb2: Manufacturer: Linux 4.19.0-14-amd64 xhci-hcd
[    1.909794] usb usb2: SerialNumber: 0000:00:14.0
[    1.909922] hub 2-0:1.0: USB hub found
[    1.909959] hub 2-0:1.0: 10 ports detected
[    1.910117] AVX2 version of gcm_enc/dec engaged.
[    1.910118] AES CTR mode by8 optimization enabled
[    1.912731] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    1.912733] ahci 0000:00:17.0: flags: 64bit ncq sntf pm led clo only pio slum part ems deso sadm sds apst
[    1.973310] scsi host0: ahci
[    1.973594] scsi host1: ahci
[    1.973772] scsi host2: ahci
[    1.973919] scsi host3: ahci
[    1.974070] scsi host4: ahci
[    1.974220] scsi host5: ahci
[    1.974269] ata1: SATA max UDMA/133 abar m2048@0xf7a37000 port 0xf7a37100 irq 158
[    1.974271] ata2: SATA max UDMA/133 abar m2048@0xf7a37000 port 0xf7a37180 irq 158
[    1.974272] ata3: SATA max UDMA/133 abar m2048@0xf7a37000 port 0xf7a37200 irq 158
[    1.974273] ata4: SATA max UDMA/133 abar m2048@0xf7a37000 port 0xf7a37280 irq 158
[    1.974274] ata5: SATA max UDMA/133 abar m2048@0xf7a37000 port 0xf7a37300 irq 158
[    1.974275] ata6: SATA max UDMA/133 abar m2048@0xf7a37000 port 0xf7a37380 irq 158
[    1.983636] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
[    2.067081] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 90:1b:0e:91:2c:45
[    2.067083] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
[    2.067173] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
[    2.067340] xen: registering gsi 19 triggering 0 polarity 1
[    2.067346] Already setup the GSI :19
[    2.067606] e1000e 0000:02:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    2.105027] nvme nvme0: missing or invalid SUBNQN field.
[    2.105115] nvme nvme0: Shutdown timeout set to 10 seconds
[    2.107658]  nvme0n1: p1 p2 p3 p4
[    2.125280] e1000e 0000:02:00.0 0000:02:00.0 (uninitialized): registered PHC clock
[    2.187850] e1000e 0000:02:00.0 eth1: (PCI Express:2.5GT/s:Width x1) 68:05:ca:61:95:04
[    2.187852] e1000e 0000:02:00.0 eth1: Intel(R) PRO/1000 Network Connection
[    2.187863] e1000e 0000:02:00.0 eth1: MAC: 3, PHY: 8, PBA No: E46981-008
[    2.190083] e1000e 0000:02:00.0 enp2s0: renamed from eth1
[    2.209006] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth0
[    2.244732] usb 1-6: new low-speed USB device number 2 using xhci_hcd
[    2.289044] ata2: SATA link down (SStatus 4 SControl 300)
[    2.289061] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.289077] ata3: SATA link down (SStatus 4 SControl 300)
[    2.289091] ata5: SATA link down (SStatus 4 SControl 300)
[    2.289105] ata1: SATA link down (SStatus 4 SControl 300)
[    2.289119] ata6: SATA link down (SStatus 4 SControl 300)
[    2.290697] ata4.00: ATA-10: TOSHIBA MG07ACA12TE, 0101, max UDMA/133
[    2.290699] ata4.00: 23437770752 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    2.292304] ata4.00: configured for UDMA/133
[    2.292494] scsi 3:0:0:0: Direct-Access     ATA      TOSHIBA MG07ACA1 0101 PQ: 0 ANSI: 5
[    2.299245] sd 3:0:0:0: [sda] 23437770752 512-byte logical blocks: (12.0 TB/10.9 TiB)
[    2.299247] sd 3:0:0:0: [sda] 4096-byte physical blocks
[    2.299250] sd 3:0:0:0: [sda] Write Protect is off
[    2.299251] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.299256] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.316718] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x396e5816e7e, max_idle_ns: 881590425445 ns
[    2.316817] clocksource: Switched to clocksource tsc
[    2.337728]  sda: sda1
[    2.338142] sd 3:0:0:0: [sda] Attached SCSI disk
[    2.435382] usb 1-6: New USB device found, idVendor=051d, idProduct=0002, bcdDevice= 1.06
[    2.435383] usb 1-6: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    2.435384] usb 1-6: Product: Back-UPS ES 550G FW:870.O4 .I USB FW:O4
[    2.435385] usb 1-6: Manufacturer: APC
[    2.435386] usb 1-6: SerialNumber: 5B1736T47082
[    2.443095] hidraw: raw HID events driver (C) Jiri Kosina
[    2.564712] usb 1-7: new high-speed USB device number 3 using xhci_hcd
[    2.599411] usbcore: registered new interface driver usbhid
[    2.599412] usbhid: USB HID core driver
[    2.602472] hid-generic 0003:051D:0002.0001: hiddev0,hidraw0: USB HID v1.10 Device [APC Back-UPS ES 550G FW:870.O4 .I USB FW:O4 ] on usb-0000:00:14.0-6/input0
[    2.627630] pciback 0000:01:00.0: seizing device
[    2.627844] xen: registering gsi 18 triggering 0 polarity 1
[    2.627849] Already setup the GSI :18
[    2.664977] xen_pciback: backend is vpci
[    2.712921] usb 1-7: New USB device found, idVendor=0409, idProduct=005a, bcdDevice= 1.00
[    2.712923] usb 1-7: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.713678] hub 1-7:1.0: USB hub found
[    2.713718] hub 1-7:1.0: 4 ports detected
[    2.752695] raid6: sse2x1   gen() 10502 MB/s
[    2.820616] raid6: sse2x1   xor()  7625 MB/s
[    2.888671] raid6: sse2x2   gen() 13625 MB/s
[    2.956654] raid6: sse2x2   xor()  9126 MB/s
[    3.000671] usb 1-7.1: new full-speed USB device number 4 using xhci_hcd
[    3.024654] raid6: sse2x4   gen() 15778 MB/s
[    3.092654] raid6: sse2x4   xor()  9809 MB/s
[    3.103848] usb 1-7.1: New USB device found, idVendor=0409, idProduct=042e, bcdDevice= 0.01
[    3.103862] usb 1-7.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.103863] usb 1-7.1: Product: PA272W
[    3.103864] usb 1-7.1: Manufacturer: NEC
[    3.103864] usb 1-7.1: SerialNumber: 45105966TW
[    3.111947] hid-generic 0003:0409:042E.0002: hiddev1,hidraw1: USB HID v1.10 Device [NEC PA272W] on usb-0000:00:14.0-7.1/input0
[    3.160667] raid6: avx2x1   gen() 20732 MB/s
[    3.208679] usb 1-7.3: new low-speed USB device number 5 using xhci_hcd
[    3.228649] raid6: avx2x1   xor() 14927 MB/s
[    3.296663] raid6: avx2x2   gen() 26540 MB/s
[    3.329470] usb 1-7.3: New USB device found, idVendor=045e, idProduct=00db, bcdDevice= 1.73
[    3.329471] usb 1-7.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.329472] usb 1-7.3: Product: Natural(r) Ergonomic Keyboard 4000
[    3.329473] usb 1-7.3: Manufacturer: Microsoft
[    3.354097] input: Microsoft Natural(r) Ergonomic Keyboard 4000 as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7.3/1-7.3:1.0/0003:045E:00DB.0003/input/input3
[    3.364666] raid6: avx2x2   xor() 16255 MB/s
[    3.412910] microsoft 0003:045E:00DB.0003: input,hidraw2: USB HID v1.11 Keyboard [Microsoft Natural(r) Ergonomic Keyboard 4000] on usb-0000:00:14.0-7.3/input0
[    3.413209] input: Microsoft Natural(r) Ergonomic Keyboard 4000 as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7.3/1-7.3:1.1/0003:045E:00DB.0004/input/input4
[    3.432672] raid6: avx2x4   gen() 30389 MB/s
[    3.448690] usb 1-7.4: new low-speed USB device number 6 using xhci_hcd
[    3.472868] microsoft 0003:045E:00DB.0004: input,hidraw3: USB HID v1.11 Device [Microsoft Natural(r) Ergonomic Keyboard 4000] on usb-0000:00:14.0-7.3/input1
[    3.500654] raid6: avx2x4   xor() 17583 MB/s
[    3.500655] raid6: using algorithm avx2x4 gen() 30389 MB/s
[    3.500655] raid6: .... xor() 17583 MB/s, rmw enabled
[    3.500656] raid6: using avx2x2 recovery algorithm
[    3.510449] xor: automatically using best checksumming function   avx
[    3.553465] usb 1-7.4: New USB device found, idVendor=045e, idProduct=00cb, bcdDevice= 1.00
[    3.553466] usb 1-7.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.553467] usb 1-7.4: Product: Microsoft USB Optical Mouse
[    3.553468] usb 1-7.4: Manufacturer: PixArt
[    3.558563] input: PixArt Microsoft USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7.4/1-7.4:1.0/0003:045E:00CB.0005/input/input5
[    3.558788] hid-generic 0003:045E:00CB.0005: input,hidraw4: USB HID v1.11 Mouse [PixArt Microsoft USB Optical Mouse] on usb-0000:00:14.0-7.4/input0
[    3.567500] Btrfs loaded, crc32c=crc32c-intel
[    3.596447] BTRFS: device label storage devid 1 transid 600 /dev/sda1
[    3.645060] PM: Image not found (code -22)
[    3.793034] EXT4-fs (nvme0n1p2): mounted filesystem with ordered data mode. Opts: (null)
[    3.943909] systemd[1]: Inserted module 'autofs4'
[    3.961511] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
[    3.961674] systemd[1]: Detected architecture x86-64.
[    3.969791] systemd[1]: Set hostname to <muthr>.
[    4.084493] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    4.084575] systemd[1]: Reached target Remote File Systems.
[    4.084818] systemd[1]: Listening on LVM2 poll daemon socket.
[    4.084897] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    4.085038] systemd[1]: Listening on fsck to fsckd communication Socket.
[    4.088790] systemd[1]: Created slice User and Session Slice.
[    4.088991] systemd[1]: Listening on udev Control Socket.
[    4.151725] EXT4-fs (nvme0n1p2): re-mounted. Opts: errors=remount-ro
[    4.154177] device-mapper: uevent: version 1.0.3
[    4.154257] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[    4.318275] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input6
[    4.318282] ACPI: Power Button [PWRB]
[    4.318344] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input7
[    4.318366] ACPI: Power Button [PWRF]
[    4.322413] systemd-journald[267]: Received request to flush runtime journal from PID 1
[    4.339766] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1A, rev-id 16)
[    4.425106] parport_pc 00:01: reported by Plug and Play ACPI
[    4.425245] parport0: PC-style at 0x378, irq 5 [PCSPP]
[    4.528722] parport_pc parport_pc.956: Unable to set coherent dma mask: disabling DMA
[    4.528909] parport_pc parport_pc.888: Unable to set coherent dma mask: disabling DMA
[    4.529021] parport_pc parport_pc.632: Unable to set coherent dma mask: disabling DMA
[    4.547327] EDAC MC0: Giving out device to module ie31200_edac controller IE31200: DEV 0000:00:00.0 (POLLED)
[    4.551979] xen: registering gsi 18 triggering 0 polarity 1
[    4.551984] Already setup the GSI :18
[    4.561922] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    4.562016] xen: registering gsi 16 triggering 0 polarity 1
[    4.562020] Already setup the GSI :16
[    4.645766] sd 3:0:0:0: Attached scsi generic sg0 type 0
[    4.718164] media: Linux media interface: v0.10
[    4.719234] iTCO_vendor_support: vendor-support=0
[    4.721786] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    4.721930] iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
[    4.722156] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    4.770797] input: PC Speaker as /devices/platform/pcspkr/input/input8
[    4.771330] videodev: Linux video capture interface: v2.00
[    4.772304] xen: registering gsi 16 triggering 0 polarity 1
[    4.772309] Already setup the GSI :16
[    4.781215] [drm] VT-d active for gfx access
[    4.781235] [drm] Replacing VGA console driver
[    4.782784] Console: switching to colour dummy device 80x25
[    4.895830] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    4.895831] [drm] Driver supports precise vblank timestamp query.
[    4.896488] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    4.896683] i915 0000:00:02.0: firmware: failed to load i915/skl_dmc_ver1_27.bin (-2)
[    4.896698] firmware_class: See https://wiki.debian.org/Firmware for information about missing firmware
[    4.896710] i915 0000:00:02.0: Direct firmware load for i915/skl_dmc_ver1_27.bin failed with error -2
[    4.896712] i915 0000:00:02.0: Failed to load DMC firmware i915/skl_dmc_ver1_27.bin. Disabling runtime power management.
[    4.896713] i915 0000:00:02.0: DMC firmware homepage: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
[    4.896934] [drm] Disabling framebuffer compression (FBC) to prevent screen flicker with VT-d enabled
[    5.005993] ppdev: user-space parallel port driver
[    5.091656] Adding 46874620k swap on /dev/nvme0n1p3.  Priority:-2 extents:1 across:46874620k SSFS
[    5.155093] EXT4-fs (nvme0n1p1): mounted filesystem with ordered data mode. Opts: (null)
[    5.245197] audit: type=1400 audit(1617909619.140:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=392 comm="apparmor_parser"
[    5.245200] audit: type=1400 audit(1617909619.140:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=392 comm="apparmor_parser"
[    5.642960] xen:xen_evtchn: Event-channel device installed
[    5.680898] IPv6: ADDRCONF(NETDEV_UP): enp0s31f6: link is not ready
[    5.740535] [drm] Initialized i915 1.6.0 20180719 for 0000:00:02.0 on minor 0
[    5.743054] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    5.743373] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input9
[    5.779506] fbcon: inteldrmfb (fb0) is primary device
[    5.808405] Console: switching to colour frame buffer device 240x67
[    5.828693] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    6.087561] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[    6.094997] xenbr0: port 1(enp0s31f6) entered blocking state
[    6.094999] xenbr0: port 1(enp0s31f6) entered disabled state
[    6.095055] device enp0s31f6 entered promiscuous mode
[    6.103828] IPv6: ADDRCONF(NETDEV_UP): xenbr0: link is not ready
[    8.299073] e1000e: enp0s31f6 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[    8.299123] xenbr0: port 1(enp0s31f6) entered blocking state
[    8.299124] xenbr0: port 1(enp0s31f6) entered forwarding state
[    8.299178] IPv6: ADDRCONF(NETDEV_CHANGE): xenbr0: link becomes ready
[   13.504246] xenbr0: port 2(vif2.0) entered blocking state
[   13.504247] xenbr0: port 2(vif2.0) entered disabled state
[   13.504299] device vif2.0 entered promiscuous mode
[   13.509077] IPv6: ADDRCONF(NETDEV_UP): vif2.0: link is not ready
[   15.573433] xen-blkback: backend/vbd/2/51714: using 2 queues, protocol 1 (x86_64-abi) persistent grants
[   15.580078] xen-blkback: backend/vbd/2/51713: using 2 queues, protocol 1 (x86_64-abi) persistent grants
[   15.594691] vif vif-2-0 vif2.0: Guest Rx ready
[   15.595212] IPv6: ADDRCONF(NETDEV_CHANGE): vif2.0: link becomes ready
[   15.595233] xenbr0: port 2(vif2.0) entered blocking state
[   15.595234] xenbr0: port 2(vif2.0) entered forwarding state
[   15.667976] usb 1-7: USB disconnect, device number 3
[   15.667978] usb 1-7.1: USB disconnect, device number 4
[   15.669115] usb 1-7.3: USB disconnect, device number 5
[   15.809492] usb 1-7.4: USB disconnect, device number 6
[   17.678303] xenbr0: port 3(vif3.0) entered blocking state
[   17.678304] xenbr0: port 3(vif3.0) entered disabled state
[   17.678356] device vif3.0 entered promiscuous mode
[   17.682940] IPv6: ADDRCONF(NETDEV_UP): vif3.0: link is not ready
[   17.743656] pciback 0000:01:00.0: enabling permissive mode configuration space accesses!
[   17.743658] pciback 0000:01:00.0: permissive mode is potentially unsafe!
[   17.758861] xen_pciback: vpci: 0000:01:00.0: assign to virtual slot 0
[   17.758982] pciback 0000:01:00.0: registering for 3
[   19.570711] xen-blkback: backend/vbd/3/51714: using 1 queues, protocol 1 (x86_64-abi) persistent grants
[   19.581799] vif vif-3-0 vif3.0: Guest Rx ready
[   19.582601] IPv6: ADDRCONF(NETDEV_CHANGE): vif3.0: link becomes ready
[   19.582623] xenbr0: port 3(vif3.0) entered blocking state
[   19.582624] xenbr0: port 3(vif3.0) entered forwarding state
[   19.585574] xen-blkback: backend/vbd/3/51713: using 1 queues, protocol 1 (x86_64-abi) persistent grants
[   20.764318] xen: registering gsi 18 triggering 0 polarity 1
[   20.764324] Already setup the GSI :18
[   20.764963] xen: registering gsi 18 triggering 0 polarity 1
[   20.764966] Already setup the GSI :18
[   20.765365] xen: registering gsi 18 triggering 0 polarity 1
[   20.765367] Already setup the GSI :18
[   20.765754] xen: registering gsi 18 triggering 0 polarity 1
[   20.765757] Already setup the GSI :18
[   20.766092] xen: registering gsi 18 triggering 0 polarity 1
[   20.766095] Already setup the GSI :18
[   20.766439] xen: registering gsi 18 triggering 0 polarity 1
[   20.766441] Already setup the GSI :18
[ 1513.828943] xenbr0: port 4(vif4.0) entered blocking state
[ 1513.828945] xenbr0: port 4(vif4.0) entered disabled state
[ 1513.828998] device vif4.0 entered promiscuous mode
[ 1513.833656] IPv6: ADDRCONF(NETDEV_UP): vif4.0: link is not ready
[ 1515.933764] xen-blkback: backend/vbd/4/51714: using 1 queues, protocol 1 (x86_64-abi) persistent grants
[ 1515.946766] vif vif-4-0 vif4.0: Guest Rx ready
[ 1515.947443] IPv6: ADDRCONF(NETDEV_CHANGE): vif4.0: link becomes ready
[ 1515.947467] xenbr0: port 4(vif4.0) entered blocking state
[ 1515.947468] xenbr0: port 4(vif4.0) entered forwarding state
[ 1515.948611] xen-blkback: backend/vbd/4/51713: using 1 queues, protocol 1 (x86_64-abi) persistent grants
[ 1515.954660] xen-blkback: backend/vbd/4/51729: using 1 queues, protocol 1 (x86_64-abi) persistent grants
[ 2180.428635] xenbr0: port 5(vif5.0) entered blocking state
[ 2180.428636] xenbr0: port 5(vif5.0) entered disabled state
[ 2180.428691] device vif5.0 entered promiscuous mode
[ 2180.433374] IPv6: ADDRCONF(NETDEV_UP): vif5.0: link is not ready
[ 2182.527593] vif vif-5-0 vif5.0: Guest Rx ready
[ 2182.528761] IPv6: ADDRCONF(NETDEV_CHANGE): vif5.0: link becomes ready
[ 2182.528783] xenbr0: port 5(vif5.0) entered blocking state
[ 2182.528784] xenbr0: port 5(vif5.0) entered forwarding state
[ 2182.529622] xen-blkback: backend/vbd/5/51714: using 1 queues, protocol 1 (x86_64-abi) persistent grants
[ 2182.534776] xen-blkback: backend/vbd/5/51713: using 1 queues, protocol 1 (x86_64-abi) persistent grants
[59342.947403] xenbr0: port 3(vif3.0) entered disabled state
[59353.134366] xenbr0: port 3(vif3.0) entered disabled state
[59353.134626] device vif3.0 left promiscuous mode
[59353.134632] xenbr0: port 3(vif3.0) entered disabled state
[59359.284037] xenbr0: port 3(vif6.0) entered blocking state
[59359.284038] xenbr0: port 3(vif6.0) entered disabled state
[59359.284091] device vif6.0 entered promiscuous mode
[59359.288851] IPv6: ADDRCONF(NETDEV_UP): vif6.0: link is not ready
[59360.943334] xen-blkback: backend/vbd/6/51714: using 1 queues, protocol 1 (x86_64-abi) persistent grants
[59360.951989] vif vif-6-0 vif6.0: Guest Rx ready
[59360.952693] IPv6: ADDRCONF(NETDEV_CHANGE): vif6.0: link becomes ready
[59360.952715] xenbr0: port 3(vif6.0) entered blocking state
[59360.952716] xenbr0: port 3(vif6.0) entered forwarding state
[59360.959067] xen-blkback: backend/vbd/6/51713: using 1 queues, protocol 1 (x86_64-abi) persistent grants
[59451.634454] xenbr0: port 3(vif6.0) entered disabled state
[59451.683038] xenbr0: port 3(vif6.0) entered disabled state
[59451.683158] device vif6.0 left promiscuous mode
[59451.683164] xenbr0: port 3(vif6.0) entered disabled state
[59522.295699] xenbr0: port 3(vif7.0) entered blocking state
[59522.295701] xenbr0: port 3(vif7.0) entered disabled state
[59522.295753] device vif7.0 entered promiscuous mode
[59522.300372] IPv6: ADDRCONF(NETDEV_UP): vif7.0: link is not ready
[59522.380133] xen_pciback: vpci: 0000:01:00.0: assign to virtual slot 0
[59522.380258] pciback 0000:01:00.0: registering for 7
[59526.082871] vif vif-7-0 vif7.0: Guest Rx ready
[59526.083645] IPv6: ADDRCONF(NETDEV_CHANGE): vif7.0: link becomes ready
[59526.083668] xenbr0: port 3(vif7.0) entered blocking state
[59526.083669] xenbr0: port 3(vif7.0) entered forwarding state
[59526.088013] xen-blkback: backend/vbd/7/51714: using 1 queues, protocol 1 (x86_64-abi) persistent grants
[59526.092006] xen-blkback: backend/vbd/7/51713: using 1 queues, protocol 1 (x86_64-abi) persistent grants
[59527.221273] xen: registering gsi 18 triggering 0 polarity 1
[59527.221279] Already setup the GSI :18
[59527.221868] xen: registering gsi 18 triggering 0 polarity 1
[59527.221871] Already setup the GSI :18
[59527.222333] xen: registering gsi 18 triggering 0 polarity 1
[59527.222336] Already setup the GSI :18
[59527.222717] xen: registering gsi 18 triggering 0 polarity 1
[59527.222719] Already setup the GSI :18
[59527.223097] xen: registering gsi 18 triggering 0 polarity 1
[59527.223099] Already setup the GSI :18
[59527.223480] xen: registering gsi 18 triggering 0 polarity 1
[59527.223482] Already setup the GSI :18
[80158.969832] BTRFS info (device sda1): disk space caching is enabled
[80158.969834] BTRFS info (device sda1): has skinny extents
[80159.077386] BTRFS error (device sda1): parent transid verify failed on 30982144 wanted 15 found 707
[80159.087265] BTRFS error (device sda1): parent transid verify failed on 30982144 wanted 15 found 707
[80159.087343] BTRFS warning (device sda1): failed to read root (objectid=9): -5
[80159.107035] BTRFS error (device sda1): open_ctree failed

dmesg from domU with the Samba server (BTRFS partition is passed through):
[    0.000000] Linux version 4.19.0-16-amd64 (debian-kernel@lists.debian.org) (gcc version 8.3.0 (Debian 8.3.0-6)) #1 SMP Debian 4.19.181-1 (2021-03-19)
[    0.000000] Command line: root=/dev/xvda2 ro elevator=noop root=/dev/xvda2 ro
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] ACPI in unprivileged domain disabled
[    0.000000] Released 0 page(s)
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] Xen: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] Xen: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] Xen: [mem 0x0000000000100000-0x000000007fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI not present or invalid.
[    0.000000] Hypervisor detected: Xen PV
[    0.173963] tsc: Fast TSC calibration failed
[    0.173964] tsc: Detected 1992.139 MHz processor
[    0.173976] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.173977] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.173980] last_pfn = 0x80000 max_arch_pfn = 0x400000000
[    0.173981] Disabled
[    0.173982] x86/PAT: MTRRs disabled, skipping PAT initialization too.
[    0.173986] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WC  WP  UC  UC
[    0.400936] Kernel/User page tables isolation: disabled on XEN PV.
[    1.127410] RAMDISK: [mem 0x02c00000-0x082a0fff]
[    1.127703] NUMA turned off
[    1.127704] Faking a node at [mem 0x0000000000000000-0x000000007fffffff]
[    1.127708] NODE_DATA(0) allocated [mem 0x7fc1c000-0x7fc20fff]
[    1.139713] Zone ranges:
[    1.139714]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    1.139716]   DMA32    [mem 0x0000000001000000-0x000000007fffffff]
[    1.139717]   Normal   empty
[    1.139718]   Device   empty
[    1.139718] Movable zone start for each node
[    1.139719] Early memory node ranges
[    1.139720]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    1.139721]   node   0: [mem 0x0000000000100000-0x000000007fffffff]
[    1.139724] Zeroed struct page in unavailable ranges: 97 pages
[    1.139725] Initmem setup node 0 [mem 0x0000000000001000-0x000000007fffffff]
[    1.139726] On node 0 totalpages: 524191
[    1.139727]   DMA zone: 64 pages used for memmap
[    1.139727]   DMA zone: 21 pages reserved
[    1.139728]   DMA zone: 3999 pages, LIFO batch:0
[    1.139806]   DMA32 zone: 8128 pages used for memmap
[    1.139806]   DMA32 zone: 520192 pages, LIFO batch:63
[    1.149871] p2m virtual area at (____ptrval____), size is 40000000
[    1.340702] Remapped 0 page(s)
[    1.340817] SFI: Simple Firmware Interface v0.81 http://simplefirmware.org
[    1.341057] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    1.341063] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    1.341064] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    1.341066] [mem 0x80000000-0xffffffff] available for PCI devices
[    1.341070] Booting paravirtualized kernel on Xen
[    1.341071] Xen version: 4.11.4 (preserve-AD)
[    1.341073] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    1.425469] random: get_random_bytes called from start_kernel+0x93/0x52a with crng_init=0
[    1.425474] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:1 nr_node_ids:1
[    1.425571] percpu: Embedded 45 pages/cpu s144536 r8192 d31592 u2097152
[    1.425574] pcpu-alloc: s144536 r8192 d31592 u2097152 alloc=1*2097152
[    1.425575] pcpu-alloc: [0] 0
[    1.425607] xen: PV spinlocks disabled
[    1.425611] Built 1 zonelists, mobility grouping on.  Total pages: 515978
[    1.425612] Policy zone: DMA32
[    1.425614] Kernel command line: root=/dev/xvda2 ro elevator=noop root=/dev/xvda2 ro
[    1.425952] Calgary: detecting Calgary via BIOS EBDA area
[    1.425953] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    1.431265] Memory: 1942040K/2096764K available (10252K kernel code, 1242K rwdata, 3328K rodata, 1600K init, 2260K bss, 154724K reserved, 0K cma-reserved)
[    1.431451] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    1.432615] ftrace: allocating 31978 entries in 125 pages
[    1.443790] rcu: Hierarchical RCU implementation.
[    1.443792] rcu:     RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=1.
[    1.443793] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    1.448196] Using NULL legacy PIC
[    1.448197] NR_IRQS: 33024, nr_irqs: 32, preallocated irqs: 0
[    1.448223] xen:events: Using FIFO-based ABI
[    1.448255] Console: colour dummy device 80x25
[    1.448316] console [tty0] enabled
[    1.448959] console [hvc0] enabled
[    1.448997] clocksource: xen: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    1.449035] Xen: using vcpuop timer interface
[    1.449052] installing Xen timer for CPU 0
[    1.449261] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x396e5816e7e, max_idle_ns: 881590425445 ns
[    1.449416] Calibrating delay loop (skipped), value calculated using timer frequency.. 3984.27 BogoMIPS (lpj=7968556)
[    1.449447] pid_max: default: 32768 minimum: 301
[    1.449589] Security Framework initialized
[    1.449598] Yama: disabled by default; enable with sysctl kernel.yama.*
[    1.449727] AppArmor: AppArmor initialized
[    1.450813] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    1.451425] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    1.451500] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    1.451530] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes)
[    1.452149] Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
[    1.452159] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    1.452171] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    1.452183] Spectre V2 : Mitigation: Full generic retpoline
[    1.452190] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    1.452201] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    1.452261] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    1.452290] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
[    1.452300] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    1.452723] TAA: Mitigation: Clear CPU buffers
[    1.452732] SRBDS: Unknown: Dependent on hypervisor status
[    1.452739] MDS: Mitigation: Clear CPU buffers
[    1.534540] Freeing SMP alternatives memory: 24K
[    1.536259] VPMU disabled by hypervisor.
[    1.536576] Performance Events: unsupported p6 CPU model 94 no PMU driver, software events only.
[    1.536753] rcu: Hierarchical SRCU implementation.
[    1.537211] random: crng done (trusting CPU's manufacturer)
[    1.537302] NMI watchdog: Perf NMI watchdog permanently disabled
[    1.537437] smp: Bringing up secondary CPUs ...
[    1.537461] smp: Brought up 1 node, 1 CPU
[    1.537467] smpboot: Max logical packages: 1
[    1.537668] devtmpfs: initialized
[    1.537714] x86/mm: Memory block size: 128MB
[    1.537973] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.537994] futex hash table entries: 256 (order: 2, 16384 bytes)
[    1.538055] pinctrl core: initialized pinctrl subsystem
[    1.538190] NET: Registered protocol family 16
[    1.538213] xen:grant_table: Grant tables using version 1 layout
[    1.538235] Grant table initialized
[    1.538267] audit: initializing netlink subsys (disabled)
[    1.538377] audit: type=2000 audit(1617911129.538:1): state=initialized audit_enabled=0 res=1
[    1.539151] PCI: setting up Xen PCI frontend stub
[    1.539159] PCI: pci_cache_line_size set to 64 bytes
[    1.541599] ACPI: Interpreter disabled.
[    1.541611] xen:balloon: Initialising balloon driver
[    1.541658] vgaarb: loaded
[    1.541658] pps_core: LinuxPPS API ver. 1 registered
[    1.541658] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.541658] PTP clock support registered
[    1.541658] EDAC MC: Ver: 3.0.0
[    1.541658] PCI: System does not support PCI
[    1.541902] clocksource: Switched to clocksource xen
[    1.549470] VFS: Disk quotas dquot_6.6.0
[    1.549487] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.549506] hugetlbfs: disabling because there are no supported hugepage sizes
[    1.549559] AppArmor: AppArmor Filesystem Enabled
[    1.549573] pnp: PnP ACPI: disabled
[    1.550849] NET: Registered protocol family 2
[    1.550957] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes)
[    1.551017] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    1.551131] TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
[    1.551157] TCP: Hash tables configured (established 16384 bind 16384)
[    1.551191] UDP hash table entries: 1024 (order: 3, 32768 bytes)
[    1.646021] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes)
[    1.646087] NET: Registered protocol family 1
[    1.646099] NET: Registered protocol family 44
[    1.646107] PCI: CLS 0 bytes, default 64
[    1.646129] Unpacking initramfs...
[    1.682566] Freeing initrd memory: 88708K
[    1.687482] Initialise system trusted keyrings
[    1.687515] Key type blacklist registered
[    1.687582] workingset: timestamp_bits=40 max_order=19 bucket_order=0
[    1.688623] zbud: loaded
[    1.805627] Key type asymmetric registered
[    1.805636] Asymmetric key parser 'x509' registered
[    1.805664] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    1.805735] io scheduler noop registered (default)
[    1.805742] io scheduler deadline registered
[    1.805783] io scheduler cfq registered
[    1.805805] io scheduler mq-deadline registered
[    1.805959] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.805981] intel_idle: Please enable MWAIT in BIOS SETUP
[    1.806388] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.806800] Linux agpgart interface v0.103
[    1.806863] AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    1.806872] AMD IOMMUv2 functionality not available on this system
[    1.807009] i8042: PNP: No PS/2 controller found.
[    1.807017] i8042: Probing ports directly.
[    1.807894] i8042: No controller found
[    1.807944] mousedev: PS/2 mouse device common for all mice
[    1.808010] ledtrig-cpu: registered to indicate activity on CPUs
[    1.808204] NET: Registered protocol family 10
[    1.824640] Segment Routing with IPv6
[    1.824679] mip6: Mobile IPv6
[    1.824687] NET: Registered protocol family 17
[    1.824753] mpls_gso: MPLS GSO support
[    1.824842] mce: Using 2 MCE banks
[    1.824860] sched_clock: Marking stable (1820236433, 1047173)->(1824119344, -2835738)
[    1.825500] registered taskstats version 1
[    1.825509] Loading compiled-in X.509 certificates
[    1.851978] Loaded X.509 cert 'Debian Secure Boot CA: 6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419ea1'
[    1.852016] Loaded X.509 cert 'Debian Secure Boot Signer 2021 - linux: 4b6ef5abca669825178e052c84667ccbc0531f8c'
[    1.852068] zswap: loaded using pool lzo/zbud
[    1.852418] AppArmor: AppArmor sha1 policy hashing enabled
[    1.852663] xenbus_probe_frontend: Device with no driver: device/vbd/51714
[    1.852673] xenbus_probe_frontend: Device with no driver: device/vbd/51713
[    1.852682] xenbus_probe_frontend: Device with no driver: device/vbd/51729
[    1.852704] xenbus_probe_frontend: Device with no driver: device/vif/0
[    1.852751] hctosys: unable to open rtc device (rtc0)
[    1.854404] Freeing unused kernel image memory: 1600K
[    1.865380] Write protecting the kernel read-only data: 16384k
[    1.879226] Freeing unused kernel image memory: 2028K
[    1.880079] Freeing unused kernel image memory: 768K
[    1.917234] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.917245] Run /init as init process
[    2.039595] cryptd: max_cpu_qlen set to 1000
[    2.048101] Invalid max_queues (4), will use default max: 1.
[    2.054109] xen_netfront: Initialising Xen virtual ethernet driver
[    2.064133] AVX2 version of gcm_enc/dec engaged.
[    2.064144] AES CTR mode by8 optimization enabled
[    2.075348] blkfront: xvda2: flush diskcache: enabled; persistent grants: enabled; indirect descriptors: enabled;
[    2.078184] blkfront: xvda1: flush diskcache: enabled; persistent grants: enabled; indirect descriptors: enabled;
[    2.081645] blkfront: xvdb1: flush diskcache: enabled; persistent grants: enabled; indirect descriptors: enabled;
[    2.697402] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x396e5816e7e, max_idle_ns: 881590425445 ns
[    3.453285] raid6: sse2x1   gen() 10081 MB/s
[    3.521285] raid6: sse2x1   xor()  7417 MB/s
[    3.589284] raid6: sse2x2   gen() 13500 MB/s
[    3.657284] raid6: sse2x2   xor()  9040 MB/s
[    3.725287] raid6: sse2x4   gen() 15746 MB/s
[    3.793286] raid6: sse2x4   xor()  9561 MB/s
[    3.861285] raid6: avx2x1   gen() 21220 MB/s
[    3.929284] raid6: avx2x1   xor() 14791 MB/s
[    3.997283] raid6: avx2x2   gen() 25762 MB/s
[    4.065284] raid6: avx2x2   xor() 16473 MB/s
[    4.133284] raid6: avx2x4   gen() 29165 MB/s
[    4.201284] raid6: avx2x4   xor() 16756 MB/s
[    4.201292] raid6: using algorithm avx2x4 gen() 29165 MB/s
[    4.201299] raid6: .... xor() 16756 MB/s, rmw enabled
[    4.201322] raid6: using avx2x2 recovery algorithm
[    4.211439] xor: automatically using best checksumming function   avx
[    4.283446] Btrfs loaded, crc32c=crc32c-intel
[    4.314797] BTRFS: device label storage devid 1 transid 600 /dev/xvdb1
[    4.351439] PM: Image not found (code -22)
[    4.469896] EXT4-fs (xvda2): mounted filesystem with ordered data mode. Opts: (null)
[    4.601265] systemd[1]: Inserted module 'autofs4'
[    4.612943] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
[    4.613085] systemd[1]: Detected virtualization xen.
[    4.613131] systemd[1]: Detected architecture x86-64.
[    4.619475] systemd[1]: Set hostname to <know>.
[    4.811983] systemd[1]: /lib/systemd/system/winbind.service:8: PIDFile= references path below legacy directory /var/run/, updating /var/run/samba/winbindd.pid \xe2\x86\x92 /run/samba/winbindd.pid; please update the unit file accordingly.
[    4.821737] systemd[1]: /lib/systemd/system/smbd.service:9: PIDFile= references path below legacy directory /var/run/, updating /var/run/samba/smbd.pid \xe2\x86\x92 /run/samba/smbd.pid; please update the unit file accordingly.
[    4.823000] systemd[1]: /lib/systemd/system/nmbd.service:9: PIDFile= references path below legacy directory /var/run/, updating /var/run/samba/nmbd.pid \xe2\x86\x92 /run/samba/nmbd.pid; please update the unit file accordingly.
[    4.835477] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    4.838111] systemd[1]: Created slice User and Session Slice.
[    4.838833] systemd[1]: Created slice system-serial\x2dgetty.slice.
[    4.973348] EXT4-fs (xvda2): re-mounted. Opts: errors=remount-ro
[    5.172188] systemd-journald[208]: Received request to flush runtime journal from PID 1
[    5.285907] input: PC Speaker as /devices/platform/pcspkr/input/input0
[    5.727638] BTRFS info (device xvdb1): disk space caching is enabled
[    5.727653] BTRFS info (device xvdb1): has skinny extents
[    5.746024] Adding 524284k swap on /dev/xvda1.  Priority:-2 extents:1 across:524284k SSFS


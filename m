Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20668466D3D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 23:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbhLBWxr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 17:53:47 -0500
Received: from mail-bn8nam11on2122.outbound.protection.outlook.com ([40.107.236.122]:23776
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232923AbhLBWxq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Dec 2021 17:53:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJp9rYMdJV05XV1IscnvLUSiPtsR/ifo6Z6xmrBHZCYMMzuysDqgqSMkRdPvdHySKBQotPSb99fEYwHaxf0UAzgpHWBc4RERRSMVRbF5U97ssUy5CmPJm/xpIPyAGDVThP7dp1E0ij4P6fJi0OIdA6mrl+r5nz2/jh4CtSiNzcbF3CE+menZsJodld2Trgpo8Miz8m44q6xMW92dEf7MNPwiBoN0mHQmKSaijsUPiSppkyqtIrgNA+VvOV2/4+7H8t5yuT4ZqcezLeDKktBTUssmy6RdsCUTu+FTWbs6I89f3ql1lHzpiYkb1OvgpNpCmHr7iP3oT/Rai8rMSjhRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ai7FmcFpqw4R5Lt7r9s/u+qAowfjvK1T2bwo9ie9M7M=;
 b=WTL9XEcLOfiD0YYWavOUV1OiVJ8Oj3ME2NH9gEt9VwPfk8gEHu03ZeLz8uMgDBLu+clPyJ910KuLdMe/TVJFpcEgJm8tL082sutcWUJWyk9H0JdzYYVHGZppQ7CBSmkiIW2b5zV5PQCrEB4AximirOsKTAShft5P2m567td9B+rszypsb8oGgpLaQghoO9K/VyaibHle+p4J7v4NpFzoOgOrhYyK0tRovVbyeBR8jmzR/1JeqkNcMzeWKtLWlV+o5RiR4ZbK+Drq2/kmL/SaY2QEcIg5sh1BGjK2cEY2RGpgK8vXFht9wc41k2kswgc5kCZPMjPkN6RQw8dZyKYYAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rollins.edu; dmarc=pass action=none header.from=rollins.edu;
 dkim=pass header.d=rollins.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rollins.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ai7FmcFpqw4R5Lt7r9s/u+qAowfjvK1T2bwo9ie9M7M=;
 b=aGbEMPdDRieXmuIFMxH+sIFY9dsm7l7S/IWOCW+7mNhRt0y9NqW8UbGJ3WwyQLBNFHo6Y0vtcvmhlwQYZ/9mSP6Jj1n3kYZsRqvNC9tWhAY9uyd6K5QU5n3IKxUxP24KWM1xp8RgWEJBfvCaGnNJ4//eCa3DR0YXkdE1xfSo3+0=
Received: from DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:32::12) by
 DM8P220MB0407.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:24::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Thu, 2 Dec 2021 22:50:21 +0000
Received: from DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7488:5485:739b:c303]) by DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7488:5485:739b:c303%9]) with mapi id 15.20.4734.028; Thu, 2 Dec 2021
 22:50:21 +0000
From:   Charlie Lin <CLIN@Rollins.edu>
To:     Hugo Mills <hugo@carfax.org.uk>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Unable to Mount Btrfs Partition used on Both Funtoo and Windows
Thread-Topic: Unable to Mount Btrfs Partition used on Both Funtoo and Windows
Thread-Index: AQHX58t5+GVppLc5S0ePxfaVV1jvJawfyWsAgAAEn94=
Date:   Thu, 2 Dec 2021 22:50:21 +0000
Message-ID: <DM8P220MB03423618BD92E125EAC107EEC1699@DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM>
References: <DM8P220MB0342912966C295206FF80725C1699@DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM>
 <20211202223236.GC3478@savella.carfax.org.uk>
In-Reply-To: <20211202223236.GC3478@savella.carfax.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 7936c266-589a-8a87-92b3-14aa96562ff4
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Rollins.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 780da1ba-85e2-40d6-7c8f-08d9b5e61f15
x-ms-traffictypediagnostic: DM8P220MB0407:
x-microsoft-antispam-prvs: <DM8P220MB04072FD7C164AFB0CB13CC86C1699@DM8P220MB0407.NAMP220.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pKpFGwbRnOGAnu2b3hhCPfigNkpm1yC/7/PwMops2CjjTwNvWOCZEfj+Mmcws0AEZaNfAmzA+Vnea8klNNcMKIrObI50fb6h7CaA0CIpnbdquezsgsPYcdgPytyP7G2ZwaffSy2BlTZm5zlBF2rlVWqtn/k+UiyLRG7Lk0wxg5bNoEtUak1/nT065gK0j6wmsZNKSKDcLrokkbx1OOdfXVzWhFhUL0NvwUXJhGCzgXtkWneQ3dIAM3kOgOXufMJwWR/ZuuDd20aYYg4jxJ9UACigUk/mJOS+M/8E/RNZROCRheGaxzjRlC8j/QyoqvGMcatLx0unFR7/w9LjHlwnmk8BrXDQpxJJ6eyFpwM8MrMeBh3ExvanObQfSBRb5WeGcn8GYoNbbdETgaF2q4MVYWOjKWqEQhq5Z/7tWYOfy6oC1naR99WBVGkPM7A+lNrbZMLLIViaIe5T6OL4xwHVdlRiuY7EfApH/KLKeYIqBC9dh8yO33+tW7QFeArGhpMBIx7rtewGDCIbvQyh4tSDkckSaE+p7F0pw2ysTKFKxQuwItV2QG8Adt6SZoCKdqc4FolkgR2FGpu63iZswx5D7OoP57sVNg0rXy8DAWUC1W+NrJNOq7XHhevpz3Qw0XHR/rh8XjRZT8U722VPCWo/HcADAd8HWk+TQgfk2jFK/lkqlHWqAZAc7/51w07A3cd/nKBRooIKUznHZVpcYa98HNhNneqa1gfkO/dZ636V4fjrnFZKFPh6p5EhypmtBBk83Mot7d6cMBgQJDX967vcr6TEFkBP77RQUId85+uhBlY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(64756008)(55016003)(91956017)(71200400001)(2906002)(186003)(66476007)(66446008)(4326008)(45080400002)(26005)(76116006)(75432002)(6506007)(52536014)(66556008)(38070700005)(8936002)(5660300002)(53546011)(7696005)(66946007)(83380400001)(508600001)(786003)(8676002)(316002)(122000001)(966005)(33656002)(9686003)(38100700002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jrZobCtB6Dmjw2P7Vg+cOkDpZg2HFwuVsD3bILFIvTtAUSgulDD2nDTaBr+P?=
 =?us-ascii?Q?CDaqMaReoMn58tF+OA1WHoqNOwYXxwpLB3VS5RuutjcFF5gdym6XoSj0Qa6L?=
 =?us-ascii?Q?v///Uag478BgWpAGZTSRsabs3bHSj/KLX0kjpTVZfuHPXocFkQqLSwATOzRm?=
 =?us-ascii?Q?eor6YRZJzWp5at6q2g6mCTtSTBhN5cOUC+6aRpK8QULWesg8RGnxgDXeuzmx?=
 =?us-ascii?Q?8y1I+4+30A1mADo/IR5PTadnv8HJEZ0MA+UwR3un+FrFWAWcukKzsIwgOkBX?=
 =?us-ascii?Q?P+H20OXba64DL0sJowEIGhKhzDDjuIZubC66XSImaeEs/xsarBHqHqLoZ4LO?=
 =?us-ascii?Q?meiSiKOvn5efzLWrd9s1/MREFFUshAwfTeccHS7BLTLZCZXiViHeA6hosJcr?=
 =?us-ascii?Q?fG5zkQJasuTlkXRsrlCK2srTIQ7Xr6JG/o0eclkBw3vCrlzDzycnxmz9omC8?=
 =?us-ascii?Q?bs65a/H6ySkQsvOSVEWw3KBpq4YyBtjBU+1f6GammfPoIXtazn1m9onqF/2K?=
 =?us-ascii?Q?D6ouzTNjmoP5CVDf0LmjEwO//o86/tU4xKtevbs3teHECPfzMsy2vDvpeVgH?=
 =?us-ascii?Q?Iihid0AHv+32UYRBh/r98lD1SU7IE844LSBZpRUjRb41XKzvpRAZJakz5OF9?=
 =?us-ascii?Q?rWzdZdfYK0+PCc5GCEojZ35pIPfZbktTqPIX32416SE6ANsckBnY8VE3+tNY?=
 =?us-ascii?Q?qTon1VFR3Sj7CRFA7TcLguxhT0Gf0fD2ebyfLTvrqUa4Hxqr55KVx4a7hIhI?=
 =?us-ascii?Q?UGSil3iPGKFPVrMQW5mGl4AyWI28sgfFHdgXKkOGPghfJQawyO994y+Dua00?=
 =?us-ascii?Q?7k8ZAVnzYGG/CB6feDgNFybk/qTNUmGqup+IG5xVCfLFX8e6BD/LAw2k4A42?=
 =?us-ascii?Q?61nSE6A7J/O5R8u2eq8dPQv/SvzAoShuhRorHF/SrPg/vy2ZQT5CAxRfIO1p?=
 =?us-ascii?Q?Hq9nWGG8aWiAAO6nHRLLEgkqWHh701RtXE3S/J8xhbzh5Ssjzhd7JVSx/RVs?=
 =?us-ascii?Q?o4jSIzY2/LqPKrkI+agPDYRpiXW1/mL8Hbup8SNJ7pwLyAUx8nYkoRG9HeHe?=
 =?us-ascii?Q?7dF3kCLDeysnntBO8zbvtWu1LWr8TvfD2qs0Sp/qo9D79mjzCc+cp0GoGJit?=
 =?us-ascii?Q?1zdHzaLmeLLSS7WOeiZgPrUgoKEc4ItMd5HRVHN/pi5qlMHQhlFdIf361INl?=
 =?us-ascii?Q?Zov34s7CV/DCNafyhc4ujIfAZ0SMAisMQomDZV+EjANXu2lz8eOQPjU5XPIj?=
 =?us-ascii?Q?JKOcYDe+1GULIB8oMDp4+2Hq7oBwzSvei5YXGzUy9RYzczBRGnCzfXpqBJht?=
 =?us-ascii?Q?wkcki0NXPKsCjIHD7jfSawlcB06tMonoNuRKyNyyyRP+qC8I2tV0BX7fAhKg?=
 =?us-ascii?Q?AOOXIYikar2v3z0jaRNnB3sFiYZbXXDH3xJ9G9q0aFb2p8mVKekiOsrSXtBA?=
 =?us-ascii?Q?36aXZIh9Qn6l25qUiiIBKXMYpStHQBPeqx0dnxyw8W2nA+tAyBGQDAlm+RQK?=
 =?us-ascii?Q?s/H1vNkc+grtwkY74B/yZ0uljGqXVDQk57i/cHOUHTZygJdY5zjFXNALuac/?=
 =?us-ascii?Q?tvBUNypJZGqeQtuV+Sy/BbMrx3HE5GtP8XyRZiqEOCFMfJUJAart0P3eEB26?=
 =?us-ascii?Q?bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: rollins.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8P220MB0342.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 780da1ba-85e2-40d6-7c8f-08d9b5e61f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 22:50:21.7237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b8e8d71a-947d-41dd-81dd-8401dcc51007
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y0BHj8ADEz/btVGEWnb6XkEG3D7WPSgpVYCRn9mL8oaY3pTzRy8FglzE5C5dUcoEVQ3itjuEgO4BlAomzslDJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8P220MB0407
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Is it still advisable to run btrfs check on the partition in 2021?

________________________________________
From: Hugo Mills <hugo@carfax.org.uk>
Sent: Thursday, December 2, 2021 5:32 PM
To: Charlie Lin
Cc: rm@romanrm.net; linux-btrfs@vger.kernel.org
Subject: Re: Unable to Mount Btrfs Partition used on Both Funtoo and Window=
s

* External Email *


On Thu, Dec 02, 2021 at 10:25:53PM +0000, Charlie Lin wrote:
>
> I'm actually dual-booting both systems on my laptop ie (Funtoo's kernel a=
nd initramfs are on the same EFI system partition that Windows uses)
>
> Admittedly, I configured Windows to mount those Btrfs partitions at start=
up, and for both OSes to be able to hibernate, so that I can access the aff=
ected partition by hibernating one OS then resuming on the other. This work=
ed well for about three weeks.

   This is approximately equal to mounting the FS on both machines at
the same time. Honestly, I'm surprised it lasted as long as three
weeks. I'd have said three minutes would be nearer the expected
lifetime. When you hibernate/suspend a machine, it stores its current
kernel state (including memory relating to things like filesystems),
and then restores that state when it resumes. If, in the meantime,
something else (like another OS) modifies the FS, you're effectively
injecting changes into the on-disk data that the hibernated OS doesn't
know about on resume.

> Anyway, are there commands to try to recover /dev/nvme0n1p{6,8}?

   The phrase "masssive filesystem metadata corruption" springs to
mind here, with a follow up of "it's dead, Jim". You might get
something out of it with btrfs restore, although restoring from your
backups is probably going to be much easier. The FS itself needs to be
rebuilt with mkfs.

   Hugo.

--
Hugo Mills             | Two things came out of Berkeley in the 1960s: LSD
hugo@... carfax.org.uk | and Unix. This is not a coincidence.
https://nam10.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fcarfax.o=
rg.uk%2F&amp;data=3D04%7C01%7CCLIN%40Rollins.edu%7Cb5264c1f5b5d480293be08d9=
b5e41b8c%7Cb8e8d71a947d41dd81dd8401dcc51007%7C0%7C0%7C637740814482794269%7C=
Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL=
CJXVCI6Mn0%3D%7C3000&amp;sdata=3DQriqcPu4YG4yZ131EIs%2Beyh66q4uQxCA9SB87Lw5=
dZU%3D&amp;reserved=3D0  |
PGP: E2AB1DE4          |

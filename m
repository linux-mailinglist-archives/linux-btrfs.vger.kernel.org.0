Return-Path: <linux-btrfs+bounces-7053-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5361F94C58F
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 22:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801271C221F4
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 20:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB190155A25;
	Thu,  8 Aug 2024 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=enstafr.onmicrosoft.com header.i=@enstafr.onmicrosoft.com header.b="l8jsPFYK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from PAUP264CU001.outbound.protection.outlook.com (mail-francecentralazon11021125.outbound.protection.outlook.com [40.107.160.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82E3146A72
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.160.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148333; cv=fail; b=MSgYsyghtCmjBqNX7ie0Wfm11S/btbhaO8JW/4AqFxwzsAwUdv28Fv5HrLYp+BKqaP0MLLnWa+95OsOLRYXc+jkpxdFEbY1amvBoceDBuhAOiBOpEABt5VY2rSfFQxYOVsZosib4oLyoSbl0FUN7R0iPCRwVplUhi5PL4mJ9YC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148333; c=relaxed/simple;
	bh=YpUNVJqgh88HdkYDR8Yy+JCfYwbJCRecbiEs1RL3OtI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tY4WNvoOzV27feXBEFT54IWFDOAssPioUhzQpkMHfi9NEuv5YrbHm30NabTCSGjYjIl/QnnJ+xFeED93yTML307vyddCy5P4hfEN/R6w0sKasg9xJV9re5ddyMbt1VU5uRF/v4alI0jfnLP4edkViLsk8vPZDn/HguQsYEqRctM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ensta-paris.fr; spf=pass smtp.mailfrom=ensta-paris.fr; dkim=pass (1024-bit key) header.d=enstafr.onmicrosoft.com header.i=@enstafr.onmicrosoft.com header.b=l8jsPFYK; arc=fail smtp.client-ip=40.107.160.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ensta-paris.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ensta-paris.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaAnAkBf6MZhc6Lgh58Hp+6srIhEuCdUWj7eOP3x3iwxllzTOcziiHE2gqendAfZXT6AKYht7RnMapavQaKuw5Le6f/6+8iGC0o/GQxr8y/c18xfAr5Ro4D/lLQv2/agqw0OPEhZGX+qWpIVgo2WLOUkpw/eFXLOzErDOrhZ21Wr8kplZC3GlQY7rStyjtKDZwmgwJBmI4ctC8/tsfviV9pEene1tV4m3CkEawcBH5wQJz1F3WDp+XjUBQGX5p2O84zGrK6i9C+C7Sh7yFYfxaC6xYFaCVGOL45IoA38JYPOVauQmvJeNXBcrH1hLAKdHORXvW4k3So21hMYQlzmew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpUNVJqgh88HdkYDR8Yy+JCfYwbJCRecbiEs1RL3OtI=;
 b=fxieXoGcqGNilb/Fh/EiHnv0MbOS6/4O/l6d9zqtN7owNAbHS1gunY+jjpqIj3IM2bayG5l2iV09DZxfLLdZO1mtacYZyQxqIAGLX+b36uC1NBKuFScQ9I48cqxE7iDNW/tGLutcVRDU7qpm2J+HD9x8SqUYUSIrKKoA/LaNYwn3eQnDDK/0C3CaB2ZDPCwybFGIHUuwPGae6lI5KeY7w3bn3kQ5zK2l1gE3rEdq1OR/lndBzn3zP/3j+LQMha5X5YI2aFg+62ujm+wAMqBHymvg3motqc/wHB4GHRj/dMzNrgTUcc4wJrOXwGe6mMMC+hSIGNg1DldwZUZl47AQpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ensta-paris.fr; dmarc=pass action=none
 header.from=ensta-paris.fr; dkim=pass header.d=ensta-paris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=enstafr.onmicrosoft.com; s=selector1-enstafr-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpUNVJqgh88HdkYDR8Yy+JCfYwbJCRecbiEs1RL3OtI=;
 b=l8jsPFYKUhu6mSiiMPR0Wu5Yhe8rrutJOqHz0PSecg1Ajm8R0m00cTRyjZ6Qz4fMrZQR+plZDULfl1SZNn+WIq1x1bkCX5PSvk5tYX3LLO/tgGAGhIOF8CilyqHHWnd3wje/6K8KGShEYXv/ZdTdFHqDOuChj19VP5LDVGI4X5E=
Received: from PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b1::10)
 by PR1P264MB3680.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:187::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 20:18:46 +0000
Received: from PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3259:927:a708:ebb8]) by PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3259:927:a708:ebb8%5]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 20:18:46 +0000
From: =?iso-8859-1?Q?Andr=E9_KALOUGUINE?= <andre.kalouguine@ensta-paris.fr>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Recovering data after kernel panic: bad tree block start
Thread-Topic: Recovering data after kernel panic: bad tree block start
Thread-Index: AQHa6c6sEcIHvQW/9E6ofjZrPNXg0w==
Date: Thu, 8 Aug 2024 20:18:46 +0000
Message-ID:
 <PR1P264MB22322AEB8C4FD991C5C077A3A7B92@PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ensta-paris.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR1P264MB2232:EE_|PR1P264MB3680:EE_
x-ms-office365-filtering-correlation-id: e8d4e1bd-ba12-4e4d-5fe1-08dcb7e74eab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|41320700013|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?7bMaYUgwiFKiY8CsFXKkndGIgkJEbaYXWEhlH9z+rg6Ca2QuWR8gTmog6t?=
 =?iso-8859-1?Q?nGPr6GOdqHxjhRnc7l5179yz8IAqjSykXdahO3nvg0wAmnSkACtidKsvVe?=
 =?iso-8859-1?Q?sOnROfPCYspoJ2wYfLcRLwHsoCTofoXnejtSempJCFoarkmkiCskT6qfvI?=
 =?iso-8859-1?Q?ppCyoY6jqDjsJbBQSmBCFKSLi5FfHHlxnJJfbJ5uYRGwmjsRAj0FdxHYfk?=
 =?iso-8859-1?Q?0qUEAmcb8aht2v6UUQZYyYPckhLsn8cxfM0oI3f6rvcKHNeJiqtG+J9GOY?=
 =?iso-8859-1?Q?7mi4+IkV3ZP+7jsSLllsAERsBmCLzX25oAte4Mx54nCiluwkmPIiimY2hT?=
 =?iso-8859-1?Q?br0pdTbrBO58hnW1t2n22v5jBb5lewzGqBOOri6sqD+l+Q9+f/qPRa0rzt?=
 =?iso-8859-1?Q?U/fbcLCI8FPJXC8J2RzQst4NVzy2E7Z/8j7PP3DTN+tRPtjebfOoYBaD2h?=
 =?iso-8859-1?Q?iq86MzIiIefz0SqNlOlrHUduY32yAw/4I1WRV5TURWuLs0sBZc525coFSZ?=
 =?iso-8859-1?Q?+6W3CoeGPAuR0fVcX01owwY0PulEW80OGRNUbJIkKq0oKhM3v5prnio1ru?=
 =?iso-8859-1?Q?3QuPcj3RSPOIeAQg+5VeW6jxPdyl+lAFSO1XLFyJPTudicPx4QncxC7ouj?=
 =?iso-8859-1?Q?rllM7x1ikPF4svSVCljo9EUx5ZvJ+Rcp4iZR1gMyjs9Q8BzBKGgAxZ1EMO?=
 =?iso-8859-1?Q?weJhe7EnCLcGjpNM/9bC4qtZkaqPLfFhJPjw9frng1qgEvA03v7CA4elHQ?=
 =?iso-8859-1?Q?8cY+fQZVRFWvZC5Z0Cq4lIEUAr0kA7BK8ya9F9UJagsXCfYhXnrV362sxq?=
 =?iso-8859-1?Q?LkmBcinelnu26BNL2ea8S2lLjnRcyhgd26bBL3xIHrxp1OcKioph5B99eO?=
 =?iso-8859-1?Q?NY2GMkUfeLKOIxSIMxmMcOheivyDCga1bspD6y2gOhol1kf4833X4fZ7Bb?=
 =?iso-8859-1?Q?XD2LPdn66jwaLxZoDhu4Urhb4oBR9ygqRIQAVnbwM8OlsxDADIIzNVwbg4?=
 =?iso-8859-1?Q?5D3j6Re18TIS0M6e2mwi5k/MSNsBmkGZzi5N7Xh6Pj6XYCLohUyXGeDFmf?=
 =?iso-8859-1?Q?K4uw3BDz0scVbpAu+1WyTpH2VJCuynsCewFfiTmvEhE7yWOj/Pwmh9ueGG?=
 =?iso-8859-1?Q?oZPAGS0/9AzBCL8QciJ/I4qSxlGY7pFB6YE0TeFTMUXY+xMEA/tJvJo+nI?=
 =?iso-8859-1?Q?0VjEMkGQ7cgf0nYZPju3qnImJGohjr51HcA4XuGDT2NLtqB3SH52z5nwOF?=
 =?iso-8859-1?Q?C5EbXK6twGdqSlW6CXWTmMdYYtnY4C4gaOn/B0y6GufyRTsVru147mQXP3?=
 =?iso-8859-1?Q?WfLAxa39pFXCjM4n/Lp8wOJQIaWgDX/1harLByEuaFgNRvo+bd3q0BgvgH?=
 =?iso-8859-1?Q?WIDzb1mmc5hnXYzQaY3YIqsKd+wG9nzAOMdaXYPCySopcP4WnngRH6bqJ6?=
 =?iso-8859-1?Q?d+C5Mt2YY9r86aOHJjzElHTfqUxVXUj4Zee+VQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?jNryexr/ndO4qTkoTMAW+tNl6zinpAH6PFEzCFP+P2aqZK8SOklgbYeChD?=
 =?iso-8859-1?Q?s52gl/+NBOjbOqjEQAt/TYoQs6Sgep9XTUW0W0IB79hWb0Ga2bS9WjGczS?=
 =?iso-8859-1?Q?x6rpYmDbZ7ZXcHXcBElB2qgdBF5/+N2noDIDHaeh7lHVrHyYO/OA6zYGkj?=
 =?iso-8859-1?Q?zG1SYcxwh3wuoTqJ1zQuXMxJhiq/2vr/umohuBScuTbh+N4AeLy3qeRH68?=
 =?iso-8859-1?Q?h5PufG6kXHYoT5b43NZq1S81r+KP7TGYKhMp42WOzE2+Ny4fdNeq+RITqm?=
 =?iso-8859-1?Q?uYazTVoJgS+eOgFLtMaAcslftTgG9+xk6R5fwa/PLWvb0nJo8AEwRi/luy?=
 =?iso-8859-1?Q?Ca2oPm7qsKhaheysMhfTtNAugFF//lIieXNCcGkbcVJUgEIrnvyPlzkS2W?=
 =?iso-8859-1?Q?p/TX1F8jZBokVut54vqWACzm/XnmW4UQOOKmG9pPT0tw4A69mJQeAbM5cm?=
 =?iso-8859-1?Q?uS/nA0BhJG/aBRFZe4Trnypwpzd2c1T92EzVQq9goukjasG+dcE7sP0Dja?=
 =?iso-8859-1?Q?o4GM1Sk737ffaRbTelCX83HWOe/GQBaHMA31S/4R1llQP82P5xOzSUB69O?=
 =?iso-8859-1?Q?6qRfu3Jr2pRXNKiv2JcZRZCZj8EfhYiL0pU+g9QXZnb/3t+FZg9sZgmXNC?=
 =?iso-8859-1?Q?hly1ycQaClFPeSOoad6jv4dMmcF59BmsZTfg9cFlSWh0ILwnAgJ+Kio7D/?=
 =?iso-8859-1?Q?pLCxKvBL1V0Ez/oI4XXFqujYEyB8M7uzTuxy1X8XKizAEanwEYVlidYpn8?=
 =?iso-8859-1?Q?MQT6zjyO7iCbVwASSqEbIN0ZIC21M+zcfPc7hfFhMA3pfVkcljNyt4L3LS?=
 =?iso-8859-1?Q?o5NAiLMOdeR4+HovcpbazzT8+P4J8If0vtiuogFKxqrg/7dsj85F4ogeUl?=
 =?iso-8859-1?Q?hrqicROT6GaSU+J2hxd3Gx9CIQpZv3tXl/9l57nytn3kaJhwS7L1vcrwyj?=
 =?iso-8859-1?Q?YBKmX8S9yALMwGBWvttoaqOM3y9/9MD4nDwM5yd1GVylxS8YUpRL7qlSgq?=
 =?iso-8859-1?Q?qUg08eb9NGhRYghwBo2HwH7hyDLA/hoGAKrVoXw2oFuTnKpCAvWolLYvJY?=
 =?iso-8859-1?Q?9ckJoxEoDV3etKOfJjqOTiMirvnywyfeVVZU8bn5iL+OCK9k/86p/C1y4x?=
 =?iso-8859-1?Q?Ex9WTAcfWgA4YwQCDd0CtmmVuwPZa8XoS3iqscmwNlXhiqRE1G8YjGG3ca?=
 =?iso-8859-1?Q?mGoEYWACJtskRcHpPx/NjWcrUxMOJ79P4yjHIHtuyOObyzLQa1UmkQVBdO?=
 =?iso-8859-1?Q?m2EaZ0t45kr+3KR13f1mAxRqJJJwgigFY7F/ph/KqEFXFesG1XqLyxlmgr?=
 =?iso-8859-1?Q?Mt4PJj+Li1vBc9bekig9KjGJ/Cft7x/tXTaN6t+Ou+YPbeV3eAs9yxZhHw?=
 =?iso-8859-1?Q?jCZB/DDc702+YnwdykMvd6WGFleirUskJztbx2eputF0Ij1i2xtC7RSiyR?=
 =?iso-8859-1?Q?nFnD3tw0M4cBFPxExMT8h8Sz8ljBcyTPIi+8p5Eotg/Np71borpQ5YY0DH?=
 =?iso-8859-1?Q?TKxVr2YEB50m5NCIM9s/vtyWSYPh8PtkqywDxGLnocq/S9nTmiJToab1tZ?=
 =?iso-8859-1?Q?/EimKCxJ/LHUT8abRbLoyS1q5KJWCP1Ip2H4biIMl4BzAR+qeRWLs1EAfL?=
 =?iso-8859-1?Q?hE0cshtrNd+1xF4S/66hl3LkT2IA5fTsoHeNxMXcC9luymjpmWw83EiYYa?=
 =?iso-8859-1?Q?VOnlW7zq5tg3UW2ngW6tQMixyBnGog8BHCIlN99y7v1V3c13edl7KTTqqV?=
 =?iso-8859-1?Q?Ro5Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ensta-paris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d4e1bd-ba12-4e4d-5fe1-08dcb7e74eab
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 20:18:46.4413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f6c3f3f-c20f-4ade-b8c1-3e0fba16ec71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GN5Ig6nGKGUlEOzcbFIFc77wrfQPCZGmiRD00vgl5jofSoR9M5tvfzMcB0iiHqcCaOlB7QmboobC7qb5kwYO8f+2elXB8AKyn47wJAnD2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3680

Hi,=0A=
I have a system running Arch Linux, kernel 6.10, with the system installed =
on a btrfs partition (with a @home subvolume). I had a kernel panic today a=
nd after hard rebooting, the disk can't be mounted. Under a live USB, mount=
ing gives:=0A=
=0A=
BTRFS error (device nvme1n1p3): bad tree block start, mirror 1 want 2116580=
31104 have 0=0A=
BTRFS error (device nvme1n1p3): bad tree block start, mirror 2=A0want 21165=
8031104 have 0=0A=
BTRFS error (device nvme1n1p3): open_ctree failed=0A=
=0A=
I am planning on doing a dd copy of the partition once I find a big enough =
disk, so I'll be able to try risky commands if necessary.=0A=
In the meantime, is there anything I can try? I only need to recover a fold=
er with some text files.=0A=
=0A=
A small request: please don't rub salt on a wound! I'm well aware of how mo=
ronic =A0it is working on code without making backups, pushing commits upst=
ream etc... Especially on an unfamiliar file system. Catastrophic mistakes =
happen and I would really appreciate people trusting that I learned the les=
son and being kind enough to avoid comments about the need for backups.=0A=
=0A=
Lastly, I do apologise if at any point I seem ungrateful or anything. I gre=
atly appreciate any help even if doesn't lead anywhere. I'm just having a r=
eally really bad day, losing nearly 2 months worth of work because I forgot=
 to back up.=0A=
A PhD already doesn't last nearly long enough to do all that needs to be do=
ne and wasting more than a month of work (though I could now write it faste=
r) is really disheartening.=0A=
=0A=
Thanks in advance for any piece of advice.=0A=
Best regards,=0A=
=0A=
Andre=0A=


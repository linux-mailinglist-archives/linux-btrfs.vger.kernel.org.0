Return-Path: <linux-btrfs+bounces-9391-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F9B9C1916
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 10:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA63283CCE
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 09:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E536E1E1022;
	Fri,  8 Nov 2024 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sturdycscom.onmicrosoft.com header.i=@sturdycscom.onmicrosoft.com header.b="RM5ZlgNf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2123.outbound.protection.outlook.com [40.107.247.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4224369A
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Nov 2024 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057992; cv=fail; b=i8SR1Y9gKpJg3loVbJAA+HwD+kpxJ97WZDkWYoltla7dOB/Z9ishWPL5DeHmhjZwDLsrKU1uJsdjfZ8YHGOcCtY5EPuih5kW+b3JxHh+T/N+igVbknSvpRMMszuNdlE9ad87+efFzIaemOYp/jTHt7LEJoXHUBEUdsmg1OVuOi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057992; c=relaxed/simple;
	bh=EGV/dTSVUDf9m+9gCcDYr+NgywRGZkmKsnigemY6N4M=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Hxze/lJm2PBx6ezKb33VgAQA/XkpI6v1IVu7ErIFT0YgeUyh+xJXfgnbGmbbqZiKLoTVhXOExiPy56qe2HyhPysK3To0cWOcS1l37X0dPj+8BZmB4kTwwytZtQ3Mker8unOgK6ABSHN/aaOPCLqm5Y8EnhflsbCLL5VyAmSkIZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sturdycs.com; spf=pass smtp.mailfrom=sturdycs.com; dkim=pass (1024-bit key) header.d=sturdycscom.onmicrosoft.com header.i=@sturdycscom.onmicrosoft.com header.b=RM5ZlgNf; arc=fail smtp.client-ip=40.107.247.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sturdycs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sturdycs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOSuSvj7aL+g6r5A251uSCnha7hXkSre8CcJwtxKIFkdCzl1kvQeTO85OOP7iW5O9bk+9qrjF4U7s5VfwbrOfqE4WzPMSfCoTma7TlN6DJ8p/p2PCXLrYfD7l/DD7vcIw6yMjhLH3nm3DPz5VX2upoddvTkJ6ImeWXODC7CYNRyPDuAQPGSoQPEsugvtZnnoPgmtIIixj3DDkHo6k9P57LFhBhE5QYESEa4OssaWL4w41mBqPgRLB59zSx3wuyDu9xl18wMZ8PvDfseFw8CyPSZ0TlWXLs97Bx5ccB8mTrbHHfEnSq3VY/g/npRgGm1DVfGkEAmp3tbUmykNoJDM+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGV/dTSVUDf9m+9gCcDYr+NgywRGZkmKsnigemY6N4M=;
 b=FSXtFab5+BXwhktUV/s1JmdXHpug5cd7tPC1kjIBNknaEo4j5uIFCOg4Bwan96BdnI0GYGl0rYlgGIvGEU5aFa63lUHMUJlAAjs3ReglkdUQP++ryhJ37mnANJCOkjp3a/XDasaJCexee8cdppEQz6eOaLI+XukMDu43m4MJOrVDg/cenlrfIcJ9jRkp4Gy7KFzCe0GQwHq4Tq+a6hGxABka19JslqfODs7WUx4DVGJ0c58Z7BP0SI41Q4XgpqEQZf6cv4BxH5EbdavUvYhb3O9HJ2WmflI56S2YyOA+m0iZwFDhk/XP7UaIpsCZfY9lHrAGUFXqKp/lX29OH9kkKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sturdycs.com; dmarc=pass action=none header.from=sturdycs.com;
 dkim=pass header.d=sturdycs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sturdycscom.onmicrosoft.com; s=selector1-sturdycscom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGV/dTSVUDf9m+9gCcDYr+NgywRGZkmKsnigemY6N4M=;
 b=RM5ZlgNfPeYHBWKKXE9EELXgso+h1+AVIMPFccGqDO1almJnH6vD1VlCoMZg+wnKiyS9HwthROC5LQz/cArAArThQ60fzgaxcoV0Ig2JNEM81P5NNq9IIdygsvNXGEtuIdBRoKyKMJdPvePgGdQjm+lYGu4DCY9Qmrthrv+rsc8=
Received: from PAVPR03MB9240.eurprd03.prod.outlook.com (2603:10a6:102:32d::21)
 by AS8PR03MB6904.eurprd03.prod.outlook.com (2603:10a6:20b:29c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 09:26:26 +0000
Received: from PAVPR03MB9240.eurprd03.prod.outlook.com
 ([fe80::d9c9:663a:e48:63be]) by PAVPR03MB9240.eurprd03.prod.outlook.com
 ([fe80::d9c9:663a:e48:63be%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 09:26:26 +0000
From: =?iso-8859-1?Q?Carlos_Garc=EDa_Recio?= <cgarcia@sturdycs.com>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Mount with nologreplay and add device 
Thread-Topic: Mount with nologreplay and add device 
Thread-Index: AQHbMb3io7QDM9LawkeU0WzV+KCV/g==
Date: Fri, 8 Nov 2024 09:26:26 +0000
Message-ID:
 <PAVPR03MB9240CDE88B1DB3A8CC7EFB98C45D2@PAVPR03MB9240.eurprd03.prod.outlook.com>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sturdycs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB9240:EE_|AS8PR03MB6904:EE_
x-ms-office365-filtering-correlation-id: 3254b2e3-c523-4226-87d9-08dcffd76b56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?0yIK1+VDD/TPdXgtIy2+9kXa1vEV3Veue2PShVpFJiX4KGIcdkivD5mjV8?=
 =?iso-8859-1?Q?4qdjNT3Ue8yWjfpG7lr21EnSzjfvkwYLKiMqTKjmsSb3FyMVUXOLhpx++R?=
 =?iso-8859-1?Q?o0eIz9vDSZUtELgL2cK4+kTYC/74JtnLKH4mRCoRsrXMUvF7uTO9tSqtcC?=
 =?iso-8859-1?Q?79LVNXuzSon0azR77CQUwnlR/Nk4Lu9RR3Tsi6bX0zsZHvoB4GlhRTBJFG?=
 =?iso-8859-1?Q?jGGKUVBZH33ybUZqipyAaRskCbfoe0aljYbmRJu3gMLH/Rhi+qgP4Gz2+g?=
 =?iso-8859-1?Q?RkEzepM+sdph1lNVuK7kwA0+VauaPTW+Ydv/4NOtaS68xlBit8THYfImYn?=
 =?iso-8859-1?Q?ZJaEvWh+j5pMiW0Z4mYH2li8fHYvANI31cfzs32GrY1/yAFIt6vCCF4JaW?=
 =?iso-8859-1?Q?btYFMFhNmo5dYcPMmoC+sQRZgMfOLFw/cyl35h96icmi21u8D3j5PayVdm?=
 =?iso-8859-1?Q?j/0+mV3d1MWIGdBWDTalFpYodjruxOErF6cSbW+AppP39FmBlIp2yEXDDk?=
 =?iso-8859-1?Q?nIFgL8/J48a0PZrUj+br/Eo9IkxPye3VHQIvWK0HXiHT35YiglsTjoUXY3?=
 =?iso-8859-1?Q?vIe5pzVq+I5MogaAThzrJdtvI3k/lqNrkrb96PHDkOLqYOdSvDQTZtGl5B?=
 =?iso-8859-1?Q?6JHR58ngfBVtvVCOqJZ6ZtaFy66V2bdSJkC1zY0pRGiMDlb99myW9N+dcQ?=
 =?iso-8859-1?Q?HnELBd65z1FLQ08j3YF5iWmyWiwv+ENUfGhLiexqISeC/R9Lygh3MKeUhD?=
 =?iso-8859-1?Q?lkIfqrALSrq508sPjMdyy1BocwZEqdfcz8sctPMDCq24DelRFTtRv9nSTt?=
 =?iso-8859-1?Q?irVsMIZfQ/IRjfKY854wcObvA3Dk/916rsC2N+9tOlUSpzCpFsvNuPC7Gb?=
 =?iso-8859-1?Q?ZMg6aOa8xgxbLdSVD1I7MORDK9EA4H7Xzm3PyTlwDqe3zx0qFZ1z0LKkAZ?=
 =?iso-8859-1?Q?24vtv+yDvsvRSUNqITVN8ejexhPVwFgrbkBeRzVRK3zm6OsmjAwjsbBhfH?=
 =?iso-8859-1?Q?SG/anYCZEWC92BNR/mLiBGjazVol+MRDgNbUyWjIyxKJqAHGV6stOnGwFO?=
 =?iso-8859-1?Q?JZFUsb+M+6wGobiF9i9p3xez066q7TiXqbsdVVXR7DNxmKGd2P0EwHo8OX?=
 =?iso-8859-1?Q?d43/HZ6IMmV8ymsS2KRjKpG7JOvvWM10dTsAzWDijCwUVN6KsB8wXZa5GX?=
 =?iso-8859-1?Q?ObRhtPrhP/f1EqSqKFiac9Z/o3BqcnKQRsyPZ2jkaye8679siMnYSvQDPi?=
 =?iso-8859-1?Q?OL0atSLn7Tc5hb5FLao0OJjGphYSQ/fPUcRMm28uTUrGprA2tbiX+WCP7K?=
 =?iso-8859-1?Q?MhvM69sV/xp7EmonMuzHA+sqamvzz+eHuJ9DgtHiaqMh0MumYo9ci9e0KO?=
 =?iso-8859-1?Q?VCzZOONjyJDh6/jPilXNqb4AS56q8in+wwn0SU/OrvGqoW7vBHLjY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB9240.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6eRmmzylhkEo10y/PllAorBlyEjUlPmaNqIxPnH0M68iiPNA8rRS3IhA7g?=
 =?iso-8859-1?Q?TKJ1DM80fwRTec0Uj2GBDYjuQ+k3zjZ9bZWrZ2O8Zg466K9g0KPomRHcgh?=
 =?iso-8859-1?Q?Lz2B23tOp9Qh7cnTquaqh8ruxZe0s+AjXHYmXoFFUlRLHSnZCh0eCg/a5A?=
 =?iso-8859-1?Q?sTWqsFGKOEG8m/129YGRQh4KAHRPYrSq2oXQmdCiYYaWM53gyA14Xo63fW?=
 =?iso-8859-1?Q?utyTatAYo9A9GuesDqCxSt6rvZs0ajLbZwNKdBaMCQeFmzBVLjrnmn66bU?=
 =?iso-8859-1?Q?d3LREEJmImyQnyUFQGQ4fwSFA3BCcX/mHHv+fShPNKw2q1qII3YX3g/lp9?=
 =?iso-8859-1?Q?n/SkHfw7TWftU7cTg/HKPmUz1THgl6YqbvPliBf9/lZdvXTT8IB5JM08Fr?=
 =?iso-8859-1?Q?l2C3aHrTgv7aT0REi/cX/bOP4QB4U9qkDfiV6UGQ8pZoF8U9zSf9EpUqrM?=
 =?iso-8859-1?Q?mHowpLx2uOp1L3/1qcdNDJYbfVtGfHz6oYmyuFedJwZKEn1pNehI3gie86?=
 =?iso-8859-1?Q?+/+v3sya7H0yrgFQXDwo+5hQ+QvlK4pzHIOwv2FboK3WJqIiIZwAxFnGca?=
 =?iso-8859-1?Q?ccvS8c996oG8+8zKynszJYQUfOtaO1IS6eBZp2EQmL528m/gi4VqYtzg7A?=
 =?iso-8859-1?Q?ffuZEMPsLvNTCXcjX0IujZdjJ4brWJybh80QG7XRW/xtdjSC1MnCUI9A0y?=
 =?iso-8859-1?Q?1K/x+doT66z56kB/PgyqhTLx261T9sY1e4MrLSTe5Na25ej7L7mB2WnWRv?=
 =?iso-8859-1?Q?QvO5E96X3k8yBU9rQL9PMqFI+oTlBeaZj7PYeKk/B4JBoTx/XxMuL3FnH/?=
 =?iso-8859-1?Q?XrLd/qBa2sMB14vHK2iIXrAJ2Jhp5vNgro9a7NfayM6ZQAGuSj2V+3vb8Z?=
 =?iso-8859-1?Q?hgcCtHakEv0Z40MMVlah49f4heXEJ57gcdZcEGq6BYeEV0SwXMMDWaswsX?=
 =?iso-8859-1?Q?en9P9Ptm/5R/Dr+gmsmxui8jj+/0HfSUGqtvXsvzJvGXzciss+Ml8QwelO?=
 =?iso-8859-1?Q?zFEvszoJKyE/SVRnEpWG8IsMgQxCYm6shnbVG7uyYbQuhjNf0CZ7VA7+Dr?=
 =?iso-8859-1?Q?tyJC3ON3Rg9ZrNHydqjRtX+tcJJbQUZ7Hib7E2AkR+9NYq/Erfih7ggmWm?=
 =?iso-8859-1?Q?1vshYSl536Y67NR6wi7f54LX1jTpFbROzzWvJvH6CmP/zV4vff/FbS1t4K?=
 =?iso-8859-1?Q?EDmoWoJQ/wqpincv/2MU18/FLp1CFQeoMKgiVKflwjFthd6gU5cp43e9D4?=
 =?iso-8859-1?Q?p7tHeS4nQhxmT96/ffH+fgfW8x8Ced7szjl9GZhEOSOBxWJdDqFwfk1s5+?=
 =?iso-8859-1?Q?0hS/m/4bjrcJXa8ks9kWSi22pZSWNiFWN3w4qWDp3vKXdFgdC2spMnYp0e?=
 =?iso-8859-1?Q?qEqW2LUhXISZtniYN10diLhYhssAQtAWyA6VLLpDsDHxiBhrBA+Llk4TGv?=
 =?iso-8859-1?Q?cEEs07Cx/j9iF7zPGmDHlsCKh4Rn3CbgURO8cLTQpG3fe2lS+6gNVJNslG?=
 =?iso-8859-1?Q?oTJe3hdYXHsf6CHTheVtBos4MMR36Tjn9dwwozQ/6uY8yE+o+qIDUCD0Rb?=
 =?iso-8859-1?Q?PR2a/nqpN3OhzelJmdqWfzsa8b67QAHqeaQSs0Ta3ZjoffAuoimTu8+3mH?=
 =?iso-8859-1?Q?T2QaS7sKbAWZna4jhMS+h9Qd25e97B/OwL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sturdycs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB9240.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3254b2e3-c523-4226-87d9-08dcffd76b56
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 09:26:26.3552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1330dc93-0167-4075-9a99-65af430c0ba3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oy0ZlHO3C1Xata6vjzXbcK0JTwtSsPB9AHc9o1n2pSFREyoAhbj/vDp9+Fsd28F6wO9AcYIDLwEQ8EzguAHFGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6904

Hello, folks.=0A=
=0A=
I'm unable mounting btrfs filesystem:=0A=
# mount -o clear_cache UUID=3Dc632109a-52d8-475e-a537-d4d979c95393 /var/lib=
/docker=0A=
=0A=
kernel: BTRFS info (device nvme5n1): disk space caching is enabled=0A=
kernel: BTRFS info (device nvme5n1): has skinny extents=0A=
kernel: BTRFS info (device nvme5n1): detected SSD devices, enabling SSD mod=
e=0A=
kernel: ------------[ cut here ]------------=0A=
kernel: WARNING: CPU: 15 PID: 9317 at fs/btrfs/extent-tree.c:6973 __btrfs_f=
ree_extent.isra.71+0x855/0xdb0 [btrfs]=0A=
kernel: BTRFS: Transaction aborted (error -28)=0A=
.=0A=
.=0A=
.=0A=
kernel: BTRFS: error (device nvme5n1) in __btrfs_free_extent:6973: errno=3D=
-28 No space left=0A=
kernel: BTRFS: error (device nvme5n1) in btrfs_run_delayed_refs:2971: errno=
=3D-28 No space left=0A=
kernel: BTRFS error (device nvme5n1): Error removing orphan entry, stopping=
 orphan cleanup=0A=
kernel: BTRFS error (device nvme5n1): could not do orphan cleanup -22=0A=
kernel: BTRFS error (device nvme5n1): commit super ret -30=0A=
kernel: BTRFS: error (device nvme5n1) in btrfs_run_delayed_refs:2971: errno=
=3D-28 No space left=0A=
kernel: pending csums is 3162112=0A=
kernel: BTRFS error (device nvme5n1): cleaner transaction attach returned -=
30=0A=
=0A=
Don't want to try btrfs rescure zero-log. Filesystem have nine DB instances=
 and this could break them. There are lots of free data segments but metada=
ta is full.=0A=
=0A=
I would like to try mount it with nologreplay:=0A=
# mount -o nologreplay UUID=3Dc632109a-52d8-475e-a537-d4d979c95393 /var/lib=
/docker=0A=
=0A=
And then, extend it with other filesystem looped sparse 64GB files (4 of th=
em because is a RAID10 profile):=0A=
=0A=
# btrfs device add /dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3 /var/lib/doc=
ker=0A=
=0A=
The questions are:=0A=
Is that posible?=0A=
Is that safe?=0A=
=0A=
Thanks in advance=0A=
Carlos=0A=


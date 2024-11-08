Return-Path: <linux-btrfs+bounces-9392-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ABB9C19C3
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 11:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258F3288608
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 10:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D941E0DDC;
	Fri,  8 Nov 2024 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sturdycscom.onmicrosoft.com header.i=@sturdycscom.onmicrosoft.com header.b="O93vESHU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021097.outbound.protection.outlook.com [52.101.70.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EF71D0BA6
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Nov 2024 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060276; cv=fail; b=rXGzzGiY8D23navXYRdAS8vcgEq/3G2eOpgedZfIS9hexzvzR2Wfxp/bAblu+j1QF5MKy1WmYf+xehpc6JJHhMtQROx+H5Hw3QRotF3gJWnMfPj52SXQ5tvrLLbLsAMlObDTCLikEVxMf9+N8EZkew/KtDg9wsElX3n2/97QPkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060276; c=relaxed/simple;
	bh=1DqkaYlsAXk9mFMG6GOG3RJt1weUN2NdTcTuElzD5gs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lq/f0Ws7FJ5u9Aydya3fm1h9eBI22ejUSMoQaDx5QHiIz7zkxaK6JblLRR1/1gfPr4OLfZNW2vvbs+p9Qx9FJk/POXhS0ilfGyKpZhMHCGYeJ2Hkk0T65mqXe3pB8n5D7pUYYL7f3HDKykFU0EEXs8BsXBJ+3uk/wJWU58VJKpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sturdycs.com; spf=pass smtp.mailfrom=sturdycs.com; dkim=pass (1024-bit key) header.d=sturdycscom.onmicrosoft.com header.i=@sturdycscom.onmicrosoft.com header.b=O93vESHU; arc=fail smtp.client-ip=52.101.70.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sturdycs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sturdycs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpN1zK00DrjZK3GGy57maY3fzYg0tTNXgllPBCTDT/dgUoJwEGpWRWuTJkERg247NAJoy7G6tQZ6Hi8lB1GthUbVuBqULq78zdWI3CbPDfzhnCcNfKu0K6w/3AAhVU3RJkrHekXDAvpBxHaxbqwSVAVEREauzPJJtg0jH5to2gzUQZ5EN4TFUJffsJncrQ74K7MKMcmMDpfJha0DOPajRdj/38xsLZMwyCwsjWX/tnrouprViDLH2iQteN/RZlt9AuTu0m8ZAYeOfsNWZVAiu0BgA6GB1exoufPlAIPQaRCrF+FrJXzhGggsgR5txNSS6V7AJr1CIQwOXh8756YRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DqkaYlsAXk9mFMG6GOG3RJt1weUN2NdTcTuElzD5gs=;
 b=QH4YJ2B5jkkmXqc764xd4RF3M2Q/Bx2jlO0lwApRxOSOhg+185gWsgddfwDgvzNz7RGrasIiVPctmmRMBLmiMyvUJVDLyCwhdqAAAKULGvQeqz7bqaUkIVBxyMIcEz1AL/sMw9tImTLmLXzWarTPJADDrTBbWzAU89vlv34n1v9wBwLDlxbdysfiCBeoaiOCIbBVYW9pday34+m5I6bQJlLbBli86rgC4O1xhXPzvpcJdvwpO2/xBcO03dh0dMY8EywmvVT5AexusF35tjm5ID8Ogvf8hJ6LwXykGmionIuV7z/BTBsgYQzImW/rNW0T6aGY46ZLpzGRg0yPesuesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sturdycs.com; dmarc=pass action=none header.from=sturdycs.com;
 dkim=pass header.d=sturdycs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sturdycscom.onmicrosoft.com; s=selector1-sturdycscom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DqkaYlsAXk9mFMG6GOG3RJt1weUN2NdTcTuElzD5gs=;
 b=O93vESHU+We7od2UM6aeDXG568y54Z9MP7O39cOwQpqDZG23Y2GTGr+xT0CpfdpI/xcmjhUAb4tBZcX6iUBxTatEtLDPIidjBjjIKJUZG5l3dTjhGmffSH+3Y4yToWvqP9nSqSQNU/dUu4ehuO4/JRiUZd+C4tJ+KvttlL41yxo=
Received: from PAVPR03MB9240.eurprd03.prod.outlook.com (2603:10a6:102:32d::21)
 by DU0PR03MB9803.eurprd03.prod.outlook.com (2603:10a6:10:449::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 10:04:23 +0000
Received: from PAVPR03MB9240.eurprd03.prod.outlook.com
 ([fe80::d9c9:663a:e48:63be]) by PAVPR03MB9240.eurprd03.prod.outlook.com
 ([fe80::d9c9:663a:e48:63be%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 10:04:23 +0000
From: =?iso-8859-1?Q?Carlos_Garc=EDa_Recio?= <cgarcia@sturdycs.com>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: Mount with nologreplay and add device 
Thread-Topic: Mount with nologreplay and add device 
Thread-Index: AQHbMb3io7QDM9LawkeU0WzV+KCV/rKtJyex
Date: Fri, 8 Nov 2024 10:04:23 +0000
Message-ID:
 <PAVPR03MB9240BD93CD6C7D99A8554B2EC45D2@PAVPR03MB9240.eurprd03.prod.outlook.com>
References:
 <PAVPR03MB9240CDE88B1DB3A8CC7EFB98C45D2@PAVPR03MB9240.eurprd03.prod.outlook.com>
In-Reply-To:
 <PAVPR03MB9240CDE88B1DB3A8CC7EFB98C45D2@PAVPR03MB9240.eurprd03.prod.outlook.com>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sturdycs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB9240:EE_|DU0PR03MB9803:EE_
x-ms-office365-filtering-correlation-id: c558f4c7-e4f2-42ec-4a19-08dcffdcb88e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?gXBeJiSLee4mHP08Jg8U/WCQ8GJrLvb3GODAws/9y/moU0PX8HYtbgwMk+?=
 =?iso-8859-1?Q?WGacfRzu5F8HyicxtpGcBNJgSAsj2wPZI1FrxVb0KItuM1hWpLI+XhkSyl?=
 =?iso-8859-1?Q?OarfCQ7nFP/06YgaGs8897edUjlalURkBcuAt/9JUw3k1YPzoaMr57mifW?=
 =?iso-8859-1?Q?abNoNklHSGCHccipw3yz0t1TBskMdMhAtgyHjzx2w070gaNn5iQY3Wr8bN?=
 =?iso-8859-1?Q?B60NbDdad1tYYDq25rWKuIDsMmW3DkYNa5/A6nox8HzTOZbTCvrnqha8fa?=
 =?iso-8859-1?Q?WkFyK0Py5cdYnPRXH7/ZmAs34bAODvap8HgENWHSe5iIvL2rWX8oxKFOus?=
 =?iso-8859-1?Q?Ckl1k335psmw6QDLEkcIH5WoEFvyUl2KQf1ukGs/fEKgZubyIzueCRZide?=
 =?iso-8859-1?Q?PDUxVWuK8kgKnzkhch8dgFe141+BiO0gBuKeupCQU7cSJcprZVh04laB2G?=
 =?iso-8859-1?Q?TkcWmsnRF3hpeuZOqzJhMnybeLaaX/FrONS7Z5xZztgABCjI5aohxdmfKl?=
 =?iso-8859-1?Q?iRs7O/csZuacwpWmxSxC9IKMBb+EgElsIVtOU8nDbNg1ecJis/9wWxDeAp?=
 =?iso-8859-1?Q?k37Y2g7XHtfm4kOl5OZEcItLwFBY8jOYEd8VfdX5Mpp4Xitibs8yyhrYE/?=
 =?iso-8859-1?Q?8U1qAOOuoRV3ZkyfIYWNpMPIhswvgs8EsnzLMAngXF/MUXI7TWtQOlYLzA?=
 =?iso-8859-1?Q?8Pg0VuqGFzgoZSORVzy/Xnp3vnPiD10J8uYPcyEXU+6UQ6TKi7eR+42iNM?=
 =?iso-8859-1?Q?oyvKvmnKBjbX0m819w6MFQzGrO661XehrUonw3lp6URVYrcVqGXLY3cIJ+?=
 =?iso-8859-1?Q?abfWcwH7TyROhgd0KRN1d2RutxjXn9DT2UCt/TW/4E01QmQ7wGKVnXP7m0?=
 =?iso-8859-1?Q?nUvmJ9sRKgURcmFV0+0U/yWOBeeriq1nwrWMYaxBwf7LN07HaWoiGdn5JP?=
 =?iso-8859-1?Q?ZmYqewlSdCIpAkwfZBZBXHQW9m0owNsUdGgDdhg6CHjJG/HiXqI6CfGVzE?=
 =?iso-8859-1?Q?jluDAui3qALzKyr0Nmia6gBx79dG/25mpOXJCHeXh833U6IlCEjLUw3gdP?=
 =?iso-8859-1?Q?NI6J3jYlguzDk7ako2Fea7jkRLq0c3sMKAq1WXUf8DhZZIhCpGCJVSLQac?=
 =?iso-8859-1?Q?jRDp32zWSJrQ5DYs9ePew3IXDj7IrSDMbiRKrRSBxbIB3/46bTiF6aKmsL?=
 =?iso-8859-1?Q?SFbKFE0s7aqdktbp9tx+IaZNJIyDI3IFnB/sGtu7XLc5li86P+bPaR8j8e?=
 =?iso-8859-1?Q?/t9KmD0EKaiTJAj/FBZgrBzNB9jb9eaGj0D1D15nhgnmTs8E5ckx8LEfQ0?=
 =?iso-8859-1?Q?/UnVXaDni1tnUfbPIVmC3WlUvojfiyQlafsYzqF2z5JMpfTXU5hltWtcxw?=
 =?iso-8859-1?Q?lusssttxgZh5WmVDaajN/Gq9gRfZ+qCmfzoeAoDzcPjmCEufN3rPs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB9240.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?HpQw8L6SBUufwKhDgPvz03GZqE+cfSr0D+y4uipzx7bc5qnknwvYZq7LPA?=
 =?iso-8859-1?Q?tr9B7qDFmrSZ+5MYXc7pP7zOf+pNcODXjY4+YcE5pqwIJ6lIheiWYbwCqF?=
 =?iso-8859-1?Q?DT9Pv8UH8kZ7BSkdE6NkVFaIVEa9Dstzmpt7hxMaH0vjStAeB+IB4sUmcQ?=
 =?iso-8859-1?Q?mCuufaHbMXTkel5sQMHdtW2svj6iqVEoxxDpH+jzKbu+YDJTE2Sl/omIly?=
 =?iso-8859-1?Q?EwBi6uFlInwxbWxVnyrCOBj3GBWmfDpzw8ulNDT/MTi0DJg9zbjWTFQIGE?=
 =?iso-8859-1?Q?42qGWZVA1YqbhWmX/3GwP07hrRZylQ57RJqMCCuTXWh9KskFbXiqTNcfC1?=
 =?iso-8859-1?Q?tIG5tPruPLx2gQ67L/uTZCEeoBTlIBw6KZOk25hSOp10ig44qbTiKEzo/v?=
 =?iso-8859-1?Q?TGbK/FxMav4sE7W8XV219Kq+Dj8R8sL/P/HjWrwH2Y1h4OoP2nmtzqq9h0?=
 =?iso-8859-1?Q?t+WovC/fFLcZstw6mBaNawMzoZNENSdtz+s8g7g2vD5XQfrepTCeU6GBCx?=
 =?iso-8859-1?Q?jgQWKrq48EF2vAdSfNOtfpYFnjZEKAm5hMu0fG9rhECdARaakoAAD0llnz?=
 =?iso-8859-1?Q?6YN0b8ExBntu1uUV877+12j2NB7WmoHw0VUEvvvwibWsG4X67UrI0aeW9j?=
 =?iso-8859-1?Q?JV7CCoAig+HpJreqek0sx+vkZhB0NQGeP/+dlELuSpAjHAdEIGxjkeqUyg?=
 =?iso-8859-1?Q?uvXx/O8DEi7MLxdnGYflhJaW8K3KgfL4Y3Ndi93rMoDuGgEfgFoIbDy15v?=
 =?iso-8859-1?Q?amALFmy1OhnF+D8+nfuGbDnx0bP10k5eD8UedvNZ05BxgLS7e8qQjvD2En?=
 =?iso-8859-1?Q?1W2A1L3Cv6jhaEWMoClCBtrQ9IywdRYlb+b+dMxcILnzjp3SmvL6HI00pX?=
 =?iso-8859-1?Q?C9l11jAmrM2oM54uYHxUnveqXkqJKPJU0wkZ8K22LMwHwTRfRnsYjia+TV?=
 =?iso-8859-1?Q?jL17CFbTcUbbe8OrLN4+9UTZXU50irQkAYn9a2cwjEUr84j4f5i2LQsspw?=
 =?iso-8859-1?Q?SaL4LOQd+0mmjEednGd0JlTSA7hoJYCNL1z9yAZth/yeNkDoC1f2G7C5lu?=
 =?iso-8859-1?Q?x5TZ4rS/dXwPQDfMKSW4HJXwLnt+HO3R2iia+ZDrhLomKd4vM5vXGDRZxJ?=
 =?iso-8859-1?Q?xfqm4Vvs/sGY2odOoeC2qti4f1rvCw3dxMiNc/6kAtGQqC6Bix/ffvWfwc?=
 =?iso-8859-1?Q?XjKNBLwSir0Ijnpwfkj0UeEn5KadtV6se1NI8FlDuc8ipMPZO5vvEcEMm1?=
 =?iso-8859-1?Q?EYz62KdamAOuovNfrtn5WCJTaLW/HhdlSigzIRkMkYPY1E0KbGRE+m6HJ+?=
 =?iso-8859-1?Q?KJCUJ4pjGUqzAwIUA4JijLFlVtKQdwYctDK4fFUztrMWEDTar1uEPnhoMO?=
 =?iso-8859-1?Q?OfInVKnu8dLRiszXFhLSfJYsEX8d9BJxjEXB5PRRFfzr77xljy6LazOF9m?=
 =?iso-8859-1?Q?98wC6gr9ffBBykgk2KFp3UrLt2nW8DR0gtnFbYt4zmNt/upI8iQnzKeIax?=
 =?iso-8859-1?Q?WG9xLjoI7tgoZuXeIsXYlktserlh/o8CBCxh4Nx8Ih+itanSdJsgp2Pu7L?=
 =?iso-8859-1?Q?PGA2Kp2+67NZ+RiIZr1BVJcxyEtoUMFxlElOCdf6CBjKt6hIpe3k1JKQD5?=
 =?iso-8859-1?Q?XgzEWA1MEQG0FkOVr6qoDxkgMyX6mfaDWJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c558f4c7-e4f2-42ec-4a19-08dcffdcb88e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 10:04:23.3592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1330dc93-0167-4075-9a99-65af430c0ba3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yey/12Q+Wl7tbLaRQ/+RHOlFE8Z1Xz2ZS+uGpG17Pd4+AG77e9W5jXwXvW65bppexj2pVdgJcZRaUL9iWK3Q5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9803

I reply to myself:=0A=
kernel: BTRFS error (device nvme2n1): nologreplay must be used with ro moun=
t option=0A=
kernel: BTRFS: open_ctree failed=0A=
=0A=
Then, btrfs rescure zero-log is the only option?=0A=
=0A=
Thanks,=0A=
Carlos=0A=
=0A=
________________________________________=0A=
De:=A0Carlos Garc=EDa Recio <cgarcia@sturdycs.com>=0A=
Enviado:=A0viernes, 8 de noviembre de 2024 10:26=0A=
Para:=A0linux-btrfs@vger.kernel.org <linux-btrfs@vger.kernel.org>=0A=
Asunto:=A0Mount with nologreplay and add device=0A=
=A0=0A=
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


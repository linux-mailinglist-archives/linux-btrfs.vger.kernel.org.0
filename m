Return-Path: <linux-btrfs+bounces-16353-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57986B35003
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 02:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52221B253C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 00:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1932D78F39;
	Tue, 26 Aug 2025 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V+6XZan4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jfBRmwUd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E46D54739;
	Tue, 26 Aug 2025 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167115; cv=fail; b=RCAUcQlN04n9A95gM/vZT90KmsJw/+YJkrQ7C8cxG1tuCGDkN54JDGOEFHmIgL7E1IuGnGYYKKaaQdjiajfGVVkeVBzvgyVygtkqV98W83pB5N5FRjOUapgnq+H09yShNbScYFUEiqgriP+CNepJShQ9hDipdu5uIdrcqwaw7+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167115; c=relaxed/simple;
	bh=MhD0fEYkcSrJGein/6xO3kHRIOI3ZPYqwM/+n7lbSpQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HbzaclMoLLaiGAWcdwc/V4F3BHZKsTlEPh0JLKWATGQH+0dkTrTw/FVwisPS4HE+wqjCJf1B3n/so01WYK/BVguw15D3h3zWJ4d9Zr8zJY6OG+oGdKTOGVG38d1iaVuApo8shK5wsIWfTMLqta+do8PwagPrPj6apEZr1vNk0lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=V+6XZan4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jfBRmwUd; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756167113; x=1787703113;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MhD0fEYkcSrJGein/6xO3kHRIOI3ZPYqwM/+n7lbSpQ=;
  b=V+6XZan4myT12nbdWhWH7/+pDbo4FjZXkvXFC4L0f97BzgSHYOkLdURX
   E5goE0ji1vXBkztOEYPcecDPPQFjgayXu2gieRlzWkp6vPfUNI3W6qH4o
   s9zz0AXwhOiGtYsx89MVv9y5v8wnGiZvM6v7eZ8laEqpGDgJKMaSDsunV
   haWBwCJDcdDVwgVCjHnsBSP+ApBqMi+XP8KupBG6w+Cc///VJliK8MZcJ
   fHclBop9XKy2wfEopsT4MBUuB/ysQH1SsY7Llpuv1NGN2ESqzOqnip77j
   HZrSFxUQdlXC9h62gFlxGg3pMyIlV1E+0HIz242arY+ws/+sZbrGUv+Hp
   Q==;
X-CSE-ConnectionGUID: cHzu1vDKSyuf3XxBMIryTA==
X-CSE-MsgGUID: 3xWMqp05S7+HuiC9wrxFNw==
X-IronPort-AV: E=Sophos;i="6.18,214,1751212800"; 
   d="scan'208";a="105332558"
Received: from mail-westus3azon11011032.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.32])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2025 08:11:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rF6o9QUVDW9s29SVQMeW2zgDG9xIc4X0hW4oR/twnxLz3UYbWdPo70orJVj0lXjkW0AyIfs3mr1L/3qODjvDpaLKKQeNXVI1v0sACtXJY5jxw7guUUVBvhINjCE8ODhyxfDPV8ApXZw/FvuE/8KkmxEucQLu02M/4XI8Gbph9C7rRyv7pnVtd9ayIQ0xReD3xzmcg2Dm/MNPneS7U9frAOhFU0r6Uah/ah6LBFdYCn+D5WYQLqGhuN6ddB6ktd8ccaknRTJ/sNTckeqSaerBWTwBhZw+vZKZFvtAWqETE8pQimwRoruEicnLgZI249U0II/CiOcRuVEjJoM2DwxiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhD0fEYkcSrJGein/6xO3kHRIOI3ZPYqwM/+n7lbSpQ=;
 b=kFWjeLCtrebtW5P/EKYUwP38PnOXQOGMWIaB+BGiIF7c0x0uSWnHVJj0thukPRj8SHEKB14AzMD28TdDYYM2/VfKw0SU8FnZYe1jbKVWWSvvzcTzw9P51YW0ETyHzro7vrDUaRsW6SIEu7y+hCxmIYHmH6hIup5/atHzbn2/hIu4t3ml70OdOwO/OANifFyqgkJOLF7nLLK0mIztr+GCMhGcOOE5+iLTEJyeRyM5zHGYkqFKcAvZpsZNbNM/NYik7r4qOgvBWcDuCtV2Pli5D1YnjNB9rP9gUhBtatbQdUai5/jC41Amm2JKaXqj2DEa80R8QXtxRqaWlJoHm3pYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhD0fEYkcSrJGein/6xO3kHRIOI3ZPYqwM/+n7lbSpQ=;
 b=jfBRmwUdfkqjAwpNFYQVM0yjAv0QHQ4JaSRjBnCzjFzTBbU2qYpOqunqiQOQ5FSFlvgBh6MOnaaCsDs/JK3iNsO126BNOxsIbAweQTj54VvOJCeYcsMZ6tT71Kiq0FWs4jJzt9kbgZ8FJRjJYg3SAyFGvLbk1jZ8I2sDUmChoxA=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH0PR04MB7448.namprd04.prod.outlook.com (2603:10b6:510:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 00:11:49 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 00:11:49 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>
Subject: Re: v6.17-rc3: zbd/009 hangs
Thread-Topic: v6.17-rc3: zbd/009 hangs
Thread-Index: AQHcFdq9Fkk1aoMJvk2xkSZ0oF9cBLR0EFCA
Date: Tue, 26 Aug 2025 00:11:48 +0000
Message-ID: <vybuayrnzu2kldwdluufm3b5bmjarzqchzsely7gdm3ih4ghjv@jejm2fg2jvdf>
References: <b2678a98-037c-4567-b028-07e5bf149714@acm.org>
In-Reply-To: <b2678a98-037c-4567-b028-07e5bf149714@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH0PR04MB7448:EE_
x-ms-office365-filtering-correlation-id: e2de02ad-05c0-4e81-dc5f-08dde4352693
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+KW/Xh0IFvgnbIQ6jiEinqP1WEt8+RNMq6tKRjVL0jFSluzds7TMhgBZSZsr?=
 =?us-ascii?Q?gULrCUBlLULRAtUmVROH94w94ps0lxjKLnZvp6/w7eLU0P+ETWHFfgbcyy8S?=
 =?us-ascii?Q?vK3KHNPcPEjIv+9TlNze7gZqdDtVcHVM6wvpt7vlj3XLNysCqEED6N1UBshj?=
 =?us-ascii?Q?yvxtp7QVLps1vWzlAQb9aZJ+L2m+69PRbYGhbYfDFlF1TY6bsgA71B3tzs1s?=
 =?us-ascii?Q?StJdegXOYWBE6V1kSkB95pVYFBKCf/7azb4di/OeKSxzoCQlNU2U6fZpGqTu?=
 =?us-ascii?Q?MC1s3J5ybGuD1At8dYUni3ASIM1VWOcZ8A3fpOnfoLwLLXVrhqQZjqgo5G6y?=
 =?us-ascii?Q?DCRlJPXB3GLmZVt4LHjKLCh92Oj73w+ur+K/05av/RFXu/w4NED177LIDuc9?=
 =?us-ascii?Q?qiji9qs3noinoDKA7nuR0pDiv/xfnx7YzDb7d070BPHJT7KtCVnWMnFhzuY+?=
 =?us-ascii?Q?r91Nlx5TEIkY75IlF0EfemcEjctq5XobJCslKKYriSJ9Jtl7H7+b57edqKPD?=
 =?us-ascii?Q?klxlSuPxOqQfYRfGPjT4/LMgisrKOX4PefxPwovX2vE94ouRJ+KC8HFUbGYl?=
 =?us-ascii?Q?ZwN8NPql8zhzFCh6rc7Vr/ZcKIzleADHvefCXKfOkY5ST4z510sweMJePY/E?=
 =?us-ascii?Q?/e9zAeYkgQuyOjBEiFeXXLBVWubqHeThn1VkjrRwv/K4k0BYmCZgdAO1RbRg?=
 =?us-ascii?Q?hp5EPeXKIxMNVFgrrXPX6U6bR0ctVLXwzd9iQpKcfTWuBQf6CMux10nsZO5+?=
 =?us-ascii?Q?Ry4UZgB/WEZPeQBXX1XxZ4jgq+L7FSLbKhRT9Bcvev8E12VhbiNglUgk/zQZ?=
 =?us-ascii?Q?CO6kIx2ADmuvM+lNxZ9YI1x2Z36lNCo6pXGixumzTznRBoz2MlTkjVLBT201?=
 =?us-ascii?Q?l8hqZWlx4+8Tze3O8Os2vxXvNIJhn0BkE9S5UdfC7oVilDgk5IaZv0nWe6nY?=
 =?us-ascii?Q?cTNCI/JLT5a2N1tnA0JqOaYYbZvPwMQJe1/FrJwRBfnqP6XeUyOw3Ld81X7D?=
 =?us-ascii?Q?NlPOq1t+yRUlGGVfBAfrrk8q4kde8EhJ4zF5Imq3dAGOzgCo2QRalCaVHnH6?=
 =?us-ascii?Q?/M5frPqXkxmJOUyrpvO2Xn6tORwCzhu0We27a7oT3l0QOQxcLFBEKY6htQKi?=
 =?us-ascii?Q?/KPr1Kdt2a8bQTCEXH5ODOTIKYR1v5sdS179F5R6Z2mbDP/L2lvCXlmSZBBH?=
 =?us-ascii?Q?04frqaosszSWsgV7gMtqbNoebcZcwvDc1jC0xPd2AH8QdcaSUEiq3PHA6x5M?=
 =?us-ascii?Q?a4igIW7CmCSv1enyui+ZQxZGouvQuSER4Q5ABE9HwGv9mvWVkgw6LId76of5?=
 =?us-ascii?Q?V3te3oNQzF7K1Pv7+NHKT5eo2YvZFcmJnVVUYjfddr63XYbUW+fpvidSbrVN?=
 =?us-ascii?Q?YDgbquA+i6Jg9WZD4/noOcR/gaPqjUTAJBqK6g+qbso4TcBeyaXass/6VvzF?=
 =?us-ascii?Q?ptt8CvPWgQF+zuFvV+EiNMIZydUS7oJmr/tkd5VKU/CoNJ573pKCkg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qMYCqzIr9yby+buLmIaMAnGmEgVQTCvByNuHKOSg2Bqzmy/+XOIitXfN8Bjx?=
 =?us-ascii?Q?AgvXKxRda94rm5F4zjdhM61kuSnvQNYf2OE4WLyTvrpmbsCQixRvua5et4AW?=
 =?us-ascii?Q?aZd3oVO1A3HHoortOPLWonISQV/F5S9gPr6XqWgm1nfqX77KlkECW97JyY92?=
 =?us-ascii?Q?HbdwWWrFiFdepmZ2pCP5fHzVMwcFjWPbQjPe8ao+ZHO9canKjGSDgpTYAt9E?=
 =?us-ascii?Q?s7ChL2ccQopAhkgMVEmTyA6UDQaSdMJjwRxYtSd20K7ZZdh4BIjc/5U/Ldlw?=
 =?us-ascii?Q?ZIOnJlLuqYNB9pyTU6g2nC4ammlmSXiK4TrbfhZ8Y/iXji52u9EPbdQfiQL1?=
 =?us-ascii?Q?2KKHo4SnzZoC6uzorjz8cy4fuFRFXzq3B5uB9F8lWzZ9e1DgTWihDusXR3vf?=
 =?us-ascii?Q?Adnz/WuDJTtj6CelAMKmP2AudqSFChervXFs8OO+rr42RZeYNazg+0n6Hgoj?=
 =?us-ascii?Q?9PjXrOyJYnFKHKjXJCaOJ4XsBqhhm+sneVc9QFdL/dSTvgYnkSalhll3bv5E?=
 =?us-ascii?Q?mXmr9Sk6JWJhBqZtddwFxjFJeHWK6zqTJ8jvTBZq3BxAK7PJVQ0iXDlsSj/0?=
 =?us-ascii?Q?7EA8+cfHsCsM9M8OKFL3+xqexIkmYGZ/xSVo5/oE5od5yeDt3zxdXytdAg4t?=
 =?us-ascii?Q?77MOsu87q8pcECOzLQ1ICJXUiKXzdV5uIE1bcV+3Np+2ioy/xEHnqT0Ho2Y1?=
 =?us-ascii?Q?/BuT2WU/hfzvTxtBbP49r2ZRgXUJeOri9hJyc+y+uNf49U8hLXOrz6Qy6ayk?=
 =?us-ascii?Q?csCrJO1w4hdnp2wsMgE2eGwcKskLDw7xD9i5R76AvMobunDrHEuykNDHPZpS?=
 =?us-ascii?Q?qq1FJ50n+NdoV//KMH1dPdZA94JDu9ubU/R2aHvcx7rcUuwyiSNSlwzjRSnp?=
 =?us-ascii?Q?McScb2gBS5xXf2HQNtUPRgFlScNJngJlImuw8eCny7M7HlfMi4j7KiONvNJC?=
 =?us-ascii?Q?V1KJ8KAe+9Wx7Fa1P3l5F/A5OqPTCzn5wgSee8VDGsECtylrwRdVsytTI00s?=
 =?us-ascii?Q?PNalKbRXe2G1w1Wa4bkyIuyLlZviINQSnzh4PjPMAOVc6nXEJWm7VUYUmynF?=
 =?us-ascii?Q?tr7K2dNKHnPaJn3HfMJKYJduGiMeGSfL7ScaVbpC/gnKRj79oRI/qPQcBg1g?=
 =?us-ascii?Q?wfWmjRaYbiClB5h0rIw6yqoyo4ggdXhS5W/U+l+4zfwOblEmBcpgBtKRJUv0?=
 =?us-ascii?Q?B5ab9IoolPyWAMArTERSQ07bMLEH7XOxAA/poHTOPelpdMtKfpRrup1hGLiJ?=
 =?us-ascii?Q?S8Bj+TDvDeMWlX+v/OoZfNj/7KAUSz8MoLIpwkWkBPs42hySPQiYGICnMfLK?=
 =?us-ascii?Q?32cG2J9G3e16HvCnx5QEzHHAlfRsdWT+BqWCxYY7r0fTg9bL8wPuIaUMLbla?=
 =?us-ascii?Q?3m5RDO2BHBX1sQLoq09e2MQt/qhyu5XxN2YZdBy3M14FZl3jC9s8l7SRiwpB?=
 =?us-ascii?Q?1R2Y3Hyv7lPsRz26Ya1s8Jbw9NnUVNndSINpanQwSlhsVgj7oNI/PBAJxf7e?=
 =?us-ascii?Q?EojHd5IKNGDDOqzbtXsd2kq3eBvcl48Y2Dvm/b5UdOpVKmd5QbyVYnoRxjWV?=
 =?us-ascii?Q?O10iH5qYikL0x+X4/CTraJ0GcoyLk8zTQQrFSfiPOz6N2M9AwQzY/Sv+ulvE?=
 =?us-ascii?Q?qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8698F4AF63493A49B6C85CA6C5E41752@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NXMbYlC7rJ38XHR+FpHnV7evwaYcdNt9GRYrOPq+A0YPNr2GBEw9wUHeHI5XJhjP6ey5vQUNspYK4RJ1YkUNpoJNw6a2XSyiuj29LyUSflq/wFIxrVnBc36t3xoSLZvLfnuQVjmbamHbmZNeDn+VDfISZ9b5VBgygKJ0J2RBKo2bpwKwl/qzbjewQ08G2Uzmit+wpKjF3KBUipHkVRXy0uW69dUUHdidKQ7tw1qvbmTK9rT9Cz5Bb2p/gs5yhQ7ptC6GmkcEmet/0nd8EUypFBCPZaB1x+tzhVqOQNRLx3NnjYs/EL6QRnhHp8B3I3sOWBOY5C9i267wVIr+e2Q1FmVMxBaEIRy7XPi2sbJRf1v/3chOnpsZjhQKmcmApP89uxxjJ0TH65oOv3Osb/o/567LFuRrAkOsoW74jrVg/71xlrfFdp6bRHGujOzpLmN9K+Wn39FwvS5ciTd7MG2MJZkOCT7DWL5CjHie/CBO7PMFv3EkxNFBOr8KZYQQBsHsrS+b5hEPCweEoRW26TaPqI5/5Hv/TooruYETnK3RgAxlTgygniUFOe+KK+95d3cXkoNEF3tImaUurNcnKEmRyQDSTQIkYZ10CuTMu+bogFdKhZC+fYfgSxcRZbsJPwST
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2de02ad-05c0-4e81-dc5f-08dde4352693
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 00:11:48.7398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z49m1zlSdsDb3/ttu45XQHgY9EUNKE/8ZJv6OoeCd95Wz8LkmNM65/6mYy/ghFAM28ET6wgIHkwTC1i0sEea2ozPxUlHzEe6ZmFP6E09+7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7448

On Aug 25, 2025 / 09:10, Bart Van Assche wrote:
> Hi,
>=20
> If I run blktests test zbd/009 on top of Jens' for-next branch
> (commit 6763582c1263 ("Merge branch 'block-6.17' into for-next")) then
> the test triggers a hang in btrfs_writepages(). The same test zbd/009
> passes with older kernel versions (v6.16 and before). Other ZBD tests
> pass with the same kernel. Could this indicate a BTRFS regression?

I hit the hang also, and identified the trigger commit 04147d8394e8 ("btrfs=
:
zoned: limit active zones to max_open_zones"), which is in the kernel tag
v6.17-rc3. Zoned btrfs requires max active zones limit of zoned block devic=
es
to be at least 11 or greater. The commit applies the same requirement to
max_open_zones also. On the other hand, the default max_open_zones limit of
scsi_debug is 8. Hence the requirement is not met, and resulted in the hang=
.

On the blktests side, I will post a patch soon to set max_open_zones limit
larger than 11. I expect the limitation of zoned-btrfs to be checked by mkf=
s or
mount to avoid confusions.=


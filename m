Return-Path: <linux-btrfs+bounces-10183-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 660409EA7FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 06:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588D018892D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 05:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CD7226193;
	Tue, 10 Dec 2024 05:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GV5nipMK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B3n96g+Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B24BBA3D
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 05:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733809234; cv=fail; b=rN0a93mqGgN1SHREYdlLPifc3u7xjG6p29G5oNTqnVieq5xauf8m6z1q+qgBOWqiwyGVuMnFFN0pqSJYgZkbeNzveOUUYCdh6qjj30r2FD8UpPoZGoTncaVYxAKBxU3v2vtl+1E5Vgg6Qs9+tpApQ8iS1zOiaNCaMhjrGF6TGSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733809234; c=relaxed/simple;
	bh=QglI/aqrxSdDPbHAukDFSWO4/Hdy+Nx+fmlpmcokgA4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bR1ivQT8yq1vq1qARpMJTc95fS+Xf/IEDrSrAmHWecAFVbVXgaHvZGxTWFsASk39ccGj4aFXrYRLWVWMD7MRAknR+V4hSoJ01mqQDbiTbhHKZm7uvRrcK2VQOCZYPV1WALT3Hy/uJx2f0K6iaO5raI9GDEwSHZNhUMSOVb7/gnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GV5nipMK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=B3n96g+Q; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733809232; x=1765345232;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QglI/aqrxSdDPbHAukDFSWO4/Hdy+Nx+fmlpmcokgA4=;
  b=GV5nipMKbq/mdfZWjI8sskm2vaqt67fYOG95m5PFsvu0G6nsNuwjD6df
   YcsnRK2VvbvGmp04s4sFGBFD0Fzrq3pgJHrIP2GpmGNU+PKIa77bQSIM+
   Ji+h0XzMfzPjmWtjuNsa75lgCsynYiySurRxm9eqg34glRdUGrdBkj17h
   ysZjWQgu439X8Otxp2l/boA/vj6353YY2KbSj3Bc8881t/HTvxRSjkJ2u
   xPAgx/EAph0D5u8/m6VvPOJLnkfj0hIdkQURQ76AV81yOhqpUyvIQi2Z9
   B/mKSCz6/STf5JCmW3kh70YvSxjV18fHUuAQBC+IW7rAKs3UFSl0Of9I0
   w==;
X-CSE-ConnectionGUID: DQ3AzGz9Rq6kwwsRTHljrQ==
X-CSE-MsgGUID: 4bHr/xB4RKGprcT5Tuxwxw==
X-IronPort-AV: E=Sophos;i="6.12,221,1728921600"; 
   d="scan'208";a="34576260"
Received: from mail-mw2nam10lp2048.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.48])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2024 13:40:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbWL+ld9lc4YeYhi/o5IizN7hFI/8KIMIXEq7JK2mvvq9yG4fzHwn1UQ+p6rvlq/KC13zrW+d651CYPBIEJ0QJ6G/zjUE3qr3klHMyndJ9NLT8MvfsfaXzVoRCCoUZTdtQlUuYCD0jPh3SeSSz9GQgsf/c9xKLpKYWLYfVVDiursGSj/QQo0jGtNyoBYZK2Cq8ac8G6+9B3L2A7iwOFIK2jsOSEegE2fUyBw6U+CFgEDv3JPXfVaaa/H76VQyKEw9MgIkE1haoeodGa4AcdbXV0LaSEARCv1LoD1QcAxvw6qREiXMzAv/OzeB2Qq4qS2Clc56MjMm5KL6TDckktIzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuhuzenWsjpKOb/7Fhf9Ap8oByTwWYT9EaIt3j23ER4=;
 b=GLTcssgbXFt7FtpoGNncOB7vbpLWLZ+gfXrx8EUZXyxg13mrU40kdJXVSu1Qnajlk7XcmrtBIrIRrcJaq0nMdrgQjHiVJw4tevNRuG6gJjQnvhJ8IQOzpiJIoo5OvwfRg/H34CmgUjsUqYuxe7vKmQk0RKVkXPvetPDmvWyB6eyvXAEAjHQpd0xecbyM3ecHClPQnNiJZUOKSsLpYB1ovnxAZFugzJY5zNv4z5Wp91GVvNaVRqsa0le/gKyL3eLcCJLK1AzfM8JvW5J5BmO2ILtJgGfZcU5cnZjhDrWXZy36+UjVtdxu+aw/1VqEA5k2TxPhLKQXzuYYWGzCjum6PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuhuzenWsjpKOb/7Fhf9Ap8oByTwWYT9EaIt3j23ER4=;
 b=B3n96g+QTMQ81Fphqv+n35TTchoseO/JaDt972/Wl/gW6gId80xOlW5jjfaXbYlxn9HEO663ak20vqPwgleOFVl4PB+lyHoLN33vTMF7Gq13KOb+/vcbDOPHYaAb+jUMK+SH1E1XFPr0OfTDG+zYMgfJLK8dQU+kp39P9RT3zT8=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ2PR04MB8778.namprd04.prod.outlook.com (2603:10b6:a03:538::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 05:40:30 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 05:40:30 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/11] btrfs: zoned: split out data relocation space_info
Thread-Topic: [PATCH 00/11] btrfs: zoned: split out data relocation space_info
Thread-Index: AQHbRuotwgVpjwk8s0m6tiD4iabBMrLaqkkAgART7YA=
Date: Tue, 10 Dec 2024 05:40:30 +0000
Message-ID: <hm5whah2es5oyjv4wdx7ucrnjaowe42kecs2ggadukakbwqjkv@x5lyewbjsb6p>
References: <cover.1733384171.git.naohiro.aota@wdc.com>
 <7c716895-1c7e-45d7-a3a3-e77e32535301@wdc.com>
In-Reply-To: <7c716895-1c7e-45d7-a3a3-e77e32535301@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ2PR04MB8778:EE_
x-ms-office365-filtering-correlation-id: a35ff92c-9169-4ffe-5486-08dd18dd2872
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?W075a81wdYd26Tn03lkjivlmeenvNyb5ob8Z8f5BKhNwixfwYhMag+EexWQ3?=
 =?us-ascii?Q?51lMFRL6F9toEJFep7ok6vNx18ANCrq0tQUzxbKIvDJ9f/HcKkUxuQobprN8?=
 =?us-ascii?Q?LucpbXyEKXXP/uQLKxTL4JfaqoveA6DzcK4LATfEYmwtVwpLe2etAneBJbaZ?=
 =?us-ascii?Q?1gJ7TA/AeCgJmDJ/wjTv37038451xX3enRP3bVLFWnAFA7JjzxwRE/Z6ejgT?=
 =?us-ascii?Q?KkUpOe6jjfpm0JkF8oZNd4DmcG/c+l9n4iiuixHagO5G0W2fS5ZZJdAmelQ/?=
 =?us-ascii?Q?6qWq4T5rm5tatGUkOBpV9mTfQjFO1nRLQZo+qwE2WUi3EMc7x5DcjuSCZS7j?=
 =?us-ascii?Q?G5762LIa2Wch3Zoid6FYjqrrtshrpMcccxZe6vgw2mZgROlQ8cGjsSrhI67J?=
 =?us-ascii?Q?lKk2ZbRIOWIeY7EcPhSCQOOxjUUWJtRjnCCZZn6XKS1sO6M1m1WsMaLoJJoc?=
 =?us-ascii?Q?SMww76dgky9rPgj/BbwiB+JAYX9QbUhzKnl7dxwdIrh+bCBSmqh32M/0N6BI?=
 =?us-ascii?Q?ga2y9le3FXXJ2vBE3fOK/IOoBFc//Fk4TOYB0WT0IG9Pppgr/0Ng1XTZgGX8?=
 =?us-ascii?Q?nO++/I72My1bYj7mwWQt3Gmqzq9rV1+bdfmqBe7W3H57UKMNLuhC+dEMM9Br?=
 =?us-ascii?Q?ChI2gc3O+/VSVtAvKRAKUPfbSWNlbFP8UuIXgaHFjU/ZDLx06XtfbF0ygC2d?=
 =?us-ascii?Q?MdcQtLC0ShT4+H67U1TxCW1xSpHognFsyB77NaUwa0vkk3HsqJfQ2Hd03uHb?=
 =?us-ascii?Q?wJHtxjihqq2n9pCnXyF6TdzPyAXjdt1olr5qitMPZJpdEfQ+54c3NZTNcjTO?=
 =?us-ascii?Q?nzGYcJ2pSIOlgbBJZv1Izh7B9S+NEZN3VFhnU9G+GOdze9kNO1eyBm/eE1LE?=
 =?us-ascii?Q?Uwzi0kMZYt+iyG/mWUKR2hxHiRQFTMgY+G3kS9mJ9VyXFLFhHhQOZ31+VQbV?=
 =?us-ascii?Q?8EtU0EabRwcr2J/AiciWD/qUwuu8NoYZvqOg5dEPiyTIEsDgINJ9mzo2N7iW?=
 =?us-ascii?Q?VAf2CbwAx+xy8ydmI/fr9ZkGybFNE3FxP9yCjx0udLxr/l6/0O6Kj7OtdsPj?=
 =?us-ascii?Q?tYluoRPv4eAp9cqsybYQqTNK035Fm2Dro4lvAzyIpPHrNIN6lXppHsasF9tt?=
 =?us-ascii?Q?bt0aesKZJkbuhgii6hgd6DwwwuoQnccedS4FlIImNW3/iKPoCDBUDR7i5C+I?=
 =?us-ascii?Q?qn7HfjSRRh/3UfIyWBEC0x4uuFus5dr1ywW41Hu0tQPDCsVkjXGDtP0AD1oR?=
 =?us-ascii?Q?lYQgktD5xO2Q7dlKr5GoMTv+rcUqCt92Q/9GJX9W8BodFDc+IhOU6CdGB9n2?=
 =?us-ascii?Q?FV5ZG9oc4d+H6PYO6M6Z71r4fD06RmJ1eDtvv/jMR5fUkmP5wa1KjMlPC3Ct?=
 =?us-ascii?Q?knLIVYYth9AdBusipA8G64aQq6gXLoyxFcSwRZvL+Hbn7sCLSrVgjuLuReoO?=
 =?us-ascii?Q?RNo3i7Jozdc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aUm4BHCrcWDTTZQFV0rGzZvPi+USCjR04ygWPk/tCxdMyePBWnaiTC9l4/2W?=
 =?us-ascii?Q?JT2GTuJhtvwfxFfACeyocZA5NmL6cTrubpbuIoErB5QO+3kzVV9lWG29F9c6?=
 =?us-ascii?Q?PBeuGCTa7HCQ2vbvvEleGL1S/ACfeRdiuFlT0fTfuxGOC92+q3dcAhOJOa+N?=
 =?us-ascii?Q?3DmFgUqst1RJwjps1WgJ0EftvV9xYxHIK1zrgFTrDVoZvq9t7GRVRrDZTVFN?=
 =?us-ascii?Q?yrxPn+8Vx0l7/OLvjD4f2H3vj3dVqijdyB8p+MtdywY7nRAADLN/7/w1IhDv?=
 =?us-ascii?Q?scqD1Lkd9XcxbX9toq0Cmopn2YQo3n6uKaSUrJBAX5FUzwL49sfmQ41/m4/X?=
 =?us-ascii?Q?0XqtQV6O4txS9EOq7q1z7682mUQJvt5BNF0qie7CQJBkZoPdHZL4Dq/FrVeF?=
 =?us-ascii?Q?pJaiEOPCFxBGespIdRCuDDc6ABjm3Srm4jAh5UqNWT5ycDTy14L4GdYTix/o?=
 =?us-ascii?Q?Mv7K1rnTC5qQfIQAOGI2bU1NHlx7oCp2JP9QjRjGSRYEpxiQRzidvbA7Ljuw?=
 =?us-ascii?Q?vgYJb8R5ntgAmX4o/HpJh5MMAW+tfbpOb6XGM64sMsR9F1LH/MlYdizDP6Zq?=
 =?us-ascii?Q?/G8bfE4i4KlmJ1QYH8iKRilduEfOXj09DN33gakDhxpe4/zAxnnqpbu0jGZX?=
 =?us-ascii?Q?Tmbz/tugxRwburDCEi7/I7aXILd/yigNdNB+HGP+QR/YGYyQqiaFsD5l4LTe?=
 =?us-ascii?Q?HbKXfLaZ+sKjmloD3+WQLFZz+Cc4Rz6S7TWOT7ZASYHZNNAXfVR1+19vra7a?=
 =?us-ascii?Q?Ct/Ov3zjuqA8rlXQjDlg5kIV7wxQy8SBQgId/7L7cVndj6xfV+v0Qgf+2ENW?=
 =?us-ascii?Q?bbJTLcG1OyX6oXibD7S6o7AyLYyvwMVtnkziaijGWIMtyMqs+nfkPU/5p65N?=
 =?us-ascii?Q?bdGK3gH8SCjsiY7vLn2vNZlHNH03iQpkuGd+XQTFyw0X6t/7kzspcirf4H6D?=
 =?us-ascii?Q?qWXNaWousTKlPZyntpGPm9xYy+VafDGpSDpCJWPh1GiSZMBj7o952M1qkT5/?=
 =?us-ascii?Q?8GMxoEqT2nQvlwVBTEB9ZZy6fATVtquY5GmNmKpn5cLBNMtMOcOet7/EsB+Y?=
 =?us-ascii?Q?dTpNSYIPblpVk7tpNJmTw1Jt6G1uHLqUWuIZQbqbml9iUnmLzi40ptDFKGSv?=
 =?us-ascii?Q?UpheDVZVOeksztjUIs8p08qVmnQVqffMHpKy+XjACwFTHDJ//x5+Ougc4cax?=
 =?us-ascii?Q?Tl86tQ137Eo3DZGMSeCW+Ux7/w7fDlgzEn/s9hYf0MKXQ3fjHAE9M0HEsUVM?=
 =?us-ascii?Q?Lnavyva5ub537qXLsy9ez26BxAYifIx2TTWRAWVDiHPZWYkFXRVyDdqBdfeD?=
 =?us-ascii?Q?+IRumcF5DGR9EdAW2gupVQ7qpwDzdJDAQ9WqwhzjbuzcijvF2U3lUFsE0jU1?=
 =?us-ascii?Q?XrY+145ciCzRhxUIhj1mrmA9zhULqYXAhC1I16+bwY2N2kG9QjG0PQjmixRq?=
 =?us-ascii?Q?1dBAEzXbcJjJHC5lNCLyB6/5qrPJybvEdOgEiWguC68jxMUTqT5cYiDcFLWh?=
 =?us-ascii?Q?QrX6fESE3IMTaZWTMXVkQcrOuIiDSd1eYgZ9YCCOVzxCJaOsUBY3xvM3M4J6?=
 =?us-ascii?Q?JgTZPYfnzGrTzBbU4ZtE58kr5nE6DeX5A0OJcy0iUFb1cKSwsa3BrpEvgkR0?=
 =?us-ascii?Q?Rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <04698B3FBBC2F04AB683E4DAEB941FFC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OjtOUdhlkWz9HRYDIPYyabAxyQ9LK3MlmdZl7apeze7xEDMU3+uSvOefUYTsnhlugIYWDb1mLJf2dFHAqjjnNUDTql1hwvmH184/D5/Yh0gzruoam4V/d35o3TlMO/suHA42S1W3Pj2xKtRv45vTBspM6xDl9b+kqPQCwd2n176YgutHub6iWOEeB6CH1w32qklPTebGwj9LvV5rYUkEgPPK4bM6yxjxhnDwyW2aWgrzcNyuJCGq9CWjRoZvRvs50xxM/PBVy8m6+iQzKscN3fUXTcLF9ROnHKZwmbhyCGxHe9rtCpCKxPhZzYG93FFc9VAQ7I5W0RSmAjQy/ZJy684e4FRrtEnpU/0Uss8RzabJF2lo/RRRHCotohgxwwI0QPy79FltHroluqZKDWZldw4k6WBDxFRiAE7Hfqo8Ao/nNMa5fn7x8H1etMXu7FLhRz68pJDi3az42h3J4Z8ymcB93QDLK0RXsnm6ATmpEW/9jXoGFarStZgF36CD6OjTT4lTPHcSp5pW1p0LOKaoq5fs6Cok8eTWthLEzOK3Pi9Adhlow452EqN8VIaRSy7wLwZabBmjUgLkk9nH9Cz2zi/dGQBi/K+GJWfDoRtDwQJNV8ktfM57JEhd6XXOfCUn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35ff92c-9169-4ffe-5486-08dd18dd2872
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 05:40:30.1573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AdwqGPaDWeMoaxZL/a1f8OSXRVVOxNU9+4d+58iR1PieqZzEyveIGQOykgeBQvns9bPrIYsJ0axQTK1TnmqrMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8778

On Sat, Dec 07, 2024 at 11:35:04AM +0000, Johannes Thumshirn wrote:
> On 05.12.24 08:50, Naohiro Aota wrote:
> > As discussed in [1], there is a longstanding early ENOSPC issue on the
> > zoned mode even with simple fio script. This is also causing blktests
> > zbd/009 to fail [2].
> >=20
> > [1] https://lore.kernel.org/linux-btrfs/cover.1731571240.git.naohiro.ao=
ta@wdc.com/
> > [2] https://github.com/osandov/blktests/issues/150
> >=20
> > This series is the second part to fix the ENOSPC issue. This series
> > introduces "space_info sub-space" and use it split a space_info for dat=
a
> > relocation block group.
> >=20
> > Current code assumes we have only one space_info for each block group t=
ype
> > (DATA, METADATA, and SYSTEM). We sometime needs multiple space_info to
> > manage special block groups.
> >=20
> > One example is handling the data relocation block group for the zoned m=
ode.
> > That block group is dedicated for writing relocated data and we cannot
> > allocate any regular extent from that block group, which is implemented=
 in
> > the zoned extent allocator. That block group still belongs to the norma=
l
> > data space_info. So, when all the normal data block groups are full and
> > there are some free space in the dedicated block group, the space_info
> > looks to have some free space, while it cannot allocate normal extent
> > anymore. That results in a strange ENOSPC error. We need to have a
> > space_info for the relocation data block group to represent the situati=
on
> > properly.
>=20
> I like the idea and the patches, but I'm a bit concerned it diverges=20
> zoned and non-zoned btrfs quite a bit in handling relocation. I'd be=20
> interested what David and Josef think of it. If no one objects to have=20
> these sub-space_infos zoned specific I'm all good with it as it fixes=20
> real problems.

Hmm, for that point, we already do the relocation a bit different on zoned
vs non-zoned. On the zoned mode, the relocated data is always allocated
from a dedicated block group. This series just move that block group into
its own space_info (aka sub-space_info) to fix a space accounting issue.

I admit the concept of sub-space_info is new, so I'd like to hear David and
Josef's opinion on it.

>=20
> Would it be useful to also do the same for regular btrfs? And while=20
> we're at it, the treelog block-group for zoned mode could benefit form a=
=20
> own space-info as well, couldn't it? To not run into premature ENOSPC on=
=20
> frequent syncs, or is this unlikely to happen (I'm thinking out loud here=
).

On the regular mode, it can allocate space for relocation data from any
block group. So, it is not so useful to separate space_info for
that. However, it would be interesting to have a dedicated relocation data
block group as well on the regular mode, because it could reduce the
fragmentation of relocated data. This would be interesting topic to
explore.

Yes, adding treelog sub-space_info is useful too. Apparently, I sometime
see a test failure due to treelog space_info accounting mismatch. I didn't
implement that sub-space_info for now, because I'd like to know first that =
the
sub-space_info concept itself is the right way to go.

>=20
> Byte,
> 	Johannes=


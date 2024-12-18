Return-Path: <linux-btrfs+bounces-10527-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C113E9F5EF8
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 07:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D741882E81
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 06:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D729156991;
	Wed, 18 Dec 2024 06:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PokvuUUV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ky60fmso"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A237214D439
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734505133; cv=fail; b=g/FEXI48Vt3+XNjRv/FmzEFWAwbAz2EiXe0ylwPgHr7OeVcsdxwL59U+zSTW3/klvKgAG/kLBGLEcxhD43deuJ1afKVT5G/+7EqCMMd3xMNnnkFc8XWDGSfAxhl3YWWt+aOTiO+QbTdDdMXtiq5ZhraoedCOaq7cOOaNEwQMCds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734505133; c=relaxed/simple;
	bh=rwNc1Sh7xuKBZXo368OQe12ShUibR5yOi1y/L3H1Juk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uVZ3bP13o+OaMzZtP+k2OU4bBDXPDAo5XxMh/K+uEPEOR3cakx0i6ko9lhW9Xx5ojW115BKXclp/QUopHG4pafzgwlTgA8P3S0AGPMZFqKjAheOG4cDlQ0Q/mQPi2YqNy0ms7I+pAzzo1lrZUhsixBSMwFbLznNVnxsGebjpqrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PokvuUUV; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ky60fmso; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734505131; x=1766041131;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rwNc1Sh7xuKBZXo368OQe12ShUibR5yOi1y/L3H1Juk=;
  b=PokvuUUVe5QrkS+E9J/bCr5vY75pN0NUmEGPYysHa0Z1GZGpNUkY1kIn
   TLBZ3otruqOitondtwJgu7uiTktQ5RaqK19Ih7DLfEJiGcnSyDbrfTpwu
   M8TL0LH3PsKm5AUFZ3Hil2R6ZN+eRFegkJEsoDjK4YL3yUufCGbaHP0+6
   14RWnkdwqSqh5sJ+/gifl/9cK/HYbm/WQIKys3aDvIv9LQp8r0bgFtpJO
   hhRnW4LzUbQPk6142DDjG5nAnjHo+DmL2Ql8reIMfbBCv2y6uqgUeWLrt
   mKfM07ihBc9fXncuALGzrIRNnHuk24V3fdmpB4kJa/i2u01yrARcsCSRx
   Q==;
X-CSE-ConnectionGUID: pm6tXB9sQMWcrV2UFS7u/w==
X-CSE-MsgGUID: kVrIlweQQRiS6xiLp/j/mg==
X-IronPort-AV: E=Sophos;i="6.12,244,1728921600"; 
   d="scan'208";a="34641206"
Received: from mail-westcentralusazlp17010000.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.0])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2024 14:58:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyfmQG3h4qKTGhAum0REa5/qj0MQqSKrp5P/YhDyvjXi3F9t3KlOwku0jor18bgTb3k/93HUWoJXPI69UUWjyPNC13WaUjMzsR/mNj8hupvrLSZ9b3uJtxYPI+usTdojq+8qiF1rnds5h5UmYHf3KeJlOvjRste9W965Od8A3gxa3qLUTUGQmxj7fgiVxoylenK4weY3a4TeTCXZwMWNcqYMcl46ncqqKl+igOroaxdSuWNUtQMDCdfBPwl4YDjmoINRB0vDN6pUQWpKOt5SUxMLe58/Vwou0zaQiD97xVjHFQlDDR/Op1DOJSMr+UBQb5hJvdaXjm/Wp6A8N+DUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1/NxbkhMtkBeKmXbIizgK3DGib2nE+gFz1EuX9u8RM=;
 b=qMH9neCKhVd54Y0c+HUjdaCmKTgN4/480/FaqS/D6i/8/XiB6KpqWRRbtfr1y4oDSgVbFQ8GTcpLKlK4ytmIWrYUAwGHJ6107ZCKozENKfuC19pZslHW6YQhwicTd/U7JZduHe/7H47/5SoYJMtwWIZH109KS+mAqZt9Bgt4QEZ0wfhVDXBJMrEccR1cDtbr9/ofiiIG1lErSVs/iwGa42g+yKUHT2XxNhGmCibZl6s4TBesRBEGiOQZygYHnHF06CIPS69pyauJle1qE+s9SQOnkpwRCL8qmHDh33ZS1jVHHd/r1jz/qS0menBjVQUYXkekp4HdMfpHKsF4mou2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1/NxbkhMtkBeKmXbIizgK3DGib2nE+gFz1EuX9u8RM=;
 b=Ky60fmsoMjomG/z5jMMiniE/Z2zTHIaVps5/V8yCAPX89qqUKw+ATWwGSGHcBNmSegQ2Qvb3h6hJxlRKBZCGvnJ1vyEQEFSfoiH3Z7Pb7e0xRfh08/FXu5z6XQsmlS8xhjKem3SUjtbvXgHJYPuaL9ZvA+NnzaXXBJ51WFSU/L8=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MW6PR04MB8872.namprd04.prod.outlook.com (2603:10b6:303:245::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 06:58:49 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 06:58:48 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: WenRuo Qu <wqu@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: sysfs: fix direct super block member read
Thread-Topic: [PATCH] btrfs: sysfs: fix direct super block member read
Thread-Index: AQHbURZ6UC0V1eUROEuoSvUIzx0fWLLrkmUA
Date: Wed, 18 Dec 2024 06:58:48 +0000
Message-ID: <fdohuhi3litxdv27zy5jbq475igics2xxlxjmbfxxp2rywzsdi@muzz3iejhvzk>
References:
 <67a25027c7d05f33c71015b60fcfb75d89ac0ab9.1734503454.git.wqu@suse.com>
In-Reply-To:
 <67a25027c7d05f33c71015b60fcfb75d89ac0ab9.1734503454.git.wqu@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|MW6PR04MB8872:EE_
x-ms-office365-filtering-correlation-id: 915345a1-748c-4eb7-7c0c-08dd1f316c5d
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Erh9rAvYNE/mxFpIGd+lZXMZur/if0j1QHZv4B2hM7KiD9p3OrV/eVS2rchp?=
 =?us-ascii?Q?XQPPi7TCHrr5ksO4wY2q11XYrRI1SDehQD0ah4MPrcTS+Z/U9b16x+A7+T97?=
 =?us-ascii?Q?24xXTWtCWabHT/WyWkotQAOQFu3enx+S/5mGiwCwlCLe+hsBbJlXQ9d2xWxz?=
 =?us-ascii?Q?trazDUUmSpQx8yRBpTZ/gttFwCwtJ09o2yQPjYP1gQLizcBpxkYuCGm1p+2Z?=
 =?us-ascii?Q?X4gGDJqIOb8ZWi+d/e4Koedi5NMI0la3eryVZ4vHl6sjISyNxtPo+d+n3rbz?=
 =?us-ascii?Q?ElpWtO5TCFyDg+JkYCGe8mL36tnxPOrnKvDbcokfW90HkITsyfc2gPfJFUsD?=
 =?us-ascii?Q?1zF8PZXRJgrri1fGW0qSKWROQsOoE98QSzLthMANHYegxJSWkMGw30HNoaKs?=
 =?us-ascii?Q?GpxnJouDvRkdqZ8zHYRtt2LD7efwjXB0Rl2GDNw58HZ7PVjAJfWNwvJq6GMJ?=
 =?us-ascii?Q?1n43ltReZJnfneKkvBOktmIQnlrQBNWcruwP3fDKC3U32B+bXr6kkRobecoZ?=
 =?us-ascii?Q?R5HfB1fFLXX0Zpux4NZNCYDdmtpx6ZZoHysHwEaZS+rRjOS4KQLstzqx1Jx1?=
 =?us-ascii?Q?x/QU5zZnlGrH8vfjP4gY8kJi2VC/ZLm9P8AJnjCOuYgv8ivcjiGah6CAmM4c?=
 =?us-ascii?Q?ocLBBNf+VjedC7gSuE/lMLb7FeaqUW2G7+GcdSGzbexkPUpDD3Zf/IdlEW7c?=
 =?us-ascii?Q?H8gsF4xyNEG3Ty/W7C7ded8Wvg0pn9Rm7e268DpGGfndXS3Mcs6ZRg6jP9hu?=
 =?us-ascii?Q?teex6bGjgB8DLjfz5BSueipltab6H7JW5I7RJ5SiBFB5OHzgk3h5cuzPcn0B?=
 =?us-ascii?Q?00xKg0UO8/0ayMv0YnIV/jlpdGoAHA51+eis4rp4e+J9yk/zFB4WtHqb3U+h?=
 =?us-ascii?Q?UrnRjs9hUyn+9rmQmsZKy9JmVzolElDjk5M3twQoxlsK7NPyF3hDnG22UECR?=
 =?us-ascii?Q?xDZ5tF5JA9I8gjgodNZ0YaK0KIR1LsGgNWlujPxschF63Y30R+k4iZKFu1HJ?=
 =?us-ascii?Q?AgLdJoggP0SbJdnXwpCkRDgyzlCKEnJCZNngeyem1W09fuRFTaD5pbrAkacF?=
 =?us-ascii?Q?McL8tjth3QsXQlcQlV7Ee3IB11DtM7hOp6fPzrwH6LfcRoNbMbWxjrRbRSdP?=
 =?us-ascii?Q?UU8yCkOILPVAX8XmAG2NgkP62QcR4uXkg3XQhfGgVw6Fb/HIFteRN8Me8yxA?=
 =?us-ascii?Q?++vRx43r+NYi+jcgp/FoOFHSYNkvJVi2btJdHPIIKzVmCGLUZ74/eLSF+0Zm?=
 =?us-ascii?Q?ddnvNnTR5s+TCNu3lHkNPt3tc5T9l2bQF5Ws4KViu5apOzXDB1cZF1l8Pjde?=
 =?us-ascii?Q?blvV+9RGxKazQ+i0WugyXAD8cYjPeKPxo4guEzNGPH9P6IXnveM9aKwNVd1v?=
 =?us-ascii?Q?nvf3YylaDWgM52wPen29jGe9BmSc1Bx4BRm8J5QT9NyhL+tU36qsON+I0Cj+?=
 =?us-ascii?Q?0KjZaInuDXZNArRgw7E6RsAFSWaD4wIY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?70kcr5qpElFyknK61FSmpBY8TpBmEXYbVHxl0RuhnN6ACXmXCq2WMsg0Z7NS?=
 =?us-ascii?Q?vZT1t2gpSZzUA96DePR3jcFWL5kT06KyZaAHQ5KQ4eS4BC2e9ICBZD+EvFB2?=
 =?us-ascii?Q?gDptJnKOUJffbdhHvXv3b24jVNdOIypRZkYXA1tCSDuUmNg0zm9y/UYj1WN4?=
 =?us-ascii?Q?0XWkvAdz9RRhajaT4amoA9ox8C7WytfSSgZ7AUX570Y8U8/8hhbruz8TIFe9?=
 =?us-ascii?Q?TxmpV7aneCcrh85Lp40o6w3Hg0Lc9ahC8Vo2YJCwpM/6yiI6U5JV82+bhk4b?=
 =?us-ascii?Q?ItEIcWm1MhocqSgJQuB8bzX094p4jOfSaZ5h7NIa38F2TUZbDo9G7/+5Lbpu?=
 =?us-ascii?Q?2ILtd04AXtQXbKkxTm2licL3mLjCrAvlXx0eD3Hc80kkpukSU86L11tdN8qz?=
 =?us-ascii?Q?HW4YI5Jw45qlEK2Gv6g1rxBdJetYSMbVpMs/41VblOZM10pjVhDpJaLruybu?=
 =?us-ascii?Q?g9G3uMJk/rE/NVsRNTt3Xp9uTxu9JECy6K7gO5uZC7re9TzTbLJJibnADCyd?=
 =?us-ascii?Q?JWVi1OoFWrVGP9zsQxNk/yyHE900VKwmV0AZVhBJUOPdBVPq/xKbsxCnQQJA?=
 =?us-ascii?Q?292JVNyrBEV8xm0m8EKyr+c0RhtUWzGkVcroC4aYzPVIipchwZ2npWipOzWN?=
 =?us-ascii?Q?0Y2ZtXge3YLD2ug/6cAR0H+WgHOQGf2fZzD2P96ngEM9mNeDL0E7rxmrPw0P?=
 =?us-ascii?Q?YXtBQjNfbnyoK00JBBff3gYbtXWihIAN2QmGPsOmDl7UUimL9yplue23NwFL?=
 =?us-ascii?Q?e/rQ2ojkIdC9Va2b60OP/AAnwesiMLTCgVatxi2ga3y4JOPrQaW0rPQ8TUyV?=
 =?us-ascii?Q?4CmK7XbX5j6H77fqsHpg5LkU20cAlJSyIt/hWvQSAQtybdaL4pn7lVDPyIdD?=
 =?us-ascii?Q?QJMFL5JtNA8rBsKlggsJDMnq9ALhOwoBvieGVpYUewcV1lfT3MRqhZAAo3sB?=
 =?us-ascii?Q?ZYOamaytbxGw/sTnkrCVf49qmHc7jABtcuBKCbmeNzPxjig2SEIeT8BhqxPP?=
 =?us-ascii?Q?fTJJTXXgI0iprbtg9qbaTwrRnLE4UbL2J03FCWc13l4ULjiwow2mgakFG+cy?=
 =?us-ascii?Q?wnoiB5WcVkWrY6Jf1vVy5O6vfTFvYMZHQkbJvMd37U65k7z6P6ou9esq/RAJ?=
 =?us-ascii?Q?UrwtD4aAdT3alsxN3qXccaFZDIqk9niaPYGLv/WbD6ZpemqDAr0wyvgZwbZw?=
 =?us-ascii?Q?VQ1ovd6YVBAc9Qz3/L9T0DiBP3rdj4ZPMERM90oZp7U0tTMar6wN5XEaeyM2?=
 =?us-ascii?Q?uu7qK5Xu/FuzgRqLmvHNwWFRELD28QBDx72JafF21P4uCtHEaM3N4k+X4VsE?=
 =?us-ascii?Q?7KKsGErb6YUu57NLzLcuavPuX+B+u2jj/hULp2flhMx7+Aao5nEJkvBGmmvA?=
 =?us-ascii?Q?VJk8Vh+vORybl7HcJIpfHRbymRjcPhWEkw8/IReKnKnV6xsF1Sa4LCNLO2qd?=
 =?us-ascii?Q?ygmX9tWU6ebb6hj62+Dq+C8yVUZ2xn2YUHsUrlZMYx6WG+Td1ucAKMuEzmFo?=
 =?us-ascii?Q?N4NNGo/9bVEn9QIGnyTDB2IKHI9nhMI8H4u6J4kc1GYRzV4fMv7NEgj54EAW?=
 =?us-ascii?Q?pLahwE89+WOSN0nuhIhOtrhfT6M+Fhw5cQ7f9ofLXYpQ9s2enCYr1a1ugNr3?=
 =?us-ascii?Q?hA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <59C7C0D14A5C0848B77699FE80D53F42@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gNxfkKUuCgviyLjtXnignOTSFiaSvlWyWnknu8mJk9Q3yJiRCh6IoeISB+uYesgydV0F+MwAiwTi6ygz49E9v37Q+bUhRhzQ2mo7YM7C5y0KD8W4rnJ4YDXeKg2t5UAKmZN3100GTOnOMLaob9uIG3nCL01X3pgcIAzhXl9n0ge2AxSjWpNFQA4lfWDA6DALaOt+GAAjtIg/3nhVp6Wd7QqHOpjOl7uctLteWzJd2AOH/XF0M3bzxTkVX5ScCqj3/O5vvhcN9WwiDU1rbJjho2TZTnuDpXcXYJEQ95lm+gI6ylRlFroyDkgtcGXyjtyNoHMdeJcQ2Zx8gm2sCbS1CTCdqcJTtNOBl6ieG12qwCi403l+bZ85uZfIVQt8KDXEn/x1lYxT8XdOhw125+OfeQ9+olA1hXAN1utEyidflvPI1G71ViYFg/+0OywN1LTtrxnvkaUZFjAgn8KS5BE1sHTZvaPmIoPFfwcBKTyjfPd1EHOn7ye2SfXlC+c3okIM2sHAj7E1pBYvfITOru757dIGD1iKnGb/eJycTz3L49JSSe7Hz1026gy19Abg51A2H2S5KJR3SXe9mDr9OT7le9I07zg6nsTTCymLEi6aiex5sPt+F/F+cklZ6cCw88Gc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915345a1-748c-4eb7-7c0c-08dd1f316c5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 06:58:48.8259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Up5Jjfa2pO7BtkRWrR/eLw5kX8Kzx/LSqUIwFIBTws2uiueOx6qhfCuPq8VUGpR0UdbxnZq2JTqm8HOftwVUqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8872

On Wed, Dec 18, 2024 at 05:00:56PM +1030, Qu Wenruo wrote:
> The following sysfs entries are reading super block member directly,
> which can have a different endian and cause wrong values:
>=20
> - sys/fs/btrfs/<uuid>/nodesize
> - sys/fs/btrfs/<uuid>/sectorsize
> - sys/fs/btrfs/<uuid>/clone_alignment
>=20
> Thankfully those values (nodesize and sectorsize) are always aligned
> inside the btrfs_super_block, so it won't trigger unaligned read errors,
> just endian problems.
>=20
> Fix them by using the native cached members instead.
>=20
> Fixes: df93589a1737 ("btrfs: export more from FS_INFO to sysfs")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/sysfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Looks good to me.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=


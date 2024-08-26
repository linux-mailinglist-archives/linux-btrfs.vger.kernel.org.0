Return-Path: <linux-btrfs+bounces-7485-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA7695E7DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 07:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0AB7B20EF2
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 05:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35826745CB;
	Mon, 26 Aug 2024 05:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IFwiq+PR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bX1Do4Gc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3820E1119A
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 05:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724649616; cv=fail; b=WzMEIzr+I7NQfTm6UwPMpfsRxEPMehT2tsP0rFd2viBGpQJGPRKzhBwuKe0OzGDBfCBqJypEYOwPKivGU2nKusPru0+3Q1E/vQOVyjliz2gIuWZAcmlLIQng6pRrwsE3pBfFGj1/+lv/o5QKbz6/HHXOKWtYK/sqk2TIrHoz8oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724649616; c=relaxed/simple;
	bh=OHrkkLokQMwSEY8xkH5vQdlfHhzVFeaRr29NK0SVtWs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OJuuKot48X/NylcjTJh6/PTAWYzGsiqpbiTTkXHOfLLAYAa9h6Wwo5M29CtXuWMKm0vXV9pwVsjtrdrFK+zJKWD7WL+lcvZKg3hSigNhQem0CxzjIrvL0/ER2tD9g2MUbbQAx4wg/SeVeKZW/3QmN+3EnaVXZftjwMcpYRKNkYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IFwiq+PR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bX1Do4Gc; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724649614; x=1756185614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OHrkkLokQMwSEY8xkH5vQdlfHhzVFeaRr29NK0SVtWs=;
  b=IFwiq+PRFh0+7/ueF8/ErBjj87P3Cl3AyfcxTI4sREaINySvK9T1hWCn
   u4LkCfmoDwIyGGacWyDsgIealfep0NIFFW1SxfXue6ES+9IG6WjAK9i39
   VGjZkO4I6AcmBZGom0TIh3FHld7Mc/3XMQsQe4ykaCuRCsBR9pdgiD0Ei
   zrRO/I2VI/zOnU4f0UqbHzOFRQQRXD8wbwtFJ0CByw9yzu1vJMVQGHjfu
   uvSFST3psq9dyA2Akcp5Xuu758NnyUtxA2S5af8Vn5J7GO+wTRZQATTsx
   FZVqn6sdnoEh5XT9IohpVCUfYSyvg79sr9FT9wltt5IqDcnWnM7LJrgTr
   Q==;
X-CSE-ConnectionGUID: OJSkWZMVTzSzYhARZsTyIg==
X-CSE-MsgGUID: qaAS163fTvGabcM/cCK84g==
X-IronPort-AV: E=Sophos;i="6.10,176,1719849600"; 
   d="scan'208";a="25150895"
Received: from mail-westcentralusazlp17010004.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.4])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2024 13:20:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrSMu35e60smkfzfQ+g2yhPa8+qR2dt05blSGPowHWLp2dA1/z2bgs+V/mFNW72fYtZbX3ajPWGzBcSVGGiGZ/9x02FRQLQbmzzzdTuDzGqMsCoddNa1bzgegVfqxIfKFtHXDuai8Wc0yW+9vcPcZpSYtK9S1VyJEPDY3fYQADkaJt7dcDKKrmI0nsn9JxGQ1YCc5+V21uBtaX8+mkH7ymFaQPQ+lQ9/9ySrQTgEshO49BN+w7icxO91DYyN+/n02UZw4bEsuTzKSrRa4rgQPRbqQkqjNGKCG2vfi2ksRoPDVTP0YERrc7ovVXYx2vQp2iqw2H29sg3XYz15VvWWHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ik53wcSfDpVNCbAcGATVXRqJQFicF1+UWb01Bd5RWtE=;
 b=maYYUcnAuEtZiicvWMFQ/twN90+nJjHg97AjidohaFDlrk6WlHf+tXRBtGB8MFm00V+e93Ht4oddvi8XrtikM3dC8Gg/+z4YcAueBHVmnb9P67jB/BODb/ufXKvLGU6lI6gKQgZPugjqB2LIpXY4YRXmEDLx18dTidtuDq/cFyJYa+yvOxybC3KPzynM8NGr6GxXQjP74dVRRjl7PiAkb9LaN+yl+rAeta2WHPxRMBhi4KuU3bsmy3q2i2wISB8pejIxmyhcilP0V8qi4lmDp5cAKIP1ycjOngLTxcZqPEEdBjzphcfv4pdxqWakuW8qhOUoF1UiAHal0mrqXLyA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik53wcSfDpVNCbAcGATVXRqJQFicF1+UWb01Bd5RWtE=;
 b=bX1Do4GcDAsqjjS0V7Hp+4WUjQabj/7OksrjMwgs/r+9/BYABnrbNQNEomD7xvWu/fVTGfKs7V638fojjP7CXc6nph/5Jgs+Dx1Uhrp83VML6sBXSJwg38xpYSKfuaCV1tAsJqiGxzMuH/mF+6souEx1z9Q2rxEJ00yU4suZn2A=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7887.namprd04.prod.outlook.com (2603:10b6:a03:304::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 05:20:11 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 05:20:11 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Yuwei Han <hrx@bupt.moe>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Can't set RAID10 on zoned device using experimental build
Thread-Topic: Can't set RAID10 on zoned device using experimental build
Thread-Index: AQHa9prnheP2LgqlTUiWHNDi66kRs7I5AggA
Date: Mon, 26 Aug 2024 05:20:11 +0000
Message-ID: <xi6vsetz4ymtdyfw564e7gkdpdsqqe6xxvn2rujuchhw423vz5@fomt4llvviq5>
References: <65B7F79F09D5083C+d0bb90c4-ba72-4b8e-8275-9ee8bfdbd3dd@bupt.moe>
In-Reply-To: <65B7F79F09D5083C+d0bb90c4-ba72-4b8e-8275-9ee8bfdbd3dd@bupt.moe>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ0PR04MB7887:EE_
x-ms-office365-filtering-correlation-id: cfa045a2-4f35-4dee-47e5-08dcc58ec232
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Q2Ris2RZ4+ndlXIVo5ZOKadHFP0FsvqBIS89k18np+zOy+/Oy7KC97i87Edm?=
 =?us-ascii?Q?UxlBsQhQzegYp0jUM5OpczgLgM0P9EKnCE/WiP8SOuBDvv+VL9Spy4RCwBPQ?=
 =?us-ascii?Q?nT3vnlaqRvx4+24NprvmYz+jlXiy0/R0IVbULWTA9Kr8CcStFDNbsGptlCIZ?=
 =?us-ascii?Q?iVfBH4806BcrnY33b3EiyGnNq7GUSQzIIkt+2ldXnwnOS2W+YyJIYswWGqB5?=
 =?us-ascii?Q?mn/J0Vikia0knNBP33TNnx7L9Y0cZxP1jC68rC0SgRuylsBEJ5A9yXj7xTqO?=
 =?us-ascii?Q?HRzNp6OQEKw49/b/tlKpDNBeGlhrQtNAk4FzxWnurKySGieQOek173xXzkkj?=
 =?us-ascii?Q?HY+khX2Xrhf0bE4AkqxnzTvKal3wuNGw2CtWQjNnXRtS4lh18kf19U84LjlU?=
 =?us-ascii?Q?aGOUmSPZNgXSVmjJU1BE/d6t0XBPdqAX7wsHwiV8PUa4UsB+HmiICx/jS/bE?=
 =?us-ascii?Q?aJacvdyWgdmMbekeXps2g6AODbmudic2u2fA0/8uGuCksKT/LYt5idfVZaf5?=
 =?us-ascii?Q?ted3cJAf6u+3KbIB8/CmvlFaSj0UMJyuBHZHd38JZlGb88oVewGaKIH6ar42?=
 =?us-ascii?Q?qLWVyP+UnvjczqGINVG5+S2YFCGhhaNRM3j2Ol1cNld1deuj+rAsZgrEvp3U?=
 =?us-ascii?Q?bwOgNX48cTXesgtgHRyEH67zHt5o9PWYPOPWCwTdG6Py3vW2L73AfusOVwxP?=
 =?us-ascii?Q?e4JK6/qXyHQTusnVmgt+7R360BVVyNFpGUpMa0ZY7hyXmkDORAWGksE/3UXI?=
 =?us-ascii?Q?3+IHkyC5TYJ9+06resKJIHHkETXxctYHwzeO40/oOylHaEXMUTphP+g/ZopX?=
 =?us-ascii?Q?qfBEnDhrdNk7ZarxrMP+hZrsDb4KKI52kqi8Z1wtzUzFnJKP6pO1GF05OkDC?=
 =?us-ascii?Q?DGz8clMAWFd5kGJyO7R4zMbJEOV7LZRZXuO9DqQmldwzBHXWnOglopdHUCWk?=
 =?us-ascii?Q?LFd458Q8e+ozGS6wO2NLFfI8o7NtowLXgZ4KNA8/MdxV3itdUVwhqKtffuiH?=
 =?us-ascii?Q?6WNKVx2bTvm4Y4/CjBovo6crSPn9JPAjPxto15YfHu0yEGF0AcZIjqXYXrVg?=
 =?us-ascii?Q?X3JQGoubFJxUhOnp3RfJUxKAnsMFkgnwIKrgXsabtll71J/08/GRym63CVnj?=
 =?us-ascii?Q?/hAKDfda10Pt53nikWoj77lXEls3ihqYEzg+Xo65mXWK1NJa5BwARIIjkjSe?=
 =?us-ascii?Q?nbKCPu/GSd0uzqCC4mub6Oj+yJ6K7vP0hSTgIjHbT5l/5EzWrQSeebkZUNvD?=
 =?us-ascii?Q?qYcE0YTZVKUIEwIhtDx2oVDma/s5+6f6goClnFi+kegjGzkhHRBgmDazd4Ek?=
 =?us-ascii?Q?lQArNALfkswGCJ7LDYBD0qmGRUBApvpWahOUN2b3AMouMg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1HxncdTve9DjGb0aQJVQUsv4mVGFDMKUP9mBuHsxSiIvWZ7ADck42eDqXTQ+?=
 =?us-ascii?Q?+dXtqKvweLBKaKvEPD7m0RUw2ChkISHbWamNEvdigiwEHZKyFcjVKwFxWvXY?=
 =?us-ascii?Q?h+03h+fCEnIhvKfOII6qbgM9h1j6D6Y+GPY5iHbwBuG6HUzPT7xAPnmCZXtE?=
 =?us-ascii?Q?MAtel+jbcbbZ/xjSpMDqYaY+QyHWH50KS+KdPtzOFDVIiYG1iyg6O5xTq8QB?=
 =?us-ascii?Q?nj7s4rJww4mCe7UNpUueNJGNKbBOcoYfooS6i1QaxDuik9D0BUj2NybPnhG5?=
 =?us-ascii?Q?lwrGEniluyLQdAl2QbwH0THkIo+A/BUZp7OmYIqAVRDYTtCZh3sxSvX/cdV7?=
 =?us-ascii?Q?y5IS/424AbBBVRQnQiy7XWdR2AJso0YOZPrd3RCIPlri/SXvYobssFRVy6wP?=
 =?us-ascii?Q?hvBhvH1zN2hVU/PT8vgqVwxO0pe5W6vrJ5nuH8JVKC5hncXeTRSecIvDF2Zw?=
 =?us-ascii?Q?iW6XcO83ADNBatuvokoW763n7+plmhhX0lj884vjMZI4HHhLiyaNC1WrfXto?=
 =?us-ascii?Q?6Z1FD7CQXtteoBres9TH4DH/1hMahBOP6MHv/aRDGvoqW55QNUJv2drvbiEP?=
 =?us-ascii?Q?YC3RmSM9Hq44RIppqj4H9SE0/wgg7XlLxx4g/p737dWONGOCWODUJ2dQnRjy?=
 =?us-ascii?Q?NEZ1rIjG/zxrx/RvlfEpHdYZ7hNfmTkwB49HHtldyuZCrf254Pw+hpyumtsh?=
 =?us-ascii?Q?piOMtP4F5ZS2LcErlZj1hFrHxuuGS0a6hTKvWGlVs3J3SdiBImwDNh2G8WHz?=
 =?us-ascii?Q?42ZiY/CN/HyQ0UWCa7ErhYrNsyJ6S30dOF9SDVMNdaJb0x/4juy/3hJ/kXLv?=
 =?us-ascii?Q?N4v7qVxhLdMI14+d3t4wIkrhzTHD+hGoxJM6IFIAT3evMNHQc/t8912gSTAh?=
 =?us-ascii?Q?OGTStQgw1rn08X9SdW6dD+/o0VJ4nqlCXToAYJyKfUUEnAR+LaOFb6uXpEf8?=
 =?us-ascii?Q?MW+iCmbLs6eKyitsybKi34AhOda/d9XpOQmIJhbpUiBo1odj1roLW9yZodEl?=
 =?us-ascii?Q?iDUluYlwTtlDgiYTjRr31rrbBQuFZSNq2yrgpVfU8/+tioxVywvBXob9r5zk?=
 =?us-ascii?Q?crW5cWW3Rb3ouGS+Rz0DIU5SN3E4MxZKVZ1Jgi0agollacKYOJevsFlrPpUn?=
 =?us-ascii?Q?OW0Ai8Z7wgtFxB4QA9jjGXqtdW6WqgFBhyqCgOhisfP74u92mlVP0DM8dsBl?=
 =?us-ascii?Q?uQ/t7bZ9aDpj4DrVPwmnuXyq2DmjvXluY7J36a9532fU8OnwQCChnWJo6f99?=
 =?us-ascii?Q?FFYz5zvLlJ1T9XZcEiPLA2y1A5llQQOQNr4lXmVWvC9/5YNfBQ9w9VyGLUFd?=
 =?us-ascii?Q?u3TpL0g0wf6SbEdeDU0A3SVn1SD+WwS6sBhO2UgDRmTYmKB5RkyudiuY4YWL?=
 =?us-ascii?Q?/F6D3GJ1JaZYBNMgyrRmT0EBYLLyussRGXLnx2lm4hcWQDWI+Af0UnM5ELXS?=
 =?us-ascii?Q?jzjVdkLIL5Y1rJZ1n+z6wYmgB3z8sa2dO5b//bSy71NzQDdCr8UKaQmenKNn?=
 =?us-ascii?Q?d6qj2NkRA+yFL5dluI2Ospf6xR2Qb3uO9lmePHFSQCLRtB4/lSfGBtObkK8Y?=
 =?us-ascii?Q?xv+HNPITDqWxzlip/bbNKiygBjfd5ZHo/DZ29EEnVFhaFtJqFDYmDn/0HrAH?=
 =?us-ascii?Q?mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <77909681F73B4648B55A7D02B7898F74@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pw8naqslVWafUWRW1lOsnrltfCTt/7G43XoCiBuxW0jHkScsfqxTupjsV1kIJxp/70jeXnyCkwpOKLlWwagFiD42BTXEmkMIyvndWzgEE63XaDri8J4PWixOrH23GTenL1Fw0z1f1obrS8QW4k7LtMydOk1FxuQfn6gG7weRFqt/hjQiJRgM3Q5GQMDznQ21EU9sfrodLlbZkDSHYFLaj90UmlR60/mmfxWsqUqPNy7xaCYs5/YdZw6ziZS7m4K1cSLVQc3y5XNCPHI8QGLYk0+uEDZHU8UX7YZvHJvIfAodfG3mcgiP7HT/AtNFini7fE+1bQuS/3K7uR4zNoOnt+ESCDAvKRHehKqnYzUbJkfKpxtn4knPmHdYz4uPDpDD1NYf/uq9IAGsRHnC8sxDNwrEM0Q2EDtliu10l/4nEnR34Y68dxI6XHFWT0Hm/W9Jr0VVpzx2XU8HkSSnRy0LEoH7jTsDDb8pGSMKyYIZPu7pryrqFSkiFNs8Q74DyvQRZAyFPiiN/8RAC0PmuqsFhCMcG6PdHHgPdx8/AsOaRFEIP3VeMBvwKBJu9fjLQXoLqaD+7UwEYYbBUdcXaybB9SONyFwM01ogjP2jRFkTJRiD3x2mGpnyWhuhYYWzXfoR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa045a2-4f35-4dee-47e5-08dcc58ec232
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 05:20:11.3758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IBiu0zY1bU8Dr3QMfZbvYGWle5+TxORh6Nrdf2GPgE82LMTvpnli9Qdzi8H/g5siWE1JKRmo8uPg5J4IaSd0XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7887

On Sun, Aug 25, 2024 at 10:59:49AM GMT, Yuwei Han wrote:
> Hi,
> I am using btrfs-progs experimental build to create RAID10 volume on zone=
d
> device. But it didn't succeed.
>=20
> # ./btrfs version
> btrfs-progs v6.10.1
> +EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED
> CRYPTO=3Dbuiltin
>=20
> # ./mkfs.btrfs -f -O bgt,rst -mraid10 -draid10 /dev/sda /dev/sdb /dev/sdc
> /dev/sdd
> btrfs-progs v6.10.1
> See https://btrfs.readthedocs.io for more information.
>=20
> Zoned: /dev/sda: host-managed device detected, setting zoned feature
> Resetting device zones /dev/sda (52156 zones) ...
> Resetting device zones /dev/sdb (52156 zones) ...
> Resetting device zones /dev/sdc (52156 zones) ...
> Resetting device zones /dev/sdd (52156 zones) ...
> ERROR: zoned: failed to reset device '/dev/sdd' zones: Remote I/O error
> ERROR: zoned: failed to reset device '/dev/sdb' zones: Remote I/O error
> ERROR: zoned: failed to reset device '/dev/sdc' zones: Remote I/O error
> ERROR: zoned: failed to reset device '/dev/sda' zones: Remote I/O error
> ERROR: unable prepare device: /dev/sda
>=20
> related dmesg:
> [ 479.729281] sd 0:0:2:0: [sdc] tag#953 FAILED Result: hostbyte=3DDID_OK
> driverbyte=3DDRIVER_OK cmd_age=3D0s
> [  479.729930] sd 0:0:1:0: [sdb] tag#184 FAILED Result: hostbyte=3DDID_OK
> driverbyte=3DDRIVER_OK cmd_age=3D0s
> [  479.729944] sd 0:0:3:0: [sdd] tag#12 FAILED Result: hostbyte=3DDID_OK
> driverbyte=3DDRIVER_OK cmd_age=3D0s
> [  479.729949] sd 0:0:3:0: [sdd] tag#12 Sense Key : Illegal Request
> [current]
> [  479.729951] sd 0:0:3:0: [sdd] tag#12 Add. Sense: Invalid field in cdb
> [  479.729954] sd 0:0:3:0: [sdd] tag#12 CDB: Write same(16) 93 08 00 00 0=
0
> 00 00 00 00 00 00 01 00 00 00 00
> [  479.729956] critical target error, dev sdd, sector 0 op 0x3:(DISCARD)
> flags 0x800 phys_seg 1 prio class 0
> [  479.729960] sd 0:0:0:0: [sda] tag#597 FAILED Result: hostbyte=3DDID_OK
> driverbyte=3DDRIVER_OK cmd_age=3D0s
> [  479.729963] sd 0:0:0:0: [sda] tag#597 Sense Key : Illegal Request
> [current]
> [  479.729966] sd 0:0:0:0: [sda] tag#597 Add. Sense: Invalid field in cdb
> [  479.729968] sd 0:0:0:0: [sda] tag#597 CDB: Write same(16) 93 08 00 00 =
00
> 00 00 00 00 00 00 01 00 00 00 00
> [  479.729970] critical target error, dev sda, sector 0 op 0x3:(DISCARD)
> flags 0x800 phys_seg 1 prio class 0
> [  479.738363] sd 0:0:2:0: [sdc] tag#953 Sense Key : Illegal Request
> [current]
> [  479.747438] sd 0:0:1:0: [sdb] tag#184 Sense Key : Illegal Request
> [current]
> [  479.756425] sd 0:0:2:0: [sdc] tag#953 Add. Sense: Invalid field in cdb
> [  479.763338] sd 0:0:1:0: [sdb] tag#184 Add. Sense: Invalid field in cdb
> [  479.769733] sd 0:0:2:0: [sdc] tag#953 CDB: Write same(16) 93 08 00 00 =
00
> 00 00 00 00 00 00 01 00 00 00 00
> [  479.779152] sd 0:0:1:0: [sdb] tag#184 CDB: Write same(16) 93 08 00 00 =
00
> 00 00 00 00 00 00 01 00 00 00 00
> [  479.788656] critical target error, dev sdc, sector 0 op 0x3:(DISCARD)
> flags 0x800 phys_seg 1 prio class 0
> [  479.797730] critical target error, dev sdb, sector 0 op 0x3:(DISCARD)
> flags 0x800 phys_seg 1 prio class 0
>=20
> drive info: WDC HC620 (HSH721414ALN6M0)
>=20
>=20

Are you using a -rc kernel? This looks similar to an issue reported here.

https://lore.kernel.org/linux-scsi/Zrog4DYXrirhJE7P@debian.local/=


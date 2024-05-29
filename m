Return-Path: <linux-btrfs+bounces-5335-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3AA8D2BD0
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 06:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D431F23811
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 04:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11F715B540;
	Wed, 29 May 2024 04:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mMRdQEWr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qqGLa4hT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145CE10A35;
	Wed, 29 May 2024 04:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716958098; cv=fail; b=KezzggBR5m3WsRFrbOpAbsgTY+5nK/yB7vpf4HQ80xD0VlaTBwx9LWlvMeuLIYT0c2jSk6LAcDdNECyTjAg6zgBvNZfdqivZhLLHJgm3qi9mejfqZyHR9eRTsM4jbRYyfaC/rni3TfPHmzD/4iNuAvZIiCnCRwzKjcuGEVRJezI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716958098; c=relaxed/simple;
	bh=C233omRX883+VXWfbMLu7SdoFIXyG5kZhUJHVudKk14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fm7/hjl8YU1oqfiN5w2yTY3ysQcQn9oMc/PlWheMg7YshlgkdEDEditUVvSEsI6U+rxXz4JgzfT5Jzs6ixQD4jbS2+5RYKxwKIqbTwgaF3pEl9KsmcZb52LTalzVBzGmaST16dsa671+/jqNmZS2cdTGGj9wyuaSsTfOg7sfTV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mMRdQEWr; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qqGLa4hT; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716958096; x=1748494096;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C233omRX883+VXWfbMLu7SdoFIXyG5kZhUJHVudKk14=;
  b=mMRdQEWrqBqOlpyMdL/6n6Iw/T/zh1HzhXHZCyAFjLY/Q5RVW99H/W+U
   Bu8s+Fp/YCL8Mgmr2IF3CBrvpZiqg+21TqDZIeBqvMTmIOQ+d8hf8yw5p
   yxA6d3sbMpgPRaZBVPHfqyh9GufXKUvEWJC6cqHudcpNz2QEpCuBQYuTX
   BR8KXpuTeJ5SJwjc8Meu0xLXHEt6wVZt+/KRlpTGyJbWQECUC28BPNOaW
   kWLNBnS3SSJmYrnF6oAaruaFpZxTnfeTanpAHXzk+Z/3gKr70qRnD07Nk
   5XfE4x6jN+LdSQPyg7jqHTZiJw2XtBn/Amvof4iSxuzO3gjqMKHW870qL
   g==;
X-CSE-ConnectionGUID: exhDu6UJTx+zTbKcA9/KFw==
X-CSE-MsgGUID: R8x7lsipQouLSNE6WVd0eA==
X-IronPort-AV: E=Sophos;i="6.08,197,1712592000"; 
   d="scan'208";a="17261554"
Received: from mail-northcentralusazlp17010000.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.0])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2024 12:48:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YinLGfM13eAIDenom3CFk2V32gZXE3LJVqkJer9r+FVbgw6Yi7td4XXm6z+3GpnDSkK2OI9NeyC0/xYyUG/GF6bH7ZGWAK1FG0DtqygrI9u8eLKsdRkdG6VG7hQo6c3CdG8XadnXgFsio1fgXrySmQ1RJA6wNAaS4SVZ3+/D/PpRc5G+zdVCE2BtVckbWA7MJBBHEZjXd9AYfmp6aVZ06m0ZvD+lptc8dCjLuCPpXWCX0MEjjkfcuaQLnuCgICI+Vw4NfOUU8v20Co055tkrihqfduZ3UlvWQUEc7NY63zmx0fncQ+N7rscY6GwpMTEzNas1J9+ftwGxH36gk8n6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f59481KNz7OrMTITb69IO1djmGs1kDGco2d0sslG7i8=;
 b=dEKzyRH8jQAY/X0hMV7pPQkggGYjKFYt7XMIIK0ix8PVhAda8eBzUDaS3Eily/bcq9Y1ybAzW29Xpt00NmmfFMqMtOQJw7FkUmJqMx3Eqig4zlCU5gu+ZmWw46gVxUBoETAhKDyBjpUcW/MyvrCCgkCRza61m47MYrFPZG/EYEI3QN5y2zWYRi/fPckJoM6bkeHJvT6AIWAvAKmqVj1TkH2vD0gUP0Q7Id9qhbvunI4TYIztRMg4ltOnKkFhnr2ZrUaOO3zABIdoo3Sp/75/58GSJeFEe/qeQnQV9ZPFX4I+MRRf6OpR/ofD7ibU9rxnRKofeE07nQ7rv2i5BAwtTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f59481KNz7OrMTITb69IO1djmGs1kDGco2d0sslG7i8=;
 b=qqGLa4hTtLHWi0AycwnztNP3OpWGk+Ul/IN1SllufMNALJleLEsYO45gIfHpAhj23rd6Kng5Do3YKtWE/RD99+CHVjsBRJ/2RpkF8jYgkvIUMf2gTqKsW1IYHKn/eDuLlcp+VymJzIOXHoq0Ze20TZs/N3Amw4KoljvxSpIO1Ok=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by IA3PR04MB9330.namprd04.prod.outlook.com (2603:10b6:208:510::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 04:48:05 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 04:48:05 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Hans Holmberg <Hans.Holmberg@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Filipe Manana
	<fdmanana@suse.com>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v5 1/3] btrfs: don't try to relocate the data relocation
 block-group
Thread-Topic: [PATCH v5 1/3] btrfs: don't try to relocate the data relocation
 block-group
Thread-Index: AQHarfeLkjGaZXQgG0yC44Z1ASpAlrGtqtkA
Date: Wed, 29 May 2024 04:48:05 +0000
Message-ID: <kiiun4v7wp7ioo6rj7wiafmx3m7f3s6llfp2qa5hcahf7p4o5f@xrrd3swmgal3>
References: <20240524-zoned-gc-v5-0-872907c7cff4@kernel.org>
 <20240524-zoned-gc-v5-1-872907c7cff4@kernel.org>
In-Reply-To: <20240524-zoned-gc-v5-1-872907c7cff4@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|IA3PR04MB9330:EE_
x-ms-office365-filtering-correlation-id: 206846c0-0af2-4bb5-90d3-08dc7f9a877e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bCuMtHZng5ewgoVFJZ4OwLNcmvC7r4vCsD8lDwOaaD5vR+P1WWQJrTMjurBo?=
 =?us-ascii?Q?QfYsWQyTFxpugpF+cqvKZXjSTZvvxU2H2OFzQ6oFjDVx7P4AwmvGQlOdaJaC?=
 =?us-ascii?Q?gEJe7eFz3UFGpw+8dz1Ky2UtmrslhFAV7VD/SBvnRhxOEPrq93prmSoeO7l/?=
 =?us-ascii?Q?iU5FCuVYQljVozDbbmtTv0dDFzTQTSTlgPrhLIHCZybPiV5bk3ZWAohkyf9o?=
 =?us-ascii?Q?avFhdqG1m+LXATl8LNLxK9jycAY00ZfbedhQTjGbM3qsgcSxU4oI4QXx87k7?=
 =?us-ascii?Q?oe5mGJtNfjrk69TiaOmVCGqLpi6i36rzd03G/jcg6pSh8D4/lBqDh18FHRWI?=
 =?us-ascii?Q?cqRL1dwciJqv7oPi5jA+aVYZEeIN8AyZ0S5jQsi+iMjDd1lDAcf/tHOXXGFR?=
 =?us-ascii?Q?80J0tUjwcSMtC7VY3gn+NsiO95Nar/Tj2hNsGSJJbvAMz7X7HNyU7Mc6qlPl?=
 =?us-ascii?Q?t/AAGFZ+8TOz+gjcWjemHlgWLI+f47+WQI2YkqTAutSAnZ9BXkGYdEXbFH91?=
 =?us-ascii?Q?kasxWy9uHRyvqxYAqUOSC2/gNS/W1otjMTYjRlqxtnav7hsNCOlyc3qYt6/N?=
 =?us-ascii?Q?MY+HUAV8PLJ6NPmImqJMfW3lzqHJaROpnKOr6jteS+cg08P0WFsR4zu4TbwM?=
 =?us-ascii?Q?zekxYjvH3nb/whHaNvGZOCWwER0t/V8C14xxB3ClVQU146fw+713GEA2KFL7?=
 =?us-ascii?Q?Onth3ttmAjDV2INUdCS8G9wSq3pAU6IpkHM9ag6YfBMuqOK4SFCoOiIBpOnq?=
 =?us-ascii?Q?5wT99LOA9KW7ZqetLQo6cMCb8I289vtk2PIJzptCa/YlVodba9wAT2cqzW5d?=
 =?us-ascii?Q?WODfcHTI+RYzZyv4vtpqhF/2dlj4VfYNIeL7UkLkKwSSIAsgXxblyNm+GWEX?=
 =?us-ascii?Q?ANDETHS2GR2z28jtY99QUuDKVwfY9GvAvc9f3SMi57doQJ1DOvSJvKHiwzCW?=
 =?us-ascii?Q?ShzP2mLVylVlswHIwuAvCVPBvZ5rYiRE2aS7msh8aw788nnSimqqLUkb5RrP?=
 =?us-ascii?Q?3uiICdtvXPeVzGRbiQ0qJCI496+oeWhKIUzrvgxMj9DJHlZPaVZbtg8l9Rfv?=
 =?us-ascii?Q?A7X/v0kgYrtIfS3Nc0fgyA+rx77LnAKpoKbEU8hZbn7XRSOnZyxQQNv0lWba?=
 =?us-ascii?Q?PMhLIdGrzV2eJUkNGasgl+R1BA0kfjKlsB4zhn3/CbS8PYM1bFD12xH2GePu?=
 =?us-ascii?Q?A17xtWNZbDBVNBkbgfaq+vYUXilx4xouYRYQw4qpNBAQHxfPw1q+oOtJLETq?=
 =?us-ascii?Q?PRQfvoKlfd0lzi5AdN1YEOlr9Ip2SU27MD5skKKYqKwmMWZrQmD1EMgEbsfv?=
 =?us-ascii?Q?Y571U1DhHQDXZQHEbzSEeT5BJ/4mHR5LnP7gF9Z0SXyS+A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rfJbjpfXAMM2r7ucCyFEUnfrP7ztWBkKs7l12iNUmroKspoBp82HRK6UFYT5?=
 =?us-ascii?Q?5Abl2JBXFDd/+CoP00QwxUeGBmGd7wVHL5CT6MIdpD78jIwLuPkxiuThvfRB?=
 =?us-ascii?Q?FvOu+bKbV9ss080r9koSNy/mv1lUG6veJzUPhX1/UHUKas/fpEvrObDGPLo3?=
 =?us-ascii?Q?LPT3zkp3nnTFpFy4qgQTDoY29CFzAVil4RnfBAPsMycQAT3mRS2EcpZAg4FA?=
 =?us-ascii?Q?vFSy+dECcLpQlsRPfglc/oZRwAd+XizkVLdpGnj+oBwfduCqLV5x0b/k2BWy?=
 =?us-ascii?Q?QT2hkby9sb8cn8bW0zTBhQtsww8RcI1NRkrbOzPti3WRe8kbRRGXMf7gh32A?=
 =?us-ascii?Q?QiJED+qnonMXx/65s3uAWy4v1EPh4KYlKhGSEfySyM/3VISA3TYndqVlU1ZY?=
 =?us-ascii?Q?2xGmPAzNpCn8Lf49+ilId0zHqBnxDLUzqfda9NH8QTTPVsrBJsclrfFI0c4f?=
 =?us-ascii?Q?TBuLbg1CF0bVCp5Zb3aPhIHhn2l0yKjVPZ3VrNuUA5YKU6keMpVGtOMGEdBM?=
 =?us-ascii?Q?aCtaGeWc3fRY0ND55rWNB3ZdqSI2yIFElncbWpPw2ml3x3H/0/zEwG5+pqGD?=
 =?us-ascii?Q?mdrMXMVdQuyvYVE0Vrzof8J9pNLdPcqUQSdhrccYe3lYTPxtdJLXhTJO4H5J?=
 =?us-ascii?Q?5tks0Po7e8Q+YNKYTv3aqk97PeMP/KJjUwr7jHG7QqK91+X3s4lXnMMfOyr8?=
 =?us-ascii?Q?nb/S/HXwavpmXDxYim1H+PdT/NkIBBkvBRsDgpviRGOkYKEOXfi3ggh78VPY?=
 =?us-ascii?Q?epCifkNHNg4BfDAe9zDD6hMNmwHvOuWVyEoasEY4cdzuAscVj9Jf0ldJqktM?=
 =?us-ascii?Q?PVSUJ5mn32WfobCoJzzuXCf7qDwBOAWrSZUvCYTzR3wFizenlahF432WmEQy?=
 =?us-ascii?Q?qDkN/cCWEx2hjhsaGEFMLD3X2Fo0KhmQopEo2cWWCz5LOIRG2Za4EXJL68eR?=
 =?us-ascii?Q?IZuDPNGAZv75oP5+nyOf9CqTFCiiWOExpVkq05Q6p+CnnsmsaFpXua+yhXf9?=
 =?us-ascii?Q?SIR4EJSKS+hnH8Thg/Rbqr3NUSxprUZaB0L5a0vFi7+FdFz93pPXqgZQYTFh?=
 =?us-ascii?Q?xK82HHKvvWK1eW8Vniz63leBJ6CV2CmEkCF1TUBMxS/8ilhMJ8adgX1TgqRz?=
 =?us-ascii?Q?ZodiKFDnypZdN4vwe03hwZnuUbvKs//9WGOA1B90gBPoDPY+XoKxJVxOazS+?=
 =?us-ascii?Q?ogTJzzxVFJGpzYNEqljN8o1H8X6Ik/4XgLLhAdICP09vzoCdCoEHbosj2YZg?=
 =?us-ascii?Q?fbq0+SniOUdbOPwCCw10l6MZmeb4rPEc/eks29Itv1XJ8YauExEVmzywG70t?=
 =?us-ascii?Q?qpICzOjvz4e0zdUwDT0+0KSFpBe/6rwNDGbdHTp/aPMAMri7He+T6QtmOcow?=
 =?us-ascii?Q?yW+bnUOKWjTz1mSoefyOy678MZuskRGOhMVdXknO2obZWemUNN5gWciDTNoe?=
 =?us-ascii?Q?mhRAqsI4VcxOUz7sI6M2Ak5Z0qaaXm7WdAkfkBG9s8xZkF4UIr5m2qKtCHdz?=
 =?us-ascii?Q?M3vLPt4wE33zAgkXhf5/AfQT5wHopYFd62bsm/xkIZlmQxIdNBPHvyfic9yo?=
 =?us-ascii?Q?jEJt883Z4ceeC3VdHhC9848fByM45WJXFJKs7jZb5G8do0yyDZNqBAo2O/to?=
 =?us-ascii?Q?EQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E0F55C654AFDF43AA942475F914E67E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nl96DWfGKz9/s7QQL4z++d7YATXIYYLMG9rT/gY3GbWD9gNEcXnKNNv/fAPq7h9/tZQsZRSxz24yYUHgYTVVmHapPl0u1Bgg7DUG9LhSXnN3Te8GgNw5yiiyJlIZxORlcuy2+ezuthydvL6vtUwx0/wbQd6mhe+ve9u/1ouyVDEzS+cWKWFlCZOm7wVslp6KuCrs/f4fhndykvA1CnMddPsGBKPn+k10kbzCY9bSk0D2LZtmN/iTPuAQtk+d/7JJJaOCqr27S58I3ln1FyG2HmNfJ7Gxj6KpOcDEP76i7ZQKhz1MiSEecpOvkvE2phoP/nJ6VLhsoh0Xn29uR6rAPUWXDltv6Wx9MEnll2p2bBciK3xbJ6Ek/q0PV2G10m6pYyr+hlOLQ0hb3a9oXrip159a2+EOQv5Mzo0PmaF6FQKDCh8CwM+sUsuXixFmsxUyQ5nvBEwy8EWby/8g/NtbxA6ll9ux5wEoLqIixaovFa3yy63vXzFlGfcLkgC3bGdjpfyr0zFhj36mMs8X+DzraVU0TcLEOmdWq3thheRFM2D830Q7NnMhXPm1svRiOXeachs/RRZJX5s3tWds/SNA/e4UuK+KyqyviQmen/9incp3eLyF4Q1JT036h5SZ0kpQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206846c0-0af2-4bb5-90d3-08dc7f9a877e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 04:48:05.4301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LLXNQef3YMSmtqOiKgcjnaliuA0AdCcqqIuMxpIwUK1t/J9MWkqBRckCQ8i1YW1sXNrFGBYhl6yJIF2RfYZhHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9330

On Fri, May 24, 2024 at 06:29:09PM GMT, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> When relocating block-groups, either via auto reclaim or manual
> balance, skip the data relocation block-group.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---

Thinking of this patch gave me one question. What happens when we manually
relocate a data relocation block group with a RAID-type conversion?

prepare_allocation_zoned() give the data_reloc_bg hint which points to
pre-conversion RAID level. That block group is rejected because of
ffe_ctl->flags mismatch. And, find_free_extent() begins its loop with
ffe_ctl->index =3D (post-conversion RAID index). All the BGs with that RAID
level are rejected because they are not fs_info->data_reloc_bg.

When ffe_ctl->index goes to the pre-conversion RAID index, the data
relocation BG could be selected. But, as we reject a SINGLE BG for RAID
(DUP) allocation, that won't work for SINGLE to RAID conversion.

The loop will eventually end up allocating a new chunk with a
post-conversion RAID level. However, it is still not eligible for an
allocation because it is not fs_info->data_reloc_bg.

This question may be out of the scope of this patch. But, that scenario
should be addressed in this series or another series.

Considering this scenario, I'm not sure just skipping a data relocation BG
is a good solution. It will make it impossible to convert a data relocation
BG.

>  fs/btrfs/block-group.c | 2 ++
>  fs/btrfs/relocation.c  | 7 +++++++
>  fs/btrfs/volumes.c     | 2 ++
>  3 files changed, 11 insertions(+)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 9910bae89966..9a01bbad45f6 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1921,6 +1921,8 @@ void btrfs_reclaim_bgs_work(struct work_struct *wor=
k)
>  				div64_u64(zone_unusable * 100, bg->length));
>  		trace_btrfs_reclaim_block_group(bg);
>  		ret =3D btrfs_relocate_chunk(fs_info, bg->start);
> +		if (ret =3D=3D -EBUSY)
> +			ret =3D 0;
>  		if (ret) {
>  			btrfs_dec_block_group_ro(bg);
>  			btrfs_err(fs_info, "error relocating chunk %llu",
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 5f1a909a1d91..39e2db9af64f 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4037,6 +4037,13 @@ int btrfs_relocate_block_group(struct btrfs_fs_inf=
o *fs_info, u64 group_start)
>  	int rw =3D 0;
>  	int err =3D 0;
> =20
> +	spin_lock(&fs_info->relocation_bg_lock);
> +	if (group_start =3D=3D fs_info->data_reloc_bg) {
> +		spin_unlock(&fs_info->relocation_bg_lock);
> +		return -EBUSY;
> +	}
> +	spin_unlock(&fs_info->relocation_bg_lock);
> +
>  	/*
>  	 * This only gets set if we had a half-deleted snapshot on mount.  We
>  	 * cannot allow relocation to start while we're still trying to clean u=
p
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 3f70f727dacf..75da3a32885b 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3367,6 +3367,8 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_i=
nfo, u64 chunk_offset)
>  	btrfs_scrub_pause(fs_info);
>  	ret =3D btrfs_relocate_block_group(fs_info, chunk_offset);
>  	btrfs_scrub_continue(fs_info);
> +	if (ret =3D=3D -EBUSY)
> +		return 0;
>  	if (ret) {
>  		/*
>  		 * If we had a transaction abort, stop all running scrubs.
>=20
> --=20
> 2.43.0
> =


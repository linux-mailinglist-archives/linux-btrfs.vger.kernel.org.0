Return-Path: <linux-btrfs+bounces-15035-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04E4AEB409
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 12:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A3A27B73A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 10:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C5D29B239;
	Fri, 27 Jun 2025 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EMEZwLCa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UI1f91KG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A2F298248
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019057; cv=fail; b=IK8mPyTNumoKX5yCYD/P2lmp0vH9lflC00h2CgH1Q+nRd9SNnyT10ciXHW3SL9G0d3TqgTi2iiErUiblf0+pcjDF6xvF0SPBHpmfqyMB0XIQv7OmUHfNSb3kUtNZl8rIguUWwykC6BLvVet8WpO2fCPL9Qb806ELgAmbqipzqkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019057; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B4Su/wSkl+9614Sn3Wtxrofgps/dV6miXm7nm8xEThTxjP+JcXMSUTyZjtXvzujbtZSGBRktA+7rT9x98IAwqEGaHZjcWS7ic0zC5SLk2+0f5CR7LFBWvS1FYHoZ7dAVDx529qp49jAKr8WenUJ94orOxeSG7kp62GX4Jcopr8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EMEZwLCa; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UI1f91KG; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751019056; x=1782555056;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=EMEZwLCaqjFoh1Rje3e7KVgYwy58G3V3BC+Z8p5wBsiVlDyvL1ZGl8V1
   gwj8OUkaTY8vTxKlQhB/DMcbD77cNfulcV0IfuavgRboGHQfL2O8YDpvB
   7Etst361O8dGRRbdAfXT/Xq2XB94Rcits+34tgep33e3dqxEujfzpvuDu
   vT3WGpMCUGeaDMh/vzebyJO2nvlqy/6+lYn+1u9aE3H1jD1U/8klF24AK
   GEseeCubB6yAGWzHqJLFi3db1etAOvLilJdOgWqzDxivZgR49vlarIJKY
   s+9QqdaLrQQVDsZuNJP7NbSvcBJCF29A3WoMRIXmezVD9+9Hbdq4b345v
   w==;
X-CSE-ConnectionGUID: P/ZJ+qeiRUKpwduSLwk2qg==
X-CSE-MsgGUID: vs51pJASRoSQbrIGDXre8A==
X-IronPort-AV: E=Sophos;i="6.16,270,1744041600"; 
   d="scan'208";a="86089680"
Received: from mail-mw2nam10on2087.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.87])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2025 18:10:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzcOk2SmtSDT/CZIT3lBEe1PlodrZNN61l7YKB2gppvq70oM907UdZ7eUYa9thkV9pQaD0SlriPh5s0hOgQS8zERHofhrcYfYlw1EPdklF9C2Gp/n388ozHbsWag1e6FT9VvA6ZJIIposPCX65fsPcAuEwstk3I1/xG8YA6l31Gv07ZtS8Wn5rhWNb1/EGk514PR/nnvyk0jjyvvd13YBf3Jc2lnB/5COX5eEoS6iCw6uwOqSPBgozygoMB6D0iTDecaqL3uJxGcANq+bKThr+b4m7eUz7f6XVaygmWRMU+1eThb4IIBRS869i+mlphdUrGZChQjibmVxd+l4NHALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=Et/LH5E5NtmN8yJbFTnbnQ6sFsal2gCS8+wmvxkG/9ChHKV3BV/GA7u3qVI6tvtyJ4MXPo4xhuOhHztryFwvSTDKvwF/pBugOIIaEGhJknb9L3/aPDqcObCZztO6TyppwP6EDf9ywjaLizOYMrZbXiI0fMOg0nn9EALB/Vx7DPeQZcM952PGGJP/W/k15YYsK26r4qOEvExFNzpd7cIAKUs5CjBuYKLTSUZbNMMTB9z0hKGF5jYLXmmwbQXnH6ss+3m1SIxDz29nxqExLj1ElhRtyqauhSxIY5J2KQOwMegJ2EkeZIflgvGWKxFlXuYI5za8N3+KzBO+HinouSLFcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=UI1f91KG8QnYbv/0Po+bymTnwWI9fTTZ/22e3Bkb9Bgidew5lk1Ie1NOQ/yLo9BtmoYW9n+7AvZlLMTr/Ysf8aGRKUEzW7++Qy6LPbS4QfqJD2AOFZ3rfoz86Xy09Ov543lA50EXNrbnyLwTAZpEKVC4vL6um/49mDosepoGpyo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6654.namprd04.prod.outlook.com (2603:10b6:208:1f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Fri, 27 Jun
 2025 10:10:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 10:10:46 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 07/12] btrfs: use inode already stored in local variable
 at btrfs_rmdir()
Thread-Topic: [PATCH 07/12] btrfs: use inode already stored in local variable
 at btrfs_rmdir()
Thread-Index: AQHb5RgGZ2D0VjNCj0WSVdpA2vnJebQWzU2A
Date: Fri, 27 Jun 2025 10:10:46 +0000
Message-ID: <9c9fd6e6-0298-4e2a-b421-8ec7205542b9@wdc.com>
References: <cover.1750709410.git.fdmanana@suse.com>
 <e1789e1dbfdb73b930d74d6eae8b728d8241cabd.1750709411.git.fdmanana@suse.com>
In-Reply-To:
 <e1789e1dbfdb73b930d74d6eae8b728d8241cabd.1750709411.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6654:EE_
x-ms-office365-filtering-correlation-id: 80b5de40-5d7c-4dca-c3e7-08ddb562e222
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UlBjamNPR1FDREkwZlY2UDZxQ1YxdFZ2b3dLY2hmWWhqQ2Erb2tKWG5PTW8z?=
 =?utf-8?B?K0REdDdibkRNeDBsS2pvYjJZUHZVdE1obDRFM0RDMTJPR2lwNW9nQkovb1ow?=
 =?utf-8?B?NkMweHFmV2tJTVhQUTcyYlIwdGxKN1RnMjNqc1RKbXdKaWRudkdIT3RtOXhx?=
 =?utf-8?B?YkV3dm05bzZxb05taFBHSFRQUHh3VUZ5b202QkZ6dDN2YVJnZjAyMjBjcmNR?=
 =?utf-8?B?WkIyayswOUxNN290MjVzSlRtVHpxeFFyblM0NDJVeHF1ZnNEYXNCcDR3UytG?=
 =?utf-8?B?ckhhZXlBN2pyU1VaVHR6R2tubVg3L0w1Q093VENWRmJlQnFWUTFvMU50UFFH?=
 =?utf-8?B?SndtT2dkWFJIUEdDY09oUmdPZFRIaDdUT1J1OHE0LzBJMjlWV3pWYktlcG5H?=
 =?utf-8?B?R2RMczByWW8yaHUzaHJTUGdvNzhlUENsR1ozRWZJb3cxOVpMQ2F2bDZTQitS?=
 =?utf-8?B?RThCdjY5MTgvNm1yVlhFQ29PcllGalV2RndESkxYQmt5M1AyNmZiWEFwenZI?=
 =?utf-8?B?RjE3c2crUEUrbjdsWGowaGdqNFJxdFptNG4wRmMvRGpibWp0VFY4ZDIvaUJU?=
 =?utf-8?B?MEc2QjgxZ2tyYlRqRElZU3haTVRsRnpySmdQdVBpUzgvK2ZWenVSV3RSUFFo?=
 =?utf-8?B?WjRzeGgrejlMMDN5UlE4NDcyMlRUY2MvR3diL2kwMVhQVkJzckZkSUZ4dy80?=
 =?utf-8?B?b05BVk1UcXVkKzBXRU1qbUdxY0ZyVlFLV1UxenJ6NWRET3NoNElZTUFycHVJ?=
 =?utf-8?B?ODgyMVNjMEJaMG0wOXZYM0tqelhCR1JSVDMvMVZaNjZmNGFwdG5wNmxHK0tp?=
 =?utf-8?B?cEo5a29CK21wM3Y2TUk0Mmx4YWFoNjhLVXpDQ0o3UXNnSmNXdzBPaVo4eG9i?=
 =?utf-8?B?YzY4dlRXdTFPajZXUllnZ05QU0VPSlZaNlRKZ2NWelZSSGNHS2M5NTkyZXQ1?=
 =?utf-8?B?cGh3VC9NWW8ybmJXQlVlREYrTkJVNFNseE5TM2lhV0REeVFabDVpdTdMWFpn?=
 =?utf-8?B?VlU4WURiaURHR0IwMG9LbG1Nbk1BRGU0TnBOWHZvWFkwR3djVXQ3MVk4ZENT?=
 =?utf-8?B?OWlvWXpaMHNCd1NmTjhyREF4VUxxSjk1Wk4vb25qVThqbllIeGlxTFVBUzVx?=
 =?utf-8?B?SDJxTUZxNXIwclFaZzVEQ2Fja0Q3am9wU3BzelhZakFMRFk3V2JWYmN3dmZS?=
 =?utf-8?B?b20wdWwxbExsTG04cTdEQm5hQ0tWMVE0ZHhQUWpkVjZ0UFFnYVFBRVRiVXds?=
 =?utf-8?B?V0Zrejg4WllxMGV2bllRMWp3UmtpdlorQ25aRFpHdFk4b1NDV2N1WG5mSnZU?=
 =?utf-8?B?ekQyRkdXZTZjdkpqMXp6RDJyc0JCdEtaS2pYelNiNzFGWjg5ZXhpeTdxZVRp?=
 =?utf-8?B?OG5Nb2k1a0s0cHcxN0tyeHZOV3p4QmFqL1MxandEOTZpZ1YyZFZTTTc5RUxQ?=
 =?utf-8?B?ejFsNk95VmVBWGJmcVNiS00xdU5YRWtoUXlKUHhyTFhsaElEd2ZuM2E3aXFJ?=
 =?utf-8?B?QzVJVnAzT0t0ZTJ5VlhFSUx4cXY1Qi9ybi9tQjdxSy83UWp0TlBWMkpQS2l5?=
 =?utf-8?B?RS9qVWZuTHpRVXl6WE90dVMxUm5ycE1MTlZ4LzhRNDB3YXlTQkgzOGxUWjBo?=
 =?utf-8?B?dS9wQjFQUEpJZW9JcEI3SWRybm9qTGlUN0FMRVpyMkpmTDZNSThLaGdRWHFa?=
 =?utf-8?B?amtZZUdCUzRac2xRcy9hcXl2cEhkWS9tVkJvbXdnUGw1WFlhR3BEOVBkNHV3?=
 =?utf-8?B?NmYwR0tGbnM5aWNFempzYkxQdDl2NXZzMkJPTHEwZFJtajFsMGxJelpJVXdZ?=
 =?utf-8?B?VUNrRW1GZXVORXl0eXprSHJwK1UwdVNCYlZ2NWxKZ2k1MGExSDY0THZFRXdU?=
 =?utf-8?B?RVFHelk4NzVzOE5GUUd4cDh6ZFdLMmZHVi9oQmtHVWZlQndpTVhzSXNFWWZM?=
 =?utf-8?B?SitxeUVaMmhFUDh1YzVUOWloR2NmN0tJWXFmZVdDaThzM3R1UzI2QVVUSUNr?=
 =?utf-8?B?aXFrZTRFVDRnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWdsTVRsR2JIOHBOZjlPdXlyUEg3cmVYU0Y0bEpSVjF5aWtQUTVxVGUxUE1U?=
 =?utf-8?B?VzV4Zkw5OFZqN3pXbzVnVkwxNU5nTzQ5dUFsNFBEa0o2bTVwSGtneEkrYTNx?=
 =?utf-8?B?OWt2cFkyWUd5VVBqNld4cGJGMjZxYk9LMkVVMndTcnhVTXY2bUVzbUV5azcv?=
 =?utf-8?B?ZUtHU0l5dkdrYXFtbWozK2xoSmlKQlJBTjRoY1RkL3BoL2xOeUxEQm93QjhM?=
 =?utf-8?B?SkR0dmI4NngxOURkYnhML3pFRDRVL2xTQXF2MXFNajlyZkNOWnAyVERIOUtX?=
 =?utf-8?B?TXN5YUJMQWMwbVBrMytiRU1vb2RKMVAzWGRidWZKRVRlNEFmNFpOVUIyVHJ5?=
 =?utf-8?B?UjJ1TzJKVlVSTWhzMUdXVXA0RDlrVkNRYWU0M2VjUUZQRjRJWHFlY0lrZFlx?=
 =?utf-8?B?aGtvaXdDUUo3T1k2akNVMnJJOE82bmpIZ2FxN0pxb2RmUlg4eURPT01xZ1Ur?=
 =?utf-8?B?eFE1SUdJOXE5U3dlVjZ3Q3Yrb3BWNHYvTVpQQTljNWZWUHhnRXZkYVJ4SHdm?=
 =?utf-8?B?RGJlWlFtWnN5ZUZlZWNzN0lPemFoU2s1bGNEVU8yZG1QcXpYc3MxNTQvektQ?=
 =?utf-8?B?d29Cc1hzcllqbUhjSklOVjBDeDdWd0I4c0g1WFRob2NqN2dIeDdYYVAxcXdj?=
 =?utf-8?B?TzUzTjd5N3U2ckd0TnhrSGEreVJjUk0rMG9uMTE3NDQ0RHhVbnRuQjVSbXdT?=
 =?utf-8?B?NlRDVm1VekNINmJVWTF1RjB3UWxkcVltbGtVV2FlcjM5dEtVM3hZUHN0U2Rt?=
 =?utf-8?B?WW1TWTMrbWwrZW9zZm0xMEQ2UWVmYzhrYjJBYXNVSDQvcU9ZeGZMMUI5emNj?=
 =?utf-8?B?cnFVc2d3c3JSZGM1MW1UNGlmdlVXc051STR1ejFTK1NhOVZodHFDU3ZEM3R4?=
 =?utf-8?B?ZWE1YmVjYUxTYkFjalZpdG9EZDFaZUhwOURHNWw5WGFSeXVabjNsWHpSOWZH?=
 =?utf-8?B?N2JUbi90b3h1ck8vSks0UmxOL3lqUFREVjdvejB1MjlYeFNuQXg4YmRsZkhx?=
 =?utf-8?B?MHEvL3FKSGVETUFVNmloZE54MFBncjAxWWtBdVhSVmJaQ2I2SFpaR0dMQytV?=
 =?utf-8?B?ODlvTjMyU3JIQytNNUwzUTBGbERNK3YrbWt6MStNRXZDOUdCUVkrWHlVZThJ?=
 =?utf-8?B?MjJNQ2hmakk5aHBicTdOdFg2WkdKUWhSdnhzbkVrREFJR2FpeUJpeHh0T21j?=
 =?utf-8?B?Q0huWkpYeng3RlpKSUoweithb0tlcUFnRzAyVjZWQ2t6WU1vUEZjNTFsL3NJ?=
 =?utf-8?B?YUE1TVNra2xkak1hdk9DZ3RGWnl6KzlESUkxR1hwS0FQR05HRzUrSTBSaWpV?=
 =?utf-8?B?WVhxRG8weFlqWVRpSUlGbFlzSnlIbGVlbEV5NkhmSmt5RzJFaVlsNnE1NS84?=
 =?utf-8?B?dS9FVGUyM3dTY2QvWUtyTWV4MmVIME1vY1BBNmVNbXhTbWJvVGhGNm5EZkFy?=
 =?utf-8?B?LzRadDN4Zjd1bFVjV0ZFeERlWjRNWU9wR0RCSWxyZTZVSDBxQmpZZlNNRHJV?=
 =?utf-8?B?RCtPQjNBRXhXdWI1OEFqSVIvbnFLS1o3Q0pYSTgveWFHcU0waGdrbHR3U2ha?=
 =?utf-8?B?bk8reFhlbWYydHVMUmpHV01kZkRvc1VvWVZqRS9lRzR4MzRYa3hyMi9tcE54?=
 =?utf-8?B?cjhucG1UK2lvc2xtZmJXUEJBZjNrUVp6VHVHdDQ4NkN5NUtidXRxblJwWkNh?=
 =?utf-8?B?Vld1b1NCd3FhSkh6RUhuNFhlV20zWndlSmI0cmQ2OHNsRVd1dkdaWlpqZVhk?=
 =?utf-8?B?ZXRNVHd4YUw1QWVocGdUSVVxSGszNVo3WUVpRkthZ3lUckxPWEVNSGhmVEJq?=
 =?utf-8?B?TElsQi93ZndzWDBSV3ZFN2JtcGRDQXNRSEVVV0ZsZ2lKN1YwbVU1Q25UNGRh?=
 =?utf-8?B?dGVtNzV1dE1OSGpjTE5zZ2k0WTgwUkxCd3NCMHNaNHBYMkhDTzJRZ3l0THVO?=
 =?utf-8?B?SjFMNThHTDFyVlFOR25GeFpVdGFlQnF0aDE4b3lLeXh6bFU2R2pTVXNRMzdw?=
 =?utf-8?B?a2xFR1MrWGdTazAraWVYaXBHdUk0NmZKVk5VUTZtSTM5d0l2RjVSWG45NTJr?=
 =?utf-8?B?encrdS9zQkJQUDMvZjlkSUFNaitFUHhxa01YU1g0Qlo2REQvSmNpTFhraW9W?=
 =?utf-8?B?RExuRldaeHpYbk9PNVpQQjAzVWRncUMreDlOLzE1b1ljS2lWSUtWWENSUTF6?=
 =?utf-8?B?MGhBUjdiNmczZmEyTEVGdjUxQ29rK1drM0gzRkEra0I2SDc0TnlVbXN1b2pF?=
 =?utf-8?B?NTYwMk9oeHo2OFVkbENTMGpHY293PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AE3D24840A23C41B8A6221D8F970EBA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	13L2m8G9KDH5SqO5gdGM+U8gIgZKV6JYwp4P84h1pnYoDt+NlqWFDrndhK2JtWwf96+tx65bA7sWTEYN17rhEQPcaequKZbACrQDNn1aPhyvkhe/cvZIwRbziN9KHaSPEqW1IVQ2+qULPF71y/iQXEgS4jmUGVUeXWwdo/T/9vPF8b/r3+Dgi5eByK3MhYL+H24X0hKw8iJoaHHbQB2KrBeOc0hcT7n8MLX2DBaAJXdpKOnjpWlRpNPT9ap3vuVmW6GggxvAZbtNbNdHEJg3WMFewT693pfSfhKMDLGiCg+9kYbTlz+lDpurevXc3/wpYS3ZAG48sgOcR+FZ2luooAaysSqf/AawCAK0onvME1AzrG5qCkqfOKthglFNIqGlgsCIohIFarNwt7Th4llb2EfW046jsjc4k96Zw/oUIhNzQmvzgjS3pWPufoP9cdCGPbwtfzkeuNh0Y6GI3ogmMMglb7vJrVnKKvxHjuGyW4ioU/J47bUsEhfWM2DPYjaaE8tIfYy372zuLKKIlLgH57HdOg8rnbV4X1er1/TyJN+9CGJR7+eKn0sqOgI8sSt09ba3ddRpmLc0Nhii34jYITdY0nzp+a7y/wGOy9MU9qons8vKhgV9DrnMzLz+wFnD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b5de40-5d7c-4dca-c3e7-08ddb562e222
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 10:10:46.1488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nbav8DrW4yS5+HCceXf0W2/LblSfN41shYeXiQHNstFly//CkLlmIwrVkNrj4kiph+hw9Ew+IU8zqOJsapt5V9bhpmTHVB/SjtOYuFN+tkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6654

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=


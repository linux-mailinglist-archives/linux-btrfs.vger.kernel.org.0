Return-Path: <linux-btrfs+bounces-14936-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2183CAE7F4D
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 12:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3417AFA80
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 10:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11E3284671;
	Wed, 25 Jun 2025 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IMHWU5CZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rTouGCoD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF46517A31C
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847468; cv=fail; b=r22iOY6JGOb3bdABv601jL+jUm7KNeVbFUH/o7ZN5kHF64sSTvaiwxAbZuL6bwtuGRLEf5/7irSWg2HMHU8XJWSEDiXbzPhPAyLRo8O3pLn05sgPaO6/W23hfKP3RkCu88i1Oyx2NPGRs1mB5fBfFkqOjEIIQuphlTAckwKa1X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847468; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NeCGg2+iWE6VAhaA/wah5334QfxtNhiue01CVQSIb0y99lbeN7zW8aMwCp80luhQFZhu6zbviYvIR+OeebEhjn6YZn5VZ8HYkOLyfd6NLiSnlqCHGWCLCw88aB7QN3QIx1mGrqyqTLhhrfZEtF3FzRUQet9R4yRytHePZNHffX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IMHWU5CZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rTouGCoD; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750847462; x=1782383462;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=IMHWU5CZ1kwHXvHV1kZhjrci5SwRB0YOT4CVHKAmqZjK339/uqx8sI5y
   Z3StOLewS8Qrdj8P25PpfkhT1K7/ps0COdWfIpzzAit+PuQTbMzhhL3q2
   u73hlkvlTo7Xq44wqfAsnN2dTJPyrEtzX10yvEH+dUeBFZEonuvUQzzqI
   zw8lapM68XIKWyttG6+2rEBRtx5UuKGBDpfE47gnb+7nUDqrk6FhMc4uc
   Xbzgj76unw6Zd4A04Toit0F8aoHMMthUcHYJN6NGmpWkkOmItlKDtgRsy
   jkY6krehcE14YZ+pshDJSKWZ0/wiIRqVtgZW94B43A/77S9ZO8fsoMFcq
   Q==;
X-CSE-ConnectionGUID: RSnL2dOvSmCXIx/u1MgGtg==
X-CSE-MsgGUID: iFRrNQv+QHqfGhZuBNj0vg==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="90119904"
Received: from mail-bn7nam10on2072.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([40.107.92.72])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 18:30:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMnUHYjwhIyYnIp8JOf8tMPZno9P5qoJC3iOwQOu96VOrN9rkaEqpJ33fPxyRtC7BpfB0Bn/XLmAVPXEi6ClhLDTILOXzq/XXS+iN/Gp+LY/2UN4+7W/F7PWwjoq4wqy4mwp+Y/n5sy/cuxcsYHPN4zCm5bAWnYM/1QPqYZeephKfg8Y3YAG6tr66dSEw5NnAfTnmAUQI8ckwYZgRSoJ6vS8iedvbsv+vVbYlihzt50rrwTGCmsee4wxTjkBomt/h7DhtUpv3sn3TYuXUuU6fhYgXkpTBoFVvI4YprXHhiel8SXC6s/23hXT4Cr15J7sDgw/pDOU5AUq4hhfqC75NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=kyVbub9V7dTuYQaf2NfVVzUmwWQ05XEUEndAGZ+I/3qdO87hp1HGdo5tX4HRjJ0S4LZCD/6SB4KdUuUeW3xzuC85WrjFRms7OephmuwAp/e60ZvDX59YvJldY/maSptY5b0CBar+n1hQHlQb/QbAYHv0wQuucVM1GD5V0A9HeMXxXPsGPipAnlhhPBZlkXeftp609q/Qp0ulDsiRKt8hPXtSptn8PUm+kTT7HqJnUxoudjDMVzwBAaBGHop/59qaodRwbXs6EiQWPjZX8mqR86zyiuJh5NxY9etM9N9XAOkbdyEyNy4XYkNlmKQgYIHpPIQ6e6Q0M7E3JXatP7Yemg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=rTouGCoDEm/0X/g3Rn5oJx35v3JgwKyT+LC7JCzypHqbaMIJM/rzrFGe1LVOwKG5slkLwpz2PnjnPLVcqWECrLsQvkXG+fK32krCa4aMexwXANR0wVudI/8mthk9kTDMtoPsl7jNxImpgkmiKjXcCnj475k8b9jlhJ0bHBSGVrI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH4PR04MB9132.namprd04.prod.outlook.com (2603:10b6:610:224::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 10:30:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 10:30:53 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/12] btrfs: fix iteration of extrefs during log replay
Thread-Topic: [PATCH 02/12] btrfs: fix iteration of extrefs during log replay
Thread-Index: AQHb5Rf6qZ7mGiPWQUeBfdb1U5EywLQTrkSA
Date: Wed, 25 Jun 2025 10:30:53 +0000
Message-ID: <8a51ccc2-e83b-41ee-baa9-df4fba7f57e4@wdc.com>
References: <cover.1750709410.git.fdmanana@suse.com>
 <894622cd2bfaf3d1871f2d88ba0a212e7661e136.1750709410.git.fdmanana@suse.com>
In-Reply-To:
 <894622cd2bfaf3d1871f2d88ba0a212e7661e136.1750709410.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH4PR04MB9132:EE_
x-ms-office365-filtering-correlation-id: af2731ae-c5bc-46cd-e3da-08ddb3d35d33
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?alg2TkV5cTllYjVYTVZSRWo2VXExNTB6Snk4T3gxZFVBUFdWTmpvWFFHb05K?=
 =?utf-8?B?QXZ4dk1TaTN3OU9nREwwQjZEaitZb1IvMzZ4cE9VZG5yTjFSVUNEaTFCMmV6?=
 =?utf-8?B?TEdBYlJMbmRjb1pCWWRWR1lzc2s4NEs2WjJYb1h2SjFnL0loaEZadDJueC9s?=
 =?utf-8?B?U1lHVys3M0NyUlE5UEVIalJtYVhlUGsxcFdYZi9KS0tnYjI1OHZMQURjekZo?=
 =?utf-8?B?QzhkTVB0RHdKblBNMVFYOXJoVnV3K1d5RXVOTmdKcHB5dUh5U2ovaXBublN2?=
 =?utf-8?B?Q0E3MGhzRldEM0cxVnR5RG5lUUVuWVg5NnhxYktGelBDUXd4Z01YZU5QYmpk?=
 =?utf-8?B?NytyNDlBZlB5aUpnbzU3a2FDY0RFSHI1WUxwY2pCeGhnVU5YV0YwZkdWSUk1?=
 =?utf-8?B?UFNoenAxS0lrd09NUVo2by9jRFdTT1EvejZ5dFBpNmJLY0tuaEQrWit2MXk5?=
 =?utf-8?B?VmdQdERtVW9nNENmUTNEa2FUQVcrSm9VMXlSdzg3T1BuWXBWSDRtZ3hlazRS?=
 =?utf-8?B?czBCQ2RwcHRwdUtJZkp4eUZOeVMvZjc5SGplelNReXN4YTZLcjhzZVM0MWk2?=
 =?utf-8?B?UVd2RCthN2lYekswYzEzc1BCeVVXWFNyVHNONjFlekIxWG5sdWVQOHhEdVJI?=
 =?utf-8?B?dGdJUEt3NWc0UG8xenh6ZmZyOUswK2ZrcmRKZzBVS2hJSEc0a0Y5SVMyKzhT?=
 =?utf-8?B?V3ROeVpIek1TYW5GUk1IeGxtbFJwTXBOVjdjeXlqUnBVZ0F2eHFEVzhwc3Js?=
 =?utf-8?B?VGFydEVMZGovNGgzR2N1YUZuV1BpSnF0TktjREZwVlZnRE4wWE4xRXBrZytr?=
 =?utf-8?B?NWRvbUFvTHkwaTVTMGgreTdiYTEvMGw0Z0VScEV2S1RUL3FZRlJBcGlJR0VU?=
 =?utf-8?B?c2dxMFZGVjNUbS9IOVZIWDdpb0VPTThFMVhrTnU4c3VrRDhqQytadVQxcGtv?=
 =?utf-8?B?VTFWZnlTZFhIM21xODhuaFBUaGZBL0dCNlRDTVdJZlQ5eEdaZGpib1JtTTVX?=
 =?utf-8?B?MzZITy9QeUFFYzdkUkxwYmdlY2hTWmYyZ0RWdTlXZzhTcnFiSXEwVTAwSm9Z?=
 =?utf-8?B?M0MzMnkvZytaaUs4RFE4ZUs0M3cvbjkydE5VQ295TWxHUG1RUXhJM3RBRFpI?=
 =?utf-8?B?dTVtbFgzeHRDUjE4cDBLcmFtMVh5dndNUys1RXBubkhqTEQxRzk5ckd6cDF2?=
 =?utf-8?B?eFgzd3hvTENCQjN4UjE1N0puTXhvREY3Wnp6M0tESXJlWEQ0TSttTjFVRUt1?=
 =?utf-8?B?dEVzcFF0OHhQUTlrSTBsbjkydTFIa01tZS9WSnpBNUoybFJXOXJsNWtlZWJl?=
 =?utf-8?B?U2NTV29BSm1mM042eGxTVzlOcVFHM1I2WkJ3Tm12VkFQUFI1UklZREJHUHhy?=
 =?utf-8?B?cHN2ODIzZEszektyUlZ5UDcyYVFhNENIY0ZvMXRCR0lWb243WHNuMy9hU25o?=
 =?utf-8?B?bkIxbmE3RWNWNThFSGY0RTVGWU5DcXhYWjNKenVqYTZqR3diZURaaUlZUHZZ?=
 =?utf-8?B?a3VLcVFTVmdwY0dOOGVRN3B3cEhzQ1ZHV2ZiNjdDNWVsYnZVY0Jpd0ErYkYx?=
 =?utf-8?B?OWxobnYrSFFvNmszL1dZVTFwdWZPZmFnMWtMcExKcmZxU3JsYTNBWjhDTHlD?=
 =?utf-8?B?NmV2UElDc3BVdWZWb29xWGxkRWZxQ0VxV0dPaHdRVFk3ZktBeEcxK3N4VXN6?=
 =?utf-8?B?MjdkRGRWQnRQUTNXcG90TDJvZVd6Z2UxQkxaSkI2aXhmdldLRTM4VWx4Y2dk?=
 =?utf-8?B?WDlmV2t4MnFMM2tWSEN4QlRFUGNPNE9NOHFVYno1MVNRLy9jbU42ckduc3Bo?=
 =?utf-8?B?eTNIeml3Mm9JYWdRdzJXeE81Y1g2YVhpOXh5c3ZMNkxpT0lBK3ZRcE4vMitm?=
 =?utf-8?B?b3YydXN6Y3dBcjZIeGpwZlBCWWVxa2JsemplWWlPcHA1QmxPSVhJTEZEZ0o1?=
 =?utf-8?B?OVNldDdVUmVOU0pDS0IyREJvb3B6eEJ5cUREVE92VjFMbzVEeHI4RVBaNVc4?=
 =?utf-8?Q?R/stauMKBrjczu7iCzyTrlWdOJjQ9s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OHBsVFNaRGs5dDM3aElJRU1MQ0tZRlE5aGgrKzByVS9udVZPeS9jbHM1K3Bz?=
 =?utf-8?B?U0ZiUjl3dUdSQW9vRTFHTWszS0M1ODNuOEwwTGo1K21UenM2aXJrT1NTYVBD?=
 =?utf-8?B?UmY5UmpCYmFkTkhNSUxwSHFRYzl6M2NIYmxKYWs0R0cyWGJzNGdWS0MrK0tq?=
 =?utf-8?B?T1VXZlVqdEsvVDczTWd6VFpKOWNuNlhHNEpVSDBaN09jY1B6M2RmNVJGaXN4?=
 =?utf-8?B?U3lLSGR2bkE0MzFsWkFITGc2UEtDcmlRUTlLZTlNWFRGVWFTZjk0MFVnYnk2?=
 =?utf-8?B?TFdPNzFhVWJmdkdURHhtM2lTeDQ2Q0I3MHZjcUxrQlhJY3BLeXBReHVaWDBO?=
 =?utf-8?B?eFZuMEpkd0tIaTJzd0g4YUFiS0tBTkhId3RaQWpvUkU5QkJtUlgwZTdVT1d0?=
 =?utf-8?B?NTB0Yjk2VU1ibXppSkVtVGZEUFBaVVpjeW5uS05lZ2NubEErQ09ZclhocWw5?=
 =?utf-8?B?NzVRMzZDMEtyZjBHRlZBNDBmYjFNY0VvbWtpQlE2R2tBbC9DUVJ0WG5WZzJ4?=
 =?utf-8?B?N2RVWWhCejdFelBWUzF6dVpJNE9VZG56MXlBS1ZYdTUyM3NXblo3NVc3YjI0?=
 =?utf-8?B?VEE1Q3RJZjQyL3IzRHgwUCtpempHSk1qVkthb2xUcldteFVTS2tvMjMveWlv?=
 =?utf-8?B?N093MEp5U1JvWkk1Z3ovN1lCUVZwUURoakh0VWN4NzlpMWgzSVN1bW11N09o?=
 =?utf-8?B?c25vQ0dtMFFOWkZGeU1MYkJqQlhOVVh3SElNenpYMzFkMHpKLzlJN3ZqbzND?=
 =?utf-8?B?SVlTbWY0UDJocC9PY1BaaVJMMDFJUGFwd2pUWk41aEJrOUMyK3dTSnFSNWtN?=
 =?utf-8?B?c2EvRTNEN1NTUW9BZW5JbFl3R201dDFtVXFqSzJUdStWS05oWGN6bkRqRVor?=
 =?utf-8?B?V3FKMXljb0g0TGF6Q29lMTlQditSdG9qd2ppS3hCS2Z5RDJVOHNVSnJ3dTdr?=
 =?utf-8?B?M09jWTkrMHlhMHJ6VVpDQVZ6Z0IxQ0VXeXdMUjlUblZ4bGcrNkpsQTBlcldH?=
 =?utf-8?B?QXJGakQwRFBkMThLeU14b1RVTjhyandWeTVVb2F1N3poN2ZxK3FnenM4MTA0?=
 =?utf-8?B?cW52OEhyLzJ6a0R2WE42WW1HT0U4Z2R2ZE9JcnRJQ1NEM1ZtUHdhc1Qxc0cy?=
 =?utf-8?B?SzVDSndic1ozaytOa1NJR2phaXlxNmQ1UklyUzhFYzcxcGFMZmw0SEhDaDMz?=
 =?utf-8?B?UGlWa2haaDcwM0s3Q3JybFk0aFN1RmIyTE9qQlp2Vzh6cWJOQnZ3K202bHhw?=
 =?utf-8?B?eVZXNzhSV2JXd0kzN1B6eDBKUFJUcEFSVlRJVmN2VE1QaG9ETDRPZ0F6czA5?=
 =?utf-8?B?eW9yYU0vVnZ5UU02VURCSGs2MmQzaDJkVlpSY1BFek4vbE5IMUUzaTJTRi9C?=
 =?utf-8?B?Tm9ra05kdnVCTm1GMFlSU0tUZlpXeDd3UVhFRU02TFdzb3NOcmdQUXVnbDJ1?=
 =?utf-8?B?NVRtcTVZMkQveklLT3FOTEdKcWl6K1RDcXJRV2xQdmRtZzlxbVcwSUIzK24v?=
 =?utf-8?B?UDVmK1NYclF5dkRud0hDTk8rdDRyRjNKb1F2RnlWcGhTR09RUU1tVzRaeE9h?=
 =?utf-8?B?NkZRTWdMT2d3VjNabC91SVVqcEV6UzZQMUxnWnBGWlZxR21hQm01aFlnYmhT?=
 =?utf-8?B?Q3IyRnBkdzBScDlwZmN2cTNCcDFaMzBldTJjdFhRZ2xud2h5ZzJNcFo1Vk1P?=
 =?utf-8?B?dHBTM0JYcHZYZ1RWTnNOa00wTzZVU2c3WmpxTkhNNzJGR1RyTTdwYWg2NmtP?=
 =?utf-8?B?OEpSZkVCV3VFdWF6Ty9WTUlOWGx0K0NQNStwN1BCVjdwUEN4TndDM3BBRUlS?=
 =?utf-8?B?OElYcFprWHMrVGtVMDVEOWx3T2lKTlRVRU9iSzdJc0ZWQVQzKzJuSVZTMDl5?=
 =?utf-8?B?UEhGcy9JQS9rVU1EUXBSMi9iOXBEMGlXZ1M5bFR6YmQ3dXkxQVE3bHhiMFJk?=
 =?utf-8?B?KzhqRzNpc1g3SURWcUF0V01MTGdPNTVEekxYZWZjS0tvTDJCaGZmQWNmaFdh?=
 =?utf-8?B?dlBvQ2l3VjJWaEFqNUo3TFVIZzJiMnhEc2crVmYyelJVM0FwdTRPYUl1TFhy?=
 =?utf-8?B?YWdIeWovYTlISnNVOE1JZExMc1hzS2JTZEJ1SEFhSFM0NXlPMUtzc1lFYUR6?=
 =?utf-8?B?TlM4ZUxjbFpZU3lwWjlrYjJxWUZtYUtNRXMrbnZkaVFDN09kU2tCUWIwZFp1?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33CAA58DD7428C458ECF490EDE9A2B59@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4JRFy+1p6kM8Ov3qoZZY8UGspJBnQGtLYPBYHsc2oBYlQSoaE+c1hfm5TbTHdMB3W6IC3n4hY5VPYbQt5ydMpOYYaERMXY/0sFB4ypsDs+7+MolSFl/NVcF9G5s+NDIaFBwv0ML8IHuzntKgRIqMzPvS6IPpyKXlHjCDYecrYcIRMk9XOhnvVP+Yeu9z4cD8VUyvg8jgT8/ZxR+dbj1u23syYdfXH1pQFb8bpM93+6lVFEIoopWBfy1IcFrlN1VPhmQhs5uN47QAjuuOVLFAtVs7oeMDjk/qqXff7qfXIrjZ0geNepryuMcRqdsQRrjYzM4O1R0kIeodQWJC4C3Yyb/EllZa8Ys0StFI2T4pa/aJ3P65raKCjCuFzc+BHk7vz58hxlEq9X/lvmHaT6NddoUhAipPZpoPucJmEnX5Oy6ep4fi/DSLoo01FKsNu6ZvHAsZXgwVAN3J4Jh3eWHdqKtOVeRWh3FzCFxLaivy67xs4UqkF36DW4fVKOmeKtuSLfKHbYE13mj8eSMK2wf0YuxTM9aG6vjS02CViJ4mgTUZoP/0vtA3uZ9f3Lfqv0SeY8YJHiLmrY+7v2I9Bxcoy2stAveLgGm3i7kXwJW1uZTsqAlpWLKCQypwcZy7G/N6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2731ae-c5bc-46cd-e3da-08ddb3d35d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 10:30:53.9087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2v79JwYRepMx4GjAcQsud/qxhYu/ND0Yt31ZFKvdoD/PXNwkEMogTjqa+tmDvY7/r/6MkdS4jE6Zp52T1Oa5M9JI/ocDfe/meDJt9cCf5B4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9132

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K


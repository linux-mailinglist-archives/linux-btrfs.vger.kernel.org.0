Return-Path: <linux-btrfs+bounces-14950-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C4FAE8187
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 13:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00E41C2476F
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 11:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D689B25DD0F;
	Wed, 25 Jun 2025 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e8ccLXCe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ye8aP3HB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8293B25DB18
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851431; cv=fail; b=FNFVMGlSAN79b/C1giOnSRb8Y3ggI7qsucJVlCA/rWqbwcp62Oz8A9tLPusqfR1XW8QxwgAilNgX6Ucl9fuMDdSkUeM/zXj5tltUYCL2e/prhEvFZIAUl61exsoeHjV0y9ygovLw7JE9bwotG47P+LhhAbXCD8EJhLTkkyf9IyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851431; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gAWevCN1gSPg16UWuBZhxO7U/aDFsEYGFwqz9eFkaeN7f4O+tcdSferGRyFXoeDFMi20hrP2PW+btUjFmoI2K3pa4dHKrxlt1s2M53j4JE6LMmCRPOQ15zK/ubPpYNIUYuKmOvJd8VTaRuDKAPi1xg/9DQjI42tDNUyuhswQwrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e8ccLXCe; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ye8aP3HB; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750851429; x=1782387429;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=e8ccLXCeaiRQo4WztTTfvWnv25gvuir5nr2NDx2ILhCI7U8URDwKg4tB
   Z0KVSRg0pnhx5aKyf2gO7c971IwSCwsZMzp8u1RtmG1Y7pNpD5q+e8CZy
   eA1sP6WWpbRh4w+1B2+P35XBAhILaTVHiaqTcaCh1Otpdx4YvznlR0Vf0
   RHzAIQB47jafTj4QA5dxrMGJ7n/kjfciQcnORFvT5iRIFbM+0OVdr10iu
   zn9H5R0LecOF3rG2ZAymRoiUO4+OeDCPn2TcMhJwOhatxD0u7UpeBj1Ui
   dk5uXaitHKvpDqSN+5orFc6PJF/MX9DIq/KSjvC5q432pmpjITlTKKt/r
   w==;
X-CSE-ConnectionGUID: R0Pb514iSVW12uWvRNm6HA==
X-CSE-MsgGUID: UoYw/Rx2T92pT+TvJMew3g==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="87198253"
Received: from mail-bn7nam10on2051.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([40.107.92.51])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 19:37:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSgrO5R26+zMZUb1rDhJ0VeA1mbcaEEXkzGT0LISZOXhlPVi7JnzTKWoUAVqhyS9I3s4j9jBGuCjbqTYgNE+uuqJEUllaE9/81+9DwfFGFd6FOG3jlKDZIpNNxkxXN0E+KG4LDK0NFnvxZx9QIHJDs5k83M60GKsvfjHeFYZaq2ngOj1de9e90iOB/2CMahGSdKuZFuuIe7q0eOIy+JKvn23AF5misHtrwygz9Jgh499jrSyV+OcR5+yUJ842cvqGZqRe4zs4DQXWEmb8HQfsrEEO61ba3/85Q8+V5AWXrAUWUd7e86I5pHU6JCQ5vavdSTk9Ht0luH52H16PmU/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=sgKNLS/0B0PZFo6YgNz3316cMrEsKwETPU9ixiuoUghrPLaOzCOlVxZh8WdwZh4lWcfdvpXvvS87op7o3WSHhxc/mVjQz7eoK3NI4948QmLBGiyioJEl0K3ocjw9mcXGyNvH1mfEDmv+j2aNiT7G/UNBY/fOD6jnhD2GfEC/qWLgqMnzhHspAmRPKHmPd4SF+lU2w1uITUObEfSrvJZMo9XU4aaOvc5e0WziJw/XFXwxuD4td1y/8MWw5IThCO6uVqWW/ksytt1JrFlNFLsNqTVMMk/rLcy+1eNH/7KnL/usS3YccZkHmS202kAON5bwQgvdonOafmyMmDmqRSNATA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Ye8aP3HBct+if2tT/Ys0LzlCalfzqe6u+eH92fNiHnCNpOkQSzwIQRMp9Fg/59HjU6Sgd5+13QO2ju4oE2QWMJjowCDi6uSCFPIp3GfNaL6oQUzfUK8SR9Lkki69nO+vgOYdbzZtN9CCP4RtQVvO5fu70XBrtwUrFsgCJ6+yK4k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6857.namprd04.prod.outlook.com (2603:10b6:5:249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 11:37:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 11:37:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 12/12] btrfs: split btrfs_is_fsstree() into multiple if
 statements for readability
Thread-Topic: [PATCH 12/12] btrfs: split btrfs_is_fsstree() into multiple if
 statements for readability
Thread-Index: AQHb5Rg4SlLJDWuzXU+oTKz+WVXysrQTwMQA
Date: Wed, 25 Jun 2025 11:37:06 +0000
Message-ID: <5dd09aa0-21c0-403f-ac10-b28a93592345@wdc.com>
References: <cover.1750709410.git.fdmanana@suse.com>
 <7984e152e4e0c6092d931f1229e21b7bf6dd9798.1750709411.git.fdmanana@suse.com>
In-Reply-To:
 <7984e152e4e0c6092d931f1229e21b7bf6dd9798.1750709411.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6857:EE_
x-ms-office365-filtering-correlation-id: 71f5bb14-fdd9-4fdc-17ea-08ddb3dc9d11
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ckdOay9qRkRJaTRmbEkrVVlBU3I0aG1rckJTLzE2T1I0QytaQTFycUNXS2Ru?=
 =?utf-8?B?OWFwZnFVQVZuU3BobHZ4QXo1dnoya01kYUlDb3JEQVRsSmhwZmJ0c21BdVFQ?=
 =?utf-8?B?Y2dUQ1IxV1VCdk9oWHJ2NW5iYVFHczhzalNDdGYyUE9MS0gzeDA3b0oxNUdU?=
 =?utf-8?B?Q2NkYmZsS3IxOFBCQSt1Ynh3djhVWnZnbHI3SEpJcFlJZUoyMUxHUjZBZWt5?=
 =?utf-8?B?ZDFpNm4yOVFzdG9UNGZRb3dBcGhoaTZIclRPSGRtd1FETmpubXI1MUJHb2pv?=
 =?utf-8?B?OW9RNHV5d1Jubm02RldZZS9HODhWQ28yajBscUhENWZhVkN0a01YMTRmWG4w?=
 =?utf-8?B?a3B5SWRna0dkTjJuQWpma0czdjZYSVpXY3AyTXdYQ1ZwTGRuOHpIa0pDcThz?=
 =?utf-8?B?bzBMTHgyTlZsOW5TY2ppeVJCUGhUbE5xSXZUb2YyKzNXMmN0QWV3eHJuNHVr?=
 =?utf-8?B?KzY2Y0FNK0l3RkNBZVh5ZUZLU3dxOTNRenNZbWdVQWpwYkV1TVVVUzdtbWND?=
 =?utf-8?B?QStUcFR6WGFRNmtDZDdpUWQwWHkzbms4TkYvMnI1WFhlN2RVaFhtdDBnNWEv?=
 =?utf-8?B?VzJsL2ZyVW01eEpiamV5OFYzcURXWk9SYktkb3NLUTFpbWN5UVZhMU5IZXZz?=
 =?utf-8?B?OTlZTXR0c1NxNlNLS1ZYLzRQSVgxSkd2am5DMEdrSVQ3MzBkeTcwUnF4cXNj?=
 =?utf-8?B?RW5BM2pIbWY3NzRsVkYvQjBxMDFhU1JnK3FXTHNhVndSWWQrUWkvVnV4WVhK?=
 =?utf-8?B?ZnBwdk15N3dtRHFMQWdCbER2TlhzYVRnODNhY3RRZldGU2V6bWkwa01la3Fn?=
 =?utf-8?B?TXNhS3ZRME9LaGFyZDVGMmJRdCtRank2OHNpQSs0Z1haZ1JpeEVoSXUxL2Rm?=
 =?utf-8?B?RWxmK09KYUM3YXd6M2xyZzBOd2toY0E1NVpVR0NjOC9GMDhKMUQ1eHdYRjNl?=
 =?utf-8?B?MDdYVThHUy9zWEI2aEZUdzRibkxyQXBKdkhQTHpwTGRWU3MzNDE2b1FlRSs1?=
 =?utf-8?B?TndBc09IYkRpL2ZOMkh4bjRYMno0QWlKY29FT0x1Q1I4UUF6dndYME01eFk2?=
 =?utf-8?B?UnRMd2ZqS0Z0YUdWRUhZQmRKMnJYdGZRL3pVK21DR1M0bmR4UTR2cXV6a3Z3?=
 =?utf-8?B?MUhqQXdaQVZHa1d0aGpMNG1EOVV2SHllYzVUdTQrMnpHb1VCYkUyNDhYNkt5?=
 =?utf-8?B?TWFtY0kzZ3ljbmZzdkFDdGt0RkhaYTV1SDRSdWE1TXcxejlDYzNRUnRHR042?=
 =?utf-8?B?b2Q5RVhUY2NwbDZNV3paVzQvS29kdG9YLzZtZlJZS0hzSitTelFuUXhYY3ZX?=
 =?utf-8?B?RmYra0xZU0RNcmdYbVV4ek1naHhjdmVqVENnQUtwYW1vVlF0ZW1TVG9SNnBx?=
 =?utf-8?B?ZFl1T3ovMndlbys4cnJsZVBrVWNNRmRyR0ZqQXU3bjN6RW80T1JIVFE3K0dG?=
 =?utf-8?B?VE0rTWxhMmwyRkw5ZG9HeEZCSFFjQ3VJMzd2UnUyc2laWDllWTlpem51WVpy?=
 =?utf-8?B?K2RDaGNqbU9za1EzQzZ2bk9UWEswVHNCczhUdWJLK2wrbVJvd0lNNTkxaDZp?=
 =?utf-8?B?dFZwZmZtQ3hudE9lc25GRDA0RE1Pb3FXZjg5ZXR3QXdJU2JnTWxCdStHbG42?=
 =?utf-8?B?N290dS90RkdLNFJ5UXAyZTJVM1Z1MEV1UDUzOVY1ditabUFQNUNhaEFGdk8z?=
 =?utf-8?B?ZXFLZnB2alBqZWVPQUYzYXhhZWE1RUR2TTl3djBXeHIzUS9iWWtZa3pxbEVM?=
 =?utf-8?B?WTFKaEh2aktybkw2TXYwN3QyanhvbGFZbm5JZXZqSkRyL0xoUTdpNmRWU0pw?=
 =?utf-8?B?bzFIa1JTTGtPU0xSb2JkdXg0ZTM5aFArNzRWZHo2VlBEMzJ0dGdzZGhDcDBC?=
 =?utf-8?B?Y0pvUFk4N1ppck9rZDg0UWxMMnBUL0VwaDBMNEIxQURCU2lYeVQrOXpKeHB3?=
 =?utf-8?B?OWFvYXJWYTNZbzBaNGYwSWd6Q2tteTluc1kreElCYStRRTdDNEFOY3AySXYw?=
 =?utf-8?Q?UrAWZKIIfSDL82eQNEXtij6wPcBw7Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWtZR3NjRkl5LzdwWk81RnhrWmlsb0U2ZnE2aG1ZRkxIUWpPOHVmV2tqRUh6?=
 =?utf-8?B?ZmFFVHJTdEZVZjREWjh1ZmVCNkllYTA4aUhNa2pQTFM1aUZaWm9UaHZHTnFJ?=
 =?utf-8?B?dTNXbnhxOGd4amhUZTZwM09MVktBS1lPY3piMTlmZUN2eUZUek94T1p0M3pJ?=
 =?utf-8?B?RjByMDJNYWxuOHJoaTNkODdxZ0FUVjJhcnYzbURUM3RwUHBVTE1IbitMRDdD?=
 =?utf-8?B?TFV4Q2J2cncrME9vVjdTcWl1QVRZUnFjeWwwVjZpcTJCTUx2RkFnRWlkdVM4?=
 =?utf-8?B?WTd2Z1NObHBXaGJYQkdFTkdxMFZZUU0rdEVhMnpxUUZockJkYXJ0K0w5MCts?=
 =?utf-8?B?UHJyUWw5SDhaSVdESmxtK2dOUGFTaUdwS3k1UjM5ZXJiaWNKZVplSHFQRXQx?=
 =?utf-8?B?SjNROGpkNnB0RHYraUxMdTRJdFdhK3JCNWk1Y0diazdENlNzcDVUUkwrekpF?=
 =?utf-8?B?cFc0THU1c1gzUDVuSlY1K01kYVdBQisrOVJENERXRTNSUzNBdUoyOWJ0STFp?=
 =?utf-8?B?a0hNbVhKRk1hd1d3bmlCL1MyT2NpSU8wd2gzL3E1OVdPRHpKV3dGSi9kc2RD?=
 =?utf-8?B?bTJsMVo5NExIUlhTN0tZU2g4YTJ3M2ZWZVhHdmdnejlyNmlCS0N2QnQxMU5J?=
 =?utf-8?B?ems3Y2VIS1hqWGY5cmRIRWpGNkZJNDVocVhiZnBXWjY3aHdzSWF4UWNHdGNW?=
 =?utf-8?B?MmJGMVlZL0w4bVBIemx3cnp4OWpBNURGVUI1S1dqWFBHdkVEVlViVStjYkpD?=
 =?utf-8?B?ZW40QlpkYkZTS1crUkVMN0w1Q09kTUUxL0lZeStCVGtqQ2h0bklHR1huRzJV?=
 =?utf-8?B?TkRXL1VtYU1GT2RBbEpFZ21jeUpnTnpVYVB5L3dibXpnaFVRTDVxS3I5WEhF?=
 =?utf-8?B?cGc5bFVaOXJZdmpuUGdVZUhTTFQzTDBWMEcyK005MGhId2hJZlZnY3dmRW9P?=
 =?utf-8?B?U3hPTVJ4eFArUnp6SmR3eFNGcEp2aTltMC9NZkNNM2NBSExHR2c1WEdiNUZJ?=
 =?utf-8?B?eHd6U0t6UW45dWhQWHE0N0NzVHhiMnVhZnpmWmRieTAzTEVoZm0zWTNsbkZt?=
 =?utf-8?B?UXozMHB6WFl4alFpazVWS2sveTdHdmg3dVJnUE5Qb0pQeUQ3cXFucHloalNE?=
 =?utf-8?B?TWszUXdMd1dYYUFYY24yM3JJb2RPTURabTZjQ1JWLzYxZFNPZzhtSGw0aURl?=
 =?utf-8?B?YlZPMlFRK3JGai9DZGdZNVUzODBIRDFMdmQweEpVV1pkNk0zY1dCdEtWR3Fm?=
 =?utf-8?B?UjdpdnN6dGZ4dkxrK1VSNHpJZDBzSVNOM1Q1UVBWRDJDWVJjTXV0cFdsbmlo?=
 =?utf-8?B?ekRCYyt1Sm5RRXNMeCtxT3FXZ3pOZk94dzMxUVhTUittS0Q1eVUwZndMRmUv?=
 =?utf-8?B?eTVBczhKU1pGOFI0Z3czdmkzTWN2NE00SjVsNnFrcU5icWdJTVRxWTVscEJW?=
 =?utf-8?B?aXp6b3VhdTBBSXdlb1pLMWt0eElZQjRNNTBYMUFBUmlNeEFHTEJld1NnUWhJ?=
 =?utf-8?B?d1c2ZTdibTNhUDBkTjJybHFtQldqMzRSZjdSYkJyK1JvaUVSVk4xV2lzTGFN?=
 =?utf-8?B?L0tyUkp5KzYyaXAwMXB4Y0xqdzIvTnZlbmd2L3R0WjhPVENFVUJZbUE3Q1lD?=
 =?utf-8?B?MDRVTlR5RVpuSTIvT2dOUXR0Z3Bqc09CR1R6dkdPb1ExWUQ2Ky9adU9OZDlw?=
 =?utf-8?B?N09QaUIwNlVGM0grQS9iZUlBU0JSNVhuMXhpVTREWU96V0pkSnRxRU5WTHpK?=
 =?utf-8?B?WmNKZzl3U3RLNkJWZnBNdmNhS2tjaWl4RkIxN29DZnI1ZEhPamNUZzFSS0Yz?=
 =?utf-8?B?WVRnOWdrRGNtYm9SUmJvQ0VjNk9xOC9uV0NBVlpaNGRSTjBsM0VhRU1YUnhs?=
 =?utf-8?B?Ui9keFI1WDFZM3BnRTI3Rzh4cXVkRHhBc2EzOTRrNDM5a0JxeERqK3VSeDJt?=
 =?utf-8?B?VVFaQWdaU1Nqeit3cC9BOW1sUnhINHV3aVFwbFQ2WjA5bzFhYmJqODk5cDVx?=
 =?utf-8?B?YzJyb0FPVkJBbDNYQTRhckdzTkFtYWZLMTFRd3crMTZSYlhGTGFYb1pzWHF5?=
 =?utf-8?B?QmN6YVh3RFY0dEQ1L0JpOHdIY3M4eFk2OERyUldNLytRbHpuWnJreEt2L2JS?=
 =?utf-8?B?M0txTm45WVU3SlVidnREWlNNeXhUZlRFTzdqU3lXSFpvK2N5dGFUWndwanli?=
 =?utf-8?Q?AmUYBFnzLlJttYiX8vNInCw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B501CE2AD6F84449E5E9EB89E364523@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iLJjGihYptivbaj4D5nJyM0GFP4RkV4AH0ptY0IKZ9GHzfNitNoluxtX2riKqoCgtiKW5l8+Ehr+ck4CnKNrfBRIG5DqBVv2TobU9a0VFc7RxhnBiQDZc6TVeSPs/6sP5xfLJUvzpYIoVJWwm5ptKrg+m6kOQFCvTAM8K4n9vRU2EVKERvXQ3agpQ3wB72ylUPcWOWEiow7Xp0/soWrVe7v+xp6owv4M57E81RUitdO71k0zZVBPA177UWnZW+jLr0IM5KNLrXqk3TY6xt+yhZ29lIbIfXHM3RsPjCDWYjV0n/pbT4jAGtOBopcbSiu4dshdWuzPRgEhy//9+0mWjLeeP1zna6tZ9cX6/VBkY6jMpJpHOlFSKEd53sgQoT1xJUwY9PSdeVU8SycRbn35SOMFdK2Q2v2Xyir1DkGeNgnZ6As4zDIcUEE491czd/0WlAiM4Pu9aEvM2G6uqRJlGGi6bm6Oh2GSQOFLbXv72UQAOwNX9VJHoFvSC6L5Dqw/bwlzqdWAWHnP/L5yWKCY1cq6DLINbijOSoCYEtdHXzkfLdfaB7GwrMRvPH4r5tYkv4n7LKuvVCKwB6fUiC5IMbEmYb/wV7fNS504hihq3lawBby0/7LzSH+MWKqiqxiG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f5bb14-fdd9-4fdc-17ea-08ddb3dc9d11
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 11:37:06.5171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 23RSJ0fpTh6EC7o3I7eyIKdamYXEM9LAzfOCvEcGn3el07Su1fBGyOMEb681yYXVPvYTEK66+tYLFprNHoSZqhF1ePIkIpO/AY0jjuJmwk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6857

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K


Return-Path: <linux-btrfs+bounces-12694-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CDBA76B12
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 17:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F24D3B6950
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 15:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3083021C9EA;
	Mon, 31 Mar 2025 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Vg8T8Wd7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yvmID6RX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8714C1DF748
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743435389; cv=fail; b=YmvbOHPGohuBf3y89dWpw6ggBu0v+v2pSAPEvXfnbJZbWDmNTbfkTOYLaaIsP2JUKc9ksmvxbqY2mNy2LAr1oa8xymvBgzTu96DQxq/2WqRDHrHLRc9yWKdpaXNokdiowNpmrpTsW5Lq2MrK79pQ0VXvwEJIQYR6aAzTZ67H/zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743435389; c=relaxed/simple;
	bh=oz2Y01PFzqzxlXZZuItWvAY6nfVpef4U7gJdEHjRTBg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ONcbHVjmUrURA7eMPO6IyboiS3SgkaFa8gjoRVTKrMXCHtbBCM00WJ01oL9NWqfoNbYjtv31lpAoEzm5gIaHjOLtLsEG9xc9SivzuNAUw3GoopQV6CUlil5u1qpcqjfCTlAkLit10Z5+bAm74SRgYMFUt56YwFgOhsg+NeoNto0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Vg8T8Wd7; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=yvmID6RX; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743435387; x=1774971387;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=oz2Y01PFzqzxlXZZuItWvAY6nfVpef4U7gJdEHjRTBg=;
  b=Vg8T8Wd7qGA3uLCXZMQFj86MuhFCzHJyNB5Vvl2fHGDo8Ry/O3xmgf8Z
   EAhac2zrfLBRp8sLjcJux+gwRg3sYMvuWOfPggTA/+Zwa/gCUDPOuJqAO
   jemgs/ajsxj/IidkLEC52Lp/RRK2LT+HIQJEPON4LlWr13IQHbziboGdM
   dIR8JANMzQWS45tVKslDYYl5HFY+/02vKFnOSPwy0S/qPwu6Nuqvf4ben
   cUyMvELF8TXLI5NEHe93C3e3RSDEqBcE/2AB3yH7L15DbkxZZ6OS+EH3e
   GxniH6kjOGa8XhJwG8IDhTozfPMSB6ABcNAwI0rvlpMJpcit21hDclJa1
   A==;
X-CSE-ConnectionGUID: 5cwFxteaSOy5cORJ4RZ7Pw==
X-CSE-MsgGUID: JVG/F3k2TCu3sEks9UNlgA==
X-IronPort-AV: E=Sophos;i="6.14,290,1736784000"; 
   d="scan'208";a="65563716"
Received: from mail-centralusazlp17010000.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.0])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2025 23:36:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLOubEQkaSZ6VJpMr8IdLzNT2CtInEe6+3lLZvgKcRoTxrdeLTy6Y23gUaeep0+05sk4URqYPktUconWYFGyfF3BTQIAjm4vokxh3GAvLahpN8hGI3h45ok+IVWTkCUbb57DL8J3Kyysq1LBAbDq/W8wB+QdEZDHu3q/+Ezvif+cWNzNwR8wPZnos4OvJvcP+uNZk24LMyB8kBrVLyIDRBmul9WofTsodL2eN1RId673eDoeCdbQ+vvI9b6XntogqQmEeFNRx52k6umNQ0gB/vcQPHOF4/u+1ONGq+iskDG/1ldBPXU+R3ggO5gtxozT6do6didF1T3zN55oWKONgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oz2Y01PFzqzxlXZZuItWvAY6nfVpef4U7gJdEHjRTBg=;
 b=V+j7dMXwJS5F8f565jqJAIh993mtSpemdkSpi39MH5snYZ5eRRxBs0dyAICoo6cwbv9l66vrqaK/VNd1kkT4YwAWMXoZzOaP9zhUagfzM4J9Od2shlQ4sAPZPkxPW2DXQJwwXZU2XCH3SyFCfh3pRIu2FTF4puzh+kD3tJIx1fmA90m7DExs07+4/funblevYLxhQpjgS+/rRMilbjGYM3G3wMpz/yNeKQqCw5iHO2Bc/NCFyrQUU+0TDYEWeqn8vK2vfuL34ijFi4/HDNgIMFSKXpCIEuEWujOJjzSgDMXkg9k95EuFKWi6xjhJGM4BsNRpuEcacYu8M+XdseclTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oz2Y01PFzqzxlXZZuItWvAY6nfVpef4U7gJdEHjRTBg=;
 b=yvmID6RX6tgIfG5Vt1o96Ki86xpIUjlM7fMErBXYQq7xyX9NXIN1/7Z8myTxFNYYndwrdCAks78lxHGnZ1WBCGJkRy22gXMq8KuGEuAw+cuvvuyvkYKvOBElRsJv6rMvsyoDDN82U7OavOQ5SD2CvCRk/oNeRvQlIxqUFzCaO6s=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB8107.namprd04.prod.outlook.com (2603:10b6:208:34a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 15:36:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8534.045; Mon, 31 Mar 2025
 15:36:15 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use rb_entry_safe() where possible to simplify
 code
Thread-Topic: [PATCH] btrfs: use rb_entry_safe() where possible to simplify
 code
Thread-Index: AQHbnzQOj+drIlLSaEGBsKX389DMYLONZt6A
Date: Mon, 31 Mar 2025 15:36:15 +0000
Message-ID: <55112570-95ed-4a63-9f30-7d041cd8e72c@wdc.com>
References: <20250327161918.1406913-1-dsterba@suse.com>
In-Reply-To: <20250327161918.1406913-1-dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB8107:EE_
x-ms-office365-filtering-correlation-id: 4e4958c8-e27b-4ee3-63dd-08dd7069c637
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0x1OWxjNkFHbEM5WWpwQkJ6dlhwNkFuSWF3SExCQjhtblorejdXSzd0UEZB?=
 =?utf-8?B?c3BUbWgxdXRwYkVzZi9CbTd5eTc2eEd5ekdsUERVdjlrankwS2V1ZS9zMGEr?=
 =?utf-8?B?eHBSMnA5N0ZWV1FlN09YbUJxNmEyTGlWKzhNalZvSXFhTTUvTjBzeGNQWWVx?=
 =?utf-8?B?VCtjcC84QnArN0t2Wk1JeVlPQjdCNGt4K21vdWViL2dJamlXaVVQTHBNaGlj?=
 =?utf-8?B?dTdYT1k4OXJ5SEt6RlVvT1hSaWZjZU11TGg0SExBM0YzR090TytIeW5hZlRU?=
 =?utf-8?B?akFmSmh2RG9TaVFJRkhqazluNlIzcDkza0h6ZUVuSENHTEdIdmFjK1NIUGVx?=
 =?utf-8?B?eWNsTWZJM3lhNFU5RVgrNUpUZmdJQm5qNE1pSWx5WGxZNnZXWC92Z3JwUGsx?=
 =?utf-8?B?RVJEdTNzdTVhT1B0S0RCTjZjVVExNnpoNG5sUFlJVGpyYXIyYTZvOE10K2Rz?=
 =?utf-8?B?MWh2cjBqdzV3Q3dqaEVpbnQwV3IySEZqS2VhcWNualEzREwwSllCcXNIU1ho?=
 =?utf-8?B?NUloVmVaUzVGTGYwd2hqMkNzVTJ6MDF0c0hYa21BZm5COUpXZ1kyUXVMUFht?=
 =?utf-8?B?M1QxYWZLeDRTT0t6NXlCdW82Q2FRWmFYZHFVN0s2Z09OS05RbWZIUWZuWHNo?=
 =?utf-8?B?K1R1N3hHbUVtanVEaVRHNU9IZVg3aVR0RU95bUhkeXZWUWduSVBGZ3JaLzdP?=
 =?utf-8?B?TVQ1c3c4VWljd0RZZFZ5dEtvT0tBK1g0UENiRW9oUUZ6U1BaRU1uMENIaTNa?=
 =?utf-8?B?dkR4c2RxcHdsc1o1ZlJaZDYwWnNHYlVZdEdqS1VJMXVGQnVIN2JYWU9MdEFK?=
 =?utf-8?B?VW96TktxNXVUeGVaeWltMTd1anI0ZmUwVHgvMnk5RERJRVdQaWlFVXZvYXhM?=
 =?utf-8?B?SE1Ja2FlU2hkbzV0RlhTeTE2THpaczlDVXRNZWo1eTBvTWlKZTdzVERSQUxC?=
 =?utf-8?B?Zlg3QjhQUUxkd29CL3RWa2xZMVZxQTZick96UWlmZVVMamk4clJsWk5jQlhO?=
 =?utf-8?B?T2tjSzZ2bnBQY01qSWlndWNHZno2dlZPUWFyaXVXaFRBd1E1ME9MVkQvcmRM?=
 =?utf-8?B?MjNSQXp3MCs0VWlTM2p0aXg3NzFKL2NBNTRoVTdMdEY3SWhKbkxYNmZzTWNi?=
 =?utf-8?B?L29HSWxqbFlISk9EVjIzVUx5N0M2NHNjN1JFNGZXcFAyNkVTQlBnSlI0R0dC?=
 =?utf-8?B?SEJnTXJQQU96WGZrZVdJUTlqWkFLeDVjY0prYlEzVVRuWkJsdXh3T3pPZDJx?=
 =?utf-8?B?U2huZGVNMGdlSXduenZLbzN0YlhRc0l3MUZidExXb0RkOG83bHdXV1htVDRF?=
 =?utf-8?B?NGhHVElTZHFsMkl3a0VyTy8vSXN6LzNEVDdEZE56Zm9NYmZzTjRLNzhBbDlr?=
 =?utf-8?B?SEkxc3psS3Z6Zy9DdXRWQk9jRXp3RHc2STNIR0FMZlBxcXZicW1pUVpuTjNl?=
 =?utf-8?B?dDVJanJqdUpiYndoc282eFlMUVRqcUk2Q2FjVjFSdFVlNWJBdHpFbmR1aDBR?=
 =?utf-8?B?SUF5QkUyR21BTE1KS2RXUWUxalVxSUVlTVBVZWcrZ0FaNVJHcGQ5Q3FNaHlL?=
 =?utf-8?B?VnBnd0xSbmNuVzNyMWxvTHJIaG4yOVBPb01SM0FURUpPUUtoZFB6TzBHTXRh?=
 =?utf-8?B?SmpEYTg1QjE1bCt2SHh0cjVXejNjOEhRNmJZNzVFT2NVMnh4MUxFeDJvNkxS?=
 =?utf-8?B?bEJFTFNPSkNpdzhWcllXa1lwWDFFck1NVXdMdS9tcHRhRUFQa243Wm5pTU54?=
 =?utf-8?B?eGlWNU9nbVdWMEpNVHBZMjZpdFNUTlJ2VWJvdS9tQVFmdm5zK08ybkc0MEJR?=
 =?utf-8?B?N0NYdFlhcGloSUJTTkpDcW5BdXJ6elF0UDJuNThseFNPMCtYcnIzZk1ndmZX?=
 =?utf-8?B?VVk2UDRDMloyeVBTcFJoUUdSRlhXc3QxR3NEWVl1YUg2RXFUTEJBdWVBRXl2?=
 =?utf-8?Q?+DrurpVLfuCKqy3BoslRSGUqSfMBZ42m?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2RJSTI1NkZuOXh6MUVIL21XOFh4dVc5dU9zUC9yMTE3NnZuVlYrWDYxWkVB?=
 =?utf-8?B?K1BTTUZtVWVOWVhqWEhXRXlIbzJuM0xJRW5kb05XaEJzK1RzL21NUitQeUhT?=
 =?utf-8?B?SllmL1VpNTBLQUc3YWllN0RJRW1PbE4xTlA3dy9UU2RZK2NBUndFL3h0K09j?=
 =?utf-8?B?aEdKbG1sN1ZYejk1MHl3eDFUcVAyZFJmdlF3MGNSMWVLOTcwVUF4dXpOTllq?=
 =?utf-8?B?Y2hKaUYzWHpBaGhUbnVIdlJFL3lObCtjQWloZHdDYWZNSXBXekNmdy9oNTB6?=
 =?utf-8?B?Y2lWQVBrVTM2RmRWRlVHYkRvY2IraDFjdVNXYURMcFNLYkwwZmhtWVBVOFlr?=
 =?utf-8?B?cllDRW9OaFRiMGhEelZ6cjF4RTN2VXpRMTJhQ3BFTGVtcWdLeXI1L3JTdncy?=
 =?utf-8?B?dFBKbE16aXR2T0ZTZndXcGx2di9Ed1dSd0g3MG95UC9zM1l1RU5WaGV2Z3N3?=
 =?utf-8?B?Sk1ZMzNFMS9ncWo0bWJtWjNzWDBsZEVPblFybGluT3ZlUlFsZFdzOHhjNlFi?=
 =?utf-8?B?V1FpczNWM3U2SmVQaUVIV3VxeDJLaXBrY0hYMDBubWd1MkJGM2xxUlJjd1VT?=
 =?utf-8?B?MEZINkxpc0x3SElhdUtkOHZtY21YL0c0VHlyVnVvb3RCS24wY0JSdzZlQ3RW?=
 =?utf-8?B?UEFTSVYxbHhrMXdMelVlK2p3RGtTcW41dWhKblh6Z2V3UTk4SXp1QVg2Uy9W?=
 =?utf-8?B?c0FUY2ZHcGN6Q01OZXBzTjJ0S2VUNlpmQjJDN29CbUFCaUE3NTlMNDAyU2pk?=
 =?utf-8?B?VUJZbFlsMkRmRm5zTkFPSzVHR2hoSVB2LzhJSVBYMG5QQ0Zjb0xjUkd1Mlpa?=
 =?utf-8?B?VnArVjV0YWtIbFFKU2FiTXJyUTAxK28zQmxJK3lRdDdTbzBqYzF6SDFmUUxw?=
 =?utf-8?B?UmZ4eWcvYXJ2Y0NsNEtKbERXaWh6eUZVWWhNTWdyUW92WTRVVmNwS2lsZWpK?=
 =?utf-8?B?Q3BiOHFwUDBHTjg3S1RWSVVWdFU4djlXTGJFRWw0ekhRWXkwaHE2RUs4THoz?=
 =?utf-8?B?ODVHdEo1Y0NnMXczM3Q2a0RJbEdlelE5Z0Vob0hjLzA0UE5jbks2aUdML0ha?=
 =?utf-8?B?cG5JbkdZWjVDY05xWVphSVduRUJaL2lnbmZjS0tRR3J2QWNDMk5yUEllZVdN?=
 =?utf-8?B?eitDOEZEd0RVekhCS1FtdEtDRUFSZjFoOGc2aXpKdkdaR1hGblNycEpkb3dB?=
 =?utf-8?B?ZmxhZWR4cURGNHlLSnBFQVRpVEN4WldDNEdPQnBLbUgrcUpVNjJFK1ZkbCtx?=
 =?utf-8?B?RHUxTCt5cWp5b0FmbmFrUHBvd2g0alRMYVkwKzhsUGRZQS9GRS9oSkw4Y3o5?=
 =?utf-8?B?UHpybFAzYWRCSjNYOHZnVTIvYm82SW9OUnNsNWZ4eXIwWFRUOUpvMW1tNXZE?=
 =?utf-8?B?Uys0Q0JtcWttNjBCUlgyYlZ6Nkd4MlFKcEhvdnhTSE92RW9xWkVLU3QrTlVX?=
 =?utf-8?B?MTVTaGdYOGw4RzlWcXVzMlNPQ2k1aUMwYmNOWGhEL216T1Byd3kzeTY5R0Zq?=
 =?utf-8?B?R0NURjYxeUFPc3FGZmVEMXY1THN4U0tRZ0hRVVpjTGZ4cGdESHJOeXZrS3ZE?=
 =?utf-8?B?ZlV1T3Rja1RYVHp3TnVnYUtpcU12NVUxc2NSNnBYOHhNa2kyL3AyOHZDaEVa?=
 =?utf-8?B?eWJ4bVBTOEZRNno3Rkk0RCs3amNiUTB4SjVCbTdVR1NOUXg1MmZqUHJCeTNK?=
 =?utf-8?B?TFZkTG5QSGVFcVlNSEdMK1BkSlpYdHd3cW0xZGVFUjFML3Y0OGx0MlNIQzNR?=
 =?utf-8?B?b0FSY2ZJRUI5dWNZZjF3eCtnUERsb2gwd0lOY0c5VE52a2hTZEFYZkJCZ0RI?=
 =?utf-8?B?dndvUE53N1YrQko4bDhvMi8zRTZLRVMydS9hYjJBME1mUy9Ma2lYaVJaZmRv?=
 =?utf-8?B?WGRCTkhQQUs2UkdpWktLR2hJbXVxcStOWmQxbHFoakJKbEtCdXgzN2hUbkZK?=
 =?utf-8?B?eXltci9BTVZTM29BQXRKRXZCM2hTRmdsZjBXRzhmT2NIc1A5NUJaTlZhZW5N?=
 =?utf-8?B?dmtQNHlzSHZxTTlvanBteVZvNVJwZkxiT0pySmlabzM4YVVPN250Z0FuODVX?=
 =?utf-8?B?d3pTSTdRdEhZU1NaQkxmdFBjK0hlZ2xJSExqaWttUEd1ZThXT0hhVHNRUnoz?=
 =?utf-8?B?aS9JMDh1VkltS1BiOGd3ZFlKdFNiNE1pdmJhQ2xqZ0FUdCtYQVNFaG9PSnV0?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E06D116BB879E43AE0B07C5E54CC28B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cY/8ri4G+5pfiITp2YPtJuo+6tL+ry9ugaTQ9WocA+X34xYxVTs+xivzLdU9k6N/Rj8WD+1hXB9bkjU89Zhw9DX9mdSgNpFI366yCkggl/bmZumsKLY/iIWnKjcXjvRlotKflM8bGdThnKBnALoDjyHcfuauDXXbmDwSOlEH7rAM4+00FEdYVAu7y2f98MBh8snXAOZ7ZHuloIYtl1P4XFVNWMgHlBQ+k8z4LYM+qZTuf17kWvGu7EyrjttKvUwrOwsEX2nkzEuC255PZm7T9vP5eH24OTNWdOPA7zEhVKv8Do+yyYrzkYsqosEqqWAbc4AHXUUsfXxX2E7hg+5E2Hz33qij9pR5DxDc/bVIQqZfwNmTDE8eum9sb8qfK0WtQ0ZbCF2iY00pJfhH/fwyAYQ8b26qrLvBV14ZTohUDMhpk/xFBFW6fQJXk8E8VAQ56CnreL+oqANLMByfiKHVIfHbOmkvo9VKvpb/ZucnjttbYl9LIUV3fTIS8KU2vMWZGRnqszl79uYYXzwfgK+LnFFq74QL31deVMC7aNOjM4aHC7pBc1wGGpzP0efVI+SaOg4kt8th2eHy5BIto8XVACuRWh7RSQQjUEHkM3UKx7IvyFJladom2UvB9KrEmIKA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4958c8-e27b-4ee3-63dd-08dd7069c637
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 15:36:15.5410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bphLxgPf3xhyqG3AqAfA0qEAquLmbgrbup8X6FQ+dZukw/OkSwz1MWibfjHf9wiuTZjLCE+ypgPzEyjnTK2mC3iqfac3W9b/5Kw1Q4KNT+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8107

T24gMjcuMDMuMjUgMTc6MTksIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gZGlmZiAtLWdpdCBhL2Zz
L2J0cmZzL2V4dGVudF9tYXAuYyBiL2ZzL2J0cmZzL2V4dGVudF9tYXAuYw0KPiBpbmRleCA3ZjQ2
YWJiZDYzMTFiMi4uZDYyYzM2YTBiN2JhNDEgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL2V4dGVu
dF9tYXAuYw0KPiArKysgYi9mcy9idHJmcy9leHRlbnRfbWFwLmMNCj4gQEAgLTM2MSw4ICszNjEs
OCBAQCBzdGF0aWMgdm9pZCB0cnlfbWVyZ2VfbWFwKHN0cnVjdCBidHJmc19pbm9kZSAqaW5vZGUs
IHN0cnVjdCBleHRlbnRfbWFwICplbSkNCj4gICANCj4gICAJaWYgKGVtLT5zdGFydCAhPSAwKSB7
DQo+ICAgCQlyYiA9IHJiX3ByZXYoJmVtLT5yYl9ub2RlKTsNCj4gLQkJaWYgKHJiKQ0KPiAtCQkJ
bWVyZ2UgPSByYl9lbnRyeShyYiwgc3RydWN0IGV4dGVudF9tYXAsIHJiX25vZGUpOw0KPiArCQlt
ZXJnZSA9IHJiX2VudHJ5X3NhZmUocmIsIHN0cnVjdCBleHRlbnRfbWFwLCByYl9ub2RlKTsNCj4g
Kw0KPiAgIAkJaWYgKHJiICYmIGNhbl9tZXJnZV9leHRlbnRfbWFwKG1lcmdlKSAmJiBtZXJnZWFi
bGVfbWFwcyhtZXJnZSwgZW0pKSB7DQo+ICAgCQkJZW0tPnN0YXJ0ID0gbWVyZ2UtPnN0YXJ0Ow0K
PiAgIAkJCWVtLT5sZW4gKz0gbWVyZ2UtPmxlbjsNCj4gQEAgLTM3OSw4ICszNzksOCBAQCBzdGF0
aWMgdm9pZCB0cnlfbWVyZ2VfbWFwKHN0cnVjdCBidHJmc19pbm9kZSAqaW5vZGUsIHN0cnVjdCBl
eHRlbnRfbWFwICplbSkNCj4gICAJfQ0KPiAgIA0KPiAgIAlyYiA9IHJiX25leHQoJmVtLT5yYl9u
b2RlKTsNCj4gLQlpZiAocmIpDQo+IC0JCW1lcmdlID0gcmJfZW50cnkocmIsIHN0cnVjdCBleHRl
bnRfbWFwLCByYl9ub2RlKTsNCj4gKwltZXJnZSA9IHJiX2VudHJ5X3NhZmUocmIsIHN0cnVjdCBl
eHRlbnRfbWFwLCByYl9ub2RlKTsNCj4gKw0KPiAgIAlpZiAocmIgJiYgY2FuX21lcmdlX2V4dGVu
dF9tYXAobWVyZ2UpICYmIG1lcmdlYWJsZV9tYXBzKGVtLCBtZXJnZSkpIHsNCj4gICAJCWVtLT5s
ZW4gKz0gbWVyZ2UtPmxlbjsNCj4gICAJCWlmIChlbS0+ZGlza19ieXRlbnIgPCBFWFRFTlRfTUFQ
X0xBU1RfQllURSkNCg0KDQpOb3RoaW5nIHRvIGRvIHdpdGggeW91ciBwYXRjaCwgYnV0IGhvdyBk
b2VzIHRoaXMgZXZlbiB3b3JrPyBJZiAnbWVyZ2UnIA0KaXMgTlVMTCB3ZSBwYXNzIGl0IGludG8g
Y2FuX21lcmdlX2V4dGVudF9tYXAoKSB3aGljaCBkb2VzIG5vdCBjaGVjayBpZiANCml0IGlzIE5V
TEwgYW5kIGdvZXMgYWhlYWQgYW5kIGRlcmVmZXJlbmNlcyAtPmZsYWdzIHJpZ2h0IGluIHRoZSBi
ZWdpbm5pbmcuDQo=


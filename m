Return-Path: <linux-btrfs+bounces-12190-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9115A5BFDF
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 12:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 237F77A946B
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 11:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989A525524D;
	Tue, 11 Mar 2025 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lNZ8w/i9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vE8Qkdyf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8182222589
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694357; cv=fail; b=OtX2Pj5TXdyIiEYZsK5w+OgFmV6kCAYg4R9MrQN2GR7Pc1WcPyb/PoPctNik+5Y/gLCfY5sLJVzbZJvIV06pPtr5XXkCPw6oC0nMVxE4HsLGFj6KumIZ3ibKkkF8MQXMijjEOP/BUiWZzDvrohOg7q4SXD+kDXWmvY+2yFwSarI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694357; c=relaxed/simple;
	bh=5fdgn/LVTP8+vGJ21ubxTVMj/y8IiuL73AiT4efuJrU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z5Ycm5J/tEZ8c7ODcBDyy9G2AXIY2fLTPxM9NIFp/UXPMQBYABNShGVq/3ZufwqWFN9OnchsqG15L41B40klCpQcs7+NIak2YXYpzLnymPX3zcmw6p4jkVeU0gFo91TdQasoOzTHeDBlyUwa8+VgbJF5rfs4kirnNHHT278po5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lNZ8w/i9; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vE8Qkdyf; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741694355; x=1773230355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5fdgn/LVTP8+vGJ21ubxTVMj/y8IiuL73AiT4efuJrU=;
  b=lNZ8w/i9DkCBBJbxr/kBeGB47wlQXLTOkruB0svUS53hjsQODhwOd7yU
   cXUcUBBgw+jQvKkhLbD+CZtArbTYgJ31jTc5IOdoGY6iAw7d1SF+SrH+D
   KcVj0mQvN3r2sVnuq8Jf1j60uv6ybDzvRWTbfgKHlZs9Yc2+KKdtwvjl1
   YEg87Xp2AXHpglR2c77ZpMsC8Vm2OOMdsqVHGIqiN2UNO07WwDFBRMDL0
   AH9PfTm6ra9cHScQNv7/4LiXUt9yYKI+TP4bDj9AB1eB5kNjkIyYvdihB
   dsuEepj8D0CSIcbjFTpLVP1j+uyADOWytvI82UAPnz0yzp5QRUUGxt4y6
   Q==;
X-CSE-ConnectionGUID: X7bJZ3O7TyWjOmf2h702lg==
X-CSE-MsgGUID: 7OhKcdZoQCGN+1e07z/Ezg==
X-IronPort-AV: E=Sophos;i="6.14,239,1736784000"; 
   d="scan'208";a="46985146"
Received: from mail-eastus2azlp17010020.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.20])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2025 19:59:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayN6HIwVI6cV/WdTrlS45mFIlzY+qbP7RZMgIjdyzuCNgexV6f1uqqhjGvNtAw7DMV0ud6IP1ECYuFmcyPaVN1MqA4KMmBUbXUkSw8TZF5xSsQXRD4HSiuk57L3CKqM40i0HWs+QOU/00wL0W0RpbdJMS1tI2gRKBm/66rwfOixruQnH/5OSWQIxMtluz54eilby4jprCKT3skYQ2ufJhgpUjRBYQiltKI6bxCbroJioI+0pW7IVgu9Hjw1gwWCh+Lq+VDibS/c7b99wc3vVJtTk+mLcBZ+Gl4EsFL37y7mR05XDJit0K2MZfaYxmWbCTMWp6TsH5BwcgoA2SRKE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fdgn/LVTP8+vGJ21ubxTVMj/y8IiuL73AiT4efuJrU=;
 b=aQXPG5TC6zx3hGz0nyqXZiF0cOZ0ktBIWgIDj266A2PkE3S+a5kzgtmd4SsbVCy/1sGsJ2RreOfUyVDFzOPVSSO7/3dQUoBGavEqgHqa2Ora/u5H2ce5epnfi7Mu1hG3sSivLcLZ73dZE2CsOl+r5Dw/bl115NZmcFYQMdTZvc+DSh09SfzB6jf7LVt42dOvSBcqVsgHlBDAK4ns4FnWEUNpcaShU/amGbw5Iaf1ppkBcB2lam5wWdU9uJW4lWn7pLOHzz7/48t74bqT2AZyNiHZTtWNg+afC1PyVXDufCrafPPI0fCL6q8sM1TltZ9zqm6OOkMN3FEjCfZ8g9ciYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fdgn/LVTP8+vGJ21ubxTVMj/y8IiuL73AiT4efuJrU=;
 b=vE8Qkdyfj3gVVWLb8/PB93dQjdENlfzZjsyka7+YKv7R7T1WeHaOsqeDHxyEi3U/sgXLyfSZt95Vt0Z5z5E76+Q7gQfR6X6X8ofA4umEqLGTz1N5XdvKXWDXNE1hL6bjav9+3YbWwdLFr4HMhrxTgNFL3jatDAFIt3iizyZjo0I=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS1PR04MB9632.namprd04.prod.outlook.com (2603:10b6:8:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 11:59:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 11:59:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?utf-8?B?6KW/5pyo6YeO576w5Z+6?= <yanqiyu01@gmail.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, WenRuo Qu <wqu@suse.com>
Subject: Re: [bug report] NULL pointer dereference after a balance error on
 zoned device
Thread-Topic: [bug report] NULL pointer dereference after a balance error on
 zoned device
Thread-Index: AQHbkWcHHm5kGZj2pUWXjQyYDI5QKLNshJIAgACkFoCAABbtAIAAl5aA
Date: Tue, 11 Mar 2025 11:59:06 +0000
Message-ID: <88371447-4d78-491c-9d86-ee2ad444c50d@wdc.com>
References:
 <CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com>
 <7addae55-e0a4-40c4-b4b5-279d4eb91fd4@wdc.com>
 <CAB_b4sAba_AtdQfM+23LhnL_F038wuE677DZx-1T_Q1TH6rtMg@mail.gmail.com>
 <CAB_b4sCNenuqK79ce7ijSDQzXgLAq8jEe98z4P6_UqAz-OvhEQ@mail.gmail.com>
In-Reply-To:
 <CAB_b4sCNenuqK79ce7ijSDQzXgLAq8jEe98z4P6_UqAz-OvhEQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS1PR04MB9632:EE_
x-ms-office365-filtering-correlation-id: 6fa457cf-3a3f-47b0-edab-08dd60941fec
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a0N6enBmVWpjaDh6dTB2Z3hLRlJOT0xGZGVvOS9jQ0s2aCsyT0dMQ25FZndx?=
 =?utf-8?B?Q2lwdW5jSXdPbHczeWpPVmk5dEI0a2hYWEd1RU8xMXN0eUpGVG9tb1ZhRVRH?=
 =?utf-8?B?cXFQOGhpeHRnNFRrUGVOTHFxUnN4d2UvU3RaQUVNWFFoN1FCL2RYcXhuTmpY?=
 =?utf-8?B?VWxvUWdzL0F0WHRwamZ1NEROd0dUUENBUHFHWEpZVGVtNFByWmRONE5QcjZK?=
 =?utf-8?B?UVJhTUxNSDJYdWIyNFdDNE5sMFhUZ2YvdnN3eWhYaEs4c1FwS2ZnUWUzZjZJ?=
 =?utf-8?B?Qkd2YmtxbXV5Vit6akJCZmpRdDZ5QnBGNUI3S205MkdmMVVFU2FUT0htYnB6?=
 =?utf-8?B?dG1KVlluS1JqdWVJUHYrZUcydmgwa0Q4NnE2cjJzdkFKdDg0U0UwS0l6K21D?=
 =?utf-8?B?K21qMStkYkNxT3FnVHNkcDVsZXVMU0t0QnZ0Z05oSUdHSG9GT2ordlEwbThW?=
 =?utf-8?B?RXFqaVJpN2thT2Q3SkRIM20xT3FlWUljdlVHN0toU0JOWGkvYlQ5cnNXVEZR?=
 =?utf-8?B?eDQwN0cyU1FjVllDbjJ5cEd5UHJKOGNxNkFGR2dHbXFhTW1CWXRSOEVRbnVo?=
 =?utf-8?B?MmhvbTk0VTJ6MjQrZnlDTWJDMnEvL0YvVnU2L2o5eTdSTUxZbExpZ25mV3Mw?=
 =?utf-8?B?QldSTUZqRExRR3V1YmZEcGR5R3E0UGthUjJGcGV3ZEl5Z3o3UFFlYzJLMysv?=
 =?utf-8?B?d0l5VTFFZmx3aGxYUUxObHdwNDFueE9SekxKS3VMb1J3dzJhNm9hM2pvUThn?=
 =?utf-8?B?MnZ6bTYvTGEwb3lOSVl6eGlIVlRicS9hMmhHb0pJVTlMRVJoMC9TbjJqWmQw?=
 =?utf-8?B?SXdGV0hsSm9TRUZEQ1lLeEFxWjIxcVF4aERxR2hNNEUzVDhTV3FRWjJFZjNV?=
 =?utf-8?B?bldUQlAyNithMUhUaUxBVTNOOTZKK2V6a0E0ZGI0cklSWXB1NWpkay9JMHZr?=
 =?utf-8?B?NkJzdDFNUHFXS1ZVbWo2b09iZnJHZG5pdEVHT3lBUXhUZjJjVWpTa1BFdldF?=
 =?utf-8?B?R3p1RVdVYjBqK0RoaUVVTDdZdmN0dnVWTjNjTENpVDg4clNJWXhxemVabXFN?=
 =?utf-8?B?TEFrdlNTaUJhRVFaR094V3kvaGNHQmFCeEc3b1Y5U1N0Undqa3UwR1JSc2tW?=
 =?utf-8?B?S3g4Mnk1Mk42dXJoZEltUGFVN0R6M2NNaVdMRUtkRGZQaU8wUGRpcHRHbGhz?=
 =?utf-8?B?dVdteHJHVEFxZ2ZBcmdLUjFSSkUyaUp3WWRlbExndEVHc0EzYnFEZm8xV0VQ?=
 =?utf-8?B?NU9OMHZPSUVHNXQ1dU50R05uZXBQQ1NsUnhYVnVSYjYxazQvZGhxb1FEVU53?=
 =?utf-8?B?L0RsaVF0MFdLcDZGd2d2aVZlZFViOFNFMHN6YlVwWFVHR3cvc1dSMzI2TEVI?=
 =?utf-8?B?TmVHcHR5Y1I2eGJILzcwMUg5Q3NlNnZGbjY4QWlObUN0YXluREY5Wm8rRlln?=
 =?utf-8?B?WXJWQnFLTGtDVjdud3JCN3p4MHQwNDcyZ0ozVjhNR0xKKytNRHN6YjhTNHFk?=
 =?utf-8?B?bWZiZW5rL2Z3NCt5aEhQZXVwaGZucVpXM0VxZ1JnK3hkUVdLbk9JNHUraEVq?=
 =?utf-8?B?SmphVFY5M1JqTGx2T2ZBVkVjaXUwQUNhazZsTFBUS3R6TXFVSm9tNGZ5OW1W?=
 =?utf-8?B?MERQTnZSazVpL3RuVVhjRHo1VGNIaSs3azB6Z1pYWWdHWFlxaTBCUWxpbkY5?=
 =?utf-8?B?cm0wK0NLdjVMNmRrdXp0VG9mZlBndGdhREsxTC9OOXZHVkJ0ZnFPcXlYMVlM?=
 =?utf-8?B?L0QyUjJ5ZXI5aFJ5YS9uTlQvbFN3MXY2N1pUVkY0RkxQMXordCtWZkxhL0U0?=
 =?utf-8?B?M1hPOHpkMEZyMUtvN2RwamNpQ3EyQ3pWR0dmZlFsTDMzR2R4bVZndkV6OUx2?=
 =?utf-8?B?OUx4TjdraFhQQk1CcS9od0o0UVAzeGNVRXo1LzBvaHBjY3pySkExbXp6SmR5?=
 =?utf-8?Q?AVjUd8grFkNlyCf5zkr0WM2wdiKS4Uw4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHA5Q3hhNjczbVNnYzJOUjVRQ2p5bHdNNmNWaHNtWUpoN0ZzNzFVaDNEc2hI?=
 =?utf-8?B?Risvcm8wOXdUUGZlbXhLSzVsbjFTVGs1c3VKUUUxZS8vRXRlSnVvNWp4NEtK?=
 =?utf-8?B?bEVnZXh6RE5oK1g0blhMc1llbk14bUFjTExDTmdPeElTeFVIYzVnWm9HRVdo?=
 =?utf-8?B?dWxGZUhEbnZndmdxYjNqMGlBTWNzaWxsVzRhek0zMDd5TzJpSVpzaWM3MUVY?=
 =?utf-8?B?dnZFL25FdXVMaHlzd3BRMCs2Q3diWEdmZzVzNmhxMGRRaXp4THRFS0M3Y1Br?=
 =?utf-8?B?akhoL2xyemZoTkhpSUJIa2FSWDJ0RXV3LzdWRGRDbEh2dUdyQUsvSG5GRnUv?=
 =?utf-8?B?MUdhcnRMc0dOMWhEQkx6a1cyaTY5bjhBN0pWaUpNWkl2S2FFWXRNeXBvLzMv?=
 =?utf-8?B?SWxCR1ZPbFRhbDFUdkg3UExUOGppbFQ2Ky9tU3NHUDVGWVNTUmtwVEpIL2Fj?=
 =?utf-8?B?WU9yL29WdlF5VVQ3ZlUxSG5zbjlkSlI1QThxS083cFpUcURUOWx6S3BtZGZ5?=
 =?utf-8?B?Wjk2S1E5Wks3REFDNGVCcFNKYUZCOWRSVldTY08wbVU4U3BhY2ppc05Mdkls?=
 =?utf-8?B?eDJnYVlOMEg1WkpxaGVmVDNkUk1RbWNISkd2b29ScHZocXZJekhtUnJJQnNR?=
 =?utf-8?B?bStnbjQyTmJSKzdKNGE5Y0E0cjhzOGdTUFBJYk42d0RlWXhxa0hHQVhRRktx?=
 =?utf-8?B?YitXWmhrSWZpTGNRSFdWUXc4YWlkWlh2ekk0cTA3OENjbWFUZzVWZ0FVWjRa?=
 =?utf-8?B?ME0rS1hnamFiYW9jWXpPbWJiQUE4dkFaNjRmajUrZllXQU5ORjRaekFuWHho?=
 =?utf-8?B?dVNnLyt3QjhFcG1ZejV1SDVPSUQzc2ZHdGJnellZdTdZcWhUN2hNbGs4azE3?=
 =?utf-8?B?cERWeUR4aUVWck0zek13NHA0K3hET1crWnBXdGpMSXQ5Zm1FUUkzZUJjL0NF?=
 =?utf-8?B?N0JVUVp5ZktLMWhOZDI4QlZObFN5MEVadnorWVg4S1E3d2RiODJ6NmhNRUY3?=
 =?utf-8?B?S3JGWUtYaWh2d1dDb1laUXl0NUhrOFJuRHR5bEl6clByT3hGNHQvSlZ1Rlcv?=
 =?utf-8?B?dXB4UkZodytHZHdleGZFa1BzOHYrckhTUEVxQTdNWmhEYmpYR2lOMER2SW5q?=
 =?utf-8?B?NGxtM3Z0NDVJNUo4dFZ6cGM0ajgrVytLYUVsMXhTYkpXckhiYXRpSnlueThI?=
 =?utf-8?B?MHhEV3lKZmoxUkYwaWVaWXFxMCtWK055aXNNbWttM0hQV055WHV3R0U1emt6?=
 =?utf-8?B?WmZPdzVsWlMrVXkxK2N3QzhPa1hDZ3ZpVGJrR3NWcGxBZU9xNmc2YXdCNk9C?=
 =?utf-8?B?bUx4bHhRY3V4L29VUkk1ODJ6Z1hkeE9JL2FwVEUvaVpBK0pPRFYyMEtNNGlj?=
 =?utf-8?B?RWVHNUpIY3RyTm9PMDFNd1g4ZGJkd0Q5WHEzN3I2VW1EZFIwVzZqazUrcGd2?=
 =?utf-8?B?SVYxZjJBSXZ1NkJKa1NROG9BY3BzbWduQnVSYVVLbXYzbVV1SUJwdHpuTm9H?=
 =?utf-8?B?bWJ1VjdQbCtUUENreERsR0xTNnd6bFNQTitseTF4RnRUQmFkblROc3FMV3RI?=
 =?utf-8?B?bnN5cmlvQ0hnbHN4eGFhaXN3Z28vdDZ6QUR6eDhBOXpPY1VWSzg3dmtXOGc1?=
 =?utf-8?B?am01dzZhNmNtSzUrTndGVFVLaW82OUNVVUttQ1pIL2NRV2dtWllYR1JNRmFt?=
 =?utf-8?B?TmVrRENlQUx3MmVnZ2xXWUFCSUFtZ2EzYTU2bVNteUJaSzh4MENhVGN6Tk5G?=
 =?utf-8?B?WVBLTG5aWkU4eVllcTdVUWNSMUM2alRkRTlDQlBLcEZSUkRQTVJBWmZyQnQw?=
 =?utf-8?B?cVU1eEQ0UG9YOTkwdG5ZT1lqYTdqU2Ftb25sU1UzK3VkWEZFTnFxdktsRlo2?=
 =?utf-8?B?azhERmRPNUFzaDJWR0tnOVJneUxoVDMveGRYc2FweitiOXlTcjFybUduUWJX?=
 =?utf-8?B?SE12SE1LTzZzV3ZXYlRIeTNxWlcyT0w2TXh2czhSODJHeUxDNi9WTSt2SzBh?=
 =?utf-8?B?bUVvb1R3cFNwSXc5M3JrYUpHLzFHaEF5SWdWYld1TUc2cDluZTJPZ054dVdv?=
 =?utf-8?B?NzRwMDNNd1FFR0Q2L1NTSm4vU00yUWs2ZnpOZU43S3RIcnJneDVhTzRSVTRt?=
 =?utf-8?B?Mm9FRzR4U0YyMTREc25HaHE1b2VwTHBsYkdxNG5uTlVJRG02eGMwYkpxT0xu?=
 =?utf-8?B?aGgvNm83VktEaGFXK2pZWmwzVy92cFg4YVNucWNrTXNtejRTOU1sQmVsU21N?=
 =?utf-8?B?SS9CTktmcVhRUFpSUzNnM0plLytBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8763288CCB73C45B5DAC4CE2F51BBF8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iBsw1c0xDvh5r7tALksF4s9Gyge+k4DCwfek9OldgPEeRz8aBrk72f1c0vuh/GdcHsm8f/Fh26nQ184PiOdtjcUyGqq2MaJgUfrITAmywRjyHW9tHOFaL+RR55x84v+iSofomBqwnh9bQO6ikhX5Vufa6edUckMZHkzeL0YLdi7hmGaK2aAMkyPH/72KfG7P71WKRoZYCxH8oBT2MzElzUe5Gc6RMZOSmOmkj9wV3+hZQ6rdNrD/1Kp1fN9e2Fufa4tqY19ji+dqrBpBVVfEUHvB5EWeFFuN+pU7u/1Qfdo21XrjXF70l2sdNbN3Be118TXU1Ih2PuYBDZdVk/X+k9gEvld2CHES/AVE+JAdVnI6HERzXog/xEIi5+cCiDwEEGNO5RcRo+HPIaqK8gFVw34F+7ONrv+iqKeHjF1uQ2/ynIApOCWFGqgcYmuCwlgYWLLwjoNbtPAUm0kzGH1p681f/oriA7AzmqA8RYuqdHROH0IgkbPZPdg1ObN81KRoupQFUn13bnZLkeiiFsZt3AImMWWtNo/5UJoDGXnVaQP83o46z0EJSFxNfaZ9vBXzxeGJi4ZYVF4Lhsx+WpymxvZndygCqSTgrPsEfimavv/01rGNq8QZP4/bcMbjFnZe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa457cf-3a3f-47b0-edab-08dd60941fec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 11:59:06.3458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzQsyUPk6bPqCiq1IevYNL48LpSVuU7OBOE+Ui3/ZxgocsAHiECvlJkPupCAG/XTAetlYF4CKSRLVFCx5xYeFx78VKBYI1oTi/9BAZPRN7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9632

T24gMTEuMDMuMjUgMDM6NTYsIOilv+acqOmHjue+sOWfuiB3cm90ZToNCj4gSGksDQo+IA0KPiBJ
IGRpZCBhIHF1aWNrIGdsYW5jZSBhdCB0aGUgY29kZSwgaXQgc2VlbXMgdGhhdCB0aGUgbnVsbHB0
ciBpcyByZWxhdGVkIHRvOg0KPiANCj4gZnJlZS1zcGFjZS1jYWNoZS5jOg0KPiBzdGF0aWMgaW50
IF9fYnRyZnNfYWRkX2ZyZWVfc3BhY2Vfem9uZWQoc3RydWN0IGJ0cmZzX2Jsb2NrX2dyb3VwICpi
bG9ja19ncm91cCwNCj4gICAgICAgICAgICAgICAgICAgICAgdTY0IGJ5dGVuciwgdTY0IHNpemUs
IGJvb2wgdXNlZCkNCj4gew0KPiAgICAgIHN0cnVjdCBidHJmc19zcGFjZV9pbmZvICpzaW5mbyA9
IGJsb2NrX2dyb3VwLT5zcGFjZV9pbmZvOw0KPiAuLi4uDQo+ICAgICAgaWYgKCFpbml0aWFsKQ0K
PiAgICAgICAgICBiZ19yZWNsYWltX3RocmVzaG9sZCA9IFJFQURfT05DRShzaW5mby0+YmdfcmVj
bGFpbV90aHJlc2hvbGQpOw0KPiANCj4gd2hlbiBzaW5mbyA9IG51bGxwdHIsIHNvIEkgdHJhY2Vk
IHdoZXJlIGJsb2NrX2dyb3VwLT5zcGFjZV9pbmZvIGlzDQo+IHN1cHBvc2VkIHRvIGJlIHNldCwg
d2hpY2ggdHVybnMgb3V0IHRvIGJlDQo+IA0KPiBibG9jay1ncm91cC5jOg0KPiBzdHJ1Y3QgYnRy
ZnNfYmxvY2tfZ3JvdXAgKmJ0cmZzX21ha2VfYmxvY2tfZ3JvdXAoc3RydWN0DQo+IGJ0cmZzX3Ry
YW5zX2hhbmRsZSAqdHJhbnMsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgdTY0IHR5cGUs
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgdTY0IGNodW5rX29mZnNldCwgdTY0IHNpemUp
DQo+ICAgICAgc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8gPSB0cmFucy0+ZnNfaW5mbzsN
Cj4gICAgICBzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmNhY2hlOw0KPiAuLi4NCj4gICAgICBy
ZXQgPSBidHJmc19hZGRfbmV3X2ZyZWVfc3BhY2UoY2FjaGUsIGNodW5rX29mZnNldCwgY2h1bmtf
b2Zmc2V0ICsNCj4gc2l6ZSwgTlVMTCk7DQo+ICAgICAgYnRyZnNfZnJlZV9leGNsdWRlZF9leHRl
bnRzKGNhY2hlKTsNCj4gICAgICBpZiAocmV0KSB7DQo+ICAgICAgICAgIGJ0cmZzX3B1dF9ibG9j
a19ncm91cChjYWNoZSk7DQo+ICAgICAgICAgIHJldHVybiBFUlJfUFRSKHJldCk7DQo+ICAgICAg
fQ0KPiAuLi4NCj4gICAgICBjYWNoZS0+c3BhY2VfaW5mbyA9IGJ0cmZzX2ZpbmRfc3BhY2VfaW5m
byhmc19pbmZvLCBjYWNoZS0+ZmxhZ3MpOw0KPiAgICAgIEFTU0VSVChjYWNoZS0+c3BhY2VfaW5m
byk7DQo+IC4uLg0KPiANCj4gYnRyZnNfYWRkX25ld19mcmVlX3NwYWNlIGxlYWRzIHRvIHRoZSBz
aXRlIG9mIG51bGwgZGVyZWYgYW5kDQo+IGJ0cmZzX2ZpbmRfc3BhY2VfaW5mbyBpcyB0aGUgZnVu
Y3Rpb24gdGhhdCBjcmVhdGVzIHNwYWNlX2luZm8gc3RydWN0Lg0KPiBJdCBzZWVtcyB0aGF0IHRo
ZSBjb2RlIHBhdGggYWx3YXlzIHdhbnRzIHRvIHVzZSBzcGFjZV9pbmZvIGJlZm9yZSBpdA0KPiBp
cyBpbml0aWFsaXplZC4NCg0KTm90IGZpbmRpbmcgYSBtZXRhZGF0YSBzcGFjZV9pbmZvIGlzIGp1
c3QgYnJva2VuLiBFdmVuIG5vdCBoYXZpbmcgdGhlIA0KLT5zcGFjZV9pbmZvIHBvaW50ZXIgbm90
IHNldCBpbiBhIGJsb2NrX2dyb3VwIGlzIGEgYmlnIHJlZCB3YXJuaW5nIHNpZ24gDQp0aGF0IGNh
bm5vdCBoYXBwZW4uDQoNCkFzIHBlciB0aGUgY29kZSB5b3UgcXVvdGVkIGFib3ZlLCB0aGVyZSdz
IGV2ZW4gYW4gQVNTRVJUKCkgY2F0Y2hpbmcgaWYgDQp0aGUgc3BhY2VfaW5mbyBpcyBOVUxMIChi
dXQgQ09ORklHX0JUUkZTX0FTU0VSVCB1c3VhbGx5IGlzIG5vdCBlbmFibGVkIA0KaW4gcmVsZWFz
ZSBjb25maWd1cmF0aW9ucykuDQo=


Return-Path: <linux-btrfs+bounces-17608-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D9EBCBC9D
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 08:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC5D74E2B6A
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 06:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD6323506A;
	Fri, 10 Oct 2025 06:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ipsz75tM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="s599RhKm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CB33F9D2
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 06:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760077900; cv=fail; b=CF4Hwa9+DwG6pEZFMpA2mWYj8P2j6LomHS+LE+nYTErsFyoLtKu5oISNuVTbEK1LKkvAFWnCElc1pAzpiBZjZ43zL4CAG5/ez6+j+kypjWC1J4kezWP22zBOy+J3ZmWEztjLm+rB4RGyZRz4pvUEr+/VtZ/Z69daGChrCoLGUCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760077900; c=relaxed/simple;
	bh=iNdwKiEoA3fVz1iF288T06bFCg5ekkGe8MaFEJKUMws=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HumUbfu2MSvK0KHmtXEBV9jUeAmXcv0O/14/m9/YVfl3g0tJeQTQu4PJCyj3D96FELpXZZajsFkeK2CoV+lfWJyHCvzsCopbHPABfwM3t+8D0ZKeBojj+/D4suRgRp2fNwVh4kckl3ROtCS6fVPcXcVkXmXbdoumUJUA3VXEGPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ipsz75tM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=s599RhKm; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760077899; x=1791613899;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=iNdwKiEoA3fVz1iF288T06bFCg5ekkGe8MaFEJKUMws=;
  b=ipsz75tMf3UeHDWb9oh8BCGeYLfoHx4MxEwBhdUrI/YHhVrGsYtCEiu6
   8q4zBu8ZSzDb58sc65QD/7PiUb5rAlhG0NkRofme3ErcQ8FO6Pqmwufv1
   BDj10trqy1idlPOkKvJPeGkr04tcn4AhrOhpEyETtakC6RevJu6XLfOoJ
   dgq8gZCsaK1/93YQOyfc5+Me5W9sQ7nR8sjFZhX/Lpj+0uZWHdzMkbGr/
   MJV2NOLTzJe7SLkXhb44R5bL3PZcvxhhaafN7nknRd3VfMucDkgXwpWe/
   rYfP05RYhoA1cKNrq+QvNY7Z/cDdk5uPmvePgDUuf+rgHDltiJbGc4B1F
   g==;
X-CSE-ConnectionGUID: WKCyn+MhQl6SECXjIc2ieg==
X-CSE-MsgGUID: pwKx5zJQTvWrbzUevRKAsA==
X-IronPort-AV: E=Sophos;i="6.19,218,1754928000"; 
   d="scan'208";a="132854076"
Received: from mail-westus2azon11012034.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.34])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2025 14:31:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMIIV1/i04Yrttqmbp8okzO+hTyptP+8PdvyJPSz8TwxJSdgLV3Lys82n3xHyb3FjZNSWdN3fq78vSr21h74UpaHzlr/p0Lslq7nOPd95MMDbi2mZl4QDSoueV6/sQOj4XVSh5k8yBchMes7dT4JN2Pb7S0ZKSbc581nZsgLZ1TxeyH3g/rQqMuFu9OHL+EZlvpuOOjFPdM1r/bA28t628fIbWfBHRYL+nhmZ0STLuyxndFQWloFi+K+dTUGioO6i3z+Q4O8krt0f+TcAClw0vTxbc2ZV2q3bqH8yFgYdbtia7DMrvEA+kwQJ6hkPXPAvnNmKLDshLDTkBuIsMk54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNdwKiEoA3fVz1iF288T06bFCg5ekkGe8MaFEJKUMws=;
 b=Z28u6gsFLRZtwAcyKDohFIVtG6I9+hb1JdJCFRI3A8nKRloOwBnRkhIRvvPNVwDa7hYUPnU6NeNQk4JBWiyMlkIAh6d3uPfCM03bzXR4o5yP9Pv7Xq0R4SA7MuurHim76mi/xZEY3cqhndjGRmVB/dKYjY3QQD1zXZMOYwPZGwCSGXDxoSq17a0fkYeHzu5vpgisR7iU7DOKAAyG8Idj2DR4qAWHepYr9u+4SWKHX+oHTjekl3KM552U/TsWIueNpJWVbT7RHHyxshcfKOyoOmqiHmhqvuohUs9ksZKAqHeLsiaj18gioeBk3Crw9UlQ88wiK8K2prkV9c9n9oo+kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNdwKiEoA3fVz1iF288T06bFCg5ekkGe8MaFEJKUMws=;
 b=s599RhKmkVz1V0QCS1zc9ZxizomDOh8tR/Avkm/r3iMZafdSXv6TqyGcg0MWO4D7D+UfIPowCYi98sj69Rgr+8PdTrDlgxusKZ6V+JK115inqigm/nFAZR84KDqlyq6wKglZgBHV+ksCaCkebpAKJGN+pRsDte5rFx8HWGSqLzc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8609.namprd04.prod.outlook.com (2603:10b6:510:240::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 06:31:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 06:31:28 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v6 2/5] btrfs: reject file operations if in shutdown state
Thread-Topic: [PATCH v6 2/5] btrfs: reject file operations if in shutdown
 state
Thread-Index: AQHcOaLieWOo+Lt9h0+8lG8Bx37C67S6674A
Date: Fri, 10 Oct 2025 06:31:28 +0000
Message-ID: <63941ce4-c01a-45c6-9f94-36d57682bbaf@wdc.com>
References: <cover.1760069261.git.wqu@suse.com>
 <dd1578ec017a4d96326bd2a2c3b1a65d35ce6fd5.1760069261.git.wqu@suse.com>
In-Reply-To:
 <dd1578ec017a4d96326bd2a2c3b1a65d35ce6fd5.1760069261.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8609:EE_
x-ms-office365-filtering-correlation-id: 91a71dbb-c56e-4d1e-7740-08de07c6a4e0
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eUFOSW02MkxGbm1GeXdpdWp0OXd6VjZITjNoM1RFVVJvc0FPWGY0QkcraEJU?=
 =?utf-8?B?VktwcHgvakV0bE5qQTEyclFaNnpnZDlWWGVPUEVHdGZOTml4bDJKSlZ6L293?=
 =?utf-8?B?TUdydENHYlM5cGZPTUtnM0JWTXdVUUpRaHZKOXhpL2ExWk5GbGpxUENkWXA1?=
 =?utf-8?B?V3lCbVo5UC90WkVkbFpseHZwZSthbHJVSUhsamhMdHZxQk5ZbDlCdDBYNHpC?=
 =?utf-8?B?QUQ0dHZPSzhudjJTOWRaM3YvSzFNWW0yMTQ1Zi82Q0VZWW14dkdmTjJ1R3Vm?=
 =?utf-8?B?VnhEaW9FWnhFNHZlQjk5M0ZTaVJEQ0NydWFlZUU5SE5sNXdVZEF5eW56YXg5?=
 =?utf-8?B?VzQ2VzVTeVlnUjBJME9JTk9odE1sQVNDMlZjUEZndUY4YVpQNGU4d3pmckVw?=
 =?utf-8?B?MlkraTBhT29vZlphcnp6RURvem1MQVZnYWN4RHFxelpCOFhWNVNvS3Y1V1VB?=
 =?utf-8?B?M2RoNWJib1lHdkUvSEk2RXlCcUtER3p2NU9lOEtaemRtdU5XN3Q1VlFiYU01?=
 =?utf-8?B?bWR6YVo1MUJoRjhURENNd0JOcnpjeEo5bElHUXBLYlJOQzc5bkduYmtkNGpX?=
 =?utf-8?B?djFHT2J6aTBNWWptTFA2ZVBCVHlkVm0xbFFKMTRGR0Fwejlnc1pOYzZFSUdY?=
 =?utf-8?B?ZWdaa1R3d2poNlVmalJEaGVwQklaYVhtdGZSTWpKOFowMTlyT1VobEZYV0c1?=
 =?utf-8?B?WjdOVFJLMUNxNzZtT2psK3czTTMrUE0zMUJYOU5YNlRIR0VMN0JPVkd3M3JW?=
 =?utf-8?B?L0tBRy9VRXk4Y2U2eTM0NVFTNVJ5aHc2ZGFvdXhpT3dJQVEzZ2FyWC95aE1W?=
 =?utf-8?B?RFVrZjA5M3lTSERBenN3L1RBS2dUT1hZTVRaekZoYktIa3ZwbE1SWmNBL3o2?=
 =?utf-8?B?VmJMQXR2QnFiNUJtMU5NQ1M0SFR2SFo4ZzJFSUpJdm9FRCtMdEJWbXVOcENp?=
 =?utf-8?B?RWJ0UGJjTFpGQmpkdkd3ME9vV3ZrSi9nb3VBTzAwUnRjSTlsb2F2cFlEaG82?=
 =?utf-8?B?VmhJL3dwOVlpZG1CVXlDaWs1TC96emdnWmppS1FTSitPVSsrN21iM3I0c05s?=
 =?utf-8?B?dlJURWxzbHRxMWxoM2s1aVFraGtsV01OcitGUVdYRDB6VXplMFhIY1QwbGl2?=
 =?utf-8?B?OFpGR0d6aml5aUQxZENDalY0K3lxWVBmbW9OVDdXR28vMTlUMk80UnIwOC9D?=
 =?utf-8?B?dlU3Y25aVjNGRXRWZjlBK0MwM1VIVmVXbE8vcEs1UnM0Z01pOWc5bXdHUWI3?=
 =?utf-8?B?dWNpMXk3OVpDQjFvNnhVN0tkYnhMWG1WbUo1UDZyczR2TU5QWVpLQy9VckpB?=
 =?utf-8?B?aGNOSzExVlVhcmpaZTZ0UERBUUZJcy9IMFVUazZWRy9kYlQ0dGltWmMrWitI?=
 =?utf-8?B?ajY4a2xPckswRWxNVzJxRlAyN3BTa1ZPNkNqQTM1eWxvd2V2MXYvRlNxUEwy?=
 =?utf-8?B?a2ZnUzBFMEZGQlVQaVpwY0gxNXVmbWlmZHRabkIzV25ndG9zdCtDc2dZR01Y?=
 =?utf-8?B?OXhxZEZMcVl6M2NmcFFZRVR2L01wK3k2c3YyYXlrencweUJ2eExJSFBTbkt6?=
 =?utf-8?B?VytldFdwN2V0WGtweWFvU0hxYWxzYWhmL1RBQk5jMWFUMGhoTW5PeDJnT3FK?=
 =?utf-8?B?d3l1djlXOU02SiswdnEzeGpsTGgxTWtyUkI2dDE1bEZQQlhMM2ZrK0xkSjEx?=
 =?utf-8?B?aC9HM0h6U0FGT0JNQXpnUEVJcWttZmZza0d5L0MweWNpSk9LYXorMGEzcVRO?=
 =?utf-8?B?VXJCZVhTc0QvbHNUNEtrNE1BbmJDOVlreXkzblBDV3FyQmp1bktjSFZGU3pv?=
 =?utf-8?B?SHNmVzZpMXRyZW5ObDBRekZFVG41UVQzM1BYanVXL2F4ZFNPTVpoa1VldURm?=
 =?utf-8?B?bW1aNDE0MTZyTWxMWEFVNUozQnhVYUxyVTIrRmRoTG1YdUkyZDh2UVFDcyto?=
 =?utf-8?B?ZTNLb2V6RTRLRi9USWFJMjd3ZjBDdWVFUGxvMUJhS252Vy9wMUVxTzIwa1lH?=
 =?utf-8?B?OXVWcDl1eUhTOGQ0V0FMMFlBeEFHeTRuaE80WXFPVGR2R09GRjlWY2NRQ2gv?=
 =?utf-8?Q?uS2LD2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzFadVF0YXdrV1hGQXFzb1lncHJZKzJsSnVQNDIzNFJzdWpneE1sZzl5Wm9H?=
 =?utf-8?B?Tk50TkswRFdnaUhvUTJBRmc2UTVYN0dNa2xiamYyMzBuSjE0UVVtY1c5cFpq?=
 =?utf-8?B?ZDh4T2RCYlArOFdrZHdLVzFQU1YwbTViaU10T2pmMFZLYTl6MC9jUlJ4eC8x?=
 =?utf-8?B?V0NpaVNBWE9GRGI0N3pPbmdZY2J1RjZzZGFNU3g2UXhzUVVIOUtrdlNGdk8x?=
 =?utf-8?B?akMxVGN5UmRRUWpxZUM5Vjg5QURWdE5PZWdXSFFkYnd3aENKa0RUSnp5RUwz?=
 =?utf-8?B?Um1RRzM1aHZmN2xpUDhrZXhOYngrR0JyNUhpbFZETjA4U2pjUXNiYTlGMTN2?=
 =?utf-8?B?dmxGWk1ZNXVQWVIrMVYzYVJwVDFZa3c3R29KK0RLSUJ1UlNPQUptNHY4bncw?=
 =?utf-8?B?MFFTVVdxeDd1MzZKWmdidGFBTTdRVGRiZW5WR1Jad083T2FzM2p2MWt3SDlp?=
 =?utf-8?B?YjdSREQ2WGJwNVVNd2hFVTM4cVN5djVhMlExSkk0Q0ExZGtIcmlYWUx3aG9P?=
 =?utf-8?B?aVd1eVNGWitEam1qWElLWEUwMHU1ekFKUWRxQkVRT2pWZ0sxY0hGV3RvT1VY?=
 =?utf-8?B?K3B6OE1nam1JQisySElyTTdBemtGaE1IbldrMjlRQVZMb0Zodzdvd3ZIWnM1?=
 =?utf-8?B?YllBUldWektyZ0VWSHEvT1Fkd3J4OUlWQjgxTi9qMVpjUlYzcysrWkdiVUlP?=
 =?utf-8?B?SjdVOXpNbFFzQzljRXl2aDN6Vmp3QU5qTzhwNC9BUjFWblR5QWNxZEcvRGJZ?=
 =?utf-8?B?ZnlzNVVXSnhVYndvdEFWUFVzSCtwYkNqaVNibk5SNVVMbGxVR053dFV5aXdp?=
 =?utf-8?B?Y1RqTVp6ZUludHQ4OTAyU24raVFBU2s0N3hyUFBZcEhiVko5cyt4MGpRRlFj?=
 =?utf-8?B?QXJQeWlOWnFrSGd6OUdkdG4xN3VkMVpyQ2E0dkovOXIrMk5vS1FjUWsvTEE5?=
 =?utf-8?B?N1JCNFByaXVraGJRbEwyRHpoY0hiOVpXWTA5WGtCeFN1NEE3M2ltelM5elJQ?=
 =?utf-8?B?dDFaRGJ0QkNmbkRQa3BpV1pPdVVsUnMzcTg1VDlTUlpibzB4S2ZhVlI2Yisw?=
 =?utf-8?B?T0RIOG5MaElQTmQwYTNhVXJibVgrYXJ4MzIybm9ISURCZkNyWExISnAraGor?=
 =?utf-8?B?Vkw2UDUxWDNON3p6cHFtVGc3bGY2bS9XeUxPcG4wcnA3Tit5SXljenh4SHRM?=
 =?utf-8?B?clE0WmZOK0dmYzdFNjVJWjZMNFE3RWVORW5nUk5NQmNLSzY2dUxnV1czbmpx?=
 =?utf-8?B?ZDlUVk1wdXRsb1JDemtJeS9aQi9oOTRNY2crS1ZqSnRKUDc1cXdEQjE4aG1M?=
 =?utf-8?B?S2hjQWkxZVRMNk54dFArcThIOU8yMWJsdWszL01hQThMOS96RnVHUU9xb2N2?=
 =?utf-8?B?U2RTREhxUTl1UG1TVXdoRU5sMDlHQkZnbk1FemRQZTFtNE5JZmZUekw5VHFp?=
 =?utf-8?B?b3RhcUdsYzhoaC9OMkpzOVJlbUxlMWNhdGkvUXhhMFQreW02Y2JJdHY2dWFH?=
 =?utf-8?B?THNkcS9kenlVWGU4RDVKSktHSHVoZzliZ1FBdkJnR2dTSFBaTTNDckpUblUx?=
 =?utf-8?B?alM2dGRLaVo1elN5elE2aWkrVkRtZ05adVJjREVGL3dvYUNYN0M4Y2ltNmVt?=
 =?utf-8?B?ZHdmam44bmRGWGUvK0YvR01yemFxWHVZYm1vdVIzb1BsNGdCSVM0emJnYkpK?=
 =?utf-8?B?N2VUamlvdGdORmZNWGRmY1JHeUNXbG1lODlkM21Cd1NnVUd6MDZPRW9CS1BX?=
 =?utf-8?B?Qk10T2o4YUVsTGNGSXZMcGtLTDRDM3hFeEY1NFBzaXNxb1RJL0FjRlhoUVJD?=
 =?utf-8?B?dXRKUElkditWc1VhNEFHZXg1NHk0RlNUVFZpVjQ3clBkRFdFN2xndkQ2azFv?=
 =?utf-8?B?SzlrbTlGTGtrNXVxSncwaWJyK1o1UEREbTR3TXRNNUtWMGdsVEI2ZHFxWUV5?=
 =?utf-8?B?dTFNYndhMWEzeWROcGV4YlhXOWhRY1pob0NmdnlQVllmVkZvSjhNK0N0MlRk?=
 =?utf-8?B?SDExWjRiY3FCUGdqVUJBQ2wxT2VXTy9KYVRjMS9lc3NOZGhFek4xNWEra25F?=
 =?utf-8?B?MEdCNmFRYnFieFFBVlRQc29CSUxGTnh0V2k5N3NaQUxucExMYnBSdHpHZkVu?=
 =?utf-8?B?NU1DTi9UcFp6VVlLdlZocjkwOVVlWGpXbExWU3YzaU5mRzdPUmxrdHQvc1NZ?=
 =?utf-8?B?TS9oUGlZK1BsMFljTm9hdWNVREdoWnBrSXlPN0U2RmFpYlp5RTloa3U0TVJ3?=
 =?utf-8?B?cEZsYmR5Wlc2eFBEWHBYYXpsU3V3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8290F1B55A2EB41934C249E1442AE33@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U4i1Okc7U2pyI9/LDuztkTENjMdmjZJK1JiUQ/3OZx36CrUu6ZCyvFbsYSQeU8f4Bq/DprFJDl5Yc9NQ6Mp2ECqGodz4AAbVRkmxKclWF0Lq3gEwFZHmmSrWxFvPVTmU4Fn5zoqlWVC4Ni2x8UZJ+crstx0jWPwXEZ3J+reXJlcrSWOYUW7sQ4wOgHjkbQW/TXzNAnXE8C94VYeyk28frjMWXfq0la+FV/+ns7L34jCzaNPYGej5MfNGVRdi8fjkHkc55pDMOvYcIS8BnggZXeIvNnF7ZZKNqteEQrMwSUbxx0EP2UUejnP8Tnm5ibhiIFQC3NPthLj4GeERai5ADdnDc7qX5vnD9TERxtT4npHX4cwixiUyXUYGWFaC3BtFY7kLw9RhfbDEXu1RcpL8cCRNGOMM3iI2o7PsdX+Cc5OTmKxh60gx0t8eTAsJrjfUCat85jXBzbSI1mH6SNsf510Etq9TZR7eyrrRLeNc/svk0i6WZJKe3BICMWO3ycpMBq7y5HEA7KPXQIEfUM9lYrp30vV6oIxIHzCpZozzkseVZ8O2/cOU52J9bSwdIt0+N4O3zdJHmA4UvpLmOxY48GiqaYSo8Ch0qRrizKlt1//2u75IK7VJP3H86qzoiXWf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a71dbb-c56e-4d1e-7740-08de07c6a4e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 06:31:28.3894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OUAOGGs/qj7PKUx96FQC82uOKbDUB6YW1qAXxB1uxWfJs/isKF5+4vf7xVd4+GaHlReh7KYJ5Or/r/uGSFkQNTKz1tUYJAtxe//LngFZYGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8609

QXBhcnQgZnJvbSB0aGUgbml0cGljayBvbiBidHJmc19pc19zaHV0ZG93bigpIGluIDEvNSwNCg0K
UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQoNCg==


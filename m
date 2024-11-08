Return-Path: <linux-btrfs+bounces-9389-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9439C16D2
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 08:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50CABB210C3
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 07:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107621CF7B1;
	Fri,  8 Nov 2024 07:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a0ON7+NU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tipc+nzL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3221D0426;
	Fri,  8 Nov 2024 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731049734; cv=fail; b=hMkCm+d277dzc7l+fJYokLQ9TXsGSIrDpmTyOIMV9sf+IbcbFmMsh+a9KQWxcJ/iaVxtCkSRlfsHKWUkHPqzfkysAblF7hs8wQ5nxf0YB4QlKsBApSpWF2CHVQt7NIKbKe8gJ9o9Z91RgvT84Jj4MhD58Es5S80jsOCvIpTJ4zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731049734; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZL3f/OcR0kbR4xpMPmYV+h36F4TxtzxTKjdbCWQg14uRMf06IL57xlyNh/ybiCPGMl/OpkLXqG4RQVqn18oXaRPRl+alBzAk97qTsUfIzgRNUHtff4JhsVEgopWRJZznkpKFgco7dOahghzZWgu6dMKqiZ1Fj7fJe9j9Y/qNH+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=a0ON7+NU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=tipc+nzL; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731049732; x=1762585732;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=a0ON7+NUQhzVp7hl+cQdRDtWFHhCZn+al/6hUUqT2sET9wECA5mhCHR+
   RUmLL0tvDXmc9oDkbaogo95sOfaLkN02OppA3+TaQnGwIh/p4k89ptzyr
   0gaez26gRfJs4iCh0Z8Oh71inFjmEQTX0sAbeujGEIRohx9oQlVqizbqQ
   +o9NdCftiKcSl6w6s8KP9D1uoH9De6K6yXTskmUVTF5y0YNkAB5hhheO3
   OWy8lCNyJhpwqY9GB3HiRR/N1en63SNhawDF44mMTeSa0a3dMzP5OdLKx
   yjTWt7KfWwYREMopEo8HI3TdRalAWorq69CaZUmT8sKD0AOp/fPb6rRrR
   g==;
X-CSE-ConnectionGUID: cQ/vU+a5S+eTlqggDzN1fw==
X-CSE-MsgGUID: k+y5oQuLQZC9EnqMXm2UAQ==
X-IronPort-AV: E=Sophos;i="6.12,137,1728921600"; 
   d="scan'208";a="32061947"
Received: from mail-southcentralusazlp17011029.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.14.29])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2024 15:08:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYtXwYcCyy/8KeUQoCPrlfa5QGtt8L7yeSvpyZNTvoQb/EhAbGL2H0sCbBzkcsRmzjJA4EOnjU0L1OMJM61lkkh9Fq9OJt1HKYT1s6OkQkhcAJi5kcj9AoWlNJiKw5knIiOJ0xPAjeNousjyzyMdkiLn7oSHkR6Nb3b9Fi24v1BdyVWXD0R78Ju10FPhRIaWNXDHwlmBc54avrXFN9R2XSXd1PUzspNsf1CSw5xV+PNljx9Wmzp4L+QC5d4wqYJaMDXf40h8l1mO1yUiR7hX+S1LPQMCKUdvVv0X0h4Xg78bawlHfG/7bhycsgksoROFarWyg8XmGRih4JGjofqaxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=UwHFHACX2zB7c0V8yrWypBWtFa37w+tgTaF1qsGMcfFC1F6JytrlomNtJ76Hz/me0cSFdOY0JNIUmyUN7dWJVRX5PeJPIY4CF4Pj/0Jyy+b6b8D+HCVrTIByUwz3hcu7LfXc7uWIWebNYBZVvxbBK9Tf0mvHfyPenPEoAHN9vS2lp6PAr7wgGPAHSSAXgitaH4evxPHFbJqrylq7B2cLNHftn65rQBYjYbGSZz/CsN6nk0o7HCvKinkYb1z1YNbCS4rr6KU1mmSdXgeGK0lyW25Fw5Av3Fs9dGNEcL0S8SZn0cR+SGLrcEokbYMG07SMdBVDcfT9nuy+4wap3DuSHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=tipc+nzLi+H3yBBitVlog6FHlZMS+gBJcRppsIfXby97AAYIbWyHuvq1Al+oqr+kxMLbGK8kPYDJbFbeTaNDk8bbPrMc3buheUeFRRt7NHOueVenOWyYKTlV7UxW4lQf1KQuTQWeRoABvS0Sz8zkwMlf/wfXTBXxCFNXVzE27VE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7400.namprd04.prod.outlook.com (2603:10b6:510:13::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 07:08:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 07:08:49 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Damien
 Le Moal <Damien.LeMoal@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>
Subject: Re: [PATCH 4/5] btrfs: use bio_is_zone_append in the completion
 handler
Thread-Topic: [PATCH 4/5] btrfs: use bio_is_zone_append in the completion
 handler
Thread-Index: AQHbLoKhajpuVelch0OiRAjcIquhirKs/RiA
Date: Fri, 8 Nov 2024 07:08:49 +0000
Message-ID: <d92137dc-94e1-418b-8678-e9f8e6cc0d11@wdc.com>
References: <20241104062647.91160-1-hch@lst.de>
 <20241104062647.91160-5-hch@lst.de>
In-Reply-To: <20241104062647.91160-5-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7400:EE_
x-ms-office365-filtering-correlation-id: 6fab0c91-36b0-41f2-2bc4-08dcffc431e9
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3dCWW1uWWhLQmxIL3pOajhmVkN6Y2lJSzc3bVd6T2V1UUxGU05uQUd1bjBH?=
 =?utf-8?B?SnN2OFJuUndhQlFQa0xpQmZxT0UzWk5sRXdRQ3pPeVF6R1lSNzdrYnI1TGUy?=
 =?utf-8?B?SFpMYmFpanFUU2V4QnVvTlcwY2V0K0IweDRFQ3kwUVRUckV5VFlCYTJ4ajRE?=
 =?utf-8?B?OTdaNDNvTkxIOEF3NFZEWFZKb0RuUzBvUXZnWHVOUTMvOGlWTzhhanJrYkx6?=
 =?utf-8?B?S0VnMU9TL0RkL2JuSXJDdU5uMUdvV3JEYU9WczMzV285bXd4c1NYVlloUmlY?=
 =?utf-8?B?ekZpRStjNnNxS2d0WnNRbDVLSkRvekRldm1Sa2ZPd25ZM0NoVzlDT2ZDKzZk?=
 =?utf-8?B?clNBT0JjTElQTHptRC9PL01wMmk5ZVBFdWNubXpDTUFuL3NJOGFBNkVWU2d2?=
 =?utf-8?B?aDhVa0NDR09KWEMwWHZIR1BTRUFlNFhSUVAxRklPZ2VsWnBaSVpwbHZBbWFX?=
 =?utf-8?B?cnFCV2FEQWsxWEc3eU52MHJQS3JTNzc5d1VKajJZeVRNeXE5ZUlKVW1iWEQ3?=
 =?utf-8?B?RzBIaGJXRUNrcWs2UlRWenF5bFllTm0vNFZWOEQ0bFdJQ0RjM3Vlclhod2J4?=
 =?utf-8?B?WGtwR1pLNGxLSmdoUkdIR1Z2U21UdGl2bWNlMGlNY1VOSXpucndvbXp0YVgy?=
 =?utf-8?B?dmJkZThuZlNBenA3K1BPQUd2NjJDMXF2YzRNNFFSY1RpczViYmczYVpjUlNn?=
 =?utf-8?B?akx3Mks4OHdCZVNiYk1Pb1hPWnFxUzk2UW5DcnVMYkc2T1NHbWF3ZytqWUFM?=
 =?utf-8?B?MTRNUVpDRnhkcU5kQXA3cDBqMTlpcHYrNHdYakFuN0g1bHJ0WXlSUnBJVlFJ?=
 =?utf-8?B?L09pWXBRR0IvTTJHTm1NNWs1aVJjM2JuZ0hpWEYvc2JzRk1JY2xzMkh6blc4?=
 =?utf-8?B?bWhsVGx3TlJKNnN2UFJ4VzBaVWN2WS84allaWUNWWmVCbGZVcWN1MnNVTzVu?=
 =?utf-8?B?Nzl2VjhxeGJHazBXdDZtQXNYQk9XOVJON1ZxM0VXT2g3MjJQZ0MzbUxZa1JQ?=
 =?utf-8?B?RHRobXVPbWM1K05XWWMrTzhYZjVRTGRRaDdnMG1tMG0xdkJuS2daNVpreUQ1?=
 =?utf-8?B?U3dhdnJUT1BZRk9XSExEMTd0ZmZrVXdGRlRobi9uSEhZQmxwK085TjdKVWJp?=
 =?utf-8?B?RTA2cEQza0laRnlRMWdtd3BES21NNVl6ZTJML2UyN2o3bnpING5qOHVmNGo2?=
 =?utf-8?B?RmZ0WnJISE1HTnk0eS9qRXFqazN1MVJWeWNKS2dWaG5sTllpL3YzaFRwbUYv?=
 =?utf-8?B?NTdwcUFFQTNvbGJhRG1yR2VyaVZ5dlRaalorVXBjVmdDL0t0bWw5ejlCOURW?=
 =?utf-8?B?OWpGTmk3bm5TWEpRSFVaN1NTc0ZOajFCeW1pem9BcWFicHhmcHRNTDBkZU0x?=
 =?utf-8?B?eTZoMGZ0S1lJdjRrMElOeXpQWGQzL3RtQWlGQUhjVmFWZklNTHEzZ3VRZmZt?=
 =?utf-8?B?SUl3N3cybVY5U1pKdWVVdmFFcnhlckpDZmVVNkNQeXNNcUFXVXZlOUdMSnJY?=
 =?utf-8?B?TS9sd1F0OUY2OVFTQjZZR0luZlgydHF6MU51VE5zaW4rdkJLV3NmcFZDam9y?=
 =?utf-8?B?YkgwekpYdXRYdEJ6QWU1dHZ4VHRwQVYzNHpObzhrMkprdmpuZ0RPOS9BeUpG?=
 =?utf-8?B?SlVxeE1wRlpac2xiRlVraW12YlB0R2VlLzlsbFpFeFpzNnAySDlxZWFBUWFo?=
 =?utf-8?B?Qmx3VzkwYWxoT3JwWVhLNFJEUWsrc0RBQ0E5azRhc0NBb3p3UE5iSnVSM1k0?=
 =?utf-8?B?MlYxOEthakdMdWdIdmhSU1JOVmpZemFOV21iK0pjWENXR1JaaFgzaExoYkhI?=
 =?utf-8?Q?zTVVgey0HI8dcMoT2tSRNT9eRfzlKbIzlO0U0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGhnMHdJWVViTVJPdDM0bDZkQUdsSk84U1JYYklCdEdianZiNEREYmMvWUpF?=
 =?utf-8?B?d0tELytNUGR4ZE1xR2Y3Y201MnZ4QndtSkZlZlBjU2MyTGJkMzF5eG80VXhl?=
 =?utf-8?B?SnJNYnpHR2p1ZmhYazZiS0ZkM3lVQlY5anF2a2NHMi9TRVFxTXE0cGsvcFRJ?=
 =?utf-8?B?Z2svY0ZtcXEyRVFSUzNIZmx5STYvMVpPOGJvazJOMUlSVnlWV3I4VEczN01M?=
 =?utf-8?B?blhtSytDcWRUQ21aMUg2RjFOSmFuVmxmMlF2WEw4K0YyNk1YYUJaVnpuNUNl?=
 =?utf-8?B?T3Z3djNLZzEvdm54QWV2Q1NBeS8zVGQ5OGpyUTI2ZTI1aGFxeHdKMFRLbjBF?=
 =?utf-8?B?ejIwdlBZVWZUSmhhU1NOK3FCUjIvNTB1WVdiK0dwSWxId0d5bGtWLy8yOEVx?=
 =?utf-8?B?S3hsT1VueUlpcDQwYWU1MFQ4ZkZmd0tTbGc4aEFyR2tkY0ZsTy9UVUNmTHll?=
 =?utf-8?B?UENTT01CK3hkbHlsWFE1UlkybG1mZlpOY3Z1VmpZTXFrUjRlQWZ5WloyaFY5?=
 =?utf-8?B?V2JqTXFZK3VVYzM0ODl0ZnlCelUvZUxLVUxyRGRZVGRZYUpaTk1BUzFJMFdM?=
 =?utf-8?B?eElwZkEyQVNCVm9pOFRvOG8xQmRVcnl1MkFpZTN3ZWNLblpuTWxaeU1YZVVo?=
 =?utf-8?B?RUZuTGMxZ2x4NDZtazMxOTRCZERHQmZQenVHOS9GdEY3QnV6bFdLK253ejdo?=
 =?utf-8?B?bEpqbU9XOHArUXRoeTdaQ3lFMEV6TDBYZ0ppeHJ5NHRYRHpWcW8yMVdTcWVN?=
 =?utf-8?B?SG9LY0xUZ283WWpjUTd1bG14TnIwcVkrSHpOTHlIS2gyV0xGd3cyTnJoM3pW?=
 =?utf-8?B?Z3JwM2s3bzlNQzdCQmlKK2Rua3psR3J2aERwbm1CRWwvaTRVcldYczhPby8z?=
 =?utf-8?B?Q244R0xvcVlDemd2SUxOczlEbEo2ZjNyRXFaTVU1VmFmUWg1UU02UG92bHhs?=
 =?utf-8?B?TDNSbzl1U1RpaTdVSTFudTRiTmlMc0E0NHJBaWZkK25KS0ozK2tyNjBhc0s5?=
 =?utf-8?B?L1duTW9zbTZXcGNrdk1mbkhCUVk4Z2JtOFFjM0I4ckJwQWtHQ0ZTUFJHRXdW?=
 =?utf-8?B?RGY4aUlpYnF3SFE3UjhyeHpjU015MlNrWm5md1JtYnhYd21KZUtUVmJmbDJz?=
 =?utf-8?B?aDRzTyt2cjFmcDFnWERhTVdVQktqS0IxVEY1RTI5Q28xWlQyOEEzZW1GaHA1?=
 =?utf-8?B?QUFoWjBPU0hlbDhrTXJrdW1SRDNteHQwN04vMmVEeGtCU3ZMSUZOYmtmdWda?=
 =?utf-8?B?Z0J6SlVvempuOUYrUU9SdmNOdEVvRndFbHcxWndtR01GdFV2ME9vL2JNV3VK?=
 =?utf-8?B?RWcyMlo2RjVaRkZyNDRRTGViUVZ6cGxxQVNGMTUrRzQ4bHlnNlBJQlo1N1pO?=
 =?utf-8?B?U1ArdTlFN0Zqa3l3TGR6ZjFQcWVEWUgwNU1OTy9OS002bSt1RGUrY05DeHN6?=
 =?utf-8?B?WHQxdFp3QndqdHQ5OVBnU3pReXpwelBoVVE1WW9lNnYvVzVjdXBEUkFNWm1M?=
 =?utf-8?B?bFFkbmJTSHYxV2Y3dFlsKzRRdlVaTE5XaE4ySDVnaWZvNkhrK0lucWVsdDlU?=
 =?utf-8?B?c2dwREdtR1pLSitBaXNlL1VidThnNjJmWlBxR1lzT1FZeGovbmFTSDgrckpi?=
 =?utf-8?B?bDByZVVldnhPZUhUWlAzNUc0YXBKQm5JNUEvLzRoMlNncStVbmljbjBvM3Rq?=
 =?utf-8?B?dE8rcHNuWS9WR0dZd3g3U3VLY0t1b2JqOEVsRmxqTlY1SnBtWUJOa2ZnN0d1?=
 =?utf-8?B?UXBTMVY2TDJTbjYwU2NUZTVGZ0djOHdhaU04K3NFdmE1Ky93bjVDcDE4V1hy?=
 =?utf-8?B?b1hYMkRlSlk3V1Y3c2QvR2JGOXNDTVpMR0xnRnRUWndpK0hmditIQm5INzNH?=
 =?utf-8?B?YWFVcER6VG1LMDQ3WEZKczcrM2sxSndNckp1d0VJRXZMWDFscG1KTG50Y0V0?=
 =?utf-8?B?ZjU5bmx4enp1dXJ5L1hNUTJ3UnFaTkhGN0p0NzJuQTlySTR5dFQyRzhHMFlx?=
 =?utf-8?B?Y2dJa3dWTTVoSlZWTGVkSSsvY2hpbThraVhSdmVkNWkrZCtmMFplQXJ5NGRN?=
 =?utf-8?B?U0puL0MrUS82bW1Ib2o5dGdQby82U3Q3ZjdwR2FWZ0ZpRkJ0SWJFcDI4Zmlt?=
 =?utf-8?B?bE9ZekVRTmxsT0ZCQzB6UUlVeUp6WUluSFBLNXl1SUtUcEZEMzR2TmJ2TjB0?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D5EBEDFFF5CD74D9DD963E55C6D6C38@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sGAJdttAZXv5dhwoByUy/9PRgkJa4b/4T7b3kbieziHYrdHU/E8ylHf10SOw/pXdg9B8ZhUUvITA0kX4ratRREviAd5LcQx+Pyw3Z7FpYURnHY2xOZx8GwwQfTnWTISJmzW9UfZ6Tg1PXt2PQRICnl1AU3XoC+6ojq05N+uctlYFczCW5W3SEwmsj7O7niQlEzE02Es4JC0d5gZ/Mbb+46qBvBWWwR99i0VrRo5DueM3DNN5zawglJgclVNvegpXyTR7WiKWFtipbJ06Ykih+RuXm1zXuCbzrj5jRtFWZPIkQn+UWq259XDLzX3LY3MAX2oBHta3gmwaJOfmvjhokd0bizGCC+qh77jgRE5yB1OyIPv1CVZSlcxKmlYiGfqzWY/PfLYBq7BSg4r050HMffwIQLpMipRk2L0oYUICZLlArvNIdH9lpRN3F01fPKQLfdvK5aWyjysp+O+AX0B3T6LilmZI8Je1c1ZOCtpEa4gIzD3PM8M4MV57wSdKHtFMZinSMqlsuSY3HxQ2gEYJok3WC1tuStDfmkBue6XXFk/vPlHLMjrOLUnb4xYs+W2aDUs/DuQTSC0iQ61QLTrnxFKeV3Q9cYu+oxRgyfmsBGyXYSji3xLbgjSHCVVxpw/z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fab0c91-36b0-41f2-2bc4-08dcffc431e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 07:08:49.5660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fY4AtesbsUYjZjhj87TzUVzxtp34C4Vn9w49mu8sVRbhDcvP8NzhxZa6EiBHkxTwUE3OEcjg57xncdZT760u4SEcCTtGzBULBleoOfXFa+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7400

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=


Return-Path: <linux-btrfs+bounces-8548-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA5A990071
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 12:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4EB61C2327A
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 10:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9921414A08E;
	Fri,  4 Oct 2024 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RX6YYyyH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fgfbtuIU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF98146A72
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036195; cv=fail; b=l901HtKd+PpkAUkXTny+xCHnRSmeLgTNgx75VRQ275gs9X+IYPs81ocxJVwyjOUrw8HpQCvgpoSUXgLFSYIkQ7nTNLuWoVnCY/jT4JGthnG19ewMRxiLJMwDLQZJPWRtmCRsApwMV2GZP7aGySVq1rZ7o0ONiM2UBXjynGpurFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036195; c=relaxed/simple;
	bh=u5IpMYABI8uZIsPbixWax8Bs4pOOdH7ihbSdag/yEkg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ldw6+vbSyhju9NttRdSF+HrGSNF+3yXc6TGQFi+VnzO16YHwjc0d2HvQyyvaWQ0PAWckTHsvKMSSW+uLHH2zOTw1HOdbSYm2Bw/9KbaMdT4DTurv8spP3IeDwemwi1nrJfoeWo/n6tLH9I679z7WFCF9mfEIlLsKHn/jnyHCk6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RX6YYyyH; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fgfbtuIU; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728036193; x=1759572193;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=u5IpMYABI8uZIsPbixWax8Bs4pOOdH7ihbSdag/yEkg=;
  b=RX6YYyyHw3aYsO7silZQR2XaiNmUUFojY5r+Kuf0pe0/56k+cNfQ8vRS
   05uOmMTcn4WB5WXkVnrXPm1juIQ+SelbgyqdSiyjYLXgRN+Q3zurOCLlk
   rKebvEXg31qknXZiGaeAZhEUbb7qliFJWsEjiweJ71Fpm5BVuXe9DNuoB
   7PiSPoFiKAYESK9yE+zUhpMPyw+r/mQe+GemsnXrErEB3NY6SOcjUB5Ky
   z6mpAFWpEtuRWITCaoggFZMEBtOjKlrQuIAcXyE/+MO0byYI3lc6OP/7F
   7HgQ14QvIieyym77msMAJqn6fmXdYW+S4Ng9qDa39cJLuyG9ZJsfFQ0oI
   g==;
X-CSE-ConnectionGUID: CoYaa7FJSHOKjaof1YTZaA==
X-CSE-MsgGUID: QJGE9/zsS7edFYckoE9+Ww==
X-IronPort-AV: E=Sophos;i="6.11,177,1725292800"; 
   d="scan'208";a="28248646"
Received: from mail-dm6nam04lp2047.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.47])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2024 18:03:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2pEH8rGUWiZ12alCeuM+JLo9HJysDI1tqQXnm5NL8blpk8cJ+i1nWvmvQ/pytCNV+iF1yyaU91N9pWEG2FcvBiTphkixh1Fe+4QwkmoLE5eAkPkOFLrQB4DoU05jsJhnKW5Mm7RlYia6nSsPlYQZ0GEt0zMIefsxnDqVupmI8prNz2X2es7wmRngfzQlIfYwfmb2oPNimMSyR6wa2C+9yByKqaRQw4Bv6Ge0Pu96vwHomVtBRNUwRLJSE9NNX2KN0+ARkw1K0d4THvceVjIdQMfNorNrN/VDg4MWdqc+b26vIOg2h5Lxhc4jTH8/yXWmULo82K7/Tn4dxqRwwDrHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5IpMYABI8uZIsPbixWax8Bs4pOOdH7ihbSdag/yEkg=;
 b=kqzo5xLATHhkfTuEowjRh6j/tFDH3C4Ksnt2md9KfQQckqxscUiyUweFPDekqI2GF8hUVSojIeXHYB3/xmoM5jC9U/4wOrDhwTUJovNb1X2D5GU4zCdMKcFXLIFp4VNdYnjt1Jo7ZIt7AQ4QCeeewLXOb4IKhjvgV4L+mXAUsBz8zAPqkYNNO62NtkhC6hJHPCvoG/udn2hg+SUgPDaxnnLC/qozx3M+krBYgPfy3kMqgZ5avwP1z2FuMadFaAedRrZ9ItTf3oEdviJEpTjz6HsRfroassFKbZyV9ZjjCdNhpix5PXp7j9ZCpKgIqilbNpz8u8ChiRFeqfraaYT1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5IpMYABI8uZIsPbixWax8Bs4pOOdH7ihbSdag/yEkg=;
 b=fgfbtuIU+3lw/JjjrnsVd1M1zlZ0qGYWXZ4gxWR2Mhe3XQh8uc30An5k5WOWyZz9DKSWUNuQJOPkcpJqcvmJmPt/yp3CJvkAi06XK627T6T+sJfoHRIpvQZHDOVwIlETmbt+kGs21kpB2kETjEpioS51A8ctKsKK1vuN6GZ+ojY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB6499.namprd04.prod.outlook.com (2603:10b6:208:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 10:03:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 10:03:08 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix the wrong rcu_str_deref() usage
Thread-Topic: [PATCH] btrfs: fix the wrong rcu_str_deref() usage
Thread-Index: AQHbFRLz/+YgYuyYtESzXxpqPQdJT7J2XxKA
Date: Fri, 4 Oct 2024 10:03:08 +0000
Message-ID: <ace405db-4089-4fe0-b9dc-ef7bacb08f09@wdc.com>
References:
 <a4a0faeba1d195f2eb71fcaae388f5976f822dc2.1727904561.git.wqu@suse.com>
In-Reply-To:
 <a4a0faeba1d195f2eb71fcaae388f5976f822dc2.1727904561.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB6499:EE_
x-ms-office365-filtering-correlation-id: 8081e9b0-db26-4a6e-2c93-08dce45bbf65
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmxFUFhYeEl1blhhSDVLQy9PUzlERWhBajllVTJBYVJlQUliWm9yWEtoKzhN?=
 =?utf-8?B?cDNGcUxlb3h0ZmZaaE9DQWhMSlZmd1RrSU42RS9LU1gyU2U0cnBNSGdEVU5N?=
 =?utf-8?B?UjRIdThTN0F1OUJLcHh5RDdyR0tLQnduQ2F3YkYzR3dmRTJKZ0NTNFFVQVNv?=
 =?utf-8?B?enRDWHViendYTzdIdTBxcStHbTE4bEg3QmtRdU5WTFNDRVlYbzVrVkRPVkFt?=
 =?utf-8?B?VHdyUjRmQWhUaUVqVFR5Q0FndXA4MllxOU9MUVUrVnVralJZalhkMU5ZV2Zs?=
 =?utf-8?B?UVJwMmpZZ2I3U0pEZy9WaUw3WlNhRi8yS2lOMVR4OWNURkxzN05JbzlzaUVS?=
 =?utf-8?B?WmNGQ0VsQ0dCc0pvS242Vm1LeFhDT1ZmTGt3RFZwN1c4OCtCK3YvWUhDbHFn?=
 =?utf-8?B?NlJqUUZrak14a0hUYllYdXR3dFYxb1o4N1QvcnpCbitNWmxXQ0liTGdMKzV0?=
 =?utf-8?B?TE1vVkE0TjJ2eE0vb2J3R05xYkdiQkMyc3IxTlVkalFoVS9nbzQvdDkzM0Vi?=
 =?utf-8?B?eEh2SitPYmtaY2FXTlYxSUdvRVd3bU1BUkpXZHNmem1OdTQ3TjkxOGdGYWYz?=
 =?utf-8?B?Z3NHcktMSWt1dUhYMExZb1lEVnE1cnJxUy9TaUZjb0FQV0hnL2J6UzRxY2VV?=
 =?utf-8?B?V04vQlBTVG9VWTNNaExVNmdFOGwvMFl0TUF0Z3ppK3RIZHEreXpZVDc3di9j?=
 =?utf-8?B?ZXU2anVjUktic0FSZHdINTBnbjR4K1JqQ3ZVQXYyQkJNMjNLVDl6bUNMRVR2?=
 =?utf-8?B?NkhVOUN6OUtBMmxlbjl4aTY5NHdRVlZ0RStkWll5Ly92bHdNNUZnRkRWTkoy?=
 =?utf-8?B?c0JKSnBoa0lnY2dxV1Z2N3IveURtTktLNHdPTkRZeW5uTmNNRk9qcGc5eUVl?=
 =?utf-8?B?cmNoUFBLOSt2MnZtMTNSc29sdEo5MnVNeXpBU3dsQ3pabmMvWHprSUFBRXhl?=
 =?utf-8?B?RjdOVjY5RTI1R29GUytPQkpJV2dCc0w4RE1NRE1hYy9LdURLY0JzWDE1cEw2?=
 =?utf-8?B?VVNGOERQc2tFQW5jcDJwaE1UVUhjMjJwWVZqc0lZNU5kdmlNaWdMcXZlS2NI?=
 =?utf-8?B?UFVubVBpZnpjSlRDVFBrbHprbGVTb1grRk1jS3VXZ2JyOWxVYURvSk5zMmRM?=
 =?utf-8?B?NnZrSXhpZGd1RFZpSDlBUXRrVFlaTUZnNHorYWJoNThaT2RhVytqWXBKckhp?=
 =?utf-8?B?R1FMa2k4L25Fcyt3Mkx2b204R2NxTUlmMG1lTm9XRkk3SGtxdm1LKzVBb0RT?=
 =?utf-8?B?RTFjTUJhbk1RRTAraDc0ZFZrSi9uUVVPckNNbHloNUF3MTBWUEhYblc0ekRT?=
 =?utf-8?B?TzgvaUpCcFhSTDRjWTZqQi9sZHVHeWs1Z2RvM2pNU05ab3dHYkNFMHYyT0Jz?=
 =?utf-8?B?cDhodERPVjMrMVZXRjhuNUNtaVRJeHo4MWVtWlFFZ1FFT05CbTJIUnNLc3Ru?=
 =?utf-8?B?WGJyMWxISEdMTGxTbWNyS0NkVXl4QmlxY3BpYkdHZ3FKeFV5WnFJd0xZY0Fz?=
 =?utf-8?B?Um8wUWdPTVlNSElGcnI4aHRmaWhFSThyMzJUUVV4UlV0Y0tPY0UvaCsrdjZQ?=
 =?utf-8?B?eHdSakVPQVoxUExBS3dtR0hIU2xWMEM3cDhNVVhYYW4wS3lncmd3YTUwQ01P?=
 =?utf-8?B?R3NYVjlvWnljelJVb2tiQTZubTFBNkJLTnBsc1JRbEdhNlRVc1lUNllyTDNL?=
 =?utf-8?B?a0t5Q21IY0ZtaDVUYnBGUjBKS0lRTmpITmlyWmZCanFQVDZNOEY5ekFxMVRu?=
 =?utf-8?B?MzNZQmU3dmlhVG42QWlVbHVJdkxzam5idGFhZ2RGcVJyQVE2aTBFa0pvOXlV?=
 =?utf-8?B?TzhBNFg4R0lUbEZOc1RWUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UThXYzhWZzBoSWZMT0NrV2hnZ2lOUlEvL1FHUGhSSHJaYmRJcWpWd0UxUW9m?=
 =?utf-8?B?RFIxYVlwa3E1SWFaUEhPWU9GTXo3Q29nSzZ1YzZ4Tmp4TnhJV2pSWHBZR3VF?=
 =?utf-8?B?N1BIb0Y3ZUpTcVBMdEdiZ3liMjI0OWlHSFVhRjVWNzB6eHBsUUtsSEwwR0JT?=
 =?utf-8?B?S1ZjNEZQWnFZRlJkaUQ1akN5cU1vakEvSEtOdm5LUk12Y2xrYnRFc3dFeHVI?=
 =?utf-8?B?RFo4U0lhbHVBQWJCeHk2NU1GSXR1UloxQ1pSYVl5djMrK3pNTm42ZC9ZWVFp?=
 =?utf-8?B?VGhQK3AzL0VqL0V4dmVpdnVjNmtXeXd0a2R4a3M4MzBCRGh1QUV3WGpGVFB5?=
 =?utf-8?B?MDU5S1J3QXpIeWFmTTJzUThKQ0ZLdi8vSDlzTlJ1ZXpUM2JQOWZ3aCsyUGVr?=
 =?utf-8?B?c3lqQmlteUVUck42dStuUXlNQjFvQStRVWtYaUt1cGp6emxPM3luZWZMNjdH?=
 =?utf-8?B?ckxtT3dZOWU3Q1VLTDdxc1lnZENMbUtiS2RORjZXWk45aGhNN2Z2eTRWNk5n?=
 =?utf-8?B?REFobVdremtpdmlsM0ZBcEd5NW1CRjhoUkNJZ3pYTDYxckh6SnhnWEtXanBp?=
 =?utf-8?B?eUZpSXJrdjdzRmkwQ3QrVGVFaVI0YzRVcTVOOC9CK0NMS3JkNlhpOStQdVB5?=
 =?utf-8?B?TENlbTFIaVpNUmFBZGJ1OGVCQjNSNXo1NVZxRWU1NUJyQWdZRXlZNVlZZzlr?=
 =?utf-8?B?Y2RHZjVTTThuRkxOQUhVT010NGdTaVhaRDNSMTJmb0w0bTlRajRNelVtMjRv?=
 =?utf-8?B?dlZOQXl4TzVVVTRtWG00aE1ab3RWVGdvTWRVZWlLUUFOL01pYjgvaFBJQVR3?=
 =?utf-8?B?Zys1ZUlnWVFOd3luWHozZUM0UmNxSUgvVmRHY3RRajVCaG5sZVh3eHhWM0ZS?=
 =?utf-8?B?Qkk5cnNVcUlqV0s5dXdzN0RiaXBIaVUxZFN4cUhmcVEzV3hjUHdOcWVUOEdo?=
 =?utf-8?B?V0xiby8xYlFhUlkxSU45elRSZ0hUc3ZqZFAvZjF0cWYzNnFqM3N3V1J1Zzk0?=
 =?utf-8?B?SnZXNlFyRGdTemNjSFlqRDEvWkRyejJHclRhalV0VEFBVm1NbE94Q01EM0Jo?=
 =?utf-8?B?bkJIYkx0aTNxY3lSbnJGNlQ5eEV0VkpTZEcrbkRQMGlVdG54Z0grQVBQWW9u?=
 =?utf-8?B?Y05GZVFwcHpEeWQ3RDVyeUtyRGhtWnBycUptTlNKTTNkbGM2clNveGY1bEdr?=
 =?utf-8?B?M25wajdZYVMxbFhWTVgxc0IxRjVyV0FPZEV5UDdPd3hTWUh2aWVDZG5hdTBT?=
 =?utf-8?B?TkQrS3Y1UU50aWF4MTEwci9jdmIwRk5tOVUzb0JLVGFUemFxMzE2S2xtVDlz?=
 =?utf-8?B?WWVLS3ZUejk1M1JaTmFqb3E4Y29vSzhoN043bVREd3JpNjdTdmFmbktRNFJw?=
 =?utf-8?B?K1VhTlcxVCtHZnhHRlIxdm9HTWFBS3NXblp1ZnA2dWxHaUovU2lJMll1NW43?=
 =?utf-8?B?bVMrVUNmb0J0aG9OR0JuZ0dNZG9Ma2ZKem5KbGVYMmRGT0hVOGNsZG55aEhX?=
 =?utf-8?B?cFNYbmFxaXAxTHR4emhHb1IzZXcwNTVSL1hsK0c1bTNzTENRb2lOQ1JSQm04?=
 =?utf-8?B?MzBKeUIxVWN0Kzh6eFFiSmg3R0dLWGVtUTZJNHFlVGhsR2o5MXJYMHBvRlFr?=
 =?utf-8?B?U3lib3FUM05HWi8xY1hEYTZUSFlHQ2x2Ry9UK041dExxUUFvVlZFZDBRNU4z?=
 =?utf-8?B?b1RyMDZueENmeVB2eDE5Qzk2UFNGMHlFTHo5TG5jeWpwQWVDVFN6RTNSN09i?=
 =?utf-8?B?dWYxdHFLUDJPUEUwS2tRY1graDE4UkwrL2RFRnB1S0hQUTJnSmRkRVdwd2VH?=
 =?utf-8?B?dkpjUjM2ZWthcXNiS3gwY0EwWEJ2bEZwcTRRT3hGTkJsR3haMzF6SVh6OE5X?=
 =?utf-8?B?cXN4MlN2U2lOQkkwQzRBd0VDME12endXRjF5TlBEdUdUMnZ2MCsva1B6MUsr?=
 =?utf-8?B?azRESHY1dVFKWVFLdUN4RHhycFl5VUpNU1ZERzRWMHpKdW02bVVvdkFqMlU2?=
 =?utf-8?B?NGNSSHc2L0kwRThRS1FIMjFqZjlXWGtWTGtOd0QzVTRoOU9uUDg5OE5CbVl5?=
 =?utf-8?B?QVhXU1ZYc1ppVC9Ib01WRGd4VWt6WHVjdCtzYndwWEprdkZmRENCOFZ6bzAw?=
 =?utf-8?B?U3k2a3pKYnI5NGpjRWlCV2Jqa0tqUjVFaENEWDl2ZlU0ZG1UK0hzcUNlK1dp?=
 =?utf-8?B?WDJkMjNGelNKaklMMUhzbGJra3drVkMySk9IUkFZWnEvZGNRbEt3ZXZxdy9p?=
 =?utf-8?B?WHl3RGoxblBuQVBMRTlmRFkwUWJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2B345CBDE8E5F4EAA3176FD46EE2E67@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5jT1jvlUxggRMr7gq9bqcY5QKzGXNert7LtaUtbRUsB9YKDT+sz2NpAqvOJhthMjkrn9fQASpxRoQNrVLOwuLH1lZavOuS6nsmH2duNUF74nXf6VyVwMuf0H1xuthS4STNliZZiHqxa8uYx+STXoWDhQCBB7OgEdqv0Fo69PLSr4sdB43YK9lsfSy9JGKTivI6WwWwVRwv4v3cT0xWYKGVEOw86eQWb0E/3yKhmhEUuB/gE+imWJeGv84npfv7TbGUgZxmVxzL0Q8pqgAVBEVc6UyeoDHAUaO7T4s8xAkMU9gcMfQkuCrEMYh2HJxI8wKrR4Tb9dr7JWs10i6dz6RVZHQwUihKdEnraB0Ztm6WF+PCabZo1hp3+FNeC9sJCMrwvAUUJZOnjrHNfCpgDJAUtnZBIojUQEy1stRLsECDE26KFy4sLi9giWlON0QbhfNKlERP3kY1VSPyq5WPY1nryh0tIwIkltriTy3uD35NbRQCk+6va3R6fSOXbj+8JCNhH515egGTzN7Ve795U02JUwrZg5Z9wKzjKPNlqcsf/XuyNIW3doosdS2vhWq3u19iU+9fGoSlTqEJ2H1cSOoPv5/IReaEvszrdSk/c12MyiR/k/9o8+Z+0I+i4IWuWv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8081e9b0-db26-4a6e-2c93-08dce45bbf65
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 10:03:08.3456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 45NDqNnGn6rfXkXOEnU2WIMNN2GgFyE1Tf0AJGTEEzpddjcPB9dProQR7WlBE9DF9GJaQrjiwSP6pNOuTg1gKJgkFRHRvHB71NAx9EJQVTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6499

T24gMDIuMTAuMjQgMjM6MzUsIFF1IFdlbnJ1byB3cm90ZToNCj4gRm9yIHJjdV9zdHJfZGVyZWYo
KSwgaXQgc2hvdWxkIGJlIGNhbGxlZCB3aXRoIHJjdSByZWFkIGxvY2sgaG9sZC4NCj4gQnV0IGlu
c2lkZSB0aGUgZnVuY3Rpb24gaXNfc2FtZV9kZXZpY2UoKSwgdGhlIHJjdSBzdHJpbmcgaXMgYWNj
ZXNzZWQNCj4gd2l0aG91dCBob2xkaW5nIHRoZSByY3UgcmVhZCBsb2NrLCBjYXVzaW5nIHJjdSB3
YXJuaW5ncy4NCj4gDQo+IEZpeCBpdCBieSBob2xkaW5nIHRoZSByY3UgcmVhZCBsb2NrIGR1cmlu
ZyB0aGUgcGF0aCByZXNvbHV0aW9uIG9mIHRoZQ0KPiBleGlzdGluZyBkZXZpY2UuDQo+IA0KPiBU
aGlzIHdpbGwgYmUgZm9sZGVkIGludG8gdGhlIG9mZmVuZGluZyBwYXRjaCAiYnRyZnM6IGF2b2lk
IHVubmVjZXNzYXJ5DQo+IGRldmljZSBwYXRoIHVwZGF0ZSBmb3IgdGhlIHNhbWUgZGV2aWNlIg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+DQo+IC0tLQ0KPiAg
IGZzL2J0cmZzL3ZvbHVtZXMuYyB8IDIgKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvdm9sdW1lcy5jIGIvZnMvYnRyZnMv
dm9sdW1lcy5jDQo+IGluZGV4IDM1YzRkMTUxYjViMC4uMzg2N2QzYzE4YmU1IDEwMDY0NA0KPiAt
LS0gYS9mcy9idHJmcy92b2x1bWVzLmMNCj4gKysrIGIvZnMvYnRyZnMvdm9sdW1lcy5jDQo+IEBA
IC04MDcsOCArODA3LDEwIEBAIHN0YXRpYyBib29sIGlzX3NhbWVfZGV2aWNlKHN0cnVjdCBidHJm
c19kZXZpY2UgKmRldmljZSwgY29uc3QgY2hhciAqbmV3X3BhdGgpDQo+ICAgCWlmICghZGV2aWNl
LT5uYW1lKQ0KPiAgIAkJZ290byBvdXQ7DQo+ICAgDQo+ICsJcmN1X3JlYWRfbG9jaygpOw0KPiAg
IAlvbGRfcGF0aCA9IHJjdV9zdHJfZGVyZWYoZGV2aWNlLT5uYW1lKTsNCj4gICAJcmV0ID0ga2Vy
bl9wYXRoKG9sZF9wYXRoLCBMT09LVVBfRk9MTE9XLCAmb2xkKTsNCj4gKwlyY3VfcmVhZF91bmxv
Y2soKTsNCj4gICAJaWYgKHJldCkNCj4gICAJCWdvdG8gb3V0Ow0KPiAgIAlyZXQgPSBrZXJuX3Bh
dGgobmV3X3BhdGgsIExPT0tVUF9GT0xMT1csICZuZXcpOw0KDQoNCldpdGggdGhhdCBwYXRjaCBh
cHBsaWVkIEkgZ2V0IHRoZSBmb2xsb3dpbmcgaW4gYnRyZnMvMDA2IHdpdGggUWVtdSANCmVtdWxh
dGVkIE5WTWUgZHJpdmVzOg0KWyAgMTUwLjQyMTAzOV0gcnVuIGZzdGVzdHMgYnRyZnMvMDA2IGF0
IDIwMjQtMTAtMDQgMDk6NTA6NTMNClsgIDE1MS4zMjIxNThdIEJUUkZTOiBkZXZpY2UgZnNpZCBl
OTQ4OWRiZC0wMzQ2LTRjMjMtOWI4Yi05YTAyMjFlMjM1ZjggDQpkZXZpZCAxIHRyYW5zaWQgOCAv
ZGV2L252bWUwbjEgKDI1OToxKSBzY2FubmVkIGJ5IG1vdW50ICgyOTI4MikNClsgIDE1MS4zMjI3
NzldIEJUUkZTIGluZm8gKGRldmljZSBudm1lMG4xKTogZmlyc3QgbW91bnQgb2YgZmlsZXN5c3Rl
bSANCmU5NDg5ZGJkLTAzNDYtNGMyMy05YjhiLTlhMDIyMWUyMzVmOA0KWyAgMTUxLjMyMjc4OV0g
QlRSRlMgaW5mbyAoZGV2aWNlIG52bWUwbjEpOiB1c2luZyBjcmMzMmMgKGNyYzMyYy1pbnRlbCkg
DQpjaGVja3N1bSBhbGdvcml0aG0NClsgIDE1MS4zMjI3OTRdIEJUUkZTIGluZm8gKGRldmljZSBu
dm1lMG4xKTogdXNpbmcgZnJlZS1zcGFjZS10cmVlDQpbICAxNTIuODMxMzAwXSBCVFJGUzogZGV2
aWNlIGZzaWQgMDUxNDhiYTQtN2VlMS00ODBmLWFmNjItN2FhMGI4MGIzNWYyIA0KZGV2aWQgMSB0
cmFuc2lkIDYgL2Rldi9udm1lMW4xICgyNTk6MCkgc2Nhbm5lZCBieSBta2ZzLmJ0cmZzICgyOTQ1
MCkNClsgIDE1Mi44MzE3MTJdIEJUUkZTOiBkZXZpY2UgZnNpZCAwNTE0OGJhNC03ZWUxLTQ4MGYt
YWY2Mi03YWEwYjgwYjM1ZjIgDQpkZXZpZCAyIHRyYW5zaWQgNiAvZGV2L252bWUybjEgKDI1OToz
KSBzY2FubmVkIGJ5IG1rZnMuYnRyZnMgKDI5NDUwKQ0KWyAgMTUyLjgzMjI5Ml0gQlRSRlM6IGRl
dmljZSBmc2lkIDA1MTQ4YmE0LTdlZTEtNDgwZi1hZjYyLTdhYTBiODBiMzVmMiANCmRldmlkIDMg
dHJhbnNpZCA2IC9kZXYvbnZtZTNuMSAoMjU5OjIpIHNjYW5uZWQgYnkgbWtmcy5idHJmcyAoMjk0
NTApDQpbICAxNTIuODMyNzQ3XSBCVFJGUzogZGV2aWNlIGZzaWQgMDUxNDhiYTQtN2VlMS00ODBm
LWFmNjItN2FhMGI4MGIzNWYyIA0KZGV2aWQgNCB0cmFuc2lkIDYgL2Rldi9udm1lNG4xICgyNTk6
NCkgc2Nhbm5lZCBieSBta2ZzLmJ0cmZzICgyOTQ1MCkNClsgIDE1Mi44MzMxODldIEJUUkZTOiBk
ZXZpY2UgZnNpZCAwNTE0OGJhNC03ZWUxLTQ4MGYtYWY2Mi03YWEwYjgwYjM1ZjIgDQpkZXZpZCA1
IHRyYW5zaWQgNiAvZGV2L252bWU1bjEgKDI1OTo1KSBzY2FubmVkIGJ5IG1rZnMuYnRyZnMgKDI5
NDUwKQ0KWyAgMTUyLjg3Mjk4OV0gQlVHOiBzbGVlcGluZyBmdW5jdGlvbiBjYWxsZWQgZnJvbSBp
bnZhbGlkIGNvbnRleHQgYXQgDQppbmNsdWRlL2xpbnV4L3NjaGVkL21tLmg6MzM3DQpbICAxNTIu
ODcyOTk1XSBpbl9hdG9taWMoKTogMCwgaXJxc19kaXNhYmxlZCgpOiAwLCBub25fYmxvY2s6IDAs
IHBpZDogDQoyOTQ1OSwgbmFtZTogKHVkZXYtd29ya2VyKQ0KWyAgMTUyLjg3Mjk5N10gcHJlZW1w
dF9jb3VudDogMCwgZXhwZWN0ZWQ6IDANClsgIDE1Mi44NzI5OTldIFJDVSBuZXN0IGRlcHRoOiAx
LCBleHBlY3RlZDogMA0KWyAgMTUyLjg3MzAwMV0gMyBsb2NrcyBoZWxkIGJ5ICh1ZGV2LXdvcmtl
cikvMjk0NTk6DQpbICAxNTIuODczMDAzXSAgIzA6IGZmZmZmZmZmODI1M2U5NjggKHV1aWRfbXV0
ZXgpey4uLi59LXszOjN9LCBhdDogDQpidHJmc19jb250cm9sX2lvY3RsKzB4Y2IvMHgxYTANClsg
IDE1Mi44NzMwMTZdICAjMTogZmZmZjg4ODExMDVjMThkOCANCigmZnNfZGV2cy0+ZGV2aWNlX2xp
c3RfbXV0ZXgpey4uLi59LXszOjN9LCBhdDogDQpkZXZpY2VfbGlzdF9hZGQuY29uc3Rwcm9wLjAr
MHgxMjYvMHg2NzANClsgIDE1Mi44NzMwMjddICAjMjogZmZmZmZmZmY4MjRjZGI2MCAocmN1X3Jl
YWRfbG9jayl7Li4uLn0tezE6Mn0sIGF0OiANCmRldmljZV9saXN0X2FkZC5jb25zdHByb3AuMCsw
eDE5My8weDY3MA0KWyAgMTUyLjg3MzAzNl0gQ1BVOiAwIFVJRDogMCBQSUQ6IDI5NDU5IENvbW06
ICh1ZGV2LXdvcmtlcikgVGFpbnRlZDogRyANCiAgICAgIFcgICAgICAgICAgNi4xMS4wLXJjNysg
IzgwMA0KWyAgMTUyLjg3MzA0MF0gVGFpbnRlZDogW1ddPVdBUk4NClsgIDE1Mi44NzMwNDJdIEhh
cmR3YXJlIG5hbWU6IEJvY2hzIEJvY2hzLCBCSU9TIEJvY2hzIDAxLzAxLzIwMTENClsgIDE1Mi44
NzMwNDRdIENhbGwgVHJhY2U6DQpbICAxNTIuODczMDQ3XSAgPFRBU0s+DQpbICAxNTIuODczMDUw
XSAgZHVtcF9zdGFja19sdmwrMHg0Yi8weDcwDQpbICAxNTIuODczMDU2XSAgX19taWdodF9yZXNj
aGVkLmNvbGQrMHhiZi8weGNmDQpbICAxNTIuODczMDYxXSAga21lbV9jYWNoZV9hbGxvY19ub3By
b2YrMHgxYzUvMHgyZTANClsgIDE1Mi44NzMwNjddICA/IGdldG5hbWVfa2VybmVsKzB4MjkvMHgx
NTANClsgIDE1Mi44NzMwNzNdICBnZXRuYW1lX2tlcm5lbCsweDI5LzB4MTUwDQpbICAxNTIuODcz
MDc3XSAga2Vybl9wYXRoKzB4MTcvMHg1MA0KWyAgMTUyLjg3MzA4MV0gIGRldmljZV9saXN0X2Fk
ZC5jb25zdHByb3AuMCsweDFjMS8weDY3MA0KWyAgMTUyLjg3MzA4NV0gID8gZGV2aWNlX2xpc3Rf
YWRkLmNvbnN0cHJvcC4wKzB4MTkzLzB4NjcwDQpbICAxNTIuODczMDg5XSAgPyBkZXZpY2VfbGlz
dF9hZGQuY29uc3Rwcm9wLjArMHgxOTMvMHg2NzANClsgIDE1Mi44NzMwOTJdICA/IGJ0cmZzX3Nj
YW5fb25lX2RldmljZSsweDFiZi8weDQxMA0KWyAgMTUyLjg3MzEwMV0gIGJ0cmZzX3NjYW5fb25l
X2RldmljZSsweDIzOS8weDQxMA0KWyAgMTUyLjg3MzExMl0gIGJ0cmZzX2NvbnRyb2xfaW9jdGwr
MHhkYi8weDFhMA0KWyAgMTUyLjg3MzExOV0gIF9feDY0X3N5c19pb2N0bCsweDk2LzB4YzANClsg
IDE1Mi44NzMxMjddICBkb19zeXNjYWxsXzY0KzB4NTQvMHgxMTANClsgIDE1Mi44NzMxMzJdICBl
bnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ni8weDdlDQpbICAxNTIuODczMTM5XSBS
SVA6IDAwMzM6MHg3ZmE4ZGFmOTlmOWINClsgIDE1Mi44NzMxNDNdIENvZGU6IDAwIDQ4IDg5IDQ0
IDI0IDE4IDMxIGMwIDQ4IDhkIDQ0IDI0IDYwIGM3IDA0IDI0IDEwIA0KMDAgMDAgMDAgNDggODkg
NDQgMjQgMDggNDggOGQgNDQgMjQgMjAgNDggODkgNDQgMjQgMTAgYjggMTAgMDAgMDAgMDAgMGYg
DQowNSA8ODk+IGMyIDNkIDAwIGYwIGZmIGZmIDc3IDFjIDQ4IDhiIDQ0IDI0IDE4IDY0IDQ4IDJi
IDA0IDI1IDI4IDAwIDAwDQpbICAxNTIuODczMTQ2XSBSU1A6IDAwMmI6MDAwMDdmZmQzNGNkNWNm
MCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiANCjAwMDAwMDAwMDAwMDAwMTANClsgIDE1Mi44
NzMxNTBdIFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDAwMDAwMDAwMDAwMDAgUkNYOiAN
CjAwMDA3ZmE4ZGFmOTlmOWINClsgIDE1Mi44NzMxNTJdIFJEWDogMDAwMDdmZmQzNGNkNWQ3MCBS
U0k6IDAwMDAwMDAwOTAwMDk0MjcgUkRJOiANCjAwMDAwMDAwMDAwMDAwMDUNClsgIDE1Mi44NzMx
NTRdIFJCUDogMDAwMDdmZmQzNGNkNWQ3MCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiANCjAw
MDA3ZmZkMzRjZDZjZDANClsgIDE1Mi44NzMxNTZdIFIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6
IDAwMDAwMDAwMDAwMDAyNDYgUjEyOiANCjAwMDA1NjM5YTJjZTJiNjANClsgIDE1Mi44NzMxNThd
IFIxMzogMDAwMDAwMDAwMDAwMDAwMCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDAgUjE1OiANCjAwMDAw
MDAwMDAwMDAwMDUNClsgIDE1Mi44NzMxNjZdICA8L1RBU0s+DQpbICAxNTMuMTE3NDYyXSBCVFJG
UyBpbmZvIChkZXZpY2UgbnZtZTFuMSk6IGZpcnN0IG1vdW50IG9mIGZpbGVzeXN0ZW0gDQowNTE0
OGJhNC03ZWUxLTQ4MGYtYWY2Mi03YWEwYjgwYjM1ZjINClsgIDE1My4xMTc0NzVdIEJUUkZTIGlu
Zm8gKGRldmljZSBudm1lMW4xKTogdXNpbmcgY3JjMzJjIChjcmMzMmMtaW50ZWwpIA0KY2hlY2tz
dW0gYWxnb3JpdGhtDQpbICAxNTMuMTE3NDgwXSBCVFJGUyBpbmZvIChkZXZpY2UgbnZtZTFuMSk6
IHVzaW5nIGZyZWUtc3BhY2UtdHJlZQ0KWyAgMTUzLjEyMDY4OV0gQlRSRlMgaW5mbyAoZGV2aWNl
IG52bWUxbjEpOiBjaGVja2luZyBVVUlEIHRyZWUNClsgIDE1My42MzIxMzddIEJUUkZTIGluZm8g
KGRldmljZSBudm1lMG4xKTogbGFzdCB1bm1vdW50IG9mIGZpbGVzeXN0ZW0gDQplOTQ4OWRiZC0w
MzQ2LTRjMjMtOWI4Yi05YTAyMjFlMjM1ZjgNClsgIDE1My43MTUyNTZdIEJUUkZTIGluZm8gKGRl
dmljZSBudm1lMW4xKTogbGFzdCB1bm1vdW50IG9mIGZpbGVzeXN0ZW0gDQowNTE0OGJhNC03ZWUx
LTQ4MGYtYWY2Mi03YWEwYjgwYjM1ZjINClsgIDE1My44MTgxODhdIEJUUkZTIGluZm8gKGRldmlj
ZSBudm1lMW4xKTogZmlyc3QgbW91bnQgb2YgZmlsZXN5c3RlbSANCjA1MTQ4YmE0LTdlZTEtNDgw
Zi1hZjYyLTdhYTBiODBiMzVmMg0KWyAgMTUzLjgxODIwM10gQlRSRlMgaW5mbyAoZGV2aWNlIG52
bWUxbjEpOiB1c2luZyBjcmMzMmMgKGNyYzMyYy1pbnRlbCkgDQpjaGVja3N1bSBhbGdvcml0aG0N
ClsgIDE1My44MTgyMDldIEJUUkZTIGluZm8gKGRldmljZSBudm1lMW4xKTogdXNpbmcgZnJlZS1z
cGFjZS10cmVlDQpbICAxNTMuODg0MDkzXSBCVFJGUyBpbmZvIChkZXZpY2UgbnZtZTFuMSk6IGxh
c3QgdW5tb3VudCBvZiBmaWxlc3lzdGVtIA0KMDUxNDhiYTQtN2VlMS00ODBmLWFmNjItN2FhMGI4
MGIzNWYyDQo=


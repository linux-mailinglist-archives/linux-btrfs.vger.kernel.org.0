Return-Path: <linux-btrfs+bounces-12224-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EA9A5D9EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 10:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE5717A4C77
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 09:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C64A23C8A0;
	Wed, 12 Mar 2025 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QGs0zqzR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="N9ohUcb3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA5423BD1B
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773205; cv=fail; b=FjeO0MPKz8EzqrD21Nc4rDSAoB0tRV7MsyOo72FG6bfu4Qi/IyIP3/u2SzK71LBIIOvxvr7HQE1vh7TPVlCbU4ZmGPNEZhe4kfD7U9E/kGIglqWgzWypyJdZ89DynuFUO62x8z2jWYtCjF+9BJcSJPlUA5atwnq0Ze/X2aws0nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773205; c=relaxed/simple;
	bh=RXkY8RvP12OEseek9Ad8nMJ2Xr/CRJjvXUZ4phIURxg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=olpZiWc0Ws0o32uvHyiRZXfm1ANCUg3zFl2qvdzb7+OAyXbNkJSTcFGMgYGuSbf9PQtHiYVTG5ecArh2+ilSgal+Ee+h1IJ7ATU43J89KvWplA0DOlE7XUeOU/LUXcwOeii3G2ikBcZChP6A1/jqikgVe3kWudoDgiZn5+NIShY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QGs0zqzR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=N9ohUcb3; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741773203; x=1773309203;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RXkY8RvP12OEseek9Ad8nMJ2Xr/CRJjvXUZ4phIURxg=;
  b=QGs0zqzRprNvAvrYsMK5hRb/DVlb7mz5ZuKig7FPVE0Su3Rw6NfEn25+
   gZNrCMqFTI0ZstOlrMFjuefr+JTg/4mqsiVaqGp+zJ3XsvY4j5ihaol7P
   Jnn7AwdmTVoe8jBALhVcC6yXW4kpcX7RVbD21PcovGAhkBzBmvdycFOi6
   CRFEWu8pvF4nb9SaCSE3GIyUC3CQNEgje6h98B/YvOVVdJ+bTkQpL+d3P
   PPlRDTs9tHVEKeTS2vvfRRxJwM+j6IL/IR1SRCeKeEZpNETGZI9ZXWIdu
   9yux4ZuiwFCu/zHY8JSPP6JIzV4XxMr5s7wmqxt06Wip/jrV/gr6XPxHR
   Q==;
X-CSE-ConnectionGUID: xCxpec1uS5u91TsENPiEZA==
X-CSE-MsgGUID: gwoNH01aQZW9i0yUerIY5Q==
X-IronPort-AV: E=Sophos;i="6.14,241,1736784000"; 
   d="scan'208";a="48638953"
Received: from mail-northcentralusazlp17010003.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.3])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2025 17:53:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0/NW8dcJ8TyHMbXmN1ZS89igZmcTJkb4DEU8BpXU+CewzaaCFPFGDiUT9kCrVLXaQXZSKx/8a3fP9T02DQBbZtzhDcPryWekIYQ7q5Y0Jbpe5VU8dfZqqaSquGQoscCm0BIGsC0kc3CNhgkPws+WqmVatRcGk7Fuu/sol43Pd2x0gDBRX2U5ViLTmoHMTxXtz+XxjN3Zjv/XhuaKiPqwD/KYbIhzAxMuzaeHD0LMSweIj7tIYlufzzqvaQHQkqo715zWvsrJ1yphgaV9YmbLz8B9ghQuRtfdHAuS7WtwV0YpxlBjU/Uz4tEyQBqdwoJItla0NSjrYXUsGhoG3LS+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXkY8RvP12OEseek9Ad8nMJ2Xr/CRJjvXUZ4phIURxg=;
 b=LvGUjm6geI5lzdJJ+vHZrxDsur7c3hV4O49hemgysSegtkpJjpX8wxdHQh165mQpGASTfS2jMnigHJW9ZbHyftmCKvGy+RC7wkXdN/no8/SCB+XN+LJGTfwFYJ/M4Klkh7EsMWd6iZ/uNEf+Jg5nu8Nzn3wSVh/VRPuoqR0CfXrfrQTNbiQsMsVJFSUYg110/7q+XAuRrGRgUXFRaQVU2eSPpEtE5jmWCAp8Z4+rNS0XI/mjWnz7uZvVgtS13HoFmOX8+QYjr5/phPKjdkBOxh9JqM/ppL1OzykDXJovy0qyJb5Tc/+FbMmMMUCfpFq+yDWARva8rrEwbGAPDtDlDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXkY8RvP12OEseek9Ad8nMJ2Xr/CRJjvXUZ4phIURxg=;
 b=N9ohUcb3u+ogQREaN4TsMkYBxq0v0psZOCQvHC7pFVeK7Nam+Zuiv1ZPOUOs8NK4OhlFsktjxUgLFMi/l15CKr4oD/qqd4e2eOjZVWmlRenkmTTmRuqfC9Ie0yPj4T2w1E9rkKo/zVqVvQhe/5GkHA3fcTTDnFYmEmhP5ESiIM8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB8106.namprd04.prod.outlook.com (2603:10b6:208:349::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 09:53:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 09:53:20 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?utf-8?B?6KW/5pyo6YeO576w5Z+6?= <yanqiyu01@gmail.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, WenRuo Qu <wqu@suse.com>
Subject: Re: [bug report] NULL pointer dereference after a balance error on
 zoned device
Thread-Topic: [bug report] NULL pointer dereference after a balance error on
 zoned device
Thread-Index:
 AQHbkWcHHm5kGZj2pUWXjQyYDI5QKLNshJIAgACkFoCAABbtAIAAl5aAgAArbgCAAUPEAA==
Date: Wed, 12 Mar 2025 09:53:20 +0000
Message-ID: <6ab5accb-de28-4d79-92c4-1d3b085fbb08@wdc.com>
References:
 <CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com>
 <7addae55-e0a4-40c4-b4b5-279d4eb91fd4@wdc.com>
 <CAB_b4sAba_AtdQfM+23LhnL_F038wuE677DZx-1T_Q1TH6rtMg@mail.gmail.com>
 <CAB_b4sCNenuqK79ce7ijSDQzXgLAq8jEe98z4P6_UqAz-OvhEQ@mail.gmail.com>
 <88371447-4d78-491c-9d86-ee2ad444c50d@wdc.com>
 <CAB_b4sAgb370vOS3OVp2Vx6W+9iLUrCUvfRwVx9WtWbFOXPQsg@mail.gmail.com>
In-Reply-To:
 <CAB_b4sAgb370vOS3OVp2Vx6W+9iLUrCUvfRwVx9WtWbFOXPQsg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB8106:EE_
x-ms-office365-filtering-correlation-id: 6fbda0a9-a2fb-4042-5c95-08dd614bb8cc
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkpVdENHYnkxa2UrR0lvVTVlZE9FOHRHMDZ0RkNndmgwdTdiU3RvNHJCNks2?=
 =?utf-8?B?ckJwSGw1UW5VYTBOS0QwRkxIaDlkYmp4bDBoUzJUYmlRbHQ0Q3F2ZEZZZ3pw?=
 =?utf-8?B?cURhUG8zOFkrOUl3ZWt0NG1zNDBEdmxqU0JRdFZDVk93UjZRR1g4b0NRQUVi?=
 =?utf-8?B?WGdWVEJRcmtBWjBEbHV6SXlxOENPekZJVXdaeFczTnJHODN0NGJ6d2E4MmpC?=
 =?utf-8?B?dTd4azhHaFZnNG5UczU4d2ZEL0l0TFFmbjdCWUJzOW5yeGdTSTNCSjZVN1Yx?=
 =?utf-8?B?aEJBN2tEQUZPRjkwYmpaTnpUVkxneTJWRmNhR2xwS01SQ3RSaFdsdEo5WFhj?=
 =?utf-8?B?OGlDM2N2dzA1dnlTTTZxSEFyczAxWHBsWmdyZUVBWFVrU1E5ck9QQmVIdXRX?=
 =?utf-8?B?ZGg0Yi9XUnpRQlIwbWJtRVJ2NStReUYwTmVadkk0bU5FTGZKL3lJbWdETnpt?=
 =?utf-8?B?TGpPTlRpTUhSWFc1RmNkclpYZXh4bms3YnA0T3hXUE05cFdkM3o1Qm5GTTl2?=
 =?utf-8?B?Yjl5TnRCNHl3UFBJTTZxclcyNklMQzhJaTdyaEJoWjNhS1hLUk1ad3ViU28y?=
 =?utf-8?B?TG1XME1mR084UVlyUWYrbGlrejdNaTRFUXgySkk2SkVpWThCS0R0NTkzeEdT?=
 =?utf-8?B?Qyt5cmN6bXl1Ky9GdE5EVW1VOXFESzh4M21Oc0xrTHE3Qzd3N3hXYytRUEJi?=
 =?utf-8?B?SjU0RjJXV3pDSy9DdFpYREJtYS8yb2lZK2JtUHVYNU82VDlBbmx0c0hHL1Y0?=
 =?utf-8?B?elRYeWhvT3N5eGJibjU5YXAwZmVrWVRtUkF0OUNjSWFCL1JaNDZVQkZTVS85?=
 =?utf-8?B?ZzVsRW4wbzNHKzRyTDh5OVJlVFlGNE5uUFZPQXBwUVVVT3VQWG5ETTlDL1Uw?=
 =?utf-8?B?bStwdTUyajJsZHFzQTcvemc5YmJza0N3QkxGbzl4dVpVMzg1ck5NbHUvRUhJ?=
 =?utf-8?B?a01PK0xwRW8ycmVVM1c4UnNxQVdtczRRU0RyTXZ1WXRDTWJNMm1QM2JPbzJI?=
 =?utf-8?B?b3UvT3VWVXlhWUVERmFmUWZHV3AyVW5Da1EycXBkWnFzclV4Tk5WQXVrWk5w?=
 =?utf-8?B?OWZLWFVTeUl3WlZ5YjEvWU5JdTdwbTBlYkxuRHh1WExhZXZVSVluWDBuRnNX?=
 =?utf-8?B?VHg0eWZyMVFsU25kbTBib0Z2UVgzL2o2alpBN2xEY1o2Z1JtTDVUS2tMSU9V?=
 =?utf-8?B?T1poWjcwcHNlQWY4L3dOTXR1WmgvM3lNRUFKN0ZhTGV3OU52blBHNVJ6bFNI?=
 =?utf-8?B?Rm0wRFRKdGVQNHByd1k1L1VQSEMwRmRiOUw3TjNmUTFtTVR1OEhuSElnL0My?=
 =?utf-8?B?U2lidU9aMlg5Vm5TWkV0VmMzaldFRWJNY2tkTFlGcEJSODNZWHdjOEkrOVZH?=
 =?utf-8?B?QWc5VHhLbURGeHk2WmV1ZW1SZ21wUEUxM0p0UjdORmRITGRPWUorN245YWlq?=
 =?utf-8?B?VjQrM0RKM3NKQXM3bmhkUGs5dE5DNHlGWXBHNzJBb1ZjSmNsOGs3QjlHcGJi?=
 =?utf-8?B?NzJHd2hvQk1BcEo1R2U0UVhCTDdXZDBCTnY1T2lNYUYxTmZEZmhjNWRCYm1S?=
 =?utf-8?B?cGFpUnFpQUg0QU9hUTBhVDA1SnJMOXk5TkJyeGtaQlJneWpITTRZNVoxUmpP?=
 =?utf-8?B?blNPR1drMUorV1BEMnJFaktyNFlFM0RmOElyKzFQbkZKZjB4Q2dwZit4SlZ1?=
 =?utf-8?B?THQ2eklBZ0kwbTlnZTYxbHJHWGoycmkrTXZaRjdnZDNScXRQRWVpRE1sR3Ay?=
 =?utf-8?B?Y0swNWRMSi8wZ2dCTWFXR3lpdExMWGswSXVoOGVvWUVVcW5oZTV3Q2FyU2NZ?=
 =?utf-8?B?aU5zemFJQXpDL28zK1AwUjk1MzgweTdXU09wRHNXaFdKbUp3NHA1ZkJDbytN?=
 =?utf-8?B?Y2YyRHZIUWJnWC9tbFZaMXd4aDU2ZzQ5aXphS2lyL3BDczM3ak9OcFJXVmZQ?=
 =?utf-8?Q?7MrZrAg9AGKTIsS0DuXIYL9MVDbEopQH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dE85UG1neWV2V1dBMGxPSy95MUxqemRiSUlFcW10dWpVZFR1SmtYLzJqK1p2?=
 =?utf-8?B?QXZ4V1gyTTVBUENFbkxGV3pxMTIzeW1UdVV3cXY3K1E0V29lMFZNam5RaFJp?=
 =?utf-8?B?U0NtRUxHOW8wWVBHeHJFOFNBTHNuL0EyYk92WVpGNS9YRmdDVkpRV3Y4cE1E?=
 =?utf-8?B?VTlwMFFheldPQ2U3dGNYRER0d3FSN3JFdGNBb2d2OUs3OGJvckhhNUhIam9u?=
 =?utf-8?B?T2d1R3pSV0xPYU1jdFhFR0ZQSDBYNXBRNkRPM1lsMmI1SVdSUU9BT3YvSFJW?=
 =?utf-8?B?OGxqd3pCQ0UzQlM2MG5oelVtWWNpSXhHaFJXNytIRjg3dFVEa3dlYnlOeWNW?=
 =?utf-8?B?YmlFOG5udS8rdW5Sb2psL2pYS2JDSzBzRmI5VEd3MjRYaktzbjMxcEh4L0N6?=
 =?utf-8?B?c2JlQXBjdlhTazU4UW9RZy9vWEd6ZXV4UXIyS05DZzlsNmJLcE5rMDdTUDRG?=
 =?utf-8?B?NFNzK1VCMDFLbXFhS0d5elcxODVzY25adGxmaVFMMS93ZmRMNnRMNDN6dGFp?=
 =?utf-8?B?TlZ4RWI2bk5pRVBsV3RhYzZrSTdiZ1RoWFc3c2p1MndRa2szOGplMGhzcjNs?=
 =?utf-8?B?eVEwb2haN1lqNWlSRU9oNGphQmpJbjVhcFliTU1TZGpaV1lOY0JTV1B6UkRR?=
 =?utf-8?B?Y3hIT1NsWmR3eEF1Q3NuT3Q1NWg5QVdVV0M0R1I1dmFWNXJ6ZW9ITXVGdlh2?=
 =?utf-8?B?eDBRVFZlbVhxTGxVMWI4c0ZySGZLeHJNK0IydGc2Z2VqcEx3RThMandTK2ow?=
 =?utf-8?B?RUszSHVweTRPSFBlY1FaSUg0YW9FdEVWZ2NreTZEcUhpeW53QVRGek4zRjd1?=
 =?utf-8?B?WnFJdkFURDVVb0VHNlFjcnBiMU0xaElEOU9ZdWk1M1VJaERkSno5M2YzNmhV?=
 =?utf-8?B?ZGlCSURNSzIzTEJWMmJWRTMySlhiVFZLYytad011Y1FVYllLRm5XRTcwWUN5?=
 =?utf-8?B?Ukg4OVZ6WlZmVlNrMXV4OEpWb1lkaDZpaUZod2FKQzdkRys3aFRIRUsyQkN5?=
 =?utf-8?B?aFVmTmhXT3ZGZnZxWHRWTG83WnJIZlhyM0dxWTd5SHpJN3VyUU9PaDBTejNF?=
 =?utf-8?B?cmhmK0JqR2gyN0k0SDRYWjV0S0ZZQUF2NmFKUkQ1Rm43NGp0aVN6NW41WkRF?=
 =?utf-8?B?Z2I2SUVBSUpHWEM5MGhENjcrY3FQWXBEazdZSVhtNG8yeGVlSG9GRWNGMHNZ?=
 =?utf-8?B?aXBFVHVjbE9jbjRNTytlNHU5M21Ma0o1U0VaU3RxR2RvelBZQk82cGFJOEEw?=
 =?utf-8?B?c0JmL2hjMm9rWFpuVU1lcVh3VG1DL0RuZWMySEFVOTRtRVpUK2NGcEJvZ1BC?=
 =?utf-8?B?ZVc0NTh6Y3VxdnlEWXN3aG5mSld0V1dYTHY0Z1lqU29PeW5CdnhDZy9sWmtm?=
 =?utf-8?B?S3I0bVNFMVlUaFhBUE51MTJ3SWpBQ203SzBpQktSMVpsV1htNitDcGtsV1Vr?=
 =?utf-8?B?MnJ5ekF6R3ZPNDNvQUQ4WHVZVmM3UEtBOTZrM1JpNFhGbG1ISEtsMkttYWxy?=
 =?utf-8?B?TnJGSlFFdk1rdnV1Mjl1OHdySGlMS1N5WlZ6MWVDOE92RmozL3ordDIwSjcr?=
 =?utf-8?B?NmVXNGpxRkFMZ3NMQXJvMWxGMUxSTmdqcGp3LzFWVDkrUlF0WWl1OGl6MFcw?=
 =?utf-8?B?U2RNS0lLemFnR1dIZjIzMVpPdWVJV1hoWlcrS21tUnVpS3JOS2dqVGllOWVV?=
 =?utf-8?B?WVBEbmlkb1gzVjFNa3llcG12anBSNHlEWW5KR3NSZjFtbFozS01PbzBZT1Jk?=
 =?utf-8?B?dy9tMTFRYjJhVnR5QUJoUXg2bHZpV0pMZFJSRlRwWEtRU2xBa1hvTlJaNXkx?=
 =?utf-8?B?eXVDZkd2WjZha1VZOUF5L2J0Yk1ReEZhSW5wNXlsbnREdUhLUDI0Njk1UHNP?=
 =?utf-8?B?VHY5OVltenUzZ0crWVVWcXR6Qk9EZ21NN3JtR3Fha3ZKWWJ1OXlmbi9uZFR5?=
 =?utf-8?B?U3hCeUU5dy84MkFNL1RSUVhDN0RjK09NTzM4cTkwQm5lZmQrWDA1cGV0MHU4?=
 =?utf-8?B?d3RXc0drQlhHOHlCaGpTVkl5b1NaNnltRXZSM0MxcVd1ZkdIVVQzRnh5WFo0?=
 =?utf-8?B?OXF0ak1aNklFV2RDUGR5UzNFM2dSWWpMSmxNUEt4Ukc4ZlVzRlJBMWpRQ3NB?=
 =?utf-8?B?UGZ2ZVptMm9KVVpGOXhZYUc0QkRFak5sMEdnTzcvS05kYS9wb0cwMDkrdGdW?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <434427CBD77E2349AE3B2BBB5213FC3E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ClfDirCkgN6dkSwP0/zPXbPhGPcw5JseYOSrslporQuPTXo6yn+imcKRm5BjafJH2zCR4pckYpvUpSRwENkV0V1VuETazWQAEGfKktPimVC7s7EQAJGzGmkBpPCnn24A6nrXjHsVIb+C7NtnY/nSW+jsmv5TsUaQr3dBYpTGAn8XpYIm6gnKiUPXajlYD64Lx2YlQMVmvQFOPhvqpz+EZRR9tydXqNHt4hsRsY2AwpKR5coA517LOBfBJ/vNeO8nRALdYlz2RW2yt7gH/LCa2t+1HinjgsVIWfw+a5aGkQgSUbPWMWbIBLrq/DqlRRqj0iX/a0wUvQVGtzp/S7f14UhN6p9BVS8hGbJal/0+ZISAbP9b/WxMupHASvjl8rm3nR8Q/ME/Lak1Kd9oQAruuT+hu6LFljpLpUsnraLeD3lQK38k+xXricn3lHIuBmwAKjqOw0a/qr5n6P5vriDpHZ7AmCtk3qm8QrO2FTgbuLGyVeQ/mi8C/2OmPCkHn0M5z9BYJ1azIH047zze3FxQb3FpXXIQmV/qMmRocbiZ91qDT0qOzQQ+ckBe45Zb/+BFRwtTa55mGwYmFGEC25dBBTOgVILz9c7eQBKIBzkE6WqKBbLeRxosbBVHCFy+Q2Em
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbda0a9-a2fb-4042-5c95-08dd614bb8cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 09:53:20.7149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/UsN4zIHF9IxX7FK/9YvrUOJsIlbAc+dG9kppw6KV9BTLy6/h74vLy/Rmz4AxhyaIf1sm92F0PJjFItg2WAM+uH3c+t8MzN56ESVdVWTVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8106

T24gMTEuMDMuMjUgMTU6MzQsIOilv+acqOmHjue+sOWfuiB3cm90ZToNCj4gSm9oYW5uZXMgVGh1
bXNoaXJuIDxKb2hhbm5lcy5UaHVtc2hpcm5Ad2RjLmNvbT4g5LqOMjAyNeW5tDPmnIgxMeaXpeWR
qOS6jCAxOTo1OeWGmemBk++8mg0KPj4gTm90IGZpbmRpbmcgYSBtZXRhZGF0YSBzcGFjZV9pbmZv
IGlzIGp1c3QgYnJva2VuLiBFdmVuIG5vdCBoYXZpbmcgdGhlDQo+PiAtPnNwYWNlX2luZm8gcG9p
bnRlciBub3Qgc2V0IGluIGEgYmxvY2tfZ3JvdXAgaXMgYSBiaWcgcmVkIHdhcm5pbmcgc2lnbg0K
Pj4gdGhhdCBjYW5ub3QgaGFwcGVuLg0KPj4NCj4+IEFzIHBlciB0aGUgY29kZSB5b3UgcXVvdGVk
IGFib3ZlLCB0aGVyZSdzIGV2ZW4gYW4gQVNTRVJUKCkgY2F0Y2hpbmcgaWYNCj4+IHRoZSBzcGFj
ZV9pbmZvIGlzIE5VTEwgKGJ1dCBDT05GSUdfQlRSRlNfQVNTRVJUIHVzdWFsbHkgaXMgbm90IGVu
YWJsZWQNCj4+IGluIHJlbGVhc2UgY29uZmlndXJhdGlvbnMpLg0KPiANCj4gTm8sIEkgbWVhbiB0
aGF0IGJ0cmZzX2FkZF9uZXdfZnJlZV9zcGFjZSBpcyBjYWxsZWQgYmVmb3JlOg0KPiBjYWNoZS0+
c3BhY2VfaW5mbyA9IGJ0cmZzX2ZpbmRfc3BhY2VfaW5mbyhmc19pbmZvLCBjYWNoZS0+ZmxhZ3Mp
Ow0KPiBpbiBidHJmc19tYWtlX2Jsb2NrX2dyb3VwKCkNCj4gDQo+IEFuZCB0aGUgc3RhY2sgdHJh
Y2UgZm9yIHRoZSBudWxsIGRlcmVmIGNvbnRhaW5zDQo+IA0KPiA/IF9fYnRyZnNfYWRkX2ZyZWVf
c3BhY2Vfem9uZWQuaXNyYS4wKzB4NjEvMHgxYTANCj4gYnRyZnNfYWRkX2ZyZWVfc3BhY2VfYXN5
bmNfdHJpbW1lZCsweDM0LzB4NDANCj4gYnRyZnNfYWRkX25ld19mcmVlX3NwYWNlKzB4MTA3LzB4
MTIwIDwtIE5vdGljZSB0aGlzIGNhbGwNCj4gYnRyZnNfbWFrZV9ibG9ja19ncm91cCsweDEwNC8w
eDJiMA0KPiANCj4gSW4gX19idHJmc19hZGRfZnJlZV9zcGFjZV96b25lZCwgY2FjaGUtPnNwYWNl
X2luZm8gaXMgYWNjZXNzZWQsIHdoaWNoDQo+IGFwcGVhcnMgdG8gaGFwcGVuIGJlZm9yZSBpdCBp
cyBpbml0aWFsaXplZCBieSBidHJmc19maW5kX3NwYWNlX2luZm8oKS4NCj4gVW5sZXNzIHRoZXJl
IGlzIGFub3RoZXIgY29kZSBwYXRoIHRoYXQgYWxsb2NhdGVzIGFuZCB0aGVuIGRlYWxsb2NhdGVz
DQo+IGNhY2hlLT5zcGFjZV9pbmZvLCB0aGlzIHNlZW1zIHRvIGJlIHRoZSBkaXJlY3QgY2F1c2Ug
b2YgdGhlIG51bGwNCj4gcG9pbnRlciBkZXJlZmVyZW5jZS4NCj4gDQo+IFRoZSBvcGVuIHF1ZXN0
aW9uIGlzIHdoeSB0aGlzIGlzc3VlIGRvZXNu4oCZdCBvY2N1ciBvbiBvdGhlciBzeXN0ZW1zLg0K
PiBQb3NzaWJsZSByZWFzb25zIGNvdWxkIGJlOg0KPiAgIC0gSSBoYXZlIG1pc3NlZCBvdGhlciBw
bGFjZXMgd2hlcmUgY2FjaGUtPnNwYWNlX2luZm8gaXMgc2V0Lg0KPiAgIC0gVGhlIGNvbmRpdGlv
biBpZiAoIWluaXRpYWwpIGluIF9fYnRyZnNfYWRkX2ZyZWVfc3BhY2Vfem9uZWQgbWlnaHQNCj4g
YmUgZGlmZmljdWx0IHRvIHNhdGlzZnkuDQo+IA0KDQpCZWNhdXNlIHRoaXMgc2hvdWxkIGVuZCB1
cCBpbiBpbml0aWFsPXRydWUgYW5kIG5vdCBoaXQgdGhlIGlmICghaW5pdGlhbCkgDQpjb25kaXRp
b24uDQoNClRoZSBxdWVzdGlvbiBub3cgaXMsIHdoeSBpdCBkb2Vzbid0Lg0K


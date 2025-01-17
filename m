Return-Path: <linux-btrfs+bounces-10993-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F922A149F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2025 08:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DFD188BE47
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2025 07:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19101F78F4;
	Fri, 17 Jan 2025 07:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A7g4oZS6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bV27GkVS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2EE18A6B7
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2025 07:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737097677; cv=fail; b=iSgjcwEVGHd+ZLDFUCiy2y8X+NVvW39Qr/Y/oE6D7Nu3Z+eDOqsgs++TDEDjJNxXGEyxCIn7m9TGL3Ex3KRt50aaQ6kPuQp2JANvngzqS+hsmW/4heMi8uYRYoYTtXV5hbY0ISj6FqGh0vJgvj9HQ9ljHAO9aNy4UMJvfnJhGlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737097677; c=relaxed/simple;
	bh=yHy9Z5uXJEO4kJqYqnmoln6FrqXnmRuTeGgddPPHF8E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a49thbFQr8kxiaI5F4Luhw+Atm9L5dNSZL+cKRgbdT6pWSW5Tbyg/3FT5EWIOXzsilNIeLzu0uTwwltqLYrQt5Q/3gRq3oRrJ+AigiMWYaP74X4bjR5/LRp6KlCFkpAFQNVTEYLcw6daoWRRv6ywGoz60J/4J47QjYvYkqtNzjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=A7g4oZS6; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bV27GkVS; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737097675; x=1768633675;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=yHy9Z5uXJEO4kJqYqnmoln6FrqXnmRuTeGgddPPHF8E=;
  b=A7g4oZS6gmtZl7xSQhKlXf3W1B7Flwjw23fmtnyPSuroh673vE9DpC7I
   0u1IBW4Ujhtl2XnVmw3G0WnYhB5Zcm2GEMKsw1KZ1Rbl/bRlP6viEpohe
   cZx2Qn+ugqt8JouoX3CL8OG63Qb5T8dRg3+g22KZVX8BJE5YmhYHmSJy3
   gwPJDybl/R8hzRDMYCiubI8UuXEAVsboYnKQ7TuOlF7TfGZUzxb3r3pAB
   K2PSmCq25tXGwjbbyZeIZXl26S0N0LJDTTwvh/xRiGUNFx/DRq3LszU9e
   +qu+9+/rQthdSdKKAvkHtsq6Bi6H0mxPJA+yQKQ7RsPtU+77lbGgQrk+J
   Q==;
X-CSE-ConnectionGUID: DVsBlU1MR/qGeaktVxpvHg==
X-CSE-MsgGUID: m+bxp2LvTGaaKTmQc48wHQ==
X-IronPort-AV: E=Sophos;i="6.13,211,1732550400"; 
   d="scan'208";a="35928503"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.10])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2025 15:07:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wf9+hu7VbwjEOEmKqLHcb/Ktw28qpBEJzP40HVDVnCGE3G0OjBO2aneTL2F1HY7af8+WutmbwkyCjmELPADwUuKiY4COLANVIazJwo5ea4HwuuDqr70ZptYwfES+O0xKw12vjuhGpE7FXz4bqyqWViKgKj+gsmiGPr+L/4CO+bh/1TLaQswnAVJYWPUeqU0iQrTFbXAIzYXPxA83+s8Erl0tWbsVR1azoI3NJV9BPeiWRJjUCoNi/QO/wpZjTmUirRxXWa5Ps0EBl0pgq7PvrVMfQm7RPns2cfRtd0E1W4KrYrV4l8BzDeR4rDmPM9JT9yBj2exg+OOLQ8MrIq/+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHy9Z5uXJEO4kJqYqnmoln6FrqXnmRuTeGgddPPHF8E=;
 b=NVQ6nh4+jVjH7TyD9mU2LUDyodG336BrPBgRpj546cspR0DL5yR7Rn7EKtbUNjBCVIzpNJq4xkQGmjI+Mhl4MxyD7bA2R3x6KofDHZhhaDkVdz2koZi+ZkAmUyuBQeB0Ms5GqvGIXojgJ3xkrwvJwDHQ70jXbOoj2Qua0VdhGk9oTDeynEDlovExSz52l6zY7khhTJUeJG7hoqvp4uBE/BgWct6SEMPGpRw2YvUMwlEA5wl9rBz4fKo4QetXXXiM90xZ0Qpq2k2C7S8mlXCg+4tNDRx8agmcwXx6iBhsFx7mu9qBUI5Z56vaJmMyXvegLstb1c6JUM0agRQGqhqMMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHy9Z5uXJEO4kJqYqnmoln6FrqXnmRuTeGgddPPHF8E=;
 b=bV27GkVSU96jntbljLmcPLYq9eJhdP0aD97Ug72YBokQGDLDiAiGGc1XS+XbyXk0BMMR2cSCG1uuJJZ2ybfGYcZmPlqU8EBojEICEKYCx5LvlbDfRa5hYKe8Kvamctd29Z3FOaT++B0k1tZ5I4/bUpA4aD26cg3cp7m/TBx2644=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CYYPR04MB8879.namprd04.prod.outlook.com (2603:10b6:930:bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 07:07:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8293.020; Fri, 17 Jan 2025
 07:07:52 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, WenRuo Qu <wqu@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: export per-inode stable writes flag
Thread-Topic: [PATCH] btrfs: export per-inode stable writes flag
Thread-Index: AQHbaKNLw/+arO9rV0Wo2oALFwS4FrMah9cAgAABp4CAAAJHAA==
Date: Fri, 17 Jan 2025 07:07:52 +0000
Message-ID: <30b307e3-da35-4baf-b194-4bbb076ea2b8@wdc.com>
References:
 <a7dd26219b1dba932d48b373fa8189a2bb6989bc.1737092798.git.wqu@suse.com>
 <ae5ea555-0a3b-4e51-96c0-d318a99d5a7e@wdc.com>
 <27502a16-9e0d-4317-9ef5-426fc5e8c581@gmx.com>
In-Reply-To: <27502a16-9e0d-4317-9ef5-426fc5e8c581@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CYYPR04MB8879:EE_
x-ms-office365-filtering-correlation-id: 2ec7e804-9e05-4747-2503-08dd36c5a8cf
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z0FtVkFIazNPM0FRVXpLSmpISysvMllsRmpqblYvdWFvY3FnT1gvcHdkOUp4?=
 =?utf-8?B?RWxRT1BBZUt1aFZEb1k2OHI5UGR5YVRxMkFZSks3LzBEalF2NGpZT1d1ZE9C?=
 =?utf-8?B?OHQyQTd1ZlFSMnpYNXdGUzc4YWt0Y1VFdC9uY0lsSXdRbml4OW5EcWtsTFJG?=
 =?utf-8?B?RDhPSnkzQkFPZWlQby9PS3ZNZzgzVllXcW5idTV2Y25uYjd1dU4vN3BUdWFC?=
 =?utf-8?B?UTBZbTgreXU5RndzaGJQditLcktsNis0UmtzQ21KMkFsSTVkR3R1OTFvK2Ev?=
 =?utf-8?B?K2JkUFJMbnJ3ZXJFejJZOXFPZ2VlQWdMUHR0cmhJWDVVS3kvb2k4WDlGUGhx?=
 =?utf-8?B?OGlNNHI0QjNZQ01LN0FKTk5FWHdJYVcvK2xmMGprQ285SmRBL09UV0VGSlZo?=
 =?utf-8?B?QWRTblFxQ2t3MVVvZjhweFFmV3NLN29xZjdadjJDSk5seTBjQmtKVFFEODlF?=
 =?utf-8?B?Q2IrR2hZR3BpS2Q3VzV3Zi9oLzJYajg2NjB5SldDbU9HZXFLWlBRYko2WDlH?=
 =?utf-8?B?VkJUdTZ3Yy9WeVlycm5jNnAzeExIQTl4Q1I1bGJtMmpXdzFaVmRhV0w5TDFy?=
 =?utf-8?B?WlUwVVNsa1VveWhNaHJzMEpnRzBPdDI5RGpNV2p3Y0lGU1ZYSnk1RzJKeng2?=
 =?utf-8?B?S2x0b0FncGZxYmptVXFpaVBwUklUb0poYkFlNkJrcXg2TW91cDN6S0FYWFNa?=
 =?utf-8?B?T252Ymx1U3BIZmFPYXZWM1RkTThKUHZUL0NBT0crUkkyUVYyME1uaVJDL29V?=
 =?utf-8?B?dXRDUFFUaFNWczlTMC9sY3RPV1Foc1dUbW5IUFlNK083ZnNHSjlKM2haUlVq?=
 =?utf-8?B?aEtZZmRNOFF2TTNhYy9VdzlXNElLanRSVXlQMEFmZUpCUjE4Q1I3SlZaeVg0?=
 =?utf-8?B?MFRjZGtXeFROaFJyRkFxWXRVRXZkRTNwa3JrTnJ3VDdQNFZrTC9NU3RwUi9I?=
 =?utf-8?B?QU9iMVYxWFBZc2p4RE5iUEUzaFdhVFViL1VvK05ldS9jOHZQM1V0NkJ3Zmxx?=
 =?utf-8?B?ZGdLWkFVL1lvQ1VwSDRhR05uTC9MdGU1Qk9rOW9FaE0yTlcwZEdBNEx2TUdX?=
 =?utf-8?B?VDhXVkNBSWlkbVVCYURVQ2oyY1hoVks4ajFqcm5CTVg5WVAvTDF6YzAvZG03?=
 =?utf-8?B?akhDTVBIRXI3L2dqUkhkbUd4MnJpTFZhSmJvckgzMmVZSlB2WmN5Vkt5NnRJ?=
 =?utf-8?B?QlZZR281Q01VMzVZbTBWTmRYZHpPZHZyUklGbFlrUWxzejVoNStxeko3cFNP?=
 =?utf-8?B?WHBmYlQyemQ2c2YrbDN0cjVkWnR2SlUxdUwzTER5THJ6U0x0RitSTW13NHNl?=
 =?utf-8?B?d2FaYnhlS2h1aFcwY0NwclpldmtxdXhqc1BiNmJqSElDNVpvUUhUaC92RUFJ?=
 =?utf-8?B?amxRVGxjUUZxNkFxZy9tMUhCYW1YMUhwSzJtUjl6V2szcmg5NmxNbDY0di81?=
 =?utf-8?B?bnlVazZVeFdlSUdwYysvaEJXaXFPSFEvMWY0QlN1bnhRZktJUnlmQ2VDR0pX?=
 =?utf-8?B?dy84b0JIdWpmN0NLSE1oUklaREx1ZEtaSU0reC81eHV1Q0ozSFVGbTlqaXZm?=
 =?utf-8?B?QzAwdG5ianFhK3dOQUtMRXRaOVAxRU5HQjNCMUZvMUJOaElpT0w4eU04MllU?=
 =?utf-8?B?MFlkdXdUUFdXMW0zK093Rkl1ME45ajlzSnVMaWpsSS9ZNXFEaVV2a0dGOVQ0?=
 =?utf-8?B?VFN3NS9rMUJ3NWJ2VGpmTHI3cSt6MTJLMk5NN1h0bXZQN0FPVHVYNXp4Y0Qv?=
 =?utf-8?B?M1dOaCtFdjZLYTRDd3Axb25MbnB5YndZZFdyNFVVYjJ2VXdLMUI0QVIxYVBD?=
 =?utf-8?B?eGtPOEdQd2ZyWi9hYW5pTmhNMXFGc1hRREpWRUY3TjVpRXJBa2lLb250UFRE?=
 =?utf-8?B?ejJMVTcvYzNNUjBaajkzMGt5ZCszVjdGTWlha2RuVjk3cFpzR09xZStHdlVm?=
 =?utf-8?Q?NqjVWk0tnaRnOsLj+J3ReFoOe5+cU+t+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDRYZlJFVG02QlhMRVlFQko3djk4dVBZMXN4MFpUMGdrUlRTZHZPS2lZY2FK?=
 =?utf-8?B?NVA1WlZ0dTMxUXQrMUpOSFdlTTJNZVh0S1M3ajJFbW91dGJGdWpMQitiQWxM?=
 =?utf-8?B?VjZtOG13STZnMGErS2xxUGFjbDNMbG5MYmNSb1lrek9tbVlGanpkVzFUL0Yx?=
 =?utf-8?B?anJ3dDZCYUdrVDl1ODNFR1NwcWdoRXdUazE1NXA1eG4yZnBYNmYxMmQwRHRN?=
 =?utf-8?B?TUZMRFlmU1piWWY0MVdUbVR4d0t2R2I2V0ErRFlMK3BlWXVDUWRwVk1iUjE5?=
 =?utf-8?B?SElpeGRLcnFPU1BVdUhJVnpKUTVVS3FKU242V1RnZTN3ODg3NmQzNXk3b3lS?=
 =?utf-8?B?Y0RHSXAxTHN1SzhGWGxhSTREZ3czYlF0OGtyRml2MjQxTFd6d1VWNVZPYmQw?=
 =?utf-8?B?c1VhdkpjSmxZaFhVQzZzS0JkQng1UlExUmo3R1B5SFhDSVJpK2NoYng5dDlV?=
 =?utf-8?B?M0Jyc21RNnF6WitRME8vclhGVmw5c0JvcElPV1U0NkI2Tll0TDhyRDVMKy9l?=
 =?utf-8?B?YU1Hc2JrLzF4WENFMnN2M0hnTVR1Z3NHWUMyUmRMV24vWW5vcjRMV016MUFO?=
 =?utf-8?B?dDI4ZnV6N21UU0t5T29sZWJkUmxPVlJFdldBeWNITWtXVFJpMVRPbWE0Qm1W?=
 =?utf-8?B?V1YvSDZRanlENDRqbzRrWDVJQjFVekFWZUZWYlF6ejJ1MXYrbWhTNkY0eFRz?=
 =?utf-8?B?UWh6MURkMi95bTc0bDBHTjFyV01rR1Z5d01yWFVWVzN2WGdrd1VDeUM1a2FB?=
 =?utf-8?B?NjZIcFhDWFI4QzYzeW5LTjhFUVMvUGdKd3hOMk0wWFpSQU8zempRSFRLOHJW?=
 =?utf-8?B?Y01lVmNkTmdGaGJhZ1BzRDR3L2Z5Um1lVVVNZ3BaN3dzV0dPQ1UrczF2ZEha?=
 =?utf-8?B?UEtqcmpOdFcwSFlyRTVpMXA5L2pESzh1OVJoaTIzZHdycnZlT0NpS21JTy9O?=
 =?utf-8?B?SVBIRFJtdDBrN2pVcHVJMHZNN1VuZHhoajlwNnhGTVRTUEJ0ZHQ5eWsyd0Fx?=
 =?utf-8?B?bzRYYmZPcjhxWEZiMDVZT25kTzZSYTdjVXhhTjF6aHRzM3JqV0h4dzVSMEMx?=
 =?utf-8?B?SnR3VjdPZGVNTEJmSFpFT1Nob3BwZjVrc1crME1LbmtMSHhQYzQwOWJxbjht?=
 =?utf-8?B?SUtGUTY5VnRZa1pSemE0MkswT0daVjRHamRlZXZZSjcwTkFvcWhLcXZVQUdL?=
 =?utf-8?B?Q2FvM294VmRmMlZiQStQMzZhcXJGR0p2aTJDYVNtQi9JeHFDd0d1R05HVkVM?=
 =?utf-8?B?UDg4UkxEUWFWOWFtMTY3Y05VMTREem45RTdEcjREc3BVTFFsUGVWUFF4VUl1?=
 =?utf-8?B?WVZlS0lxZlkrMHQ2d0xoNGtWRjRQTDRkNEZhaVp6K2hOd3pFMTY3b3VSU2lt?=
 =?utf-8?B?MHRob3JaRUZ4d3dOVkl4MHVKd2lUb1RBVW13THlLVlRWNXdUZkVld0lnMFJp?=
 =?utf-8?B?dHpSOUQ1OE50REVJVTgraWF0eWNDbk1jRS9tekxOb1k5aGloblBBWGlHU1Na?=
 =?utf-8?B?c0VoUkZPU1J1am5US1puR3RhdXZkWUU3SkRVKzhoVEdiS1ZhVXEyRkM5bFov?=
 =?utf-8?B?QTJhZWNramU3cmVHOXJZWmFYc1ExMW9zRmtkM0cvMTNNYURrY2ZOUE9Nb2dK?=
 =?utf-8?B?ZU5OalQyNlZSMFNtQXMxcm92YmdoN2g4SlJtRXdNYitvdlJwb3RZQTJIV21i?=
 =?utf-8?B?c3RSRFdzRmM3cFk4c20xcnJLZEFqL203YVlxaFByMjEyaXFjSVRVYTc0R093?=
 =?utf-8?B?ZVNHWHlCbWZZM1ZZRmxHM2VDZjdYb3AzM01GYXhmcmlZSlc1M1JReVpXWS9F?=
 =?utf-8?B?T3ZqWlk2cHltVE05bElOSDV1WlU1VSt5a1FXWFRrTTJjSkMxMVVwaG9iSnVk?=
 =?utf-8?B?RTVvUkw5NVYxV2F2bTVWSVpnenRxczBvamQ2UFJML0pSS2xOdFgyQ0txcExE?=
 =?utf-8?B?enZxZm4xY01GM2NvRjBNNE5zaHZYSXVxQjhpYkFZQVpENGg0S0hodExCRFU0?=
 =?utf-8?B?anJheGduMDFHR2lQWjNiRXJmM05SZnhiWlRzcE1ycTBIUDVhSmNFck9ZWGE2?=
 =?utf-8?B?UlNMcTRJVFJvUWU0bEZDMy80NGZlajhNY21IcjNRYjgrMWxXYjYzUnhZK0hn?=
 =?utf-8?B?cmthZGtIOFZ2NnpmOGZkdlRHczNoem5zQ3Nxb2hOL085bW82Sk9VdkhXZFpO?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1D3C25004ADB644B73A3EF2FEAA70F5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cbpaRP9hP2x+ZueAle/o5v0SxwobAVH17SXneRGzYveLwWgVNaG2qBxVrwa+iHZh6Fc1aDACWkk67hyGtyoP7sreB/GwKzD5cuhqa36eh5vN4fyi6aB1X6f0KsoUEQRoDUbi8+wnU+c8FDlDJBpHHBZAATv7dj4bpUO3fV1+m0BQRw0XtDMrOMyHAoc08b30cqjNk5J2Eg17u5e8aO+oqKbZc50jGZst4xyGDJHkEEpntPR68vRGncwNP5nCdKRh12llpo0hzcb0Tgp2ehtvDpnUui99oP6IURPWD2o7HvGx0IzbaNwMDOi32frfsCMQV/0pkaoTJ8t76zdqZV4zEjrTNT4iA47AMIGlNU00RE03SjG/+lFb2YJlVkQ9sow9U09RF1Lv2odf9etUF8+iEaa2n06rMX7GvaBJC8wu4E1wI84/gVf4YibVqeuOomYaAR0KVim8mWXxMR4jK5oDI8fwfXZq0gkeZqDLusUqBfyHqPz6Ko6uM3T0YpN1BdBrAdh1roerorqqG9PeENMf8mjHJOxwZzlycgkd+Sd2SLMs4GIUgoKkY/HqzJGTrbtepdbUms4PuQkQZ2gVNmTrTPhqyjt4HoDOwvyAO8XGu3iLsirBVoZWBq2QFQVKV2RW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec7e804-9e05-4747-2503-08dd36c5a8cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 07:07:52.4465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dBIEBHk9kacrL3xEZIIoTcGIWDsT1WTI9hIJVSMPezcBd/RlIm3IY0WJ/goTBzofp3B7ztQFhOGJe7KBT3PHcM88oyunTNgehKrTnF7WOHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8879

T24gMTcuMDEuMjUgMDc6NTksIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiDlnKggMjAyNS8x
LzE3IDE3OjIzLCBKb2hhbm5lcyBUaHVtc2hpcm4g5YaZ6YGTOg0KPj4gT24gMTcuMDEuMjUgMDY6
NDcsIFF1IFdlbnJ1byB3cm90ZToNCj4+PiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvc3VwZXIuYyBi
L2ZzL2J0cmZzL3N1cGVyLmMNCj4+PiBpbmRleCBmODA5YzMyMDBjMjEuLmJkNzFlNTdkMjk3OCAx
MDA2NDQNCj4+PiAtLS0gYS9mcy9idHJmcy9zdXBlci5jDQo+Pj4gKysrIGIvZnMvYnRyZnMvc3Vw
ZXIuYw0KPj4+IEBAIC05NjIsNiArOTYyLDEzIEBAIHN0YXRpYyBpbnQgYnRyZnNfZmlsbF9zdXBl
cihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLA0KPj4+ICAgICAJc2ItPnNfeGF0dHIgPSBidHJmc194
YXR0cl9oYW5kbGVyczsNCj4+PiAgICAgCXNiLT5zX3RpbWVfZ3JhbiA9IDE7DQo+Pj4gICAgIAlz
Yi0+c19pZmxhZ3MgfD0gU0JfSV9DR1JPVVBXQjsNCj4+PiArCS8qDQo+Pj4gKwkgKiBCeSBkZWZh
dWx0IGRhdGEgY3N1bSBpcyBlbmFibGVkLCB0aHVzIGEgZm9saW8gc2hvdWxkIG5vdCBiZSBtb2Rp
ZmllZA0KPj4+ICsJICogdW50aWwgd3JpdGViYWNrIGlzIGZpbmlzaGVkLiBPciBpdCB3aWxsIGNh
dXNlIGNzdW0gbWlzbWF0Y2guDQo+Pj4gKwkgKiBGb3IgTk9EQVRBQ1NVTSBpbm9kZXMsIHRoZSBz
dGFibGUgd3JpdGVzIGZlYXR1cmUgd2lsbCBiZSBkaXNhYmxlZA0KPj4+ICsJICogb24gYSBwZXIt
aW5vZGUgYmFzaXMuDQo+Pj4gKwkgKi8NCj4+PiArCXNiLT5zX2lmbGFncyB8PSBTQl9JX1NUQUJM
RV9XUklURVM7DQo+Pj4NCj4+PiAgICAgCWVyciA9IHN1cGVyX3NldHVwX2JkaShzYik7DQo+Pj4g
ICAgIAlpZiAoZXJyKSB7DQo+Pg0KPj4gSnVzdCBhIHF1aWNrIHF1ZXN0aW9uLCB3aGVuIHdlIHNl
dCBTQl9JX1NUQUJMRV9XUklURVMgcGVyIGRlZmF1bHQsIGRvbid0DQo+PiB3ZSBuZWVkIHRvIGNs
ZWFyIGl0IGluIGNhc2Ugb2YgbW91bnQgLW9ub2RhdGFzdW0/DQo+IA0KPiBUaGFua3MgZm9yIHBv
aW50IHRoaXMgb3V0Lg0KPiANCj4gVGhlIHRydXRoIGlzLCB3ZSBkbyBub3QgbmVlZCB0byBzZXQg
dGhlIHNiIGZsYWdzIGF0IGFsbC4NCj4gU2luY2UgYnRyZnNfdXBkYXRlX2FkZHJlc3Nfc3BhY2Vf
ZmxhZ3MoKSB3aWxsIGJlIGNhbGxlZCBmb3IgZXZlcnkgaW5vZGUNCj4gcmVhZCBmcm9tIGRpc2ss
IG5ld2x5IGNyZWF0ZWQgb25lIG9yIGNoYW5nZWQgYnkgaW9jdGwsIHdlIGhhdmUgY292ZXJlZA0K
PiBhbGwgY2FzZXMgYW5kIG5vIG5lZWQgdG8gc2V0IHRoZSBzdXBlciBmbGFncy4NCj4gDQo+IEkn
bGwgcmVtb3ZlIHRoZSBzYiBvbmUgaW4gdGhpcyBjYXNlLg0KDQpIYSwgaW5kZWVkISBEaWRuJ3Qg
dGhpbmsgb2YgaXQgdGhhdCB3YXkgOikNCg==


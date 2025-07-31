Return-Path: <linux-btrfs+bounces-15779-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62789B16AAE
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 05:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C507A2160
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 03:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD9823B625;
	Thu, 31 Jul 2025 03:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kvJiFQzf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pDVZ/3kB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4510238C35
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 03:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753931343; cv=fail; b=STDdQx71wowHomSbGViNm5hLxcB1M2jN/Tg7zvmYgJr1qvv9/XKarlPHCpp5SEfZhZbi/Ceq+JlXPlqVpRUtHFG1K2etQiiS8bp5Fyr+WDQSOZWviDo1j5TrpGU+6AVPXH4AZ0QKNa8di+QAPwPl3xa4jYzPrsnfTUugU5++CB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753931343; c=relaxed/simple;
	bh=r7rV6pUEVfcs8rhIYXekYlEe02BeyNKjsOodXGSfuYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LqiElXIYOu/JWZnzbuXaKO5oeA+By1sRbkyFGEiFyKO2POtAxelYTwe4aPNNbLVPPAMylLDwfWHWhLLjHMz/fr1SxhkgBTjyHVmoN4IgGcHquNFUkhUOIjY6fnNn6Lqq6CYHyTjC/1AoP673PUSFR4+ydJ3628kXqsfRBE2KCwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kvJiFQzf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=pDVZ/3kB; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753931341; x=1785467341;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r7rV6pUEVfcs8rhIYXekYlEe02BeyNKjsOodXGSfuYs=;
  b=kvJiFQzfeG6ls/a7bUpGzZkJXh7upn4oIg/II21LzB7Q6ros/UOvtBNN
   9xjrANW4QBFCsCoo+qPV0FudCWayuaGvaMHDvwlkptG5JvLcw38uH1rVO
   nmLayQ52KouRNP4CoymhlrTXI/JdOF9fz7JOK9X+2LqLqMMBqEKgto5ri
   LNTUXT78UgV6mPm5I9oZnnILxOkGFd5pGmOh1LAdPLlXgORHsarHTSCVT
   r6+4m4q0buDbWQeI7312ASbv42HZ8F59/35geH/914Y4V2RDKbiVTcIgd
   TFYmPhi8cHSKCueuglk8KLHy+nDX+QOiZbHBOay1ZbMeOtCw70C46EeBX
   Q==;
X-CSE-ConnectionGUID: WiKRs/TrRwWR9RW/i6n39A==
X-CSE-MsgGUID: m5TnzHKIQ+qCPdwHAFU40g==
X-IronPort-AV: E=Sophos;i="6.16,353,1744041600"; 
   d="scan'208";a="103093567"
Received: from mail-bn8nam11on2080.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([40.107.236.80])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2025 11:08:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spoJTyrNElpGGpGF2RGEut5q6z/FFrcUWR3iCgQ+dsFXgiOeX+EQKfrVBgwzXnwo52vtDeDQlUjXG+n72hnQwhYp/+QVwszpWccQpoAhrH5jPEymTmCHnenGRBg61RVLLbENogB8f/a5+Wcun8XOtTh7GL5iaCtevraGztFcazu0884Jui0tEUNNSRljQzR2aoQVlCpuf2XjRXsixuc5g8k68bs6gUGTPR2ROtnCRshMNRplinTwAI3DWIAIMqpTaTawdi1IVuBQ2us/Fsn6OSK/Lm6U4jJLEANs/K65+MBBgfVjDIz9dU3jK8oZsNPi9/sRQVlg6G+dkL4LTnQARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7rV6pUEVfcs8rhIYXekYlEe02BeyNKjsOodXGSfuYs=;
 b=uGfKgm31RR3UzhqV8j9wMovlExg4z4PmOLVvhTzdwHB62uypXrwQSvbUvAeFFAM3hF9B7RD58EZUEiXkV3GkFmM/7rhZozV19j+5p0bHC/beWCMi77xww5sY3cMzprAS19fIZnveJR470OGwL/G3Nxpgqcy6qyE/G95qMW9KHnzQvGd7XrZS9iU95zP65dW09mSmxESc6nioL1X4RUASMTzqc0N1yAW4FOHd/ziBwV4Lgk1f+ZQ7MV0DRne8DmMnvV2/TePD2X2fDvo42bHsNgqCZRStV+sI+t6n+QzOT5DzNugPTjmooGiBcUCeSDthe27Flwm6sPntVcyISivwMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7rV6pUEVfcs8rhIYXekYlEe02BeyNKjsOodXGSfuYs=;
 b=pDVZ/3kB+Euw4z/th7lwFl8AieWPyEWRYqpZziOMMANn0ZtHZz2zkHSLJR4KKOK0V3XIcwcA3WDYxApBP86fejZpJWDe0oxpjx1jCDRe1+RWksa6hLKwU31jRbEdLPEGjC4/i9rkJvgCLguspOhkd5w8yklXHKT0AaXxhbrKB+k=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CO6PR04MB8425.namprd04.prod.outlook.com (2603:10b6:303:144::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 03:08:52 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%4]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 03:08:52 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Boris Burkov <boris@bur.io>, Naohiro Aota <Naohiro.Aota@wdc.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, WenRuo Qu
	<wqu@suse.com>
Subject: Re: [PATCH] btrfs: subpage: keep TOWRITE tag until folio is cleaned
Thread-Topic: [PATCH] btrfs: subpage: keep TOWRITE tag until folio is cleaned
Thread-Index: AQHcAT3Hf2fNO+Z5wECNV1otilOkXLRLA7oAgACKqYA=
Date: Thu, 31 Jul 2025 03:08:52 +0000
Message-ID: <DBPWRLF63V9L.Q3G6L14ABT49@wdc.com>
References: <20250730103534.259857-1-naohiro.aota@wdc.com>
 <20250730185232.GB874072@zen.localdomain>
In-Reply-To: <20250730185232.GB874072@zen.localdomain>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CO6PR04MB8425:EE_
x-ms-office365-filtering-correlation-id: 036d6c92-5818-48eb-f845-08ddcfdf93f3
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWp4UXljTVAzRDMycGNFNlkrRWFBdmN1Tzd1WW1pSisvakorVzNEUzh6SUln?=
 =?utf-8?B?bHJUWmlXL0RoWEdJbUZ6V0NxaEpJV3k3TktGWWN3TEM0ZVk2SEJ0RmJzL0hn?=
 =?utf-8?B?TU5qck1MbEtmNWptOWN0NTZpWGcvbUpKNnVGcEFLczBkTktEL2o4SUxkbndv?=
 =?utf-8?B?WE41amdnR3JYL1F3b08zS1U5c3dkVlZiMWtPWWZ1dG1YUTRHRlZFTTlVZ2Fm?=
 =?utf-8?B?TXRQYkJoZWZJWVM2cWRjT3RvMW1JbUJ5OHJORmREVVNsa28yZTQrcWVQenpK?=
 =?utf-8?B?dmNEVDV0UGhVeVYybEtheUtXOUFRM1FDYWF3YVpmQ1BqcDVKSE5Fd2tXRTZp?=
 =?utf-8?B?WlY1M1BIWkRUWGF6TlBQYVJpMHIva3JveExYbFJTaGxMdHRBK0hybmRFSHM4?=
 =?utf-8?B?TTNIdVRqUFJ2akRVTGM2UHVJTzh4RUdRWEFzdlhKeStmN2xRREdmeFZoakxj?=
 =?utf-8?B?NU5iekxNeUhhUnBkL2ljSnB2enpkSVh2aExjdTIzRDE4cHIzM2p2WHRTMm1j?=
 =?utf-8?B?cDRIM1hwVGNXM3dtd3I0SnNHVHlGTUxOZDBFbXd0eGJadmVpSEFibGx3MnUr?=
 =?utf-8?B?T25HS2h3SUlKMGRBbUVwWjhLaGhiakRCbTlGUzM4S1QydmpsbHFIVzlCRlRQ?=
 =?utf-8?B?OGwxMjdadEU1NnZIQ1pXNEtCWXJjWldpTDduOThnWnVuU3JXNTRZUW5jNzFo?=
 =?utf-8?B?RURpMHFaRStzSkVZdHgwaFVnUHdiL0tnV3M3cW1KbW91Rklubm5wZnRxbzZQ?=
 =?utf-8?B?WjUvYUJMbmxNdGVOTXRFaWlNcmRtVTdkU2Rsc3V5ZGFVZUd1Ym9scHhQaGV4?=
 =?utf-8?B?c1lYQU9PLzdmRjZHVjhRL3A1cDF6bGhOU25Gc2EveTBBOWhCOVVWU2pReHF3?=
 =?utf-8?B?TFJGQXl2bFVwekRzeTJaYm9LdXF1dXh3NnY0WDlabWVodEhUMzVvc3JONGdt?=
 =?utf-8?B?SWxqSWtUTTZncWc2bmNNVTUrSmkrUkZFbnF6dFNGT2JuRFhaZEZod3RpWnhq?=
 =?utf-8?B?NnJnUFZ5SEh1d2hJclBEd2lvSm10aysvNVNwMWc0bkV6Vk9rb0xyalNMVkNX?=
 =?utf-8?B?MmZ6bmtpWEhva0prVDNqWXZHbTZDMEs5a2ZGb0REaWlGK3MxZ1MraXZHUGZs?=
 =?utf-8?B?RDdTZG1BS2g1TnJtVUtMV3IrL1BIRkZHMFVzWGt0NWZyWHE5eXJ6eGFUOWVH?=
 =?utf-8?B?SDdRT0VNUkQ4Y0tpdW9wK2VoVUZCQnJ2QnppTXBKTUc2cUJmRCtUa3pLSGJK?=
 =?utf-8?B?S3JxYnpJa1kyWFVyT0hYd1RlUzNTSnVaV2F0TUVQdHFad21mWk5PQ2FLRUth?=
 =?utf-8?B?NzdyT1VINDZMSjUrNTBFQmMvQnRqUk56bnlqdFpwT2ZaZy9lUTlLKzdsNEdR?=
 =?utf-8?B?NkJzRnNpR1kzUEZPbSs3c0hESFFaVWx1T1pCV1JWck9wWUxwOVNyVXFFNEpL?=
 =?utf-8?B?UFRVMkRNQS9EbHVBYUZLUEdrRkN1a1V2cFJRU3ZFaWlvSHNyb21IWWJqK3Np?=
 =?utf-8?B?THM3K3NWUFpLZThTT0pGbVFBb2Nmby96WTdsUGRTZG5vd3A5a2lEWFE4SDd0?=
 =?utf-8?B?aCs5L0hnMittU0hWV1lDM1FiK1FJcFE1WTJUSHYwUEFzUXh2TUVYMnBlSVBE?=
 =?utf-8?B?aHN2eGUvaS8ydmpxa29qR0JkNGpzNUJrWmNXaG4rUGVnVk1zQW5la3BQcURO?=
 =?utf-8?B?ZWEzREtMOWVTZmMxcVhlY1RGQkNPV0FnMk52V0lIaDgxMnZkZU5ZOThCL1B5?=
 =?utf-8?B?YWdaOEdRUVJBSlVydFRlbUg4aVdPck41T3BLN3oxSU1CVzN0aCt1Mm1GUXJD?=
 =?utf-8?B?NlBVS0dMNTdieldLc0pTRUYyWEtmT2ZkbGp5L3lIeWVXR2grYmZzRzJCQlZR?=
 =?utf-8?B?c2ZPWTJuNFg0eUw4aUl2dVpPbW90UWpwZVBUb2doM0J4S0t5YjlkNG1rYVdS?=
 =?utf-8?B?djJaYUtIRVpEdDJFeXZxWVk1YXVHVkg4TjZPSGhmUm1ncXQ1dTFZSFR0aVlj?=
 =?utf-8?Q?aC6F8wGoHXDQvpJDDHDpXqQah0q41Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RnA5VWR1ck9mZlpGQndoT2dzc2JacWgvRGJmdkpVSzVZano5b09DWmhGTTZa?=
 =?utf-8?B?dzV1Q24xZ0xBbElnMGdTLzJ6dUFwUlZPd3FyTjZoanVGVW9HYW1aMGExQnRw?=
 =?utf-8?B?cDlHRkJ0VXRXMjFnYjRoYThMaE1FUG1UME8rd0xCdFJIVnhuZCsrMTlhR3hC?=
 =?utf-8?B?N0hsL2xqWkU3YUhCQnh1NGsvenNQM0x5Yi82MGtzeHMrMFlQQlp0QkJKOWlD?=
 =?utf-8?B?SkVRbE10WXlPa1ZWZk9CYkFncGpuOGtIVmVPVmVtMHZUUjNxZmNpaVZHUEdO?=
 =?utf-8?B?eXpCMmVDSk1zaTN0TWNoVTV3ZTZaSnc3TzVwb3lrZnJOL2dVeVJwUk9jS0xV?=
 =?utf-8?B?enF0bjNROUY0YTNFbmxiYVdveXNCTnhMRHZaN2JMc2hMcnY2ZnFUcldDRlo0?=
 =?utf-8?B?NGZkRW1LOGEwNUw3Y05uNTFPOVFMeElsYmVDbitlRWN3alRPYVV1b2U5MWxH?=
 =?utf-8?B?dFl4ZVdVank3ZHZ6SWtKalNBZ3IxZExyclZOREtPNGQ4ckJVZFIzS1Z3eEdv?=
 =?utf-8?B?ZHNMVkhxdW85d2srVHEzWENyT1c2NVRvYm51clJjMXlLYkhKYnhzUmpaR3E0?=
 =?utf-8?B?dWI1THVTMTN2TkR0RHpxTU5Fa2YydjNMUFNlNTcrT3dRUDR3TkRlU2JTZzJx?=
 =?utf-8?B?SFhBOTM4dHlzbHMxamxHeXBDT3FNbGJRdWNGSWxWNFl2Y09OSWRwTHV1cGxD?=
 =?utf-8?B?RllMck5iL1hSUG12NkswdDVFS1IzS0JQM1RZTUZSWGVWTFpCa3p3RWxKNlRF?=
 =?utf-8?B?endHWjArZmp4dHlacFhZQkh5NUVhNjRrYlEzcTJQcUx2Y1VCL3Bpc3JXN2V4?=
 =?utf-8?B?MVJOWUtoNER2SVZWeXlhNG94VHoyOEVIVWprVGRqRmVtdnlXbThPNGtjdU9q?=
 =?utf-8?B?eFVSeXgzdkl5blhwVUllSnEwRW5qeGxHWGd5Uzh0UlgzTXRDbVdzczRRRjBF?=
 =?utf-8?B?QVFDVHJSWHZrZWFuTVVXeHJ4R2xNa1kzYVJ1dlVWSmNOK0puN0tNQjc0anVx?=
 =?utf-8?B?OFpDRkREeGQ2eE14WkRqQXAzeHBVSmxnaVl1NGRPclQreDFSVkFLKzJlQnBt?=
 =?utf-8?B?R2xOUjBOVEJmY1dXL1RRNTZodWdUT3Q5TnJab1dEcDQwcVVBaGRFQWx3cm5x?=
 =?utf-8?B?TDhrbGxJM0x6WGs3VjErMWdTcGpIY2lZMDBNQU9zZzBreTdseWMvRmR2cFRo?=
 =?utf-8?B?YVJJeTYzUVJaREZxRDZEb0JQRlFQTk5LeEZudHcwV0Nvd0hqUTFGMkhpcm45?=
 =?utf-8?B?VVl1ZzJSVmVqNWlXUFdQWStQTFU1emQ4ck1RU1BLc3JnRTZ5SmlHUjRiSDFI?=
 =?utf-8?B?R2xjaGhnZWVYV2ZOVllka0w0eGJMeTBXUHo3VC9vc1hPdForelNkRGlQM3A5?=
 =?utf-8?B?QUJDM3dEaEltazIvdWMydzRleHdrUlByWU1tbW9qdTlvWjg1UURqWlFlNldi?=
 =?utf-8?B?NzFiU1Y2YVNtNExPMUM3RzROWnFIeVdtWkVqVXhCRUNNUmZVVzJya3YwV1g3?=
 =?utf-8?B?L2Z0c3hRdG1NTFpWSFFOUzN6R0ttckNOSzJWdkVYVllWeDA0WnVZWFAzSVFs?=
 =?utf-8?B?ZlM1bmkxTDFSSEhpM1FqOWQra0JNazVBUFF5UUlIREg2UEZRZjVGL3JUZ2FG?=
 =?utf-8?B?TXUxN3I5SWpiWHFsYUp2TUhCWTErV3VJc1MwTm0rRnlLVzBDL21vNkZpMmll?=
 =?utf-8?B?U0E5L3B4MWZQM2dyZGp3SnVRTEl6SktwL1pVZWZZVWV5dHlsTlU2TWJYNVNl?=
 =?utf-8?B?RmJudHdGRlZ6Z2psRVgxVFpKYnd0SjJMNkRrejd0dm1vMSsrcVBsVXVhT1dS?=
 =?utf-8?B?SW5DQWFNQzFUdlFQMjZnQ3M0VlBjRG5iTUhJV2tVWnRxNWoreEJiemwranNV?=
 =?utf-8?B?dDhtRTdkWSs1M2xpR1kzUGhiVDErWlZLNyt2K1pCaU1hc2pRamF1dDlRUVZR?=
 =?utf-8?B?SExkdVpmdFkxMlVaMHpRVE9wTDVZWHBaZTVLYVEwRmFnblhzcEMyRG5xUmYw?=
 =?utf-8?B?b05aUDBCNkg2TGVJTXlQMU84eUo2cEs1NUx1dXBqQ202UlM4MGJtN1FjQ0pK?=
 =?utf-8?B?KzdvL0VwUnRXWW11YUM1STFNK3lDTjJnMTdKNHQ0MmIwQ1BISk9Rczg5VE1k?=
 =?utf-8?B?alhIcHU5ZGllc2p5TDJNdWlRQUUrQmlyQnhSd0Z1L3BQVmc1WEdQcFgvQVkv?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79BD0D40623FC54FBBC05E4E67D98487@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w4mV9s6U8It37q/2pz11KDVqRUjeUIicBhcbQfGK69Lqre5g2Wlv+lGWdnyJ6RvLBvwvLvTr0UaNYh8BtxljrUObbrOhnoYj2x61Gc60kpxxqFX6+HO/is/AyJ2XKY9z12CGEN/pHlVzF425epKsq5/OZ7649Qc9Q0DRxDsgvasBKP64890KeD0s41XR+c0nZJLCjFJcMFJTzDn9nw6FWSTIIdi3LKOjiHaPMZyHtzfAIKlH7zL2szeO0zKcjQCFh0AvCl2Wou8z6FsqdB16W6L/i7C0COJzBS5x1lrLD1YecJDW4Fq9xvF40LYySHHH2AZSreHRTHsiPueHi4mV/Dek5MFpE5bqgHM1Zcr6HFkvHv4t5qpEaKh2gd0lrr4aKHgYhgJzSCLvc/K0NSW7Z3yhHN7r95qlXMZ4iyJSOBMtwofoXWhTXKue2QVAF2j6G1GR7f8JWHsH86a3482fZUYxf1AkTYXquGQngqdB6mRJQ4hctwOmR7EGNxMTgm1n8YcWT78tM/pgPJRaf5/lbIrd3SgW+/CMDtJDkwzPFFLmblq+/UkJ3AhcZtseHEtF6rKaK4LGtvT17mt/DBr7qnswbsiEfQxXF8vh6h1lWrQBcDIMUzDdxwGJDOWqViJ0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036d6c92-5818-48eb-f845-08ddcfdf93f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 03:08:52.3235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uT1MiD6GgnlVXCxjMT3OHPBUMfD4WkqwtmwQhfj5ewWYWVpROjeNDWILLseuvGuLNdCTn0frjjL6zAHadcrrOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8425

T24gVGh1IEp1bCAzMSwgMjAyNSBhdCAzOjUyIEFNIEpTVCwgQm9yaXMgQnVya292IHdyb3RlOg0K
PiBPbiBXZWQsIEp1bCAzMCwgMjAyNSBhdCAwNzozNTozNFBNICswOTAwLCBOYW9oaXJvIEFvdGEg
d3JvdGU6DQo+PiBidHJmc19zdWJwYWdlX3NldF93cml0ZWJhY2soKSBjYWxscyBmb2xpb19zdGFy
dF93cml0ZWJhY2soKSB0aGUgZmlyc3QgdGltZQ0KPj4gYSBmb2xpbyBpcyB3cml0dGVuIGJhY2ss
IGFuZCBpdCBhbHNvIGNsZWFycyB0aGUgUEFHRUNBQ0hFX1RBR19UT1dSSVRFIHRhZw0KPj4gZXZl
biBpZiB0aGVyZSBhcmUgc3RpbGwgZGlydHkgcGFnZXMgaW4gdGhlIGZvbGlvLiBUaGlzIGNhbiBi
cmVhayBvcmRlcmluZw0KPj4gZ3VhcmFudGVlcywgc3VjaCBhcyB0aG9zZSByZXF1aXJlZCBieSBi
dHJmc193YWl0X29yZGVyZWRfZXh0ZW50cygpLg0KPj4gDQo+PiBDb25zaWRlciBwcm9jZXNzIEEg
Y2FsbGluZyB3cml0ZXBhZ2VzKCkgd2l0aCBXQl9TWU5DX05PTkUuIEluIHpvbmVkIG1vZGUgb3IN
Cj4+IGZvciBjb21wcmVzc2VkIHdyaXRlcywgaXQgbG9ja3Mgc2V2ZXJhbCBmb2xpb3MgZm9yIGRl
bGFsbG9jIGFuZCBzdGFydHMNCj4+IHdyaXRpbmcgdGhlbSBvdXQuIExldCdzIGNhbGwgdGhlIGxh
c3QgbG9ja2VkIGZvbGlvIGZvbGlvIFguIFN1cHBvc2UgdGhlDQo+PiB3cml0ZSByYW5nZSBvbmx5
IHBhcnRpYWxseSBjb3ZlcnMgZm9saW8gWCwgbGVhdmluZyBzb21lIHBhZ2VzIGRpcnR5Lg0KPj4g
UHJvY2VzcyBBIGNhbGxzIGJ0cmZzX3N1YnBhZ2Vfc2V0X3dyaXRlYmFjaygpIHdoZW4gYnVpbGRp
bmcgYSBiaW8uIFRoaXMNCj4+IGZ1bmN0aW9uIGNhbGwgY2xlYXJzIHRoZSBUT1dSSVRFIHRhZyBv
ZiBmb2xpbyBYLg0KPj4gDQo+PiBOb3cgc3VwcG9zZSBwcm9jZXNzIEIgY29uY3VycmVudGx5IGNh
bGxzIHdyaXRlcGFnZXMoKSB3aXRoIFdCX1NZTkNfQUxMLiBJdA0KPj4gY2FsbHMgdGFnX3BhZ2Vz
X2Zvcl93cml0ZWJhY2soKSB0byB0YWcgZGlydHkgZm9saW9zIHdpdGgNCj4+IFBBR0VDQUNIRV9U
QUdfVE9XUklURS4gU2luY2UgZm9saW8gWCBpcyBzdGlsbCBkaXJ0eSwgaXQgZ2V0cyB0YWdnZWQu
IFRoZW4sDQo+PiBCIGNvbGxlY3RzIHRhZ2dlZCBmb2xpb3MgdXNpbmcgZmlsZW1hcF9nZXRfZm9s
aW9zX3RhZygpIGFuZCBtdXN0IHdhaXQgZm9yDQo+PiBmb2xpbyBYIHRvIGJlIHdyaXR0ZW4gYmVm
b3JlIHJldHVybmluZyBmcm9tIHdyaXRlcGFnZXMoKS4NCj4+IA0KPj4gSG93ZXZlciwgYmV0d2Vl
biB0YWdnaW5nIGFuZCBjb2xsZWN0aW5nLCBwcm9jZXNzIEEgbWF5IGNhbGwNCj4+IGJ0cmZzX3N1
YnBhZ2Vfc2V0X3dyaXRlYmFjaygpIGFuZCBjbGVhciBmb2xpbyBY4oCZcyBUT1dSSVRFIHRhZy4g
QXMgYSByZXN1bHQsDQo+PiBwcm9jZXNzIEIgd29u4oCZdCBzZWUgZm9saW8gWCBpbiBpdHMgYmF0
Y2gsIGFuZCByZXR1cm5zIHdpdGhvdXQgd2FpdGluZyBmb3INCj4+IGl0LiBUaGlzIGJyZWFrcyB0
aGUgV0JfU1lOQ19BTEwgb3JkZXJpbmcgcmVxdWlyZW1lbnQuDQo+PiANCj4+IEZpeCB0aGlzIGJ5
IHVzaW5nIGJ0cmZzX3N1YnBhZ2Vfc2V0X3dyaXRlYmFja19rZWVwd3JpdGUoKSwgd2hpY2ggcmV0
YWlucw0KPj4gdGhlIFRPV1JJVEUgdGFnLiBXZSBub3cgbWFudWFsbHkgY2xlYXIgdGhlIHRhZyBv
bmx5IGFmdGVyIHRoZSBmb2xpbyBiZWNvbWVzDQo+PiBjbGVhbiwgdmlhIHRoZSB4YXMgb3BlcmF0
aW9uLg0KPg0KPiBJJ20gYSBsaXR0bGUgYml0IG5lcnZvdXMgYWJvdXQgdGhpcyBmb3IgdHdvIHJl
YXNvbnM6DQo+DQo+IDEuIHdlIHByZXZpb3VzbHkgdHJpZWQgc29tZXRoaW5nIHZlcnkgc2ltaWxh
ciBmb3IgZXh0ZW50X2J1ZmZlcg0KPiAgICB3cml0ZWJhY2sgYW5kIGRpZCBub3QgbGFuZCBpdCBh
ZnRlciBhbGw6DQo+ICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJ0cmZzL2ZmMmI1
NmVjYjcwZTRkYjUzZGUxMWEwMTk1MzBjNzY4YTI0ZjQ4ZjEuMTc0NDY1OTE0Ni5naXQuam9zZWZA
dG94aWNwYW5kYS5jb20vDQo+ICAgIFRoYXQgcGF0Y2ggd2FzIHZlcnkgaW50ZW50aW9uYWwgYWJv
dXQgY2xlYXJpbmcgaXQgbGF0ZXIgdGhhbiBhdCB0aGUNCj4gICAgbW9tZW50IG9mIHNldF93cml0
ZWJhY2ssIHNvIEkgd2FudCB0byBiZSBzdXJlIHdlIGFyZW4ndCBtaXNzaW5nDQo+ICAgIHNvbWV0
aGluZyBhbG9uZyB0aG9zZSBsaW5lcy4gSSdtIHRyeWluZyB0byB0aGluayBvZiBzb21lIHdheSB0
aGlzDQo+ICAgIGxvZ2ljIG1pZ2h0IGZhaWwgdG8gZXZlciBjbGVhciBUT19XUklURSwgZm9yIGV4
YW1wbGUuDQoNClRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgdGhpcy4gSSBkaWRuJ3Qga25vdyB0aGlz
IHByZXZpb3VzIHBhdGNoLg0KQ29tcGFyaW5nIHRvIHRoYXQgcGF0Y2gsIG15IHBhdGNoIGNsZWFy
cyB0aGUgVE9XUklURSB0YWcgd2hlbiB0aGUgZm9saW8NCmlzIGZpbmFsbHkgY2xlYXJlZCwgd2hp
Y2ggZW5zdXJlcyB0aGUgdGFnIGlzIGV2ZW50dWFsbHkgY2xlYXJlZCwNCmF2b2lkaW5nIHRoZSBk
ZWFkbG9jay4NCg0KPiAyLiBTaW1pbGFybHksIGhvdyB3aWxsIHRoaXMgaW50ZXJhY3Qgd2l0aCB0
aGUgZXh0ZW50X2J1ZmZlciBjYXNlPyBUaGF0DQo+ICAgIHVzZXMgdGhlIGViIHJhZGl4IG5vdyBz
byBJIGd1ZXNzIGl0J3Mgc2VwYXJhdGU/IEJ1dCBpdCBpcyBzdGlsbA0KPiAgICB0b3VjaGluZyB0
aGUgZm9saW8gd3JpdGViYWNrIGJpdHMgYXQgd3JpdGVfb25lX2ViLg0KPg0KPiBTb3JyeSBmb3Ig
dGhlIGhhc3NsZSwgYnV0IGp1c3Qgd2FudCB0byBiZSBleHRyYSBjYXJlZnVsLCBhcyB0aGlzIHdh
cw0KPiBhbHJlYWR5IGEgYmlnIHBpbGUgb2YgYnVncyBmb3IgdXMgcXVpdGUgcmVjZW50bHkuDQo+
DQo+IFRoYW5rcyBmb3IgdGhlIGZpeCwgb2YgY291cnNlLA0KPiBCb3Jpcw==


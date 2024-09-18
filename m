Return-Path: <linux-btrfs+bounces-8105-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE01C97B97B
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 10:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E871C20F76
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 08:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56141741C8;
	Wed, 18 Sep 2024 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WleF4kv9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="L9KWXAtH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6AF78276
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Sep 2024 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726648687; cv=fail; b=jvWzgtYWV3bEQiLKoConqEDA4xHWpNPObmreSLrvmqG0RecWiU1QjseYhmOrRRuiLA1K6+kyNAcRXwDKz1jQheJFYg6ZxbIo0L1kYW2LaTzXfqCie63o2fcxPQV/747kIXGn6TUhTKW/pXBtZl3U9y8BWkQ+iHbYsHxR+JvnKm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726648687; c=relaxed/simple;
	bh=M9CYthyK9pcI0/pKqvS7/x9kFdpN40hgU/3CyTc74go=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rG4NnD0tHebpqIL/47B5cKiv018boWe53sDwnuWDgin2Boiw5p7DUsz+ca8Gnd1OJbJv0V6+l8Z+Gu9xs1cSSgsknrGtwX0ZopUlYghzs7juCiTd81FBbVqQ7VWe2O5FvifBXxCHqN9ooK6eYfhCDOYQHzc3D/JyXtu/TWIY8Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WleF4kv9; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=L9KWXAtH; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1726648685; x=1758184685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M9CYthyK9pcI0/pKqvS7/x9kFdpN40hgU/3CyTc74go=;
  b=WleF4kv9EMlTrqiuATObyQEK5AU7DjeM6K97bWFYXjswQoS+D1SWrZri
   9g6RsC0qaXAbx1KeYn1iJUVl4mAIx7Bp+x9jOykwq1bXypHribL6fHGk7
   PZ/e/a+D/LyMuzrFucRX3hD7mB2e5hN3E1i1jfj8QlFNfMUzaH/eFIfWN
   Bl7veDy9/9DlR3UI+LCoCZQO1QrEgGaA3fppFrmg73tPtLH2nAr4NVTd1
   YHHok6EQj1hLJ0Bs6dZVktxW9azqSTL0fmvG0/PkK9IfVA+rV1xw7gCu8
   vly1V6adyeiHKoksBeJayP0md4bhXsbFfr7Qy/pebjqfbsNeX0Yt5ZQHm
   w==;
X-CSE-ConnectionGUID: TyYER1TkStqRyPfF53/9WQ==
X-CSE-MsgGUID: ouK2yE7GR3OBfTJR181Klg==
X-IronPort-AV: E=Sophos;i="6.10,238,1719849600"; 
   d="scan'208";a="26954009"
Received: from mail-bn1nam02lp2044.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.44])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2024 16:36:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhnYMHAeYiyR1umvd130UUJbVQhy35pLuFYDS1Q061i/1RK7nA+WlJm7GOQbD6gPXswmVI9AViHR+I2l3fBNBYK9ZN/6LbSD/6GN7GtmKNxrnr/qedZMnx52trU6bfmcq6X/JyqV/ItrE+QXu8uyGI5HTF2tz+JXGhgGYFpnTFbdEJneEbb2emmzMO6iGGb3OR9bnOyqZoo5wOczrpEoYaUmpUmkzfiQnIeX62GUFMnRp2L/RC8rkQvuRAeWPD0ji2NKPIYCB6Woz/WyNxB15XuvAT9iVcxDhaEhoSEi9SoP4d6SkwwCcOUidHCFZoAwkFxFQj4KS+FMstaPxK1L1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9CYthyK9pcI0/pKqvS7/x9kFdpN40hgU/3CyTc74go=;
 b=aJbSM64G4iL+VsMuyowi62S6jcihHzx8JJN1Npr97GRjJ7gma9vcLm3TLM+xJ2vJCSDiKCuNm2rfHhWtDRhehRC9F833CrJ9Xym58kw2+qxCvlLdmx/TM8UfbYzrLds19nw+StjQuvPzOYwPU/xGCyKmnRzdRrS2gfI/k4oM4m3LNO3rlMBHDpBD5//D8Mq/TT1fIkEShCG99h5F2z0A0SbSoNmS2xGAtLC4mpIjte/U30keV1cf64d6UX4it44mte183NGGeiZ05Sa8wdjLlIsgeQvDcmkYmq+PllnpDeOdH3Zj2ygPTb/OlxF0dUY8iZkF2fJfWEzfWjCDS52w7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9CYthyK9pcI0/pKqvS7/x9kFdpN40hgU/3CyTc74go=;
 b=L9KWXAtHSxbNZ1uXTmru9RzlD2Zj2F4//bF4dKFOemmtaX3vKtS+NXaGKpmEUDzYEw0v6AX7gx6+zzhAxc0o2VPgsBDXhaQ5kzcBh1gC8t5zqZj1NttXpXMu/q2T14mGy1L3+XBpDBFYjmqDnKgo6BaXYz1zYxlQ2/VPeswjb6w=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7771.namprd04.prod.outlook.com (2603:10b6:510:e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Wed, 18 Sep
 2024 08:36:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.7982.012; Wed, 18 Sep 2024
 08:36:49 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: j.xia <j.xia@samsung.com>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "dsterba@suse.com"
	<dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] fs/btrfs: Pass write-hint for buffered IO
Thread-Topic: [PATCH] fs/btrfs: Pass write-hint for buffered IO
Thread-Index: AQHbCV/+Gt4mPl89yEy/hyhvdRfwLbJdOQ0A
Date: Wed, 18 Sep 2024 08:36:48 +0000
Message-ID: <7e191731-de65-41cc-b054-74f524828be2@wdc.com>
References:
 <CGME20240903054032epcas5p41a43b67314c727e07a049344adbca480@epcas5p4.samsung.com>
 <20240903054012.1238270-1-j.xia@samsung.com>
In-Reply-To: <20240903054012.1238270-1-j.xia@samsung.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7771:EE_
x-ms-office365-filtering-correlation-id: 79cc77af-ebe7-46f2-db7a-08dcd7bd099e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bEpLWEpQMEFQVXZqbEhCQXlOdlpReDFnUDlUelRZM3FQV3FFS0lLaTdqaE9X?=
 =?utf-8?B?M0N2b3pZZU04Nm9lcXpvdmdUb1hIUWpEK1VCRkU0MzZTNmpWeTFBSVV1L1lS?=
 =?utf-8?B?VkEwNkgzNkFvVDNjdVJpZGpMSHREbmlSbEozbGw5dVJXcHRXcnVQRUdBSjFC?=
 =?utf-8?B?YTB4TVl5RFZzbEgyT1dZL3VQMmNCdVBYeDZOYllHbHMyYklkZ2VXZklMUitr?=
 =?utf-8?B?aGpaTTFvbXJnanB0UHlSTU5rMmFZN0R0eithbHRRdzJDWFo5dWJXL1V3d01l?=
 =?utf-8?B?bFJpVzBVcVMrWWFSQkZKUzhCdmxCa3dZTnJNNGphZFdqN3NSejdpVlUyWmJ0?=
 =?utf-8?B?REgwMlBGbFc4ZGNVajJReVNYVDNEbEhlV2h1TG1yc051MDhVRUtaYmJ4cU9K?=
 =?utf-8?B?N0xFN29VY0tBR2Z6cmdaTERPSmZjM2ZPeXlHTmwvdVRYQVk5RGs0THBWcGtN?=
 =?utf-8?B?Q0hFM0M1Mjc0RUFHLzdvYm4rdnovdnYxYUU0YmdyR0Y2UFZjNHE4SncxcVNZ?=
 =?utf-8?B?WWFrV2ppcnBKU1V6SWppNmNOanFzNmJvaVZ2dHhZZk1kWGsybnR4ZUZsUTk4?=
 =?utf-8?B?czQ3T0J3L2s2cGh4RXl5Z29GZW1TR2JGUUhZTmNnTWdwYmI2Ty9BNGhDWnZo?=
 =?utf-8?B?WUErbDAyOEkzcTMvY3BscmdiVzJXcXJ5bnVpNFBYUTU2OTFOWkhGQ094TG1Q?=
 =?utf-8?B?Zll1UXVOWDEyTUNnZEs1aDcrUXhQYVV1L3BRdDFUTEVnbzhXYVlxeUVyVFBN?=
 =?utf-8?B?eStSUGxqaEpxRDJZcVk0MDc4d0dtcjZqM3RHK3ZhVFROL0RUL0N2b1JSVUNo?=
 =?utf-8?B?RFlhckE5dkdVZFhGWHlBMGwySU41YWVXU24rTWNuc2JoR3d1eHRWc1I5bS9Z?=
 =?utf-8?B?TXNQR0VuQ3hDQzZoMW1Vc1pmVkc1Z0VFY3JwK1FnRWk0RDZNc1NyNzRva3Fl?=
 =?utf-8?B?bGlWQ2p5bTFSemFQa2hZaE5JVlhoL2hqL3pUbS83bGxaSVNZSlZaWnoxVklC?=
 =?utf-8?B?UmZMdjJvZzRHQk54djFyVkxkaml6T2tTeWZYYzdPdnZRWEtlWkVMYjRNRm9y?=
 =?utf-8?B?ajgwSnJ3dHFpS2ZSaEtNNVBET1pNSER0NlVJODBUL1NSbGpvK3krNmRTamZV?=
 =?utf-8?B?NWY4U2gwL2RzVW9XbGVMK2drTzRRczNjNHU0Vy92bEVLTEpybkNPVWM5SEZX?=
 =?utf-8?B?RXQzVXJtRzB3M1l1SkJNR1Y1eXB2R3hTSmZMUk1RenRXSjh5czhlZjJJcVBq?=
 =?utf-8?B?Ykd3MnQrNG93MTRVanZQRDA3anVBTU9JR1FRNXBCSW1vbUQyaGhra0lac2FW?=
 =?utf-8?B?R2FWU0t2RWlKUlhuWFgyRklMUXF6TzRld3RSVXphamlpLzVuOWJNZFkraE0v?=
 =?utf-8?B?MThUamJlTWh2YnJLMkdCa3FaeTFVV3RLNVB0dWtxeTBJaGdyLzBFUXg4Qklt?=
 =?utf-8?B?TzdyVE9DUk9pRWR2MDNLM2RzdzJ4TnF2RVZMZ0NqNjJWbmJvZnhrS084elZ4?=
 =?utf-8?B?V3RUd3JDUkhXOEhHNEI1R0IvVEZOQlBtSm9zVG5nNVZsR3BSVXJmK3E5NTRo?=
 =?utf-8?B?Q1llZEdoQ2I3NWIyeHRJaUJOcEtqS0YxNGVhM1BBYVN5RlJhVVF3aU1DRURX?=
 =?utf-8?B?aHlwOG5mTEVsdmdLRk96d0w5bmpPQVh6d0VxMFZGbE5QOUFheXlibzg5KzZB?=
 =?utf-8?B?ZjgwQU5LU2lVRW0xSUEvTTFUL3FpdlZpUEhuald1ZDN5R1FES2RtVURuSmFD?=
 =?utf-8?B?WjFuQUJvNUZ4Qm51UFFUdE5zcytjYzBOOThkckpsMWRNdnFmYWdOQ3FMcURO?=
 =?utf-8?B?Z2NVY0hSN1RER25yUG9IajA4ZVh0cHcwUm9rSytzS1pwSUQ2NHIrUGNCWHNW?=
 =?utf-8?B?UG9BT2JLK3dYdXVaY2lTb1AvY0JocCtlcnV4Q2lYc2VNUEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVBacUVzVFN2Y21kM29YblgxcDYycGY5RjVrTXRqMHBnYm05dmM2RkoxQ2Jp?=
 =?utf-8?B?YjN2eEJEUVkwemtLUWZweG5wcUQ5anVCYTJ6b3krRHVQMzM2QnhySkNVcHZZ?=
 =?utf-8?B?QUxuN0hGc0JRUDQzd1VRbXY1U1AybTNScHF5K255K0xSTk0zZDZsYVlrQkRK?=
 =?utf-8?B?cjkyb01LbEdOcit6M21JeGtIWWJyd2o5WmptaDdiRHBQOFhORVp1WXNib3Vn?=
 =?utf-8?B?LzRnTGFOb3hJWUpxVmNVNzZYeWkwd3ByUTJzRGwxN1FEbUd2ZDRtNHNMdlFo?=
 =?utf-8?B?bk95LytiNHc5eVpNYUxGWWZjRndIUVR4dUN6R2U5TmRaa0NPcS85VDhmZEpm?=
 =?utf-8?B?OW1ub1BYTGozaG10eEoxRWN6TVdVSG9UTDl4MDZJdWp5SVVOak96blZJNHBn?=
 =?utf-8?B?WGlSTnJPa2xkd3FXWEp2U2JPa1VKMTcrQkM0dk9vTG80c0dCNkt5MTg0UUxC?=
 =?utf-8?B?d0RVdmV0U2wzWm4zTkZmUlZIMDA5d2x6emViUjlNUGNoNkVGakFVaEVkSFV4?=
 =?utf-8?B?Sm9PekcvTFhGWjdRMzJoSmtuZlZaS1pNT0lBWnhHRFhFc1RTSitYb0I3VEUw?=
 =?utf-8?B?Zi9leWx4SEZtQWtka0lrQVZSbno2SWRxZkxNQ2dSdmhEREtvZDVEelFIM3Yx?=
 =?utf-8?B?eDBMMUJyRkJIamFnMlUycEhIRXBQTlA5VU1hSFVnU3lZTEhwUkw5SEhBeHE3?=
 =?utf-8?B?M3BXODNHUDJreHVlajRMSmU1OFdwWUlLMlRMYmsycUpjNms2eG5vVE9WSDRQ?=
 =?utf-8?B?Z2ROaUdIWXF2ZS9vMUN2cFFSejNMcXJnZVo2c0kxeUR0ZlA5eEdHVi8zWmlE?=
 =?utf-8?B?MGJ0bGkzYUFiV2ZjdGgrb0RIcDlTTjY0d3cxam9vVzNnMHhaZVNGa05oRGc2?=
 =?utf-8?B?aEVtVjUvNWJGc3pDc3oyM2VETEpyOUs2aUk4dzRWQjdTTERINzhWN09nT0Fo?=
 =?utf-8?B?R3BwYVBtQlZmeFl0MEhKVWMwLzlSMlZBTkx1cnY1aFBiTno1K1FUcytGZloz?=
 =?utf-8?B?ZWJEQlJqVDB5Rk8rZkYrR3poeUdWeGxmUkUxVHNyUUk3RXRPaVJsRXp1VWZn?=
 =?utf-8?B?RE1QNkJLNXRUMFFQbWZXcm9KOHU5cXBmYW9oRkw1Nk9rM1BuUkdYRWUyUlgz?=
 =?utf-8?B?VWhWVmQxSkJ0dDZjUVRvZmVoeFI0NzVRRVdKSkJpNk1MZHNkS25QMHFINEpP?=
 =?utf-8?B?OWhvakoyTlRlSHVaRFZSbFV0bU4yVHZ5aDVIQnVWZGxFaUxTbjRQbzJDM0dl?=
 =?utf-8?B?UCtMZm1VNVU0Nkk5SmZvU2QrZWl3ZWxvQTZTaXFPMjV4WVdNTzQwNXNGVk9O?=
 =?utf-8?B?RXlHZFNKa2k4OFJVMlZXOStUOXJhMVlrVG1vdGlqd2RteG1KRUtPOUlGTjJp?=
 =?utf-8?B?QmVkaG9iNVRkbERqWDRGemp1Q2REbEdhMTZ6SmdDT2R6c1FtZUlwUUVPNmxE?=
 =?utf-8?B?azhQWGZaN0Y3N0FnYlV1KzZmdzhUWHc3bGFtbUltSU53Zm5VbzdkbFgzdTZn?=
 =?utf-8?B?MFdrbkhwTUVpK3QwZ1pWa0xRMmlNbGpoeHhkT1YwTUdwVU1BTWxNOWFmTFZa?=
 =?utf-8?B?WU11SHh2TUdlcUhqZEUxUmdCWU5aUjhmczNaQXFGTyt0UW1UYlR2enhhaWVm?=
 =?utf-8?B?bXU5UGJBQUdCeHJ6UzFoNkxIZU1sT2tGV2VWcUZzdnI4YmpLaFJnVmcvZmVH?=
 =?utf-8?B?ekxqZ2hoWHovSDFzaGVCNXNtZ0kvNk56cjN3dldRZFR6eUFLZWNxZTJQTUYx?=
 =?utf-8?B?UUJ3QUc3YmRzVEt3c3JjYzlvZTFCWE1jNkt3c2FFOXB2NXBGKytNYkpqc3dZ?=
 =?utf-8?B?OEZGY0VUYW1LRlY1VXlYTzZSck9VKzNiNnZ3RTV5MFgxcHQwbWtla3lrenZs?=
 =?utf-8?B?WVVEMThheHRORTMyMHM5Ky9mYm95OHJZcHN5S2gvbmRxS2JGdmpkZEZGbmdq?=
 =?utf-8?B?MElldVo2TUVzMzNZRXdLR01xK1k2YmtDTDBGaUFtbFVRb2hSZ1FvU0l0LzNy?=
 =?utf-8?B?dkVHZjZHajlzbis4UU1QcjI5dU84OFBzSVZZNDl0STJlbzR1TURoYzV5c2Z2?=
 =?utf-8?B?blpqdVMrdDhGY292c2VsOTZBcXEvYmxQc1lseUh0c2RUcnZDcHI1czl0bVkx?=
 =?utf-8?B?S3VobCtlek11aHRwRDl1TGNBQnlJYzVLdkpYRkNlVEx1ZXJPL0pPb202YjJx?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <161502B62687D441824948BF4E1C622F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WzBbB5ziXp90ssbV6amwnoc2JHKpcQkotpVe2G+9Nihl+HRVQWUVeeTIg1gFxHk5IXUnpv/u+YI7Ov8lubgeethexb+FVYRu4WFXHsIXdIyVFvhMUVPBlElKAI+bDWynHKiIiIEn1go3W811Jf/cBx1fS5M9F2A4Bn4MM+CkFk6rqH6K2XlVV/zz6rzgY6oQv73DN3nOUPWYzK/5A3eHUg9MJvhmgueHTdxHWG95Tb2YdRchM5Ef2J/wqJ3J14kOCEvH+9Y6XvKzpby5Upmcqgk/daukemcZqresArQJyhhxpiEf0QZHTTKcpzo/BIlhXvfTZ7hEtpVVCYR6CJr1Fw/2V4Kr1YQa0Jr+ir59FraAGMKibNhJRo2Ui/f1AgjS0Q5asR3UxGXFeAQcVzNURAFHdK14VeN9e0k/ulA9uP1oh1m4fGWviqYbLN58DX9khn+MapdbjyY1LYiTt11J7noQ+RVCujm+7mv3dD6PRFf3qUDvVx/A4HfD2uMLNZzHin8816/68FN9yEgPyCYxUTjpWthVPI+tspGXDX/1Nto1bVLjXSQIGjhuIWq2B5je4md9BaFnUNiMHrss0JCrM9/Ymi9Iz2TMORmOkNfJ1V0p6QweJH+Mx7/g/lPiSd6Q
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cc77af-ebe7-46f2-db7a-08dcd7bd099e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 08:36:48.9478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wq8qIlUjYTFZi2cJNQdvTNsnFVxfRswy4IopdGBz1DDmICgTkSF8bWkgkTOodiF0O1irkQDFf2s/zpPVNtJ8u+JyJ9QckUW2IWjFmnpNfOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7771

T24gMTguMDkuMjQgMDI6MTYsIGoueGlhIHdyb3RlOg0KPiBDb21taXQgNDQ5ODEzNTE1ZDNlICgi
YmxvY2ssIGZzOiBSZXN0b3JlIHRoZSBwZXItYmlvL3JlcXVlc3QgZGF0YQ0KPiBsaWZldGltZSBm
aWVsZHMiKSByZXN0b3JlZCB3cml0ZS1oaW50IHN1cHBvcnQgaW4gYnRyZnMuIEJ1dCB0aGF0IGlz
DQo+IGFwcGxpY2FibGUgb25seSBmb3IgZGlyZWN0IElPLiBUaGlzIHBhdGNoIHN1cHBvcnRzIHBh
c3NpbmcNCg0KYmVjYXVzZSBpdCBpcyBzZXQgaW4gaW9tYXBfZGlvX2Jpb19pdGVyKCkuDQoNCj4g
d3JpdGUtaGludCBmb3IgYnVmZmVyZWQgSU8gZnJvbSBidHJmcyBmaWxlIHN5c3RlbSB0byBibG9j
ayBsYXllcg0KPiBieSBmaWxsaW5nIGJpX3dyaXRlX2hpbnQgb2Ygc3RydWN0IGJpbyBpbiBhbGxv
Y19uZXdfYmlvKCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBqLnhpYSA8ai54aWFAc2Ftc3VuZy5j
b20+DQoNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGly
bkB3ZGMuY29tPg0K


Return-Path: <linux-btrfs+bounces-17995-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A87BECE17
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 13:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCDB58815D
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 11:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC16277818;
	Sat, 18 Oct 2025 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JWqwA8yk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="E7HFDbdM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152D4217F2E;
	Sat, 18 Oct 2025 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760785994; cv=fail; b=AXv3jeZE8FoygfKcQiXOeOtLObkTtixL0yn2caQzhoKZwrCvZrWwaQCE3pQDwsckFbYhECjgXaKf/ZMUHqpyYJy2E3k9dSZHuaLdfNc5crG5ZdXfPaFfeEGNlYpGUgMY6drEyQn1PWIFppF2SwKJrf5M6TkLZHN6aaI6zEluI7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760785994; c=relaxed/simple;
	bh=qHi+s08A0G/cEY7hIf1rgovauEba8Pob2n5zUcw628U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T5EObMwlv9Z34tBCppJJS26uZow5U/DB8gMSg3+CG2O+Y1KCX8uqXpAQrDYpgxRWQmLthOyTCtrP/5Kem9cXxSCI6MzMgk/k+/4G/5+x/+EyC1lckEJhwfVi/+wh8J5ys7H6Si6fDuxIR+jVS7lW6H1f1wlMgSQXZS5voYumBTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JWqwA8yk; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=E7HFDbdM; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760785992; x=1792321992;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qHi+s08A0G/cEY7hIf1rgovauEba8Pob2n5zUcw628U=;
  b=JWqwA8ykrgwULzJJ91fQshTZrhSRgbGwij8ZhbROIZKR4SRZyPrKIa4l
   oErMXb7UvE1hFs7pcl4qfzwDNe611/VVK8rlahfhc22xkhdWXbQdaHLYm
   UWNEtQ6FC6nzgqsGcGoA7Y0aq0o0Tr2vE8Ru3zfayDaz9UK2poN0ZpxSf
   RhnVSEpwqR03tq4J6mCgXdB5hm6xllLSj87q19R6tPY+Tey3AbiCYSb2Q
   kHDleZO4cgNlIKPcU1HSLkwEqIU67yjCw6HUE9zmlOON9/xZnoh/vEyRe
   FmvQl6ElYcPzk80VoEVZKTt5pZ8ooHEgJfibqgnmepeJb0+WbTOTPFyjB
   g==;
X-CSE-ConnectionGUID: Q0F0CVmVQ5G2YoVILaQlgg==
X-CSE-MsgGUID: x9YjYwx8S0y+PX0mImzL6A==
X-IronPort-AV: E=Sophos;i="6.19,238,1754928000"; 
   d="scan'208";a="133161032"
Received: from mail-centralusazon11010057.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.57])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2025 19:13:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWBJ03vZ1qIw1V86VMmMG6Cad4ePIqfcFj6W8bPUXGfErUdqaoAyI4Fzl4tjZn30tN6hid9xtHKmFfBrIAs/o5b8RWscmV/ZwOwOCL3OvC+/U6Thd9+QdbqvIEc738FrY9PqP0Q2vnDNu/n2/O6dLHm4QcbDRJ7Rflx3xM3RJ98aqutZ8JYajL3Rxn1ppurbgOHfw9Q+9/sHE4m8yw3KHKcTUPWl5h8jL+81WlTHhKKgTvI163WfQAJzXXT6wQk5SqlNvfWOp/bCLSINQjtWr7Bi8VHamhGtqWV1TKngAYL5fdVEPNTCfa16MOgR/k4/4nAGqRjzMalMIsCf0cPmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHi+s08A0G/cEY7hIf1rgovauEba8Pob2n5zUcw628U=;
 b=XX9qKIP78ItKYKjlFCypw3rTykIsIeNsTHTAwg2A/w5KSNSjXNu9s9+r2iy1rpH9VuJnS68aJkfijWYYrKRgqt/Y9VBrRJJi4XI23FJGv2y/eYu4AddfP6dIa4Um+tIrWDwAE8sFa+gzcZhcyaFQCsAkhwx+Z8HMojX+BAu+LDHXkN6V1ydi/iutMCdgaoA5EUZtla9RD+oU6fQV9p8uoAzgfFNBWfCWVw+feyUkcaBM7yckrLsIJtkjrPXI92Ec+jKbi36FrPMnQJ0Z4Rz9Me+tWcYBc1f451x32mUeNFnz2Dcj2Ml0nwtjsna1sN6VIFA0d6YcFn0Xdzy+tZhPOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHi+s08A0G/cEY7hIf1rgovauEba8Pob2n5zUcw628U=;
 b=E7HFDbdMrHeSBgRgGfcR0u+Stbke5YsSqNtdjjt/zkDiaEy78qRlCqOomyLnBdbUpYc38VFlRa0ZzcyzaPEJcHG0SmVLTwRjGH5VzAFDJARDzrabYIihVGwWIVh+L91k2F8ejbFgC8/qBLtsDyP1xIhn/GPRZe9+KTjMTB2dMRg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6322.namprd04.prod.outlook.com (2603:10b6:408:dd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Sat, 18 Oct
 2025 11:13:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 11:13:03 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
CC: hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, Carlos Maiolino
	<cem@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino
	<cmaiolino@redhat.com>
Subject: Re: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Thread-Topic: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Thread-Index: AQHcPrB98rc0Re5Mwk+pm/9ca/TvXrTGsiGAgAEQ1AA=
Date: Sat, 18 Oct 2025 11:13:03 +0000
Message-ID: <0d05cde5-024b-4136-ad51-9a56361f4b51@wdc.com>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-4-johannes.thumshirn@wdc.com>
 <20251017185633.pvpapg5gq47s2vmm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To:
 <20251017185633.pvpapg5gq47s2vmm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB6322:EE_
x-ms-office365-filtering-correlation-id: 6efefd13-b98a-4f0d-1b15-08de0e374e79
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YlZkN0Nzd2hvMXo4WTR5eUdWNG9XYXo1bjhUMEFBWmxoYzl6RUpPS0ZRNjlF?=
 =?utf-8?B?UnhqeDduVitpdjdsRFNIM2JWVzRlbFF3UzNJYTBCazdOT0Nnd1FpMjhmWjZS?=
 =?utf-8?B?QkJWaWdRaVYxcGU4WWZPZENZK0tyVEVvTkpGSngwVnVrclQ5Q29BY01udTNR?=
 =?utf-8?B?TzVNaXJkL0RMaktFaTkwSE04RHJwMUJmOTZFcG9vKy9VOXdIN2d5bXkzbkQ1?=
 =?utf-8?B?WXMyRGY2T0g1elFjNFNlckV2ZEdTWGx4Y2ttZlhYNVVxUm1EMmpmOEJVbFY5?=
 =?utf-8?B?YUJGTk9KcUJmODBBcDVmK0tVZ05RenJHdnNYMUtYdUFXeUI1eDg0UEYvSjlZ?=
 =?utf-8?B?WFdaenAyTDNXOTJKRHJWckJvRkhzTFNXcHoxR21Vek0xRTRTaTN3SUx3UTdE?=
 =?utf-8?B?QlVld1A4c0RrYmk1YWQxUkhTRFJRNGE5SEE0L1ZrRU9jU1RhMUdGZ1loZS9m?=
 =?utf-8?B?ZXhzYlFnRjVrYVFwckc1bFJBdEk1TEc2b09ZZ2RKTzJYZDNHa3NPOFp3U3BR?=
 =?utf-8?B?S3hiWnNIZnhGb0U5RGJoWDBuYU1VVm9uaXl5N1pENjlnTHlGcVNpQ0p4WFdn?=
 =?utf-8?B?VjBaWUNHSEhaRHFYd096ZVdkYWppaForUWJnSjFuWExDQjlGQk9hTDlBRTR1?=
 =?utf-8?B?QmV5ZE5KYkZET2gvRFh6c0lYQzZUeERuVTc3VGJhRks0akpmRTdFaDJBeGY1?=
 =?utf-8?B?NnNLZ0lYU0VONkI1cS9XYkkrc0NUZHllVit5Snh3ZzdQMVpzeTZSOTBlbHdu?=
 =?utf-8?B?c0FZbWpwUGpiZEF3eVdKbmtmRmdQWkVxM0J3QjlIWTRRZUJQNG1rYnR0b05w?=
 =?utf-8?B?NnZhajZmOE5HK01vYzM0bTdqUXhZcUpMQmJEaDlVUnJ6ZkovTzN6YVZza3V6?=
 =?utf-8?B?V2JSVHRHblBka084OURnamhNQjZnQTNQWjVwcllZbVZ4eXBiQ0svekIzdUcz?=
 =?utf-8?B?cXhseWxJUVJNVTI2QkZEZkRCdzlJeDBWUXZ5enk3dFVQaUxuZkJ0cnlHMWVu?=
 =?utf-8?B?SW8xbUhqR0xiMFNHSFhDZHJRNGNpZjlWcVZ2eVZjUlpIUWdxVlBaMHFMeThQ?=
 =?utf-8?B?TUh6a3V5UEdKb0JxYWw1OS9iL3BoYlRkSi8xZllEb0FsSEFqTU1VM0NQNUhv?=
 =?utf-8?B?akt0M3ZSNGt3R2p3K0FkYWdKa0NmZFZPNDJwKzhaaHlScCszK1JFR1dQWC9y?=
 =?utf-8?B?eWJ0WWhKbDdTaGN5OEJrdjQrL1l5Q1dGZ0xpK0NjY0xBaHd5M25ER2JUbzZJ?=
 =?utf-8?B?U2tpZGpvTHpXeG1sQ2RKVWx1d3ZDK05OdXdrTVI5aXdWeVhkczR2YjhFNWFO?=
 =?utf-8?B?VDNKM1Jvd0crOFg3L2RsVDBNSDI0OVRRQlR6cy8rc0ZyKzYyb1JmY1Y1SDZZ?=
 =?utf-8?B?bHI4dHVlUHhnRG04S0ZrQ0JhNjRIc2lSNHlIQ0VON2FvNG42TEpweVB5R3oz?=
 =?utf-8?B?cWpEaFQ5YkhMa1FydUJDNUpyaUxwOCtZcEd0Z2FMQzNxSjFGMXEreVZSdkVV?=
 =?utf-8?B?SXhoTXl2djcreEV2ZnJtVXRTeCtyR2dPOXQ4YXVQR1E4ZWVUWjVXQWN6NllK?=
 =?utf-8?B?YkZMT0piNFJqVVh3YnNoY1RNclNVK2pNUGozTDFDNFNPWFovdHk3Y2hIRWhn?=
 =?utf-8?B?TnFDcFN1eFNkWmJsdlRSbmNBZEk5dkwzaGxKTTAzODFkNUtiamZUeTRJU0Ix?=
 =?utf-8?B?YzRXTGs5Z0w4UkRhMVFsMUFKbVVwK25GM2RmR3RFaWd0c04zb1puSTF3Ukty?=
 =?utf-8?B?V1FHVEFWMElCd0txdFhFUEUvcXBFVFRiTHRnVXBPbkJIcm1IRFJsSG5WTStn?=
 =?utf-8?B?czM2MXFpYXJRTnowby9IT1I0RXNnZEZzd2dIY25tSmswSDBBQzdSQzlETlE5?=
 =?utf-8?B?dzFLRGVUV3I3VlRZTDJzeVcwN2J5Q1FRRHloQXBySWVzR0xteldQQ0EwWjBJ?=
 =?utf-8?B?YUNCZWhNZVoxc2ZEcFlPWW1EZGw0U3lVYlN4T0NZSDR3OHhhUDlKbnJtaVJl?=
 =?utf-8?B?cDgzditUZEtqZ1pSUmM2MVVia3k2QnY5bWxYcE9menFVV2VJVHZCNDVKREpX?=
 =?utf-8?Q?R2yW+D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tjg3RGZwLzF0Tmlxd0NEczYreUEvZlJPaGhvSXBCZlFyUzNINHovVmhXbkU3?=
 =?utf-8?B?U0doYmEyWXF6cVFpeWpBamNWWTJqUHJsLzRTVUdCOTJ6Y21BVTdUeWFmdDZs?=
 =?utf-8?B?OXBCdzA1MEtMYnZ6V29LZ2lLV0VtdVFiRzhQNWVDTm9KZFNaeXA3TEx2Y0Rm?=
 =?utf-8?B?YmFreXRKbVV6UjQ0MldrN3JPNmU4QjByNTM4QUswMVJLM1kwbzZQbTZpZXRB?=
 =?utf-8?B?QlFwd25xM1hHTGZ4QmlkM1Qybi9oejU0VE0wUE9FR2RxL2FPS0pLa3VROEY2?=
 =?utf-8?B?M2FKUys4bTEvN3o1NVo3L01ZalJ1ZU1MaFBBSzNGZ0pTR2hqNG1yMkRlT284?=
 =?utf-8?B?dVdNUWxhOTJyMGpuY0NTWDFNS2ZZak12emxLYkhuTzFucWlqanV2NVQ0OHVr?=
 =?utf-8?B?SjFzUmdUb0tEZXAySWgrU0l6cXBVOFE1NWsyNkV5OWxBVHpHT2hmSHBad3lF?=
 =?utf-8?B?QWRpQnBuRUZsb205T0JuNXFxTlJMRlNqa3NOR3hISHFLdEdDcS9rcWJ1Rk5I?=
 =?utf-8?B?b1prZkYzd1R0TzIvVmg5Z3FxSXNZWUZrYUdMZG5vQTNHbkxETUdXNWo0UENB?=
 =?utf-8?B?OUluajdPK2hSQnRRaTdVMW1LRXNLaVU2UFVwM3RyZkd0eXJ1Z1RvWngxQS9B?=
 =?utf-8?B?MGF2aHZ3dzlSdk5ocWhLNWQxTENzNCtlbXlFbVcwdHF3ZkhkSk8yRkVURDQz?=
 =?utf-8?B?dDdWVHBEcmt5STNObWlwYVB3S1hKbUFRdm9TaFhPd0s4WCthVFh3czRHNU5q?=
 =?utf-8?B?TTI0VEpWR3M5SFMxdG9mYXlRT2U0WnlOOTFiQlMyVHBTRGFDS05mS3FJUitk?=
 =?utf-8?B?cWwyZFZKTDJxcEZDL1llcFM0M2Y2L3AyaHF2cDNsbTVTWWJKUlVCaGdES1dz?=
 =?utf-8?B?TEdVclo2RlFSNWMzZXFTOFBPOVF0RGFqUjBVckZoREpSaXF6WVIweXlyR1l5?=
 =?utf-8?B?T1ZtVGtnNnNqN1JCOTlTVTVjUXdtT0FUaUpZQ2o0Rzg1RlNoTzdhY20wVSto?=
 =?utf-8?B?NDJ0MU0wVUlsUXJlSWtRanRES1hiVnp0d2ZBdHFJQkx1YXA5dkozeFRvNThI?=
 =?utf-8?B?bXVra1A3Si9aK1JTSDFFTmh5VmVLV2NiU0xLaTRjcG9vMUQyYXYwZnRzVXNn?=
 =?utf-8?B?YzFubEhBcnRXL0NRcFlBU29POHJKZGVyZGcrREkxcGE3QXdkVGlQY2tScmx4?=
 =?utf-8?B?aUJIWnordnFFdFRpbVpQNVRXVUsxY3ZWUVZBbjRhWlEzaDdPR003N0JyQ2Iy?=
 =?utf-8?B?OWFTQ3FvZ0VNZTlXSGFqd0RPNElGQ0diYmtJYkJnNURDNDBlQjJHYjdFdWpH?=
 =?utf-8?B?R2ttZFFpOEhyWGg5WVNndXhQT2k5bUhVY05SL21jSjdQQm9NRDRBNlhjOGRN?=
 =?utf-8?B?VFdnZEMwTVQ2SlVTOHM2ZjNvOFIxbGorS1Z3aTZ4Wk1iZGw2QTRDaTZOVDVZ?=
 =?utf-8?B?eWUxMUc2TUQwVUN2LzRyS1A2U2JCNXBVSlNra0U1TUdjYTVHaUw2dDVoRGZP?=
 =?utf-8?B?NVIybW1Oc1l3UStNY2JYQmFMWkNhN3FsRFdiY2hUQVlFalhNbTVPb0FOZjVm?=
 =?utf-8?B?eDF6OXNMdVc5YnBVbVpyd05KdXhQTXpHVmNmQkxFTDJEWlAxVTNyc09vb1Rl?=
 =?utf-8?B?OVloc0hiano3RVRYOVNkcU8xUWZBMDhvdVk4TGl1VWdYUXZZa2RxM2NHV0Fl?=
 =?utf-8?B?OFFKMjBITit4Q2lZN0l4VlBDNFJFLzlGMkI1NXhUQXpEd3c1aUJ6MDZFVE9O?=
 =?utf-8?B?K2orWnFOMkIzTlQ1NXNXSWtUdEUvUVZXd1dQTmV0QmswQmt0TVhGcXFzd0Ur?=
 =?utf-8?B?QVJuUTZ0NGZ4QVN4aFhRMVc2RXFaaW0rdXVXelRmY1hzWUJOK0RmaXozUUhT?=
 =?utf-8?B?UGl2NjROa1loTksyU29LRVBoc2I0a0FXYmR5Qyttd0tvMmlEekh1ME9zT2NF?=
 =?utf-8?B?Y2hLS1NyR2Y2U2oyR0xyK3lHQm5qVEFNSytQVjBabUJycHA1c3FwQkNDYWRx?=
 =?utf-8?B?eC8yL2NORGFQVVNBQjNYVVppL0pFQVV5VWt3MkN3VVoweGNyQlN5S3U4cDhp?=
 =?utf-8?B?MzJGMm5OdDQ3RTJIR1FpMXNSZ0Vka0NZU2xvczh0OWxEaHd2OEVBN1JONGl4?=
 =?utf-8?B?RStsMkZ5V0x0ZkdjY2Y1MmhTU1F5TE5SaUtWUHV4bzV6dDFRRUUvbzh4UUJx?=
 =?utf-8?B?dGF3N01kSVpmSHZ6SndJV2poOVpXMUlrdGNwOFF3VSt2UVF1VU5tSGpBeDBn?=
 =?utf-8?B?NGRuNWR2bzZtRmhsZE5hQWZldmxRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <666F6C6AC9F8DD4F87C64993F5318DAF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rHOcaFHo29zFZvXWi+yTkdaiUVSdGnQV7Nz2+VD+IS60OA3po+T8g8m8/3GKkLphkA2VPiiy17TEdkZKk+VzR6Xnybl2Ah1JHEnysCMilqUKxuz2bWOltuBj1jtrX9F3zLjPTRF94x/MoONRbhkwjdwyj168VdiPkqXy+SFhLlfbmsBco1QXtkHUsW258zLMQ3f7+D3j7Ee7cRUTAhrSBS6i0rk03eFIZ0fTx+kBRRFZormPSEG8GR7qRlcngJJWWpXhlCxPwNRUrGO0FevkluC+wWuOZ0CHpXgrNE45YTUPf0aE/wabVCqSPegPaIHgjEEu2RvbDycecfhZnL6jPSXltMFuXWTbnABrZbc3+V3eK4KUjWgG4S+52l/lJWNMq2R08CJ6+rNtUmAxCcbHbL1qSV1phY8aLRUYcdxEY0vXcQ3ms+TKR8a26Hxzk82BmArJJ9KM8yjjdHg0LI+yZRWpVQ2WNjtC76oQtZPJ0eA7MIEt9a+DSAMxqVZ5msAKStya2JZ6J6mX2F31EjG1PrGVYfOO8rSCeSzC0CZ5i3aki9ZZ80yOAIweDqkr+bv5sBWUtUkd3w1aqcLRhU07OgpCJGtjHhreLW89w8OS/qKDovzzvqQCxogk380/SHiV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efefd13-b98a-4f0d-1b15-08de0e374e79
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 11:13:03.5568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ONLtCSWZJ385VacM8E8bTavB0MaU8ByvBMMx19J9kUqMcsbYpdVWz5Q4x9wr42d4CS6pz7uvSVLUAd2O7sgZGf7e5fub9hzTHqG3dggBEFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6322

T24gMTAvMTcvMjUgODo1NiBQTSwgWm9ycm8gTGFuZyB3cm90ZToNCj4gRG9lcyB0aGlzIG1lYW4g
dGhlIGN1cnJlbnQgRlNUWVAgZG9lc24ndCBzdXBwb3J0IHpvbmVkPw0KPg0KPiBBcyB0aGlzJ3Mg
YSBnZW5lcmljIHRlc3QgY2FzZSwgdGhlIEZTVFlQIGNhbiBiZSBhbnkgb3RoZXIgZmlsZXN5c3Rl
bXMsIGxpa2VzDQo+IG5mcywgY2lmcywgb3ZlcmxheSwgZXhmYXQsIHRtcGZzIGFuZCBzbyBvbiwg
Y2FuIHdlIGNyZWF0ZSB6bG9vcCBvbiBhbnkgb2YgdGhlbT8NCj4gSWYgbm90LCBob3cgYWJvdXQg
X25vdHJ1biBpZiBjdXJyZW50IEZTVFlQIGRvZXNuJ3Qgc3VwcG9ydC4NCg0KSSBkaWQgdGhhdCBp
biB2MSBhbmQgZ290IHRvbGQgdGhhdCBJIHNob3VsZG4ndCBkbyB0aGlzLg0KDQo=


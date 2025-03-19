Return-Path: <linux-btrfs+bounces-12425-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C50A690BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 15:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACAB1B834E0
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 14:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1189F1B4F15;
	Wed, 19 Mar 2025 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g0+QFBIk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="olCSZe3G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC4019DF6A
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394413; cv=fail; b=YfvPtE/oziJY5VGxWe9NdkImg+lK4BVD11MBmz3jmo86z18w2afBWrg/zVpSE+4D1qXe640nbHbVVH/P8efxPJioxppBTuO6QL5Yt7fTIChI3PhMGKqfiybGYXUQ0Yg+pYv7KhgRbkhzg+Njug9rIGVqSn97qS3WAk8sY0T/Zhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394413; c=relaxed/simple;
	bh=SnpI7EqSwyROUqy6Lg2bV9MaRqraNHNaaVjXFwmSKUE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A3fW8rDg7UopK5Qk/U2C5QyrfRzBsLSL2RntHdHqKuB/OG001CAGhNmXJmrUrGQfGsGt2N+Hut6uummTJNN10Zx88GdqOBfbbCplcjI0D9gZ7EuI88QsXEJWII7DyGa2VZ76cng5++IS/AAC06BvUW3Ke+H9byRduDd0uJutxJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=g0+QFBIk; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=olCSZe3G; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742394411; x=1773930411;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=SnpI7EqSwyROUqy6Lg2bV9MaRqraNHNaaVjXFwmSKUE=;
  b=g0+QFBIkSQ8eYSX5t4P2Rq2S+COOQ2b3mgPS778cnYJWdzzi+KsQ0KYS
   lxTIl1n1wmpdtuT+JiCeZvzXOUFPlp/8CRJKS+IOsK2SHvZT3/6cLZ/Fi
   JKzbql1vFpF0EiG1Yly0fglsd4p2vWw06wg2XNOlSzrDJD3UD516aoZSN
   S5PuswOlQ/dNbcmdwja5TzhPU9OTD5pM5k2H3PhgI1+iVbRT7JyPbB4sW
   CssS522Mld4wBF6XvqMmt7LGNTLyesh6r66rY40E5xqvdkCbD8vf4qkKd
   vAs7cxwOYH7r9NEDEcJWVf/Rs8Ru/KAtswfW4u5ntJElzapsWf3j1aWsj
   Q==;
X-CSE-ConnectionGUID: Lo6gKFnIR/6EHtBVZMw14g==
X-CSE-MsgGUID: nCtNH/xqSBuVSlahlnPh4A==
X-IronPort-AV: E=Sophos;i="6.14,259,1736784000"; 
   d="scan'208";a="54180808"
Received: from mail-westusazlp17010007.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.7])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 22:26:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKq1VaDFQXSZMIo7Otw6T/TG/6ROrfu7a1fpzXFmPoVbAf52qU5sxGylVM4EO9BPh1OVzA+0VoLrTDXn29t6pah+ePACMThnoUz+eq9AvXw5sWXYDNPiijhkCRxO0+TC2ZDtnw2QyK9FUziSHpl1FRudIZUQbRgos1fwQpfTe34ZnRjymV9fX20ajvAdlLSeiKNpO2QybZxuurVhWMC3ycrQgPBWiO730T+hg1BJL8ZF9i/cgBBs5TggaWaFBJBBj4izsk56KyMxYcmX0xbJQcEhAnnPNMx8bozR5GMZM1SF8Udgm6EljgdS/U/kHuC+gUm96MBWp1D4cTR9oEWRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnpI7EqSwyROUqy6Lg2bV9MaRqraNHNaaVjXFwmSKUE=;
 b=Y/TjU4fU1Brexn35inC5FCjwcO53po7miRgsV7no6lzIXWNxEqKNTO5jAiI3giF6JIS6hzvcPUPKbjORZkRuMXwuNtuWtCDrwDLa5Z/eHFogFfYRz7lq+SLbG5xUWwv7YJ/V5vXOaVthYMbXvqbvkPLdi35KXh+aA9/X2Ir7MTtdYC0+lEJkf9Y9w3LetV2HBLDTmQVqRM8Ga3NLS4iTN/43iXueUo6PVzNksdza488787fSuwhhula1QGkOk9POJJI1shnrezMlvzAoETlrZfDvQhb/7G0qYDPE/rnfu06XYlE6OMIikmt8JNnapTpfPyMb0au6zpfQgkariPY69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnpI7EqSwyROUqy6Lg2bV9MaRqraNHNaaVjXFwmSKUE=;
 b=olCSZe3GP6AKfoOK4EvddGl4zqJEsqGYYFlLZyie2F3rZFMnpEBZGRpla1oqukZz3AHKeALkPqKSTypTjv0xvYFtmYoAxRFbVk665SfWHbQGdpwuEIsDZ1hnDJTI/4OS44ivfbvr5I2IfuZQpybYgnuyjuDtAoV55EtFqiNcucE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7715.namprd04.prod.outlook.com (2603:10b6:303:af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 14:26:43 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 14:26:43 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Mark Harmstone <maharmstone@fb.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix typo in space info explanation
Thread-Topic: [PATCH] btrfs: fix typo in space info explanation
Thread-Index: AQHbmB5oS5uTJesuikOGPIfy5sHhHrN6haKA
Date: Wed, 19 Mar 2025 14:26:43 +0000
Message-ID: <cc167caf-371b-4b67-8938-844cdc910464@wdc.com>
References: <20250318155648.159250-1-maharmstone@fb.com>
In-Reply-To: <20250318155648.159250-1-maharmstone@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7715:EE_
x-ms-office365-filtering-correlation-id: d7f5af7a-08cd-4ca4-8ec5-08dd66f2125f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NmVON2ZHeSszd1h1V00zT3JmQVp0RmJkaEFrM0NyaExhdmtUT3NXWEpsRlQ4?=
 =?utf-8?B?STZ6TjJrZjdmRWtJeXptTFJlRXo5R2dWY3NraGMvZ3dXa1Z4Q3Vpa29SRGRL?=
 =?utf-8?B?SmJ1Z0FyeXEwTENNM0gvY3Zpc21sZFU1S09QQW9IZHFTQS9PV1RrQ3VyTXcr?=
 =?utf-8?B?ZXRVNW94MEkyL1BOSWFUSVJWcXJwdGs0VmtjTFBqMi9PZGgxb3FFQVZLU29y?=
 =?utf-8?B?S3VJRXJRWkJENUhVYlEwbFdGd3VGNWcvOEVmRUd3QU9Ka00rb3JKNGoxcVo3?=
 =?utf-8?B?R2hDcG4rY0laU1B2WDB6L2trcXBjZmNTY21JZDI1d3liZWE4d1loQW9yRUVB?=
 =?utf-8?B?eE5EajNOQllFYUYxNXF2dlJHcHFPZkN1bXZIYndLem1iNVg5L0ZETkxONzJr?=
 =?utf-8?B?dGNtZE5uLy9CY3NkRHdGMkcxVk5STVhEZGVmbnJQb29KclAzQ0psWWhVZE5I?=
 =?utf-8?B?eDUrVVpjSEovSWt6bVk4dDFmWHdiSDZWcXZLNUxoSUlkRzRMVFlqYUNia1FQ?=
 =?utf-8?B?cTIxNmlyOHRSa0kwU2I3VDd4SGVOQnQ0Vk9aWTFxcW9RVWFuVGw0Z0Z5cmNH?=
 =?utf-8?B?TWE0VmhEa25Wa0ZyMDlGRlowbFdoVEg3OEVpL1RFY2I4alpiaEYzd2t6MmZY?=
 =?utf-8?B?bm4yOTY2TG00QmxnZUxNTFI1enhoM2Q4MlBVenRZWVNkOC9CanlVSjFsT0Fa?=
 =?utf-8?B?ZWIrdC8xeWYxM0s0d3ZoMmlGdW1nWVZDb1d1S0tQbUxYKzRnVlhKVGZqRGZ5?=
 =?utf-8?B?V2JTWUthWWFqT1dZbisvSzIyZXYvaDVpVW0vb1NlWDZoOEpIbFJsZWpscTY5?=
 =?utf-8?B?cGdVMU5Db3dXREp5Q1dFcGVjRTJPaytSMWhTR1Nnb0lGS1lzcTdkVExTUDZL?=
 =?utf-8?B?TjBSeEpvcm1BYVFYZms1M0x3VU52U3BEMnBwUFlySFQ2MmI2TWdRWG1Mc0FJ?=
 =?utf-8?B?UmZDKzRuNnhhRTRENUd1aDdXYThYMkYydWZ6ZWJJOUpFUUdBVDgyWi9xeVFp?=
 =?utf-8?B?ckM4TFl5OUJYNS9wWkhXdEdLMzdhZ2JMcThqb1hlYmtvbFVUeWgra2lJRVlo?=
 =?utf-8?B?U09lVThiVXZTQ1RLcGIyeEoyL2xsWEtoRkFWc2FjYjlsVGRrYzhwZlo4clhx?=
 =?utf-8?B?M05DSXRjb0daTmc5SWdGa2xyNXhhZUZZVy9GK20rZVNBbFdRN3VkRlNKMGZw?=
 =?utf-8?B?UExjVlNKVGRTcjc5N0VydXc4WGNUd2FGSTFxakJXR2pSN2hRUHVrSEZhMjgz?=
 =?utf-8?B?QTBhSzR4cnpGaGdIanp4dnVtUU5JVEhLNDhZUFFYZTBZYzh5cDRRQTdRUlUv?=
 =?utf-8?B?T1NLL3NtWmc5TVl2SURZb2p1QkMra3lic041WW9Pd0RIS0RDZEo1UWNTUEVF?=
 =?utf-8?B?SkcvRTNPQVBkT1ZCWmpDbjdrbXlDc2VsazhwZU91YVh4ZXhNYW9zc3dXMGpQ?=
 =?utf-8?B?M0NTOWVIQnJFaE9Bb2FrSStINHErcmZ1anpZRC94MDBDczZtdmlaTHhPdHEw?=
 =?utf-8?B?eW5OMThmUGhwUlNQZXBicThGVnBJaEZwcTVTUTRSZ2xweWdZS1Nsa2xadVdn?=
 =?utf-8?B?S0RzM291bm1GczFmV09yZUVjWmJMYW5hdE0vUE5YamlIWncwVHpyZ1VrQ3NB?=
 =?utf-8?B?M2EyQjc3VkhRdDR0eTJBMFFGL3dOdFBENGEzZFhvYkRsZldrWGN5TGJQM0ZS?=
 =?utf-8?B?a1NBVzZKVWt0SWowY3BpWGw0L09QWlMzWU43c2dwTjh5Vko0MUFEZ3dIQWRF?=
 =?utf-8?B?QXcvWEJWZEh1Smh2VXZYQ2Juc2hOVXgzQkc1NzQ4dFRnYVgvN0ZxY2RKOElM?=
 =?utf-8?B?NkJlK0dwUWpVNjhmWXlyek9zY2lOZWtwRUF0SHRHRFhqWVhEb0xwQmtqOXFw?=
 =?utf-8?B?a1JtNTRwTWhXeEV3eENGbXlCRTdwVmJ2U1Y2MkYrY0xQODRzNVJBMHE3VVYw?=
 =?utf-8?Q?Pd8EX/scRDe9HrXhrbpe1o2xs9e59cZR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZnNlYkhUN0lpWlhpNVcwTVNtS2NMcTlOZ21HNFBSRXA3anZjQ21pbDhhZzdF?=
 =?utf-8?B?MERneXp6Z3ZRNHZrKzM5YVUxRXZBcnZtZkRDUERoNU1DSmsyUFNBeDdTcmVv?=
 =?utf-8?B?WVZsMWhaUVdpNlJObldURTdGZ2NCdXpxUmlENXFWNk9qakRoRG5Ca2lHLzl4?=
 =?utf-8?B?OEFpWkRvbzMzcW1EUjhGc2tHQklsMjk2QkFISnRZM2h6VnlmNmZEZXR3Rm95?=
 =?utf-8?B?VjBETnRBVGplektEemJKMmFOS1A4dmJqWGdST2Y4KzlhSFVPOXhtb2ViaGNL?=
 =?utf-8?B?SzNza3lGek85MkNKMjZybEJtaWZ0ZDhreUNVZk8zamJCTlF4Y1JMK1ExY0JB?=
 =?utf-8?B?eUpkR1F1NEg4NzIrMkJuT1RlYUxCN2k1b3JYQXlLN0V0WVFkNHIrTGdIS2V2?=
 =?utf-8?B?QUhLVVJ1V1dsejV3T3FjMis4Vjg4Z3Q3ZzN4Zml1azRpM2JSSFNmNGNpTEYz?=
 =?utf-8?B?QkJsR3ZHY0dFSDgyeGE3aFcwWFdudFdFNDNkczJUWDkvRXExb3lsTzZETlo0?=
 =?utf-8?B?ZGpCZ25SeFJucVNUbFNuRk0wcFhuNmFTTUZDdEt2U3Jhc244QVZlc29xa2ta?=
 =?utf-8?B?M05rL1F3RTB3UDBtNE9nV3pHbk1VcTcyQisrSkdzanlrY1Fha0h6Z1paejFt?=
 =?utf-8?B?Q3Rrb2JDQjRUWlBHVUM2NjJiekZVb25FTzhiekZXdjhPWU15OFZza0YwWjV4?=
 =?utf-8?B?U0ZKVm5JdFZpNEdFOWt4WWw1VC9ocWhWaUtKM09vMERDZ0N3SEtzbndmcnBR?=
 =?utf-8?B?TGdKWlVVU3BZS1MwejJRWFdzd0FmT0xYanVxdHNTVzFtbnZaRUE1TjdtbnFF?=
 =?utf-8?B?YVI0bUVZZVh1WkxHdlQ4dXJDRVJMQVJaa1lBTEpkVjBuSGlvUFAxK1l2enNQ?=
 =?utf-8?B?cTBoUkV2cGtBN0NFSjhFYWQyeDZUNWtCUzRvOVdNc0FxN09TWCtHWFg3bTla?=
 =?utf-8?B?aG1ZbHlYTWdzMEkvN0xtZEFYVXBlM2RPc2ZZUURGRXVBRnRLZlFlMnBydzQ5?=
 =?utf-8?B?eUVSNjNLcittS0R1QUNuNFhoclRmRUZ5SkdhRnBRS0tFTmlYekhNYmhqR2tQ?=
 =?utf-8?B?cU1mT3h5KzhXRVNUVUUzMkhmQlpUbEVBdlVkaXRpMEhMeXFwSkFSL3NQeUFj?=
 =?utf-8?B?QUJXL29zbEEweTZJbGp0S09zOGJRUnlWUHFvdHV1bUJMdldBOHJwb1dhc0F6?=
 =?utf-8?B?VFN3REtaM2xkRTE3elZsZUUwUlkzL2hJSXh5SExJbWFSei9rREc5WVB2Tzg0?=
 =?utf-8?B?aWpCbUhjNTl1YmxBRi92TEt5YWVzREN2TDRLeElnLzFJNFZFRHBQVi9zL21U?=
 =?utf-8?B?WXZURHZFR3FKNnZMRnF6RllpUUVKZDM3a2x6Q1JEaG5FeEFCMDJrUVFUZzZH?=
 =?utf-8?B?RVo0cFBPNXFIeVVKazduKytBRmNxUWhucHZFdDhRRnA3RlEzenZoam9yTTVn?=
 =?utf-8?B?dFVkSGw4OHVCcnNZVnRNR1kwN1FQZXZKT254a08ySzhDVHlSbTZXa2VDTy9U?=
 =?utf-8?B?L0dMWWhWOTQybHpteDJ2VloxRks4RjE1RTc2VTBEZ2FZN2tqdFpOZlhFVTkw?=
 =?utf-8?B?a0Z4YjQ3MkYzT3Y0M0M3MnVUZHdoMjRNOXpsNDdTZGJyajdwa3h4MDgwY1Rm?=
 =?utf-8?B?SFFUekRVcWxFcVVxZDY4RW11ZVJEbS9KMlFSMmQrZVI4TzNRVFZTUW1ERWFj?=
 =?utf-8?B?K1p2VXRxc3hHR3A4cE1ZL1RHWUNLQnAyVXVETWlCSGJLaktpS1oydWdhaVZj?=
 =?utf-8?B?N0RNQWh0d0o0N0crR0ZyKytHWGJ6ZUR6NkF5M0IzQ05lMmQ0QjREOGpOVmFZ?=
 =?utf-8?B?d3BzOG91V2JkaWh6YkJJdHNtL3hsNEtWbEtXeEg0TWNldEJxUGdkeG1YU2pr?=
 =?utf-8?B?OHdvenJtYTRZb2pKQjluTDFVSUJGRFcrMWJBa0JBU09NOG1XaHNiTlprNm81?=
 =?utf-8?B?aFprMnNlblhhU2R0NGZ5cUFUZHJ5R0I2enRBc0lJcXEwSkZXT1hCTXNnVmZk?=
 =?utf-8?B?blNlM2FqQmVNc3JXQy9xSzhsY0EreWY5MkZJVGUwQ21CUVRodGdsTEFjbjEz?=
 =?utf-8?B?TTloc3p1UG5IU3NPSDdDYVRNSXpNdGZtaDJ2eWJuZHFibS9jNlNFejJTemEx?=
 =?utf-8?B?VThEUVF2NGp4c21UOHRobEZvbmw3b0c5K0kzd0NyQVBNVXptRUMrRjJaK1hG?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCD843C4ED6E0046BDA0049130A52025@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tep+62dDKj90dNpK/M+oNLizfYlSnXeW5231sY8bHh6kbblJY39q73BCyEqXtDY8z5UG5YkD62iia70j70HFUoJB9cuMc0H47OQEdeT98NrfyG9Amb2j+EsUAf5V5PWKJeYbgAAHargWMxdnphW1kHpNqUP1ZQj2iK9iR0B03X4E3ASk5DNrxEQr8ZTkIKLX3eRFdQrHxfu0q1aOXKFtLYTkmoMvGb0xvbYxRua/XllDFdcaRpjWLBD7s/IrQZ7KmwFKSsh3A4BmMnWNS54gQS+KIZDJKeHgq3AVHki2zl3EN+tRs11gtUmrHoVHkmLsxDT2/iEcj3X/u/ljcoVNdu/ff6LOApDSAjRLoqnzIYwrhk0cT/ujEClAvn4780BUxB0DwNhXCqjE1PshSMSFXa3DiVYcgGzK33SkQUSy9ddyBvzCPwCTKP4BfKpz/NATfrBhKE5/m94+sPxwuath37YdtnrAK8srstio20jl09o+Wa9Oy2JcM088N4c8QGwucNU/7gHOP+t7x7XdYtCUFXjoADtOPYm4r18UF1NTRpYlq3pYaKWmUi8YKY7Plxknwh3mRx25bO5EErXHb5NpbUHvPeNfZX81fgTKRQhTjy8sdsCdjniW3UOQy6PYUtPU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f5af7a-08cd-4ca4-8ec5-08dd66f2125f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 14:26:43.2426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pui/2tFmuRz3hNnSoxmO0zADBf6hdO5XcdbftsG8OqhG3DnMOcMgotZ7xCYUPZVcwz0k++/BEK6x7Z6XLwLQFueb6J9WF5oPAsN1CcsvkfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7715

T24gMTguMDMuMjUgMTY6NTcsIE1hcmsgSGFybXN0b25lIHdyb3RlOg0KPiBUaGVyZSdzIGFuIGV4
cGxhbmF0aW9uIG9mIGhvdyBzcGFjZSBpbmZvIHdvcmtzIGF0IHRoZSB0b3Agb2YNCj4gZnMvYnRy
ZnMvc3BhY2UtaW5mby5jLCB3aGljaCBtYWtlcyByZWZlcmVuY2UgdG8gYSB2YXJpYWJsZSBjYWxs
ZWQNCj4gYnl0ZXNfbWF5X3Jlc2VydmUuICBUaGVyZSdzIG5vdGhpbmcgY2FsbGVkIHRoYXQgaW4g
dGhlIGNvZGUsIGFuZCB3YXNuJ3QNCj4gYXQgdGltZSB0aGUgY29tbWVudCB3YXMgd3JpdHRlbjsg
YXMgZmFyIEkgY2FuIHRlbGwgdGhpcyBpcyBhIHR5cG8sIGFuZA0KPiBpdCBzaG91bGQgYWN0dWFs
bHkgYmUgYnl0ZXNfbWF5X3VzZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmsgSGFybXN0b25l
IDxtYWhhcm1zdG9uZUBmYi5jb20+DQoNCkxvb2tzIGdvb2QsDQpSZXZpZXdlZC1ieTogSm9oYW5u
ZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==


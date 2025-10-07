Return-Path: <linux-btrfs+bounces-17502-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1FABC0F9C
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 12:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55C63BC0E1
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 10:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8965B2D8362;
	Tue,  7 Oct 2025 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GMNx2RPY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="esSFPYvs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED96E264609;
	Tue,  7 Oct 2025 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832004; cv=fail; b=jkdo7xi0DExJkpuGXzwLE4kB7MpYLF8EcNHxEmr7sJsukXSXZNQ8v4QVpVWZ3AuEKwQ+E1kL+N/6rVElAOvQ4LHQNhVgE6izBH+AID3+QB/LJeJkIDnGvfNkrHsjKS7uMD7tG4/w5ffKvm8EiHeK62TtxZ6CIwWxUkdBsz5H6jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832004; c=relaxed/simple;
	bh=zgsQzO7EUH3ChrgF1aQGhLSuJ8H20XEGrXM0A+PaFdY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SHx6cjLX4wSBdJpQHKFSd61Ef5fx1PNkM145KL0dKDZ6RtY0fPk2+98M9Pctc7/VGnpsJTJ0KNMslJDlbVxDlzbUjw5Yg0ChvSInrOfEN3bQWKFpaFiqIFnD/HvfZjE1hykV1rCv+hVz+X32otmJnz4804m3K+gMtpQC6PBQY70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GMNx2RPY; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=esSFPYvs; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759832002; x=1791368002;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zgsQzO7EUH3ChrgF1aQGhLSuJ8H20XEGrXM0A+PaFdY=;
  b=GMNx2RPYVwNn1RIYe13ohwJBddf5dU3QiomUrng6F8O7K+tYTBa2a0Lg
   DjBeysySD16VffX0Oq/N5m0hw0J7ISflj6aLwAqwKrdWV0Z9pR/EstQT/
   fy/zbjM/jgEmIUx1he2SdSxOwfJFhBtomzQYnbkaAKuoAfofeynabvXcO
   OAUSy1U+t34SDVaCpnpDhQ2WuOCvFuFJ5UJqaq8lLGAcgoR/zYoVwGOTr
   mP7tnB6oT2QetjXV+yO8ZKgTyhWPECf5Bs3zraJ9wtG/aZBovaLdAvtI1
   6x3ccrlRn67Z3Kpky87Rz9hTe+u0CCqMZI6cBM9QOkqrQjcirQd7r843T
   w==;
X-CSE-ConnectionGUID: q0u/IjCaR+OySG71xlA3QQ==
X-CSE-MsgGUID: 7Gg4iqx9TOObARU4d9Mpsw==
X-IronPort-AV: E=Sophos;i="6.18,321,1751212800"; 
   d="scan'208";a="132610679"
Received: from mail-westusazon11010068.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.68])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2025 18:13:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACWDyx+J4Y1W1oikKijAWxx0/lpltilzNVlGqf81m/J8/No2M6UFACoMvjM1w5bHK4O2Ir+P7cJuYFW8+sDvqHr5MSMqnA6eYgvv217Ob566xyaC6/Tu0df79tQYrOP/TcSCzExBvp1LTSpGuJQUr/LJ7tR16iWwpCLRm6HS7+Q0MfAJrBM9lrmOSvcl7Fj0Fe4zJTuj9vnOvyiCULPSinWoRM4RX7yCpz9FJU9pUStktqSivRUnYS5+0SSAzQM2nLihWSd7QX4o85OAb1gSGZBiDhtc8ArCIa5jSfRR8YOsExLSPC2Q/s88v3oPcLj2s/DoHRQaWb2wCgr1YFKJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgsQzO7EUH3ChrgF1aQGhLSuJ8H20XEGrXM0A+PaFdY=;
 b=uvvY6X2NgXAc9Wi0W++HyjCMYz1ZMpcZSSAP3IwBXrOEdklHHtGlpA1JOntTA1dSuw3/8/GhTgJ1QYLvq4+ojTBoaKb6JhHEylOlCdK3lmG2XlkS/4H5gbX9lXD8ICPg21aC3m+9Mzg8usNhiu2H09PiwYckxuD6YieWJgITUCXOiubWHcay8hU3Ojtz3eFD8iRyfRuzqnq8X+v7TifL+zEvz579h3MrOznmUuOPDQCizScIi1I+gUBDdSKOlfq0gBcc1n8B2XaT1XUQFm6BRCzRlIE7pxxCuqYSVlrJe3QnLSc7PECBM4QmKfrAuIDLFgsdkRLKiG4vwKN6sSrpCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgsQzO7EUH3ChrgF1aQGhLSuJ8H20XEGrXM0A+PaFdY=;
 b=esSFPYvsCTouqoWKGSN8fNL++LhBUROwLxrNyPWnNsG3UXi9AQCN7l9DpNI2qn+9Tg/h45kuwtzNQiv0f1ZckR9MivTrherROnMejLgIni1c8NUx4WXvB3pGi2qhipyms4e+XPpI0MXj5zNcwuV2OnXaTr1B230amgrxpzFMGE4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH1PR04MB9735.namprd04.prod.outlook.com (2603:10b6:610:2b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 10:13:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 10:13:18 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?utf-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mssola@mssola.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix memory leak when rejecting a non SINGLE data
 profile without an RST
Thread-Topic: [PATCH] btrfs: fix memory leak when rejecting a non SINGLE data
 profile without an RST
Thread-Index: AQHcN08Ff68oaDows0qTslh6hE1dNLS2d2IA
Date: Tue, 7 Oct 2025 10:13:18 +0000
Message-ID: <e82bb44e-5f56-4ddc-976a-9ff268a5b705@wdc.com>
References: <20251007055453.343450-1-mssola@mssola.com>
In-Reply-To: <20251007055453.343450-1-mssola@mssola.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH1PR04MB9735:EE_
x-ms-office365-filtering-correlation-id: 3d6858c4-de28-41c7-b001-08de058a233e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TGF1U2JxYTBsa3F1dll4MEdKYjJBTzhRM01UOUhFZVVDc21PVVVzMU93b3NW?=
 =?utf-8?B?R0tQay9adFBjZkxhWTV6Q3VUaWlpRXB3WHQwMTFJN3R0RWZxQVFsMTFtdTc3?=
 =?utf-8?B?cUFMbjk5N1ZDMWd2K2ZqOVRySGRBTXhlOWhqTHpRVjlIdnN1YU9Kc29uc2p1?=
 =?utf-8?B?MHNLbXJFNzRtVGhwb3FRbExJdDNGdnRWcmlvY1FQVXJNeXBvZTZZcG5Bc25W?=
 =?utf-8?B?Y1BzTWJOdWVUZEpTYjlxT0MrUktaUTZmb3NMNDJzV0MzamxHemtwM0lCSU11?=
 =?utf-8?B?ejZVNFAxenlFcFhORWR3b1ljbU9hZ1pRVVAza2lJUm02ZU02b2Z5QS95ZC93?=
 =?utf-8?B?NGRmUnFpTTBJZGFWVXk3eWVDb2VRbjY2NXZodE1TNEc0d1dWZGpNZnozVlJH?=
 =?utf-8?B?TzNiNW1BZVBQVlQwZzZycDBnSkJMcDlQMGtyVzdjbzczenhseWxpMFp1a3lY?=
 =?utf-8?B?R0VwMzhFVi8ySWI2dWRadTBVaFN3VXE4bjRFNEswL2hRMVRRUU05SlJKZ0lj?=
 =?utf-8?B?ZmNhVnNoa3JtenQ4RFcyTGFkNWgzS2RCWnZhVTF6TnFnUHdEQ1kwVUNIa3V6?=
 =?utf-8?B?REdudllkQytvVFlkd2VIcW1mTWZaMXhqblFFKzdOVW9zMFFhS3dmS0ZSdDF1?=
 =?utf-8?B?VDlTQnFpY0tUcnMvc2pDbm1YTnY5UDR2azZxTEpES2phQU1PTGY3S2ppd2tk?=
 =?utf-8?B?QXVleVlyVDJRWGttWUZsZzc4aU1tYjNBTk1mOU5vTDJLcnhBSUdEL1VZWWhn?=
 =?utf-8?B?UXppcFB2b0NwRHU5YjJ1VzF0Q3pyK1dvbThuRkZKU1NGWjhJZjZxUG1LemE0?=
 =?utf-8?B?OC91bys5Z3U0RENIcVN5K1RMQmlzdG4rclRwcG9BTkk5ODZjU3QxUlpPLytn?=
 =?utf-8?B?VE8zdG9QN04xNkJBVmFYalFGRkdSRkRpMzVMcFVoWGROSDFnYkd0czh2aFBX?=
 =?utf-8?B?Sk9yaWF3OC9Tc2k1emhWNzhuZGh2R25pckt4dGQyT0lxZEFlbEFXaXhQM3dB?=
 =?utf-8?B?dnNxWnVlWG9KYldZdzlxSGZJTW0zWGN4d1paNzJtTldjaFk2ek5IR1h0d1l4?=
 =?utf-8?B?bW5TOEhVaWpLcmtaTTQ5eWFBTksvYy9oK3NieDAyYUE1VmVQUEx2UXoyeWpH?=
 =?utf-8?B?YkY4ZTh0S20zaUdYQkIwVXEwRDJFelRxQUxiOHFyK2NjYkxnNFJDVDBpZ1ZF?=
 =?utf-8?B?OTRuek94anRsS2FyNHFQU3FPclA3eXlnMmFVY0x1TnZxSHJxNHZZNmhwdzhn?=
 =?utf-8?B?d05FbTFqSVNTZFFIT214Q1BQd1BQbkRJNHpyWklVMEVLblZSbkoxY1Y4anZj?=
 =?utf-8?B?a2ZSMUJpeEsvYkJwOC9jdVA2OVdFejY0Nkw3aFZBbGNmL0E3RGJJaGxIbWta?=
 =?utf-8?B?c3pac3Z1cUJHeUltcVhZb2JOamdYNFl3N2JiZFg2RVpKY1Q5aHFKaUl2Tno1?=
 =?utf-8?B?ZUFGTUtkNjNZSUowYlhJVXRVUFYweGVpYnVFQThEbUFMSGM3T1dNaHVIdUda?=
 =?utf-8?B?YXF5U2l1UXJCOVRmWHdRWGsrajRnWXVZNHU2TFZuNk9haTlBaGFic1lpcHlh?=
 =?utf-8?B?b3JrVTdSSUFIdDVJUHZ2TklUWmlINStmV3lqWmhHdEl3MWl6ZFFYZ0VsZTMw?=
 =?utf-8?B?dnZCOU5Vb1lwZEl2Vm1mRkc0RzRZM2pqY2pULzJxOTBaeUxva0NTNkNoUEJP?=
 =?utf-8?B?M0ViWmpVd1A5NGkzeXJiOXRGKzBaNlYzSitzNUMvUmJ2QXNjaElBRHFpSU5n?=
 =?utf-8?B?RThsWlB3b0MxeVVna3ZMdXVjN0g3Lzk2NmtnSUVjUDE1NUpKYWpKTkdESm1W?=
 =?utf-8?B?TThnNmgyLzRFbkZkam5uVldqbTZJRWpjTG1yV1UxMlpmTG1tdUQ4Q2lSelRX?=
 =?utf-8?B?SEpzUHEybmxrdVBQVC81a2dUalBmYmpFbFgrZllzQmVwdzFWMlUxWUxwVEU4?=
 =?utf-8?B?ZzhXRkQvYWJhT3J0SDZVT0lGaWhvZTgrN1A2ZjlpLzZQVW9uanMwZTdLMkRm?=
 =?utf-8?B?NUJFbTFMWnNPbUp2WjBhSXAxVWJaRkQ3RHRxcVVUcGdmOU5HZm5odkwrMVZM?=
 =?utf-8?Q?AmTEOI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3FZaFFqVmFLd0JpVlJTNjZkYWxZSW8ybTVwWmYvaGl4KzFtYmI3Nld4ak9t?=
 =?utf-8?B?VzhNTWt3a1RlKzRWcG8rdnMyNWZOQjFXTFJhTWVmaE9ReHdZK0JGTEhEa3FS?=
 =?utf-8?B?eHcrU1F5SzE3Zk1NTEdVVU8wN2dMb0VLTllkTTJYb0RWMzRzcUpCRVU3ZU9N?=
 =?utf-8?B?T1kxYXZHOUdmeGMzeHFoaXBCV25zcXJybEo2VExlbWNFQlhVRENZWisvTjVE?=
 =?utf-8?B?NE54UmZSZW5TRnQydURJZFI0RExyYlBOanV3RGdPdDdraUhVVitGYldNbkNl?=
 =?utf-8?B?WnpDVEN5Q3dXVER0dEZWRy9lVUZLaUlXLzJza0Q0VGxMTlU3NW1LbmZNWGZj?=
 =?utf-8?B?WUlEODM0cGY1ZjQyYXdIM29WVmVvcHE1Qm5nNHYvNkdTZmpINjlSUkt3REVE?=
 =?utf-8?B?TWJkbm40bjRTc0NMTHRMR3JKU1hRN3pxVFl5cCtKSnRkZ1QyMEFESnN0NHJs?=
 =?utf-8?B?T1NBS3crNHJVdFJPajZoK3ZHTjFYSGlVTEZSclpjOUp0N2JqbHFsUmlSNDV3?=
 =?utf-8?B?bEVUNEVmaFB2WFdBQVdoQkVpcWhRT0RXY1lxUExuckgrUkxLR25vWTZ1VGg0?=
 =?utf-8?B?Q2VtQS9FeEdjL2dtaFRRZFdvYXBjL3ZJeEZvdjR6OXdwbnozTWZ5b2QvNnRJ?=
 =?utf-8?B?MnlqSjMxTHZvR21DN2YwR1N5RkRLc3N0Wk9xUUFQWldEend0N1lNbG9pS0Fk?=
 =?utf-8?B?ZWtxcG50M2FaVGRWZUlzYkMzK1gzM2NkczRuYWdIaGVXVnFYTE9NV3g3aENt?=
 =?utf-8?B?dW03endvUWJFc1RFR3lSYlhaNHNOeTdrNHk0czZkMGw0YW1ZM3VXZnpzNDBu?=
 =?utf-8?B?RFNjUWFEdm5acTA2UUJ0R0ZUaDgwMnBOTFR2MVo1V05Od1UrLzhhb3k2L3V1?=
 =?utf-8?B?YlRHa0pkTlcvR1BQWHkrS1l1bEVJbXBuQlBPbVorZFdzSW53Ly9QZk45VzQ1?=
 =?utf-8?B?QVR1RDJVK3ZhYTIzZHJkai9RWFpOL0RwbGJmTXFOY1dIQnpDRDlzOGs5Ykp4?=
 =?utf-8?B?Unc2QzQwZGQ3di9hTGRaRGpTaFFKMUpacFlLNnZpd0hPeCtycFFhUHBiUVFO?=
 =?utf-8?B?MWxRUFRRMzI4MUh5Vnl1N3hlU05LbktZNGxCVXdpckhWS3hVR0VKMW5uWWFn?=
 =?utf-8?B?enlicFp6eUUzWitqaDFOeWRZUVV2NTBUK1NyOEdCSVVTYTQ3dVdSeUN5S3Ex?=
 =?utf-8?B?THQxaWxNNk5JWGFxcE9rclRGOXQyR0k4KzlLTXJIdjJxblV6UCtJN3EzT0ZU?=
 =?utf-8?B?Y09Ed0E5a2Q0YnYyOSthN3dIQkpwaXdOV2ZnSUpqQUtLUUZ1TjZRUk9iNzdM?=
 =?utf-8?B?bmtUTlMxNXRqUWVYSnhWcllZMlNuKzEzZEl5M1hlOVlnS3J4cXhZQkhlbjU3?=
 =?utf-8?B?OGtYVmdzYU0raHhxblNEV2k1MEVLNzFZNDJmNEVFVlVHbENneW93MExUcVN3?=
 =?utf-8?B?eUlNenhKdlVUTDRiT1VrQ3B2VGMzcERFK1BNYjhVbFVoUjYvMmE3NmFrVTFI?=
 =?utf-8?B?bTNkdmZxOFJ0c0VUU2VMbkUyNkl2d0YyM0E1NkRqaWRNbzEzdkJ6NisrcFQ0?=
 =?utf-8?B?cXVnNllMTkJwNXZrM2EzOHVGVmlQelZOUmkydzl3VUZZc29VNGZka1FScDla?=
 =?utf-8?B?UG1aSFo1ZXMzWTJWQlhuVXArSGNDMzRsUlhLZHhBMmJEVDhjSTBsSkxYc1FX?=
 =?utf-8?B?YW5Oa0FQUWFjZ0JKQ01lVUdSdTBQZDdaUEhxUkFnc0NtSXVEK2VuT0RYbEVV?=
 =?utf-8?B?NnZtQmtnbE1CbHpDNEltdXF3dlVlVXhNb3FzUlVkMU1TU2x3TTlnQWFvVkZm?=
 =?utf-8?B?V2xpT0d6SVA3NEFLd1EzUHhEZTRNTkJFYnRGaFlXQ1hNWFB5WFFPRFRnL1Uv?=
 =?utf-8?B?QVVyZktjS2IrK1ZjYzFBNnpFUFp1SzNyK2pRSHZlbi8wKzhQT05CK3FqblQw?=
 =?utf-8?B?OWErbVI5NDVaNnYrSTEvY0NmVGE3MmswVGl3TkYza29ZaTdxMnR1cEZsOHJ1?=
 =?utf-8?B?VGVpVGlLZXhtSHRXWnJwRzFSUjl0MzBDTzZzbkQzK0gvay9YWXR6SGlPZC9s?=
 =?utf-8?B?YWV1a2l1U2JkWllRMnJ3bmxhR2VuU2JNSWYwOW9Walpwd2JSbVJMWVA2Q1Jh?=
 =?utf-8?B?SS9BUkZnbjR0dElmVXdJQW5ET2Q2c1pvbmpaSDhEcnlQYmNqcHFxNFFkVWND?=
 =?utf-8?B?N3VrMXNVeWZ1RlBOUmtuRnNNYTZBaEhUQWlWeVE5SnIxSTNhV1djc1VjMUc0?=
 =?utf-8?B?d3ZtSU5MUGowTkZIcFJmMHZLcU9BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69E6CC66F9A4E1499347AE2E8E0A2B1F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	puZUKwph9ZVpWZ+o0/90Av4qXuGKT314rLDV2IBZuvv3yAkP3hyezlnm0oplSxvyDihrKq7xn6Yx6HSCXy5Tc1qqLiPBNR3GhUw9ko8kPY7/rcEO90PKjW3bq6AhUNaleFAT5Ac/mBqdLy6foG3zhOhjzuqtyj+vL+NxHrufOHVUUS34Wnhc4R5b83qpyC6edoFoZf70c1j35NzgmcxkiBFYthD5THOZbjJBeqrgfQFcPZ2sTFuYSAwppt0kcP7VIPEWBjv4QxuvIVdC/E1DoeZNf4iVYwICGJCMm35cyLdV8BofSDkbaXHKLq4phAIHU2EMXSqj5zvbOau6kzWyz7qpJNLm9KCDUairOZyik0O6qbfNcPvExC2K7dr6anGCKt3L8jz+ERrt5S0DUCn+CITp2WO+8aTle5BbFx0SJlkRNy6zO16tej9pyAwJgqQJ5bnBuxek45BxfjGuJ+DlOtwqCqxT485dTBawmN+PBluZ+/CQAJn3B18BWJd8JVEyQ+ftVh75fklqI1fW2WeG9N0xt0NaxJ/LGH1i/sFfIO6JOzaZKi5iNBFxumq9JYVjlz5AKa4zdd4lJtcSfspYe7x4dPYgaXsDTXI/Obuo4/KIH0OVy3IaByc2R+RmC4AA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6858c4-de28-41c7-b001-08de058a233e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 10:13:18.7543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NhQINIfFnYNCrFpDSUPYP2NW540bNEE1IwImKAc6bZZMwMiRP0wv60bQyPFcReXLP8ofazrxOVY7RTAICYCaJipVBr0ZJm55ey2Y8FHlYiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR04MB9735

T24gMTAvNy8yNSA3OjU1IEFNLCBNaXF1ZWwgU2FiYXTDqSBTb2zDoCB3cm90ZToNCj4gQXQgdGhl
IGVuZCBvZiBidHJmc19sb2FkX2Jsb2NrX2dyb3VwX3pvbmVfaW5mbygpIHRoZSBmaXJzdCB0aGlu
ZyB3ZSBkbw0KPiBpcyB0byBlbnN1cmUgdGhhdCBpZiB0aGUgbWFwcGluZyB0eXBlIGlzIG5vdCBh
IFNJTkdMRSBvbmUgYW5kIHRoZXJlIGlzDQo+IG5vIFJBSUQgc3RyaXBlIHRyZWUsIHRoZW4gd2Ug
cmV0dXJuIGVhcmx5IHdpdGggYW4gZXJyb3IuDQo+DQo+IERvaW5nIHRoYXQsIHRob3VnaCwgcHJl
dmVudHMgdGhlIGNvZGUgZnJvbSBydW5uaW5nIHRoZSBsYXN0IGNhbGxzIGZyb20NCj4gdGhpcyBm
dW5jdGlvbiB3aGljaCBhcmUgYWJvdXQgZnJlZWluZyBtZW1vcnkgYWxsb2NhdGVkIGR1cmluZyBp
dHMNCj4gcnVuLiBIZW5jZSwgaW4gdGhpcyBjYXNlLCBpbnN0ZWFkIG9mIHJldHVybmluZyBlYXJs
eSBnbyB0byB0aGUgZnJlZWluZw0KPiBzZWN0aW9uIG9mIHRoaXMgZnVuY3Rpb24gYW5kIGxlYXZl
IHRoZW4uDQo+DQo+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBTYWJhdMOpIFNvbMOgIDxtc3NvbGFA
bXNzb2xhLmNvbT4NCj4gLS0tDQo+ICAgZnMvYnRyZnMvem9uZWQuYyB8IDUgKysrKy0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYg
LS1naXQgYS9mcy9idHJmcy96b25lZC5jIGIvZnMvYnRyZnMvem9uZWQuYw0KPiBpbmRleCBlMzM0
MWE4NGY0YWIuLmIwZjVkNjFkYmZkMiAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvem9uZWQuYw0K
PiArKysgYi9mcy9idHJmcy96b25lZC5jDQo+IEBAIC0xNzUzLDcgKzE3NTMsOCBAQCBpbnQgYnRy
ZnNfbG9hZF9ibG9ja19ncm91cF96b25lX2luZm8oc3RydWN0IGJ0cmZzX2Jsb2NrX2dyb3VwICpj
YWNoZSwgYm9vbCBuZXcpDQo+ICAgCSAgICAhZnNfaW5mby0+c3RyaXBlX3Jvb3QpIHsNCj4gICAJ
CWJ0cmZzX2Vycihmc19pbmZvLCAiem9uZWQ6IGRhdGEgJXMgbmVlZHMgcmFpZC1zdHJpcGUtdHJl
ZSIsDQo+ICAgCQkJICBidHJmc19iZ190eXBlX3RvX3JhaWRfbmFtZShtYXAtPnR5cGUpKTsNCj4g
LQkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJCXJldCA9IC1FSU5WQUw7DQo+ICsJCWdvdG8gb3V0X2Zy
ZWU7DQo+ICAgCX0NCj4gICANCj4gICAJaWYgKHVubGlrZWx5KGNhY2hlLT5hbGxvY19vZmZzZXQg
PiBjYWNoZS0+em9uZV9jYXBhY2l0eSkpIHsNCj4gQEAgLTE3ODUsNiArMTc4Niw4IEBAIGludCBi
dHJmc19sb2FkX2Jsb2NrX2dyb3VwX3pvbmVfaW5mbyhzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAg
KmNhY2hlLCBib29sIG5ldykNCj4gICAJCWJ0cmZzX2ZyZWVfY2h1bmtfbWFwKGNhY2hlLT5waHlz
aWNhbF9tYXApOw0KPiAgIAkJY2FjaGUtPnBoeXNpY2FsX21hcCA9IE5VTEw7DQo+ICAgCX0NCj4g
Kw0KPiArb3V0X2ZyZWU6DQo+ICAgCWJpdG1hcF9mcmVlKGFjdGl2ZSk7DQo+ICAgCWtmcmVlKHpv
bmVfaW5mbyk7DQo+ICAgDQoNCldvdWxkbid0IGl0IG1ha2UgbW9yZSBzZW5zZSB0byBvbmx5IHNl
dCAicmV0ID0gLUVJTlZBTCIgYW5kIHJ1biB0aGUgcmVzdCANCm9mIHRoZSBmdW5jdGlvbnMgY2xl
YW51cD8gSS5lLiB3aXRoIHlvdXIgcGF0Y2ggdGhlIGNodW5rX21hcCBpc24ndCBmcmVlZCANCmFz
IHdlbGwuDQoNCg==


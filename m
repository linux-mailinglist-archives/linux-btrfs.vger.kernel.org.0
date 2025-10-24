Return-Path: <linux-btrfs+bounces-18246-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 946F9C04B87
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 09:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9417A4E3DB4
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 07:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAA32D5952;
	Fri, 24 Oct 2025 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f90tIj8Y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lOAJg0fP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E20C2749C1
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761290996; cv=fail; b=loeaIoNmum3ZZ5hDd4/gxSEOKbInPVGZi8wkUzcvBBL0OBwy8f2FdPV1LpkQyBpqOC7beDwzu07xFTQkyi8LVbCZWo0s/Ab1/HT+jDYVUxxSkKtw5vLNVHIYD2BCF+oXIKJqF5tWs4cBkqxcKykS6EVFEiXWeuRX+aJey2TKF0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761290996; c=relaxed/simple;
	bh=lm1ackrqHjdDwtd1N2UV9VrxfUMRHGhsxd+y/hMIBLE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XemorLfouch9macflT9hWCBvPWqxk4eKdXq0J16s264ikObCilHOtm+yKSS8OtlVvILEF8vFDXilHgJ30SlExOPFFsyVDKlwwk1mM6FdHTrE8ADBIT05jXkFymCQlmzcj1kxksQu0kLcoVt/BUFEidHQU2648266/3K7SAd2RcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=f90tIj8Y; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lOAJg0fP; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761290995; x=1792826995;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=lm1ackrqHjdDwtd1N2UV9VrxfUMRHGhsxd+y/hMIBLE=;
  b=f90tIj8YHAzSCmuTY+DzXTrP9Ne1HOn9ICG9bjsrf+DLK114T9HXwwby
   +HECqgzB6A0AJthjaWyGSbF5wM9NRHYiWoSvErOZAU4XMbDDf+ex0D3lX
   XEUSMhMHnFFMMV+fL0yDQYHikEWuz+K9Gywgb9agk824Ctw72W2ANRzYB
   ULGOla63g1jVsUaiAROLp8x48NVxJAH/H+TzgobhsiZxgLcr2PP9Z+tAs
   maWyIAKjJXL7IxlyZ4fkdWu647dwiLf3I4nhkvN57PRwp6TKsscV3tjem
   STMf0y7hxVoHAO1u1M9dEnxQm72bskhld1gX7zLg+fDf/Y0zHyZSqw/n3
   w==;
X-CSE-ConnectionGUID: 4PYbW0zXRw2PuiIAdbeamQ==
X-CSE-MsgGUID: WBVh8SdGQyOrlEGmsT9fZQ==
X-IronPort-AV: E=Sophos;i="6.19,251,1754928000"; 
   d="scan'208";a="133834122"
Received: from mail-northcentralusazon11013065.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.65])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2025 15:29:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKxaQXUSnpHDY3mk0l70UxRK7MdZ0dDp/iEJe4N5WrOTVC2gmPpJeNiCnDyfQEsdJkE2MTknFGaSk710R9qLMzsjJHjxFahGdcz7rs5P5DvmxHWexF60Eg2HOPPvdDbzyg8cZQIS9La+W1e6lhv1Cfan2c+UeRq9Muc2N8JZnsrX2wtFfh3XN/ayoY+MhWtghYLUmu0AaNu4xK1+ysUP5ysaqSGo3rG42k7yuFaRMONpPyRx9Pei/B+VTLbvPRtteykR5/34PrFWOdX+7Xyr7CnQruMsK7FJuuPMF+abomjUUEZIhkGrvif1E9qcZiiZklUyY78TdWtzoPspUWMTXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lm1ackrqHjdDwtd1N2UV9VrxfUMRHGhsxd+y/hMIBLE=;
 b=MnsaL5CJzZy3TmW1D6FlG+z8rjiv/xqooDXczvK09UDmPk+4XqN5H2bspA8SpgkPJ4cYtWq1eD73WhlNxK7bbBTbjqu/8SVBEZHsCG+UnAb4XIj/zxk47FQ+GkUioQys2SKJzDoJSuB8v9eIM1qK2+ipfDXQx7P2E58P1KITYnKCu6o+1CZupwOOlLHYOjDzNARtg0ZOGaLwaO5pRhKYpZ39rbkxJYkxKIFlTC1Y6GBC6xOMPJy0PAYOQ6brw3QU4dS83FaQ70a/U8BFgBJkANn1T90s7+9QOjMFkYeuuyqRePA/VPqC+B35CmseB1nuM2g/ladiivr2N3fdUAXorw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lm1ackrqHjdDwtd1N2UV9VrxfUMRHGhsxd+y/hMIBLE=;
 b=lOAJg0fPm1MvIXH5Y05qyfexq/e3dFXvBN3h+k2abNjS4Hv5z3xZX13e4W+ICvn59ixT/u7CwMh+c43wb2GfZmiCHqXbkvSVwmjHxSn+/XhaeSHyqDasLRDvng7HiotEQSUgQFC2ZDEiddm6WeHQ3aJhWRNlt2YYTno6LvodNfc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6714.namprd04.prod.outlook.com (2603:10b6:5:241::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:29:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:29:51 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 27/28] btrfs: avoid space_info locking when checking if
 tickets are served
Thread-Topic: [PATCH 27/28] btrfs: avoid space_info locking when checking if
 tickets are served
Thread-Index: AQHcRDZTeRmcrnZtPUWL1N7a3MHHsbTQ54kA
Date: Fri, 24 Oct 2025 07:29:51 +0000
Message-ID: <a5aa1b80-ff60-4981-a06e-cb89c0ccefe3@wdc.com>
References: <cover.1761234580.git.fdmanana@suse.com>
 <078852f3ef7b95046eeca1c13cfb1bfa34ccac90.1761234581.git.fdmanana@suse.com>
In-Reply-To:
 <078852f3ef7b95046eeca1c13cfb1bfa34ccac90.1761234581.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6714:EE_
x-ms-office365-filtering-correlation-id: 05a37de4-6c2d-49bb-ab64-08de12cf1e84
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aFpZV3FHVTQ4UnAzMjZ6S0QvWEd3YkZJN3B0N0dSa2RGSUEyYlJYRUlhYk9D?=
 =?utf-8?B?bW9oS2ZGNE0vTzQ2YzJOYngwZitWbzdvN0hqVnc4OEVUM1JNQURCUmhMQkxp?=
 =?utf-8?B?c0tGTlVDSFJLc1JmY2h1c3RWVlloeE1qeG9BTHhzaWJBR2RVdnR2R1dtVkNk?=
 =?utf-8?B?SXhkelhmUTdKTzBTMGxEOFQvbTZqb2NmTHZXMkZWYnRPZmR2TXFURFg4dHl6?=
 =?utf-8?B?UDlMQW9HRG1kbStSMFFsTEh3aFdrcDZjTExxLytSc2FmRnM0ODFEUG4wdys1?=
 =?utf-8?B?bTdBcXFjM2Y3Sm5kR3VvSFJrQXRxOThkVkhuaXJXaFdodWRzMkk0V3crYXJ1?=
 =?utf-8?B?VFNadVRmakZVSEpoNTl5V3FlYkFPZktUZCt0ZE9mbWlqakQ2aUZvV0Fsaloy?=
 =?utf-8?B?dnNoQ2dxeUFybGNaRnNVYy8xT0RXa1pRSU0vYXlSOUJDNmVVRFNPdWt3U1ZI?=
 =?utf-8?B?QUREaFpMRUdtOGhvZVVtMk5oV0crNmpKRzltY1o3QjA4OEFNbUc2dWVYdFFy?=
 =?utf-8?B?Q1hVQmd0RDJkb2N1eGIxQ3AzTkhlMU93RDN1eXVHTFRnR3MweDhpY003VHBU?=
 =?utf-8?B?OGZKYkFRclpIQmNzdmhaSXQ0K3NkWUkyMFpwOXZTRFhpR0JoTWlDQ2k3WUd3?=
 =?utf-8?B?aklTZFdURnAxY1RDL2FPb2htQmU5LzVUMGwyRG9OMEcvTkdBZFJBRVg1U00r?=
 =?utf-8?B?WjdwSjJESnVacFZxWTRiUndqam5kNXdsZEowR21NYmlFMU9hMUpTVHptQ3V6?=
 =?utf-8?B?SzI2RXA1RktoQjBGTVZrOW94UTZ4dTE4M2I5WWFKdGV3L0diVTlkcmNjRk51?=
 =?utf-8?B?Y0pTaEZUSFlNU05DMlUyVGdrZnhiVFFnQ0Q4SDEzeHlHU295bTZFbDJrWFN2?=
 =?utf-8?B?OGdaOGZ6Ni9YVXZKUUhiYXNCOUZRUlpYU2xIdUFmdGZleFBaTDBDZVB2b05v?=
 =?utf-8?B?VUxhdEJ3U05aVnpIM29tUkZrNy93RHB4M0xCbStaRVN0OFBnWjZyT1lyMmsw?=
 =?utf-8?B?VVpJVGRCckJpL0hGdEc0WTBkaGNoVnhtd3gvYnF6OWxCVzJQT05HWXBXb3JR?=
 =?utf-8?B?aTF2ZEpEOHRvenVzRUFnWlZUMFR2NUYwUUdHQVlNalptUXlYSjY1QytXNmlR?=
 =?utf-8?B?YXdnNmpvUEFGdk05MmEyZGp6Yk9qc29HYlJJbUREckNlTEcrWVF4K2M0d0Z2?=
 =?utf-8?B?TjROVEI2SithNFk4SFc0QzZ2ZE0yTXRHeVlyM25YbmlMTW5WVUdUNG0waERM?=
 =?utf-8?B?R0dZdjNxV3prL2hPQ3VWWERiTEVIQVZZa2t3NThaNUJLUmhtbkdoOHlJU0ZY?=
 =?utf-8?B?YXQ0STZyQTZZVXdCV294UVhTNnJJS3FpOGlQdHBoVnhmK0pqNEIvK2piOWtH?=
 =?utf-8?B?eCs1NC8vYjlVdVllc0ppQWo4Qnk0R3czelpnSzRpMjZFMjlyR1FLSEcxYzdD?=
 =?utf-8?B?UGZSMk9BQjZqL3BlY0hUdFlNQWpncHpNV2FaYTExdDVmamhlQU9FOFNnNUNa?=
 =?utf-8?B?SHYvay8vbGxSaUxiMUdndkFlSDIwK211U1hJVDhyN1NNQTlIbFlhTkJ0U2xs?=
 =?utf-8?B?ZUNDNjhscTVRMksrVjZVOXhBYlNleW16amYvSitqZ0hFTkMvVy9KbTRPRWNG?=
 =?utf-8?B?M2dsdmh6T0FhK2F2R24xVnpZOVNGTW5TUTBWdEVMSmt3S3lvL1RLTVVOV2NF?=
 =?utf-8?B?dG5QNy9QWVptYjRXRVVqZlRwWnNiRWVhNEpGQzVzNHB5M2E0U2lHMlBQYks0?=
 =?utf-8?B?NkNRQ3M5WFR0OG5NcmdtT1JkSGJqL1VZdVJjM3kxdXlVdWwreVY4SUFCRWps?=
 =?utf-8?B?NXMxb1FXbmxvdGdWNkxkUEMzaWgxTTdEWGZwUXo5dXJIWHNOelRkUkhsNTFG?=
 =?utf-8?B?RVNsWi9XS3l3bzBaUlJQdjZsUTVlTktZS0dmb3djQlEwT014SWZOSWZyU1F0?=
 =?utf-8?B?SGlHYUcrT3FiNktaOURoNm1vblVwTjRYejBTUE5KNC9tRFdTSEtaQVVHQ2tV?=
 =?utf-8?B?NXErcmlBajNUb2YrUjhpeTlqV2NnMGZmNlU5bkJKNFN0WDl6S1VGMUMvZlFr?=
 =?utf-8?Q?Enf8GX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlA5SjNkQlJ0MEFPaUNKMG93VytSbE1YQmFaUHlSSjB5cXpQckdKRmx2ZU5t?=
 =?utf-8?B?dHpMYS9laUlPUEUxRytLWjRFaWJFZkRtTEV2R0Y3S3VSVlVUZmRaTFg1SWRJ?=
 =?utf-8?B?Ylk0dnptRnRQcmIxZDF3ZmYwb001ajQrMERKTFNmdDF0clhWekdmKzhSL0JT?=
 =?utf-8?B?UXBhZWxSMi84Zi9IbWk1UWR2bGFmUElWL0tldzkyN3dTRmNOMEdjOTFiNzgr?=
 =?utf-8?B?N2dMRUtZdXNPMmx6U0haQk1URzUvVEtBZ0ppdHBTa01xSmpQNzNvUDc1dkh0?=
 =?utf-8?B?M3JpS0VQc3NOVjlBWTlUQjBuTGpHSHU4SDIxWXhheUtORjdmN0srdHNjTjBL?=
 =?utf-8?B?blVINmhvWVdRZE0wL0c3V2xHL2hJWFBmSzVpUVVVcjlCYWQ4ODA4SmhweWI4?=
 =?utf-8?B?V1BoSzdYMGYxc2p1ZFJDS1U0YzRMVE1LUlhaUmNRenVVeTNRc2sxTWpVTU5j?=
 =?utf-8?B?MVZpSjB4NkVKeEpRczRBYkhDVGcyc1J3elBIL2RQQ0drbDI1Z2pzSXZtRUly?=
 =?utf-8?B?enJkRzluVnpyUVJZWVB4cjlWOS9lN244TzJyTEJzTjU0SGtZYkxETzlIeUFm?=
 =?utf-8?B?UHJ0WjVsWmFtalg1L09rUS83YjVQSkpwSFUyR1FxR1loRm1YeWE2R09rWGVX?=
 =?utf-8?B?alVCMGlXc1FZemg2NGJ5SWYwMVY4N2xoMTFhTTFaQjM2MmNxY2RtVzBMb1gr?=
 =?utf-8?B?d2ZSeUNOOURldTdJY1d3YkVkQ3F6Y0Y4Qis5T0JMeWRDOGUvN0R1MWQ5Ukt6?=
 =?utf-8?B?dk50MlZBT1BTTmlGNFhzOE9LdC81SEtQZFo3UFdjL09tQUJLWkRTdFBWZ2dl?=
 =?utf-8?B?SWJGTkJaZUtlaWJYQ3JVN0M4ZTBOZkpJWjdYMGhqNHllVEYvSlcwQnFGYStG?=
 =?utf-8?B?RGsyVEltT3hSSU5zYXBXMCt3VXR4RGZ2R0ZnY0lCQmNta1NTNjJ1eDdaSEhK?=
 =?utf-8?B?TklsOVY5aGJGUWZ3endWM3hJd05iMzNCbmU4YTByWWh6ZGhNM3pubnAyTm43?=
 =?utf-8?B?WGVJaFZQbTdOZzZsKzI2ZjJhd3dicUZaWDBFa2RuZUlTUHdhaWZTa1ErK0dj?=
 =?utf-8?B?bFNCRUViTlZUeFVaMWpYcWxvQkEwZUpRRVJjblNWZzRUazFsTmZhZDNvaXpy?=
 =?utf-8?B?UWlwcmxtS0ZUbnhKWnJjbVViRGxFWkRoOGJKZkY5ZHkzOXRzT20wbkJpbjNH?=
 =?utf-8?B?Rk5YVjlDVHNqWFI1Z3ZNYWdNUkFWejNKWW4wbUN4VWhtT1JPelJlTUxjeGl1?=
 =?utf-8?B?bFhtaUYrSE9mcC9vMHJnMWpHOTB2b0FvS0FYeGN1eTE3OGZidWR4OElnaWEz?=
 =?utf-8?B?Qk1WSUpRMm5KcVdFK2k2aXMvSFo4SEhUYXg3RjBCQnd4UFlRV1oxL2s3VmFj?=
 =?utf-8?B?RkVnb2pOMStDblpidnFveTFEV3dmV2JtOWJQanluN3lTdjVaZmxSZGJ3MElq?=
 =?utf-8?B?ejErQ3NBN0FkeHNPclpmL3gxLzBTZm8zd0RJRVAweG5KSnBwbllGdXpzL0tE?=
 =?utf-8?B?WXZqQ3dxOHRUbzRaNzRGWG1rUy9CR3k0ekRvZUxiK3h1OFRzVXM0VDMwaXdu?=
 =?utf-8?B?ZkpWcnA3cW0vQ0piSGhHUUJ6MjRPRmdpS1FuYnRVUFFPbGwrYmJFeHhxQWRW?=
 =?utf-8?B?UitoRFM3OG9BaWM1aFM2cWlsRHhNeVlqaG1iRElyS01weWZCSFhGcEszSEpy?=
 =?utf-8?B?SnRlUm9uYTVveURiaFcvQlczazd5dVZnYk8wZFE0M1dsaGpPYmlKTGE0cUt1?=
 =?utf-8?B?blZhUG9XMWhWQTg4MEQvWldNemRXQ3VpUVdlbVVjaTFicU52Q0c0bkNFV1BJ?=
 =?utf-8?B?MjVFSkt3Z1FxeklNdm83UnBkU2V1aHNEZk9tVXVIeENFczRXRzRGdmtSbzR5?=
 =?utf-8?B?dWF1UUI1bG1XWFJhUzRKWTNaYlhvbU1oS3pzNUlTcHBvNFJlQ3I0QzVtbnVV?=
 =?utf-8?B?RXpVUzlmUVpMVFpRMW5vSEhBUVFDTFhJYTcwTTJ6bEdsWC90M0NJTlJvTzho?=
 =?utf-8?B?Yk1ZMEFaWThKVzk1MmFQZ1lwNEFxeGo1dXhpdllJdG8rQkIxdTc1RDlSSDhm?=
 =?utf-8?B?bXFaMHNYeExxQmIzTmtib0ZqM2JJMWNBbEd6MXFqS09nSFVqWG1reXFqRUdl?=
 =?utf-8?B?Uk9QS05NaGJEcnk3SHNwaldJaVQwU29LdW9XdUk1R3pySEpBNlJFUWFuVldT?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3882AB95A8AD941A49D6022D27730A3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QaRwZnMjyUT+Tkh4rAAZLV5Z9/kqP9l+v4rWUlIY14Z6ZIpAbp2oZiK53AV0fClZQkyeBq+b2j+efFiiD4e0VvfyP7EspkhJGCx/4i6artjVTGwvVipiYKqptktIO1By37590Wx+oqETK2vfpq9wMkU2IT4HVzS7R3zEjZty1shwRGKKsOEpnGM8Z6J7LwRasF08FhXtKDwzNfP4wGwgQsnOcCA4p+Q6sD8eHTDH3whr/oEwdJrQ3ppDhqPsfNduY1jNImf4gHJT3t0BexLW4Ss95KEyMQfXvClCfV1t0d6za+671YeTP2ZrADgeL8odB3QMRlEbibSFj4TXbSb6yvfgr3OJQ4qnlK3U9ZVg0LKVy/tImiLGDioKzH1oy7XNGny1XU1lLDxWxjLDdIL0HuLCN372fD18d/fWfg77lbejIEd4Mn2uG2EKGZXjyFE3N8ZrCIsb1UEY9pMjVrj0A8EcJiUdar/Xetlt8RPWWpeWNL95Pd1INt3htyYRJ8Ywf6lEEgqW+tCfF6Q89DEU/QzZKTJDcEmkVmLd6P9s/fCRCwGg+DjwF+0LENS4wOPOmpU3GqXGYwcy7qOHu50UAjj0B3TuHwcAIheAcg9N8jDQN7ZNIaXe7f3r2tKcnXiF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a37de4-6c2d-49bb-ab64-08de12cf1e84
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 07:29:51.2204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xY7ilOyNumEQbNLME9EjMCtpkAtYxaI2qydDq17u7NiUmJpdL3W7bGCXssk0redL9DNXf6kxpV+YslXcVqFt4ZQxGedbnpzEdga7iQ458LE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6714

T24gMTAvMjMvMjUgNjowMSBQTSwgZmRtYW5hbmFAa2VybmVsLm9yZyB3cm90ZToNCj4gQEAgLTE1
MDQsMjkgKzE1MTksMjUgQEAgc3RhdGljIHZvaWQgcHJpb3JpdHlfcmVjbGFpbV9tZXRhZGF0YV9z
cGFjZShzdHJ1Y3QgYnRyZnNfc3BhY2VfaW5mbyAqc3BhY2VfaW5mbywNCj4gICAJdTY0IHRvX3Jl
Y2xhaW07DQo+ICAgCWludCBmbHVzaF9zdGF0ZSA9IDA7DQo+ICAgDQo+IC0Jc3Bpbl9sb2NrKCZz
cGFjZV9pbmZvLT5sb2NrKTsNCj4gICAJLyoNCj4gICAJICogVGhpcyBpcyB0aGUgcHJpb3JpdHkg
cmVjbGFpbSBwYXRoLCBzbyB0b19yZWNsYWltIGNvdWxkIGJlID4wIHN0aWxsDQo+ICAgCSAqIGJl
Y2F1c2Ugd2UgbWF5IGhhdmUgb25seSBzYXRpc2ZpZWQgdGhlIHByaW9yaXR5IHRpY2tldHMgYW5k
IHN0aWxsDQo+ICAgCSAqIGxlZnQgbm9uIHByaW9yaXR5IHRpY2tldHMgb24gdGhlIGxpc3QuICBX
ZSB3b3VsZCB0aGVuIGhhdmUNCj4gICAJICogdG9fcmVjbGFpbSBidXQgLT5ieXRlcyA9PSAwLg0K
PiAgIAkgKi8NCj4gLQlpZiAodGlja2V0LT5ieXRlcyA9PSAwKSB7DQo+IC0JCXNwaW5fdW5sb2Nr
KCZzcGFjZV9pbmZvLT5sb2NrKTsNCj4gKwlpZiAoaXNfdGlja2V0X3NlcnZlZCh0aWNrZXQpKQ0K
PiAgIAkJcmV0dXJuOw0KPiAtCX0NCj4gICANCj4gKwlzcGluX2xvY2soJnNwYWNlX2luZm8tPmxv
Y2spOw0KPiAgIAl0b19yZWNsYWltID0gYnRyZnNfY2FsY19yZWNsYWltX21ldGFkYXRhX3NpemUo
c3BhY2VfaW5mbyk7DQo+ICAgDQo+ICAgCXdoaWxlIChmbHVzaF9zdGF0ZSA8IHN0YXRlc19ucikg
ew0KPiAgIAkJc3Bpbl91bmxvY2soJnNwYWNlX2luZm8tPmxvY2spOw0KPiAgIAkJZmx1c2hfc3Bh
Y2Uoc3BhY2VfaW5mbywgdG9fcmVjbGFpbSwgc3RhdGVzW2ZsdXNoX3N0YXRlXSwgZmFsc2UpOw0K
PiArCQlpZiAoaXNfdGlja2V0X3NlcnZlZCh0aWNrZXQpKQ0KPiArCQkJcmV0dXJuOw0KPiAgIAkJ
Zmx1c2hfc3RhdGUrKzsNCj4gICAJCXNwaW5fbG9jaygmc3BhY2VfaW5mby0+bG9jayk7DQo+IC0J
CWlmICh0aWNrZXQtPmJ5dGVzID09IDApIHsNCj4gLQkJCXNwaW5fdW5sb2NrKCZzcGFjZV9pbmZv
LT5sb2NrKTsNCj4gLQkJCXJldHVybjsNCj4gLQkJfQ0KPiAgIAl9DQoNCkFoIHRoaXMgYW5zd2Vy
cyB0aGUgcXVlc3Rpb24gb24gMTAvMjguDQoNCg==


Return-Path: <linux-btrfs+bounces-20632-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 116DAD30D19
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 13:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 375B030695C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 12:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B467937E307;
	Fri, 16 Jan 2026 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MN76jaHN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vBUiwOzf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC5917A2EA
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768564988; cv=fail; b=MLPp/FJBSexIQbM4+i4TXZ7e7MlmvdOejA/f7xNotFsU2V2xnPRJfRmnHTaQuILBg30aENOL94XSr5v4NVyhmjF/b15yWWc8gFknZ4UPepYRufjrH4bOuvCVU+If/PxUnPh5GmwVQ597TyrybqUbmgzijX8j7Nen431hv/pAch8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768564988; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KRm0fcYqVgJVWg1nTQyZXUlk78/Wj65RapiiJuLrFsBPCD8wQGl5Rbsr4ctMVHwM71fANBoPZhumFB1oEk4wNapdVH3a89NZ5JpzD+IETIKuDaH8iFcfJNMXZ36gS8cEY7deaeONyifgeZoDyt1kgNuATZ98PhROFQRHWy20u1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MN76jaHN; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vBUiwOzf; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768564986; x=1800100986;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=MN76jaHNbnw9qKPvtlhZ6pSRPrR/SHy8rRl9WyXv6+N1GlZHLKHV6wCJ
   T/wwczFDgCUqSr+h7bQis0m6CVz2SYyWseY3WIBhvqpyGPUqtbbrNUlg4
   FLBCH07+zQAP9PetqKULQU3W3wJHuCgi3xeQRbqDWbLSbtTctNmNz799p
   nNsgy236K/0FpE7HcgqU1hse5fLqdbt6VSJtTGYusZepHCUOGBwJLE7Xf
   gDM65UlzsVp2XfL0LA4YmpBr4EVg57W4wvThPJbw2WopMRy4o7l5j9109
   VNWP76914BIdZjARmystBPbFR/yNHetmR/+UaT/Q17yNG22rY3hOtvIWh
   w==;
X-CSE-ConnectionGUID: gk08jHWGSPeShbA+6AtkaA==
X-CSE-MsgGUID: 7F9nKZo2TMCg6P6w8XmzsQ==
X-IronPort-AV: E=Sophos;i="6.21,231,1763395200"; 
   d="scan'208";a="138687042"
Received: from mail-northcentralusazon11013030.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.30])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2026 20:02:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yndp0lgG1NNt40utttKY804LSYFdFFSg+NroVNICRgPFETd5XxFrOlwB9gacqfRWUxbqNt8XljRQFic69ndLW5ZBEzaPcyeEXYj8x2QLYqC7afncw06VZg7oW7xVC2K7U8/rDhyn+LSrQjQxn6ByWnIPRdAwy4JlmBlV/+x+AuzFZWNURPAScEPl+ggmh6bb/qTguTfmhFQ54dpGK+NfGOhiATqAIJVnZBfnAtz6BbzSJ93Ag4Yh7xPXuBb4I69m8ZlisMpwqRsqCKsah4RGzP2PowByXAE2UWnILrWBwnoEZWeVgOBRmN79wq5ljPdD8S5PWJEHsEaKCHe/kAGcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=RA4PugRTUj+jq0VeEbH+9o9LU2CbRmKcV0feBrZa26SKZ0UhwrKRI66g1cHAd2sIVN1u+xhAhBx0sJdrkC1+CwDcKzE5xWSTRdCc3wbR66jGOOTcEdNhVbmAXyy+RIYy6f4kiwQzVIIJ+uWYbpVHgbeIHT9rXcJIedJOGtZ1MBupeWtUCAiX/xketb/yZKWAvnsn7Uxa9k+w6KFjziZTnoyP738SKq0qPIvEjgXq7Q/vGPwbW5gjJbTei6mExSAHPsDWjXirT+UGutsjxEMPDLhb2buKqO1chcoAyFfZwjdg81pd/pcsUHdVpGky9JuNyY82bGKmk7jWkvrw1pXNfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=vBUiwOzfvI7xscycT5+dUrW41+qfEB8lf+cQy4SF/Xa1W9n/SpjUVu4A55s6rsUFodaw4IMPyFZqYAr3oCGt+l9d0mp7TdxBWQl6/+rvV7CNB5DZ3t4qb8j7MHEZW+kIZQA1RuBSoDf8VA73ZKpHK7F7PDeBJ9Xehu9vzFKTThQ=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by MN2PR04MB6736.namprd04.prod.outlook.com (2603:10b6:208:1f0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.2; Fri, 16 Jan
 2026 12:02:55 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9499.004; Fri, 16 Jan 2026
 12:02:54 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use the btrfs_block_group_end() helper everywhere
Thread-Topic: [PATCH] btrfs: use the btrfs_block_group_end() helper everywhere
Thread-Index: AQHchtOhINvO9S28dUGMw5M5g4U43LVUsm8A
Date: Fri, 16 Jan 2026 12:02:54 +0000
Message-ID: <d7559fe9-3e6a-4dfa-8c49-2a463f18de30@wdc.com>
References:
 <f7afa4b2c9350b08695cc34cd917dea3bf766bce.1768559305.git.fdmanana@suse.com>
In-Reply-To:
 <f7afa4b2c9350b08695cc34cd917dea3bf766bce.1768559305.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|MN2PR04MB6736:EE_
x-ms-office365-filtering-correlation-id: d7867763-a437-48dc-ca34-08de54f72e94
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aGZGNzlWV2tZL0h0SGFGNWcxanBQQTlsZm5JMWo1Ymc4ekVjMGlnYzBZTjVR?=
 =?utf-8?B?V2p5SUZjaFExd0t0RkQxMDdpQnZOVVZoRTFtS0xsMGdrRWVmdEtqM1N6dm0z?=
 =?utf-8?B?MWpwZHREZENscndOVlJ6N2VOaW53cWkrMklhWkVLK2I0YXk4OFE5S1NNa0JN?=
 =?utf-8?B?UlZSMDcyRkNzYnZQdDQ1MHRaMS85R0NjL25sY3g1SDVieXFCWWJnTmFJalhM?=
 =?utf-8?B?SzhlMDVXdEJYem1vcTlRT1BtMVB1SlNmTUFlYTVucllpY3UxSjU4ZVBQZGFx?=
 =?utf-8?B?SmhJTWRqV1NYcUFTSi9ETUMyOVhNTkd3RXZqamU5aS9KclNTbnFsWkp2Ky9U?=
 =?utf-8?B?WjZ5clMycFRHQnhpZnR0Z09yWjJnbzRUUy9QckMwc1NKRXRBQ1FwQjRJanYz?=
 =?utf-8?B?YzNBS2Q1blZFbTY2RzB5cnhpcUpHWUpKcFZPRlg1aUhPcFlmdG52UjBCTDRJ?=
 =?utf-8?B?TFFmSmc0VTBLR0l2ZnpmVW1EUmxhdjFoSFdndnZnZ1UrSGJlbFo4K3VCeUZh?=
 =?utf-8?B?UUw1YVlEYm9BRGNkNXg5MXhZT1JpSGFaZ1ZCSzVTZ0RSa1Mvb0xQTXAxdEZZ?=
 =?utf-8?B?NGlxYjd1VXFuUWw0ZWk3VHJCQ0dUTmpLZW96TzgxS2Z2WlF3U001djArRTZF?=
 =?utf-8?B?Q3k5czc4ZUsyZDNkbUtscWpFSHV0WmczUTRaS0NkMGFWSmFOTlFZUGpvMG1R?=
 =?utf-8?B?ZC9Xa1dQZFQwOURXaW1qUUNBaDk0WTNZQ1k4QkY5YmFxclp6MUpKUFNyblpX?=
 =?utf-8?B?M1hKRjdycDB5b0c0Zkg1R1dkRFJjb3lQdjdJcno5SWdabEhCNU1jTDJZRWlm?=
 =?utf-8?B?V2dCbWw0REwxN2toL3gvSHVvMlFFSDhQdUQ1c2dEQnF0OG1wMVg3c1dwdkx4?=
 =?utf-8?B?RU9tME03aHVFTmZUQXRqSGx4WjFKVVV6YlhKNlFuMG5DMlVUYkhMa3JlVG13?=
 =?utf-8?B?SUtkdk9MY1JRL3dzczF4a2pCTFNUK3gveERzZUlLNDBybkpJUmRhd3JNb2lY?=
 =?utf-8?B?NzYzOURWWmVha1l5RWJGRlowbmdsb0dGeEU3Vk9wNGFEdURrYWhGOS9DQ29n?=
 =?utf-8?B?OVBRaitiS2RCUUIyemhFOVFmd3pEWUFBeHlqeGtIV3FZa0dLQ2RjNlRWV3F4?=
 =?utf-8?B?bmtHQnd6cnUzTFBjS2VObFh5a3ZpbTNHamdzQmZVRzh6Qy94V0VSOUxYSXR0?=
 =?utf-8?B?dGRmQzQveUV1ZlpkeXRaUit4Zlg5MG1VRnp0bmJyeTRYRjdjVmRhU2Ricksz?=
 =?utf-8?B?TUIrY1JjNDl3aVkrTHRyL2hzT2pxMHdQSkpaVUt2eS8veDYzR09SS0UyU0FL?=
 =?utf-8?B?VTJ4ejNMVFRCZDFlQjlsbmJwd3ZTTnZ1UCtsM2RoclFUbS95TWV6RmJ6NXI3?=
 =?utf-8?B?L0RhbjRabUdmOHdvd05rdkZOWm9FUytLOUJTOFEvWFNCR2wvMUdTbnkxWnJ4?=
 =?utf-8?B?R1hPMGhUeWJ6dzRSeTRCVGV4Zmhuci9IeGtrazBxNnhKSlc3eldZeDNiM2Y3?=
 =?utf-8?B?SWtTYjRnYTBJSXhFcWFnRDZkUnVLUDJkSExjOUR2ZkJ3Y0NBSVZ5VHl4TFA3?=
 =?utf-8?B?Zk44cDZmSnprZzZYYksxKzFCYVB0ZmJnWHBHMGZtSEZYTTByT1RmZloxdWc0?=
 =?utf-8?B?VVc3OEdVMml5aGRkYURLVEJZZ2NRb0RoQzRUNUN1c2RKbGZqQjg0VGFqT3Q1?=
 =?utf-8?B?R25JZ3p3VmIzdTdUS2pWREpzMlNzTkNGOTNveE80eEVIdFBNRE81ZlJzdHhn?=
 =?utf-8?B?VHp4QzZsKzJ3Y211ZGx0dHBPVmdNdE5rTUN3TVNxZVRhb1BiV3BnNlE3NGdV?=
 =?utf-8?B?b3hObzJoUDVhMWNSazlYM1E2azFOVTQrRVFQUmtEQ1Y0Ujl4L2I3TWd0Ulln?=
 =?utf-8?B?ODRhSXpBSXhBY05PeVBxOUd2Nk5MTS9aZStrT093MDJCSGJJcnZhVzY4WHRz?=
 =?utf-8?B?WmNiOHVLYkJBM2FjVVFtaVlRSElsUm5jektBSVVFUjcwN0taM3hId1VqdzNP?=
 =?utf-8?B?VGhqbFllTXF3S0xjOGtPZ1VMMWJreFJrN2tPd2xmU0xNVHAxR1JjUFBtc0NN?=
 =?utf-8?B?NnhrMmRzM2xWT0laU3pRR1h2OGd4V05zWnZBRUw4U2Q2U0pwL2l6NHB2NEdx?=
 =?utf-8?B?endRWmtoOXZ1a1BwbndCdXYzNHpacXUvZ0JUVlpOZmFXM1JUZHlDd2psK2oy?=
 =?utf-8?Q?1GPnMpPxrfES/0TxhT5Vnho=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHJXR2U3R0RqOVFoanB2V3BoQ1htakJPZnlIblFrSVpEbFlOOTRKcGZ1Yk01?=
 =?utf-8?B?N0VraFV3UkZ6UE91OWVnNVVkV1hPOFZ0cG96WFRhRDJlck1pOXREbnUvV0tF?=
 =?utf-8?B?Nm5GRWFCUnhmNHhFWkdEWmhiODhXTGZmQXdPU21VRjdYYlBPZWRFYnRJOEty?=
 =?utf-8?B?OHdacUgzUE0xaTVzNWg1Q2pOMmdRakpUYWE0U3oxNkQyVFBiUmhDQm9zQlFC?=
 =?utf-8?B?ampGaVc4d3lEU0xvaTZIU0J0dXc5MWdDT0hMSFFBL0NaSWZrMk9BZk84U0dq?=
 =?utf-8?B?djM2NVlic01qZHU3MG5MOUw0enhwNi9LODRxM0hZMG1NMW9kS1lUZlcwRWV4?=
 =?utf-8?B?bXViRmhTZzhsRGJiTUtJUFJ2WkNQNG9iM2tsbzlnbHdScVN5RGE3aWNCRlBk?=
 =?utf-8?B?K1dweTBMbDFMVU9kcXpCemZvYUxrQ0VWMWlnYmhlTUhtZ2FHS285WkdmRndz?=
 =?utf-8?B?WHFFZkFZNjVmcmdsN1ZKSEowY1B1TVF3T3F3ZVg4UFdMdHArZVJWSTFxM3RQ?=
 =?utf-8?B?dUFtbWJ6RWFaRmRxLzFCKzQ1NUEwenI3SlhqTktoSDlQY3gzYlVHNzEzNlBv?=
 =?utf-8?B?ZG14enZiTTNVd2NZbmJEcXNJNlg1bFFEbHpidmRvMU5QN2luc3QwQzlrU0Ry?=
 =?utf-8?B?eWNHZlE0aTVkTFR2ZU5ib2k2M2xxdGJJQ3R0L0NKT2hYbDRqQTZHbTF4TDND?=
 =?utf-8?B?VGptUE9hb0pOR2FnZm02eS9xVjdmampYdWoxODFmSDJNUVVTdHRmUjZYOXhB?=
 =?utf-8?B?OExUajdEbFVuTi9EdEpuMEhzbUxSUlhFUHRReTg3OWZZWSt4V0RkbzdIZWcy?=
 =?utf-8?B?Ukw5THYxL21PWG85b0xrWHVEOS94eXh6T0xEQWk3MTNJbHhqRG9oMkZxV2Ux?=
 =?utf-8?B?elBubW81SStMN2lseE9xRFEzd3lMTjJuRGh4c2ZPVS91VGJSQURwVUZHa0Vp?=
 =?utf-8?B?bkFvZEwwVkhQK3QwR3A3bmpnR29aeEJDN2I4VGhzZ0pOclJNUmpuRFJnYk1N?=
 =?utf-8?B?WjF4dGoyQVUweFNMeVZKMG1yWEJNay96dnBlY0lXSTlVRVlQT01Jc1BkQ1JG?=
 =?utf-8?B?NW1YOE1QN202RmxMRys0Vm1hQzVCUTNQYnlTOXZUNmY0bXJ5YlZYRyswd2dl?=
 =?utf-8?B?cXJvYTROaFZHeHRORkMvR29MN0tQK1N4d2hzV3BmZm9pQlhmb25BL1BCdTRZ?=
 =?utf-8?B?VjF1cWdvZjBOTXIvMDNVNDNMS1Z3YmFQa2YzaUFtTHFDbUV6Q1ZHNFBjbzh0?=
 =?utf-8?B?aXpkeGh0NkZ4N25BTUJlV0JkN2VOZjBKRXdhQmF2S29MWVRlSEI3SkFxNFdr?=
 =?utf-8?B?SVZFQWxOdFRSUUlsN1BDKzB0RjdUQW5PSEpIbDhYSTlubVY0RFB0dERpRGQ4?=
 =?utf-8?B?YXR6emRpWi9HSGpFU0Z2dktobmVwK1QzU21ScEFKR1ZoOG9Ld1BJSmZxRUtJ?=
 =?utf-8?B?NFNHT0dPb21BS3NpcjRtamxVU043U0M1TkJRRURZeDV1OHdBZiswbVc3ai82?=
 =?utf-8?B?aGY4Wk9pMkRrZFJQbUtwOExmSTFWZGhlWW5kaVpjeDdmYzRHckd0bFZKdWkz?=
 =?utf-8?B?eTZCNXdoRFEyVXhyc3hJY2ZtNE95SHE2YlFNTHJBdWFuRkxjNW5CT25xS3FG?=
 =?utf-8?B?ajRKV3Nsb2gyQjNxdjVOd3VvNFRWRDdjZUtXd1luR0ducFNwV3YyVXVmazM1?=
 =?utf-8?B?dVRyRm1zMXFIYkxmSm85ZlA4dDhTK1ltSXMxL0w5c0dBQURTZFJhMlY3d2lI?=
 =?utf-8?B?VTR1SlVrMUN2WFpqTWdxUGxKWWVuQWlScWJLZ3B6UGQxOTJtSjJmbFBkN3dG?=
 =?utf-8?B?OFh4cEVRMy9ENG9DYVZJeFdUamRUV2NZSllEMGpwRjA3dHhpaktTcHM0NXdo?=
 =?utf-8?B?UFpyVXF4MjV3QkJIYVgvWjdxMVBxZll3NlYyUG1kbDdsTlAxbWZ1Y09KQkxZ?=
 =?utf-8?B?YXdVb1k1TVNUVWR3c2dETndNRTdHckc2d08rRUhSRnlrSFpETERYZUdVdFZt?=
 =?utf-8?B?YzBLdVc3bWtFU1h4NU1EdC9xNDJmZHhkQnIrdHFsNFJQdUtmRXkvMEsxQlhr?=
 =?utf-8?B?Zm43aVEyakFkTnJFR3lVYUp1amFuUDA3VXg4aHpwU0JieVRvTGQzWEtzWkNV?=
 =?utf-8?B?RmQ3aXkrRkN1TS9IQm14WG5GeDYyQ0RmMzJ2U3NMV3ZHT2pJSEkrWVUveWpx?=
 =?utf-8?B?U2greWt3R09TQk43bEd0THlJU0k1bHVYZHRhZXc1eldoRlpoNU5naDQxNmMw?=
 =?utf-8?B?SWNMRjc2Y29JTVFmN2Yzb2hicTBET3BNdnJ3UUNjZEdTNmdlMzEvZG9sUS81?=
 =?utf-8?B?V0liZGhqWXRYc2lLVVFkMFViVTZjcWc1SEx2VGVyeGZIMEQ3TVpmakk3a0VT?=
 =?utf-8?Q?UbRF2AqDh2R9Pn4s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC2EE3DF0558384FAAF0D354B26B4825@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vp81gvresL3miv9FJ6Tc3eAKfG8xX84vnwXa3wlbPKMBKCsL3vcLaKBKgr3HwP1uwGGzzTSZ3M7uyoWc/DS5ylO5mW0PN0I15H382p5JYVaIaEYiisviihmElY6MbXVTjWuTT/M3EkYzsCob+ikl5l9UI6acwE1WGkjqpHd8zUevVKScRiAmF2UEg+ohxzKDLXe52yf1G5AOZ2lT+auhoscB8oSWLzutNZRY2ugVqM6rxiqv0BysX5HHwxLKn/Fg2qktL96eyvgprCJZ5Nlwk1Kdu+loDBSKXd5SXCKV+XEHNEh+oalZFIbKPI47d8ZNB7cc8xPS1aZnz/b2hqha8/hGOSLgiC7zolu4Obgyc/goaPU/0o33MshSSvjDIksCpWj2u5zBxJjitx9GuqEDSsVm+WD5bOtM9tP1S1+E+ZRB5mGQqpcit4UI+65ZMF7WKXteaOu4SBcHU5+yGYNQOYu3Y1jqzmNfYfG4CRir4VIY58R1atIU2TJF4EbBltJPgxuCPSd0dpxPwolw8iSOLN7b1Gp4ouMJOUoCS9qY02fC8DEU+wa8dxlOmKemDNWyMOj5f3JiZpK4V4QSuSZ42dbtgdMeEcpx9UcfvnYjITVBoU6h5blKtu9pOnMUDzU+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7867763-a437-48dc-ca34-08de54f72e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 12:02:54.7957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZEkaNmyv/Zd7V3JkJyT6kLQDdh02+F5Njz+Rf7PmnFz5xkGqP4CyuFHdGEdRYLYW3gHdJycC9jEcOKH5ax30u8nYo6nD3eRwu5mS9f7tDkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6736

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==


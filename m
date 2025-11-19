Return-Path: <linux-btrfs+bounces-19138-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E462C6DF1E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 11:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD79E4F8288
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 10:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A9E345738;
	Wed, 19 Nov 2025 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f02hdmlm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mTGqmWSv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230AB21D3F5;
	Wed, 19 Nov 2025 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547195; cv=fail; b=UuBt81pUrKcrks9CbvM+8+BMdcK9XJTEPYqEbILpci+FYW6Pr765FFEFw7I98F9Dzk0xtrpzY1peDh7d0rZ2ME4x0SEhKnD/gMtE2f+o5PVxc+UCRJxazg4oQWWQDUoYwJF+L5n2p3Fg6cIjM3GjDN6SP25yt+RP/lBx35H1tmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547195; c=relaxed/simple;
	bh=OU15kYwHeCS5shcZ+kKu5tXFdasLHamVlorkwycFef4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vm1WJ/9FxCMGLQJSLmkCeOdl8onE/BKmM4v0e/biXXxbpfm3whEJXYbEBYxeEffUSX7s5h0DzRAn1UdNHowY6KdPjSSHyMl4/rFlocZMXs0b8zvsp2e43WN5/bFno5/g7V9v+R/1CDjLrRL7letHwscdn24S58URVWkm8sf7TGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=f02hdmlm; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mTGqmWSv; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763547194; x=1795083194;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OU15kYwHeCS5shcZ+kKu5tXFdasLHamVlorkwycFef4=;
  b=f02hdmlmGhhVvBHgY7uIN8GResHaERPr2/w9spMYgTjjzzZ85aAdUsYB
   hxfRYzE35WqWB9DCrjS1xlVlhRGM7fusYKYhGIGvpRoNC6QtLyL1fxcHb
   yka+uDba6al/q2yNyW/msBQPA948SqJ0izSn5ZnlzIV1FVCw0MeYrZBPQ
   QKhleTAJRMiq0ep8F4MdUiN5ndQAMaNbMysQpj5Nj/0qkrhSevC6Ggsag
   gqLpM/5wXrrK2Ko7TWVKvwVThFO/X6MIZ/AJd+9NZ38KjgGtZmEHV3JFI
   5eocjtphNH7mb5sNReh5ai8EnLQON/Y2TUCuXeZCmX1phppOqUAuEMgHn
   Q==;
X-CSE-ConnectionGUID: 2ryShQmdR62kIRd9mHnbRw==
X-CSE-MsgGUID: jA6sc7XTR5u/dcl9uo8Qog==
X-IronPort-AV: E=Sophos;i="6.19,315,1754928000"; 
   d="scan'208";a="132357689"
Received: from mail-northcentralusazon11013051.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.51])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2025 18:13:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejD6LAWlLLBexSwcRPzdFCDMcn9O4VpdKe7TUEcSV4PHVpI+6+/NgBXopPbLv/b8PnSFtsncYOgU+6HovGvY1IGoWDLPuAsLVQXc7tfLCCtFTZVtheAsvnNBexptMSnpmiEr3/k9Ww1kgWwaC+oWJtrqkepHnuXUHxwa+ll0SAmA4+uAzi3cKFBERzjW3knQ/HDZQRw4/YApv+debDa1VGsS2eSnkoKvJSiIVBII3hGcOShRTlWTmIE+Z7Hwmk8iMaD6PklLSZXDWlR3MPEyQfkS3W4P1Vkm/bAy/sUpIYaXXW4HBMci9zlKjg1gR3+lVur0CyTM5A6ZaHlSwatvqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OU15kYwHeCS5shcZ+kKu5tXFdasLHamVlorkwycFef4=;
 b=r6ggnseGqatLzrQUF6bWD3jmr9WwvAUZPYBdbzhQhMh/c2idOu2cq6Cq8tLksF3PI/T86nHAFr5X2PN2QnIhwdtKK2GPyqB1Ei1TMBbyTJ20S7rEbL26RMhb+8z3IP/fzsCbmxpDE9kuDJ8U0l7cjTqGhKqEtLcmP+GwBV0oFLd/fH+Wf9onJxgTguKW+v2/2qbuRgF598dde151njigSOnXCM0q5nTpkKLcAVo3sh+N5FSsaiST9S9UBOFyCVhoznrMnaX5pPbOoAY1UGe1YC39nVueYXR0WaaoN1SZQcuWhiBpeX6X+aHj1Gperm2Q9pjPO6zbEM2RCc+UOvbjMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OU15kYwHeCS5shcZ+kKu5tXFdasLHamVlorkwycFef4=;
 b=mTGqmWSv+Htj+wQq/90E34OrwI9Z8qtlO45PK0vzDPN0rx5kxog6S88V5osUVsxPkLaN+9c4xAM7DwBKrHSF5cV+AUEHdJ1QYpdK0nlb8iWefoChnlPPrfHryGBkr5JlWPG3fSesBHRy64vh05MtwQNYfGGDDMtsrqVs45mbx/c=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH0PR04MB7802.namprd04.prod.outlook.com (2603:10b6:510:e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 10:13:11 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 10:13:11 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 4/6] btrfs: don't rewrite ret from inode_permission
Thread-Topic: [PATCH v7 4/6] btrfs: don't rewrite ret from inode_permission
Thread-Index: AQHcWKXl/q7eMjema0iC9q3cHje4wLT5x2eAgAABgwA=
Date: Wed, 19 Nov 2025 10:13:10 +0000
Message-ID: <21e38a27-b589-486b-9825-79755987092c@wdc.com>
References: <20251118160845.3006733-1-neelx@suse.com>
 <20251118160845.3006733-5-neelx@suse.com>
 <55cdc311-7b12-4dfc-ae79-9c4aab9153e0@wdc.com>
In-Reply-To: <55cdc311-7b12-4dfc-ae79-9c4aab9153e0@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|PH0PR04MB7802:EE_
x-ms-office365-filtering-correlation-id: b63afd6d-72ce-4281-b02b-08de27543e5d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UUtibXMzYzhRcmxwSERCTEpya05adzN5ZjZPdmRtOHl4clhKYkFFN0dDT0x5?=
 =?utf-8?B?Yy85R2Jib2w2SUFDOHRKZjRKMW53WVV1aE5kTmhsWHgxTER1NXNDNC9jaml2?=
 =?utf-8?B?V2xaSEpXUkEra2h3WjI3ODN5MGM2Rk1XTzBvNFRLQ3J4bHJBMzl2dEF5SHpB?=
 =?utf-8?B?UHNnaDRROXdxb1JjQUhrOFVVazZjNWRPeHRpUzF3dGVkNFNiUG9wUmw2ZWJE?=
 =?utf-8?B?aFkvQTd6MmRWWHkvSmttREQxNm53QlUzL3JNdTVQd0I0Y0VWeitEZTY2Qll6?=
 =?utf-8?B?NXpYeWY0R1g3OWJnQVF1TWFuZ0NYRHkzT2NUNmxLVTBSWldJYUtBTlMvTWZw?=
 =?utf-8?B?dlNUemVGMkhsRzlmY09JZ2RXcTNoTkZjdkZISUlneE5vOTNmVzVFUlUvd3Nh?=
 =?utf-8?B?ckJvdzNEbW9YbEFicHlka241T0ZkVFZvS1c2cTRZNTBERGVEUEVNN2IycXRL?=
 =?utf-8?B?bTJQdFQrbXZNUDRXcWdkNGZTbVdHR2lpYlNQcWozQzJHeVo1akVqeDFnd0RF?=
 =?utf-8?B?UG90Z0ZlUk1pQnk4LzFWQncrM3hRa1M1ODYxQ2xkTWoydzVyeFJiYzZyYUZz?=
 =?utf-8?B?b1pSTS95L2JXeDdSWVVNKzlKKzJxK1hicUMzekR4RlVOeHZuSnh2Q3VPTGNr?=
 =?utf-8?B?OUl5YVE0THdWOG1kK0hVTkZxMVk2YStuaExucysvMVEwZXBaRE16SWRrb0dD?=
 =?utf-8?B?RG1taVhMUGIvbzQ2Snoxa1BoTVdVWkdlUDJ3a0JucVRLNUxpL3Fzc3VhKzNK?=
 =?utf-8?B?Q2xtVTBlWTduRU9rd01SOGtabGpiZXVXQko3L0tJd2ZNNmJ5bjBzQnlaVWxo?=
 =?utf-8?B?SERhSVdqdjJrUUdIQmNYRUlRM1BSRktUSzh1bXNyTHQ4NXh2NURSRUpqczU5?=
 =?utf-8?B?M2s1V2tuZFpiWjc5a005aVM0akorL2todGdXZ2hCSHdnU0U5dEtPcGYrOVgw?=
 =?utf-8?B?M0F5dFRhaWJTRjRlVGJ4TDhtMTdoa1ZTUnlvVEcxaUw2YUtlNHhLRTVpc2pS?=
 =?utf-8?B?a1hjc3YvRUlCYmF1a29mS0pCN3hKcHFRZncyVUJoWHVvZUY0Q0hNUFhGSHNz?=
 =?utf-8?B?RSs5ak1heDNkTGxBVEV2VVZldUNoTFJGVlVoUFBwQlh6L3I0bXV1NkU5TW92?=
 =?utf-8?B?TVFzU042TFQvMGRWR1oxazJFbjdPcDVmYzJ4STU4ZXZOc3VzQVkrRy9DMnZX?=
 =?utf-8?B?K0k5VGdaNm8yMjlFZVBjbkxQVWJIQmt5ZUx6MHp6bktMU3gvRlpiL2ZnSGxi?=
 =?utf-8?B?bjY2VU54QTlkTzM3a04zNkhjVGFNTkJOOHhvT2Vsc0VlODloNmxHd2RLaFBq?=
 =?utf-8?B?T0Q5VEJOYVVBaURGVEVyOUxWc2JxZTVQU2hRRERNNGNRKzVIRHlBUWUwVTg3?=
 =?utf-8?B?OW5rY3p4ZXJoQzliZnUxOHMrYVdXZlBRZnBiaDFmTFREQzVoU204T3d6Uzdi?=
 =?utf-8?B?ZGM3RW0wOUVoTEYwYmFBTWtrbTk2a2RCL2tIM3JacHdBM3ppZnVkU3FnQXFZ?=
 =?utf-8?B?L1hPM1NuZUZlRDZKWGcvdVdYSXFwRGt3V0pxSkhqWUdaWjEyOG1DV0JXa0hE?=
 =?utf-8?B?SkwzK2xrdk4rL1YzVDQ1bFMvQy9MQXFCRnNYZ1FLdk9VZkFCVVF1elVPZWRr?=
 =?utf-8?B?VlhkcC83MXE2a3ZoTXNuMU5HbzJmcURONCtVRkplYkFBVkRUSEJqaytJbmRD?=
 =?utf-8?B?alFxSEoxaThCL1pmWk1OczhyRllXWm5WVHczc0gvTUFDcGZnZWxIQTQ4MUJt?=
 =?utf-8?B?QmxXNHdJNk9TaW9rejQ0aUFlNE5Fa0dwbzhoVzBodERreUV0V240cC93UHJm?=
 =?utf-8?B?am11STR0TFBYNnFJWUhaaC9RSTcyQ2hWSTZJSzdhSlU0akZMV2FZNmozQmVO?=
 =?utf-8?B?Rld1R2pPMWVKOWJxLzhVUit4aWpkUmlLWGk3bzIwdXhpVEFxN3NHVnQ0SWll?=
 =?utf-8?B?ZHI3eUtnelp5TGpKWDQxVHk2QnpvS1B2N0g4SCsxU0o5SDNMaFpUVnR1MUsv?=
 =?utf-8?B?bEQrckI4dlJEeXEwSDYwNUgrTmVyMWhtTDE5KzV2OGNZaXhGRzc4Z3dYMjU3?=
 =?utf-8?Q?dkoC7J?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmZDakZYTVpONUtQczczcExSZjcxUWhFZDBCcEZBZHFrNGJ5a1NMM01RYmdI?=
 =?utf-8?B?OW9QVmsyTExXSEFNRlNPcDloUDNVUnJGUnBmTDNGSEZPdE5nOEx5bDFPeU1s?=
 =?utf-8?B?Mk43Y094SStwOGtGUGRUY0xaR2Z5Vjc0NVllcFZyQnI0Y2lUYWFjaWQxN01R?=
 =?utf-8?B?cUtWU2M3eDUvWTZiTGpMTGtLR1RyaFVrK0JjRC9NTFFJTE02blI4STNuUEtE?=
 =?utf-8?B?SXdaMGFDb1Nsd0xDNGJsKzI2bXZseEJESlJJYWxRV3NpT3BSSzBsSllSWUFn?=
 =?utf-8?B?QUF6YklnQm8xdHRPVUsyZUFTQUF3Ky9RbktBdGltbFpqRzZGK3RScXRNRS9O?=
 =?utf-8?B?NW4vdEhCakdNTTdLcEpQUVBLaWVDZVJuVkdITUNFVERxb1IrR2ZmWEU1U004?=
 =?utf-8?B?cE5TSGJHeDdJSGpCQnZqNS8vWmV1WDRVcVQ5YVluWnN6bzJJWkU2OXZsa2Jk?=
 =?utf-8?B?cXgvdS9SbGhhNyt6RmJFc2FJK1hwTFFIL1Z1cGxVRHZzMnErVHZyaVM3R2Q1?=
 =?utf-8?B?REJZMTl4MEJveThIb1poK1dDZE83cjFYZk9nQkFIQTdZRzJIUC8zRFlxVnN6?=
 =?utf-8?B?UndJN2Jwa2NHaHhJMVlIN29xMkN2Unh2TkxqMTlCK1VwUDBibnFQOEx6SVFn?=
 =?utf-8?B?djUvMHRmRjN1NHNFQ05oeGlEWlhIeldqblFEYkFOaHlZaDU1aXFqMmQ3YTRq?=
 =?utf-8?B?a1B6UTFBMXVZZTVVVW1TajN3eitGek01VWlWV2lvUmdaQjczbHUvblVuL3BI?=
 =?utf-8?B?YTdiV3N4d1lEbDVKWXFIenZIdHNtT3h4MzJHQ1ltTUdEMndscVlJR3ZUTWxK?=
 =?utf-8?B?ZG1zU3pmd3hvSDYzV3RDN08zRVJLcktuQWxMM0VUNzFHZGNkZXIrYWtZdGt1?=
 =?utf-8?B?UTNVTDcwMDFnUk5jMTFEVlBjNUJZOUM3Tndwa01rNEVzd2p2N1duS0JtRDI4?=
 =?utf-8?B?T1BnVXF2anZBdXg0N0tyQ1duZi9BeHhSNjlERjBkbmNFMnQ2cFNxWE1RRDl6?=
 =?utf-8?B?SzRRZTRtUWE3SGtFSHpvYWQ3aFVYbmJxYjJvMmJ5c3U5Nm1ucmxnZkZkN3ZH?=
 =?utf-8?B?bk1UK0lPbngyOVhlamtNbjdEL1pCa0dJR3dJRFZJOXlIZjVSU0tRSGZUYVRy?=
 =?utf-8?B?SDhUS1ljcGJPRnpXRlBta1VlWnEvY0I1eS9KUTdFZzFGNmtseDZFVldGRFFu?=
 =?utf-8?B?aklodEpXdDVuWGtUb0l1R0I4am4xZUNiNVNJV2xRUmpJQk1SMXJRaVJodWdB?=
 =?utf-8?B?NXhUL0hXcUZPQ3ZBb0hvZndvMStLQW8yNEhybHVYbUovNUtEVFFkNC9Ha2RR?=
 =?utf-8?B?ckRSbDQ1VkpYL2tXWWwweUtxMUozM0pKWmpiSDF2cERBRUxrWnppYzVMd1Ay?=
 =?utf-8?B?Zy9vMmhuRHRiZ3Zoc3JGSFR3VGd2TFVmY0dQYTZHV3poVmhQR25oeWVBc1pB?=
 =?utf-8?B?eUVRdDVXNHo2cEZSZkUyK0FrckJLRUFITXhhbGRmaDlSRmk1bnA3WkQ5ZFdj?=
 =?utf-8?B?elpYSzBhRXFUMXNSajI2RG9QQTJGZHpWdDBvRFVtY3IwK3BudDZ4MnR5UGUy?=
 =?utf-8?B?aHBOanI3Y1F2MUZKTmdBRkd0cXNrUi9ybVVyeUtNaG1rY2xwS2N2dFdDekQv?=
 =?utf-8?B?TGdNMVB4WU5ERHVndUdUZFRuWmxvWm1TU0RGL09qK2dWait4TlV2bTEvTEtz?=
 =?utf-8?B?VVk3aGp6OURwOGRPUnNpQmNEUzRlcG5Kd3A1SWxrNzFiMENDSWUyUUppVENV?=
 =?utf-8?B?RWh4cHl5RDU4MVJ2NGcxSm1WTDFwWmQxVXNFS3F6T2d2eHlseHhhTThOMnVn?=
 =?utf-8?B?M2dTUTV4enRTMDZYWGtvd3M3bGJJb2ZBNHZrS25taUY0TzI2cDlOZ21HMnUv?=
 =?utf-8?B?SXpKaE5ZbmsxTG5rMk13ZkxsR0dCbzBSSDdUbjRTbzY0ZzdreGNSZFRiajV6?=
 =?utf-8?B?OXlFNnY0REQxU3RhNHZDakh4RlA1bmE1em9WejIreFRlSnJ1QjcxeUN2b0pr?=
 =?utf-8?B?TG13SDZEQjNGM0cwdnorVXhXSGlOZzEzV2Rra3dudlhnbGpNeENyMFhSOENv?=
 =?utf-8?B?NmtMZVp5UUxiWVBVcVEyOSsxeVA5VWw1aSs1RHJ3MnAyR1cxRGZUeVhWV0F5?=
 =?utf-8?B?L0hYYjNWT3MyZTA4ZzVlQU1mWk5heXBWTWcvTmpwcUNkUUpKOXJPN2Jwc2NS?=
 =?utf-8?B?NDN6OG03S2pmNlNmSDFXZThSWWNwSWJ3WndJRmxFR2Mvb3huazFyUmRSU1lo?=
 =?utf-8?B?WnpKMTUrVUt6SnMvRjYwL1IzemhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70D203197218EF4CAD03C82FF281FDD2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RyfQzoVCCopNdiV6ArfXCOANvWMvpHxQF2wYwk/Rd2qgxFOa1yD7CiZOVrgJPJ2rVuqhFjReEAwBgpF7L5PastRTauKadS1zT1/nV/XkPd3yIIm1dZ3SOtTM/1DW0hu3/r7oNp3lLz0bWTQ8YsxDJV8NfRMylwQRSrjKd2e+9OBxRgGjO9qaKYEc3/LEe7iJXJ0KYzQNWxSiSZ4qCvnVesn3kO0IF7TBYHk9DsF/hJrGVbBgKBfWLXWLajkAvki2htwoOEoNs73dLWUMnC5qF0GT2CF+zxGnZYM+FDLIL+DhS/Br7PW8KJzn29A4fsKCqHNnc2f6CsCHLTlPq7gUTaUim5GR/ntAxHxQb+vePI4KG47IWNWMEvA8yVNF3mGBALM2oKgc0SxeVkDeNevG8ErIcmIkgKEDDuYD4/NmAnGOs/cCVDgIcnKO98B+oOIZqg76QWYOFp+yhxmRpGeu/7VHLJzKN70hI8bTCY6o2SysMCQ5FCNs8qZvmlyCBp2fUDQy3G5MjjOAXt8mge/w7pX8u86sDalss7VX7GoM6v6ou94cF0AQldDtO3ai+Zb2z0m6tZhJUZ8AVD42R9BHiaQJ+DSt2Vj0MugR0L1b8cSzI7eeN8KeTm381FFzR/nu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63afd6d-72ce-4281-b02b-08de27543e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 10:13:10.9778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MAsbY+3xg9dRPU33owkiNaqCI8IverRE9mK/PVhfowuM/Kk9nGD+yW5RY7nhoJRnU8MyOoRu9wlGTPcBYaZ5pMAXA71GZkurhGtFvkl7OwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7802

T24gMTEvMTkvMjUgMTE6MDggQU0sIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gVGhpcyBw
YXRjaCBvbiBpdCdzIG93biBsb29rcyByZWFzb25hYmxlIGFuZCBJTUhPIHNob3VsZCBiZSBtZXJn
ZWQgQVNBUA0KPiB0byBub3Qgb3ZlcndyaXRlIHRoZSBpbm9kZV9wZXJtaXNpc29uKCkgcmV0dXJu
IHZhbHVlLg0KPg0KPiBJIHRoaW5rIGFsc28gYQ0KPg0KPiBGaXhlczogMjNkMGI3OWRmYWVkICgi
YnRyZnM6IEFkZCB1bnByaXZpbGVnZWQgdmVyc2lvbiBvZiBpbm9fbG9va3VwIGlvY3RsIikNCj4N
Cj4gd291bGQgYmUgYXBwcm9wcmlhdGUNCj4NCj4gUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1z
aGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+DQo+DQpGb3Jnb3QgdG8gYWRkLCB0
aGlzIG5lZWRzIHlvdXIgU2lnbmVkLW9mZi1ieSBhcyB3ZWxsIGFzIHlvdSd2ZSByZWJhc2VkIA0K
aXQuIFNhbWUgZm9yIHRoZSBvdGhlciBwYXRjaGVzLg0KDQo=


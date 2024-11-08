Return-Path: <linux-btrfs+bounces-9390-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8E49C16DC
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 08:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54DF9285E0B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2024 07:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430471D1731;
	Fri,  8 Nov 2024 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Eau6Vwmm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LW/8Sc32"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37B51D0DC7;
	Fri,  8 Nov 2024 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731049760; cv=fail; b=lnrzu7rQ9U2u/H8JmKS7rzczh5A1ujh4N+D75DFDhQ5sYBVtJSZiGPEiETnFPvVJQRtKn/z+bkMkdW1bymcJq2u2Owaq4pj0rS1MMSsuBdpmKFKIep0GE+rPL9j0SbZkXBLMAp9PJMVZs2HdE4Wf/3kxw8Ne8jC3F0YQ6pRE5h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731049760; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZhfoMxFU7Fa5HjpJHEnntD+ho1If2dVuR0iTb7Hgfqprn/eTaqs+87XaJ8w0UwnWLHOr2oAGUTzw/5aomOs9MAg7sweDw2Vuw82EbXJZzUKtZSbOXVw0lNrjcRWj7DZ+uljm18xk9GLDcirwZsrlBJqDGn8e3KzhUPttQ3e6yn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Eau6Vwmm; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LW/8Sc32; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731049758; x=1762585758;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=Eau6Vwmm6Dl6Yqu1pAl8LlJ+lGpZzYRqI9iA8e2/sXENheLcIlqao3FW
   7DtHfYLCg1yedFpVJCN9EISEArqCPHnQJ+M0UIBDz5jhHiOjIe8S7t2WG
   EpjeP5do9hBK51Vn7NrSvemAQy2PAXaMAz2JCRjaFuuQGKP1vKG2u/QDM
   BhQEbdj8urBiAAH4CiMmJWb6oJFtq/Xd4VOefaKoFLMZ+KT+na0DT2fa6
   lXUUiIqfvNFDvMMvj71znX7N2amui5JPRv+T0Apm8HhQq2fC3CXDoqkpR
   3x5l4hY9Z/MtiQ5R+VAtTTHNUhGQFD+x3bhDwkU5SlDNYQxKzO8QPhATp
   A==;
X-CSE-ConnectionGUID: 2XmlmdTvQZiLD5EAdyAPqA==
X-CSE-MsgGUID: Nf1qeVjfSjSwXUp5aUo5og==
X-IronPort-AV: E=Sophos;i="6.12,137,1728921600"; 
   d="scan'208";a="31961951"
Received: from mail-westusazlp17012039.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.39])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2024 15:09:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKYAFIy6IOtiPPJb25YdG7hBZ8bhYt2/vCYEDKZC43cJEOVgMRH3gXnihF74rhPHSv67COcusp3qKQktnTJK+AIfE/zzWD5I+YeXqaCULZImEiaNOivS6slFRBjs8XwFeIxd29VjMBnYcBXDZpgAhrSG4r0kmGArNkTPBYIXmLASSJRT2xmSSVKBpUH3D/4OupudLhmRlzG8RtAWfkiquzq+bonwFU8n61cGKxq0khYR4pxmO6lAB74RkbcUQf7FAFQXpDEJJnK6g53HCySwbrQc0+hFzhAMu+eZWRETMe70oTBLIdBwZyJUF4HlPF9BGCxWh7Km+3wzCi6fXxxayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=AUm49RtsTTGItiKw0Qcl8YRZcVPBnqNHwZAZzrJQNOr/lD7VBxhNAAdATeO6oviH+PCsdT5caXOQ3Ol7zhN3SduU6gR0f+MtjuiLJJuXaY3r8ManpB9oy449DkdKOzCq1HLkLQ2iGvTpVubQPAgvJv2wxS3nSRDCeBjkEXlo8MhGXPlbhsPkHHAsUtyo9OgYVKBgGii2AL80ajTrb0RCuWJH3M09UgqhRUvd6KudDaNf+PRPNvAPbDjbW8UW4neQnfoUyX4Auw4xdXCeKHhGDFKK2tso5nrXLTkIp8IfuJmt4f0eL8NKNDNrmmo0m8bJnYbAEJYYvBzritWdCnoGDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=LW/8Sc32eGgaQodPHwT3xH3WN/+TlknIH1MseeFPQ4dgabzHTpfRgrRyAStltYDNaM4T3cmgotBxP19LR4fzdvx14OnkuRqtwOHZ035WyiYk/fWpj3EcEhlnC+4eBq4874qirGKdytS1ykBCYsRDu8XX+eD2qnqhA3ZnEjV7mxc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7400.namprd04.prod.outlook.com (2603:10b6:510:13::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 07:09:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 07:09:16 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Damien
 Le Moal <Damien.LeMoal@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>
Subject: Re: [PATCH 5/5] btrfs: split bios to the fs sector size boundary
Thread-Topic: [PATCH 5/5] btrfs: split bios to the fs sector size boundary
Thread-Index: AQHbLoKjqypbJHjfOkaOPfS2bczrGbKs/TYA
Date: Fri, 8 Nov 2024 07:09:16 +0000
Message-ID: <a1f49f2e-50b4-44b2-b128-907cf182f34e@wdc.com>
References: <20241104062647.91160-1-hch@lst.de>
 <20241104062647.91160-6-hch@lst.de>
In-Reply-To: <20241104062647.91160-6-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7400:EE_
x-ms-office365-filtering-correlation-id: 844ecad9-c210-4090-b222-08dcffc441eb
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NTZNeHl1MzJDVHVlVTFxOGw3R05oTUpQM1B6WEt6VkNUWEF5dWpKSGR1TXNN?=
 =?utf-8?B?N3RRVHB1cEx1NHlPMlIrdnBZMFFQN1oyaU80OGpUTmNoN0lHMjV1QmNONHlD?=
 =?utf-8?B?WlVqTVJ6RXN1eUIyRGZtRlh1NS9nclc4OER3U2VnZGozQXFlcCsxbExsNHl0?=
 =?utf-8?B?MHd1N2NudHhoV1J5dGo3VElSQmJ5Nm9LUGVFM1dOaW95cCtqWm1QUVB5MUNC?=
 =?utf-8?B?U3JMcTFNdkxwN0w5aHFsYW51Q3l6aWg0TUZYZlQvUENoTHpMbUdETnEzWUJK?=
 =?utf-8?B?OWFwdlQwUFRQdDhibmE0RDJkSUdCQlFpQ2dMSUloV1FLak9HamhFaUo2NG5U?=
 =?utf-8?B?RERyTkpZQzFSYjNoclQ1eUtiV0lvNVVMa0xsd2gwSFZXZGU3NS8vWmNhaFM2?=
 =?utf-8?B?ZmhMbXkzL3dndndIQytMcVdaaURMOGI3bWpHbFZvOVVZdXVmUDFCRGw4Ly93?=
 =?utf-8?B?OGJ4K0xCb3FmRGtYYk1MOXdOdkk4dWFmcmhaOUxTdHZ3TFB1Q05WcEYyd1I0?=
 =?utf-8?B?c0hST0F1S2R4dDhwV2FTM1lIaVViRTBFT21aZzU2MWFOZnFvZHY0OHhETkNj?=
 =?utf-8?B?c2YrOXBXKzhZWlZvd1N4RGpLdTNxRDYrcG1NRkE3WlB0SGN1OTZnNWVxdVlh?=
 =?utf-8?B?RUVPRXhLOXVPNEVXTU55QjJWUGpRTy9pRXFvSG5yYkk4TVljQTlvaUNlZnZs?=
 =?utf-8?B?VVVBdndpbmdlaW9lZ0ZXNVFHdDBPbStsdy9qUkg4djlDN2g2SGc3U0JxQ3l5?=
 =?utf-8?B?T1R0b0dEaVlLSHF2cm5idHJVbE5rWUxTakVWSkgrSTY4VitDUnN6c1hmRm9K?=
 =?utf-8?B?VlBxYSs5dTB4YUdYaTJVcWZZL0xWMG5CTE1Gbm0yNWxTS1YxZTFZUjZEM29M?=
 =?utf-8?B?RUQ5cFhWcGZVWm1UcHc0YVVqRHF0Zlg5SGVuM3Bac2hBSHZpb0ZFTWJRUDBi?=
 =?utf-8?B?MXV0aFoyOUI5NXd6TGsyb1JGc0o5WGlpc2lublVSSlBGbS9hdFA5NkRVTitm?=
 =?utf-8?B?aFZHbDNpUjA1Q2tPZlpZcmJtSnR6TWRMSzlrM0s4ZVpnb0N3TzNvakRySTZP?=
 =?utf-8?B?ZlVIcEJjMXFoUE55d3ZkK28ybVBUd2FNR2JReXZjSXJya1pEVFNMaDZVaHRT?=
 =?utf-8?B?NXFGUVhCUUlzTTZ3aUtyQU0rZkpoQUVYUFVHN3VCbi95R2ZOQnlLTkNMSGtO?=
 =?utf-8?B?Nk9KZGFYb0tjTkVaaWptQVFCYjliNmJrSS81NFdEVnF4WUg4OUJZdTI0R3pv?=
 =?utf-8?B?czc4dWV1aCtIOFIxQ1FjZm9QMUdYZHlwb2lhZ21BNUpVdC8zQnc4U0pzSlRq?=
 =?utf-8?B?RmRjVG93NG1YeTlhMmwrK243a21QVFRHWmh3UmNsWmNObDRxdHlNZjlXR08v?=
 =?utf-8?B?Mk01VGtPRC9ZR09CbC9wVlJzcHJtMUJVTUxtVFA5WklMenpUMzh3MnpnalJJ?=
 =?utf-8?B?SUdodWlQNGtXRFVGR2tLS1FEbGt1TlJ1RnJFWXY1U25sZXVDMUhXNitWVEUw?=
 =?utf-8?B?MnA3UjgyWWNDbnlhY0pVTGdKYnhTK3U5NXc0YXFWcm9KOEx3YmwyU3p5YVY0?=
 =?utf-8?B?NkFncVZLZ0RDUVRDWUxOTUdBaWJ4ZVVYUFJXN1NOeGNQRlR3Lzh5RGtrM2R0?=
 =?utf-8?B?SkdseXpMN1gwUXJkTXBpc1VhczFWWHM3a3ZUMFNlTUJEMWRvWE0yYTFDR0JH?=
 =?utf-8?B?cURwdU8zaGtSZldQSU9CbHJ6WjdJVnRodHRITExJZk41WEpkMUo1NysxcUtq?=
 =?utf-8?B?WmtVcTNHcnlwTVhrRDRKSjZHcUltSjd6NTAxaFg1UnM2dVhqVkc2d09KRDJS?=
 =?utf-8?Q?CdOSbuto3Ln1/3CjmcG2lFZIkNQbRAF9Qp7Ys=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2Y1c1ZITnJWN1VuNTlFRmdvYy9yb3IzblYvYm9ieU1NQmN5RXNZcGMwZ2xU?=
 =?utf-8?B?ZDg3bFVXbTNBMGNucDJvUFlRVEgxZmlDMUJTTmNaTjNQODNQbnIyTTFxdGtM?=
 =?utf-8?B?T0ltVGt4aGxxZXhmVVY2ZnlEVWxUTlowaDFUNG1oV2xlTnl6VUlzVzlVc1hs?=
 =?utf-8?B?UGgwVmRBVlVjNTNKUmxQQUkxKzFycktQNnNOa0tLU3M4RFRjdkxLZ2ttVFht?=
 =?utf-8?B?WTZ0eEVINmNQTExqWWFKdW1NV2VkVFE2VXpzRHJsVTJna09NS2RrWDVvbGtF?=
 =?utf-8?B?dWJoSXdvT3NTVHV6bks1S1JmL0V1RnVoYjd4UU00TUhQQkFuQkI3MkdOcmNi?=
 =?utf-8?B?ME1YS01MQmUyNmxNbGEvU3BoelFOZFVPTkFCREJaVXp3R1lpYUI3MGhCT3RG?=
 =?utf-8?B?dzJWRnYwaHRjUDk3OEg3UzRRRWF3UmdSTEJsb1VNVUhENVRFRmZPY1c4MW1u?=
 =?utf-8?B?cHl2OTNCazB3SU44R3VCSC9TVGxBajdPSEFleEFISjlQaHBFQTQ0TytJSEpi?=
 =?utf-8?B?NU1oNE5wejlveFd1aVNXYjVlWjIwd1UrY1pxUlVlZzdnVlFvem1rQ3d2Wm9H?=
 =?utf-8?B?dFUrbDRhTnlWZnk3cDViT096QUF6U212VjNUT0ZwZkp0SVhab3R6ZVJIR3lP?=
 =?utf-8?B?VE1PQkhXQm10VEYxMCtrUFhibzBQdTlEb1I5dEtvMGJCQ1Vpak0rYS9vLzFu?=
 =?utf-8?B?bUpvNXNXY0Z6akNFWnpYcHhsb2hDcTRlbGdrZ09OUk1YZFFxQ0Zjc2E1Tmdk?=
 =?utf-8?B?K25EMzV6OEUybXFCcnZQYUlRR1kvc1Q0U2pvdG9MWjd3Y2VRVEpWTDUrRTZQ?=
 =?utf-8?B?THhWTjZVRHhvNUpUcUNEbFZTeVNMY0lKMXliS0hOcXRtT3JsbklzV0l2amFF?=
 =?utf-8?B?MTV0b1BsbUcxLzlxS2xLSUJ0a2VtRjdSQUxzMnBKaU9NalovRnhCZi9TdUJp?=
 =?utf-8?B?c3RsVmdadUM4RUJEaXZYSk9qR0FlallpMXdiWlArZWxTSEVXekQ1VlFLUm5x?=
 =?utf-8?B?ZXZhM1laaUgvVWc3WDlBT3BiLytZQnhmbUs2emoxVlFYb1o4eEtQMnYrNUkw?=
 =?utf-8?B?YWVBZEFaKzM0aGJYd1ljTGZEQitucndJUUxqekI1QVN5Mjc3Uk91S1lUVDVi?=
 =?utf-8?B?SWUyL3FhZHN4TkNIeFAzd1VpNDRXTjk5VG9YWmR3ak02TjV6alBJeTlRRDU4?=
 =?utf-8?B?N3FtdW0rWXIxK2V3T1IrN0RxeDBMM1BudVdlLytZV2Z0NnlvSkpLVzNqaFBk?=
 =?utf-8?B?M2tNQkwwNU1iRTVCYTkzQmhGR2xBNjJzYjhCb1k0K2tGR0ZFMXdoaFdlTzlD?=
 =?utf-8?B?K1lIWnc1TlNnMmlzL0k0Q2F0U1pXMTVFcHF5aUlnV0lidllwTmVPYTVBZFZs?=
 =?utf-8?B?eEh4WVcyYUU3OUZrMjIxN2NxTGZST2ZOUm9rWWo2bW5pV0VJWUxxcUNydURF?=
 =?utf-8?B?Y05tcks0U3RkY1B3cHJ5M0ZjeFdCaVV2RVUxVStpZHpQWmx2TnF6ZjlvNVhP?=
 =?utf-8?B?clE0UDdnVTRXWVhrU0g2elRYaEN5dnkxYzVwYlF2SVUzcEt3Q29EdWNxWEZ4?=
 =?utf-8?B?TWtKeGdtbHdIVTFabkpTelVOOE9xaTRjR0lQRzBYdlRXQmFoc3NIU2Q4NCt5?=
 =?utf-8?B?N3lyTEFxQ1FXL21ocTFlbzJNRmxRMjI1aTVTNGZNU2tPOFR3eC9GdkZNTDZ6?=
 =?utf-8?B?UlVCWGtZWTNhYkN1eWJTTi8wOEZqZ1Y5d3c2K2JsK2I3ODZGTWc2YlJteVhN?=
 =?utf-8?B?WXdYeGZaMUVMcXFjdVpRRkxUU24yZTB2a0dqd2pQN2oxaHFVb2k0ekV5NnE1?=
 =?utf-8?B?V0psSnp5ZHlWOGkyc2JZWCtHNTdoNUdNbGtxTllSRzJPdDR6SkY2ckxOL0Uz?=
 =?utf-8?B?c2t4Tkk2UWl2TmlvN1h2NDV0ZmlBajQvS0VJb1FwV0t1ZmRiWjkycE1wOWtY?=
 =?utf-8?B?RjFXbUNJVHNNZXVDb1pTdUpMT2JldklWRlhXN3o2T3laUnlwSDhQbGphcmtJ?=
 =?utf-8?B?LzJUWldaN2xZazBDOC9ZbFNTNWkrWENYZHI1MVhGY3lZYmM0SkZnN25qL0Na?=
 =?utf-8?B?NnFsdWs0S3VKMHNzL0l4Qms0Um5lKzRYT2VaQld6UjluODdKNEdIejBQVmwv?=
 =?utf-8?B?MlMxcThpODQ5emNoUmNtRlhGR0VKMVRYOXJocVVTdjNsbUhNdUtrZTlKZng4?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F18609F7EFBBE74288AF52BB2EBBB5FB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AsvKcL0sEclIJvOl87nDnPyqKdK11Q0yNQcZhiKmKYIzIYnYUSvRGrm77KinGkFeB6jUQySi3p/emZOtVodMgowmwwJtgiVbB1gP/h/u7j4AqCQrZFDiSf7x1R1tDyCZnVNDRKofxulTmphJzbU420ShlXdRkhNxU4eTpHbHtAQerswjkS+5B5lKrAoUWa9O2uzWzpReNqPjrFl7DHLWDm/Jt7rsL/sNjklEVLU2PQRwRiltcVcp8zl8GPgW5C4LXPEwqQDI1U/GVnq1S4LKkvJqHW+uEiwoi6bOk6BWH28QbbThz02VEnDryqhU1kGCQj9gnP1jTeEVJcLNBTg2gjOzOYkLiNg3tLXofDegGPLqz5cmkzifUb5bcfg3IW6v2jtZmGyzO3A9FHPKDVs9ocxhB7XC8CHR3gzsNOWSdVMmNJupn1cVofKv8OS4+qIkrs8r4VlmUTg99S+KF7qg/i5+TJ/54BsopnRA4rSA0+UDYJbU7J0YBR6fK1FVYtzbr3g5tKm2JlZWLjsFPmaOSoQKIK3JGdGu2/L7t9m0oeKu93KyLNZIFBA10sHybtD4X8YZ0wFNGk3CzvQi4XBT7wZZLXiTQAPR8bTT1byHWWs8n1NKbVi55FPKui83BWE3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844ecad9-c210-4090-b222-08dcffc441eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 07:09:16.3803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JHddVYtLJPblJekHtICR7icJ8cuOAG46KZ+hhrWIIifzcIuREN4fqoXVXyz044MDGsPjWzGBiS4mZqWtU2Nw/09uq7Zu7fXXgDVyAVrTBs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7400

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=


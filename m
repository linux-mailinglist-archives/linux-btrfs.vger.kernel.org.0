Return-Path: <linux-btrfs+bounces-9250-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF129B653E
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 15:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598831C20B36
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 14:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31D91EF93E;
	Wed, 30 Oct 2024 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UiU+RGaJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xkrrqPiW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B328D1E8852;
	Wed, 30 Oct 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297211; cv=fail; b=HjK0XeXHFSh6Dsku8KepgYy0r/uSCNj1ZeXx0KbtGPaiIq53Hshz/C++B0tYJYOhFNxDo/MN8HYBc93LI10cZOD0iFazSdlntFbFrmrKTTg99fgdShQxtrXabdqTZbLozrcA2Zi87k5k/HbtJYAreXcGqq1l0BZxNOtMUio1fiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297211; c=relaxed/simple;
	bh=sxyN3j1TLhxDbT8WWJj6vKiAk+GSHllI+uiUWiLO7zw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jpw/UqgI0E6O/TODSWdC/yatRvzyBoM9iYQS6LSQQtDTDP12xXDwkOd8JeFzq9uDhpruR4Kh33TLBWo22imRKSakvk6KSNAxIfoFf0YU/MSnVENgzYJO+vYOXNGqoLqmaep1kstlAXYhl1cDO/ogjB/EcCg6gKoV7hqmJWxeha8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UiU+RGaJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xkrrqPiW; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730297209; x=1761833209;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sxyN3j1TLhxDbT8WWJj6vKiAk+GSHllI+uiUWiLO7zw=;
  b=UiU+RGaJ12vNiIM2C/QZDDHB0RqsQMRFf6Hn2dnFfS3mCnnBB5U97swg
   dtnn/zRXeyDDa87xY7CDSqcH+yrXSunfKRCPCRYdXj9IHONu8Wx2/0SLg
   beEw8WnsPHn5oSYSgBEDWR5OdblxbXG4ftzTtdsg1rox2QveDsdMMRxX0
   KsM8eIneQujFCBbtwnkc5wj9y7hgpqzp0pvI/u0a/wCNXL97Y2mxRyfz3
   zJ1DmqjzhIU2sLAgSxfZRlaoN/Z7Jh6jtDYm6ZC3KKIYbMmhAOdmPWhWa
   d1TgJiPzc9SVczVCos9Ubh49rjvRyEYqONxYLzQe9pV/VLiMiKxkagPc0
   A==;
X-CSE-ConnectionGUID: fnaTQPp0T0SyXh3BcyPPmg==
X-CSE-MsgGUID: 0Zp7iecLQYmdPeK/GJHeAA==
X-IronPort-AV: E=Sophos;i="6.11,245,1725292800"; 
   d="scan'208";a="31348190"
Received: from mail-westusazlp17013078.outbound.protection.outlook.com (HELO SJ2PR03CU002.outbound.protection.outlook.com) ([40.93.1.78])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2024 22:06:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBxVt3Zaux3DDV2DzyYVGk7ZzkoxP580ZOsrGKq3EUx+9xVwZW1GsQxfZJ6uw4tO/JfhNO3xRJtaLqDjZiECGrOJPmgNDK0uO02FPFW7dizCcMiXLWnDVraTvUvY5nZwdARKF+XxZnr/bXIms+fy8ybbRRwnt6JuJwFbid8nwRvKNR6oKswviGd3wN2/Eg4LXzWgjp1eZEE77iDOUV0KeUynZjhcIT6Sim9SOixC4LXe0TQJym8RgM+gJt/gCb3guTqdPsHpizA7RCd1pHc1r+SegPm7k6UNq1YjGXinOzQX/B3Vu5BS7+UjH1EgL7Orr0L+/esgix7nKonTPWUKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxyN3j1TLhxDbT8WWJj6vKiAk+GSHllI+uiUWiLO7zw=;
 b=GuKA8ced+M+gzPHtn5H1l3uEqEJCCIaxKIeq4Ouwm8YV+vYxONU+L/zLuLhzwKrxeufT4Quw315kGbhyVzXkagnbdnajCsqp5YurnyR6LbQ9xJu5RTqWxMv19tgbar9twe1HWgTGrJi4IfoNjU7YA11vOUK/0h7giuWUfSzeTtdzPYFTKtw3QxKNz/VZoi1uKoN1jkbU/QHWDNEIGdLKB/3usERyrO7Y7X0N3sV15jfABqs60YXrS1LKhU3RBRKqxe5Qm5hIULkt1L2Wu1JKQCe05ePYbNjzSixHE+DE9yPUmn14w/YMuCy8Q2PbIY6QAo9SLI8KEJthTsbLJdCItg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxyN3j1TLhxDbT8WWJj6vKiAk+GSHllI+uiUWiLO7zw=;
 b=xkrrqPiW4WkruZr+q//APq2DKW/Sv690c7Mtg1V1mK712CBctGdxr1k3kCGLtX+BUobK2sTNMHR7LmgRtTGgojlE5stqWWb3zG9wsjecvreY3H2ORddIJRfQlTOsjfw+0eQUJxgw4khosbmr3f3neM7V6LOI0TNqVQUSMIQNyqQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6315.namprd04.prod.outlook.com (2603:10b6:5:1e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 14:06:39 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 14:06:39 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: kernel test robot <lkp@intel.com>, Johannes Thumshirn <jth@kernel.org>,
	John Garry <john.g.garry@oracle.com>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "song@kernel.org" <song@kernel.org>, "yukuai3@huawei.com"
	<yukuai3@huawei.com>, hch <hch@lst.de>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH] btrfs: handle bio_split() error
Thread-Topic: [PATCH] btrfs: handle bio_split() error
Thread-Index: AQHbKeKi9TIjMidpj0CKdqAwMRBjTrKfVHeAgAABpIA=
Date: Wed, 30 Oct 2024 14:06:39 +0000
Message-ID: <c9936883-d766-41f5-9a54-35702585ff6a@wdc.com>
References: <20241029091121.16281-1-jth@kernel.org>
 <202410302118.6igPxwWv-lkp@intel.com>
In-Reply-To: <202410302118.6igPxwWv-lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6315:EE_
x-ms-office365-filtering-correlation-id: 4a63c06d-ae77-45d1-771d-08dcf8ec1301
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2hFbkdyWmphcFd5ZDVaa21kbE51QnNhSGFLbmF5MXRpdWpndGxIb3pDSnlj?=
 =?utf-8?B?QSs5cEthaWllMmRKZUFsZTk4M1RpL0hCU1NMbGRtdmdvdU1JOE9aa3RJWVVh?=
 =?utf-8?B?WCs1b1l2Qm1TcUJ6ZldqcTNNakQrUW9XVzNHcno4eGVrTlVydyt5ZEkzTVRU?=
 =?utf-8?B?dXBobzZ0dVNpSWFJODFIMm5qR1BzRm41TEkvSm96WWFwUmViWTRmTUhKUEVp?=
 =?utf-8?B?V3FWdkxXWXlEcHRQQWdCTXAwTTNZWmcxeDhVc1JaYjNaS25sMmd0RzJ3VlhF?=
 =?utf-8?B?L3RtVnovK3BRL1JQTEtSWmQ1NnFWQjUyUjFuL2M1S0RJWmVEWk9ySUp6TDJ3?=
 =?utf-8?B?anRSdktnWEhSaXdNeHk3QWRQcHMvSHloRnA2b2F1SnRUWWlEalRMem1FK3JI?=
 =?utf-8?B?TDM1SUI0WlZIRCs4bUR2bUZmaDdZUlJEbzA5SnB1Sys0ejhCYXlRNmpvNUc0?=
 =?utf-8?B?VGRna3MzbUdXK2ErVFhIVVNpdUNQRlJlNFJmdG15TGNQQXVZVTVqbk04OGxJ?=
 =?utf-8?B?WFlqLzVBUFhqOWY0aTBvbEhhNmNxdUVIRXRLTGQ5REJ6ZlhUR0JqQzhjRlU5?=
 =?utf-8?B?QmZLYk9MZDhzNjA2VVZtVjZTbGlmUkxBTWZENVVkRzRGei80YURHcWloeGVm?=
 =?utf-8?B?ejdpZnFvSzB2MVFmS3BDZ1c3MzlIMkREZytobFQ0SFZ1ZWhlWk1TdlJmWUxj?=
 =?utf-8?B?andFWTU3cHNOQWNkenJVandNRTQ3TGloTEs2UGdiWXRyTzJCSFdncDJMSjlY?=
 =?utf-8?B?WlNXNERQUk1DWDE0SFFiK1hqb2tlekNub0l5ejJQWHRwRnpRUlNFM3pNY0dw?=
 =?utf-8?B?d3paYVFLZ1YxVGh0V1pNMU9iZ2ZRR0VjaCt1WUdtSHVaZHVucjFWSGlvTXI0?=
 =?utf-8?B?V1N3ZmNhM1llNnl5SjlRRFRGclpTNHlab2RaQkF2RmYvVGo1anpEZURlKzlX?=
 =?utf-8?B?T3c2NUplUDNURFBnMmN3Rk5BY2w2NGlQQ3ZTQUpZT0IzZjd3dTRzTTZLRERU?=
 =?utf-8?B?bzBFUEpuajV6eXpvZnhMeGdPVmVXWnV5M3lGSDdmSnBzQktnM0RQaGJ6dDJv?=
 =?utf-8?B?WDdKaDc1M0h5Zm5aZWp2dlhvTzh4MmpEeFVpVi82MWdwckJUK3M3a29XVzRG?=
 =?utf-8?B?SklaRFRKTSt5SVVKWUlVbnNQc0pSMEpRVG0wOTFpL2FMMmNkaUVieUI0ejVv?=
 =?utf-8?B?eDV0NWVKSWVMQ2duZWpnaUlrUWFZV01IUUxnVHc3MTMrUGJuTU1LM3ZGZ3NL?=
 =?utf-8?B?R1d5SmlzTWFLSG9WMTNBYnM2UExuLzFGNk0rVUtxNmV2Y3NpWDRQWTkxdkVF?=
 =?utf-8?B?MW5kSWxMVnpmMTdFeXBmQi9BZmUrUXFoZmZYQ0hHeng5Vm9yay9nMUdRU2JT?=
 =?utf-8?B?LzJBMWgvckVNRURlZGcwZXBFOG4reEFBWVI0ZDdnTHVNNEYwQ29SaC9EYzVP?=
 =?utf-8?B?V3MxbjZvSXNUb0xvRkE2c044SE9hVXoxV20vc1ZET3ZvemtQSmdSbk9JZHgw?=
 =?utf-8?B?Z0FNR3NBT0hvNU5aakF5ZHJMTUNTNmQzTFo5TENoVFJKSlBOQXUrTzZjN3lL?=
 =?utf-8?B?cnJpNXhhK1pkc2JreHFqVTI0bjgyWWd2NVZ5Q0s1c2wrcU82YkJScW5ZYmlH?=
 =?utf-8?B?YWI2RnZRRGZQNW90Tkt6Sys4UGRZNUtWMS9KbWY4K285M0ZtSFNvRDhsZWZr?=
 =?utf-8?B?UHJuMUFVTGlMdm5qN2F0UTVIWDVNd0tPVytjWUh5enVFNVFpQnBXV09jTG9l?=
 =?utf-8?B?cy90QlVxODIwaWZhM1RtYW80ZnFFaUsyZHBOVmVsTjYrMUdDUEpTRVBrRjFW?=
 =?utf-8?Q?kv/dUwCumPfPKtRRpn+4db+/VfMcpiv7xvsyA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUUrNVFZQXF3L3oxNitXY2hURGw2TkhhMTladWREUlY5NDVCTTJLM2JYVUdK?=
 =?utf-8?B?RnVadGEzM1hTa2p0RDBJTVhvZGhBYm1iam9oRWY1Z09udlZwdm4rQ3lHS0pM?=
 =?utf-8?B?Wnp6OGkwWUZCRnlCTkxLbEUrSnZZVXh6eHM4K09NUzQ2N2xSQkpwRDVuNGZG?=
 =?utf-8?B?d01udGNnejlqTllDSmlHU09aM1lLbU5URDlER0Z0QUFKRStuRTlFQnFZUHp6?=
 =?utf-8?B?d0gzTmU4M1RENm1MMG84b2llVzNSOTAwNHBGSTFzT1JXOHQ2VkczUE9Rbjk0?=
 =?utf-8?B?RU9uQVBuZUx2VWFjb1Y2MXE5UkhCbE5LUER3QlRNNGp2SnBsREFNMVo0bFlt?=
 =?utf-8?B?b3JYa1lRcXFEUnZSKzkvdVJHVXA5Z1VxVCtPSGEzcFU1MDhaNTI1RTdNV24v?=
 =?utf-8?B?QlhxM0srNjc5cXFKVUxFZElrclR4bGswRlJweU9QK2U0aFdDU2dtSEthM0Ux?=
 =?utf-8?B?ekMyQ3BJN3h4U2Vmbzd1eW1aZWdOT1E4Ryt0bzBwaWxHVWIvY2RPYThvenRu?=
 =?utf-8?B?bzVVNStOVWhFRlZ6WXRlQ2gyZG9vcm12UzlrZys3NVp6dnRvSFNvTXNxMGcr?=
 =?utf-8?B?QlgwUE5aOVJEbDZMTjJLckk5UXdtMEFnTExYU2kzSEdVd2l2dkYwRWRSTGJx?=
 =?utf-8?B?TlZRK1lMclI1SVpUbXpUWDcvb1FSVjBGbTdidlUzNmFPL00wS3o4U0xMNVFC?=
 =?utf-8?B?SnYzZ0RaU0VFNm93ekZIZmFiVGhEamdpYmM2MWNtc2lQWG1RVkxyWmplZmt0?=
 =?utf-8?B?czRvcE94OThKY2FyVjFGaVg4T3UvbkwwOTc3eTR6cnVralVsZHRnZUdsOVJl?=
 =?utf-8?B?MjBNMkpIQmJTWmpRNHdWb3hPOW5TdnR3cjFoZHVLbmhWMldMRnJ6RXJmZzNk?=
 =?utf-8?B?ZXNISEhUQ2MxMVBWeSsrUHhSYzllelR0YWNrU0hIYjNWM1Y2ZU5wb1h0cFJz?=
 =?utf-8?B?NnVIUXdtTU56azZHNmVXTlpOd3lGL1lZTGwrMTkwWG80VFNRamY1ZG5mWEw2?=
 =?utf-8?B?R2NxS3VYc0ZRQ3Z6blUzVmRPekswZzNkN2V4aC9YMFFDOGNQQjBwZFJUS1Nm?=
 =?utf-8?B?WEs5M0VFRHNyZ0d6UjZXMTc0Rks0VEwxNm53Znpzd25VS09ESjl0N3BZNVph?=
 =?utf-8?B?eC9KOGcwNFBHV2dJTm5EUmlraEJJcEhPK2dMenZxeC9SRTRQMGowWEpHVFNG?=
 =?utf-8?B?WVJxUHpHSVROT0VQc241Q3p2dFdENDFJUndPMnZ4dE5uclZ2VklGeE50N1J1?=
 =?utf-8?B?N2hvWHprUXo1WFV5TjRONWYrUFRyakJnTERzckhxTW1LTHBLYVIzR0lvVXFH?=
 =?utf-8?B?Q2Myd2FRRWt0aGRRSkhZLzFCRzZ6VHJOUDBQSXM4NHp0UHNnRXkzNERCOGZk?=
 =?utf-8?B?MnRlMWc2VVBwOUFnUVczWm1vbnRSTjYrL2MyUGRuKzZXandwbVB0L1NmK3pr?=
 =?utf-8?B?Z21SMWl4SGZ3WCtwdkxpZ2RkSWhvdUFjT25BakVuYUk4VG1tZURkMWNWTkY0?=
 =?utf-8?B?Z2p4alUxQ0RpcFlVSmVoZURTTXloSnhEbHBtOFhNbjlHV05YY0JhUzI1YlVM?=
 =?utf-8?B?WjZxWDFMUDdkbHoybjk5TGRIM0hHME1KTkhYVktYcjlmNmcxVzNnK1RlUW9C?=
 =?utf-8?B?SmhLdG5lZXhRdkIwRFROcVQ1RDdVZXdlbTkzZGFmY1BOcFE5VzB5VkFDVlg5?=
 =?utf-8?B?dmZlTU80WE5FVzVLdGlGcVFKN3dSSUFobDJHY3MvWG5XeHpuZ2ZaNlIvcjF2?=
 =?utf-8?B?SWc0em92Y21rYXRaRXlMM2xTTjk0RnZydDBqN2hFZmtCM1I0Qi9HN2VuY2FY?=
 =?utf-8?B?bk1WclFDV0FqcS9Wa2FoSUQ4OGppYSsva25XMFhsbmN5b3I2aE5zOTErdis1?=
 =?utf-8?B?Umg0ck1ab1ZmTnpWNFdaSC9zZDBnMHoweUI4UExoVzhaUmFJSUhHaGtnOTVP?=
 =?utf-8?B?cmR6ZVpsb0F5WnNFUjhaUjF6N0dWMTZJMjNzbFNET0dQN2dkZmErTFJBb1dU?=
 =?utf-8?B?VDlZVzVrMGxhWXpTcThtMm8yemxJZitRajJjM2ZSK0g0c21TVXpkc3A2eHYy?=
 =?utf-8?B?ZlU0by92WjFyYklLREdtWUZ5ZnhCVTh6b3dRSnoyZFJVVE9DTDZHdTcycjRR?=
 =?utf-8?B?bk5DbHZyVzRQUGhkOE44UmVlWlJMc041UEU2ZHo2RmpBWE5FRDZRS0w4QzhX?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18DED409E552534CB24AD338BAF504AC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MLEn+YGZp/+elvhEw9JCmQtKrKbgsev8WIyxWaSUwXQzumz+uCMDDC1bPfTXucFlsdvw5fcT/lFhZYZe3Zks9u5xTIBu/08v82WXzPJ9W7NU7dnIZU1YMSgIubL9H6wPVy0LjjL+0cXDiSNdau4Sxugf4A4kwqNNbA6OA7u6PDz+3e1SpkweIjUeeJS7p2DNf96QDqI6Lf0Qf3Esz73Sg85YpBUl/OysNIOrkZh9xCzjWeGXiipQD5hREehpnqaONtRUYUbpv0CZ4+LAYLBhk+9iAk24sWK3JXpwcQUT7eujqpGee4w3/diCIQmSvRxJXooOkGN1JGIHRVJRfT0stJuO9apKswWymjF3RrlmTWCFZBsm1+f0TYtelZXZ7Wr4nY6H8miAUTZ98CWtM/CWz6PyoH6nSlDTBth3MEukPschOquS1M2pRtRVYS4TGaLmAkkaXu3LdaYcDyO3zgBbcFmEKsbh5CwhnBnD4m1iTiEmugzPT5lSzM0QgzOdMgLsCzKmTf/g7kCg2GjliiFXDn34wWOOA7Uo3ANxgmnTdViA7WqoUzCYlUsOmPCA7NkBHgnOZA5SxZosPTqO3ysJbVtpPHxIc28u5DEQOiOnM7pbUZkvVef9Pf66M4Qsl6vw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a63c06d-ae77-45d1-771d-08dcf8ec1301
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 14:06:39.4184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrfodsGKU7VAjsKRDo/WnujkgUI3n6J+fiL8gpqSwK3AD6YiG7nnT2EUfzZ0kOPZsupFqtO9qBJbI8aC+nPZw8EdBtaBi3+Gd/h8mRideX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6315

T24gMzAuMTAuMjQgMTU6MDEsIGtlcm5lbCB0ZXN0IHJvYm90IHdyb3RlOg0KDQo+IHNwYXJzZSB3
YXJuaW5nczogKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KQ0KPj4+IGZzL2J0cmZzL2Jpby5jOjY5
NDoyOTogc3BhcnNlOiBzcGFyc2U6IGluY29ycmVjdCB0eXBlIGluIGFzc2lnbm1lbnQgKGRpZmZl
cmVudCBiYXNlIHR5cGVzKSBAQCAgICAgZXhwZWN0ZWQgcmVzdHJpY3RlZCBibGtfc3RhdHVzX3Qg
W2Fzc2lnbmVkXSBbdXNlcnR5cGVdIHJldCBAQCAgICAgZ290IGxvbmcgQEANCg0KWWVwIHRoYXQg
ZGVmaW5pdGl2ZWx5IG5lZWRzIHRvIGJlOg0KDQpkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvYmlvLmMg
Yi9mcy9idHJmcy9iaW8uYw0KaW5kZXggOTZjYWNkNWMwM2E1Li44NDdhZjI4ZWNmZjkgMTAwNjQ0
DQotLS0gYS9mcy9idHJmcy9iaW8uYw0KKysrIGIvZnMvYnRyZnMvYmlvLmMNCkBAIC02OTEsNyAr
NjkxLDcgQEAgc3RhdGljIGJvb2wgYnRyZnNfc3VibWl0X2NodW5rKHN0cnVjdCBidHJmc19iaW8g
DQoqYmJpbywgaW50IG1pcnJvcl9udW0pDQogICAgICAgICBpZiAobWFwX2xlbmd0aCA8IGxlbmd0
aCkgew0KICAgICAgICAgICAgICAgICBiYmlvID0gYnRyZnNfc3BsaXRfYmlvKGZzX2luZm8sIGJi
aW8sIG1hcF9sZW5ndGgpOw0KICAgICAgICAgICAgICAgICBpZiAoSVNfRVJSKGJiaW8pKSB7DQot
ICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBQVFJfRVJSKGJiaW8pOw0KKyAgICAgICAgICAg
ICAgICAgICAgICAgcmV0ID0gZXJybm9fdG9fYmxrX3N0YXR1cyhQVFJfRVJSKGJiaW8pKTsNCiAg
ICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGZhaWw7DQogICAgICAgICAgICAgICAgIH0NCiAg
ICAgICAgICAgICAgICAgYmlvID0gJmJiaW8tPmJpbzsNCg0KQ2FuIHlvdSBmb2xkIHRoYXQgaW4g
Sm9obiBvciBkbyB5b3Ugd2FudCBtZSB0byBzZW5kIGEgbmV3IHZlcnNpb24/DQo=


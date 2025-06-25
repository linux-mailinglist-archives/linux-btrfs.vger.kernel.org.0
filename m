Return-Path: <linux-btrfs+bounces-14939-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64212AE801F
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 12:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E59B3A39A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 10:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCA82BDC39;
	Wed, 25 Jun 2025 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JDjCHkIC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="E+7c9ksm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B382BDC06
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 10:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848369; cv=fail; b=EbOVrQ4yTn+zjbXyzSY4+S+C5sm2rDjxIaXfsgMFjtneExIkaVFdxNixpWyN7+rrrYW/y1h8hkVgOwjpYJ70VjGkgqfM+1E5vXNyS9ATXCyJ+MI5BjOgMibdWDSqgHrlFsdHehGB7kcVCFwPUKU91p4m160Uwvc9YBrhW7vqTLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848369; c=relaxed/simple;
	bh=1i+no7JGetFlYhR5WgNnl042eQyWeQcp3MCJMHbgzJM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hJz9qDAFKxkE28LsjRgk8F1FJ/Co8pls5VAU7x0UH9JnvozVN3xdYbIT8M8drYG+0yHzvL0q+2IEQI6Jlw6bBPIOdlumyTM41Mp9SRg/6eCkqAbyUy7L6waFo+gwbZlCCFDDw/B4kPnvnVSfYl52DymvcDWOai+IwsPOpHNGIek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JDjCHkIC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=E+7c9ksm; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750848367; x=1782384367;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=1i+no7JGetFlYhR5WgNnl042eQyWeQcp3MCJMHbgzJM=;
  b=JDjCHkIC3d27HYo+IhPOL5EqBtCFbGipn2pgUcx7vMHbqh5/fQA+Zfka
   w8+ApS0c4b0jroBIq00KyzF44/uzjFbszKLl/13bHvuKUffNls2WQkxtr
   yRnG3R9Bfam2yH7EtS4nLhXO9vkboZgRc22TmdpMAxjU28Hl86B9Wf4DC
   EyWpqwwRhFXtzI4MW8eBptBbhSi+7ZSJMoI7ATe3Em47xJCRWi3QNRZKy
   UW6cbcD0EPLg5jy2R51CEO3gUDsFdb3E9WxBt0Xe+RRp+x7z0LBH6XQcV
   EE2UCCrXJqeAkkG9sWx9OV/4sCHOkxDUDxDP2AEA4JFDb6tmnW6KnKc67
   g==;
X-CSE-ConnectionGUID: /uYp+FIbQl6wwYa2g7gavg==
X-CSE-MsgGUID: a9H2V0zmTf+K5LaojCuNoQ==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="91247313"
Received: from mail-mw2nam04on2070.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([40.107.101.70])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 18:46:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEiZoxZhIQW/9pixwCcDuCEZjH8EDI1G0XiwT1ZkNoaz6enh8LouYqRlPWvk+Vpg8ZzBpQv3Es5Rgxw58lvMwBKkH+5uXNY1q5Jc2Md/gXC8rPKGS8yYgRXicrf3CfOzD8He4lvaK2MzRhVCCrK8GWMjL/YwzYt2iUrkIIY2LYB5Q3Zi9eIZquIzjjqiNdj+nUrKp6ijgNEIIv3umpAjvOqYPYPVd10NsuovmB+oZb+qtbMDiXzN/63AHAevLRv0+ZzAUnctJ6wgkt5xpoNND6HPwq3cWeBdHk2K8eEB7SfjGrTf6PDPqQR25vh+LITNPZdgXP6B/o793kI3qp6Tew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1i+no7JGetFlYhR5WgNnl042eQyWeQcp3MCJMHbgzJM=;
 b=tzXLtgCNfdWqLq+HQBy8SRdr7w7IkQ/LnBj3l8omU2DX6lVlMZvhgs8IdW9Q6JJm3e4UKYbmASlfprBmzUDZZsIfXN/gbAmYj73ZaKQYic4j7+Cor30GKnHyJ1y24Nvgy54piPJh/dvvz+rEzbzc/oM7ZAhtkWt4XVD/GfOkJXNJVujuMoEsoT922RWc25iH2BzYQfPNgBqOzcMLBhkMuqiDh6psEX2THHJL/IE+xMcPCdxj9TFhe4Z17YCpv5JwsYU+pAg+krNg7Zq2fipjDAsfp18ZmV5fo8wPRMANyxXBFJoU2QR2MZ2E0pa/n+MzFoKU1U5dQYjPRO0n8TWXPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1i+no7JGetFlYhR5WgNnl042eQyWeQcp3MCJMHbgzJM=;
 b=E+7c9ksmA1gecPVZCQbMyuqAhKvQiG/9ste7il7f1Ji1eOXflmy0OUO6p+w33Nb82hqVHvVbWsrMpWJOAB/BC2MLTIA5yzj6FMAT/ZZc26Fte7VSpztPqjSeTdlOLo3ICBmOkZKYYxypZIYpQdarLPHJNcekT9pGjCwI2O9swac=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8311.namprd04.prod.outlook.com (2603:10b6:510:10b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 10:46:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 10:46:04 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/12] btrfs: propagate last_unlink_trans earlier when
 doing a rmdir
Thread-Topic: [PATCH 05/12] btrfs: propagate last_unlink_trans earlier when
 doing a rmdir
Thread-Index: AQHb5RgOMlkngGKW00+Wxe/YuND1xLQTsoIA
Date: Wed, 25 Jun 2025 10:46:04 +0000
Message-ID: <b437a8c7-2c7e-440a-aa24-f878fd75c2da@wdc.com>
References: <cover.1750709410.git.fdmanana@suse.com>
 <cb814b7a99065d951af9ae37b31a986e6c4eb3aa.1750709411.git.fdmanana@suse.com>
In-Reply-To:
 <cb814b7a99065d951af9ae37b31a986e6c4eb3aa.1750709411.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8311:EE_
x-ms-office365-filtering-correlation-id: 8439d028-aee5-4a55-1ee0-08ddb3d57bf0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZmVUMG9FMTUzUTFoM2ZGQ1M4TjA4ekhkWkorZ2ZaaDAvMEJWMnoyMUI2Zmdz?=
 =?utf-8?B?cHJGWnJrelY5Ti9Jc0xyOTgxU2hGa0Vwa2YyTFR2ZmpnLzNENGZoTUFsS05X?=
 =?utf-8?B?RDA5dGRCZTVNdzh1Y3V4aktndytpaDlpd1VUcjJ6ZytVN3JDMVRaVHQ3c0tx?=
 =?utf-8?B?RCtSRWNrS1NLb2E0ZElSZ285VXFFK2RvZXM3bHZXbjM0c2o2YXc0VlpMVGVZ?=
 =?utf-8?B?RHB2SE9ocC96a3dQK2NnQXovdUJCdmNRRkwvVUZDN1hBMEFDekViUUEvZzFJ?=
 =?utf-8?B?OTc3OXo1dEZSS05Qck5CMlFib2ZyNC9xcHFZU1lKSEVwQVdjdE5obVhxd3Nx?=
 =?utf-8?B?MDNKbnZsVjY3cExUVFI2NytqMzVvRXREQlVJaC85akNDZStuSHpoUTl5c25M?=
 =?utf-8?B?YmsxZUFuclZLVzNiNWl4RXBXcTBKOWtQQTQrWXQvODdIWERYcWJGaUtsQVVS?=
 =?utf-8?B?eU5VdzRiWXplOW5SdW12YWdGS3EyUGVBV2VrdjlOS1M4K2ZkUW0wQ3NvMWdT?=
 =?utf-8?B?ZGdqU0hIaER1Q0g0OUw3RnE3NE9KaENPM0hKRXk4NElwakFZODRRRDVPbEsx?=
 =?utf-8?B?aTRkdW9HUElFT0FLc1NQSnVlZ0QzOUMzbFI1YXdiMGl3V28zVlJmcFBuVG5G?=
 =?utf-8?B?QVNhb3VUNGkxaWQ0OUZBZkM2NEt6STdzemR3TUZtWU1nbU5oR3JZZWoxRmdG?=
 =?utf-8?B?Y3JGd1l0SHBYdTlaenlzaTdwdmZrajExR0FYd2tFUytwRExrQXhScmEwVGdp?=
 =?utf-8?B?aGh6NmI0a0tHNWR6eFpqQ1h5ZUZmeEhjZTdDMnhqUnlEMWJNS05DQVl0a01a?=
 =?utf-8?B?VjltcW9lRktmK21mSkZDRjlsREwyRDFHb0pFNkNYRFFVNzduNFRGSU1nRVVU?=
 =?utf-8?B?LzJsNDFYNFdDT0xtSkI2ejFtMDhhUjZHZFRGdUM5WlZyTG1OMk10L0lGd2hW?=
 =?utf-8?B?Vkd0MCtGWSt5R1pnZEZjWWROT1lxQkpndlgyYk41T1pKMXI4dFhqd2U0MEFl?=
 =?utf-8?B?aUd6aW5OTURrQ0YzVG4zZStOYVV6V2tnOVE5Qmp4cmI0Ukw4N0t5c0xFSTRn?=
 =?utf-8?B?RVJyTXovdTl1THBIb3V3OStia1hoWjFMVGlLb1h6MG9hc3h5OWx2UjNFMy9m?=
 =?utf-8?B?TTRWZzgwcW5MUHZnWGlGQ3N4WndoNkd1NkkvU3RKQk5VUEl5UzVteVdrV1dx?=
 =?utf-8?B?RjB1ck5qVkU4ZUR1ZFJlRXdRelFpakdDdFQrNTNCRDViTWtiYU9udEN3b1dv?=
 =?utf-8?B?ZzZQSURROVJYQjd6enRSZ05ISG1jM3pZZXptaThabW4rRVB2STNLT1BNRzhm?=
 =?utf-8?B?M05ILzBnZG5kNTU5dDBCVUFlODdTUmNHRmFKYjRFekY4bUpxcDhQTGpyUlIy?=
 =?utf-8?B?R2UzTmp0U0ZiVERydmo4L0QybVVzZzNxZXg3K3NBKzZBU3AwTnBzY1N6VDRZ?=
 =?utf-8?B?WVFkYS93YmlQb3NWUnJZRit6L2l5M0RoK2VFbnJjSjNtVWxUaTZmblVIbVpa?=
 =?utf-8?B?OGdiRUwraEhhRVg4UkhSR3pyM01XdE5VbmFFdGl3eGlNNDNMSXRqZHZVUkpG?=
 =?utf-8?B?QWJqT1NVQUkyR2hBdVF6LzVWOENhOEF0anpySThtd1V2OXJKQ0dwRWVNQndP?=
 =?utf-8?B?TlVrVndLRFpUZGQ3cU5na3B6dEVESHdlaXVkRTNjaFpwUjhmS0xBR1ZtajYx?=
 =?utf-8?B?NXBPSUZpc1p5SDNYK1J3RmQrSnFBWExzYXh0d1o2S0d5UlpXT2NWNEgwUXNr?=
 =?utf-8?B?QVMvYWJkMzE1S1NKcTdJMk1RbzZuRmxNVXd2K3YwY3VsVm5ZVnZXR01TQzFy?=
 =?utf-8?B?TFV2cU1RTzNHSzZkUXp3SFhuVTlBME9hVUFEYmdzbEsrek4zOVBLVUxiaW5P?=
 =?utf-8?B?MmhkbVBZRDJrQ0x3bTV1aTNCZjZPWXRwbjBlenRoTTkwOWJDNVUzMFdkV0VI?=
 =?utf-8?B?NDF6UUpleUhTbzlYaUdjVnF5MjVyc1N5RGFYU3IvMnVpMVJ1UEFmR1RmUWpV?=
 =?utf-8?Q?4R6R3iFrGyzKMDXc7hSU0McpDx+XPs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnNDQVlYSzdHcU1ZRkM2djMwRkJzTk4rc1JPQVJaeTN1SE1SeGdNcFV4RDNk?=
 =?utf-8?B?STNIQjB2Vnh0SFZzRWlOdFRwMnpLMnpjeGc4MkRUbHFQRHJ5RnBMb2p4cmlu?=
 =?utf-8?B?MVpoWENOcGJlNXN6M3Q5TURidjd4WHBXbG1nZkZlMlFlcVFCMTBnMjMyTXNH?=
 =?utf-8?B?SkZKRFNISVJ1NEI3MXo3YXZPZUtxUkNZamw2eFBjVGNsaUNLektGSk5aSEJm?=
 =?utf-8?B?TTd6RDF4VWFnMUFRVE1icytkcHZQN29SRndxZEFXd25sc2ZYak1kVzdZL2VH?=
 =?utf-8?B?RFJlUE9DZnMzZ2xyT0IwL1Y3dHVrclhDRTR6N2dNU00rQnNaWmhaL0lHT2tK?=
 =?utf-8?B?WVhRNDR1ajJTcnhKZ2s4N1lVbS9xNzA4UWdtMS9xK2R6WUc1emVwdnl1NEtl?=
 =?utf-8?B?Y2llQ3RITU9zU0EyZVZyN2NMUTRzQytiZlBsZGZYMDFlMjJpT0VDYVVTQzNi?=
 =?utf-8?B?OUZWNmxrQitSOURzTGVDTHVKdlFjVnVudTR3dUF4bVlBcVpQZUZaaFN0cFYz?=
 =?utf-8?B?N1d4K2tZTDRHMzJSS1hJUlFQMmYzdUdjL2RGclZ3cElEY1MvZE84VVVWRjYv?=
 =?utf-8?B?Q09VUFZPRXlCUXNBZk5kZzhNVHJoUTIwUlI5aW83MjNzVU4zZWg2RlJpWjZK?=
 =?utf-8?B?MkZJcnN6U2tvWkVXdUd4cVJmc083UFhCSXBGNnNSTXVLQVVmN1NoQjQyWkpv?=
 =?utf-8?B?cGJZalJhaXRWMmJyejUrYmxTTVhvM0RpL0xmb3VBYVRKem9BN25QbGRYQ0pl?=
 =?utf-8?B?UFFUMjVPOTRXcVc2OHdQVTJuUlAyYW54c29OTVdPM0pnQlVxblZ2V3h0T1JN?=
 =?utf-8?B?WWYxSmFndERwc0tmczVWakNTdHVZQjlhVzNEYzZUcCtsRFptbTRtQ2hIS1Zz?=
 =?utf-8?B?ZGpnYzVJaUwzcHZVbUhBU1BYT054SHhZQ3pkK3V1VE9oNHVpeVJxajQ5TVNn?=
 =?utf-8?B?c3JwT0pOY0FibTdjdU1NaWJLNElndWNqRzlwYks0RUt1ZDU1M3kxUlRlZWxr?=
 =?utf-8?B?ejBTaUhvbjhUNlN5N1pZRjliYTUrKzVmaFN0eWpmWmpKR3cyYzBwQmRGY3gy?=
 =?utf-8?B?Z2RYV3MvRDVhTUFhWVdQWTNFQ0ZDTXpqYW9mdmJ6a3RYeDlZd242Y0l6U1A0?=
 =?utf-8?B?TElKcTBmNFB3Tm41WGhnR1J5TzlPQ3pmTnRCZTBMR2NJdE1uNTJOVHBTV0tv?=
 =?utf-8?B?M2Q3VjNOQmNXTk1Gb0tRNm5Uc3pOZWdCczdrOUczRm8vV0pvUVNFTWxGTUZU?=
 =?utf-8?B?TUszOEpiMnJkbWVNMTNiT3JSNWg2TGgwdEpSREZUaFpVdHpIZ1g2Q0VLdm1F?=
 =?utf-8?B?SlZDbVErcFp4S2ZuanZvNW5CWUZoVzZ6dC9hU3RnU3FhNXdZNWRwRzFyTmh5?=
 =?utf-8?B?Z0llSjNlRjVqeExkZmtBeVcyWHdhYS9SbHpSMEVKcDYrOVQ2a2VLUDdLdkdj?=
 =?utf-8?B?aDErL0NzMkdyWG5vdm93ZTd2WHNEbDdOR1RYQlZyNGZFTlRLSjN3STNNVkR3?=
 =?utf-8?B?V3lKdlhUNWh3RTBGTHBWWnNrNHZrcXVyNUtua0tRRlNucGxZcUdyUXE4RURT?=
 =?utf-8?B?cjBWaHE0eUVHV2JrTkQyNDZOeDQ0WmFEL2xmUEF2T1ZOeTRsUkdoWnh2THY1?=
 =?utf-8?B?VFNPeVJ6Y1ZuWXZxYW1ucE5vSElIbXJvc3pPeU81VnhON1NXSlVsNXFlOFlG?=
 =?utf-8?B?TnE0VGFiT3dqd2ZyTktLeFQ3U2NIK0daaFBONFZOaCtjUDViWjRvNzh1SUlh?=
 =?utf-8?B?WFpJYWZDY0xwNWlXYzYyRUNHNTBOQktmMjZ5TVhpdERoSU5ZeXlxZHJPVXBQ?=
 =?utf-8?B?UktqdWx5OEZoWHpqb3JRNlRuN2pyZVNIbjZZR3l4UFRNaDRuUEFJNjdvR3BT?=
 =?utf-8?B?M2t0VFVNTUNTTGZrcjJuSVFoQzBpOUQ1TitGS2w1Z1A4dWdSaUptVE1lYUYw?=
 =?utf-8?B?dlIwRHVaVmlWeCtIZW95TkhQYm1mcDFyUVhIdEFEMXZQRDR5Qi9JVWxUeWZu?=
 =?utf-8?B?WGtXU0h0MmwvcndKRjFaZThhc2Y5TkY0T0pKdVNCYXdWUjkvQU1pVXQrZHBs?=
 =?utf-8?B?eXJuR0pCdXdINFREeXQyZ29veEFvWG0wK2c4b0l3U1JhMC90SzdBd1o1MWVL?=
 =?utf-8?B?SkMycEFaZFlFT0hiN0pnY0xuN29kVkhBa1hwRmhCTmlobUdKNExKcjlENUM0?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F776BD1C7E3F9843B601E1CBE3B8C438@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bqmwm1NTP8nNC58GVBPv/F+ZyvF4FLjF2lrkWsClz34m71TwRsSgCnUPi8L9ews6sfXjmtBhKyu0AuTW9f+PUPekH8hWIeYMN66AKi7B85P4NQcBtGFExIV44jbr0J5k1+nEdW/nbI3OhWYbKMNB8ZRh4qRsqMVkoojr+26QzYE1crp9WFcSjdkza7BNRykWDzCpfWbsLFVEKBK8RUg1oyyxfgMbWRGKp/vKhbs80sUekPOJfN8FW02Lu5ArXpKKddogkyslSWkn7p4PvSX92bNk3Jq+CAcqRbXbEVSQM+Y4XXXVNpW7z4s/W6EuAH9snn7WTuwWXy7Lz78nHO7zV4vZn7aQ/0GGbpiog7HQv3ZzaCz6+vVaI8MGtk/Ylx/gO1Ty0n3lvs+LaHwFFCutfUhqK3BrHgkJPTPGmbwwjKk/mt3VEzhAhDaq23LEzqXso+6WmXJTtpIGQUvAXrWiFdi+KdVWSd1afzE6xl87RSD+LhR/leH6dzt8LSbBWtqaqHhMQbO83mnmjydF1be82ZnAWRNLtmzKajz0K0WpM6OYionZIni30jCS124FzP689uvGsqZdxX74M8V7mfqmblnazWKu7QaS4neGB5Y8CYVuW0RyMO7c/Zjr10x9iJtG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8439d028-aee5-4a55-1ee0-08ddb3d57bf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 10:46:04.4761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UWw5N9JRDa8IbFG7q2pBkPrhIP4VTH36+UZew5uxb5HiOk9jEhNit7pE9gM/ttc/cJrqRV1tjWXvg3CQ3mc7fX6Zx+hUM8ExgbLx76XyjGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8311

TWFrZXMgc2Vuc2UsDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50
aHVtc2hpcm5Ad2RjLmNvbT4NCg==


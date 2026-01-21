Return-Path: <linux-btrfs+bounces-20860-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOTMOBgjcWl8eQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20860-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 20:03:52 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F30E5BC30
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 20:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D0FA82B384
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 17:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754F63D3CFC;
	Wed, 21 Jan 2026 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oA1UEbcj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PyVigQhV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F81A36C582
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014919; cv=fail; b=U1XM0w+UVg4PbvwvbTFQ23Sj+vaH/Pv7MsAfsxRllDlPCY3a3qIxPaxtUNVXqv/Sp54M6kRDDMmd/iikJJ04z+uD93A+0KlM9Qkpn0BelUgcuOKeeEap8U7sCPYsOHDVdhTyxg/eQhfQ7iPKuvbUCtWE2FJaffa5wDicjMFZpOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014919; c=relaxed/simple;
	bh=1/TTZRfIZ/pB5O3mqZtj2DVyUlwoMNo4sQfcDp0Bp0U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QZgLqFmQTrrTCKpPr/rSIsZejNo4axjJu2SoceF9GgmCnfsOtu18KQzbZ3PpzJeTQq9isgbeVJkuU80eqJvg9ji//AG8xegpCmdmgoRHOP/lENzBOPP/ziwiv26oNXthq6mT1vFB4bfHO4nOIm8f+fnoxppDPKrUdRAnVfvTzTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oA1UEbcj; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=PyVigQhV; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769014917; x=1800550917;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1/TTZRfIZ/pB5O3mqZtj2DVyUlwoMNo4sQfcDp0Bp0U=;
  b=oA1UEbcj9VESm/zm/+u7VrEdOcnceUIgmSDphs7h3JrGvVc8QpFqDcCn
   W5GsHGdmO5UhFMNggWc5Pn36wNOAaULso/Qom+8S/XShDpuOarAZjCAr8
   stAyPEAau8BBFgyzoSnrTUmzt4NB6s1gx+VTTCrHnHqTr9fSKPu8rJFUb
   8f4bMEAa7aVIBQaN4DGa0ReUPlQrv1Y8GcWID8x8XdG8NVyafniuWL4dN
   p25wepL9qRxdTtUWkh63QCO2gx/+4kLIUWwPD6O5A32xTvZK4+gNfLidd
   1fHobq4Rb6te7hLcxbj1s4MBmkE12tS818hQlYfhR/qJmQxv51RqVqonL
   A==;
X-CSE-ConnectionGUID: vJ/lSGMcSDiAv0vl4p3nDQ==
X-CSE-MsgGUID: BgBnFdeJQhS/Ec7w60GJSg==
X-IronPort-AV: E=Sophos;i="6.21,242,1763395200"; 
   d="scan'208";a="140392653"
Received: from mail-westusazon11010009.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.9])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2026 01:01:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJfQi26YscTIGRKO7jvmIb2zn/BIPIfeEoSrkxgbth9+btiS5nBlFgQAvd+Kja5r36yY1/Umkz+VgyAwiQX4q9NO+7fe+VX6LAJWuYJx47Z3gebkfAkC2kkHSxWoTDf7jIGdtLXeEQ0W+fVef0cnTmWCMtyv1EKaRBc+MaW7NhppCYDjmqtmXcpfPXD5YLD3HJctLiNSWts+lj4RbwtSkQKT9RCUFGqxpRz6kyij6Cg+Wacw2NzR6AKCdfn3PFoBKNSstcrO3o6g+/wwpdXyI1XCOtZmq0H52mrUp5tNgPeuUM2hP23iuFFqK4npuyeC3E5RVJ4kFatkmYNu1BlA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/TTZRfIZ/pB5O3mqZtj2DVyUlwoMNo4sQfcDp0Bp0U=;
 b=OBMQWe+tC66U3iKyS9Ru/ejHtmVOgZcNfGWQBOZbwz9XN9t1msWPOm3EX4w5GbLFMF9ElOjkbMO9aCAIKQ+YnSdLbZPT14OSbPc6sfBxDgjN2YtU1u9BtjMjg1WfdQnb8SYoVMahcKikhOgBgYe8iWjEwCRjWQ7urH4Wa+u52Wvmw7SYyjJJPsoO9sTO8sj6gf7h2r9ahFt8PJ8uwCAPtb1SZN2BrnEyD/pU4deHrBQVjs8XnTVSbu6eIv//nSNbb4LI/z/6liBu3WxAg9okSyPQHrToL8mKyoNDoyRpq4Kx/i2ee9c0IzczAyU2JAQ+FT27JzPpJiNkcb9DlxQDNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/TTZRfIZ/pB5O3mqZtj2DVyUlwoMNo4sQfcDp0Bp0U=;
 b=PyVigQhV5LPWHyQRjMoSa+MCOcmx0nsyt+IDtYaWSeu1i8fjCsU0C37wOKyQ0uAdI2RKp/fX6dSxXUigxW+YMeGUTlSaM6q3Ll8LMtpBJQEVEd2Q/SePG+LJjac3DpGDE7nHfvAjGxbkqNsbBRbMnazI1cBBmMFr8fM7bdbNFrc=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by PH0PR04MB7240.namprd04.prod.outlook.com (2603:10b6:510:17::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.3; Wed, 21 Jan
 2026 17:01:49 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 17:01:48 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/19] btrfs: remove pointless out labels from send.c
Thread-Topic: [PATCH 03/19] btrfs: remove pointless out labels from send.c
Thread-Index: AQHciskGPL/DjALwr0q/TJRihaUt67VcuNqAgAAFZ4CAABtvAA==
Date: Wed, 21 Jan 2026 17:01:48 +0000
Message-ID: <26a0886a-9ded-4723-8550-576d2d87e5c7@wdc.com>
References: <cover.1768993725.git.fdmanana@suse.com>
 <9684a687dd031bdc506fd15472be9356369a163c.1768993725.git.fdmanana@suse.com>
 <82b91a4e-095d-4a3e-bb66-a046f3d332f5@wdc.com>
 <CAL3q7H4fvdyKJbwN-FWM-2FHYKNFsUkX9dBdvLV2fJ_USTePrg@mail.gmail.com>
In-Reply-To:
 <CAL3q7H4fvdyKJbwN-FWM-2FHYKNFsUkX9dBdvLV2fJ_USTePrg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|PH0PR04MB7240:EE_
x-ms-office365-filtering-correlation-id: e1dec0a1-f136-466f-72d6-08de590ec42f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|10070799003|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MTAxYlY2RldMRzV6ZjA4L1hpK1VwWWdkby9ycmlXMEdIZS9aMG1adnU3MHBL?=
 =?utf-8?B?TGZBdFRtRS9vY2lhLzhBL1A5bUNOaFhKd2JaZUlVUzYxWmVNdnF4OTc4U3Jm?=
 =?utf-8?B?VlYxeE95ZGFjTFZaZWZXbUJpdGRTZW9oVllocWRnV00rWjlIQUFRTUNCNXFo?=
 =?utf-8?B?bUJSbXZYeENpVnZlYXNpcVRBRmlTZzM3U2Jkc0psT2w0cHVFa3BvYW9zdjBv?=
 =?utf-8?B?MzF5MnErN0FjSitUc1VVcExCVHJ0L294TmdoMXlzNU5rbCsxd3pEamNlcEQ1?=
 =?utf-8?B?TmdBbk5tSStvOXpjV2NuK1pyMUI3S1pCL0I0TVZReEhPdkVZbnM2Nncvdm5v?=
 =?utf-8?B?MDRSd201dzI5amN1YzVMYW1BM01qbTh2a3ltSUlXMkZVT001QURWVHJXVHUx?=
 =?utf-8?B?Yjlza1pJeVQvZSsvS1hCcVhodSsrek1PRDlBSHZNQnNLRXJnUGg4YzJJaTh0?=
 =?utf-8?B?WWRDcnNQZ09qa21ZRDNWd1pRRFY0SVhaK04xeGIyaUxIMDRRTDdUYmtnQmlL?=
 =?utf-8?B?bGtibFVIOUYremVaOTRtVjY4a0ppN2Y5a3dBWGNNODA0L3hNa1RhTnI5cFZk?=
 =?utf-8?B?MXJPUWxYMGF0MGdlNEVadm55Nm5UQkZXdCtRWmptRkZzY1BqN2JpNmpIY0Ir?=
 =?utf-8?B?dHN5UDd0ak9IVkJhS251SkI0VEFvcTJRQnFvdWY2Zlcxb1pPc3NZa2xEb2Y3?=
 =?utf-8?B?cHRYRUZOcGl4SzNlUEJaWXFOUnNyQ0x1MTJDZlV5NUp2OHVxWTZ0TzFRSnVN?=
 =?utf-8?B?MTlGQzFSdzdFYVFUdVA1U0ZubEx3UUVNNGg4R01sSHg1OU1TcnBuSGUyUU56?=
 =?utf-8?B?OGZrVTZSbE1FMkRPKy9xUlhabDlnMTloMFM2YjU5eGZocUNPRThEME9IRWNx?=
 =?utf-8?B?dEM5YzNoWkJjQk1yYzZxSlBudGF2SU5rb2hjNjRjVlZhejM3bE0vZWdZNXpv?=
 =?utf-8?B?V05ETHMvMkVicWVNRHIwRlQyby90eW8wUWQzb2hqZkZ5aHBQTkxUU0R2MHhw?=
 =?utf-8?B?QkE1TDk3ZGs0RTR4SExmWUVoTzloRXN3WGp2M0tuUUg4K0xYWmxaYUF5aCt3?=
 =?utf-8?B?OHltenoxWVhUTnRlVEs2VEhhOWFMdDNoenl4aXVoRU5VY1IvUk5Oc2F6V1gw?=
 =?utf-8?B?SHROL21veUxvZCtlVG5UTGlNaFVTMmxtY3l6b0lwZXNVYmswQzJscThyOFor?=
 =?utf-8?B?WlAwUjdiRVhMNWxzd2xDWXFXKytIbnJ6VGsxWU9hczNYbXBnVzhCN0N3QmI0?=
 =?utf-8?B?ZWhiZHdBelk1THg3clhEdDZyRUppZVZGYldQeVNGdmIvbzZtYmNZdWx2YTJO?=
 =?utf-8?B?U1JiMVNJN05oUkdJNDJaWld4WldTdWhWeW9nTkxYdWtKN3oyaEhpdEJDdzR1?=
 =?utf-8?B?SDdZbjJDdmFHbUw4aCtKOHVZVzEvaWVDUHN2RngzMlNZWXIrdGRQeHdmZTU4?=
 =?utf-8?B?TTdUWWNTQ2YzVHFYSkJCTFVrdW5iWmFweC8venFUeW9tQzNYT09Ua1h5ZG5O?=
 =?utf-8?B?aWZ3Vm1BOFR5OGNISVg0UmppSE9XMzFLOVJIQ3Njc2xja1cxcXppb1hSWmtL?=
 =?utf-8?B?WGR3VEM5dHEyWldUZ0NJYlhDK0J4OTYzU1g4SVNJMmRLN1N0Ui9pd2JvZ1Js?=
 =?utf-8?B?NHgxVXN5N1pBTU5pZFJkTVhiSmFVVHFyb0hudXVTTUVRNWNkL2lyRng5OFA3?=
 =?utf-8?B?S3A5ZFBYWlZjVzBBa0FOOEhmdEZJWUNDT1E4eHhhNG5SUVhZYzZxaU9ibzZw?=
 =?utf-8?B?MVd3MXplRlc0cStBRmM3Z0lJRHV5amN4OUpXU3hnVXRBVWpDZDRRL1lsSWJB?=
 =?utf-8?B?dHlZUDNaM3pXWi90RXRLZWdYaUJXZmJwbkJDUi91TW5DcHNqYWMybmlreVNH?=
 =?utf-8?B?bUtTdm9KSW5RN1FUN0hOMmo0OWRCRUh2YmJ2cDFwT2pNN0pBRlg5RXJuQnRa?=
 =?utf-8?B?ZlVHZ1U1QUhma29nNUVkemJ3VklNUE9xUkFNMlNJYmdFS04vLzRJejVIZEtY?=
 =?utf-8?B?OHZ4MmhSZjA2MGV5T29QTHpXRlM2MUozc012V1ZWOVl0d1MyUFBLRGpPUWxk?=
 =?utf-8?B?QjEvTzBTUUd5VG1iMmU1U1pRYlBFT2pGQlpOcEtTTk56ZlNTZkkzUHBwUWMr?=
 =?utf-8?B?RTgxSkFManpIWWFSMzJjV2kvcmlJY1JabHFxVGM3bVZWa2tpc0duaVg4VkI1?=
 =?utf-8?Q?8c5INRMSnhAdtAKTz445+4o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(10070799003)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eTlzK1haKzFqZ1ZzWVJRQkw0NS9mTUNsWGxjSEVybEtKbm1QOHUrWWZDTHFB?=
 =?utf-8?B?SzBwSjkwVDV1NXM5UERPK2N3aUpISTRZRzVCVkVRbC9Iend6TjI0NnhVYjBz?=
 =?utf-8?B?OHlVQ1cxOTBQazAwN2pLNGdISCt2M0tFN293bm9TN1lITlQ4a2hYQXBTRnpZ?=
 =?utf-8?B?S25waEpMdURSVzBvc0p0aWo2YnIyRGhyaVE4QUNTdzJmT2lRTXhSODdjdDUw?=
 =?utf-8?B?Rnpjc2wwMUl2OEhkYnd2Rm93Y2c0Z1RSSSt0YkMwdGM4L1VtNWNmNitKSmpx?=
 =?utf-8?B?SjZlQWJ0MWtkL01hWU93Y21nUEZBVWVEUUgxTnp3bFZRNmdVWmRZc1FlNUs0?=
 =?utf-8?B?ZFZCQ1hjNm8rN3lKYkswVFVwRDNpTkt4NHp1NHdMaEJXRDB0TkY1WFhkZlpn?=
 =?utf-8?B?d3ZqaGJqMlJCUWFnUTRVVW43dm11Tm9nWW5vTDd1cHc3eXRWZHFtSDA1ejlK?=
 =?utf-8?B?MzV2RjF5SEpBVHhQemJMMndadEtuVFBZZm5TWFhwcG4zaEJwM05ab000K1VE?=
 =?utf-8?B?WDNjdXBqdU84bHVudkxjVlV6U09HcFB2M1duazNnU1NtUng2dkZxaDJaM3hD?=
 =?utf-8?B?Q1QxdFNTY1l4cHp1VWRqbVJYYWg3OUFtVy9FLzc5Z1JrNVh3SE1UNzh5OXBK?=
 =?utf-8?B?RWY4cFZvWnAxbTlmZ05heHFWM3V2RWR2SUt6UlJDMkRqTDRJSTBNZUpvbEFD?=
 =?utf-8?B?OU5iYXh1NUxDQlZFQnZCUDlsZ0txZk15M0U5MzZxYW1vN25UTGp0QXFHVy9T?=
 =?utf-8?B?bjUrMStPMnc4ZzRUT3NnOGRDV3F5VmM4OU1td21BUVFFamxtNEVlbUc3bHJE?=
 =?utf-8?B?cWxsdjVhUnZ2RWZQejBra0U4aUpxSytqenR5YWFVWWxrVjQyemxBMW5Hdktl?=
 =?utf-8?B?QTVLSTJlMkVHL0dyZm9Ld2VIWjA3ZW9LY2VTTWovZ3lpRXl1MlhCOVhKTnQ5?=
 =?utf-8?B?NDl5UTlIbHF2VWpyV3NBRERQcHRKVjBYeHU4L1ZQNlBkNzdyTWdGVm5GbHNB?=
 =?utf-8?B?NkdjcG16dk1FazJxaVY2cVhYQkk4SDRwMHRRNC9rYXU5WHdvS2kzZVRNOFJ1?=
 =?utf-8?B?Sm5oMWEyVUlXeGJEMjJ1bGEva1VLRndIQ2dwc0o3bDVxVGxRcnFNYW9PaGlr?=
 =?utf-8?B?OER6NTdjbmN3RTU5cU5KNHVJbzh0ZXpHYTZvY1VWbWhOU1NkNVBsRGJmTnV5?=
 =?utf-8?B?UTRROW9ac29Yb2NDdENaZHhzS0hvaXhoRllhMG1qNi9oZFZiWWFHcHIxYnN3?=
 =?utf-8?B?RU1CNlZvWUlSU1F3aTVuZThZVGsyWW5VN0xJM2dZRm5DdjRPMURRbFRBWVN4?=
 =?utf-8?B?UWJyTjRkUUpNbDJ1THJLUHpiQjZ6N3UxZG9URCtjWDY0NTd3ZXR6MEIwK2xz?=
 =?utf-8?B?ZzRRT0xlUVBiYTM4ckhIc2k5UFJhV2pBMVo4N1ZTWkxkd0pvMldKU0Zvczlj?=
 =?utf-8?B?a0FIYnJvbXdyT0syQWcycWZsNkRBaWhuR3d1SFl2NWN2MGxnQzBWL3hLbFlG?=
 =?utf-8?B?akFNSG8rWWtpKy9XYmdnazZIOFBIbjZoNmNZVzVNdjFiMXRJTVJQaGNCNWhF?=
 =?utf-8?B?OGhIbEhNdHp6dE9oMFlRa1Z1SGk3Y3RtV095SmxjUDFlUzJmNGJhMlNrVEpI?=
 =?utf-8?B?YVhpdTgyT2t2bGV3SmVieTJ2Wml0Y0VVdWlRRlhSM3dLUE1ISyszdTJwMjZw?=
 =?utf-8?B?NVZMZi96dVMveDhOdmgrRkJkVHJML2hOZkpGaEVOZkFuTXpSc3hjRzdGZFZL?=
 =?utf-8?B?djhSbXFmVytkaEV1elVmOTRiQzRZL1FocFJmSVU1bUp6Y0xXNGpNY1g4djNT?=
 =?utf-8?B?MUlYMndHSUR5THFtblUzbGplNzJuVUcrRXpjZXJEcGJYMlkzelNxUkpGbzNW?=
 =?utf-8?B?dzdhcmU5SE1henRUeFJCR2R5UWE3SnBDMFhUeWo0bXNSZTNpcWl1alVJUklq?=
 =?utf-8?B?UllhTnVKY2RmODFRdURkeFZPbzN5VUZJSnpEcGlNUWJ4UmRHZ0Q5bkx3MXBk?=
 =?utf-8?B?Slk2QVc4VGhwZDhjZTRjeDNiNmFQME56NlJEOVZ0Z0oxSjNQcGY2UGhhdTg2?=
 =?utf-8?B?cHF6eWgvVWI3bkd4djRKU2VtNkYwbkNya2pHZ0J2bWVQeWRwY2hESCtZcVpt?=
 =?utf-8?B?RDVzUmRUWkVjODNxeXluMHNwUENJMWJDTWpuQmM2VGF0TUVYVUtjZktIQk51?=
 =?utf-8?B?SEJKMjRJdDJyRHVKK0RzbCtRZVp6M0pXQTRwTzQvQko2Q29zb3U5OEtXMjVn?=
 =?utf-8?B?djNnUjArYng5UjlRblBWNGRHK0RDM3B2aUJacXN4S2NrejRSSmJ2WGFTRjVL?=
 =?utf-8?B?Z2VpZlBxT3pMV2lwcjY2eXNxSTk3NjdXVmxjQ0EzaE1pTDcrWTFoTVFFa01q?=
 =?utf-8?Q?pIZpwqdUOw2OV/8hzmvu28WyeY5kF2XfLyCKC8BDMjMcO?=
x-ms-exchange-antispam-messagedata-1: alEpxvDmoIxNge+dJKrjVMSQovNhnCcbONc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E85E3C2B4F699D47B5B49E3C18E8B08B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H5tj+pEDWp5CL7lxi4x9AHi1sBOUdJ/3PIGqRuP7buamNJ8mFtgXYO8KE1xCnr0Tv7bar1VLm46+jckccUNMXHEFsypvzWny9aZ6CdO3255L7KCTplziGZ9SRbvspAqEc/wvfccZhv5lo6q4v09cxWTI/45L1mBJRMI8+n/SSN95dvpjY8ODfmlE1NV03RKpF1XtoSyHKETcz5OJL9/dMXTi09bCgmbLCeZu8UKulO9j+AdN0TQON6x4ab/8xl6mN9ND+oEM+vKJYDdcv472lUipkHckaEvj9yRwpWjFzC/hq7DEO/wBjnAtoBcR+KOa+uWfc6DsyvAhooVoCPlbDrsL7orl12GsAFDn/VL0LsJs9u8h5VvcmGJWYM+xrJcp4kmzxVG7BfQQmaAhlj9H27JAU5z9A9q0dsn4YOXH/fA5JvqCbxAGflbd45Xc2QMjsv1u0KZ8e4nsyDhUUD9HW7bzdtnMzqZU8QnkqHEOlSARGaYKlHo0N35e24wcnmdDI9vMOpNHgFMR1vg9n3Yf/linpptWV2PGf3E5WJgY2JpUKP08GedqL9KTFNpBcXK5rLbGCvp+M5/NUq0PcpnyUluTvbQd1UaDKzrJqHc1acO2way4sUeYD82m2rPbh4An
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1dec0a1-f136-466f-72d6-08de590ec42f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 17:01:48.8351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hKMgUEi7irw9vDZQKOUKFLu66iBL6Ah2EKAa8daqtORmoIXZb1YU6QyNL7aP3Wx/rZ4BNsTJkEQQqRRvkdxrmffe1Lm9C2fC9D0tQtBLNJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7240
X-Spamd-Result: default: False [2.14 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[wdc.com : No valid SPF, DKIM not aligned (relaxed),quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20860-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	R_DKIM_REJECT(0.00)[wdc.com:s=dkim.wdc.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_MIXED(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:-,sharedspace.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 8F30E5BC30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gMS8yMS8yNiA0OjI0IFBNLCBGaWxpcGUgTWFuYW5hIHdyb3RlOg0KPiBPbiBXZWQsIEphbiAy
MSwgMjAyNiBhdCAzOjA04oCvUE0gSm9oYW5uZXMgVGh1bXNoaXJuDQo+IDxKb2hhbm5lcy5UaHVt
c2hpcm5Ad2RjLmNvbT4gd3JvdGU6DQo+PiBPbiAxLzIxLzI2IDEyOjI4IFBNLCBmZG1hbmFuYUBr
ZXJuZWwub3JnIHdyb3RlOg0KPj4+ICAgICAgICB3aGlsZSAoY3VyX29mZnNldCA8IGl0ZW1fc2l6
ZSkgew0KPj4+ICsgICAgICAgICAgICAgaW50IHJldDsNCj4+PiArDQo+Pj4gICAgICAgICAgICAg
ICAgZXh0cmVmID0gKHN0cnVjdCBidHJmc19pbm9kZV9leHRyZWYgKikocHRyICsNCj4+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjdXJfb2Zm
c2V0KTsNCj4+PiAgICAgICAgICAgICAgICBkaXJpZCA9IGJ0cmZzX2lub2RlX2V4dHJlZl9wYXJl
bnQobGVhZiwgZXh0cmVmKTsNCj4+PiBAQCAtNzEzMCw4ICs3MTIzLDcgQEAgc3RhdGljIGludCBj
b21wYXJlX3JlZnMoc3RydWN0IHNlbmRfY3R4ICpzY3R4LCBzdHJ1Y3QgYnRyZnNfcGF0aCAqcGF0
aCwNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPj4+ICAgICAgICAgICAgICAg
IGxhc3RfZGlyaWQgPSBkaXJpZDsNCj4+PiAgICAgICAgfQ0KPj4+IC1vdXQ6DQo+Pj4gLSAgICAg
cmV0dXJuIHJldDsNCj4+PiArICAgICByZXR1cm4gMDsNCj4+DQo+PiBEb2Vzbid0IHRoaXMgb21p
dCB0aGUgcmV0dXJuIGZyb20gZGlyX2NoYW5nZWQ/DQo+Pg0KPj4gICAgICAgd2hpbGUgKGN1cl9v
ZmZzZXQgPCBpdGVtX3NpemUpIHsNCj4+ICAgICAgICAgICBleHRyZWYgPSAoc3RydWN0IGJ0cmZz
X2lub2RlX2V4dHJlZiAqKShwdHIgKw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY3VyX29mZnNldCk7DQo+PiAgICAgICAgICAgZGlyaWQgPSBidHJmc19pbm9kZV9leHRyZWZf
cGFyZW50KGxlYWYsIGV4dHJlZik7DQo+PiAgICAgICAgICAgcmVmX25hbWVfbGVuID0gYnRyZnNf
aW5vZGVfZXh0cmVmX25hbWVfbGVuKGxlYWYsIGV4dHJlZik7DQo+PiAgICAgICAgICAgY3VyX29m
ZnNldCArPSByZWZfbmFtZV9sZW4gKyBzaXplb2YoKmV4dHJlZik7DQo+PiAgICAgICAgICAgaWYg
KGRpcmlkID09IGxhc3RfZGlyaWQpDQo+PiAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4gICAg
ICAgICAgIHJldCA9IGRpcl9jaGFuZ2VkKHNjdHgsIGRpcmlkKTsNCj4+ICAgICAgICAgICBpZiAo
cmV0KQ0KPj4gICAgICAgICAgICAgICBicmVhazsNCj4+ICAgICAgICAgICBsYXN0X2RpcmlkID0g
ZGlyaWQ7DQo+PiAgICAgICB9DQo+PiBvdXQ6DQo+PiAgICAgICByZXR1cm4gcmV0Ow0KPj4NCj4+
IElJVUlDIHdlIG5lZWQgdG8ga2VlcCAncmV0dXJuIHJldCcgaGVyZS4NCj4gVGhlIGludGVudGlv
biB3YXMgcmVhbGx5IHRvIHJldHVybiAwIGFuZCBpbnN0ZWFkIG9mIGJyZWFrIGRvIHJldHVybg0K
PiByZXQsIGJ1dCBJIGZvcmdvdCB0aGF0IGxhc3QgcGFydC4gV2lsbCBmaXggaW4gc2Vjb25kIHZl
cnNpb24uDQo+DQpPSywgSSdtIG5vdCBkb25lIHJldmlld2luZyB0aGUgc2VyaWVzIHRob3VnaCwg
YnV0IEknbGwgZG8gc28gdG9tb3Jyb3cgDQptb3JuaW5nLg0K


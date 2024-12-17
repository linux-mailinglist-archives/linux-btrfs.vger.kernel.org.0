Return-Path: <linux-btrfs+bounces-10473-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6611F9F4A6F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 12:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CBF18906CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 11:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90471F131B;
	Tue, 17 Dec 2024 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S62Uq+Xo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AqjdbMzz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2031DB527
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436644; cv=fail; b=tx0nYc7+E13qBQTlrDcfZvM3gh/7N1aRz9O+DalDcxD9XrkmDB2Jd1z5i9geoXCws4N9vjOpyzQcelbd5ZFUtS6srIGsOrYLUnQh7ukCZw0ijlTZC9OEZA2sJ9Bva2QEUEAa7ZFJhvQvego7AAfKXLFou1k9XHB077VDb8vDmig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436644; c=relaxed/simple;
	bh=NmYsPPgaGd60dfz0cThbRBYqzPwVUzwtyv7KMzuNCmU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xu+a9DAyejm46X+VTqC/JVqvZc5ILWkuNlwQ3VDREbuBEIe9RplvcCLEYl1iZxOVDXPPqjeP8j5UsIIf02RG+Ea6WuWq80tKYTrFMiCuz6CFU6bebPKAxCFqqoI6jrSdUbuKmbtoMFB1HO+dpBKneQ53U5Pw4XQ9AG76pEw8HX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=S62Uq+Xo; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=AqjdbMzz; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734436642; x=1765972642;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=NmYsPPgaGd60dfz0cThbRBYqzPwVUzwtyv7KMzuNCmU=;
  b=S62Uq+XoPFYsYfMLTAsttLOH7pBethmmkwAcEWAYMzRiWCiR1BieoczP
   AnzDAeYluBy6P0YvfBofofnJevK0ye3z2HJPeEkAdpAyP77m5hTiJw6LG
   yrJEWL4rE0HIANPvsVBsREDbVary1Up6U39NKYUsVJAJUCXlFWsY2qonb
   QzXf+U5iTjW2XE5ZuY09p0f5nkF/ikwCZroDAZQGoX+JvOJWb69iNVO5F
   tjpJYH+iCKlT/MapWWqgKnnYGNmNGcEaylyBEJoV7o1Aputq83Vb1nyw2
   Y0pwzyxfnFVJBI9I0sCg+CtYfJAatCDX/KG30wCO4+ukr9QUda2s3eam5
   w==;
X-CSE-ConnectionGUID: WnM9m2siQQqfGdmok/j6IA==
X-CSE-MsgGUID: EnUwy5wnQRO4HGrJHicR1Q==
X-IronPort-AV: E=Sophos;i="6.12,241,1728921600"; 
   d="scan'208";a="33876250"
Received: from mail-dm3nam02lp2049.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.49])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2024 19:57:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQIi1oPg0ixh+Jae50SQ8GG/LgjIVw0lKbaCFskUAb0mVv8t5YoqYEsm2eJ4W+XluzAYJ7KrZRhLZAa+aam57S8FNA/KYKopSjXuBm/IfEbTmhbZjpe+9umL7a/t8TOR1zkerm7zWshtQrC9LB9a5mlOh8ptG0PBO4hnOh9yV7JLAxzVGO0jY9FhYnkquB6+cal1dfEP+7hBJKJWtiY4M4dBeLL/1E6i6pBrBO/C1OAUN/2jUYv1NNAzkqlHG9P0mDFde3cbotfTrgVKBjwnckEKjA+hObvAoXaA8Bn0p3aR+UBXU1j8+r1bsp2HaYA+sEhbnESLsD2n95plup1yWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmYsPPgaGd60dfz0cThbRBYqzPwVUzwtyv7KMzuNCmU=;
 b=CBZ7tBT3goJmJqHvGobDd1xCsyW6BXhsdYeXd8SXn9qS2CKO4zxBBRy1NWAGE7BfOUt9Y4b7GXgwDR3OH5CY8N09TzT4hbUlT50fbfyMLrPtEES5nnWgwQsFynPNRIxRV2GosM6HxIe8cxpWsl2ScALqkq5L1hB8mlnYCdodt4l7Ni8tgBvK8yBs1uYJErTc0/GoV3LIcA2kIqLZew7pFuy6j4LYTJJwFhnlidcUD3zsGU87e6CisKB8tc/3k1IWQXQwqEk5LchwoM2nUJyUH0hgDnbdzb/zbkGf/vgbhqAoNTQhTYOzIlmNIVjNRru8vnJ5tQdUHexifQjHzybAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmYsPPgaGd60dfz0cThbRBYqzPwVUzwtyv7KMzuNCmU=;
 b=AqjdbMzzANazevmxE+Zi1Uo/1HLeUr1dIK/9VE0i7w6TQBH0yedaYbhhPiO4vRNIDs3a4IPk+wrNK2m82xPbwX/m3wVN+9Tvru7Ty/HYzD9P1ui1x9UaLd6y7q/r9VpHt1/HBKBAxo/PI63X5FJB/HpD450zP2O5HpKDRNkh7Xk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7405.namprd04.prod.outlook.com (2603:10b6:a03:295::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 11:57:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 11:57:19 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/9] btrfs: some header cleanups and move things around
Thread-Topic: [PATCH 0/9] btrfs: some header cleanups and move things around
Thread-Index: AQHbT96OFI2niSbEGU6M0UEBo7tuxrLqVeiA
Date: Tue, 17 Dec 2024 11:57:19 +0000
Message-ID: <de349da7-206d-47d2-b2f3-4e88f2795027@wdc.com>
References: <cover.1734368270.git.fdmanana@suse.com>
In-Reply-To: <cover.1734368270.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7405:EE_
x-ms-office365-filtering-correlation-id: b34a81b2-fe2c-44b7-86aa-08dd1e91f5c2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VDRCN1ZyamV0TDFOTDdHeGMvL1ErZTQ2djJ4YStkTDg2ZTFocnMxend0WEd5?=
 =?utf-8?B?eHJuQkVhSFhFQmd5N055MGFYZ0puOVQ4bS9ENXdBdk10N0N6emZyUGovNEFa?=
 =?utf-8?B?bUo3c3p3OTFaSE1JY0FhR1dwdGV5TDVSRzkwSHpxM1pNcFpjelYxbXFwVDdk?=
 =?utf-8?B?dUZEemkzRjZ3SHAwR1ovSXNuWHJEbEFBVUx3M2J4Q1llOFJQSFZOVUhXOXFU?=
 =?utf-8?B?L1BsbC8yWUh1VnBhcXVGM0xoNE9IVlBwTUd0bm14RVZPQjEzV0p0REN6L1VN?=
 =?utf-8?B?TFpvOUFKWkJNQnRPbUVpMVpZY2dvYWtkeVhhTW0zNWZ5WTIwamxkdlR0emR0?=
 =?utf-8?B?c2VwdldJN3oxZFcvWDA1MUlJdyt6OEdXVEVTRFRWN3ZvRW1BVE81NlczTTNN?=
 =?utf-8?B?UWVzank2VE0xaGtjZGRtNzBhdzFrM3FwZnU4Nm52SDVPdkNheHB6Z0wwcmts?=
 =?utf-8?B?Z3NJQ1ZjNlZpN0oyb2t4SFpodGhiUTdMQmdjTXhBeFpOenYzSzVkYWdROXgw?=
 =?utf-8?B?NXhuUkg3V2hPankwdU8yOTFNbkVCaDgvTHNGSzNCcW1ETlRIWUdWd01TbFdK?=
 =?utf-8?B?SnVwNGJ4VFIySE5HU0IzTXh2UlZJTjdUOEYzd3ErUUpBOEJPL2NnL3ZZT2lF?=
 =?utf-8?B?WmF2cnJNSVpQYmt6M1hLaXBOcXJaVDZEOU8wZXREcjMyRFMrOGJ1aWZRem5I?=
 =?utf-8?B?K0V1U2xUNlg5WFFqVmRHQW1aZWJ5VHE0c04vQ1U2dkpPVDdCdUlwY1AvaUha?=
 =?utf-8?B?S2RITm9NNzdtYWRHRkEwQjFIOG1TUFB5M0VJYWFqd3ZGam9oMzQ3Z3N5YnNz?=
 =?utf-8?B?c2ZzT2RIbHVib0JXMkJMWng4eHQ3SG9wQVhoTlJ6YmhOMGRoeks4djRHdzRQ?=
 =?utf-8?B?SXYxNjRadmlXQloweHE4bmJHMVNMekxWaFlaZW9NOEkrRENPbWZtNVpNOGVJ?=
 =?utf-8?B?ZzliWlQ4WHZlVUdiMmdaSjM0Zk9hQXVFMDNLUHR0SEZEeGlrVXptTXkzOXBM?=
 =?utf-8?B?YStjTm8zYytQVVVuWWJ4RHFCbzZ5Nlc0QklNeGZ5TTBlTUYxMmhNWUlQeTZk?=
 =?utf-8?B?RFFUaGdMTE1CeklTMWdxT21YM0FEdnVRdmJ3ZWJkZ0VLcnRXazFzM29XNzFI?=
 =?utf-8?B?WUlHY0JHU3dJbytZSVE1ZXJlTWwrK0dBand3UTF4NkZmQUxLMkY1S1hWZzZC?=
 =?utf-8?B?ZUVFYzgxQmNYekd4Qmk3Q0lpeHBsU1ROblhnQm1RdnhGNEI0eEFUVHF2U1NO?=
 =?utf-8?B?MGZSQis3aXZoVmx3Q2p6UGVFNVBSVHZBaFA3UXBxNGd1NE5abHIrRDNzL3RW?=
 =?utf-8?B?MVc1bDc2QVdFVit2b20zTTErMTJ4YUJZTGdFRU1BV052QWpudlNYUXhpUUNT?=
 =?utf-8?B?SzJKSkgxWWRWcFd5UjdmUndtaU02T1A5aTRKdEZpcG5mazhrNThrZldTazlj?=
 =?utf-8?B?bllEZ28rbXE0VGxoOFBNU0IwWnZWMFBRbHZ2NXkyK09zZXNyYnBzaFIza0Fo?=
 =?utf-8?B?ZzhSNGtta0JqNEwrNmxYV1RtNkxnb01EUE1CaGxpS0VvVmVqeXVjK3VMWmVZ?=
 =?utf-8?B?ZUNmS0Vha2hIY1BjVDJhM0FDbnNkTXc3ZkFtTEZaNFl0L1RlQ1hrdHRpN1ht?=
 =?utf-8?B?VWNFaElsTXpGbDZVMGtxdndRUzErb3lldVJqNi8zMGdZV3RJOUVoKzRXVjdY?=
 =?utf-8?B?VVptcHlvMVd4bVYvMS94TCtoM2l2WUtrd3JXbnpkQS9Eb0NzaHV2bjRuYllp?=
 =?utf-8?B?LzNhRmQ1QXdpTDBCcEZ4L1BPOGZ6QWdpZ1NWSDdmMjZEVmNCblJJSGw2Tkd0?=
 =?utf-8?B?bTROOEdUbjZaZGxZMlVxNERKOHYrRG5LNVV6ZFV2YXpCVGdmRzB3emQwMVBz?=
 =?utf-8?B?akV3MW9sWHhaaDc1U3M1SnNTVklUMkNlbnJ3a015OEhIVjdtV3lqSWk2Y2N2?=
 =?utf-8?Q?AVtV2gLkb66Hvn/jR02gFFSkjyhmIVYj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a01EZUpDWnpEVG9ST0pYTTV2U3U0VWdNSlh0ZmdOTFN6V1FMQzVRYzZ1Q3Bh?=
 =?utf-8?B?SXBQbkhzS0t5TTk5b1dJSi9wZ3QraHVLMjI2NndOWkhJSndLY2RtMGR1TUpH?=
 =?utf-8?B?elcxaDRvaFZHMmFDUFU5N2FmRTZXRHFxdURlZ3dueS8ybCtnSGtkUjRYVWRr?=
 =?utf-8?B?UjhZVFFQQUY3NCtGV2syUmZQSmNUZDVlTE9lQzRBYTIyREZYenJxcm1NTDBs?=
 =?utf-8?B?WjdORnRuSFNVUkFnczVHcXJKU202RURuVTNBT3BWVEZRVGk0YlRFTEVvekwr?=
 =?utf-8?B?RTNKekJrakFUVmcwd1JwOGlONXRPWXV6TXAxeXlvRzBrUGFIMkVtbWVpVWRX?=
 =?utf-8?B?S0hLcjdnN1lZK3dWMmlJbVE0WVczeXoxSkVMUTZDcm5CQzVBQXJVVU9INUxh?=
 =?utf-8?B?eDlLT25uazhaZnVNWk1GcjlCQnRpeEg5OVZQemRvQ1h1V1RSWWZxYmxWRWFP?=
 =?utf-8?B?d3N1OXdaQkF3RkhjeGlLQUFIQUZsTHdzVDVHU3dBdlZ1dHRzL1o3M3l1Y214?=
 =?utf-8?B?WnJiUktVUVo0d1BTa0FGZzJrVW1kZFFXaGpzK21XRStrL0crY0VhMVhPeHU5?=
 =?utf-8?B?aTBjRHBsV3hld1l3bk9pZXFSK1ZBT2lPL1pVeTlIK0RwS3Rma0JCcFh3VUNG?=
 =?utf-8?B?cU5lTXZJcmNPdmxtNmIyeThDRzdYZ29NSnFROHBiSkdDS3NkWk80MXhUaXFr?=
 =?utf-8?B?WnVuaElTOEw0SEsrcUxJM0d1YW9sMVpCMDdySzN6am0wLzRLQmNNZVdKTXVG?=
 =?utf-8?B?RTgxRUQ4dEVzc0Nsb1pGNDhvdldkcng2TG5pdWtwZndDdHpBVnZoY3ZOS2Vr?=
 =?utf-8?B?NXFlbHlwcXpka1dIYlFaQ2lWVDNQTG1HODNkNnQwMFR4TVNrcUxDUXVtOHYz?=
 =?utf-8?B?ckQ3U1B4eHc1TmpIRk51R3hDbWFJTWR1VVRLVFFNU2xqMWtVVms4amZhUWZL?=
 =?utf-8?B?dlQwcWVWUlM5YjZhWU16ajFxSSs2OE8rSnRDNndPbHBIVFVTOXVyems2OTZm?=
 =?utf-8?B?enBDRlVpQis2SEx2d1ROUWdxVmhoZG5LeUFUaDhvR1ZFQzkrL1k3emlzam5Z?=
 =?utf-8?B?R0JIUXVWZ2JMOC9odGp5U2oxcWY2Qk9uN0RXa3lJZjZONWludFRLdmVvemcr?=
 =?utf-8?B?YjB4M3BaV1hRbm43UFc3WUxiQWFrTVVOUVBqMkFFZS9YZWk2Rk42MzZOaWJQ?=
 =?utf-8?B?b2kvT1owNG5wWlppb29IWFFaK0h6NEZyWXN5MUVqN1ozZVlCWDYyWkRaRkVK?=
 =?utf-8?B?MXVoTmZtTEc5MGc2bndRVkh3OUZ1d254cWRMK0EzalE2akZOcmxob1NNRFBR?=
 =?utf-8?B?S3R2UmNqUXhSVG4rRkUrV01uVzVoN3BlNENtN1RXcXNheGhhdjJsNGg5UEFC?=
 =?utf-8?B?czFZaHFEd0RuOVg2ajRQS3picXd0VEI1ejhwUDcrM2xhMTBlQy9uSmkzeHc3?=
 =?utf-8?B?VE51N2lKYml1UnptZkw3SHdzd2hLdmJaUGxIK3N4bDRva3h4bTYzaTIrdW94?=
 =?utf-8?B?N0MyN0hYZmNnWjZ0T3FpOGlGRVVHZmRCN2dmV29DSFNPRGxiTG5iWVY0VXpB?=
 =?utf-8?B?UU5Ga2t0UmtabjdPeU9UQVlkYzFEaTFoaEZkY3FHUS9zRHNqTzhZczdxZUxh?=
 =?utf-8?B?Yy9reXExRkV6MHd5MUdFbnk2Z0dqaXFKQThDUzNMSW5vTWlveXYxbll0Mm5J?=
 =?utf-8?B?OXFuTTV4aEJsdFByRlcvaVN1UXFnSGMwZ2xjd09HT0YwVFdrVnlNRnUvbWlB?=
 =?utf-8?B?YWVxZTlITHdGdThKK24zdm01c2wweDlGeTFXZWVtTCs2K2syNmd0ZzVOOWpo?=
 =?utf-8?B?dWMvSFJZbTlTcWQrcFpFK1plSCtvOC9zeVdBbXRWZEVRTSs4b0h0Sk5UZ3Br?=
 =?utf-8?B?NHVoK01MbXBBQUVGQjYvdXlNVzdsOHg1VWdqMUtuUUZnRno3eHdiSHZHNkcz?=
 =?utf-8?B?M1NFTC82Qkd5bmFGUVhFd0dzL25iVXh0K3kvWU9sYnV5R3J4UnBvS2NvSVV3?=
 =?utf-8?B?WVhTTHdNOW96OTRFZGM4MXU4VTZ1aFlNYXZaUHVLUjYwcDdIOENZMGxsL0Jt?=
 =?utf-8?B?ZXlMK2grMzNpS1dURmJNNm9FNnEvVkM4dzBaT1JlOWRlYWlmeGNmQzh3Qk1X?=
 =?utf-8?B?ZkorT2V3NElZcFJPQVFLcWxOWnN4Mi9ZVzFUWWkzMGxmTUkyVmJoN3E3bWZa?=
 =?utf-8?B?a1NhYWtDRnpxM01vRit0KzJSN1pETnFWNG8yVnBvek9UcVAvL1YzOTEyUyts?=
 =?utf-8?B?OFpIbEZiOUJnNFd6M2VCNm9ZREhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55ACA2FF70BC2E4CA4F132EBA250E793@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RPKL1ykE1urXHGLGfu0NwoIDIkpQtLkMpyd9qLnyQzUapNN/w2bwxS9QE9ui+3VM9h+UB2tsKMgkOcLWAVYXq+xZZiRiROQrmwbcbJgxsnkdiceNJgRM4BTCLz9MBrrywCWpBDqhGSmO4Fs513kCbE2/KTWzcLPoV8dWH8aqphaCyamZSL9yogqByil0ege1ooDw9QPDY/xt+IuMXMgmRLBcfUOv2WQyRX3MnNPsYZdds/VGskWbfrnmgT3eTaX9SF2RDiRhRiZ4rqmxI1zHyPB+rOrsdlG+bSNk3sLAaYRue3nwDbnwF2l1lgiYGwhhbNZGx6wnGIAMdeVhgcJcs9Rb/OwwPZxdWbmXzd0qgI3csgjYZUfcRdR41gyraXT5Bii5YG78eGFbmzm8AOiwHjxcSz9JE0os3SEPxVDsDgumC6HtD65tv+kaWB7a0nsDQ2ERScDYmP+9X9kKmcs3/5Kq6TbWtUEtnzgi8EVM0UIImyrPKW1HElqdQs3AePEl/FIKDKKLaNFcWXIs2ycuCWdOXFRR4vAVCek6a62Mv1G+B6TepTSQNVYiZncjyBcE84eolDgVIIJSHbs1UGyaRJpqdIqxXaYisFYOI2GwSZ4CtwQI/MAOqZ+R0cdgWXGy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34a81b2-fe2c-44b7-86aa-08dd1e91f5c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 11:57:19.8300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l93ErGAr2+xbSxKuDQCFCbcf1dWyVCavjmorqDL3H5/wIxi9y6y/t0vibmXokxxrVnsMpxjCSh6bxZCwquoZWP4M22FtYK4xg7JHNat3Y8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7405

T24gMTYuMTIuMjQgMTg6MTgsIGZkbWFuYW5hQGtlcm5lbC5vcmcgd3JvdGU6DQo+IEZyb206IEZp
bGlwZSBNYW5hbmEgPGZkbWFuYW5hQHN1c2UuY29tPg0KPiANCj4gTW92ZSBzb21lIG1pc3BsYWNl
ZCBwcm90b3R5cGVzLCBtYWNyb3MgYW5kIGZ1bmN0aW9ucyBhcm91bmQgYW5kIHNvbWUNCj4gaGVh
ZGVyIGNsZWFudXBzLiBUcml2aWFsIGNoYW5nZXMsIGRldGFpbHMgaW4gdGhlIGNoYW5nZSBsb2dz
Lg0KPiANCj4gRmlsaXBlIE1hbmFuYSAoOSk6DQo+ICAgIGJ0cmZzOiBtb3ZlIGFib3J0X3Nob3Vs
ZF9wcmludF9zdGFjaygpIHRvIHRyYW5zYWN0aW9uLmgNCj4gICAgYnRyZnM6IG1vdmUgY3N1bSBy
ZWxhdGVkIGZ1bmN0aW9ucyBmcm9tIGN0cmVlLmMgaW50byBmcy5jDQo+ICAgIGJ0cmZzOiBtb3Zl
IHRoZSBleGNsdXNpdmUgb3BlcmF0aW9uIGZ1bmN0aW9ucyBpbnRvIGZzLmMNCj4gICAgYnRyZnM6
IG1vdmUgYnRyZnNfaXNfZW1wdHlfdXVpZCgpIGZyb20gaW9jdGwuYyBpbnRvIGZzLmMNCj4gICAg
YnRyZnM6IG1vdmUgdGhlIGZvbGlvIG9yZGVyZWQgaGVscGVycyBmcm9tIGN0cmVlLmggaW50byBm
cy5oDQo+ICAgIGJ0cmZzOiBtb3ZlIEJUUkZTX0JZVEVTX1RPX0JMS1MoKSBpbnRvIGZzLmgNCj4g
ICAgYnRyZnM6IG1vdmUgYnRyZnNfYWxsb2Nfd3JpdGVfbWFzaygpIGludG8gZnMuaA0KPiAgICBi
dHJmczogbW92ZSBleHRlbnQtdHJlZSBmdW5jdGlvbiBkZWNsYXJhdGlvbnMgb3V0IG9mIGN0cmVl
LmgNCj4gICAgYnRyZnM6IHJlbW92ZSBwb2ludGxlc3MgY29tbWVudCBmcm9tIGN0cmVlLmgNCj4g
DQo+ICAgZnMvYnRyZnMvY3RyZWUuYyAgICAgICAgICAgIHwgIDY3IC0tLS0tLS0tLS0tLS0tLS0t
DQo+ICAgZnMvYnRyZnMvY3RyZWUuaCAgICAgICAgICAgIHwgIDI5IC0tLS0tLS0tDQo+ICAgZnMv
YnRyZnMvZXh0ZW50LXRyZWUuaCAgICAgIHwgICA0ICsrDQo+ICAgZnMvYnRyZnMvZnJlZS1zcGFj
ZS1jYWNoZS5jIHwgICAyICstDQo+ICAgZnMvYnRyZnMvZnMuYyAgICAgICAgICAgICAgIHwgMTM5
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGZzL2J0cmZzL2ZzLmgg
ICAgICAgICAgICAgICB8ICAyNCArKysrKysrDQo+ICAgZnMvYnRyZnMvaW9jdGwuYyAgICAgICAg
ICAgIHwgIDkxIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgZnMvYnRyZnMvaW9jdGwuaCAg
ICAgICAgICAgIHwgICAxIC0NCj4gICBmcy9idHJmcy90cmFuc2FjdGlvbi5oICAgICAgfCAgMTgg
KysrKy0NCj4gICBmcy9idHJmcy92b2x1bWVzLmMgICAgICAgICAgfCAgIDIgKy0NCj4gICAxMCBm
aWxlcyBjaGFuZ2VkLCAxODUgaW5zZXJ0aW9ucygrKSwgMTkyIGRlbGV0aW9ucygtKQ0KPiANCg0K
Rm9yIHRoZSBzZXJpZXMsDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5l
cy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==


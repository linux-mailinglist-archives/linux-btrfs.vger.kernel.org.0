Return-Path: <linux-btrfs+bounces-15280-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B65B1AFAD4D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 09:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32DF189CD51
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 07:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A43277030;
	Mon,  7 Jul 2025 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nuQQtPTK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CZf5RHty"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5854B289340
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751873703; cv=fail; b=GtCoS+5kLdA6HXOkpyZtg6PJ7wAMmeJz3cynMpLiO4m/2GdLJgLLW61DN+Lq+NScwFUyBA5dpKDMakpqB4m+wxPgcJXHeWLX4jfDZG7U6TW83ojMCKC4lyZYLb8ww6AoUj0E0T0t6aAG9QoUDaMb7bpluM88DtSgrHFnCp2mmtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751873703; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DzBy35cUq6uCKBJAGIBYAvQ2s62x5uLfV6tbdkWYAGahLCNbLs9b/g3F66cUkiYIhNJmlXOroWW32t1dASFnJdt0ma3X62Lm3IaDxBz5RcS+xZoFWlF9E3V1rq/91FZegL9yHYoibyxSesAmeq/kTYe9kXDJ6A+9YOKrQ0/mRBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nuQQtPTK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=CZf5RHty; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751873701; x=1783409701;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=nuQQtPTKDArbd8W9wA+/QM1XdtgMza4B6oxD/bhk6gpmnzfm0kwIlLxS
   aW+K8AmOKGadoFJx06OZ3Bjofun489+XwPNdQC57t8TdGvnnxXRSCoCGn
   +DYDyfSjH1xiX+BYj+eGJ+Ei2yfEXWkXbB32IEYQ2TTiiP0FvfwwzDvx9
   xosF1TA4/a7123L9Pb69wfu2vGe4djGw8KftvG/vI/nbEsdFL0p6t8BNL
   /596gaNjFuoKc3sZqDvIF4b0IG5yOvRf/ZfyAR4yccio4V9OgMzBM/J2W
   wPU5IKeA5v+uzTsM9H1CV18aZjvL0lb7PH532FlEfulPXzrLgQz4LVTGu
   w==;
X-CSE-ConnectionGUID: IbttIXaTSyipHXBq1hqkNQ==
X-CSE-MsgGUID: i5e1FAT5QYKDurErhXK0kw==
X-IronPort-AV: E=Sophos;i="6.16,293,1744041600"; 
   d="scan'208";a="90824543"
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([40.107.244.69])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2025 15:35:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9d9lWRivr54zEFmaGoO3jb7ZnvzQY2guL+U3CGu2ah2DeXKVjs9aiCcBIDvPF6i9nsVZvZrf1kA5/bhQGhfSGXHk/kphccnIkC9jTYs9WtSywsLGoH/07rznv3yTgbsmfaoyIS7XlBKqda75YdU6wGin3ttWW+4eCBVZmL1K0FdlQwxjC5o5TVMJ6ZDK2b21PUiDp+mhoiiJPmfWGna8cjaoJuHA7ZpKvZ8Qe06zAi3nl0LdDRJgfB/aPmAaMh8CWhJxkbV4RmIIkmmMsOvnJuVl3CnG0/QovLNdP7pR7GsLamNNUycXNsTevf53n27B4zbzjDW94isYZWs/xWC1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=A5wr8aNp985EpnWNQhwOkh5+4iJgjT/qF/EHxtZRG5fQHWRJmGdMLMMV9gEjdleKiFMCw8ldEYpzsI3SxOltCs2klQGhEF3vEcE/QK6VOPmL6BZU5lc4fprG94qVlMAS4ZaaFnosA6dVO34efi26wLNR14c3arQy84sEh66356tc3IB38ciOT4W5vPR+DnDekbq7YkotC5XROiik39e7sj0SfQ2z4LxYVtEVDtyQicPkJyHPhyS3e2ttEqsXwF1VQq89R0/6yq+6p+PjvwhfFrA3CHeQoVRH4nxLDOnglR9FinTvWPswqOcgcTaK1oUmlkKybeZgLd4oPv3vBBcJIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=CZf5RHtydFbt7VgxRVxlrzYsiB+FXrDvgySvXg+a1gDpvg0bCHWEFKqAjib0le176LI2M3bzO3w9cB5XQWW7B3fgA7X+MbeHbIOg/S1ubbs/u8Vx/cb7tkR56pIO+iHJ/jNcvnBkwsZwAKi9KKSv50Q9ZSDdyL/SyzZ0eP2EEVI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN4PR04MB8416.namprd04.prod.outlook.com (2603:10b6:806:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 07:34:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 07:34:58 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: zoned: do not select metadata BG as finish
 target
Thread-Topic: [PATCH 1/3] btrfs: zoned: do not select metadata BG as finish
 target
Thread-Index: AQHb7ulNC0+sUVEOnUu8L4FrcXL59LQmRXUA
Date: Mon, 7 Jul 2025 07:34:58 +0000
Message-ID: <aa1b1dc2-ff64-4dff-95f8-f9129385b3f9@wdc.com>
References: <cover.1751611657.git.naohiro.aota@wdc.com>
 <91e1b6f06906a4737b9d7b3e1083bd8fec040041.1751611657.git.naohiro.aota@wdc.com>
In-Reply-To:
 <91e1b6f06906a4737b9d7b3e1083bd8fec040041.1751611657.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN4PR04MB8416:EE_
x-ms-office365-filtering-correlation-id: 884e7fcf-39b3-4375-e7b8-08ddbd28c6b7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V2pya2J5VzVKL29kZURLNFB2ZTduU2pGUjhndWVkQ2xPQjkzbk9uUFhJcXVk?=
 =?utf-8?B?UnRtdjlSTWxLUUIzZVlPK1EwMHBlbjZyejVqazdUZjI5clBCam1aQnRXVHYv?=
 =?utf-8?B?RWpILzQxWDM0R1FXU1ZrK1lwUEd3d2JQekpuOXpNL0hYY2d1UFhxOS9ZT3ho?=
 =?utf-8?B?UitBWGtKTEdraWhFenJyWGVBZG5rN0RNb2pmVjhnZHVEZ0FrQjhFbkxIamM4?=
 =?utf-8?B?c2kzWEZGZGkvUzUrS0FScWdyN1g5MzJyODdqcXd1SHdNckV5eVRzTEtxYlc3?=
 =?utf-8?B?V2Z1cXo3UmdXNUNFRjRrWXlzQnErdmF4ZHBZa2VRejA1dmpOTDFnc2ZwcGNj?=
 =?utf-8?B?eDJVY0tiaUdacXF1bXE3U2dkamw3NVo3QWFjTEV6L2FWcWZxRnBjU3RQS3BF?=
 =?utf-8?B?ZlFjeEpJeVgwZU5mM1pNS0h3MkwzcXUvNHQ3S3NMMzN3RlJRb2RFRWxuNUwv?=
 =?utf-8?B?QWxEWStpRENLVHJVMlpnKzZwMytLdzdxS2I2U2dUYUpTelFxaUdqN0FhcnJ3?=
 =?utf-8?B?U3dZTUVVOXN2dHJidVV4UUtiK2I0K3BTcjJ4MWo0QTBVZ01VN2FsOFJSUEx5?=
 =?utf-8?B?S2hCSGJzNEpUQkhtL1h4WHhKVHJzOFBGaktNL2hZZ0FTOVE0VCt2dGRlVm9k?=
 =?utf-8?B?ckc2WEVReWZ5Uk11WkZZTkFyL29mdnpudW9MWENYclZpdE03aUVpVGVOQ0Jj?=
 =?utf-8?B?Tm1vTkN2ZEZYT3Y3dWJYbVJ3ZzdiM2wxTzRPb21tVWhxQ05WR2plTXNlVSsv?=
 =?utf-8?B?c3psaVhZT09xTDFFWnpKOVFXZXB2TStNbXAvZ2JpZ2hUbHlGTTVxS1NuaVpZ?=
 =?utf-8?B?Mk1WU2FnMGxIdnQwRXltdlU1MTVDdEpnZGZxSlVqZUJrejVuZkFJS3RSUkNk?=
 =?utf-8?B?OVRIbmZ6T1NVYlJ4MzJZSlY4SW9PUkJnbVZBejhseXByQ0xIclVaOFlGajVQ?=
 =?utf-8?B?QXQzdU5oRTY2eTMzdmsxN0JxNzBRTU95OUZubmtTTlVWSWQ4MnY1Y2ZsMmhr?=
 =?utf-8?B?MHNQUzlWeHZhV0JETFBrdzc2YzVQY2REekZ3VytCcFUrS3drSXlseVpjdEw4?=
 =?utf-8?B?SFJac0VtWkJxQm42V0ZhVjRnMTFHak9GS2N3dE1LVXVqbjBWTGJOTFh0Nllo?=
 =?utf-8?B?Y000Ty94WFBWYmhtdmNadm9aNEhIY2RMaVYxQzJCejRBa1EvSTNhMU16R3hT?=
 =?utf-8?B?cmpBRzE5QUVVaVltdEtneitGem9VbTJtVldvTWdlZGxZU3lDdm5JSGs4WHh2?=
 =?utf-8?B?VzloQSttVlpSQVliVG03UHcvTWhjeEJBbFg5UGpQNVk0Z2F6cXhjeUg3NXhG?=
 =?utf-8?B?eDhERy9Jc3NVMkxVaFBEakxDYURqU2IxODNuR1pIMjNlcHY2bGVmcXpudEg5?=
 =?utf-8?B?MC90NlN0cnpZSTA5SmdSZXlmenBXVWtxV3kvUXNEWHlEWHBUbEN1N0RXQnRt?=
 =?utf-8?B?b3hQUnVrUHU2WnFDK0QwMXdEY2luOFF4Y2liR0wzSU9zMHFoS0ZTTTQxTTdM?=
 =?utf-8?B?YTNOTnVEOG1vYnBabU16akI4dVBrdVc5SFRFa0llUWVZSGxDcDI0WVZTODJQ?=
 =?utf-8?B?dms1MmhKNStIOFowQkxWN2RsSlZjNmxHMWx6NWszQVJKMWlkekJPVjBGRmY4?=
 =?utf-8?B?NGFmOGhZelpHNFJ0UkZMVjVTcEdHdDJUM3JFNHc0Z213U1dvVmwwK1BvUUZu?=
 =?utf-8?B?SFRCRWZQTjdnbTlwazcyOFVtVVhMZEs0OXliWEFjZVAzR3BLZnBpZURzNjZG?=
 =?utf-8?B?bnJ2YXpIY3RKSEc2NTNiWm1WUHFkb3kwZkhMWUlkOGRrUUtpN2F0ZXlETlRa?=
 =?utf-8?B?U21UMjJaNjU1WkZRTlBoSHpsMkpTWnM5UGVBOHRYbFIwUW1taDZNWW14eHQr?=
 =?utf-8?B?aGdGaFdmUlNvYTF4SXpwWnlQSkFMdE81N1R5eXVGa2NvV2RhYjgxRjZDZytC?=
 =?utf-8?B?YWNnS25VZGppNmVBMTFxc0toczZ0UVZ5eE9vR2RRUlRJVUJsZkx6MU9TWTlM?=
 =?utf-8?B?L2xyYjdQeDNBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QW5LV1NOMWEyeE5DRVF4dkZWYkdrbDdQazVPQnZjMWtaYjFZanFtNWhnTVky?=
 =?utf-8?B?d0hqVGU3a3hmSmtRaks0S09UMzFPckdKMVcyRm1lMmduK2JZUDZqemlrS2Rm?=
 =?utf-8?B?ZTh4NmQ4aGZrYlp2cldzSVU3VUhUa20rKzkvSkhWVExzRW5uREJWUWVhVU05?=
 =?utf-8?B?bDNtdVZyNTFKa2JWSXN4d0xkQ1lIQzhrYkZRejJwVXVITDZ4Q3Q5MDZ4T0Nu?=
 =?utf-8?B?dXRySG1IY29MOTlXUGpDYkJNZEordHc0aUJQdk1xMWtEcmJSTUUvY1dtYTdM?=
 =?utf-8?B?NzJ0Y0RBUDBJZmg1czFzQmZBQmRQbHFZOWFiclNOdDZvenhuOTUyTStpaGEw?=
 =?utf-8?B?Rm4xZ0UvVUZaSUx4RlBmUEdodkk0VWZVeWVxeUhHR25GZnZFa3JWblA0SDNI?=
 =?utf-8?B?WGJhS1pIbGZPZWN3V081ZGc0L1pabXdMbXRFQUd3WlNmTWZNUFJVejBVajFL?=
 =?utf-8?B?YjZ3KzNMbmZnUmRyOG8xZEg0UlFQeU5aOVZmVWJZM3dwamVRMmlSK2xIbWw5?=
 =?utf-8?B?bWFxM1lxYXRSRnlzVml4SHFHNG5GZCswdU1XcWhKdkhia2VOeGZnZ1VKa3U1?=
 =?utf-8?B?ZllFZldJQU5sS3gxMUtITWhpWE41SzE0Q2p3dk9TRk5zQStWaG91cjVkaWEy?=
 =?utf-8?B?eW5oZzRrRGFzcWR0RXUwYjd4SS9QL3pkelJPZWpwdE9CRjY1eit1bTNocGhw?=
 =?utf-8?B?eFFyczRjekh0UnMwT2c4S1paak9zdmhLbTlQKzR5Mi9DSnNQL1lCZUEvVnU0?=
 =?utf-8?B?UXIyQTBMTVFCZTJETlp3d2k0RVR0bVRLb25PZzAzamZyeDZQUit5czVGTVNY?=
 =?utf-8?B?Mlh5QkRaQmNZZ2hNTHJlZnN0RkFZN2UzSHh3dzhLRitMREFtMXVINmpYL2NH?=
 =?utf-8?B?elZOc3phWCtuM0U1anp4VEFraXhzOTN1cEN2N20xUTI3MDh0SHZPVHpjV29I?=
 =?utf-8?B?dUpVVW9HM2Z6eC81M00yS0Jxc2ZteFVSWkpsYTR6NWNPOElNaW1CTm1WaytL?=
 =?utf-8?B?UjhmakZRMEZFOGthYllFWHlpcmw2M3A4UGVzRmNhVlhqQWlCNFZndkoyTXdU?=
 =?utf-8?B?OWl5V3JZenFqdjQ4ZXZXNkVFSW0zZ0J3L3p5a0FUb0Z4czErNmVXL0hjWXV4?=
 =?utf-8?B?aEVHdWxBOFNxUmNyWCsyenl5VktwT3B4UlFtSldlOGcxUVk0WFg2eFIyWmZI?=
 =?utf-8?B?MFZ1UklhVU1jOU40T002OHRVN0V3MVB2S29GYjZ5SitNMkx0cXErbEZJenhz?=
 =?utf-8?B?STA3cWdPT1h1SlNnakZWTWpRamFRNTV0cmVjTEpJa1B3bmxVTEtmeXJ4azln?=
 =?utf-8?B?QVd3SVN2eU9ESlFWMklQRHc4V2diMGZESEtWOE9MV0hwbVNWVHRKWXowb3B0?=
 =?utf-8?B?Nnl4TnRxZjFyQnlVRXJPT2lCY2tjRExKSEE1T0l2Ujh5UVc4SHk4K1ZzZEdr?=
 =?utf-8?B?em9SYXlBazdmTlBMZ0U5MzZRUytLNFRiN2RLdWtNMUk0UmFCMFVES21PTXRX?=
 =?utf-8?B?aWlYWmQwaTZ0NlBwQUNCTm5wbzJRSFJuczB0Z0dINXN1bEFFbllsOXNsT21O?=
 =?utf-8?B?R1h2STNPNWgrT1lQU1ZkMlNSaGQ4RDFud3ViUjh0ay9uVEV4cHFYZXI5NDl1?=
 =?utf-8?B?YmZKZ2FTQ2JKRld2aUUvVG9YbzVPOVJzdDZRRXJuaFdjZVhJV2s1QWpuOXVY?=
 =?utf-8?B?MTh0SVhCVkZYVWVveCtzYnk3ZitvMUtJWk9DaFFZWXE3R1Y4WWk1WGprTWxn?=
 =?utf-8?B?UWVXVTFnbzlnVVcxaUx1OEFkWTB1SkxyMytzY290Z0hKOUdVRmtvR2NPbGZs?=
 =?utf-8?B?Y3pGMzdFVUE2RDNQT1A4YjdDWFJQd2RZTUNXOXh0S1R2RGhoWENuTVlGSzlo?=
 =?utf-8?B?MUNUR2M1anVSUWV6cUN6U2VnSmdyTzhRNHRJT3hMNlVWM1A0S2tzUzg1Ykxz?=
 =?utf-8?B?M2IrcG9WOUIxaW9kQkJmVnpqUFVQOWVyU0tsWitrVkZuZnN3QktUQkU1bTFz?=
 =?utf-8?B?REorMElqbnJ2SVFhR2ZCVmZaclZHdDk4V0RwWFZyY1I1bkZYV3lWWnY5akh5?=
 =?utf-8?B?UjFzSXREMzViMEYxenhJTDNSNDUvcWRmZGlTWjZZdWVUS1piNXlSMlNJMjh6?=
 =?utf-8?B?R3V5b1pOTnNBSXpBRkttOFpJcVNFbDYxZWhpa2ZvZnVUT2ZGOHpDd0Uzam1P?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAC1C37FADDD474E8C9E37A3953AE700@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KVWKnlk1z41US3zXR2Dcp812wRS82RxYm5dou9mLQ18xMtwXTKStMJYOlmCI85q4AQhvFZ+E8SIeyR197Yi/mC5buHf+ySgp5cP9sFHguleQPbwvU2U7/ur/73heLepASptyuIkfjH51AmCbhABLTdkuyFfJKKq8Mpz86jTHA0qe1M2fVfPv2R5QmmC+DhtrceURDrqG7D9Sc2Rf/KvTh+goG0ezPNT91MfEOXNlxQhpoSnBOK98/f8VTIW1x6onI2465qs3FCdEBSef1bkii8EQbISNfU1ibPHubrVEKeq3RG3fbkcF2PkqUHHRWf5vF7uYA+it/OphL9Mxx1kar7QkiUvT8uf27uRLTh2aaBZghz24UAI/KKvCQByrX7Z0DIUBG6a7zZMXJhFvK2nj415VDmGLIl2CpE5oDLPWxASwLsuPXWKN/NcL9Oxyzbe6qjVt/3oEM3/NEWV64XBmRiT9/tnIAJiPAUVwipbrzQiWB2vC5abfV9nY04QyBKIDbkkdMMRChBwzUeT+b7hsdv/KrtC3awyAjLI9VcZwrZoIJyAmt5xrlK06qXKV97NKdIkqoKE2IfeEy4K2cJs8BoOrheXGBDkBkKwgODTIbleYzRgb8gdL8yDlC4ocsy/6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884e7fcf-39b3-4375-e7b8-08ddbd28c6b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 07:34:58.6628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l9JVQHuutYHsNA8kYH1jhVSZl7yTtqpRvqHtuxAMuE7j/uCMngWq5h6aOeQu9v0Skaz3qSuIA/Hyw/l6fq+qgNOdPYdgycNtfJ3uC3AcV84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8416

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K


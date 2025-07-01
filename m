Return-Path: <linux-btrfs+bounces-15138-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2209AEED6F
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 07:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052BA189F450
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 05:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F021F5435;
	Tue,  1 Jul 2025 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dxxTvAxW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="m+E2yTym"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E403A47
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 05:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751346557; cv=fail; b=OkrSZOwLce3/oldr/87su4bEG1VuskBcJsSCgPWz0B0xJRD15Ot8LW3pZe6d2QqIEaFtDhODVSch8369ndWLVcJnTdT9s5IJsBi+HKp81ZYZEAYAs/6f9ybl+W7uiCj79cVmDeSjoo7sHHOzYkT/71cCYBR5LHEcYT1uPAFAtOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751346557; c=relaxed/simple;
	bh=A6UYvSCFGP0kyRQ91PvShKpEZcJqUw2wdCdxP+vKXjE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EP3d6sKiVM3GZvE4W42iGR9DnhPyxQNhwXnrlRw9ni1nFskVwBNEM5BbmIs5nsVm1bTk+xAuziINmQQuJFmqrI+ANh7SmY1NHOvH1WWdkxUMaHW75z+uBYCYZXA7ve/e5pi49AkLgWykwa2Q+7gVTIrEaWSPJteDi7EUZ8arvqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dxxTvAxW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=m+E2yTym; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751346555; x=1782882555;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A6UYvSCFGP0kyRQ91PvShKpEZcJqUw2wdCdxP+vKXjE=;
  b=dxxTvAxWc+cNSd4Q0MhC+HfyOQ4Qpdk2UgXv2ODsa5SyyqJbfXKSyXhX
   Cwa+XqPJE38OlLPphSDuusfGjU0XYFFDJfTZKYNHBMLmeHhFltElCvXDS
   t5V/Cc9pAedC3VoTO7x/asPEA0ACESWR14iwnrYFe4zxqFvf9bUonT7cv
   srYJYEUw2pG4pJitYKJOnyFkaBQazkAlNJ74KYUQhFKgStmZUsQZzzPWK
   OvrpLLW/0wUs/ldLtJ+ttcKXoqAuRDaXXxAGt7AwarH+8vQHBFAE+FqdT
   1fwSpzzAklcXU8uMu3FfEVGzHR6rMryahp5qMCLcVJrD4avj06rqbQkpN
   w==;
X-CSE-ConnectionGUID: z5geYD5CQyCuXOGjysORkw==
X-CSE-MsgGUID: ZDiNcGWORWGvjtiK6gWgIA==
X-IronPort-AV: E=Sophos;i="6.16,279,1744041600"; 
   d="scan'208";a="87525797"
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([40.107.92.73])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2025 13:09:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KY0Hle21HCcl/+BkzOft1QWDn7xRAgRQe6D6mlk7MbvoARIQUylvMyfju7+KtzJp5Jf9ayTU2gKGvxgwiev4vcMXyYoEBTWNDHMYa76X1BUD+JEmr2wc0b3fVwelADtpP5r/J2TEV94iDfmMur5DEhZLnPz+WojWa5EXm2QsFgt6I+ZFCDvmJ9f5Cw/OQ50mIqC6O6PqDbvynXnOZJpdxTLeibtLOImZ78AY3uULFE9YrV1YEA2riGJagHrNXsWkLgZvuk/Oty5ZxdW5TIHloLsM67/zTPDFAlWStsxFhSc9NM3chg0NPjVOEqwwePHae6nIZIJXjnIw/74RvC04ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6UYvSCFGP0kyRQ91PvShKpEZcJqUw2wdCdxP+vKXjE=;
 b=ph6gf9vFiY5Xu+eM+WPiJCopK10QPfJBBlh7VIimjfVUQ56BAZbZYZqAfOk2erNUQCE/zHUs/4XBUY9VPZp9PEHlJAj0k+aKP2EsDlElItYsJ/DTl+2OcYXzVHsQEZ/F9CMR8p28ormOfQjBL13DQrgB2M75eIfm3hph4vy9s1QS29pnHUbZqzaILjuQsOVzR3yLpxCjToFNXay1r7sVqPvweP2DL0NFgqaXHb9U/wg+kbTx3pjJO3eAT2XnvI70UHlpzlkJta8fhCftmJMh8hw9Py6lRVZqp3p2wPZaJP1HhM23udkGrfhn3ox59jbpblvT1cBRKWjuIiUI5C0+1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6UYvSCFGP0kyRQ91PvShKpEZcJqUw2wdCdxP+vKXjE=;
 b=m+E2yTymSok45KTf9jE/mvK909l++jzaffDFIHs7phlAP2uf+5hPpyT0zT4pddA4VxhCbAAAi7lBTO6NyR5nK8U5c0hqh+uZuVwnHt+iFF7W9vzkZkMdYRPymuK3I7t5cOQKqgNanTJoCVrC12PqBoNlSUASOifYqCwHO6uC1nM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6651.namprd04.prod.outlook.com (2603:10b6:5:24b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Tue, 1 Jul
 2025 05:09:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8880.030; Tue, 1 Jul 2025
 05:09:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>, Johannes Thumshirn <jth@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>, David Sterba
	<dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>, Boris Burkov
	<boris@bur.io>, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH RFC 8/9] btrfs: lower log level of relocation messages
Thread-Topic: [PATCH RFC 8/9] btrfs: lower log level of relocation messages
Thread-Index: AQHb50Sdg+TBESm3SECbxp0/W4pUMrQb9bYAgADISgA=
Date: Tue, 1 Jul 2025 05:09:06 +0000
Message-ID: <be89847a-c3d9-4f8e-a468-c98d150ef361@wdc.com>
References: <20250627091914.100715-1-jth@kernel.org>
 <20250627091914.100715-9-jth@kernel.org>
 <20250630171214.GO31241@twin.jikos.cz>
In-Reply-To: <20250630171214.GO31241@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6651:EE_
x-ms-office365-filtering-correlation-id: c49b4a77-aa0b-4bb3-08bb-08ddb85d67c8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VUF1RmNTWmdvRzdqVWlPQmI2N0YyOGIzdmhabUtVM01GOFRLNEJIdDUyTVJ1?=
 =?utf-8?B?clAzbVg2YTBvTTBDNnY1R2ZMTnRHYkxPcC92ZE1KcnQrcitoWFRoSGhFejdQ?=
 =?utf-8?B?RTRwOENkaHhFUU1JbTJXVkJjTWNWS1NwMUVHSHBqWit4alNkK25UaXB2R3NV?=
 =?utf-8?B?a3RIaGhuS0Y4bzFyc3d5NmtWaVZqdWZ1blFoa1U4bjBBbVcyaVR1OXhvK1N6?=
 =?utf-8?B?cFRtNE4xcmk3VWNGOUtZSStkNEFBMktONmZwUHZmNzNBTHRWQitvT0IxaGdl?=
 =?utf-8?B?MkdVR3ZNYkdRNklSblVmVzlmK3ZkUzRKd25tWFZzdGMvdkE5akF1NmFVd2x2?=
 =?utf-8?B?VWxSWnR1RkR4YXFxL0h4YlJZOFFIM1ByU0NuK3JIemU1dVdSU2YwT0paVXA1?=
 =?utf-8?B?N0ZsSVpXQzgzSklaNDlsQXBYTGcva08xS0tZcWh0MzZmckgzbjk1Y0luMnRw?=
 =?utf-8?B?ZW4xc3pjOWxqRnU0OXh1ay8wclFHN0NCTXNwWm1KMGQycFFJVVMwbzUrcE1x?=
 =?utf-8?B?OG4vRGxxNWV1d0VhcXNYMzI2TlFDWDJ3cTJOb1J4MERNQ1hRbU9BVnVMcSsy?=
 =?utf-8?B?S0RVajdoL2lYQ3ZEaXRpbFNPQUxFa0ZEbUtjZXVsMUI1UVZLNS81TXhFaStL?=
 =?utf-8?B?ODBDTG5pUmVlbzFLYUNLL2REcDBFenhqb1dWMlA0L0x4WnlJaVpjeWgvYlZS?=
 =?utf-8?B?alNNQ2hFT0lOdVFjbnpIczN3UHNXbThmazQ0Zit2SVhxOGNFcGVmS2U4NWYz?=
 =?utf-8?B?bEVJUkwwdEVzbFJ2akJ2cytvQUFjOVFFQXlFWTBCRXp1RWdkc1ZvRW5zV2VJ?=
 =?utf-8?B?L2FrTGg2Zkl5d29TMVBRaEZnVWxkTUJCSXFuVktXdUI1WDAvcW5VSnhMNHox?=
 =?utf-8?B?TDc0VkxrNk8rVU0xbmJvcHZ6dXVMWlBBckxUN3RiVFUxM1FJTjVDTWltSkNN?=
 =?utf-8?B?a1NBTWN5Sm5EMG9WamIvWnIyc3dwRisxYU93ZjVqdXE0YTVvNUoyUEl0QllD?=
 =?utf-8?B?UUN4WXBwSVQ2QmFySDFRSmx1UFMzVzJoTkdwalczRFplR2luSjZtS3pDQWhk?=
 =?utf-8?B?RjZRSjJiV1U1QzlYc0RGQnp4c3h1MmZsK2Y3RGJqN2ZkOEcxZjVWcGRKUVI1?=
 =?utf-8?B?a3JBZ2lTQXMvREU2OG4rR2pZQXNWRkNjYWFEVmpmYVc3U3ZiMDRVZDRvZFhZ?=
 =?utf-8?B?NnNMNDFRaUxCMXdHSkdTMVZkYkpVbXNnM1hwS3RQVWdhVHV3eFU3YmFLdlVi?=
 =?utf-8?B?RVpDOGMyb0hWcWhTR2dtRElLVmcvbXlYdEdKckExL1FZTFZiaEQ3RU05N1dF?=
 =?utf-8?B?VHd2MnBkT0VDNjlVZ0dZMTZ3eEhSdkVobWxxTzZOV05qUmcxZUhkODVNeUps?=
 =?utf-8?B?TnR1bWxKdUQwS25pM1hqR2xiVDFhMmd2aDFpTEM2RnhQZk1QdXhiMXlaMVBm?=
 =?utf-8?B?MUhsL2lNV2x0UHBIR0Vsdmtpd2llbWlMTmZnRTZwbFhnU1l3MXVVWGFaaElo?=
 =?utf-8?B?VFNqandwUCtCMkZIS1pDU3VmZkM4eUFmSkZvc0QvRk4vN1VZaEdzWHg0Mm9G?=
 =?utf-8?B?aUhCR0M4U0lCeHkyeDVNYXl0T0o5Ky9ONFppK1QySnlpTlR3YTR2UDg5cm1v?=
 =?utf-8?B?R01kZDN5M2pOeVdSOEh6M2p1cTlMV1RtS3p1Nksxeng5QnJwTG1JWi9GVDVQ?=
 =?utf-8?B?MWtQNGVHeEVGd1ltRnFKOE5VOGpRbVc4dGNnYXNOaW12U0RiaStoQXF4Y3ZZ?=
 =?utf-8?B?Tytzbmo4TXUyalF6eE1xcDh0YTFXWEsxSUx3aXJvNGw3QkdXOFlGNHYwdzJU?=
 =?utf-8?B?T1VOLzE0Yk9Xb21idTJvL1B6TDc5akJwRGI5OGxVU2Mxdlo0SmFTblhQWGwr?=
 =?utf-8?B?ZS9LbVhxRFd6Qkt6NHBMc2crcUYyK3dKN21pRWxFRmJrdU5OdmlPSmVDVkhL?=
 =?utf-8?B?Ky80TjI1TUpKR2l4Y1Q1ekd3a0pnZjh1U29ISlNGT1hVQy82NWFnLzRlNTFF?=
 =?utf-8?B?UHFQZWZudzV3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RUNkYytRdVRWNWhJZGc5MDdJbEg2NG4vcDFwbjlYT01XR3hnVi9SQzVHK0pk?=
 =?utf-8?B?eXIyVkVWdm4zMlNKeGt0RjZDUnpYRGQ0QXE2cS9Sayt2VkkrN2sra1VYKzM2?=
 =?utf-8?B?SlBqUTcyNzFFTnNoNFFnR2M4Q0xWNzMxMURnUGRrWGsvYkJzL2tFMS83TWQx?=
 =?utf-8?B?U202b05YNmo5Y1VBTk1MSHNYUkxhNVhqcEI3bW0wb0JFcVdycFNJQmc3akJ3?=
 =?utf-8?B?WDU5b0hsd3hRTVQxdkhoU2RQcWN4dGQ1YW15ay9PZHlOWktoVGxjdG81ZkZ1?=
 =?utf-8?B?Yml3cEwwQ3lpajFDdXNEWkpZbHhwNERjaWhpcFMwbldHRVkvMlFFeTZVM2x2?=
 =?utf-8?B?OWVrWkpTdXlxQlFZMDdDc0g3YWdQQzcwaTdGUzNkaDRNNm5QN20za2ZNTk5q?=
 =?utf-8?B?akUwUkd0SHh3WEg3ZjZVVVI4dGloYkdSOFNjVXdUWFVQemJWYVlGV0xMaERK?=
 =?utf-8?B?RHpsdkU3NGdmTlYrUGxkc2M0OFF5WDFWeG4ycHJEWVArOVBucG1aNUVBNzBy?=
 =?utf-8?B?WXQwcEcxZSs2d3lib0Y4N0NCRWN1ZlNZWC9iTUR6Q0E3Q3dha2dvbFFlMHM5?=
 =?utf-8?B?Y1plT0xTTktUSDl6MEgvc0xteXB0N0JycmQ0QzdJOUxOYlJETERyVEoyTU5M?=
 =?utf-8?B?NEhabEhuR2hKdW1LZHZ1SS9SN1dDblFJbUtEUU5DWE9FU3loMUNVdGxrN1M1?=
 =?utf-8?B?c1g5SmNCZEh6SjZ2S2RwZDNXcGg5VnB6SmpEenROSnlaUlArMXhESWxtM3hC?=
 =?utf-8?B?QUVvM3U0OXErdjFSWWZLK2Uvb0t1OU9mZ1g4Tkxmd3phUnBQRDl0UThKQXpP?=
 =?utf-8?B?VXJZZCs5QUVKZy9VNlNvTUw4Q3JhNDdVTitOTkdmQWd0Uk9kUTZsS2FWM0I3?=
 =?utf-8?B?UUo4S2hiTXBsS3E0TlFvLzRrQzNLalhya2wzQmZkZTdjd0tNMmM5bXJyb2tj?=
 =?utf-8?B?T0t0N1lsUFNOZktpUDJEUUNYc25NZm4rdmZ6YUJlMDM3WGs0L1N5K1YzMlVj?=
 =?utf-8?B?cVI3OVhlQWdScithRlRsTHB5RVg1TGZ6NlhycUZaM3o1VFJPc3FsSmhyTVRV?=
 =?utf-8?B?MlRaSXlGZVBVZFlYeGg1WFNtcUpkTjgvZ1ZwT3EyanRaSTM3N0pENlFxVEtK?=
 =?utf-8?B?azh0M2J1dnJndXlVZy9abVlaclVVODMvUkE1elk2SXYzUnRodVJRSmFYMHFa?=
 =?utf-8?B?QS9tWmNMRVJuMWxRdlRVMFQ3SWk2UjBoUXk4aTRjdElZMnhzL0JwQ01PdXB3?=
 =?utf-8?B?N2Fmbm8wams1YW9vMnQxWkJFT3NyQnlPSXpCMzlsTEJud0puUTRxbjRzZkZQ?=
 =?utf-8?B?U0tHOURKcWNmTUpDM3hrc3h2K2F6ZFFXYjY3WndQNTUrS1kyVU9sOHF5c0J0?=
 =?utf-8?B?MjBXamVJanpCa3BPME1FYWNXTFEzZEtHaXJ6Y3ZOVjB1Z0c1TXRyb2ZzNk1J?=
 =?utf-8?B?ZmJCanVDTnlZV2xjazJCWWJiNkVoNy9uWTgxQ0FTSWx6dE5GTkR3eTVOOTg4?=
 =?utf-8?B?c0RaLzcvMEJQL1FaS1pacEZzZlc4UHN5dzl3OTNwS2RMbTFvMmVMcEdFU0lu?=
 =?utf-8?B?RFoyclpjd2JsZnBjeURJR3RoN1RJeW9kVTZxY3NiN3JhNW9tVU9UUVU1YXk4?=
 =?utf-8?B?Y25vaWtkNXFER2lBek4yVkRlOWNHOUNucVVEZG9nd0JwUmQ3RzBIWkNDeXRX?=
 =?utf-8?B?NDVnOVpIaStOUS9zcUdOUUo3SVEwamZ2SmJ5TFB1RXZYdkJMUmN5MVFMbms0?=
 =?utf-8?B?QmVGRTRnNFZ4amw1NHVhRHcvT2FPN0RjU3phczNkZ2lmSHVhN0NBT1ZjSmtn?=
 =?utf-8?B?RmIydWEvalNMT1ExTnZoRzY0RFMxWloxcjB3dmhwdHAzVml2WG15a2Y2ejM0?=
 =?utf-8?B?REtMUmtRU0x5NUxoMHo5RU1vMHk5VWpURGo2WGNUWUtxY3REUUNHUUt2QWc2?=
 =?utf-8?B?eFBFS0hpKyswb0lBQjVxdW51dnFKTVU3Ym5tUVV0WVNhNVR1akxNTHRvdXBv?=
 =?utf-8?B?Vmh2L3VLM2U1bUQvVEtDMExwbVJCSTQwNktzTU1acjJHZngwMUNRbmtERXpF?=
 =?utf-8?B?cXZQcXdUZjlubHhZZ0o5SkFOaVZxUEpabVpwcXF0S2VhWVpmV0pwdXVDL2ZL?=
 =?utf-8?B?bHZXVFk3TjJSbXdzaS9JTlh2QXpoWTdUTklxRzV4cFIvd0J1Mk9ndE9IeGlI?=
 =?utf-8?B?NDZYVW14dXJ4NS9XYmNsR2RlaTdsVjg5a0FaQUR1QTlXNFZ2MG96VmI4aGlp?=
 =?utf-8?B?TGlwTXFvUy96eVJjWGhkckxDdWxBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60B6677B5133534199763DD5F0E62AB8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RvicUXVT/LiYwRmNO7tmTcbmPSx5bKj9oVrrEwqmOtmWxU7PXgfk68hx8BtGDqQI7kHw6/cxe2PQ+qqUfJmQYeJQ4TTdTRfLwFtwmksU3P2tk6on/iSVCV1i+DQ5A3ICEI2AyKa7c5b7/v5Nx5pyCHHegN7t3smlXHy0ZqJnU+uuSpjRYgcx3O8dYFqs7W8Jzu1SfbJtxT8hnbYUd2I0pFSbmzzBDTobpfBC0ddwQkLk7zIsdLaX8xhmGMHzF+t2fDHux49pUorxmPBaePEWvBn9O/cU0Du8G4QkFkDr60bxjRCWTfnGVmX9L0BloutaX0vNRZdnuI81rC99pVYQx1Ap9Sy/YyP/cAfSDx3PBol9KBZgTSud7DdauuntSbeNAeufcskwAPuAO3B6FTGvGvVtWXtji92C3hZH87h3mPfFl/dKoWKkxMUexw8M+EHv26sJk/oAhNFuMvi0bZN7ccwHq+WE6tUSB8b4VZK4bOehNl5acGXPueEgWpMq8ev5hLhBlxgZ9DAMUjfWsVWOQ/gFJT8A2Yya6z8VKsGxZdmjJbpFx3gluH6lWwlYLIIM8iTekHEao+JvJC/jttP/X2wsSsLkZBz/Opby4zAJgYJXd84Ut9ZV08D6qJ9hN4S1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49b4a77-aa0b-4bb3-08bb-08ddb85d67c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 05:09:06.9020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IVgSCGmerWfZMAuR5SQB0PRfbAixH4OgZoYKKnC50vncdj3UTQaKlCYI1CZaRn4ryj3C6lT5AIRv/3z+hGzbw2BQKrHgBiFXSsgivmDn4k8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6651

T24gMzAuMDYuMjUgMTk6MTIsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gT24gRnJpLCBKdW4gMjcs
IDIwMjUgYXQgMTE6MTk6MTNBTSArMDIwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4g
RnJvbTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+
DQo+PiBXaGVuIHJ1bm5pbmcgYSBzeXN0ZW0gd2l0aCBhdXRvbWF0aWMgcmVjbGFpbS9iYWxhbmNp
bmcgZW5hYmxlZCwgdGhlcmUgYXJlDQo+PiBsb3RzIG9mIGluZm8gbGV2ZWwgbWVzc2FnZXMgbGlr
ZSB0aGUgZm9sbG93aW5nIGluIHRoZSBrZXJuZWwgbG9nOg0KPj4NCj4+ICAgQlRSRlMgaW5mbyAo
ZGV2aWNlIG52bWUybjEpOiByZWxvY2F0aW5nIGJsb2NrIGdyb3VwIDYyOTIxMjcwODg2NCBmbGFn
cyBkYXRhDQo+PiAgIEJUUkZTIGluZm8gKGRldmljZSBudm1lMm4xKTogZm91bmQgNTEwIGV4dGVu
dHMsIHN0YWdlOiBtb3ZlIGRhdGEgZXh0ZW50cw0KPj4NCj4+IExvd2VyIHRoZSBsb2cgbGV2ZWwg
dG8gZGVidWcgZm9yIHRoZXNlIG1lc3NhZ2VzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvaGFu
bmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+IA0KPiBJIGtpbmQg
b2YgbGlrZSB0aGF0IHRoZSBtZXNzYWdlIGlzIGluIHRoZSBzeXN0ZW0gbG9nIG9uIHRoZSBpbmZv
IGxldmVsLA0KPiBpdCdzIGEgaGlnaCBsZXZlbCBvcGVyYXRpb24gYW5kIHRyYWNrcyB0aGUgcHJv
Z3Jlc3MuIEFsc28gaXQncyBiZWVuDQo+IHRoZXJlIGZvcmV2ZXIgYW5kIEkgZG9uJ3QgdGhpbmsg
SSdtIHRoZSBvbmx5IG9uZSB1c2VkIHRvIHNlZWluZyBpdA0KPiB0aGVyZS4gV2UgaGF2ZSBtYW55
IGluZm8gbWVzc2FnZXMgYW5kIHZhZ3VlIGd1aWRlbGluZXMgd2hlbiB0byB1c2UgaXQsDQo+IGJ1
dCBJIHRoaW5rICJvbmNlIHBlciBibG9jayBncm91cCIgaXMgc3RpbGwgd2l0aGluIHRoZSBpbnRl
bnRpb25zLg0KPiANCg0KWWVzIGJ1dCBub3cgdGhhdCBhdXRvbWF0aWMgYmFsYW5jaW5nIGlzIGlu
IHBsYWNlIHRoaXMgaXMgc3BhbW1pbmcgYWxsIA0Kb3ZlciBkbWVzZy4NCg==


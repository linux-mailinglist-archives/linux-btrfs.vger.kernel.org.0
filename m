Return-Path: <linux-btrfs+bounces-6282-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7583A92A086
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 12:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1BB4B23AE3
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 10:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4068178C92;
	Mon,  8 Jul 2024 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qx8rMq2i";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ItUowU9Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9171517721;
	Mon,  8 Jul 2024 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720435945; cv=fail; b=ir/Wd00tIdvO7BgVpxhJnbaIlptfqw50O8h8auqrqYxujHjDI0C1v4m3iAGrk9utp2WE8tVX9qk430tWmdQXt7OsXTa54AUqlvcEO1WJ7PxX1s89ETusOclTUH3RdoSbabFm/9jnsbf9LZrDPJvfEBsCBmzwy/3sd5LBQ3F3mBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720435945; c=relaxed/simple;
	bh=YDIkN7lA30Vh2fWQxLKaaYWlUTLKqeiSE3ss95JeXg4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dyMMOxNJUDtx2uUT4Rcy68plYjKvcyOqfrmO/r/3Ts0Lp9msWqCIJySgHGsZytv54a/Puz0hfNYT45k9ZaKKaf3jg7pvjcwBN8oLQBI0vsrgxsCpNP0XsVwbWCYwhbcByYhECsWHtBjh1PlDGQXbNBZFQJUmMf8aQZp58cVwX2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qx8rMq2i; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ItUowU9Q; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720435943; x=1751971943;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YDIkN7lA30Vh2fWQxLKaaYWlUTLKqeiSE3ss95JeXg4=;
  b=qx8rMq2iOVpi1lxx1Y5RnytYo/5RDgXGns28kwT2HTIgdXNb1cfnu/EB
   JUpWJMyNzJ2bC+jawFQumC3+UXoeXqPMlpXoUfj1DjUVMsTuzwkpdx6fz
   VHnJ+U0Wp5+VD8c212WnAPUhdv8+nEGQ/GMAA/aj/PV8LrZoCRqXhIFC/
   XiAq5A6U1xA5zLlnE4vUarOWItrwFsiBTARecwboEx0ZQt8B7mZTiW3sa
   lnoihxHw8AXov9PKu36e/dF6HNAVtBu3hzGEsOPJePvdOoR0LZqvTT4Hu
   c2e4nZ5StYAgjjyFcySai3iN+5JbZispok1cE9sdjtOgzDrVVKST0ZryR
   w==;
X-CSE-ConnectionGUID: lAw9YiBCQTWtmWRLdXS+Tw==
X-CSE-MsgGUID: qTum/PGWQ7qmhG7DIfK5MQ==
X-IronPort-AV: E=Sophos;i="6.09,191,1716220800"; 
   d="scan'208";a="21026416"
Received: from mail-westus2azlp17010000.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([40.93.10.0])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2024 18:52:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sptwbf820IQS7vX20K5i1aEoPAYPCtOPQMiD/syEUM8A59C4/cuI3jCcckCN6DwXXIiKYMFH1y+fkCKy1b1Fe+zQ3Aj+biwprPuhLbeMtoTqg7wjC7jLvoJ90Nj5O6V1x0/eXMVYOlKREvyxxkoh2Gxz4hMOzKBFm0UP31VtqFRjx2QhbXORMfPyMv8T8GrILogEs3XktvHnJo65X7MWUyxtoPvMAcnlCVnM92ZDspsjMYFj8wFMH+9Y1bSIOlslrFF0aWALxDIVkYaF4jcGVnGTmq0m7ABWmuLvGeStR7QffQGyDwzpx61JKTsiKYOZlD7mbSIBxpPHadP9rMVxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDIkN7lA30Vh2fWQxLKaaYWlUTLKqeiSE3ss95JeXg4=;
 b=UFJ5+yFrrbvtcI9kWkvZgefl9qqlRk/lm+RfyCmkKH8owAJB6sLPKBucgw7JbddZkxxAXHetQZfx4ea5K6GpxSYCXtEArFND8RZG30r+vhLqTLaUf7Co18sRG8OSJqMeNVYGQnwlL+e/oZVNDK0LLJmx4zzl2uo4wPSthDmEaeEy7wvaV45w7DDdNhRnNada804j5/IvJjY5t6r6eeP9LLXFRzuHcWi9YETFcPYE7+L5N1R4jex6b+ME2ikDU5s2WT3W2rJL+Ipm2G6YWcS8wHRnmqcTsLpT7DlPiSkaFqTaX76tp421OPMIa4w3wgcPe5yuwk9nmcxK/WwaFPjzJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDIkN7lA30Vh2fWQxLKaaYWlUTLKqeiSE3ss95JeXg4=;
 b=ItUowU9Q7XdT7h2oEAbSrckvEE03eONSG7ySZDA8q2rEcdklwVYGod1ZyS8+8HvMXw7dTC+pujs9z5urgpZ97+AkmBYY3NkFXQOMHdUquUCr89i04MbPjd4nsMJ5IlNJ2YaoYA72LXxIasT9CovucRP1clWH//8I1RLuOYy8ztI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN4PR04MB8333.namprd04.prod.outlook.com (2603:10b6:806:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 8 Jul
 2024 10:52:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 10:52:16 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Thumshirn <jth@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/7] btrfs: split RAID stripes on deletion
Thread-Topic: [PATCH v4 3/7] btrfs: split RAID stripes on deletion
Thread-Index: AQHazu35+gWM7QXR/kW5py9pDxK19rHox7kAgAOA7YCAAAZ7gIAAAY0AgABbQQA=
Date: Mon, 8 Jul 2024 10:52:16 +0000
Message-ID: <50d64ebb-857b-45ad-9f98-70353dfef535@wdc.com>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
 <20240705-b4-rst-updates-v4-3-f3eed3f2cfad@kernel.org>
 <e0041c2d-f888-41cb-adb8-52c82ca0d03f@gmx.com>
 <e3927e86-d85e-4003-9ce5-e9e88741afa3@wdc.com>
 <ecd368a8-2582-4d23-a89d-549abb8c4902@gmx.com>
 <d0c28a38-23d4-44f3-9438-e374be1c33d0@wdc.com>
In-Reply-To: <d0c28a38-23d4-44f3-9438-e374be1c33d0@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN4PR04MB8333:EE_
x-ms-office365-filtering-correlation-id: 0040afc1-7988-457d-c0c1-08dc9f3c0854
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aDVZZ2ZkdTJhZkM1U095VENkcTRVazZQcnRiSXNCZFNaS3pGWkJDWGRpU3ZC?=
 =?utf-8?B?blVVeVdQaGIvaEM5NHVPVTVnZHBlZ25oRUp5K0lvdk1QMkVxZzNEYkNQVUpq?=
 =?utf-8?B?azRrWUlMbzdPdDBGMWsydVJDV2lxRXljbGNNM2UxNjhsSSs1azhXa3k3OCt5?=
 =?utf-8?B?VWVHbFZld3J1Y29qQUNaMFFQMWtxMUdSOUlGUCtXM1owbG84LzJ5ZGxlaUdF?=
 =?utf-8?B?azF4bkdGQ1JYRmd4TXduZGZ5L05UdXFzbVNOOVI2NmV0WDR1MWdvdWRGT2lq?=
 =?utf-8?B?VVZnQkFEcHdoYlNqbjZZSUVkc1E5NFc4RS9abUJraUVQM0pob2JuMHJPdnNS?=
 =?utf-8?B?OFpJUkErSnBmRGp1UXFiblROR3l5dThUVGtRZll2UGF1b1JCcS9TVUlxNDVT?=
 =?utf-8?B?ZEtIbm4ybFY2UjJWem4vSHcrUkNGektMUmtNOEhqZjI4MHdaWVpjNHpWMXRR?=
 =?utf-8?B?RWRCeXM5WUdDWmVIVVVyNXQwaDF4dmVzZTkrcXk2cDJsc3pDV1owRDRScVVq?=
 =?utf-8?B?Yll4UUpvcmJJWGgrZUJOY09uQURYRFhUTFZ3V0N0VmVtdTl0ellzc3Ayb2ZO?=
 =?utf-8?B?U0JRNFREcUFXeTdWRE11VzhRRVM3elQvVHZ3UVQzMkxJYXRiakFHeEUrM2h4?=
 =?utf-8?B?RWExWUpyUWY2Um01WUFsckZZZ3IrZzhvUzVscGJGS2YwNUNLVlRoaXExY2xt?=
 =?utf-8?B?T1ptS3NTY0Y5ZTZ0N0VIeno0dzdFSUpYWGtUbFo2amd4ank3aUNDOHh5cHVv?=
 =?utf-8?B?NXk4Z2NpSjhPWkRoYlpMQzFLdTlHWE5YdERMZElzMWd2Nm9BOTg4SXBTWHZ1?=
 =?utf-8?B?Z0VNTTd5Ty9sV2xxNVZDNmhVUGRLclA0VnF5R2pjRFU1eXlpenhudTJETmRR?=
 =?utf-8?B?TzV6YWtIaWJtWVlrYlZRbTJicWk3RjVzYVUzQjRITmZNVWdsLzAwUlErTnFy?=
 =?utf-8?B?VnBlRVRJaGlzYzBIaEFwSk5iSGJOUnZmd2ZFdHlrU1FIaDJwdHRaak9KTjM5?=
 =?utf-8?B?TkNwcnhIU003N0JUNmZTKzdNL3htOVNTbE13NkxhamZoQm96QnlHbDgzSkFa?=
 =?utf-8?B?b3UvdldOM1hRMGRiTThrNVg3MkJPcXhxUnBIa2FtK1JrUUhxMW9yL1NqTjN4?=
 =?utf-8?B?ZVZtTVVHQ040NGF1SndkZlBYdWdCMFZpVUhNSzhzMTM5cG5SU21jQndhc29C?=
 =?utf-8?B?U0krKzlWclM1emdoNFpTenVPUGYvMytEZ283aDVQS3FCM055aWRhTkZZT2ow?=
 =?utf-8?B?MWJNNTVxd0tIcCtPTXBtd0VINHRwVFVZU0xVTUZHby9leFNpQVVIMzlIV1dH?=
 =?utf-8?B?WXdFaSsreUxMV0htOVJQYUNtR3BTSmFNVkZ3T2g4UWhZbG5PY2x5N05rc0VO?=
 =?utf-8?B?VEpPZmxjSTFybHdBMVhtbjZjdFB1L3RRQUY1RlRRaFBoTVU0aXlJbEtNekZB?=
 =?utf-8?B?SUNOQVZRRWdvTk1xUUpxNitDeVhhZHdLK3BOd1haQ1dtcmptMk0wdVA5dkFo?=
 =?utf-8?B?T3NtbEtnMUoxTWxWOXcycVpmQkJoTWlqTUQrSE1OaTVhNGpQOWJuT08xNFN3?=
 =?utf-8?B?ZU4vT1hzV0RXT3l1RWsydUFURFdmTG4rbGcyWHh1elRKRXBCTHA3dkh4Wk5y?=
 =?utf-8?B?R3VBS0tGS29OQ1lKVDRMOG5icjM5c0dDSEhNMjZmVGZzRlV1OVJTNHJ1Znlk?=
 =?utf-8?B?eWJRNEZLSHdjY1BDU1pLUHhCNUJ5Z2lmdjlyZ1BYQmd3RlFtdHRmN3BCMFdq?=
 =?utf-8?B?V0NWdmRlQlFOdk9ibVlUYXE1a090VW5PZVB2eGlhMU9SOXJYMHIzTGNpTG94?=
 =?utf-8?B?MUVnWnpwaW9yc1U3QW1yWFZOaDVtQ3BhMGVCbS93YmNId3RLOXBZMnp5Rkw1?=
 =?utf-8?B?VU83YzNpelo3cFhJSTBpTUlJQWxJWWY0UElaTFFrMExuZmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWVxcTFJTzA5emtvcHJERUJ2V2h5Y3ZlUTdWa2E0TWk1ZzB1ajUrMFhpTUM2?=
 =?utf-8?B?V1Fjbm1Ua05Gb2dGU1cxQkhmZkczQ1owTEhiZkp1Y09HdXBDWTFLYUg2Szhx?=
 =?utf-8?B?MlBQQUszd1JCdGd2WElENXhJbld2Yk5ITlAyR3Z4ZU00aHRlSEhrdU5INGtQ?=
 =?utf-8?B?akc0dXF0ZlNsN29INnhJZXpzeUVhS0FSUTJ3b2F1L0Z3VjVTNDhPeW1LK05w?=
 =?utf-8?B?MTBsZE5qSTJDQnBqS2ZrbzRjKzhjZmhGUnkxdmJiMDd4a0ZsM1BQTWNabUdv?=
 =?utf-8?B?QUQ5dTgrRWdrNjVwd1F5R00rMWtvOEZtVm1kbnB4bHlOUmpNMzFZZFM1Skhh?=
 =?utf-8?B?VU9ZRXlTa1M4VXlUcHZQSzNHei9HTkI1QklRaEw0OEpVUTFwdnFnWTZ5U2lk?=
 =?utf-8?B?eHFudmNjQVRFbjhja3kwMXdIMEMxVkN6YW82ZHZCbXhCaDAxODJPNk0vRGVv?=
 =?utf-8?B?WisvM1NlZzcwU2tjeE9iNjVpMFFOMWVKWWd2a1RPYmhDdmRaTXBFTzVBQkJC?=
 =?utf-8?B?bXdvbXh3K1pRMVRjN3dWZWxmVEk3aS8rQWxsTEtTa3lqMS9vdjgrL2x5NWh4?=
 =?utf-8?B?dC9oOWEzQ1dNUjB5a25DMSthblRyRU9WN0Z3d1NzOWwrZVVkejhmd29idGVZ?=
 =?utf-8?B?dmczSHZwYzFJdlEyWWs5Vno1TGZWOEc1bUdUWUdKbWtzelc1eWpWNnd4ZEgw?=
 =?utf-8?B?RFg3anBIZ3VGc21GdFhxSE1ENVJEWUtSZFRzYmhDODFRRFFpTGVPcjZMcVBx?=
 =?utf-8?B?OXhZWFRkdXZJV3FkazkzNk5ZYi9uYXVrUXk1eCtDZnBTYmd2amtzNFFzVisz?=
 =?utf-8?B?T1lHeXBCTENKQjFCWmU2a1BWQ1NoZ2xtZVZCVk01YjQ1WUc0Z0UwM21SR3Fy?=
 =?utf-8?B?Q0pkTk4yOHJML2Fka0tuZU8zSHNXSzFVTEFZTFFmUUtiQ1lCZTZtcXVHcm4x?=
 =?utf-8?B?dmZhLzF4VGhtbjVaWU1XSXNNY05hZzdlRHpMSFc0T0ZNQldtcFZjUlpUMjFy?=
 =?utf-8?B?NEJSNWNVellCeWJuMlhZUnI2bGhJL0YvaUxwR090WVZiTVFLbGpoZHllMVdk?=
 =?utf-8?B?K2ZyL0ZhWEVyNm9BZlhUMVJiNGJDclFQcUJOZE0vSm9RVDFrRFp3ckZ2WmRp?=
 =?utf-8?B?REl2WldXeFZGa1QwNHRGZi8zV1duVnZiMFk3ZkM4aUd3aUV0aDM4Yzg2V0Mw?=
 =?utf-8?B?NTN1YnhycytXTWEydXR6M2Z6NnREeXR3S0hjWXBZSUxGcXFHSm50NjhOaUVj?=
 =?utf-8?B?eUh5Q3BON1hxREUxVzRJUFlLSVVzREMvVVF1NDNsdkJXcUw4VXJKL09WYlpk?=
 =?utf-8?B?WGhJWTZMenlGNGF2YVJ5Sy95T3hxNWl4dER6WHhzbm11cGllSTkxMS9IRHgx?=
 =?utf-8?B?dmlLb2VLUmt5ckpIV05FVUNOa21YM0JMdGlneXZyREEzMXQ1WVNRWXVNLzJt?=
 =?utf-8?B?ZENXQlpuNkV1NXNhd21CWTd4dXBrQUNURXM1cHVIOEwyWEhndHV1S1RpRm04?=
 =?utf-8?B?T1FvUzBSYzRyR2kxQ2FUL01qYmttalRmaitQak5aYlkvV0wxVit4QkYzQ3pE?=
 =?utf-8?B?NXVjdW10UHBmQ3d0cHVBUHBXU25MbmNBQTg1ZSt0cStiMTNKTUxZWWx2R0hC?=
 =?utf-8?B?eXpVSVAvTUxKN3ZiQjNDVG0vOHR6N3I2a0cweG1vZXk1VG5OQXNuZldwTFpJ?=
 =?utf-8?B?K2g4cER2SG8vTCtVd05lWUgraDVmTjFmYzMzTkZNb2FkcWdKek9ZOTZ6TXdY?=
 =?utf-8?B?TEwrL1YxSmZRRlNnSU1iUHFENEFlVjcrWlJZZ216TThaRjM4YjhCNUZhajJr?=
 =?utf-8?B?aklmRDJYNDdtT2c4TjhFMHYyQUMzQ2NTdXJiSDJTZk8xdytvV21qUW5QZ2Nz?=
 =?utf-8?B?dXNDaGJ3b1hoUFlmcmd1UHhYSEluZmNMV0k0ZWswQmNkeGgvZDZZcHZ4QXQ5?=
 =?utf-8?B?dVp0THFLYmkwWFNwN1VlVlVIczhDMSt2cW1CWm90Q3NTZk1rY1o3b0JDWVRS?=
 =?utf-8?B?T0F0ZWlpSmJnNlAvU2dqayszc0wvWGwxdWpEcy9wcytuMVFGZFJ4cldZc2JY?=
 =?utf-8?B?STFKUHdkamx3Q2xGZU9HSjh0Y3VMak5Ec3pLNWxnTDFFemdQOWhPTm9QZ1Iz?=
 =?utf-8?B?bGhLdzRlbVhPTmdURy9SVWNFKzI0OW42QitvRmgrVVZsRUcydUhHbzdNTERT?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99AD17F3316C3449B8B6CD5998DFE382@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K9wfltYDqPaLBxUea6ZavTf8mzAyj+171JSdw35CBGC9dn64fq8JX+nqTCKJZdH88iylArSb0KvealtEyaMBbla6CC36EkJ21bTKQ9/+QF3yDLB0jAMQLzrsOvTCSdHFDRkTK6p1vAMUZyuIDNgAitjBixyrUpApPgTSFh5X2uBuOf05Fv/BS/+2A/ZZJX0eVq2nNteQ2PRBewOs36Jguyj96khYN5C/BMKtDeivDKHs5Ygwcz3GSrmVMLt6gqeFqt5VBBwlRjAWFXweLt1IUy02BDFJlkCopP5mEC7nVOiIBN882aHA82B6/FEgbSFHwdbL9KBBXNxMy90LA8+x4vAjICoy1zDkvssPxS6GKiqU4FxvEq1Pix9QqmQdSl7hEB2dZ4FjQExHLXoedwqaGXnBHwMkBrH4aGRLP4Z8CNO+wGt/tr43weD1MEY2ynFnIL1R7XyJXkMwn+FqLlJdUsx8EPxXwowTbsGpt44Rs2xbBIRDxzWkyqh9dfODujO5dW2hrvnj0Jxg09Hea/R/x/5HniZbmI5rMOg6ZQyeF/SrQ4H5u7Z6ivtCkQ1lSq6lVPitWXZmm98cudswSRxp5+9c7DFOLa0xdjWQEbJANwJvZsQ7QC1xjSM5uK0Qz9EB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0040afc1-7988-457d-c0c1-08dc9f3c0854
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 10:52:16.5883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JfEaRstsbNECJhUJOHb7LpNUzAfRt90wzSF2C91dfdu9a62pR0XeKEMk49L530TvN8P3xJroNW0jgabPBh20hL6mlJF/2nM8OXSkEfNJm4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8333

T24gMDguMDcuMjQgMDc6MjYsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gT24gMDguMDcu
MjQgMDc6MjAsIFF1IFdlbnJ1byB3cm90ZToNCj4+DQo+PiBDYW4gdGhlIEFTU0VSVCgpIGJlIHJl
cHJvZHVjZWQgd2l0aG91dCBhIHpvbmVkIGRldmljZT8gKEknbSByZWFsbHkgbm90IGENCj4+IGZh
biBvZiB0aGUgZXhpc3RpbmcgdGNtdSBlbXVsYXRlZCBzb2x1dGlvbiwgbWVhbndoaWxlIGxpYnZp
cnQgc3RpbGwNCj4+IGRvZXNuJ3Qgc3VwcG9ydCBaTlMgZGV2aWNlcykNCj4+DQo+PiBJZiBpdCBj
YW4gYmUgcmVwcm9kdWNlZCBqdXN0IHdpdGggUlNUIGZlYXR1cmUsIEkgbWF5IHByb3ZpZGUgc29t
ZSBoZWxwDQo+PiBkaWdnaW5nIGludG8gdGhlIEFTU0VSVCgpLg0KPiANCj4gTGV0IG1lIGNoZWNr
LiBJdCdzIHZlcnkgc3BvcmFkaWMgYXMgd2VsbCB1bmZvcnR1bmF0ZWx5Lg0KPiANCj4gDQoNCk9L
LCBJJ3ZlIG1hbmFnZWQgdG8gdHJpZ2dlciB0aGUgZmFpbHVyZSB3aXRoIGJ0cmZzLzA3MCBvbiBh
IA0KU0NSQVRDSF9ERVZfUE9PTCB3aXRoIDUgbm9uLXpvbmVkIGRldmljZXMuDQo=


Return-Path: <linux-btrfs+bounces-19239-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 199FEC779FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 07:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28F3335AF6F
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 06:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47939335070;
	Fri, 21 Nov 2025 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ICWjmOWE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JANWEaub"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F9D23C4E9
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763708339; cv=fail; b=TiMsexJRmczsvhSsUKTFkFhf60drqyDDVCpqtK7v+blwDtkFZ/vhaRsNplyi9fjH4i0CR4LjwV6yZGG9G9fbnVrfgUbqeGYu0LEGb0xcL0n3Cnj1BykStgZJi8C8+Qyc/bGxAdL9Wj/RcOrstOqx5LGljppk1pbwV5rAoCFOB5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763708339; c=relaxed/simple;
	bh=fXH5HVRGsdyfs3p7rBP5UXCh6sh0xsUoWsuKpDrlgXo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d6XOMeOtayAnlCX7Ytuk4zuKrJp+3qMBQqC6O5ylEJc6jOlM2HBPWq6+SqDUmInl3Sa2/nL6joh6lZPqxXtU7tKQxIm/6ekziIW2Cc7pPGjT/zmDD8qb71qsr0iwaqxgRp3pV0fGs/vVlG7z9BeMSPrswjhVs/E/YOHLlLF5G3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ICWjmOWE; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JANWEaub; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763708337; x=1795244337;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fXH5HVRGsdyfs3p7rBP5UXCh6sh0xsUoWsuKpDrlgXo=;
  b=ICWjmOWEZe7rg2UgaHDvAyj4HG8VkLzj4HIKX5sgYLiFtxzLfp6JE+55
   FKStxRg+aamXXoExV0UNQ1xcAOxrdLNNATO3c26ae+N0V+j3YIvnBkVsF
   NB0Bh45e8KbGnH9JMZSxsiDC/ait3qnuffL7xaU1Yk+uvTjS3GGntnV3D
   9Wn1sFUGRwwDqZav+j74BN7HCp9j2J9UGJyKR+oNAw6dMvgduQQxrBRAm
   7F56Ut3yklDtPA+Ez+XGtxNyV7NO+21ynEh3UjnfJhj9uBsyRIr6i8Zc7
   K8U6Yd07icrKBbN8M7Y2GRU900zTuOhnJ0a36hl4akIp60Eph2BpK4VPs
   w==;
X-CSE-ConnectionGUID: CnrrjzT6Qaac6Z5Ecf31fQ==
X-CSE-MsgGUID: PKrpPtfpSTiMZ66pu9mEew==
X-IronPort-AV: E=Sophos;i="6.20,215,1758556800"; 
   d="scan'208";a="135524932"
Received: from mail-westcentralusazon11013067.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.67])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2025 14:58:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=la4+K+IuXBe/SBnYwy2hXXLR+9eRj6zzemazRE9M1Lb+ZH5D3jFFEUj+IdiswLxaGI7Sr7G6CjM97Ssu9Daml0FNmjynRqRa1W6UXRkvNXY7blzWmF0jTO/3cXnCQ9tBWDHL2q5MuajlCQOF2sA094rVxNzSWeD/cWHCcUJJ3Q7NnKGStkT081rMklkEBxM2B5fifyJR7URAjlC3c+lk6bJoZTm9mP5/uepBY95I4mQkESs9zP79hIAprTHx4LSF1aL3vGQeSRKlId7hAOF20tB0zdvn85/HqrSj5noTlTUJg60MJiRU/pNwL//0puCE4yfpvkwq4Nzpo5k6rJ39Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXH5HVRGsdyfs3p7rBP5UXCh6sh0xsUoWsuKpDrlgXo=;
 b=nwHxrLB6oEQt7AJ7sQPrrhtfjiSdzJufO6sq8HYpk/4IgSuqaFrxH/12wyQvXOcA+MvsSzZgha9dqgWzqsKvwFJ14ajT1WurPmJd8wXhdIPlF2g2d5M9boiBs7hoPfvuHMUZOYtv7wxgZer5XM3dKb/L2R4lLMqeCZK+B6/V8JmS8O6QAchoklDmVC7flGeYcHK2UwDaXYrtcc6lRF4WwhP+Q1c08zK3qxS3vWuwU7ybAQzjACbLUCeNTsyEFi1ddwSkHaoDEikc9Xr2gvAzAKoxD1u2ZGdhc1+U29a7DfIOEz9FVrbHB4xtbfjpXuQrT/t7udx6SKT14Y5ahkKibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXH5HVRGsdyfs3p7rBP5UXCh6sh0xsUoWsuKpDrlgXo=;
 b=JANWEaubRcBdq3/Xmp6cAomvrTftr+R9/f1wv0eESOQf9WMMeoPZlNAdx6jhZRk+opMlqsP05dojz20lCrd6PA41Dtj4sgHy4WErm+tiLNcKmJ3vOdMeOfBjGcLGLTpecr50EIee1A4I0ejIGzTID2qvbSWrxY9NQsNIk59ZMro=
Received: from CH0SPR01MB0001.namprd04.prod.outlook.com (2603:10b6:610:d8::5)
 by BN0PR04MB8192.namprd04.prod.outlook.com (2603:10b6:408:144::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 06:58:53 +0000
Received: from CH0SPR01MB0001.namprd04.prod.outlook.com
 ([fe80::1425:795e:ebac:cf71]) by CH0SPR01MB0001.namprd04.prod.outlook.com
 ([fe80::1425:795e:ebac:cf71%5]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 06:58:53 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Sun Yangkai <sunk67188@gmail.com>, "dsterba@suse.cz" <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"boris@bur.io" <boris@bur.io>
Subject: Re: [PATCH 2/2] btrfs: simplify boolean argument for
 btrfs_{inc,dec}_ref
Thread-Topic: [PATCH 2/2] btrfs: simplify boolean argument for
 btrfs_{inc,dec}_ref
Thread-Index: AQHcWijlGWxMBsoUCUOitRGvZhMcFbT77AEAgACKSQCAAD38gA==
Date: Fri, 21 Nov 2025 06:58:53 +0000
Message-ID: <b84d76d5-7046-4250-82ae-070e3f16e9b0@wdc.com>
References: <20251120141948.5323-1-sunk67188@gmail.com>
 <20251120141948.5323-3-sunk67188@gmail.com>
 <20251120190206.GM13846@twin.jikos.cz>
 <6e3d587b-89ed-4b44-ab62-c485b8fdf814@gmail.com>
In-Reply-To: <6e3d587b-89ed-4b44-ab62-c485b8fdf814@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0SPR01MB0001:EE_|BN0PR04MB8192:EE_
x-ms-office365-filtering-correlation-id: 69c904a2-a101-4764-0085-08de28cb6eda
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?STZsaXYyT3FTdElPMTg5S0JOQnF4bHVEVVNhVHdFazdwY3kzU290dTByL0hw?=
 =?utf-8?B?bE5oOGtRQ1JpYVU5d3dMSDRhc3ZOdmR2aHdiYlFOdDFad2ZKa1E3Y25XdVBl?=
 =?utf-8?B?WEFzZkMyekprOEhVRFBEL3A0YWRBaDl2RTNGNVczbFFET3I4Y0hHQ1JocW1w?=
 =?utf-8?B?UzZkaHQyMGh1Mnc2eDJsU05lMGp5T0lsT1MrcnlWY2N6Y0k0NG9VdEdsN0Mr?=
 =?utf-8?B?MkQ0ZjZOWmYyc1l5YWtwS1hhbHZDNGo0d3p3SzhBS29HZGw1WHBmT2cxOVNz?=
 =?utf-8?B?Sm5kbUNWdE1JdHUwaXo1QmFCaEF0L01HdmsrWHFmRmx0MExwQUQrWUhwZU85?=
 =?utf-8?B?cmtpWmJVWDRxa2FXcEo3S3VJMzg1WVNoT1pWcCtsVzRuSmpJcWlXUFdoTXRY?=
 =?utf-8?B?bHcyOVNobTJkQzFEazBGVm5RY3F4WEdxSmIvT01CNXhKSmFCbi9EcFdvY1M2?=
 =?utf-8?B?WmhIYk4ydUUwT2p4UUVNTDA3WWtmSmloVGxGSHFhREYyZlFMNXVjNlFseVNw?=
 =?utf-8?B?aXVCOGlDQVhyNlhhMDRWYnBJcEdzZU1Bdk9rN2tZOFpSRlNnQ1JOQ1dvTXcx?=
 =?utf-8?B?MGJiZGtTNnRDZ1N4dVUrL2JySUowR0FEQ2l1Rnk5M3o3TFNQMGt6TDlwNC95?=
 =?utf-8?B?Q0NyZWJpT1BZRHMzL01NUFAwd1BLYUFhejZMd3JZR2tEaDdwTVVVNHlPeEJp?=
 =?utf-8?B?NktGaDlpS0lQSnltSlp1K1RVREVkdzQreWhLVTFMSm9MWXc5czBhQk1Rc096?=
 =?utf-8?B?aFpBRDk0T0hEZm5pRnJkZ0Nxa2VPQ0M4ZDhQb0ZBejFsQjVjWVFqZmI2b1F3?=
 =?utf-8?B?ZmZ4YXlhWVFGVmwwRUF5QmpJbHBlVzltT1kvVTJsMVNkR0p2Tkh4akhNRzQ0?=
 =?utf-8?B?d0dMSmh0UUZQbmdVU0NhZEVzTmVOVEFYaUc2V2JJYmlzQ1RFeXFvZGhDcmVh?=
 =?utf-8?B?NE4xZE5LdHpWenNSejVra2crV2R4NVFoekhEL052VmZPeXlkTmRVMkx0cmVG?=
 =?utf-8?B?KzlRTXFucm1WVDVvV1dja1EyaVZ1MEJpSGxQOHA0dm52ZVgwR1V3cnAwT0VH?=
 =?utf-8?B?TnJUYWxML1dtVUNGYUUvT3FqQm5aS1N0UTFlclNaYWVlYzk4dGpISXNPeTRw?=
 =?utf-8?B?blFSTHZzajR3RERhRzR3V2hqalc1cXMxWnlTTGk3RXFKcTgrQ0p0MnNZRlpt?=
 =?utf-8?B?WExiYVJmWHQzMU81TnZHWnA3dFpFbnBGWDJpbjVBS1JQeHpGMTJIdkNvckFw?=
 =?utf-8?B?TlpRWjdHbnNCZmM4RUVzTnpUK0Q0S2w5VXExVHBvNS9TbWMzZzBGVW1hT1Vt?=
 =?utf-8?B?OXBaZVlkdmlWTm03UXc3bGhIak53SDVHVkM3ZW05aHFsZW1DWDdNNFZ0S1hO?=
 =?utf-8?B?MEp5ZWZqM0tpOEthVVB4eHNVVjZQeFg1UkNnWkpuQys5YkJxSHpYMG9kZmN0?=
 =?utf-8?B?S0VjaGJhK2RVeHV1UDFrWjNZZkJnN3pXaG55QW00eGFVbzlydFZiMjBXbkFF?=
 =?utf-8?B?Qjd4VTM0eVB4RWRnU0hKTStrdUt1L21GYmdFdzEyc0VCMWp5SHFXZmRMVWpU?=
 =?utf-8?B?ZVNzSVdiNXlOek4zb1c3THpwRisybDQzSXUxcmdmdFh2QlNtRHlYdllZM01p?=
 =?utf-8?B?Ry9NZHYvODhFVGNFTGhubGpTRUxBYTZjZk0ybjlRaUcyNnhlcmdJNXV3T3dp?=
 =?utf-8?B?SGt0S01PeWZRd2lMU0duLzlVVExVRmROeEQ2VHdsSzVxdGZ0MUdrMHB0MXZ5?=
 =?utf-8?B?MnVmY3VMWnJBa3BrN1ZGcHNXME9ZYkpSRFZlT08rV05wTzkzc3dTTHpTQnlS?=
 =?utf-8?B?MHlFbWxmZThxQndXVXhQcXlVTDYvU2dVblg5OEFLN1hjYlF1TGxXNEc1REEr?=
 =?utf-8?B?S0VKV2toK3ZvL3hacEFJVVJsa1Y0SDRZM25Qc1JyMFdXK29VZ014YVk5VkFI?=
 =?utf-8?B?YmV4UHhyWWJtVXFHbXVFc2RnZHZKU21TWjY1ZWRwQXJnT0ZBdWJtK2ZNMjc1?=
 =?utf-8?B?OW04bWJEK2U2eDlzMi8wRjMvVlRHZGhxeGhmbWNOcFBpQ1dibnlseGkrUjYr?=
 =?utf-8?Q?OxkR5P?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0SPR01MB0001.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDJTcklzakx6OHhWaFRPQXExa0xHWlVELzBsVXZvU1k2eWlNNHZpeU5oKzF3?=
 =?utf-8?B?NEZpSHNxQSs5dS9BWk9XRTdGY0kwTVlJczBTb0xsNVlaSy9tWlY0RFdqTmh1?=
 =?utf-8?B?S1p0MkFpWEcrR3N2THR1TDdDem9panhsVXFveUNOK3M4dGtkVFBjNEZkQXBa?=
 =?utf-8?B?K2QxUGg4d1RnVVRHUEk3SU00SERqMHRERnlnQXRhTmIvQ3daZ3NNdzlETjVB?=
 =?utf-8?B?d1BoekVINzIwVnlHVzdaMTFqWDdISGVUVGhFdVo1Z0V3bEpIUUplbXBOQ3BV?=
 =?utf-8?B?OFIyRGZkTTVvS0loWUZDVUhPU0NXc2Via2wxUndLa3NYTW80a2JOWlVzcUhO?=
 =?utf-8?B?MVVTV3M1RmNBaFBFaTUwYVQ2dXhyNVlGWnVTKzl3d1ZNTGNVZVQ5YVMrbmpt?=
 =?utf-8?B?dlh0ZkpxNHRPQjZ0Z3JBcmVkU0FteGhGbG5kWHpUbWFnNkZDcW45MVlhM3Vm?=
 =?utf-8?B?LytyalYzSUtVUzhSQ3pYQXo0dURFODRWUXRkSUJTSDFTaHpZRHNrUjdjV3E4?=
 =?utf-8?B?Sy8vUDBLV0NpQlpuWDZVbm9JSmFUSzVuNlhGYm9GMzRZVEpPZE1EYWhaa1BW?=
 =?utf-8?B?ZTRyZ2xwVUN1MW9IR2tYSU5sUFRqZG1Qb0lXREsrWGV4bHU5aEFuRFBmaWdn?=
 =?utf-8?B?QlhKdWs4L3N2T0dabzVqejlrZG1sak9WUGxmZGJqWlc0Nm5qWDNMQTRmUk16?=
 =?utf-8?B?N29sVlEvOUE2dmptcnFpNXl1Vzdrak9GZk5mbVJNYXVuckk2SmNUVXVnNDV4?=
 =?utf-8?B?N1owKytrME55bHJ2MjZHWGJLSzBHclJXT3pocTdDWnNzZjhBa2pNREJKVXZp?=
 =?utf-8?B?eU92YjR6OGRJSWI4N3pUTFRKMFV2cElUTzlCblFYU0xsWUxRaS9ua1MvYlpj?=
 =?utf-8?B?N001YTd4VDh0QWVudE5BcGR2SjRyZkQrNitsU3RJeGVpdm54UkI2TU1acXAx?=
 =?utf-8?B?ZkVjUVh6SUFWMW1ick1ZVVJDcWVlNXlrTDNmU25tTXZRYjZKaXZoVFhFMDZX?=
 =?utf-8?B?bzBrS3hoUXBIVEFIZTh5ZDdZT3F6dHluNnhublJENlpGVXg2RUtTeWN0MDcr?=
 =?utf-8?B?eDh1aU1HR2Rzd1JUeUhQV25oempnMmFyWXl2QWFKUGF0YTkyajlxMENadm9N?=
 =?utf-8?B?bms5WkxpOVd5N1JoSzMxVkhzVHVrTUFMSlNiQkRnbUJpNWpXZktTckhWWWpD?=
 =?utf-8?B?ZUtHd2JzSkttamxOK256MFlnbG81MlpiVFBweUVUSXZPOHVvQlNsTVJUeVFP?=
 =?utf-8?B?YXgyQjJiWDZnbk1CdHBkUGwrWVNmbHlBUmxZNVZqQnBxd3lsMEpNWUxOR3hl?=
 =?utf-8?B?b01ENjY1Y3ltRDJCdnpQVFdDajk5UlB4cUxuS21ubVlrOW1VMXlVL09LRmdu?=
 =?utf-8?B?Vmpma1dQWlEybTFRYngzblVDV0NveUFJRzFCdE1maG9sNUNhZi9rRDFMdWoz?=
 =?utf-8?B?ZXpFYzY1Sk8wQzJ1QUlGSXlpazBoNE5VUGNkSFlWRVlxL2cxZkxQVjl5Vy9F?=
 =?utf-8?B?RDhFNGhQczl1SktqcWovRmY1cHp0N0N3SHQ1dWxuQkNVZTMvTnREZS9NS0Ro?=
 =?utf-8?B?VitKaDZhWjZBcEhyTzlZWWM0QUEwQmk5cnF2aVNiYVVBWHBYUFNZc0xOSzhM?=
 =?utf-8?B?TUorSTNLMGJCLzNrSVA2T3BqNmpzRW55UXE5RzFrbFpucFllUk81S3dacHFH?=
 =?utf-8?B?SW9qb2U2M01ZeWFyYkdUS0hMaFd3bnRBTjBMdUNGd25adUJ2ZkMzanVLbnJL?=
 =?utf-8?B?bnVZUTBtRUJhQUtLZ3F0b3k2alVqeUd1V3pFVXNPRVJEWURkREFTcW4zTEls?=
 =?utf-8?B?NzEvbVNPTFQ3d3lhZFNqWVBOVmJtc0pYMGpUa1F4TVdzcExneWdjdGhJVEJK?=
 =?utf-8?B?TVNGYkhwWkFKdVQwSEtOdi81VXhmdnN6blBtNFJWd2dBVkFRZmpjalFJR0Er?=
 =?utf-8?B?N2dVWGZzdzg2NTdBVHhhMDM4dk1xNkFGeTNhZ1BnUjIzdkhjU3Zhb0VIUTVy?=
 =?utf-8?B?NVRWMmY1Y1FOeDVza0VzdGVZTWxrcTdRZ1JneGZHZXN4aW1EbzNmQnI2dG8x?=
 =?utf-8?B?MUx0SHFIQzFqanFzYzZJemVzWGNzUUxmTldxTFEwWVk0Nk9QdTN2dnhJU3gz?=
 =?utf-8?B?U3NsUmhuWWlBY2IvRkJyL0h3WTJLSkl2U0NRRGdueUE5cGxQbGF3VFRGMkJW?=
 =?utf-8?B?RHFYU0lFWWQ2MzdydGxqMkZKVEdkY2U4MXB0NzRhUC82cTdmYkxpM0llcVVZ?=
 =?utf-8?B?T3BhVTJib1Fkb0EvczA5eGh2ZU53PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFA89F986EADA54A97F910FE8E92E356@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n1vKwyzrpSAxvsLL9Au5evlxDwpbYJEOjpGBj50w4JX4xcrQ0jRbEWqEk+npUMZF0jSCB67oY4ReT/BiN40pyx5K9or5Ci/nvzwJVSGNKT5NvbhKYQw5xHPv2H4diwXnJBfoEPRAr6L0sqxW86GCWrm3j0zJInSmV1rpYSG8YrTJHG+XC/RQyJiJx24E9SBKONZOcxAeOqw0Nn6SE4vQ3h3P4ttz7R+t5HCZF5DbR8DVr/Dyzz+zo6TXEPIV8b9+Mt951NEuXz+fyZTfqElwjsMYmCilFCBoYqxyHb3QajuNEKvuR77yMbsbN4rdhmEOF2mZOu75t0DBFWo7ef7d/7FI0Bpq+3LzjiqaAFZpjHzI3qph/+x0plTDcZmBMLILOcH4Lg4BaFIC1VJz+oZTkUDJthWlwQg4ThPKpOPMUZsz7labmW5OYufK8ptJM/Yw6rH1u8AgiZ0J6oZBk/sc25jzXHWChd0S0A5Yz2aP8dHkDcOcpkgSZHnBG1bDxHq5MqfjJD1Sgd42/K0ZhGh+RUFx75057Roj2njx7HXlEGfSQS3WiR9kQv/pYPLs7mcONeSJIC3Jzs5qCQk/ELCu3EmO+qO7MuMdLAWa4CHnlX4HQzeXJ1iZlwuxkGl9B5jR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0SPR01MB0001.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c904a2-a101-4764-0085-08de28cb6eda
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 06:58:53.6081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYpek+6hM+/FJzUJ7QqDXljP04E2AIfknMFoCV7WHLLJZLARYzLwQ02S0LIXXms1RsexXrHTvAdUV3bxPX8ysIIqfdenxGgoSBZPLF1HG3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8192

T24gMTEvMjEvMjUgNDoxNyBBTSwgU3VuIFlhbmdrYWkgd3JvdGU6DQo+IDMuIFdlIGNhbiBvcHRp
b25hbGx5IGFkZCBhIGxvY2FsIHZhcmlhYmxlIGxpa2UgQm9yaXMgbWVudGlvbmVkLg0KDQpZZWFo
IEknZCBvcHQgZm9yIHRoYXQgYXMgd2VsbC4NCg0K


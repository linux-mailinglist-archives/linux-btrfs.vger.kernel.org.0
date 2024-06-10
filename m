Return-Path: <linux-btrfs+bounces-5595-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABE0901D3F
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 10:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8571C20E61
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 08:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEAE4D8C9;
	Mon, 10 Jun 2024 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QBIa+MFK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QPXf1wNv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF025227
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009241; cv=fail; b=SKiXxxkVu5I//na/wGY47vGYdRn1LdU4T0oc0nncxGGZje2WbOoCTqaLk+GnnzXq22UvfPxwOmSBIodXR5zrZIKw5mNqhfCR0CbIJ4u3PvanYfFd8QK636nQ0Zm427Om8iBDsUUDXDesTbF6R5Yr/fz257IpMS1+zsnjZ72UWrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009241; c=relaxed/simple;
	bh=Eo+HhL30vDE7bhEDTPVB6CK1ev+QD7Cjae2Rtn4Y/Rs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=agu9TZy+TK0KPQUKN1ap8BqkHJ0RgtPls7IVCFPeiOQoA6xdEXZYqx3n3UIW02WPZ0ZLhZWwVWpynw+hyM4CymsfsdsAcgC/2ReDl3uHFQp09asb9QFm2RUd5EzKJ0XFSqD9JLajrFV34LqCXrfmDpYAq0+VdcUBM72o3ki9Iyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QBIa+MFK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QPXf1wNv; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718009239; x=1749545239;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Eo+HhL30vDE7bhEDTPVB6CK1ev+QD7Cjae2Rtn4Y/Rs=;
  b=QBIa+MFKBWp92EF49aUVNApNEttJ7qnu4msBV2jB6d+BWh5IkEQTZ5cM
   Iwj0zd63AYLmhEjaMADGBANpRpUlx8YjQyixi6GHEeChwbhNg517IgSBa
   xstGsEUKeleipq4FYAcnNp2FgyDln+x/pVPmqCIT669D0PQM8+RcnWEUs
   qc/YSHR/BMyoyN7Pu2arJ/yYRGiAMRwxTjggCBDMDAZxdVD8arjfF/e4K
   epQHfOo25PD18mza1Gh/CbM/ntpeBy7rifNSwh+EDg2zZPrdYQoOLykro
   dbomK5jovUE28AJceP84qZbu5VXgjvMDsGhVQsJwVSPHjPOYPDYwhzbYq
   g==;
X-CSE-ConnectionGUID: StulgMGETXuC9rei0YJpTA==
X-CSE-MsgGUID: vuT4JR6mQti0xTahr1pgdA==
X-IronPort-AV: E=Sophos;i="6.08,227,1712592000"; 
   d="scan'208";a="18980863"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2024 16:47:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqFPePJDKd7Y6BtOIaQsOXe/ogPr51O+7RR5+ExzIVeGWt9xXL9cAaTd3Txp9aFCUT3nRPqC+KwD4F/8BCG3qgfTTYmO4KlHJjj1pCDuq0qFFCee048nmoLG0qIMKBg+SDvLupWB3sYw/3afDTIGSk0eEWSVYE+NfJNEMRqdtKzadT3Z9DQ3M/7WBFFcYPOWnGc1VW5xdBoeJjx+FM0rTtCK/aHfwG+LWw+FtHZeeKHkQne7wZZJswwRaKUOrTA7E6W/cp3JSCcv6CHmQ0UGcHHssNbAs0Cs5oEJuh0vLWN6+wVo0dV7AMk6ZFcZU+KMYlNnW/kSR3hH84627l/L3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eo+HhL30vDE7bhEDTPVB6CK1ev+QD7Cjae2Rtn4Y/Rs=;
 b=VlMIWghbTfXX5yhQqurxwUQ3ZBWFTwqFqMVXlBca2pUopJbr62GCB/SntPqr8R/c9PPfY204xxHGa1uhtIvc51a5Jj/k/nWSYhNsF7WVXoA7dbMuy/p/K7MtavSmUo95gdBUdToXtrXzLk2Fc+xMZDICZnehJQlifHCKZ3beBgMSEcLkUmuOjQ3iNrlD4x0wFJdotcU+FQScqo1TJkyNsVAX00Y8FMW6K9PkMs5sLcpsiG/8QNzzPUfSkK61Jdb/sp+2hiGoN9AYm6RPv0uJCkEbK9xIIt9EBjeXpsiCXQBKD/WWiJhWv7OIKo79RT8UiqukCx1MJ2lcHu38kwBxOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eo+HhL30vDE7bhEDTPVB6CK1ev+QD7Cjae2Rtn4Y/Rs=;
 b=QPXf1wNv16ESCwyfOOb9RvA+dyCGTB8kL4rjU1f78yY46hFjtosxK295JFexr+UdNKoWOfBB75t45OpC800duik5+n2j/jgihAd/yXTPS9av9asbPv+V76TyO91/UiHvtWbxg08/NwO7id3xjOjwR1wMnN57sTbi/2FvJbLKng4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB8007.namprd04.prod.outlook.com (2603:10b6:5:314::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 08:47:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 08:47:10 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, HAN Yuwei <hrx@bupt.moe>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>
Subject: Re: [BUG] unable to mount zoned volume after force shutdown
Thread-Topic: [BUG] unable to mount zoned volume after force shutdown
Thread-Index: AQHauhQr6SuMoAb9C0CqQJ5ZLB9fJrG/PLiAgAF0rwA=
Date: Mon, 10 Jun 2024 08:47:10 +0000
Message-ID: <916d8fcd-138a-4fb8-bb0f-196c72f2309f@wdc.com>
References: <CD222A40B0129641+992beaf5-2aa9-4ad4-bb3f-ee915393bab1@bupt.moe>
 <d32e99bd-e83e-4449-a8f9-8eeefb813400@gmx.com>
In-Reply-To: <d32e99bd-e83e-4449-a8f9-8eeefb813400@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB8007:EE_
x-ms-office365-filtering-correlation-id: 3632f80f-6365-45c7-6667-08dc8929eaf8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?TUFDV21lTnJUQUQ0UUdKc2xpQjVkVmk1QmJQUkMvcHdMS0FyVTBjT1d1R2pp?=
 =?utf-8?B?VlJzZEhzRjVmaEJnNUpYYzc5VW5XVzk4SWZmZ3B5ZFRQTlN2aVBSNndQdnEz?=
 =?utf-8?B?ZWlyc1NUbkF2cktJYmprWkE1T3I4QmFWYW5rL1NVUy8wMUN3b0N2UGpXYjB4?=
 =?utf-8?B?Q3JGODN5WUFxdnFqWmkzU0dWNVVmOS93T2cyNUhhc250djh3ZUhHVHZmb01a?=
 =?utf-8?B?dVpxZXo3c056ckVNdGN4R21lbFdsdWRxMlJ0WVN5SkY4ZVJKNk9UM3BXREFB?=
 =?utf-8?B?b0FTMDBsRUtoS0FDNm9VNG1heHZQTFlaZGVNU3l2N1dTZU9Qd0ZzNWZsVGtm?=
 =?utf-8?B?Z1ZtWnY3Vzgzcmd5OEJRZjE0VVBlRFplMkM0UkdwY2J1QXJDdWVIb2pzd3U0?=
 =?utf-8?B?Qnh4VlhzMThjN2Fyb2pvK2lQcEJuODJmazRackkxSkZrZXY2NjE5cy94aitT?=
 =?utf-8?B?dU9JdGsxb08waklMb0szUUh1WisxYUIvUm5NV3htVnd4RFdWeGx3VU95Y243?=
 =?utf-8?B?cjF3ZkpkU3lMZTJ2UlBVeGdLWVZQblZxdk5aS2pqYmdlS0MySmVZVmhXZE1k?=
 =?utf-8?B?ZlVmbHYvZ0dJb0E4L2lYdGI0TEVrRGg5ZWJoOU43c2pWdmN0SDF5RFdNYnhr?=
 =?utf-8?B?aWZTVVViZjczL3hucTFMNXoxWHVXa3JBYXRpNTRuQTM2MWxnSmpTUlBIZjAx?=
 =?utf-8?B?NW00MU1oQnY2V2pQaE5UVlIwTTJmcHZpQjdVeVFJRlg5bW5QLzRENEpVTlJt?=
 =?utf-8?B?REd1Ym9HcG9zcGtPcFE5b3ZjQWxrZWozR3FvMC9xdFZDcFIyYlpGMmVpNTBX?=
 =?utf-8?B?WGFjUzVzT2UzclEzTFh3RDV6MlRWdlRndEV6MFE1Q3VtaGY3eWgvUTFZaVNY?=
 =?utf-8?B?d09OTEJSUElqRGpyNW1rdmtzdnNXdXpvcU9ra0JTSlRHV2plenUrVGppWjRn?=
 =?utf-8?B?SkY2VTNXQ1NxUWxsYUt4RzY4SlFOUnNkS3p6NGVRT2YzOFZRMlZmdGlha2ND?=
 =?utf-8?B?RlYzMi9UVnJ1ZWpWR2ZpdzRyak5kbHh1ZXcvbUUrVzcyUllBbnhkc0I4NTdk?=
 =?utf-8?B?OXNyQ0F0Tmx4MEorK2l1K0cyTWFTQmlCUUxHSUJVVnQvMFJvSG5HblVMLzFv?=
 =?utf-8?B?VGZ6NkhxeWFMMG1wZVNWdHVpa3Z6dW4zY0JManJVUmpxUEJldDd6RjNFRERY?=
 =?utf-8?B?a0hEWDBQVTd3MHpPN3ZObHBRUnM3cnJQTkxGZTJnZEJoakhnTXFiV2tuTStU?=
 =?utf-8?B?VmNRVHpuR0dJK3htREVDVUs1bzFMVkFxYnlvVndvSjVQNTJldkxSTzUzd1dH?=
 =?utf-8?B?bCt2MGxBTmgra0ZNMUlVY2RvM3lzb3F5cWVxMjhYODcxTm5LNU1FR2ZnaitT?=
 =?utf-8?B?MGdsVXZqNWFQYnM1QzAwT2FEVXNKMEEyYlZ0R1diUm1wcXh3Tnl1MUVzTlVk?=
 =?utf-8?B?UHI3WlhWOEZJNjBvZlYvQ3ZLZnJRUjFoYjZGSXcxeTdFWlZERnNMVU5zeVdm?=
 =?utf-8?B?SEV6Q0N3TzVuMERKTEpxd3lLSEpXYzVtYy8vU3hHM3JzdlRxY1VQR2xhc1ZU?=
 =?utf-8?B?bDZJaFFLME5jT3R5aXlqekMxWnR4VkhzRFhVZmd0STNCSXlmUUV3Nkd2T3BI?=
 =?utf-8?B?TkpCNGJiVmVaa3dWZ21SaVBiOW1QYTVaU0o1T04yKytWam45SmVqTG1jS2Zx?=
 =?utf-8?B?Q3pObS82VGJqWFRGM3dGL2dCeUpENnpkR0plNDdRSExUbjBQZTBTeTFySGpW?=
 =?utf-8?B?Sk4zcEE0bjBMam9WdmwwNS9VMTJrbGN6Q29zeTBUem84WGhwR09vYWYyVXc2?=
 =?utf-8?Q?1th3NQ8rvqaJvGaAB4xQ4h9QAMs5zY+o4HyRI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGtXMWdkNDZVTGtyVStvbW1iQmxOR2Nkcy9ORTRBTnBETDdLKzdTVWx5SjIr?=
 =?utf-8?B?WFp2UldSdndtZWptSkNzZ2NpakVmWFFVMU9FSU1IeUpEVUJtendCUnhGWEdn?=
 =?utf-8?B?b2E2cUJnTVI4Z21aRGZzRldZa2ZEaGhndmNXbnh2TWo1elpvZStSczYzYmlJ?=
 =?utf-8?B?a3dWRWVMaDVrNmJwekhib0xsWlZESjVPQ3h6M0pDM3hrbUNKNVRKTDFkNm9k?=
 =?utf-8?B?WXFyM1huN0Z1LzkxZVJnRXIrSTgya3NNYk5JaGozVFV5dmhGQUFnVVhlN2or?=
 =?utf-8?B?aGdaTGdhMWd1U2xUNlBMY2RuQ29ReTQxNCs5SXJxOU9DOGlZWnQ3MFN5QnAz?=
 =?utf-8?B?TFk1cFUwWitlM3FmZ2hJMkl4S3JTc0ZVUUdaQ0JVeDE4SnRDT3NxTVRMQ1o1?=
 =?utf-8?B?a1ZHR3BtdG4rcjNxSnRzUVRwOXRTUWc3RG14OFNlUWZqNGhVcDJjMkpqVXlT?=
 =?utf-8?B?ak9jVGdvN2tVNStwRWl1cG5WK0V5SGlGQTdpdVQ5U1Y2bUZRckMxRWkxTHV6?=
 =?utf-8?B?cUFnOFVvSmZJWHRXenBWRitGcFpod1FKK3NaVFJCZVN5TjM2SzgvMHBZOGcx?=
 =?utf-8?B?QStEZy9RaXFEWDBlV2dOcnZDaFgrd3JIMENQc2ZXS0xBSWh2SXVCTzl4K0Vn?=
 =?utf-8?B?Y3FraUpZbHBjZVlReTV3V2tIUGFsK245cEJFcGtCWTVrbS9BSVpsdzc0MjB3?=
 =?utf-8?B?cE9GemkydVF3eGtTVDRjMmtLWCtRUnozV3JRQk91OTlhMmZTSE5iRnZGRUNP?=
 =?utf-8?B?c0g4YnBnMEZ1Ulp5K3g5NFA2RVhSdm5ETG1LcWU0ZVJ0SkhQVEk2RlNvZGNF?=
 =?utf-8?B?dW02VWQxSHlBOXFxWk1oaFdQZjFWcnZSZ3VVVVdmNDMvdmNMeHBpdXppQ2Zt?=
 =?utf-8?B?UTI4NVJCOUYyTlhSb0VzdGFraTZMeGdUQ0RxLzBHTTNDQklhTlpiYWVMYVlV?=
 =?utf-8?B?anFqMzhGVzUybkRYb044TFo4WXN3MWF5Ym94dVhBNGNGTFU5UStJWnhaU1Zy?=
 =?utf-8?B?UWI4OGlPN00yQ0JSYmxWdmowN2xEMmZwQjgzbTFOZnhYbm1yeHRpRmFnUDdH?=
 =?utf-8?B?dUJnc1V5VENDVW5YdkpLdGg5Y2J4cjRBNEhxRFRTclArUG1KektLSXNPM2pV?=
 =?utf-8?B?b0xoVTV2Q2xPRFovTTdsS042NFNsL25CWWhWNFRMdzg3OTRsNGdUL3dQVFpx?=
 =?utf-8?B?RWtKS1pWNS9YWU16aTNKQmNQWThOY2tPb016cWZxUGNhTjNCd2dseVkwZ3RS?=
 =?utf-8?B?SGZTVDdyNWZoRjNJaFdIQWdScksxV3MzY3Q1L2FndHJhZGxEcmFaRCsrZXNs?=
 =?utf-8?B?dHhIMTRDeVdXeWNCYmV4UWI0ekRUMnRsb0FmYlFad1E5am14cm94aGVlMVl0?=
 =?utf-8?B?Z1RjeUZJYlcxR2l1TmFoQzBCU3NnWTE2VVk2c0lMeEFmZmtTamRuTjlFY2R0?=
 =?utf-8?B?ayttS2grSld5V3lwZ3JvL3VNcnkzV3Yyd0VVWGxBYjMwbXI5QTE3TmZ5MEM3?=
 =?utf-8?B?S2p4b2FqZzlDOTZ4c2dib3NhQWRMTW51Nzk1Y1NjTDFNanorK2FRcWV0TDA1?=
 =?utf-8?B?MTIyaGNTdVZxVWNyQXRSQUZROHpCZEhSZmdhVGhaaEpaRVdvUW5kYVd1dmZU?=
 =?utf-8?B?UHczVmRFMVJ2aEZJODg4dHkxSEZLbVNlRy9MRkxFSDRmTzk5emduSWcvMDE4?=
 =?utf-8?B?aWpoMWZPRmZsWnIwS0FRbStxZVZHdDZ2SGU5bHRzV1ByZStXc3RwSWJOZ3VS?=
 =?utf-8?B?VnVwa2VTQTBzUytBN0VYZWRmYTQvTWxGYkptR1hERDNzL2I5cHBjK0cwK3Zt?=
 =?utf-8?B?T0JQVnVzeTQvR0NWR2FYTzhyT3R1Q1Z6VkVpWitvLzhGVklCb3Zoc0dzanpD?=
 =?utf-8?B?aHV4ZiswWUljMytIaG1UMXR2eWt0cUs4a1ZTNWoyMHNHZjE4S3FBZytLcERR?=
 =?utf-8?B?ZnRidWFnWFVBaGRaeW05bEJ0SlE0R1oxNmlMbHU5SE53c2g5aXJLUTY0SW9k?=
 =?utf-8?B?NWkveFIxWHdVeWdvZ2E0RjVsaVJHSGpZdlZyRXFZZ1dRbHROd3BMQkJOamRF?=
 =?utf-8?B?dW10N0YyYWhQM1VOSjlROERxMXNSVjZ1Q0lOS1RUZ0RpRFNlZEoxYTkxWnJl?=
 =?utf-8?B?WFZHUUxMVngxTTJjemgvamhIcnFFWkhvc0Ntdk9QK0oyTHBxblZNL1ltOVcz?=
 =?utf-8?B?eDdSVkVBTlJ6NGVZQ2NTYlVaZzVhTHVKeTBWaW9pNkVrRi9kL1FJSVhWUFd4?=
 =?utf-8?B?Sk04QVNDcUtqQ0dLNVE3anZpc253PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFE5B1B086921E41A9957BD8DA7BEBC7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GoBQPzY1G4I3XJ6yITupilRmeCPwkqvPisR9blt7x/uIk8A6Vwg5LDLQeR2TzfWGUgZCTtlY9boJAnfa+wXAwpCquoqAwneE9e9YqyAgsNyY4JdNCSOzomaqHlMa0CEvOuzcj6ow/xnfT2g8PFj1pA/zvogVCcbUX1dVbvzGl2NbgaaADT6ft/5qA6UaBGEA8Zo4rRy0xIgvZui/dUWwE/8uFr4ZDHZyGBsLgJ/iVEgQ8OSziurt2UscrO2hhaUxTWeFqIiy0uHFFyhrAZamAsp/xm0vi5GWaaz7QEtKBfbGJyG5oFAJXYspWnu6n5Rh8mHXjMEED/XEO4l3kvYqqNCDS63y+20UFzRumczsfrfs23s4N9UX0SVw1Ek3EaYEXSBGtPL73yOiugUoPhEFirwx8AgBOLVXwP7k+RS09JaCw7gMRWo7/foZuYsfDcI4cL9Av7UPiL1oDETfvM+M0u3QQs+8egA7Hzd8UKVJB1LMHH1agHxLlfTeXKkj8ghXUHGzrWfSw5Wcs5QDKM8yGOzD+OFomHJ9jOILucZ0wJzS04kr1DEATKC4C9MarBHeMIPB8HpmthKLNAh5Y5PF5QpqHdswTzl31uM239PT0lkkG9Gm+JbTgP9Z5s2l9NEq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3632f80f-6365-45c7-6667-08dc8929eaf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 08:47:10.8157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w9GTg5JvhWbVJyoit3Y/NHD31hbRpUzQ9+edjacfAWBqaMOmPMz3NNwHgSxrEFqhjYvDGqrSvtMUVRx4V+/givvfQK11tie7Kdh3o5ARMcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8007

T24gMDkuMDYuMjQgMTI6MzMsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiDlnKggMjAyNC82
LzkgMTE6NTMsIEhBTiBZdXdlaSDlhpnpgZM6DQo+PiBJIGNhbid0IG1vdW50IHZvbHVtZSBvbiBt
dWx0aXBsZSB6b25lZCBkZXZpY2Ugd2hpY2ggZGF0YSBwcm9maWxlIGlzDQo+PiBzaW5nbGUgJiBt
ZXRhZGF0YSBwcm9maWxlIGlzIHJhaWQxLg0KPj4gSXQgZXhwZXJpZW5jZWQgbXVsdGlwbGUgZm9y
Y2VkIHNodXRkb3duIGR1ZSB0byBrZXJuZWwgNi4xMCBjYW4ndA0KPj4gcHJvcGVybHkgc2h1dGRv
d24gb24gbG9vbmdhcmNoLg0KPj4NCj4+ICMgZG1lc2cNCj4+DQo+PiBbIDE5NjMuNjk4NzkzXSBC
VFJGUyBpbmZvIChkZXZpY2Ugc2RiKTogZmlyc3QgbW91bnQgb2YgZmlsZXN5c3RlbQ0KPj4gYjVi
MmQ3ZDktOWYyNy00OTA3LWE1NTgtNzdlOGU4NmRmOTMzDQo+PiBbIDE5NjMuNzA3ODAxXSBCVFJG
UyBpbmZvIChkZXZpY2Ugc2RiKTogdXNpbmcgY3JjMzJjIChjcmMzMmMtZ2VuZXJpYykNCj4+IGNo
ZWNrc3VtIGFsZ29yaXRobQ0KPj4gWyAxOTYzLjcxNTU5N10gQlRSRlMgaW5mbyAoZGV2aWNlIHNk
Yik6IHVzaW5nIGZyZWUtc3BhY2UtdHJlZQ0KPj4gWyAxOTY1LjQ5MjA2Nl0gQlRSRlMgaW5mbyAo
ZGV2aWNlIHNkYik6IGhvc3QtbWFuYWdlZCB6b25lZCBibG9jayBkZXZpY2UNCj4+IC9kZXYvc2Ri
LCA1MjE1NiB6b25lcyBvZiAyNjg0MzU0NTYgYnl0ZXMNCj4+IFsgMTk2Ni45NTM1OTBdIEJUUkZT
IGluZm8gKGRldmljZSBzZGIpOiBob3N0LW1hbmFnZWQgem9uZWQgYmxvY2sgZGV2aWNlDQo+PiAv
ZGV2L3NkYywgNTIxNTYgem9uZXMgb2YgMjY4NDM1NDU2IGJ5dGVzDQo+PiBbIDE5NjcuMzQ2NzU4
XSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RiKTogem9uZWQgbW9kZSBlbmFibGVkIHdpdGggem9uZQ0K
Pj4gc2l6ZSAyNjg0MzU0NTYNCj4+IFsgMjAyNi4yODczNTZdIEJUUkZTIGVycm9yIChkZXZpY2Ug
c2RiKTogem9uZWQ6IHdyaXRlIHBvaW50ZXIgb2Zmc2V0DQo+PiBtaXNtYXRjaCBvZiB6b25lcyBp
biByYWlkMSBwcm9maWxlDQo+PiBbIDIwMjYuMjk2NDQ1XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNk
Yik6IHpvbmVkOiBmYWlsZWQgdG8gbG9hZCB6b25lIGluZm8NCj4+IG9mIGJnIDUzOTk4NDc2MzI4
OTYNCj4gDQo+IE15IGd1ZXNzIGlzLCBkdWUgdG8gdGhlIGZvcmNlZCBzaHV0ZG93biwgYnRyZnMn
IHdyaXRlciBwb2ludGVyIGlzIGxhdGVyDQo+IHRoYW4gdGhlIHpvbmUgd3JpdGUgcG9pbnRlci4N
Cj4gDQo+IElNSE8sIHdlIHNob3VsZCBub3QgZXJyb3Igb3V0IGJ1dCBtYXJrIHRoaXMgem9uZSBh
cyByZWFkLW9ubHkgYW5kIGxldA0KPiBiYWxhbmNlIHRvIGtpY2sgaW4uDQo+IA0KPiBASm9oYW5u
ZXMgYW5kIEBuYW9oaXJvLCBtaW5kIHRvIGVuaGFuY2UgdGhlIGVycm9yIGhhbmRsaW5nIHRoZXJl
Pw0KDQpUaGF0J3MgZGVmaW5pdGVseSBhIHBvc3NpYmlsaXR5IHdlIG5lZWQgdG8gbG9vayBpbnRv
IHllcy4NCg0K


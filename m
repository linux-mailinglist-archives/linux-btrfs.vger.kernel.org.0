Return-Path: <linux-btrfs+bounces-10869-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F220A07C25
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C91188AEBC
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B6821D590;
	Thu,  9 Jan 2025 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y0QtEfE4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GuBtiMrP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC0F219A76;
	Thu,  9 Jan 2025 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437277; cv=fail; b=CQ0/m2L2xyh0sKlw/G7kV4XBEBAJWmlLwzGS8Z4qs7z2uktl6cQt7XO4/LXSbo/LosKKMsZrvnAGSVpXHDFbnV78+8+a7AhJ5Ae21rZiVqw7O1HVKJEX6InUqd9m2FdXXwQs97JRXf6qoEMWftOYENlBsvq27gnDehDQLaswSK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437277; c=relaxed/simple;
	bh=0gasVX7xdQAvICA22aGTvTXTIOBsVdplD8/PXW4nj1g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pypFxfUy9mmgrGhdgPSaUH0IeAasZRcDn1rPXBIEYlELc6IF5ZL60a2Tc4IGYCy8Rj+lXvlV72neTcgvmCc1+UrlcDtEBRehDpDnWQvP3mpxLIbzLk08oL6OKV9v3YQn2eJqqyibqBD3wb5CfhuU7T2rHJ5Sa6a5NNEyL31t9NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Y0QtEfE4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GuBtiMrP; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736437275; x=1767973275;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0gasVX7xdQAvICA22aGTvTXTIOBsVdplD8/PXW4nj1g=;
  b=Y0QtEfE4xO57EMJ5y1VlXD3lrwE+p5OhCckQdFf+esXTKyRhlCHX2xJu
   jdojUlwk1TYHt2YT3HqE93wfK2xm21oPnY9agMEP7QN+z8HS9Kzw6d90X
   YHfLFZv8t5kva8sg1J0u/WK7QSAhpiCIRwo3YD7UAOmPaP0SvwBVE8vsf
   MrV0u+mnm3f79t7Mn17enTFR2sFfp/3xuBa15ECnrC/2trT2rH/dvmDRv
   BV4DomgUNXjWQusyGLj27favSljWc8t3yI1iX4BX9tjtheXh8M8ZNHsXV
   CJg/1Sj16fbrirCPZGWbLwsc12iX4X1crR2IC7yjBLkplDW14AjaNcqRU
   A==;
X-CSE-ConnectionGUID: 6xBMzRnpSJ+KNDRusqLoZw==
X-CSE-MsgGUID: TEl0XOlrTX6UeshU9RCYkQ==
X-IronPort-AV: E=Sophos;i="6.12,301,1728921600"; 
   d="scan'208";a="36763088"
Received: from mail-westusazlp17013079.outbound.protection.outlook.com (HELO SJ2PR03CU002.outbound.protection.outlook.com) ([40.93.1.79])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2025 23:41:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHGviNeZ/7ujFzRp3aI+OaY0jbzW42Q9LfmY6uOmd2ZR5Zq5drfDAIvBGljiS2indUy5w0QZ0HaxxgWVPKvixTxDjhAfjwjZQq6nHZcGQD+Ry2AUvyWDSoqnJajsITeimx90G7FVKgcO//ogI4r3UXX7tFbubeAPbxNZwmWqY16Yip12mdVi825Brby7ws6uXAIWyQKWZVFTwzcxmupkZKD95L9FNFrucJgcnALWe50a2h2lGZ5Vf/huQnTI2lkHjEF0iyWQ4pFAOUemhsYX87wB4rOQ0IbhEabOVC3qXapRBN6HJscrWiVSjm8heM2ofN5F6sOJKMpnAYz4Zc+ibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gasVX7xdQAvICA22aGTvTXTIOBsVdplD8/PXW4nj1g=;
 b=oDv8msLYlfFGnh972DDxPG+zkoFcZcQ7N1J8xPeEMkKT2yyA+qaE+qITXyY4WgFHUW/YZWjFChp412U+YaOxE3Hmm+ShT5pdnGepmgkCmO0frNl4S+FV9xPYrEEtu1r/Y5pzs91O74qelURi3UHCA9Edc4G1PjNaCMioV4iomgS+jgeRaXn/EB8athsEl3eSpBeVI8ozJlivnS480GxbkHgdl9vFfwdskHrMzg692xtdVAlZEcHdGLL95cfMvYiJ6JYhoA0rQr/RmWvOTUNF0ys/vps1K1Esy3TCI/9+f90RFLn/KH6iEsjek9AR336fDa01doc0ukze7uUrsnb5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gasVX7xdQAvICA22aGTvTXTIOBsVdplD8/PXW4nj1g=;
 b=GuBtiMrPZHTmFGEa74bLUmyFdLIH/21WTUkcQTNkTU6CWvbptNTe9H8gVaVgmFm01g92jqaQfE1e74+GyCO8tvp61HRAp0wzZTgtHt8dljoLofBc+mkaOY0HHZwKT3cDOZ/iDYcZDJjG7bBIa0ivxzZmbdFwU4LKsC4EWg8Ng5Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH3PR04MB9039.namprd04.prod.outlook.com (2603:10b6:610:17d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 15:41:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8293.020; Thu, 9 Jan 2025
 15:41:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC: Filipe Manana <fdmanana@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/14] btrfs: more RST delete fixes
Thread-Topic: [PATCH v3 00/14] btrfs: more RST delete fixes
Thread-Index: AQHbYqlQ+83UKouFTUeoh75F2Qp1DbMOlHgA
Date: Thu, 9 Jan 2025 15:41:06 +0000
Message-ID: <4b700c13-0e9e-4ea5-bab5-24290babfe94@wdc.com>
References: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
In-Reply-To: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH3PR04MB9039:EE_
x-ms-office365-filtering-correlation-id: dd41198d-ae8c-4d99-dfd4-08dd30c40842
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dGgrOEpjeU93cUJZS2hyUHhOOXpYMDZoMTJJUWwyOUFMS0lvbDZiRFphZmZE?=
 =?utf-8?B?Z0VNUjFvT2doTmxwNjVvODQ4S1BBRmpkS0dzNVBMdTZwT0VYSEtWMFRoZDM5?=
 =?utf-8?B?UjJxeXhrSktLR0Jmb1poR0dWTTNwN1plTzdGUzZlSEUwZ3c0MnRTS25LRDZ5?=
 =?utf-8?B?MzhyelkwOUtYQTB1VFgyU2g3QVc0UnV2a1pyREI2c0djZHZ1VU1iOEZmUVNv?=
 =?utf-8?B?VUtQeERja2hGNGRhY3M2Z05rZjcvNk1pQ0tGR3dBWldxL1pQcTE2Q1FtdWFC?=
 =?utf-8?B?ZEF6SjIvbUQ2dlFVQmxEMkR4bTg2ZEdEVzE1OHdhNm1TY2FZeUsyWitPejZQ?=
 =?utf-8?B?Zk9RKzNJRzFNS25qMVRGTzdtWldrZU5waCt3NnBZMk5EY2YzL0FKamxWRnlD?=
 =?utf-8?B?U1BRWkJnNVI1THpsZXM3bmEwZzkyNDVBZmFsVWlQNC9xVkxPTW16MnRmOElB?=
 =?utf-8?B?Z2tDMmZZcUttR2U2dUhyY1ZSZGs4cVNGLzlsZjBaU3dZVWZuZGo1OVAwWVEz?=
 =?utf-8?B?bGdCdWg3VmNtYVJPZTBOSnY4T1J3SFltWUF6TFlwNkNlY0xpdmtTZW9jdWpK?=
 =?utf-8?B?ZVBkV0xUNlMzMXZHaHlXclRZR2J5eG9JWFJTaEY3Q0c0VVpBTk1jUHNwLzQ1?=
 =?utf-8?B?UmZzbmNHaytZQkJ6ak9Rdm9nV3ZvYjAzSkN0TTFlclN3TmFTOXhEWjdHVllL?=
 =?utf-8?B?dHFuanpPMTZsTUZMcmsrb21jM3liTmowOXUvaHNZbm9kckk5eCs1NXpCYmQz?=
 =?utf-8?B?Q2ZnRTljWVQvQm9KZHJMcTJabGloeEFYcllZV1NZOWtGNjFPZVpHcjhLckE1?=
 =?utf-8?B?MW9OVk9RN3ZCT0UrQWJ0eU5aaVJXeU5QdlFoUkxzcWsxcXJVUkQwY0JBemFo?=
 =?utf-8?B?N0NKRTJOS2I2WG1jc1BnUWh4WHo0d2ttR251UjhGQ3E4d1ptMW0wTXRXZ1M3?=
 =?utf-8?B?SW9hSkdnN3NrQS9ybmZKajJ5YnlrQjZ6SDV3UnJIVldVdlVRRlBTSWhqUnl3?=
 =?utf-8?B?SFkxek8yMEJFSnc4d2R1YXNrS2JjTjNEQnZtMFFxL1JwaGFYeCt4YTRWeEZl?=
 =?utf-8?B?TUxva0Q2N1kzNVVLeHJPbEJLM3k2ZjRYaCtOY1FGbVdRRE5QYmRPN1k5UWJZ?=
 =?utf-8?B?M2E1WGtpM1JNbTlYa2YwcW5XQ0tnSU1GWE9MTTIrTE9reG91b1EzdGR1b2xV?=
 =?utf-8?B?ZTgrSnMvbGNqd1FUWUh0eksrenlabVhCWW5OQThTM1FnTjFKUnp6UDRvSWtD?=
 =?utf-8?B?ZTRFVUlHdDBDZi8xOHN3QVU5amR6UFJQK1k4dndwV1hJQVZ5NW9FVlNud3V6?=
 =?utf-8?B?c1Bid0NzRDVUcUpLL01ZQjdrNHlsN2M0b1FuZTJhRkJCNlM0YzhwR3B3eTlN?=
 =?utf-8?B?ZFVqYnJieTB3Y2ppYWo0NzE0cUlJU2s0RmszblNta2RJRzRNVmh6NmN4QkRK?=
 =?utf-8?B?cE1PZWpJc2lUREY4Z084Y2F2UFA1aEVvRmRHb0J6RzJPb3BJN3c4MkNOWHVG?=
 =?utf-8?B?RDNaUWNtbkhRZElaMjVEVytIQXk2VXVldG11MUNsNnloYis5RForZndvM3Mr?=
 =?utf-8?B?eGx0S2w2N0M3a0VxTmxicitHMzZ5bmNpdWJ0UVlaRi9SN0JzSE1taTZVWDZw?=
 =?utf-8?B?K29xbkIrR1RCbHEzb2xFSnVMTjRmalptazErYkVLbUdXUERoc3pZclhORUw0?=
 =?utf-8?B?U3VxL3g4NVByZWlOajJqd3VxUWsrUDBKNVFlb3drWHdsbStENmhOMXJheGpV?=
 =?utf-8?B?d0hkejZnNTBxbWVQWFVBYlMxWXRGNWxRbW53dncyQ1V6R2krSjZVZks4UFlQ?=
 =?utf-8?B?MUJpWk9meVJaWmFsc2xYcEFPN2pSd3Z5c2lnVDRYNk5YOHVxRmVzY2prMzJj?=
 =?utf-8?B?Z3c4SVN2cGJsc293bSs4eDBKcVdxT2JVcnZwSlo4QnFQbHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cG95b2FTR1pGYXZUTHBRWnFIcTE4U0pzeVdJaVY4ZUQ5Um1ZVU83ZGpGOFNW?=
 =?utf-8?B?bjVqSmdpUndNNGx0ZFduMkRLV1c1dWg1NDlRMW9vcWJQdFJNMGdpaytEMktW?=
 =?utf-8?B?SFhJQkxmMGZtdzFna3NkeHQzVXVnMEhmcVZJOUM1Rmx6c1FsZ3JBQ2tuOENP?=
 =?utf-8?B?K09aZ0NhK0hvY2pkaU1GWDBzK3d3VE1NQ3JuZmNLamZ4NHNwc1RtNFFoVXVO?=
 =?utf-8?B?Smwzek9UdDQvWFA0K2xLL3JxM2tDdkMvZmgrbDZLZzhXUldrWW10RUJhdGJa?=
 =?utf-8?B?OHhFTWJuZWlxTHJRZUoxNEFYekZLVFNrbGxodk42Y2JhSG9MaitGcGt6VitJ?=
 =?utf-8?B?SDUxTVovT0lZNWQ5NGwxczBFN3lLSi8wUTJjVEdkZTc3Zm15WFMwOHR0Uk9V?=
 =?utf-8?B?U3JELzB2K2RMMVN6UzJtaXo0ZFMzVHhiUlM4Tnc5UHdWYlhLWUZwRWNtbHRt?=
 =?utf-8?B?dHl2MWpDRitoNHNVZndyWkpST2orbTNOOHBxZkY1QzA1aWVnUjlqV0lkekcz?=
 =?utf-8?B?clloWlRoeW9zTHdOSFZFc2U4amRWdjlIdXVTMmhORUxJaURXVGlsWVEyS0JX?=
 =?utf-8?B?bmFIRzhkS3l3dVhsS0FwT0c1Z1YwVWZicDZmWHhKMWdlTTltM0xEdVFkR1JS?=
 =?utf-8?B?Qml0ZmtIOTdWRmFuMzlPd1JOT1NuaXpVU09iQ2dpMkl0am55MktpNDM5d01y?=
 =?utf-8?B?UzBXZWYwZ0JPb3prS3p3L0JiYzA2M2ExL2JaNFdyTm90eTU2QmdJdGRueSs3?=
 =?utf-8?B?R3l3N3FOYUhXdnB0ZjhmT1BSME55V29qSXZJeVVmUVVXeFhmcEs4WTM0OW1q?=
 =?utf-8?B?U29uQldFUTVRckRNUHNsUXMwOFB2SW1QMVUzTnFwblB6WVF5TUYybWlyeXdW?=
 =?utf-8?B?ek5GbXcrWkpJams0THJTbkExMHNCc2ZWVDlsQ0ltNnkxL296TTEzTlZRdVNQ?=
 =?utf-8?B?YzIxdDVURDhaSTIrVGlKODRXbWlOWXlMSjE4TWJvM1h2b1FRamo0RFF5QUNR?=
 =?utf-8?B?cDl5dUNPcDJxMFlNcmFwQUtkYjZMU3plci9vekg3ekZmNTZnVTZsb1RuWEt4?=
 =?utf-8?B?Zng2NDJPc2FaYVEwZGdKemxqWjFiUGkyOVhnYzk4TEpTZVZBODdtUSt4WVFN?=
 =?utf-8?B?Q1RIamovT1FPYmNmd0ZoQkdPMDBRQXZYaW1laG1ESlJFbXdPVHJhd0NKMjBy?=
 =?utf-8?B?RTJJWDZ1ekRBT0tpWFZpSUNpUHdiaXI0NExER0ZPa3k3MGtSQlJ5a0pCU09i?=
 =?utf-8?B?cW40U0pMZTJRajE1ZThPLy95YzBvUGppeTJCbFBUVWpONkhYK2ZaWVlCR3R5?=
 =?utf-8?B?SktvcFE2OTkxLzVrdFl0UU9CcVp2TkdXM1NMTU82Y1N1NXA5cTc4QTlUUUxE?=
 =?utf-8?B?ZFZGY1VlUSs0dVN5TFFzeHZTWHQxVHcyU29BbHY0RkpSVGRaTnFJSytDMFZp?=
 =?utf-8?B?TUxOUlJOcERBbWtNYVROd2lFRlJtK09YdWxXYzRSQzFFWXJCTVlwR1UrbFJk?=
 =?utf-8?B?S1dZSDlZem9MaTNPa0wzcVZGVHdibXFzZjJWNUJXeXFSNllpSjNKNGNQYS9L?=
 =?utf-8?B?cXNLRkk1L1dkR1NaVjNJcHU0NVVTUmRYbno0Zk16elBPTGNRV0VqU2JPcEcz?=
 =?utf-8?B?L0UxSnRROVZRZVc2RUcyc0RsRVQ2cHhHWUpGVk5qaC8rdVRaQk1SR2dTWWtF?=
 =?utf-8?B?dWlEYXdpeUVOUUYrNXQxMXFYbVJkdlhrYUZJSmpZUmNDL0tpMFpwWC9xOCt0?=
 =?utf-8?B?REVWbGoycmZyWTlobm9IRDhJMHllUHpjMk1XTUovM2JBSkY1cnFUdno5MDNu?=
 =?utf-8?B?UllOZ0dEdmM3c2RENk03YWJOZGl5blV0bXNqazdYSHBabUQxcytLMitmV2g3?=
 =?utf-8?B?V3NITGZYdlRGUDFNbEhmQWpvTXBTaGFlSkRoL0xvVnl6dGFJTnU3aDhubldI?=
 =?utf-8?B?dG5Ed1EyVGtpZU1ZWERJU2c5eFgvOHZsbGZ4WFYwOTV3dElYSUlualN6d0R2?=
 =?utf-8?B?ckthTHVtaitseno5WGpHY2t6ZEVrU2sraXlpU2pVVTNSR2N1V1hsMXF3QU41?=
 =?utf-8?B?QWY2alBQZDh5QzhBTHlJeW0waWFrcHN2Zk11SDFSMG9XUzhWOGV2YTVyK3hr?=
 =?utf-8?B?WUY1dWQrZzJvSnNRU290TzM2U3hNbXhIUi9iYkRVWTBiVEIzSFBUakxSQlY5?=
 =?utf-8?B?UVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8A9926A99082E499E989F0005A0A111@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	00oHLmysn+j3fR/XgVeA989+Ra1ZdVktDlh/0LcMVORb/ZHtbd5a5TeSFSDeRMiyQ15B18CsjMZFYXdlpysIIL0Am6YYrJrhE2HENsN9OEtt9sBnJ6f5ZfB1FgkEuxOTr235cc3iRzr0p3l28feKZXCWqXnry38YoX9vBsGSMGr8pw3/QsgqbQ0WZsro2+fOcs+EjJtanY9vtJ957+4A9LOTYNmobL5cyBxNyu9fAy9x71lcMe0rn+sXoUnFqNt82tmk2y+UH/qaAgxHiAPq5ZEq7yLx9mwrgCfPeC08dlRMDAtwR8ervKhQEvrd6KMZBQdXa7Id0fNLKuC/gNUdj2wlS1d2cEFLoSr2bZnmYMXz+D8pyJim/3SRDCJ1ckaC6zo0kPtQXw5woT1HVYq3MnUu50c3Df3OaxdgyPDccMvzjHAt2UrJUJqKJw2Nc4Zrf83OB15F2bFcbH46L4CnJ0zUEDM3vJZAwKx0OEq14vY6eaOvFmACqFYD4rvIFLCz6Q69LD3n1vcupn78wM9QxNA3j39q0BTn7NxaK6WR24A9+G8dt8ngZnZwkFyODLsJ3jseDwNTxvmSPd/r8xXTaCrPYmLYPXUS9mO0Mz065xz/Kle7/AfbPh3ivrSq/glw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd41198d-ae8c-4d99-dfd4-08dd30c40842
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 15:41:06.6554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRMB5jWHBnWSqCPQWK7Uic+gtyTUuHnRPsj5KHiE4sGBx37p2yMxEoEOHjrJe3Xe+Qk1MMjIAWC7KeUkuMSrj7QRViFu1pcLhigk2e0A96Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB9039

T24gMDkuMDEuMjUgMTY6MTUsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gSGVyZSdzIGFu
b3RoZXIgc2V0IG9mIGZpeGVzIGZvciB0aGUgZGVsZXRlIHBhdGggb24gUkFJRCBzdHJpcGUtdHJl
ZSBiYWNrZWQNCj4gZmlsZXN5c3RlbXMuDQo+IA0KPiBKb3NlZidzIENJIHN5c3RlbSBzdGFydGVk
IHRyaXBwaW5nIG92ZXIgYSBiYWQga2V5IG9yZGVyIGR1ZSB0byB0aGUgdXNhZ2UNCj4gb2YgYnRy
ZnNfc2V0X2l0ZW1fa2V5X3NhZmUoKSBpbiBidHJmc19wYXJ0aWFsbHlfZGVsZXRlX3JhaWRfZXh0
ZW50KCkgYW5kDQo+IHdoaWxlIGludmVzdGlnYXRpbmcgd2hhdCBpcyBoYXBwZW5pbmcgdGhlcmUg
SSBmb3VuZCBtb3JlIGJ1Z3MgYW5kIG5vdA0KPiBoYW5kbGVkIGNvcm5lciBjYXNlcywgd2hpY2gg
cmVzdWx0ZWQgaW4gbW9yZSBmaXhlcyBhbmQgdGVzdC1jYXNlcy4NCj4gDQo+IFVuZm9ydHVuYXRl
bHkgSSBjb3VsZG4ndCBmaXggdGhlIGJhZCBrZXkgb3JkZXIgcHJvYmxlbSBhbmQgaGFkIHRvIHJl
c29ydA0KPiB0byByZS1jcmVhdGluZyB0aGUgaXRlbSBpbiBidHJmc19wYXJ0aWFsbHlfZGVsZXRl
X3JhaWRfZXh0ZW50KCkgYW5kIGluc2VydA0KPiB0aGUgbmV3IG9uZSBhZnRlciBkZWxldGluZyB0
aGUgb2xkLg0KPiANCj4gRnN0ZXN0cyBidHJmcy8wNiogYXJlIGV4dHJlbWVseSBnb29kIGluIGV4
aGliaXRpbmcgdGhlc2UgZmFpbHVyZXMgYW5kDQo+IGJ0cmZzLzA2MCBoYXMgYmVlbiBleHRlbnNp
dmVseSBydW4gd2hpbGUgZGV2ZWxvcGluZyB0aGlzIHNlcmllcy4NCj4gDQo+IEEgZnVsbCBDSSBy
dW4gb2YgdjEgY2FuIGJlIGZvdW5kIGhlcmU6DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9idHJmcy9s
aW51eC9hY3Rpb25zL3J1bnMvMTIyOTE2NjgzOTcNCj4gDQo+IENoYW5nZXMgdG8gdjE6DQo+IC0g
SGFuZGxlIGV4dGVudF9tYXAgbG9va3VwIGZhaWx1cmUgaW4gMS8xNA0KPiAtIERvbid0IHVzZSBr
ZXkub2Zmc2V0ID0gLTEgZm9yIGluaXRpYWwgc2VhcmNoIGluIDMvMTQNCj4gLSBEb24ndCBicmVh
ayBiZWZvcmUgY2FsbGluZyBidHJmc19wcmV2aW91c19pdGVtIGlmIHdlJ3JlIG9uIHNsb3QgMCBp
bg0KPiAgICA2LzE0DQo+IC0gUmVtb3ZlIGJ0cmZzX21hcmtfYnVmZmVyX2RpcnR5IGNhbGxzDQo+
IC0gUmVtb3ZlIGxpbmUgYnJlYWtzIGF0IDgwIGNoYXJzIGlmIHdlJ3JlIGp1c3QgYSBiaXQgb3Zl
cg0KPiAtIEZpeCBtdWx0aXBsZSBpc3N1ZXMgb24gY29tbWVudCBzdHlsaW5nDQo+IA0KPiBMaW5r
IHRvIHYxOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1idHJmcy9jb3Zlci4xNzMz
OTg5Mjk5LmdpdC5qdGhAa2VybmVsLm9yZw0KPiANCj4gTm90ZToNCj4gSSBkaWQgbm90IGNvcHkg
dGhlIGltcGxlbWVudGF0aW9uIG9mIGJ0cmZzX2Ryb3BfZXh0ZW50cygpIGFzIEknZCBsaWtlIHRv
DQo+IGhhdmUgZmVlZGJhY2sgb24gdGhpcyB2YXJpYW50IGZpcnN0LCBiZWZvcmUgcHV0dGluZyB0
aGUgdGltZSBhbmQgZW5lcmd5IGluDQo+IGEgImNvbXBsZXRlbHkgbmV3IiBpbXBsZW1lbnRhdGlv
bi4NCj4gDQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIERyb3AgcGF0Y2ggImJ0cmZzOiBm
aXggc2VhcmNoIHdoZW4gZGVsZXRpbmcgYSBSQUlEIHN0cmlwZS1leHRlbnQiDQo+IC0gU3BsaXQg
b3V0IHNldHRpbmcgdGhlIGluY29tcGF0IGZsYWcgaW4gdGhlIHNlZnRlc3RzIGNvZGUgZnJvbSBw
YXRjaCAxDQo+IC0gUmV3b3JrIGNoYW5nZWxvZyBvZiAyLzEzDQo+IC0gUmVuYW1lIHRoZSBuZXcg
c3RyaXBlX2V4dGVudCBpdGVtIHRvIG5ld2l0ZW0gaW5zdGVhZCBvZiBqdXN0ICduZXcnIGluDQo+
ICAgIDgvMTMNCj4gLSBMaW5rIHRvIHYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUw
MTA3LXJzdC1kZWxldGUtZml4ZXMtdjItMC0wYzdiMTRjMGFhYzJAa2VybmVsLm9yZw0KPiANCj4g
LS0tDQo+IEpvaGFubmVzIFRodW1zaGlybiAoMTQpOg0KPiAgICAgICAgYnRyZnM6IHNlbGZ0ZXN0
czogY29ycmVjdCBSQUlEIHN0cmlwZS10cmVlIGZlYXR1cmUgZmxhZyBzZXR0aW5nDQo+ICAgICAg
ICBidHJmczogZG9uJ3QgdHJ5IHRvIGRlbGV0ZSBSQUlEIHN0cmlwZS1leHRlbnRzIGlmIHdlIGRv
bid0IG5lZWQgdG8NCj4gICAgICAgIGJ0cmZzOiBhc3NlcnQgUkFJRCBzdHJpcGUtZXh0ZW50IGxl
bmd0aCBpcyBhbHdheXMgZ3JlYXRlciB0aGFuIDANCj4gICAgICAgIGJ0cmZzOiBmaXggZnJvbnQg
ZGVsZXRlIHJhbmdlIGNhbGN1bGF0aW9uIGZvciBSQUlEIHN0cmlwZSBleHRlbnRzDQo+ICAgICAg
ICBidHJmczogZml4IHRhaWwgZGVsZXRlIG9mIFJBSUQgc3RyaXBlLWV4dGVudHMNCj4gICAgICAg
IGJ0cmZzOiBmaXggZGVsZXRpb24gb2YgYSByYW5nZSBzcGFubmluZyBwYXJ0cyB0d28gUkFJRCBz
dHJpcGUgZXh0ZW50cw0KPiAgICAgICAgYnRyZnM6IGltcGxlbWVudCBob2xlIHB1bmNoaW5nIGZv
ciBSQUlEIHN0cmlwZSBleHRlbnRzDQo+ICAgICAgICBidHJmczogZG9uJ3QgdXNlIGJ0cmZzX3Nl
dF9pdGVtX2tleV9zYWZlIG9uIFJBSUQgc3RyaXBlLWV4dGVudHMNCj4gICAgICAgIGJ0cmZzOiBz
ZWxmdGVzdHM6IGNoZWNrIGZvciBjb3JyZWN0IHJldHVybiB2YWx1ZSBvZiBmYWlsZWQgbG9va3Vw
DQo+ICAgICAgICBidHJmczogc2VsZnRlc3RzOiBkb24ndCBzcGxpdCBSQUlEIGV4dGVudHMgaW4g
aGFsZg0KPiAgICAgICAgYnRyZnM6IHNlbGZ0ZXN0czogdGVzdCBSQUlEIHN0cmlwZS10cmVlIGRl
bGV0aW9uIHNwYW5uaW5nIHR3byBpdGVtcw0KPiAgICAgICAgYnRyZnM6IHNlbGZ0ZXN0czogYWRk
IHNlbGZ0ZXN0IGZvciBwdW5jaGluZyBob2xlcyBpbnRvIHRoZSBSQUlEIHN0cmlwZSBleHRlbnRz
DQo+ICAgICAgICBidHJmczogc2VsZnRlc3RzOiBhZGQgdGVzdCBmb3IgcHVuY2hpbmcgYSBob2xl
IGludG8gMyBSQUlEIHN0cmlwZS1leHRlbnRzDQo+ICAgICAgICBidHJmczogc2VsZnRlc3RzOiBh
ZGQgYSBzZWxmdGVzdCBmb3IgZGVsZXRpbmcgdHdvIG91dCBvZiB0aHJlZSBleHRlbnRzDQo+IA0K
PiAgIGZzL2J0cmZzL2N0cmVlLmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICAg
ZnMvYnRyZnMvcmFpZC1zdHJpcGUtdHJlZS5jICAgICAgICAgICAgIHwgMTM4ICsrKysrKy0NCj4g
ICBmcy9idHJmcy90ZXN0cy9yYWlkLXN0cmlwZS10cmVlLXRlc3RzLmMgfCA2NjAgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0NCj4gICAzIGZpbGVzIGNoYW5nZWQsIDc3MCBpbnNlcnRp
b25zKCspLCAyOSBkZWxldGlvbnMoLSkNCj4gLS0tDQo+IGJhc2UtY29tbWl0OiAxZjc5ZjU3NTdl
OWU0OTQ0YjFjODQ5MGI0OTVlODYxOTk3NGQ3ODhiDQo+IGNoYW5nZS1pZDogMjAyNDEyMTgtcnN0
LWRlbGV0ZS1maXhlcy1mMjY1OTA0N2Y2MjcNCj4gDQo+IEJlc3QgcmVnYXJkcywNCg0KUGxlYXNl
IGlnbm9yZSB2MywgSSdsbCBzZW5kIG91dCBhIHY0IHRvbW9ycm93DQo=


Return-Path: <linux-btrfs+bounces-19413-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CE5C928A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 17:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9571E4E49A3
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 16:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631F3288C30;
	Fri, 28 Nov 2025 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gxARZo8J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1987B79CD;
	Fri, 28 Nov 2025 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764346405; cv=fail; b=bsdCExIVu1lE1emmMRwUVqShDsiCy9rJzr3/1FYyh2nlRI9Ro8ZQlVMnBUDRzWIs9cKcqptPmy/zfReuJxU4X4BVu8B+EtSvPV2Ro9Xv2EJOfeUaFRgafJV4iEi96xsYUVjkvl2eHlwNxL2UGraUCqEoOKKtEvLTxIdNMpQ0vKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764346405; c=relaxed/simple;
	bh=LZatiwkXGpDNQp0fiOSYWJ6I5kcdiAxNmMXeHK2MxDI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FozM7eVWc0zmLKVzKehFgb91w/CVi6BU2s5KRTJR0OvbwKZ1B2xxcHRmoflw+KUMfrcfZVJTzWlyJ7+rgF07hInvf2Q19r/V3rxJniTlNbhlebkSYdpW+VI9nKrgsZkvRIKEZh7As1HJ8AEg+dQ9cFavKazuDUb98z+mgzkcb2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=gxARZo8J; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ASBJsvT1974977;
	Fri, 28 Nov 2025 08:13:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=eZnSuauRDmP/3vPB9OGvCAMGtWoPcY59Lia3EtRJ5X4=; b=gxARZo8JnkWq
	DsTKMvMgRyUYLauk57H8OYx/oM4+mjlZ8dv/DsxlLWYbSN2qJVH0sU5Bj2hJENII
	Q5QnVW36ir7F/X9BVqNuf4A4O6lTZ7c1X0yc6vPvgAfhTkhYJcuecfJPQd8KREco
	uRXtaTwi/N6xY1Hopk7Lv1H7V89CCXEtfsxqbNq3Pu7XiRJQP7vCydhBIEyey05b
	LHJ4yD9y06QU7+TxkCVCoQpTehkgWgORjtjrNweq3IruqmyFC0JAXdbw1y00XvUl
	Qy3lmfGwm0IOD0wFJnRKejC5tmH4PcX6GaIgJc/lsaFEJgn962U73TM05DW1hMe4
	vwYC3G2TSg==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4aqas31t9n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 08:13:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIDuwlEUGv8rNNq3wsOipJavpnyMYj4TA08xkOqwohRY3FUEvlpgJrTRnXSvv5uXOi6eELovYyhFuinE1wJZsdE2amjJ9wUynac0A8FxQnKYRF3RQXyX5yfonnHjUVRwXalKG2ikOx4cazeu5klixfKEtbJmZxRn73IPml6c7KLCsZ4f+GNjl8scypV7+m4TJgbVv/rTKHrF3TcLLy3SAHgf5W0JLuwBAUB5nI4X9B/T9c6Ayk/4oaawvp8J5sHueR+PZJh+uB1QICyx6L/FVz+dfAuF3J9njbxSKqQMVdZiItv+xR54U030pw9QtnbTHNB7zpymi6LrAmm2xjgDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZnSuauRDmP/3vPB9OGvCAMGtWoPcY59Lia3EtRJ5X4=;
 b=rfBcypGetJlrW/GPXQgof2bAaZw0UrL4f7Rcvp5Pvewadd+0wQ3uD98orkMH8etS04E0t+YX6UMMHdww1EyX7JZkUMEPWW/msFGrwdDwjIxcn1ApiKcli3x+kr9vG0KCKaCBVTwaI9gZI1r3UdE08Lx6iUQpuYCQoSJHwb/DGn964MSMFyT8oBZIXL4sY4BY3MMUcleRUTmilBPnHyI5DO6A8PYgXS2U2Yx41zuq9ppjN+3SQHo27u+iVZXPVVXIwiZII7q7y5rsbXf8g8w7ZJL/4qFrdCpXzZdxt1/+Hblw99/H8i/neCzwJzQd7izLSGyJ8LT53q8YOmLCDBcxsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by PH0PR15MB4718.namprd15.prod.outlook.com (2603:10b6:510:8c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 16:13:16 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 16:13:16 +0000
Message-ID: <0405949e-a41a-4622-9c26-8f25b9561e1c@meta.com>
Date: Fri, 28 Nov 2025 11:13:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/16] btrfs: offload compression to hardware
 accelerators
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>, clm@fb.com,
        dsterba@suse.com, terrelln@fb.com, herbert@gondor.apana.org.au
Cc: linux-btrfs@vger.kernel.org, linux-crypto@vger.kernel.org,
        qat-linux@intel.com, cyan@meta.com, brian.will@intel.com,
        weigang.li@intel.com, senozhatsky@chromium.org
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
 <aSmwygmtIVgfm+2o@gcabiddu-mobl.ger.corp.intel.com>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <aSmwygmtIVgfm+2o@gcabiddu-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0192.namprd13.prod.outlook.com
 (2603:10b6:208:2be::17) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|PH0PR15MB4718:EE_
X-MS-Office365-Filtering-Correlation-Id: d26150dd-e5eb-46c0-3900-08de2e9909dc
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2paaDE1T0FxQVJDZ3lVeG9pdzhIbWNNVGJsRnhYWlA0MXRtT0Zodk5SUmZn?=
 =?utf-8?B?TTV2SmhyU21LRldCcXFLY1plQk5COUJGcWRQdnYzVUJWNzI4djdkckRZRWFP?=
 =?utf-8?B?clhtc1dEN1VNOFVFVmZMWENNdjBlNTdFUXpraUpOZFZBYjU5YldLNldPMUZC?=
 =?utf-8?B?Z3FzRnJJWG5TSHhtRFVjeUtCWmRqSGVsTGt4V1JQODZidWU2T1cybUJuUVd0?=
 =?utf-8?B?alF0RnF5RmJycDcyOW82QVAvS2lNRnF1Q1Yxa3BXZVI4RTRtaFZCemdjclMx?=
 =?utf-8?B?UXRNbzBxak03ZzMxNWFHOVB2NVMrc055QytCQ29aQmhUQ2tNY2dWQVkzSG9Y?=
 =?utf-8?B?bmxsZFMzY243Zk9mTnBSYythbFgwV3M5MytVRCtzTEFWVXN1b3g5a3VJQkVr?=
 =?utf-8?B?NmhoUVVtcm5hS0VFSlV4bkF1SEZrRGZEK0xRMFUrQTRQM3I0cVBUTVR5ZytG?=
 =?utf-8?B?ODZwdXVYUnJIZjladTRvOE9rc2J5MVJ6Y3p1WHJKakRIeUgzS1pXVzhrd0Nz?=
 =?utf-8?B?VDhQOHdSVGw1dWlLZkgvVUxHdmFuM20yMFVvb2J4NmhkaXZPTS9nb01IN2pp?=
 =?utf-8?B?ZWk5Vi9yME5JUXpyTnRZRWVvOWI5OXd1YlE2QmdzZyt6dlhJdG9uMys0NVor?=
 =?utf-8?B?Q0FTYWlFRDZKRmE5R25oM0lFOEg5MWF5eVN0WlE0RTRxb3V5R01LWW9tUWdp?=
 =?utf-8?B?UEJWb055S0VCYWg5ODRhc0c5TU9GUVVNUnhabGdMRmk3MHdPS0JUK0dRcll3?=
 =?utf-8?B?elRZU0MvMWkzTDJvazhDdjlyVGkyTEtxQmcyL3lnWHRLT0syNTRYL010K09l?=
 =?utf-8?B?RUY5dlBYS1BraTdoWjBUL3FnMW5yUjlna2kvbEVXcDFGWDVYZlN3Q25DQnRl?=
 =?utf-8?B?a2dUSW11VXdCbUxFaWhncnRiWVZ3aFdEbk5OaGFOSEw2M3dYcGlqYjBHMzM0?=
 =?utf-8?B?Q2czUVpFMVNqckNkbGpmRm8wRGlua3dLRXYzQ2JHNFVWeUcyekFPcVBwVDRX?=
 =?utf-8?B?N2JTSDJyOGZsd3dzNG84RE5XZ0NEVW1mZjdrQVRKVUlxV2tRYk11bWYvS2tI?=
 =?utf-8?B?VWx4TXJGV2NzSk9XdWlxVkh6bmt4cHF3RkowMHA3Y1ZrOFRHN2VWcHBmNE5X?=
 =?utf-8?B?d2Zxek4vTC9Qc1VaQmdncUhtRFlEcW01eEppQVNPMUU3dVJhNlc5bU5pZFVS?=
 =?utf-8?B?eXE1ellaRnVZUDJOZjdBTk9Cb2prd2xlT2YvWG9teUgxVHpvbGZjcjRUWW5y?=
 =?utf-8?B?bW9xQnRKZWZxM0JyWVRRQ01PeHlnWEdJRWRWeUtkekNvZmlseS9GK0c2NVFv?=
 =?utf-8?B?QVJ6bCtBdkZ2bzh4Tk9tSU5RZTYxRm4ySC9vNUVZN2xzM3pvMnBzSzhMWnlk?=
 =?utf-8?B?TTB5MmhYdFlJSlJnZ2hzaHNDaTJJd3dISFAwRDRYRlJ4SXZOWG9NbG80S3dB?=
 =?utf-8?B?MnNJQ29sK2J2Zitoemp2Zk81NlFVTnYydUdJRDlwREJFd08zRU5wNTZYTkJN?=
 =?utf-8?B?NkJpTUxvV0FrQStsMThPK25WaEhLMzdSdld5Y0RPWFVhemFpeWN1NVgxNjhi?=
 =?utf-8?B?S3k5V3dJNWM4TEIyYWdCb3lSZGJFdEpMbFpkZ3QvZER0bEFYNnB6TkJtZzB3?=
 =?utf-8?B?NzRJZ053NnFwbmRFd3Z3VFBUUXpGUlNVT2F0dE1XY0tPc0UzU1BERnJyZ0hw?=
 =?utf-8?B?eDVHeWp3NkdxZWJUbTV1Z2NzUDEvdnV4dzVVek9tQ2lBZEFNM1ZrMitJd0U5?=
 =?utf-8?B?Q1dyM0ZUNlhveUd4djQ5SnZscEtmbStnLzFpcCt5RFdEbWpIMjhJUkFLWE9W?=
 =?utf-8?B?bmlBUGlZc1BVNDBCZDVwUXp1NU1BRFNVSzg3a05nK0l4bitGN1kxNTNPYnNw?=
 =?utf-8?B?ZERZQ1hzZDY0YnpreG8yZFQrV0Y1ei9HY3pUZGNMVkFLci9GYkJGYUFub2Fz?=
 =?utf-8?Q?YFh/p/0HfyJhpyYYdv2zIcqXndm7iCu0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1RBaUxpSk9KOGptNXFQN3J0MGZPbkhpc0RDWVpFOWZPYngzeTRscDBrYm9V?=
 =?utf-8?B?U21GdEw5Wm1QRkpmK0IyZDdNQ1VFSTZiNk04T0ZEdGpQK2xDbUxUWGdGbFQ5?=
 =?utf-8?B?eHU1MWRnOWkyYVlhOFBXM1JqNzlUYkx0c0QydjFJblErOEpxRnYvUUt6Zzlu?=
 =?utf-8?B?Q1dPdXpVSmVNa2F4QlZ2ODlybXlXZStVbTl4YjNpUHQ2enM5bklGaTBTZ1Mw?=
 =?utf-8?B?RmVGZVAwcHBPWlpDaExZa2pEYkc0aHIvcERtVVVlR05wU3RqYVkrQVVBTlQ5?=
 =?utf-8?B?SGVHdi9McWg5MENpS3F1UFNqMnhkeVJIek8rQkE1ZlN5MkczdndqQWc1dUU2?=
 =?utf-8?B?c0lkVUFpWWMzZkg5THA0MWlYTFVSQitoZjNRUVBsNXpKL1JmLzRaV3FOblZC?=
 =?utf-8?B?TDJhdU95WGdNdUVjcXpJZi8rdUExQmk2UmhQNCtLbitjWTZZZzN1Y0taVXdZ?=
 =?utf-8?B?Q2pGNUY2TFdMTFozUTlid3FNRE1pWUJ5WXhNc3RHaGI5MnRFNU8vQVkvRGQ3?=
 =?utf-8?B?TkhOaCs4dkJRMVdqMDY0dVBDRG1WUFZpT0lIUldEZ2Zzc1VtRHV2aG1PV0t2?=
 =?utf-8?B?UjdnV1hqZlByanp3bmpqZ1lISllPRmhTcUg2M2JvQWFkWndIRTlIU05qOU9y?=
 =?utf-8?B?a3FqQ1ZFMmJXejYxTFRyM0VlV2w3cy90VTV2Y1E0MWQ3eFdmRFFTSy9rQm9S?=
 =?utf-8?B?TjdKcHBBck1GTllsWVFDdmUrYjkrRXM4ejNvWE5RNkUrYXdXVEUyZlB0SVdV?=
 =?utf-8?B?czJQT3BlcUhDUHZTT0ZOUzNPemZ3L3o4WmVTcUNpSmY0SWpqQXRWWWhmOE5w?=
 =?utf-8?B?NDhhL3RsVVkzSnFINkNGaFZReG0xY29YUUIyUGZoZWhXUkhEQXQ1SStia0Jn?=
 =?utf-8?B?QytzQm9XUHVaVDBMYkhUdU1RYVg5OUpSVjJjVnE2Z0JJd2d5YS9KRHUyQXlJ?=
 =?utf-8?B?anFzaDgvNy9OMkFXcStMckRSU1N2M25jMnNmMlNPSDh5ZTRFYnFDcEtPR01o?=
 =?utf-8?B?QzFibHNOVjFvQTFibjF4UThwR3BCbUF0bWdMaFExZWd3U0ViWGRPVFZBZ1VW?=
 =?utf-8?B?M1VEUklSZTdEdm5uVnJtNGJ6RUkyVEF4VzBqUEZYamptS3BVUEFSZUVseTJm?=
 =?utf-8?B?RUZ3ZVRKdmI4MzdPQ0g3WWtzQ0ZjeUdJTVEzaFJYTFp5WTl6ZkVrSklpS1gz?=
 =?utf-8?B?bG50VWxPalFtWFdiQWxwRTlUbXcrRFdWWGJHQ2RXYjY1MlBySUNzdVJrOWh4?=
 =?utf-8?B?bTlHUDdFeXdvSmRKemZ0SDA5K0c2NldXUzI5T3ZldTJOMkd2b3U0ZmEybFJB?=
 =?utf-8?B?V1dmbG1vb25yYVB5cURmOW1lQkdIVlNweGxjaGpUeHFmLzRKU2c5NEJaZVBH?=
 =?utf-8?B?UGIrejlaOUhNY1dKcWg5YkN5K0FzUGw4bTNxME9hL3BYTkZOVjJWZkRjcDR0?=
 =?utf-8?B?b2RaM3J3WEhyN1FQcVY4ay8wclAyUXZIWE9LSzF5T05zK1R0cVh4blFSaGM1?=
 =?utf-8?B?MDQ2SW1FZXpLL3RHTWlYdFovS0R4SjBlbkVEU1ZKVjZSMVUybjIwSlozMmlj?=
 =?utf-8?B?UTc4NGpkR2NhdzZ6eWlRV1Qrb1hvS2xiWUdvVnIwOWQ2dkNiM1htaVFnZy9D?=
 =?utf-8?B?K0JJelhIUWlqa0JyaGhIMzdacTFZN3Zra0VhOVl0ZnVYRWhkNHJwc1Q4UGVn?=
 =?utf-8?B?Y2pEMDB2VGRvUGwxdWtYMkRCZ1JZUUhFTDM5cmo5VWNJMjZ6WHBVS01YZmM5?=
 =?utf-8?B?bWtGY1NSd2pkZ0pjU2J2OGVXbUFpbWg2YU0rQnNZVGhuMG1EWVdXWjZBZ05I?=
 =?utf-8?B?eEVPZzNCUDYwVEl5eXN6UWZkdzBKZjdhblErUGxiMjRhcVgvS1phenZnQ2pl?=
 =?utf-8?B?QkhlRnY3QnVSbFArNkpFK29XYjZpYkRWUEI0UnZRVVh1RTU0NG1KZlpNdVFp?=
 =?utf-8?B?ZVEzSW8rb2JOdGN2d2J3dUptOEFtWWdXN2htb3N6eHJoc0puSjVHMkFBUnBZ?=
 =?utf-8?B?V2gwc05uaVBVWXcwVjh0REMyM2pZbDdxNzljbXVXeFhkSHFHU21GYWxOMlFh?=
 =?utf-8?B?U241OCs0eGwwL0JKckduWTJZdDc1Sy8rL0JKQkttazJ3clJUQjhXRk5ObUFa?=
 =?utf-8?Q?vaqA=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26150dd-e5eb-46c0-3900-08de2e9909dc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 16:13:16.4918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hShUsH+0FiCfnfidC1OjMx8dWytW66K0NeTomUDxdQkj2yxkiyycNRJZzBm3bYSy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4718
X-Proofpoint-ORIG-GUID: YFAivZV5S82CqYjOajuknQbCyBaD_6Qm
X-Authority-Analysis: v=2.4 cv=NMvYOk6g c=1 sm=1 tr=0 ts=6929ca1e cx=c_pps
 a=v7DXidBSvHT+GL4JoI7fUQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=4qWzBPTriSYewp5v3jUA:9 a=QEXdDO2ut3YA:10
 a=Qzt0FRFQUfIA:10
X-Proofpoint-GUID: YFAivZV5S82CqYjOajuknQbCyBaD_6Qm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDExOSBTYWx0ZWRfX+a5TCi39BW6n
 /8Q5JpM25IbsC1IE4vPvY/fXSsVsbU225yYMq9GniKV4cWsmbZw4E5+pQC+vzhZc4NgvOdJ2ao3
 WEhfv6XmXDu/fGmqLZHxI0W7OUtCFshbvLcK21PojORMUxIzd9rSTFFtF8yZWMs+dpOH880XJg/
 PgFRKVmdOP3ROHJ/1LBtxR9SyU8K2RFcPt4DBhp22cNxxk+2TSSs+jMI9nuEMHKGbCr5iyGzMRG
 hgoHkJ/+QblNTNKJSRte83T3VCT4LcnoU2+EO5qVCxlMwJGYWBHmxzAlkz36DSKWLmV6VlDyNdR
 lOBNoL2tworiQMPgaIeePuBax2NI/KeZnVqr8kHzjJi3zE5HvV1tvcy/oGZ7/H7ZtVu5Czm45cx
 KSMwB1bCnakTjPicVa+o2e/IixZvmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01

On 11/28/25 9:25 AM, Giovanni Cabiddu wrote:
> Apologies, I just realized that there was a typo on one of the email
> addresses in the TO list (Chris Mason's).
> Let me know if I shall resend the series.
> 

Thanks, no need to resend just for my email.

-chris


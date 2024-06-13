Return-Path: <linux-btrfs+bounces-5717-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95482907B82
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 20:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217121F2564B
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 18:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7565D14D299;
	Thu, 13 Jun 2024 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Eog4Hs5v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qXPNdMmQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28AB14B976
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303593; cv=fail; b=YIHTqUIn2k/mRRP/3xXi4yn17YWbq9Le7u0rFFwNi694VvMKRQ85VehFWQuStjbtT6hI/92wwqTRj8wQhJb0jWX1lfTnVlQyVHWqTixvLwiXal5e5CTdeMCY6ezgJrzx8kXl8DK4XG3W+RzPvqSnM0Ka+rXRkhv1H2aS8qo1l98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303593; c=relaxed/simple;
	bh=U/kLJibf5mLwYFSTH6RvbD5ZHpMyN0LOY54vm2vm5es=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DaHuD54UTKqHxhphWh3O84JS+JPwuCG10bgFWr+mHoqG7e2jY2GzBDwbm0sTbBsCl2qdVjqa0Dls6sqVnHKKMMykiuqw3yRD+bc+6uaovCFCcyZjgGN1nfBPztRqCQGeKwAvc7xC6uKqweS4wymaXYW85dKE3t4YYa98b+n12Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Eog4Hs5v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qXPNdMmQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DEtQjt028967;
	Thu, 13 Jun 2024 18:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=U/kLJibf5mLwYFSTH6RvbD5ZHpMyN0LOY54vm2vm5es=; b=
	Eog4Hs5vfp2frRXU2Zhs8B7m4XwuBjD7f+CSEdKct6Ag5KNpFdRVvp9yZk1TVNKl
	gTdfCKEjhWOv8w8Cu0RiDgVQPCoMWggM/ceCbLMmM1xvonQbIj04Dy6WESJvoN35
	xPHw9UrVei+g0a1dJCBA0tso69nZvwBrRdIE0XojvKnyWhll+RNbI2ZXsq+eyUWb
	u1P+q9f3smUVbLYNHosc06GcTJjxswPltbtZcRRoMgkIYEMPu2Hly5RRwNjARpg/
	aTw62GGQeLkECfUdwYsZk3qgvHwBU6w6hSKNvNBX7+QD2/kMhofg/EvOdkL2W9Tf
	ZDcrHFAlAswlBDi8Im627A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1mj85w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 18:32:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45DIL0sO020039;
	Thu, 13 Jun 2024 18:32:54 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync91jp8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 18:32:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBFIKpsYr2ffxgZYJQL9YZOUjDEVE0e3+iFQOOllWaWQ+FxNtwVK3jDt2kt8H5CmTdHUhh8gcIfy9lmUzM7BShVNRi7+yJHtybl79Y9EfAz6gA2gL1uBQG6iUOR+sdeVdWJLxgVSXT78mK7Klj9yW8hbg2yZ3wUHDqyre0H24vgmseJ/6bE1p1sj7+NDvmVP3QjQM7nJ0GUBzsNXRClw9yOsoWvCYevW5+7gcFujZCdhPzLt4INaxdeM/apX2M2INzlrSt3yLmiXtEatyVDosVOP7x/5Mzk7I6+8pNwBTj4nNHApoylJm5sIQb4IyXoc1PLzoqiuCd16mXL+WA9Jaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/kLJibf5mLwYFSTH6RvbD5ZHpMyN0LOY54vm2vm5es=;
 b=gXi3wV7/sNKr9Cq95dwVH1VEELQLz/FBECqxZho7+zIK5ZG+/ht0W7ad+ZifM0v6UwENDUFtBtaz7pVSEQKWEV9Grp9oXBtoCOaoY//XupS5XzqwrkjM/APUn705WqvLYmEzt1O00YzVZOSkG57BpXsRzbf46QLwEltCdQR0jVJsSeeJjpe4ntUltI1g1Gwbkv4Pos8Xp8XE5sQS3EBUQJJHNFRf1uUpo1RTFc0ejcPpk75gNMO9GlVKRDHzrEqPMtTatcIaLvk6nQnKRp6jwMJ+oj0BSOfeYrmcjoh7lewKPF+y5odfbnHK2d8J2+3TUjRGjC8JdZCpS8lKqq3kzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/kLJibf5mLwYFSTH6RvbD5ZHpMyN0LOY54vm2vm5es=;
 b=qXPNdMmQNBsZUHjonhXKVwWhUKQtIskmRqmfwTB7MGNCJ0yypTAVedo2Naq86Jks+MD9vmc+YaoBsDmx2f/aB+QIbp4VwnzbKw6Pmf7wo8OBLk++17wNysAVPjFOtO8L1rcvKdi2GYeTJfQxHWmTK8nNKTnkx/Dgsov8O12Kywo=
Received: from DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11)
 by BN0PR10MB4919.namprd10.prod.outlook.com (2603:10b6:408:129::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 18:32:51 +0000
Received: from DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::1e9d:8ed8:77a6:f31f]) by DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::1e9d:8ed8:77a6:f31f%5]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 18:32:51 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>,
        Rajesh Sivaramasubramaniom
	<rajesh.sivaramasubramaniom@oracle.com>,
        Junxiao Bi <junxiao.bi@oracle.com>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
Subject: RE: [External] : Re: [PATCH v2] btrfs-progs: convert: Add 64 bit
 block numbers support
Thread-Topic: [External] : Re: [PATCH v2] btrfs-progs: convert: Add 64 bit
 block numbers support
Thread-Index: AQHauGDoDe2/f94lNECPwQghwg/+QLHCGSbwgAKG2ICAAW31IA==
Date: Thu, 13 Jun 2024 18:32:51 +0000
Message-ID: 
 <DM6PR10MB43472D82C0F98094C31F77B0A0C12@DM6PR10MB4347.namprd10.prod.outlook.com>
References: <20240606102215.3695032-1-srivathsa.d.dara@oracle.com>
 <c3060faf-f0e8-4bd2-865b-332e423a8801@gmx.com>
 <DM6PR10MB4347A0EADF68B973447C5591A0C72@DM6PR10MB4347.namprd10.prod.outlook.com>
 <20240612203743.GQ18508@twin.jikos.cz>
In-Reply-To: <20240612203743.GQ18508@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR10MB4347:EE_|BN0PR10MB4919:EE_
x-ms-office365-filtering-correlation-id: f3477866-e749-4e52-b7ee-08dc8bd73bad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|376009|1800799019|366011|38070700013;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SURBTDR4T2I1MmE2cFhCSXliZjEzdkdyMzhLajJHSTB0QjFSaHQwVCs3eHZp?=
 =?utf-8?B?b0VXS1dUTVErdXJNZDhaN0tRWnIwVEVPbFcwVWdYY3FWVUJQcUNEdkhXR3VS?=
 =?utf-8?B?d0dybWJlVFlzV29KR1c4TnYyaG9hTTFWajZKRGNVVVlMU0xkUEFBUDdlMlQx?=
 =?utf-8?B?OGhPcGxIaytkYzVOd3BCL1B6b1BMNDQ1NmpEVjVYVFllam81blVrNWhrVUg3?=
 =?utf-8?B?SEt5VnptQjliWnJTUGtCR1VQZkFHZFZIL2JUWWhSaEg3L2RSalM1L3RJS0hW?=
 =?utf-8?B?WGp0MWRNWEg5N3cwZ3JnUnBncE4wOVJPYnZZL3VxMjdaWHU3eFFibXJnUUV4?=
 =?utf-8?B?ZUN0Q05FSWdwbGpEREZJaG1BcFU2RGs4U1RVeHZ0ZmNCZHNDUXN3QTg2QWhO?=
 =?utf-8?B?WG1XYzN5a2hqN1R5UkdiRllMRnBEbUFuaXZWUG1zRDRHS2JURHZSbVVqeXJ5?=
 =?utf-8?B?WUIwM0R4a3VBNjBJWFA3bEplQk5ZYUN6ck92ZlNMTE8zZExCRDl0MEEvc0p6?=
 =?utf-8?B?R2c3a210K0hBdCtrTmY2M3plQjBPK3BteG9vVXd2L0dFTHdyREY5ZEdoWEVo?=
 =?utf-8?B?cVp5cW8yMmFiWm5sMEo5TUwyM3dhNjhLRFRGWldrZUV1ZVRoM0tOeEZRKzF5?=
 =?utf-8?B?cXNpTUVtbjl1Q3h6Wm10Q2RBUUd3dmNleGNkZG94Uk9OZmU0eEJKY0VnWXFM?=
 =?utf-8?B?dFdlbFBYZUlScndKWHljeldrMmw5S2hWK0dtWFIwYUI3Y25EbUpKUEU0OWty?=
 =?utf-8?B?SjZTRzNCM0ZtQU0rRUV5c0w2bVpRcEc5TVF4Y2Fra3YzbkwyUHR3NVZ5WDYv?=
 =?utf-8?B?b01jaDlvdFZJUHZuSlEzRGdPQzhVUkdwYlJrQ1FhVXVZMkROL2JlWElBeVU2?=
 =?utf-8?B?QzgvZmIxY3k4OTkxY3NjQ3JoNHIvZUFaMmthOWhza0RoUjFwb3dRNE9tcmlz?=
 =?utf-8?B?NVFHZlROZTBkQzE0Z3duME02S3pLNFZ4ZUFVWEhiYlY4NEpoem5RQ2FhMlhF?=
 =?utf-8?B?YWIxSW5qODBsUVNsaGlreklrY3RHYlRZeFllTmU5YnNoZlN2cTNRY3ZWbE1s?=
 =?utf-8?B?T1k0M2ZpRFNpd3FxYXh0QmFNTkNvRzMySU52ODVBVlNyWUNDM0E4V2s5ZEE2?=
 =?utf-8?B?QnFSZWxKOW01Z2szMm9oVGpJRzU3MEY5c0RIYnVHUnBTc3l2eVB2Mlc3MVJk?=
 =?utf-8?B?a2tWM3A1aE1XOEZ4NWxEYVNIb3NrQXl2ckpHMlhwaXFTNzdMeFBkWkFDQytU?=
 =?utf-8?B?LzRmanpzdEVXSlNXSzBBcVFuN0ZiVFZFdVRyNVpsNkN1S0V2Q1RadnFmcUxC?=
 =?utf-8?B?QnBFRUlTKzZ4cVpWd1F0bkxQNnBlNDAvL2oxMTdiYUpWSjFIK3pERWN2SEFH?=
 =?utf-8?B?VGViQlBSZWtpTy9QZDNTUXA2d1RLam96RzFkaUM2dGU0VjUwT0ZTMnVueERW?=
 =?utf-8?B?VEJXb2lidFNlRHNpQ2xIa3JhY0ppUDNSOTBUK1NKbWRBZ3JkbmdQZ0tEUWhn?=
 =?utf-8?B?YXpoSHRqWG1OOG90NGYxZUM2aUdoZ0hsMVF6cGxEQ0ZVR2oxNFRiSmxKUkg4?=
 =?utf-8?B?MDk5TGpKUlhNakYyNm1NNVpaU3dmZVVyWndqeDVXNEtrenBySEhCdTFMeGlW?=
 =?utf-8?B?SnZpY1owMk9DUk84T3Myc0hpYWVJdzYwdnpQN0cxelNHaTc1ejhyUlhzczZK?=
 =?utf-8?B?RllOOE5qaE1rR2JyZjRTRGJXbDdlbDZTemlra3l3QmNnVXVzb013N3ZPeFM3?=
 =?utf-8?B?WXkvVStWTFVOTEI0UGhKUjJaanI2dnUvUFJ5V0pVdFI1UmNDZzJWaDg1WjZm?=
 =?utf-8?Q?lKlZohoOwz7mqfFt9lgZSfFaMTI06oi1dJNRQ=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4347.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OTBVUEtScEpTWW5lRk54ZkZWZTQ0ZFIwNzV5ZW1QMnRVTVR5RUZMMjQzSVBm?=
 =?utf-8?B?bzdVTDJmSG12QnVSNGVOVTk1SVVUVjliZ21sUEhUM1MzdWYyVmFjMjEra3hj?=
 =?utf-8?B?ZUwrZ2FvVkRYUG95dHRGdVhMTFN0QTF5ZTM0UGFMSGJ4c2VZdmZTcG01U0s2?=
 =?utf-8?B?amRxQVlxOElLb1gxL2Z5QlVrOUlUV2RKRzBRTzJMTk1hRndtQmJHYW1KNWVh?=
 =?utf-8?B?U0NyUXA3bWR5SUFCQUtBMzJrNnpjM3RVZzl1aEVKdHZRZ1JFZU5nZVZlYjEw?=
 =?utf-8?B?VXpUdW9KZUV0UWhlSDZrNzhXeWdkVXlTQ3BGVVNwUklCSEJnZE9CdUJkbnlK?=
 =?utf-8?B?azhJdFhWdi9DRE9jYXhpeWNOaHJJUnFVRVFIdjhxSWtRYWZtYnQzTjVOUkNp?=
 =?utf-8?B?YlY0UWl5RFdOSzByR2llWnFaMFNLWkdUbXZoQ3dHMFB1OWJ4akxWNjBRMDNP?=
 =?utf-8?B?dFVnd1ZWUDI5Z2xTc1hpWG1BQ1pzNGorOCtXUnpwcFpLV3VYVlB2OXo4TWxT?=
 =?utf-8?B?NS93N2k2dnJ0TjIrRUlwNVJ4dk1QWXFUeE1aZVN1dDNoWjB4VzNSTERqelpG?=
 =?utf-8?B?SWFoOTdtTnUrRlJiblZTb3g5YnNxVWpxck9qVlBtM0tBTGxqWndxczNlRUJo?=
 =?utf-8?B?L1ZIaWVHWFYxWU1DbkRGZEYydFY4Zndsbk15SENnNVJJWVZvV2hubzZtanJM?=
 =?utf-8?B?RW5HKzhIQ1lIU05TZnZVQlFHMk12YjFzVlVJZlNLUjB1WGE1YVp4ZnFnUkdX?=
 =?utf-8?B?SitXY1J2UkQ3KzFqSVBPOThsRnowQThXR2MvdkZGN3hlampCbFh6cm10NnFH?=
 =?utf-8?B?NWtLQTJKMllvSUZDdHZOVXNSTmhlYjlqRDZxSjI0TUI0ZWliODdLNC9kOVpr?=
 =?utf-8?B?VkNHbWw3eVAxcXZvQTJyOVMzV29BVDRtL3NMZklIM3NIQ0VtT3NBYjVZb3RP?=
 =?utf-8?B?SVNCVTRZN1p5OXpSME5ZTWFjMVRlMWdyalpKUEU1ZnhCMHZmZnVZdTJzbDhZ?=
 =?utf-8?B?KzVVTTZ4WW4yblBrQ25KUWVXM3A5QXNiZzd5Mi9Pb0tuMHdBWkVOVFhqYWRS?=
 =?utf-8?B?NEEzeTEvLzdnME1hUk9ydVRnRjM2T1VTeXBjRHdYbTJJdTNYM0hLd0YvQ0VH?=
 =?utf-8?B?TER2ZjhKenJLRkJvR1dBNGppbUY5ckgvYXRKYW5HakdLUVhpKzcrVXR3SVho?=
 =?utf-8?B?SzE3REZDdDdhYkU5L2l5ZDFWdWZkTVJodkJiRkRiSWxyczlHTGg2dGt5VDJK?=
 =?utf-8?B?eVV1bkRFajRxYnFTL1JLVlpuem1xV0Y0L2gxUVd4SGtwOHlweWVFYmNKL2Nq?=
 =?utf-8?B?eTVGb2ZXS3lMbWVzYno4eDNLbkw3K0VPWFZwWjk4aDVLbmQvWUM2RjltRHdQ?=
 =?utf-8?B?UGFzVkVzb0tvd1ZNcnpzVEVRMzdsRStYa0h3bXBwQ2RJVGQ5K1FtdlhqME4y?=
 =?utf-8?B?QnQ3RldabE1HQ2g5OFdoMUdYbFFlWXFNbjQyekZvQ0VxN0ExazdxN1RiMzJL?=
 =?utf-8?B?bm4zbGZnbFRtZWViT05qcWhSTEt6QVM0L3JXSTRHZlNQOTNHb29VLzIwaWFj?=
 =?utf-8?B?aS9yQ2JBK0hvVHZzbmtFY3FhK1lLVEw1S0FoemZ0R2xkcWdNcDdrck1Ca3Qv?=
 =?utf-8?B?QUp1UUppVFduZU5tSS9kZWRLWEdESWNVdlFzYjRCYmJKTVlWTzVHSzhZeHJx?=
 =?utf-8?B?SUgxUGVyT3FDVGQyMFBVc2JndG5KOXFTamRLNy9pVDlldkRPbkNtOERmQksr?=
 =?utf-8?B?RTNKZWpxRWgvRS84a1FFRFNoek5YU1REWGI4MzVXSXZqa24wRVNCMW5sSW5E?=
 =?utf-8?B?aERtam5PT0pWdWhGdHNnY29HYmJtNk5VRjJDMVN4ME5mRjlTYW5vbTBITkVS?=
 =?utf-8?B?YUpyTmRUM1ZrVDU4S3Z3Q3pkQnB0Q2VnRkNLZ29hM0RnZjB5RjdMd3RnUHZo?=
 =?utf-8?B?T2pGVFFaY3VVSG1vMEV2Q3JjaWJSdjJFYm5jMGdlZ2FudkE5di9kVklSa1Jq?=
 =?utf-8?B?cEQ0dTFDU3Evc2dwVjFVMTRBYVhqWGVkVWdsb3A5cEphWFhXanBTRUFPa3o1?=
 =?utf-8?B?aUNhaThlYXcweHpQUXVPUE1PSkRZQzhHWi8wWGphVjRIbnBGTTAwelhXSllZ?=
 =?utf-8?B?WDFFMXJCb0lkWGJXWXVBOVBUdjl3dWg1WXc2bFUrdzBJVUtpRDc0WmFvWlJt?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8mTEj314hwTIuV6vonfdeEP2/yGTpTPlg9HyEUsIaJgRcuE7ZffwgpaKxcVqqor/Vg8uYEo7mz9EykVCj9nvH5pA/yOmozV0K2mhtNytUdRs4eUW3CRKlDK7496iad5Y8AwmZ0jfRSXRwyaw0b//X/iSW2Kx13Xdi8/YxgI5IbtYiX8F9Bb7SFuurFSxMpIgxXDepTFuVszBti2VgcNXT49OfHywOT/FF5+Dh7Obeu2FdK0cN8apJvEIwTtl+lCkoxL2/Tn4+Ymy6THXf79xMGjUhbNQzUAyfwGb0qsVbeTYlVJ0wvdXVh3zHSY1k7y3V/pLZ3D2SkIbzSLk8GHYQys4RUCBSZWFK70XJ/EF+qag77frG8PshJUKfyFIFe7eoYD4wrRXDRROXjTQK3hbseg9MB8N0VmCy+sLr2W0D/Sxhybvle0M0luJ8DKCZbBgdiTKGqebduf3InxP5Hp4PB/9yu3Eg0IA5jsSR4BXGmDup16+I2u06+4Pbi/1bm+/p3HUufVfWw+FyatIotxueEvWfxI0SYQ+Azvj14GyP0IdycViKMnVS5nLFYRf+bch+66wfM7Cm+B0yaChah66ITEvG/THPkyxpgqog5dlJ5g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4347.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3477866-e749-4e52-b7ee-08dc8bd73bad
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 18:32:51.5094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5x59kovG2ZZnNpeskTeC5v1Ib8taOVr+6WOvPEylraZ6TGIQH7rWrB04o8SvRQXeuPdfzSpmLkJBDOOfTVOrzhvpLjiEGNsevA6Y66nPGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4919
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_11,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130132
X-Proofpoint-ORIG-GUID: orEC7i-bpAQSlRufHCFkgcSLMON4IT6f
X-Proofpoint-GUID: orEC7i-bpAQSlRufHCFkgcSLMON4IT6f

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBTdGVyYmEgPGRzdGVy
YmFAc3VzZS5jej4gDQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDEzLCAyMDI0IDI6MDggQU0NCj4g
VG86IFNyaXZhdGhzYSBEYXJhIDxzcml2YXRoc2EuZC5kYXJhQG9yYWNsZS5jb20+DQo+IENjOiBR
dSBXZW5ydW8gPHF1d2VucnVvLmJ0cmZzQGdteC5jb20+OyBsaW51eC1idHJmc0B2Z2VyLmtlcm5l
bC5vcmc7IFJhamVzaCBTaXZhcmFtYXN1YnJhbWFuaW9tIDxyYWplc2guc2l2YXJhbWFzdWJyYW1h
bmlvbUBvcmFjbGUuY29tPjsgSnVueGlhbyBCaSA8anVueGlhby5iaUBvcmFjbGUuY29tPjsgY2xt
QGZiLmNvbTsgam9zZWZAdG94aWNwYW5kYS5jb207IGRzdGVyYmFAc3VzZS5jb20NCj4gU3ViamVj
dDogW0V4dGVybmFsXSA6IFJlOiBbUEFUQ0ggdjJdIGJ0cmZzLXByb2dzOiBjb252ZXJ0OiBBZGQg
NjQgYml0IGJsb2NrIG51bWJlcnMgc3VwcG9ydA0KPiANCj4gT24gVHVlLCBKdW4gMTEsIDIwMjQg
YXQgMDY6MDM6MzBBTSArMDAwMCwgU3JpdmF0aHNhIERhcmEgd3JvdGU6DQo+ID4gPiDlnKggMjAy
NC82LzYgMTk6NTIsIFNyaXZhdGhzYSBEYXJhIOWGmemBkzoNCj4gPiA+ID4gSW4gZXh0NCwgbnVt
YmVyIG9mIGJsb2NrcyBjYW4gYmUgZ3JlYXRlciB0aGFuIDJeMzIuIFRoZXJlZm9yZSwgaWYgDQo+
ID4gPiA+IGJ0cmZzLWNvbnZlcnQgaXMgdXNlZCBvbiBmaWxlc3lzdGVtcyBncmVhdGVyIHRoYW4g
MTZUaUIgKFN0YXJpbmcgDQo+ID4gPiA+IGZyb20gMTZUaUIsIG51bWJlciBvZiBibG9ja3Mgb3Zl
cmZsb3cgMzIgYml0cyksIGl0IGZhaWxzIHRvIGNvbnZlcnQuDQo+ID4gPiA+DQo+ID4gPiA+IEV4
YW1wbGU6DQo+ID4gPiA+DQo+ID4gPiA+IEhlcmUsIC9kZXYvc2RjMSBpcyAxNlRpQiBwYXJ0aXRp
b24gaW50aXRpYWxpemVkIHdpdGggYW4gZXh0NCBmaWxlc3lzdGVtLg0KPiA+ID4gPg0KPiA+ID4g
PiBbcm9vdEByYXNpdmFyYS1hcm0yIG9wY10jIGJ0cmZzLWNvbnZlcnQgLWQgLXAgL2Rldi9zZGMx
IA0KPiA+ID4gPiBidHJmcy1jb252ZXJ0IGZyb20gYnRyZnMtcHJvZ3MgdjUuMTUuMQ0KPiA+ID4g
Pg0KPiA+ID4gPiBjb252ZXJ0L21haW4uYzoxMTY0OiBkb19jb252ZXJ0OiBBc3NlcnRpb24gYGNj
dHgudG90YWxfYnl0ZXMgIT0gMGAgDQo+ID4gPiA+IGZhaWxlZCwgdmFsdWUgMCBidHJmcy1jb252
ZXJ0KCsweGZkMDQpWzB4YWFhYWJhNDRmZDA0XQ0KPiA+ID4gPiBidHJmcy1jb252ZXJ0KG1haW4r
MHgyNTgpWzB4YWFhYWJhNDRkMjc4XQ0KPiA+ID4gPiAvbGliNjQvbGliYy5zby42KF9fbGliY19z
dGFydF9tYWluKzB4ZGMpWzB4ZmZmZmI5NjI3NzdjXQ0KPiA+ID4gPiBidHJmcy1jb252ZXJ0KCsw
eGQ0ZmMpWzB4YWFhYWJhNDRkNGZjXQ0KPiA+ID4gPiBBYm9ydGVkIChjb3JlIGR1bXBlZCkNCj4g
PiA+ID4NCj4gPiA+ID4gRml4IGl0IGJ5IGNvbnNpZGVyaW5nIDY0IGJpdCBibG9jayBudW1iZXJz
Lg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTcml2YXRoc2EgRGFyYSA8c3JpdmF0
aHNhLmQuZGFyYUBvcmFjbGUuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gICBjb252ZXJ0L3Nv
dXJjZS1leHQyLmMgfCA2ICsrKy0tLQ0KPiA+ID4gPiAgIGNvbnZlcnQvc291cmNlLWV4dDIuaCB8
IDIgKy0NCj4gPiA+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2NvbnZlcnQvc291cmNlLWV4
dDIuYyBiL2NvbnZlcnQvc291cmNlLWV4dDIuYyBpbmRleA0KPiA+ID4gPiAyMTg2YjI1Mi4uYWZh
NDg2MDYgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2NvbnZlcnQvc291cmNlLWV4dDIuYw0KPiA+ID4g
PiArKysgYi9jb252ZXJ0L3NvdXJjZS1leHQyLmMNCj4gPiA+ID4gQEAgLTI4OCw4ICsyODgsOCBA
QCBlcnJvcjoNCj4gPiA+ID4gICAJcmV0dXJuIC0xOw0KPiA+ID4gPiAgIH0NCj4gPiA+ID4NCj4g
PiA+ID4gLXN0YXRpYyBpbnQgZXh0Ml9ibG9ja19pdGVyYXRlX3Byb2MoZXh0Ml9maWxzeXMgZnMs
IGJsa190ICpibG9ja25yLA0KPiA+ID4gPiAtCQkJICAgICAgICBlMl9ibGtjbnRfdCBibG9ja2Nu
dCwgYmxrX3QgcmVmX2Jsb2NrLA0KPiA+ID4gPiArc3RhdGljIGludCBleHQyX2Jsb2NrX2l0ZXJh
dGVfcHJvYyhleHQyX2ZpbHN5cyBmcywgYmxrNjRfdCAqYmxvY2tuciwNCj4gPiA+ID4gKwkJCSAg
ICAgICAgZTJfYmxrY250X3QgYmxvY2tjbnQsIGJsazY0X3QgcmVmX2Jsb2NrLA0KPiA+ID4gPiAg
IAkJCSAgICAgICAgaW50IHJlZl9vZmZzZXQsIHZvaWQgKnByaXZfZGF0YSkNCj4gPiA+ID4gICB7
DQo+ID4gPiA+ICAgCWludCByZXQ7DQo+ID4gPiA+IEBAIC0zMjMsNyArMzIzLDcgQEAgc3RhdGlj
IGludCBleHQyX2NyZWF0ZV9maWxlX2V4dGVudHMoc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAq
dHJhbnMsDQo+ID4gPiA+ICAgCWluaXRfYmxrX2l0ZXJhdGVfZGF0YSgmZGF0YSwgdHJhbnMsIHJv
b3QsIGJ0cmZzX2lub2RlLCBvYmplY3RpZCwNCj4gPiA+ID4gICAJCQljb252ZXJ0X2ZsYWdzICYg
Q09OVkVSVF9GTEFHX0RBVEFDU1VNKTsNCj4gPiA+ID4NCj4gPiA+ID4gLQllcnIgPSBleHQyZnNf
YmxvY2tfaXRlcmF0ZTIoZXh0Ml9mcywgZXh0Ml9pbm8sIEJMT0NLX0ZMQUdfREFUQV9PTkxZLA0K
PiA+ID4gPiArCWVyciA9IGV4dDJmc19ibG9ja19pdGVyYXRlMyhleHQyX2ZzLCBleHQyX2lubywg
DQo+ID4gPiA+ICtCTE9DS19GTEFHX0RBVEFfT05MWSwNCj4gPiA+ID4gICAJCQkJICAgIE5VTEws
IGV4dDJfYmxvY2tfaXRlcmF0ZV9wcm9jLCAmZGF0YSk7DQo+ID4gPiANCj4gPiA+IEknbSB3b25k
ZXJpbmcgZG9lcyBleHQyIHJlYWxseSBzdXBwb3J0cyA2NGJpdCBibG9jayBudW1iZXIuDQo+ID4g
DQo+ID4gTm8sIGl0IGRvZXNuJ3QuDQo+ID4gDQo+ID4gPiANCj4gPiA+IEZvciBleHQqIGZzIHdp
dGggZXh0ZW50IHN1cHBvcnQgKDMgYW5kIDQpLCB3ZSdyZSBubyBsb25nZXIgdXRpbGl6aW5nIGV4
dDJmc19ibG9ja19pdGVyYXRlMigpLCBpbnN0ZWFkIHdlIGdvIHdpdGggaXRlcmF0ZV9maWxlX2V4
dGVudHMoKSBpbnN0ZWFkLCBhbmQgdGhhdCBmdW5jdGlvbiBpcyBhbHJlYWR5IHVzaW5nIGJsazY0
X3QgZm9yIGJvdGggZmlsZSBvZmZzZXQgYW5kIHRoZSBibG9jayBudW1iZXIuDQo+ID4gPiANCj4g
PiA+IEknbSBndWVzc2luZyB0aGUgY29kZSBiYXNlIGRvZXNuJ3QgaGF2ZSB0aGUgbGF0ZXN0IGMy
M2UwNjhhYWY5MQ0KPiA+ID4gKCJidHJmcy1wcm9nczogY29udmVydDogcmV3b3JrIGZpbGUgZXh0
ZW50IGl0ZXJhdGlvbiB0byBoYW5kbGUgDQo+ID4gPiB1bndyaXR0ZW4NCj4gPiA+IGV4dGVudHMi
KSBjb21taXQgeWV0Pw0KPiA+IA0KPiA+IEkndmUgdXNlZCBidHJmcy1wcm9ncy02LjguMSwgaXQg
ZG9lc24ndCBoYXZlIHRoaXMgY29tbWl0Lg0KPiA+IA0KPiA+ID4gDQo+ID4gPiANCj4gPiA+ID4g
ICAJaWYgKGVycikNCj4gPiA+ID4gICAJCWdvdG8gZXJyb3I7DQo+ID4gPiA+IGRpZmYgLS1naXQg
YS9jb252ZXJ0L3NvdXJjZS1leHQyLmggYi9jb252ZXJ0L3NvdXJjZS1leHQyLmggaW5kZXggDQo+
ID4gPiA+IGQyMDRhYWM1Li42MmM5YjFmYSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvY29udmVydC9z
b3VyY2UtZXh0Mi5oDQo+ID4gPiA+ICsrKyBiL2NvbnZlcnQvc291cmNlLWV4dDIuaA0KPiA+ID4g
PiBAQCAtNDYsNyArNDYsNyBAQCBzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlOw0KPiA+ID4gPiAg
ICNkZWZpbmUgZXh0MmZzX2dldF9ibG9ja19iaXRtYXBfcmFuZ2UyIGV4dDJmc19nZXRfYmxvY2tf
Yml0bWFwX3JhbmdlDQo+ID4gPiA+ICAgI2RlZmluZSBleHQyZnNfaW5vZGVfZGF0YV9ibG9ja3My
IGV4dDJmc19pbm9kZV9kYXRhX2Jsb2Nrcw0KPiA+ID4gPiAgICNkZWZpbmUgZXh0MmZzX3JlYWRf
ZXh0X2F0dHIyIGV4dDJmc19yZWFkX2V4dF9hdHRyDQo+ID4gPiA+IC0jZGVmaW5lIGV4dDJmc19i
bG9ja3NfY291bnQocykJCSgocyktPnNfYmxvY2tzX2NvdW50KQ0KPiA+ID4gPiArI2RlZmluZSBl
eHQyZnNfYmxvY2tzX2NvdW50KHMpCQkoKChzKS0+c19ibG9ja3NfY291bnRfaGkgPDwgMzIpIHwg
KHMpLT5zX2Jsb2Nrc19jb3VudCkNCj4gPiA+IA0KPiA+ID4gVGhpcyBpcyBkZWZpbml0ZWx5IG5l
ZWRlZCwgb3IgaXQgd291bGQgdHJpZ2dlciB0aGUgQVNTRVJUKCkuDQo+ID4gPiANCj4gPiA+IEJ1
dCBhZ2FpbiwgdGhlIG5ld2VyIGJ0cmZzLXByb2dzIG5vIGxvbmdlciBnbyB3aXRoIGludGVybmFs
bHkgZGVmaW5lZCBleHQyZnNfYmxvY2tzX2NvdW50KCksIGJ1dCB1c2luZyB0aGUgb25lIGZyb20g
ZTJmc3Byb2dzIGhlYWRlcnMsIGFuZCB0aGUgbGlicmFyeSB2ZXJzaW9uIGlzIGFscmVhZHkgcmV0
dXJuaW5nIGJsazY0X3QuDQo+ID4gDQo+ID4gT2theSwgZ290IGl0Lg0KPiA+IA0KPiA+IFRlc3Rl
ZCB0aGUgY29kZSBiYXNlIHdpdGggdGhlIGNvbW1pdCBjMjNlMDY4YWFmOTEsIGl0IGRvZXMgaGFu
ZGxlIDY0IGJpdCBibG9jayBudW1iZXJzLg0KPiANCj4gU28sIGlzIHRoaXMgcGF0Y2ggc3RpbGwg
bmVlZGVkPyBJJ20gbm90IHN1cmUgYWZ0ZXIgUXUgZml4ZWQgdGhlIGl0ZXJhdGlvbiwgdGhlIHRl
c3RzIHBhc3Mgd2l0aG91dCB0aGUgcGF0Y2ggdG9vLg0KDQpRdSdzIHBhdGNoIGZpeGVzIHRoaXMg
aXNzdWUgYW5kIHRoZSB1bndyaXR0ZW4gZXh0ZW50cyBpc3N1ZSBhcyB3ZWxsLg0KQWx0aG91Z2gg
bXkgcGF0Y2ggaXMgc2ltcGxlLCBpdCBmYWlscyB0byBhZGRyZXNzIHRoZSB1bndyaXR0ZW4gZXh0
ZW50cw0KaXNzdWUuIFRoZXJlZm9yZSwgeW91IGNhbiBpZ25vcmUgdGhpcyBwYXRjaC4NCg==


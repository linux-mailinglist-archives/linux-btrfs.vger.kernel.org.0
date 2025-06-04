Return-Path: <linux-btrfs+bounces-14442-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85756ACD959
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 10:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4F63A366C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 08:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DB7221D92;
	Wed,  4 Jun 2025 08:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q4lhnPds";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="joV2Vm/4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63342154423;
	Wed,  4 Jun 2025 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749024625; cv=fail; b=j+CIgjZQk0S31rj+OU20874PjqioEoSuryahTtxUOwx2AsKFed98Zu0vXM7xRfuwao+g1YUIu3ZpbVT4vtEWWPtDCKyYNf3MAhxHd7nl+5Pnr1ok1lJ2t3Xdh4LzC2xshumAXoQUlOP35GIOLe/P3gCOYSHo5dNxtA3jREemJJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749024625; c=relaxed/simple;
	bh=+FKmbYWBJ4wwnfFLBOlBWffuVfwgYwIsac8GXWIIujM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GXlvaioWHGwNp3+MS7l1p4RmH7e8QEn5zjhxw3wdNWvYbHL4nNg8lstOre+Csnc/kx3iARGlT/w2ODryZ5AgbAcmcf1GxX6I02AXEf/DeKSD7zh3kSPWtUld6D7vtmADQ6hlq0//MRZtpE5EXnNpj6jmYba+9PF7sDRfERID8oI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q4lhnPds; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=joV2Vm/4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553MNP34032748;
	Wed, 4 Jun 2025 08:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nkCv1AqT+1rBjUqeoa/84lmrKLGS0BfZV1gbioikZug=; b=
	q4lhnPdsKY+OvtVVSxAkTZZj4zZUyy+WI5wWwfy/phTj13DqK2J1ZiJc8GOSNNUM
	CGTkBLdW9l2xrNfog0MTF9ny7wJM4QL0etjRQed2NMqdgnRUo/msZDFN6A694VMt
	L7Vv/vV2aD9NsxU4R4ADVzyNa6D8tPQ8orxS9iVeTmkbvOrAKtq6gi2ibBvTEmuM
	NKTkat69lugUTAofjcFHwoID7O8R93aNYCTeALR4667AKmDeTZpv3D8J0g/w4Hg3
	B5ClZ9u6o5xl7Iy3MCiKhrnj+lm+V4Q34FVLFtd6weYGBQlC3zujhodXklNLztJ0
	ENAd4/qBKY9q8wSPgr1yZg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gwhb9xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 08:10:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5546rWf2034366;
	Wed, 4 Jun 2025 08:10:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7aex1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 08:10:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhMuUl4fjmtjfv0WS73vJiwQM+SvoeLl3RlDkvMwgLepSPe3Vv7MSKR8abWpuJIu0XPqPh/vDxLFAjGuwovRDi9r1GJUQ8tI+hepk0kmSWaF9OdoUL0i9tPRQyQsIHgHBRxZ6/hKlTy3jmTlUHHXtL7Lg7vDOEHIO8xc8MIRJR5uKqohmgW+aJ91xCA871G2HnyoVgvCN6StdTy5y5uBHqShiZvfSDFLiorNpxzA9/ShX9TiiZUk3VS15c/fm9TZc06Y1XjIb2b98jiuegHQwJcBmJ0v4Iz39A+YutKW88DPcwgcPFSP+ly7BFMQ+vw4WErmDLx3+U3a3/ijIdXXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkCv1AqT+1rBjUqeoa/84lmrKLGS0BfZV1gbioikZug=;
 b=RpQdxSIiqoM/9FJEO2YIIkRQjZA3e/CsAa0oa90lVB4XIMpQmZqjFD6t9fAPTxeRnzFDRotxrdQA4vgOTgOSaDkrJyYBg3uYhGMI+o/k+NbniBe5AND48hcKeeN8OxakLPeX1H0fHG2KXJ9IwKwCp9o8K2ObTRKss3FVyG0vXIm2FCtpz0BVDWaUBSGDPoATRtrvHR9opmopStlUtD8D1t+IVlGd8Q22kGoK1kMeeehB6AjTCWq6x1XtHd8/yoWwD1oMCvI3pkCGycAvVlRw2cHH4mvLSDQ/aNSpKsuOgj/KJvWVJ905p/i4FH+mecgL/+PdQ96nGa3NJIpNzeooVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkCv1AqT+1rBjUqeoa/84lmrKLGS0BfZV1gbioikZug=;
 b=joV2Vm/4QGBWpHni78VbztwAEVNKV3xvaB17R7oKrl5cyaLMqIMG+/NNJsZ5HGy6o4GO4Inf03VvTg2814GeGNewaWcT/GWCord+XsINJQ/VSLKdJ55G28Wvjgwso2maM1mGGBIUwvismu9XpM2ekplPIay6YAm3r2XppJ/i6Xk=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by CY8PR10MB6825.namprd10.prod.outlook.com (2603:10b6:930:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Wed, 4 Jun
 2025 08:10:17 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Wed, 4 Jun 2025
 08:10:17 +0000
Message-ID: <bf4a8a9f-16cc-467d-a039-2a5705ac52f6@oracle.com>
Date: Wed, 4 Jun 2025 16:10:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: generic/730: exclude btrfs for now
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20250604071024.231586-1-wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250604071024.231586-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0092.apcprd02.prod.outlook.com
 (2603:1096:4:90::32) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|CY8PR10MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: ce2e0a00-7adf-47b9-50ed-08dda33f3d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGxnRmxTWkYxSE1LaFBzL2R1c1cyN0E4a0dnNFdxMElLeFpEUG1tZGdpU2NE?=
 =?utf-8?B?NExCSlc0bjVQeE9xQ0N6dURrMHlleHRZL0lGN2NnbThaVXpCb0FXZGFSTkNM?=
 =?utf-8?B?amw2VUlWUWZDdVErQ1VuL2o0OE5CQ2I2YTJKa1pjZGRnYXBMUGgwWEZpYkl2?=
 =?utf-8?B?dHNuOXh3eEwvOUtRNXhrc0YyTjdqUnFJNkphOXZCaVRuZ3NoNncwSzI4R3Fu?=
 =?utf-8?B?eVV4amNJQ21DcVRnTi9VVEpHMHFEUHpMYkx6MklWaUQrYkViQnZ6akU1UEJp?=
 =?utf-8?B?aUxXd0htQ29UcjRabG5LQ3g3Q2pkWkFUZG5lNnRPcDU1N0VhT2tQVnFKWmdU?=
 =?utf-8?B?eDhOLzcxUGtMbWFqWTJLVzdjT1YxV0ZXWm9mbExwampZTnQrMFNsY2V5Q3ly?=
 =?utf-8?B?NzJJSkl6Vlg3cEQxcmRlRFlTTkoyMU1wTFVlc1BKYTBtaGFwM3VoTzFoV2Rs?=
 =?utf-8?B?TlpVT2pMT3VxTzcyNHB0OUU0NHRFSDE3WGZoL3ozTVJtQjlWcmh2RjJjZHNT?=
 =?utf-8?B?NEV0RldWTXZhcEM2VWFHSUZoMi9BV1dFQkNpaWpvektsVlRaZ1VOeGhvNGU2?=
 =?utf-8?B?YUJaQWFzNUFiSUpiYzVDR0oxcUhsakN4cjdCSDJBdnhuU3BOMGU0VDBOTVEy?=
 =?utf-8?B?bllxaFdLb2F1ODVrNCt0YTNzNEpReUcwWkFKem1tNkVQdkdzWWc3Zk1GcFFC?=
 =?utf-8?B?MWttd1FnbHJYa0tIUWlwS3FnenhhbXhsQ1NVL2trcG12T2lLTGtTdXJrZ0Jj?=
 =?utf-8?B?VFp1cEF0bndRSmNVN3lDaW9GMG1Jakh5WDlna2ZUUStvbU4vbVpNbGFnRDVO?=
 =?utf-8?B?Z2VDbU1oRmV4aCtDM1N6UjE4L1FNa3lEU2p3YTcxYVpBbXlWaWdsWFFXc3p1?=
 =?utf-8?B?T0poSWpSNDc0cVFjbnlDUnVCVUNZK2I4azR0bUVaRk4wKzdoSlpPekZ0TUFQ?=
 =?utf-8?B?R1F4bkpaYS95R0pBdSttVTdubEJwQ1dlTGsxVklKcVUzUUIrNVFJSkpwQ2Jx?=
 =?utf-8?B?WjdrcEh0Q2lUVXlOME5SQ3ZDNUdrL0FqNnJweWh4ZzNHeFVtdkdDL0gxU0kr?=
 =?utf-8?B?cmhVOU9ONlE2d3VzR1lXak9kTmU1QWtzeGM5YU55Mm9aMmhiV2R5V0hMbHdm?=
 =?utf-8?B?azBzRkh6WHBXUzBaZGRMK3drL0lpKzllUms4eHFBalNJU3JLMEROQUFsakFQ?=
 =?utf-8?B?L3p3SC9MYmVFTXBFQmVacWpHdG9RTmJvVWI3eWtTVnhKQkZYZEpzY3FpMG50?=
 =?utf-8?B?QnR5UlhIODJxWDB1bHRGUlFtYVlpY1M4TmZ2ek55UzlzVDNvTXVDcy9LMy9r?=
 =?utf-8?B?SlF6aFJ4SDdJc1Z5cWlFOGtWSk5GK3JmRmFodWJrVzN0SThJZS9mYTRtR252?=
 =?utf-8?B?M3ZPcWFkUW9PQWNUNHBHWTN4UjFKQy9Ed25LWDlhcUxJZWlHWWwrRzc3enBn?=
 =?utf-8?B?Q1MvcmJzcnRuREdHNkxNckRaSHpxMElLMHRZaXF6YjBpMEUxazdLMmREVVN4?=
 =?utf-8?B?SktwVFVGek9iWUNjaVNFbWZURzlXZDNCdmlwaWFkNFZXR3V5MVdVNUVibzJo?=
 =?utf-8?B?RTlaUUtnWXNkU2ZwUVZtZEE3aWdycDlDM2IvVXFsdVBaWHhRbDdvUG5pa1pU?=
 =?utf-8?B?eWNCRW9pUWdSZ0I3bkRDMlpVeDJ6TjRpV2xmR3ZMcU9WdmZIaEYrZE9KTDZO?=
 =?utf-8?B?Y3BuVERKVHVzelA3dlJjVHFYQjF3a1d0djV0Z2F0ODBRWSsxT0YrS1djaFVo?=
 =?utf-8?B?M3QzNndRL0FNanpUMHd5eTloSlZZNXBMSFkvL3BhdzB5SmdZN0E0a0diY2xP?=
 =?utf-8?B?TUFnM0JvQkhINlJjcWFtbTdiWWl3djdlVERVbFNTb0pzdFBMZkNrSlRGajdF?=
 =?utf-8?B?YVhZelJjeHZNOWpsUmRFYkUyU1VQcnBuYmdqQjMwWVJYVDNpM0dRa2dSZDNm?=
 =?utf-8?Q?APw9DMinmco=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzIvc29DNzZDa2tEYjlHZTBITUQvVjBrWTVXbTVpRkVXcU5Xbi9ZOTJkRWRY?=
 =?utf-8?B?WWN1QW9ZVmpoc1UxaWZvb3EzbDJhQzFjeUZoKzJCT2NiUG9FVEZxQVh3TUtH?=
 =?utf-8?B?T3hMQld1SjNUdVVyQXAvcWhtTFpBcmRjc24yRm5ZdWZYalZydWJYMGFsUTEw?=
 =?utf-8?B?SjB1K05ISFl1cGw1M2JOd3NvemZWbTFVMXUySG5BMGNiRytlbndsb2pnNUdl?=
 =?utf-8?B?cmhiTFhac3prWFZnc3IySGVLcUxHZWk2VUNROUFXYUpZTmdYdjJqY2pzOTVv?=
 =?utf-8?B?L2xWNklnbWN0Z1NxeUtsNDgrY2NYcE9mb05ieFhBSUdqcTlNN29rUGFsM2dn?=
 =?utf-8?B?Ly9tRHBFVDJKZi9FUkxQQ3dhc0ZuZjU2cHg2aldkeTVBYlA3eVl1WTY5aFdo?=
 =?utf-8?B?UGJhRk9oZ1gvM2h3WjVPTHN6QWhvMU8wZGIzUlhnTmxmWHY3UnpxVEowdmFK?=
 =?utf-8?B?alFTMXVrU2htaVZYRnZVNzlZVWs2RDY3NGxyM1pRcXpHRXhNbi90UHhpeWFy?=
 =?utf-8?B?bGU3RFBMV0xxSS81TWpPcUdDQTF5WHRMaFhrVk1EdlN4dE1wMFpONldHSVMz?=
 =?utf-8?B?RTlPZGNvUEdDODZucVRQcVN6ZnppUC9vbElhM3BGRThxallLZktreFpBU2dh?=
 =?utf-8?B?bTNJckYrQmVBaWpiWFMwQ1gxYzQvSFVFdURSVE8rYXpzWVVxQWpEb3A1elV5?=
 =?utf-8?B?THpSMXdVbFJET0dBWDRENk84anFsU3ZabDZGTFE3L3dsd0E4VnhkOE0ydXJW?=
 =?utf-8?B?dkNuQUptV0hlN0tDTEg1cjg2MUhtdFVINWM0QWtrQmxDTHd4T3BlYWVQaHJy?=
 =?utf-8?B?RFQxaUc2dTVHZTFpa2o3MW1uM0dXQ3QvR2QrV21ZN29ZdlU4OFMyNzNjV1JV?=
 =?utf-8?B?eUtOR3ZDNldReGNTcGx1cnZHZTRDU280NEFRaFRweWk0YVpDUjg3ZVBGdEtw?=
 =?utf-8?B?cFRoSFRNNEFTMkhISE51R1dOaDFsYnRsdFoya3FudG41VFB6R1ZsY1QrdVJF?=
 =?utf-8?B?VktmeWtJYmthUE5XNVF3M0NZT0lhemdiT0ZiQi9yM0ppbG02T3VXSzZlMDlv?=
 =?utf-8?B?Q3Z2TjlHZzFqSlBzeDEvRHladnlCNDVVNGx6ZXpRTHE2elYvWDJBbUZKQWZj?=
 =?utf-8?B?M09wTkVTemtEMDVZc2Z6T280TXo3T2NacjBYZFZPbnQwZ1pKZHptLzJwcFQ4?=
 =?utf-8?B?Qm5uSEdPQm1GNkZMU1NGMGNId2lXWVkvYTBwcit3bkd0VUZaMG1Rdm5FdS8v?=
 =?utf-8?B?a3puZm1XSGhWancwazZ1UlRTQzNNVUtSSUhHUy82MTA4MTNSdkd0Y2NwV2o3?=
 =?utf-8?B?ZXVvdGN1b3ZObVRMVHJTc1k3RDUxdnlhM254L1ZjeDJ5M0xPQlRtN0JSNTBP?=
 =?utf-8?B?Z0xvT1krTWxmRzB0dnp1eVYzVWlrT1hzN3BQOHA0N1YvY0RjbzMycGpOd05v?=
 =?utf-8?B?U2wvVVNDK0RIVlplT1V0NnVzRklkTHgwejRmdVk3TFoxYnBvQzhLQzFIby9J?=
 =?utf-8?B?MUFQMXNONDlRditJUFBOazZwdUYvSkdIdU9LMCtiU2F0aFhCWVlOS0lHRFJO?=
 =?utf-8?B?VWpXbXduNzlYb1BHWjl0QlRJMHFNdCtOaStrY0NPL3FUQnBBM3dTbFRVcEYz?=
 =?utf-8?B?cy82ZmtNa3p5Wk1ybjViNEJLTWQyVktCZHFpSWdteWk5Q1lobHJsZWI4ZUhx?=
 =?utf-8?B?TEtoSE1NWW5SYlRxcWFIc0J3cGdEYitiQ25YOTcvV0J5dFFIblp5ZTFnb2VI?=
 =?utf-8?B?ZEpHWWJrbk80WGJGSDgvdVV5aUtqZTZUMVNTT0V2SWFnMHkyeGE3d29BVGMz?=
 =?utf-8?B?TnpGeG9nN3BCblI1WHh1OTJ6RGJsQmpOekRxK01ZZ0JmQi9iQ0Q4ZjkyOU4y?=
 =?utf-8?B?RmJWWHQvQ0RGZ0lidXhTdjA3eW9EajQ1T0pFb3VmYVBGWm9BOTJ2NS8rWDVY?=
 =?utf-8?B?VGJwOXVZSU1reGFSMmwvYU5tNCttM0dmc2RXSlFJSzhXRktNSGFROEd5VHVu?=
 =?utf-8?B?MEhPMUhJa20yOGxRUGVqcGg5akxXY1QwUU1MMjBic3RYK2phc202VTRpSU16?=
 =?utf-8?B?R3g2SmRsMXVFZW9RbitMTkQxcjVaOVZnbXh3Ny9rRWlsSjBUblRoQmd3ek5k?=
 =?utf-8?Q?quO6WeC7pHgYZYNQ3J7aVaEij?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zFnEwltqY+hKXyzliQn+shXAl6F4Rp/v1zcMif8ArYyIJWhFPy47beki2XazdssKASZ3R+eZWrB7IjUEU9GgIbhSKxxCcqUegc7jXgsp96OjTFJIlCy5aRURQtN4t1S3TFkKogQRJkrriLtlE3MWqA794YgbI5LcZnsz9B0u23XsYA3gLqaO34lTRjXV4q80fMcC28c5Qvd6OsBF0LrmmcTac/GExr72nm5LJfvGx0ABgfd2KpigRHebvHWSmq00syAkVFpsUPHl/Ch8Sdk0NN0kVsvR4oa+ix0GDPRAcOfKssZYEiZuOGeWw455rpNZuvqa6EyqcbE1S0Aq2YMcg+Bz/CiNaGRvi/ws77uizAiELsNy/Q535cTInuUpLKriOghCcq7u2ZqdVMEA07xog69nWDBZNY23/fHscbyMc4B0FQOLfa4QqL65WJn2E+zb9kJDo9ptU5erQ+ZSgv79vSKjqEub/W2Knz6ltWc3FoSmGbUdugl0LAvAYH5y6KQhrRQY3FEw98ziWKJ9kb/SBuMnqOcpFyoB9VCSsbzzJOze6yLn3gBvTCnc3fzj3obAnkdwCvBFTwVE5LgawUWhWzWHropmyV7OtDoFZ7Ec5U0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2e0a00-7adf-47b9-50ed-08dda33f3d6a
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 08:10:16.9188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwRkB70lXLEIiyrJ7QOLHDwdsqAE9qBTaQJ5lDVXIjjmtBwu5aWRNfaQ5dpKBn1i2+vNgRIyp9iwAV06D9UK4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506040064
X-Authority-Analysis: v=2.4 cv=Wu0rMcfv c=1 sm=1 tr=0 ts=683fff6d b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=iox4zFpeAAAA:8 a=l_ROuJoxyfqdOmf8D98A:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22 cc=ntf awl=host:13207
X-Proofpoint-GUID: yFV6Q7UQgflF2tYoYQdbm1-Z9qSxQnKl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA2NCBTYWx0ZWRfXxwhxnzmdsZQN c8uu1ywehkQ8uTiyMeHlUVtjzfVzuZk8lXCNL6vKX4jxE5rUfOOPZF9CB2uqnJblwx3ceRG5MER d/ViJALNfPSEUMN+5lXYCu+LWYn5dKBB619lH/KCpqzwVlR8FDxdc2kYUvMhWrSJpPKEqABOKZa
 Qb6xovovPool2HEBimLw+AjVdgBxOgMBAZILQFmH9bHXPMrA4CFmQjAPWGAAN4Au5d1+m/Tz8xw S8yA2iklhbxWc+j8PV0v2pn6181dSD3Mpq/nFPG77yDt8tZxGAn2VZGUuo5tteh8H4xJbjIr5bb iAxyT717WPs189n9lnPTXQnVJMnjC3Xay1wadwuhy7myYggkn+gGdTvuQBDYVMOaVA7YKWv2OQ3
 oXAmmt8zvHM/msUBcvqPSv0yy0WbLUK8Mbml/xAQjrK3XmcyV6pWeOv5VpfuK55jA/wN4X2w
X-Proofpoint-ORIG-GUID: yFV6Q7UQgflF2tYoYQdbm1-Z9qSxQnKl

On 6/4/2025 3:10 PM, Qu Wenruo wrote:
> The test case always fail for btrfs:
> 
>    generic/730       - output mismatch (see /home/adam/xfstests-dev/results//generic/730.out.bad)
>      --- tests/generic/730.out	2024-04-25 18:13:45.203549435 +0930
>      +++ /home/adam/xfstests-dev/results//generic/730.out.bad	2025-06-04 15:10:39.062430952 +0930
>      @@ -1,2 +1 @@
>       QA output created by 730
>      -cat: -: Input/output error
>      ...



[PATCH v1 5/7] generic/730: add _require_scratch_shutdown

Fixed it.


> 
> The root reason is that, btrfs doesn't implement its blk_holder_ops when
> opening a block device.
> Thus when the underlying block device is marked dead, btrfs is never
> going to know thus no way to shutdown (nor btrfs has a way to shutdown
> either).
> 
> I'm trying to improve the situation, but until then just exlucde btrfs
> from the test case for now.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Update the root reason
>    It's not the sb->s_op->shutdown, that is only for single device
>    fs (through fs_bdev_mark_dead()).
>    For a multi-devices fs, it should provide a blk_holder_ops when
>    opening the block device.

Along with that, I think it is a good idea to bring  XFS_IOC_GOINGDOWN, 
per fs (all devices in a multi-device fs) and vfs level so that we could 
support unmount --force.

>   
> +if [ "$FSTYP" = "btrfs" ]; then
> +	_notrun "btrfs doesn't support per-fs shutdown yet"
> +fi
> +

_require_scratch_shutdown() will take care.


Thanks, Anand


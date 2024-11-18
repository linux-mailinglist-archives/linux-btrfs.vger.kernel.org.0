Return-Path: <linux-btrfs+bounces-9743-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8C99D0777
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2024 02:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D259A1F21A65
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2024 01:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01AF1758B;
	Mon, 18 Nov 2024 01:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eUzEtPcT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="adSIIRFw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFCC8BFF
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2024 01:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731892528; cv=fail; b=I2HJNozH1EgDRC+XDk2mBUAcn5ffK6bKfGhhRZ4TLuNG9nMVLY9EWPjMHqnDkfyMq8VrSX77yMx9mRW5ZLPNNz8fWnwWAVq/jEUiSIXfLqBG49GrjJjkr3dilF2WvUN6Egs2YU3q9kaBTqMRvLYypB1FvYs4DDplTTUXdgB10g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731892528; c=relaxed/simple;
	bh=xTQTy2tcbto+HRxm9T3Qrdb/+f3RorJSS1/SbZ6gFUo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gFxDOF1NyR1wvTcOF7bmfWQouy3lADB96uYdqc12aCOvAliYKxLVm/jcTAMhznKBPXQq9T5w+CuOBYOTpHt9RNQZOMBAwj31lEBXrzCvTP4lXDb5MHIQLRi8ykIxc8UNQClqJeh1srLk60by4hxLw9myqRQjU5kKTMW15cHoSM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eUzEtPcT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=adSIIRFw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI1BpU0028042;
	Mon, 18 Nov 2024 01:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xiJAGdbtl2qFxURVUxPtb2BV8+UfAEcBTZoCmu8WDao=; b=
	eUzEtPcT8rSpE1YBaKQIPjZeMvsfFWNdhLFlchQti0nikOzjz2dJZBMOS5JdLF6V
	31Lbrf6SRdDYddsXNh2QMVDlP19Qv1si1T4xTwH0d/NVAKmJzcA1efXrnVUgCYid
	pG2wWJWHP8v71vn0Gvih50f2Oanaw5PwMZPDrJCfc2hJ5ljT5z/DbuMBJhcPwTx4
	3n9KXNAZb8t04T1QZPkoRRbbsaHfvjvZxFxhBMQgovXe9oojjQDXtbo5d56UP2qE
	JxqPrx0r7UZHLIRUKDREUgwbVCxDqL7AcJUIjzRoeOlR9jXwg/DBrImG90Scxk9i
	fp89fzXiBGpUUnooU6ZHvg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkebsqmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 01:15:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AHL155D039224;
	Mon, 18 Nov 2024 01:15:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu6ge3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 01:15:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhBHeHl1nMdMC6vdpE5qixjosJ1uCfgMtxkkSt+PCSIzg/dfiavoYeTHUzmC6HADqp7wKWFWeLt7Rc9dtEIObYm3azpYxVFs5k5qszl6P4OASjX17pZ7MZV1kxUz6Oe3I+0MRbWPRKTSuttuXHWOo0+QOTcHCygTRvn+JmoB5IcfMXcBSCfMs9ETW/N013EMflqOS+g9j1EWQ+q5owkAILMsq/jC/aNyQteQ0/rFqnC9hDdaJSghATuotL5ZNGj/vG+G9FYyf2cd3jl7MvVE8VySK3q8synHj4Pz4xyBGLp7ZT6FjLeXotDjTRBi7eAnRUCjxYCUJaZrnPqFmZ2PAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiJAGdbtl2qFxURVUxPtb2BV8+UfAEcBTZoCmu8WDao=;
 b=XJHO4swnVxBbxQI5Nc9qMKnzcq0Y7RzctZPrJkav+s0H1lOxQpOd+/c9xqECciWKSbRg9uUahVgOwGKjB225gpQdHMoGiD6p6joM3+oUysW4MGvALzYZrajCIy13Sum8kAD/OAjswUnmj2F6PlmiISUOPSGaaqGrcbYwr3XN7KR/udEsZc+/qWvFV1Uy8DdUZosxIEoioBSV9N498NboLVD0QmL+KKXDZZW9tAjOM/KDGkIPRnXj+mfl5c531UtIUGhYMBcE7yRQk8OtTcnrlOzYhBEV5vzneHRp4daI9sLCUklxSwlmFNdTevfGpEQe+YoVSA9cRwFgBoXYWTO3rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiJAGdbtl2qFxURVUxPtb2BV8+UfAEcBTZoCmu8WDao=;
 b=adSIIRFwB/rJ0w+crqXWGSuWQQyJ140NKkuGAOk+M/Rh09qk4fj+iDPyriCsRuSlf6QDNWL16zstaudG+WZDh322yr4DxuiI+A1nBLe0jYRSBoE+uThGcMJ8M8aT/qMMCqT4yJop5r8NFezMismQ81xRi7PyMD238sA0NE+dQIo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB7264.namprd10.prod.outlook.com (2603:10b6:208:3fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 01:15:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 01:15:08 +0000
Message-ID: <d4411ff0-d5f8-4a7a-94b9-ea3cce62c903@oracle.com>
Date: Mon, 18 Nov 2024 09:15:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] raid1 balancing methods
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com, hrx@bupt.moe,
        waxhead@dirtcellar.net
References: <cover.1731076425.git.anand.jain@oracle.com>
 <CAL3q7H4PjErPf0XxBwLgK_2Sm1ABen4Xb-bi2Bj_+zM7uB7YCA@mail.gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H4PjErPf0XxBwLgK_2Sm1ABen4Xb-bi2Bj_+zM7uB7YCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 042bae1c-44c2-4969-eb45-08dd076e708d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enNyd1BlZnRQSnVQMktOQTdaT2wrd1BXTG52STd3empFQkpld0p3NDNMbUtH?=
 =?utf-8?B?NWJJYjJnbzdGbTNqZWx1T3N0bndsenIvaEtuNms1OFovMGNwbW56YlZTMlhK?=
 =?utf-8?B?UU5jekxVZ09mTXV0c0JudHkwK1NhWTRFdkQ3Tm1HQXB3bHJxMlhBN0xnTDNL?=
 =?utf-8?B?VDBSK0hxVDhFYlB5UEVFb0hTQnpCQ05lUUJvNDJyU2pXdGcxNGNsRDd4NXJP?=
 =?utf-8?B?UkhQUXlqT3djRDZWWnIrejNHdE9scU11R244T3ZXbG5YWVlqTTFjVktsNGVl?=
 =?utf-8?B?UUFVeUF4OTRPZEtaaFM4dTlUbkZSZVhhdkRiL1J5RmV6b3doMnFUM2p4NHow?=
 =?utf-8?B?SG5CeUtjVUpJa0lyNHplMU0vL3JHNkNHYUthM0tPck04c0ZHTEVuVXI1bVdF?=
 =?utf-8?B?YjJ2Z0JpYTZYc2tOeDdKTHRabzBYVGhuRFc0SW1QN3BQUGNmaWhXemNLcEdB?=
 =?utf-8?B?VFgxNldkU0xNdDlrU1pIK2tIa2dUQzlVNjhob0JOQ1NVSzE4djYzUnJXTkRP?=
 =?utf-8?B?MkVsTm05bldsOHM0SzB1NG52aStadFRFK1dMMnpsSm9UTVptbCtlVWlHUWc4?=
 =?utf-8?B?UW9OL0hrVUlKeXVGNnprQ3ZGekZhcHo4M3VCcG9ESzZ6Sk43d3pEbmNnT21s?=
 =?utf-8?B?MGlLTGNJdXBsUU9scVdTQm44MzNHMVpvVmhWRHQ2NmhHQWpqcmFJZ2JVbkFV?=
 =?utf-8?B?M1FOYmdzVUYyUG00OWptR3ZMTWo3U2VrZjl1NndldnZLSFVmdHhmZXdxMkxU?=
 =?utf-8?B?QnRBYk1zalYxREcwRkRpanlvQkJzRWh5cHB5bmR2R3F0ODVHRXpiQndObHF5?=
 =?utf-8?B?Q2cyTEpjT0lRZy9PRDNwemlxSGJjaElPK3FkN05HeWdveWZTMFBySGxZZFdm?=
 =?utf-8?B?RVB2QVlOZ1dkYzE1TStlN0lDdnp2clhJaDArUkZsOGZpZzRqMy83MmVYSlBN?=
 =?utf-8?B?VUlUY1k4dWNMcDNsYWVpTXBhS0dRNVljSElJMm8rY1BFTlQ1a0VWK1hldzQz?=
 =?utf-8?B?aDJjRHNZUHUzV2Z6ekN2V0hhY1JNQnh3dnU3Qy94Q2VtYnVoTnYzN3dqMngr?=
 =?utf-8?B?c01PNTVyZUZseFFXODdvTThqeExpUVBvc0hDWFp0czRnc1BGck5TREhaV2Mx?=
 =?utf-8?B?VDlWa1dvSnAybUUxTWFFekU5VFlBamJTL0c3eEFveTFmUVBnWjl3dW1hNUQ1?=
 =?utf-8?B?Q3AvLy9IdUNTaVM1TTg2dVpySjJmL0Z2UDZhNU1xNDc3L2toVnhZZnRSajI0?=
 =?utf-8?B?cDZuOTVxTHAyQU5rYWlEeFZHK0wwUmF6dWRoME9uTTN1bXdqdFRtYlRkWEVB?=
 =?utf-8?B?VzZiL0pzWGFCQjdFSUtSUUswc3dqZmtpQW04dng0eGxzSlZyeUR5NWdPQUFU?=
 =?utf-8?B?dUFWejE5aUtWUWYyUWgyYW1EZnBtbzVWZ0NZbXp6NWdYWHdCRmdhMk1JQjV1?=
 =?utf-8?B?TFhNV0xFYXplSlBPdVN1VHhZb3FRRXNuZGNVUXpwV0huRUR4QzQva0pkd3p3?=
 =?utf-8?B?OE8xWUVWYml4bVgxaWlBcUJYNk4vOURuRDN0ZFhUWUVXbGR0dVlscHdiaEo5?=
 =?utf-8?B?VCtJQi9HbUg1MVJNVnVqdmYzQXF3ZEYvbXpnMVgycmtDQWtsWnhESlFqMTZZ?=
 =?utf-8?B?ZkI1SXF1bCtwRnhncC9MRE9CN3ROcWo3czFEWjIwVnk0YXUvYUlLeFh3UkQw?=
 =?utf-8?B?T1hhZnZ4TzVXVGh6eG1CRG4zK3JrcHlSa0tsT2RLNkhyTi9CSlVlTVZpOVdk?=
 =?utf-8?Q?RgCPYep6uDGS4qVAcwZbLnW1wmAFotkGYTVoupK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0RpMnI0a0FERlE5eXhqMlI1Ny9HMlMxcW04YmdxWEExZXB0K2pMeFZzMGox?=
 =?utf-8?B?cVlGLzR2OCtHSHFBM2ppK01hdTIyVHE3bjFKT3Uxekt4MmlxY1Y0WWZaQitw?=
 =?utf-8?B?YWZNMkFnVVJhTG54VFcvbFo2NFE4YkxyYkxzM040dGVoRW83RGVBQk5ISHFk?=
 =?utf-8?B?ZTZFTXJISGlwRE5YUktnTExzVTFIVlpyZVZWdVVTeUdQMGZyd3RMMFVJQzZ2?=
 =?utf-8?B?V1I1UFUwdEQza2w1WmprYzRpaVdzWVZjN0tEczc2Zmxwc0lXQ3VsMlc4bWJB?=
 =?utf-8?B?OTlzaXlXai9rNWF0dmI0TG5jYllBb0g3Q3JFTUw1cTRJR2V3TU5VMVp5TlJu?=
 =?utf-8?B?L3I0V0RKTjNQblpZMk83Wjdpb0ozYUVRWnFDSTBidmxYQXljR2pnSFFTRlRj?=
 =?utf-8?B?YkxlVlE2VGZmbis2WnVHaDZRUmlNU3dlcE9KTHFGOVAwdnU4MnZJbnFJVmdN?=
 =?utf-8?B?TVFiZE0waFNsL2xxSHZmMzFhNllvdG43Vmd3eWh2TDlpb0laTWpENEJQc3gz?=
 =?utf-8?B?R2R1b0xsNmhYcW9GekpTZ1dDRlo2RTgrSWJHMmQ4aUE4RTIwTWFUd2VXSFM3?=
 =?utf-8?B?Z2Z6bG8zRXJra21aLzNYVnlzWkErN0FsdmJTbkR4T1RJbXUyS0VlY0Z4QmtV?=
 =?utf-8?B?VjBpdExyQlZEbFJDL2ZxVVQwcllOV1JhUmNIUjNOQXF1WHlQdU95cjhUTlF3?=
 =?utf-8?B?c0RpREZUbFN1KytLRmwwd0ZsU0RxSVhBbjV5S3lCalF5QTR1VmN3ZnNPV2U4?=
 =?utf-8?B?MWZuY3J0Um5IWlQvNURETUx5YjVNVGc1R2pZTFp2VVlKc3J3YmVyNVVydWFE?=
 =?utf-8?B?TUxrcjkraGlRK0JFZWlEZ0o3K3I1R0J5RW1VU3pla041Q2dhVktEK3BrblJo?=
 =?utf-8?B?alBGdWUySVpoRVlVSnN0cTlkSk1lMHBNNDFWanI1ZHk0dXA4c1VpTVZwMkUw?=
 =?utf-8?B?bk14NEtSWUpFU2pWeWlBQ0xtbGVXWEVHU1RJcFludkQ2MjQwL2ViVDFuT2Ev?=
 =?utf-8?B?MkhaZHM3aFdtVUhubVVCVm4yelR6YmlaOFRXOHl0LzJ3ZVhDRVgxUmNpOGtF?=
 =?utf-8?B?S3Q3SmJmS3ZzZUxWNldsa3NUWnJCSTRZOGlqbUV0MVU2c3czTVZ2UFVvUld0?=
 =?utf-8?B?VGs3UkxKSWNmVlZscEdJRFZDbEd0eDJQQWlxRGJxeVU0N2FrRUdDdFE0aHlW?=
 =?utf-8?B?Y0JwNHlsMmk5UHFMRDNRcmQ1bTRTOUR2WFVQbkEydlI5Y2V0WU1iNS9KMUVv?=
 =?utf-8?B?WEpSbFBrSkRicUNJTW5GK2VGcSsvdkdtbVdwSUdyN2QwaDdRczVKSzlSNnJL?=
 =?utf-8?B?Vk1Cdk9rcHpTNWc5SWY0RjJ1TW9SWWJ3bHlzak9MRHhhRDNWWG5teUtkczRG?=
 =?utf-8?B?Y3RsTzdicGxEc2FFQ0cvbkd2N0RiWTRlWTN5WEE4OGFlZ1RLV3RuZDB6ejVB?=
 =?utf-8?B?cENMcjl2MXRMbW1La3BCZVpuck8ySjdsVEZSM2J0N0ZROUtBRVhUaU9ta3ZL?=
 =?utf-8?B?UktKeWF6Y0wxZEovdS9UMlZQVGtKZytmeXpTdEVtQWljY0xXZ1REU3R1M0hZ?=
 =?utf-8?B?R3dreld3UnBNeDR2YnpKYkFpVVhXTjlGSkQvMTlBaXJlOTU0RFo4MkVhTGtO?=
 =?utf-8?B?YU45aUlKQjhGdWh0R3hCODZlL05yMjVYR3kvcmJlMHo1YnBYdlhYVGVnZkJa?=
 =?utf-8?B?dlFBMmprSmt4ZjFIQlM4VXlRYktCR2ZJN0JTZlo2bWp3dDJTVUhabDltT2Ny?=
 =?utf-8?B?NlVpdGtXK05pcFU5RnJ0MXFYc1lLa2VQWWRCV05kQnhmL3g1d2dCNDlhWHZh?=
 =?utf-8?B?a2draWhORU5Eam1NZVVGdWpVSTU1R3RSM01qd09iZUoxU256OTB3VkJFdWFK?=
 =?utf-8?B?UFdtNTFSeWxkYUZ4N0xLVzUvamgzc2JVeTBGQzR4NG16SktWazZxOXZ2aW04?=
 =?utf-8?B?b3V5U1pUcUwyVXhwZ2Z3SXdHMnNkalNhMGc4QlkyR2krbGYweWxpdHIwa1Vt?=
 =?utf-8?B?K0R4K1RFWUdJNDdKQWMxdVBWMHM3aUFxS3I4cVJqSnNQb0Mxdis0cWVSQU53?=
 =?utf-8?B?dWd5VVhlT0FRSFVjaTVaVS9ia2o2N2taVk9Mcm4xU0hhbFFob2RsYlZGUEJP?=
 =?utf-8?Q?/NDvqQT4eQtoAD5f01FyH71Bq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SsF6jgBNB7TBrf6XU2uirBxl580rv6Ivj8f8L0dBD2/cc3S6W1tYYuk+TgUp+2++2vqv3i+xjJPtxLnnjh1PfYV18JfmJDtO5IPxAuNTHfVsOVmj4gq2oklVN8qPd4brv8zTRn71frCksjfRkydmdhIBjEOghlTfkJpTVW+h3WaMn4uiOGGHPeVNFsU2OKJl25+8qA8QZAcp2eOhyhIwnzBSV1Z0brsY+Ad8KfH3QqrMqGCBQOHyHIi6FcZcaNOyJ4rUiKPxOUBAo9tRMf28aIJeKXhjcSMiH4BOjW1X1LCwcwU0CGmR8gM14zMg9GaG4TQSG8BOaIqcIsEFtrWrqkxOMOZiWGeyvXcGecgFjq+0mRHiHWtQmG4DjqRAfJaxGBLM9L4Yc6zlVg4dDpKOeD2mrItF/YVLLDMAJncDPt81d6DyFv8Xc4v8CyF9OuXv66UfjhIYvtjA4vEIbbpeN775e+ZNv6FbkaT4KLUwPvLpn4e3BKEhtOAFpFGgcs1QH+QMud6K+2Jf/CD3+h0haSUYQBCbPcp3TSy/0kbt6kZoo4wsY33pfhqyhmWlIJxb+dzxY/xw0tF99z68CCfj7+NGLCm8LxZxkbxLg8xhLJI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042bae1c-44c2-4969-eb45-08dd076e708d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 01:15:07.6567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULbSFK+Mx27Mhm5suXuwb5edGx+9JtlRQeJMSSKBeiFrSdyXJ4ki7ApdGGX/gA/5s55vfWf6kScozXyZgsKMlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7264
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-17_23,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180009
X-Proofpoint-GUID: XcLmJQ7DjJWX2HM5M1ZYxlafWK0eOu_o
X-Proofpoint-ORIG-GUID: XcLmJQ7DjJWX2HM5M1ZYxlafWK0eOu_o

On 16/11/24 03:16, Filipe Manana wrote:
> On Fri, Nov 15, 2024 at 2:55 PM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> v3:
>> 1. Removed the latency-based RAID1 balancing patch. (Per David's review)
>> 2. Renamed "rotation" to "round-robin" and set the per-set
>>     min_contiguous_read to 256k. (Per David's review)
>> 3. Added raid1-balancing module configuration for fstests testing.
>>     raid1-balancing can now be configured through both module load
>>     parameters and sysfs.
>>
>> The logic of individual methods remains unchanged, and performance metrics
>> are consistent with v2.
>>
>> -----
>> v2:
>> 1. Move new features to CONFIG_BTRFS_EXPERIMENTAL instead of CONFIG_BTRFS_DEBUG.
>> 2. Correct the typo from %est_wait to %best_wait.
>> 3. Initialize %best_wait to U64_MAX and remove the check for 0.
>> 4. Implement rotation with a minimum contiguous read threshold before
>>     switching to the next stripe. Configure this, using:
>>
>>          echo rotation:[min_contiguous_read] > /sys/fs/btrfs/<uuid>/read_policy
>>
>>     The default value is the sector size, and the min_contiguous_read
>>     value must be a multiple of the sector size.
>>
>> 5. Tested FIO random read/write and defrag compression workloads with
>>     min_contiguous_read set to sector size, 192k, and 256k.
>>
>>     RAID1 balancing method rotation is better for multi-process workloads
>>     such as fio and also single-process workload such as defragmentation.
>>
>>       $ fio --filename=/btrfs/foo --size=5Gi --direct=1 --rw=randrw --bs=4k \
>>          --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 \
>>          --time_based --group_reporting --name=iops-test-job --eta-newline=1
>>
>>
>> |         |            |            | Read I/O count  |
>> |         | Read       | Write      | devid1 | devid2 |
>> |---------|------------|------------|--------|--------|
>> | pid     | 20.3MiB/s  | 20.5MiB/s  | 313895 | 313895 |
>> | rotation|            |            |        |        |
>> |     4096| 20.4MiB/s  | 20.5MiB/s  | 313895 | 313895 |
>> |   196608| 20.2MiB/s  | 20.2MiB/s  | 310152 | 310175 |
>> |   262144| 20.3MiB/s  | 20.4MiB/s  | 312180 | 312191 |
>> |  latency| 18.4MiB/s  | 18.4MiB/s  | 272980 | 291683 |
>> | devid:1 | 14.8MiB/s  | 14.9MiB/s  | 456376 | 0      |
>>
>>     rotation RAID1 balancing technique performs more than 2x better for
>>     single-process defrag.
>>
>>        $ time -p btrfs filesystem defrag -r -f -c /btrfs
>>
>>
>> |         | Time  | Read I/O Count  |
>> |         | Real  | devid1 | devid2 |
>> |---------|-------|--------|--------|
>> | pid     | 18.00s| 3800   | 0      |
>> | rotation|       |        |        |
>> |     4096|  8.95s| 1900   | 1901   |
>> |   196608|  8.50s| 1881   | 1919   |
>> |   262144|  8.80s| 1881   | 1919   |
>> | latency | 17.18s| 3800   | 0      |
>> | devid:2 | 17.48s| 0      | 3800   |
>>
>> Rotation keeps all devices active, and for now, the Rotation RAID1
>> balancing method is preferable as default. More workload testing is
>> needed while the code is EXPERIMENTAL.
>> While Latency is better during the failing/unstable block layer transport.
>> As of now these two techniques, are needed to be further independently
>> tested with different worloads, and in the long term we should be merge
>> these technique to a unified heuristic.
>>
>> Rotation keeps all devices active, and for now, the Rotation RAID1
>> balancing method should be the default. More workload testing is needed
>> while the code is EXPERIMENTAL.
>>
>> Latency is smarter with unstable block layer transport.
>>
>> Both techniques need independent testing across workloads, with the goal of
>> eventually merging them into a unified approach? for the long term.
>>
>> Devid is a hands-on approach, provides manual or user-space script control.
>>
>> These RAID1 balancing methods are tunable via the sysfs knob.
>> The mount -o option and btrfs properties are under consideration.
>>
>> Thx.
>>
>> --------- original v1 ------------
>>
>> The RAID1-balancing methods helps distribute read I/O across devices, and
>> this patch introduces three balancing methods: rotation, latency, and
>> devid. These methods are enabled under the `CONFIG_BTRFS_DEBUG` config
>> option and are on top of the previously added
>> `/sys/fs/btrfs/<UUID>/read_policy` interface to configure the desired
>> RAID1 read balancing method.
>>
>> I've tested these patches using fio and filesystem defragmentation
>> workloads on a two-device RAID1 setup (with both data and metadata
>> mirrored across identical devices). I tracked device read counts by
>> extracting stats from `/sys/devices/<..>/stat` for each device. Below is
>> a summary of the results, with each result the average of three
>> iterations.
>>
>> A typical generic random rw workload:
>>
>> $ fio --filename=/btrfs/foo --size=10Gi --direct=1 --rw=randrw --bs=4k \
>>    --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 --time_based \
>>    --group_reporting --name=iops-test-job --eta-newline=1
>>
>> |         |            |            | Read I/O count  |
>> |         | Read       | Write      | devid1 | devid2 |
>> |---------|------------|------------|--------|--------|
>> | pid     | 29.4MiB/s  | 29.5MiB/s  | 456548 | 447975 |
>> | rotation| 29.3MiB/s  | 29.3MiB/s  | 450105 | 450055 |
>> | latency | 21.9MiB/s  | 21.9MiB/s  | 672387 | 0      |
>> | devid:1 | 22.0MiB/s  | 22.0MiB/s  | 674788 | 0      |
>>
>> Defragmentation with compression workload:
>>
>> $ xfs_io -f -d -c 'pwrite -S 0xab 0 1G' /btrfs/foo
>> $ sync
>> $ echo 3 > /proc/sys/vm/drop_caches
>> $ btrfs filesystem defrag -f -c /btrfs/foo
>>
>> |         | Time  | Read I/O Count  |
>> |         | Real  | devid1 | devid2 |
>> |---------|-------|--------|--------|
>> | pid     | 21.61s| 3810   | 0      |
>> | rotation| 11.55s| 1905   | 1905   |
>> | latency | 20.99s| 0      | 3810   |
>> | devid:2 | 21.41s| 0      | 3810   |
>>
>> . The PID-based balancing method works well for the generic random rw fio
>>    workload.
>> . The rotation method is ideal when you want to keep both devices active,
>>    and it boosts performance in sequential defragmentation scenarios.
>> . The latency-based method work well when we have mixed device types or
>>    when one device experiences intermittent I/O failures the latency
>>    increases and it automatically picks the other device for further Read
>>    IOs.
>> . The devid method is a more hands-on approach, useful for diagnosing and
>>    testing RAID1 mirror synchronizations.
>>
>> Anand Jain (10):
>>    btrfs: initialize fs_devices->fs_info earlier
>>    btrfs: simplify output formatting in btrfs_read_policy_show
>>    btrfs: add btrfs_read_policy_to_enum helper and refactor read policy
>>      store
>>    btrfs: handle value associated with raid1 balancing parameter
>>    btrfs: introduce RAID1 round-robin read balancing
>>    btrfs: add RAID1 preferred read device


>>    btrfs: pr CONFIG_BTRFS_EXPERIMENTAL status


>>    btrfs: fix CONFIG_BTRFS_EXPERIMENTAL migration

This patch can be dropped, as Filipe's patch below already fixes it.

> 
> Why are these two patches, which are fixes unrelated to the raid

This patchset includes the last patch, which depends on the patch
(btrfs: pr CONFIG_BTRFS_EXPERIMENTAL status). I would prefer to
keep it here.
But the question is there a more effective way to indicate
experimental features with the raid1-balancing as the use-case?
The current issue with the patchset is that `dmesg` doesn't clearly
mark `raid1_balancing` as experimental. Would it be better to add
"(experimental: )" or simply use "()" to  highlight this?

---
[ 3663.742802] Btrfs loaded, debug=on, assert=on, zoned=yes, 
fsverity=yes, experimental=yes, raid1_balancing=round-robin
---

or
---
[ 3663.742802] Btrfs loaded, debug=on, assert=on, zoned=yes, 
fsverity=yes, (experimental: raid1_balancing=round-robin)
---

or
---
[ 3663.742802] Btrfs loaded, debug=on, assert=on, zoned=yes, 
fsverity=yes, (raid1_balancing=round-robin)
---



> balancing feature, in the middle of this patchset?
> These should go as a separate patchset...
> 
> Also for the second patch, there's already a fix from yesterday and in for-next:
> 
> https://lore.kernel.org/linux-btrfs/c7b550091f427a79ec5a9aa6c5ac6b5efbdb4e8f.1731605782.git.fdmanana@suse.com/
> 

Thanks for the review.

-Anand

> Thanks.
> 
>>    btrfs: enable RAID1 balancing configuration via modprobe parameter
>>    btrfs: modload to print RAID1 balancing status
>>
>>   fs/btrfs/disk-io.c |   1 +
>>   fs/btrfs/super.c   |  22 +++++-
>>   fs/btrfs/sysfs.c   | 181 ++++++++++++++++++++++++++++++++++++++++-----
>>   fs/btrfs/sysfs.h   |   5 ++
>>   fs/btrfs/volumes.c |  86 ++++++++++++++++++++-
>>   fs/btrfs/volumes.h |  14 ++++
>>   6 files changed, 286 insertions(+), 23 deletions(-)
>>
>> --
>> 2.46.1
>>
>>



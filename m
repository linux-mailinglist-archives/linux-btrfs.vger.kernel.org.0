Return-Path: <linux-btrfs+bounces-13423-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7C1A9CC7D
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 17:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04DD29C3CBB
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 15:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9AA26FA6F;
	Fri, 25 Apr 2025 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hrBsGOOO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jf86NHnw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A922126D4C6;
	Fri, 25 Apr 2025 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593826; cv=fail; b=tbE+BQcmqmy+933T7B6lukIgeeIuf7qxdSmyh6PrxPuDxCn64ybrlpPogpXQbccfn5NmRQOp1H2JG2kFbUnohBOazThhRV7Zl4BKKPaZds029k5ArmnkbmFaTzCpih7qhpa4LUhAhIVoZ4Sjxs4esqezoevyRWIF0Ja2oV/PooA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593826; c=relaxed/simple;
	bh=TsGhrMqNTY6yHho20RbOtMmsC6BCX/ZSWR86wbFq8Bs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VkbIkg1u7H8axz2HFZXaseL6Re3e6qx2m7kIjq75aEuEVO2jO1YQK9YIVD6H87QbW0XtQsRDqN8tK2YF1oEEQYwtOmKXt2T8KnnudyYfT+voLqytNRvDRtUuWdd9VqZzNbDD3y2rfBN5WM/XhEWmRW5H8N6/2trazL0iktrN1aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hrBsGOOO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jf86NHnw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PEtrP8028238;
	Fri, 25 Apr 2025 15:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=kNqw86HNhmuZiSusRv4VTYW1sTWjWmC8qPuOhfURXOo=; b=
	hrBsGOOOSTj18tC39Wu2qmHVmw5hvJ9Bcsgl9LCUjhtapKBxTMTjLJUF/l6/vl0T
	40rGlBufiXZY0fXqFR1g26W70sUT+5SN4NuoeZYnoGDw6dUyg7wdCfU7z8svYxLD
	OhgNv0R61iqcwoON5DUjDrrZrMQFk7qFcRFeGShDlfqGyTAP6eHcejd/PzIe9qiA
	q0A1pk3ZPbadtOz8U7kBLtnMzg5vw1lhc36LANLUoBj3XeqdCBBV42zoVFg11X4B
	fTraDLuOnsEqJXsMwo+zDd4uaKGwOafAUvJLsTEl2wseTcsfcmaaWROA7C97LMtR
	yQIAZADA49ChpJ5MDKpWRQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468c3br5pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 15:10:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PDtKNl014162;
	Fri, 25 Apr 2025 15:10:21 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011028.outbound.protection.outlook.com [40.93.6.28])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jxrrv2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 15:10:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nx0teoBzYdqgZC6U4gwcgUeCdrvdfy2bXM2x47U2ZXsTl12WbRpUo07TB3CJTdYLI5P38teHU1LRZGH3hinl9bmT10qdpAyHkZVtyTpcz75slWh40HXIE5dKvTMDhQl7COgEJR0PJ5kRjjv5Z3LReEV+woxJJvUlq6OnMG/Ej7lbDxSITQk7qPd2mw6G1UZj1X+SqYvRNYAm5rvuNGy8X7/yQxsQdRHtBptMtVKVlDXvcpWp4XZh/8+xXoHEpTiWStyziOghm9c8OxZcWBR6qlSiY2EV2aV3/NysEMznTT/6mZAVe363p6r7e0VgCDbdNiuxxEQEkGC9Abyf0vrp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNqw86HNhmuZiSusRv4VTYW1sTWjWmC8qPuOhfURXOo=;
 b=SSfxJhBpRbJhXazSbNAwwLi6a8RhgvHgATqob6+n9oei+rjhNhA9ol+bkwhnkxzijQhWjhB+S7Fg1RpX6OHLBTwsg/Oq6iiIVuSOuruGehLNI2X4x2+cWefNFtf+Y9fJtwgQDdMqsCbjaNTwZ/0TycAKmpljnoDKKHAG8zSRSBEk2HIfDYY+7iFnomR9ylYxH8lva/Ni6P6LXxND5jo71nfqaaXA999ySJuPAALceBSeNTPGGn/ZWiiPkpvEL69Y+iWUjo8EXOxPf0dbguayL/Zo21haxH7cn36EkWrByLp3Crm5l7pEmJAUMUBuXCgHTfGTnNiJfDp6AuWMYW2rwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNqw86HNhmuZiSusRv4VTYW1sTWjWmC8qPuOhfURXOo=;
 b=Jf86NHnwlUTIytHn5aUamrThkI7iufcDiTUGmy5RFFGzZQJMrNICj0XHs4lAl+X3NTMuf6aV61+alPecaOD5ib2BVGc75/66VjzwBAjrunVbAd8jdIbiD/BRErNAqcjfQvmirIK6WjmsjLuhzH3/EyE37F9WTNferd03bL0UFSc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6118.namprd10.prod.outlook.com (2603:10b6:930:36::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 15:10:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 15:10:19 +0000
Message-ID: <fb361125-9747-4739-9964-a985bb0534f3@oracle.com>
Date: Fri, 25 Apr 2025 20:40:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs/315: fix golden output mismatch caused
 by newer util-linux
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20250424072907.256692-1-wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250424072907.256692-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: b25f94ac-c4ce-4380-9247-08dd840b4ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEltaS8vUFViOWJ2SHJaUW5wdkpDdmVtNm5EYis5VTdDU0JUYVZYUXdRaEhj?=
 =?utf-8?B?Z1FVTFVEblVsL2hkNTFZaUw4eEtyV2tWM1hoY2lMNDBWN3VONW8rY2h3b29q?=
 =?utf-8?B?N3ZPRWdYT3I3dEpVUGYrSjNXRS9CeS9PbWgxSHFma1NTMU1OYzhpbk4wd0NR?=
 =?utf-8?B?b1RPQjdrZ0kxclNSMitUK2EveHB1Ulh3T0NKWmJIbm53UDJVdCtkMlk3bzBQ?=
 =?utf-8?B?Smp0R2FQT0lrYXZKK25hMjYzZTBEK3owYW9IN1EvVHJERUQ1TUsxaC9mT3Jy?=
 =?utf-8?B?UjhlMGxKVWVpUzlCMlBsR0hGRUJxMGsxRnhCTHF2QUh1UzBvclZhWEZvL2FZ?=
 =?utf-8?B?Wkt3WDQ0S25GYXhYY2lIbGo1OEQxejhOdEV5c0ZiS1JRd3Z3REMyMEpQZ2tU?=
 =?utf-8?B?ZlNYUWNNVy9MTVViUXZ5Si9SYVd1dngrTHhlaFpTR2svV1Rxb1R2NGhnQkJ3?=
 =?utf-8?B?dUoxd2hoSkZvbVV4OWhGNEhBWEtkVFlTUklxNSszUjc4cnUxVUppM1g0NFhp?=
 =?utf-8?B?L0NMLzlYdUdvaDZZUGlOUDZiWGZVRFlUalVPbEh3M0pyRlZQYU5YNnk2VCtx?=
 =?utf-8?B?WC9OeUQxbGw4OHNQMTErclBoNUhScTBrSTdxaVFacGFWc01WWWNaUjkyUDE4?=
 =?utf-8?B?dTdpM25WTFhPazBQblJsUWR6YkhNWHFMRzduN1Q5QkZoL29rYk5FQk1hR08y?=
 =?utf-8?B?TEllRWNENm84YjR2VGh3TVNWMEtKZnhwK3o2UEFxS2d1OWhRYUtSK2ppdmNH?=
 =?utf-8?B?L1hNcEFMWmdIdHN2MjNBWHdkckFMRkRrbmtndWRmaEFhcmY1dVZIVlRicU1C?=
 =?utf-8?B?S213R0pOc04xbkYvNldScmo0V0tkdTUxTFF0RkVLcVlCcm1UdHg5QkhOZllT?=
 =?utf-8?B?dU16TlVWQkxFMEowNEN2VjE2ZlRwYWxjK09tWWdEdlZ6QTZlcnh5STBsMW0x?=
 =?utf-8?B?bDJTUkNiZCtOQTQ4UmpwWVg2YXBFYWdSVzVzTUE4aFVyQ3RHYzlEYTZabUdV?=
 =?utf-8?B?dWlPVmhhZGNUbDR5aVplMnVCbkdtWXNZWUgxUFRiVzhiNEtiekZLVkJKWlhL?=
 =?utf-8?B?eE5tM1YyRXM5aWZxYzZqdXdTSzFYY0wza1NIeko4S1lqNGV5eFhiSXdXUEMv?=
 =?utf-8?B?UnJNeVJCVHMxZ2JtSUI5ODNNa1hoSXZVK3JCUTVxaTh6em1UaSs4cVdieHRz?=
 =?utf-8?B?djd1OVRrU25zaWVhRzZFbUwyZkJ6RzhzMGpUUXFJT3Y2dDRJTHRrZGE2S2d4?=
 =?utf-8?B?U21qZnJJQk5sNFgrMUxnQWZ2dmU4bkpKVEhjaCsxNE5ueVhxemljU1VYcU5N?=
 =?utf-8?B?eCtkVkpHQmZTZWxicm0zZmNHSnRKVFdMckpjTkF0OTBqWWEyOEJRRHdjSWwr?=
 =?utf-8?B?NEFTN3RqSVpGUEZzenVRQTZmcGJTNDVBUVVXYXprWWk3d1B5LzFuRjM2Vzgr?=
 =?utf-8?B?R3RYbXBKWDgrdXVTVDNzUnZDdXZBZk41ZzVFQXVvUnRCekY2WkpYZkNid1VC?=
 =?utf-8?B?cHlLbTloNlM1THR3UHJmbVY1TXVmd2dhUWV6bTA3TFFQNmJ1U1VUWHA3RTNG?=
 =?utf-8?B?WVEzRW1JRm9MN0czOW9EeUhIMWxUVldjOW1zeU5saW1YUS9nMDE0OEw1QzhB?=
 =?utf-8?B?dzJzVEJSVlpDZHVBUDlEWGFDZi9KU0FYTnZra0NLYzRVWWgvMnVVbG81cnhw?=
 =?utf-8?B?WmljT3prWXJNR1dKaWpyeDFwc1IyVnEwaFVLOXpLNllsaUNKdDhlYXRTZldL?=
 =?utf-8?B?UGttRS8rV29UMFB4Q3I0ems5ZW8wQjFpcHhnNHlTL04yNGRBakNCSEhSKzJL?=
 =?utf-8?B?OFQ5L09EUVAwYzBtTjlKSXVUVjR1QS9oZTI2anBTcGpSRmJ0eDdUaDFXKzM3?=
 =?utf-8?B?dFo4T2VLQWRvR2xWUExmZEt5SkNZRlMxMTZNdnB0Y09RWVVtN1RBd0xEci9N?=
 =?utf-8?Q?g7xUzLQJiP0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d29uQldSa0NyOVdLNkNXdXorRDdFYTZNS2dxTE5SSFNEYU0rKzlpK0oxem54?=
 =?utf-8?B?NUlnSzNaMklYSEtzNHRIaXFKdmlScDNwNTFrYkFqUTFUd0NuRDhnTUxzYjRj?=
 =?utf-8?B?aWtPUE5OWnZlYU1xcHIxRTBEeUxsTmxLZytnZ0paUE9Lc1lWT0grVEtzOVh4?=
 =?utf-8?B?Y0xkbHptblM0NmdqZy9xQTBsSUJrWWQ1ZklhTWozem0xbE0zQ0ZhUEpTSGxY?=
 =?utf-8?B?VGRVOVlYT1RxeTFwbDk3bzR3S2NwTWlGSzZFZGFQUGE2SkkxdURYRm03Tmcy?=
 =?utf-8?B?Uktia2hDV3phYUR5U2x5NExuTXIvNU9zVmhsWGhXUlFjYytPS1RFV3c4S0hV?=
 =?utf-8?B?dzZsQVRGUzdTTVg4TVMxd244TStHM2x5ZzVpZUVYZ2pHNmk0SnZTU3ZBTkU5?=
 =?utf-8?B?MVlIa2ZRZ0RHeTU1RVBsYTdPYjVwR2NVMlFqeTMrMVU4cXNEMm1Pd20rT3RN?=
 =?utf-8?B?djJ3MnhiTW9nR1dvT0o4QXJpRHNZTnVLOXZtMGVUQnoyR0FrWWh3azhPUVli?=
 =?utf-8?B?MDRqdENXWHRCUDQxNFJtSnk3dE9NRnhjREsraWdNUnZQdDk1dTFtRjZPTGpi?=
 =?utf-8?B?MFpZdUV1YXBUcTlpejdMUTVNaEVZR3RRVlFwZWFLSGVTNVJKand0amJPckdr?=
 =?utf-8?B?ang2YWxNeUdHSmpuOW1OcmdvZjAwV01xbDgybXMxNUlnVngvUjFITXB0VHZJ?=
 =?utf-8?B?VE9RakxzZGVKSlZzZlNOTmd6QXArNkVMVkFQQ3Aza0xRWWVJb2ZCSWIwS2o5?=
 =?utf-8?B?eEp0VWV0N3RoZ2taZ3ArSEZkQnQ3b0ROTXd1SmpXaGxlV2hMY3VGTDN3TVhv?=
 =?utf-8?B?ODhaamdpZXE5QlpIRDVJNE94QXhVaEpYZXZSNUdUYWhjYnhXZzJjV1p2Q2tt?=
 =?utf-8?B?Nis2cU1HR2gyYjJJeVowK21WUHNta3FtVWZld2ZMcldLQ2F3R0hoT3BUd2RY?=
 =?utf-8?B?SXVySmZQdVJrdjllVjBuVUN0Y09oVHNjMDdJbURYdStyUjRjY2srN2JQK3Jp?=
 =?utf-8?B?VXFoZG1BbUtJWWtrNm5NbThJNWtSd3h5aHNyS3hxNnJZS0pNMXEybmRjM1lG?=
 =?utf-8?B?Ukt5K0dXNDk0K3RRSG82WmVpblJaeHFSWTgvajkvMk12eG9ubllxeGE3NnQy?=
 =?utf-8?B?MDNPTXM3Z3dKUWJ4TjlsaU1rRUJhaUhiUjVoM1JZTzRpaUkxR3NSa2diUDln?=
 =?utf-8?B?bVlrNzRBdG9pdXk4QUJHcHZuUTBkWExpY1ZKRnNyb2dKOGUyVmR0bHYvcUdE?=
 =?utf-8?B?VzJ2eDhoT0M4QVZjZ29VUW1LN2sxbXNaNDRPOVZjQXBvK1dNUG4zbXR3NzMw?=
 =?utf-8?B?WnRCN0t1Ukxtd3BJcUx0TldTQ0x5SzA4akRiRlRFaUtwWGF0VzhQVllJb25K?=
 =?utf-8?B?clJ4SmtpM0VINGZ0ZzErZ2F1SzU1RVMvVWpmb3dnTWZzeS9iYjRMdlNMRVdl?=
 =?utf-8?B?cUtaUlFtdDhOakw1eFR5SnN3MHZSUmZPdFk4d3JKc1FQUkFJclVnd1FPQUo5?=
 =?utf-8?B?VVJqaUNzYjdyeTVoTDAvdkpRcitPK1Z3dGRkdytQZWFaT1MzbldXLzFZQjdC?=
 =?utf-8?B?SVZXQ0JDSWgrU3R3RzIvRGRwT001YUllZ0dLK3VOWE1wUXVENTh6TktxSGJH?=
 =?utf-8?B?eUd0TkI4WENMZzlZdHlYeUsyNFYwSHg2R0hFUzBJTEdrTVQ0UzhQU2RVSXEz?=
 =?utf-8?B?bklvU1AwNjRTOTE0NnFzaktsaEhRc2JaM3l2QXNVUUU0TXZoTGgzbmhFMDNu?=
 =?utf-8?B?T2RvVVVNVGFKVzY2N2YyYkZrQll3d2QzVDNZbXVYcGZxSGdOK1NNbXBiVGU1?=
 =?utf-8?B?VGZwbk0xMlpXeDdYakRjM0M1clNKek5YQytpSGpmK0J4eVEwV1dzemNjUVhF?=
 =?utf-8?B?NHdnM01hVkxIYWpQOUQ3SElGNjdJaFU3T2FkeUNRTmlCemRPcHEycHZHL21o?=
 =?utf-8?B?Q2tUVDN2b3FwRG41cTFDaUJNZmZleEJlcVY2SUYzaHd0SnROL3BEd2RrSTZt?=
 =?utf-8?B?S2NBd0tVU2xLSm9NdmVWRU5FbGRISzVtOEpxZytaSTNvT1pKb3Z5b2NQQlk3?=
 =?utf-8?B?VU1zUS9uaUJtUkdwSy9BL2RPQ1owZzMvNUJVV3lhay9iS1lPOVU0V3MvN084?=
 =?utf-8?B?MGtIbzhreVU1MW1sL2t4Nyt0TG0zL1VseVl1dEhhdStDNEM3eHNHSHVBb3Q4?=
 =?utf-8?Q?Mad4ZDDNo3yVHu36LIgoVBB/EbCXpmexhLzqlDrZBggK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	akZnwrq4kP+X/OBXJOb5Uud+tlmEQZH/RaJnFk/g/Zi9wwq+84PzyCVe6yXLbVnGCelm+CT154agKGMsRb98uIb3xvdVXzpWouYRU7FdTs6nSZoPecDiaf6DK8jTiiGMs+OP33JOrs35HPEJMuHXTl7JlOrpAeGTHIfDJWpgY7ERSmQRv0UcB081Xr9IWya62TNvkMnhM1dpu3HIDALcDJEvjC3h2qWEu054kBL2ZC/zzL2f1Bw9b8m7ZdA88BRh6VOZFvsKAF7bzapVB5ui9jSztzE0MCnFKy+fpS8LnPlzWmaPv7dykTknLE9IS8xUob3VIVpe10+djzrt4Rsk8FUH/DUeJWHKtmFuFyVodDbDOI6jByPWbLCW/WVL9oIUM/muX+nTwXr9ZfedMMhzMWIh+yDlE6SBrHSJouoKRbX/rH1Q6Ir2QFP7GnsUrS8b7Di2QQDb1PrUHQNEjAXQLJn+LrilXckMcs5cgrDgOj0ADKyQP3iKdfkJfWW34QVU7Q/bpKPoqxQSjfk0363/fnppjMy2xiLklO5xhFoPBlnSlP9vFOj5hkJ0ruPC7SPXUStZueL2E4PzK70Lxvcyry25IHEowy7WpSzeLmqhUmQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b25f94ac-c4ce-4380-9247-08dd840b4ac8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 15:10:19.3881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIyUgsrm8HzxPFT4A4sRSSPDtqoY6+x62K2PbXSKV7OwUY10SHoMzuZ7Di3fQ3PIFYn4fspyqKHUD77/71O1kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504250107
X-Proofpoint-GUID: 3C2I5nmFD_HyZHryyC-GHB6zx3hyLU78
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEwNyBTYWx0ZWRfX18x+KYBgvE1U 0aUi2Ue05LGNHsiRK86tcL26bryGHdSUrq/MRW4PZPqCQML1MpGMYtIkCY1NPHwOoAS7i0HsNpg s22N2ihKq2fnw7UhPU/le1bmVrJB8dpZLZBSYd/gIT309sDHaf1b9UzNNK9JUPmFLA+jXy2V8I1
 iQiU8R0Fdfz2Do0T76vr3XjpfbO+sKNO2ps8P+jP/xtZmPp98jWou+3znrUTwgX40eWEfMqShKp W+Oypqk82Lx4A1nnNtFQ8SD6g65pkAFlzuidlwY/MhCratjwRIrznRUgfdb5QxNDoYIeSjGHKUL MCysmTRyLVDv+u7kg9RR5aH2DdBMbq77rbFRz2XYSkxLRCn9kc4dQheYK6+qiNV5FxqY/qwFmoL tukDVEsh
X-Proofpoint-ORIG-GUID: 3C2I5nmFD_HyZHryyC-GHB6zx3hyLU78

On 24/4/25 12:59, Qu Wenruo wrote:
> [BUG]
> With util-linux v2.41.0 and newer, test case btrfs/315 will fail like
> the following:
> 
> btrfs/315 1s ... - output mismatch (see /home/adam/xfstests-dev/results//btrfs/315.out.bad)
>      --- tests/btrfs/315.out	2025-04-24 15:31:28.684112371 +0930
>      +++ /home/adam/xfstests-dev/results//btrfs/315.out.bad	2025-04-24 15:31:31.854883557 +0930
>      @@ -1,7 +1,7 @@
>       QA output created by 315
>       ---- seed_device_must_fail ----
>       mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
>      -mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
>      +mount: TEST_DIR/315/tempfsid_mnt: () failed: File exists.
>       ---- device_add_must_fail ----
>       wrote 9000/9000 bytes at offset 0
> 
> [CAUSE]
> 
> With util-linux v2.41.0, the mount failure error message changed to the following:
> 
>    mount: /mnt/test/315/tempfsid_mnt: fsconfig() failed: File exists.
> 
> Thus the existing filter only striped the "fsconfig" part, leaving the
> "()" without changing it to " system call".
> 
> [FIX]
> The test case is doomed in day one by using a local filter, which
> requires stupid catch-up game against util-linux.
> 
> Meanwhile we already have a much better filter, _filter_error_mount().
> That helper can already handle the newer v2.41 output.
> 
> Let's use the superior common filter and update the golden output to:
> 
>    mount: File exists.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Remove the cursed local filter and use the generic one instead
> ---
>   tests/btrfs/315     | 22 ++--------------------
>   tests/btrfs/315.out |  2 +-
>   2 files changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/tests/btrfs/315 b/tests/btrfs/315
> index e6589abe..9071e152 100755
> --- a/tests/btrfs/315
> +++ b/tests/btrfs/315
> @@ -19,6 +19,7 @@ _cleanup()
>   }
>   

>   . ./common/filter.btrfs
> +. ./common/filter

common/filter.btrfs calls common/filter, so we don't need common/filter
again. However, upon closer inspection, there isn't a filter originating
from filter.btrfs, so it can be removed.

Fixed and applied.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks. Anand

>   _require_scratch_dev_pool 3
>   _require_btrfs_fs_feature temp_fsid
> @@ -28,25 +29,6 @@ _scratch_dev_pool_get 3
>   # mount point for the tempfsid device
>   tempfsid_mnt=$TEST_DIR/$seq/tempfsid_mnt
>   
> -_filter_mount_error()
> -{
> -	# There are two different errors that occur at the output when
> -	# mounting fails; as shown below, pick out the common part. And,
> -	# remove the dmesg line.
> -
> -	# mount: <mnt-point>: mount(2) system call failed: File exists.
> -
> -	# mount: <mnt-point>: fsconfig system call failed: File exists.
> -	# dmesg(1) may have more information after failed mount system call.
> -
> -	# For util-linux v2.4 and later:
> -	# mount: <mountpoint>: mount system call failed: File exists.
> -
> -	grep -v dmesg | _filter_test_dir | \
> -		sed -e "s/mount(2)\|fsconfig//g" \
> -		    -e "s/mount\( system call failed:\)/\1/"
> -}
> -
>   seed_device_must_fail()
>   {
>   	echo ---- $FUNCNAME ----
> @@ -57,7 +39,7 @@ seed_device_must_fail()
>   	$BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV_NAME[1]}
>   
>   	_scratch_mount 2>&1 | _filter_scratch
> -	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt} 2>&1 | _filter_mount_error
> +	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt} 2>&1 | _filter_error_mount
>   }
>   
>   device_add_must_fail()
> diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
> index 3ea7a35a..ae77d4fd 100644
> --- a/tests/btrfs/315.out
> +++ b/tests/btrfs/315.out
> @@ -1,7 +1,7 @@
>   QA output created by 315
>   ---- seed_device_must_fail ----
>   mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
> -mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
> +mount: File exists
>   ---- device_add_must_fail ----
>   wrote 9000/9000 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)



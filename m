Return-Path: <linux-btrfs+bounces-4211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5D88A3F88
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E561C212E5
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BF05822A;
	Sat, 13 Apr 2024 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SmKauk7g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pTqHaJUk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571A61E535;
	Sat, 13 Apr 2024 23:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713050057; cv=fail; b=qhk7BKSRdTyLqwo48rTNZMHHNW/wXlQUOQHhLqcdmC3w2kZPogwoSE2iqP3REnGpwM3duMzYA4YApzUms+Iu1Z9X+JZYPxZRP2pCexKphcaWooLF8X3/pSRHqkIXpzTDW3OsqLIZW3gurIpXP5f8xCmQBJXhBvh4BOhaOz9d6kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713050057; c=relaxed/simple;
	bh=HXb2XHnvkWOtwz0rWo8hPPKmaMm3xyxPL73qaNoMPjA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SQSP+tDCeA0omzMmRMDs7tyfmaMhwbA61pRBfVWouWS+N2+oCOo7hzNlwSYrdZ4i03ZFnWZn3A37XZrBFV9cAx31HuN4Z3mrg1iw+az+BU2G2j3/mK8r7gtz8pPB7fnvhTK8EULARC3LX/1AXzUaKr0aQimNwmtfsHysF4T2WkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SmKauk7g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pTqHaJUk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43DN0x4r030719;
	Sat, 13 Apr 2024 23:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=SqxL0TPWy4VHgADKig1eccSqQSknrzbDuzCr7bCB1fE=;
 b=SmKauk7g7FNYfxN+WV1Ex/+TB2U12Md1aGFRndmSBoFgfv1THxPfnwQf9GvsuKOvFIRi
 R4UYyETwsrHtVOZANPa7z+cn1yxZdMMNj4Pxsl3dN1CXo+UTiZeLL3pBurH+gvYUKmuP
 O17dwZYogBvQuHK0sgqwzAe8i55drYEVkt1898vZenPOUEecrBR7z9XiP1AbImkDZ6u6
 HKJlwUAT9FnOydsIlkkpwZdiOc7tG8DF+ZAsNg+nziwAubU7foHpOWJUktzZFN5n1aeg
 NZ21I+V0O94fg/4AHUPE6Wm9HuTyUlKb3aUMDtQHYmI9yX45zs1fW2NcBwV1gvGX/fD3 AQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgycgufr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Apr 2024 23:14:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43DI4me1029247;
	Sat, 13 Apr 2024 23:14:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg4dh2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Apr 2024 23:14:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFUYSBEYQbOdT6B0AE5VijZ18MmbWpWglZnqfNy60pr+qETruqcJE26vjVmPxyE+c4ZZqjEBd3jvwxD9ukhnWdDk2yGjlLzuv/duZtlYq1quErTySeHiZd6JQU1FBMWYTBxU+q3o7whKel15h4EWljZFEv5OuQySBSelTzIlZloBb7uSpryG5IXRt3VVm2wxoNZFroVtprDyEGQFt+lJuBSLSDv66GGvzDmyoUToUgKPokhlyPzqdbt5gjfw6zTZ2MPvMc8jPXeXbVrUN/68m/8ZsrBrWGG23hSGT/OwvvCnaVWH4y+AfuvLsiUX0nED0SqOT6IAuQnYRqVniX8DqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqxL0TPWy4VHgADKig1eccSqQSknrzbDuzCr7bCB1fE=;
 b=OitkmxedwQt4PVqlFaBR2yW++yo4E7i8IfdKsIufyIoXwSRCz50TFZYuv0oABBKcUANg8bKVPBmSuBLE2y8+f9G2aRN1NODrLzsVHkXtPMGaRZOFnXXOWWJJA6CNvCkIZ3BgHrWVyMZ5iy2vfAO9DoODKV2PHgYesBRsPIC+qld07IjsBFPOBmYaQBDINKaG/ZszViowNtiKSktWk7/nujR4Tj2nZpf6fhTDuMZCuYR36kfQ7vj6g9GXI1JFOxMjLEmpszVpW/ANNOSxVUgyXsTzgnQigIc4rvIv/1FLmhlvoKP2LFYKaiWTUOVx1DGb2hRFC4tlQ4UaJ3z/pPfJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqxL0TPWy4VHgADKig1eccSqQSknrzbDuzCr7bCB1fE=;
 b=pTqHaJUkIEeBCEmVPypWkPXwFplRTrl51CSjppEYzEt9i0uvOnC6cZM49QRYI+S8oGU64usvHdS6Re4H0kYf3Elvp2W7H8x9BOz9Jcpt5zF3AYFW7vXvOjYbQwOTLWvGDGoB+dp89WMjD0OEkEyjJzeYdwrOwGrUMHhey3V1zFQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB6429.namprd10.prod.outlook.com (2603:10b6:a03:486::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.58; Sat, 13 Apr
 2024 23:13:59 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Sat, 13 Apr 2024
 23:13:52 +0000
Message-ID: <27c469b2-95f3-4232-8b86-1c8527eee314@oracle.com>
Date: Sun, 14 Apr 2024 07:13:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next v2024.04.03
To: Zorro Lang <zlang@redhat.com>, David Sterba <dsterba@suse.cz>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20240403072417.7034-1-anand.jain@oracle.com>
 <20240409142627.GE3492@twin.jikos.cz>
 <20240413192824.sz4ppx3rmdvcov6i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240413192824.sz4ppx3rmdvcov6i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:3:18::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b2bd25-1589-4085-8ce8-08dc5c0f626b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GHc211tNf4NM33UoRIvB6u+ovT1ADw1iNTyfxGNlLM1UpWekGyhwpIfaSlBtX+nssbZ8KtA87aE8yWGud5MZ/11aYJL0pdr1ck+rWo5BJR8hEPSPG6AoYfCSbUNDuDp9d2yMjCHTJzzls3a2rTZv/viSqjMUhXcq2bHD6KyvDyU+fqAclkHg0BoCabsVs1WSJDc9RqOJ+rV8K+Hq0A5bIq31rBRFmO3rMppbdlf3rJhjzZXGMNpXbDTbKNuNiqw13iHFfWgs94fbYK+md5Ez6xpJDWDLQ2z0tSK+ppTEnLzcAqkkclHNSEdJHXIK5jnyazYFqB/iAt7QnckBrV2VJsIiCYPNCuKn+sFCbYDQYvG1vJPlL2kEt+D6CZHkbYutqq34Rwlm76KtF1/YFwn/FdZ6ag5wKFF/+QWuXlhaP9kShssXWDiGq5SrW5u97aoebJcaHScyAy3stJ44Sbx+XJ3NNIizwSiBw81FRiPdIiQFbqmjQ2bJgqiOeUXS8xiJIgGRFeX+RVRpfi0Ar2+sFw6PsvtL0bs/aIFCDo2rnA7xlhV71DbvZ3WBNePtQNU/Cv1YyyZtnFGEHjAH6mQPEFOur33XXKTDtfiXV77Sg2k2+d/cUAl4ZHYXKW5bXIN/V5YkAtn0XXu3H6t3r4mEiwuy43aeFMovgTkTmg0N1/g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cWRrMnY2aVNsdk9MUmtnRm1KT1QreE5KQ1M2TFNveW1pdFRDakl4emlPZEJy?=
 =?utf-8?B?VGJLNm91bXBRRG5ydDVOa0VON2RJSm9ZYk1iU3lSaHJPQUxHM1cyOHB1VlpR?=
 =?utf-8?B?eFNSVjhZMmtNREZXZE5XZjdhS2dHZU5HeHIvZkJDMkV3cUIyaGpjS1l4bWh3?=
 =?utf-8?B?OTU0cUtubmk4R1ZwQ3c3OVpSVm00eklPcUp3Ky93TVZET1AyUjEzNmR4dnRW?=
 =?utf-8?B?amp0R2liQjF3WFQ0NDVMeUpKUUltMFBWODJjVEdWRlZhbzdDY1hVamZkZzZq?=
 =?utf-8?B?VXdlSjNiMDJ0dEl2bkJPY3RlYkovQlZaTzc0eUJ1NlpwZG40SkRFeG1KS1hz?=
 =?utf-8?B?MXdTU0xxN1BoUXdlWVd3RDlPQTlqYy83bWZDamtjTldWcHBieXkvWjQvcGx2?=
 =?utf-8?B?cVM0a3FqMG0zQ2RoTkVSWmppTzFhSkQ5S1owd1JaR3F1R1JHbHFuKzNYUkhl?=
 =?utf-8?B?T0V1VVMyby9nbTFGWDRrOS8vWWZMa0ZOdzIrV1NsUXFBZkNMUjE1aUdhU3Y4?=
 =?utf-8?B?OW1CbjhMRkVkMit2UXlXa0p5V2JSUW93SmlEMkVDMm9hcm4rNWsxbFhuUDVE?=
 =?utf-8?B?T1dwMFd5dXpWMzlvR2N6cGhYOFNvOHV2T2tNeXpzLzVKU3hVelJvOTIxMXkv?=
 =?utf-8?B?QXN2UnpsRnUySFNBWnZ5amt2bURYUmVzVEtQK3p5ZFRicVN4M2FzYzdVOGZn?=
 =?utf-8?B?cUR4TU90d3J1aEh2RFFXcU9pblIraG5pamp2eDBHOWhlai81Y1VlQjUvOEk3?=
 =?utf-8?B?eWVQN1A0L1lQYmJKYi82aDlvb00yVzdMdTNMeTVSdE40YUNGc0xrSkJKMSs5?=
 =?utf-8?B?cjUyZWM0OFNQRlhZRXBVM2pFR2IwY1c0eWM0MXJqcXJLQmMzcFVidXRySmxB?=
 =?utf-8?B?blltMmxaUnBjVTRUSlRtN0VPN1M5dkx5TVZOZVZnWUwzeG9DR0V4MmMxeElJ?=
 =?utf-8?B?eElSNzN4OUR3Z1o1ZWpqU29TOGdiMjFOK0tBV01MOGVpaDArdnFKVjkxNXU3?=
 =?utf-8?B?Um9KNExYYUF3SVhjeE1ZL2E1NkFUVE1Rd3RaNnRCWjlUOG1EQTl5S0RpQXY4?=
 =?utf-8?B?TCtXcmFEdDExVDArei9IazR5Z1BxOVdsV0dNWmQvZGdVN2Frd28vM0hvTEE1?=
 =?utf-8?B?NXlkK3MzMURaODEvZHhDaHFOL2kxckxTQVFrV0JuSTVTdjNMRDR1Tkp4Y253?=
 =?utf-8?B?RmVYdElBQXZ5Y1lJaVFxemRoSzJSWXRQcE45cGtsOG4xanVHL25abmFWM2hz?=
 =?utf-8?B?VkNuaVpKMk1tK0d4bTNvbGJNSmVCTU9rTmp3UnZoNTdCVEhmckhBV2Z4Wk5I?=
 =?utf-8?B?dkNRVVN5Nk05UEwyOEdOZUZjVnhVaDl4V1VoY0U3OUFYeDg1Sk91Kzd0RGJ5?=
 =?utf-8?B?N0pvTTdrQ0Vhby9IQSt5MWhhd2Y2YmVWeCtYTGVKZjhxS2MxOTd4RFdHTGRv?=
 =?utf-8?B?YXhmemQzb3R4cExIR0JJVVplL0dCb2hpem5EZzEwQ0o3SERHMUZEMjd5NVZ1?=
 =?utf-8?B?ZU5aRFNEc21wbUNWSE9odkVQaUJIek90QkxacFV4Q08rakFEa2dSUStDT1Zn?=
 =?utf-8?B?bDg5NTRRVFBGcmFSOWVMbGZGNEhlSUlnWHRsam8zemVCb3IwckdRVm8vRnZZ?=
 =?utf-8?B?TjJhUkMrYXh1ZXoycFhtb3IzYnJFZzgyYk5iN09CbEZIWWdvZzZUbnNoVE9j?=
 =?utf-8?B?eGIvQ2lBT2JqWUg2K0MycytiQ2hmaFFEZFZhYUZRdDBjTjloalNRQm40cUlB?=
 =?utf-8?B?RlZhM00wc2djdldoenQ0UGZFV2NPSlo5VjVlMnNKY29oRVNWRGs1c044Sm5I?=
 =?utf-8?B?Tm5nMmVBNnFEcmI0aEtEN2pVOVlZNjJHYnBmSnVwd3ZxYTRUcDNsQUVqZlZz?=
 =?utf-8?B?VUtzKzR3WmJqT0F5cjZPZkZGblhiR0VUR1JLNUtMaXJ1MFFBMzZtSXFhYjBr?=
 =?utf-8?B?U24wUjNqQUFyTnJYWU91cXpxU2lNZ3Q4MGlWSTBXVkRVbkowMFYxRG16M0Fn?=
 =?utf-8?B?Zm1zWnFYRXBqUFFhNTYrVHpBZXRJZ25OR3lRUEpYY0kyNnVFekQ0ODVrcm5U?=
 =?utf-8?B?cUR1RVNjT3dSUmpJK0JLbVRzd2FBeFl0dlB0Q21qU0ViWUhQdS94NDFDMlFl?=
 =?utf-8?B?Z3o3RHR4dW8xZUxjMitQSit3NUtLdEJLWlJlVy94ZkFtbU5qYjlkSDF4c1pB?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1SihZakAGiCLYIhn5I4/z6xqReNNVYqme393h1gDgp0YNHkEP/osIlQuxwSvXVjlEVagYra4fnhF1QzyT6B3cwl8fsaxUebkWwqA3X3QA5nJxP6XuJZW/psbe+0XoHsfp24pMJHKm26ncUGZ48/pIViYBSmEkGGyFsdrePAAlbAezSE2lXxRHYaLpJGV6+M5QXcDTeDtZpzquxO6SY7iS0cPDpEHYX10Wb7353J+6uy1w1FJuGfhwrfnX4X3nKPh62bQUXzWF3/oGcac2boff4pLTsPguNtwXR10RobrY2waUUe3MEO7mDojlSuxsm23jPxVx8Q4Af1OEBeBD2GD6gwvL4OD6oFKwwnylpFuZcXzHc5oqP3hvCBjmKj4KzJMuAXhTpAk4rt4dUPYGR93imz08MMFAPmzyxEMzyyJRFRfF9rCdRB/xJmuQfXgagOaujpQ/H1wAYKJ6LM8DdgMhrSbshhQUQ5Ad5rnyVfRhH6bYurupLd4Jz/kHjDYhDG57Z91k0mobv3njwIiX2dz5ECn7FTIZoOPztuPCyT7gzgwt/dBUKUdb5XSyZ8mplLlJJZx6++TvVCMdt9ppk850AGDvRDCOxuzt1sEgQ3CK/c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b2bd25-1589-4085-8ce8-08dc5c0f626b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 23:13:52.8284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wq+v8xfa27sgZLvMPlcQrriJZ+Rct9CqyJt9FKZKMBo60jxgzsggLIQu3wY9vetYn6YV5mJ1YoB3shXC40TO5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6429
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-13_11,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404130174
X-Proofpoint-ORIG-GUID: EIUU32ZKxBb44yg7DyLeqFv0Z4crqOGg
X-Proofpoint-GUID: EIUU32ZKxBb44yg7DyLeqFv0Z4crqOGg

On 4/14/24 03:28, Zorro Lang wrote:
> On Tue, Apr 09, 2024 at 04:26:27PM +0200, David Sterba wrote:
>> On Wed, Apr 03, 2024 at 03:24:14PM +0800, Anand Jain wrote:
>>> Zorro,
>>>
>>> Please pull this branch, which includes cleanups for background processes
>>> initiated by the testcase upon its exit.
>>
>> What is the ETA for a pull request to be merged? Not just this one but
>> in general for fstests. I don't see the patches in any of for-next or
>> queued.
> 
> I think you might be confused by the subject of this PR, there's not v2024.04.03
> version, and no plan for v2024.04.03.
> 

It is the patches which were pending to be pulled as below, and I see 
them now in the patches-in-queue branch.

--------
   https://github.com/asj/fstests.git staged-20240403

Anand Jain (1):
       common/btrfs: lookup running processes using pgrep

Filipe Manana (10):
       btrfs: add helper to kill background process running 
_btrfs_stress_balance
       btrfs/028: use the helper _btrfs_kill_stress_balance_pid
       btrfs/028: removed redundant sync and scratch filesystem unmount
       btrfs: add helper to kill background process running 
_btrfs_stress_scrub
       btrfs: add helper to kill background process running 
_btrfs_stress_defrag
       btrfs: add helper to kill background process running 
_btrfs_stress_remount_compress
       btrfs: add helper to kill background process running 
_btrfs_stress_replace
       btrfs: add helper to stop background process running 
_btrfs_stress_subvolume
       btrfs: remove stop file early at _btrfs_stress_subvolume
       btrfs/06[0-9]..07[0-4]: kill all background tasks when test is 
killed/interrupted
--------

Thanks, Anand


> Last fstests release is v2024.03.31, I generally make a new release in ~2 weeks
> (1 week at least, 3 weeks rarely), and each release is nearly on Sunday. Due to
> I have to give the new release a basic test and check the test results at the
> weekend (I have my jobs on workdays), if nothing wrong, I'll push it on my Sunday
> night. That's how I deal with fstests release, please feel free to tell me if you
> have any concern :)
> 
> Thanks,
> Zorro
> 
>>
> 



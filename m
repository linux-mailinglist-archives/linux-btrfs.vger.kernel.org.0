Return-Path: <linux-btrfs+bounces-3805-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7233F8938AF
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Apr 2024 09:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC86A281A6E
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Apr 2024 07:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0959BA39;
	Mon,  1 Apr 2024 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LztCeer9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SegDjRWE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFDB53BE;
	Mon,  1 Apr 2024 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711957267; cv=fail; b=JaObvKOl7W756oPef0s+txxx5RHZXpC/ayC2VcC89b9Hk4UCGgXijhRYCKiB2bl463SIPHuX7taj/rUgZIXUPmR0Y0DkIJ5gm7x6IpRkoMBygXEqrvTWr0oETpjVBTlJ/7Rkj7cXKs0tZQtO76rFaCxX1qHLQkRqRA7oEjVn+ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711957267; c=relaxed/simple;
	bh=X1n6NJqn6JM0s16bL8KIdJcYL7M49sfKD6dSkf++bPk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CPCNt+k4jpkjA/VkxugzAn27m0XukBMjtsT6+pADWnfR5CdXjMIAZF8Aniq1xkvsY/YGoTzjKQ6SPLi+c5mys1jARSRngHyJ0F+GEYAFPBKjaiKZZYRdSTFUnr4WTfrOruQ1M5A5m/z55EeYMhapg7QAdSoauhDzNnZmMb9SGEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LztCeer9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SegDjRWE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42VMesmQ016081;
	Mon, 1 Apr 2024 07:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8AQRO9wTzryO1tvEparmxhgJqHE6iaXSdjzTRBDrvlw=;
 b=LztCeer9PgAVR0QU73GU3ESuQPvYYE2sa3IUJEozBJGT6LnsrZrfAp4q7NVkEaBEOzFj
 tA2a1d9nM5PhAXuaGplEqYoHNcX4YD6Wz6Fnr89rfqhJKzpNKiWBa+gJQLqEahiNUpqG
 tmXW4Sct2afClqGdwxR3adfTR6I7+IXxFdLdl57EjcvlsmTSegXRdjiIUOgFh3toVGys
 2QZyjdIVJku2XDcIeeWO70jEuXI5JEzBf55sP/XtQTDbpyRwXO39t6vK8u8w42e2Ocja
 phb8oIrJMTI/nDkS0tj0HMLurTK8RWURlrpiAcHRlyijR6+oUIAJwujWm5YgYSy28Oh7 XA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x6abu9tmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 07:40:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4316i0Fq040559;
	Mon, 1 Apr 2024 07:40:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x69654hr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Apr 2024 07:40:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHys8FQ6C44SW4qeSUhZ3m42qCiYFNZ2zbY+DxhTMNWLaGqOjfhN3iI/i9DHzLH4FrfJ3KqrO0s0Kx2vSy81cxf76wdPZAVnNqu1plFZX4Ba1iXtvPl8CwxpOzmMWgrPxhLoQEotg6ywK1ULAxAHAg2DPyUVvkI40R9H/swEdjJ0/xX8cxMS/AkFhyVCW8yLeWjWWpOX4iFrwbfEj8nPMPVPdF7zueSWGAhnNrDE+2mMT5hBw3x1/WkaNVv3n99isNZIw9cEjrJhT0qsQRERgCCLyX49CGVFR+5/PyL18XhF9Qb/pwTSrjb368MJ7b2ysBoscV4p/LT2/59qy1OFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AQRO9wTzryO1tvEparmxhgJqHE6iaXSdjzTRBDrvlw=;
 b=GZZgByj8A+cSs0gOFHIFbwnLQpOuAUUdEaceuIr6Sz4Xl4/+b/gWeWr3qzWOQCh111dJ4s6JOHZubuBYa1dLsuBI0rrTtzQEENQxT+DH2uFF5pk6b2CttU8pQ4vZoh3/loRXQNuvY9IMn75OmdVn0FZ74iNI4K2taT+7mVWTMzwujNIMO6e+oyPpJEJs/0h9yR/nxOleZ9O+741TlEmpsedqUwzmTFzPDRshJb8M8JxXIGCJt0Z0S547r4GNRo2oSY4t0xeIEVDueFKMQlTmoCKezVgO73TUXxgJ2ZSXhsGgMBBGdbRtrzrT4m9SA5cKlYgE+1Q9QnV3GDRmf6FIhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AQRO9wTzryO1tvEparmxhgJqHE6iaXSdjzTRBDrvlw=;
 b=SegDjRWEu6q8fH1aQ/ULM1orFokkLZnb1FhYXd6Dr/899yJyIZK7lWwYORLNK04LCTpfEG3sQP+6tzKYWG18JVu7BlMi8k74fa8Ze+lWZA9Q90FDPT7joL3m3SizbjUcqpIuHTlQgb7wMh7XFKdQtxNCNIROvGMc4LiGXLHdayE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ2PR10MB7828.namprd10.prod.outlook.com (2603:10b6:a03:56c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 07:40:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 07:40:52 +0000
Message-ID: <1c581fa7-f481-48b8-8a55-fed0ea5ed38f@oracle.com>
Date: Mon, 1 Apr 2024 15:40:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/btrfs: lookup running processes using pgrep
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
References: <572b5b3f11cc414bd990d1580f8bf287f4797676.1711952124.git.anand.jain@oracle.com>
 <a21b3427-ae9f-42e3-a335-3fcb3c10e081@gmx.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <a21b3427-ae9f-42e3-a335-3fcb3c10e081@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ2PR10MB7828:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jsO1LgNvMY2kzdAiDQR7a5UqOk66U9yKevW32tqoZly/RbF/nYW9LaY4C4NkWMPKUs1cN5pxy3F/aGRanEQIioLl0o2YeHcuWOAT+BmNuMYtGLVc9LFJsoPW4X25iEKWofQifvkOGTL6L2ldxH891VbSk2yc48kbwuPeTeJsIIOH1vVjsYeMcVXRJ7TR7ZO853bwfGr98E+/wZIV+xiEBbZ93d9X06Ifxg5u4vhPWjty6BCdCumptRBU3d+iGUDvEW1tKskYCQb7c5Gbxah12HvM0f8iMRfnW346hcPFqdG4QWuk4Z5k705REbUPi51OmImB0ywVKm1ew2GzRCjGxQo3vf0HnJ6dQG7YCBH3y/MJYB08gkXjUNMWA4ROesijXEc6HnWPcBVnVLqHhy6wqDs2alBFzf/Wyg3MboYH/cz76rc+Y3/WvMVzizesWG1WIvgxGfuUmSADSPLC/xKAFeKQC/+BoEy/01xgxabnbvbZB3+x7LGv/aXjWurkj24zQbkpO4nk6FXFAmk3kpvpQViC0V1TGYBI2vGrCUlwG1tMrKziMOW83ZrFim9zJDMVpIYIWcWYQGVQeUbPHlwJuKgbR8fTO3f1AhB+LamVJHaBkj0USJQIHx20fO+ZN0/dZ/c5DViTPU18SiEJNCPbkQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WC9hQUEzY3Yxek52ZDkwYkdIbjhrN2wvYm1WaFhuQWJPOEx1VTdNV3RGWEJl?=
 =?utf-8?B?aWtzeWw2WlV3TEFpak1sUmRQWCtnc3pScHd6dW4zMmo3Yms2WXB6aG9XUGdE?=
 =?utf-8?B?TlZjZld1RGNJR2dkTlZhZmd2TDUzWVp5YUl3VEtqV0w4OWR1Y3Yyd3ZpZjl2?=
 =?utf-8?B?SS9LNTNDUGo2NVFvM05qVW5HbFRweEIrSElFdU9Zc2RPQXRmamZFQlo1WGgr?=
 =?utf-8?B?ME1pc2ZmV2o0R0pOb0paSkNYaDNnRS9KMjJxLytVQWZiSW9LaE9YOVYzRWNG?=
 =?utf-8?B?bTExQmhTVnlRcWdrcFpKNTQ3aDFmOGJUNnlFNjdyNzVMTkNnZ25USi9RTVY1?=
 =?utf-8?B?MlEvZEs1MVVjNVk0NVJMYXRUTks0WTFxdGtSbFluYXh6bEVCOFpmTStiT1Qy?=
 =?utf-8?B?ZGR5eEw4N1RXUm9DbjY0MVpGVUpOQ0hiT1d5OXFPbmpabFRDMUozY2krVkZH?=
 =?utf-8?B?ZFQvMXhSYXlGd3YvUUIxMjYzTHo4QTk5VDlaSm5hajZUTWRPS3JWVUhINWE0?=
 =?utf-8?B?U0FFVUx6S09PWEUrY3lPdWJHM1c0TGlnTW5BUC82MkoxOExITFd6anZ5Y1lH?=
 =?utf-8?B?Z2JrSHNpcHBoMGNTanMyMnNYSnFUSjZyQlppY1BCekJURGNvN2F4cFhzR0Jh?=
 =?utf-8?B?MUxGSVN5bzcyT1hMdDBKazJ3czRyZElUWmhvZ0NBdnFwOXZNa0VMWVZkbUhZ?=
 =?utf-8?B?RXVWaUNrUG90VW1lMS9kZmwvcFB0WU5zVXFpT0RDZzJvWTNUbUNzV2NDVVBF?=
 =?utf-8?B?M2dUVnZ6aGF5VDZHbTRZdENTaHA0N0JFUzhWMHZaWm12QWF5UGxGYzM5NVFM?=
 =?utf-8?B?Uy9aYlZyZGxPNXdqcysrVFJvK3ZpUUtWbFAxa05NdTBYT2t5czdMZkkzWWpQ?=
 =?utf-8?B?YlN5anEzZVFBZmtoTlFNNGlJcDFJeEo2M210aUtiS3FoWTIyM09xS3VxZGhM?=
 =?utf-8?B?MnM1T0czUnVkd0ZQdW45M0VCZ0U3ZjFGSEFiOUIxVXl3UFlhTGVWM0lZSEpF?=
 =?utf-8?B?NEpJRDVvRHJKWFJGU2JoMk5MOU44Yk9LUml3ZG1JR1EyVE9FUmI4aTF2QXVX?=
 =?utf-8?B?RExKWWpPR3ZOSEpRMDVQa3o2dlBEYlVNN2d2M3BHcWRJdC9tZEVSdnp2djk3?=
 =?utf-8?B?T0F6SGJNNXNrdTRicWdpeVhBbnBFRnpNRmRzSkdlajB2NUhCc1JLa0tLRm4r?=
 =?utf-8?B?L2s1ODI4aWZvbWJldDV6Y2FwSjRacUZhUDI0Um5TQ2RmeEVHa2t2bmxYY1BO?=
 =?utf-8?B?QW45VXpjQXVYOEF1bHUvcnYrWlByWUNzeWtIQ210Y25DTjRXOW9MN1owcmZU?=
 =?utf-8?B?RVBubGRpM2lkVG1PajlZcnBaSmJNNzByNVpjZkZnUzR1UW5tdEFRcFJob3pQ?=
 =?utf-8?B?VnhvUlJKSm5ONmtCNW43RG05Skhrc1pKdGU4VHk4RmZpbE11N0xwZU5ZZElZ?=
 =?utf-8?B?QkcrSUMzeHZSUE8wRWd0aVhTZWowZGxXenYwOVFZeXZaSTFZaWRkaStBd3l0?=
 =?utf-8?B?VWxGa2FqSVVmaVFySHRTNlpuM1daS05GN1JzWjlvdTJrZ3VjVVF6cHZRLytx?=
 =?utf-8?B?ZW02WmxoakxNOWZnUnVwSEhhRlB0Wmo5ci93Skt5UEV3ME1xN3R5bUVhcXZG?=
 =?utf-8?B?YVd0UEJXMXErSWZhaXppeW9jdytGVUhkamV2Zk84cUQ2bGZnc2lpZGJwb2No?=
 =?utf-8?B?d2c2WU9RY2U5VWYxRjdzL2xGakVzZWxzYVJJcGw4WVY4YVkvOHk5ZW9HOWND?=
 =?utf-8?B?VmxSaEo5NUZhRTNwV29TZTB5a21aOVEwTE5sakNNVGFyeDdlZ2lCTDJZTnVq?=
 =?utf-8?B?SUVDT3hsanRKQUpHdFpVQWZzN2NvWm1EQ0d4TXJ3ZE5qQ0RDQ21ERmNUYXFm?=
 =?utf-8?B?MzNlN0w5eTlJby80ek1XVThlNThPZlh3N2VuSXltUis3ejROMFI0dXRqdkU0?=
 =?utf-8?B?TVRQcmw4TjVIc2l2NjJSWEtxK0FPalhGWlBQeFhVUVRCZmZTMy9jdityZEd1?=
 =?utf-8?B?bm5SZXI3dlZOSjhHMGs0aEtQR052cDlwUHhGR2JLbyttV0dwUjZBei96V2ZH?=
 =?utf-8?B?UjBSdzQ0bWdwZGhjRVlsTmphT001eUx5bGVsVmRCVXhTeENXMzJROGo2cGgw?=
 =?utf-8?Q?HBvjfEC6ID2f/YnWtj7UYIIvh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XvShrxwdSMuW/LKMCNFbsoYQw4myq2LrpU/Jacd+RW9Fn/5T1IcfprT1Ed/6tGrN4qX0DFI+7Kljg1NNLjRrDcmWMeOb9Xdu3JYvBMW/5jTb1ECr4hTEdMr/+o//Af7Mbvp/aN7pvRF1PJaD6Uzu7TPwB9NYNF/mL40SjRXJV5B3+4LR1LO4ccNMUrmLu2yc+VO3ax+t4lemV4kB4LANC0r8ZlwD3s/znbGYze8FOXioX75pKH9hFw/2iGkDYCOA1f7ql7ewtM6zpoHmxDS+FbxlriND2CIVR0W4EowOdvW5JW9OUlHYyegpIkSueRgBwXXlTmvjc+AJlot37PM3o8H127aIYgA+G4VFsmrCOigrDhaCcVewp2c0ii7vcqYYMuMCBpu6HLRsvL/vLM7RfPA/R7l2szdXPWuY5ZsamohoxPu9wi3bzIwZNt9NUv8WmqK4YW0pzIuxA6qlec0oPJty1bIhLw1l5Re6cuC0S8xIVf0nylBpdR6GBeGBE8cb9vBGtdF28thPAH7Fhk/Cm/cmgWcODr2vXiP+LV2Md6hQr4P3fFCppxejGnVTNmuw5E0pS7N3VguB9HRZRLKVrF5JYIHd4qdbTxhrmzpaobk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbab9a5-8716-4b38-cb63-08dc521f0e90
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 07:40:52.4448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dr+e0aqFzvAwJyQvCr/paiHUwB3RgqK1EQQSmYwSbK+CAx6Aup+zA4YozPm5eMwUTARQ/NyeKfMvfEfVfBFu9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_04,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404010053
X-Proofpoint-ORIG-GUID: W-0ko4QVDfMIZH5zLDkHNDPNrAPxrMcS
X-Proofpoint-GUID: W-0ko4QVDfMIZH5zLDkHNDPNrAPxrMcS



On 4/1/24 14:21, Qu Wenruo wrote:
> 
> 
> 在 2024/4/1 16:46, Anand Jain 写道:
>> Certain helper functions and the testcase btrfs/132 use the following
>> script to find running processes:
>>
>>     while ps aux | grep "balance start" | grep -qv grep; do
>>     <>
>>     done
>>
>> Instead, using pgrep is more efficient.
>>
>>     while pgrep -f "btrfs balance start" > /dev/null; do
>>     <>
>>     done
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Looks good to me.
> 
> Although there are already several test cases utilizing pgrep, I'm not
> 100% sure if pgrep would exist for all systems.
> 
> Shouldn't there be some checks first?
> 


Actually, I checked on that and noticed that pgrep comes from
the same package as ps. So we are fine.

  $ rpm -ql procps-ng | grep -E "bin/pgrep|bin/ps"
  /usr/bin/pgrep
  /usr/bin/ps

Thanks, Anand


> Thanks,
> Qu
>> ---
>>   common/btrfs    | 10 +++++-----
>>   tests/btrfs/132 |  2 +-
>>   2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/common/btrfs b/common/btrfs
>> index 2c086227d8e0..a320b0e41d0d 100644
>> --- a/common/btrfs
>> +++ b/common/btrfs
>> @@ -327,7 +327,7 @@ _btrfs_kill_stress_balance_pid()
>>       kill $balance_pid &> /dev/null
>>       wait $balance_pid &> /dev/null
>>       # Wait for the balance operation to finish.
>> -    while ps aux | grep "balance start" | grep -qv grep; do
>> +    while pgrep -f "btrfs balance start" > /dev/null; do
>>           sleep 1
>>       done
>>   }
>> @@ -381,7 +381,7 @@ _btrfs_kill_stress_scrub_pid()
>>          kill $scrub_pid &> /dev/null
>>          wait $scrub_pid &> /dev/null
>>          # Wait for the scrub operation to finish.
>> -       while ps aux | grep "scrub start" | grep -qv grep; do
>> +       while pgrep -f "btrfs scrub start" > /dev/null; do
>>                  sleep 1
>>          done
>>   }
>> @@ -415,7 +415,7 @@ _btrfs_kill_stress_defrag_pid()
>>          kill $defrag_pid &> /dev/null
>>          wait $defrag_pid &> /dev/null
>>          # Wait for the defrag operation to finish.
>> -       while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
>> +       while pgrep -f "btrfs filesystem defrag" > /dev/null; do
>>                  sleep 1
>>          done
>>   }
>> @@ -444,7 +444,7 @@ _btrfs_kill_stress_remount_compress_pid()
>>       kill $remount_pid &> /dev/null
>>       wait $remount_pid &> /dev/null
>>       # Wait for the remount loop to finish.
>> -    while ps aux | grep "mount.*${btrfs_mnt}" | grep -qv grep; do
>> +    while pgrep -f "mount.*${btrfs_mnt}" > /dev/null; do
>>           sleep 1
>>       done
>>   }
>> @@ -507,7 +507,7 @@ _btrfs_kill_stress_replace_pid()
>>          kill $replace_pid &> /dev/null
>>          wait $replace_pid &> /dev/null
>>          # Wait for the replace operation to finish.
>> -       while ps aux | grep "replace start" | grep -qv grep; do
>> +       while pgrep -f "btrfs replace start" > /dev/null; do
>>                  sleep 1
>>          done
>>   }
>> diff --git a/tests/btrfs/132 b/tests/btrfs/132
>> index f50420f51181..b48395c1884f 100755
>> --- a/tests/btrfs/132
>> +++ b/tests/btrfs/132
>> @@ -70,7 +70,7 @@ kill $pids
>>   wait
>>
>>   # Wait all writers really exits
>> -while ps aux | grep "$SCRATCH_MNT" | grep -qv grep; do
>> +while pgrep -f "$SCRATCH_MNT" > /dev/null; do
>>       sleep 1
>>   done
>>


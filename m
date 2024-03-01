Return-Path: <linux-btrfs+bounces-2960-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CE386D9A5
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 03:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B87B28200E
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 02:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3383B28F;
	Fri,  1 Mar 2024 02:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UjcCrP3f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HIRIHZtX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026BB3A8C3
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Mar 2024 02:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259681; cv=fail; b=rbcgQhTM2UqnwMLFJEZDiR9B7c2TLEd0PdqJJjLPJYXME2X1rLTzg8PQ7LKVHgU9pL0c6ooE7x2h6Dw3IUEk4OpF1TrktW0U5nGR3gMpBkZdnOyV73u03BMzCZArYyHanTwmU64TlYbJmpCqU1k4HSrqF19CimgE/6C8ukQo094=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259681; c=relaxed/simple;
	bh=CgWvIfTgi8YU6ymVSa7NA5HSpMr6jQA4X01znaY6jO8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t1UR3MVC99HyAcWrfJFbP/yHb2xlpdEQA1UIxQI481/xmSS/MJpnYU8/AXbDu3T029+s6A7it4Rg7SD/H4gw8auAWWneOkuvF1bdfe4SfQuumdaezzuqLFzs/Gbn6qYkF8rbNgjxzK0hjWhq6mqbo6l3DVlaJbZQCnQH/+2fMmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UjcCrP3f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HIRIHZtX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4210hoDR012326;
	Fri, 1 Mar 2024 02:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=aOfu27fKWbBi0KY7f/g+GbsWROyUOgc+evPQUldS2c8=;
 b=UjcCrP3fMQopGaeu/U9RyaHt+JlQMq+KpEuJH8mXv8UaMf917qBu558EmksVxocV2oEV
 oGYlm/YWA/UudDzkOwojH7q9QTIOvci/lQmDY7ZHj9EDvu+atYksW4qN8vV9dFURFt7I
 z1CmTQBWLF7NDBcyFdWV2HsxtEHLIpo0eAjUvMwk2YgWA1lxmq0ruY3Z3URn9RA9nqd8
 oS9lgMdmmfhdOS+Qgxnh1/npozvyhoCpRz9mMoSrL8x1zU60GxnYe2DUYOoUsoICWpIg
 FbBlN9en6QSyL18q8p9aLVbdvlXAuU1NjX3F8gh9x7Jnf5ovzLEVpFbYW1MT8YXMT4cs nA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gdqqtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 02:21:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4211gdt3009794;
	Fri, 1 Mar 2024 02:21:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wbdx84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 02:21:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDFB5dSoGCKMXblfY68tVDXLHv7hJqfv3p1mf/nXiamzBKj9kQXnrJ8dbPQ7QUtGw2Yhi+tokJp/b2JMmHkUNC25jR8HgRI6W7+fEwPweSq1r7NyIOsLy+Ib2IKoI9vi3ntZVbhzQQMolVFPU2yMQ4gTFuLvf0aLAvzgwCxuovDZvnbmCxK7Zm50ZEYRw2sU0iJcNy52zHTmATx3DJu9+QHljBKmmwVLZGuvFdeWKDrYXSGYB40EDWwZVDu812wfKEI/xfuRxmfhHTnmruJa2JPrwu+Dnqj660JRWFXxu7TBstGPo6BwMEGkvaZqADDppvZmVm7+KeavTBNHNZjykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOfu27fKWbBi0KY7f/g+GbsWROyUOgc+evPQUldS2c8=;
 b=PFC9lQX2FqCzRfkyaRa/EtZj2a1X7E/uqDe2JK6rk+8b93fwZOHi3fw3+spG5b3qUBEb7uxx1wXJxr1OpvwLJsMTqP+XiwKM+Jb3by3m4E8WUK6ZZdEIAHsO7r65T6zRTz5WzvY9iEtI8py/ngDynwnj3pBET4bwhEMQQ0o+hRnLEkfvFolC2q3GlDjFx09ruXWYZ0uL6b0nMy6kskGHAYiQN+GiKwvsf7Zu0l2DtsMSiWksDux96aYI9RNYAgvnCF93xVlnENP58ef/kCGRwlrA41mDUmAJllqLmDsaLvsTMbkiBnqKaOfNv+AECm1okM9We+rBJSMXLE31Bz/6RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOfu27fKWbBi0KY7f/g+GbsWROyUOgc+evPQUldS2c8=;
 b=HIRIHZtX8SnA9APWgW/LNn4QQrWX2VImDM8QAVc2IzRwfWN0DISrysZs2eCMO+Y4RA9Y0ef4ILBCWkrMFca+pt5NcaOREkM0+aPe56gDBOtx32dGCHHjoqVOTbGWhytnszSqtv7ZhWlkaOWzUCsZ5XTzIn6Fkrk8r5fkHzxl+ZU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4807.namprd10.prod.outlook.com (2603:10b6:510:3f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 02:21:11 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Fri, 1 Mar 2024
 02:21:11 +0000
Message-ID: <b5085200-94cc-4624-a853-a92176f5c37c@oracle.com>
Date: Fri, 1 Mar 2024 07:51:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: support device name lookup in forget
Content-Language: en-US
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <40d13cb5a18a2fcb5e667ee0bc61f2b7a12c93e4.1709233065.git.boris@bur.io>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <40d13cb5a18a2fcb5e667ee0bc61f2b7a12c93e4.1709233065.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: 291c88eb-d05b-4019-ac12-08dc399642ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yN1DRFALGDKTN046F4Q4pyBzyjJrBrUAat8+WrbDDcA0V5SHwg5wG4K4VnxS795FTf5q5cXMxSJTS/o48EqHGw878gmNiToz32wHhNeDc7y6iRhtgk+gD0rXTKgQA6hSbBhJrvrOZ36WnvUPJPEJA5IHbGJsZFvpMv4gu40syPzedqNpT6aqjd/WK6C4+UGFaAqlrcm8YjsESWQAlImKqAeQdEo5tnIDq15S3Bq1brl1GtpKawInFQuhtbE8qnjkwMttlWUQmIzZTzPM+Se+VZqX6L+SbO1+wfZtZE3P9BZKFtYN81j5sVzxrM0vmgMC3Ie/NaHcTZxhYvm0ThCgjt39NOw3WPcxbCvuTS1Y1a7uJvT2ci56q/TqhbEYgUqIblv1j6gA8B02ti2+WlljGbLYPHamzh/o2TL3O3YnXwviBW1UjPBskYReAGAC6RFPenfyx6vFB3GSBrLqT7Fio9SZqEwxmjf/UlRP2A0OOjUt0PrNitofQJ/Tz6Riy+sDmuHYpAPL9BxYqX5CtclPW+WP5izTX78wQ59cgbzB+YlfdmKlCkPy4YDRC8/iG6o+oxbMOjKuKsqgUYK5Wa9Jj8i8iCQVXaalvAdmP+SznWIQTj3AMeLask3/FTPY+ZT83n2T0v743+sORYQR+OKxKQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L3RhNlBmYUx1eUZ0Z3pKZXZtYmk4U3gwNEJ5NjJFWXF6UzdWakJyNE1JN25W?=
 =?utf-8?B?RXFuV1NpLzJGb09uSnhXVFFoa1hEK21KQjgwMVRxVWs2aFVvdVR6NUErbStZ?=
 =?utf-8?B?NG4zSWMwT2l0RzBFYXBtcUZBdTJJVHFOSDJRejJDanJQcjlqbi9QZzBYdFlJ?=
 =?utf-8?B?bmxYTVBSQkN2QW5yMExaT2tHYzhGQVhRWUd1U0E4ajgvVU0zT0l6aVJXS2o5?=
 =?utf-8?B?d2ROZUVKbkRGS2xxRWt3bXI4V2VabXMyWllJM0RlaURZNnVqcUM5aVp4bklP?=
 =?utf-8?B?dzBtUUxlUFVralljV053T09veDlnVnVqbitxcHljdDBsQjZSUWtHNDV2YXV4?=
 =?utf-8?B?RVB2R0ZFcThvUXZJenF5ZzUrVjhwaFRuQy9lYnNiSEdRQ2hIWWREaWlLb3ZX?=
 =?utf-8?B?Ui9id1JhQWlsNU9IZVhVOWlxOU5ZTzVqVzVvLzlzK0V6c1Zsb0JYWkNsZGE5?=
 =?utf-8?B?R0E3Wms1VTAwVEhqSVlVUDVlZEszVUVPT21rR0pUWksxdE43UkdmbnhzSmZJ?=
 =?utf-8?B?R1NkUlNkdngxeHlaZVZjQXRxZ0pXZ0FBOVo1TDhYTVNBVGJSRHRleFNudHVC?=
 =?utf-8?B?TGpnMDRzNmZtQmtJVG94Q2Zub25LN3RheXdsM0lSdUpBb20xTExmQzZYMEYv?=
 =?utf-8?B?SEdVZGFNOVdITVBDWllweUFKeEwyK2g3a0x3OTAxbFErUXBsZmRDem43MFE1?=
 =?utf-8?B?ZnlNRmIwUzhTeXhCeUkvTFdYb0xwc1EvcWIzOHpnMEZMZ1lvNDN0S2lVNzc0?=
 =?utf-8?B?WldXbXVoRTRPRXphQW8xczh2REsyM3RMVk5oMDdnZDJXdmlEWUpZNlhCdWhq?=
 =?utf-8?B?OUtWSHJHZ0xDeHA1ZHRqeUlUZzhzNExVQ0JUK2NzOGFTZmZmbkZ2Q2hqTWZT?=
 =?utf-8?B?Y1BvMi93cjdCakVaK21UclFGWXBBUkQ2MnVrL1NyMEpzVFd3WUdZVVRYZW9a?=
 =?utf-8?B?WURIVWlQNHFFWUVuQzBwRy80eCtPYXFrRDF0aXNWQkI4Nk5GdjNHWnRNVnpq?=
 =?utf-8?B?aHNGaTRiRi8wOXJDeXZJOWM2S2FTRFlndFhlUW5iYlVhaWVRVHdMQ2xpc0U4?=
 =?utf-8?B?THhFaTZaTHpGWVlHU3ZRc3QxMEN1RTg5MFE3WkNjRnluK2JKM0Fyb3E4cE5G?=
 =?utf-8?B?TjJUR3NlQVB3dDh6MFdJc3Vhcm5FUmZCNzNUd1oveHV1UzRhRFFhbXJWeCtI?=
 =?utf-8?B?WTR1UTBrOG0vLzBnWCtEQkpSUnNibTB3MnlnbWN6ckZKY2M0Y0hVVERtdlFO?=
 =?utf-8?B?UWw1N1BvNG5BTXpCVTZGbHJmeGpNV2J0QmZkZXlDR21OTHBUMUlDMVBkdXdX?=
 =?utf-8?B?YkhramxzTWtSSEo1ZndEM1JPTVJKNjlRcWE5d21MOUtFcEJVdjkydzNkOSty?=
 =?utf-8?B?VTRUQ0RpaGVKMHR6SlllTVhRUUdvUGF5QU9oam5od290UENLd296MlBvbFJu?=
 =?utf-8?B?QUIrNy9TZk84ZEUzR1EvV2hEdUpJb0hzZkgzNnAybVdhVHF2S0VHRGU0cFlN?=
 =?utf-8?B?Z3JkR1Y2LzRDUzVvVHZ4eVBBUnhSK2N1eHIwdUQra2lJTWYrdVZFU0cyNGZ5?=
 =?utf-8?B?Q2FwMjdYLzlUdUo5NjBlOXdmc0JOUFlNSURQRDFHdzIxQjNxWE8rODJEdmpy?=
 =?utf-8?B?ZG1ydDNQSCtIdm5VVndVVFdjMU8wZ1pwU3pvdkNmSFBvZ0drNWdQaGViQ3Y3?=
 =?utf-8?B?Z0hPeVVkQSsxMzRvM2RhMzZVMjZKOG5hOUVZVnUvc1ZQTWpiWmZmT1BhaSsy?=
 =?utf-8?B?QllmYlZyd2Jxa1NYeWpVUFdlKy9ncDB6THVxVzUwdGtMYjN6dFhBWFhuU29T?=
 =?utf-8?B?Qld1N1dEbGJMTWx2alhWbkJrdFBZNXRwZWtnbFAxR2Fnc3hKdldnR1FsVTRo?=
 =?utf-8?B?VytrZW5pa21BQ0JkN2lXUTVYOElNUDJXMWJKY3J3K05IWU0veXNSOG1CYTFI?=
 =?utf-8?B?ZC81WnQwUjBSUjBxTjgrN2FSeFFuQXdibm9CY3hUSFRXcms3RmFNSkVZajli?=
 =?utf-8?B?b01IQkViNHBpb25LZm9PQ1JIK1lmblBvZzZpNUM2Z2JUaTJHbCtzSUx5QWpV?=
 =?utf-8?B?MFE1STVPNHA3eHByaHFnYzBFajNpRmZCSldaNUFGQ1hlb1RTOTlTdElEcXpR?=
 =?utf-8?B?TjVxeXpzdGp2SXVYT0laUnpIWk8xSFkyWDd2YW9QMlR4UkV3OEI5U1lDTVVH?=
 =?utf-8?Q?Wx5xOlnguMwrDQh3nasmH24LeJnjwjBHb1QXbEZWP8Rg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Lz0PaU1zS22cE7HncDLS3F9lCX0Bao/Br90mJrCKsUSgU6psKtpKsRHCSjSK8/KceLwocZgKFnawMS8p13w1mb31a+h9VpES4tojy9QErymYKVgk9seJsuDESjV1AFH8EXKv2O+1IazUAphxCK4VSSpt8hjM5ufqM4rd78q4rvre1en8cgGp3Upa+4dyEVmmgYmZfkeZmsQZP7b469hCniTLF+p9TcSaIYiX+/Y6v5wtHzcZ5SQyQZYL1nJezu71CbDfudIM+ZQEEcmghXr9Lk3B8bQ3GtJXRSaSGwYSeMQ4CwU+8/fqRLSzZKAAtk0K7O/CwJ8/cOXke39o8KxZP4V7zCKkposWwjki7it2SQZreqq0jaV2c6HHvfnbqOQv3fKvMaxJeQa8SYtlQO1oFJh3G8gF73LVfOjHVU5EYBi/kIA1IyS2Kbp2DxnGNTc8gCz+e30IILvsscVWkVCzx2pV+W3Xk7JwhBsD5JjpCwVg3gHD0aXurDRLeXzT22RaTEezXWFw2LeFjmQ+zuBPQ2Nu0NGIus3I1KUIdJcwVZvuMXiNX1uwo0519yFXWJo58BGxl/rwPNuzkKzUZlmh10t4c0Ib3o+/qS5CuY4HaxA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291c88eb-d05b-4019-ac12-08dc399642ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 02:21:11.3698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWOkiX6DBrJXjqGRq+s82chuwfIhZW57uuQ6wmMKNrpmE61NGOGoPn0LRwr51WySAPBw756htXVPB4cQ16omDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_08,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403010018
X-Proofpoint-ORIG-GUID: 0sgz7iAOrkkYEvb7NPmMHQpxin-UuAcc
X-Proofpoint-GUID: 0sgz7iAOrkkYEvb7NPmMHQpxin-UuAcc

On 3/1/24 00:29, Boris Burkov wrote:
> btrfs forget assumes the device still exists in the block layer and
> that we can lookup its dev_t. For handling some tricky cases with
> changing devt across device recreation, we need udev rules that run on
> device removal. However, at that point, there is no node to lookup, so
> we need to rely on the cached name. Refactor the forget code to handle
> this case, while still preferring to use dev_t when possible.

After the kernel patch ([PATCH] btrfs: validate device maj:min during
open), I don't think we need this patch to help fix the issue.

Or do you have any other scenario where we need this to help udev rule
to release the state / disappearing device from the btrfs kernel cache?

Otherwise, this patch will be a good to have patch but not specific to
fixing any issue.

But, we should make this patch to search for both path and devt
because these two should represent the same device at any given time.

Thanks, Anand


> Reproducing the underlying issue is a bit of a boondoggle, but can be
> done with a script like the following. It assumes three devices we can
> run parted on safely, for which I have been making loop devices. I sent
> a parallel patch in fstests with this script fully fleshed out.
> 
> ==========================
> DEV0=<dev0> # primary device we will be corruptin
> DEV1=<dev1> # second partition device to trigger devt swap
> DEV2=<dev2> # second device to mount, to trick temp_fsid code
> D0P1=$DEV0"p1"
> D1P1=$DEV1"p1"
> MNT=$TEST_DIR/mnt
> BIND=$TEST_DIR/bind
> 
> parted $DEV0 'mktable gpt' --script
> parted $DEV1 'mktable gpt' --script
> parted $DEV0 'mkpart mypart 1M 100%' --script # devt A
> parted $DEV1 'mkpart mypart 1M 100%' --script # devt B
> 
> $MKFS_BTRFS_PROG -f -msingle -dsingle $D0P1 $DEV2 &>/dev/null
> 
> mkdir -p $MNT
> mount $D0P1 $MNT
> umount $MNT # multi-device, no cache freeing
> 
> do_rmpart $DEV0
> do_rmpart $DEV1
> do_mkpart $DEV1 # devt A
> do_mkpart $DEV0 # devt B
> 
> mount $D0P1 $MNT
> $BTRFS_UTIL_PROG device remove $DEV2 $MNT # open us up to temp_fsid
> 
> mkdir -p $BIND
> mount $D0P1 $BIND # crazy dangerous duplicate mount on same dev
> doStuffThatCorruptsTheDisk $BIND
> ==========================
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v2:
> - updated commit message to include repro script
> 
>   fs/btrfs/super.c   | 11 ++++-------
>   fs/btrfs/volumes.c | 46 +++++++++++++++++++++++++++++++++++++---------
>   fs/btrfs/volumes.h |  1 +
>   3 files changed, 42 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 7e44ccaf348f..3609b9a773f7 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2192,7 +2192,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>   {
>   	struct btrfs_ioctl_vol_args *vol;
>   	struct btrfs_device *device = NULL;
> -	dev_t devt = 0;
> +	char *name = NULL;
>   	int ret = -ENOTTY;
>   
>   	if (!capable(CAP_SYS_ADMIN))
> @@ -2217,12 +2217,9 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>   		mutex_unlock(&uuid_mutex);
>   		break;
>   	case BTRFS_IOC_FORGET_DEV:
> -		if (vol->name[0] != 0) {
> -			ret = lookup_bdev(vol->name, &devt);
> -			if (ret)
> -				break;
> -		}
> -		ret = btrfs_forget_devices(devt);
> +		if (vol->name[0] != 0)
> +			name = vol->name;
> +		ret = btrfs_forget_devices_by_name(name);
>   		break;
>   	case BTRFS_IOC_DEVICES_READY:
>   		mutex_lock(&uuid_mutex);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 3cc947a42116..68fb0b64ab3f 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -503,11 +503,13 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
>   }
>   
>   /*
> - *  Search and remove all stale devices (which are not mounted).  When both
> + *  Search and remove all stale devices (which are not mounted).  When all
>    *  inputs are NULL, it will search and release all stale devices.
>    *
>    *  @devt:         Optional. When provided will it release all unmounted devices
> - *                 matching this devt only.
> + *                 matching this devt only. Don't set together with name.
> + *  @name:         Optional. When provided will it release all unmounted devices
> + *                 matching this name only. Don't set together with devt.
>    *  @skip_device:  Optional. Will skip this device when searching for the stale
>    *                 devices.
>    *
> @@ -515,14 +517,16 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
>    *		-EBUSY if @devt is a mounted device.
>    *		-ENOENT if @devt does not match any device in the list.
>    */
> -static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device)
> +static int btrfs_free_stale_devices(dev_t devt, char *name, struct btrfs_device *skip_device)
>   {
>   	struct btrfs_fs_devices *fs_devices, *tmp_fs_devices;
>   	struct btrfs_device *device, *tmp_device;
>   	int ret;
>   	bool freed = false;
> +	bool searching = devt || name;
>   
>   	lockdep_assert_held(&uuid_mutex);
> +	ASSERT(!(devt && name));
>   
>   	/* Return good status if there is no instance of devt. */
>   	ret = 0;
> @@ -533,14 +537,18 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
>   					 &fs_devices->devices, dev_list) {
>   			if (skip_device && skip_device == device)
>   				continue;
> +			if (!searching)
> +				goto found;
>   			if (devt && devt != device->devt)
>   				continue;
> +			if (name && device->name && strcmp(device->name->str, name))
> +				continue;
> +found:
>   			if (fs_devices->opened) {
> -				if (devt)
> +				if (searching)
>   					ret = -EBUSY;
>   				break;
>   			}
> -
>   			/* delete the stale device */
>   			fs_devices->num_devices--;
>   			list_del(&device->dev_list);
> @@ -561,7 +569,7 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
>   	if (freed)
>   		return 0;
>   
> -	return ret;
> +	return ret ? ret : -ENODEV;
>   }
>   
>   static struct btrfs_fs_devices *find_fsid_by_device(
> @@ -1288,12 +1296,32 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
>   	return disk_super;
>   }
>   
> +int btrfs_forget_devices_by_name(char *name)
> +{
> +	int ret;
> +	dev_t devt = 0;
> +
> +	/*
> +	 * Ideally, use devt, but if not, use name.
> +	 * Note: Assumes lookup_bdev handles NULL name gracefully.
> +	 */
> +	ret = lookup_bdev(name, &devt);
> +	if (!ret)
> +		name = NULL;
> +
> +	mutex_lock(&uuid_mutex);
> +	ret = btrfs_free_stale_devices(devt, name, NULL);
> +	mutex_unlock(&uuid_mutex);
> +
> +	return ret;
> +}
> +
>   int btrfs_forget_devices(dev_t devt)
>   {
>   	int ret;
>   
>   	mutex_lock(&uuid_mutex);
> -	ret = btrfs_free_stale_devices(devt, NULL);
> +	ret = btrfs_free_stale_devices(devt, NULL, NULL);
>   	mutex_unlock(&uuid_mutex);
>   
>   	return ret;
> @@ -1364,7 +1392,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>   			btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
>   				   path, ret);
>   		else
> -			btrfs_free_stale_devices(devt, NULL);
> +			btrfs_free_stale_devices(devt, NULL, NULL);
>   
>   		pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
>   		device = NULL;
> @@ -1373,7 +1401,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>   
>   	device = device_list_add(path, disk_super, &new_device_added);
>   	if (!IS_ERR(device) && new_device_added)
> -		btrfs_free_stale_devices(device->devt, device);
> +		btrfs_free_stale_devices(device->devt, NULL, device);
>   
>   free_disk_super:
>   	btrfs_release_disk_super(disk_super);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index feba8d53526c..a5388a6b2969 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -681,6 +681,7 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>   		       blk_mode_t flags, void *holder);
>   struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>   					   bool mount_arg_dev);
> +int btrfs_forget_devices_by_name(char *name);
>   int btrfs_forget_devices(dev_t devt);
>   void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
>   void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices);



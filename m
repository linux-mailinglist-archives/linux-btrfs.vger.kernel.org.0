Return-Path: <linux-btrfs+bounces-2727-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF04786292A
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 06:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7BD1F21AC9
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 05:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465C29445;
	Sun, 25 Feb 2024 05:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CWrQWXJv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rqxaYBZe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390CA5256
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 05:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708838974; cv=fail; b=YenCVdSAQptrFvT5nOYF24//QzCpXolehLQn5LF+XCKMVau8Y/B1Nde93e8ZDiOE4oZg7fBVCCayHuaAq4oHUB1xk4DWWPcGnQ7N0PpiWpMBpuawpW0K+e8CMHYyB8IFL3j5wJNbY/id+M9aeOh5OfjFFZHg9TfJ1ecg8/YAOPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708838974; c=relaxed/simple;
	bh=uJmWjhNRTytgQmaZiWElW7gb/8DluZhomEkTb2vaFfw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L9+2nmF+1syY3WLelo+rF5nEotzsRrhpcNiaPV7G1+yXSGN8smvY++h2CIVNQKAsIfvQQ4NOTrZds7ZF/RnFISkTqYnKO4m6UBxEbyqa/DU+63lyLNSJUSLAwUsVTIVebIdY3l6vy3Tr3aS/n/5ORhmz0rNHSXh4kZbBq/CELa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CWrQWXJv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rqxaYBZe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41P4uRFm014220;
	Sun, 25 Feb 2024 05:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=XlVuMM/p10htN7xHuZlpsChgLWyR5LttONqO6fz4eUA=;
 b=CWrQWXJvvA3szlajlLEdd4Z99+WplNbZOkodiIc6ZkyNx9HXpoMQhVMeJcZP5JGfjReX
 ODzjTP0e4R6sFjDJ86ELlDNhDU2Fcmoa5O8Sm01IklsnzEPBgb5k0rNW17Q1j2PMA+mQ
 MuaPSkHW7ZeEdTtrxLE3wuDzkiwO2oKFXgvbvEzAYCc1G/hI/WPwK/MU8Qlj7QIZmYft
 fbWmqd0QXzPnJZPdU9lhhrAfwu2/qb1X9428Crm1ULd7vRgry5uTMCKNSmLkOHmqieKK
 TahS1k3uRgjzB3EVDSYAtcf6k4s1O9YlTTd0YNuYwZ6Jlb8HEN+vNBoam7vCcrramoaI LA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gdabw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Feb 2024 05:29:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41P10xQ1017413;
	Sun, 25 Feb 2024 05:29:21 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wapfgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Feb 2024 05:29:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHdoRsvFFZeruYueWI+KNxxIX7qX+HaeaTGB8K5TaiGgj3uVle1r+9Tz84N7bMokmm4kdRVp+XDwlf3Fz8l76XnEEiVmY2J/Ryo1GNj2fBPbYf+GFB3ID5gZOXpoxqjBMUn7KGS5iQ9kvzoIkFl7b1nI5/wW9Hmm8XDaYWt2yHrTp/l9d/hhsAofb0Oxm+TP20nLE8kz+ZzXM6LdQgdK7/GcvPyTKobzeVUvq0xlH70pO9R6VzjJ/iK71UI+Plw7AMFOSecW22zROq6JEg2ATW6tNymZpMDnDA96qtKBDG+Tz/Eex9ekcZHpuKF8rjO5Pz1BzuDOpZcz3uOWT2V3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlVuMM/p10htN7xHuZlpsChgLWyR5LttONqO6fz4eUA=;
 b=a6a5DMssBi3fhjlnMVa6DQF0SVNiOnIkLsWXDHfFkGdMEINrLsbdb3usZcTklEP4mQjxCAGxm4jrlNCTyuJXhvdDjQqjarU/ngn/wasi1cMd4sXvxwLnpQBOb9Vi2FkUOVkY6DACMjX5PjV1ZWgwgLK9ZfBDUp2Grkp3LdKFrLdiO5LUutrrStn5pp+nUc3wAUUaQMscvacgMdKDJuHuCtp1zUBnwtOQRXVK8J4fzPFZuiP+EE2ECDeA2QDFwpArlX0vCZATtFE9cAs23JOnwdw0wu1jgF3CTuKjjuyi+ADTKPAjxYmeWXd9rLLH1lifRrjq/A3KzN9VPwwFSz28UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlVuMM/p10htN7xHuZlpsChgLWyR5LttONqO6fz4eUA=;
 b=rqxaYBZe9Er/bGizrjuHs/h2uhpjkZ9Hbvw3h8QuIo1ZsIyz8E+wjKgPu5b9kDXOrrZqtKDM6x7qVJkwJfwrd11LFQ2YeozSdFGDB/ecv0f+LCVZoQ+8sj9JsxZOf1LUy44tBSD6aj8jFvhy69ZRcvO/b3vSUWHaJd47q939gII=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Sun, 25 Feb
 2024 05:29:20 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85%3]) with mapi id 15.20.7292.036; Sun, 25 Feb 2024
 05:29:20 +0000
Message-ID: <d8cf8a92-419c-4785-be09-bc3f05c3d979@oracle.com>
Date: Sun, 25 Feb 2024 10:59:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: include device major and minor numbers in the
 device scan notice
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <9b8ddccde70488086ea466b33b9cc1e52d0dee3e.1708687432.git.anand.jain@oracle.com>
 <CAL3q7H7CoDyHqSWEKkzJi+akeTvLDpR__xvGO7aZpV=hUzz75w@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H7CoDyHqSWEKkzJi+akeTvLDpR__xvGO7aZpV=hUzz75w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::16) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|CO1PR10MB4515:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b4eed5-1b09-480e-7336-08dc35c2b769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0s9qGoHfgwIewJ1rHO54RJTQFIie6GZKHBoDoeJK/NPXMkVErb5csXRHCi9CifMsgvqt9ipKMnJcWrLV4TOicYL5TnBhPm/82scKmoCrepaT6j3cGRXB/tK8xZgtqYULFJJkCGQ4RUVfL8tx4tBoRnqIFsuWQfVYJCiPdvmyMHM+Nol4E5qraUaqdMu8/wmbJ7w5GBUkxPAHBIMwq8j1kKVK2MZpLA3uX2k3bBSjXHVtBJKx61/4qZeNkPzJH2K5e5LBSaZ9Ad+8dQoXWDszXsrW5EF5WaI7CPe3fV/es14PU/TFxALpKdGU+XhaZFSCJJrGVq+KWX67F2i/Ww7qG9t/9tHRv8S8XaJxtXd/2UCJsjRUJ0LNLcwVJiYg+DqDYI/U8DCrR3KLcCK04WLhhgC7N4BJvVP/fWoOu8yey9jY7NBzcyF1r5wZChIfnQe/bs6STG6YRT0rZxH0htf3vmUHtj6JYezY1bVHCkdNU/acocP0/Ms2YvMiV058c9xVoQJZumjD3UZ3tHe4lrClbb+eB2GQMnfuGnK0k/pkf9c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VUFBM0d0Z0JxYTQzQkllSDEzZUJ2SUhEZVVBakhrMjkrK2RFb0VSOXArK2ps?=
 =?utf-8?B?ZWlaSEswRWlyVUdGRmM2cW5RTmRjdUFnQVdOZ0JkVnlVNHkyWWY5ZzNZMG5X?=
 =?utf-8?B?UFRVbllPcUlLd3EyWnNPdEgvdE9PVVhGQXRhV3hUS1FhT3JjdUc5TC9wMTNn?=
 =?utf-8?B?ZFhaZVV1Q0VpTExoei9uK2prUUNOWHZRdktxUWtHSlZsbXdUR2Y0S2l0TFlQ?=
 =?utf-8?B?TWpLcWlCa3pkVEsxQmU1ckNBVlpDeEgvUDdFOXF1em02ZDh6Sm1Ob3B0VDR3?=
 =?utf-8?B?WHJSa2dzdml2OGdQRk1sR2VtTlYxSmFncXZHYzBaWnlFVDErRXBDNy9zWnpq?=
 =?utf-8?B?VXlvL3lISkZWR2JNYVU1RFhURnF1NVdCOG9QUnI4bDFiNC9ncTl6a1ZGTUZo?=
 =?utf-8?B?NndBNWVZTXNCWEd4cy85MGpOak9lQmNEWXlTWVhjN3I4eFUyejYxQ3l6UWxv?=
 =?utf-8?B?c3RpZzVuclVyNWFlZlMyUWIwaEE5YkRmWkpuYWZuRStXOW5ybk85RUZZekFO?=
 =?utf-8?B?WERGUnc1Z2lrNnpoUDBVMHVaN0pQSWFNMDBBaURPZWNQYU4wZm5sYjZXZ0l1?=
 =?utf-8?B?MnJoVzZXOVlwdTRtOVNWRlFwT2FiTDdlZk9ycUhJNncwWHcrSjFYZU5TN2RL?=
 =?utf-8?B?RmZTTlBpOGZpeVp6ZEF2Y3h5QnlaMGI3eEwxZUxBN0hVeUdTVUUyMGtUWkph?=
 =?utf-8?B?dHZIK211NVBmYm9ZOUUzbUZGbnp3cWx6NWR3ZmZBRXkwQ2d5V04zZ3U4NFJo?=
 =?utf-8?B?Q0poMVNuMDZkYTZybnNhZkJPdjdicHdHTjBMczFGeWtkNHFHc1Ivd3ZrS0tV?=
 =?utf-8?B?YUJvOTMxWmZISGZKZlArVXdRV3g1YVpmcU9hUTQ3RmRjeEVtSmxpRjlZL0Jt?=
 =?utf-8?B?RFNBT2U5NUttbnNuM2FqUmtOZFF5Y0J0dHluZk1QOERXSHQ0dVNsa3MwaTZw?=
 =?utf-8?B?ZmxkR0hWWmlrNmo1aGFYcWhyNEtwaHdpUXkvMHVXYTVOZGUwVDZ0V21FOGt4?=
 =?utf-8?B?VUhrOXFUNkZVUm9CaFlxY2xXOGR1Q3liMTBBeks2ZnExSzIyNGRURzZCRmZa?=
 =?utf-8?B?N0NYWFlJVjViTGY1R1kvbnVTOXhZZmJuR2RaODFqV1ErYzcvNUpmN1RWRXJx?=
 =?utf-8?B?QSs3SEtWVlYxRnpFZXJPRDd0T09ObzZHdzg5OHVTRXRFVDc4STl5RnpSZFlJ?=
 =?utf-8?B?RGVGd2FVSTc4WHByTnhRZ3doeUlYaWVhU1VRS1ZJbWFGSDZyTWtvMEhtOVE3?=
 =?utf-8?B?M3RvVWlMVkMweFZ0Q3hrWXFHQm5NY1BOUW5kVklvaGpvV3ArcTNVRWxnS2ZE?=
 =?utf-8?B?TmtpaDdJQXVESkpKWjJ6K091UmhVbTdwYkZ2aXNSWVE0VFVIUGRVR2djT1Q3?=
 =?utf-8?B?NGo0cDBuR1VsTEF2VG1MN0QwUUFiTkZwMHNUR0E1SmI4YnBKM0ZoUlBFWU1H?=
 =?utf-8?B?UldsWlFwQUZRUkxiLzJUU3JVNnR4OW5iYWJIS2wwVGtTdnBCby9xN0kraGxi?=
 =?utf-8?B?S0xHdWJ1WTUxVitQSm9Cd0lIS0dwVEVNVEZPaENYUU5Lam55T3ZxMWp0Znk1?=
 =?utf-8?B?bnUvcUtNQWdrbURUYUtaai9uNE5NOGJuWW0vK1RRaUFiRHNxL3NpQ2V2dGQz?=
 =?utf-8?B?TkRka3pxRjdzUXJ5THZ3K2NkR1V1U1p4OFYrRG1Ca1JYWXVkaUFGMWhaZHd4?=
 =?utf-8?B?bDVZUkR5Q0hzenlQUjJyeVBiRXVXcnZ6aWp0L1ZNMEE1SDB2TmIxbW5MZjVB?=
 =?utf-8?B?R0tWVG5ELzRLODhheElINkZnOUdYZWpFMG8rQXNtRU5vWnpvL25OUWFocVBv?=
 =?utf-8?B?Mk5lQlBlMENMa2tScHVLM0lwVk9GRFFCTGJRS3EwMVlzTGdWaW1tcnIvOUxq?=
 =?utf-8?B?bjQvaDBCTnViR2R4WEgrMDBZUWNWTnVtSjQzVEtmb0t3ajc5YkNSQnVzeC91?=
 =?utf-8?B?ZFMzVStsSG0wK2FpMWErSlEzcnp6SDZYeWR3SE55bUVjZXJTZlM5REFlOENx?=
 =?utf-8?B?Z2szUVk2b1p0b20vc2k5SmhvYmVkcERSViswZzRSNzcxeWEwSk0zeUsxQ3pC?=
 =?utf-8?B?azFoRWtxL3AyY0pyRVgwcWhrd3VBZDY5aEU0eUNHL1k2TGJheTkvQ0tXdm1O?=
 =?utf-8?Q?TcYddDm6iKu+yK+F6yuDe74DK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nSpBkvefH3duHqGOp2HJfmhzOkP4iHBSqcQcHTVwIZSJi979awgdiZZaFwPKbxHv38VhaT7H58fwui2iAEE8ZuPQc6wcFITfJ1rLf+DpHvu6NEBiXk6u8UtidvTOvdWsZLCB77vxd3wHXQkdh0zp4hKXvuX6OMaEr33nymgHvJXGqYQkk9MUnOb53JbbplrAuu3Qq5XE5AmtbygfWQjdImfj4FOZmOQ4FR6FJJbyjYNB2AWmmd+5AkVEyRQN8kQVxrEqP8gH+9aCbNBilUBiQuqTPS6gMULo+WuqRNH/Lkal1WB8fjChNZ11yjCFKp8fosR9oTmKxYjyY12QInuvs9MRembBWfkO3xOrFOyk+zcAtpHpUnt6dBk1m3TT6YKgqZcXg6p3ysY/UFEFTvltoxfrSQ1Hn/RqbqLypJgVxIcNft8Im6t3nK0EbJbNlr0eHe2wFQYQY6ZIzzuq7riylZpvi3cQz/NPlebOUQF7sTlMGosBINuD3bkncSvkaLQxDVCSplxcCfqDosjFWGqN7Rq6ww+NNcSUnvv6G+qNiQnT26Jrf7jivKVI7nVSybYvUQh1vM7MrlbvwfX8UjpK0BPHEu86D9aBrf4rjtgC4eI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b4eed5-1b09-480e-7336-08dc35c2b769
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2024 05:29:20.0519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9MCTm4Wx4K9BkcFR1mJiwGEsAxl1w8Ge/nCcOM2UbUfrFg3j6KscSzssyX5OTCrWsb01sjP6FDIh1ZLKD2t7Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-25_04,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402250042
X-Proofpoint-ORIG-GUID: LgWAUaBu3hxlY8ksMUu4ocPCZgRsLkMo
X-Proofpoint-GUID: LgWAUaBu3hxlY8ksMUu4ocPCZgRsLkMo

On 2/23/24 21:16, Filipe Manana wrote:
> On Fri, Feb 23, 2024 at 11:27 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> To better debug issues surrounding device scans, include the device's
>> major and minor numbers in the device scan notice for btrfs.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 32312f0de2bb..6db37615a3e5 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -824,13 +824,15 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>>
>>                  if (disk_super->label[0])
>>                          pr_info(
>> -       "BTRFS: device label %s devid %llu transid %llu %s scanned by %s (%d)\n",
>> +"BTRFS: device label %s devid %llu transid %llu %s(%d:%d) scanned by %s (%d)\n",
> 
> Can we please leave a space before the opening parentheses?

> So that it's consistent with the rest of the message and more readable
> (I believe it's also more formal English).

Sure.
> 
> 
>>                                  disk_super->label, devid, found_transid, path,
>> +                               MAJOR(path_devt), MINOR(path_devt),
>>                                  current->comm, task_pid_nr(current));
>>                  else
>>                          pr_info(
>> -       "BTRFS: device fsid %pU devid %llu transid %llu %s scanned by %s (%d)\n",
>> +"BTRFS: device fsid %pU devid %llu transid %llu %s(%d:%d) scanned by %s (%d)\n",
> 
> Same here.
> 

yep.

Thanks,  Anand


> With that adjusted:
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Thanks.
> 
>>                                  disk_super->fsid, devid, found_transid, path,
>> +                               MAJOR(path_devt), MINOR(path_devt),
>>                                  current->comm, task_pid_nr(current));
>>
>>          } else if (!device->name || strcmp(device->name->str, path)) {
>> --
>> 2.38.1
>>
>>



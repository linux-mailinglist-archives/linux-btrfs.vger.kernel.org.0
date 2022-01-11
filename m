Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E74548A6E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 05:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347925AbiAKEva (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 23:51:30 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:30196 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234039AbiAKEv3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 23:51:29 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B3TbTW003756;
        Tue, 11 Jan 2022 04:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=G82JzXWE8lv7mPMkBUWgmDhEE1t/4Em5CnFsWteiji4=;
 b=y9EhkWDyu1vCvG0tHqK/ikEbnuyuc5CuiCzsWxW9EIB+e1VXMFjln9H+9SyAsEi2czqq
 rOFBSTf0ZuI87s78lWmc9feiY8/uphPzJmkehudIWDdmNf5q7LvuBHOQ6JyzO8p/BAYC
 ET1kgzS7BVPY5nBsqH8ILLnBHgrAADlZnPRnUs4qnoSDxbIkKEcahn3jsn2ujE9Nh+gl
 lWkYnKHJsd/3KAJfLvTJOzmj6UU8S2CL5BusGcIBhOGUBWl+MDlzA96MFlsDQTxl8Bzy
 nOCzOuKUBK1zh+KlZ/3PtxgowPM9GIzBrumZZ1vgWApk2Fe/+3mvlGcDzgF9JE0KALoW mQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgmk9a319-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 04:51:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B4jcqZ101265;
        Tue, 11 Jan 2022 04:51:20 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by userp3020.oracle.com with ESMTP id 3df42m3g7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 04:51:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBDyDWR9KW3jWUqU9Qb5w8M9Cf/cgSrA9Ilvnj8hT6+QSYXs5tZc505FKW5kpUwURnksIaCm1U/0f3PmOaCXeROU2FqVTo0fMoMv4gQXPKehSnVFoPgIrjd6PK/U7aF4JXGeX+6E5HjPCn7ErIyiPcjKX5NFx3tHQ+ulY0hnvjUomszPNx5Vb2pnocum9OXNLwU1HO9UJvBN+hm1b5jO6Tj0HFlBPvKEkophGyzmo1kd95Gz43RfOjoKxvlvajRDs7g5ge0zsOB/V/sF8Uyo3LSYJjSwU2NECZ2jlu/GSGc6lCmiMc44zXr2+7PUfzEZE5rDRL3lzHUXLMlYhLRk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G82JzXWE8lv7mPMkBUWgmDhEE1t/4Em5CnFsWteiji4=;
 b=JMleYnBKkK4CK1ED/8OJ+3cHYqmxdYHzVOaD3U0DSTMh1mz3gbLMtEBlXhWbnyW/R0JvoysYhkrJYzjhXSG3VnDm1Xu9N493yVd6suojXZNX96dZo2Ybi8l3zxUPdfAAvqC2i/0sET/kfbFlgBNMgGTqLfTXr5A452gfRpsbIb8yBE8S3E3BANZeVzSweCRV70l8ysCb3dKcnGAMnQcmEatere/yHK3Ss1G4qkXuaChD0zlKbzksm+GbIZQfCnx7aI9G3dPUxfeEN193Nn1nIjlHjBbs3OuXlfOmldzoK2Fct7m0lYPBp6UYDkR6uRVBggYCO3sd+yXokeuCcljTdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G82JzXWE8lv7mPMkBUWgmDhEE1t/4Em5CnFsWteiji4=;
 b=YZ/3VMZHL2fRlXxEfRVXzjDiVL/xeBpQnI7AlJmfjobCd0gGPLrK89dcFxQCfFoyJ8gaAMQwFnE/hLqAZ2alYsm2+eSdD7MB/EDUDsr9lt8/1SglaLhAKANBxNBpGGyM4l6B+hV9Ugaqv8IrsyfrvJ/6i8qDP8+Se2OA3FmHLwg=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5124.namprd10.prod.outlook.com (2603:10b6:208:325::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 04:51:18 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 04:51:18 +0000
Message-ID: <5656e466-7950-2dd0-11f0-2dadcc191f7c@oracle.com>
Date:   Tue, 11 Jan 2022 12:51:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [External] : Re: [PATCH v4 2/4] btrfs: redeclare
 btrfs_stale_devices arg1 to dev_t
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, l@damenly.su
References: <cover.1641794058.git.anand.jain@oracle.com>
 <d05f560ad6b65dd6fd7fca0e54271d3d0d8a3f8b.1641794058.git.anand.jain@oracle.com>
 <df5e06aa-5ed4-0df2-9210-ea8d19069cba@suse.com>
Content-Language: en-US
In-Reply-To: <df5e06aa-5ed4-0df2-9210-ea8d19069cba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e50a37b-5f1a-48f7-953c-08d9d4be017f
X-MS-TrafficTypeDiagnostic: BLAPR10MB5124:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5124ADC18E31DD127DF500BFE5519@BLAPR10MB5124.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMbMerMqW1eUcnHXK2M2LKxYR6NtkJftkzg6rnwUItPhDwxKKGoYVpGO8v+ULMtt1tHnQAxc1MbYkVj1pJy3PQYNIWYMH5kjsloPKrZSQ59Rxulvy1W8XzKtjFQ87OxVuc0KZ3NUCoPA+KxJ05nVs7INcDyMMgdasEaXjzaBWzWwnrUwuri5PdGCC3v4TqCkKq3XnS1Ou4sRV21mnFAIjUMcV/xhMpmYiiT7oReOYpxt36TRFbD+Nd+P8z6BW8FulSRmzXCFmhxSnP5wsE+RP5212cRSDD+rhVNeG749lGsknRbEJJACmCxqsqZbuzl+NUMvBgXB/sWodJ26v8YoYwHVJHKvTJ+JGkqLd6tArhVpyJ4u+yN16ZfJWpM+cBZZPgPbXo+WXCa/Dw8ShPGOvs/BgQugirTHdjQLYEwT0ehViI8SKmJw5XRwSXoN8iTgTvV96XP0fLz0v5cYWIp5Kg18GCb+Z2Sj318X/afNw0CFTDY6sRxK8US+rVv/mNkYRigB63/ViIY87Xg4+Tj40OnQt0U9FnsmBD9vdm5nesQ3srIEpwlP4sPKrOmZ5rhMuDXE9DQ+qZn906mYbDsxiNlLblmWFfyxX8WTsKHn4UkLP/tST4Oiyi3BkgZ74kHOU69M+KoCwmZIrCcC/f8QIrovcR5rhisBdadXpMfG3Y+GKTbSEEespdkZmgt8ZVfRwaBPnoK9wIudXjMGzlAFD4LEln7N+vK8F5H6sIwJ0A8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(36756003)(2906002)(2616005)(6486002)(66476007)(44832011)(6512007)(31696002)(26005)(5660300002)(31686004)(38100700002)(508600001)(8936002)(6666004)(6506007)(186003)(4326008)(86362001)(316002)(4744005)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1kvRTU2STRNWkYxcFVXY0VKdHMvT0UrR1UvNGQ0WEpxWkVqZ0xGdElQbU5O?=
 =?utf-8?B?UE5MVEM4bldkMC9kZzlzTXhQRzFCK1Y4OVB2RFV6RTdyTTBobkxRZGdSNFFo?=
 =?utf-8?B?MkpTTHE4TkNTUUNjVkxLZlhENlp4UjYyRnN4RW4veXNBMVgxbHpzd1hrQWF3?=
 =?utf-8?B?Vm5TRmFGNDBncDByWVAwTWhObURCTUdKQnI5dy9lTWNNM0lZRnV4UzVQNTUv?=
 =?utf-8?B?aTlrYU1vU3pXTmpCcHFNMFdxQjU2eXVHSDNoL3V6cEVGVGp4M0ZSL2l6YUhp?=
 =?utf-8?B?d2JweVZ1aEY0Q040eVlnaWJtK3RabXVvbCt4V3pCZDQwbitOTzVLYkR3RjJQ?=
 =?utf-8?B?WHlnbUIzNlgzWnhXYVZNZi9BQW51MUduYTZzQVJSSHM2NnppSHg2UjdYcm8r?=
 =?utf-8?B?TUxpT0JNN1UzWmZVRFgwdGJDRDdsenhCb2YwM2RIbWNFU3dzTG5WTURBeTdq?=
 =?utf-8?B?SzI0aHltMzgrMi9FZ3ZPaHVqcm1BYndpYkJNNC94ZzlkQlcxZW1ZMG5jZWdM?=
 =?utf-8?B?V2xLeldXSVhxM0hGSnBSQ2djOEV4NFFJQ3BlYkxvbVZKbzZZQndGWWhBUTF3?=
 =?utf-8?B?TkhXMUZSQXdjekxWNHA2RFMweUZFRmFlVFF0WU9kYVo1bWQrYU81VHFSWTRZ?=
 =?utf-8?B?QTY3VVhXd0FjUHpDRndjQ25ueGJ2ZWl5ODRiVzdhU2RTNmVORDFYWGI5WW1R?=
 =?utf-8?B?RHNuSkRmdlNDRXRMTU5mbGtwVkpyRnJFWlZ2YklkYlFiaHV5MlpEYnFHcmRp?=
 =?utf-8?B?SHZSSk9aUGZuVjBIR0xMVmh2cVF0ZFFrSTc0WlJZZzRkdDZUbEd4R2ZrN1di?=
 =?utf-8?B?QzR5ZTI4akRPck16d0picXRZdkpycjI3aGJ2YkdiTm8yS2ZKdGRBVEJpQ0pl?=
 =?utf-8?B?QVRGUWVwSXdkUmp2SVNFbEY2cUhDaDJWK2FEUXROSGEzZWhqUlNTSmF2cE5t?=
 =?utf-8?B?bFBtaTIvUUdDUFcrQmdBMTZza1hEUlJEY2lMWW5uTlMvOXk3bCtBbS9aalRT?=
 =?utf-8?B?L2FuejJMMnF5eXdhaHRROGRVd3ZEU1NweW1wL1ltaW5mSmFzMjg1UXNXYkYv?=
 =?utf-8?B?UlJ4Z2xXQzFxYVFSdVQwWlZSVWFGWmdubkdKTGh6K2tUTVk2b0Z4S3orSWRS?=
 =?utf-8?B?eWRDZjlLbVhFYmFYamZRUmIyM1pUT1ZVS0Z6RFY4M3VjQjFTLytPLzlITWl6?=
 =?utf-8?B?aXhGc0ZPMXUySXZ2M3B6b3dHWUhsVUpJS2RPZlRRL3d0QjZzbW5KYmZsK3ll?=
 =?utf-8?B?YXhkZGNTSTdjNnpVYXZVbnI1bWtmQTFQbnFZSHdWS3JTcU44N01hTXh6ZUU1?=
 =?utf-8?B?QVg4aVFpUngvYlhvNVArL2IxVS9LVWpxLzl6RkEwS0R4b1RJNG5lMktwbWQ0?=
 =?utf-8?B?NWlmancwanFrR1RPYTFtbnZDQ1FYakdBQ1lDWFkxY2lZcWs1SGJaTEZoWGdj?=
 =?utf-8?B?bWg3aVZGU0IzWlNNWmhnR1l2a0xlcGV6U1p4Y3JEU2VxMU1wSUdOZlExSjRB?=
 =?utf-8?B?VTJXZFI2c3dTdlNNUW1qcS92U1RON09hc1F0N04vZVdTTVFKdFZNbnJBZjR2?=
 =?utf-8?B?VWJFMWxqQ0xRQXBIRzVZQmZCMFdIQ3lSQlhZMVZnYkVaNVdoaFVQTzlnM2lz?=
 =?utf-8?B?SGxQZ1hKMERRaUcwRVdrM2dZZkpseDUvdm1oTk5RRjJBVkVLY3ZCT2lNU1pi?=
 =?utf-8?B?T0NVeTQxK0srbHAwSXVVMWF0dDg0bnNVWXJiQUM2ME8zeHlpdHp0elcxNlRJ?=
 =?utf-8?B?MTREbDk3bXl1M1MvZkt5ZUJBeC9WUU5OUVRZa3JoRmJXa29rcWVod2RKbXV4?=
 =?utf-8?B?cU5GVlRxcDVDVWJaT0JQUUV2SGpGeVJOeWJPYlJ6TjArWHlOWTdYSWVHYjRQ?=
 =?utf-8?B?VTh5dmJkYm05eWNjL0VRbGEyV0tPVG5tQUg4ZGdIdjRjL0dlYzhKZWZoVXA2?=
 =?utf-8?B?SVh0dkNtKytVK2Z0Qnd1cE5xazBvVE9yZXJkME9qUll5a0hGV3B4bzBJTHo5?=
 =?utf-8?B?ZE1NTG0zYXN5OTF4NGFmU3dDaFp5SnI2bHorL1kyQ3QyZjB3dXA0ZWt1NVI1?=
 =?utf-8?B?cGJzRlVBUm1TcTNwTElPZDc3L2RKQUFKeURBZlRjYWNNMkdncnpqYlpxc2hM?=
 =?utf-8?B?SnZ5ZElmb0tkRlVUUFgxRHVSY0QrWXJndlM2ZG0vaCt3T2I2bHFSTzJhRHlw?=
 =?utf-8?Q?7G1nnglN17rAY4P4sDtDrgI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e50a37b-5f1a-48f7-953c-08d9d4be017f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 04:51:18.7085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNsJPe/xzUKWU8mzRXbPeZV7+Xu+xevF1L89UqBMSyV3Kh8tqgifbgQ7I8wxH759Gl6DxrrFvk6veMWruZdfjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5124
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110020
X-Proofpoint-GUID: W4LxHts8Uzl_EMmA8VkBG29xGLu8TeIy
X-Proofpoint-ORIG-GUID: W4LxHts8Uzl_EMmA8VkBG29xGLu8TeIy
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>> @@ -604,14 +599,14 @@ static int btrfs_free_stale_devices(const char *path,
>>   					 &fs_devices->devices, dev_list) {
>>   			if (skip_device && skip_device == device)
>>   				continue;
>> -			if (path && !device->name)
>> +			if (devt && !device->name)
> 
> This check is now rendered obsolete since ->name is used iff we have
> passed a patch to match against it, but since your series removes the
> path altogether having device->name becomes obsolete, hence it can be
> removed.

We have it to check for the missing device. Device->name == '\0' is one 
of the ways coded to identify a missing device. It helps to fail early 
instead of failing inside device_matched() at lookup_bdev().

Thanks, Anand

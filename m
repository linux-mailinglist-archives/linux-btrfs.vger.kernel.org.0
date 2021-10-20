Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA9F43437F
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 04:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhJTC3H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 22:29:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:14796 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhJTC3G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 22:29:06 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JNUKC8014998;
        Wed, 20 Oct 2021 02:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zP2zG1JujEIYmC/Ba/UBtHrS36YWqokBInGW61KCaXc=;
 b=pHqbqZiFYqG4sMSQecWzOGsO6Q7HxuXaf7QmvbV31e/koS7G+sRQN2+nOoKevAiIc01V
 zPzrLHG0alHG9iU2BrSwwFzUPWEKQUR/5F7trfnaPZjD1WEKRy5YHJ17WE21scp3AcjC
 EWcDX4jwy7+DiGJ/QBP+MJr0gchxidKGYHniv0ulFBxlZei2kaUAZs4hF8iye/2WHeBh
 X9JoSIM0UKJHQIb/5DFbj6KMHD5rWNJOLw0rxAqP4SyHhk3YVgEovHb7ZtOJn3X74WA5
 LZoPBQGzRCfrd1rWh2g+c+1qtUZOUPTVZN8rJSLv/OPEC2Edf2OYjxuV0WMjZoFACBZG Hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsnjhwypp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 02:26:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19K2FX5j148787;
        Wed, 20 Oct 2021 02:26:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3030.oracle.com with ESMTP id 3bqkuy9g13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 02:26:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kt4Tjub/f30jfB3PwCwCzN1efb95x3B8YBLquKT2h3RQ3CWHCVox60aZboec620wxhDHWqTvtVTJUQB9+SE8OfLmOt3z6A8xdSyno0BPuyLjsBG5PS9Df/Nb1wOoGeNzzo5IdY2Q377aSgiWCj29p1feDsN05YoJ/eLtQg48H8mknVHbCtHmcmvAb3nOSa80qfj8729k7MgEzPUO3bv/7erANCqwfM6KOP4I+Px019b11eqSS7ziZP5dJcGHERSF5ekQ/nt5J6gcayDf0vkNrVjXEGxS4zYNc7IKJIjHUYeHnv3sQVu1FGyHxBu4Qv8o2w/uSx32Dm1RtTef0YChHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zP2zG1JujEIYmC/Ba/UBtHrS36YWqokBInGW61KCaXc=;
 b=kC2eO1Bx9BUz7afyU+UPO0OmsHDa0fpnGODfBqP0HdbDERf/8MIxoFw+yY+Xhr1mOPUyFsbsjiymM+3kWUOzNk117AIsL2fLxh3Nxypd+/JEEVRjOlYFffxf3YWYZK2P8xnjpAIyj+VG9k4tyZCXjFElNchl4kHIix4oOmDvVEXe0Ea/zvK5h1QOcjiFyBaQGde8piOEsIi1HjhemSty46SfAohuTDagaQfF1I6xX2imiFDrOmg2QsLJ8ADCLWlaRxi116b2P0nLkqg205rCVcJvCT3y2cbX1NKEV2zvn5NtLTENN+01tfHzEn8l5wY2I3Zk3l1BxVxAP28bQjdghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zP2zG1JujEIYmC/Ba/UBtHrS36YWqokBInGW61KCaXc=;
 b=icfCjZFtKdAejeO5+6xp2WMrOr5UTPBqqxxFv3tgk7AHNDJFD23gX8MNEc+NcuZluFxLzXwR4gooW/op5YUoXqF9jwiiGBjCvlz6jBC0RW0DZeTT+QA9ehFwzrKFaeFDQy2gCXYuwLf+v3m97FkIKQa20bCRvo9f9/Pf0lnP9Uw=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3774.namprd10.prod.outlook.com (2603:10b6:208:1bb::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 02:26:44 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 02:26:44 +0000
Message-ID: <776310ac-e37c-0c44-e4ea-15d4f37de020@oracle.com>
Date:   Wed, 20 Oct 2021 10:26:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/2] provide fsid in sysfs devinfo
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1634598572.git.anand.jain@oracle.com>
 <YW7O5Sr0PlSPgE27@localhost.localdomain>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <YW7O5Sr0PlSPgE27@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2PR04CA0017.apcprd04.prod.outlook.com (2603:1096:4:197::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Wed, 20 Oct 2021 02:26:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d872b343-6667-4aea-9f0c-08d993710ec5
X-MS-TrafficTypeDiagnostic: MN2PR10MB3774:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3774E4C361EA068B8DE2A23CE5BE9@MN2PR10MB3774.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +iQfOuEWWbidqHWZUWTKN7L8yoK0qphdnJgGgEyOu5kb4L/ZZksEL9rWLLq3MFLNUBkYKofyGnFuVAw18qFBU/8vaFnuS9GHWs6ud6LAFz3qTPFpVsVuXJj6R0fUcK5dWxRDexZJsh3di2rVsRtqsLoggKPNjlW0vP/owA428CMZd2JLp6oiAIZlYpzpgonrgl0sFlzSRMZQ8eUaT5iPaCQNtITLZ8W8eEPufLQlce7/k512z/xDDkFW+nFSLmMDFbyRdNIdQ+hvaQd/Jly9q+03ibtn7jRgAc8XRIpdKeXAGcGUOe2GMSPSZK4ZtSfo9rXuOcKgj4tHWjNc1LUyPtEkuBuVDzE/skqklpvXOs0WxKaiKjVRithQw5Qyr3dgiX/kuattoP3ZiH1Wmm/r8iAIFJxl7JKyhy9CUEGVNMct/MIK3SS9AlSUtgGA22OHes/aojxQeNF7VZxuTnHSrJvTT13va8nmUAWaL4Ox/4rYJBEcDYO0J5JkEFrslZf1XYZPyQ/2mJuKzSEmNg9RTburfnOSZC6mHYRV5MqfdZvMIW0y+dPjRZx1VQ9Wc1OykrBB+WltI+CCq1VUR8uyncuMgQ/4NCFtM+6TnXB9MltISeUV0AgBY+7M0t45BF0s839zHBBnY0OvsZsTJ/LaJdPmKgTNjgIiYfW06Hr9T8oco3yWZp3wj3vaqLDavExMvHo6PDlG+vV5ft9Qmu6xu3qQ21o8qiQjDBk/XyIOZGA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(36756003)(31686004)(2616005)(2906002)(5660300002)(31696002)(66946007)(6486002)(8936002)(16576012)(44832011)(8676002)(38100700002)(186003)(66476007)(6916009)(26005)(66556008)(53546011)(508600001)(86362001)(6666004)(83380400001)(4326008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE1zKzRoNzRlenpZK0lWd3pRa052OC9XVC9MU2RxV1RpQVJvc3BMWEpBRzFL?=
 =?utf-8?B?b2c1bTFUTEpBRVdhQlRWdVJZVzQxMk1JRDJWNDZMTzhqR2t4VmZMcXREb1Uw?=
 =?utf-8?B?Rnd5NzEvdXBIaEtjL3FRb0xzVHFDR0RlVHRjYmQ3S0hCeTF4amsxVGcxZVBV?=
 =?utf-8?B?NHpXYkpwZlViQ3pZUXlQM0hsME14VU5ad1N2alR2d28xemNsdCt2dmdPeGdw?=
 =?utf-8?B?eU1rdEJUeW9yL1NjM05uTHR4SUQ0c0U2MFU2QzBxTmdXR0JyMmFndis3R2pR?=
 =?utf-8?B?MndOUXoydDBHTFl4RFJKWGFpVVpPSm92SjhlQ2VXaFh1MFFiaDYzTm1IMkZL?=
 =?utf-8?B?Z1J4R0xDcGFua0tzdzNuWGNScGxQMEtSMmwvTUthRjRNSTJkZjVrYURsMDg2?=
 =?utf-8?B?USt6RXJvdUx6ZnlPVnkzTWUvVHhObVpNL1d6MHpYR0RaQ05MSUVyRmdRdVF4?=
 =?utf-8?B?UG5RdHlBK3hYdldvMlJUODFTWkdMNHJuUmJ1U3JTaWJhMHh0d0VqMGpuUjJE?=
 =?utf-8?B?bXM4RSszdzBkRlBSdzNlU2ozRVh5MVJhR1dOWnN5RVBkTlVEVXh4NXVsTnF6?=
 =?utf-8?B?d0UvdmtCc3E5anEybk5tWUtxQlZTQXpCdWdjRVJiRU9EYTh5cmU5V0dEdm1L?=
 =?utf-8?B?YzhRcTRmRHIrTENIQ2N3aFVzUkpnWlRKNmMrN2JrMDRJZ0NWWU1aRWRWODB1?=
 =?utf-8?B?REliVDRwdk1uck9kRzlZY1MvNTBtWmp4RDQ2dmRMUnNVdWF2Rk9GeU1HZzB6?=
 =?utf-8?B?K1c4dzFTTW9OTEtoeUVBdStDYk5WcDRPY1d2d1o2T0Z4cC9EcTUxNnA3SHpN?=
 =?utf-8?B?RW5YZis3M291d1NGblRQcHBlMEhhUmF5UTd1d2dtWFRISjNyMHYySWNaVDZ4?=
 =?utf-8?B?SnViZ09mTlVWR29lNTc0OW4yWTJyYnFTREptVzE2bFlmODJCU3B6OGdGUXlv?=
 =?utf-8?B?R285VnhTcEIrYXVPUVRObnRUbktMUUo4TnNrNFV2YzRML3MrYnQ4Z3pNNFZ6?=
 =?utf-8?B?eXZUcVBPQ01tbnlrYmdoeFB5ZWE4VVBmb0U1ZTJFcjMxaE1rbVZaRVJSMllF?=
 =?utf-8?B?d2dqNmU0cG1oeFRReGNiTE1wK3JSRnVyaTRtTURWSTZ5M3JTQXkzUFU3bVN3?=
 =?utf-8?B?NUNEcU5RRmhtRlBkV0JZZVVMSmsvS3RJM3ZWRFNFZWdZeFdIaFBDMWdIL2gz?=
 =?utf-8?B?cjROOWZGeWswWjFsazkrZytJSG9OYTFEYmlrNXNTSkZuU0JENWNrWFcyK09n?=
 =?utf-8?B?VWwrMXRmUEw5aHRPbzB5NDRZb2pOaXJtZEpiQXMzcVJ4R2d5OVpINm9od2tk?=
 =?utf-8?B?UE1GdXVLR3FXL2VhTkhOblhMTVdIM0Z4VDVNZXduMlR0Tm4xK0hET2hSbER3?=
 =?utf-8?B?Wmk1MFV1MzZKU0NpOGpVS3BNV2xMTXZsWmlYOHZXaHF3T1lKcGNxKysySkRW?=
 =?utf-8?B?V2FQa3dVR04weXJiRkJtZnFETE1EaGRwV2dISC9LaUhuQ0o1amNYRlBEcVpI?=
 =?utf-8?B?NXM3OW1vLzQ5UlVDK0xPRTBzTFdCZlI2QS9iNGF4Q3BvNWx0ZHpWbkFCa09D?=
 =?utf-8?B?ZnY1eVpBai9IWVJrU3ZEYW03clVDanZmNnJxNnJpbWduNTZudWplWWZPOUtm?=
 =?utf-8?B?N3lHeTg1ZUZyYXpobWFEUkNPYU9EdEg2K0NqTHVmZ0dhaUMwMjZoQXJZNWxQ?=
 =?utf-8?B?U1lNYzErdkFJUmR5aUlUbmJlU0JmQjlEbThaeGhRMEJady9NcENOZWdHL093?=
 =?utf-8?Q?BaxsfAMkj3F/1iKimTCvQK8SSbphgBEED47/Il0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d872b343-6667-4aea-9f0c-08d993710ec5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 02:26:44.3661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3774
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10142 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=895 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200008
X-Proofpoint-ORIG-GUID: pyiGf7lrnVdP3uREDa6-z7wVhglDs3mW
X-Proofpoint-GUID: pyiGf7lrnVdP3uREDa6-z7wVhglDs3mW
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 19/10/2021 21:57, Josef Bacik wrote:
> On Tue, Oct 19, 2021 at 08:22:08AM +0800, Anand Jain wrote:
>> btrfs-progs tries to read the fsid from the super-block for a missing
>> device and, it fails. It needs to find out if the device is a seed
>> device. It does it by comparing the device's fsid with the fsid of the
>> mounted filesystem. To help this scenario introduce a new sysfs file to
>> read the fsid from the kernel.
>>       /sys/fs/btrfs/<fsid>/devinfo/<devid>/fsid
>>
>> Patch 1 is a cleanup converts scnprtin()f and snprintf() to sysfs_emit()
>> Patch 2 introduces the new sysfs interface as above
>>
>> The other implementation choice is to add another parameter to the
>> struct btrfs_ioctl_dev_info_args and use BTRFS_IOC_DEV_INFO ioctl. But
>> then backward kernel compatibility with the newer btrfs-progs is more
>> complicated. If needed, we can add that too.
>>
>> Related btrfs-progs patches:
>>    btrfs-progs: prepare helper device_is_seed
>>    btrfs-progs: read fsid from the sysfs in device_is_seed
>>
>> Anand Jain (2):
>>    btrfs: sysfs convert scnprintf and snprintf to use sysfs_emit
>>    btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
>>
>>   fs/btrfs/sysfs.c | 113 +++++++++++++++++++++++++----------------------
>>   1 file changed, 60 insertions(+), 53 deletions(-)
>>
> 
> You can add
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

  Thanks!
Anand


> 
> to the series.  Thanks,
> 
> Josef
> 

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FE33E505F
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 02:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbhHJAfJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 20:35:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29414 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229991AbhHJAfI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Aug 2021 20:35:08 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17A0Wdjg032352;
        Tue, 10 Aug 2021 00:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EPvR1nIiT1huAfLy2Am8zvqk/rlCrNuFqzlYhmeOlAw=;
 b=Vopnny3UgiRHeZdyI8Aev1GuXf3YeN/X+l5oRiVwdHcSPm9b56MjcQdV29xhTGnKBPBj
 PxW3GQePLM1P5J8pMNt9kOl1QzS4fSmxZlLwjgZjm4Pe+hAY6dW5RbznUR4ZDB+qAxb9
 fPqQYb033jzjZd6hj60q0noZ8drNpeiDupqIks+uqEfprp9NKB0PLinqeOpH1zj8FTMi
 BcDFZjoTyvtuo3eAO/JvELsk42eO9h+zLPoxVaf87bHD5SyigSHv8pUxUG0ZbCdNh6uD
 suyUxexAXA53lrB/46HL8/TVnWFwRnhbpia+t2JcVkIRUc8CYpcueAro+1XQYYDAbrGj iQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=EPvR1nIiT1huAfLy2Am8zvqk/rlCrNuFqzlYhmeOlAw=;
 b=Zl6FCk1ndTPgDRuzJuZoNphWo1NEIbYgGUyRibW7bBls5GnAbIybcYxbNcAytAVnhCH6
 TwdXyNrCq/9/+um2aieGBz0PLdPAwEmRjhxYkDCCT4FMqKxp3K4KtoT7Uo9FJJ/Ljlap
 O0aGiQoGHpWtP67h/sOHsprIVRQxbNEAngBgolef966QVwd29ClaA+r+YAPq9PGu0hM2
 E1fmf2KOLK+Js90cASbvycrPZLps6liM99bip1/LTRBbhQ0oD7R3vqu65sq9TqGCItJt
 C8s7gKrDb3mrsDIqxxVwpckJGIPFozSPBA8ZZ8rzaSl/MSxuf+xJDYuGrPFP6U+wBJqN gQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab17dsyns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 00:34:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17A0GQfL123525;
        Tue, 10 Aug 2021 00:34:44 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by aserp3030.oracle.com with ESMTP id 3aa8qs6f4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 00:34:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrvliknIeHAIu/+YLa0tF6IfD9DSicZK6Ummp1qj/n9Xu6ZPXYPGUL41fYgZUbmL+y2eMPXm1c+SGUsPUI2ELQR4ComjPd+IOMEMll6OsY+dnfjX69J669pibKhFd7RMWUu2Rzlr3cU8Dq6MfU7k7EvCoY481m54mnc/rKaNW12TUm1qlkWAFNZa53JA7Iv24sSDvqvgGE9yxR7gyO264Z4QFqLhzdnWkApciRBCwdWaPmdUQxaaV6nNlLoaB6QXhDiLnc1EkCfGN0egbZRW/Lp4ducxUxtQ8k79vq8M3/uVtsuaoTdZd11jGuoFRUXizerIwAs4emvjvBpNSwNOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPvR1nIiT1huAfLy2Am8zvqk/rlCrNuFqzlYhmeOlAw=;
 b=N4F+dqd+uyVMHkCPViVhoQhyrHdhJGrxC/A74LpjaXYIVgfRuybmRpU7yGXFFUmnUT71Jw7Jopl8BNFtopp1z5FxTQmSbrPOiB0845v9q9ms0tqlu3AQtcs2YtnPCbShoaCa75Ds4kt2t9WtDBVRwmLMt4YhlnkUMIgWzdQfDB1woszJSdvFv6SEHYXTXRhD6I6AtZCMm3QeWy80tS+Nua0eh/U2VwJY7kYkZseOcZNN1oIXxLH1Q2W/kawuzUmJLRn942oFICr5ckMZOS6BGU08ZWWP+v/zaw3jXpPLvceSmLue1IXDNXImTJM7zVQJM7VHPnEy+4cfzo0KFmNZrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPvR1nIiT1huAfLy2Am8zvqk/rlCrNuFqzlYhmeOlAw=;
 b=j8y4MTVfwswYLlzxgk9AQKbUCeSvX9jMj3LFMvNi8S9FDi9xiqoh/q3GLu5xmisz2PrGWrUoiDgjJKwO7DbPdVtRzl9b+dSBdJ8L5hGU4DaBucjUKuSGwx9Kq+pBDLYNNoL3CcPcSBwvBazIc8SSQ+zdn95mZJhQLTzFs/yoTMA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5124.namprd10.prod.outlook.com (2603:10b6:208:325::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 10 Aug
 2021 00:34:41 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%4]) with mapi id 15.20.4394.019; Tue, 10 Aug 2021
 00:34:41 +0000
Subject: Re: [PATCH] btrfs: sysfs: map sysfs files to their path
To:     dsterba@suse.cz
References: <8a0aac47cbdcc25b7ec861a5d334db1b6add34ae.1628125284.git.anand.jain@oracle.com>
 <20210809143646.GO5047@twin.jikos.cz>
Cc:     linux-btrfs@vger.kernel.org
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <8c3126d0-c9c0-5cf6-9a64-38e6e8b9f855@oracle.com>
Date:   Tue, 10 Aug 2021 08:34:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210809143646.GO5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::15)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SGBP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 10 Aug 2021 00:34:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e691f09-0ca6-4df0-2dac-08d95b96a49c
X-MS-TrafficTypeDiagnostic: BLAPR10MB5124:
X-Microsoft-Antispam-PRVS: <BLAPR10MB512488624340743A626EB468E5F79@BLAPR10MB5124.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5xuwdZzwkDe1NTYCUuMN8esNIOZodRFfdIIwiqY8iY1S4KEsjfq91g97f/51wZ8Q5ZKv0rV8bMQDz01ZyGFpq+7N3lK2sWgLbQAf5GI/RM9ZEye0aZL4JOV2KohhfUDg4TC+aFh8cCxeer4kTxhK8Rrn2AWGU6jCEZ45cLMGRAiyYrh4N1AVSt3CjPivM2mwBquEr6zKVaJQEKwi2ymTU2HvRkS5aDkWsac9ialqFnOUAjb+6B1f0WLNtJetYou49a2K8O61kGBZ1tsMYFcZv7kFkvAzNYO/Rfc/HNLw3AEXaMyYKFe6EfToo8SS6ienPksHY59cHFGKtGksu/aPO4RJvgLR99+OvRN7IWgKfQ45mcuEOEGLTJY1xSEvK75rIrlWUGEKM9tDPmu2j+rmNGTKdQNiIQF8/xVXUvVuXMGEwVPCPkRV0RiF9fYkgruflJUmBGcv003FeAgfpwP1SJZEEeJH/0VpvD3vOWVfUotXFWk8zskxvD1iIFKbCyO/kGupLVT+TvmcJBPmaiVFy1AyfpZDr/BNd11nv+PgJqfS01e498EiRy826K9VKUs+0i/UItHJGbjfNhzXWk2p0GfDkAgtOlfz+V3tNQtDQzMd85bH/1Xa/V20ryBc3X3P6QluXjFHVfGhda302R4Ssz+HcyupT1j0ebBQUhFup9vXz/gFNQN5kNguqQDyvU+/TfAnzRXjSRGL9ZAb+CE3z0F1OXkr8VmkIxLeDItZ4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(136003)(346002)(376002)(26005)(6666004)(44832011)(31686004)(2616005)(2906002)(86362001)(6486002)(53546011)(4326008)(956004)(16576012)(186003)(478600001)(38100700002)(36756003)(66946007)(8676002)(66476007)(66556008)(316002)(8936002)(83380400001)(5660300002)(31696002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVlab3pJbWVva0hwY1lhZFBodDNaeDhzQ0xPUUEyc2tkVWQ5dGFKdVRxTXow?=
 =?utf-8?B?WjFUZVhWQ05BWFRxQ0NCeE5kZnhoL2d0UnJzUmhESENHeFAwdGJVZisxWkZh?=
 =?utf-8?B?QWJzZkI1ZmcrUVlRWFgzSUhheHIraVEyc3JTKzJPdVdjQ3N4YjV4c21LUlYx?=
 =?utf-8?B?dXJDYStrdStNMVhYSnM1ZUdiTUk3V24yMHBoY2xOZmVOZTVEamVzVGUwVitM?=
 =?utf-8?B?WFoybVZuaytsMzhteVIzUDFHdUduVUFQSUxYZUlBRVMwREpackJocjVsTEI5?=
 =?utf-8?B?ZElkWHE4cFg4TjUvNkgxVDNJMmRhb1VMUnlrbEhoQ0VnMUREQXFGVHk5SHQz?=
 =?utf-8?B?K3M5UmJFdndMYzM3UzJ1UGROVXRCSnBQTXFjL0gxd3Q3MWc2ZnUxVFJ6MG5v?=
 =?utf-8?B?QytLQ3k1T2pYSG5XTW1rNVNyR0s5T1lsT3VrWVRKYkFuek5Mak5IUW91bXha?=
 =?utf-8?B?ckJzelZRc1Y0bmVkbVJpWGVDZHhJZ3oyVGIyRmo1aS9CK2dReWVsSFVHcWs0?=
 =?utf-8?B?enpjS1ZVUm5DeVhrVGxoMm84M3VxeFhyQ21QTDNXOS83MkFCUllpbFREMyty?=
 =?utf-8?B?SWU1YlEyV1BPN2dXUUk0dys0UWhXeDF3cnBFTHJMSUtUcERCWG05RzloS1lt?=
 =?utf-8?B?cmNPeE9LTEVLT3NLdFZEaXpoNC9IZlkwbU03UzZBVjZHOFFwc0dZRkM4c1hC?=
 =?utf-8?B?R2l3cE1adkdENVpuY0NvR1hEYnNWblRRdFFUV3hGa2pReFRRdmp4RGR2RG5I?=
 =?utf-8?B?dkNTdWNpdUNsSHJrVUNta2IxYWNRRjNKVmJrZkNZQWtJeUFLbVcvSkxTY2F1?=
 =?utf-8?B?ekVTclBaZjMyeDNBdFAwLzl0eWNOY2JSbUVUaVpqQVpaY2g4Qi8zaFpvenVo?=
 =?utf-8?B?NGIwb2p1VTd3TmxsUXBaVFR2SjY2YXpHUW5PMjNVMHkxay9oTUZpVDduVFlK?=
 =?utf-8?B?c1RvbGN0WERTZWljT2djQ2dUUmtZYWt6akpDcEk3ZkZvOS9CeUJNNjlhajZF?=
 =?utf-8?B?cGNKWUsyMVlPUTNnTUd0T1NNUWR6c1FCR0lrdE1SWDVYanh5Z3BmdUN2UXJC?=
 =?utf-8?B?MnNMN0M5czh1aDFuOGZDVG1EcE1Dc2ZwZk9TTjhQalZPeE81U0NzeDNVKzBu?=
 =?utf-8?B?akxISGJIbGVwNkJXeDlIc2RTUmd5WmVZdm10YWZwUzB1dWIxMFhCWldIQytI?=
 =?utf-8?B?OUdKUGR1dUFkcHRLT1dUclArSUdzdDNHbXR1RzBXT2xWZmczelF3QlFLSmRV?=
 =?utf-8?B?dWRsMDMrVU1wTmxuMVNlbUpwSm5CNjlzV3owREF0OU9JRmRPRkRQam9Ba1o5?=
 =?utf-8?B?M0RudGxBOERhUVBRUFdORHJvVVErSm9oTUw0TElPdlBMNFRpcGFsRENPNktK?=
 =?utf-8?B?Z1Z3Q0JuQnZJZzE5eEMraTVTQW9KL0hUL3BhQzcwTEFyK0RoZ0s0YWxEVTds?=
 =?utf-8?B?amVjTFZGd3V2bUlFRHBJdzlLQ3ZjOTA4NVRiL3Z3bFBDNlF3MVcrN0ZJaWtk?=
 =?utf-8?B?V043WTJwQmxpN0VHWFVxb0hiZmRNeS9SWlNUbU1tR1RKSjBBZDhDUHRrakYv?=
 =?utf-8?B?eWMxV1hZQUs4Y3o5QWY3RUpJQmhMa01uZ0duZVNIVUpBM2VBaU9mUEk1RVhT?=
 =?utf-8?B?VFZpSVdDY3VoMFJkYUNwZ29VVjJReGwrNWc0OXRueUMrZGgrbFBaUWxNRytw?=
 =?utf-8?B?dlgrMndvaHYrMUo4RkxmQnNhZkVmR2g0WjUzM0R1d2lUVE5OTEJIdk12QWRj?=
 =?utf-8?Q?jrKHCpM2Tz+jRkuYr4FxBVoaAWc78ZMHPXh1f8O?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e691f09-0ca6-4df0-2dac-08d95b96a49c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 00:34:41.5303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0htelJbT7nnoSfa51aJ7iywkXbAqnaQm7K+HrE+xgD8Kq1baJI8bLbKQnF8/f+oJ6zCcbuacX7rTmJt1au+D1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5124
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 adultscore=9 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100000
X-Proofpoint-GUID: ld6T9_-I7BVU9D4SthW2eK8U4nDMUZZz
X-Proofpoint-ORIG-GUID: ld6T9_-I7BVU9D4SthW2eK8U4nDMUZZz
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 09/08/2021 22:36, David Sterba wrote:
> On Thu, Aug 05, 2021 at 09:02:46AM +0800, Anand Jain wrote:
>> Sysfs file has grown big. It takes some time to locate the correct
>> struct attribute to add new files. Create a table and map the
>> struct attribute to its sysfs path.
>>
>> Also, fix the comment about the debug sysfs path.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/sysfs.c | 22 +++++++++++++++++++++-
>>   1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index bfe5e27617b0..cb00c0c08949 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -22,6 +22,26 @@
>>   #include "block-group.h"
>>   #include "qgroup.h"
>>   
>> +
>> +/*
>> + * struct attributes (sysfs files)	sysfs path
>> + * --------------------------------------------------------------------------
>> + * btrfs_supported_static_feature_attrs /sys/fs/btrfs/features
>> + * btrfs_supported_feature_attrs        /sys/fs/btrfs/features and
>> + *					/sys/fs/btrfs/uuid/features (if visible)
>> + * btrfs_debug_feature_attrs		/sys/fs/btrfs/debug
>> + * btrfs_debug_mount_attrs		/sys/fs/btrfs/<uuid>/debug
>> + * discard_debug_attrs			/sys/fs/btrfs/<uuid>/debug/discard
>> + * btrfs_attrs				/sys/fs/btrfs/<uuid>
>> + * devid_attrs				/sys/fs/btrfs/<uuid>/devinfo/<devid>
>> + * allocation_attrs			/sys/fs/btrfs/<uuid>/allocation
>> + * qgroup_attrs				/sys/fs/btrfs/<uuid>/qgroups/<subvol-id>/
>> + * space_info_attrs		/sys/fs/btrfs/<uuid>/allocation/<bg-type>
>> + * raid_attrs		/sys/fs/btrfs/<uuid>/allocation/<bg-type>/<bg-profile>
>> + */
> 
> I think this would be better next to the definitions, so you don't have
> to repeat the identifier name and it's at the same location once we need
> to add more attributes.
> 


  I was thinking to add to both. That is, create a table and also add it 
to the definitions.

  The table provides a big picture and easy to locate the name of the 
attributes list. No?

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EE3483DE6
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jan 2022 09:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiADIPU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 03:15:20 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37386 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232675AbiADIPT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Jan 2022 03:15:19 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2047xnrV006494;
        Tue, 4 Jan 2022 08:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rcR8Ar5KTvo8Dnq37nGQ0zPVMeTiJJSzW03drXNAa3w=;
 b=NG47cVAkUSM+9Tw5ZyF9BT/B2JKqHjsUpxhJINOvVxInJQ53y0HYwQtORFu/+vs9q6cu
 Nehjt0JqYssQiBSv6U4Wsdc9GgNap7BoLYqgZ/vHt29QgybqI1OMJ1LWB+ddaU0hCwXK
 TBHpckhrniudjkz3BzT7KjxTPD8TbL0nJ22ehR0olSO+J38II9NL974qzsUdazjhzp/G
 BaCKpG3hsvXrHZVaQPleAu99E0WFLvHZS8Z6tvsk+JQwY1869gZumlC6CnrfiNBDLKEn
 K6Vy33vGG2gWIJltD9qgBitxlnR6fbxnP7yTJNZpJmjhUDvEBR2by7b4eoB9Q8TG4qUG Tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3v4hjh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 08:15:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20485hhY195300;
        Tue, 4 Jan 2022 08:15:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by userp3030.oracle.com with ESMTP id 3dac2w5am3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jan 2022 08:15:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4kgpVPB9333VwAfDCqJIun9EflCcQIpmG68g/iNEXozvsq8gBNBG9e+vdilaquCuV2JX4TDVoWHqvVGAJK5MGPA1FI4KbctY2Hcdnvvtj/Ij6QON7NRGMo/pKX/ydmbcurFBxNF2luhh2ojvf3oj1hjJ8gvNID/v30ZZR6ed8P/qD8RSxQoQRTjUN3cw2BK0pcPqk9iblnts2Spj+8orW/Ukf7n3eVKpB5QvHpapLkOAbzIChmhsTZYdQmh0bSPFUEZGFHtL8AYVRTkEMUFk13W4UstV9UzX2oR0qPHsdVnb+68fE9EbN88WAQkR6WDD0ieicFCKFGwbXod4P1W/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcR8Ar5KTvo8Dnq37nGQ0zPVMeTiJJSzW03drXNAa3w=;
 b=U4ja4lqJlrhaYkgI7qr43XvPaeCJS4Q+jhJK8ZREn8CXc+9iRLMxqnwbfY5E9dDG8vxsL8MkAJO361CAggEhN7HyF5Z2tHldpySQ4HVh7jLzjJMQttvrK0S9bleLatZ05DclVj0bckJe97HnpesHBTL5yXZiJk+Ykh68T0B3FW8xuKcsBsPxjhpZ+GsP8hjwal80CKXJ3/8bfu29/Bl467fByLxZAZTvLvS91z9fWOqc77TV7zA9oTQUQinpLw8Q/6t+9/DwKO/jxLjU3Q79CJP1qkWbY29+n17FQQ/eyipVnA8tUhi7FrK2ljx2tg1UemYthj6JIi3Rdpb5Lc4XwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcR8Ar5KTvo8Dnq37nGQ0zPVMeTiJJSzW03drXNAa3w=;
 b=u6l18rrdRPA9fWIm55pKTT9XwDxZTm0OLrh2/TQ2Qy+GWAuVKO0KJhk21aGsIiiBuOhtirx+Nbr1dfldp9DHYqyNeRtVRqLAl3lkxWYjHdEpTqSBxjMj7PePEMyMV5mKScMHj+80sPTBfa2arE0vcA7vDGcrwhqo0OUzRJaxtVM=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5188.namprd10.prod.outlook.com (2603:10b6:208:30d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 08:15:10 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 08:15:10 +0000
Message-ID: <18d607da-3d98-3414-d93e-4267a61fa4c3@oracle.com>
Date:   Tue, 4 Jan 2022 16:15:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 0/2] btrfs: match device by dev_t
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     David Sterba <dsterba@suse.com>
Cc:     josef@toxicpanda.com, linux-btrfs@vger.kernel.org
References: <cover.1639155519.git.anand.jain@oracle.com>
In-Reply-To: <cover.1639155519.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::36)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 926c8244-8752-4c6c-68b1-08d9cf5a530e
X-MS-TrafficTypeDiagnostic: BLAPR10MB5188:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5188C1647D8EEBB8358E9341E54A9@BLAPR10MB5188.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gi8KEIBOE4cfQe/rruQ5PrbLpYdXEdAijH/GpJWrUDjqWlyfTJIGAT9Cc2xnzvRfSWo8O9Mj9YfTvlXJduFPiw5bT4bHjr1HyhwMr+OSGDr4iZAhJJv0D2QPnigePzr6sJ0LIfBwT4v0sC/w8mAmAPppsJCkXQKJawxBXA9qSjU4U2axoFjQimOToJE75k5HUzHe5K8oXYvVEOPO2oDrmRBioN+oUFuYNy22oVhmesexEChPZKmyw5lzasgF0dJGbNP9+HmXtBSnkwIGD8q4z/m+odaU3wJ3MXEvrjbJL0Wa1jTrL5QDhAyrYcnpHzUm/8xD4vzTnKWTGAdHJhN8NehP9VKHEonPnpBw2AXyp8bX6hRVV3yvbDAKIEl5vg+uf/0BEAxInZmSy56ZW0xF01w0ZJOKQuoCkZj+O/Rjj6ZEOBhfnhtRa3xtYUBB/qRoiXtFjs5RPD+/JnD1x45qpxL9Jf3QZBe2+eyhf0wyyO5+2aTTPsVCf7oBOjEj29oQ0wF6GLV4URhneJgMqcTiZpghfQ1qiN/evflqs77Hkuzh0OAYSxGoCJhybVf1ybVT3yDWMfSjAx2osKVEFURrORTrdft6ekR04a/3lF7RpWZQ6hooDqvevGCWZvkGmZcQtRahrMl3eyoudbsLjkGk66fZCSq7u+gChqPpX7+rV9AE9rbpZ30trVHQYUW5jJVVXR9yRTIFnQUErDckgFy6N3iQ3lPX8Gd939hpJNaO+Ps=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(5660300002)(4326008)(44832011)(6666004)(186003)(38100700002)(86362001)(6506007)(53546011)(31686004)(36756003)(2616005)(66946007)(31696002)(83380400001)(66556008)(66476007)(8936002)(316002)(8676002)(508600001)(26005)(6512007)(6486002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVQ4eFh6Wjh2SWswY014c3BJZ3IvZm5HVEs5NGdZQlowWG1VZU81R01hemVy?=
 =?utf-8?B?OWs2RVd4ckNObi9HRDNacUUzSS9VSy9uOGl5WFFuV2tOb0lMYUtjeDk1UVRP?=
 =?utf-8?B?V1FlbGh5WlAwdmdmaFA1TUhXUWl1ZVhHQ0cvcEtTUm5vd1N5bGxQT3ZKd1Fa?=
 =?utf-8?B?NVVXaEJMSURSRzNUaVgxb0NlMXYrOFBBcWFsUVkzdnZvT2lrOWhtaXVvbVRQ?=
 =?utf-8?B?ZGVNcTRrbVhBMjYwcHhTMmdUaDNxWnZINlh3ZTF4bmlUaVF5MTd1a1ZzZUwz?=
 =?utf-8?B?a1hJbGpLOWFlaXNUbGlWVE54MVIvUnE0aXUrd1FISndUcDcxa2xhMVluWkRW?=
 =?utf-8?B?dmtFZGRyc2t6ZFVRRmpUaTZLY29pQlNVaStzeHRXa1FxT0lEUHRSNjBrNGZa?=
 =?utf-8?B?Z2NkMGpoL2J2MWJnQnlsUmZvRlZuTSthamJGcW10dVlzRW55MjcyTnZnRld6?=
 =?utf-8?B?dm1YYkc1a3dOTEdBR1Z2cFFMUTBOWlFwQmdQT0YwN0NaTWppQkZlWFhWTytx?=
 =?utf-8?B?RFZKQ2d5NlZDMklZNG91ejJkUkNQUFFxMUMyMmhZRnZMS2twREJsVnVpaVNu?=
 =?utf-8?B?ZkZlTnFFM285eXhweEwyb3NrMENRcitMZWcrblVDUmQrMXlHcWNPTE9vWVVG?=
 =?utf-8?B?S1FoazBGOWpETTgzcDlOSklLSVc3emJKYzhOSzVDUUdJNU5OQytJQ1dmSWYy?=
 =?utf-8?B?c281ZktxWUtydDV4eEJPanJLWmp6cnhNTW5KSFhRWWFBNzdiK0txYWpvbmcx?=
 =?utf-8?B?OWFiTWxIZDkwdUI3aWNOZElVbGRZREFsd0tTdFFtSGRTL0tmOEZQd0JRcHhE?=
 =?utf-8?B?d3k2Y3FmYXlGaUMwWjVMWnFvMGZaQklOYnE2OUZ2cnFPeFdrSWhKNkswelht?=
 =?utf-8?B?aGJFQk43L25kQWx1VndUdXZBb0xxTGZQenVyZGRhVm45enlLc3NNZzhHZFVk?=
 =?utf-8?B?WSs5cnR2RmtLMS9tZ2tDRzZrNDZQQlA0QWV5a1ltNWJ2OFBDVStqalhLUFJh?=
 =?utf-8?B?alVHVGcrWVVkQTZWREdqbEoyajhNUmVsQVlZT1dRN0xxTmxUbmtSSy9yWTds?=
 =?utf-8?B?SmpYWEIzbWNJN3VOajRtV0R5ZVVSQnJqc3RxZGRlNy9HRzVBQ1hxcWZCbmlt?=
 =?utf-8?B?MzVka0k4WkJOLzV3Wjh1ZEtRZjhMTVdyakk3TGx1MC9nRTJwdndxbFdyUWNn?=
 =?utf-8?B?Nk55bHllNENpY0NiZWw3TmdxeHQrS2xRL0dPRkg0cDBqajFiZGhJNEtQZGRI?=
 =?utf-8?B?WHpkcGdmTGk0Ri9hb2FjSDNYQU0wZ1JVdlc4RmpLUW9KTHdRRzdwaHIxeElN?=
 =?utf-8?B?Z2pFbUswS2NjMlkvWkxDK09aTVhhUC9vQ1JEY3BpaHJjeS9TRXdSOWpzQktG?=
 =?utf-8?B?UXlTYlFmbFdwRGdHVE1WOGwrVU1kRDRXM0NtUG56ZUxobTN1bVBlTjN4NC9S?=
 =?utf-8?B?NHBHSktWdVNEamptU3V5YnFKaUY4MW9taHIwdnkzRGRYYkFsam9PVHdTS0lK?=
 =?utf-8?B?Y1EzOWV5TmluM1gzRUJTbkkzR242ZGkzZHowNWFVZTU3OC85NnNJVllHcWJx?=
 =?utf-8?B?RDlaa1FraGM3eUNVeDlYZ29tMSt6YjZMR01mRGROSFRVbDRHTkhXZ2ppcjNC?=
 =?utf-8?B?MTlNNFM1WlB0WEFXQUhid3BTeHVYb3pqRkxWa3JSQk1LY3Rleld3d2VPOUw5?=
 =?utf-8?B?eWtrTEY3Z1RZYVFQUnNpY0hjQ01VTGxvdTZ1RUZuQ05PQTlWWXcwWENUaXdV?=
 =?utf-8?B?RitQb3NoeDBlaklwRGlrRmJuZlAzM0dIb2pXK2RlNGJsb2NxcXZNL1E5Z2Jt?=
 =?utf-8?B?V21WNVB1OFVYZVN5SnFwUUtLb29YZlVkQlgvdFh4eWhWZUpiTG9KNzFDbjNo?=
 =?utf-8?B?dTFCMXYzazFqNUprVVIwYnhMWHBVRk1tbG1YamQyNEZpdXljMHQ3OFJJSDdI?=
 =?utf-8?B?R1JxSG51UnFsODNiaDh5dmgzRm5GY2ExNnRqQUo4cCtpNmw1cUl2bEFqVUc5?=
 =?utf-8?B?MzR3RU8rWmZQcmRuRUpnZ0VCMmNGOGR0YU1ma3ZNbDhGbVFuU2MxQnVaWHdj?=
 =?utf-8?B?MDhiRkkxVkdoVFV0YlBWbDdtMmFiZGJHS3NnZkZGRTBycFJZL2w5ckhuREV6?=
 =?utf-8?B?RHV4S3l0UUc5WmNOSURPcVFwQnJGTERsZytvbmRHTUlvajkwWnA1ajBPak9z?=
 =?utf-8?Q?RwFjTBGg0MeRsBtVVZ1bg6Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926c8244-8752-4c6c-68b1-08d9cf5a530e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 08:15:10.1469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiAGrpsUQ3AqO0BOgzGEi+YfSo8uXET4D36Q89PTEu7Q5F+4O+6FWOCI8o6jlQWRkDRsWl+7MZCGZpONnuZSYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5188
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10216 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201040054
X-Proofpoint-GUID: ePAboU8qQ6ieP1bumjFDwOkJdvb_Jc4N
X-Proofpoint-ORIG-GUID: ePAboU8qQ6ieP1bumjFDwOkJdvb_Jc4N
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Gentle ping?

Thanks, Anand


On 11/12/2021 02:15, Anand Jain wrote:
> Patch 1 is the actual bug fix and should go to stable 5.4 as well.
> On 5.4 patch1 conflicts (outside of the changes in the patch),
> so not yet marked for the stable.
> 
> Patch 2 simplifies calling lookup_bdev() in the device_matched()
> by moving the same to the parent function two levels up.
> 
> Patch 2 is not merged with 1 because to keep the patch 1 changes local
> to a function so that it can be easily backported to 5.4 and 5.10.
> 
> We should save the dev_t in struct btrfs_device with that may be
> we could clean up a few more things, including fixing the below sparse
> warning.
> 
>    sparse: sparse: incorrect type in argument 1 (different address spaces)
> 
> For using without rcu:
> 
>    error = lookup_bdev(device->name->str, &dev_old);
> 
> Anand Jain (2):
>    btrfs: harden identification of the stale device
>    btrfs: redeclare btrfs_stale_devices arg1 to dev_t
> 
>   fs/btrfs/super.c   |  8 +++++-
>   fs/btrfs/volumes.c | 72 +++++++++++++++++++++++++++++++++-------------
>   fs/btrfs/volumes.h |  2 +-
>   3 files changed, 60 insertions(+), 22 deletions(-)
> 

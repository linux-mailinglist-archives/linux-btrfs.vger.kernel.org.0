Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB23C56BA93
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 15:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbiGHNVj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 09:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbiGHNVi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 09:21:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C56E2A703
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 06:21:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 268B8DKf026591;
        Fri, 8 Jul 2022 13:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=firZS4KD04lvI7U/AJ3jbsDBd0JgsMucj4q+cfVmAcs=;
 b=we+PJfmM+VXFo3MPx0kdNtMCTTtr3s4yrRMA2xyoWQgYyCDf0KeUQHeuUXlW8hhRoSo6
 nbdt+9fsVZI+ybKOmth80Vzvl+gPa08NtvijVsTIY5DIZkbmEmG19C892sx/zs9a2ieH
 zJPb5ql411IZABegdHhO7DSWhLoHjEa2uz9X0DUkzmRKdsO2rDHL2MHE2QYzNKG8cabq
 2hhPN3vJo3I+p/1doJYJFfXjnNFf0dZOBYI5i+UBT8Z0wZzLPxYNnkdNt4HLA+4QtLot
 bRL6iAOkQkYmA+kRX7Pfc7OdUQ4qvan5k+Wuu0akBUNKjJ3TSOpk0MarfWP1O4V2etFj ug== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyg4ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 13:21:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 268DF6hD018683;
        Fri, 8 Jul 2022 13:21:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud2nnuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 13:21:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWnlrHQp6nuG/uFDYalxiU/YPe80CHWzMbgsFMx3HvmrvnuVOmJYkg5jdc2iZS6QyuZw82P4yKbALj/85eW7TeTJR9Hmkt2p7rJlbQshjTg1Wu0q3Eo4DqLGhA3bWCk1Jwes+cPkpOygT0ekcJP1GErYc+4AT9yPhOIuKYdndx+Y5VHCz+c3i6PXtl1fAJZkj83+qifrqEpECA795XI7y0SflPL3PMaXsP1SdxiGxTU/uS0L1ZJdtACrHNZuzJ5teup+tc6LATdyHLO625XDnWV5aRLAhUtsssgmGMVZATYg0LOBbiKrGl0g0C1zls+71rN90JiPF7igYGAfhsMDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=firZS4KD04lvI7U/AJ3jbsDBd0JgsMucj4q+cfVmAcs=;
 b=eM30c3KCMgYbpTV6EPiqQwqC/8mY9wk/H6dC9tG5w2wWD81CXswoa2BXJBdkKJ0TOymThGol2SmJu8lm/DMYQz+l5NrDhmS1uShe9gw8E8knjYuGXO+WRYpv4Qn7Ce+9CJfj6GgQKFFfH1U1zse2C6a0eWoE8OD4xPPmvXG4Yt34NmIw8IWdXAbsUlzqEWNpwT4k4CKKs1NbWW7YV0pg3FL1dub8KU/CV2iRGuxZN2Z++33Rzd2tFq/OcwqGFj6lAfn8TkkDDiUmxumrrFjiKbaIyC2gK04gRr1G8lb3K6ZAUSrIg4ud+HnV9Fe96ft9LiPocuF4Hxgz7YPnSehuAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=firZS4KD04lvI7U/AJ3jbsDBd0JgsMucj4q+cfVmAcs=;
 b=IRVgplvOSrDmKdLu+hHZRrq2KMI4CMH3LZZDd4wNCvlGH1t9eeGzvi5/L7NB89MY+3P/5NU8dlUsXljyfS9rUD1oe2UgFWVExQXChKU9hQ1gSrPq5oPPdOyS7XGY+v+r8fVggly3biyhzB6nhwtnXS2d2rO2KtOIzkIKjw7VUKY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BL3PR10MB6139.namprd10.prod.outlook.com (2603:10b6:208:3ba::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 13:21:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bcb9:f224:ac37:6044]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bcb9:f224:ac37:6044%7]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 13:21:26 +0000
Message-ID: <94010efe-db44-e1c2-b445-61babe9c0893@oracle.com>
Date:   Fri, 8 Jul 2022 21:21:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/3] Cleanup short int types in block group reserve
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1657220460.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1657220460.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1258afdd-9c62-4bdb-7fd6-08da60e4c268
X-MS-TrafficTypeDiagnostic: BL3PR10MB6139:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vEBiqc7580Raf0geu1am1G09xN/827pgtDrggAOsekF16RqZICXKDeieqMUhqcp6dI3cQKgLO1kwqcHb7x5C9EvB9ApPquHy970Y3jRVIz92AOg7jr/IbVHETkGZTAzps5eK5qjyAhxwuCeY2ccAbLJK/U4b5q2huKZaDlckQix+8fikOLpE9LWx/pQiGE83U9hnA7xVHL/fG57+4IzujtnzvkyR9sPPHdZzs8fKjmBR12DV0AxH6h4RE7FaUos1Nv46q+010vhJW5wq+Tug1eGkQGoLJc2CDSd4V67URDo8E4hjH3wavWqQVd7cEz5dhawMXFoMZJNM0t/qj8vA/9pbGhEpfRnwhhou4V6Z8D1RbaGmZIEl8YLEVQ8yNezfYq3KmFwJhQwQumvL1W8o8o0nQArCiSpbUae3dlOaQphckPlHZ1ZgKwzBR3Ya6aZW4LXfdpAnKZXcolJgMk8zfN9OzL4FyBB3oJpgKQt9I3UjkbjY4rMw9vfTbT5S2vkPD617uUocXZ5Tq+Iq5S6SN76oFlSJCzHPGLxd9hamrarEQV3BOUOSB2EQpg7DyZCM9qO80vYLPDmfr7XpZ99tStQasw0ouYle1UqSuGpeDQZXHnF8qtzcfijAN8kFyzeQRCRGaANxCwEJKseNDd0LO8auoaH6BrX7m9Q3Dz/obtodTAxN9F8ldzuntoSEGEjDl5NOCZGDVOf4R+a6cEQRJGiyU4AB51GF5IU5JVzjA0i+fTu/SfW6obBxjUUd9QC+ErhDHffzKp6IYTofS/MX1Z94LL/AMOOSvhZeUF2ii/RN3e9v65N2CHPF/DEVlR4lQNpUtjKFviS2jzMyFab0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(376002)(346002)(136003)(5660300002)(8936002)(44832011)(2906002)(4744005)(6506007)(83380400001)(36756003)(86362001)(6666004)(31696002)(186003)(66946007)(6486002)(66556008)(2616005)(66476007)(53546011)(316002)(38100700002)(26005)(41300700001)(31686004)(478600001)(6512007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmYxQXFZcm9QWjFGcjY4MDBONEdNWGZzZ1YzWHA0QzdwT3BON2tyVUh4NHlF?=
 =?utf-8?B?SkdML3hPR1RiRCswVTZ2Rlc1SDhySWdsbXArM3FGZUtZS3dMdFZ4MnVkRHhT?=
 =?utf-8?B?eldIYkZRdlRlMy9HQ3hSNWM0cm1TRlJaWUx1ZVRYcE55M0NZeWZMUlZnTHZj?=
 =?utf-8?B?aUNlUG5tTk5HdnZzc2RCbUJBWFJrdVU4R3FjNEMreUcyb2JIWWUyTDdvZHQx?=
 =?utf-8?B?ZjVsUUpsYnNDR1J3RXpPVEJGRzh0M1daU3EwZEVYRzVrZEtMblBrV3NJOE5y?=
 =?utf-8?B?UkNKQzVkUk1GWCszRUh6NnpzZ2ZJSy90dXM4dGw0cEdJRWgwS1pKemwxNml2?=
 =?utf-8?B?UGVaQjMwMWdRTTBZa2lldlVqMUQyNFA5QzZid2VMQkEzV3o0Qy9DaUNLQUJv?=
 =?utf-8?B?UjN6TVFEeTh2YldMWkl6bnoydEVMU3RaVEF1ZnRXS1VYNkFibmIxTXVxK1dU?=
 =?utf-8?B?eUtSVU9vdzRtamZvTEs0UVNFWno0dld2L3R2WjRGd1lyM3dLUFErR1RONmtU?=
 =?utf-8?B?eW5ueG44RS9zL3c2Nk51WU96OElhd1d6aGNQVXJsZDRqU05XSEhDbnVidnVU?=
 =?utf-8?B?VVhFNEJpRE5Eek9GbjltSmxzT3BWd1BVdmJvbDZKdTVPMi9EbWw3M0l4WkV2?=
 =?utf-8?B?SlhBZGEvMHNBaUQ3bVZuZllMSlA2Z0plZi9ENUNDZWc1U3FvVER3Rit6WnlT?=
 =?utf-8?B?YVZha3lYTFNuZGUva1FJOFBsdElRL2tVQjBCQ0dOKzBqUEozMTJ3Q2xySzVn?=
 =?utf-8?B?ZXdoTkNGbjdXVjY0WENJVjJraks5cVdqYTFuQS9ubUtUSVV6OTRvR0ZDZzhy?=
 =?utf-8?B?ZDdDOWE1NC9XSnNaL2ZkT3B5VythV2t1WjBjZjVsRE9GQjFoT0JwZFExVTZu?=
 =?utf-8?B?T1N6UmtOTHkwQWtZWXR0Z2VNakVPbk9tZ1MxZFUzYTlDd3QwdHhKQzVOYlhx?=
 =?utf-8?B?UkVuV2JpVkdkaEpvUTJEbHpaUWFjenZQVGxVWGlvN0NtY2pvN2N4cGxIY2pC?=
 =?utf-8?B?U1hJMytaSzd3clhYM1NEcDM4TW1zQTFWT09ZV3VZSFNGWWpkRmIyQ1QvcHRo?=
 =?utf-8?B?d01SNXhXRHhtOUtMTnZ4bzg4V2NkUUZ1ZW5VQy9weTVrL3NmSkM1SGdWOXgw?=
 =?utf-8?B?YXU0YVprRW5PYUdYRkJGVFJYUkJJTHBhYW5pZ0VyZjY0alNmanJnTFlHZGtM?=
 =?utf-8?B?N1NwTUc4M0JOV0IwRlJWU1lqcU83cDJzQ0YrOHhBSjA4R0FpUm1wSC95TWMy?=
 =?utf-8?B?dmxZd2duMWRsN2VsZU1HY1BzdnllVVhlUTZQNk9qZGJXcHNRS1hvZEhGUUhn?=
 =?utf-8?B?ZEJvS0xCUjMvVytCSGVXSGtDKzMxS0FTcFVTcCtFaTBjRXBXZ1BLM1lraVFt?=
 =?utf-8?B?NmxqcGxsZ3lwblQ4UEpMNnN4QWZFZDh5VFVibGtYaVhieWRsY2VTMUlYaXNU?=
 =?utf-8?B?VHZON3NLdnA5L0t1aVV2MlJmS2N1QnUvR2RtYXJkU0JGV0p1bHVUa2VLSDNF?=
 =?utf-8?B?eXJwbjAySytTaEwyR2F0N1dMeXZkR3VVdVU2QlJVNElZVmk5MkVFL0t1S2lu?=
 =?utf-8?B?VkZuSHlWT1NiM0xBeUFSMitScnhJZXpEL25yYTloYmt0WGlFcjVJUkd4NjNV?=
 =?utf-8?B?R0tjL2hrWlYwb2szUG5qL2t4cXdTdGwwWEcrenR0QXVhWWhzTGh5UXUxL1Ar?=
 =?utf-8?B?eGE2NWZ5S2EyeTBCWkQ2WURycXptcnM1dUJMWUdTRGlGVHdaK3RTUW5MYWRN?=
 =?utf-8?B?ZjRDb1E0bDJTZnE5NEhReWNPSXExdzJuaytiaTA4Qy9XMTFoS1hnUlRKd29o?=
 =?utf-8?B?d0cwSjR5REZJNnpmZ1paaWVFcmU5SmJwcktEQi9HMWdFd0d1NEUvQ2VkY2hJ?=
 =?utf-8?B?VkQvM2lyZ1FOanNMZUQ3WUp5SDhtQTNPbGV1SCtCVHlzaUtPZEpFWE9udWM2?=
 =?utf-8?B?TEt1OHB6SVpBdWZxSCtVV3N4NVdzdnRPWHl5bnNLeXdMQjNQYzdmdjVYaE52?=
 =?utf-8?B?OEIvRmt6U005UWpQdmFBOGVrdUVYUFU4SGEyRmdpTVFLanM0U09VTmk5bDZ3?=
 =?utf-8?B?Vi9YV0xYMEJ0MDk2QzVaUitFUU5SUFhWZVkvK0RqZjg5WkgzR1lVR0svYTNK?=
 =?utf-8?Q?8a0/QBAumhknNs3EXbtnn/EEn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1258afdd-9c62-4bdb-7fd6-08da60e4c268
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 13:21:26.1158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMnJQ2tTplMSHNIaiL6Wuu45SPgiC0vQxZelN+qtLKQlUb80ietzaf4OoUGIFISUZ1HIcFS7q/LWurva1O5Wrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6139
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-08_10:2022-07-08,2022-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207080051
X-Proofpoint-ORIG-GUID: 4dCMTzDfHYxKgDIP7JsemZSWz3mK3uQw
X-Proofpoint-GUID: 4dCMTzDfHYxKgDIP7JsemZSWz3mK3uQw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 08/07/2022 03:02, David Sterba wrote:
> Using the short type in btrfs_block_rsv is not needed for bool
> indicators and we can make the structure smaller.
> 
> v2:
> - fix true/false typo in first patch
> - use named enum for block group type
> 
> David Sterba (3):
>    btrfs: switch btrfs_block_rsv::full to bool
>    btrfs: switch btrfs_block_rsv::failfast to bool
>    btrfs: use enum for btrfs_block_rsv::type
> 
>   fs/btrfs/block-rsv.c   | 21 +++++++++------------
>   fs/btrfs/block-rsv.h   | 15 ++++++++-------
>   fs/btrfs/delayed-ref.c |  4 ++--
>   fs/btrfs/file.c        |  2 +-
>   fs/btrfs/inode.c       |  4 ++--
>   5 files changed, 22 insertions(+), 24 deletions(-)
> 

For the whole series

Reviewed-by: Anand Jain <anand.jain@oracle.com>

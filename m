Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC312620B59
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Nov 2022 09:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbiKHIlf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Nov 2022 03:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiKHIle (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Nov 2022 03:41:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664BC2DFE
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Nov 2022 00:41:33 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A87uuNh014621;
        Tue, 8 Nov 2022 08:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mjD7eTlShfEp8F7szZ0h7aMItH/IOo5Qh763en2amYI=;
 b=HXBuAssxgY7r1T91EZXq463pV7je+3U1txJCCx2a3Ibus5yb1BEHRY3PKTtiisTLYko2
 TgmGLMbkOj/+/0wKsvyO7Z+1gTJnxrtLr2DAOx1MQtrNkoh/WOL2U3bwEpDWgx/zyh5p
 B8yBb6G7OGduyjtsEYRscaNEb8ePiqgDtdjQmkn8ywQ9Ll6KQuze3JHV1wRE2+c2V8Mv
 SPTx3mCGVXeiaS3STiDv7A7GnUkkB6PgyylbI6kBkBbkuXcC8T3XzYZQRPQ5Wvsz4WcS
 bhvZSJHITKD09m2K2DLEzAiEhCUtxcd3IIU4xAqOIHfxxukbb0t5kMMVMNm2hjfQM6Lw Tg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngnuxg84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 08:41:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A860jAA003426;
        Tue, 8 Nov 2022 08:41:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctbwnax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 08:41:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU3mVNGxIPUFbwDydEo5BJdfTtDm+mc9BRirrBdWeoxr1xTqaDhnWRwCWHyEWXrx1lhroPkU1Ei0jjLhbLXYtn2EQmwEK5NI/65A4FoU4PGsd1mc4gVVJVqI+4HvNgdTC3nhoi2nDct9lu9dWKWuJB3H2tHqLaDhN4l1XLny3BF1Ahjs1PZhK6V6ORb4T3qwcBQSatUZGm/u54/Ok6V1AhFpLQvNK2RAMqDiFHI1GIl0olKOHq4IMBX6UIO8YwBSCLAS+P+i5XlFqZBDIJ0kW5GAI9pBfhjlC/jb5Rq6marsAzGUxXGuf7x15UwKla1jDGKr1PoWXGqO6gd+V4ojwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjD7eTlShfEp8F7szZ0h7aMItH/IOo5Qh763en2amYI=;
 b=JvAfyK7yyLMq0B7lXJnUQVGvc/INy5CT8Zb1B/OIdWI8I87bCCnUToPdP63GKWvT2tXjDQIzlp4ICSxUyaE8K+GjRb5oPS+BuGhPKZJePut0Z1l97ftu5sokSUDmJl4vQARG9pd1dJE+ywrMPy7gXP2Hu7UJ5shfsGP++Az78jVAVNRsxqj3sbHJC7+i6yyp6N9yFnXRlaJ+VvQr+k04C8lb8z7wvPKCVnm7hFKunMbPT+Ey6RR2vRxaGY0lCgqWEC8ZE1oyNuxg6BA1ONAyC/PpFBSZnBAT3NcZdp1siT7dEk0MlXW327UCJxik2UinFyL/u2CJOmbDS/jwHVkGoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjD7eTlShfEp8F7szZ0h7aMItH/IOo5Qh763en2amYI=;
 b=JuaPxorOU2vohwrYrNej+2UYADAOMweOCg7nbwByVMma7VmX2CcUdmf21ng33SqfHCUwkt4zekm7h5LmXH3EKYQttxbtHcNK6vEeJfk8fgr1DXDwxYh5CiqZ0ZuCnLhIUNDpyo/3lcMsjU+/7rvtDJoHsViAMFYff0Y0inUgJVg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BL3PR10MB6068.namprd10.prod.outlook.com (2603:10b6:208:3b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 08:41:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a4:3fc3:dfa1:8f56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a4:3fc3:dfa1:8f56%4]) with mapi id 15.20.5791.022; Tue, 8 Nov 2022
 08:41:22 +0000
Message-ID: <38c68da6-6556-f90a-5938-ad31603cce7e@oracle.com>
Date:   Tue, 8 Nov 2022 16:41:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: drop path before copying root refs to userspace
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     syzbot+4ef9e52e464c6ff47d9d@syzkaller.appspotmail.com
References: <73b531f0b9b9317a0693244ae7cc4e60566ccf25.1667839482.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <73b531f0b9b9317a0693244ae7cc4e60566ccf25.1667839482.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BL3PR10MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a7eca0-e585-4723-0d69-08dac1650359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vT2VpRcQEGN4FkoB6Ffzy45L6TgGxq7Kh8QXIsteYfDeDx6DlJPKO2R2i5rGPAmvoxL3SBOkgtKum3ihjCD+/02+FfDAhpQripKiJKswILUj4NlBRZajmdX5HDCDfL8qSFlutZ1ydRx7OvGdHZmEATDshPo6Q3777ydA8LwpZK/DDwry7sgiX/rv+woSgjDCuR3BdLtBVPGqSxW974Bk537Go62LHc+/1raXKYuk4JbKdxznx3qZvaufC0easrA6ZqNiH9NL6M98nMA67RxI+/eyjtmzPU2/8BZ9ecVTglyTFpHPECJSLVMfZVmt+2TFwHbyqRYSsaBbFs3xT0TGdHV1znSDHRAp/xhePE8I7P1518wmlnAezdeM8UVH3aUoBdhgetAchOe8TS0r+6L9Jfycr/zxZiLqjJ3rwEf0OT3Loe4Tq5/Q0B3zV6yfr0uUEVjm0twjblNyx0d0uv4yKaggEd93sPvVhkUU+du7FIxDBXag5r12IvLi/SqAZC4HtMvQOuhMdWRf087smKWqpA+MpfbkoPrfpQrOdZPoCsTHgoR7GonK/aYrjVpul/gncHbobYGqdqQZ5HJySyRN72s6/PqPEtFQWJye7MDnu/yChJiHeNNy/0t1FqmpQz8OfeFj2pco9MxjSEiWNhqCutf6b86fnDvhQ0bp1XCch2e+hKs2gbve0OJkVU8Lhs9//eN49hrkhDui6FLu8k89vuxVH8/GIpuCZ8CX9+iuBQ1ypjdmcYvDsiuapiynm6mM6eH2LilLie4eMGfGRt4FuN8OQCrrhnY2ACMdEqHHnA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199015)(2906002)(53546011)(6506007)(41300700001)(26005)(38100700002)(83380400001)(6512007)(44832011)(86362001)(31696002)(2616005)(5660300002)(186003)(8936002)(31686004)(316002)(6666004)(6486002)(66946007)(66556008)(36756003)(4326008)(8676002)(66476007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnpqV1A4QlovT1RvV1hqQ1FVVXVBcFNFbHA4WXBJSDBKWkVwWTJYMENsaXNn?=
 =?utf-8?B?QnhEYWlMY0pWNlAySkFDR1IvSGovMndHVHBlQldhT29IM1QvRW50VUZqRWdr?=
 =?utf-8?B?dGs4VU9FcTBwQ1BNczUyMXNpSjZiN2w4Slp1UUtkMkRqZlpOYTZPNFAyUkto?=
 =?utf-8?B?dktJNlRETEJQVkFLYUxmR0hnQ0JHSUNiUDNadGhIVSszQ042YVVYaXFsRUc5?=
 =?utf-8?B?YXIra2dZVS84MkJ3bUhLQ0NGcUljMElDb3dtV3Q1b2pXU1A5SjZ3N2hKRjlD?=
 =?utf-8?B?cHJXS3FzdjFBK3ptZU1vZmhqNXBMbVpLNE9nZVVyTEJjUTZycTNKQU1PV2pB?=
 =?utf-8?B?VUZBSGpLUlRadEZCY0FJa1kvMzNFMTB5aVJpYXA5OG9FWm12VkxiaWQwWFQ2?=
 =?utf-8?B?ZG4wbG5SYks4K1pqOGYxTVVxQ2tWQXBjcW9NRG5ndW5CT2hhRWhsMUwwUk9L?=
 =?utf-8?B?a2hTNEJRNktROWxSaWpUa0RpUVBmMGtPMHlKeDRtamN2WEFWL0M4R0kvajBF?=
 =?utf-8?B?d3hNL0hTRmhNZjRhOVZ5T2NtaDRiNmZHbXJ4VG1HV05oREptdHZJRldqY1M0?=
 =?utf-8?B?dFNOVkdjRjJHRk9PY1gzNHZGMlRIUmRCM3RjMnJGTlpsanFHT2Q4VzdQb0hx?=
 =?utf-8?B?YlNXNkJCU3NlbG5rK0lEY0lPS0ZoNlo1cFJhemhCekl3b2ZNY0lRRkFzbmRM?=
 =?utf-8?B?R004VmJhNHI5MlFFdVVOL1d2TFpjT3h3QVFUQmZiamJqQmZVRnVKZlo4QXRP?=
 =?utf-8?B?UUdrUGVURUNFSjE4S0x4L1RzRDBoS0diVzRwY0dORTUzU0ZpQzFlcE43TVpz?=
 =?utf-8?B?eSt4ajhWTUx3TlgrdjJiRExVR0lwa0oreEp2cXF2eXZDUXZHTnhLaUlOaWha?=
 =?utf-8?B?dmErK1ZhMSs0b2Nla0gveTJ6Z3NiVENPT0dJb2JyRHhzbXdubnF0SkFjK1A4?=
 =?utf-8?B?SnpKYWU5UXFrNGdMWFdSalF3b2lSQ0dMT0tTU2JrYjZFbTJ5S1U0S1AvNHFo?=
 =?utf-8?B?dzdkK2UrU3JTQ05PM2lOZkxML01iTWhnSjRGZTU1em1zSlZ1alhCZ2VvS0Vz?=
 =?utf-8?B?bnNZU1RjbHV4bVliVkJ1RFd1bDJGQndGVVJVREl3Zy9LQnpUd0ZHTEd6Vk9B?=
 =?utf-8?B?WFhtNlJzVGxIU3RCeWV3K09Rc3dDRG5Sc3M4RU1qYXZtdnEvUjcxWlZkK0gv?=
 =?utf-8?B?eVFTajMydTRrNE1MRlZNeEhXS3V3L29nbjlhSVlNcy9JQlZMSHpXTitPSWNL?=
 =?utf-8?B?MUtXQVlibnk1U0pudnFJWWdPTmRINHlUQlNER01GSlMrSSs0Z3hlYXpqZith?=
 =?utf-8?B?Mnd6ZTdJUWphdDBmUUUyaXA5RzNTS0tZemNrWXlmd1Y2Qml5bWxxYlI0a1Fj?=
 =?utf-8?B?NHQrTXVrRjhDN1NWaGxENGVHeGxZZUU1N0lJTUp3Y0hsOGViclE0M3FVY09x?=
 =?utf-8?B?a3BqbEE3UFlrWjUzdGc4L0l2djZoT21FTThYRjFZVHF1S01FOUh3MjZReDQy?=
 =?utf-8?B?VjB6ZmIrd3RZd0VOdGY3blNseXVUejBvTy9nNEwvQi9YLy9KTTlQSmlwUFJz?=
 =?utf-8?B?Mk5YTHNWeDh6dkVhZUZmUkNraHN0ak9pc2w5a2pwN2hET1dWcUc5amlGdDRq?=
 =?utf-8?B?ZVVOYm5kZGJhZERCek1jcEtYVUZmRkRNTHdtbkUvenNoMUVNelZxOEdya0xT?=
 =?utf-8?B?UEJVdnNzbGdHZ0tSbWpoK0ErdXlyQmk3TjU2TDQ1WG1VZ056QmtkNGxIVHRi?=
 =?utf-8?B?WlZHMjNFbGtmUGZsckpoOSthZ0FlemRXaFFXdU14TGdrdm8rUzA4Wko5aTFt?=
 =?utf-8?B?VEV4bjRxZlhocXVMTUdMZG1zUUYxTjJzYi9kcHVOSEdyVDVwVXUrN0ozN1Fp?=
 =?utf-8?B?aVowU1U5SW9obWZQN3dMamlFQkZTWEZhYk5oeHdyL1dpZkViakhDSzZTOUxr?=
 =?utf-8?B?T25xME9QcmVETkxTUkhMY29ENXZFWDlpK0FPa1FnNXR0NjRaWmhUeVE3NUsr?=
 =?utf-8?B?aHZjN0pvRG0zTnNKbkJuWFFMZUN2M2I1clNveGY2ci8rQWJ1MVQ0V3JrWU9U?=
 =?utf-8?B?eERuYlVYb2oyNGRWV1JmbG9ncWM2eEJBTlVKQThGVFZpbDM3dXo4Ri93TzdK?=
 =?utf-8?Q?qwlm+LxSIeCYwOIZScFPH8Tc+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a7eca0-e585-4723-0d69-08dac1650359
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 08:41:22.3071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfKZf1wU2apqmmeJFvXlGM/im/CinGNeqyExZ3Ys9lAgocAGYOvFiwL4PgBJpbqkLvF8cW0quGYQ8LyVgIXM8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080046
X-Proofpoint-GUID: 4AXv-Lqw1Vz2JEwNkZSzottEAFmO1ZmA
X-Proofpoint-ORIG-GUID: 4AXv-Lqw1Vz2JEwNkZSzottEAFmO1ZmA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/8/22 00:44, Josef Bacik wrote:
> Syzbot reported the following lockdep splat
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0 Not tainted
> ------------------------------------------------------
> syz-executor307/3029 is trying to acquire lock:
> ffff0000c02525d8 (&mm->mmap_lock){++++}-{3:3}, at: __might_fault+0x54/0xb4 mm/memory.c:5576
> 
> but task is already holding lock:
> ffff0000c958a608 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
> ffff0000c958a608 (btrfs-root-00){++++}-{3:3}, at: btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
> ffff0000c958a608 (btrfs-root-00){++++}-{3:3}, at: btrfs_read_lock_root_node+0x13c/0x1c0 fs/btrfs/locking.c:279
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #3 (btrfs-root-00){++++}-{3:3}:
>         down_read_nested+0x64/0x84 kernel/locking/rwsem.c:1624
>         __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
>         btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
>         btrfs_read_lock_root_node+0x13c/0x1c0 fs/btrfs/locking.c:279
>         btrfs_search_slot_get_root+0x74/0x338 fs/btrfs/ctree.c:1637
>         btrfs_search_slot+0x1b0/0xfd8 fs/btrfs/ctree.c:1944
>         btrfs_update_root+0x6c/0x5a0 fs/btrfs/root-tree.c:132
>         commit_fs_roots+0x1f0/0x33c fs/btrfs/transaction.c:1459
>         btrfs_commit_transaction+0x89c/0x12d8 fs/btrfs/transaction.c:2343
>         flush_space+0x66c/0x738 fs/btrfs/space-info.c:786
>         btrfs_async_reclaim_metadata_space+0x43c/0x4e0 fs/btrfs/space-info.c:1059
>         process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
>         worker_thread+0x340/0x610 kernel/workqueue.c:2436
>         kthread+0x12c/0x158 kernel/kthread.c:376
>         ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
> 
> -> #2 (&fs_info->reloc_mutex){+.+.}-{3:3}:
>         __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
>         __mutex_lock kernel/locking/mutex.c:747 [inline]
>         mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
>         btrfs_record_root_in_trans fs/btrfs/transaction.c:516 [inline]
>         start_transaction+0x248/0x944 fs/btrfs/transaction.c:752
>         btrfs_start_transaction+0x34/0x44 fs/btrfs/transaction.c:781
>         btrfs_create_common+0xf0/0x1b4 fs/btrfs/inode.c:6651
>         btrfs_create+0x8c/0xb0 fs/btrfs/inode.c:6697
>         lookup_open fs/namei.c:3413 [inline]
>         open_last_lookups fs/namei.c:3481 [inline]
>         path_openat+0x804/0x11c4 fs/namei.c:3688
>         do_filp_open+0xdc/0x1b8 fs/namei.c:3718
>         do_sys_openat2+0xb8/0x22c fs/open.c:1313
>         do_sys_open fs/open.c:1329 [inline]
>         __do_sys_openat fs/open.c:1345 [inline]
>         __se_sys_openat fs/open.c:1340 [inline]
>         __arm64_sys_openat+0xb0/0xe0 fs/open.c:1340
>         __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>         invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
>         el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
>         do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
>         el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
>         el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
>         el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
> 
> -> #1 (sb_internal#2){.+.+}-{0:0}:
>         percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
>         __sb_start_write include/linux/fs.h:1826 [inline]
>         sb_start_intwrite include/linux/fs.h:1948 [inline]
>         start_transaction+0x360/0x944 fs/btrfs/transaction.c:683
>         btrfs_join_transaction+0x30/0x40 fs/btrfs/transaction.c:795
>         btrfs_dirty_inode+0x50/0x140 fs/btrfs/inode.c:6103
>         btrfs_update_time+0x1c0/0x1e8 fs/btrfs/inode.c:6145
>         inode_update_time fs/inode.c:1872 [inline]
>         touch_atime+0x1f0/0x4a8 fs/inode.c:1945
>         file_accessed include/linux/fs.h:2516 [inline]
>         btrfs_file_mmap+0x50/0x88 fs/btrfs/file.c:2407
>         call_mmap include/linux/fs.h:2192 [inline]
>         mmap_region+0x7fc/0xc14 mm/mmap.c:1752
>         do_mmap+0x644/0x97c mm/mmap.c:1540
>         vm_mmap_pgoff+0xe8/0x1d0 mm/util.c:552
>         ksys_mmap_pgoff+0x1cc/0x278 mm/mmap.c:1586
>         __do_sys_mmap arch/arm64/kernel/sys.c:28 [inline]
>         __se_sys_mmap arch/arm64/kernel/sys.c:21 [inline]
>         __arm64_sys_mmap+0x58/0x6c arch/arm64/kernel/sys.c:21
>         __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>         invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
>         el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
>         do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
>         el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
>         el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
>         el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
> 
> -> #0 (&mm->mmap_lock){++++}-{3:3}:
>         check_prev_add kernel/locking/lockdep.c:3095 [inline]
>         check_prevs_add kernel/locking/lockdep.c:3214 [inline]
>         validate_chain kernel/locking/lockdep.c:3829 [inline]
>         __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
>         lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
>         __might_fault+0x7c/0xb4 mm/memory.c:5577
>         _copy_to_user include/linux/uaccess.h:134 [inline]
>         copy_to_user include/linux/uaccess.h:160 [inline]
>         btrfs_ioctl_get_subvol_rootref+0x3a8/0x4bc fs/btrfs/ioctl.c:3203
>         btrfs_ioctl+0xa08/0xa64 fs/btrfs/ioctl.c:5556
>         vfs_ioctl fs/ioctl.c:51 [inline]
>         __do_sys_ioctl fs/ioctl.c:870 [inline]
>         __se_sys_ioctl fs/ioctl.c:856 [inline]
>         __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
>         __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>         invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
>         el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
>         do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
>         el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
>         el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
>         el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
> 
> other info that might help us debug this:
> 
> Chain exists of:
>    &mm->mmap_lock --> &fs_info->reloc_mutex --> btrfs-root-00
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(btrfs-root-00);
>                                 lock(&fs_info->reloc_mutex);
>                                 lock(btrfs-root-00);
>    lock(&mm->mmap_lock);
> 
>   *** DEADLOCK ***
> 
> 1 lock held by syz-executor307/3029:
>   #0: ffff0000c958a608 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock fs/btrfs/locking.c:134 [inline]
>   #0: ffff0000c958a608 (btrfs-root-00){++++}-{3:3}, at: btrfs_tree_read_lock fs/btrfs/locking.c:140 [inline]
>   #0: ffff0000c958a608 (btrfs-root-00){++++}-{3:3}, at: btrfs_read_lock_root_node+0x13c/0x1c0 fs/btrfs/locking.c:279
> 
> stack backtrace:
> CPU: 0 PID: 3029 Comm: syz-executor307 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
> Call trace:
>   dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
>   show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
>   dump_stack+0x1c/0x58 lib/dump_stack.c:113
>   print_circular_bug+0x2c4/0x2c8 kernel/locking/lockdep.c:2053
>   check_noncircular+0x14c/0x154 kernel/locking/lockdep.c:2175
>   check_prev_add kernel/locking/lockdep.c:3095 [inline]
>   check_prevs_add kernel/locking/lockdep.c:3214 [inline]
>   validate_chain kernel/locking/lockdep.c:3829 [inline]
>   __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
>   lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
>   __might_fault+0x7c/0xb4 mm/memory.c:5577
>   _copy_to_user include/linux/uaccess.h:134 [inline]
>   copy_to_user include/linux/uaccess.h:160 [inline]
>   btrfs_ioctl_get_subvol_rootref+0x3a8/0x4bc fs/btrfs/ioctl.c:3203
>   btrfs_ioctl+0xa08/0xa64 fs/btrfs/ioctl.c:5556
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:870 [inline]
>   __se_sys_ioctl fs/ioctl.c:856 [inline]
>   __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
>   __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>   invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
>   el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
>   do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
>   el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
>   el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
>   el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
> 
> We do generally the right thing here, copying the references into a
> temporary buffer, however we are still holding the path when we do
> copy_to_user from the temporary buffer.  Fix this by free'ing the path
> before we copy to user space.
> 
> Reported-by: syzbot+4ef9e52e464c6ff47d9d@syzkaller.appspotmail.com
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/ioctl.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 9c1cb5113178..306524554117 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2303,6 +2303,8 @@ static int btrfs_ioctl_get_subvol_rootref(struct btrfs_root *root,
>   	}
>   
>   out:
> +	btrfs_free_path(path);
> +
>   	if (!ret || ret == -EOVERFLOW) {
>   		rootrefs->num_items = found;
>   		/* update min_treeid for next search */
> @@ -2314,7 +2316,6 @@ static int btrfs_ioctl_get_subvol_rootref(struct btrfs_root *root,
>   	}
>   
>   	kfree(rootrefs);
> -	btrfs_free_path(path);
>   
>   	return ret;
>   }


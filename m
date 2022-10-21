Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0641E60709C
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 08:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJUG6U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Oct 2022 02:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJUG6R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Oct 2022 02:58:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FFA244708
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 23:58:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L5OjNO004666;
        Fri, 21 Oct 2022 06:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=x7nzwt15ZoNmT/CgRUcXStnPl9tEoRBOCtMAuHIcTfw=;
 b=pMlBESwUgIJhbB3qy3vcuRpuWZruDnG5jth6SsI0GbaBwnJsUyHhUA0BFtn1y3fchT3f
 iysuFqeh43ej3uJKadYkRc01kijutSNfQi068ufs6POoVaUTU/AuxikPTCZqKCVjeZHZ
 qYqemrBQrh0rtChwHSUk5uXqXwDZb2U2Ar/TWD/g0jVq2OnMy2BJ4jwK6s0Z2MApW/3d
 WcWhEOYgsijlx5RQjq3Bgg8++mGN02BVXCGSaNAB3rw/WFMA82jwG86awpDvJHqj+dn4
 fYVQlSTSbd5+d6F7q5VwHUTGVTah1iLVnw23PlCjJQwCaMbLWLKlruuTfeGjhi92UHYP 5Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99ntkk49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 06:58:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29L5Epg9007144;
        Fri, 21 Oct 2022 06:58:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hrdjtvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 06:58:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgPy5MgJVQyqNGGB3ZEBUUnYdWr9Q7WCBIeSmcD5+4hJzZnIPc8yQyrwURp1tEIUJzQU2MYDlN+ysduWbSpOeoOUXtt7Llx4UT2Cq+WWAznZVZSv49CENgZ8WTb9i2eO6t1Cndc48P5A+0RwcKFJkhCy8K6WwduAt49Zoa08qZ+SgpUbZ/jozVjKzO9jMxTun3OFMtVevJmJC8vGfiJV7gFXuP9Is39Q2dztgBbXiUQ2Jl2GMkLLoyRbbGHQouU2mF4cUYZiMXHu4X5Qb8jL8hsRspKyAnZA1K3OOJ+FfviHynHGmsNxdbeclpDvviCguMjgcRlpiTeiYGIMY1JNaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7nzwt15ZoNmT/CgRUcXStnPl9tEoRBOCtMAuHIcTfw=;
 b=BrUqzKmFyHvKimRwmfPhHPWLcAmZ1ZJkHmlulxDYQfQygT1kcMDYrtHU2v67373QeIpAMo9YaHoNeQFzelGuqv0YPE3L8UiRL2lrfKRhN9avU2ao8ICV52Stz9kHzjE9a/lc9V/IqIA+1JuLjErmLd+RvcxKumAm+v3OdnDRUwvfkAhLejL2ccdV+18f5P4Cl1dbz/QdPv57vCW6YjC4x4G09Ha5+gLquq+sC9WSoHOXj9Vk7hD7TiKxTBFu30/iSdvx+VM7NR2EfWWn9gld1Yubs39kksXJaTPUq1grUDYLydaL8pzE5NCQ6aX0qguvR1ygkW5jNN712+Lt0rWg2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7nzwt15ZoNmT/CgRUcXStnPl9tEoRBOCtMAuHIcTfw=;
 b=Vcmg68bHF+iDPQ621iCnAiXJoNHqsymkX0+24DHVWv+XAGxho9kZF5DnvasLWbwQ22a3u0aIdg2gMbJnEab9JR1xnA5DX1JA8O2ruH64aNoyv+TCd0LNjZu7clAoALGAYSrrIOomGP+uYkaectZbcoIdu34h3qzMLw6PKM9DHd0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5263.namprd10.prod.outlook.com (2603:10b6:5:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 06:58:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 06:58:08 +0000
Message-ID: <9fc964da-f5d3-1ab4-fa82-3b411dcb73e8@oracle.com>
Date:   Fri, 21 Oct 2022 14:57:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 08/15] btrfs: move fs_info->flags enum to fs.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
 <dd6a84746e98212744297de1f72ca634c51419e7.1666190849.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <dd6a84746e98212744297de1f72ca634c51419e7.1666190849.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5263:EE_
X-MS-Office365-Filtering-Correlation-Id: 071c2f0f-8fc4-43bf-aa54-08dab3319bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1UV90/SNgLWxincaIECS1L8QxwScG919FaSdiU8xwvrt9u/Eqj3opTiifFLoLS5LZRioem0Ak2xeCwegL4oIMo5xyHUiqn7PCJhPEB7jtTnVNo3WtHQb3oHqr6sB2tJKEr2Q4CfPvqsTHRPZNdFIii+J2jssznbadiFdGVFjPGtHAgeMDDBOrq3eWnCSVu7SRR/lj8Zq5n/Ei1cLyNFntDWaA447SCQ/BXwT+yeQI4tLl3Epw7e0Pfn+Q/qkRbiAiFIHZzjLiZ6V2D+ImiyOOwLhONFmwpsF9SYLQLpWzccIDrijL8k3khHgh3Ef7v31BCuBAe39yMu+fkNpQFUGBRDqiyPkq/pAv6iWwbkUK6ZE1HoGtNuB8M9vOxvPlbA1nZgWZFwBbNgnFEFSzzXOp4LZMSNLeNhLhd3UZKQfN65g6BOeXWm/nItOjFVr0TYqBAak2cv9q04cy1DwIG5In5LQiedDR8zVNj2BABPP+EJ5ao5XpCn+ItshN5LevW/Dpfs0Xqm7OaLhrj2jsF604ClIMmv6HGLAvZRfxHMfJvvObLZuDfHWAORvpBzrfx3T33EE5ketDNIwR7AVi9d31RpvOJU+ccwwxcz08iQ6Nsz25y+7KHUE3xtgzqcxM4b5np9oI2CsWgRtNn6FTyAT47+gxggCJmCEc6bCJ9IQoFl5QEVa7FrcU5v3zuG/1J/av9gIuoTfr0an6dBaBCGr5IzgXJ6oWeppFj8fAHdFpCYAkwoVFkob5J42ccDUCTOE81zvzxMk+gugNwdGI3m6zCopWNjO2Iuanx8eMwJqqH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199015)(6506007)(478600001)(4326008)(41300700001)(6666004)(66556008)(5660300002)(66946007)(316002)(66476007)(44832011)(8676002)(4744005)(6486002)(2906002)(26005)(6512007)(53546011)(2616005)(86362001)(31696002)(186003)(8936002)(31686004)(36756003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djh4VGlyUHhoYzRLMFpUVFh3c3NPR3grUnBCenBYSVBxbjlQUitZc1VTVi9C?=
 =?utf-8?B?b0dNaE1xYThycjh5a1BRSmxVRTlMM0dlU3VYeUlkdFVOM0hVT25sb2phek9G?=
 =?utf-8?B?MlU2V0NEL2ZSazFIc3ZUdWFta05lYWRGL3VyZVozNlo5bFczMmRGNE91RWN6?=
 =?utf-8?B?VytVdWtBNnQrbXFTVUlaZEdrTnpWZnpIcThWN3BhRmJpWTdzZjRBUktoSVpa?=
 =?utf-8?B?dUN6ejlQMWlyZTNSY09ValdUcUVMdTYvcUJ5b2pJVlFRSHhUL1cyNkIvU0ha?=
 =?utf-8?B?ZC9UQnFDWi9XN290NitqS01GQ0hwUytqNWxLcVFtTnhhMmF4ZnlDNnIrOEkx?=
 =?utf-8?B?bkFJRVllMndJOEJtYUhKTmF5VXMyYm1TN1NJZWRPbDJVY3JpSDBhWHRyWlNP?=
 =?utf-8?B?UGxLbnQ3dzgxdmVGcFZKL1NQeU9wRXc0bm5HRVhOMklROUtEZGlVUGp6RTAy?=
 =?utf-8?B?OERDVGhEcWRoSUlpL2ovTllMWGNobUI3aldSN2RlTWZxR3RqejV5V0w4K0FT?=
 =?utf-8?B?UFcza2MwamdmeGo0MFUrcVpiSDEvT0ZuN0NwTG5HMUl1bkNrbHR1clI4UEtW?=
 =?utf-8?B?NFBqODhiUzRpZVh3QWJNY3dwcEkwVnFMandkdGdkdDM4NVpPZ211OEtHbFhn?=
 =?utf-8?B?bVZaS3NnR2FLZmFaTDNhVGgzaThnS25aWVZGUUw0aWhjU09RRTB4a1ozWHpC?=
 =?utf-8?B?ZnRsYndOYy9JamZtcXNuL3EzOEZkMFBvZFZYRGpGek4zazN2MGhIQzFiWEZR?=
 =?utf-8?B?VDU3V2tHc1M4RUNYUisxMU5ZS1ZHN3h6RDYvQVluQXVXUzlXTUJ4amZ4VExj?=
 =?utf-8?B?L3VyVDJFMFZxMjVLZUE1THkxSkpEQzhxMUNXOXBPL2pSZjExcVZXRTNHZmFY?=
 =?utf-8?B?ejdyQ1o1QW1lYjBFWDhDcUQzZW5vSnFYN0w4V0RoZ2Z6Yk16YnAyRHRrQy9m?=
 =?utf-8?B?Y3FkRlE3ZkxWQ0VWOHAySlJsTEhXRHlEVGs1cGEvRmFjaDhzZWJ6L1dHcEJr?=
 =?utf-8?B?aVlFUUhQcDhJZnRsYnZQd0tuNTF6dktheDBveEJDYVdlS00vTU4yRU1WU1ZT?=
 =?utf-8?B?VHp3QVRwYitrQXZKa2J0NzFXb2pqdEZCSHhFc3NOSkpnZ25nVlQxODZFNGM5?=
 =?utf-8?B?Zmk5bE5Ma3VublloQmx4QWZaUCtSSUo4c2pNRDVoYm9PWHdDVWIwMFpWNXcv?=
 =?utf-8?B?ajJCYVd0Q0FTaTVqTUg1RU9XRlZJN0tJa0l3Tjl3V2x0SWZiRHBhS0p2K1Iy?=
 =?utf-8?B?Q1NRN2oxMTAzZmJnQnFDZlpibVZuZHJWdXNSU3paNkw2WGo4eVdhOHZsSUNB?=
 =?utf-8?B?dW5SR3NwS3A3RnQ3Y1lzZWNBL2UxWnZrOERYVm8reDVIOHFVQndZSVA1WG5u?=
 =?utf-8?B?RHJpVWphb2ZIMEJJS2tuMVpQN2hGV1BieDZTSEZ5WXpMSkw4VTJqVDlINi9V?=
 =?utf-8?B?TVdGVHpLeG9zNHU4QzVSMG5KK0o0ZVdGbStBRFJTMjdteFd5cU5RZmxXWk1n?=
 =?utf-8?B?KzV3LzRpV1AzMm5OVkh6RmwzT0EwbGRFQ1hndmR5bnNQclVBT3E3NTZObzgv?=
 =?utf-8?B?bUpIZHY4L3pLYndRMEpCV0h5R3ZmOFAxQjBBdEUwOTNuSGowVS9HRFU2K3FF?=
 =?utf-8?B?U2svOEF4Z3ByTmluZ0NpVlFwekI5K2RPS21OdTUyNGtwWDZnT05MSUxISmkx?=
 =?utf-8?B?QTJ2c08rZFRnU0RwOUNiSXcxanF2WnZYQnh3Q2FtMlVKaDZhZk96QnZTbkNu?=
 =?utf-8?B?S09hMTRQdXA4OG5nemlwOTZ5U0k3NzlhdVlOUHVzVDVsS3B4ODBNWXZ0bC9H?=
 =?utf-8?B?eHRZNGRUTWZMVGRNL0tmSldEVVBTMExmKzl2a2NRbElTRDNCZHNvbTNxU1ov?=
 =?utf-8?B?YTlRMUtRYncvS3dXa2dGOHp4WnhUYWRRaXRzaitKTk13M3dEMHpydTFGK3V3?=
 =?utf-8?B?ZG1XZVVMR014MEtNeUlyV29Zcm9pS2ZJUHE3dXNDaDhHZVVUaTIyZzZxdmhm?=
 =?utf-8?B?bEMrKzRTUkN3akppU3p1UDVtWjRYd054YTFDTy9YOVRZVWRRSDZYY0pUYWU2?=
 =?utf-8?B?NHh5SHJZYkR6eDltamtrbVBzRmxUbUw5YldiY0dNUFA4QXU2UTR2S0tEN0ZD?=
 =?utf-8?Q?hqGZ9ox2zlmhn3gDl/X9cgOag?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071c2f0f-8fc4-43bf-aa54-08dab3319bd2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 06:58:07.9296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6gvs6Ar/7S7C8C4d8TDaK5O8WwN6dPoy7ZdJuRT1YaE+YO9UatMLQXqZtXn3PM114Z8O87bAKs5gUEKXmwXoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5263
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_01,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210041
X-Proofpoint-ORIG-GUID: cyBBnW6kdjQHds68um-5C4Kn5V5HQcYa
X-Proofpoint-GUID: cyBBnW6kdjQHds68um-5C4Kn5V5HQcYa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/10/2022 22:50, Josef Bacik wrote:
> These definitions are fs wide, take them out of ctree.h and put them in
> fs.h.
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


Same as v1. Except missing RB.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E665B9995
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 13:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiIOL3T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 07:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiIOL3Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 07:29:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1B78A7F6
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 04:29:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FB1r5Z009352;
        Thu, 15 Sep 2022 11:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=S/vQOMOVv/z+LAlMHrCYFJakkB21xeQZUu6b1KRZt+4=;
 b=hQND83v1ebZ32hRDrKiaKalOnge8bMNv261Nb3J5dhLydi9tedJWvckkn+DVdU2E3YG8
 31v5hnSaLmeFDS+WIg8YyuwKHpq8h2y6vIYwnhkxEWECLcStk+G3H3TmhGy/b2BqJY9a
 oa2r4Ehaw4CP5vKj8QNTwyXIuKP60+cvHn7ReYhbIkRwMhBIPwxkPHmjlNFkw/YsD243
 nJXzmiF4NHuXv5TAYlHSzzl/Pm2VU7EMIqNUqMybFq5+dM908Np+4QGGVHe7XAXGWloD
 3lwWhAN/Sujqo8UciG2gMQ2+xgxqdzhOuWCpLn6cCYkgamQAWzB6KV42cWrWwnQ4YWNG bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxydvy1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 11:29:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28FB30DO001175;
        Thu, 15 Sep 2022 11:29:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjy2cbptm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 11:29:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dly4GAPjepotbWJ7yj9jeZgEpqUnNt6C24kaespbo71KtAwt/l7humhbs1mwPPwnHDWBtS8VE3koun3+VGdp5w3uMw/h/ZQ3Cv9kXJCWCx9/Nf8GVvYLF8OOwYgyutjXsZxKvLvGvePhQIYQPJUFQwKOmHVxjv1hW5mqkTcMefuyVBT6bjAzr4+JQQz00rOKKQrroeLMvVLRVbWTTEO07kjhMp22MJ0qdsubAoCLnUjo+kgPLIoh5uNO4ySPVb/HL0iZJI/LRywUdRD2ZwE2o8MX0Y3UECI2VUIqPSdEcvNk89/p0crm58f7XAniPgDns11Om8lDqucA7bPQ4mFIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/vQOMOVv/z+LAlMHrCYFJakkB21xeQZUu6b1KRZt+4=;
 b=m7NranTaw+U597gFmYhw6HtRwaoLQL7nlf+Q/AFKYBR3WJKA7VnjSR/ke7CpHSj5ILi04WUS1ezoyGur19BZpdU3lokqVYEX2nWH/lvHUnvxMn1F+k24lX5h00qWUz6HKdR4NU10iD8x0g96YP81yTYcZfJbe2qC5yb3uVHdKci648HVP0LLpN943eFQqTMsl6qZ+Rm0yWIHtSgH52TvWyuJdDUM6Ug6d01NvKziSp1fyfP4hizMt0NMFNCAeKxnVhNq1Syf/+K3w3/dMxOe9yTEMLhrc8onOBsm6ImN4gFPdK7K+49U8nD1uqmDYhM7Tu+6pG7uXNVzCMLqFUrudA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/vQOMOVv/z+LAlMHrCYFJakkB21xeQZUu6b1KRZt+4=;
 b=GfT/aARmvIMGpW3F6yI5bCnNMK3oB8rndkr7BrUhr5Ksuy12qndcjrIXSN0vtSge37kxxwKHlW8dn41JViYxhrSNLl6fjtuPBJjjZnwI/v5pCdNvcjvnN8n1dZ8Ho8l2BEv+WK0kNSTa7k20457qv08VDn4oX7x3fyujJ50RhnU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6625.namprd10.prod.outlook.com (2603:10b6:510:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 11:29:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 11:29:10 +0000
Message-ID: <aa819abc-4e81-6ac5-e5cb-c8fabf15178e@oracle.com>
Date:   Thu, 15 Sep 2022 19:29:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 11/15] btrfs: move btrfs_ordered_sum_size into file-item.c
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663196541.git.josef@toxicpanda.com>
 <7d20c1fad6d774c24413fd43af0c204b53adb814.1663196541.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <7d20c1fad6d774c24413fd43af0c204b53adb814.1663196541.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f7574d-cc59-405f-bfc6-08da970d81ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gCCavbGLqh7Ns0P0eapOfsegK38RmiHuQuFI6MWVLJ+FY1HBtMMpIC6Mykcz4yp1rC1ajNbo/hkEJD44El7IBR3p0lkeDV75Bj2hFmXIaI9rzDjyyTHlx+HLRqNl2keGWQqzEQonfzZBUnPGver2Y8xWbqiOrUxexGVvB9YOD5cK7y1sNqGORPLNYXQnr2dKgU2H369JqMzoIjNeMMCRTCqyjVMmMokfKAT73hFsdupGdLUBcbTdXuSUY88IbGWF0wFAgoAk6L7AbtkEfGsBcgsAWZMF5fc+NdTbNfWyujIuiVIeUBZ7gnH6InLTo086nrmPKV3ShXVjPL0TtTd+RFCa4KiZuedgCgt/K+OGtbTVg+EYEIvUo6CULey6TQooM5Z+2uXeWE2+aO6UBrneQP5BXhQPqiRVOQ5qkbCVjgZcRF2Pz17g94AEOUkpymewXbKx4XEe+gAkVnl7mlu/CXuYqoKRassM8mGy3FmsdIFffIl7eOVNLtYt+MgCm6rMdRs3VklWTgU7Tmj9pxYYKI/gsNfCIwZJPK8ntfTENokbH9fUg2SQkgpe6fTTCJQbQalIzQ7VIwFn4MsHw4au5nll4XofEy8bdmmsyvDyVNDjzdqj5MYPULF128eC9wHQneVUS7ZvmwYJ6+9+Hh96Mu/IF+e0cZToi8wjx91Nc5rVK52Rio/5G3FpoX6pow2S/OxRkULwa6Vwu7Xc9gUAf2WS5RWD9Jn7s3mCdHpwrZ27MNp2H1X6amIgYOA2+OT4Kjgl2CPGJakZoArY3znSSY8vm+buzD0E9IRfztRO5B4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199015)(8676002)(2616005)(86362001)(186003)(44832011)(6486002)(5660300002)(83380400001)(6506007)(38100700002)(53546011)(8936002)(6512007)(66556008)(31696002)(26005)(66946007)(558084003)(66476007)(41300700001)(6666004)(478600001)(36756003)(316002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU5PcURvV1NXRTJROHRSNStCT0M0cGFidExIUkZURDFtdHhqZWlBT1daa2N3?=
 =?utf-8?B?Qy92VUVhck5OVldiUTJId0s5Z3N4ZHowbVBheEY5V056NURabXlZWEVwTW1q?=
 =?utf-8?B?T0gvd3E2R3A4NDBRME5NbWVPL1NCeEh6d3RlYmJqTlZRTHdpSzlCU29pUTlm?=
 =?utf-8?B?eUxLNWVxU1QxQ3JTb0I4K1J2ZjZpa0llalJiZHdwa0ljSld2bUVGbTFSdVFt?=
 =?utf-8?B?a2htY25KWm9WeHV0aTVSUCtBZG5QNlhWbUkvYk1JbFUyZ1ZLNEJGVmtzbGov?=
 =?utf-8?B?T0pLYnJiVlVZM203T04rakYvVklJaWlhNDdZU1ZHS1M4T0tKT04vYWRxbksz?=
 =?utf-8?B?cmhwSEJRc3hQWEtCWjZSS3VXQzhJT1pJcjMzb1BBa05qTzJFTGoyS3oyLy9y?=
 =?utf-8?B?Z3k0VGJmdThyTDhXYlBNUTJTcjNSaXJwcFZraFFCRGJnaGdXZ1JrNUgyNkNq?=
 =?utf-8?B?aFI0Z29lRDUyOXZrMGNXRm4rZjk3U1QzdmYrbXZyWjdhK216VGdGWTB2YnB2?=
 =?utf-8?B?R3pFUHZQOWVheU9rTFZKckhlbVlVdERTQU55Zld4MEx2ckg4NTRlZGoya1Zh?=
 =?utf-8?B?M21JYkZOL1JWRlhpclVNV3pKN0lzSE5rZVV4WE1UNm9qaTFPR21ZU0dEaGw2?=
 =?utf-8?B?Qzd2Q3BaNXkvaHVyQmMyV0VIdmw4UWZqbVhPWDc2WHk5aCtSeGIwKzdidlZh?=
 =?utf-8?B?WkM1d0F0c2pMTDZIZFZvQndOWXpvMlllaEwySHRMS3NnL2lEcVFUMWxhbGRk?=
 =?utf-8?B?Z0FiNzlWOUJGR3BRM1VyOE52bFptNlhwc3lZa3RQZzhhL1ZvTHZUSUwwdEFE?=
 =?utf-8?B?OVR3azFUK0ZnVGdueEtvYTdKYXhmZDJyTS9yWDZtUnFrYmc3UHVaQ08ycjNB?=
 =?utf-8?B?U0ZhN2t0bnFkbnVWMnExQjFaTUs0c2ZvR2pCakI2OUgxaHIybHFQZHdOMCty?=
 =?utf-8?B?dlpsWlNyODhhejRLbktTWXI1T1FTdFZZSlBLRVVoMnRlK0U0UjBLWlBQejYr?=
 =?utf-8?B?S0pjc294OU51SGJEQ0JqSFFhRXdEb1Z3WGNCdytNWTVNS2VaMk9PcVhjRGN4?=
 =?utf-8?B?QmI0dUpMUktGQjNIaE5GYVBDZDFuaGNKR3NpWHNKZWNPZ3VMak9sYjhrV215?=
 =?utf-8?B?Z3FUd3BNVHVZUEZ2UUZqRUNZM3oyUmhiS1NnTWlTZjNGNVRBTkNzcHUxcHIw?=
 =?utf-8?B?ait1bzRrM3g2azI4T1lXTGI1TTFpNmZOekxPZVltMVNvQ1dGRnc5L3M4a1V3?=
 =?utf-8?B?ZEhrZHlUQXFEWDQzQzY0WHgvYmZtUjlhV2M3blNmaFhxMkpRTWZrRDRHNjZM?=
 =?utf-8?B?aEszSzNxYk5UTW16REZPN1d1Y2Z0OTlvcWgvWStpM1FrQVNrUXF1WEduMlhT?=
 =?utf-8?B?ZEY3blZyR1lNcitzeXNKazBzRkFGSUtyQlN6bkdSZTVCOWRSaFQ5TGdXNVdu?=
 =?utf-8?B?b0dLN3dZUk5TQmRBYTdxVHZFM2hiZUhGY3FIOUJ6RDNvaysvaW1VckJidWVU?=
 =?utf-8?B?OXlMSkFDeExpekhGc2VrUHZCTkN4UUtIY3J0a05pVjdWUjlJQzdIM3hvMGZa?=
 =?utf-8?B?UlY4VDhHVE5UQnd5YUVOMTQvWU9ZN1NqM1ArZ3RldGd0NTlzRjkrVHMzdFF2?=
 =?utf-8?B?SEgvS1FReVU1aEh2aHE4bTN5Z2cwWHdFMlJrc0RGcUpSWFo1YTdMbm95aEd1?=
 =?utf-8?B?eEdsQUpUQVE5bjFCQU14bGZWMVNvWlBNRHduZ2ZGZkRUY3ZLVWhjU2tmWU9i?=
 =?utf-8?B?c3NrMjlKUU1zRjBnV2dBc3RJS1Y1NGQ3M25vTEtnVzhKamRwK3VFZWJYRU1D?=
 =?utf-8?B?RmZEYkx0Q09EMzVENmhJVVVlajc5NUZqU3UxR0F5bzRFSEdBVmRETFU1N3Vi?=
 =?utf-8?B?cUNpUDB6cDA3cENtbmtYOUdMVzE0aTVoL0xGVHVFMzBWYitXVmtvN3pSUDVx?=
 =?utf-8?B?MFdXa0Z5ZURlcWt5ZUhnNVZoaEE3MGdBcmI3c2xlYTY1SEVtd3FJak1oMXVZ?=
 =?utf-8?B?NkRlNEV6NGhtdmVpMDB1Z1hYMXdVVkhmQk11YnRRajdidTVmNm5BWWtIeWdG?=
 =?utf-8?B?Y1ZRSXBSSjR3S21LUTVkWFVIZ2laN2FrNVUvS1pmMEE1emNUbHRYRjB3aWRH?=
 =?utf-8?B?aU5oMWc3eG5hN2cyVWFCcS81UmNOc0NXV3JBNDgrSjlNSEdRRXNGTGZSOHdB?=
 =?utf-8?B?Znc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f7574d-cc59-405f-bfc6-08da970d81ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 11:29:09.9812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVE1uh2FLThmTkAIU6J+lfej/k/oi7zZchBpZhpvR6eDtrfXTKO0eWGhpL3ixq5nlwK2kDwJZEG0fuomD+Ixsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150064
X-Proofpoint-ORIG-GUID: VwzRcduw3NSChcG88W-ZbSBbg_SRl96I
X-Proofpoint-GUID: VwzRcduw3NSChcG88W-ZbSBbg_SRl96I
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2022 07:04, Josef Bacik wrote:
> This is defined in ordered-data.h, but is only used in file-item.c.
> Move this to file-item.c as it doesn't need to be global.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

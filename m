Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34A75F8521
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Oct 2022 13:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJHLwc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Oct 2022 07:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJHLwa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 8 Oct 2022 07:52:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB223419AE
        for <linux-btrfs@vger.kernel.org>; Sat,  8 Oct 2022 04:52:29 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2989332m008519;
        Sat, 8 Oct 2022 11:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=w2tHiMFwPmDvhFSCuSemhfXETSeZk3AToUZ/yiSpA70=;
 b=0SgXDTAKPjx3p8FZSqtWtw7aH0cy7eXEHuNVO6kqEMaUzgK8lPJRG4ykVZzwvGV2EYzB
 kRccyLjFcnYM24yO1+t0AYA8mTUbVqmx1LvNtNKt0TSVJtbNnSt/MLoV+XlslwLpw2/A
 r45SE2M3YdLovrGk0Lz0ibwAPIfUSJK7bvQ/JIjc+mKkxgZlM9C6P5utcrLnFmidd2o8
 4cCWRd6PC3pESEtdHJX8EwpMSGmImgwRPLvknlVQkIl36pzu9BxITEOTA6NcG46Lp6V4
 tCL/U7GI/HyyR+LcNOJtARZyYVUIS0I8pJQHrYlce9sPLAcw/D3FhPvq9SRSe6oBcOrb dg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k2ymcrgf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Oct 2022 11:52:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2988Fqwb039140;
        Sat, 8 Oct 2022 11:52:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn1faf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Oct 2022 11:52:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHUYfJf+6WCPGh9g9QC3cg4fyRV/OjPqhEK+A91g9/gbgExCxqcAUcJLWVUSHzaXLnXLQIJMnT673/wvdftVqkYnkoZHnuV6epLEBTr8YReFaazQhewdK1pOaC4xlOylop6IDtykAnX/eFIUz/MpimlhiSms3NV+6gPZVNCNU6lyMjBN6DnTP3yHhnOgYnlJqo3ssJMDjTNGhZe/asJnQbpsOIySnZXjejcXW8U87cPagKHB5FZ8bpHynrDr29B2ZDHZYRKBHSetjFmFlT09Inz8Rx9oQRKfFkSgffDkNlARP/ehhwkx49hkp5QDjeTLLU2K8owl1vmGDXCkcemG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2tHiMFwPmDvhFSCuSemhfXETSeZk3AToUZ/yiSpA70=;
 b=Wn/q/677UdIB0QypfExV/JwrzM/wRN2FVp1iklzP/t8Zz2VSiF3wGkLn5uP0FUn7Nqf6GiYuuYRDcJsCz3XPng/guvBdV2byG0hv2JWnYrmXEr5KZLCcTjlkvNBILWDc9ShA9DOrypJX4c7b0yO6LjHIRXCc7SZJ58eupC9FM+cwMHNQcyZ3etaNv0R1fPDGze7KAC37q+qIhWuafs4c4VAmgjuohUM/k9Ypw8Z5Hr1wqjtsRRa6mtZOxoVIHUZFV0C+z+6aFwPSA1LrnYfCklDLTXs7n6l9KXho26dCYazst+f8EXKGdbpARrYIr7Ycb/lVDuP1ktc/ZnaHXMbnTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2tHiMFwPmDvhFSCuSemhfXETSeZk3AToUZ/yiSpA70=;
 b=TrEAwEdD0BY4R0GDsToD5lxqBWXa5oN3kXUWwdMr9/pI0AN62bmG+V2PxWgcESFmqmQ+o18lxAKmDLfhglsDu7OkoayHTg5WRAa20BLAOEd0AySsaXGsI/D3Q48lrJMl+fgbNZzNLhaGJhPrCgbp5CpqPLF0HOZZx6m2XM6Si4M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ1PR10MB5955.namprd10.prod.outlook.com (2603:10b6:a03:48a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sat, 8 Oct
 2022 11:52:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2515:220f:4d94:63a7]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2515:220f:4d94:63a7%6]) with mapi id 15.20.5709.015; Sat, 8 Oct 2022
 11:52:23 +0000
Message-ID: <900811cf-1d80-f890-a70c-4c0537f48aa5@oracle.com>
Date:   Sat, 8 Oct 2022 19:52:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 2/2] btrfs-progs: mkfs: fix a stack over-flow when
 features string are too long
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1665143843.git.wqu@suse.com>
 <d6a5f3dd13a8f2b4d0b1e2e4e20c4ff28e055346.1665143843.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <d6a5f3dd13a8f2b4d0b1e2e4e20c4ff28e055346.1665143843.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0094.apcprd02.prod.outlook.com
 (2603:1096:4:90::34) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ1PR10MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: 592543b6-d260-44ca-0f65-08daa9239025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QUKv1Df4im4h0o375/4yZ9ZBFHYqeTZP/k6K2pFThLlcXosnRFG73/6rxDKWz/T5VoT0xICDwgENlRbm8NbAT37IP5YUk5/5Eqp0POlz05s2xiydCKasMT6hBiTFModMj3SOwILydaevnx/U458/DtvmenfYRJvPV5yW/tTs8Z+tWc2KnLMRsTr6cAYMp73qd37aLNyzFVTpWiq9Ly1NIT/gNfZ0wzs0/m1abPteZTygoyjAUiSa0UC4Iyz1j837vfLRHfVIRF8TpoCA0mQhWhCFF2B5lu+l/bexh0NWX4EJkerKHJHqScbUk5Kr4YL68l/TgkOfviZoVlMTuyU3UtMUl++6jL3IjrEB4R5pqnWRTG5j4IDOgbjz4SLEmWDt2Pguwtc5/hzeycgTNper/npQ096L+GWndT8YbttbZ3tWCSl7BQdphNM/KMaSQyCHVrMwxDTxhsatVk5YhCX89jfEnQ9j6Rmt5tphU/rJDib2wdY/Y7zblKtFtWqZjnSo8IkODCw4sQa0Kv4oAkiailwECWYwftUlqU7PsgaUwIrWyWkcPJawQyuTXf7ZjW6O9TipnN5GMMPkYMS7SC5iDRED5Rf9nOmQUNBCYDqc2bLN6jeyQUDwCgDUNO/1BhZBFomqDZUyRQmrql2QQoSxwyGjlj+Xi4RnkQc6ezsiTqHxQWX0dcMXxgrENvehEks5bhXa5tfBq2v6XWtlpMW3nU2QpVJGUaz6o+VWqNB5jzaLRv1LO6pdesMhvCbs/9ZoEcegfj/doMXKbw5CDI9f3pZ5LfOyo5mmxh5u0a9XM5/j3l0A5qTNAtSiLn3dlpj7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199015)(83380400001)(2906002)(84970400001)(186003)(2616005)(86362001)(31696002)(36756003)(38100700002)(478600001)(316002)(31686004)(8936002)(26005)(6512007)(53546011)(44832011)(5660300002)(966005)(6486002)(6666004)(66476007)(66946007)(66556008)(8676002)(41300700001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVlEQ1VWNTJnRUFSa1RkZmVYU3hYcDJOQVViTVFlZ1FuekN0NDRwQ082SG1X?=
 =?utf-8?B?OTMrY0dxbE94UlR1UHhTMnViUkE5QUNOUzFSTnRzNmkwYnVCVXd5SFJ6YnNV?=
 =?utf-8?B?SXdMQVVrZUlNWkVLZFhKL3lzRXVzY0ZVV1ZSMHI4WWl1YXZxZ3lycnB6emxy?=
 =?utf-8?B?U2JsekZ4UjY4czB0Y0ZDNXpBSjNKcXYwNmpvMzVMVldFR3owYm5ETkZuTVl1?=
 =?utf-8?B?OUp5RVJqcVZOT1o5akQ5eHdzOURkaGxuYm51VHJodW5PbU5hRDRSdTQ0OHF6?=
 =?utf-8?B?eGp4YlZGYm4wdDd1Y2xlR0V2NG5EZDRHTG5nU1JXVUlTYU85NVppc3ZKbzFZ?=
 =?utf-8?B?Y01ha1p3VEs4V2FGcXZKbExYeEM0NHhpUmhYNHYwbDZmTitWQlFGY1Npelo4?=
 =?utf-8?B?dHk2RTM2U29zdDdMcUY1WEhvNmFmU0ZPZFkxVDF0M0dMcGhGa2N6eVA1Rzkw?=
 =?utf-8?B?SE9NNWJUdll3YVBWNXJRNUFKclZCUXN3a3BYY3NqWExMUHFVMnpHeXdzNXNs?=
 =?utf-8?B?ckZyQkpBYkZQNk1wTlc2cko0S3hTNjVXWm9sckdTV2pLRVY5bWtHSDA2OXJN?=
 =?utf-8?B?ZzBwdmlocFg2QllCSEtrZWFrRm8xREJOSzJjUUtwQ1ZzVWdDUk5GalA3T0lF?=
 =?utf-8?B?bHJLUjlRTERaZXRoMUhSRmFEQ1Q1UTZoRWhuRG1sU2VTMXljUmoxSEVpOUZi?=
 =?utf-8?B?TFA0c1VIZUU2MUM0SEY1NnE4WFB6WVRzZ2NlUXhzMm9PdE44dDZxalZtbUN0?=
 =?utf-8?B?QXIrSm9BWjhHWm5NcHkwL0JXemFmS3NGWDIzL0t0bGNpdVRHTTlnOG9ySEQz?=
 =?utf-8?B?S2VONkoyNmlVcXdFdUR1OXEwV0pmaG8vUXRlS1hiUktIdVZ5eGR5eElGOVZC?=
 =?utf-8?B?ZW4xWS9qdE9KUENvSWhqTnR0QXlhbFY2c0Q4NnB2T0dvdVhrWmxmVExySDRC?=
 =?utf-8?B?Mjdpakl2Qjl0K2xBdGpCdDcyTmg3YndNK2kyUkRja1FpM25XL29uRkNZeVRZ?=
 =?utf-8?B?amdpZktSUnFEdXhyVzFiMStSdHNOSWFkMUpMOE9yam5ZcE56S2NlbmpSMHBT?=
 =?utf-8?B?azk2MURWU3F1ZTAyYUZSd3pCNzZkWUpLbVVpL2RmcTFaQ3VmOVNFdVdoLzNv?=
 =?utf-8?B?TGJvTkxXR0NaU1BUMW1QZkU0dWx5Wk54b25tQklhQjkvdjl0R1lkYXlVVWdS?=
 =?utf-8?B?aXBzbncxOWtiWnJPZm4rSnYzVjJtdDRRaURrek1WUjZFVGlHdE85bnl6VUpI?=
 =?utf-8?B?N0ovYTJtZnI2ZHNTMkQ4SXVlZVNuVjBTNm53ZDMreTc1eTQwSjgwWFFFUG90?=
 =?utf-8?B?ZkRzWlZzcTRHQ0hwdXJ0aXFpbHhCMmdsODNHOVFrT2JjRXgzbktBdUlpbmlH?=
 =?utf-8?B?blI0RHFoTE91NTFqNFlHVjloNFhWRWxVejFRYUVqdWdxcnFSZWROT0xXRGN4?=
 =?utf-8?B?TzJKVVl6WE96eXhnMmhWU2duUExrUS92Y0dxMk1DdTQwODRSc0hKUVN0eUdn?=
 =?utf-8?B?WjF0MXBNNTFjb3hUNlhJTFhnQ0M3VXBBOG84QTA0eGlxZ2ozMWZlMisxaDY3?=
 =?utf-8?B?WVhXSnp4NUlJdUZIa3hzcXpmdnJmdk5FZnJ1YktOaFdBTEVjVHZjUUkrSjJB?=
 =?utf-8?B?UTRlTEsvTHVHbytBUkxhWmNBaWZNMFlwV2I5cmdsdVFIQXpXZG1ZaHZPTWpy?=
 =?utf-8?B?M3B2c3hrQ3g4eDl6TW1taHdrUkMvS3A2eThvTy9WNVl1SHg5V1piakJ6SXVH?=
 =?utf-8?B?bGFFS3hNeXM5bnc1WTBoZEQ5MkNrMmtlU2puNmc0VXg1Njg1d0c0cjh5S091?=
 =?utf-8?B?S3JBc2dkb1FkRlAwNWtMY29YNHg2UWpITk4za28vSFZIVCtUcFdWYUVJZ3Mx?=
 =?utf-8?B?VEtLak10ZXRmVnJjeDNyN3BYRkZQRVFlOFBFOEFXTlo3MGRsWnRlRzUvZ2c5?=
 =?utf-8?B?bXUxem9kYyt5MVBqM3g5QUo2Z21PVnlISTNRYXBRenowb3pyYWZpVkxqMGJB?=
 =?utf-8?B?MXFSRzBIbEkvUkYraUlFTTY2NUc1T2RmOXR0WGFpSWVEMzQzSk1VVTVZVlov?=
 =?utf-8?B?QmlMazJqZk9jMHZ0Y0lwR0NOVE54Y1JtY3ZHenVtVDJxc3RaM3dpNjhTKzlW?=
 =?utf-8?Q?/FNSApthxgDWVHaxw2lq1nUfV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592543b6-d260-44ca-0f65-08daa9239025
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2022 11:52:23.6767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: haWZPqlLDw5/PX7JwjPV5vxUmpgJDIyovrGNY7mByrK4IHvXBSM4irweBNySEhdErKwAnsS00G+T/vy0PYh8iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5955
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210080074
X-Proofpoint-GUID: s8O0hhdDNPDurMgJnUMB9eKfS5GY2Lfh
X-Proofpoint-ORIG-GUID: s8O0hhdDNPDurMgJnUMB9eKfS5GY2Lfh
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/7/22 20:03, Qu Wenruo wrote:
> [BUG]
> Even with chunk_objectid bug fixed, mkfs.btrfs can still caused stack
> overflow when enabling extent-tree-v2 feature (need experimental
> features enabled):
> 
>    # ./mkfs.btrfs  -f -O extent-tree-v2 ~/test.img
>    btrfs-progs v5.19.1
>    See http://btrfs.wiki.kernel.org for more information.
> 
>    ERROR: superblock magic doesn't match
>    NOTE: several default settings have changed in version 5.15, please make sure
>          this does not affect your deployments:
>          - DUP for metadata (-m dup)
>          - enabled no-holes (-O no-holes)
>          - enabled free-space-tree (-R free-space-tree)
> 
>    Label:              (null)
>    UUID:               205c61e7-f58e-4e8f-9dc2-38724f5c554b
>    Node size:          16384
>    Sector size:        4096
>    Filesystem size:    512.00MiB
>    Block group profiles:
>      Data:             single            8.00MiB
>      Metadata:         DUP              32.00MiB
>      System:           DUP               8.00MiB
>    SSD detected:       no
>    Zoned device:       no
>    =================================================================
>    [... Skip full ASAN output ...]
>    ==65655==ABORTING
> 
> [CAUSE]
> For experimental build, we have unified feature output, but the old
> buffer size is only 64 bytes, which is too small to cover the new full
> feature string:
> 
>    extref, skinny-metadata, no-holes, free-space-tree, block-group-tree, extent-tree-v2
> 
> Above feature string is already 84 bytes, over the 64 on-stack memory
> size.
> 
> This can also be proved by the ASAN output:
> 
>    ==65655==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7ffc4e03b1d0 at pc 0x7ff0fc05fafe bp 0x7ffc4e03ac60 sp 0x7ffc4e03a408
>    WRITE of size 17 at 0x7ffc4e03b1d0 thread T0
>        #0 0x7ff0fc05fafd in __interceptor_strcat /usr/src/debug/gcc/libsanitizer/asan/asan_interceptors.cpp:377
>        #1 0x55cdb7b06ca5 in parse_features_to_string common/fsfeatures.c:316
>        #2 0x55cdb7b06ce1 in btrfs_parse_fs_features_to_string common/fsfeatures.c:324
>        #3 0x55cdb7a37226 in main mkfs/main.c:1783
>        #4 0x7ff0fbe3c28f  (/usr/lib/libc.so.6+0x2328f)
>        #5 0x7ff0fbe3c349 in __libc_start_main (/usr/lib/libc.so.6+0x23349)
>        #6 0x55cdb7a2cb34 in _start ../sysdeps/x86_64/start.S:115
> 
> [FIX]
> Introduce a new macro, BTRFS_FEATURE_STRING_BUF_SIZE, along with a new
> sanity check helper, btrfs_assert_feature_buf_size().
> 
> The problem is I can not find a build time method to verify
> BTRFS_FEATURE_STRING_BUF_SIZE is large enough to contain all feature
> names, thus have to go the runtime function to do the BUG_ON() to verify
> the macro size.
> 
> Now the minimal buffer size for experimental build is 138 bytes, just
> bump it to 160 for future expansion.
> 
> And if further features go beyond that number, mkfs.btrfs/btrfs-convert
> will immediately crash at that BUG_ON(), so we can definitely detect it.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>
Tested-by: Anand Jain <anand.jain@oracle.com>



Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA566F67FF
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 11:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjEDJJH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 05:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjEDJJG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 05:09:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB58AC
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 02:09:02 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34444b9G003741;
        Thu, 4 May 2023 09:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=YhtCjJHerMlKdbzlNDi01yuD2RhX3ezowUPXZuxw0IY=;
 b=qy/BSno5ydRWJjU+p59wnRInEdSbSYyb5ePe2CdQC6krqQsLzFVLLKpyPpdo8/CCXrPU
 C/Pn8xUjXuG+dJBiSgOjJ+vvQVp2CuFXMVpa4hA7Kq+DgyquvPbup5B7Zw2SN/ISzp/W
 8EMkHv3YxyoSVOiNp6V0zGkNerZHxQ0A5lfAun9AWaQfZcCjaN9CHlpwiSloohpcRt4Z
 C1OiZFrd79+jZIxnR4bQeKua9zTXDp7R7CsUQUhibzSOXegrsDe4pM/0rYFPUEkwljjx
 C8pGS1fTpXxLVc3oI8q4q12ZjLgPqClC07077WPbg3bNFuyBn5yCruIjFfbSX6ec+LIO HA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1sbju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 09:08:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34484eYF040652;
        Thu, 4 May 2023 09:08:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp88nvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 09:08:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOdFjhsV6gjb69m38fC2DXnSD9JC5DJbii+SUHFVqLFtYaHzXCeUtPC7lLZXrlEoemYIUH3eN3xsrM8uqSO8pQTkPjXIuWiSnObunXQxb9gJnwvL80a9UKJbFDO/fI+iMC8dk9P9ElcjHi0/YPoDrz0p4IWfvI92bLbc+x2UJOvaqys2ykW3YRFgWhkK2jYXngUMoiSoBErPv4IZsPiNSnTgC5AwHNDMWnKi1W9qIYuexNCO43QUwuE5L02ajotHW91xhMKUFWf99BMRxiPRFtVVDGNW/L5eQ715MAUqLQYhkHZR1AA+ZBvRc3NH/0CGExIymzG4NhP4/Qn285YNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhtCjJHerMlKdbzlNDi01yuD2RhX3ezowUPXZuxw0IY=;
 b=f/uD1qMQeXzSgVKbJKK+g2FcR4al8wsvnA+HeO4zZxcVJ73BIxBJfS0uPWYAKtVtCH2zrncD5yelR7RKE14/f8rk+4CZnNX5qeOSYUEAvi3qR8V10n/mffXSY4Hm/MpYpRTVypA7M3zalrM/JhLx2YsZesN1p/H403urLXPEI+xuzOUMZ3vaHb/0Y6CasjMBEnM+thQm0xIl1W3sIWZBF3f+KTZHk72GiVBR5AL82WHAselRvVEcwsI9n6qYUaEMmce4L8gmPErTMyBPHZ2avbtQE4Wrzh4gXx5p4bBH0LJ3rL86ZfmStTHh5LdfdMosj7ivDlZJ3FRg4gWRF7R6Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhtCjJHerMlKdbzlNDi01yuD2RhX3ezowUPXZuxw0IY=;
 b=tdEr4vdlC8Lznf4FitNmT+pkmoMV21cyYsV+KQ9uINxTgRsH7MjiZVzYtjiEPkGL73tQC1rbL68eLpscBNxRbL6cLdFkoyVn4IzWDLsZaZpjDROikNSldodQpbYrheucXfwoFudGzptHjYYwf/5HxuSmPvx6Y+9mkFaAVrLL2dk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6911.namprd10.prod.outlook.com (2603:10b6:8:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 09:08:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 09:08:52 +0000
Message-ID: <f84102d0-29ec-11a5-2777-9dd27c3b4123@oracle.com>
Date:   Thu, 4 May 2023 17:08:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/7] btrfs-progs: crypto/blake2: remove blake2 simple
 API
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1683093416.git.wqu@suse.com>
 <6f15cfedf228f6e8d855fcdcf125b678273534d6.1683093416.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <6f15cfedf228f6e8d855fcdcf125b678273534d6.1683093416.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0195.apcprd04.prod.outlook.com
 (2603:1096:4:14::33) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: ab976e88-5d60-4449-9780-08db4c7f2e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAma+RCsgYCUtvcXFhc7tnRhrGGQvopsiBTq18G/aSrtDLSqWjoP06XeAfzKl/XKPErVa8juIFYiWkWMh4LwQOEirmBnsxiIgqr/avuR5C6NtzgSBt268Cl0NzCYGPaRgWI/kkJR+LAlIXO+Yk7W8kpOF0AZkduJDZpghVqjgbLVhZi623m+basvz9H9B7lHkEGK+2snurOH1LGpBoyuQ1s0iIo7zgWNKQ6t861urawiSldmUcbVtFYOh2SN8W3TGS3bmUstU6JNBdjrJUXGLPxOoDE14AD7qInQ2bVPcFh6JUgjxYAQDe+ZDbnfrc1QjFSaTChydBc5JOU88l+pxm2xuR9E/2vwew9EaUejjM6JksDeM/5+7idWtGpW18AhxUFBhNRnWaTTRjGjhS4FlJT0QVkncNDWmMS4sOLBikbPvmc5dumsZ4O+Peb59pvC5aLEbKLVVeiJp61yx6vUGzRkQW90DInZydG9BGUvAw+JENzGbj4tP5M5m5+lbtoBR6Duc2gAkItkctKvgew9z9514Yw3oulw7wy4VzzlfPZPQERSPMOK8PQz5noX4OGmeNkXwndH08ojQ16ABYttCA2O1lY6o6TyHy8fg33DT0hiQfVM+zqoCFduz8cFAqueRyUxP4UQ3zgL/LJ3lJt6gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199021)(2906002)(66556008)(38100700002)(53546011)(2616005)(26005)(6506007)(6512007)(186003)(83380400001)(36756003)(8936002)(8676002)(5660300002)(44832011)(316002)(31696002)(478600001)(86362001)(6666004)(6486002)(41300700001)(66476007)(66946007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RENhd0tEMG0wakZFYnZZK3RWbmM4Y3Z1TFk0Z0ZFMk0zRDdpdUg0aEZyZ2pr?=
 =?utf-8?B?TnpIVzBkWStSUzFEc0NUdUJtc2Y2RnR4WnNSTUpERVRSNXZPVGRHSDM4OFFK?=
 =?utf-8?B?TDQydDZqWWQwTm4zZmpyNk5xV3lPOHl2Wjd6Z2hJL21BMFg2d2pybkQxWldB?=
 =?utf-8?B?N1NGUnJSZjh3QWFpc0Y5UWtyZVJmbldVQlZ1Q25PVHZnbWRLa0V1TGVXTGJa?=
 =?utf-8?B?UHdDenNQdzBnSndRaU5QbG02bCtxbUlWZzc0ZUtxVXB4di92d0ltY3pNdnZP?=
 =?utf-8?B?MTJFMndaR0xzNm1tTUsxc1p3VUhuM2svMXJRbFlra3BOb3BhKzV2QW03bTEz?=
 =?utf-8?B?U05RTUVsbUtiV0R3dkVjdjI1NUs1ME1ZbTVEN2RlT010ZnhETHdqN0VxSFpH?=
 =?utf-8?B?cVZ4MFVNbTVXMFhCbkM1TlpkdjZrTzBZVlBCcGdKVm1tMjNNcWN5ZGJkWFFD?=
 =?utf-8?B?ZWdqM1l4TW9hSUs3allkbkpsTjdmRkpDdDNiSk1NRzgzYWcxYmlHQ05ybzlr?=
 =?utf-8?B?Yk8veitLdnJyMVlaY1FleE1ncWtWVjJFMWtWdGVMQkRJQWhGR2d4V01EYWIv?=
 =?utf-8?B?b3JnK3B1Rk0wZ1MvQU5NWjZwQ2x5Y1dtTXhLWEYvYURRVWNyTTJGT0lxSSty?=
 =?utf-8?B?QTBQL3ZTNWtsa2JNcnZ4V2EwaEV3WnRNY0k3RXpHWVRFaUR1TlpHVWJsQVhq?=
 =?utf-8?B?REJ4SFRRL21leHdiWUp2KzF0YThnK1VwYUxFbmVNTmtWb3UyN1BlWW1LcjRm?=
 =?utf-8?B?RGx2S2FKTkNDZWxzakdwV1hZRkF0bnoxTjJtTnVEWlpyMXIvOVJMeFBtUjJm?=
 =?utf-8?B?MWtGNlhFaTFsYmhPT1JycE5jdmxFd1JyVGh2b3E0cjRvU25xN1JyNGRGV2NE?=
 =?utf-8?B?ZzhQY2ttMUZzbUpjM0NhOG1wOG1PSFJ0NTRwUHVLZGJ1MmNlVExFZFdKb2pY?=
 =?utf-8?B?YWU5Qk8yY3U2V2k5WHdNWmNRcGFVZW42d1N2dHJBOXR4eUFpNmlrOUYwREFV?=
 =?utf-8?B?blVxSjFJVUExN0g5azZoT3ZkM1V5NWtIK0VCbGJycVdJOWxXSDVlWmNiMCtI?=
 =?utf-8?B?ajYyRnJKQy91RmRyRHowZEZqQm1pd3FwejNRaXBDZk54ZnNwblhoNnoxMmlO?=
 =?utf-8?B?T0hXU3lhY0JiMzF5WU5CbCtKcGptTkMzRDNueitTMjVZUnhkVHZxOHV5WVJz?=
 =?utf-8?B?RDdMMmczYitkZXZLYTQ1R25LRWJsLys2cExtV3BVb251eUg5WDJyamZ0SkF4?=
 =?utf-8?B?OXBkR01jK0NPN2ttaHkwUHZhRmRSUDJhTnlkUWtvZXhOOU9GckV6MzI3emNZ?=
 =?utf-8?B?ZURlNzd0TnR0RkkrN3pYTVA4Qlo0c1JqMkNYQlpCaXhDZUh1SWt3QnFOcUU0?=
 =?utf-8?B?U1l5akpMaEJYWVZESTZ5WkFjendFb1NBczhnUUJkaFdpSUt5eEQzaWdZaGhC?=
 =?utf-8?B?ZkhoVGZXQ29yTTBsa0Z1azFucWJ2ejAvMVVoS0lqUzBUQ01UWmdSSG9hVVdh?=
 =?utf-8?B?YndRZnU0M2lKbWttajBRdFh4bjNVWXpweVBGbWMwK2xCRjBOTTBOU2k5Uk5N?=
 =?utf-8?B?WU5tOGdqQ0Y4Z25oSDJjekZjOE1uUG9DUGc0NE5nVkZQVHphMkQwUDZlaU1B?=
 =?utf-8?B?VCtGYk52WERaby9MQ0NwK3JnajEyRkc4MCs4UVZjYVkzUzh2WTRwdS94enBi?=
 =?utf-8?B?d3VIRVg1RWVyakkvU201NW1rVjI5ODVmVWQ3VWxodGFZYzRvOFVVd2pVSUlz?=
 =?utf-8?B?QlZUdXVQYnBEeDhhL0ZobVJYYVJxdU5lTDlwSS9pMGNpVWkxQisyaUF0VmZE?=
 =?utf-8?B?a3dMbGFyL0VlNE55N1JiYThDL2dnMFF1Z3psMWgvM0ROLzlqM01KanFrQUMv?=
 =?utf-8?B?M0JEcXFLWU95N1JjblVJdjUzMVQ3cWF1VnZrWkFBakdqc3VuRlVacExyU1FX?=
 =?utf-8?B?WHRpcjRjaVlaZTUzd3BqNGlnaUtOQkVrMnVjOGJMQnIrVGIvSHpHME5zeEk0?=
 =?utf-8?B?YjdXUGh0bGprYlZhSWpBUnlZZjIySVB0RXg5Z0FWZVEydHIyR1RlU2YraGZS?=
 =?utf-8?B?ZTNzN1pScDVUZzN1VTVtaWRDWSs5eG9DTjhwWU9NTnNyYnJsN0ZhOURjZlNs?=
 =?utf-8?Q?DLqGz4oNoGGyW61X+xU45V2NZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3atbrztkKqddk/eoBojBfIV13uJEHAzRCReS3So8t7wJHLUe+5j5wOxdEKodMEOMre8SzqSZPJaRlKITZTFDCld54x5VEboFnS1YHCkMvMlr+B1+93muHlP+Ejow4ofm6/TO6sk5vt2ofqZWPyOd831Y6qRQzEgZw4J/JfMWv4LTQVzV4qbZly4WZXfFYbke6j9K4jM5Ty9Cjels4hj24jD9wVSQHwTki87J3Q8iGuKra8dQcPge8xjHH01/XgNQsUi+rxFLCdMKoVIUmZMk8n5FyrPkDP/7t9jjy5w4SZdXeNmk9HNNirh9urtxQmp1cgt8J0OO5ei3kNXwRWOr5dgUhEoq9omyEosbRD8bm/EVNVCN9LTFg5t66IpautaYDTjqrJ4oMbPqG80ZC0xGmrBJ8+xmMP2H2EEIsKDlOKFEkrW5T3WPcRDNxVwbXsHTEn5N+zEK9HoRiuLlOjbm/x0ODS5KXbB1QiwsLcOleSpYj+/v0pyI5N4OIux9/mZ83MRf5S8akcEF4hcg5X5f2tjtdtYjT1vQAbCcUpAxkBYg2UXxI9DokBE95OYRuISGlOk5LvJeQKFv9W4Wfa3OYo+2+tGrRXdPWKwUsiYhANeG3+RKEAGFWdLCbMWUSpRif/quAtf6qwsbLEcikroMqKjJL8Omn2DMWkETlH8KiMZHlZZjb9InNA8ERv3p8ydC4xU01LW/SgkVnLTso4DyONUhPFBVygUXF8BttbtnEYdSx9lOEIPMlEa15eTCavNWyzTtoysoJd0kgcHwZBkJWqnuxQz232Tpn76Gm608lfA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab976e88-5d60-4449-9780-08db4c7f2e3c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 09:08:52.6773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVbrqvcFVDIdTtNbsEwQSCtMUChbgho2SzbH/ejgRF58g8d4k2tU17acFa9VslniryDLUZVeYSZdNDSYguzgTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_06,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040074
X-Proofpoint-GUID: lmlF_7k4aPJLzlR3BnwSD2NTxgSzPQ9e
X-Proofpoint-ORIG-GUID: lmlF_7k4aPJLzlR3BnwSD2NTxgSzPQ9e
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/05/2023 14:03, Qu Wenruo wrote:
> We never utilize such simple API, just remove it.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>




> ---
>   crypto/blake2b-ref.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/crypto/blake2b-ref.c b/crypto/blake2b-ref.c
> index eac4cf0c48da..f28dce3ae2a8 100644
> --- a/crypto/blake2b-ref.c
> +++ b/crypto/blake2b-ref.c
> @@ -326,10 +326,6 @@ int blake2b( void *out, size_t outlen, const void *in, size_t inlen, const void
>     return 0;
>   }
>   
> -int blake2( void *out, size_t outlen, const void *in, size_t inlen, const void *key, size_t keylen ) {
> -  return blake2b(out, outlen, in, inlen, key, keylen);
> -}
> -

It came from the ref implementation. With minimum changes. Maybe needed 
it for future sync? No?

-----
commit 3778ece7ff4114dc071667cf13a60c4ef1936576

     btrfs-progs: add blake2b reference implementation

     Upstream commit 997fa5ba1e14b52c554fb03ce39e579e6f27b90c,
     git repository: git://github.com/BLAKE2/BLAKE2
----

Thanks, Anand

>   #if defined(SUPERCOP)
>   int crypto_hash( unsigned char *out, unsigned char *in, unsigned long long inlen )
>   {


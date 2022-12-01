Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AD263E7FC
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Dec 2022 03:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiLACnI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Nov 2022 21:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiLACnH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Nov 2022 21:43:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BE529CB4
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Nov 2022 18:43:06 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B10oHMH005306;
        Thu, 1 Dec 2022 02:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Wtt9ZzUKVPDpvVGlRMg4wOF/ACgBVE2DeWcY3q47iAI=;
 b=01BOQsbX+0tm7MNIprFlx5Oh97acf10gHbemaeNfi9rApbKt3StmT3emjd6LLlJjX8dC
 rUwZnXdZEuI+DavjQFS7yGnxhUcP0ennqvcIxdiRia31t0DwX5sFpSzkKRSOXwp+0x2y
 G1+ksGLQEPO+dBCIYaZg99tocN4pv6LASCDA2ED/kRQLhwOIXJ8q4uGHt8keTVvukl7b
 yU3VKJGJwYfS6PGGGLgcm6IHrtfXVkiWzmY/qHul1CGjCj9gggnKQhRHBbARN3XROz3k
 v8nLnLtfEC3siLNr/bM43MvmG/RtmxD5h+jxhFcMOnfXC3QdwXdpMHGkV4n5lZj1JU7l 7g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemjg5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 02:43:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B12bhR9000532;
        Thu, 1 Dec 2022 02:43:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398gjhvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 02:43:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ea8sUpOUnImQTYPhfkjvU4Jgzoao/EJh0OwgtOnmxMX7M3jnj5UkolDqpILcmadOAFJevZZnrn12owIB094hfxBbF4MM3nZmUUpHG1V3iWl65iimEJCUj/M8XM+vX9ZsKiYxFbidMHqGUfhv9cJoNrlNYHttb11EwulFMBeDm0Jsmayl3Rk3wZ6viYlDJNGN4VsuG3X4Lkvc8KGJtk7dXTMfom1M1rdqScDoP6rU0oUbTuY/QwZfNsQABR7cBhmlVjeV9gRldfhGJtreyUTLeLGV5tJY4b9k3pYMc0NK993caMur01YiaDF5z5hsPQfTK3kYH89sF9RW4iT2Wo+aNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wtt9ZzUKVPDpvVGlRMg4wOF/ACgBVE2DeWcY3q47iAI=;
 b=EZkEOc4Dw+vQZg9o2/Xu7tSZaLVh+XqJ+PkOqV+dkX+g6Yf60BlLknjbgPyijfVDjmpjwOa1lVyjQMwnE853B13siO5XNmuHYNsZLuAqiJQD/IcTsbaEsqNrH7qKF3JCHTtFjfMC7i3eskHZe/1tL1TnWO8HlcGWqOc0Jj0YIf8iyJ5DWCatHOXUqY9E3HChhMjOUa1CFnDm6IGuYD+k0xyf2aHb83tD264ejTHgaMCkP54K/lwuy9JFLJO4MWzYsJlqzm3cxXCFdbsc5jPzj+EEUtv+8T8E1iCAMbuOgrTl51AUI+xYlNHN8X6EdT8bXWnKQHx2xM/zTsw56QGA/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wtt9ZzUKVPDpvVGlRMg4wOF/ACgBVE2DeWcY3q47iAI=;
 b=z7iro+R5s/KNj9wYNQVvdWY/OeQ9zBOFNI1vJOt3HOB0RdbRtWVSvsf/MrGSQlqyTQrCpEiNvnhYeRevBtdlQaNWkyU8UOvCp3yvP0PfWi12Cumb9NKAS9afFMOhG4NlkzOSbzqxHo74mYEq6u7J2VLGKBQ+2lYE18F288snUSc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4459.namprd10.prod.outlook.com (2603:10b6:806:11f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 02:43:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65%8]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 02:43:00 +0000
Message-ID: <5b2f3601-cb52-b8d6-cc8e-0413bcc621d8@oracle.com>
Date:   Thu, 1 Dec 2022 08:12:49 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: print transaction aborted messages with an error
 level
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <06fd62ae08b2206c5243f8f5f4811ec488633f08.1669823310.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <06fd62ae08b2206c5243f8f5f4811ec488633f08.1669823310.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0c396a-2238-4e67-0bae-08dad345c296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hfDmSqGVgy8ODsQMg4NLzvKxJuVErcv2KrUgK/sGumxjhvHS/aIvXAN43SE03yIBQGc2unTRzJukkhp8QwShtYsICZPLHNVvA5NvhQexHX5ZlybfU6mMQh3l2N2w7ULvV4CBAsyzig6zxFF/nwrwS43omETp/rd1InbIPHhQQWQcZagTlthlDvyCbvQXpZIDtCVLmxjHqOUFtyEj8+5CtI/3B3HS6VjOaTo5tjxGWMA7WW/8ESmRzHlMsXk996CVukLmM3mvCwHkIBfbDEFTgoLcwZXrXQtDl7VthUyBZP/Eygqca9WcZF/qT5/1/rb7OdYQAFYLc2yQHdrqPeW9C7Tsf0lXpuj5asfvEBfTgwd1PQwKZJqUbqWrkJ+Fu0CsJimaze3Rm92L4tdLLbbYb0CVc1lf05JdLx5cHiFAyBFRWypKM+cLl4BkG9fx25EzUWFrmDrG/9+G0pgmsUOk/vVem6dObPXtrgL2N1J6h1j3rgAgaXctbg5VI7ESPLqNJVpyz4Tb62SZEQFdvyuvHsqnwcWP4mVn0+K907f3HW7z2k5RD5Oay51WXUiGACnG+fkb+KT0Q0olqNUTP1LNYrxUMyEdG5UrPYefEKIJg9bSNqn+J+vxwq/gdKbR4AWemI0NuU8Yw44U/uZ0DbLsBRAwVp/d9bWooqWJ5YBMzKhG3zSde5Rcj/xIsJd6M37PIV5XRjXN2atfbARL3Y/yoesoWz1JSvlK26QFvUzixfg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199015)(2616005)(31686004)(6486002)(316002)(36756003)(86362001)(31696002)(478600001)(38100700002)(83380400001)(6666004)(186003)(6506007)(6512007)(53546011)(2906002)(15650500001)(4744005)(44832011)(5660300002)(66476007)(8936002)(41300700001)(66556008)(66946007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0I1TVhCUVc4eG9OMTlCcWtkTVVYamRmREdsNSt0aDNQTjh2OHBvcU9oR0t3?=
 =?utf-8?B?QkZBbHJ5L0ZuUENoTU91elFPb04xRVVRaGNYM3NtK09hVmpwUGl1SEFsemdC?=
 =?utf-8?B?M1dFZFA1b1hXdzNzek5wdEdFN2lqS1haWHFaRzJpREg0clhxb3g4MDNOaDkw?=
 =?utf-8?B?QmpaZU55TUt6eFlwZU9HUHkrYVl1WEdEdC8wandSNXJrNkJ1YnB3UURRZVQr?=
 =?utf-8?B?VEFtdWJZeGs3KzRNa2E5OEhrUUJWUGJUTmgxMEs4cTRRMlNEUkdMWmU2SlVj?=
 =?utf-8?B?SFI4bVVJN05HSEQrYjgzaEhmb1dQUmgxUDU2ZTBtS3A5VjJGM2dHbE96SG03?=
 =?utf-8?B?V0ovMTJlMmhmaHR3djVFOEU5ajN1V1VkLzI3Ty9EbkRwQkhiUEZzSEVPWlhD?=
 =?utf-8?B?aEZUK0FLbHVFRURoVEpWK1k3QkJMa3FSeXRMK2l6NEROT042cWNZUTB2U3oz?=
 =?utf-8?B?a2I4ZFptSzZ1aHBJU2NMVDZuTlcxeEVSVXJrb1J6aklFaWpQMm91d3h4UFV4?=
 =?utf-8?B?TWw2M05BOXQwOW5sdzBOY2tzN2xHRDA0UXJxT2ZGa3hqVW1NY3FUc0JGL3p0?=
 =?utf-8?B?djBzbUI2cGcwaVZGN2pyOWF0bDUvQ1RDU2FnTERpdEhDN0NuK1FMdkM4RUQ5?=
 =?utf-8?B?TkNLa2w5WkNzdG9yckQ4R2U2M09oRWtMNzBkcE1mTEE0aWsrV1gxWmdFRmlM?=
 =?utf-8?B?VjhNUVFXK2JvSERzd2xGQ1ZlWmx6Wk9ucE81TG9kdnBwOVZuME1VakkrZEJE?=
 =?utf-8?B?SGZRWjRFYkVrUU9SWUNHK3hKMWdHbyttUWErSHZmWXNRVzJCMVNERmdLTWVL?=
 =?utf-8?B?Nmk2RVBpd1UwNzRETUNwSDVUbHoxOTZOVzBVQytkeCsvdmdKTjl2WGdHbk9w?=
 =?utf-8?B?b0p4Nm1nZ2tQU0VwSE9VNndYb2tRZ29OUGpyNlZDRFlsc0FhV2lwTENLQWJM?=
 =?utf-8?B?TDdlNi8rejVHUCsvODJuV1lodSszTDVxck15bk1ESWlCVEtMdGxvREl5Mlhs?=
 =?utf-8?B?VFVPN2t0TmR5aDdGTTNtdXl3VHFpQXhva2FtVW1lbXpjNnFheklwNU9FNHc3?=
 =?utf-8?B?clVOT3huSEpSVDJMVlhseGU1bXZpRG0ra2FubjFZeFZpZ3U2YVlaQVhvdnZS?=
 =?utf-8?B?cWQxeVRId2I0bkdaVHZFM3NnWm5YQ05SVjVBaW5tZWhjZTI5SmtZYnZsK3Zo?=
 =?utf-8?B?SmhxZHhPV0J2M3dKbFcwc1Q0dzNqN0ZBWkJQODQrZk5Cc0VwMksxQThpdUtx?=
 =?utf-8?B?bjVwMTQ3b3drSUFpU2tsaFJBb1E1S1pocHdBNWp1dUdSdHRyandETjdJa1FW?=
 =?utf-8?B?LzRHVnh0Zno2bjRlQ0tBTzlqOG5ac0JXaGpCZm1BdVkwKzYzY0pvV3N5anVT?=
 =?utf-8?B?eEVtNTRRQlhvZ0NzRXhsYTNVUDBvM2o4L2V6NjJyTW9pRmxWcjBHcERmZ3RM?=
 =?utf-8?B?MjZZQTJIazBEWG1HL010bmJVVlJnaDBhdXVPMU05RGtrZHdmVE1NRlZ3SnZh?=
 =?utf-8?B?cSsrS09yd2hrcksyVUFseDd6Mk9ob2xsNjFJUnNvbDhvZGNkamNqaHVSREl0?=
 =?utf-8?B?SXhQd0lxa3J5aGdrR0h2MTVlZS9mamhCbXI1T1JPdHF6a1lmdURaOU5panhB?=
 =?utf-8?B?ODlqdE9yZG9VcDNaT3RyY01MNmt3SHpxY0h1YXdHRlJUSHpyM1V3aFdMdzUy?=
 =?utf-8?B?Z0ludzAxMytMeEZuVUNqei9Mc2xYNmttM01MUEFsdGExdzdlMlBRUmJheXBt?=
 =?utf-8?B?RUl2bENzWGN3MUVTUHVVSFFoK3d1Mk9lWS9TdHZwWklGYWY2N1JzRzdLZ3Jt?=
 =?utf-8?B?S3BuOTBCMGVDYzd3OVUydmErSWpEeUJvc01Ldmx4R1RNTmJudVU1bVBsSnYw?=
 =?utf-8?B?ais5REd5YWJaVlVKQ2NUWXNUd0h2Smtaay9mTzRzYi9qbnBNNHlvZ2JCR21E?=
 =?utf-8?B?cUZtak1yaUlzWlIxT0pTcUtHRitORGsrY1htUzRaQmJ3NHZsNGNSRE1sR3Bo?=
 =?utf-8?B?QmVBWURyWFFUemlSdmE2S1UrdS9kSTNWYlJ4cFI5b1MwMndiVDN1QzFidnBv?=
 =?utf-8?B?aE1YcHI0czV2ek9YMFlYa0pENzBEdFlWblpkNHNtcWUySXloc2hpWllHdmVQ?=
 =?utf-8?B?Z0p3YUh6V29vOC9XWTN4bmNVc0lzZXp1Sjk4R1lDMFViRGVSaW1xZGcxL1da?=
 =?utf-8?Q?TfPsMUciL0Szb4uMbhUaeeLBdgEQ4NErUVpuZxM1j4Qj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5kwcneKVrJrdWOlzJkkxgT0CXaVvjVXpLJtEyx8ZkcBvRQH1hH9ls6fVWVr6tW6CryzP+fpcIvtj6t7BHrb0GVNIaYbUHNXp1oGsOHA1kPLV7UR5y5GboFd+UehOxQQGLznu7giT91efXrOiQRFI+TYMlDnqLkECPNzb49ogvs3gbzBFAByRc/xuEXPgVDknGv7nmjj7h9whzGNCTYeudfR315rJuYCsoNLLARPH9X6Cson0nX6zOtdg7F4zc1nMbROIl6gmJ56Khp5hGonrYOfohCwV+ksn/JNwHsdQxDmstIiniOMtf+8Z5QB3vI+6VBdq0f5urCMnCBZY2xEHLeYA0coFrk4dFs1McCaVU1iuvtAr4hNGHIERTDubf9qxcied0gsXAdTC6PA4SMCQq/kEOl4Mp/qPuJKmXriWQS9nAku1GJiBEpR1h/saCsETOHwUUjNeJtcvcVx8WEO1U0uz+CphT4bM4RsFJec5vcal7+4sx/zyDiTKdGPMfQbYKoSgf48N97KyMKTFAb4MOxljTmUimGQmYYZC3/qMNghn56oIFfXxzJmwgHG1BwvphuvCSaNg5ya0w6QuUORIbd/fJtHQp+jjVRW4ScFB3YNIGWIsxi9lHnXYWxq6DrevR1SEnqbWpI+D/ltCtvz01FZ0kdA+wG12zbtNsfwxLvM01w2W8l1akMVZ9LInpAqZDF8neRQzBdtVp92owlP3cA/OctUQMAixci/dSMzWsau/UfwBL6vKqHjn6H/yEyhc+FZqiCtMgrkVQ5VJv85rkdYKqa5vZ1W3shVvPVidhEY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0c396a-2238-4e67-0bae-08dad345c296
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 02:43:00.2319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /z745Rp3Pd4DbLWkUerjBNGVIDKThZYi9nL5mmcMAcvkCMybvpbDL/LGUM2EI8WHKU38YVhRXpdgo4n0EYnXtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4459
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_02,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010014
X-Proofpoint-ORIG-GUID: qCoB7rOX53giDTEusDwyCnCjR-1087Of
X-Proofpoint-GUID: qCoB7rOX53giDTEusDwyCnCjR-1087Of
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/30/22 21:21, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently we print the transaction aborted message with a debug level, but
> a transaction abort is an exceptional event that indicates something went
> wrong and it's useful to have it printed with an error level as it helps
> analysing problems in a production environment, where debug level messages
> are typically not logged. For example reports from syzbot never include
> the transaction aborted message, since the log level on the test machines
> is above the debug level.
> 
> So change the log level from debug to error.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>



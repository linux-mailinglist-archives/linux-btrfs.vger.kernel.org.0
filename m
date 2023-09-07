Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAA279795F
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 19:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241771AbjIGRMN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 13:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241763AbjIGRMM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 13:12:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03861FF5
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 10:11:43 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387EK6UZ024242
        for <linux-btrfs@vger.kernel.org>; Thu, 7 Sep 2023 14:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=clHNP93fMA3FKKQZm69AY5g6Ccpwfieq7Wh8c8q7oss=;
 b=iSCm5r6prsmHUSMTtKDAwof4Gg2XNbOO+VtUKeRl6KX3W3764XbO8nuNIqlxw+iRCf+m
 VWU/uo+NgIqfaltyiHT3jx81W9PsQjRO4fptItm+YRmn6nqZOfrDe2l229psMtiqdd9a
 rr9A+3dDDOGCrL4MYGZAHckBi6hzUi8pPs+zMwfg4NCNbiFlUgXCKRfr2YRTn2uUfgUd
 tGUzUw4D8CFA5kJnnMldKYTy9+m8OXJXAgcd0gsKOTOa7ybNKNEcB5WQ6bVJbUMxbOiR
 psGWtOcTAMAPMpOOZ2njGbLt4XtV/qyYZnaH6VrPyQcl8XmRqHOD8h8D/A5zXLQu2a+k PQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3syg6b01a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Sep 2023 14:33:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387E4d4g009437
        for <linux-btrfs@vger.kernel.org>; Thu, 7 Sep 2023 14:33:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3syfy016b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Sep 2023 14:33:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaKRrf7U3sBHACWGtYf3wJiqigL1Zu7i7MWjp2nbsWDKmkCw3qZ3WHCui0aRv6T4sG+p/F9kZVzZaxaBl5jINYdfvd1iDSodjd0KtzD0VwCBbX6C9n9V10etG/scWf6vLgucLRC/Un0A98GMXfZNlTq5TwLsGgi5KKIg2myupNM0Xtxujrij3Qrub4Nx4OOUvCDENXJcKOR4F4sILBr0EsORLXPLShcrdSEc5i37pm5WAz1uc/Stkr5nmvRhQJHRqGPbExKctEK9D5IrGPJZQTjDFB3Sl5YlnU+ZsIXyPO5lPs7M2qN0WwlDgfVo2gpeNNPdzj1BC5FbUAzUYdHtxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clHNP93fMA3FKKQZm69AY5g6Ccpwfieq7Wh8c8q7oss=;
 b=jsAqwdRmFJQMbmitDVobCEHneaFE68rWF0a+pOnk29kw0V9qS7vf8uFwt3PQcpA5zm7kewiZf3xU++TZ0py6EteEq7N+lVNPFuUFtkWmYya80BFk7LFMYFURxn4Gj9aijnbmCphWuN4X3g36KjWIQ+SlJmlH/2DEVsMR6kUfsyZ7iFDY0Up4YHH5trH9tw/XjbS06PkmsbmoEnXg8m+xR1XvsIREBLo2/57JeQNuAXhhiJBCIyEKcfe7YlRoSeauhBKU77ASdkshnNLwVE8xSLVfPfKRFImodajJL8fd0pssgnKRrnOIcBSsRX1Z8rXFRvC1HibdjK4FGBS8pHW6WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clHNP93fMA3FKKQZm69AY5g6Ccpwfieq7Wh8c8q7oss=;
 b=UZuar6vwmrzoONy+OLW/h+ByNAh2QabWzKzHX9Fkxg8trW4A/zmjAQPIFLscodz0zjNBbUYjxTlnCI6KATfsKPVDcU4rnpedvTNS5ctf49uI0pVenLK4qV+fm2xDu1LXpO9nQNgTZhD502TofxYq704kG2opne4XXayCDYBeAXw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 14:33:21 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6745.030; Thu, 7 Sep 2023
 14:33:21 +0000
Message-ID: <4272ad23-baa4-7791-2f68-c87acb88fd05@oracle.com>
Date:   Thu, 7 Sep 2023 22:33:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] btrfs: pseudo device-scan for single-device filesystems
To:     linux-btrfs@vger.kernel.org
References: <b0e0240254557461c137cd9b943f00b0d5048083.1693959204.git.anand.jain@oracle.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <b0e0240254557461c137cd9b943f00b0d5048083.1693959204.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4515:EE_
X-MS-Office365-Filtering-Correlation-Id: 99300395-9c7d-4957-9739-08dbafaf629b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pcRJIvAufp8U0gH/DNjq9H6MOK8L26WM/HDebSEkkzMsqNYOOhxhpfHVKlKh0AG7MWwXnz0rsGm3qURXHucB+yaJF5BOUWJ/ssZiyVSibGEAZ2s/yFVoz6bshGJc0fq2/qXi4d97ixwYusWqvP5QDAVoKN5HOFTNjNSdIQ/l/SNM1JL4FLz4Cnrevp11zyTMD4Cj6+Ko02cxqbHycJDBHJCgnKROHFBRibmh48FZSfe8CoizO2ByXmOAMyKkyhpWMdT1cde7ITHa9lqsHQCnrLOZwHcN4oqMGSCUskzpEREL4UsG2sIyC+12AqmYzA9ceLIkvzWQ+1DuKUTU3JGY+WgkmjbsuO1QFpPz6PpegehU0gKcc/g+UmY7lonLdj6qHr0/DkbfxS/qNcdJsXDHDbGlDFjwvc4sjulS/RY/rLNZmFU8I42xuV1ziMu85IfOR+klA+QiCZA4RFC0nOC/SzIVhMQw6jPLV7kWVLmKW1HYUOEQ0U6Kowv/yKivgFZRemiSwXVaw+yUsumsN2AYQwmHUkY22O/g59HBIxy2jWo8+o5BVWiUUp1e/vxtw6n6HtrSK3/7kyJOFRcqSR7vTXCOZEF9UZSzL7HBjyf0VsVi/gwNdlBhUgf/ACUUnVDQ3e1YgVd6rO06wRQlkZ+wKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(366004)(396003)(1800799009)(186009)(451199024)(31696002)(86362001)(478600001)(66476007)(6916009)(316002)(66946007)(2906002)(36756003)(66556008)(41300700001)(5660300002)(8936002)(8676002)(6486002)(53546011)(6506007)(6512007)(83380400001)(26005)(31686004)(2616005)(44832011)(6666004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTZtV2c4enJCbHd1NGIvUW9KSW9ROEFYMTlYdmdFdDVESk1yMERtTm9RTi9J?=
 =?utf-8?B?bmhJYkFWWW40YWRibmlKQVpSRnFyNE1yS2tFdzVHREFoWEQ5ZmcxNFFBR0Fh?=
 =?utf-8?B?TUZ6cTV5UUI3REw1TmU5YTRzczllRDJYZm5WYkg5TmNJK2JodE9ubUhaSkJm?=
 =?utf-8?B?U2V1S2M4VnRMNzlEQ0ZqejhRVzVldEo2N1BVdVZjek9EbXdFeWVLWHdsSlVj?=
 =?utf-8?B?aWxCSVRvNzlBUW9GZmNSM2NNdWVBaFNnUlQ4dGpWMURzWXVhZmVqSFE0VWdC?=
 =?utf-8?B?bmJOT1ZrS1FXRW1zMWVGc3RrWnJLempXMXlFbU1DNjBCMkE5Yzk5Yi9RT0Iy?=
 =?utf-8?B?Z1R2V3B1U3k3Z216R3J1YVEvUzNaNGROUzdvRnQ4bFkyanF3WXI4c3pvcC9Q?=
 =?utf-8?B?dlhWVmYwOHMvNjAvSklpWFBUVlJQTDdkbmZUWFlxcHNZYjFoTkZTNHFGb0Ev?=
 =?utf-8?B?dHJmK05FQzRtNjJReFZyQWo5TmQzZjdkcHhNVnU4UzNGYXovTDQ2WkNSbWJo?=
 =?utf-8?B?UGVJWERLN2swOVNob3JmWHBEWXEzOUkxRyt5ZnhKMVI2TEhtOFBwUW51SDZo?=
 =?utf-8?B?a1hXT05XcWszZWVWZTRhR1pnb3JaSjMxaE9lVzFUaXpwKzZSdGVWRXFuZTBZ?=
 =?utf-8?B?VEdjMmN4L0hUczM0ZnpxMnJvaExnTnBEYzM4bVJIOWxGcW53WG43M3JKcEJO?=
 =?utf-8?B?VEkyZ0x2YUFhODZuQ1kwS0pIcWIvcDFUdjFHZzVsOEUrcjVLSHVOMFlDQnQ3?=
 =?utf-8?B?bU1ZQWJYVG5NSjROOHErTHdST1U3T3hHOHI3RmtWUlp0TnBUNzl5c2swMmtW?=
 =?utf-8?B?M2tmUVdTaGNYZDZEdmZRMjVYS0F4TzZKNFJLVTFYbkRkVElCUStMc0h5YXFp?=
 =?utf-8?B?WUlFdCtiMERNWElCb3BXdVNQZFYrN2xPSVVRckU3OVZKR0ZlNnp3N0hKSFE0?=
 =?utf-8?B?elNjSUVrOFBYYUlGbEUyVXZwc0YzYjhrVkNFQSs2Rk9QWHUraVVvNy85K1RT?=
 =?utf-8?B?N1BwYkdTNGx3bHk4WWdva1Q5bHdFUFBCQSs4dW92TjUwK0RQMTdiK1IvblJv?=
 =?utf-8?B?NHF2bFhETUF6SzBqZHVxZ3hTWDB6ajFVUUlFSlhiNjhsT0ZyM1YwYVdQTHdr?=
 =?utf-8?B?VDNKeTB3ejQ3YURmT3NrZXh0RWN6a24vaVp0Q2FpMGV6ZU9yTzIyOVlsOS9W?=
 =?utf-8?B?RFBwT2tQdVpkRWVHVDc0bE15NGdhTXdZeDhKakc1c3ZwbWh5bEhjWDVTM3lv?=
 =?utf-8?B?M3ZlUzZqeHVwR2VPZjhuRDg0N2ZieVNoMUZSMGVIZU4yem1KMXlnVkdhWDlW?=
 =?utf-8?B?SFJoTTExMStscWRmZzFRcXk3WUY5ZG81ZHhkbFZOUTNJd2xrNktMdGJZM1Rt?=
 =?utf-8?B?bXBSWnRjM2d3ZVpsSTFRVzE3ZHJPMjFVV1dONWlidUM3aml4a0MzcnppdHU1?=
 =?utf-8?B?WnQ3WlJnQkk1eWdoTWZqN0RjQXNCY2UzKy9MTXR1ODdxWC9UTDB0ZVFsMXZV?=
 =?utf-8?B?R2Jaa0ZHdTd1YlY1OERJMGFFQlJHV1cydGcvZWlqN2tMMzNSejVjams0eHQ3?=
 =?utf-8?B?aTNDZ2RVWXRGY2cxcFlxSk5weEgwQWdlU1hXMXlIZGFhZ0dPLzBxc05Tc0dk?=
 =?utf-8?B?UmhlY1lYQXY4YS9iYTEzalN0dG13b01hQTYySitXQXNPQ0picTk5UDBVUExQ?=
 =?utf-8?B?VFZyMEh4QUFzOStLbkRsU3dqMExGOW5mU2dMM2VsUE5MVTRvSVZielNlOWxL?=
 =?utf-8?B?WUNZWUtPajNKZHU0MnNaZ292OGkxRERXTk11Q04rMmpVVkxsOEp0eG56ZGxj?=
 =?utf-8?B?aUZWcmt4R1BCTVhsL0ROVDhGM1EzZU44WlNXNHlIVTNndWRKUHRNVDVUNHFS?=
 =?utf-8?B?NG8vT1JDTXF5YlQxMVVxaDA0aittc0dPZGprTHpWeW1IRU5TYk1hbWdRbkJD?=
 =?utf-8?B?dVZWenI0ZUtHMFAvME5tNmNqYVFYQlh2STRlT2dVVEFhN24wQ0pQcmx5aHpv?=
 =?utf-8?B?RnN1ZzU2elZUcWhMQjErTGhmVTdXZDRKdkNMZHdwR3M1OGlianA5NXh6L1FP?=
 =?utf-8?B?eVVvd014QXRWZUhUNzJYeTB5Ly91c2xvbmxFakkwcEZlSXpYa25vKzVtL0FB?=
 =?utf-8?Q?oaUwWId8mRVwg478ubDqrwKdi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qG2LtoU1i7pEGZCydwDfTpj9VR0Yujc8Pug4OTPNkSNni+/YXCDmiRVba9XMEt6vu9FUb/0uZfsxUvfCv/y1bryGRRk37ctn4YUNONC8l/5RQ7QtLfKo1L+/BNAUpERUJkrtVMEYQoMeUydWU0rCPIdVKJWifj6Chauy+EPoExloeeEbIVFRNr4ZSKKO4wIXTYdhJfJ2zbsfJWwEGp3ERsRSIiqyxCaiM9Qe1OcKcQL4X/9mNukCPLeAlCX+qqrl2NpEx3IpFyP1EMj7npJCwnGFaGQgM6HuOwJJl/WQY8IoGOZMTmdNVQPp30YY+c+ZzQg+ph+QBLn8GsHLFlM/QKs52GIyTsEc/9ULIO8eg6JgCHUqmU6KiL4G45G7Z4RDcFOOmvppD+xj/GuXSFaE0oxv55r75RfNGNmbQTEBP3iZ7mTuIwxvkr42jpEUaRUv9H6hpZ8gx9D7sAkkoiE6o3cPMWukLMYE7VyCokENDyc0qv3yHn8ZECtBFPScvNeihLv4OhWN8uKEKYKA03wAJreLGiVet96XkqQ/ycpCeLNlwmz5QOWLAgaa223GA60vrw8F9oYP8DluPF4F4B1WFDW7BByX92hYieAJuJRvroBXLWGuxzIEe28G0riPWamwpbghdLUb1iyfmsBvCnE1Bj9fcgYQy8hITtx9x9V/2Z+oot2bVN3Ni9+qc+XpuSrlz95aMwbSgBo0DVyW0EqzvYg1e4rgLrTOi7cnlatmKSeo2kashUn137McImPCrr38
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99300395-9c7d-4957-9739-08dbafaf629b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 14:33:21.5108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjXM2K5Y+AFaRWFFgBN3odKU0l5qHF6ZHLYC9ovTtDoaROy54NbXvsk4cYYPH8E87zvhqkTxDakP/CDuZqI6pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070130
X-Proofpoint-ORIG-GUID: fsdBkOXoVyQ9UYyfjBmWkpCxRwrAbTLn
X-Proofpoint-GUID: fsdBkOXoVyQ9UYyfjBmWkpCxRwrAbTLn
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/9/23 00:27, Anand Jain wrote:
> After the commit [1], we unregister the device from the kernel memory upon
> unmounting for a single device.
> 
>    [1] 5f58d783fd78 ("btrfs: free device in btrfs_close_devices for a single device filesystem")
> 
> So, device registration that was performed before mounting if any is no
> longer in the kernel memory.
> 
> However, in fact, note that device registration is unnecessary for a
> single-device Btrfs filesystem unless it's a seed device.
> 
> So for commands like 'btrfs device scan' or 'btrfs device ready' with a
> non-seed single-device Btrfs filesystem, they can return success without
> the actual device scan.
> 
> The seed device must remain in the kernel memory to allow the sprout
> device to mount without the need to specify the seed device explicitly.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> 
> Passes fstests with a fstests fix as below.
> 
>    [PATCH] fstests: btrfs/185 update for single device pseudo device-scan
> 
> Testing as a boot device is going on.

Confirmed working on Fedora as a boot device.

Thanks.

> 
>   fs/btrfs/super.c   | 21 +++++++++++++++------
>   fs/btrfs/volumes.c | 12 +++++++++++-
>   fs/btrfs/volumes.h |  3 ++-
>   3 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 32ff441d2c13..22910e0d39a2 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -891,7 +891,7 @@ static int btrfs_parse_device_options(const char *options, blk_mode_t flags)
>   				error = -ENOMEM;
>   				goto out;
>   			}
> -			device = btrfs_scan_one_device(device_name, flags);
> +			device = btrfs_scan_one_device(device_name, flags, false);
>   			kfree(device_name);
>   			if (IS_ERR(device)) {
>   				error = PTR_ERR(device);
> @@ -1486,10 +1486,17 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
>   		goto error_fs_info;
>   	}
>   
> -	device = btrfs_scan_one_device(device_name, mode);
> -	if (IS_ERR(device)) {
> +	device = btrfs_scan_one_device(device_name, mode, true);
> +	if (IS_ERR_OR_NULL(device)) {
>   		mutex_unlock(&uuid_mutex);
>   		error = PTR_ERR(device);
> +		/*
> +		 * As 3rd argument in the funtion
> +		 * btrfs_scan_one_device( , ,mount_arg_dev) above is true, the
> +		 * 'device' or the 'error' won't be NULL or 0 respectively
> +		 * unless for a bug.
> +		 */
> +		ASSERT(error);
>   		goto error_fs_info;
>   	}
>   
> @@ -2199,7 +2206,8 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>   	switch (cmd) {
>   	case BTRFS_IOC_SCAN_DEV:
>   		mutex_lock(&uuid_mutex);
> -		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
> +		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
> +		/* Return success i.e. 0 for device == NULL */
>   		ret = PTR_ERR_OR_ZERO(device);
>   		mutex_unlock(&uuid_mutex);
>   		break;
> @@ -2213,9 +2221,10 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>   		break;
>   	case BTRFS_IOC_DEVICES_READY:
>   		mutex_lock(&uuid_mutex);
> -		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
> -		if (IS_ERR(device)) {
> +		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
> +		if (IS_ERR_OR_NULL(device)) {
>   			mutex_unlock(&uuid_mutex);
> +			/* Return success i.e. 0 for device == NULL */
>   			ret = PTR_ERR(device);
>   			break;
>   		}
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index fa18ea7ef8e3..38e714661286 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1218,7 +1218,8 @@ int btrfs_forget_devices(dev_t devt)
>    * and we are not allowed to call set_blocksize during the scan. The superblock
>    * is read via pagecache
>    */
> -struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
> +struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
> +					   bool mount_arg_dev)
>   {
>   	struct btrfs_super_block *disk_super;
>   	bool new_device_added = false;
> @@ -1263,10 +1264,19 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
>   		goto error_bdev_put;
>   	}
>   
> +	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
> +	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
> +		pr_info("skip registering single non seed device path %s\n",
> +			path);
> +		device = NULL;
> +		goto free_disk_super;
> +	}
> +
>   	device = device_list_add(path, disk_super, &new_device_added);
>   	if (!IS_ERR(device) && new_device_added)
>   		btrfs_free_stale_devices(device->devt, device);
>   
> +free_disk_super:
>   	btrfs_release_disk_super(disk_super);
>   
>   error_bdev_put:
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index d2a04ede41dd..e4a3470814c5 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -619,7 +619,8 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
>   void btrfs_mapping_tree_free(struct extent_map_tree *tree);
>   int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>   		       blk_mode_t flags, void *holder);
> -struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags);
> +struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
> +					   bool mount_arg_dev);
>   int btrfs_forget_devices(dev_t devt);
>   void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
>   void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices);


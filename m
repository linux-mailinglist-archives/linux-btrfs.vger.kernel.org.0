Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78FE7B6B05
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 16:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbjJCOG6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Oct 2023 10:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjJCOG5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Oct 2023 10:06:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E3EA9;
        Tue,  3 Oct 2023 07:06:54 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393DtnpK030987;
        Tue, 3 Oct 2023 14:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=DvqhEc1iC3iphDglpMmUuyghAi2LGCUa0KQv/AAfaCc=;
 b=tGTveXwPTEF0jBehwAjv6J5xmRVf2yGTqiyKg9d+8VddgsGzT7T5djkTVWzgfrojLgH3
 wSf/tfgy4KdSyr8g9K3uaSiKYlPV7sf2MZRwGufscHyeCzOzbvMsX/JbrDZvn8NaMOPD
 LlTV5Lo0OxMiZl6smGBWy7K8D9wynW+kNbXC9Z3qOKiT2GE2rVUo9jrzFLEvGq7FFCNs
 +9ImtW/R3SZMjsFkdOSw/lIFusnOXpG+Rp+odbgyXMFTdRJE14EkyNKVipCvyy9Tscl2
 vgOCk5EeETjV8rPrN8Ml5veH3rO6DwPGyYrGYoOAlc69bVAmbeaBmuoqp95YISP+5y4p KA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebjbvrb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 14:06:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393E18gK025727;
        Tue, 3 Oct 2023 14:06:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4cf48d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 14:06:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JP6npn0N9+bk2N4tAML8sygyHd3pry9jAo5TMxmX5zuB9blJhO8lUfdkg0MVvkmYFYifKuow1GxiBK7XS5fZem34XRPqHv/G3s/mNxtbJjmKzD8dgUgRd9qOBV1GF7wlZTbsIiXBJKjWpUrUcBYU/iDe1uFxavVo/hBpksUwIsH8B3bM6BUYYk88QD6jEz/+XukrEk+zqhX46pEiGFJdnJOsa7UwHVl59YdKgELx+NO0FGECWAqctikFBhFWVFpBGNx5o8FK7/chE7QJQsBMqatWTZAJl90MSxVaNLfVnAwg9jMwLz1wTmOW7x2mTXd8nflC0LUb9U7nezq9/Bruyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvqhEc1iC3iphDglpMmUuyghAi2LGCUa0KQv/AAfaCc=;
 b=NTEzmJUn66OM98iemhF43YUYXwLOl8rPEH1NVfLmKRQw+Nmrw6i/EuA7Ncv4mxBC5STFtNq2L5hbU6QZuPqT/kKgJ/FZOWG4cyDDZyR8Fvij8fUp2OvOF+1zCyUvQL8Hpj4VDUBnr2vpLeHiwK6lUGc39DiJ1auQLaRxL/3+nPruSCBNx64kAHDNnn+onW8T8+FlIJTsxB3etQB3hux/D9HUG6FHYOWZCirQNz9STa6BQfDr8wxSAmyEcWClsmhiZSWQ4v3i6du6xtUmVchH59eLhLwAMsMqnoCb5iSPwLZ6thSAz7qb9GP7Tcfqp9X2oK1Tauk5L9Sh0EFWkPhsQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvqhEc1iC3iphDglpMmUuyghAi2LGCUa0KQv/AAfaCc=;
 b=GwdT9BZh4s4ebAoZAJuA+gUyc6pdnFkqUUi+ijmRk643k15obZOnEM+KIiqjAYq6mULj/tsUP7jYkzt99IHICqZ8gXNXuc1hZzxNm0zGcQlCtoZk4m12JccXCr1cPAkWJ/gkNJYWRT6idunW5W73nQ+QFz6J91swGNxajSxWi5c=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB6738.namprd10.prod.outlook.com (2603:10b6:610:149::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Tue, 3 Oct
 2023 14:06:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Tue, 3 Oct 2023
 14:06:42 +0000
Message-ID: <aad48568-4389-4d2e-fb4d-803fc155366a@oracle.com>
Date:   Tue, 3 Oct 2023 22:06:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] btrfs/192: use append operator to output log replay
 results to $seqres.full
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1696333874.git.fdmanana@suse.com>
 <4569296ec5111e78e4507f3b4ac2d982ac452e83.1696333874.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <4569296ec5111e78e4507f3b4ac2d982ac452e83.1696333874.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: 6479f67f-8cfc-4c2b-a93f-08dbc419f7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wmz94/6Y6MKxxJeZQFASWkxgJwuqxL3VUm138rc08RKoQKppIouQQN39DLW3vfdx14qSL4CUnT+0QgQb+fe7MnqWDJnZkzRda8Bm89bQofmiQg1ylj3F2wsXTcl5ImV7QKjjfTjhVbRx+uVQFUjWcgTGWHrVU9v7jiT9GfMn02a/7xwvw9wF6cy9fRoB622R5VWm6tJpG5tCr8KuAQPYI9wBNo7qdlGe2lu+xJnG/Gp/dPVcoV03AjsjYzHFVIJMdZrSm+zqMu87S4KuxWyBTzDIhAYzLn0wY7lyCqunzCGwRekVPsB47iYrSC9+fjoX3YEZF4AT9+At4+lJ9A2gjrqHTlGNLHVp1Ux8lGgFjdFz1egFr/LMxmUY+tt3GvPazAEv4UTySVQ4zGwhLzlPKXFyFWQqOxfjJDj5Pld6hbJi2nQNOXGWhbp8jPvwnYH6cHXTB6Nv4ndqednmraWNQFPJ4cN+U2GHcU5c3YWgDd/xPpqTSKvjY5OR++uTHRQU0NgqZM+P5amBxfSQ6Qn0RIPbt4PihtpG5MwwZlHDquEJxRp72j9fPP20cl1PPN4fSWURH0wiYHWJO1smGOaUfq8H2O/2KTFdCNNXy0MaXzk2sCZy214yT0A5jJA2eesjakjLFxNl46tX1sfqo0merg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(53546011)(6486002)(6506007)(6512007)(26005)(8676002)(31696002)(2616005)(5660300002)(66476007)(44832011)(316002)(38100700002)(66556008)(8936002)(4326008)(36756003)(41300700001)(2906002)(86362001)(66946007)(6666004)(478600001)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVlzRlBFTnlzV3pPdUYveXE1YmhlMGltcnl1VFlZeTZBZjR0alQzR1JaRjJY?=
 =?utf-8?B?dzB5VFNaSGhNR2RuaWVSc0JEOE0wRVQ4RGo2NE9ReVZPL3ZFTzZ4a3p6WEZw?=
 =?utf-8?B?SVJLLzB4L1o4QUxUbEk3OGdDODZqTndkdU5zQWpTUWMxVm03T0xQdjFVd2ly?=
 =?utf-8?B?eGlHa3ZNZTVXOURPaERrZEZpSEdZSjRHdWZPclgxNW1EclNYc28zaUVlR3pI?=
 =?utf-8?B?MzgxME5DZ3dwQVhiNTZncXVoM0hBVzdNRjlMRGdVMjRKSmJORkFjVm1PSU1Q?=
 =?utf-8?B?YkJEV0hGTk4wamxXOG1tcy9JOFZUODZKdjIwZnpQUGI5RzR4OU5VR1JyMjBM?=
 =?utf-8?B?OUFEU3VIdmhHRmQ3bVR2TzRlU3hFeEhUaDRIN0FieTN0dnN4N2d2S2JPSnVt?=
 =?utf-8?B?eFZ0em41UUpBL20vRy9MdzBXZFQ1TWo5Q2ZjYzRFTG14bURJdk5hV2ZOYUdX?=
 =?utf-8?B?aXhtNG5mVURJT20xRlJYVWsycjh6a1N4bVQyd1k0RG5tSFJMYSthWWhoWDdO?=
 =?utf-8?B?UWpuRXZaQ2V4aDVKaisrM3VLZjBtdzl3aUM1d3VXdkpYRlU0eWZFVUlLeTFl?=
 =?utf-8?B?eDRqc3BadDRnRVBMQTVMUDl0cXJhSDU5TTJBZ094OHNwbURsQk9hay90SW54?=
 =?utf-8?B?SWpJYkc1T0pTRkpFWkVLV3J3bW9QU1RPWW5sMVR4aFhTeXhMT005a0hGLzA5?=
 =?utf-8?B?RkZyVlZHTG9UbzI4WCtUaWp6UjlLRE5TYm9yd2ZTMlV0Q25BZWxzcWRUdGU1?=
 =?utf-8?B?Y1l6bkw4WWY0ZkcxUDR1Q1BDNDNkZGpoZ0lTRWtvZ21HdUVsOUNxamFEdytD?=
 =?utf-8?B?WCt5VzFBS1ZDaDQ0Ui84T1BqbS9PYmtZM3E1SXU2WWhWbzZxL21NUFlCaHNS?=
 =?utf-8?B?ak54aE1XUHVZcDlieHR1dld0UGZiVzZzR2R6bGNueENGcmxuODl0QlBsV0Jj?=
 =?utf-8?B?OUd2SEhXNVQ0NmZkR24waUVINjB6R2E4T3FibmlCZTEyMmtTRUl4cnFZaTlG?=
 =?utf-8?B?KzM4Sm94L0NtWmgrajJBQjZDNjE5WDFKb09MQ3dadFRRRGI0SUg1ZjlhUjJZ?=
 =?utf-8?B?ZGRZS2RFbmY5OVZCQWxJYTRBcmZ5dWRFK3g1eiszNHhqWkdrTFovZmtYeHpD?=
 =?utf-8?B?NzB5UmhCSFR1ZDlVd1ZIdW5QS3A1Z3NZV3Y0S3I0OGg5YmljRFRsK0VDRnVO?=
 =?utf-8?B?QXVWVXduWHRpbytQRUlUVXhEcXRpcW9XcUpuMWRkdHVodVVwRzVnNXdicENZ?=
 =?utf-8?B?aGNLaXc1RE9TQW9mVnZtNllnSjJhd3VBM29yWFZ4YWZaQ1NKZEJMaE9Nb1Rx?=
 =?utf-8?B?MVZ3QTgvT0NxNWR4VlJvNzJQYi9mM1hYT0pXaElZUkZ3MGVxSElWTStMQ0Nt?=
 =?utf-8?B?Rm1UK0psRkp3a3ZqK3kwK3Q4b0JYb24wUnJiclV5SFY0T0Vsa2xwT29xdlFP?=
 =?utf-8?B?ak1hN203cXlEUUMvTlpXUnhVOU1ldXpGQmFkci9iVmFta21NQVNTVWtpanQ2?=
 =?utf-8?B?aGtVZlp0L21EUEJpMHdXOGd0RDd6Um9HYnJsU1BZUGtvZmRZaDJrMEFTejJU?=
 =?utf-8?B?NGdZVWNvNTNUN3pBUGRVTXNVVWMxOCtwRUE0NGw2MmJvcDJscUg0TEFzMmdX?=
 =?utf-8?B?alZtcFJBbWRVY2lwdjJ0R0FhdDlCbWdxKzB2WExGMjhTZEZYeUdZdGpwbUUr?=
 =?utf-8?B?RnRJQnJ1dXE2VVAvWldsZlF5SlFWcG5ZKzBadVZOL3dhS1B4bCtpeVBSdFVh?=
 =?utf-8?B?aVNJTkZCSjZlVDZQQ1hsUXNod0Uwb3ovcjhacmU3Z1M1WFFIZitLUFRuSkEv?=
 =?utf-8?B?aVJkS21qc2docWZsSThsQWhuN3RGbzVFT2FNOGNkUWVyKzFGbDBaWjRFem1l?=
 =?utf-8?B?UXdlWWR2U1c0aGdESHZyM0d4Mzl2WXk5dExkZHBiUE5xVUJRMFBQZklxWmlQ?=
 =?utf-8?B?K0UzZmZmd3czQlFXMG5sSkw5alhpb3VvSWhrUWFnZEFjam16a3Q4K3RtTDRJ?=
 =?utf-8?B?cFdYZmFhQ2x5RkJPNlpPOStIeTVsT0ErQlVSMkF1TzJYOVFXNDI0YUJYRHRS?=
 =?utf-8?B?MTdnQzZsekQ4ZUx1QkVjczBsL1kxdHZ3cUh1Y0FPZU8wRDI3dFFod2RpNTFP?=
 =?utf-8?B?a0tOdlVhaHZOWmJ0ZVFGWnVWRUtjTTRMaDRmU0xVUTFjSFB3aFVic3RRYmVz?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jAH6iDWTJsCGv/LWVZdDmLL/6B97hBTRU0BI+RGGYmjZ/hCjmc2TWy6iboR0DXhUGX/Ns9txLFo1yYRcNMUwhFgA5oRhEJAmaNE3RZq57haeBUKLhaznW1/TpROslLnp8wlI8S/Av0OdrJyXbkPshdRrbSiFNLphhI8tm6Xng/acQuG1BKFf6UJ+pYlmo2hMgX4FDpp/7aelr4TBRgpWPUVa/zcpDfPanS6P/RaqsRWqecsuzgPLUG35CbI2PtK2XyRQeC/J97huDzjkFkmEN0Kh/JlZKZqRrXsFNnpDxAyCXObZvmK6rn9FaiQ7r0aj3D7XGQOJ27YX5OzIA0PBvpe05l5lcP7dQzqnhUvj8FGPsr5Lsp0SMVd00Wk/8B4bdq4M2zbWXBjrIt5J4Kg23vxJm4oh2elEBvZTgNnxLPh60gt0vpiZMtsmIACWOmcRVGh7WjSGiMrh25AY3jtY6C5uceo+/bcLxWJckW8NGe02dafGDvPJTy2e3kQYXV8ellAlfH8PEfA/NBfYm46XgHVzyD4ovzD7Dt1fDc+7oH2vdweyf24zyMQGA+ZYwKRH833i/70K/vc1FPlf3oT00jtdO0Ct3QftPU2VEzesjmU0bSXFewZPe2A28Mx0P3pCRg87DZoaScxbWj/6m7GsJc7ZKv9XIVbp+9CvFBekoTzrFPakDngN12UzxubpAiESewda9/7t3nlI7OjhCoH2Da+m8T84b34ureSq9ogfbEeicMQ58zI4UcN4pIXPHhY0Wu5Z8qO3oIA8zdb07MR0HAynwb9feGAtWUdRWFc+1Y9hq9xmJ/oT0yjDGpSn9wYV
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6479f67f-8cfc-4c2b-a93f-08dbc419f7fd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:06:42.2519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhGQ+Fw7dX2XdKMakOss5VafofQN9jDWdP192gucY6NtfWQG5SMkONGzmTRKpxwsRDodAYKdR4K9IUxkY4wFGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6738
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_11,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030103
X-Proofpoint-GUID: pJlw3tUQL0csDpCULS6YQK3DqEfycSRq
X-Proofpoint-ORIG-GUID: pJlw3tUQL0csDpCULS6YQK3DqEfycSRq
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/10/2023 19:57, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> After doing log replay, btrfs/192 is overwriting the $seqres.full file
> because it uses the plain ">" redirect operator, instead of an append
> ">>" redirect operator. As a consequence it is overriding the file and
> eliminating any previous output that may be useful to debug a test
> failure (such as the fsstress seed or mkfs results). So use >> instead
> of >.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

> ---
>   tests/btrfs/192 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/192 b/tests/btrfs/192
> index 80588a3c..00ea1478 100755
> --- a/tests/btrfs/192
> +++ b/tests/btrfs/192
> @@ -121,7 +121,7 @@ log_writes_fast_replay_check()
>   		--replay $blkdev --check $check_point --fsck "$fsck_command" \
>   		&> $tmp.full_fsck
>   	ret=$?
> -	tail -n 150 $tmp.full_fsck > $seqres.full
> +	tail -n 150 $tmp.full_fsck >> $seqres.full
>   	[ $ret -ne 0 ] && _fail "fsck failed during replay"
>   }
>   


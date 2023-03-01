Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E33A6A6791
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 07:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCAGQL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 01:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCAGQK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 01:16:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385363864D
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 22:16:07 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SNE1Yu004859;
        Wed, 1 Mar 2023 06:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hWyZobq9tWb5B8R0OZ+hTURjYTzFmRz5LgNGmMjqpuY=;
 b=LQBn+pGxndzCqPth68rF6VGJhuXEuisM4FhBCjYHjEDxrj0f9ES0NTmWNzp1uzuTk6/O
 FsInTlJkWE2MTqpPcyTPiD3+bSi7PxFDALchAtmDCpep/Z/NYWYo0y3P7V3y2aPetNe1
 5zBTQ4RbsQ7+DgKmciO+vPJHxfqqp3ZlfWb3bOWhhLawzbjcBKKnoe2189pyzDV5uw/7
 Wf0rxVHAc7rdqKGkJ8k3l5kiyUsUCgBQGDFGiXGIJZxQ4vE2lQ0NDgzinhWJZMgMon1a
 /PUpdO2G2pmGhCkJc6Y1eqVvjBzwpZrHqfpoEnrI69kGWlCAg5aIT+kZl+tZ03CLS/a+ Dg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba288y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 06:16:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32153oCE033053;
        Wed, 1 Mar 2023 06:16:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s7yp5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 06:16:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTKZlZQkjl4T9qSt0JxMEY6XCfiNAHVNrWoUHYGgKXsxL82Fw5w67IVQlfPiURPR3lhtxRq2nz81ZP3BTkuyvHfZc2a2Uw5bhktHDNh/s2IRdNUoIiNOVD0sHLx7YZHTcva2gfHF7aoORmnb4hzhUmM5IypfgclkiGFBPtT5tRPfwdUfKaibyR0KrpgPCi29OZlvMHC3AJdP1iquyBbb6rnI97hV9CicLr15YnUXMgunFMKOIMwN1B9R0Ap528aVrQxVfBxgTLVXAK/iWV7Me20pTFs1EDfXK7EoQDOpUulkhrj7uPz8UyYUlRyw4H4L8rWR0q+Xu+IG9wSa4TbDTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWyZobq9tWb5B8R0OZ+hTURjYTzFmRz5LgNGmMjqpuY=;
 b=S7n3DqFAKYOYuTyF7n433Yo25pvnZFRqBCPNOZgi1LTpzgOqw4VDUkD95WbXpVIaOPUmoouBzLky7W1Bnth7X+zKbHNxPH77CWrwfAUnVH+5SFWT86QCATHDt/nNpx4ZZW9WNvuEBQrL5G7dqyKDFzwuyViD0AeHqEVxEDjOxFgAxKjC44SMyb8fTZvxrEtm9aTHAQjf48T3F0bWIgUnCthriuX441+y0KECbrtTAjl7eBIFKTTaInZaYx9QWjC9Bt/BqHUkREW7zWNlQLgvInQAY5rFClp2PMTJUGcbTpWwJD1vT7vd3+ffh4T82zz/9CIpiLlnMjYAvWo4no7YPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWyZobq9tWb5B8R0OZ+hTURjYTzFmRz5LgNGmMjqpuY=;
 b=YdWaIZBvJ79zHCfmv7BU70u4aLSgSaUoieE77eXaoIQruRNkP287/Fe6PbTqe+7EZbroLQAxQTt2Tn6NdPuyhOq3rDI3hAoGqVmRwi5wemJPKLo/qNtz2+DWYDSBVAInPwdkeYbZ6SUT9nOOfTMDGB1WnzemPMpXMYiLs6LHEIE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5340.namprd10.prod.outlook.com (2603:10b6:610:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 06:16:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 06:16:01 +0000
Message-ID: <02600387-c3cb-9c47-8427-501e5f115f92@oracle.com>
Date:   Wed, 1 Mar 2023 14:15:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs: open_ctree() error handling cleanup
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <3a0a3e3ff11bf19afdf600b4ae42f49acd71c9e3.1677545065.git.wqu@suse.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <3a0a3e3ff11bf19afdf600b4ae42f49acd71c9e3.1677545065.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0214.apcprd04.prod.outlook.com
 (2603:1096:4:187::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d231490-ca38-46ec-ae56-08db1a1c6dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Lxak7UvAlXbEQ0cQ3VdmLgrodogVKNIfwwtt1JjVixLEl1OxY/FEx/yejgxSi0RVKw3xfsRR6T1HhdUuVCmVRm0mc/vT9pd983iZg17U7FPCYdWcYG+E+C+W62e9819kbBWXGmJEHsCrBFrF9g21ES5uHDqBQnVtQI2Wnp5DhKdEk351Y3fyQPlsmqzPt1eLJtiuDoR+ELnBBtBc581Zv1xJwa8mn7uFW0YE0NjcM4tyVpIZ0jHzzD1gScce97CqgLBgF94Kb3f+4sKl7qGgB4eXS78PeyHrBi3P5YCQs8+jqf04CQO+XcRMMR9Y/LL+92DrB/j4KeaL/3DAx5gvsP4qVC3Ef3/CZBeqd3d9dXuPmnmxxzaMpSvF7rpk+cFsxudtwJLjnAG7MMcqsuT7qqmmzPORMLtE1TDaA5Vch9ec61yAhqmVuTv3h60cYm5Ez/grghfpiB07BiRbb8xfNraKiO8ydJnY2G94igE+UBhvVqZ5Yqj2aYbYCx8Pim9YRr1Y1gjZvm4ljRRxX6YEzd/bnYQ5EWtxbVEFy3VLv6QuDxrvGh+x1nmPziw9qrUrbS0CLDoWKq87AvAZARDXPX9y0IE4Endhduo4D21P3kZKWPVSbPTn1d4lIePWEDOOG9Dw3ZQfHam+MZiln7VGs0etidz24Gu2Gq3bhk9mASiSNj9IrgO/h61gEVjMuVwpZa2UPJEnLHUi+WQvwaXhoNgoW6afYZre8mqrhesv1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199018)(31686004)(186003)(26005)(2906002)(38100700002)(36756003)(478600001)(44832011)(53546011)(6506007)(6512007)(83380400001)(2616005)(316002)(5660300002)(8936002)(6666004)(41300700001)(31696002)(66556008)(66946007)(86362001)(6486002)(8676002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWNqdkVkOWxWWWlIaFprdzB2QWdKeTYwSVRxK2gvY1Z4czRFY2JYaFl5SzVs?=
 =?utf-8?B?aU5LWVR6TWdmakZucG5nVk9ZWlo0aWsxS3Jyd0Z0T25NTTArTG9ES25kTzIz?=
 =?utf-8?B?M3pXcHBYQVl0RkdEd3Z0cUpubmIvVTVieXAxNkVnTGpWa1JCS2d1b1MxcW1s?=
 =?utf-8?B?UzIweGZqKzVobEx1MG5CejFOZTNURVc4V0w1NkwySmFJbE5rcWUrbmptQ0JU?=
 =?utf-8?B?TWFtcVg5VVBUTW9BRmplZ1ZyYzlBMDZGSmZYWUpydkxXWlE3cm51bS8rbXFs?=
 =?utf-8?B?dUNERkxueTZzTVdTUWt3bTZaNFc0dzNoaEE5SFNHdFpJZ244eW8rSTlyajNX?=
 =?utf-8?B?UlZVOExYLzNxWjJ4Z21sRjlqSFhyaTJCaWhJWW0zMlhvd3l2RytEUG9HREJz?=
 =?utf-8?B?N1VzUUtqdmpyV2c4QWJKYmhnZ3BJNkZPUlk1c2xpQlErMjRsamJDVmpQcWNm?=
 =?utf-8?B?b3M5VXdiWVNEdHVzYjhHbW4zdXlVRXNBS3ZEK2VJQjBmaGNSTDhveUcwSktu?=
 =?utf-8?B?ZUYzVWlwb3Fnc3kyL3Nxb2l4Q1BkNWdaWjdJbmZiYStyME5MUzA0ajdDTEZw?=
 =?utf-8?B?bVQwTkpvU3JEajZLai9GVGZBdzZ2ckJtQ21PUVgwejY0TDRqcWFEdy9vd2lE?=
 =?utf-8?B?WmdSSU1iZkVvVXBqbFBEcGw2amZMekJYYTVZRG5DZC9EdlNxTFFxZ0wvUFRh?=
 =?utf-8?B?ZElucHBGWElRbmZDcFFLSzZmOTlaWTZ3dmhGRXhBUmNoaFJzQnV6NWQyUWd0?=
 =?utf-8?B?WGNmd28vTWdlUU5OK1BycmdxSFZuVXpxRFEyalBsQlZQU0QraEF5RzhaVEY3?=
 =?utf-8?B?YjY1aW5UUlo3VU9wblZTUi9iVkhXMlcrYVZvSWxWS21SRnRpUmFrZzFhNm85?=
 =?utf-8?B?NDdrSWZwK0czZ016RVZVc2JXMWxvZlo0Z1FLNFQyRTlLZmJwdWsyRVdnaDNO?=
 =?utf-8?B?RExaQTh4eFA1Q29jendZYlBUUXJITmdDd3hJQW1WeFFQYXhuUWtZT0ZIeURw?=
 =?utf-8?B?YndidUh0UUxZaUNkcXNvWXo2MHdnUVlKdzJTbFZUTkYzYVdVTTRtWWNCL3FB?=
 =?utf-8?B?NHEzZnI2MU5TcjdNa21OeTFjbDVmbXpKNm9kRXlpSE0yWDhnN0VPWElaeFpU?=
 =?utf-8?B?MDNFeEtGODRxZ2xRTzRqVkFJT01tOVVLWmc5K0pYRnB1SmdMcmUxZmFOc2hF?=
 =?utf-8?B?V1FjWmdTVHhqakZTbFlWYXo0REx5aFpnZHZYbGZ6dTFZYjdpdGlmeGowL1Zx?=
 =?utf-8?B?MG9mcWdlTTE5Uy95T1BnYllOa25Xbk1pdXBxRzM3ckdwU0xjV0ZkR3NsNCtU?=
 =?utf-8?B?SDZsb3JjeDE5MCs0OHJIZ0dsSG9JNnFYRU52L2RGanBreE1rRTBDa052Ujg5?=
 =?utf-8?B?RDhjNkhNYmlaVXlyaWpwd3JkS3QzNXdVK2R1d1owbWE1dDMrV093N3RDMFJF?=
 =?utf-8?B?RkpsVEg4OTNqOFBFT05rbDNCUlordnBNeEsweXpRYW5BU3dsbFpGRWZmSTM0?=
 =?utf-8?B?Q0x0aWpkSTl1a2d4VW9mbWVlczE3VHl3QzhFY0tNa3FFYnFadkM5ZUE3M1Bz?=
 =?utf-8?B?czBlRHI1N1RlQ0dGcThvRXNMUitOc2tCSDhWOUJBZ3R4TnYrb2xIQmtBZUl5?=
 =?utf-8?B?aXo3VVlpaEx1RTU5emdLdDV5am5GUTZwRlBLSE1ZK0t6aElZak96Smxpa1ZM?=
 =?utf-8?B?WWlJOTR3cjhXOVkwYUtLRm8vMHJJU2VmSXdtbnZIU2RqelE2WFJDRE9jQTQ1?=
 =?utf-8?B?TlRET29zNGhhUGN6M3dUOXR1aTRSTjZ3YUxmMVBTZThpNTd6blFqSkZKQk5I?=
 =?utf-8?B?VDZJUE54WWlzRXVLcldZb2tnRkdncURkZSt5MEMvb3JmRC9FVEx6M1lIdnBB?=
 =?utf-8?B?Nk1KcklzWDVic0phWFVraXJFbXE4VnpiVGVJTHNXd0FSbVM0WXlrNXg2VGln?=
 =?utf-8?B?LzNlMHBqODNldW5yUVUrMzB2d0tOcVlWSE5qRDFrT0gzRElGR2ZJY0tVT3pK?=
 =?utf-8?B?ZEFENjJ5aHRUMVE1WUFsc1BRKy9SZ3JJMW45OUhLbHNvQ1BUWTNKRkN5akw5?=
 =?utf-8?B?UEVENGl6S2o2QnNpTlBRK3IzbkRkQ3hwbU1OZDNVbGtuUFMvSWhCNTg5VG1q?=
 =?utf-8?Q?YORsB5tWX3VBGJQRGW5b8wb82?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v7Fm4osLkQc+jZDfQbL3r0P9a+4K9LrNyxL2e78ktBkaIp9VNFPiVMWVMUp/iEOVcqpujFg3eVsGAIHlssH1D9hCJyxv5RbmO2V4OyEUZeWwi5OxMHa7IcOmfsN2BpShsT8LXbzz++R69w+5F1RvLdvf3gb0Zy28PB5JC//Ca79nO5Au7pcr32xmX/cXbVJQF5XC/uBbmAAzh0Ev0PCOzq4Zyb0KPR++aVkk5jcaNVfl6v/KFgy8YXk5xUXnAHv3fcNwx3hO/6BlzmROfuKZBpn2RJ9u+DqBwQUq9nLPL39aImLksqN/rXj16nuZslsztDqox4qVLsj8xm5c3L7cI+x1/VL3i2xf9GZTDNZQCFn7QArMHxevJAYjev569rwImwKlvRgAlQAZQqG2M9FVnYshLxoJnDflfjEMSm3DwBZpXQae5QQHczLeS1uUXsk0yU9v8cXpbr4FapfkWqMhmPG2LAvQ2sKG4F9PHLzbAKfxWJQxIIgkfv23GZknYV21/xs+PDb166FYEBp9nD8CtmSPaEcwZIviK79hYqjUD4/6ZXkDDWz2qdx0OH5zSCTxS6/bRF2656aK/cahqXZ5c3BfF3uH3KKOPo7z1gheuBLEeHjoqjctBUHnADkyninzuL3ACOn5uEkwjiKU2J64kb3PRKQ9OjueTBLeOSErx2nyhirZ5Ca86ziDKzFa3JkXXSPw8sseLOkHW9i+j4nfyOfFvScB2LLWWpWMVtVTLtReJ2TjEp/P+4N/jWEo3JgKv1QVcxoBGOK/2iZDgZc0ovqRMQHZftpQKRLlo0sdcKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d231490-ca38-46ec-ae56-08db1a1c6dd5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 06:16:01.0308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJHx+/uK6npJwceou6Ky+btgH8RyXgPrtHxZg728FKLgfU6OxqGT04iC/G7fl9G42baLNppy4UvN6mq/wfyy2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5340
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_02,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010048
X-Proofpoint-GUID: u7GJxVNuVBTKFzIyDy1FYQuxfl_KoN6M
X-Proofpoint-ORIG-GUID: u7GJxVNuVBTKFzIyDy1FYQuxfl_KoN6M
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/02/2023 08:44, Qu Wenruo wrote:
> Currently open_ctree() uses two variables for error handling, @err and
> @ret.
> 
> This is already causing problems in the latest misc-next once, and it is
> already causing more hidden problems.
> 
> This patch will fix the problems by:
> 


> - Use only @ret for error handling

  So far looked good.


  Nit:
  Further changes below could have been in a separate patch,
  as those error-codes persist until userspace.

> - Add proper @ret assigning
>    Originally we rely on the default value (-EINVAL) of @err to handle
>    errors, but that doesn't really reflects the error.
>    This will change it use the correct error number for the following
>    call sites
>    * subpage_info allocation

  On fail now we return -ENOMEM which is ok.

>    * btrfs_free_extra_devids()

  On fail now we return -EIO which is ok.

>    * btrfs_check_rw_degradable()

  Remained as in the original -EINVAL.

>    * cleaner_kthread allocation
>    * transaction_kthread allocation

>   	fs_info->cleaner_kthread = kthread_run(cleaner_kthread, fs_info,
>   					       "btrfs-cleaner");
> -	if (IS_ERR(fs_info->cleaner_kthread))
> +	if (IS_ERR(fs_info->cleaner_kthread)) {
> +		ret = PTR_ERR(fs_info->cleaner_kthread);
>   		goto fail_sysfs;
> +	}
>   
>   	fs_info->transaction_kthread = kthread_run(transaction_kthread,
>   						   tree_root,
>   						   "btrfs-transaction");
> -	if (IS_ERR(fs_info->transaction_kthread))
> +	if (IS_ERR(fs_info->transaction_kthread)) {
> +		ret = PTR_ERR(fs_info->transaction_kthread);
>   		goto fail_cleaner;
> +	}

  It appears that kthread_run() returns the error codes -ENOMEM and
  -EINTR. However, it is possible that there may be other error
  codes as well.

  I hope that this change will not cause any test-cases to fail,
  but there may not be any specific test cases for this
  particular area.



  Otherwise looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>



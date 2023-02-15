Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C208E6975B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 06:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjBOFNz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 00:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjBOFNx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 00:13:53 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCCD6EBA;
        Tue, 14 Feb 2023 21:13:51 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EL3seq016207;
        Wed, 15 Feb 2023 05:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Y8s2oGxo+kYC6Uo/JUTBvsifsrkyPz9ZwRyxiFPZT/g=;
 b=ZVrK2PMCERiQvZd6BM/rairS9/uPGtqY7LUUjpYr6VX4uC+c6pc+l89PaWMh+3Z3DDf6
 abPfSOQvWSXC7mrG3Sr1VQaLUqAMP1lElvWYwoMeC3oUkkarsx+KZlbiHzLGFAoxI7TU
 kTFw8REG5H0tnJx+80kcgiYVUEo8kgZTKn+WJTdCU0BF4yRQ9N719qX3WTZFSXhq2xI5
 nH1WvPVpe0V8/oXRpFYfVs7FOP1TIlLSYzMj+4vir3sZHTSmyqjirGeJ2noHDozKdqvs
 u0XB7meBAyAGKqkqxo/nspUdyPuUzBqgjjnU0DpOLXoNA84NN96PA/UGrH7Vv/Ygkwdq dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1t3f8y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 05:13:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31F30OjU024616;
        Wed, 15 Feb 2023 05:13:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f73dv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 05:13:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fo7J2ufqcmCeCqNB9UrOqgPXrFBMd6rUCyURRlZGj9g14XgpsV7VbRLFXtpryFBWeJUR7pEb9bxY8x4n2UCAeLUsSgvGSo25vYlUYqOY5JfI0ygyxuvJPBOCR7OuCXn19zHDOG26IUN677rmICP2RQqezxevkN/xKHw+lnEmbJ2d3HWlWREnDTNTIsBqwGaIBi3NFyTz+n4qHbfwtV06rW+avVSDzH8j0PPCZAOesgs9IJF7OTqLjdKAPF6Wm3irpz4t/LgB7x4i2qqEHEk7874vWPtjoLy3CybLkCq9DBA1Js6ZY6F3GZu+3GBuH0+7i2VQ438e2dlnQmF1Oz6aYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8s2oGxo+kYC6Uo/JUTBvsifsrkyPz9ZwRyxiFPZT/g=;
 b=Lk+QhPinMUJ5oGckC2wLpbGiqW1u9kXP+QlVuVxDL8/HQ5UMD/WlgekZ+xJLT3oGYRcnQ9fFyCMngFmMCd/D6NXxu0U1OVV/vESPYBw8dTG6yeO8ZXDvomDmuybJNlRsyPXDQp3tgEDYrmcOtHHn4kqdDIOyv7W+/uK429fb8eEqj2ZBxxjhxWWdW3WQqiLvDH3B7gxP37sEhHfj6syGZ9OnbPAyKdRzpXmBoF9BC/Qqj7tFjS+ucNy/QwBdlxQLDQ4GTR1HUz31ONxQKO17UKUhrPFCr2SpcLEIOFTiMbeZRjOU7N2FOEoK+p0wQmX6VH03JRZVXlQMTJDZmqVySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8s2oGxo+kYC6Uo/JUTBvsifsrkyPz9ZwRyxiFPZT/g=;
 b=rbKoDx8j0k1SOqxpI3amvx86Ra9rZCki7TGDigUCEh0nQElqj+tPn8MP7iXilhEAoxcnK0eKG3nc6Nkq5zinON0ZqPDmWip3tqun4EfVCAbUAml75GhKgVGUBjviSYeVIWtbPP8H7QOBcCBSQeZHRCkWexYQlI2w2KPVRVaXslI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6263.namprd10.prod.outlook.com (2603:10b6:930:41::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Wed, 15 Feb
 2023 05:13:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%8]) with mapi id 15.20.6111.010; Wed, 15 Feb 2023
 05:13:39 +0000
Message-ID: <8793a090-55a6-5d5e-4f8c-e01eaab75eb6@oracle.com>
Date:   Wed, 15 Feb 2023 13:13:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] fstests: btrfs/249, add _wants_kernel_commit
To:     Filipe Manana <fdmanana@kernel.org>,
        Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <a9970cfc5eef360f6eff8cd24b41f50c07c1d744.1676207936.git.anand.jain@oracle.com>
 <CAL3q7H59UW_=wBo0HW97+RNUHPt0+3FxEN7aCT_dx6bzarFDyg@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H59UW_=wBo0HW97+RNUHPt0+3FxEN7aCT_dx6bzarFDyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0148.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::28) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 09691671-1539-431e-c265-08db0f1365c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iK5GLdni2iljDmxKRkZLusjsbPUsR5bHhoxCzReGGV6BKUIaAYmBv6d4glusxtH5YnfIa3JhubliGHIUneQVAypeVCoVKFDSlU+oSBI/4D4kTmHK5rGLjATQ8rw2KcQVkMavWOJt62YyydhJBxYkVhBBKW+TUL8wIHQ19MYwYpqOaALoNe0tbC43wEnRXhrLhp5xCivmRVpCTA3UlTi9qJDZY2cNPXO/LOAstLh7jTwMV3pZScYseFUjS2/VagS8pz8kiFkhBuknEq22TuWNR3R51L5hRDKmFtnZiMHGBoGy2ePMQGDXluHx+gF2B2ln4mJkoyjXM2VyTxPQmfEfrPb+jEncdipyVI+ktQm8Ww5h8s3ptKJ/r6nP/umWKLgVdCgSpfiiOyhKxp5D+FtSU9nyGOBMbmeguja0gHUggnYzBpEIsjb06qvokXBct2GmrnDL5bT/aoXsGSz1MjEOPzgHDtb5PAkXzENXwxXRsgY+9o3ZASBL3P13c1pZ/h7M3pfG3EvixWJErHZ9ctnF+3VVsvPWDfpqXXDJbJ+q9+VK93wIxXhJ2Dic+aPcLtJX75JIfXkjlBcmRGgvafuUVI8i9O4ltlM5umFAg4/tbiuTUih3ZD4Cr/FkDjlJV75jDIHbtF5xWhLOwraWQPr4yFeChQ6cBWOsXs13pK+8VxdXaR4Mr5XEdw7o1WCH9B3uf+JNk6J2atk9o/YQjKdNVuwGMGa8CDKD9nSWyNsAfU0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199018)(8936002)(41300700001)(36756003)(44832011)(5660300002)(2906002)(110136005)(478600001)(6486002)(66476007)(66556008)(66946007)(4326008)(8676002)(316002)(38100700002)(31686004)(2616005)(53546011)(26005)(6506007)(6666004)(6512007)(186003)(86362001)(31696002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUJ0Z3hScHo2REsveDFUVUpYL0l5WjVyaVlQUW8rdy83QWhGNDdGeUQvQXVq?=
 =?utf-8?B?STRSWkc4cFNCamc1bkxPSWRhRkNjMEV4VmV6eGxxRnc5Z0RwVGdpZUtqM3VW?=
 =?utf-8?B?aVQ0SUZjaUVQSERLWmE1bERlWmZYbXhNc0VNZWJpWDRNdzl3TEx5ZElsRjc2?=
 =?utf-8?B?aUllKzFrQll6Y1ZaVFA0cXFwNzkrNmR5dHAvc0JYUWsrUGdTR29VS3lrQkNM?=
 =?utf-8?B?YWFnNGxRQ21uQTFEVUd0MkZENTBRUTVaRVBBLy9JY1FiMS82WnkwYk8yNnpW?=
 =?utf-8?B?eEN3bGhyUWFQWDU3UUdqYXdOUy82UitKVzRDOXFsYUFhZ2ZoMU1yR1Z6eWgv?=
 =?utf-8?B?YmNXc01ERjlvVG5LaTgzTldNbUYvRm8xYUN6aFdJYnFXMFoydlMySlEzdFZS?=
 =?utf-8?B?ano5TVBQUDFFczFZUzZxeFZFTFdYTWcrQ0p6bjZ4cVN2M2RLUmdIK3hLOFBl?=
 =?utf-8?B?UVRMWDZjWmoxaEMrb1hFdWhzbEMwbGVaT3hXOFkxdmxpeGJXMGNTSUEydC9E?=
 =?utf-8?B?T1FtTFFMNHNFaVVHelR3VHhsSDJ3cjFJQlFEdjFacHQxYzRmU0hLNE1wYVR2?=
 =?utf-8?B?eEw0eUVuQTZ5VllkQjRESk1lVThJTjZWVEMvMzQzaFVlTmZleTg4S2l0K3U3?=
 =?utf-8?B?c0FsT3QyVE84RXk5aU0rakJWVS8zdEVjejJYMU4ybDVMb3JJa0ZReENRcHlY?=
 =?utf-8?B?Z05KVDNJOUE2VFN1SFVkdUlYaGJWdURpVCtyYVhZSlBKWnZURkl6T2ppcEcr?=
 =?utf-8?B?MTk1bjdVN1ZOUy8zWTN6TjFybTUxZUFFOEZsMVV6N1o3Z1M5YVphM2NiWDY2?=
 =?utf-8?B?YUFsNDVjZHk4T3N4TnozOGlFZjM1aUVmTEtKRG9zdlBJbENwWHcxQ1hNR1Zz?=
 =?utf-8?B?RXBOaklvUnM4VjRpdnl0eTNkeU9xQW9ybXA0OVVOeWdzV25RL04yZTMwYXkz?=
 =?utf-8?B?d20wNlZ3VE9vem02ajRFQUlRNUY0eGpObW1WVnJIa0V6SFNiWGx4WkhrWGNG?=
 =?utf-8?B?c01XYnhDMXFVUU1qNFRXeW9ydjdwVjR4TURtcGttWWl2S1ZmOGhiNUZKcDVa?=
 =?utf-8?B?aGFMREpmeXBnRWZmMVVmbzZXVHBMZVFHOVFjUDFyU3FXb1BTUzd4TlBtV2Z4?=
 =?utf-8?B?OTNDbVVMRFRMZ2pKWTExTkRvMnVLbDNkZ3pZdWVFNzM3SEY5RzM1ek5PUzNu?=
 =?utf-8?B?VVBZUWhhYXp5K0Y1U2VhV3FidzJ5ZVRHL1o4N1RlMDNBbmJtWXM1Wms3OUJq?=
 =?utf-8?B?NllQSnBrRzRSaVNHZm5WcmxtdExOc2VqdEhyM0doSGE1U2JZbU0xbE01NVI5?=
 =?utf-8?B?MlJBMDk4bCtDakRLcWUwampGdzlaand4dkVQejNDcW1lSnAwUERQQWtyblFY?=
 =?utf-8?B?NEZKano2eks4V0JlLy81N3dlbEczWWFwTlpiTmhJWUEwYnFjWFpzSlNWWHdj?=
 =?utf-8?B?L0pMVDNMOHd1bHlUWVhzWGdDSkJJQ2VoQ1huZXlERnB4U3dYWU9TbVFOMHpM?=
 =?utf-8?B?clB2RGg5bWZmZUs5WUNuV1g5Zkw0RmJGd1RFc2I0a2tiNC9kSzBRdWJSZzVF?=
 =?utf-8?B?azZLenFvTm1xUnAyTEJkK1NRdVFmbHhEeUNrNEtrVDRZamY3b2IzaktLN0Rt?=
 =?utf-8?B?QmJxZnVYK1lpVHI2NU5UdHQvRmg4KytxQ0N2SEsxYXRENncvOW0wV2xsWSsy?=
 =?utf-8?B?eTJabXJVSkJicW9wWHRaZmk2QldvMmR2Z0ZrM1BCa1FzUlVFQlpxZW1hTEk4?=
 =?utf-8?B?ZTBpRld1UVlhMmt1bVd1MW1JSFJRQ3pZZGl1OUhFVGduZWZPSkg1bDNhMUtv?=
 =?utf-8?B?Nkh3ZTlXeDg4bkF4dG5COVlHSEdzQVJpb01pdjVTTDhVQ1M5bm5lRUI0c3JS?=
 =?utf-8?B?ZXhnWWNwajVObG8xSDVsZ2svQ0tGS3NnY3ZNeFNVWTRYODlnY3BWZStoQmNp?=
 =?utf-8?B?LzRJM284STZ5ZXdSQTVRb0F4MFJTNTF6QnN2RzdhdHFXb3UrdituS2hrSlBi?=
 =?utf-8?B?c0diSFFZemhxelFTZEM2bGZadnB4cUErSUkrSVF5dWtTZHdmTHZ1QmhoeXRw?=
 =?utf-8?B?U3JkTEdZWWNFU1JBeEM1NmVsZ21Qb0dQaGwwYlRlWVkvRU9KaFNaSnJZWWZ1?=
 =?utf-8?B?eDFjenZlY2ZIbEVkQjJ2UlptbkNkbk5ucnR2Vm8raEVxQ2NUNHMzSitHYVhk?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oXxnrQyF0QQDRy0opII7/LZ3YQjkd9vavYShq5n7ms3//kw4x/AcKrz22yybuA1PhulgS/ym2MJSLyDnHYxVY0D3CyN3GrXr1Thc4z78aTpDg1HuLqol51UNaG+DqilB4nUb0+CUEWpV/FwUIgTVnRyxrOCQ4VWb6lPagRw86mFzYwzJ9ZtqW6sSdWVbwMqybnsWUvhzttHV24JvU8deTVcaWmXsOEAGF+ijXTpKQOXHjpFkGqofwxl6y/xpeCCK/oJDxOC+0/4Rumjbn60npi/Sk95icSVEHlaQwUE98nFqqpqAtNfVmlm+ohIbqTcEm/cX0/Eqp0Rr8yoNtcnPh1IyVjdz0gWWru2ND0Un6dCvfq54T2sKymoxmnFKPzFJYmpMS6ZtnpI0rxfCypcIwBtfhz1V5IVydQOnvkue/XKTVY/tMsCFMS0l+mSzXa6GQ7BpGkmnpygJLsNIhLov4EwqEM8otA2FxFH6nSV1P6tS7RZkGTJ1C9B2lQ+2fePPdfX0mCLYDTk7yHcapQFK/k4GUw9Bw4dOmoG/LQKGwYGX6q2JmwEXGMxyoylD4i/Z3dU8pTrOp5oote4ows8T8+otiTDjUjlZYwCz+7JdYSpvuPr/jihP3w3mblSS+sjw3P6HGKXFbs8IrWkR/VjjO9ZQ8glvUQiHAHzhyEwSfUDDPKNyVEQ0bR23hVWofCSNpvUoLOxZW8Df8n6MfwBW8GlgzB6l043EKkvXdQgzJO5buAufN77C77EZBBS2lVuDuqRUBFrOlx7gvVNKgRHpxd1knwWKJirjNX478ppuJeM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09691671-1539-431e-c265-08db0f1365c5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 05:13:39.3060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxvHQuoFyJG2VcPomVfiLIJtPAMnJUcyWuOkbgl/maK5e4oaKJhhG1aGdNUo4Vu+36WC/NbBnSqYctZecp8HOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6263
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_02,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302150047
X-Proofpoint-GUID: KI9mzIthWbtNN_DPKuyLkXBPckRnbAkn
X-Proofpoint-ORIG-GUID: KI9mzIthWbtNN_DPKuyLkXBPckRnbAkn
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/13/23 19:56, Filipe Manana wrote:
> On Mon, Feb 13, 2023 at 9:58 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> Add the _wants_kernel_commit tag for the benifit of testing on the older
>> kernels.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   tests/btrfs/249 | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/btrfs/249 b/tests/btrfs/249
>> index 7cc4996e387b..1b79e52dbe05 100755
>> --- a/tests/btrfs/249
>> +++ b/tests/btrfs/249
>> @@ -13,7 +13,7 @@
>>   #  Dump 'btrfs filesystem usage', check it didn't fail
>>   #
>>   # Tests btrfs-progs bug fixed by the kernel patch and a btrfs-prog patch
>> -#   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
>> +#   btrfs: sysfs: add devinfo/fsid to retrieve actual fsid from the device
>>   #   btrfs-progs: read fsid from the sysfs in device_is_seed
>>
>>   . ./common/preamble
>> @@ -29,6 +29,8 @@ _supported_fs btrfs
>>   _require_scratch_dev_pool 3
>>   _require_command "$WIPEFS_PROG" wipefs
>>   _require_btrfs_forget_or_module_loadable
>> +_wants_kernel_commit a26d60dedf9a \
>> +       "btrfs: sysfs: add devinfo/fsid to retrieve actual fsid from the device"
> 
> There's a btrfs-progs patch listed above, so you can also add a:
> 
>   _fixed_by_git_commit btrfs-progs xxxxxxxxxxxx "btrfs-progs: read fsid
> from the sysfs in device_is_seed"
> 
> And with that, you can then remove the comment above with the patch
> subjects, as it becomes redundant and pointless.
> 

  Got it. Fixing in v2.

Thanks.

> Thanks.
> 
>>
>>   _scratch_dev_pool_get 2
>>   # use the scratch devices as seed devices
>> --
>> 2.31.1
>>


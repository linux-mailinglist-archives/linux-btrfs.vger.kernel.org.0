Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE587A8FAE
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 01:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjITXCS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 19:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjITXCR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 19:02:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68A8182
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 16:02:07 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KKJ82q019125;
        Wed, 20 Sep 2023 23:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=3lW2pMFKpuOi8jwYJGe20w7BzWWESbHPIrbod5AdZV0=;
 b=Q10Xave39IeL/Us5g39jOh9b7woOyWZTixApq8DAAO7aEF+SrN3iVIT05s1PmvjKKJX1
 KuY+rJ2ZqJUvhNVwpXqIHWT4/pKApB/WoIbq+NgGpFB67GMmrk3X77RLYyns6LQO/e26
 ky6RJTqZNmvN3EQ3No50di6lHn8C+PbK3PZQOPlNIY3MJ7H1IIjNPv2nj6UkkcrRuVp1
 F17RCuHQWYx3YHOEQy0O8XFpl5DzbAjMZBx+2evz3Oof9I5HdbAl1MNaVETyg/1cX+rX
 RbumcUOX3jptiBAhNuS5wDxdUxCxj3d6+TuNZI7PIaNtQ9exy35RoxbM9UnmzcNC5mBI 9g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t52se0fts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 23:02:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38KLNHXU030886;
        Wed, 20 Sep 2023 23:02:01 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t7r55p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 23:02:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hc3swq8Skjoh0zXT7+mUKVp5Kb6GQR83QaCkyP/a548P1duWX6rKJcML14SMw995tLpmoOzhGTVHbg3kQTk6vZb1wMiRSTHWn3GTwKK6cpwJOAW1FjxBsfSOyUPz1YIyoCzjqIK7aFzDm039uDqFNFuWu7C03+Xk9+oVp9D9UYJB/4cqpaoXYgFE7j4ilhvRvSZsrE440Wxo12zH1M8Ezwy1X8j5VbrEvxBxVqHSm75a2Ul4KnxyB985pzhoTHu4XaHPD3UY3fAwkfe4J3Kur9CW7Pd+zYWhKbox4s4UXnWBuU/BeQwmod8Of58jtv5iTcCCeDeq4SVjS9TC6Fljsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lW2pMFKpuOi8jwYJGe20w7BzWWESbHPIrbod5AdZV0=;
 b=mm8hySAyL8u0GMr85j1fVTY0myX7vPRs90Xh3vCTlBBX65vq5Ap5QNDSVtgr2ziSnRGsaXjqPuzs6EyCFCFpjzJl8UNZRyGED81ZHYNtbq/xLo20r6GQ0CzUG3/FqNy4PzubrqvkmFuRX8RaiBAsg7bc5xRNkhsHA6yoQBcsGHOiVtTOu7AQeKoXr9tTxek7WfANryAAeDBvbUEGhmXAUHqjHyey2fj3cFg0Iy+4XYstkLcGjc0Lfh33WdEhC4OCFcFPPWE1xV8ye77jeJ+zaq8AZcsIjLSnITFp3dw4CBl5MGFsCqQbjzwKlDjFMputbC1Tzz9OilrWDPzocnPlwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lW2pMFKpuOi8jwYJGe20w7BzWWESbHPIrbod5AdZV0=;
 b=QQeScFbIm7Bb9YT0+puJVuJ5ZzrBZqJN1C+A6yqSOhSoAyclU7Snh/wFLyAvvAqcpdyJNu/m2uETA9YIxWgbKxqq7wOjZZH4RTzPULusihi7VMaKteUmLxNjsHVRJ8nnGIgn363k0LhbWObKYQxj8jMJ8/wx+CvR+AsbsAwkSkg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5332.namprd10.prod.outlook.com (2603:10b6:208:30d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 23:01:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6792.024; Wed, 20 Sep 2023
 23:01:57 +0000
Message-ID: <8c6110f9-b338-492c-01a8-d831507b9f16@oracle.com>
Date:   Thu, 21 Sep 2023 07:01:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH RFC] btrfs-progs: btrfstune -m|M remove 2-stage commit
To:     dsterba@suse.cz
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <12b53ab9683c805873d26a4881308137e0bd324e.1692097274.git.anand.jain@oracle.com>
 <20230817115229.GJ2420@twin.jikos.cz>
 <161c8ab2-2f8c-ce87-783d-f7f0993074af@oracle.com>
 <ef88fc2a-b845-4637-b006-43ecc511d9fd@suse.com>
 <df569834-1949-5c1e-dd99-8da105a10b38@oracle.com>
 <20230918223856.GR2747@twin.jikos.cz>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230918223856.GR2747@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5332:EE_
X-MS-Office365-Filtering-Correlation-Id: 2219a25b-4b34-42ff-4cfa-08dbba2d96a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: seVsrzgyc7O0LrF1t8LFYQQDzqEXZmJpTWg1XT7i5mMBPirRc5qEREJ5+gj7co1ssekicuuyZ6fOTwatbBv0WhROkn8sJ84jWJUBkxX5Vc56EN39WHHHy6WDE2y6bp77VFNxSkNxVRFCZZkLxbBhQGKw7x4y49mZBBtLNbXyF9cQerjxQyeoDaM+d4nzuggV+a5VCI5QFds4LPKDpXdvJ/IaYtjFEEReTRKr4Rdgv/q2qFPAlRFVz+RxVzoFN98UTC8s0MBlkehaAHT3gbCwF9sJe2iW1Fa5e3X77vyTDIUjGQ3AT0S8lPlcyZxuc/JHyyabhnV5qLz0GcjK+TxMnfqvpO7mT4nYxuKNElsXdwtsWT59UkJE0VxK9gFd7cICiDpd8LEep7dJLOtmbKyB95Q/bCqwjT4hkqvWqaityuNLbtrRJBrqYnHwI7/brDZBH2zHMZUgphQnQraBBRXoOYaJJZb8Is3d4exYYeYlL6aruowSV7lM6GWnH+FS/q5SXSxMzo8Gmv0gXmf1jU/8GAnW9D6EJwUgC9it/Tni9D066CjPEKph+jv56sM/2tBfX7E9XmYsNIgfZLDn87wlsLEVP0MVW4AV6PSI4xyfeISdsdtGSHeSnaj7SicW7ZDXmT5kfQCvuTTgDR0zTFgDSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(186009)(451199024)(1800799009)(6486002)(6506007)(53546011)(6666004)(6512007)(83380400001)(8676002)(8936002)(478600001)(26005)(2906002)(66946007)(316002)(6916009)(66476007)(5660300002)(66556008)(41300700001)(44832011)(4326008)(2616005)(86362001)(31696002)(36756003)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmRjN094MFNqcGxKYzJiWGlWeTdhUkl5VHAwSVc0YlhQRE1ZR1l2Mng1azd3?=
 =?utf-8?B?VUFheEpaanBrWUJnSmtaTlhucVZlRDNEalRLdllWTy9LV0h0SDRWeUN4Rm8z?=
 =?utf-8?B?Znk3V1oxOERNeHVhV3RoSHFKMFhjZ1JCeGJBSWJJcjFoamE2RzVQWU5IWVd4?=
 =?utf-8?B?eFQ0b2h6V204YnFxNXhZMytFNUltZnY4M09rVDhlMnp1a2NTMi9pNGFuOEky?=
 =?utf-8?B?dVk5Y1lieWtxTzl6UDQ5S1hWSFlFQWNDYk04ZGtEZTFlVXBPeXcrRVBIVEZC?=
 =?utf-8?B?aVo1VHk4V0tGQ1YvczRYYmJwNm0yTkgxZis2TkJzdEVMTUtCSERjeWtJQ1hY?=
 =?utf-8?B?ZVB0NDRDdFNoV05GdGMwZmpROG9DbU5iaWtDcU0rb1I1bUJUdEtrRW5PMjRs?=
 =?utf-8?B?ZmlDOWFJUWcrN0Z1QjRRVTRIVUdNZnlORlk4LzRRZzM3OVBlc0pZWkdXZVU5?=
 =?utf-8?B?TWJjcVkrQU1oQTR3cmJrbURieVE5R2NOSXRMRktraXY3bFdpeG1qK3dkOEdh?=
 =?utf-8?B?Q1F1MGgxVmt2UklDUWxxaEtJQnA2b2JNODVJcEJldDFEY3Y5dFA5RkU5QWhU?=
 =?utf-8?B?Yk1zSnpTSmRpTUpaSVZZV09QMmhFb2JKWDk3Qkt1UU5uT0RveE9WZXNhV2RW?=
 =?utf-8?B?bURab2M4SktYUmsvcmd5RVhIT2tJR1V6TEI0UW9CSmgyTjN4ekZaU2JZdGJ4?=
 =?utf-8?B?UkNiVk16SDV2SnZYTnE5dmJwY2pZMTlSQi8yVjRONjlITWtLdzlWT3d2TTFX?=
 =?utf-8?B?dUFqL1NaQ2JHbXA4OTEwZjhEUEJhWllnZCs4NUYyb3QwNk5OMndvV0FtaStz?=
 =?utf-8?B?NDh6Nmt2WUtWc0pwWTR5MERqaVdSM1hIRnVUTzNtR1k5RlRtQll2ZG1DR2No?=
 =?utf-8?B?Q3kwRHhaQ3FtdERsMzk1OWMwRnRUL3hHSWFsK0RTSGNmOUlMbU9teXhnMkpB?=
 =?utf-8?B?eDVhR0FjbG5RM1gyazkvMUZiYUJ5aDJqWHJuc095WGk1RWhmUVB3NEtDZlFW?=
 =?utf-8?B?L0loNEs1Z1I5M0lERWpqY1NwMDJaZyswZXFhaWU3UmFiQ1AzRyt4MERHaDgv?=
 =?utf-8?B?eUcrZGt6Y3hCRlMyY0RPbmhqSGtpMDNlQklNaFlGVjhsVnJLeGlPenk0dkF4?=
 =?utf-8?B?dDFERG1GTXNtM1R3U1dUaVFLeFpNRC82Ujc0NHl1aFl6Y3creU83ZDVqemRR?=
 =?utf-8?B?UFExdFZrQlJMdmdSR1lzRXp5dDFOanU1dXIyRHVWT2I1dzlnYzdFbVN3TWEz?=
 =?utf-8?B?dGw1czRoQkI0d3FTQUxTN3JoT3pNTWUyWXZWa3pvTEpTMEZWckVtOGVzZTJ6?=
 =?utf-8?B?Y21zWktLTUdyNDlvRUdneXNCYXNaZkxyUUhOZU9TM0Z2aldiYTl2dGJBRzZU?=
 =?utf-8?B?bVp5Zm40aXJ2R0I4Q29EeEx2Q2h0TkYwN2JzZkV1bElRNG1kNm80UmJ5cVhC?=
 =?utf-8?B?MlBBRHhPVDF3Zkh5YStkcjQzUC9xSVZmMkM5cWFiakJCMWtla0NSK3oyZkRY?=
 =?utf-8?B?alU0WjkrdUErRDZuZ01vKzhlajVBYmJpcVZsL29xd1hPRzMrcW13ckdJODF5?=
 =?utf-8?B?MjNxRllaYXU3VVV2QVJ6N0QxVUhzUzQ2T2tXcWk4K21mYnpJTW5xVjY4NFFh?=
 =?utf-8?B?V25wd1d3RUtOOW9weGNyNzhEdDhZbUhIRUs5emRtMXhONkVLSFg3MlhwOTJl?=
 =?utf-8?B?MHZYMnEwSjQyd3h1WEtvNEpxQjJtSFVTY1VLNGpVZTc5WkltTnhDNmhLWm1P?=
 =?utf-8?B?MmNYZzg2UVcydkpLNk5iK3ZCTEZFRnZMM2lwb1h2bnlWSmZwd0J2MXoxcU81?=
 =?utf-8?B?ZG1VQ1Y1Rk0zaFJsSXdFdWNZZFNVdXd5YW1WZ2lhWC84VHBQc2dKWmZzOCt0?=
 =?utf-8?B?bEhhOGVQY0t5ODBobjNYQjVPOGpONnF0cVhrWncxSXRmRVBOc3M5bGdsMTlp?=
 =?utf-8?B?QzRGUnlUamdMMEY4VStyejVJK0lDa3gwRGxHcTF4VEtlMzVka1JUeWtGNG50?=
 =?utf-8?B?d0s4cnQwL3EyYzM4NWZRSFFMMUdkT0s0UnhNbCtQdzVuc3cxWkV5eWFhOE1N?=
 =?utf-8?B?eWdkcitmSlhFaTNLNVRoNjRkQ0R1K0s3U09ZWkFWeG5lOVVpZHZ1ZFpPbHFC?=
 =?utf-8?B?UkFuczg2OHZJS3R0ZHovOWJqOTdDZit2ajJaUjU1Wk90RTR2cSswcEtDNWVz?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RBPHauelP1EwyP6ZcrNdbi6mm8v5bRymtHp8STAAWdEhRt8PI5MIHx5dstcE1Z2gKAV0KTQBAA971gHA8TyrTmBjSLLPBED01GyBC9/zDR7n8Vs9JcwMdrpyNS74s3QoFSMhDQysZ9hgtoBJxoA25Y2FWwnMvh4ETnwW2m50B4S1LdNJT+/g709EbufQqQa7oY3cjm0Zxp2NXKEoO1gQ4QexsO34N9mZX7ycqRuy10XzveqsWCEZNylsOYb474xjlOvEDrfAfCC7oUC0s2NUjam+pRrDk5rAwOA9EQSFiC9laGABQBsRcRJpp6xQmS5IcRuxGwEjGuAvvTAex4Xu8xufbMQdvS2Ugt+IFyDFaALfVC6zZeW8CMY/JR0p4fAy0A6tz9Iu87B/lh+EnbBK9HzJeV6SuX6W50jHzKZ/U1MvJWhh0890bzYPgegreRNagIs9GZIyZle6X75PIwrMG5zDa5hl42vlFCSsod51Z/Afs0eosrmZPTIpaRkGP1iUeLYTgStf5Ik0anVLHy+aqiYDxjiODe6ns+hO6neqMFDq2NWsfcEqL//Os7W3Hz2YP7OghlkfJvI2v+B9OYsNQiS8CyeNqopa4kn5R44MiX6S6i5H8kUN0aYFSGmzyKbsaOzUDILoBDjmDwNzjqpB7Uf05kb6MG1vhUREJYPZgoqp0pXvoA0guCWDFMC7TQeRwZVAp/waV7wM651GFdOx1ayAnQ8pC0LUuyram8by5t7QvDF72aAeGw2POOb+YNTmy5FEblxUzfTg2rAtos3P3Vljj84Hf3C2XtOnCgpN8602pUZAg+PQoq1DQW1bi9Sc
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2219a25b-4b34-42ff-4cfa-08dbba2d96a7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 23:01:56.9805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNdWfefz5aWu74+QPgkqifv4+Cxoqgme8clv5i00aX4ivHbhVyYzutUBCMFUKRn+SYLl5czvjS+lN0ey+j+7kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_11,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309200193
X-Proofpoint-GUID: hVlGlaAQUKOnupSQFlY4ZDMzsH_b7yyQ
X-Proofpoint-ORIG-GUID: hVlGlaAQUKOnupSQFlY4ZDMzsH_b7yyQ
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 19/09/2023 06:38, David Sterba wrote:
> On Sat, Aug 19, 2023 at 07:14:40PM +0800, Anand Jain wrote:
>>
>>
>> On 18/08/2023 17:27, Qu Wenruo wrote:
>>>
>>>
>>> On 2023/8/18 17:21, Anand Jain wrote:
>>>> On 17/08/2023 19:52, David Sterba wrote:
>>>>> On Tue, Aug 15, 2023 at 08:53:24PM +0800, Anand Jain wrote:
>>>>>> The btrfstune -m|M operation changes the fsid and preserves the
>>>>>> original
>>>>>> fsid in the metadata_uuid.
>>>>>>
>>>>>> Changing the fsid happens in two commits in the function
>>>>>> set_metadata_uuid()
>>>>>> - Stage 1 commits the superblock with the CHANGING_FSID_V2 flag.
>>>>>> - Stage 2 updates the fsid in fs_info->super_copy (local memory),
>>>>>>     resets the CHANGING_FSID_V2 flag (local memory),
>>>>>>     and then calls commit.
>>>>>>
>>>>>> The two-stage operation with the CHANGING_FSID flag makes sense for
>>>>>> btrfstune -u|U, where the fsid is changed on each and every tree block,
>>>>>> involving many commits. The CHANGING_FSID flag helps to identify the
>>>>>> transient incomplete operation.
>>>>>>
>>>>>> However, for btrfstune -m|M, we don't need the CHANGING_FSID_V2
>>>>>> flag, and
>>>>>> a single commit would have been sufficient. The original git commit
>>>>>> that
>>>>>> added it, 493dfc9d1fc4 ("btrfs-progs: btrfstune: Add support for
>>>>>> changing
>>>>>> the metadata uuid"), provides no reasoning or did I miss something?
>>>>>> (So marking this patch as RFC).
>>>>>
>>>>> I remember discussions with Nikolay about the corner cases that could
>>>>> happen due to interrupted conversion and there was a document explaining
>>>>> that. Part of that ended up in kernel in the logic to detect partially
>>>>> enabled metadata_uuid.  So there was reason to do it in two phases but
>>>>> I'd have to look it up in mails or if I still have a link or copy of the
>>>>> document.
>>>>
>>>>
>>>> On 18/08/2023 08:21, Qu Wenruo wrote:
>>>>
>>>>   > Oh, my memory comes back, the original design for the two stage
>>>>   > commitment is to avoid split brain cases when one device is committed
>>>>   > with the new flag, while the remaining one doesn't.
>>>>   >
>>>>   > With the extra stage, even if at stage 1 or 2 the transaction is
>>>>   > interrupted and only one device got the new flag, it can help us to
>>>>   > locate the stage and recover.
>>>>
>>>> It is useful for `btrfstune -u`
>>>> when there are many transaction commits to write. It uses the
>>>> `CHANGING_FSID` flag for this purpose. Any device with the
>>>> `CHANGING_FSID` flag fails to mount, and `btrfstune` should be called
>>>> again to continue rewrite the new FSID. This is a fair process.
>>>>
>>>>
>>>> However, in the case of `CHANGING_FSID_V2`, which the `btrfstune -m`
>>>> command uses, only one transaction is required. How does this help?
>>>>
>>>>                   Disk1              Disk2
>>>>
>>>> Commit1     CHANGING_FSID_V2   CHANGING_FSID_V2
>>>> Commit2     new-fsid           new-fsid
>>>>
>>>>
>>>>
>>>
>>> Instead if there is only one transaction to enable metadata_uuid
>>> feature, we can have the following situation where for the single
>>> transaction we only committed on disk 1:
>>>
>>>       Disk 1        Disk 2
>>>       Meta uuid    Regular UUID
>>>
>>> Then how do kernel/progs proper recover from this situation?
>>>
>>> Although I'd say, it's still possible to recover, but significantly more
>>> difficult, as we need to properly handle different generations of super
>>> blocks.
>>>
>>> For the two stage one, it's a little simpler but I'm not sure if we have
>>> the extra handling. E.g. if commit 1 failed partially:
>>>
>>>       Disk 1            Disk 2
>>>       Changing_fsid_v2    no changing_fsid_v2
>>>
>>> In this case, we can detects we're trying to start fsid change using
>>> metadata uuid.
>>>
>>> The same thing for the 2nd commit.
>>
>>
>>
>> The changing_fsid_v2 flag an unnecessary overhead, right? As it could be
>> something like:
>>
>>    . Write new-fsid and Verify. Revert if needed and verify.
>>
>>
>> ------
>> Summarizing the overall patches:
>>
>> Patchset [1] is a port of kernel changing_fsid_v2 recovery automation
>> functions to the progs. So, hosts with older progs and can't upgrade to
>> find a tmp host with the newer progs to fix the disks?
>>
>>     [1] [PATCH 00/16] btrfs-progs: recover from failed metadata_uuid
>>
>>
>> Automation in progs/kernel cannot fix all possible scenarios; we still
>> need user intervention to reunite, as in patchset [2]. It adds --device
>> and --noscan options to reunite. (Needs comments, so that I can rebase).
>>
>>     [2] [PATCH 00/10] btrfs-progs: check and tune: add device and noscan
>> options
>>
>>
>> Patchset [3] removes the changing_fsid_v2 recovery code from the kernel,
>> as pointed out- recovery code is robust in general, except in corner
>> cases. So, after this, similar to changing_fsid, disks with
>> changing_fsid_v2 are rejected.
> 
> Hm I think this is acceptable though degrading the feature a bit. We
> can't tell how often the kernel recovery of the metadata_uuid has
> happened but fixing all cases there might be too complex, more than it
> already is. The whole conversion in btrfstune is quite fast, crashing in
> the middle of that is possible but highly unlikely.
> 
> We don't have a proper documentation for the metadata_uuid use case,
> there are the option and sysfs descriptions but not really how it's
> supposed to be used and what to do if setting the metadata_uuid fails.

> 
>> But when progs can recover the failed situation and could remove the use
>> of the changing_fsid_v2 flag (patch [4]), we don't actually need the
>> recovery in the kernel.
> 
> Ok, let's do it.

Done.

Kernel:
  [PATCH 0/2 v2] btrfs: reject device with CHANGING_FSID_V2 flag


btrfs-progs (in the same order):

  [PATCH 0/4 v4] btrfs-progs: recover from failed metadata_uuid port kernel

and

  [PATCH] btrfs-progs: misc-tests/034-metadata-uuid remove kernel support

Thanks, Anand

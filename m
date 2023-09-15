Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9052F7A18EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 10:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjIOIdy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 04:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjIOIdx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 04:33:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F04E9
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 01:33:48 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EKxwMt020455;
        Fri, 15 Sep 2023 08:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1J6Iu65ISkTfWgNdWoeZIw8o92y6mV2Wv3EJlasaiuI=;
 b=jC9qrBop+wFIcf93xTQsB2AQL+HcBoQWWTylTg3uuNBqoFQO+LAPzI3JEtUgBI5Aegtd
 D3rnEiRj+4trHOh6uBjl0roxseEIux/5KUe4wrtDUOD5MOej9oclss1yRRdpzLZaVV9k
 1wIPfRYxUkPyycvkUUCuj0p/KK9gKIw/69GSOlHJk4sCLnDtMEmDPDLmsPKxCzNu3huI
 kjPQ59Ll6DdHmJZT28nyBWyrA5OMEhwj17TvzCXkfvcrAhWa5c4/rliVffNAkCNf4By7
 aWMfnRM64fgnwx6yfz7fXDVBJ3XIiMcaEypz6DyfGSYaCgyYusCDx5XzweC4s3PpQuOn Qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y9ky5rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 08:33:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38F79bFe007352;
        Fri, 15 Sep 2023 08:33:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5aj1aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 08:33:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPg9gzP+YshFRFBG9g9hkvSbdDxUeATN6YUxcLkHxk9Gr7cVqWKLEtnN44nfBmoWnaNfDEilXlvy2IcWy4+x4QunknOhO+5A+9mGF3m+AYA+bwkEvGV5Dmu4j5wVQP6N7K3PmlcVM5CxQfJMQ33t30mU0bac0mgRtpLo569Pv9bZMZhYyjH7Toa13hAAOv+PltBeSpsRCr9vNOpNWzogZ6Hq7FK2YRInY+drpTfkgY1LJ4f6y+obiwhxUO0nKDZD9YLChgFaUMoWLPjl0xrRb+01MQhiK4b+nV7m6WHEPrjCRgYbT2tNmgy7OeOfjL1XikjHtcZMuiH4WSiGkENohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1J6Iu65ISkTfWgNdWoeZIw8o92y6mV2Wv3EJlasaiuI=;
 b=ewcqL7Cqm5y8IHik7exTMRyQw1Fm+zfVGrbKS80c2Didd65Cln5D4F+M/VmL/I+byEa9Ad/vMoVqcQ5LcIYkktB7QnH9tUhwIKdUFTrwx1N0yybAXXTbATikx6LtCgoROCcTTP7+aF9o1mqt2SveM64V1eE5hI54Met3OY58hpcyTEcFPMIEl7YtEttFHyxtgzZJ8j6VV/lwoxPouT1jxT7+RGxurDHI93Mk6diyCJRqLJuxrS6nticVPudWTmLfrPPl6iJatTyUnTnvKJYyDDER/zTAYgq09BAybl9c0SFAEyiyExVQokbMIPISUtSZNNYUku4v8EQy78bxb3AEnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1J6Iu65ISkTfWgNdWoeZIw8o92y6mV2Wv3EJlasaiuI=;
 b=fdkVqzZz9YJZfrnkwmqokt1wz1hjD7iAXyjO0FFa3xXi6L21FpLdRu+Ej8TenzUIAgUsEP19pl53xNClkMiocmpTjTt9OyLMqrY/ROa/aw9qlzbS+yLz+XOFCqp9wK3Qq8Db2PpJ6iA4KKAupcwC9vzLI6qk9zaCfUrUxyRb4BQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4795.namprd10.prod.outlook.com (2603:10b6:806:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Fri, 15 Sep
 2023 08:33:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 08:33:41 +0000
Message-ID: <61d41b70-8a1c-c6b5-682c-607599e8b3e2@oracle.com>
Date:   Fri, 15 Sep 2023 16:33:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs: fix smatch static checker warning in
 btrfs_scan_one_device
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>
References: <81fd5fbda9772cde786d60b3cecf7d60d5a378f0.1694765532.git.anand.jain@oracle.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <81fd5fbda9772cde786d60b3cecf7d60d5a378f0.1694765532.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4795:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ae2e02-318a-465c-39a2-08dbb5c67766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EonT1sM3VHhfAsLpkebYWygzSfhL1mqT9yh3Zltq1JnFnSfTODAjmlgLCQtivMOnYeKw5qBzlP3Kw3md09AL5Oaiv1LO2jJ9Kw/tBeu3bkpnLVHpOM54oz7I30JtN+wKUoEU9R4QSjl/A4w+6SURcOiSHyk2AaMwYB1nyJ4JwtvkgoMYw0MNvtTkhrDyKb/VgYwSngONVUlrEaIeuWw870dOolBc1h5KlIO96cyFBVZggIFdNatv/FuGpelTS7qwQo4bUxjJri5hLG77C2ADcvb45iZC5o1NngM6lWchVORZHKs2tezJlm1Vf+hrHj5BGbA2WT5sQ+cH9LGQlFORfq2sF3zGRJJubl1S3JRKyNAxjrPAik7wshg2GKJRoG4sY54yXKnPzTZUYjd/aVfEMIQ72wSEi5r/ixwFlXVwU1F/rHK2gU69Z/lg4VxAxfvMbu3DVSTZ6gY6Cy8iYJxR9eD3vP+4IWmunfM3YTm+9r/qgtYrHP+Oz8pWrzg0IYXWEoOvo/IKOGhklb6ybDnm/3mcjfybILU8qm3jF1BDitV8SFoGIHgqb+USoKXYOcNp7nV6bLAJxbgj2a+uKgbb4ST4DLBeNsYT7pVjXQ4gpIiq8r0Ft2BEaVw/yB+V8hQtU7tgc88EPh8idoSiR9Dt3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(186009)(1800799009)(451199024)(36756003)(31686004)(66476007)(6916009)(8676002)(66946007)(5660300002)(8936002)(41300700001)(66556008)(316002)(4326008)(44832011)(38100700002)(31696002)(86362001)(2616005)(26005)(6486002)(6506007)(6666004)(2906002)(478600001)(6512007)(53546011)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVI4Um5WYytCVnl3UFZ3bEhVQ0svQWRwZkE3ZnBpbU56VjAzaGNSY01ZbFhJ?=
 =?utf-8?B?TDd2Ym1ER05vU29oMVNLTzF2MmdmdWlTRDdaUC91Y1l3WVhaSHhhVUZFODVz?=
 =?utf-8?B?TE43K2VQbms4S1RyclQ0aHExNkRPOXJXYkxkaXBLQzdhc1NtT3pESXZzdjYx?=
 =?utf-8?B?OWFkSlJ3UEkvK3dkOUZJcXkraGkxRXRna3hwSTJEUzVXNHozSGdXMzRlQUxw?=
 =?utf-8?B?bDFDVFVxK3d4M0ErRUFQMDFzTDJ6YXUxRjlDTlpIZXJ0bVpEdVg4S3dxMXc4?=
 =?utf-8?B?N0J2V1dJYUhycVRrWlFRQ2dnNnpFaUV1YVRSU0tlQ0pYWUdnNE51ck5QSVdm?=
 =?utf-8?B?dXpDdlFNVWpxN0QyOEs3Q1BoVzB5WW9IdmFUV1JNQmh3WGxtOHdLUFRubElL?=
 =?utf-8?B?bEY5VDdsZXNHL253VnQwVWJqRWNWOUxKdTIzSm1QM0Vwb1lHRm1PdkRiQWd6?=
 =?utf-8?B?WUgyYUMxcFRBcC9oeWNBUmRJRXczb1BuMHhDdUcyVlprRU0wL0p1eTcyMk0z?=
 =?utf-8?B?dHR0TmxDNU9KU2ppSFZQdktZRWk5WTk3NTVHRzRkNkJxNVNjMVBtZUR4MUNH?=
 =?utf-8?B?WU1xV0FjMTJmZWQwZ3JCWTEwNjVzaGc3c0dTWDZuTUE3ZXBTbDhWVk5MTWtP?=
 =?utf-8?B?NGhsRmhUbzViVkZmQVRuRHZYeHViNjRONEsrRU1QeVU3TlZxdm5wUVkyWkcy?=
 =?utf-8?B?OHJXS0hGWmg0clFjbXpXamxvQ1RaVUxmYUlEVkxFZ1owR3R1RzRwK1VyckNn?=
 =?utf-8?B?SUE0M1JIOXpZL3BjdGtqZ0NyV3VNRG5raFZKQ3hTUnBQenU5K01GSDJ3Yytz?=
 =?utf-8?B?aitxcDdRTzY4U3NlRXh2a0xTUTlad0o4YmNlR3dSWVNOUUVwRkovalROR2t6?=
 =?utf-8?B?Q3p6bmRzVTc4cENaZ3JscHJzVmt4VUpvdnc3U3lmR3NiWUtYRHptUVVKdGkv?=
 =?utf-8?B?VW9mR0dXc3FCc2tzdkMyYkN0VERjNXVHSkErUFFEVHVIaFN0ZXRVSkpPZ2VZ?=
 =?utf-8?B?bkRiemdabjRzcGJaaVZEd05qd0hiZ2V0VXRiRjh6Skg4eVFKQTFDR0Q3K0ly?=
 =?utf-8?B?Yk5vNE5YSEdITnpyQUZmNVZYUE9oYXphQmN6SW5pSHBWQmk5Uy8vc0VnNmdW?=
 =?utf-8?B?TkxMb1BzNGVWQlJ5TmNEdi83VXczR2tiSW43bW9CSmZKS3c0V1IrcENSWmtN?=
 =?utf-8?B?dXlUVTRDMHlHT0pqSllBTk5zWnFhd3doaVpkeUtobjlVOW5scXJtZVJSOHpQ?=
 =?utf-8?B?a05Xc3hWYlpCQjFFMThDWkVzcU9sUmdLYms1V1lOdWEyOTJudnZwc0gzRXZn?=
 =?utf-8?B?bUZnYmFVZzJRY2ViZ3lCK1p2Y0kxMGRjZ1dRdmNtNW12Q1pVN21yaHFBdVZk?=
 =?utf-8?B?eEhOdzRyR096RnBKanNkM1p3YjJwWHkrOWdsbWRjNHAyZzhBLzdqbVpWd3M1?=
 =?utf-8?B?d043U0t3b0hic0VlQnBoSy8zM2RKK0hpVUFtSDdybmFhaEVaZCtQOEdlR283?=
 =?utf-8?B?Nm5lU2VvMWNXVU5DaU9SdlpMZmN3UnlTbGdUKzhYYXIrZXVkL3FySW4rTGpH?=
 =?utf-8?B?YTR1MGlSK2JQcHZSWjlpOThzUU9sU2R2V04vbUl1STB5OXJoMzFEUmJBR1Jp?=
 =?utf-8?B?U2liT2NzekoxK2ZjYWozS2dOdTlUbnh5Qlp1KzQvU3gwL0RXYnNxdW93M0pG?=
 =?utf-8?B?VEFQUTJreDJxZllMOE4xT2JiMXVENVR4bnVrMHhFc3pSYVFuWDJGNVNWSENX?=
 =?utf-8?B?c0d6WCt6emo5emQyNUlmNjRNcXJXYkJmMWJCM0l3L01xQ2h1RDU1K1JMdkp4?=
 =?utf-8?B?R0RTVmdMcHhZbFJrbzh4WTBJUTUxSjl3clpTTUJCU1diVVY1ZDNneTBwVWhV?=
 =?utf-8?B?K3F0ZlMzVHM2Tm1aZ1BtQnEyVE54blZhT0I2QlB1ZTV1SUhVYlpVeitnaFVR?=
 =?utf-8?B?U2szY3hlcENTMVNtVFVIMnZ1Lzl3bkZxWFo2Y05TaVc5RDRHL0lDYzdZbWlK?=
 =?utf-8?B?Y2xPUEFEY0t2NnpBNGFxOHVISDhlNmh1Q3Fwa2Zja01XZjBMQWwvTUp3RGhR?=
 =?utf-8?B?TWNyL1VhSVR6akpldm1zTEJlWkwvTzNZZ2tRN1JEc29BZlljb2NJUWtvWUty?=
 =?utf-8?B?VFl1ZFNpbHlJY1VLdXQrbXdPcTNFTnk3NFhiMkptQTQxYkRMVHJxb1dwTmdQ?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Jm97dUawTelXiSST99ochbl2kz3dKUTTQ6g3/kIWyfIKC/3HHEKrWm9GGZXsv1X4SYk8L4bpKOTNx8ZlqaMJeQNyxZ2xjjg5jSpjY2uaKt29BvlwmrRY7WU4pMvmHLDVfneg6p1h94X69ooBXf4yIrKGhpgAOQ49tx+4OkJ0j9bX784vMyYru0fArdTQCl3glHbxBWMxfMGRzHGETR/Gm2IG4rcpVK6GXkDdLRCrt/J2AQ0C59s0//0s3rJQCQXS23N1uweyO8sQvR+7R+y9HH1CW6jKNHq9eZGciUkA4+q5BuM7l89oNONg1VbGLyPUEBbZwRZtgwELQh6RbuJ+vNTH+MIyxliAKA6Tto/EcbZ/W4WX6hhyBKia/lyJZPIYNjfNMj0BVazGXm3UQxkrxjpB7khedT6xxCa91p+kI1Kel4g4+ep6TlWSdwj2+HqdYdUuBtPHwP95rC4lp56ZE6okV/8gAQaGB0GfKU22+BGbULofhdcVLF5N2wITj7zSRwp+8cEvXqEeTg1BeOMkRHD250C1Du6dtLt2DlaNjhhhHLNSjhdzEpKSZvIg1SOZRjSjTspTikb70zD+5Nd762XWM1dBcRO1p1MRfPZpX9Wmnb6gR8R5zPSM9w5DWpPXiLE3s0L5lZ/IxXB8hG9juT5ZH3AqBPQM0/hfI346o54UGxSBe4yIUM7+U63fG+TMAR87kEAJf79H+C6LD+0wexa4UW3T/9tpC243pFk/d20rFDQlH/lVX6Uu+xL1SJEvLL65VStIpfMRY+xb7zswkKBrUR6nkEZq3gvkH4c6mHA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ae2e02-318a-465c-39a2-08dbb5c67766
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 08:33:41.7658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baduqr6gPzJxxB6VKXXPjUmyUDf5cK8HSfIBOsKAwIZxPyhgr4Lp8oSqwRyH+Ch1+kM+zlV72rDkvz7B7b+CcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_05,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=980 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150074
X-Proofpoint-GUID: bBN3SvdSPZMIa0sxm9WRD7UJhKJdp_GX
X-Proofpoint-ORIG-GUID: bBN3SvdSPZMIa0sxm9WRD7UJhKJdp_GX
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Adding more.

On 15/09/2023 16:17, Anand Jain wrote:
> Commit d41f57d15a90 ("btrfs: scan but don't register device on
> single device filesystem") might call btrfs_free_stale_devices() with
> uninitialized devt.
 >
> To fix bring the btrfs_free_stale_devices() under the else part which
> will ensure devt is initialized.

We don't have to fail `btrfs_scan_one_device()` just because we couldn't
free the stale device; it does no harm.

Thanks.

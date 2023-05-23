Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B4570DBB9
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 13:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbjEWLre (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 07:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjEWLrd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 07:47:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCE5FE
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 04:47:32 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6EFQF027118;
        Tue, 23 May 2023 11:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=0wrQh6iIyc7aFSILYa3Mid+ZCXp3EUzLWa7+jzYVFIQ=;
 b=qRDJBfIzd7M7Dk+OiNIlEqJ7NEWu7VhHYnYkVdYjP/Ap5r/Qx1EBuVLsijt0DsJLljai
 RisP9sYTvOqKkvv3Xs3ih6MTJflvWAERJ0JwTrEAo/Tv9Ft3vYO7Q6hlevAlRJfE6IB1
 RPXsCCYfv+L8LLove+nVcmn7/Yaqj9DZxbaOjHrHDn8hGYvK1vNEYPrH9uUZACbmeQdZ
 U8KLDPaaoJ+orum27Frcx3ng1CxXgwvpp8YSH7DAJP3Ic/R8Gj3Cssx6ORxWioz1KkFp
 xTZ0II+WXYUzwRERkf7BtRtlF16uGCUpGQn7s6IaI7L1QuA4fK3Kuh2XlYBdz5Xk3jaz Qw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp8ccy6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 11:47:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NBDV4Q027571;
        Tue, 23 May 2023 11:47:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2deuu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 11:47:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcumnXArxmqqk8iKb8MCrRDschXNnfq3dJhGzhbDd5LgtSxUJ1qFPgFtsVDaRi1H7wrqC8JFHWUqLGUi5zbCWtUgNVI4Ajs7Lh77wjedt+kyyaNFtcoe+q2Xky81hhbuRmbKrDOKo4nX68TKNGlPyILz/nxWOxeLS5gFcPlKw7ThKVA/OGjh/ZOFjI3GMUy8TybJa1wvG+CckKW0+0MljxQSkdRF8JJrN1SI2yqK5ZRf3mF0kLY9T2aJxXEOk5gdjcA/LZV74WvWMkL4C1HeHh64BV4FJjQ4w5mNntcs9fYP/ncwA+dXtu/ZgIkNVWyBUL+gdxKqDUQ4MOgkDsFbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wrQh6iIyc7aFSILYa3Mid+ZCXp3EUzLWa7+jzYVFIQ=;
 b=G1Yc60DQ7FDM9QuBJkUQZWcUqdGJ3FlsN5C8GLn40VP1DpBJFDpen5PRRuK9PTIKzSYrlyTm9JEla6j04uSCCBXvbefWuMKiB26RSZiEwKDRoa8kRVcJ4q1Z+DvlXdI2FcTYuyG4YhL9xqBFKcAXnQ5QJeVM77JaTne4wgPUgWvO8PdhuaZqV+DV1qK5A9qy4L4tA/cWpI/m25kuuraDaOh+B71ni8a0cEtTxJU6AFkpFveiQ4etdamWyS7FGNwK4sz4jW09tAg7w0lp5yIA58i70bRF3VAOT8dyzkhmwgt708Fz8CAoFnzXhXE4zKnUESOtHahh+EHXVoLT/0xxWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wrQh6iIyc7aFSILYa3Mid+ZCXp3EUzLWa7+jzYVFIQ=;
 b=lzo2RF13t7WSea3272DCp/EeAaOojr3mtrL8Fr4TjeZJ+39D8ZeyowrLn4PUz+sSG4L4l1NTxG0iDUPONxyyvRl+MiF02EEoIWnv/hiar6FHqo9g/o6MIFnoE9I+lrRrj1DsYLBe9SB5s8AoWpjY16kH62UZkVwpKAx6OOOg7zA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4259.namprd10.prod.outlook.com (2603:10b6:a03:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 11:47:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 11:47:22 +0000
Message-ID: <e3fc220d-3229-454c-6106-bc705490f05e@oracle.com>
Date:   Tue, 23 May 2023 19:47:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 02/16] btrfs: factor out a btrfs_verify_page helper
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20230523081322.331337-1-hch@lst.de>
 <20230523081322.331337-3-hch@lst.de>
 <7d1d512a-e4d6-70c1-93c9-61800955b4b0@oracle.com>
 <20230523113907.GB28908@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230523113907.GB28908@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:4:7c::36) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 78259575-9799-43bb-fb61-08db5b83783e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gBAFGxajT0GmaYoZEJwwaCv6eGrc9jR0yu1Edare/8RRAQT71606RC4bnD5x6hW89ZPDx7Hra3C/xg1r5Zh+/c/bNUwLV7k4vcNkT5lq31hjoD622rV+r9v9lyM+xlLhAy30XDIBHfDqsV3cQUwJc8S1d37iG7TBG+GnF0hJ7ZAhs6hWkNm+GFwRC4CTu7uwAIBqx95e9UcfSS4X3LQdwMyG0dcVOzVWK6/s0rfQ86vTosVUbnHMHnfMizKdX9tncOlJtmkHNd5SUYIZQ/kPvgKVDoEk0r5YV5OpUGgafAyn7RpaMuWEiiVQVOw+LCf5aySxzkQW7TnMXYViL9UaTMrrojXSvxLCD09CJZqB0G/4q4C2wgpIeMGuuot16JFtGT8YnOSlGKIjQz8s5wWeOzJTjOmNQuhTRX5ME5CqYeEACJWOH7aRvdd0cvnEFb9/YweADqbQzAWyTAwGfIRxkrwZzDJBdBVVWoA1mnQ1it6iENQkG61lqE4mhO94/NY5zucRO5dBpSNEKHj06lCuQknnKnNLx3rWdTSzagJxREKM0mcPlBVfiakTTgyAP5JKUgitB7l/MZX9QZKBCx+KHl6MQ0aRlCD3AmyAZy/uJfjY1LrtIMVU1LedDKw43RXx6q+CRBtr8cOpUx34t6Ys6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199021)(186003)(6506007)(6512007)(26005)(558084003)(53546011)(38100700002)(44832011)(2616005)(36756003)(83380400001)(2906002)(316002)(6666004)(66946007)(66556008)(4326008)(6916009)(66476007)(41300700001)(6486002)(86362001)(54906003)(31686004)(31696002)(478600001)(8676002)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTRsUVNGOThhaTBkU3VVZ20vRzY0NlhnOEhjelB3MmI2UUkvOGFOVG5IUlhJ?=
 =?utf-8?B?dVJrRXEyd041VHRPNmR0bE9NVEI5eWxiNVc0Y2IyNlUxZnVLVmszU2Z1eXJa?=
 =?utf-8?B?NGNZY2paTGVQSzRjM0NMVmpHMmdzYTZySXl0Z3JwMU5WZ1ZMSUVTRGwxcHcv?=
 =?utf-8?B?akdDUVcvZ2xzcHlNOFJFK05STTM0dkhtdkJqaDZyQ1JZYTJIeWkyaEI4bVR4?=
 =?utf-8?B?dUZaSWVhdk1sWFJrM1BLZHdMKzF0aFVRSGlZYktaK1k3UHJVODRyQXFNWEE3?=
 =?utf-8?B?MXF4TTZGWUdUK3RkZWVicnQ4amIraTNQVXdZVHhDeDVZYlFKTDhod21YRkFX?=
 =?utf-8?B?WFBwUGkxWkZrQ043ZHdPWXBMT054Y3VBUjQ0d2d4QjlqQVV6WHdpZU9vUjRq?=
 =?utf-8?B?TS96Uk1ZbVJVUXY1azJNQUZLUmVnUjNHT3JqRnh0SzQ4UzlrcE1JZHJWVEV5?=
 =?utf-8?B?V3oxL0FHNG1ZVjlJWVVpd0RTYnoyVWwzeWJreExjdm83OSs3RDhFa1crUlRa?=
 =?utf-8?B?NlFCZ3NGemxiRFB5QnUrd2xNYTloaFdYaXNGRFByc0NnNTdPRmRlR00zZ1RB?=
 =?utf-8?B?TWQ2cmZSMFZVelJEanJNUFpxNTZvS0lCNkVOLytJakdwVDBxRzdSTXU5N2lP?=
 =?utf-8?B?TU8zZEJGUEpKSTUvNXIwMFY3blZxMlJsZkVQSlRXbkFKYjFJMDc0eWp5WTU1?=
 =?utf-8?B?bWV2K3NjRkdaNlFKWGhnbHdVVjJHMUlFUnJhM1FnUXNBVmdDVzlvaVJOUzRM?=
 =?utf-8?B?UEdyZ3hDcGk0d1ZvWDZCMHhNR0F2a2V3QlhtaGxqWHd6Mi9OMERQTUttU1Bu?=
 =?utf-8?B?UmUyNVhVT2x6TllBeWhua1J5ZDJXYnFPTTlpT2V6eEM4M1hQWkNQOTZvWmlH?=
 =?utf-8?B?WEpHdDk3OTNPaUhoM0gwWU90TWxNcEx3dFBlUG9VcUFPdW9VYkRvY0VET0hU?=
 =?utf-8?B?Y2U4WmZxUEZ3b3U5cit2bWZqWVpFU1hzaFJOaW5pNnNubHNiV3cya2Mvbzhl?=
 =?utf-8?B?Q3NLaHdocUNKSmRUWDY0MDluU1VZdm9BWElpWWlXNElmVk1GcUVUTXRmdktU?=
 =?utf-8?B?a3J1aHJaeStBb3F0cDRtVHQ2SEJWZ1U1VS8zZHlmUzlYTG9JYldSazgxTEU3?=
 =?utf-8?B?bU5EUWtWem5EVFEySVlPOWFsdktrWEJEWWdzcFpMTTNodWtKWDVhYkhDa3J1?=
 =?utf-8?B?RXZJNFVkVlFFNGMzTml3V0p5dGFZWmdKaVdLa2RuZEZJdEpzUzM4MXM0VytD?=
 =?utf-8?B?YlIrRDVWS1NLQ0dvQUs4V0VhdGFFRDhFVGJuR0RseWhkMXFGRjBDNzlQWHho?=
 =?utf-8?B?bVdTWVQ4MHVLMmdFRldVUGdjWURZNWZqOGY3bUhJeWh0ZCtGZHhCUGcwT0pR?=
 =?utf-8?B?eW1CREd2TXhnRHlYNFl3blVqY3I5M2NzRGhlSXZPZVBIdEJwTWxhcE41Tm5t?=
 =?utf-8?B?S29xQVIyVlRuT21GN1l3d2F4Q2ZQcjB6NDVwVXBkY2ZFQmN0S1l5SGhjZzFx?=
 =?utf-8?B?Qm8wZmM5dHc2L04ybVJPZFREWGRYVVlhenBabjkzbFJ1SlZrTVk2c0s1MUhv?=
 =?utf-8?B?c2NRM0V1eU5qZmYzQmE4YVBFTEdNZDFzV1VDbWo2SmNDaUJzQ3IvVUdWWWtT?=
 =?utf-8?B?UnNPdXZ4ZFR0TURHOWYrclRvNDM5L2tvR3FmTWw3b0FxZHFYczJSYUZkdzhG?=
 =?utf-8?B?ZDFFMjZGUzZrYTlFV1J2TEN1QUh4ZnJwdUdjTnltaGMvQTFTTWRjTHBUTlZ3?=
 =?utf-8?B?Y2xvWmZJaEJWVlJTNjlQdSt3M2IvSCtUWWtrYWFoT1dSRGZQdG1JcDh6akNp?=
 =?utf-8?B?S0xTOHlDbVBsYkVJbHVZRG53WjRoWGMxYmtYajhIajZYOXBqY1pySThSY0pQ?=
 =?utf-8?B?L0xrVkhjaTBsU1lmMTFlQndaNmdFWTl1dGdlQnFQMnlodFhKTnJvREU3Y0d6?=
 =?utf-8?B?NWYya05kb2ZLU1NIVVJlOVZDOWxQWUphb0lOOXZhOTFzRmdSbkN4VkZkeSto?=
 =?utf-8?B?MUc1UjNWOEphRG5ac1hLRjUxenE4aXh1b1I4YnBHY1VWSG1sRm5DMlZnK0lZ?=
 =?utf-8?B?TjV0eEZQbnB3WlY5Z3g1bnM0dUtMMHpvMVZuM2J3cnFnWXgxRVZGa1UvaTlv?=
 =?utf-8?B?Qzlzd1lrY2k5SDhpMW5WcHpQS3NpYUROeTlXWFJBN05UZHJ2bE8rY1VlVy8x?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BAGmP3Xhlx1keEGAwEDDwpZ/I7PlSypHJre45+cNqC/LYhxb0p38izkwi3qy5hXGjNyGTBXBVmc8euNvdrQWCXWXIRb1XwQ/zyoZGY22pcvB/6RtpHjEJUtsWwqwdFlgZSUBxivaveCJE/HGZ1eKnGOTithjMC2KvVCqcfiVkHz7AOzJ9CsiVHDSvsU0BOs4flrh5FcuUd1y4dwTe5cAsJIHAZp2xAnhIzRaVNdqPpI6hF3yHVXHPrdEdN/ZijahWbPojHEoBCQOcKWYOclLebdzRvA50Rg6vwGVNeIA7WSVKRlIUFbLBrLcSA4xhj+EaQ8g8DSZ+K+8RLU8RObYRyMKmM2DjnwML1w1DMH2twM/YiHiHQrSYmOHHMOzeUq+8MB9EvGBd7jVn3D/Tuay4Xl1tdwQYNTwC7A4RrGpyEhdqigiqoH2uvQhRs9QCChEDLmTrItLPkceak8HOxXP5QONBawFHB3fXCDDmPPO4Pn0+RIjMy2ldiMKTGeo4dCgeLWlq1eYDBlVSRMhCAMttAaq3C48PmWE9Zs9fnykbWqyeBHoh4PdfNXmx6sg44ocuoJUdLNhrLgrb4yZBvdS1kMboVJJ34foVm7+20f3DbXCnBjEoLSrVaupM21AOdR9uBWk892uR/100Wi5sCsm141aRRvhnu9vhVGzPGv7VgyQd2W7QSBYZe7ABt3UcKLTQLVCT8mEP7dMGwMWjepFpZkk68ysWiNgE7v9zaszHaHO6IcemXTITxvDgiikFhTZGuKpX9mHYx5pujMI4cEcHYaB+6iOqAVTFpNeR2v+IrK/bTFOiuiCBj+g4QI5O1565hZpW5AouLR9R+I676Ftlvb180aP95OaN1hUVM5rpHE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78259575-9799-43bb-fb61-08db5b83783e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 11:47:22.3270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiZ6GPkhzsNcRbXkaCbxnYTDEPRCgX3lCZZ0icEwKYxo9J25sD3FUQXpU02OCAJrJGyKiGVm9QRwwl+Ljf6Abw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_07,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=806 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230094
X-Proofpoint-ORIG-GUID: tDEe1EOVAk2Gzt7fWXzPJpvQPbyQINR7
X-Proofpoint-GUID: tDEe1EOVAk2Gzt7fWXzPJpvQPbyQINR7
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23/05/2023 19:39, Christoph Hellwig wrote:
> On Tue, May 23, 2023 at 06:16:25PM +0800, Anand Jain wrote:
>>>    +static int btrfs_verify_page(struct page *page, u64 start)
>>
>>   Did you consider making it an inline function?
> 
> No, why?

As the compiler optimization may or may not inline it?

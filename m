Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663045245D3
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 May 2022 08:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350421AbiELGb1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 May 2022 02:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350509AbiELGbQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 May 2022 02:31:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC71710FF0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 May 2022 23:31:15 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24C5mFs3013766;
        Thu, 12 May 2022 06:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=efoggfdsANOcVVnRJrnOkhkiZ2QbCW59vfkCRj9Cg9o=;
 b=yi/jO3f1yXls2YetDFdEzA8remtY6YJZX+mQ/ojD0AiLdBkwu80OGpTeznJ2gHlAKAej
 JSa8YMFyLWfI/netEFfc3qkaRHHARiryTU4OQWY+iuyzrOVNqJt9goulUTGWPUv9+Bt6
 mVX1EpL02p3Dbw+3k4Mka6ixB3ZvE3hMjNKjE3NlyoqwK4Br4kJzWcHuUaMXqTow7Lv4
 T1NDPJLmsf0Sb72dSGGl+ajPTCIRfgXN+JfpqlcaGlBzfFTA6e5YeF0oaSjj1uRBOJIC
 wAy1iRAOgAqHJyzNUKQ68qnaGz7nkuKZrPCh1gV/whK7f8CS2dI5Y8hb1Au49rEWMHYe vQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgn9uc2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 06:31:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24C6KVig006797;
        Thu, 12 May 2022 06:31:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf74vn5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 06:31:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHjKTYGidXFzpnBgaQ3653e3xcfGCah6kqxWVyFKu42eTQoXEElLBDIX2Wq8cyZ2nGh9m3N5wBeOuqSmSA6MTNfDaTwvL/put8Vx7bYfOczpTlLyc52YZfPP7WKfAwOQks1G/yPn/g+O1LoAfQDDbm+0inIC3dZC8ZuXCwAEW12QGBp8IHjYPTxWzIRE4cSnUGUTmMYpM/aTx1zg9TKNyrbc94bI1jdypD9NN2EB6k05ZXtLREzSUNgLyZfaunqXwtBahbyDnewfTmLQVxKO2WORdS8O53Y/jFfRKLEONc1hzm2/+vWm9+I0ZPsvIHx2spK9KOfKit0hBh8fBcHS9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efoggfdsANOcVVnRJrnOkhkiZ2QbCW59vfkCRj9Cg9o=;
 b=Pn8EXxeBMs75q86cfm+59sJoHla1EqFG8xFu0ivfmRw3+enKCiuLMjKsDga8N27JbBNuoX3ODbAuJwaJ86xKmHm1dTLF987xRXGb8O/0n0G5VZCZF9IxY/hGA1GuC8nvXUrdvOrhmeloF6KEVAj2dLAmvShKeKinZtCrlFoiZvqh8R09TTD1KA2/uUtjQdUfo0Cm1oVgz7v7ipXOZjjbRB+8Yl1wtJsZWf+Swk1GdD2UPKIdk6PxBFoR++/lM5lV2w96I54bdXbqx3s+eKrpZZVuypr7gz3sxqnw1Vsq3YIz0FNBDYjmSuHsgOngW6O4JLh19Eniq9KEtnb/VgOtQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efoggfdsANOcVVnRJrnOkhkiZ2QbCW59vfkCRj9Cg9o=;
 b=KsYqWLRlno2GVnoDyxkeVEybLUiYKVvwWgAEk8zh9XzUA5XGmE7vC1rtUytQctTKfF1YFkUq1qZGeuC4F1IGzmNyRfUh+/B+21cD+THgCL53/sHAcDabTr06NLrOGOBqP/0gWbWZgIWVL7kdpp1j9uJKq1FYzt7SSZDuCzGM19c=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4744.namprd10.prod.outlook.com (2603:10b6:510:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 06:31:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306%8]) with mapi id 15.20.5227.018; Thu, 12 May 2022
 06:31:02 +0000
Message-ID: <eb6a263a-0b5a-e5f1-04a1-4448d536e7a5@oracle.com>
Date:   Thu, 12 May 2022 12:00:52 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: cleanup btrfs bio handling, part 2 v3
From:   Anand Jain <anand.jain@oracle.com>
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220504122524.558088-1-hch@lst.de>
 <a6952ff4-1e4e-5650-7d57-8fd442e9d5aa@gmx.com>
 <20220505151128.GE19810@lst.de>
 <dfdec676-66fb-c746-7fbb-d9133cb29377@oracle.com>
In-Reply-To: <dfdec676-66fb-c746-7fbb-d9133cb29377@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0128.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2cb7ff5-8547-49c6-04d5-08da33e0fc21
X-MS-TrafficTypeDiagnostic: PH0PR10MB4744:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB47442CC2566482A193B57A53E5CB9@PH0PR10MB4744.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q1Gtwn6/qlnYdsok1hAQdq44d2umoDomOrswaosizpPduFxIQoTfnBi9D7wSjgtraLKBlhe6U9kvnAOVuBaftbHRE0B/sXgBVKNTUSPic9RXEc1HRuS9wRu8AvE00/LxD8XX9J/i8rg8V2iwd5hFxg94HTQAGJroRx7f1BEd57FnqNYYF+P4sZTRUwkf+cun7q4NabYNdJCS1LCUyhGInvR5HW1keRT9gj83wKwuZ9xC+cQx+CGsUwsyzsqkmXqvasDFW51sFw5NqOzZiSBFBeYYpFuE8SiLZEOxUPgsYUUKp35ABZuq3TDBNu7SbW7q98JOPGdkpY0Z6SQuw4p7fedYPkTT0JW561ybN+RIXAZ8cBup75HP/1Rsma2CUC2QtDKCfJxQ81HIJPqhTuEHzO+XNpiL6EbTykIdHIDyPzGGFKNHsGaWhtej/4eZU27rcPLiaNxVLEPHsiHf1xhcGm/XODU426o0dd4O0n8NJX5CFO587gGlIk2nKf7kdXqC7hxsH1kiFrHkjO6aKKooJSattBE1h5vJFem1MBGKXveI5kkBiUwFdIZaRG+hgydZbnVn8K2DEiTQ66QCLmOgnvcYxuihSRuUBvuZf5TgsZuFS65iXqlsRtesqjW+5k7AKUYjnwgY3gCj9K4g2nNMdOJg1U4oWhnXoquj46OFZ22bbtdiD/wFTE0Ekv9mBdarG8CqRFMoB1z7bRZJB7axnu+qDbxOgpIaWFXMwGJzdDw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6486002)(508600001)(6512007)(86362001)(6506007)(53546011)(6666004)(186003)(2906002)(5660300002)(31696002)(2616005)(36756003)(66946007)(54906003)(4326008)(66556008)(66476007)(8676002)(38100700002)(31686004)(8936002)(110136005)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3dvdGJvMkZJRHE5L3I3NFoyWkZvVDJQQW45eEV3MHRqQnhaTXZhbk5keXcv?=
 =?utf-8?B?Qmd4bG01ZTh1dFAwUnZUdkROVWpCNEZCYzRjZDA1d1NiRkU4RGtGWG9NNTdK?=
 =?utf-8?B?SFJscE1tOXlGNmZNSkNHalNKRVlBNWxQVEc5Sy9ndWFxUlI3Sm1ZVDNVRHRQ?=
 =?utf-8?B?NmtUUFZPcU5UTWIyVFQ2cFlwVXBlWThBVzVUYnVHVG4wQXhJNnhWWjhYYVpX?=
 =?utf-8?B?NDZreXlnVzNQNnFGV0FXKzNNeFhKZ2UyMXZ1OER6cVdVZGVVMjljY1VPZlFZ?=
 =?utf-8?B?bTRzTERNUVRJTFR0WGZXNis0SGcxUGZvUkhYTlFPcm5PeE5NVjhZQzBSM2pw?=
 =?utf-8?B?TWQyTVpXb1BMbm83THZlS0lFVGFXcVlEVkYyN2hHV05yekR5R0JlTW0wbWQ0?=
 =?utf-8?B?eFZaVUNCVFYwb0JEYWUyN0w2MTlLOERoSDcxRVBzQzJXNG8xbWFsOUlyc3B0?=
 =?utf-8?B?UzBlSUVxTE51MllTRERKdW9rS201Wkp6NVJrTmwwSGJQaTVUSW5zU25jZXpZ?=
 =?utf-8?B?QWhpMkRaZXNqU3g0YXJySWdCVThqV1NRN3d3S1k5YjdlbnluK1BwU2tqTXRp?=
 =?utf-8?B?cU1MNDA4T0xYK0RlbGtWSEpYYi9kL3hkUHFzYmk4bG5rek52dlpvS2tickxH?=
 =?utf-8?B?aTZSeW52QXdPdEtlVGV6Q05FcmVsdTlCTG1WSjlUOUFwL1dtZC9aUTZUUlpC?=
 =?utf-8?B?WGNGRVNEcGZOcERldGRPQzhaS1FGVHh0NENqZ2dtUHVLbmQxSngxc210VjNL?=
 =?utf-8?B?U096M0dpY09nWnF2ME9wYzFiY3hua0ROZy9WRWo4aElzKzZPWll5ZTVYWmpp?=
 =?utf-8?B?bC9tbDZWdWdldnYzUVRsNXFoSDJQRWpxRnVwYk00K21wckY1OHdJYWt2Ujlv?=
 =?utf-8?B?Ui9vWm5ub2tZMjcvREk5UnE3b2RUM0NuWFJlcWtmTndtR1AvbmVlU2kzeWIz?=
 =?utf-8?B?djNZVUFjcGJIbjB6UU5OUWk1N2l5M1htUXZrNHYzNFJlNDU3R1NsZWZoMjdE?=
 =?utf-8?B?c3hXNTAxUks2eGNXdUVWeVkrWUZaOXVhS2hQUHZrMXlrQkdUSzMzYWJQMXJa?=
 =?utf-8?B?R0FIVDRLUGd2aUFEYVpMNHRZWmhSRWtscm8vSXZkWDhmdjVFWlV1aDJvTWJX?=
 =?utf-8?B?cUFjc2FwWU44aFpTTFp6aXZCQVQyR2hIVWdpOXU5d3NWTlpyS3dFaU1LYjZO?=
 =?utf-8?B?aitBZkpuNUZaMkZTOE1LTXRQZk95NzNEaEhQdVk2UVA0UWxFYi9xazVua28x?=
 =?utf-8?B?anNsSGhCWENtYVhPZm9MOEluMDl6U3FMQWxGMC9NWXBEM0lwblNMa25kRTNy?=
 =?utf-8?B?eTBNS0NLcVhia093VVFwdGI0OG5NTkZUSSt1UVJjYmFXdmFpTGd0MG51V2JV?=
 =?utf-8?B?NVpEc0hScjV2MExUVGVka0lkbkIzVGZzcW50TUJHUElxT2JJQ2ZCWEhVTlJP?=
 =?utf-8?B?R2duSUxuWmx3aTNJcUo2dTJ4MzQvb0FQellFVnVlWmlnTDhyaithU1JWQkhP?=
 =?utf-8?B?MnNoaUg1K2UrdlV5eXY1a0tLdVVzQVUrLzdFeUtpbFNMSDdRNGR4ZnRWU3F2?=
 =?utf-8?B?bzFBOFZ2ZjVMNFdEU0c4NmtpVDRqdUN6WmNBTUFGczI2M0JXc1ZKNDNZRmwy?=
 =?utf-8?B?VFB6MG9ldnNBNzR6Qit5djBESEtkUjdHZXhPSGtlSU1md0huNks1QUJWdk1k?=
 =?utf-8?B?dFRqaFoyejlLY0hKdjRzTXJtWjFTNzg4Uk5hUTY1NFF1NzErYTNLSUplamJL?=
 =?utf-8?B?MDZaWnhEWVFMQVR4QXJMRHp6MVJDem52VU5FbzdFRjBNY0RVMDBRMUlyZFlO?=
 =?utf-8?B?eS9IUEdja1BOSWxFSlJPbGVRbVAyYnRlcWhFZ2FoQ2VWditkek9oSldNSmNi?=
 =?utf-8?B?MDlpS21PWU9rYkR4YjdvVnhRdUliT1JLZkhMR3VWajBXakt6WEl4TFBVS3N2?=
 =?utf-8?B?cTdaS29MUjBDZ2x6eGpWVGxrKzMvZ2lKOGlxSElua245T2RzTVgzZk9tem9j?=
 =?utf-8?B?M0x1c2tFSTRRdzJuUlpBM3hJL3h1bVVvVFZDZDdYYUw1WXFGdkc3dGRJVkMv?=
 =?utf-8?B?MHBkSGc1dFNkalo1TXR1eWE2SUR3RmNhZ0JUMGUrbE96TmJEekRqeHNGUUJN?=
 =?utf-8?B?UzdJU1lwaGRNUjYxdG10NmIvd1lWa3dDQlpDNjRDQ2VXcm5TenMvUDBQR2ZK?=
 =?utf-8?B?Nk9QTHM0ampNYzZRM2U0UjVpRWVlRGRVUUl0cFpFY2JxdmgxcWtGSDNBYUhY?=
 =?utf-8?B?ak8vYzdPb2FSVmdUK0Y4ckJTZ0E5S2NvNmhybjhrSDFWNjVFZ3hFbU14WVl5?=
 =?utf-8?B?c2tiWHpBY0pZWGxINXNIQjJKQUZ0dDVoRUM2dWFRdjlHZU5vZktTVHMzRWxP?=
 =?utf-8?Q?CHLoauH9HcZ0zOhBuP5NcYL3LHt2sKlQ9fU6IocyqZdy6?=
X-MS-Exchange-AntiSpam-MessageData-1: 0zYQXmwnJ3hhm3adIAEtJRC04JDARw9/68o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cb7ff5-8547-49c6-04d5-08da33e0fc21
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 06:31:02.5184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Knd4ZPFdxqp2GmDCeiIWQlLy6C4j+abGZEww+Agg7QCgaKkpknarBkZeZdprjaHbL6Kp5cKSOy1lcnVLMxoSFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4744
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_01:2022-05-12,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=858 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120029
X-Proofpoint-GUID: STmkA0mlas6dqt_ZgNA-q-bx8ieuUW2B
X-Proofpoint-ORIG-GUID: STmkA0mlas6dqt_ZgNA-q-bx8ieuUW2B
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5/12/22 11:52, Anand Jain wrote:
> On 5/5/22 20:41, Christoph Hellwig wrote:
>> On Thu, May 05, 2022 at 02:56:49PM +0800, Qu Wenruo wrote:
>>> So do you mind to do some basic benchmark for read and write and see how
>>> the throughput and latency changed?
> 
> 
>> I'm not actually seeing any meaningful differences at all.  I think this
>> will help btrfs to better behave under memory pressure, though.
> This patch got me curious a couple of days back while I was tracing a
> dio read performance issue on nvme.
> 
> Yep. No meaningful difference. I am sharing the results as below. [1].
> 
> [1]
> Before:
>   4971MB/s 4474GB iocounts: nvme3n1 545220968 nvme0n1 547007640 
> single_d2/5.18.0-rc5+_misc-next_1
> 
> After:
>   4968MB/s 4471GB iocounts: nvme3n1 544207371 nvme1n1 547458037 
> single_d2/5.18.0-rc5+_dio_cleanup_hch_1
> 
>   readstat /btrfs fio --eta=auto --output=$CMDLOG \
> --name fiotest --directory=/btrfs --rw=randread \
> --bs=4k --size=4G --ioengine=libaio --iodepth=16 --direct=1 \
> --time_based=1 --runtime=900 --randrepeat=1 --gtod_reduce=1 \
> --group_reporting=1 --numjobs=64

  Oops wrong thread pls ignore.


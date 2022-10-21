Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457DA6070F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 09:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJUHYW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Oct 2022 03:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJUHYT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Oct 2022 03:24:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657672465D7
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Oct 2022 00:24:18 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L5OOlx001028;
        Fri, 21 Oct 2022 07:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=l+ImTYZAtZSvZtlJGZaaa0GTIaNec1pLnr9B+/FgoTo=;
 b=LbR84phIUeuR1eMtLiqLjW3Jj5ZXXCUMg8k27PuUp5p4lczmptqe1LsyP23kQUH9SVPN
 I9Ol4ekF5oii7ppez7hBiA8KMH4081JBHdXznRx3+IjvpkbJzxIvo0vpfKMV3HbQgByb
 x4+qtYraSsJ8+A63hCKYtiXKPRZgql7YGigzB3D2dPGfpEAJyDSTy9Hyb0FWeP7+XudE
 8etRBi0tM4fUr6CJ4wdsdfrHWvTfNKKgbFQpySToFDaAo2z0JyaK2QuBPdTl9AdCD2oA
 qvgf8Dg2ZNeEkosBkXavC+VonW/uFHEGOrRmMdzsvBunMA9S0J3EIbXZhev5K8bAAzRO mg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7stjd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 07:24:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29L59Mgt027371;
        Fri, 21 Oct 2022 07:24:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htkbfm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 07:24:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cohmn1OHgm5vOB5wh38eAGAKf4tSBeMKfK9IdiDbhrSLc3dKud8ESwEyA5zWYJOypkA056J+dei537IA8OkSaxmJyfSMLWrV/zYHJXDQqSIK0J3lBMa/bdiSCS/jZSgEuExb4zs5AKcQaBXs01W0fXXjF/vCM3HLFhjA8owBf+3+2gO7DELwyCN5cjNIwfFmfG7yKKPdwAPK/xydTWVZ6fliHY389pINT6noBuFYc2i1pNmIVj3wiZJc3jKLklBs44H0WRq2XvhjW7lNcIOj3kizPpafilXAa0xtNyl/WNtjvFBOzIPIlC862MS5ULPKxj4rYUgA4zs52xFuixTUeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+ImTYZAtZSvZtlJGZaaa0GTIaNec1pLnr9B+/FgoTo=;
 b=WQu7L9wT1FSpThIZPgOjjTu+kwVGMieLRizQ5ttdngECBml9S6M2hKUaP19DJEp5rb4dLW8l604ZbdGlhDbUnYH0q6mAxAjUuKCQRL7ahjYpqQ1ca6zyPVaFObTtXF7wzm6InLLLTTT+D1K0oEr3PJaPii85WhH6toYOfhVfayZEqrO+oWlNQzV23bsSFZ4WyR1ATU3cBucnEPr6+IVRE9ST6WL5ZPwHuZh2npky8Was2GWnJQ9sVPZc5TNgDV4mrvL3T/kVy0KXPblVx5/a3j4QmGNGseqktJWTbhWS5ODpLnuj7odRZMto5RydKEr2spnnpS7yuh4u8aG/l33iqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+ImTYZAtZSvZtlJGZaaa0GTIaNec1pLnr9B+/FgoTo=;
 b=yVQy8vbsSep+h2IZ+Ecrm4ZF8l8myvKbvDgU469Mo5ZRuFELyXfXhhNeNT6fXlI4ZlAuJPDESeIIBW0EgeMGEXaWbHi2hP0QfvQq2aFhGva/lIXj3vcx5vsC13zizMfrq9o6gi+eD5NlrnDZpSV3p+sOKxv/MTDuDUUCoVHclqQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4661.namprd10.prod.outlook.com (2603:10b6:510:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 07:24:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 07:24:14 +0000
Message-ID: <29013eba-cb3c-baa4-45af-4930c5cbad93@oracle.com>
Date:   Fri, 21 Oct 2022 15:24:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 10/15] btrfs: remove fs_info::pending_changes and
 related code
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
 <dd2d57bb9c440c765be0b7f34622351283edefdc.1666190849.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <dd2d57bb9c440c765be0b7f34622351283edefdc.1666190849.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4661:EE_
X-MS-Office365-Filtering-Correlation-Id: 4975cb71-ac4a-4a65-6cbf-08dab3354149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZKTSaQ1FiTaKtNlJQiL1ImUbYt4am0xyjW9g6MTJnyMdNXx3YRtcul5HJeekrcQ+mYopQi3LtpvhUSP0V7cAA2tgRZzSUGwXABcu227IflgMHVaxS0n5qILFUZI97sXU/3JXTNWK57wCjcA8Qw/CAvrh+F7Y8mH+XUsa0DZpBr+ANHb/4ZjD3Phq7egjAcCYFr0jw7RUz5XubvVp6vzgjWlha3S+iBFKBNn4E0G6q3T+R4twkQvp+iAjJQAbAJckdzVlndm3KG/NLfkwK6n/nlOAK6StRwEuvBGiJbAYJRbSi3HesgnYRgXyGqzr7E9NGaM89YPriusz0qqCqHvBKJX+sVx9B9w8n3Rvct4jVfwNiC88CFhRsVxW/PeU5e5vHjb2FcXi7K5U8EZfekispqCY/adtqxEIpC9kelYRluWMpb44A4jLgAPX8rFqe5TM8m7VsVsBHr4M39GHeOf+OjvLhcnf53rbmASipuvayNC0N1trs7dRF0oaXKhi2mTj/aLx/JsXOBth1zv6Coz1wOTp4GxLQW0WCAgz8j3ZIixNHcYw7X46mOIA2Fr5GLt7ZArNRAsQNggCTjOReQB1E6JE/2g0DYkDIdf1OhHb3Wim24RYRdScZZqauMPufhwcmZ3FtSIUS5jgHRIzPkmfKcKFDIBmrZgpSfc04LxqogBWIEuS9Ow0LJKbivtdRoqmfYkoez1zwrW9olsJCzAZEQS+FjFwUHMP1QNnOsI0GGTqSS1EPeLOjIH536gViNfTsZYumQEIGJI+1csMoHXYHWsD8sWfqjX0WHiWKNIKbs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(186003)(6486002)(38100700002)(2906002)(2616005)(478600001)(66556008)(4326008)(66476007)(86362001)(66946007)(8676002)(44832011)(8936002)(4744005)(6512007)(6666004)(31686004)(53546011)(26005)(6506007)(36756003)(41300700001)(31696002)(316002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2lsTE1STGZ4dEtrL3J1b282UkJRTzhGVkdZSzRiYWwweUI1N2VPUThaNEhH?=
 =?utf-8?B?aFpmM0RhODc0K1M2emdVNlNEalNEU0hqekJPOW5RUVdvRjlrR0V4cjJQTXNL?=
 =?utf-8?B?SDc2M1B6ck4rYUJoVS9CdEhLWHZXT1BPSWlkdS9zWC82V3NSTVJmV0t6cnZM?=
 =?utf-8?B?V3I0ODJkU1ZXMGpvMi9od2dNbGs5RE5tQ1BoZDZBcUMvYmZhNllFdVltcDJ2?=
 =?utf-8?B?RnNCWXJZS0I0dHY1Y3p3NTRLcVF2UnB6emR4MUs2SDdlQkR2bitGNzJ4Qnl1?=
 =?utf-8?B?clhTRDFYbkE0cUZRUllkOXdxeFZKMU9BK3Z1a1l1ckFzcXVYeWZXdGpzcmJL?=
 =?utf-8?B?YVB4RXk3UUJsMXo3VmkxTTR2UWttTUtaOVc3VUlSNmVCNmxtR3loTWYvR1Jh?=
 =?utf-8?B?TTJLM1ZGbGc3amRqdFliZ3B5dGlHVWtWMEJYMU9ydExkZWRKdE1sQWR1eEs3?=
 =?utf-8?B?TlB1YXd5SmgzNnhtalRQcmtMcWZwdVlHZmdGMkFlVzJjdzhlUVR5YWNUMll4?=
 =?utf-8?B?OXExQUVYZHNSUyt6Y0hxM2FxSEdsNHF4b3YyNTZhT2hYRVkzK1BVN1ZGOVhU?=
 =?utf-8?B?VnpOT0NJUjMrU01wWE92VGxFWjRMUjYzRGo0TnB3MVl6clpralZsa3BEUkk5?=
 =?utf-8?B?K3M1TjdRL1RFczV6VThybVp2SVBZellSdGVBRTlCY1kxT3JVYmJrakk1bFFr?=
 =?utf-8?B?c3FaWmd0alAvcTJVa3A0SHpPYnJzYzEzaFk1YlVLd1J3V2tTbkVZbkh5b253?=
 =?utf-8?B?eFhjSnJjdFVxdGRDbnE3M1lXNWdWTVlpcHZGMHVsVHE4U3JMYVpwY3IzTnpE?=
 =?utf-8?B?ZmRlY0lxVURnWWZNN0NsQmhrenBZOG5TMGJzbkhRNUhNL3laeEk4c08vYmN5?=
 =?utf-8?B?MElJWXBBQVZXNVloZWJBQVg1NFU1b3hENWxDeXRXVVo3QVR0VlZRby9LTEFJ?=
 =?utf-8?B?VU9BU0lMZkNubjU5cGNHaTNkeHdpSWpFUUhZVUFEcldxa0Y4MExiMWxtektL?=
 =?utf-8?B?VExRWGUyT0JxcFNXMzhkTUYyYlpUUHhNQUw1RXNvc0Y2YUQ2Wkd2VDMwQTVK?=
 =?utf-8?B?eVN1ZXdLcWo3WkJxa08wZkhSZWpZd0VMZ2VXaEVIdGZ0YmhjWDQ5TXQyd0tF?=
 =?utf-8?B?VkFtWXZqSFFJL1pGbDJlN3lKMmdmTU5nNTNYWW1Gd2srQTUzMHd3cFlZcGNT?=
 =?utf-8?B?NGtlb2xMVGNrNUVNYk5iOFducFlEZ0ZXM2craEVyc2NnMGJsV0Ezc3o3U0tL?=
 =?utf-8?B?aWIzSjU5dGcyd09aY2xkWCtXbFA3dUcxV2VwcEh3VkFiVmlEbFlMUy82Vmpl?=
 =?utf-8?B?TzZpaHhWdE9yTmFuVUJBNndaMkl1THovbFJoNXl6SkZTRzdOV3hIRWtnbEJz?=
 =?utf-8?B?NksxUHU4NEhYbHJZbVB4UUVCMGEzaFdqUDJ3c1lpME5wV2wrQlBia3R6dDNO?=
 =?utf-8?B?NnR3eUdpZUYrb2hRMUVRM05Lejh6K0lKQzlXOFBDNDQ5RmRFbi9aTVhWY0Vv?=
 =?utf-8?B?RjVyWGRRYURueS9hd0hhLzdoM0pFQ3dlV1I1K2JlU3NPa2tZa2FLekRFNmRn?=
 =?utf-8?B?TWhVOVY5NytKeUM2SE9GWDRrRmZsbjN2M241ZVVXQTRTUENrNC9PWGsxUjQ5?=
 =?utf-8?B?bzZKZnFFYmdBaGFLMmlmU2szWThQRjNraisxMnZQdUErK2tlTitkcmgyVU9w?=
 =?utf-8?B?TzVFKzFVaUtzNXlGbjhkL2hnZXk3YUtkUFNBcGl1RHpVWDE5SGVjbmVBUlVr?=
 =?utf-8?B?ejZYbDlEN2NsaVJkbHUrUlZmQ0tFLzNGWWVCbEVYT1BnRGpNemtuYzhvNjVj?=
 =?utf-8?B?a3BkNThlOGc3RG96dkhUTDdWVG04eHkyQmZneFAyV0sxUFFpT1g0MFhRN1Bs?=
 =?utf-8?B?ODNZdGlZMkFQcDVpRWRhNS9HeVBQSXloUS9XcmhYbno5ODQwaHY3aFFCcFBW?=
 =?utf-8?B?TmZxWjRHZ0JaKzJZK0hCK0g0VUtIZGM3YWFOZlZER1dySU5UZUpjVVZSOW55?=
 =?utf-8?B?RmIzSGtCQm1BQjNzeHFiMm84N1ZHc0NOVjRkcFhyL2p4MWNzUk5TWDFGNHMz?=
 =?utf-8?B?eHV1WDMvdXRmc3RyODNRZjZsRU4zNXZkU2htVzFUdEs5bDRPZlhPcjRIUmtO?=
 =?utf-8?Q?39kFHzt8JtzBit6A9XM0NzFIE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4975cb71-ac4a-4a65-6cbf-08dab3354149
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 07:24:13.9909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/TAAY7m+yB4aAcidCPkl16PFKwjjiSr1ejRnT4qzKuyhn8MS/zk4E54cpyfVa4CNFBh0UixSFTeuxYzNMGETQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_03,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210043
X-Proofpoint-GUID: RBhVxsY3tyx7JHWKZ7tdkXw2X4sUiZQG
X-Proofpoint-ORIG-GUID: RBhVxsY3tyx7JHWKZ7tdkXw2X4sUiZQG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/10/2022 22:50, Josef Bacik wrote:
> Now that we're not using this code anywhere we can remove it as well as
> the member from fs_info.
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Same as v1.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


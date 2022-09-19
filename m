Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F515BCBC3
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 14:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiISM05 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 08:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiISM0z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 08:26:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5219F5B4
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 05:26:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JBx83A020153;
        Mon, 19 Sep 2022 12:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+27K/MIF5Mnb57ZlDpHtRh4yPebJgS5vR6KgF+VePcI=;
 b=FbC89urWQL6Vj5Gw4+15Sye9AoAoAPnGEclqmlxHomUXxC8hRndQuISCJFMKkN+FkJ7H
 Q2c4ERZwv+2kPo4cGFpjMAA7qGh/7TbwdoL7Gh/U/1s0SzjoNCHYMahiQNSpXHzIM0UA
 t4VIwIzGvRBa3l8Y+6oiwQ00fwfP0dw+izkSbUnnCIYLFPboMVRe4j6Sag+MAB2G0y7n
 Hfwn/qfL6GxwvJYWbWxo5uCWQa931zP0048J+oWDbiuAmKZoYKvj5QquiL53sZ1fyfws
 ivwRLhUSPcI6lycGuwH6Swnu70FNH2yAwbQqB3Ar9U+vCm631rvM2FUcki6eT6ew2vz4 1w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn6stbpf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:26:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JAt8PK010067;
        Mon, 19 Sep 2022 12:26:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39p39ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 12:26:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKFjOeWt4fkQHoJRPMqWQz6jQjVvS8dsU7G/lL5wL8aV8M01l8ASpBx6Fmw8TdW3Vc4UniyO+vyI6czBQIXkt2bA6p45fsEJtM7brTIErNHrbeENtUA0FA/rO2Uy3mthggID8BOWI8TJvpDUnUs0i/iVdcBMWKMotMETclHYrs+/Vi3ykgaUENSO5nYHRmUcK9JWediN4/YIEm0lP1eVhuoQR4gdyUX7udcJJkPlBy1bdFBy86uYEyWVRGJQT37jwNMKrlnkvo3MdwMwtgbGTkerU2VI2ZC6UrFUGDK4/fCr4GVY39IxtpsuO6tIAC/Dot/iilKmq4fBYCO37Sezvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+27K/MIF5Mnb57ZlDpHtRh4yPebJgS5vR6KgF+VePcI=;
 b=E6lw7MNDkdKw9KQRQs6+v6TradLqxc9QqS1mbCLcg/V0OmaIs9MHLPMAs12wXBhXiQz8z03vDEOPrSAxbiT6YhEiVidzgjzj6VRI5LzvHbzubPw1cf2CbiDsTx1hvfva9NWT6xxq2EAI/sZp6HOXFxRqYATZqKdbe5Zoj6vH0NXwi+FeTmKy9LWIQ/z75bDVWv8DrMOPrtUcOoYLG7wiUxGE19UDwzci/PbyCB9Lbv5CEhpDI3jHtD9Q5W24eAQFKXEvvHAHiWg80LAxV6lk7s0ao87Kt3KjqPtj9pP3+kmmeVyLa2FidZnueCezQ3ycmn+wEaMyUTqRvisbP4VhVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+27K/MIF5Mnb57ZlDpHtRh4yPebJgS5vR6KgF+VePcI=;
 b=DAThdQvdpC2/lsGBC0QX7YGIeFKJ/nVRAbDQjO/Y0/rNn4MseKRzSRpXSd4SEvVlKecgpR5idz+V/AjLFRr30MeDbnLRNVR2GcFAmBgAofvqq2nce5RrNkbaBF1XpPGvCfuqbDd/VRK2rUuVRJTNnTC+vIJcHiQh0d0jzi46C3Q=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6283.namprd10.prod.outlook.com (2603:10b6:510:1a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 12:26:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792%3]) with mapi id 15.20.5632.019; Mon, 19 Sep 2022
 12:26:50 +0000
Message-ID: <cc25ff87-538a-edf9-a8e4-d7bece672266@oracle.com>
Date:   Mon, 19 Sep 2022 20:26:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 09/16] btrfs: move mount option definitions to fs.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663175597.git.josef@toxicpanda.com>
 <7f0974cdcb5a900311ddfa3bc602433e3aee2000.1663175597.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <7f0974cdcb5a900311ddfa3bc602433e3aee2000.1663175597.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b62b45-0e45-4400-716c-08da9a3a3a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VC6nTB20t4KD7Jz5LktCWNcY1GWxXpBlKKyzMlJ7tbIgJSz+TA61YtiBVYlejVwWPQeNcq1JySsMuqM42b2ohCPstIVBuCZpTKw+ogV1Ym8HkljnrinLW7ffTKNwVuNnyLDmGLx57EVPst26RjHWWJR8J3k5RUx7qX9nFboxe0FOYsakWWRnOvMb3G1A7cQt1YtZfOhrqQDDM2uNmsSSC5JTcmM5p0H5Ux2IvoUXkwhtDTMUAPniNLTlgQnviv44Pn9nhMFA9H7DIuJtu5N/XFc83MHxjK8IXSFlGQjo0cw36yjl8nwU9HhSOorFtmpjlgqseINX6QCtnWuiBqy+TEgr6xRdGlExMzXMAYBWGVYj823zNQQEftp/iH2qwIy6FhHUAzt++d+dEvsKx+gEXTMTeo7fRHSc+qhAWBWi3CNysxFzf7GC70tpl4zlHTYaaGRP2PTeYEij7a2r6okiDBzdp11kGkJVcA7riJDKAg8/EdVMZ7ALsiXlWvzhcU66b9PdQBvjy6EtKK1wOl6u6XUQDxzXxUp91pHaxrf+RAs2vfZtTi1RrI7bgiWcvJf7ElQtQfeRF/PXihRM3RWgFxUwGgJ6UDTo6NKTXVtwRfEpmTqBcM3jIzAyeE6McvdRQDmp/M7DOfF1ObSOrHlmZIt1ivvL6ZUGjF71QGws3v4lG2jZZShuLMVyyWmY7iRkro/R/04rbkhJz+KItPpV+5/ffgpti+Ov6mE1kETVrLJOIpkd9xU9Fa6KxBIGzxDl0w0FqtthE4Wz2Ms5ZZqbDreYTjcZfDagJTvVaKleqzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199015)(558084003)(36756003)(316002)(38100700002)(8676002)(2906002)(53546011)(66556008)(66476007)(66946007)(186003)(31696002)(2616005)(86362001)(6486002)(478600001)(6666004)(6512007)(26005)(6506007)(5660300002)(41300700001)(31686004)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3h5SFJWZlJIS3FkZUhmSUc1anBPU3BRMFdqUHhEUVFsU1c2YmsxUXUzZ3NY?=
 =?utf-8?B?SklMUitraWRQcXdPeGR3MlMvaHFMVEhpUVJsSU85TzU2QzBDMGR4V3hsekdz?=
 =?utf-8?B?TU1lSDYyTmEzUFR4a1JKOThYeFVHQWdjYjNkVm9OQ2RCcUlkempZM3FiOURl?=
 =?utf-8?B?WUIwQTltcjZGeGY4TW1yVUdjTGR3Y0tJRFdNWkYxYjN1ZER6dzU4WTJ2Qm10?=
 =?utf-8?B?UitmaFNxVVZNT1RwVFpYNzhNYzRwNFB4SGFNYi9EbnVYSENWVzl0dTNicTJU?=
 =?utf-8?B?SWs3SWNrVTZyWU1wT29USjQ2STc5MVF4QU5EWlFGcG9mNUtLKzQ4QXplQTFX?=
 =?utf-8?B?ZFdiRWJKUWRIdzlOTDJ0UHNoYXRJWVduNWFQSjNmaTJiREVDOVQrQS9hejky?=
 =?utf-8?B?aGQrQ3EzMmhGaUoyUUNjdEROVmtPWlVGbW5KOXlUT0E0SE4xU0xIMHZCTSt6?=
 =?utf-8?B?SEN5ZSszbU1KbmJUclBVaWxOa3B1d0ZIZFZQUzR3dDFBZXZ4aEVJdG9SZFdR?=
 =?utf-8?B?encxa3c4VzBhK3ZweXVlak4xK0VONVgvN2psOFcyRWNQRXJ1ZTh1N1VxSlBl?=
 =?utf-8?B?N3BrTEpaYllTdnZqUU9GU0sweDJHQ1FxMjYxdmVSZUhjZTVLeHh4SWpjOUJZ?=
 =?utf-8?B?bk5RVjlHZUJJM2NXamNoajR0ZjNsdFU4Sjg0MTc1ZUxSWFp2WmY0MFRKQXhq?=
 =?utf-8?B?Qm9zb3gvV2VJSTRpREV1ZEZxcUR1OU1CeHArQWJOK0pDNnZhdGVpazRVTnQv?=
 =?utf-8?B?OFdKMHdvYVdFWmJ6ejRjb3JIbWpXZldFZkZNemlINnc4Z3FqQmJVa1h2emJY?=
 =?utf-8?B?dU1iSXdZVEgvLzc2ekJEZkhhRXk0aVU3aHNZR2xMM0JQZ3F0ODIrNVBuWWlS?=
 =?utf-8?B?aHhuK1FJdU81ejNQU3E3WU5wZzdNNk42dlRWY3hLOStqR2N3SnZtTy9YdDUx?=
 =?utf-8?B?NnFSbGZWZkI1eFduWGUvdkxWUzNSNGY2Nm1VbjdKcHQ3ZmRpVFRsanJ3QVNF?=
 =?utf-8?B?VzdjSTVma3NKNmlIaXpXZHJkOEFrOHAvdWZiZkd3Q0VUaXJaS2ZLNUZWZFBr?=
 =?utf-8?B?LzRSMXYrRlUrMnlpUER3cUZJdFI5MkJtcEFqdlNWcWhtRnFMVTZuOUp5MklE?=
 =?utf-8?B?dmZsemdjZkdQV3ZETzV4RVZxa0V6WVJYSnBFbDlMR1VrdWZxU0JFRnExeDIw?=
 =?utf-8?B?dWR1KzZIMGUzTXhpRWJjcXF4UkdOcGk5dHN1a0FMN2ZzcHBJMjhKVEZyNUJa?=
 =?utf-8?B?LzRWNlFrOEZlYlB4bFVLNnViVk1PV3V6ejBvNDN4KzU2cG5OWUpoSWdMc0RE?=
 =?utf-8?B?eHYxMENlampwYUtyT2hURWs3L0gxRHdHYmFnR1lVRFl2RnBWb2w3OHhTNHJZ?=
 =?utf-8?B?aEJEdUNYNDdqTmdIaEF3OVovTUF3eitvemNtT0pjeFhZY24rdmdpa3N2RXZL?=
 =?utf-8?B?VHNTNk43R0JlVG42aFpMdzZBODYvV09yZiswcnNxS204dng1cU0raXVTQ1NQ?=
 =?utf-8?B?TVhXbWdVV1BoeVhYV3ZzTlRPUXp5bnNUWVZNY0d2T296RGZMYXNrc005c1RQ?=
 =?utf-8?B?a3oxWWRLOGRtVnF5dmhyYjRNZzczQm12T0NnR0JmUXlpSWc1c1dLNGx3S3Jp?=
 =?utf-8?B?bFpXR0wzZ3RSWGxwTGhNanBmNVU0dVBuK25qbnBmSmorQmZVN1Mra2pDODFr?=
 =?utf-8?B?N3c3Y0FjMnUyNG5kQTBFbm1aMzhyaHVBVjA5SmVtQ0hYQWplWkFHUWo3NmVx?=
 =?utf-8?B?Sm1ZNFlwenB2cjdRRFpSNFZ4di9TZzdydm5nNnAyM0pld3l0SU5pZEJvNTIz?=
 =?utf-8?B?MnBBazI3SjNJbmhPd0tKdi84ZVRGQTk4bEczb3ZzNEMzSlJlYUZhUENpeUNM?=
 =?utf-8?B?ZzFGazh3WXFDK09rS1cvbzNRQ3BzWk1LYktvcEpDRUFDNXNDM1FuWDlBVlha?=
 =?utf-8?B?cUxqenh2KzBQRUlTWCtHTFZJd05VR20xRVdYWFhmQ2wwSFBYek0rTkxVUkpz?=
 =?utf-8?B?aVRGcjREMFpiOUFxYis2Sy9ldDQxOVVlQjFNTHZlL3I1bjIwSVhNM1ZDTnpW?=
 =?utf-8?B?YmxPcTNiMmpXMVVyK2JjdXpJcTF3U3ZIbmVnZ29JUzYxQ21PeGt0ZUtlQ2lr?=
 =?utf-8?Q?cVGkhAKWKqpFXJ45NCAcgISGL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b62b45-0e45-4400-716c-08da9a3a3a00
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 12:26:50.1827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+naHvJG5uvE1A6ZsEQhO+DvQDm2JA+CedFz47NYJ1yh6iyhAhQY1bihqurlIk7MMDCbaHTxFHIGfL6VynE+XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6283
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190083
X-Proofpoint-GUID: GC-o-ow92ANGLVGVZoxlwVJFMTbgL9MH
X-Proofpoint-ORIG-GUID: GC-o-ow92ANGLVGVZoxlwVJFMTbgL9MH
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/15/22 01:18, Josef Bacik wrote:
> These are fs wide definitions and helpers, move them out of ctree.h and
> into fs.h.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>



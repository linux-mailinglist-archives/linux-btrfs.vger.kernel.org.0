Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768F460DA2A
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 06:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiJZEIj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 00:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiJZEIh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 00:08:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8018296A07
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 21:08:36 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29Q1nYrv016729;
        Wed, 26 Oct 2022 04:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Y0rbz1QlRf902pkKZdPmsss4i7qNybVRY5/P/fThUaQ=;
 b=hitl0iJz0YJ3LVASzgI8c5AHB0vaIKR4/Pc3YXohANPqHKqWXwD497E8g/J6PyJoSnrn
 BXhP3mXMlC+MxjHjpKVyMm3d9Bo0Ygh4VSAUpqajA6WIIVgAms43Xbeuh6McR1HM9SX0
 bfu7P6igZHkcSv3KaxcZe6oVthRJ1p4qfRYH18uaNot5FLJvwlZnYUXDpb+gL/7pi9v3
 XlWnIqfXKATXJMlemkYTBSMwhzEedd2V7FAK22ySl/AaQ9WjXgKlyZ0LvN1xlNtNqzZ6
 9EtzLDaCWQrNyIRffeJiB6iQaGyn3ALJUHb+wphLHFpHpYUcUkhp7fp9FVakjfMsZQwn Xg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc6xe4ms8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 04:08:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29Q30tWa017493;
        Wed, 26 Oct 2022 04:08:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y5hrqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 04:08:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+TSwDi3e3AKStK8UCEzWGw3WLTQjLsP31Gme32oiYZ/ER2o9mqCFc9PSKHEgN/WTHxxrUR4MwjyALgkRrY3Vaq9eTE1kZtli+yAhbk+kl6bKMzDthiHiB9zgoI7PN/lJsU1WuzT89utT3Xd9/nNbEfo1LprFLA4f4kVtWy7bpPQWuKke0a89LtXMgw2RBPtmyrHumz+XHIJTUiIvQ6MQB+VAmbAOJakvTcnZcuYfM1MARZGv/66iEfhF8D/pSR6NzY+1NzWZ3AdeN3cJWqWtQWfX3pUVVn6SaDoVveHIq67P2OL4ocRuHE4/p+TQsNRo/vL+MCuzgAmkwBihfsOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0rbz1QlRf902pkKZdPmsss4i7qNybVRY5/P/fThUaQ=;
 b=VOkwbaGPDcwAPBaoB8mYzKk41lBr0e2dT28x+U/lsHS+uWJvpdCPPQDyMXZcTMK20W9Msi7rPYZIKTozamPJhAyPDBZEUGYwWvoo78RVdfcy8bVouauT0+59ciB3BnuEthYjNWaKCL934mg/qpXbSz6vMKfWcqBTubtZ+Beof3C2n8qQyo3DkXgsFaAjHIQ4QcXLbe6iFUmPh/9uoNqc1ULstpfnuNR5pO8KiCPFvHVowGhCwBsP5SaEsnq1/72q3nEHdNW1njQRaH4KCunXGvIqkB9io9cOMR5pku7tl04tWXDlPs0U3O8IiuY6B6TlJ5mBVpnamlyEMKQzh9C+Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0rbz1QlRf902pkKZdPmsss4i7qNybVRY5/P/fThUaQ=;
 b=TW0hyxeCkn2kM97tEONVXIu/9BRRI6SmPBicWYYjn4g8YtwbIkyxhYMj4P8D4oB1xnbnoLOJZHtugPsl5MKEdbuTkRSheKKGYOS6BvoT+/NQflSswzxpol/VFsAipk09yQ6F21JhsGLj3AoXuEqMoabKWrupBgB028UzCpaS/9U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5024.namprd10.prod.outlook.com (2603:10b6:5:3a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 04:08:29 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8de9:6a9:997e:d271]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8de9:6a9:997e:d271%5]) with mapi id 15.20.5746.021; Wed, 26 Oct 2022
 04:08:29 +0000
Message-ID: <cd51f83a-6357-f1b0-c008-568c2d5600d5@oracle.com>
Date:   Wed, 26 Oct 2022 12:08:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] btrfs: remove unused btrfs_cond_migrate_bytes
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <f108ebbe38bbcec67c8551f35c68dc38d342addf.1666710777.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <f108ebbe38bbcec67c8551f35c68dc38d342addf.1666710777.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0181.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5024:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d25ef0-c561-4b39-3b43-08dab707bd09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJhpflpPcVfSZ8tZkvKsBpJUx4L/SidSkauGbs05/nvpttf98EccPqUQUm5UwkdjMWOJ/mJFRSftHDFjQPPOI9aG0RD7NIZ5IWu1tklkj+sgPG1uqme+jRN91SPyseHr0QKW5ZluxptJw4IzAFNLMfNysIMP7tRa1lzPdBVU/HJkxVf50M/UtH0fMGslpRN8l0V1VpZBOYS04R86VyZahopUx8sIsEna70Vq9IIVqEHBPG9PAjL7syUPbVT14m5e/TIHucU3bG1mOp4hhIAJf31Wuw6p5JqsmXqMjj/BD+/BbSSW2rCTGp0d7lDTc2T02X5sNMfyQZplcH6eFJh0BBc50mDoco5nHueCufB3vRpbpXHMUCZH7QqeK3XhL2chh06MGtWP29Vl0s3Tr2u8ppM+AZuYb2+quEY7n0qKb+lM3Xy/dWHuWrECdRhaB7jmGtyVnIKehcZpZ5MCK3xrNliQw9jw/PP2Ik2S5we/h3xHqYgA1X7w8ttWAw86kqpOcF1LQPoZxuyRYngs9blXViOVgkv0tjIEULElrwHhLcWakaruKarXmmmNugC94OSobk1Vl/SWO2ZRreRnI8QsB5G6HMHj3T2nSUsoKji9kXnbDr7SGV0QB7V9K2qnhMKoJDXG14qpGlRLhaCXdTg0e+wNWZCtTLxHrvqmpaCDJwpNN1BwnNSvKMMsPyVVI+2ZGvUZfNhZTkQFZO2kfOswjSQFUxsUONWuuPQQojP2H4x7l26IA+Ye55/LIblFr6KXcbXGiCzOX46Q4cTFqu+DkkWZSlcsn5XjFxBAtaeBoAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199015)(2616005)(2906002)(186003)(44832011)(316002)(5660300002)(53546011)(41300700001)(8936002)(26005)(558084003)(66946007)(6666004)(66476007)(6506007)(66556008)(36756003)(8676002)(6512007)(38100700002)(31696002)(86362001)(478600001)(31686004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0tvU2hTd0FoRmVpYkV1UTdrK2F2QXBYSkVoT0M0KzZsUTJtbkc2UVAvRnVE?=
 =?utf-8?B?R0FTa1BNZXN4ekxObW9CK05CK24zNUZyY2hSL29nSjdhMjZWbkRlQ1plbWto?=
 =?utf-8?B?NjUvNnJBN295MU9jTzRIOWxsbmNpT1dCcndYaE14ODJ2SUFHdktPYjN1RU1Q?=
 =?utf-8?B?WDFyZGgrbmtCWUM0Vjd2ZTBTbjNpVWNFSE13ZzNlRTcyVFBSL28rV2Y0a0t1?=
 =?utf-8?B?c2pmaEZYK3lnNzc5N0Q5RlV5dmJ5STlYejZiRklKQUp2bjdiU0ZEeDdPb1h2?=
 =?utf-8?B?REcyNW0zMi90TzBEd2RsNHZOR1c4MGVxMVE1USswM1E3U3k5WnZDb1ZBNjV6?=
 =?utf-8?B?QkNzNVQ3bERHaUJLYXdjNlR3Rk5LZmtMcjdJeWxGRjVXMGxpYlhoOFdXb2oz?=
 =?utf-8?B?VXRJU1NtZnN5ZjVqVXFEOVlnanRLdHRkVHk1bDI0MGNkL2NmaWx3NzY1OGVF?=
 =?utf-8?B?UnlBKzRNRE1qL09Bb2JGT0FxeVFXaS9Lc0M2bkxoMzltdE9tYUVaZGswSUli?=
 =?utf-8?B?bkZURVl3UnZSSytlYWUvc0pEWmpzTjdJclB1RVZOR2FSenM3REpDcXc5N1lr?=
 =?utf-8?B?ODZBY1JOeXBhOWljRHJMQkRhanJmOVhncjBrRDNnT200Y01TMlFtOTFCVWUy?=
 =?utf-8?B?c3VHRlVRSytENERpZnpPQStua1Z3d0Q4bW1QR283UEJXUTMvUGl5RkR1ZUEy?=
 =?utf-8?B?L3lkMTY5QzFwcUtFWG1KRyt4YTlOTlJ6VEduTWVnNWIzeE8xZDM4dU5RcFlm?=
 =?utf-8?B?cjZrc1RSL3dBN0w5R2hid2YxR2xrTk9VajNJa1RxRUkxc3k5bEFCNXpNM3FC?=
 =?utf-8?B?MDZKYXhHM2ljRDVCQ0ZmRkZ5WXZtTUJYRjlVNzhvYktrYmxVYmJ4NlVuemZ1?=
 =?utf-8?B?TnAzY1RXUDZQT04ybTdoTGtHNHhMNHBDdURmcUdadnZ2aWoxL0c2V0RWK3dW?=
 =?utf-8?B?T3NJcDR5VUk4Z3BDSmp5OEl0WFRtZ0ZtdGpJV0hGWHBiYjBzTEROYlZ4NGNO?=
 =?utf-8?B?SnJmRlV3Uk9ERUtlWTJFL3ZYMnhMUjN5UGpkU0dwaENSL05nVDBtUGpKbG14?=
 =?utf-8?B?dG9vMFp6UVVrTktNeDhRRERJYWZUTzhiK1lxeFFhdDQySXR4WS90Slg3Ynpp?=
 =?utf-8?B?aHkxTFR2TDE1MUNQclpCUk9qRTBwU0kybUNoZWhRTlZYV3JUSGs4SkVOeElX?=
 =?utf-8?B?eUR0eFZ3bzZCdlYzMzU0aUJvRkVFQkVsdUJCYWFkbHoxRTE3VFB4cy9tdWRt?=
 =?utf-8?B?RXZ0ZFRsL3JYNUZhZmR2bXFQMk90dXlMZzEwS0RiblhxcTEzL3cybk5tUkd5?=
 =?utf-8?B?am4wbnBYMnVqYTFUQWtyeDdqSkluUGNWU1htR3kzN2oxYjg2M3dMbVd5RXBB?=
 =?utf-8?B?MjBsRWU3NEx1VU9keVY2SVM3SDkxdTdveGdrWjY0WllFRXNsK0hkZlJML2pZ?=
 =?utf-8?B?UWZEU1VNZlF4ZDN0NG5McFNSSEI4TzBrc3Vmc3VHRE9XNm1oOFhLYzFaNWxp?=
 =?utf-8?B?alZpb0tINm5WZmQ1UW5IcThoUUlIUGs5ZGk2VG9ET0lSeXlrUUVmUkY5RExz?=
 =?utf-8?B?WGxWMFVMbGExems5RWNvMkVHVUc5U2Qrc0NTZVVDK2FSWTMySTZQUldoZ2dk?=
 =?utf-8?B?V3dvSFR0YjJ0SkRIUUZBR0hYZ3p6a2UwNjBxRENxd1E3bFJWQmwrYW00TTQv?=
 =?utf-8?B?VGZKTUZqY2xjRHovSVllbXM3Ykg2VWt6bU9BMGpkb2RvcVlVdUdIaHlEbkNa?=
 =?utf-8?B?ZmJ4WG4ybWdyMldUUW5MUm5GWDc5Q3lLYm5RUTN5Z2Y2NnVJZTRTa3diQUFu?=
 =?utf-8?B?S2JOcGwvdHN3clhQVEFacUdvT0dZdktGdUVZNUQ4V3dmaG81Q2UxcUZMU3BS?=
 =?utf-8?B?Uk9IenlHM2dZMXpRVGQ4WWYyZUlLbG9kYTluc3pHdFdJMUlTaWIvV2ZVSWkr?=
 =?utf-8?B?TmNGS2lObFhmYS9qbmdTKzVYUVpJZVBGcHZWZitmZFV5ZWl6SUxGMWp4QklT?=
 =?utf-8?B?Ykx2WVU4SGZET2dhRmRxcmZIUnZDQnkxRmJjTU9BbmxPeFNRcnZUSWYzYkR5?=
 =?utf-8?B?MFlRQ2VoNDQrUmd1R3Z5c2lFMVpoZFRxNnFSNGgvYVhwd2NFdStORUtRVmRn?=
 =?utf-8?Q?dhwiURU5k0/uER9+GYb5NHiyj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d25ef0-c561-4b39-3b43-08dab707bd09
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 04:08:29.5185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pf/bYBgJSbGcNfdGGOmr15HVTAOSgwxM0ODupPHBTOOlsfC5h2pJXiKL+S1iLYCm/bKKztoK5+L0W9td140PaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5024
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_01,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210260021
X-Proofpoint-GUID: mo5O72gHf5x6wmYoK18J1Ze4Tm2o6v52
X-Proofpoint-ORIG-GUID: mo5O72gHf5x6wmYoK18J1Ze4Tm2o6v52
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/10/2022 23:13, Josef Bacik wrote:
> The last user of this was removed in 7f9fe6144076 ("btrfs: improve
> global reserve stealing logic"), drop this code as it's no longer called
> by anybody.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


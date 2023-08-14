Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3D977B767
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 13:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjHNLQ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 07:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbjHNLQs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 07:16:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B81E5B
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 04:16:47 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E7DlP8028394;
        Mon, 14 Aug 2023 11:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=R/K+xO/xi8GoZcY//u8qtYwJnFyfOaWYI7ATjRHGz3g=;
 b=hRJVIhRXIcUMZJjWldc9RlanT9oi0peEQzk/b+zf8YW4dUHYFhEQbWm64ep5NOwWKUZ4
 gTYeZLf4qOHH+k2imqsbiV//nfo4oaVFinbGRT+NVacaFxdncw42d6e2ZvlQslmaIh34
 JnshKRZlPdcoQq95Eff7B4varyzaH0+6KA8wef1dXHIGfx0JLduOlO31I6b0FpP0ZfRe
 45Srz02KzyR0w8+gtndX6q8Aynb5uziwZ/o9kVaXpzkK4VRket15CmelvrS2hEqcWQU4
 hH8t7TuNjGq0S2Mfrxr81wOdRcu4pgLbCYZoZV0gdNDlmNTSNSg3Xqs2j/HuCNKGGwwN 2A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2y2td6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 11:16:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37E90fll006624;
        Mon, 14 Aug 2023 11:16:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2brrn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 11:16:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8fhTRbw2e7lQzNkTHqFh/DnVYvuUVAsybljtXXoNL5GZr7+NNUgtgIsd7RKELzQhX5u1gE8YNTp922kkoLAhKnJtldmjQbG69D4g9o5jPnobzZHYF+43Qq9KtectHTTFarQ7JyHADjemo9u1T1uSress6WMUVPZIm0l94snTbZttGam/8jsugQF4ZbCwMprLAXw/SQ4Vtf1K+p1mzpY0RMz6SVeBbpXe3PfiJccPMDzBq9ck63DSX8twJPdsxXFDjCmWZvljJ2YGlAL5s4dyIcnVbNH/+3X0YjOlyMyweOjQ9C1aXCFklXXL+CMUtRVh3rH7Rck0s5qSRZLIntC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/K+xO/xi8GoZcY//u8qtYwJnFyfOaWYI7ATjRHGz3g=;
 b=gE5fWOyM26vYAueBgU5XfZ6C4DCMhLwjZn/Hl75jg7zti4RxZbV0ReTYC72dU2ySIUSv8sjb4Ap1DXZ57MtKNE/bjtzruEeELWDIDz3PBQwNvjaBTgNoG8hOXHg8QkFdFPsU5Dxo4XA5A96/460BBMTMwrYIdhSbcOYfociqYU0efN/ikLccZvxCi2V68xYFYfogtwEv9Lw+UdC6++FXGiQbHEcUenHMHE/myUags9b58lE9MOYlwPZjWieb47irhQq3VViUGBrIMWoNc+t9xD/exIOoZPYzbdopIWSvbTK7iEbB/FbfW9jQ7JWnpAeniyPAA9vTwKc56UIlEizluw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/K+xO/xi8GoZcY//u8qtYwJnFyfOaWYI7ATjRHGz3g=;
 b=xRV4UR8t8sWb0TuufnNymv8YTtkzeTiFpu40oWP0C6It55JZbHWcZNmEr49LI8RwvzkxhBPdQtP2azWQgJJr8i1my01llnROycYozrJfb5H6F6WJB4BeeltkuPeD0n5c8+CjOpXyww2eYvBW09qW96ZuXfgeo06qze21YRUvGtM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5051.namprd10.prod.outlook.com (2603:10b6:610:c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 11:16:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 11:16:41 +0000
Message-ID: <f0d3827b-f817-075a-24d7-82755156d114@oracle.com>
Date:   Mon, 14 Aug 2023 19:16:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 07/10] btrfs-progs: track num_devices per fs_devices
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1690985783.git.anand.jain@oracle.com>
 <bef7d89c5e6564fcd621787a647fedfe72f94c0b.1690985783.git.anand.jain@oracle.com>
 <20230811174152.GX2420@twin.jikos.cz>
Content-Language: en-US
In-Reply-To: <20230811174152.GX2420@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: f477bfdb-b72e-4f1f-a031-08db9cb7ef6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /TGA3eRhOuhpK3O/2jPMc0y9yvLhN3VMVqotrKntWP/yXQ+7oqpOragqzb+pM0DpYmD0pg8wgQHOlSsxJKT9hnlnqyrf3U51FUuy1Tf+Am0oNA1cUGM++gqxQTR1nj3AhQ62KaAwTafwd0OXS6XuOcNPn8dhZas0NuwrD14uJK0f9Nfvrvg0dWALWBLCgI8pR25RiTPNZeQ+oLqfgxINQj7RaZCXpp1dhMdtoct3IvhFyMYABbHi3fu0JCZidEiISx7WYnMiby3dbXavvDn7upc6b8H3GRQZ+0zfx7gRHLY5c52uXJXF8I5ACilIpl3R3xqrgfifCvY3lXt4xQkUa3vi6QLHzppssa3nCb6MKx9fgdR6j7Kgt02MWwbR3yAM242Ni2clRsV2cLH0OOdc5PuBYxCjEnhqtiVUE9/Rec/gQ9bDw9OdcArrMpvHEo5cDBRAANFzpx3vwOkjWUbMUnqRiD4yt0SNzE6dE0tNtaB0Qy599cP/23tjTVlwGy/HEdrNMJzc/TUIKoWbDzrY5wxNuI/N6Zv524sH94lN0ALniRx8x8Nz4IT8tVu4aUubi6KFRm4ql1/myAGUYBqyOtvqlmorpGx2sqvnoBBJ2D7l1ETNkrTvAzQpSBfxdQ/ylehde8DGfRVTLmbBW+QtZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(1800799006)(186006)(38100700002)(6486002)(6666004)(478600001)(5660300002)(2906002)(36756003)(4744005)(86362001)(31696002)(44832011)(6916009)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(53546011)(6506007)(26005)(83380400001)(2616005)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1pkWmVwd0RZbkZRelFDbmI1Nm5MeDZTODFMdzdSczF2TXpINkRDbC9GSnBM?=
 =?utf-8?B?QmxiSDd3bWRrOHlMblpFWmtIWXEwdkduS3lGVWo5K256RGYwaFdvTFlvR3RT?=
 =?utf-8?B?eXhpV1NzSWduMDk3V3R0dDRrZnIrWTZmL04vMzFEdm1yQ1ZGeEkycW4yakla?=
 =?utf-8?B?UVVDclZhb0g3NDd5d3RISXRmcFJIWUtIWUcvNlV6T1hUMXNtcFB1SzgxM2xM?=
 =?utf-8?B?NmxMYVNDUlgxNjVSRHBGY000NVVZcFJlUVdPbFNaV0hhQ3R6QUFha2ozNGhB?=
 =?utf-8?B?aWNZRmtZVXZ4b1dWOHdteCsrdzFEbVFYUStpN1VNU3ZhNDlyQW9lUmN2SmQ5?=
 =?utf-8?B?WmhHaHVSWGRsRXFQWFZsTTNjT2tFUUxaWWFQVUl0RFlkZ2VCMzlaR0VlcGpx?=
 =?utf-8?B?eU93TnJXanc4RG53WHh6ZlJ2aTVIMldwV2hKQlFMVHlFdXVKemhLM2p5bHJ6?=
 =?utf-8?B?d0V5QWlRNGUzelRFalJVRk9mRE1tM3YyZkxZUHJGR0IrVEVzK2hGTjh1OUhH?=
 =?utf-8?B?UXhtN0xjcXROUDd0V0x5UENSODhtZlpoNEc4Nm55Y2ZQU21LWVJiVDgxVDlJ?=
 =?utf-8?B?dk1pcDZnczVNSWZDeWo5NlN3RzhqTWJhcU1lMkVYSFZyelIvRnRZLzB0Y1R6?=
 =?utf-8?B?MUxkUDAwL1RCdGFadWw5SXNIdkpQWTE1ZkRGVG91OE5Qbyt2RmhYWnlHMHVl?=
 =?utf-8?B?Sjc0MUdkaUw0RDVqRUJGTDFHaFVxQWJUVHI0TzF2TGR6akpnazhaNHN6a3JJ?=
 =?utf-8?B?cW5oUFl5MVZTcGFHRUVMTGw0ajJJSWlKVVhacmFYV3oxYTh4c1cvUjdHQkVa?=
 =?utf-8?B?c2VCd1dUcU5xcExvRDQrK2JtTEY1WHFIdjlSNVJLUkxtVFRMSys4YkdHSTNJ?=
 =?utf-8?B?V3ZFaHBkNjhTc2RMZC9rMG1wQlRsWHRvUmptOUNLQWFWNkpRYXloZ0NOdlUz?=
 =?utf-8?B?REcxTk1IUFl2bk5FeGJFOVJnWTNuNUthTEJlcjZBcFpraHVRd3dnN3BLT3ZU?=
 =?utf-8?B?djhGdm5pKzVieFhIdlFWMTR6NjZHZTNqVVpBdTBudWdqWEgzMjJWTVI3Y3Uy?=
 =?utf-8?B?Q0lHWkQ0bWVVMEpLVEdvSCtUVXV6K25ROWNsZmd4bzJsOXIvbXExSGdhUkhD?=
 =?utf-8?B?U0JudWRrQ0hCQ3dsVjQ0UWZMd2RZRzU3RnFZalZYMHhNcWpoeG9kYnRVbXkv?=
 =?utf-8?B?MzZWdlFUZktrQ2xEZkdnY3MwSndjNGpBTWF5RUpNT2FHVnBpek5GSStxVDZn?=
 =?utf-8?B?aU1GRDBMa3ZOTGtIbUFFZzJHVDJDWE92Yi9ZMTQwam5iejlhWUJCMjV6VUEx?=
 =?utf-8?B?K200YzBUc3NzcU9xeS9NQ1NUSmM4Zi91QldnQTR5anlFUUk4bDVBSDgvOEw1?=
 =?utf-8?B?SjhsQ1hFRzVlT0thQVB6UGhaM0hNbVA0Mno0VUdXbC9qNWtsS0pMWWJ5b2xI?=
 =?utf-8?B?Mzc1eHVJdHJjVlhETUg1MjQwUHNjWmtJWTJFSnREYW9vSHk2MHNQNFRZcXpx?=
 =?utf-8?B?WHhKcEFrNldlVnZmSDF5c0JMcVUyVEo0SEFBUUNrVDhkaWVKeFVsZGpjNmd3?=
 =?utf-8?B?MzQrS3g1aWtqRXJaZ3FzMFRQZGRVSlorRGNSeUhELzUzMjFGalNGaS9VVkVZ?=
 =?utf-8?B?OXkyMFg5eVBxUmlnN0l4YkdnbVFvbXU1MzE4c2hYQXJwY2ZHRGdOcWJLTGZR?=
 =?utf-8?B?bExUZjZDUk9XbzJ6UWRhbHpGcWlyT1IzcURneVNDdUlNUVRuSWpXVHNXbVdo?=
 =?utf-8?B?VFU0SnB1SGNMN08vVnlzU1N1MEs0UnFTL0N5U3pKcFVuOWw0YmhkcEtEMW82?=
 =?utf-8?B?Tnl1NS9PVU1UaStkUjlzWXVTRjJua1JXYmNIdGtWb0VOelg2bUFrbDdVamM4?=
 =?utf-8?B?V3NWalRrMGRMQy96bm0wZStmYkhkZ2JOSEx4eVhaZzhlZWxYTTJNcW1FV2Qy?=
 =?utf-8?B?VjFJTXpPdnVxQU54cGpRYzRiSVZHSVNxeUMyVHp1REV2MXF6cGoza0l4NjNF?=
 =?utf-8?B?TTVTV05mbUQ2MlBaZUovaHNOZnBLbCtLL0VOb1ZpUEIwRHcwVHY2WW95K3dW?=
 =?utf-8?B?aHp6eUJCcUhsd2R0WnNTZkRvWTltVmNOdnVseCswQzUrb3BRK1N1c1hpdnpt?=
 =?utf-8?B?eDNmNkxjcHpzMnJEUmZLTU5za1I0ejQvY3ZTeWloa2F1L3REbEZWd253bEU1?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /vMwnFbBEpWz6FfET/7CdvcMS0HWIrML2XtMKs2MmfV0EFMN6/gr+8RQdNaYPJfImG9vbUN9j4k3OA/Sdm1JkiHAyr+9C2l8nsWQLf442fxJOzWLiJtIYODlXGbVTrrJx/OmB41UXw1iT38mdainlGc0KGfHUlBcC6n/ipmNkrvdSy0Ajd/fuS7aWMmMxpU/usknl9hZzHMzGY3CFVQZOwR6ZhdkJlLLHfP6KG13FhBCRL5/k613/py0imCXrivXqvfklMlD23lK8kaOjPdrN0PXVHQvCRYlq4wTBWvCiILP9bHT0OmXz0sDAdUp7mghO1DGlA7kAxuHp24XE0lmPPeaDAionHJ0tjPCmG9g1ZUyGebN+sRjgsU4T0qGWA+Iixqa5zDbZJvJge6FrmE3/b8OFVz9NqwIHwr0ORmOoJHsnvlASCjByDG+8cCEykhs8zmOMHZdPr5XjFI5qsbwfIzkv12qfGAzR9tas80ZVzNhjYCRed2HUXCkR+okvb6T57gwtS0jtntDFnWSLv/ea3KS3Y5K0YDsXiCgD3dZRKYHbblC2l0SQB7J9zaBKS8mDKeLfDXY2zyA31MkzOw+sh9a3h4VrtOnPi1hpfw0KiWjk6zdi8kvN2jtAGr46DxV/Hme3UwBizf9KaBoPmweEZeRxSUBiwZabFVcOPkUTULfXAnjO4ocCnUuF+mizgh3ZuuHSSSZUhGmt7e/+l3P+lFqLsX0fZRF3sam3uJ+egwhAvNfJW5nv7Lbv/8vGB5ysmZeBa6IdFp6hB8rQ1CR73+X39loWECfB1COJ9pu00s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f477bfdb-b72e-4f1f-a031-08db9cb7ef6f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 11:16:41.6569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S46DHQD8ohgLoyEE70T0TdFwu3u+EdL9VaqIglNLRWVOaEkm2DoYMpa1FcUmNiHHMaBx7mxUhezr4Zf9AFau9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5051
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_06,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140103
X-Proofpoint-ORIG-GUID: ZgzHUQO2KQRHJngVmpbsjaCOC6xfk2fK
X-Proofpoint-GUID: ZgzHUQO2KQRHJngVmpbsjaCOC6xfk2fK
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12/8/23 01:41, David Sterba wrote:
> On Thu, Aug 03, 2023 at 07:29:43AM +0800, Anand Jain wrote:
>> Similar to the kernel we need to track the number of devices scanned
>> per fs_devices. A preparation patch to fix incomplete fsid changing.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Patch looks ok and makes sense but it crashes on segfault with test 001
> in misc-tests. I haven't analyzed what exactly it is but given that
> there's only one pointer dereference it must be it. Reverting the patch
> makes it work (with the whole series applied), so I'll drop it for now
> so you can have a look.


Run the command: $ make clean-all to fix it.

It appears that the struct btrfs_fs_devices is used somewhere
statically?, and it gets updated only with a clean compile.

Since this has not been integrated yet, would it be better for
me to include it in the upcoming btrfs-progs patchset?

Thanks, Anand

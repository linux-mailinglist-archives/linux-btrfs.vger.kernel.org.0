Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C276F0F5E
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 02:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344368AbjD1ADQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 20:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD1ADP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 20:03:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6F22704
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 17:03:14 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RKPCaF031852;
        Fri, 28 Apr 2023 00:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=39qRLgp3lm6xH9HjIoWS862vC7xUY2ORQ1wJherQdTc=;
 b=NA0+38KvsSht9w5rgUmgZIx1IQX6+gwrP3WSDye/FQRmPomJpwoVGrzrTq8c/GrGDfiE
 lm/k+pEjOIFLEB9MfgyYkFqlH7Oxmv9duYMx1calECYgw36ThgIHuxY1trDXH4CEa20U
 qW6yW1i+EjaPEw8Vo/AHAxs7RehteQMbuFQTQBud/clmL1SGZ9TOSWtuJci0mZK/qrzd
 AOcmn8yUZcNfmwD4NYJPseGDa7OP/JXJ68JgqDdM9bUt8lJWQclTViunuKBlbJeEpbHC
 CMSrnNjgKMnHcPR7jk5wx5Bku1WSzymJIMCQ0IqnPzUG1aOuyPnGOAQfjq8R0EhvcDDs mQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q476u53ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 00:03:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33RLh0af006753;
        Fri, 28 Apr 2023 00:03:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461a33ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 00:03:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKD7HAF7jkx1eFt37dsEGBetGDXKBzFvqBbYI+djao3xFEd1I3dBaOqWOF7L5ikTLY2tZKb0+BACvmeVjZrnWx23ISap7pw3pF0lzCRR0PZCCZmjRworfgmidFzLRPZW5CcnRLDRkS+zeoIJ6N1MB2Kn8LGoPueKSOgmtv/9q53T8oqcN8iGTAlo8UaAoMr16tTQ2aNvaGFSz3+vdifFgvainv0wDnpFTjPsjQvqA+vJEggXpHQ/8lcwu1H4CIe9WHAZBio187x2xU3iDq+46TQuh7Ws2tDelV+dSeo3xHtRg9DD3q1nPAaYj1YzP8UEiXdieGETzn9yPeKjRSAhCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39qRLgp3lm6xH9HjIoWS862vC7xUY2ORQ1wJherQdTc=;
 b=oM09UE7k1xva1M6qeZ0yTZbLOhwBiva09oiAYUga1eaQdAo2NfQTja+3Rhe4KMAezgyDO9YqQxSw30xiM927oXDPd4G0sDApAhKcBAkCKI7X5ePrav4ChJke/CrydU06kSbtf68ZP4nUfO8zLh2o4jSYyvJghhQM3ENOZz+Gy1GlT3mplFDBurhlFIMTOp0L8r50xawkA4ZHlpJmc0srobThXE89N1f4Zb8RjQa7foR8Cp4l6kxcPvG0QDTSBG462OjRw3uRoyuc0uDGNgeUtMboLvPpfmuuxaDUl6g7/cgho5tsQkTv/HO/dg1rD/j0/1ZktR+zoSS/qihqp2xYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39qRLgp3lm6xH9HjIoWS862vC7xUY2ORQ1wJherQdTc=;
 b=zNLL2GBRiB6+P8euH7u68mv7zaWMWw/kRrdpMglGIEu2oeEISp3t5ZBIhbxwMpKmZ6z/55xTv7/zUEVUH0gIFBslyrWmneTiUmewAHhJ1dD0u4nPnsOXpICLhBzY/30dx01bRYNISTzknQuZ2kLmr9UEqcaCWfvdiemcQ4fhduU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6147.namprd10.prod.outlook.com (2603:10b6:208:3a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Fri, 28 Apr
 2023 00:03:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6340.021; Fri, 28 Apr 2023
 00:03:06 +0000
Message-ID: <8dee05c7-ae18-49cb-b855-c79364c953fc@oracle.com>
Date:   Fri, 28 Apr 2023 07:51:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/2] btrfs: fix extent state leaks after device replace
Content-Language: en-US
To:     dsterba@suse.cz, fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1682528751.git.fdmanana@suse.com>
 <20230427225223.GG19619@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230427225223.GG19619@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: edf42a66-76d8-4e36-8f38-08db477bf165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T3q5jWDmkf2tMUQMvvLXlRkmBx1N9Bbg75ylWXhPv0KsScbiht4xFvSp8HBuY4NN1JGBh+oroeBs+1k51RYKltyQspti3fg7BqiB/8PZIC8rx/dPN7sZdrWqSyTEaP143tV+STiQrHpDu6do6PYndnmp5N7lJEQ+bzYpKmHxSa3+ySLq8BuS4WFJC/2omK8qVdHFEmT5p2K8HvNOXEC4XcPABuePtRzv48VNakytpquv11k7z0gxYxN7HLi9IgotXIpVBeRbikozfAepM9tQVPSOg/8nUtzwLSe3KoJyxkfjPbsazpZ02fe41H1KDJzaOX2rGw6eo36KQx9qV8HfHC5m783Zxi0+hyQEI7gtzi2K4C9oqysM1Ye55AL7zxCtd7KI9gz+IVG7i7lUwkLUBTp91iGNKZeNqv9mTip2Ljs8YviJU24B46lDuESVBlwDctrM++s3walzJ5qXCOqpS+zdbCXkOZ51FH22hnsjvHRB+T99+dYASmVbVLwBzxUOmXKuZyteVObDXMV5ucUr8yGi3dSHLuRMIKHvCtiNKo5wfKJ3deJDVT0QkETLzQ6D5047ntwob3j7ARBUKkwVvhVUmJlbH5j4BJ8iyh8Xj3yKzoK79nuHwlVKCs6ck/4XFoHZG66oF2Qxjb+ZrmdqoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(44832011)(4326008)(66556008)(66476007)(66946007)(31686004)(5660300002)(316002)(41300700001)(2906002)(8676002)(4744005)(8936002)(86362001)(31696002)(478600001)(38100700002)(6486002)(6666004)(2616005)(6512007)(36756003)(26005)(53546011)(6506007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTU3K21QR2RhblRKWVJ6bnk4YXJEenl1T1JYenJ0MWpQeWQzQXcxbXhKWTQw?=
 =?utf-8?B?QkxyKy9GT0p0bVlMQ2E0ZGVOYlVzTmphdWlTbllVV2hhdGtLZHM1VlJpR056?=
 =?utf-8?B?N0xhTTBRMFRhMEVXa0dLazdDaDN3cnFxNXFwbldPK3lCdlNQc2lCd1V0MTY2?=
 =?utf-8?B?L0lyQXJyelRhbmdhZFN4Z2RIWS9lUVZTK2NHbzFRdTEwYUc5a3k0b3oyVjBM?=
 =?utf-8?B?VmJ6M0VUeS90ZzVhMEYwMXhwS0YxQ3NReDFwRGliakVHR28vL01BT3IzaXpy?=
 =?utf-8?B?SDh6Q2VaeXJuanR2cEpMR2U2dkc1UWU0OTNzVHpVTzNiWmJONzF5YmNJaXFT?=
 =?utf-8?B?Ni9JOHlxREdLQkY0S0Z1M1ltOXpOV1JFaGNuOEdxNy8rWC94SW52WEl4ZTRm?=
 =?utf-8?B?WDdBVjlrZmMrQXQrdHZxNDgxWVB5WWZYZENDZlk2R2xrc2NCOGVpdisvUkpO?=
 =?utf-8?B?S2xudVRvMEZPS2ZjdUh4TXhyZjA5dVh1aFMvOVYveDRsWkczNFdzVnhFQkRD?=
 =?utf-8?B?Zm03U3RuL1FlU3RjdU9zRlR5VHlSL0k3SlBDR3Bidk5LUS9VQ3ZzRUd2ZzVJ?=
 =?utf-8?B?Q0c5bktTb2orSUdWVVRzZzJvemRRVnpMUUZzRForK3BYcnNBVTY1R1pCdXZO?=
 =?utf-8?B?UkNqZVZjc2UxenRwdTNyRVYzTS9HZUtQOTZDbDliaVJBRFRrOFExZksraUhy?=
 =?utf-8?B?QWVJeHE0d2JVZTNmRGdNSmZDOU9CSmVUcE5xTE50aEVLbkttWlBBbnk4QVNM?=
 =?utf-8?B?SlExRTB0UVo0TEVZNXFZSVE2UWh4aCtzYXlKQUJ3QnFieGhoejNYTDRDOHk3?=
 =?utf-8?B?N3grSDR4a2R2SzRCUkE0V0l0QndMSFpSbnhQQ2ZtbmtjMHBNQXp1ZGRXVFdR?=
 =?utf-8?B?VCtCNDdTUVhXYXNnMlQvRXQ3OUNseVFzZXhWcGxMSTlYVXRQZE85ZVdtNmNH?=
 =?utf-8?B?UFVXUDd1ZG5FMktObmk5TVI2UEM1UGNxY00vV1NGWGdxNW03eEsrU3UrZHg4?=
 =?utf-8?B?bStudUxSMm5yMEs2L0JOZ2crdW9Jb3ZiSlRsQ2ZMMGY1bGcvYlROTGo2OTNK?=
 =?utf-8?B?clR4RTJlYnZwU0pCcCtQMUlpa2lrWis1dElZQUtFM3hvckgyenpoazArajBN?=
 =?utf-8?B?aG56bEdPaSsrQ3VUZ2pZV0NSWU4yNVN0SUl6UFdLMnBRNDhtcXRTS2NBdDhE?=
 =?utf-8?B?Ti9rR1FmaldRM1ZBWEh0ZmJ4SnFqSlZCL0RQOTdaajRSUU5yWXdINjcrN0pw?=
 =?utf-8?B?ZklPY3pkTll1MzBQNU9xUXA5TVNibkZpbkd2bGZYZngwR0oxY2cyUlhuNGpn?=
 =?utf-8?B?Y3BLb2ZFSDJYKytCMkhPZ0E0bThXeE1ZWnVWU3IyRElwcEtNdGtiMTdEalVE?=
 =?utf-8?B?aVVKOVlOa1hDZm9UNWEvSlh1TWtnL0Q4WEhyMmZERHhZR2xtakRSQ2Q1cDMy?=
 =?utf-8?B?MGw1TWp6L21XRTBKTW1SLzlFdGlQYTVvNWdFb3ZSMkp4MEtwVHBmVWIwNG9l?=
 =?utf-8?B?LzJ0TnlVK1lmOXFrMG1TMFF3b29hQTdWVE52c0hXeERJYjhwT0JSbkNhbm43?=
 =?utf-8?B?VlZhK1NESStCZWtoNjI1b2RlWGNvcTBJa3ZCODhray9EMVorSjFKdmc0Yno0?=
 =?utf-8?B?eVhFazJ3N0pIMVE5N2JuN1k0NGJsZ0tOQkFlYUpzWnhPOHJvNjJteU0rSkpN?=
 =?utf-8?B?dEkrYkdQQXBsK0FVblVIcUZzcTM3eEkzemFDdGphNUpXY0F1VmpIdU9YOXlx?=
 =?utf-8?B?R1NqY3ZTUnQxVWh2SGFJWXl4K1ZuRHBwUVN1OE4vZE1aUDhXallXNGVSVHUy?=
 =?utf-8?B?MDh2MFdqb1pjT2hhOVZzditIWk1ONnAxRXI3bEsyNlEzK2RQY1ZTejZnYUVo?=
 =?utf-8?B?S2ZuMW5lcnVlNmVycDF2bnVMRVpTNnlCZFpXRmlKL0R0d0NnWUpHaENKaHZT?=
 =?utf-8?B?OHlQMHFUSHpnbFJITlVTWGVRRnJvUnlrL1ZFdjVHVUJueUxENitrcCtDS2Rx?=
 =?utf-8?B?bmVBZjhmR2ZjK3RjcllJRlpWcnlyUWNIM21ia3VjVW92eG9SeExzZTQ4VVpB?=
 =?utf-8?B?Ykh4T3VhK2hCZGU5NkhnWVpQcVJEVUdENE1aK1gvbE1kK3dGNTh4dFFsWEo2?=
 =?utf-8?Q?26Tx8dZzXVH6j/3pDmg2YP68A?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s8Aa5FZuTxPnU/1/9nGPFzyh3OSmyhip+HNT2O1mWDciM3Vypd/WKiWklVCQAh6xbKDxwbs/v36Cmlxchbt3h9gvEEM5oxvvNXqOClXBxxJRDqS/CKgyT1zVsdyOewuLZItsPwb54YRikj2c6uc51Y6TM2yTAHG1jpIv632Xct2RSWRzgKP8X3bjSAmQ3aqzGk+3bnW+Enl28E8q5lvjwdIoyqszjefrWl7Ohk+5q3b+r9ujq+vYP/AhcAvxeREKSccrjAyrDvVjQ+i4An+OLF6cKxrSmkpj9oDdRbgtvTHi3/Wx4uJTMydu4H2vW+ly1p3z1k+i42TSa2zYXjkf9jpvWJCV7FfHZy6pHOep3E0Mz4pCwmKiraCd9Iy9jVENL9fitIpkGMsc/xTI/HJ+SpA9zVvspNh4btx2WIZ9nj6oUaEgOP6/3GWFGWhQt6emi+8b9czTUXNgOCLcMBWiw/Pou7HScA5bHi2QvTeg79V/119DRF43my4lk+VQvnESOvvWXUC8vtV3uyVU4TPJ4HSUrSfKO6f8nirkvPjRdTS6AraYoHahm8MR7vLQJiXUhLqRm0kbW3RjdKuFLUa7RlosaU1xHfwHm4BKwqKief1VN+vyfZUh7vIgGF9PnDA6XgwpBYngOkodtoy3pKMalAu3Hf5SCXtbg1LbiQZbzusvqOQpNq8uMo1BpGtdnHf1OUCt85erVh0w7jjqNse47kSakFcdepu1Hc84YrIY51ytNpBXSFzeKuetdN3PDVUaLkda5GUhRC6O4bU2o9IUXwajyBl5Knq3gX6LWBuWBvEKTL4+GF5EXaXOpRc1p1U7
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf42a66-76d8-4e36-8f38-08db477bf165
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 00:03:06.2989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNg+bxm4uN3H6xwQa8TaZNsP+3DKNQL8KiuDX3CbfEqIHJWzq7gT1qrUCUKBEQp0kMmQJWGFhxCJD8Dh4BqcBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_09,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=879
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270211
X-Proofpoint-GUID: weySyJtxu6ZJsBL_q22yaQImX9Rgf65C
X-Proofpoint-ORIG-GUID: weySyJtxu6ZJsBL_q22yaQImX9Rgf65C
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/4/23 06:52, David Sterba wrote:
> On Wed, Apr 26, 2023 at 06:12:59PM +0100, fdmanana@kernel.org wrote:
>> From: Filipe Manana <fdmanana@suse.com>
>>
>> This fixes a recent regression (on its way to Linus' tree) that results in
>> leaking extent state records in the allocation io tree of a device used as
>> a source device for a device replace. Also unexport btrfs_free_device().
>>
>> Filipe Manana (2):
>>    btrfs: fix leak of source device allocation state after device replace
>>    btrfs: make btrfs_free_device() static
> 


> Added to misc-next, thanks.

Oh, I hope you saw the discussions in the patch 1/2.
We can address both calling extent_io_tree_release() twice and the
leak after device replace. Or no need of it?



Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB632727B1B
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 11:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjFHJVd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 05:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbjFHJVb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 05:21:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572ABE46
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 02:21:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357NdkdU017995;
        Thu, 8 Jun 2023 09:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=Q4O9d9cwy+m+w7XKy9ABoOcHMsX4eqPGCCWy1/+t2gH1fdXwA/UDDb6IkHpa9QD2yuMT
 nUScZwoFDIuKRQZowvjS4Y643O6rG2OQVX8cE9HiPujkfYYaZJXS1KBtPTvxHmLNKkUA
 M5BUwf/1P5Zq28qwVAacMjivsZUjk0pm+RXLlWShJckUxzOD7AZX/kq/rAry+Zh6hxJo
 a9mQ+36188gQ02YAVOj5ROpwWl37h05R7biZRYC4bz0xS52WAe7GW2/BO2gaUpAW3Zvo
 zq09UutUwT2pK+FCpNBZ9BVIY29WujWlOKxafE8PIpQ2xLHJcj24oIEtra6KpzDy8Dnq zg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6ubr7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 09:21:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3587IodY003126;
        Thu, 8 Jun 2023 09:21:18 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6mc89c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 09:21:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTDXrLVqar40Hp49OBYnEQ6vSZV+vGC4D0MNTnKY9tjnGuSucS46zB2EGYTG3YzHC0twok47/I7+OJwQzY3/vx0A/I/CJ16lK9TSyQ2Fli/NryWOxi3GloERolog8gktHDtaq3v+6TBZFDMTTDKUunNtq2yiGDtrtE1ZRe8q/JGBYLukzmE0zTz0eEaolkf8ivUqo6E7+rHzUYQ9GpF61+HW2AzfUcd7oc6s2krbmZnUQCa1e/abQDhJbq/kXpnloNrwKlJEi2S4I0JGqaFNnbMlsJekEbtbKvhqUHS0KuAz+dsIxzOWdZfJFb+EVlIKwbn0opf6Xdc2lGPsCN+Acw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=Fd2MkBYZaGAY6wuVGo6UY3Zk2ZmTBCrTlcts5jewnWaE/DRxcg68hxo/NZhTONV3IwhsIRQFB2A1C4p8fRtjh2LcovvptEe0PWLukMkhPAxAflx1uXxAureuLs3BKpPemUh+dx+JzEXZZehATGoXaEVwJh4/J7SqdbUywnhzaGmQ5ccZID2NVTFi6RCNX0tS9zg0Xq6XOKqkiSp3wDR6n/RdrZTx+J3Myxpn4/7PkspoQKRIgZGGXfUE7Q37xlFkTCeh8Ery8nBLnLcyjf7XvW4nzyYqP8f1n/kXl1YEXsj9o5NkwouBhAUBirWlx5JCUiiEJJll09FZ99b8l+Ddig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=ZdTE7VgbZ5uavL7XAlJ9Pv3uAzWpKyHFXUpFN4D8VsGhs774sg1cjVYQVCmoEHm2jhivUvqn9kSzQ/hVeWGiBEIiZ0700+LfLhsEgzD1RNBHBHHe8baLf1xqFZd2xBPC9nKGmoqol7I1haDAg/TcyxCG8HYW8D5BVJTVoi/UFls=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 09:21:17 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 09:21:17 +0000
Message-ID: <951bd83b-147c-d31a-789d-6f8b99e71f57@oracle.com>
Date:   Thu, 8 Jun 2023 17:21:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 06/13] btrfs: rename enospc label to out at
 balance_level()
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1686164789.git.fdmanana@suse.com>
 <4da7393afeffff23420fb2eafa27db99f882c39c.1686164811.git.fdmanana@suse.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <4da7393afeffff23420fb2eafa27db99f882c39c.1686164811.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5117:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a335194-dc08-40a4-19c4-08db6801b658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQdFGmckZMYN0ls/N9vkRNfBDt6osN636uCiiVYqBN/UP4U/lTpwDLhJ52BZKgOxGCPzk5vww3M3OngTFzHBV6zPtwecK5kQ8cXaw4G0h3yoPPc6Otdzav9G/I5JrUIfuNoMI+RyO4kXMu2ubrodRExqEARrRdZMvxsM3z+SqsYyitA5Z8fevTobBFqJhc/CGmRQzNeufE0QbuBlAlo8nOGbew0MG1x3/l0YPAOI05ihgClrEBD2akOubbW3EbUfkGRi95d79+yRzqbT1loMsR6U3SBt3uWg21ESleMZlLYdBdvngMiJ62MgEZpTh7hv8KdrzNTRWucHSxj4zA1cBiFVLO3t67FkRba3/Di7grIvtm1HVu8LrR/hwIw+wYauQwvPJxvzu8whY2fSTz4KkPskoKgZzKUXa9NYRVTkgm4PAEguKm/g09jOgInZR6HH8HfYAi9kKc0spUePxbBFRQYp1AHmb6R8k8i7e1iOwpbjtUerdqrQ5+079pSOLrjDLEvPfoQgx8u4kluFiobAzv94ZZoww5ScLa+/8/RtY9oImLx2MD9Iu1QRcNN2m/eXM46yMT/ejtUtOKUPHQjaqkjaB+r20G95zRqCWZa55w4qN+ym9DdFBfDlxN11ejZibvSdbmb3sT3yFuHQm9/wHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199021)(86362001)(31696002)(2906002)(36756003)(558084003)(44832011)(19618925003)(31686004)(6666004)(6486002)(4270600006)(186003)(6506007)(26005)(6512007)(478600001)(66476007)(316002)(66946007)(66556008)(8936002)(8676002)(38100700002)(2616005)(41300700001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWRKV3Q1T3FMMy9sQnlvT0dIaW9XZEYzbHVHYUNiOFRyc1lRYTZYTDRmRkhT?=
 =?utf-8?B?QjU1S2hBYVZjNUVxak9NR0luT28zUTB5QkF4SjU0TnliRGJVUGh2bEdPYkF1?=
 =?utf-8?B?WHBXZW1sZCtIM2pxZ2Jwd0t6anhqTFl3YytQVnEyV2lqLzYxT3M2ZEgxQkRv?=
 =?utf-8?B?SnR1VjVTazJHQ01sWXBTNi8vYjBzeXE5MCtvbXppbmRFdGVzWjZkejdIbjJK?=
 =?utf-8?B?aHQ0MlJiOWVxU0pMSWsxdjZaYktLNzUxRmtDQUptckhEMnVKZVo0MFpvaHV4?=
 =?utf-8?B?bW1uRjdPck9Sd0RhM0oxZ0Y5S2RXejI5RUdSdUZ6TE9VL3BQWDQ5M1ZPSDgw?=
 =?utf-8?B?SWpuLzFyd0pNZVZNVTRYSUhkdU9TUjJYVGJZQkhEZWhnaERLdWM3YThISkps?=
 =?utf-8?B?a0V6Um8wcDArdmJURnoweTdzVXZITjFZTUFkeVV6SjJhQkd3Q1E0QTNLUlpR?=
 =?utf-8?B?cTdWeDNrUklrSFpkQitxRzB2dHdCTXJKcjRkTS82ak1KT1FCa2MyZHpGWUMy?=
 =?utf-8?B?bElvWitCVytiZnBQWW9lelJNd2w5dzQwZmR4UXZvN0ZEWUxTd3dUamw5WTFK?=
 =?utf-8?B?eXNYeXZhWk80dkFmOVlOcEk0Rmhnb2Fubi9ZUlhtaVdGTHp4ZEE4d1NKN2c5?=
 =?utf-8?B?N3luMVpEZVRJaE1NYTh0OXVBVDh5cUJOUldCN2hQcWtMNVFFOG9kbWY2N1I3?=
 =?utf-8?B?Vm9adWoxUXhQOTZYNnF5dUsvaUhLTGgzQzJXWG5jM284UmhFWW9vOHBHUFd2?=
 =?utf-8?B?cVo1T1I1SytITEJUVGhmTEpReU5OdnVLR1QrdlJlRk9TdVpRRHJDdnpJNjdV?=
 =?utf-8?B?M3cxUzNFMDNhQkR6eFF6S09yV1dMQ2UwenF5azdnWnZ6Q243WFhMc0xOMVVT?=
 =?utf-8?B?ZGZZUThkN0VLTCtJZXljY3ZJWHlmaVVjQm5RakwwR09Ld211L0krSkxrT3pT?=
 =?utf-8?B?TTNkTWVWcXNBaDNoaTdCaWRoQzVJbEdvUkIvcGJ2WndQR1RJcW8rR1RFYTk4?=
 =?utf-8?B?S1VRVDdNY01qbkY4WjlIL09qcnZnc0FRSFF5M25rLy9NNVlVelgzVU5FNlZK?=
 =?utf-8?B?UFNiandJQ3pUaUNhTDhvNG5LL2NHOVdUazdDb0dLU255UUpLbngrQnc1YWlP?=
 =?utf-8?B?NUFyN1R5VXhSZEprbE5zMkVYcm5FaURFTzc4RHErK21ldEFvODFHdkFGekVs?=
 =?utf-8?B?S0diV0l2RW1LQS8zck1PWlJQWXlTVWRzTkZwNFdwaVB4elNsdVM1T2l3b3J1?=
 =?utf-8?B?S1NLdnJqMzBTQ2ZWZjVOWjlodXFBNlBFeHNaOStXMzIxcHRxM1VPWVRaamc1?=
 =?utf-8?B?THJXanQxQ3lPTmc2ODcyZU5FbWtxZm8xWEdjZXVFNUdDYVdwZWVTcEVJWXBP?=
 =?utf-8?B?VTBvbUtiVFZib0pKMDQ2NVJiOVN3WGNLanZZSHh2bHppck4zRStDSHdpVHQz?=
 =?utf-8?B?QU5yRzhZVUN4SFVVdEtjOC94czBZc25JY0NkVmp0MEFtbHhoUVZIa2hiZnI5?=
 =?utf-8?B?dlBydytHekxVdUtwRjBxcHEvaklRdmw0Y084QmV6c3g4TjBlb3B1RVhZMlNn?=
 =?utf-8?B?OXpMblBHZkZmYnZ3a3dHaWxlZE9WRDlnQ0NmNTREeXFTNjhJYlZhdnJlVWtK?=
 =?utf-8?B?d3JNNnZBYlpBZkJDK2dySHRab1BXMVIxMTBHM3hGQ3J1Qy9KWTlzYXA3a2Yx?=
 =?utf-8?B?ci8zdUxDaFVSRlFBMjhSUUJzbWhkVjV6d1hmektHSEw0a0JiR2VGL3NVeHZ6?=
 =?utf-8?B?RjdmWlBKTDRLaU9hS0NrTzVreGZ0QTNKWS94cjh4T2UwaUVmQ0VBZm1vbm91?=
 =?utf-8?B?MnRGUkdrNlUxd3FMNGU2R0J3S1lYQllCMEZkc0xJaGdmZlNsenYwQWNWSGh0?=
 =?utf-8?B?WjN0OHhNVWtVRnAvZXhNajRMZ01tazJvQ2ZmQ2ZUREc0QkRVUWwrY3RveFJt?=
 =?utf-8?B?U2Irck84UXRVblBoNDF0MjNsbW1CR1hlUXVtNUhYbmtwWUEvOXNrMmVLRm40?=
 =?utf-8?B?MEJUN1BSMTZQUnRyQkswK2N3c0Rud29XeHpRV3ZMb3AxK2pQaElERTlwcndn?=
 =?utf-8?B?VXdnK0E3bzFwbWp5dDA1aWpXdFVkSlZjWGlGREZUeTBNKytFU0o2QWNjSzZu?=
 =?utf-8?B?SmY2MGpoM3pvRjBZc3RSWmxkbUs3Y04wbm5uZlNYNTNUcE5WcG1FSHd2SGxs?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rR412G1BCSXaXMbkoJvaseBvcZWuhlAHmPMU/l/KLhavEyukrFirM5Ke6hmKPNmrKzTY3svzBMzkK9CtM/ipPxuE6IoCtm4gQk9WOAdt5LM+x0sUcipBfyxQnB7fdzBG96vlUxJli+CQPV9XJ5R2AF8AkF8/XKmG3Jq73SKtcYDTgzShDFTm9siDQRfl2khS+HLPKR0Gca0k90YVoI02Q+4BWPjoxagsj4Y14pySLwfYdwS1eL8GYuyj7yapAKnUMU2othOa4F4qc85f0vX26Kq+uDW1hErKCyfINJ8anmByVq2qNq+DzfzQ8k56CSrk96EWzfAacNAPPVA76mS3aOPuL8SXnXcFsdnsm8Ya7nR3E8G/TDGOZjFbWjrmN//LNwZp3wbyPdLQ7lDd54rewlcdD6odDHsw9SzqOJf5gDC+ENrda4eQG5hpo7UjZRfb+jCKkgiixMdD8OShkYjeHPKLR5oyU35XVXenka6S6yBcQcy3O6LINNxFIs7yNgUhgqrbLYDVbxZAunRd9XoIN6A+a7Deb+LaMOgGT6EBRFUan/Ed/eRiDoLG96XeNod5hyXrQdNNkY536AJbIDRpGCSudanrxjz3kplBvvdxIUZuGOuFjnh5Dy5FdhwsxtNXZdb14UPs2G21Kvon8mcVMFjNiAmG7Y5/EFNpvCwMAB5hHy1gYN1lhFhnVLN0otLNZolsu+glkQVevUTziTDAyvutzn/glMOyHKN0Hn5FZ7smsJ8biqh6UmbpxBysF2IuVnxv3RLjNcj5KsaMZuxTZq1vJFu2IRESa8lV8rurEv8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a335194-dc08-40a4-19c4-08db6801b658
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 09:21:16.9785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4mP2VXojGtd62Qvrx5rfCw6VXqtOqueVJwJQvRoys3mLCEcInk0lUubMoZALNWYivmI1OTl4w6Kj6EgrR/bzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080079
X-Proofpoint-GUID: Jz-rQck8pNafz_65wTUvz1Te24-otAEx
X-Proofpoint-ORIG-GUID: Jz-rQck8pNafz_65wTUvz1Te24-otAEx
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>


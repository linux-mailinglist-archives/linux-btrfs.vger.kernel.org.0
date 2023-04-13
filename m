Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB636E0D65
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 14:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDMMYU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Apr 2023 08:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjDMMYT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Apr 2023 08:24:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEFE359A
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Apr 2023 05:24:17 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33D6Xuxh026327;
        Thu, 13 Apr 2023 12:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Ntt3kQhHuS9HBV2uqwwZHZcbF9kPGUCYJ6uRiLg9UgY=;
 b=FAQEeh4b8pqIPZAQMjju2GFu691lIUneQyrM7wGdmoMHDn/19ggBzXur4NK6bOUVAZox
 ck/Zto4GrjWfBTQWI5Ce3NkUDBNtLgnsUbI7LGtsTRoyWYbJybGgk3R/ukfc0hCcKYOM
 nSm6QICQ6zTNfn3lZAViU+t1ZhlSYzuy7MvKM9JzwhjVqMUPoXkc6zoASjSUWsMXsA1G
 j3wUeM/m4LzVoPuCMjrh//YvvEsS1Nj+AYl/mlRDS2jCsg04xJ5+tmJfQQ0+TEoLkFG3
 07Gr6HkSdALaplvM1y3W5T/gpIg3wwcQR/KPQTWHrREfCOvUHWJPYPEBJmVwzpxS5HEj QQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0bwjvf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 12:24:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33DBPX1W012738;
        Thu, 13 Apr 2023 12:24:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pwwgqx531-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 12:24:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fj6Oagt+n1IlpkcCttWCa5k77J/UdVwJGiMKYaTx0ThgzWJ03ctGI37QMKStuSihYfjSdXqN3oZ+N6q6fw8K1U7/wdN5aO0uh/Pt+lgTMMmxvd9+pm9Fp36m93owqr1A87Ll3t1u5zefrvH+N1mGKGpQKgObGfoC+cD1Bthz8F1UqIT2hpCJrch4bElhq6dGWUCN/zYyIlHr60bdVDN1POEfIbpngy9vaawa8k+4moz1Eb9Z34ZM2HfnOF0Wj7biK21h3x0MnhAwCCeAq59YQ0kykAVQjEq66uZCtt6/3/hys072p+yuI7b+uLfbW86r1DT8aKRbYBCrReDu/qhHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ntt3kQhHuS9HBV2uqwwZHZcbF9kPGUCYJ6uRiLg9UgY=;
 b=MuQSIx91aIL7OgTPIR57PywfuIW9dWNbBRmiNkW4GjdN4x8206KfVNMdKrqEToJ0fdeoc35xmsYXe5AA4XKeNk52gm1UAMJL88eySJNfXCL3ke453QqJ3Q+O9Bq0JDqJLgtmvkI3dvup3JYme6BSztXLMId6JhHFPMY9bHZWJuu9ueaua5uKm760Nbq9zYME2dFVL0D9XW1GrPOio+faowyy/rHX7A48w4TLnuSqT3upv6FLTq47f7BNVrNb4OFE6pPiDeLds2So1gBos/ie6XDs4cd/tfY6ZzSj7hzfY1s9Ayo28uDHw5t1VNXcNTcavimHrc9sNxLFO0d9IXHnpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ntt3kQhHuS9HBV2uqwwZHZcbF9kPGUCYJ6uRiLg9UgY=;
 b=Wxr6NRXtRTA/aCEDZYUt6YFJ8e/9vG5ampAaXwZH3UDTkScvQsn5YRRQap2R7NzIqgVAguFw/ubrgqaCHtWqDF9uQnBOfQZupp59TNDKFzR2YSfKirqazBaK6rxIR/VXOKqjBIW5EG/Ke34SJ/YNJfeSjtGdgEDnqka6SsTFLbM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6319.namprd10.prod.outlook.com (2603:10b6:806:252::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Thu, 13 Apr
 2023 12:24:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%6]) with mapi id 15.20.6277.038; Thu, 13 Apr 2023
 12:24:12 +0000
Message-ID: <054ae0c1-3a1a-eed5-5ac9-c4d7773c8ab9@oracle.com>
Date:   Thu, 13 Apr 2023 17:54:01 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 2/2] btrfs-progs: move block-group-tree out of
 experimental features
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1681180159.git.wqu@suse.com>
 <4cc5819796bd2af6de78b7a1919b4f8ed02b985f.1681180159.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <4cc5819796bd2af6de78b7a1919b4f8ed02b985f.1681180159.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 90474e93-0c8b-4c4c-703b-08db3c19fcc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFNswWICP2p7o8yu5VEGskVEKc4VQh8MMA24ntiEFxgqhkT7ZVwvOKzFslb2nfCe0pdUnq1ZguxHPg9p0cxpRrbssqQ9FCwMekbNE1hZmZ8pcJSs/OnFG0LeE+r26punRqhekQK0ssme3vuekbXaZkELx0DQLOLoldiuuVBn9mU0DBwOFuq+5D5ligEEUYiH5WsoEY+0lxz9Zt5p2obAPhXe8dJp9LUCNy6rw174Ol9uLCZF0EEAZWVrQrUjoZzOxyTt5eUEYgVcGzS4lTpGaaYd8y+B1Tp/4atoVbVQyBsL39lIQhfyAaOhoTPrlJzPVJZRCK0F9KcU4mNaMI4m012zug/xwdsPIb+bYfDfce+yy6KVQ4GzylNAmoP3n7ByvprFcQQmlWdZr79B41kr7lnC6BY1HUXNZaeQtHk+KPo/JwY01eQH/ur1H5bMOv5FJayjYzlgVcOV4kPMvq9to0FTZCM1Tz0x/TrfGGshSH26iOsnl+GVxC6H7/fCc/VkKGd+9NvD4Hr9W+KDRocNDtdyOMx9zj4WHpeHk+g4BdMisGMmrZpTBJfXxJGKAq4swMc2beKeZQPh8Nj/nW5tMLLUJUumlvjCYN4ufqLqp4H3WZTBV2xe9UbTeOtwM09xuV29APTY2Y+gGPwS/wqYb52N0TYtc82n9E5LGlTl7fmo/AJ1wmANSmJX0oCY5rAL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199021)(36756003)(31696002)(86362001)(41300700001)(66946007)(316002)(83380400001)(66476007)(8676002)(6486002)(66556008)(478600001)(44832011)(2906002)(8936002)(5660300002)(38100700002)(186003)(6666004)(6506007)(53546011)(6512007)(2616005)(31686004)(461764006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFFXV1NqWFpvNWpmT0lsbVluc3FrVmtQa2FjazkyNE5tempzcTMzVlVLMTJp?=
 =?utf-8?B?UUVLWStzUExHVkFGWlJBV3JGQXNnUHpyU3UyanBiazdlbzhUaE1KNFNMREFS?=
 =?utf-8?B?NEVxRU9jT0JVOGlHc2dOemg4RkFlR0F6dTNXejJwQXUyRGhpUFdkcnBIeXdw?=
 =?utf-8?B?YTlZUzhhc3l1TktZTjhST1ZLbzhNdFBEYWxua0RFcU1lVmNqUnJldFZSRGFv?=
 =?utf-8?B?Z2l0bzJZaEE4SFRhRWtDVTZJMEVpOVY1VnFOMmN3QVhBclpFbVVGNEF3RVFx?=
 =?utf-8?B?N3RuNFpoOWJGdmltcVR6VEtPTUtaMDdocFBLcUtVdlJLeFk4dkR2WTZJcjRo?=
 =?utf-8?B?WFlLaU41L3JVazR4dTZpbHhnQTRLUTlra3JzK3Nqek8yYk5MY0dzL3N0Q1Yy?=
 =?utf-8?B?NGliUk9BckFCK3puRjRaejNxSk1tNERyUDd6dlRMUlhKdGdmWDRFdDc0MDVv?=
 =?utf-8?B?dEVLN1dvbDJab1RKMzJlZEVDZEhqOEpjNjZvcHpKVERUZlRQNmFSeWRQUU5Z?=
 =?utf-8?B?eW1JdXNFYVJuS240dEx0ZTY0QUUvVUhSa0k1a2RUWTFhMlI2bGdSTHh3ZlVh?=
 =?utf-8?B?YURrclNkbXVYWGJDczNESm5uN3BMZitKSjdQVUExSkhOa3JKeUVXd0swUWR0?=
 =?utf-8?B?dkpJc2xSSEtlcTI4SEdtS0JKZUlYNkRRcDl6blNHa1FwajFpajJMcThvcHoz?=
 =?utf-8?B?cnl5dVg4b0puRHNMbTFVS04ycGZFVGpibUJrMnB0TjBmVk9YRjFpN2hVYTZh?=
 =?utf-8?B?SjhoUzU4a3RvekRHSndNSEkwV2ZtVHkwSUQ1Vnlnb3poK3dNVWdFYnB0bk9r?=
 =?utf-8?B?b2lxV25xdFV3VTRvZVVVam9La0tBVTZSNUhyODNBdUN5TkJOS29QbGowbW9s?=
 =?utf-8?B?aDN5TVZNNU01WlptVEZMZXluTy9oakhLN3VWbWw0eS9WaHNhYlIrT2ZPWkZ4?=
 =?utf-8?B?NE5tbU1zUTdXdnNhNFg1MVVmOEc0cmFGUllhRlBBcEJlbjV3cGptWUZpbVZt?=
 =?utf-8?B?OUsrRERQWGdaZWdGekw0M2tUaXFXMTZoNDBadnRzb0s2M1pGZnpwVGMrejRn?=
 =?utf-8?B?K2d0RjBpVEI4d2ViR3Q4aDZkc3A5czhYVVJ0aERtc0p1TnUxNk1nbVlvSGV2?=
 =?utf-8?B?cHI2dkYwNE10dVp3Q01CQlZaTU9wU0lBNWxTVEx6UStFZlJKY1Bva1FhOUM0?=
 =?utf-8?B?VG9GMjRtT09FQWh0Rks4dW9VdENPcVl5NkswZHVGbWdYRmZjbklnOFNyZTNu?=
 =?utf-8?B?a2hWbWY5eHhGd3lCVGxWOTJNMkk0QTlvSXloTXBFQUxWb3dpd2ZseG9BaExK?=
 =?utf-8?B?TS84d2RycGRQUXljb2JuNHU5VUl2YzlORmRWbndTckZkQmJaUTJBc21kNVlx?=
 =?utf-8?B?bTJWZVB3dkpodlk5eHJGYnpZdkEwbXM2blNjUmtiQ1RRNkNwTEJWQmxicysw?=
 =?utf-8?B?ZDZvVjdjY0dxOGdVZVFuaXord1RIRmIvc2MvMFJpc1JrM2NXd3hXTjFuajFq?=
 =?utf-8?B?VGk5Y1MzTVlDRGlQNXpnS1YyMFAvTE05azVXUk8xNldjbldUV2dkdmFMWFE5?=
 =?utf-8?B?UVAwZWR2RVUrMDdtOGhEZ3FjTTk5STZKa3V1Mnhsd0x4aFRPTmpOdkpzUWVB?=
 =?utf-8?B?YUZvUUFJb25Mdm52UFdDQzRYWEFjenRrMzcwWTFIdmlwUjdMYXBZbW1IZnFx?=
 =?utf-8?B?bTNvUk53NHR3N1lzS3hoYm5aVEQySy9MeVlGVzNHdDQ4QjVFOS9ERW1nN1li?=
 =?utf-8?B?VG9mOEU5Y1Z2OWhPRGlPVSt1YmZqYXZFeE1NNDFCVU9INzVueHVsSWZFbjJN?=
 =?utf-8?B?a1NvMzRXMVI1aUpUTVdwLzN5eU1XUUVSOFU4OWZOWGdZdVNWZWJJS1JMbEdY?=
 =?utf-8?B?WktWTEttdWp3RWY3WWtIL1VpTVRDanBaMW5QU3hsemlsZ2NNMmpvWWVtQ2tv?=
 =?utf-8?B?dVRLa2tqQ3dsWFZyTk1MenNHbitqZDV4TlRsK2NoY1h1VzFKcjdWUGg5ZTM1?=
 =?utf-8?B?bWRQelB3NC9NcVczZG1KS2VTZkdMSm5NMGhrSDZEazJ6MFB5dzNwSGdFdUdR?=
 =?utf-8?B?aE1GT0dITE1PdzdQbkJhSGFra3ZFRERDMHBDODN6MzZsd1BiUDQyU1cyMk5m?=
 =?utf-8?B?TERNSEVvQklUN2tOZFVCNCtwM0I3OTQ1SHlCMmYrOHQzSnlIS2V0YU9VUTNC?=
 =?utf-8?Q?4rXx6jHKKzn9R3kvC+FRcdHn/bWXBHIAjUUOaDNaXXih?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CeOUZI/6A/88cjR6iYkNnH0kz4q+1h1ZzMPtTAqey2nKWNvjzMw8CVuRYNf2TTfXoHqv1ZvO77v6mMTzIovRdl5MCBmujuTjpVNOXYeFSPAh6Zdy6DJzBfxrGg9Zm5XgjIQPYSZzHUNmK8vMsq0EP8P2IQi1/lG4A8aj3saYpRC1nvSMYHYOyz2yjK5dbXy+BvBoFLbETQ9M/XTrqLN0llRWT4lL58B0pQhWELDBVp278fflIF8JARc4056pFw0r+8KChPjiXqRJnzEAU1J5J90ndK6bbDssOa0I/0LPL42ADrvFTO2F3I1K6o7YGHX/fVM18Onryg+Yc3q3lnq+L47pfoO0P7I2SE8DcNTKByBdAiTraHSGWLwUnhIiJONnTaskPnbTIQEVDaAWo3ZxXBpdpaWYek5D90ivdpPyoMB0CAoGjJFVgRDcqvETczmGy8vF6cBaJpKN8rBlLZUkNPmQ5w6L6tPYj3nf9UBhdZ+jxdpWjyOGF76GISmsafrQnk4bjHu7jUzq54KgmzUk+/LhubIgT8WE3wn+BNKJuYbcs72U/59qYSESLwRfJkbr7fXnPHirWUCLzBaYY8lyUE3qpNy7ZUg+YMVlGqVL1CKBK9RiyxGDoCJ8g1K75rfsDCoSUXhSJVE1nyAVijcBDXHhsKKSPyJR/9vh1hIhRANTeVlTAanjQs2rulTF/k6CWYhonSeE3xcwB2qOqFNQCqGJHTbWmVjc7T7aiHfxXdQrfIJvt7Wh1OzGVOTuLpARU/dBPOqyi8Ydym+oqqVgUKQ4UFNZdbBADT4v05tkJsg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90474e93-0c8b-4c4c-703b-08db3c19fcc6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 12:24:12.0225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzdTjpktHtw6cv41KiXv/AO4uTbN9rxKG+wzuk/TlL9I967txYTiwtucSR/P1hFfcX5Ag3L/bcdg2z8jGuX3xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6319
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_08,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130111
X-Proofpoint-ORIG-GUID: S9I3qwhTBgDlZvIc2X0CUSkZ2NlSpOPi
X-Proofpoint-GUID: S9I3qwhTBgDlZvIc2X0CUSkZ2NlSpOPi
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/11/23 08:01, Qu Wenruo wrote:
> The feedback from the community on block group tree is very positive,
> the only complain is, end users need to recompile btrfs-progs with
> experimental features to enjoy the new feature.
> 
> So let's move it out of experimental features and let more people enjoy
> faster mount speed.
> 


> Also change the option of btrfstune, from `-b` to
> `--enable-block-group-tree` to avoid short option.

What is the tradeoff for the desktop use case (lets say 1TB disksize)
if the block-group-tree is made the default option? And add btrfstune
--disable-bg instead.

Thanks, Anand


> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   Documentation/btrfs-man5.rst |  6 ++++++
>   Documentation/btrfstune.rst  |  4 ++--
>   Documentation/mkfs.btrfs.rst |  5 +++++
>   common/fsfeatures.c          |  4 +---
>   tune/main.c                  | 18 ++++++++----------
>   5 files changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/btrfs-man5.rst b/Documentation/btrfs-man5.rst
> index b50064fe9931..c625a9585457 100644
> --- a/Documentation/btrfs-man5.rst
> +++ b/Documentation/btrfs-man5.rst
> @@ -66,6 +66,12 @@ big_metadata
>           the filesystem uses *nodesize* for metadata blocks, this can be bigger than the
>           page size
>   
> +block_group_tree
> +        (since: 6.1)
> +
> +        block group item representation using a dedicated b-tree, this can greatly
> +        reduce mount time for large filesystems.
> +
>   compress_lzo
>           (since: 2.6.38)
>   
> diff --git a/Documentation/btrfstune.rst b/Documentation/btrfstune.rst
> index f4400f1f527a..c84c1e7e7092 100644
> --- a/Documentation/btrfstune.rst
> +++ b/Documentation/btrfstune.rst
> @@ -24,8 +24,8 @@ means.  Please refer to the *FILESYSTEM FEATURES* in :doc:`btrfs(5)<btrfs-man5>`
>   OPTIONS
>   -------
>   
> --b
> -        (since kernel 6.1, needs experimental build of btrfs-progs)
> +--enable-block-group-tree
> +        (since kernel 6.1)
>           Enable block group tree feature (greatly reduce mount time),
>           enabled by mkfs feature *block-group-tree*.
>   
> diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
> index e80f4c5c83ee..fe52f4406bf2 100644
> --- a/Documentation/mkfs.btrfs.rst
> +++ b/Documentation/mkfs.btrfs.rst
> @@ -283,6 +283,11 @@ free-space-tree
>           Enable the free space tree (mount option *space_cache=v2*) for persisting the
>           free space cache.
>   
> +block-group-tree
> +        (kernel support since 6.1)
> +
> +        Enable the block group tree to greatly reduce mount time for large filesystems.
> +
>   BLOCK GROUPS, CHUNKS, RAID
>   --------------------------
>   
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 4aca96f6e4fe..50500c652265 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -171,7 +171,6 @@ static const struct btrfs_feature mkfs_features[] = {
>   		.desc		= "support zoned devices"
>   	},
>   #endif
> -#if EXPERIMENTAL
>   	{
>   		.name		= "block-group-tree",
>   		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
> @@ -181,6 +180,7 @@ static const struct btrfs_feature mkfs_features[] = {
>   		VERSION_NULL(default),
>   		.desc		= "block group tree to reduce mount time"
>   	},
> +#if EXPERIMENTAL
>   	{
>   		.name		= "extent-tree-v2",
>   		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2,
> @@ -222,7 +222,6 @@ static const struct btrfs_feature runtime_features[] = {
>   		VERSION_TO_STRING2(default, 5,15),
>   		.desc		= "free space tree (space_cache=v2)"
>   	},
> -#if EXPERIMENTAL
>   	{
>   		.name		= "block-group-tree",
>   		.compat_ro_flag	= BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
> @@ -232,7 +231,6 @@ static const struct btrfs_feature runtime_features[] = {
>   		VERSION_NULL(default),
>   		.desc		= "block group tree to reduce mount time"
>   	},
> -#endif
>   	/* Keep this one last */
>   	{
>   		.name		= "list-all",
> diff --git a/tune/main.c b/tune/main.c
> index c5d2e37aef3d..f5a94cdbdb5f 100644
> --- a/tune/main.c
> +++ b/tune/main.c
> @@ -70,6 +70,7 @@ static const char * const tune_usage[] = {
>   	OPTLINE("-x", "enable skinny metadata extent refs (mkfs: skinny-metadata)"),
>   	OPTLINE("-n", "enable no-holes feature (mkfs: no-holes, more efficient sparse file representation)"),
>   	OPTLINE("-S <0|1>", "set/unset seeding status of a device"),
> +	OPTLINE("--enable-block-group-tree", "enable block group tree (mkfs: block-group-tree, for less mount time)"),
>   	"",
>   	"UUID changes:",
>   	OPTLINE("-u", "rewrite fsid, use a random one"),
> @@ -84,7 +85,6 @@ static const char * const tune_usage[] = {
>   	"",
>   	"EXPERIMENTAL FEATURES:",
>   	OPTLINE("--csum CSUM", "switch checksum for data and metadata to CSUM"),
> -	OPTLINE("-b", "enable block group tree (mkfs: block-group-tree, for less mount time)"),
>   #endif
>   	NULL
>   };
> @@ -113,27 +113,22 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   	btrfs_config_init();
>   
>   	while(1) {
> -		enum { GETOPT_VAL_CSUM = GETOPT_VAL_FIRST };
> +		enum { GETOPT_VAL_CSUM = GETOPT_VAL_FIRST,
> +		       GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE };
>   		static const struct option long_options[] = {
>   			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
> +			{ "enable-block-group-tree", no_argument, NULL,
> +				GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE},
>   #if EXPERIMENTAL
>   			{ "csum", required_argument, NULL, GETOPT_VAL_CSUM },
>   #endif
>   			{ NULL, 0, NULL, 0 }
>   		};
> -#if EXPERIMENTAL
> -		int c = getopt_long(argc, argv, "S:rxfuU:nmM:b", long_options, NULL);
> -#else
>   		int c = getopt_long(argc, argv, "S:rxfuU:nmM:", long_options, NULL);
> -#endif
>   
>   		if (c < 0)
>   			break;
>   		switch(c) {
> -		case 'b':
> -			btrfs_warn_experimental("Feature: conversion to block-group-tree");
> -			to_bg_tree = true;
> -			break;
>   		case 'S':
>   			seeding_flag = 1;
>   			seeding_value = arg_strtou64(optarg);
> @@ -167,6 +162,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   			ctree_flags |= OPEN_CTREE_IGNORE_FSID_MISMATCH;
>   			change_metadata_uuid = 1;
>   			break;
> +		case GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE:
> +			to_bg_tree = true;
> +			break;
>   #if EXPERIMENTAL
>   		case GETOPT_VAL_CSUM:
>   			btrfs_warn_experimental(


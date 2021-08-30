Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95CF3FAF8B
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 03:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbhH3B2N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 21:28:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42760 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231401AbhH3B2M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 21:28:12 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17TERw39015309;
        Mon, 30 Aug 2021 01:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RtvCXJW6fMPcTHpGzhxL6eW6o6HPJYwxnUaP/zVcpMo=;
 b=ARaqDCMnsU3y6ol71iHEMS4HT13eIAajHRJuglZmo3sY5FyxNJuTvoAE1QjuSKScvBkG
 2qxcckrjOs8KrRNEn0WD51xJqF7LPleGOc8GGKeCWGhmgoaUF15ccQD3/TebX9Ntv7mX
 e13iFdgMqk7cQ6Tj6gy7iAAnIVCptfqLk906yucutSvbT+mFi3FMboR4FSwTJ6DWnvAs
 HkJTuFiuZW7g2P7IiaO3II+bF0rPt7Em+qIY3AoMdQW5H/YKygKxU+gVQUmpvAMWDqL4
 LaD01JWCJmEpERi6UYUR3p9xcxnevCnjfFgF6HjJqeCeBqhnnH8Tmreo1draY+XLot4j ew== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RtvCXJW6fMPcTHpGzhxL6eW6o6HPJYwxnUaP/zVcpMo=;
 b=S10sMlbCNJQmjrOaTEmWNKrHzvUGj6EFMGwOQYUau8tmKlBCasyEAQBDBIlZr8ub/anB
 zwrTZUHY+h7T0ipw3LCU2zppdmTNEchsGwqQpt2RQOxQDVavUiVy4mHuieNjwLTqZbH9
 AhD1DLSOoHhvsGIxXH7r5uG6eJWCMmMwkK7yR6bn1XVQptkRIfqUpyrM39bFxIbu6GjW
 Ismo89ClBtAH0mhCopM3p2E1DAjZb54lnLAJ+hUkeuQXz9D3+zo/UuogNGa7amGhOrN7
 M986mJ+Q5V7qeUN6pL32WgBZN3b3/pZDyL2BDX6rA/Ogupla1qAvrnITSITXOIZD4L3X Tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arc1a0bfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 01:27:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17U1Bj9G108908;
        Mon, 30 Aug 2021 01:27:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3020.oracle.com with ESMTP id 3aqxwqfhaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 01:27:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMZBOiq8vmvXHo3z2a+O97GLpv0aXFMC8IKAUlAhlvw3XHbwoJWAlY3/0NLkzMn5SKFGENh/ikHib5bApP3TpumNmJnZgqvtLvP6yfI1eY84fGQgVcnzM3wGP2yxT1C11uLCAHWiIlbt8lHD7EsOSgeGW5sFcxItIQrhqVVGkZb/bXODucgvEdKMHGHsuhvJvyJ+xwwg6wXh+F5Eo4PNYtTEd/fHBsKYbj4vNDpTPxr7pE1eGf8Qc86wAp/a/DqceEg5ETf6jPxp0fvdLMAAI24lWxI8r7H4xpR/H3BS8KPpukfuSU7Vi0eaimeAEeVK6rOOWQ4RExoIr/qzmyrqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtvCXJW6fMPcTHpGzhxL6eW6o6HPJYwxnUaP/zVcpMo=;
 b=af/oNl8uZTHMMUq13r+t0yr2lFqZV1nWfjNVdKTme4e5VrVvDbFWltLpZk/5hhLovvCT9dflKjlQUf4HfZ7++NEhxRS8KGrU5EUyICYmC+SikGC4CID3Qv2bcenrZKlmtL8FWgX0K5jACfKfG8uK/3/95ZUuxZL4VJ8nxT9Ck+VPeyyM+KVR2V/tVXlkdoroEosK4uKiEABuIokYNr1PtIQsAlofIqXW40ytLBued1fFoe9aVuCPJq7E24fObN+0lilPxFcqbkcAd7LE8fhdx10kgQMe0NwE/qItWhDgXmPyJ3ByGGoQh5Yw+LsYZphLF78CwAJIcqm3AOmUjmvC8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtvCXJW6fMPcTHpGzhxL6eW6o6HPJYwxnUaP/zVcpMo=;
 b=m1kKA3Nj1DKXuGaqp2GnjDKRQcSvqasr60hKn4rPu7+ZI/31dfXrw3f10TIJMa8v/PEOX4PAxFfR/q03rbfbYGPvE3dtT9vWh1BsJZilCRozWFZSZHxC6xUsOQLspHUkdB/qNHrzVSEmzbCcVvr0LePkSDmuL7Ds0fLemXz0gk4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5234.namprd10.prod.outlook.com (2603:10b6:208:30c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 30 Aug
 2021 01:27:15 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Mon, 30 Aug 2021
 01:27:15 +0000
Subject: Re: btrfs mount takes too long time
To:     Jingyun He <jingyun.ho@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAHQ7scVGPAwEGQOq3Kmn75GJzyzSQ9qrBBZrHFu+4YWQhGE0Lw@mail.gmail.com>
 <ce0a558f-0fab-4d52-f2d1-1faf4fb1777c@oracle.com>
 <CAHQ7scVkHp8Lcfxx2QZXv2ghkW-nYpiFGntyZa0Toz2hU3S-tQ@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <b0feb23e-4a18-efd7-eeaf-832ef0cf6860@oracle.com>
Date:   Mon, 30 Aug 2021 09:27:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAHQ7scVkHp8Lcfxx2QZXv2ghkW-nYpiFGntyZa0Toz2hU3S-tQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 01:27:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c3b5fea-d0ad-4bf2-9be0-08d96b554cd8
X-MS-TrafficTypeDiagnostic: BLAPR10MB5234:
X-Microsoft-Antispam-PRVS: <BLAPR10MB523433AB2DFA0717E50D4E4BE5CB9@BLAPR10MB5234.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIZ6ILko4RS3cAdXLRGvMoy8F/lClVAo7yuF0zCQ2Sg2Oiuk4tdMcHkBk5v8Dx4Mg68I70Xtb7YEtnPUq5RhWogwbNagc0XPtg+MPZWME5AVQh6dLO01VWpKJ3aR/ExfDwSGHeQEy2Fv2kpncEZcy32sDzlqMCJy+N0rv+IWzYzZXRHx/ObjJhYLpsC/ZuKfqDbX7OPQ/rQbBBC1OfJ7r1ETvyd3g5nqc1CDH9PDrMpMU0waBd+g9Xs5aC+i8vACv+tOnqvDrG/n5f7wxg3I8OmU4APmBKAzQlvSjarCXLbqzqqF1kUK3V2i6BH7xdrsestocg/B9VR5AFgpLvjz0afJ1JvD7focNPGw+kaPUx0MlgTbgEjRQm8M8KgvvffKtD3JbXpvD7dyzAAKDPTmwq+KOIA41Cc3nrkMk8wliZko9HgrrawHL8osH9T2fzcwJpZO7lD03ZGdOuiUQ1iOfv5eDgjsQrkBX0S2iB/Yd8m+J3pQPvJLoH+tovoJxYBOe6oL27TKb7hrgDCZ6blzruN8W/vIl/p4MGZvhOiFelk7v0IuR6eYo5lLi+fw2J7FEyXLkhSEfYWDyw4nKJutn4+7CuIqJp01nkuS1LLvvL1tTLFH/XPXiYyC2KiDmP3lT5YkqzTiBQJ3QaZIkW1cGgqtr4Uc6da7vj+x/rRp0uyqFBUXbbK4/FWgV5fpALU4X8j2RJeJh8dSamqWh0cXd8pyPVe1jrFH5EIfPTW3rr+s6vTbB6h1pvCFdQdrmu/Ygmxj7dLvDG2+doGCr+EYPPgDA354ZZ1yTcTBKaPOAWU1BJjxZr0yWQ+3jQRj3P/O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(366004)(39860400002)(136003)(26005)(44832011)(5660300002)(38100700002)(478600001)(966005)(86362001)(83380400001)(956004)(2616005)(8676002)(66476007)(31686004)(53546011)(66946007)(16576012)(4326008)(2906002)(66556008)(8936002)(31696002)(6486002)(6916009)(36756003)(186003)(316002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REhyNlFvOGpXOFQvQTFDTitKV1hpRExDRVNSUmwwZnFhd2NXUmpRdWJpeko2?=
 =?utf-8?B?Qlh5aUdRL3ArL2RIUEg5OER0dHRlNjNlVmVYMnpBU0RJdUUxY3FlT1BJNTBi?=
 =?utf-8?B?RXUySjhvWHhNbmJsL2g2endGWk1OVkdzS2M3TWcvYytMQ2RyZVZPbDR0dElT?=
 =?utf-8?B?M1FhM0tFbDY4TjJiSVZwLzBCWlZab2REZjdsZjV4T2tXT1I0TjFHYW55MEJy?=
 =?utf-8?B?emdmNXNGQmJ1cEd2ZWNrWUNCTHBCTDJMc1ZNcEFybEVLQnlQSUpkdkFUV1Rk?=
 =?utf-8?B?dDhzWFpYNFE1N2p1MzlOd01mbXIySEQ4dGJ4Q0NlN1JTdHBua1Z5WVVJNTJS?=
 =?utf-8?B?bk8vU3RpdTRtdzBtWU5BRGxqeFlSakJOSUQvS09ZQVZRRUVGTHJlTThzbFZH?=
 =?utf-8?B?d01CaHcrUEZPbEovYWxYd1NFOXhXSjNqQ05CR0tGQ1N2azNHanNEWUNkY0pl?=
 =?utf-8?B?WmVYNlhSODIzWkNaRE1MSUs1a3lRZVNNUzhoYjFha012RDExZ2RYN2sxK2Ji?=
 =?utf-8?B?eFg5bUNSYm1sSjBMbDhMNEhEcitzMEtiTlBKMUt5OWhvajZsQkVVeWg2RmtE?=
 =?utf-8?B?SzhYME1jYlhuRU5FTGNXR1RSbE9UQ25QUlZqRmxMeWZaVHNaTDdXTzBQbTBC?=
 =?utf-8?B?K2pCMnJtTFJvc3VwcUlDcXJUYUxSNmpscVhxN3psY202dCthd1hNbWk1cHRH?=
 =?utf-8?B?SzNFc1dMVHJYemRqSFJVVmhlRjJ0R0N0eXlnTjc0MjZpcFV5YnNQY3RFVjFI?=
 =?utf-8?B?QkZsZHI4blNYTVoyVmJqaXFrd0VFS2l1c0JQcVBoYThMM1RnZXJndVFhUS81?=
 =?utf-8?B?Snd0WS8wUjREQlBOb0daSlRUQTZmLzNEYzlaVHphT3BRMkxhQzlrNFZTbHJE?=
 =?utf-8?B?MWFWOGZZL1Y5WldITDRXSFB2dDJpRVkxeUdBRFA3TVo5cHVnNmQ0ZmE2Qjl4?=
 =?utf-8?B?NVFvdnJCalJMMzE5NytHQloxMXZPRzZBTXpxdEt6eGkyZGl0UWY0dy9TODd2?=
 =?utf-8?B?OVg0K1c2UzllN2lFMzNTQUVZelNwc3F6eUZtYzVMU0lGV0NXbi9vbTNLTlRG?=
 =?utf-8?B?UDlqRXpmNDRETXd2ZkxxNTFxRFlVOWo4VTNFVlppenBHY0cwNHJwcVdUSXd1?=
 =?utf-8?B?VkFuWDlIbWlVUVY3QTFXV0xvRVkybTR6MHBZUjl5bW9HZHg3dGkyRlg0cjYw?=
 =?utf-8?B?MUE5S096aklNb3E0SkY0Q0JFMXJZZkVCMWQyY1pDa2dzZ1lJQjdjQVR6OCt4?=
 =?utf-8?B?aW02ZU5LcHpGL0pBVFliN3o2c1hpVzExMkd5ZGdQSVYzNVNoUHZ4TG1VQkl2?=
 =?utf-8?B?QmIyRkNtcjZYd1dRM0RKU28rclRZT0lndWszT2pXajJBY0dTQi90bHRRb3Ji?=
 =?utf-8?B?dGMvdFVVaU50SzI3WGdoVnUzQWJsMVVlTTVZMGZwSndvSC90OW9IM0F3Y280?=
 =?utf-8?B?c2NSak1ZWWZsTUdZalZxQzdxRUlsazQ2MkVOOGJPSldTYXpKclJaMTA2eTNx?=
 =?utf-8?B?YnRVSDAzMWlVLzByUHR6QUpiODZEVHc5cllUMXJwZEZOTXJTa2lRZXBDeml5?=
 =?utf-8?B?VGR4b1NkQzBqZHBpMlM0MzN6Yk1VMDJzWStpa3drUTVYYTliQ1AxOHJ6RkVS?=
 =?utf-8?B?dlIzQTQxNGV4VU8rTlN3SkVQakJVS2h6N2ZtZGRKb3FhTnZRVjVMSDE4TXJF?=
 =?utf-8?B?ZDBHaDA4UTE5ejlCaTBuaU84VkcvWllHTEJuOWNKNHFLSWVsQytadHkxeit6?=
 =?utf-8?Q?0e3ezpFUu3+YkY7II05Ic/TZzRKJ3WEkALBEH2S?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3b5fea-d0ad-4bf2-9be0-08d96b554cd8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 01:27:15.6875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85CCWX1dZFn26J31OarEXqcfzkklBn5DtperNRaFeyimOQkr6syVl1rBkFeDV8ykEOt7aa+AnF9ZQIe1A0UXGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5234
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10091 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108300006
X-Proofpoint-GUID: HKDfDfMap8SZpJb8WzPviUVMzWZINRZs
X-Proofpoint-ORIG-GUID: HKDfDfMap8SZpJb8WzPviUVMzWZINRZs
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Our open_ctree() took around ~223secs (~3.7mins)

  1) $ 223375750 us |  } /* open_ctree [btrfs] */

Unfortunately, the default trace buffer per CPU (4K) wasn't sufficient
and, the trace-buffer rolled over.
So we still don't know how long we spent in btrfs_read_block_groups().
Sorry for my mistake we should go 1 step at a time and, we have to do
this until we narrow it down to a specific function.

Could you please run with the depth = 2 (instead of 3) and use the time
command prefix. Also, pull a new ftracegraph as I have updated it to
display a proper time output.

$ ftracegraph open_ctree 2 "*:mod:btrfs" "time mount /dev/vg/scratch0 
/btrfs"

Thanks, Anand

On 29/08/2021 17:42, Jingyun He wrote:
> Hi, Anand
> 
> I have attached the file.
> Could you kindly check this?
> 
> Thank you.
> 
> On Sun, Aug 29, 2021 at 7:47 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> On 28/08/2021 19:58, Jingyun He wrote:
>>> Hello, all
>>> I'm new to btrfs, I have a HM-SMR 14TB disk, I have formatted it to
>>> btrfs to store the files.
>>>
>>> When the device is almost full, it needs about 5 mins to mount the device.
>>>
>>> Is it normal? is there any mount option that I can use to reduce the mount time?
>>>
>>
>>
>>    We need to figure out the function taking a longer time (maybe it is
>>    read-block-groups). I have similar reports on the non zoned device
>>    as well (with a few TB full of data). But there is no good data yet
>>    to analyse.
>>
>>    Could you please collect the trace data from the ftracegraph
>>    from here [1] (It needs trace-cmd).
>>
>>    [1] https://github.com/asj/btrfstrace.git
>>
>>    Run it as in the example below:
>>
>>    umount /btrfs;
>>
>>    ./ftracegraph open_ctree 3 "*:mod:btrfs" "mount /dev/vg/scratch0 /btrfs"
>>
>>    cat /tmp/ftracegraph.out
>>
>>
>> Thanks, Anand
>>
>>
>>
>>> Thank you.
>>>
>>

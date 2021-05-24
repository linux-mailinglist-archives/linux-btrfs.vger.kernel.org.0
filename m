Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AE138E8C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 May 2021 16:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhEXOdK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 May 2021 10:33:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41456 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbhEXOdJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 May 2021 10:33:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14OET3sU070182;
        Mon, 24 May 2021 14:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=OjYFp9L/8uEVtNSTTlqp3koudQd1zGjQfwKudkxEjQw=;
 b=T2uA4gkB4vDUzmZaz3sj+97nxUC1jcgpdPXV8zCFcgT5CROuts21lK6OlWw9wD5DGtoD
 hncEoDeGmBvFvz4QyxUxeh9WjD/izF4jJcCZq5Nyvz/qvy6yFogqrADbEC27lxGez0Yi
 E/2yr2elT4YJmbtZpmBYxlrG3JPWe/iPiZioTVxXR1DHn9NOKbNhF64Vtgr9I9baa71A
 NgKyypKtboDNLgmvYUWxy8KAisHQHsVVvf/vWO9BcXm0ZZcCPdBhm8IMlT2EemYX7uGv
 mD/AliPJzTc8K5o75h1Zw5jnH08Pb3aNjmxHOifIEgSXHGbTsdr/00fRfpSz4UrCCFDX KA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 38pswnb7hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 14:31:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14OETvuF048664;
        Mon, 24 May 2021 14:31:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3030.oracle.com with ESMTP id 38pr0b2f1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 14:31:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0eQm4tpvH2uKl1r9BO5jwpdSHeskbNgI7vlRuZmeMXONUB/eU5r51ZipB9/9p0/BosgwQaIgZtGgpS+jL1kWkYKdpHkdpq2UXBOaJMX7+mQ9ooZShGDFctWCUXyLxqprfh1xtw5g553/hJn5+GcASCIyik9N6MH4p69AFWXaY7QUUspeTlsSxWwXGACLH6tn8ozCXQYcW8anKNNm57LMNqzonr/OtQoLy4uNm90mrzaqSyqrY8Va85jhsx7VgCLZQ/6u6MilYvQSM57FdeXenI6VtT4wz7M5k79HdHCgfb6x4LRrZm4hNd1e00PmZsg7IUjDXAY6LRDBEx77088Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjYFp9L/8uEVtNSTTlqp3koudQd1zGjQfwKudkxEjQw=;
 b=TO9OkCw9P/yf8Q8BX8nzhq2+IPaS/tdpf2zoujJtZ/SE+UUAOnj/M8aZ+acw00E+CBPewhUyxWhvHq/hogQbrYfGhinTvkksvSz+GE4R5Zo+/zAKw6tLfKoY92d/T9DRATWuktEhLmSP86oogaOIH/KK/npHX9BdOhmNmgMBH1KQnvNIxIg3P2VEey2nPWUN3pCZrE21RfoaacGyaqUrlj1WspUageXSe5qETof5vJX7TOWZ36HQQwrNL3xAwhdiiT1eF2rczOkC91mrNNsDxoJmpHZSp0/Nq2mgGIxJhJpuG6AiMrICzWSuiPMw0jGN8iC6CWe8b6+zwTz4WYbcDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjYFp9L/8uEVtNSTTlqp3koudQd1zGjQfwKudkxEjQw=;
 b=NJrTF7sNxmQFzc6+6S0L3qcA5kdjJrlLMiizoFGtC7bpj1TfetXWTPvgqgRdKb8soC1pgwDb5QgzSN0tKhH8LdsRY8bN0rWBOcfhSN9umTdyb/7syMfmqCbzgBGkAMMZa/W6/z8VXi+g+2cFUMo8Mi5GyPJ1ONVStyv+toO3lw0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3058.namprd10.prod.outlook.com (2603:10b6:208:31::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Mon, 24 May
 2021 14:31:37 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%9]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 14:31:37 +0000
Subject: Re: [PATCH 0/3] btrfs: fix fsync failure with SQL Server workload
To:     linux-btrfs@vger.kernel.org
References: <cover.1621851896.git.fdmanana@suse.com>
Cc:     fdmanana@kernel.org
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <b299df16-1d4b-8e73-be2d-323feffaa45e@oracle.com>
Date:   Mon, 24 May 2021 22:31:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <cover.1621851896.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SGBP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::28)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SGBP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Mon, 24 May 2021 14:31:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e820f562-5559-4a83-2c95-08d91ec0a336
X-MS-TrafficTypeDiagnostic: BL0PR10MB3058:
X-Microsoft-Antispam-PRVS: <BL0PR10MB30586993C308A7B4E2DA01ECE5269@BL0PR10MB3058.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDTRspMlCkeEzeJM8p+rzkfRAc/Lk1iIrcsdbMxSi8gDTyXurSu3l7j5sj6F6h6wJ1cXvsUNDIklrbjGJLVqjyrHo2/Pugqvcv6RBVXnzv0hHsxVfdPVDMpO3wxW1CP2IU1Ejp1OTIbjYys9Rpoc28hG2C00cQHdQtQbk5KAb+fWNSNZ914nGQL7XPO8HBaNUpbuz4JFkp3xrU+/6omiO9cg8dwrvoCyG5IVpbn8nJ8m4q/lhJllpM6d2CtgA1vUF6SsjsPaYftEue/B7tLTimnT7mUb8RQNAcGG/tS+WegqYcdvlRI2UNwK+zZXSHIeYi20uPT7sDqmnbLnOJRl7QQ6Aa+JwGXuwaP7hhxVqGpZfhLnGwPatxXE42kM85LqeaA7ma+QVawRnKFaCXZVbu9AZ2ISn8hU6BNT33fEsz4E4sZafxaQUygu7GWLQYCzBZXomRr33QbFY2km6ItANNab9qw3MomvRI7R1TQ2m2/YlDJfS9dQ9zlW825pDTQn443+fcj25C9lI/RFODUfb3ZrIvjt3yjck3IiWU1vtoa1M3hDR9pdSbWsObsZ2MtLC8sMn2hF5c0MwzQBd6Xsz3goKAhTq3MR17+ey0WP3iHn3kuyIF1yVzwRy0hlFy54VYAP1vd+tpaqDzwsz6/MQoaqtZdxiLphPpp4yc0xdIFtE1mSMYUaqJhJdgb3LYCxxPGpfUDZ0YGzlcCJmtiRr3JJ7bmNYM5oHrLeUX6UGdYj9Ek/sN5a3oXNH6dtzLGSuHZypJCHkyFiyB909IGOLz0HvfhAGizipkw34pFoxkU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(8676002)(6916009)(966005)(5660300002)(16576012)(31696002)(44832011)(36756003)(316002)(2906002)(26005)(31686004)(86362001)(8936002)(956004)(186003)(66556008)(6486002)(2616005)(66946007)(66476007)(16526019)(45080400002)(83380400001)(478600001)(53546011)(6666004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d0VqcUt2UUptNi9vT01SUExtTFJHWlptVXNia1REYTVtL3E5VGkvMXJRRFJF?=
 =?utf-8?B?MXJ0cHlnaHVrTUw2UEdVRkx5TVRMdUQxRlpPTDYyNFhkZjFSc0p0OVR1RHNI?=
 =?utf-8?B?ZlAwbEVMaTdBR3UxSzcyYkRUME53Q1JkekIwT0xhVE5vUU5xNlFVU0xiT1Bw?=
 =?utf-8?B?ak9ra281M0RkLzZ6cklSREJaSk1MTStYUzIrbDlWVkdSdHBYK0xYMG5BdnVB?=
 =?utf-8?B?b2FRRFRTQmwzWnl3aGFKMDVKNkRjSzlxaWlOMDBFNzlSQ1lERnpvT0U2akVq?=
 =?utf-8?B?TUlKVXFPRU9Xbk1wM3JuVFF3dW9VMnhzWG9nYUlzQys4MWNtS2ZKNDJ1eENP?=
 =?utf-8?B?ZnJjaE90U2FmcElLSmxSV3p2TW5HY0t4WWkxMksyMVJnRVlkYXArWGNwWmpL?=
 =?utf-8?B?UWpkTXo4LzQ3dkV0YmEzK0w5VGtzeExzcHdNbXEvOXI0VWs4YndadjQ4Z2Nv?=
 =?utf-8?B?VFFyNmRFTmVxNHpXRTViSGZBZ0k2U2dPOExmZHhrQ0hQZDVpS2pZSWRuVW9v?=
 =?utf-8?B?YkxTYkk5KzcvWFF6eEhWK3dDbHZTc3Z1WjArcm5sdXBjakpON0YwNjI1TFk2?=
 =?utf-8?B?R0JobjVKZjBxZ0VyMUZBR0ZSdHNReGR6VE1rTHVsRmJrdnc2N3VNZ2lDOWVG?=
 =?utf-8?B?OHFhc085cDY5RUtZbVRJZkpzSXQvUWVqdFpidytTdnEzK0xwSTZyNkRMR1E1?=
 =?utf-8?B?T2U0SlB5MXBxeG1wcXRVNlJiQjdnWlBIRmFYa05QSnBUM3M1amlkNldUb3FE?=
 =?utf-8?B?cXUrV1lwdWd6Y082MWpEc3daVll1NlJaUWd2K29FWlQrYVN3MC9QUmYycXJo?=
 =?utf-8?B?T1AvNlFXWDNIMTFGZ2F0M1RJcmY3MXlwVVlvQ3hnbFV3R2dQckJtZEZYMkJl?=
 =?utf-8?B?NTB1d0MyRFVROFJqWmNEZGhCTEg3SXpFM2thbGdndWRIMFBoT2R1ZHA1ZlVU?=
 =?utf-8?B?WlhKMnhKU3NXWnY5K2VFd21ZaVBjZmxpQVBzODIvUDRNZG4rVmJDVmNJbTNr?=
 =?utf-8?B?bUNleURSNTh2N2xDSjQ2TGI5NDhRaHhVeUxRck0zY3c0ZmplT2pCOGlHdExC?=
 =?utf-8?B?NDJDOFVXeHRvWlQ5Tmo5b1UwcGI5WmFPZDNuNHdTaFpDWlc1RzVyN1E1VVl5?=
 =?utf-8?B?YXpTN2hnbE8wT0RQY0tjZm5RTjFXemZBdkVsNjZ3TXhTNTloMzhFV2hCQk1U?=
 =?utf-8?B?VUc4L2VYVitla050UTlTYmdkY0ordDk3elBpQ2NYd3hZSDBJbTNIT3F3NExw?=
 =?utf-8?B?NVQ5bFRPSG1vLzBZLzBlSzMyU3I5TFA0R3RobmtiR2F6VVRnL0NiMG0zYytk?=
 =?utf-8?B?OURXUWZwdFVUN1pGKzdwRnhYVnFNU0pIQnRFbE5hd3FmalI0SFFyL3oxMnBG?=
 =?utf-8?B?RitNYVIydDlQV2hxOVlSazNCWi9vVnRVZERpb2FFT1M3bW4wVnU0dFYrbFNI?=
 =?utf-8?B?K3M3OFNyV2NEZXdWY2RWbENJSndXOFF1bVl2TEZhY2w2aW1pSHFTVXZDOFU1?=
 =?utf-8?B?K3lWbXh5MytWalJqZXB2K2YzYk9Dc25qdTRBK29iNVNWVEg2S1Z1VVJEdjRG?=
 =?utf-8?B?TjQ2QVVFdWQ5em92SkZKeXlTN2tzbzBNWmQySGYvWEhqTkZqV2pHK1dEeStp?=
 =?utf-8?B?UjRQZnJEQkxZNEhIdk5ZdEw1MjdSbmNmbzQzNWRmMksrQlA2QTMrenMvMjJO?=
 =?utf-8?B?eWU5ckdLQXhsWGZFY243N3BiNUJpTTFRa3p5K3FNMklQWCs4Q3huL0xMdVpW?=
 =?utf-8?Q?Qgp5Jy9G50d52y/fHwrtlukMtpkc4J2q6KdJT8g?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e820f562-5559-4a83-2c95-08d91ec0a336
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 14:31:37.4359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcaMzzgMCubUkLBFESoa+Zp9Qrc6sVNtwBVC1IxfhUurE32aQK728JKDKhdb77pxejNp4RkQPYaIP2/ExmiAWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3058
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9993 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105240092
X-Proofpoint-GUID: N-rSa8pXHiSYRHtvei1l-YD74jxZz9Mv
X-Proofpoint-ORIG-GUID: N-rSa8pXHiSYRHtvei1l-YD74jxZz9Mv
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9993 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105240092
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/5/21 6:35 pm, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This patchset fixes a fsync failure (-EIO) and transaction abort during
> a workload for Microsoft's SQL Server running in a Docker container as
> reported at:
> 
> https://lore.kernel.org/linux-btrfs/93c4600e-5263-5cba-adf0-6f47526e7561@in.tum.de/
> 
> It also adds an optimization for the workload, by removing lots of fsyncs
> that trigger the slow code path and replacing them with ones that use the
> fast path, reducing the workload's runtime by about -12% on my test box.
> 
> Filipe Manana (3):
>    btrfs: fix fsync failure and transaction abort after writes to
>      prealloc extents
>    btrfs: fix misleading and incomplete comment of btrfs_truncate()
>    btrfs: don't set the full sync flag when truncation does not touch
>      extents
> 
>   fs/btrfs/ctree.h            |  2 +-
>   fs/btrfs/file-item.c        | 98 ++++++++++++++++++++++++++++---------
>   fs/btrfs/free-space-cache.c |  2 +-
>   fs/btrfs/inode.c            | 65 +++++++++++++++++-------
>   fs/btrfs/tree-log.c         |  5 +-
>   5 files changed, 128 insertions(+), 44 deletions(-)
> 


Patch 3/3 needs conflict fix on latest misc-next in ctree.h.

Tested-by: Anand Jain <anand.jain@oracle.com>

For the whole series.
Test arch=aarch64 pagesize=64k.

Thanks, Anand

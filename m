Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB2D35A8F6
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Apr 2021 00:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhDIWux (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Apr 2021 18:50:53 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45858 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbhDIWuw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Apr 2021 18:50:52 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139Mnwwk015585;
        Fri, 9 Apr 2021 22:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=S9WtCWpzpOeSpz+TP/J5riwxUif57eB92FGPFwU94T8=;
 b=YDXBghmfrHsDRPACcNdSmramMz9zFFL3h+I8avgSgFdzwyy1lsqhSUoyGDhZVpwEhTgW
 EPjuzuXPLfpTkODyA1HGmqi1qL+c5ADKJ+G/FC3mnLYL+zLNsT6raCweIrzQeRJTL7ZR
 1WtrMyOB0OXVMVQ7Dn6lbYuleDoL0yXv79mRqXS3fB0ntu+laKGhOw/VeD50SX+UTL/x
 CWmxn3zbjlqg+6lWy7NATrMB9Pw412lhpGbs1LNfCECVNbabtojf70oC0w5O7+t8xt4h
 8owxR+M5mIIGtHWl2fITdimx+ApSgcY/l7t0xgYcHdM/QGvNCx51eszWghMHh8dININl Hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37rvawawm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 22:50:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139MjFFJ002339;
        Fri, 9 Apr 2021 22:50:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3020.oracle.com with ESMTP id 37rvb33gf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 22:50:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQ3paJx2aMEHGxQAuj6tOL/2rADlNTbChhQaNqaVhcQeHWJ17vBHJ2YwozX25Pzr1LXyEEkJts3bNMg9DiljP5f2+dw20HWBnWhzZcD9ivfFy1UqWZj5m9HgtADa0UlR045e8V5tqAFnSaqhPkLjeQkOrR+LNykiwldMFMuiXe3VLfPyWxBE2pa4H1VHHYG4j05meGeuB6mahcuB3SrUrOR4rDRivIFxbGOS2osC99Z5ApbtZGEvFYug94qb6INV/gABhHJv5e8ncCWdVmc9lI22MCprGG4gitqZDid482CRC8m6TpccZKHCY/Q4nX+csXbI0st92/2d0PDaK9JAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9WtCWpzpOeSpz+TP/J5riwxUif57eB92FGPFwU94T8=;
 b=BCJJ7TRzts/9vfFLRbmc3iQ1bGfLHol4v/vwkWrn0XzECQfLo5G8u5DT6j2yiUZbd3gAU10A97BkbCrnmQ0+W2ghqHhQ7Z3Q6p5mqgpI0oGbJTtm0g+lp/Zav+t7oIdYjGVAs+MYz6Zt7cN3/RLl3g4Q+Icv9cP2ex/YWoVgAw04bGObuXjbYhXIOYnhShB/cjEtM69MU3oU/N9NGjoUaVTiwTStr9X+2DVljJoMDt1iF2a2menTEgUaagywh0WJ5UolR7dffD7zfqc2xyEUsRQE/0wSxZcvbyV6TT2tsSVSxHq4hMH3DhtZqYUHYCngIh2nqEwYXdirx3H7k+3vnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9WtCWpzpOeSpz+TP/J5riwxUif57eB92FGPFwU94T8=;
 b=kMubi1DvyAADRk5u54d4HrUgnyttnmiw+PjOpgw1QEFwws5ZaZ+KgxXVjvabkxc6F3TqDzT94XNzEljRbgCD7jyPYIITIz9ig/daNH+Or3v9PvhS9uomD4/oCoitg2D4GLbTmEcDI1ZrDpRYCPMPPlG0M7bqhdofyWAWGq8wiv4=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4365.namprd10.prod.outlook.com (2603:10b6:208:199::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20; Fri, 9 Apr
 2021 22:50:23 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076%6]) with mapi id 15.20.3977.033; Fri, 9 Apr 2021
 22:50:23 +0000
Subject: Re: [PATCH] btrfs-progs: Correct check_running_fs_exclop() return
 value
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Dave Sterba <DSterba@suse.com>
References: <20210409155644.qkk6puelfjvtjwqs@fiona>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <7efdb3f8-ff4e-48a1-158c-863629bcb6b6@oracle.com>
Date:   Sat, 10 Apr 2021 06:50:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <20210409155644.qkk6puelfjvtjwqs@fiona>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:a0be:f172:361f:c3ba]
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:a0be:f172:361f:c3ba] (2406:3003:2006:2288:a0be:f172:361f:c3ba) by SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.4 via Frontend Transport; Fri, 9 Apr 2021 22:50:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d961baaa-8d5d-400a-b488-08d8fba9dbd1
X-MS-TrafficTypeDiagnostic: MN2PR10MB4365:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4365F9708D4EE08849713D03E5739@MN2PR10MB4365.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: som2178PTj75Lsfs3rAfXqb3htZ+insBY0WBAe30eviu19lzPXv/yEwm4wbi1KD//wgc1FGGypZAra8ugQvFg7oNTKIjPcGYQS9TcM88rC2reWJ7gF5C5i34A0fzRy+xqCwE0D6gaEdkAJD45XbnMsfHW3LUJWAqiG31cXK+xC/te79/msK2Kptfy0yc8OeEx6BTMmRnUfjX3abZsK1chUoGH+TSJewYIfvg1j1EIoyCvfm2XDGiYJRBBgX5FXeLQ4/67LInpJVSCFSQumHkROJMByrtvXwVbmGVyd+UMf9FwHOUO5sG5x2bbQ8+jmW7OnqH3/u/EREXrnTYLNIM0DRtHHtttECBJJkgF9wnvsjqKnl+HgBd9Vp47BJxDSXdVQvVP48dX19q+5WainrsOL/89jJZoY608hVpBN6ZHA3E6nsNicc/rPbr7HxznJC4H55+t2oXu0PwCfTofKgfoe/3TBw0FDcXcHlfzToklZlkX7fBbpFP7ZVmv17n58BQXje9Qsrwrb29D0/18MhLkhDOhg2Zf0wScWilTjA5E/1yaX1EhyHOk3tn3hlgwiMrSrjLqp8Xt7cMFnFqp+kUlVr3EBNuTON96v/VoVgwTUl1iCEXTF5Wsl2bZqoJM3FpJGidq2bqOq4drgsuQk32vjXvq49Hgt7DT7a+eEWseu7HKAkjclTSohXFq+SOvLflkaGNT1hkSxcUrD7MRGPrgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(39860400002)(396003)(366004)(6486002)(478600001)(2616005)(6666004)(31686004)(53546011)(66556008)(5660300002)(44832011)(31696002)(66476007)(8936002)(66946007)(4326008)(16526019)(186003)(86362001)(38100700001)(2906002)(316002)(36756003)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VnRFT2FOVUZsWm5TZzVTRXBHcUVWTXNLZC9aS25ia0ZHalpCcGExZVcxNjlq?=
 =?utf-8?B?UjdsRG1TM3U3RkxpcHhCTG5JdFMwaTBjczR5WGRpdlNrd2RVS0Q0UHBPZXhX?=
 =?utf-8?B?YWJCVkU3aDR3ZlpVUlRCZER0VHkzdGRNTS9nTUszK1JUNkpWeGNkMklURjhz?=
 =?utf-8?B?aXJKUjNTTnRBdTYyRXRnelNFVHVadGczSVVvbGp6QURLTjY1QVFGNjJpcEVv?=
 =?utf-8?B?a3pWd3Z5eHFSa3NlUUp1eTVPU2s1Q2Z6NDhKZlNGQ3ppZGxLUUY5aU53NDZJ?=
 =?utf-8?B?VUtvYjIwQlBldUI5R2RnUnFpeS9DRUhrSTk5MFVIbFpsVkxmTHNFdXFTOHZN?=
 =?utf-8?B?VC9BRFMwRDNqajJQSUtSQnY3TVUwLzBJNzh6dmVxUzBJOExrZVZMV0lrWk9y?=
 =?utf-8?B?eXdNdzBqd3ZZblVIb05QZFdyWmZqTzMyc2crRGZMcUs0QzVNQ2kzandITk9G?=
 =?utf-8?B?RkRQaUN0elg1NHBVR1ZiTEtnWnJNbmsxNkovbDVETVJqL3NYUUhTcTVLaUw1?=
 =?utf-8?B?YUF2SUxWQ1RZYWRQNDNjUEIwS280SVVuK296dWZuSHVkNTYyWUNkSFZtVEpl?=
 =?utf-8?B?dVdyZGtnVzRwcE52ekEwUGY2S2ExV0RwVmx2V2lRNmo4ZHFCLzhJdndlZm9Y?=
 =?utf-8?B?RDhwQkdqN3UvUC90VUtEYjJEdXVsdjFuNUNqTGlwV3libVBGN3p1ZWNpejRH?=
 =?utf-8?B?YVIxd2o3VUxhM0V4MmJYUnVnNFhGS1pYWk9sOVhMUlNsWldRdUJvdXJ0ZHRJ?=
 =?utf-8?B?RE81VEN2V2VqbHNvRzVNV2NlWmYzbG4wZllvMGlDanExS1ZJQmgreGRKUURE?=
 =?utf-8?B?MXMxcGlCb1lIM21FSE94TFBxQUZWTDl2akFudnRQMlJsNmljdVhqNmpwTkZM?=
 =?utf-8?B?MVBsQWxjVTgxQkNmdjJkVGR5Um41bFV1djJ3RGt3YmgwRDRxU3ErK1ZOS3pX?=
 =?utf-8?B?aVV0OU1jVFcxcTRDdGlUZUFhOE4rTDVLMVhhNEVxMWZGTmN4MC9RT3hHM3BU?=
 =?utf-8?B?UDlqcmJwS0FaalpEUFg2NUVlcDNpS1VOemNjdmxsaEVrVEppbDhqZmhkam5K?=
 =?utf-8?B?QzZIc1MzVERGbEdIT3VaN29FOGVlWXJQZXEvV3JDTnJuV0RjK2ViY3dWalpU?=
 =?utf-8?B?N2lIdFd2TExzeE9UT1Vvb1hrVHNjSk9NNGpvWTZ4Y2d5aWpqUnlxbi9ncXBN?=
 =?utf-8?B?VldIZURNYmYzN2NBQzJDcWtCb2w4dGIxM1U1RjM0azhVY280MVp0bXhHZXJL?=
 =?utf-8?B?S0g4VW9kZUVVWUR0YStXR0xqbGpCYmFYZk41bXhTMlZ2N2IwTENKRmpBUUR5?=
 =?utf-8?B?V0VHOTQ0Z2VHV1FBaTZoRjRoYlBJMFJDVXZ6RytabkVzc0VWaG5GVjl4UnQ1?=
 =?utf-8?B?aVJpOHlnNCs1OVJBajU0SVcxaFo1Z1k2b1N0M1Q2SnozZmdBMCs0WFpMQ2pF?=
 =?utf-8?B?VFQ3N25qOWhDZ0szZmt4QnRTTUk0UTkwRXdpcUxhMWxwZDhzMnhMVjlvYktM?=
 =?utf-8?B?QmJDWFhrMWhtTGhqdGYwZ3RNa3lqZVgxb29za3B1NTFLSjVPTHVDVGk2eUV4?=
 =?utf-8?B?VWtCd3h1SFlFQmFZRWpNenZOL25sTzZGd0N5Z3FqbmJaajBjZUxoMUQ1eDlG?=
 =?utf-8?B?bGR3T25CTkdsOVcvUGF3d2N3RVhHdzhmQzNuRWhDOFRBL0NSak5sK20vemI5?=
 =?utf-8?B?QWtQTE5UbEdlWm85a1hOdEhIMmhiM3lhUjErYUlhS3RyakpqOGFaTXdLZ1hK?=
 =?utf-8?B?ZHd1N3Y4NXRiMUhQSTY4bjN4czNyVDVWZXZ3R3ZrTHJINE44SS9MY2N4Mjlp?=
 =?utf-8?B?VCtHU2lucUswaVdLK29YeVRZWXRPcXhLRUVudlpaR1VyMk80bHovd2tZTDln?=
 =?utf-8?Q?4JukGRwtLwvxQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d961baaa-8d5d-400a-b488-08d8fba9dbd1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 22:50:23.1064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBisG2bHUbZ5fRoWPJ8wtLzQrWL2/oPzfyObHyOT71vlgxeiiDxRNriEXDLkKkY/oEHNXdMmi7qv+RE/kws1XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4365
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090166
X-Proofpoint-ORIG-GUID: W6soVxQ541KEs1FqequPcNWIUa3WBLcl
X-Proofpoint-GUID: W6soVxQ541KEs1FqequPcNWIUa3WBLcl
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090167
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09/04/2021 23:56, Goldwyn Rodrigues wrote:
> check_running_fs_exclop() can return 1 when exclop is changed to "none"
> The ret is set by the return value of the select() operation. Checking
> the exclusive op changes just the exclop variable while ret is still
> set to 1.
> 
> Set ret exclusively if exclop is set to BTRFS_EXCL_NONE.
> ---

SOB missing.

>   common/utils.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/common/utils.c b/common/utils.c
> index 57e41432..2e5175c3 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -2326,6 +2326,8 @@ int check_running_fs_exclop(int fd, enum exclusive_operation start, bool enqueue
>   			tv.tv_sec /= 2;
>   			ret = select(sysfs_fd + 1, NULL, NULL, &fds, &tv);
>   			exclop = get_fs_exclop(fd);
> +			if (exclop == BTRFS_EXCL_NONE)
> +				ret = 0;
>   			continue;
>   		}
>   	}
> 


This is bit inconsistent from what is done a few lines above:

         exclop = get_fs_exclop(fd);
         if (exclop <= 0) {
                 ret = 0;
                 goto out;
         }

We return 0 for both BTRFS_EXCLOP_NONE || BTRFS_EXCLOP_UNKNOWN.

Thanks, Anand

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983AB355FD1
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 01:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344865AbhDGAAB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 20:00:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51508 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbhDGAAB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Apr 2021 20:00:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136Nt4Sk135803;
        Tue, 6 Apr 2021 23:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=KvlfS84dMfmo61NcqPbsxPA/0wa6imfjhhmGXLpNAts=;
 b=TpjPA8r3B9I6z2fzwuNIWAScvRM9yi5nRGc4pbyU74Pv9jDu8L6VcTo7aFmdxGewLzVm
 Lw1ji2f64dZLyVEJ78spqYno1fMOd4w4pFVqHvx1IB059HPC2sOyHRdgW+Lwurksz3KP
 4vc/LX4CsnyI+lgDkyns7altIkeLyLwjBcCmq9ZYNQu4ambAokGQjk5Hs+XMQJFG7fJl
 JXeJuaI3ApM+HxWxzsNR5w0OH5DhSLK47PMtJZuHhheo6axgVxSiLlYUXayCfxycezBT
 InLjNENL0NN5ie4gANH31qbGBxWWTPpTHj67CVIbdcu8ehWksClnMMyI4heuSAlJQx9W 7g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37rva60st1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 23:59:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136NtGBI029531;
        Tue, 6 Apr 2021 23:59:40 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2053.outbound.protection.outlook.com [104.47.46.53])
        by aserp3020.oracle.com with ESMTP id 37rvb3238d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 23:59:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn/jqu2QQScp/fG24SHciLP23LfXO/myYhfzMojsfWVCBDnXZ70GFiVZ1hhb2Gyr2TQRBbvxQAEZoFJ62nAZTY9e2qUr6XW2KFJLMH2n8ZZdQjjgBDC60SqXGSVOor8WBBVb+K3FqMFVUP5tqfgS/o8mVVjiKwLo9YFBApF3Vp+UiKsQfKMXF4KWFrbKsMr9/tO1qEhQIvI3x75iNFxD9cO2bintrj3xG1fY0ry21sNT3eiF+Xu2lR05Jwn6TdYSHGkHmlCKyOfp78SobVo87vZj1VG6lWGe639N6VIk0+ZvoEpIeLc5x0wdvdlIIMftY0V5FHvR0KtVai+KKrOkJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvlfS84dMfmo61NcqPbsxPA/0wa6imfjhhmGXLpNAts=;
 b=gEiX/GzNVkieEU2FKi+c+A85SwMRu4dRqyqPpUZl7B6nJsTCG/1CC2JrAMmX1svNYyfusPC0OslHlpccxspIAtaU1fj8KknaNIgz6qyTQqqe5R90znx95WbhMKsOOu9RvB8lX9o84NZnoOHmp7VDIZ+nc0RGo4+jl8z5c2+7vYAFtq++d4/9Nz95p4TfGmrVbpFf0vTThWL+kxp7F0zZAHEUDk7BNMEoTZBXDDE7JYEfZ6dUGRElRF2lpik55OM3ErfFc+VdtNTYCJGvcA8DvEw7wiEbck2VV2k7orOhuUvDHYQUD4l+oMHjAsnySVHJsUlHFaj2TVf7NL8HwT887A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvlfS84dMfmo61NcqPbsxPA/0wa6imfjhhmGXLpNAts=;
 b=A5N76JpJ/MZ7L5udSwMhYSVc1JhWXlWqiqvmpqJnPeoiNm8lz5wCWPb2Desz076vsGbSAZYBMLUGX5VclPxl/rua2ej1sQK4MbXTwoPk2TIjipLePwrWjSXCC9h7FVe3z9p98a1CPADtTFVUIqzNTPHLNtx+yo7OpJpKCoojaUM=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2994.namprd10.prod.outlook.com (2603:10b6:208:72::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 23:59:38 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076%6]) with mapi id 15.20.3977.033; Tue, 6 Apr 2021
 23:59:38 +0000
Subject: Re: [PATCH 1/2] btrfs: Remove unused function btrfs_reada_detach()
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20210406162404.11746-1-rgoldwyn@suse.de>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <2bce898b-bb2b-cedb-1b09-cecd48b5e73d@oracle.com>
Date:   Wed, 7 Apr 2021 07:59:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210406162404.11746-1-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:e825:e63d:5d8c:fbe6]
X-ClientProxiedBy: SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) To
 MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:e825:e63d:5d8c:fbe6] (2406:3003:2006:2288:e825:e63d:5d8c:fbe6) by SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.3 via Frontend Transport; Tue, 6 Apr 2021 23:59:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e9a17b4-6009-4126-7d5d-08d8f9580957
X-MS-TrafficTypeDiagnostic: BL0PR10MB2994:
X-Microsoft-Antispam-PRVS: <BL0PR10MB29946FD2DFE21114BA7DB288E5769@BL0PR10MB2994.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3aqaeLabE65YMDGWxNYxDFDFQn7OwkJMBN0srq/KIUlVQj38L6URlO7sBfe+0jJH1oeguW50B+0KGU04sI30GYhEHuXsnc0kMfmuXEMHbMu+TfSGkv/2xYq8X9GgoQurX1xVzd7YI6lzzA8vd8G14IvftSxUCr3VoVN7l54quNhGMUJzWC+unK7l/G+yLNz3m33O1Nd1nYriBhrPTIGAnhIp5JHDyNK1XenRHtUMYoAg0oaNt3WJ+uCRYw5WGKeCcLQXnFLXahtgJG5tzi1GO0oNuJPaE2fjRcW1LxxK/zMefglJJv3iLTrmjesTTXEycpz7UAqYFfI3lrEorNHHclzbMfOtjLod5+SJFaBIP98MYVVOiCcREd8h8uqUnaAnovqFD4lns9kK6tkqEmosmWxOoO1BYbx8CoKHwjhFrrON0Qux2XgFqB9YwaISJmy0Pa7fs9qnP+TK1NlMXnBZ5IIZZBfNzly/aSsm8ArFK6b4GnD0/nXCPtSn4YW6vvxN0eYjEUoQRZY/lY5oS0U134Xwspyt2+Xsrgkhec7YXeHb1NVsEKO5H/ps7XxkdjULla5AMfMeupY3lEark/D4DIdlELn/KloznNiGoWHWdpjfYkQ4/rPLDITyuJuVambApO+pmm/Sfcb6jNsJeVOc565dwMECU96EFPe+WvUNRS18fqFpD5KiqKiBJM41Cq7ZD6SAawKkTdxDw1XFzGc8RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(39860400002)(376002)(136003)(86362001)(31696002)(53546011)(316002)(83380400001)(38100700001)(6666004)(16526019)(36756003)(186003)(44832011)(4326008)(2906002)(5660300002)(31686004)(478600001)(8936002)(66556008)(66476007)(8676002)(2616005)(66946007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WjRwcVBDR1JYSE5IVnppaDFkYWcxTkFMNGM5NGdRMExiYXZ5REZBaFVGY0pQ?=
 =?utf-8?B?ZTlKVlhiMjVKSC93Y3d3UlBaaW9NUU9SMVFGYWF3VmVuNVdzUnBFRlVRdWEy?=
 =?utf-8?B?TXcvTkpyVGgxaytWT3hEUzNuQXZjVGY2Y2hWYUpRUXJyNi9iQnBoMENMSnd1?=
 =?utf-8?B?M21IZTRyaXo2Sjd1Z3VXTGpTTXc5cFd3RCtvRFI2WjVKd1FsZHUwN0J4MTZm?=
 =?utf-8?B?eXloL2NsMW0vcVhua3loMWVrdkI3WElIUEQvZWMrRVh6czAvY1UveGoxRzNB?=
 =?utf-8?B?YmczMVB5Y3VFQ1hiNEFxeCtGWTNoLzNUV2cwQ2s2QndLM2J6eUVxNUlhdDRP?=
 =?utf-8?B?MldncXRFWGoxVTJLUVFQaG40YWsrWnBiSGlXZFh5VG85MlNNejBJdXY3NVpP?=
 =?utf-8?B?M1lEZXFlbWgwbzRra2hZVHdvNlR0WDEzRHNqL3dqYUdKV2JkL3dDQU1jUGR6?=
 =?utf-8?B?bER4dnp0Rnc1MGpNUEF1d01MZWtPRUo1cGVPd0haZTlqbFdXOWdmWlg0SVRa?=
 =?utf-8?B?SEtBZUV2T0F6Ui9uUXVsWithd0QyZUdYVWhzVkhFRjZiK0JPaWFQK3UralRV?=
 =?utf-8?B?dnY3T2MrSnlZaW5ZNUNpKzdYUjQxRjYzbHhHeDZTMHpXay9XbFk5ZkVOdmxK?=
 =?utf-8?B?a2NjZlZXc3dDNDZqZ2x1L296SGx2SFVrVHVrTUNXZWx5aGFJcUg2VXNuRU4v?=
 =?utf-8?B?bTl5aDYvYkNseXIvY2QybGx2UXdhZTREcHN5S3V4azI5SHBXTGxzaEo2RDFR?=
 =?utf-8?B?NzlDL3ZvTzRlTS9rKzhSanE3WkM0czBBa1NQTTJ6UnlDVkkrS2JTYWZIS3hy?=
 =?utf-8?B?azF3VUVnOWdVY1U5QW41bVk5aDlSdVg1cEM2UGVHTTd4L3NNUytDN0dFWmhr?=
 =?utf-8?B?YVFJOTlrSUpieEE2M0s4eDJ2QlpqMlNPQVJXQlpNVTY2WHMrMENJNE0yZzg1?=
 =?utf-8?B?M2VVUUZSbUd3RFZTbEQyRDA3VUFJK3lYZUxFeVdiOWI5SHJjeVc1MjBkS0xH?=
 =?utf-8?B?MjJlRk1nZEJnRStmTlFCMTI5TktSamxzVnI3V2ZiVit2SzFBaUZVWWZiaGdQ?=
 =?utf-8?B?R3lPbjNxRVhHbWRyeGFSdS80cEhNelp3MEp2cWtzL0dHQllJVi9MMTkvVmlT?=
 =?utf-8?B?MFRVRHlaZjVWSmcvZ0Q3cWxaaDhlcWFKa01JQWtRdi8wQ3ZWTHRDT0o0SHhx?=
 =?utf-8?B?eXE0ZGhQVmJzZEJHbDJ3R3pxOUE3RFBQMDRiK2hiRnpBM2tqQXN1K28vWTBy?=
 =?utf-8?B?YjF5VFlFcFJUWXppUlo5WTUvSWtNeEJHL29BZEpKdnEyamZsL1dYVGYxWlFH?=
 =?utf-8?B?U21zYmt4enRzRnM4NUxKZ2FEaDZ0MnF0MW11ZGprRVF2WS91MjBnWkJmMTNV?=
 =?utf-8?B?L2pQamdTM05sZUtvOERQOFZvdnQxNDBFRFQvOUZQUTArMmNxMjYraEQvWUQr?=
 =?utf-8?B?L1RCeWdlZ1lBc1QzK3VPb3dQdzhTSWFJVnZRSHZRdEhmWnRUR0VDa2IyRHJI?=
 =?utf-8?B?M0hiOVNZendNL3lxbEJlS1dOa3hPUlVpWWh1QUI4NEZNYUgyZVhIc2FiSDdk?=
 =?utf-8?B?ajc0azhORXZVZTVBMzhMdEZBQkdmbFpPcjlBQ2s0R2xFMzVvRVIzd1ZOempE?=
 =?utf-8?B?dkthWEtybjVuVEtWTnk3MldJc3Y2SGtmUmNoVER0SUYzajVNaW9GY1g3OUxs?=
 =?utf-8?B?Zk5ZYUJwOHorUjI4VFNVVUs2YVBKTUZVZUVLUUNJcmVpYW5SdDkwWXRRVWpu?=
 =?utf-8?B?YXBpTzdreDNQci9kSkduUitoTFk0T3F1VFdPYndLMVpuL09vSlFCcVpVbXlH?=
 =?utf-8?B?Q3I0ajFCK1NjMmRjWGtKbXZ5elU1c0VQZmVoS1ZEYnM1Y1lVU3FIcU9SUC9W?=
 =?utf-8?Q?5eGbsM9oAIptp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9a17b4-6009-4126-7d5d-08d8f9580957
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 23:59:38.6711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TC2U+IY3leTJ/aCTktRZJAynYtgipI0SnLPF65odn6dED0BhncPNf3+bAHQcrgiYR2+lTBF/ecZWauNXdelLyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2994
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104060165
X-Proofpoint-GUID: wdv3fomBq6A4LiNMbtNruKuGG3RxBrDm
X-Proofpoint-ORIG-GUID: wdv3fomBq6A4LiNMbtNruKuGG3RxBrDm
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104060165
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/04/2021 00:24, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> btrfs_reada_detach() is not called by any function. Remove.
> 

  btrfs_reada_detach() was never used.

  commit 48a3b6366f69 (btrfs: make static code static & remove dead code)
  spared it.

  IMO ok to remove btrfs_reada_detach().

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>   fs/btrfs/ctree.h | 1 -
>   fs/btrfs/reada.c | 9 +--------
>   2 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index f2fd73e58ee6..2acbd8919611 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3700,7 +3700,6 @@ struct reada_control {
>   struct reada_control *btrfs_reada_add(struct btrfs_root *root,
>   			      struct btrfs_key *start, struct btrfs_key *end);
>   int btrfs_reada_wait(void *handle);
> -void btrfs_reada_detach(void *handle);
>   int btree_readahead_hook(struct extent_buffer *eb, int err);
>   void btrfs_reada_remove_dev(struct btrfs_device *dev);
>   void btrfs_reada_undo_remove_dev(struct btrfs_device *dev);
> diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
> index 06713a8fe26b..0d357f8b65bc 100644
> --- a/fs/btrfs/reada.c
> +++ b/fs/btrfs/reada.c
> @@ -24,7 +24,7 @@
>    * To trigger a readahead, btrfs_reada_add must be called. It will start
>    * a read ahead for the given range [start, end) on tree root. The returned
>    * handle can either be used to wait on the readahead to finish
> - * (btrfs_reada_wait), or to send it to the background (btrfs_reada_detach).
> + * (btrfs_reada_wait).
>    *
>    * The read ahead works as follows:
>    * On btrfs_reada_add, the root of the tree is inserted into a radix_tree.
> @@ -1036,13 +1036,6 @@ int btrfs_reada_wait(void *handle)
>   }
>   #endif
>   
> -void btrfs_reada_detach(void *handle)
> -{
> -	struct reada_control *rc = handle;
> -
> -	kref_put(&rc->refcnt, reada_control_release);
> -}
> -
>   /*
>    * Before removing a device (device replace or device remove ioctls), call this
>    * function to wait for all existing readahead requests on the device and to
> 


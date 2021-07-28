Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3513D870E
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 07:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhG1FMf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 01:12:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7356 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229752AbhG1FMd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 01:12:33 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16S5C9Wf023760;
        Wed, 28 Jul 2021 05:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=20DkoaUtK2yJlOsmt6Ls//BGQ1KD/e1bvY+58c7gKeU=;
 b=mW3HsP0Ve75YaFmAKQWXmiPesvXcWaPhtzrPfK30rckMpylaku9vUegJivf3GeM9owLW
 zsZiyNpNcEh75R7P/mfWAEg4lQjZ/cmbpSeIKyGteb7ZIl1piruZPAikC1/GShQ8cp2D
 GVy124JGwKu5KHGfjK/J7TfQNyMIc40fQ1r74eyh4Y0RDi66VAi41Xrot4Rf4lo2SaT+
 VSJMXt4swBD1/ZXIm1MMdl7ZXgXMV8TYiDh4fzLS8/ZtJzyNAzwHVZJex2bymvo7Hfbj
 gk7LXd5W01faxlDzS3bFPfmM5NtLrILZPIsZrlRrXUAU8RMXhM1XQy3cYTo0yf93rdov Wg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=20DkoaUtK2yJlOsmt6Ls//BGQ1KD/e1bvY+58c7gKeU=;
 b=AiCj06HQWmqn7Khp7pT8thLzN+FLWzACXo0Q2/LNJ2toOJmAlV7m5mcPmO2gz0ldhqLQ
 x9Ntq2oL92RDtxLTyfp/XjbhuwGNS66/LUwUp82Nfwi6fiL0kRum4scwRpZcuQHiU1vZ
 uBnWnZAhB/yBIRVIIJU0zWX/SSNnMdZXbhFm9mLpmRdnFDafPy2i1lA5XhWptpQtdWdw
 o7M/wBK0Krqr3f6LjHlZDachq4iBjYZRpeH14I69s2bTCWb8IRX1Xij0wufubMSPftzH
 4tSR42V02G6Mc1Ga6WvUcMJGuYioAxgwtpydo6Bv3DSqLIwOhKAO8biSgym8tHHtVALX sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a2358beqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 05:12:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16S59jde186595;
        Wed, 28 Jul 2021 05:12:24 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by aserp3030.oracle.com with ESMTP id 3a234bq29q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 05:12:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D90yx9WpDUL9/kO7bRtpk3Bq6Ycexyg4fKgRoFrTYFgwzE+CXQSZ58JUk0kMWLxIuH11uJNoa2NKmLxmKh2LdEasj3124qIaWTCKObtvkL2gSEHWsJ79nzZBEurL6is6SFM1Ddexp41/cCIBTp5PTBookkfl/y0nPX4bioXqCyCe0giUN8p3gbq8YiOw0pCpKZsDnufQAUXS6P6iVAW+lMNKl9K5G9RXyf+Vo98r1VkMKh7IKRBmOuNQ87TOAymaH99PfJKheiddgFiuPubAa+Djw6Vs1yv04Wm5OCBrGaAf84kqTyojYPxWLm/x6WtyrlRNa8EVFDaw7y+QOXY/IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20DkoaUtK2yJlOsmt6Ls//BGQ1KD/e1bvY+58c7gKeU=;
 b=dPDzJIxKDOz1rWyomTMC+nIy9aFUP+JLlIsX3arytpCh6L//MmawjLmrttDVfkYCDOHUVZWqTEBaF4e19ESWrzSwPKFhpkd/zHd5jsOto9lmoeF8BBKwggSn8kOo1XA/QNlDriGEv0AotGAudI8Z/AZKEXePzGJZ1B2RdhAr+C7Z4qgO9VLRORFZe1NgzjPvdl87PaZSy/F0Qja1IcoyohoI3zQjtrGgPlps36rCKKzTTzDBOJwf1Xn3wJJTeURm0t+1FbiJp3Bs8gcjUqTjsE9ql19ooxW0RwXNq9uwOEAbtwWGaECdwfz03qGVkp+oPFNOd0ywZydQO/J0MPUnXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20DkoaUtK2yJlOsmt6Ls//BGQ1KD/e1bvY+58c7gKeU=;
 b=mn24VIfmLq2r/bWqw5yVfxSeG12Ul8VDtWTcDwOtbGwggTtSVMn5lKfQIAc4gREDYqNSLhV/iB3IG5SB8F61WyiSHkjgAELWI9ilqgrzylJ2tSCSWe/tyqQLqP1A52xr4JLstIvVfuvzOwWo5GX23HEoqRUVOQ+8vkfPwYPN27k=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2820.namprd10.prod.outlook.com (2603:10b6:208:75::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 28 Jul
 2021 05:12:05 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4373.019; Wed, 28 Jul 2021
 05:12:05 +0000
Subject: Re: [PATCH 1/7] btrfs: Allocate walk_control on stack
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <cover.1627418762.git.rgoldwyn@suse.com>
 <381dc8c84c07b4eecc8b5de6686d79ad5c60ae58.1627418762.git.rgoldwyn@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <1700290b-4735-67aa-c98d-3427689e8774@oracle.com>
Date:   Wed, 28 Jul 2021 13:11:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <381dc8c84c07b4eecc8b5de6686d79ad5c60ae58.1627418762.git.rgoldwyn@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR01CA0112.apcprd01.prod.exchangelabs.com (2603:1096:4:40::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 05:12:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0153feda-a721-4254-42b4-08d951863dac
X-MS-TrafficTypeDiagnostic: BL0PR10MB2820:
X-Microsoft-Antispam-PRVS: <BL0PR10MB2820AAB8509AC4F3589CE038E5EA9@BL0PR10MB2820.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUjn+QYg+Qi0SCLkfdjUPhy1bN3C44RTPJdti7IpJflw4olNj4cqLurC2u/snOLIePSU3941K2B+5BxKHmEB2QaBGe64kuJHO6CTRlxWt/u0rdoR+oLAOqN7rSs36ArQUllNgpsDnVoxEetErMFckZTHfy0m8fAPe2VPzoN1CFPCZit/jl1jLoL/WjUx7HUBavORxwz/zWI/2dMCI9w2ERRvfp8biavvpW/tm4b55yh4Ln5t9tjKHOl5dLuDHHQGdr8LBgmQ4Lr1cER2aQ/DS8gbh6LUcK8gsn5OFU4UiQH7cHHFTAmKVy6XP1ZLH7THJi7aA5VoTYLRvmcsFJgiJ04lYXLz06lF8RRxYMjAqEHkbxwkIiIUSQzeiZsvCypHcSMXzwuMh/oB5O9syS+aErW1xuV0qGIbVJGxODwoe5nXxN7GxwslNp+nTScnG/w8Q1kR7GopSrQh+uPV3FRR4bDhLhlZqY81LTDaayDXK5WDsESaiiJTJ59roKJHyrbmaRrkN993r1dmhpCyjfwXepDwP0Y98Lm12syqqEwRQ+gXxseOBKpRh+grZBLDlDENcPtbJtYlx7fpg8Z0ZYelkv/inBgeCVhYyiVDxiq6oI/vklp7jJhM+ZiGVNXSoMVWqQwcPkeMhqrD/A1VqQvCF5/UohBTAvJtuWgvTUxKFpvBWG+Xj0+Yef4dLvVowZ/avx7tDMRtkFol8686w7kKgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(376002)(136003)(366004)(53546011)(16576012)(8676002)(5660300002)(83380400001)(478600001)(26005)(86362001)(31696002)(2906002)(4326008)(8936002)(6486002)(44832011)(36756003)(31686004)(6666004)(186003)(66476007)(66556008)(956004)(66946007)(316002)(38100700002)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3QzMlJTdTFrN0pyeHp2b2FoS3BUSWZGWE5jZDRLd2l6cFFFNU9mQ3J1dmhE?=
 =?utf-8?B?VUNGalBxYUt6Z1BnWDh6cmI2Ri8waHAza3pQVGk1YUkwdVk5bjFvdFE4d09J?=
 =?utf-8?B?MzYzMGJxY0RVZ3YyV2ZxcjUrN2hockdoT3NwWUhWTGI5NDVKSXBSc25rOU14?=
 =?utf-8?B?bndpMnpMT0JYUWtBTlRBRjhiVGpZa3lDLzltTUVYZmhxU28yVW54bFVwengx?=
 =?utf-8?B?dVdQSDVoSmhZbjNYdlFwTlN4NHc5TEZYdUlXY0JMVjUraXJlQ3p6eDd6enVG?=
 =?utf-8?B?cXRFRlI1Sk9jQWlPSWVIakE5ekQ5cjB5Sk1oREo1SmcxT1NvemtsWWs0YkhT?=
 =?utf-8?B?VldLbisyc3lkVWpVdW5mVkNuTGxsdFlGVnhkOFRhRGJCeVdhZmVObmNGUW9J?=
 =?utf-8?B?KzFYZllleHYrRFVvZnlJUkoxL2FPQ0FZbXpqbmZNVUJMT2MwNnNWQ1hjdW82?=
 =?utf-8?B?aFN6K3NLOEZDTHBpdm1QNTdhNEZJaDQxdnBhYXBaV2gyYzBOY1hYWXNjVzgx?=
 =?utf-8?B?a25QRGxqZ3puVjZsazJraHIzRndjREdpUzdzRnloL3hiU3cwZzlZWlZHaGEv?=
 =?utf-8?B?ZUs5bUUvTGoraGQ5em1lN2ZwUGtUVE9iNWJjOGZxcExYb1I4QnNNUDN3dnJZ?=
 =?utf-8?B?eVUwT2lubmZZSFByVUlPSmpDWnYxcmxwMitHYkxGQzhiZzhSV212OFdUUldS?=
 =?utf-8?B?bFhnMGFBd25lVmlJa3E3dkduUVExcE5ETE9iL3hRbWtQSnhISHRjaldpTStS?=
 =?utf-8?B?VDFuMWs5bTRRZWF1M0lIOXdMY01pM3Awbnl2eG91V3ZHY3VPYjRPTmFaTnRV?=
 =?utf-8?B?azduMnovQ3BUekxZc2VFWHczNjVZd2ZkR3Q0aE52THNYaWVtTk9WazkyZFo1?=
 =?utf-8?B?b3NGV1ZtZ2NPZkRzc2FHZ3ExSVE3WUtyUFUwZHBSaGRTcXZTd2hKSnpzYnQ1?=
 =?utf-8?B?TGFxM1JhK2NFd1dxM2FqamNqUHdOajQ3UlpBR1RvN1FkYi9jUTd1UTlsOXBx?=
 =?utf-8?B?MXN5M1prY0l0M2lZdTc3eEg3N201U1RJUGw4ZnhaTHZ2dmIwK0JKV3hOODdh?=
 =?utf-8?B?OS9GaXBPTWVaRzFaczVycGJiVkQ5ZlhVb3BTV3FiaHg3RzlNYm55S2VwbVll?=
 =?utf-8?B?aGduQVJ3UmVzeURSazFNWEVkSEtFN0QyQmZ6VEl1QnFTbDN5cTB6THNhcjNF?=
 =?utf-8?B?d3hQSkMzNjJHQ3Y3S2Z6WkJsSlYwWmVJUWpBUEE5MmU4aTJsVElBMmxLL1Iw?=
 =?utf-8?B?bCtiNUUwUjFOMVBVUFdORHpjZlI4SUNhYmp6MFF3R0VEMGRPa25RYnBtS0Rs?=
 =?utf-8?B?ODhtQXg0Z3pna2ptTXljNDAzMHNNTUExUFo2U29waFE5VDZnbmJSVktUekc3?=
 =?utf-8?B?eHlFd256b2k1aU1RdUZxTGN0NzhnSGtjcTZ0eUJwVUMrakh4NTNZNGlhZjlS?=
 =?utf-8?B?VndBck02NW52U0taSENsV0RyRk5kZHFKYTZIb0xiT08vbGlNSXhJNzRveC9M?=
 =?utf-8?B?SWdFTndDRjNKYTcrRzZFbk5VUmdtSVZQbkpnd0RoRVkzVVNNbG51MCtGVnUv?=
 =?utf-8?B?VmdGUzY1RmtoT3g3dHNCTUFhUnN2M0d3YUtWV2xGZEo4V0J5L2xYZ0JjUCsv?=
 =?utf-8?B?THdneGZFdzlsSmZ6eG5jd0lZSk5vR0MvSXZoZ2Z4b2xvRHBiQzRMZkx1UUQ2?=
 =?utf-8?B?NWdwWm5qaDlIcmd0Y05FdnE0QzBSN0Qyd0prZTcycmlaME92Mm1yMjFreVho?=
 =?utf-8?Q?aBXst2ra8juXkpXeR3SZ1COBPeGaqlTSkZqZsgC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0153feda-a721-4254-42b4-08d951863dac
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 05:12:05.4759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xmqYSK2KS6oycTnr+DxYOsaC/17lNmT6RcDcozIKDHB2+Z8im56JdBYx23YmohgBV4C5yMyQ/tLLO6QVnvIiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2820
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10058 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280029
X-Proofpoint-GUID: G2qYcvfwuAXhMR9hIjkbs_7xH_Z8wNAb
X-Proofpoint-ORIG-GUID: G2qYcvfwuAXhMR9hIjkbs_7xH_Z8wNAb
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/07/2021 05:17, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Instead of using kmalloc() to allocate walk_control, allocate
> walk_control on stack.
> 
> No need to memset() a struct to zero if it is initialized to zero.
> 
> sizeof(walk_control) = 200

  IMO it is ok.

> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
>   fs/btrfs/extent-tree.c | 89 +++++++++++++++++-------------------------
>   1 file changed, 36 insertions(+), 53 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index fc3da7585fb7..a66cb2e5146f 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5484,7 +5484,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>   	struct btrfs_trans_handle *trans;
>   	struct btrfs_root *tree_root = fs_info->tree_root;
>   	struct btrfs_root_item *root_item = &root->root_item;
> -	struct walk_control *wc;
> +	struct walk_control wc = {0};
>   	struct btrfs_key key;
>   	int err = 0;
>   	int ret;
> @@ -5499,13 +5499,6 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>   		goto out;
>   	}
>   
> -	wc = kzalloc(sizeof(*wc), GFP_NOFS);
> -	if (!wc) {
> -		btrfs_free_path(path);
> -		err = -ENOMEM;
> -		goto out;
> -	}
> -
>   	/*
>   	 * Use join to avoid potential EINTR from transaction start. See
>   	 * wait_reserve_ticket and the whole reservation callchain.
> @@ -5537,12 +5530,10 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>   		path->nodes[level] = btrfs_lock_root_node(root);
>   		path->slots[level] = 0;
>   		path->locks[level] = BTRFS_WRITE_LOCK;
> -		memset(&wc->update_progress, 0,
> -		       sizeof(wc->update_progress));
>   	} else {
>   		btrfs_disk_key_to_cpu(&key, &root_item->drop_progress);
> -		memcpy(&wc->update_progress, &key,
> -		       sizeof(wc->update_progress));
> +		memcpy(&wc.update_progress, &key,
> +		       sizeof(wc.update_progress));
>   
>   		level = btrfs_root_drop_level(root_item);
>   		BUG_ON(level == 0);
> @@ -5568,62 +5559,62 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>   
>   			ret = btrfs_lookup_extent_info(trans, fs_info,
>   						path->nodes[level]->start,
> -						level, 1, &wc->refs[level],
> -						&wc->flags[level]);
> +						level, 1, &wc.refs[level],
> +						&wc.flags[level]);
>   			if (ret < 0) {
>   				err = ret;
>   				goto out_end_trans;
>   			}
> -			BUG_ON(wc->refs[level] == 0);
> +			BUG_ON(wc.refs[level] == 0);
>   
>   			if (level == btrfs_root_drop_level(root_item))
>   				break;
>   
>   			btrfs_tree_unlock(path->nodes[level]);
>   			path->locks[level] = 0;
> -			WARN_ON(wc->refs[level] != 1);
> +			WARN_ON(wc.refs[level] != 1);
>   			level--;
>   		}
>   	}
>   
> -	wc->restarted = test_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
> -	wc->level = level;
> -	wc->shared_level = -1;
> -	wc->stage = DROP_REFERENCE;
> -	wc->update_ref = update_ref;
> -	wc->keep_locks = 0;
> -	wc->reada_count = BTRFS_NODEPTRS_PER_BLOCK(fs_info);
> +	wc.restarted = test_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
> +	wc.level = level;
> +	wc.shared_level = -1;
> +	wc.stage = DROP_REFERENCE;
> +	wc.update_ref = update_ref;
> +	wc.keep_locks = 0;
> +	wc.reada_count = BTRFS_NODEPTRS_PER_BLOCK(fs_info);
>   
>   	while (1) {
>   
> -		ret = walk_down_tree(trans, root, path, wc);
> +		ret = walk_down_tree(trans, root, path, &wc);
>   		if (ret < 0) {
>   			err = ret;
>   			break;
>   		}
>   
> -		ret = walk_up_tree(trans, root, path, wc, BTRFS_MAX_LEVEL);
> +		ret = walk_up_tree(trans, root, path, &wc, BTRFS_MAX_LEVEL);
>   		if (ret < 0) {
>   			err = ret;
>   			break;
>   		}
>   
>   		if (ret > 0) {
> -			BUG_ON(wc->stage != DROP_REFERENCE);
> +			BUG_ON(wc.stage != DROP_REFERENCE);
>   			break;
>   		}
>   
> -		if (wc->stage == DROP_REFERENCE) {
> -			wc->drop_level = wc->level;
> -			btrfs_node_key_to_cpu(path->nodes[wc->drop_level],
> -					      &wc->drop_progress,
> -					      path->slots[wc->drop_level]);
> +		if (wc.stage == DROP_REFERENCE) {
> +			wc.drop_level = wc.level;
> +			btrfs_node_key_to_cpu(path->nodes[wc.drop_level],
> +					      &wc.drop_progress,
> +					      path->slots[wc.drop_level]);
>   		}
>   		btrfs_cpu_key_to_disk(&root_item->drop_progress,
> -				      &wc->drop_progress);
> -		btrfs_set_root_drop_level(root_item, wc->drop_level);
> +				      &wc.drop_progress);
> +		btrfs_set_root_drop_level(root_item, wc.drop_level);
>   
> -		BUG_ON(wc->level == 0);
> +		BUG_ON(wc.level == 0);
>   		if (btrfs_should_end_transaction(trans) ||
>   		    (!for_reloc && btrfs_need_cleaner_sleep(fs_info))) {
>   			ret = btrfs_update_root(trans, tree_root,
> @@ -5703,7 +5694,6 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
>   out_end_trans:
>   	btrfs_end_transaction_throttle(trans);
>   out_free:
> -	kfree(wc);
>   	btrfs_free_path(path);
>   out:
>   	/*
> @@ -5731,7 +5721,7 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
>   {
>   	struct btrfs_fs_info *fs_info = root->fs_info;
>   	struct btrfs_path *path;
> -	struct walk_control *wc;
> +	struct walk_control wc = {0};
>   	int level;
>   	int parent_level;
>   	int ret = 0;
> @@ -5743,12 +5733,6 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
>   	if (!path)
>   		return -ENOMEM;
>   
> -	wc = kzalloc(sizeof(*wc), GFP_NOFS);
> -	if (!wc) {
> -		btrfs_free_path(path);
> -		return -ENOMEM;
> -	}
> -
>   	btrfs_assert_tree_locked(parent);
>   	parent_level = btrfs_header_level(parent);
>   	atomic_inc(&parent->refs);
> @@ -5761,30 +5745,29 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
>   	path->slots[level] = 0;
>   	path->locks[level] = BTRFS_WRITE_LOCK;
>   
> -	wc->refs[parent_level] = 1;
> -	wc->flags[parent_level] = BTRFS_BLOCK_FLAG_FULL_BACKREF;
> -	wc->level = level;
> -	wc->shared_level = -1;
> -	wc->stage = DROP_REFERENCE;
> -	wc->update_ref = 0;
> -	wc->keep_locks = 1;
> -	wc->reada_count = BTRFS_NODEPTRS_PER_BLOCK(fs_info);
> +	wc.refs[parent_level] = 1;
> +	wc.flags[parent_level] = BTRFS_BLOCK_FLAG_FULL_BACKREF;
> +	wc.level = level;
> +	wc.shared_level = -1;
> +	wc.stage = DROP_REFERENCE;
> +	wc.update_ref = 0;
> +	wc.keep_locks = 1;
> +	wc.reada_count = BTRFS_NODEPTRS_PER_BLOCK(fs_info);
>   
>   	while (1) {
> -		wret = walk_down_tree(trans, root, path, wc);
> +		wret = walk_down_tree(trans, root, path, &wc);
>   		if (wret < 0) {
>   			ret = wret;
>   			break;
>   		}
>   
> -		wret = walk_up_tree(trans, root, path, wc, parent_level);
> +		wret = walk_up_tree(trans, root, path, &wc, parent_level);
>   		if (wret < 0)
>   			ret = wret;
>   		if (wret != 0)
>   			break;
>   	}
>   
> -	kfree(wc);
>   	btrfs_free_path(path);
>   	return ret;
>   }
> 


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5E241A73F
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Sep 2021 07:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhI1FsF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 01:48:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43564 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234207AbhI1FsC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 01:48:02 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18S5NuXu000560;
        Tue, 28 Sep 2021 05:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qDhTQzxp5P7HCyBEPb71doRGrgtPLeYPz+RgX7k4ANE=;
 b=08U5Kv0hr7ZRd8hUrt5YyHtn1EYULY7YtauH3KqPLjvlKzJAtluoADnMlpgkCm47ozsi
 t5KI5hF/F959GcAelBuZu9WRyKrQIodgO9qpjjyHj8h66V29ToTMsnHqTZAy4ST6avx/
 nGsX3zKRZDewuQ7jr8ECEsiZHGiRh88gUgCM8uvJA0eYdGCU6g5V/L10irLhDhBKpeX7
 cW8Dhdgn2bazPT2XBVdYCU/aKda2uUkkXtlRy+lbfVTH0Yi0ZcFoK0jImw2s9xa+w2aN
 XfypRv/L5y9buJluiyl8mlGfm4Qb7hFe+AYuUYSZB1xGT7w3Ryh+75z6WIhBNX1jkVu2 4Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bbeu15mpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 05:46:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18S5PI37030559;
        Tue, 28 Sep 2021 05:46:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by aserp3030.oracle.com with ESMTP id 3b9stdmdq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 05:46:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiuJncEBCaA/9SHSpsHCkYpdv1IzPa23fUdz6gSMLbaRezCMF9sYDBM65YJ9LTJ99WW40faCRiJSjEuYiJuAMWA/YU9MYn4IHiT8sGRGYHFexZdAK/KLA6PBmJmUXCNL3xC4ddxQp4hrG0TFMB0Q//cr3vxfP3NCBfqmbcAJ3xOpFJmzZ6PzPYmUHHMhI4hemeRS2q614KcmNQSwuss2VOatKaeGyWkY27li1YSw5LSR25Yqj50CXvU9QSGO33BRItDTc6EuLrsAjrCaVYuqoQjl5p1LDuHiA7yXw6ME0PB2mOmyOrl+sGd8S0umHLE+0BZpsF86xOWPjT2+GjaKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qDhTQzxp5P7HCyBEPb71doRGrgtPLeYPz+RgX7k4ANE=;
 b=XRqtWluCTiK4O7KwdpqZBH05mc8Sz3UKdchGBFJjOPnG1y9ov24QHdWxshwWDFrdrrunpf8HrYUlBM0GDxHHNyyxzgtKbq0t6JwgPHXzE+3EfGqSbHd8RRIcMfLN532G7X2kOJYLXMpI0NQK63Fl2c25e14eCXvcjkpoQZ1J8hwc8rroDvAEst7khOUHF4VF15alrYchRbJZeCoTYG48O7h+jQaiNPqu5g0foWC3m7ZgTfJAtunqtVF+ByYnyCY/NUjpyMD9B7Fo0+jMXdhkcOndX9Kda8nFkYeuWeU6m57J5YyJODC9SUbhuCkUtamfGq0i5YXZrIUGH8Hni6BEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDhTQzxp5P7HCyBEPb71doRGrgtPLeYPz+RgX7k4ANE=;
 b=d2umyKf1jnVFV/B/GzFYudTBedXGKOSzBJwPrqE4ufX0O4E/qFjCLkv4EFYP05aUBKjQFZGc9sBZ/ojd1qLqWbMoZZKNWyIMC912ibf5sq+fWJi3lYIWEpQ9l5906idFYxdS2OeJJITD+jsxWAziGi56+PKZMQN8MGRdGVNjMw4=
Authentication-Results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3427.namprd10.prod.outlook.com (2603:10b6:208:7e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 05:46:18 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 05:46:18 +0000
Subject: Re: [PATCH v3 1/5] btrfs: change handle_fs_error in recover_log_trees
 to aborts
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1632765815.git.josef@toxicpanda.com>
 <5c30fe9cce106cf33e5d0b3ce74ff628a90724c3.1632765815.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <d46ffc87-cbf5-03bf-a92a-8a06e1df153c@oracle.com>
Date:   Tue, 28 Sep 2021 13:46:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <5c30fe9cce106cf33e5d0b3ce74ff628a90724c3.1632765815.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.0 via Frontend Transport; Tue, 28 Sep 2021 05:46:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afad07fb-2f52-4027-accd-08d982434b01
X-MS-TrafficTypeDiagnostic: BL0PR10MB3427:
X-Microsoft-Antispam-PRVS: <BL0PR10MB3427CE25579FAAD9FD31C029E5A89@BL0PR10MB3427.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVJx3AlWu/UVt54XFEZ3cZcfU9L22x7oiZbGohlh7ebPXu6xRZ1GhHiUNX/IZpb9V6wQTeDo0PgKiI/TnpU6BYWprOtspDdMV+TMYBjkGrgN1Ah1B/QYZg3cP+OoElUIGu9FK3VRVl853bY1Ll01VUCWwMZuXbQyMphUPRSPMc2MtMQV7WhG0o+STwqgEb6oMZLlS17DErpqnV8EiAYwBxlFgg8mKggxOgG40NQnIsbh1iCOiJollI3XkRCi3eeLWaJDf8odF7R1wbQnBnltPLiRvPbxEv22/7FK2j3udlQgoBxfKeb+a62QUSIINb2LYFt6OaUxhyycqtb8K2YIdS7H1tTiNm5vs74jWjkV9OMTASC+w8ryKYpLKd5IvNXRU4iIRtjEgJB+ZFuJkqoTFVm6QHuwMo84ViKF11+eS/ZbPMg8C79C3xnRoL4mIW4Z9MG78mlMxQUe09BlwewC533CKTXnyBa/NEF2HjHNbx2aTSqhuy6CeY1fEcZJgISvjf5BIqN0v+NRphwtByjT7MKP2+W7cFfBZNZkL9rEqzdstvurqfEcGz3G4Rn7oWVbZyqSU5EyKxQ1lrY+bNDtcPz27JspgEOiqVSlLyYBs16ZCWq6RvEKLrPn5jxO9lr5kMNAvC8rT22UCtrlslHbSGBIEWkDmB5QRzT+WX1MiF8dU1ob2GItfNif5G1RPnFlp4QRumRijHcvW5kgvIfL+iKhzchmINHtIDmgwYWxHgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(2616005)(6486002)(5660300002)(508600001)(956004)(36756003)(8936002)(53546011)(6666004)(8676002)(66946007)(66476007)(26005)(186003)(66556008)(316002)(31696002)(16576012)(31686004)(44832011)(83380400001)(38100700002)(86362001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXZUNTdaYUpoNzZPMkM3aVIzbVdYTzJXS09qanZzVlVHSTBBQWc2dzlvZUJJ?=
 =?utf-8?B?TWdBMkxsSG9jMEJ2aXdCTlRvQ1A2QlJSZ2poMkpRUzB6UXRyd3FlNnBPL1l3?=
 =?utf-8?B?MzBRNXJRQ2l3L2swZjIreXF5UnpvRzZsUWRXempVNStIK2ZYS3BGNHZNVCtp?=
 =?utf-8?B?bEZNbDQxRVZhbVRQTUxyTUVVZmxyQUJhd1FXL0R3OGNNUjBWdzF0STZhUWxP?=
 =?utf-8?B?VUU5WXVWREVkbmhkTlpTYkZ4a1prQnBaMEtGOFJtWVJnZjRUR2tYVk0ya3RB?=
 =?utf-8?B?SVMrbkUrWWJlOWgrdVVCWUVPTVk4VGJwQlFsZHBRYTRDcHlFYUNzRTRhTmsz?=
 =?utf-8?B?M3IzK3pIYUIyc2F3Y1c1UHhwNVJYVmZic2hsRUNaM2Z5QmJldkk1LytKbkxh?=
 =?utf-8?B?b3BQLzBnYnI4Rzl2Wnd1VDlRRXI1WHlPZlRsdU1SWHk1T3NLOCtKRWlyN3Vt?=
 =?utf-8?B?a3gxZ2tnNFdsV1VOYVI2YzVsMndSVUdlY2FVWUdmclRUQkxkZ2MrZUdpL0Fr?=
 =?utf-8?B?ZnRqc2NvZHhEb1FJQ0pMSnZvNzRaOHllajdZbFQyQ3Q1bllCUG5Oa3BrbnpM?=
 =?utf-8?B?OEx3b2RvTnBSdHpXaEJtdUJ1U0xpYmU3SXZ4NmJLZ3FVZDg1OGJRS0dpbDU0?=
 =?utf-8?B?Q2d6OUFhYWc3N0hXWGNWam53WFpmWSszTmh0QjZsVjJxZlg4WEpDVjIzZjc0?=
 =?utf-8?B?blFOVkVpY09FTEExOHk0bFQ3NUVtaEM5YnhsSW5QQUpyQjRhYXh6K2xMc2Jp?=
 =?utf-8?B?VjJXZDUzSi9OUGxvdWVIckt1VHlIaXJpczZBemNONmtlTWNXYmdzbHZZUlNi?=
 =?utf-8?B?bHIza21xRFZUb3RYVkt5TEtDQWNCWEhXK1p1S3ZUc1B1Z1JHazhWK05OaC9Y?=
 =?utf-8?B?cVFqaGVyU3RMOTcrWXVUVXZaSlB0SFJKb0xmY3dqQm9LWlEzTHM4OFcrYmRj?=
 =?utf-8?B?U2lPTE1tNmNBdTdkQ3U1SGlhMElvckVOanVMblJZL2JpdDZldFBzYkx6dzA2?=
 =?utf-8?B?NE8vbzNYMmR6RzNrd0NENmdjM1Q3UGNXak9FWFdFcWRwTmdUZlg4aXpFYURs?=
 =?utf-8?B?WkZjMTljSnluR2VHR0JqYzFkSUNWNHZEaytHNEFDdnpYVm4rOXhHN0p6WDdF?=
 =?utf-8?B?MU9jWEkzdXA2cGJic2l4ZEV1UVZTTnRCUGFDMEFKTG40YWN4QjNvZ010R3Fw?=
 =?utf-8?B?aFZRUDY4R3JKbkZwaFpWOXVMNHZkK0VST0pTaE9DMG1XTHdJVys0RzY4ZzRT?=
 =?utf-8?B?REhwQnJjNFhQd0F0OFRVNHN6cHQzeWp4OStjUFYrbjE0U0hENFV3dWxGaFh5?=
 =?utf-8?B?MitPd1dpcU9qZ2lvcDZtK3l0VkRHUDFqNk1ZaHkrS21zTjc4dnVtSGgxU2I3?=
 =?utf-8?B?NHhhdHpaUWtRRzZBQnlZckVWazB2UW5hdUIxeUNPWFEzNEl6eDhJNWhKS0hO?=
 =?utf-8?B?WXZrMnlMdldOL1oyZm5CWHRPeERwUUlmSE1MKzdOR2dBT0VVd2JRYjM1eUQ4?=
 =?utf-8?B?anJTNFhNREN6OFU1c3NxdytBZ0FOZUV4dnAwYlFINmFyZUtjTU03OE82QWQ2?=
 =?utf-8?B?c2VMcUFtUzFJY0M2eTdOZUpuSjE5a1ZsenJVOWtqOE5XbmdDd0dyZUI4Q1Q5?=
 =?utf-8?B?Wm9jQVpPekV0UUt3Syt5Mk40MzVEcXRXYW5mbXduTmV4OC9sQXE2Q3BZY1Yx?=
 =?utf-8?B?aEdTaW5JTDlLbUVwTDI5b3JpOXZGODZZaDU1WVN5Z3BLeGY1UVVxQXVoMVdo?=
 =?utf-8?Q?m4H8DzwhC/xAcrjC2dCUI0kw+rr63jfzJQHd7/D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afad07fb-2f52-4027-accd-08d982434b01
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 05:46:18.3392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 999b1u143ArsoLuLWjPUzdLNpgtYs9cLzHsaiiCHHn5sVHOMLa0Ntg30y1bW23fABoCGqu5ewpSXOh+xBltL4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3427
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10120 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109280033
X-Proofpoint-GUID: IQZ1wGSm14eF0eYREBfvejQIFo_Owp4r
X-Proofpoint-ORIG-GUID: IQZ1wGSm14eF0eYREBfvejQIFo_Owp4r
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/09/2021 02:05, Josef Bacik wrote:
> During inspection of the return path for replay I noticed that we don't
> actually abort the transaction if we get a failure during replay.  This
> isn't a problem necessarily, as we properly return the error and will
> fail to mount.  However we still leave this dangling transaction that
> could conceivably be committed without thinking there was an error.
> We were using btrfs_handle_fs_error() here, but that pre-dates the
> transaction abort code.  Simply replace the btrfs_handle_fs_error()
> calls with transaction aborts, so we still know where exactly things
> went wrong, and add a few in some other un-handled error cases.
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

  After this patch, failure from walk_log_tree() still won't call 
btrfs_abort_transaction(), is it intentional?

  Maybe it is time to enhance btrfs_abort_transaction() with an argument 
to pass those kernel-error-messages in the 3rd argument of 
btrfs_handle_fs_error() in btrfs_recover_log_trees().

  After this patch, it will continue to print function line numbers, but 
those kernel-error messages are more informative if printed.

Thanks, Anand

> ---
>   fs/btrfs/tree-log.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 30590ddd69ac..e0c2d4c7f939 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -6527,8 +6527,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
>   		ret = btrfs_search_slot(NULL, log_root_tree, &key, path, 0, 0);
>   
>   		if (ret < 0) {
> -			btrfs_handle_fs_error(fs_info, ret,
> -				    "Couldn't find tree log root.");
> +			btrfs_abort_transaction(trans, ret);
>   			goto error;
>   		}
>   		if (ret > 0) {
> @@ -6545,8 +6544,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
>   		log = btrfs_read_tree_root(log_root_tree, &found_key);
>   		if (IS_ERR(log)) {
>   			ret = PTR_ERR(log);
> -			btrfs_handle_fs_error(fs_info, ret,
> -				    "Couldn't read tree log root.");
> +			btrfs_abort_transaction(trans, ret);
>   			goto error;
>   		}
>   
> @@ -6574,8 +6572,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
>   
>   			if (!ret)
>   				goto next;
> -			btrfs_handle_fs_error(fs_info, ret,
> -				"Couldn't read target root for tree log recovery.");
> +			btrfs_abort_transaction(trans, ret);
>   			goto error;
>   		}
>   
> @@ -6583,14 +6580,15 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
>   		ret = btrfs_record_root_in_trans(trans, wc.replay_dest);
>   		if (ret)
>   			/* The loop needs to continue due to the root refs */
> -			btrfs_handle_fs_error(fs_info, ret,
> -				"failed to record the log root in transaction");
> +			btrfs_abort_transaction(trans, ret);
>   		else
>   			ret = walk_log_tree(trans, log, &wc);
>   
>   		if (!ret && wc.stage == LOG_WALK_REPLAY_ALL) {
>   			ret = fixup_inode_link_counts(trans, wc.replay_dest,
>   						      path);
> +			if (ret)
> +				btrfs_abort_transaction(trans, ret);
>   		}
>   
>   		if (!ret && wc.stage == LOG_WALK_REPLAY_ALL) {
> @@ -6607,6 +6605,8 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
>   			 * could only happen during mount.
>   			 */
>   			ret = btrfs_init_root_free_objectid(root);
> +			if (ret)
> +				btrfs_abort_transaction(trans, ret);
>   		}
>   
>   		wc.replay_dest->log_root = NULL;
> 


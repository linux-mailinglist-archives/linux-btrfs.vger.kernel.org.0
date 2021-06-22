Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9029D3B01DE
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 12:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFVK4a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Jun 2021 06:56:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53154 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229831AbhFVK43 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Jun 2021 06:56:29 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MArT7c025728;
        Tue, 22 Jun 2021 10:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vcVSlSQQ26ce6oaW0wp64JM5VO+Bb9xkm14YdtSNFiQ=;
 b=kps+dXEwK3JstuQB/uchCtBzI0kwJ6eRdzLS4JoeHK93IfBwFpkCaAiiDJdJMYnXSpSU
 p4yNe03hes/tm5NN/At60KmPyOMPIP2bdRvA33dH4KBxZl9iL1fkqY2a2EWAIizfuwXN
 M+cILr1n8nWosecneujQUMiSPx0OyeIWyWx3lfw6chfAb6MRyqcP0mlmSwC4X3XPO2eX
 M+pS1rTb5aO4xvWJGuFQFWclsHGjQItBmZUwm4hYoDaMpJ4RTxNKzVMczm6DzXz8cCZj
 sottwt4JQ9++THfN0zce4xxWT6L6pvtB+NZtLOfDXJqlC/oBgW7+XtI3JGGdmHLDNrLY cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39ap66k0bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 10:54:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15MApCXK172264;
        Tue, 22 Jun 2021 10:54:10 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by userp3030.oracle.com with ESMTP id 3995pw0tnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 10:54:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQUXizwpTCDvbX7wJ+L2ZNLDdJ4Pb6n0xV6EHGV/KvjBTyztjXu1j+mKXY9IqgjxiQen27+cXyggSIFd6gAYVn9z7rViSrlPR0CUc9Ri0zo4a/vlbRi5Yp1AARwnDrl8nTqcbvAUJcJoTDSw3oKTOrWhXDuLerDzVxFAtKYxGqc5lnfGp0B/J91VXq19YSU6j3sep0BSF/jGFb5VPSjiBXz+L0720HBKb4RuPGlU+gdI+i+VlNp7W9AYGcZ+2wHJ2zuru/ApSAqRUSo1mGkMaxh7mrwzHmRCHoh0m/yCtsqOnXTYAmY83RApmDhKa5ICFfXkiEZeioPvavQ0LZqNng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcVSlSQQ26ce6oaW0wp64JM5VO+Bb9xkm14YdtSNFiQ=;
 b=Z5/18wW7HZ+m6z0krix3IeKtGMNX93iQP/Hi7291hjT5yu2116Pc3YoUCt0j3PYOi8mKHkKFlqFbWFlTNKR2VJg8XtQNOh5Ew2a+u0W2oHqUqk6RGxySAiYdPqOkunQwfnBcJ3QdLy0FwOdW9+jOg4gN3uwe5ghQTLt77yuY914op8nakDAEHtcYx1VBCqVrnvuiVqgIU6lN92kL/vGDmKC8bsVTUbgXjAgdlFTYnWbO10Uyy8SM0r7UASVAjWUIecVgI0C9DBE7sKRRt6BO4VKLPStyuvVDj3sQHN+8hradM1pM3WsOAC4KEjo1Cqyi2xoaeSSx1Cshe7JqhhY1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcVSlSQQ26ce6oaW0wp64JM5VO+Bb9xkm14YdtSNFiQ=;
 b=kKzau5TgK4Nesw8PCL48Yoy4BbQ+AZNh/0Mxzpkz/fjbtnqo3JYSdV5Cu2tpzr29ewfoPf/AgJHcZFsZHLCllHg69gxKfU8MZwPSUCeszu8bI08R5NBE3DC5GcK6biXk096NEiaam9aRG2a1CmCz9uClc5gTIo3AgbbJUT497Tk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4868.namprd10.prod.outlook.com (2603:10b6:208:333::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Tue, 22 Jun
 2021 10:54:07 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%8]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 10:54:07 +0000
Subject: Re: [PATCH 2/2] btrfs: shorten integrity checker extent data mount
 option
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1624027617.git.dsterba@suse.com>
 <4caf7228626fb21eecac55d22ddbfbf9bff8b219.1624027617.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <00c12baf-1e23-0ab9-3feb-6a6c5a3dbe69@oracle.com>
Date:   Tue, 22 Jun 2021 18:53:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <4caf7228626fb21eecac55d22ddbfbf9bff8b219.1624027617.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR06CA0093.apcprd06.prod.outlook.com
 (2603:1096:3:14::19) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0093.apcprd06.prod.outlook.com (2603:1096:3:14::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Tue, 22 Jun 2021 10:54:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecd085dc-0eb7-403b-9eaa-08d9356c0efe
X-MS-TrafficTypeDiagnostic: BLAPR10MB4868:
X-Microsoft-Antispam-PRVS: <BLAPR10MB48681780AF1D43E891F31DB1E5099@BLAPR10MB4868.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxqP2q96grlNC2eBtLTdZgucMS4t209gaKH1LOm4wp3Fa/xDszYnFoXZ70JIsCk67VlONprxNZlvvscYgsY1wgS3G8Db1bf+Ly6hIIaMTV1W8t/ImBmahRRvSEXQWJmYQdSLt/IVsjnixXl2b3ZTVieJ+adB7Uwq5plF0mNyug8ojXGMr8r6C5h7gIpjpqgnUq6L9sz4gPC1kbTBxIRrZN4OyrygNQkXY4F2DDhhebjMa83E3GfzjLP0A94DlUTrBZIC6lPdO7GbOL9MoUhWxtj9ImutjCTRMj3G4E/da/DudVmha62/R6S+i4DkFC89qdUMzMGCKhiilyj5xvaDcfzaNwc/ClQDTFGP2GNGVUBlxYFQzXvRQ1ftfcDwi+v6B7RhaIhGiVC8rADjccc5qRE9efTlO8uT1hTz28lTGaj+LdUBLmi6BuJno4XaDayEypbxsqTnCMMeTCyzJtYvuhAXbwekQaQvmMpDfi8UwtRuOzSN6RDH3qAd09IDbkFz0F6fqD/i3M/lT4Ij2UP/onGC4jRMBGV+3JWQSnELHKuFImsWnqBbm1MdOvZlpdyhG5hqMDcLPW7qIKjNA5I7mBI/0a7pJtiYYQjIATys/HU6Vi1QsXwpaYVV1bOIE0J69Epu9NB9uDKbM1s4s9Lq8OTwlvf4RmyAENfvlxh1wEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(396003)(366004)(136003)(6666004)(44832011)(6486002)(38100700002)(2906002)(2616005)(956004)(36756003)(8676002)(186003)(53546011)(478600001)(66556008)(66476007)(66946007)(83380400001)(26005)(5660300002)(316002)(8936002)(16576012)(86362001)(31686004)(16526019)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFNYaUkrWmVGWC9SUEZnZXJYeGxYSVNLZ2pZUGZhZk1ZQkhROEovQmYxYUlP?=
 =?utf-8?B?RERic3d2emZWaEFsUU5TOVdrVHZKdmVXNGdBeHZNZlEvUk9GNVUyY3BtUVdw?=
 =?utf-8?B?ZDdaT3hNdU4yYUlrSTJoZW1XM3FnNStDL1ExTHVBSkdtSGZxK3BMZDdTZWd4?=
 =?utf-8?B?MUc0bElmQk5KRnV5czh1amUxaDFDeTMrQWdWN1FINzVwdjFYUzFpUUljQlYv?=
 =?utf-8?B?ZVJvdkRBdktjWnNDSWZpVWRETExxbnNaMmg3SDk3OU9Fc1VTYTlwa3ZFVHZa?=
 =?utf-8?B?eVhiZ0QyYXNSS0l1Y1VWLy9CbFJ1WHFKRW1rWWZHdW1nTmhmSGtlSWlQRFhu?=
 =?utf-8?B?OHR6MWswVTVudHJnMDdZUjFEVXdMMEVFeVQrOUxOdERSbWllVGRkNk0wWHNs?=
 =?utf-8?B?Mmp0dmY4VjRPYW1UY25RaHR0RG9EblhIeGIzcjJIYTYrZk50dkNMbThid0pi?=
 =?utf-8?B?YWFFdFN4c3lpN1gxcUYzUlh2dVcyS0ZxWEdaNkJDYkxsMVF4MEo2MUFXaVZT?=
 =?utf-8?B?VGQvTDFDM1NXQmtPdGI4cm5KNmw1Q2R2YStkREdZLzBxM0xYRDJSWlozaE81?=
 =?utf-8?B?aVZiemo1R0JkRk93TndFV0YxNkwzZjNIM2dVa3lJYVZscXFveHJwUkhkZHo5?=
 =?utf-8?B?RDBFbkhUQjJLc09hMGhPUGxuRE1jRVY4Sk5jSGRkc0xoQWI1N3J6eHNoc1pX?=
 =?utf-8?B?YlZQQ2ltb3RpMHlRT0lxMFRjemdDUWE1UmM0TkhHTTk2UE1aOFVpTXZBa0hZ?=
 =?utf-8?B?TUJtblBkNzJtbmpvOTJSL2FmNFlSZGVwN0MvYjJaRGN6UXNDQjQvbzczTmVa?=
 =?utf-8?B?VktTeHU4WGN0ZDI5NzFSL1ZRRU05LzJXbDUzZSt2dzZZZlI4aFM0c2g0bTM5?=
 =?utf-8?B?aWtzUUFuZ2xLN1lDVW5qblhpS29hR2hjQWJCSDB2cUUwQVdmMlhGZnFnQ3RQ?=
 =?utf-8?B?OGpoQ1FrdW9XTGNrU3F6S1pqQmFOdEZzOUZ5SXBLVGJOUFR4L0huejBWMWEy?=
 =?utf-8?B?bkl1OS9jc1oyaE1Gb2hIK0l4SVpPbXNtSG9Fc3ZNeDRkYVZUUnd0bXVLTFFw?=
 =?utf-8?B?UzhMbURITDdlR3NaQThINTV3T3FoTHJKRTFlc2ZacEZ2VDYybzBFZXdyYzFT?=
 =?utf-8?B?cG80dlphNzI1cGJxblhnYXJjVTFyalB2OTVGM2MvTExkZWt4TlhUWVVNVTFo?=
 =?utf-8?B?Q1RTczdrMHU2MDFOTUV4bE44MHVrdmFLN25GRXcxemNCSXhrWGdLMThBRmNJ?=
 =?utf-8?B?OGJQdmtIQ3FPZWJESmtuT3hQQU9HUldIUHJrc3Z5MlE2NkhMTWFWRm9mZlND?=
 =?utf-8?B?dE9Pc2NNRFR0SU5wdWhsRFkwVXlJOWh1ZTBWMFkxSGlobkRBdVVmL2NHdG1n?=
 =?utf-8?B?bHlIeHBhcTVmd1JvWmlSV0ZsanpxK3BvYnFsbEx4ZjVNZHpDRURpWVpzTVhi?=
 =?utf-8?B?NjNPR3pFSUVMZlBqUE02eHA1cFlJUTdXOXNZWW9QY29Ib3ZrME1USm5YcFI3?=
 =?utf-8?B?Zi82WWFsTTMwcERlWWFOenVjTUpJdUg1WUdkVHlRNzBzaDJxcjRvb3R2TTJm?=
 =?utf-8?B?WnV6a1NBVWU4bWs1ZVZRWFpmeCtkYXYrcXpwUHhLSUF5UUVmdnAzV1l0Y0J4?=
 =?utf-8?B?d01LUy9SSlg1VFBMcTJ4NDE5eGo5dVowL0FXWXAwdmxBM3BqcUszZUVVbGU2?=
 =?utf-8?B?Y1NoLytzemI1aDkzYXFXZDc5YkNvWHRUdnRUL1pSODRjQ0NneE1ERmhyQkpJ?=
 =?utf-8?Q?7BKtbaEPP6MUo7ehSu6nUI9ytmz8o9N32XII+zY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd085dc-0eb7-403b-9eaa-08d9356c0efe
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 10:54:07.7020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMm02eOs0pUcbRWuLFaeS6eirANjB2OQtwyLx4r87VLl8ndOYAeKNgON+Ln0HGovQxWNfvRrpYTV3ifM8nVV+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4868
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106220069
X-Proofpoint-ORIG-GUID: D4zgnpZrjJ7CkqPiRSqG27xprw8t5OSu
X-Proofpoint-GUID: D4zgnpZrjJ7CkqPiRSqG27xprw8t5OSu
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/06/2021 22:52, David Sterba wrote:
> Subjectively, CHECK_INTEGRITY_INCLUDING_EXTENT_DATA is quite long and
> calling it CHECK_INTEGRITY_DATA still keeps the meaning and matches the
> mount option name.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand


> ---
>   fs/btrfs/ctree.h   | 2 +-
>   fs/btrfs/disk-io.c | 3 +--
>   fs/btrfs/super.c   | 5 ++---
>   3 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index e0f6aa6e8bd2..4d156d9e8050 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1405,7 +1405,7 @@ enum {
>   	BTRFS_MOUNT_USEBACKUPROOT		= (1UL << 17),
>   	BTRFS_MOUNT_SKIP_BALANCE		= (1UL << 18),
>   	BTRFS_MOUNT_CHECK_INTEGRITY		= (1UL << 19),
> -	BTRFS_MOUNT_CHECK_INTEGRITY_INCLUDING_EXTENT_DATA = (1UL << 20),
> +	BTRFS_MOUNT_CHECK_INTEGRITY_DATA	= (1UL << 20),
>   	BTRFS_MOUNT_PANIC_ON_FATAL_ERROR	= (1UL << 21),
>   	BTRFS_MOUNT_RESCAN_UUID_TREE		= (1UL << 22),
>   	BTRFS_MOUNT_FRAGMENT_DATA		= (1UL << 23),
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 544bb7a82e57..6eb0010f9c7e 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3598,8 +3598,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   	if (btrfs_test_opt(fs_info, CHECK_INTEGRITY)) {
>   		ret = btrfsic_mount(fs_info, fs_devices,
>   				    btrfs_test_opt(fs_info,
> -					CHECK_INTEGRITY_INCLUDING_EXTENT_DATA) ?
> -				    1 : 0,
> +					CHECK_INTEGRITY_DATA) ? 1 : 0,
>   				    fs_info->check_integrity_print_mask);
>   		if (ret)
>   			btrfs_warn(fs_info,
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index bc613218c8c5..d07b18b2b250 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -934,8 +934,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>   		case Opt_check_integrity_including_extent_data:
>   			btrfs_info(info,
>   				   "enabling check integrity including extent data");
> -			btrfs_set_opt(info->mount_opt,
> -				      CHECK_INTEGRITY_INCLUDING_EXTENT_DATA);
> +			btrfs_set_opt(info->mount_opt, CHECK_INTEGRITY_DATA);
>   			btrfs_set_opt(info->mount_opt, CHECK_INTEGRITY);
>   			break;
>   		case Opt_check_integrity:
> @@ -1516,7 +1515,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
>   	if (btrfs_test_opt(info, SKIP_BALANCE))
>   		seq_puts(seq, ",skip_balance");
>   #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
> -	if (btrfs_test_opt(info, CHECK_INTEGRITY_INCLUDING_EXTENT_DATA))
> +	if (btrfs_test_opt(info, CHECK_INTEGRITY_DATA))
>   		seq_puts(seq, ",check_int_data");
>   	else if (btrfs_test_opt(info, CHECK_INTEGRITY))
>   		seq_puts(seq, ",check_int");
> 


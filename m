Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCAB3447DDF
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 11:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhKHK0g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 05:26:36 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39192 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235081AbhKHK0e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Nov 2021 05:26:34 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A8A9EO2005915;
        Mon, 8 Nov 2021 10:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uWzp6/xkpdYpMB043qiCLVlgHOSEWHWgnlzgiAlhoUs=;
 b=s/e7UfEsaOkmyNolOdO6nrBQnyNnqjwogdtLmT/7clWbFhQ5DUgcFTmdELOZVXn6j3gU
 dqy8Gap8FOBZqzXDWpZbK7/c+yloVaMpLFEvvyNGzKL7eRR93ViJkAP76HlgdK3dyDm/
 vcBraTVYpYgdDcRQiu1bME119XsZDvrnvjXF1WjYa1zitqSFka9Eowr14ldZ9C4vjYI2
 hjwQL6wAGm6mTqLTen69RvwEUOzdP59nei9ukksZhYElJv9XeWlR7XjWS9JWNWoAMyiB
 JnEA5G/8tZT/TnWJ6h4owW5aUueXZmCRzfM42VcQXNfQEKY/aN/hh3O7sUC98A6gBBHX 5Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6uh49xvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Nov 2021 10:23:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A8AGapE140684;
        Mon, 8 Nov 2021 10:23:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3020.oracle.com with ESMTP id 3c63fr1hf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Nov 2021 10:23:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiF27s2+OaDEBei6ijPBqoC4ioYPJ2iXNrJPY+5IOzQS9qyaI8+lkiRPYHTiOY/cj35H34OH7kK92gCME751ccjs9RRD95gvSkD1qhr4q/VSf1D1yMGgJ6PCjeH4+/r+Q7DBfX8aQxc3PGUpcTd9yA+Lkyr/WQJjYhT+BomMsEgDkxJ+hcZO5XMPbT5hiiJk4ZTNsuQXpXwAeFrcKgjA9MnQbzRa3NeMjUerTN/R6nPV4aB5s21qF8LVSuXPwGKzNfdmc4i5oBCFKNXs/WNeA7F77wcSo9AzERgLRBKm74kSA0AMCwyw4z0SlVjL77EtH8bYMHUOEjxkZwR1TCfYxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWzp6/xkpdYpMB043qiCLVlgHOSEWHWgnlzgiAlhoUs=;
 b=BaNMRH7VeSxNgt/sYT7+TtLOxYtGhPQn1c2cS4rjtRTmpCDXE795VABKC592fg/Sru25flGIerXrJW5LzyAwbAC6Tc6us4LlXRLwm6dGfnV+xkFT49atrA4jgSuw8ddbxP/qzbqMmnnWbWU4fRc9g36jzc27UHv24DjYXg1BoAlnnFo5VqGIDEfBiHJ8qB1h9VZrPSdYa2vg3nKDB0VAjKAYA6ZZ2wi/9ynqP1OEqMn1A20lUvmOV2eipnw5MeCPHwiQAmhfluMAZzwfAggJO4KuQsx2jcIwh9qg38MoRS+IxJE+0b/gpaOkDnq7Id+D0IJQSesLJbYFhRjt5XzKyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWzp6/xkpdYpMB043qiCLVlgHOSEWHWgnlzgiAlhoUs=;
 b=g8Pii4uCQJKViQMeL9JEuadz6OmYyW8Ui5FB3ljLQdjv7Ctw04pmIam0iwSAPccP8eCDo7a0spy+nqinX5uyM8qVvZYnHAzVBoq8mpPxvQSqTtZzYTvaWT2m+x2tU59u2pg4VAb+rBo+OJz5GGMHaOwoajRPNutOe6hVfFMquqY=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3982.namprd10.prod.outlook.com (2603:10b6:208:1bc::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Mon, 8 Nov
 2021 10:23:30 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 10:23:29 +0000
Message-ID: <92714617-fa1b-8f89-7c9e-9847f36f4777@oracle.com>
Date:   Mon, 8 Nov 2021 18:23:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 03/20] btrfs-progs: filesystem-show: close ctree once
 we're done
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636143924.git.josef@toxicpanda.com>
 <a666deeeb9a7f9194406562ee8ef632f1852b4bd.1636143924.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <a666deeeb9a7f9194406562ee8ef632f1852b4bd.1636143924.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:3:18::24) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR02CA0036.apcprd02.prod.outlook.com (2603:1096:3:18::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 10:23:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7959d0f-6d5d-4938-a9f7-08d9a2a1cede
X-MS-TrafficTypeDiagnostic: MN2PR10MB3982:
X-Microsoft-Antispam-PRVS: <MN2PR10MB39827DACB1918C16134DA6A0E5919@MN2PR10MB3982.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTn/xNcdDA0v5upZTn6hDk+MioBQtxEFdLHCs6eYbhDQt0IPumKMPR0oN/CbBdkcoIaSTMrEiItJyZhDebBxQcBXM4uDqJOvAC7/TRvGFuV7RQY2ac+pvEPVCtieiuT3kR8BXBZbgDu0JJ7F1MB1fw6JR3/6ovs2XXPZwMAR1NOzJkT7xzPz96VOni8b7sQ4NkqBTI/mC2J/61N1pnmIA9d9JmEDjFiX3du58AdYfWUgb8yDjiFrItyHM59wu/tmEfXj+7OIZOZEnawGm1S+NQ6SM1J38tUw3AgBC62sTBXNd8cBojlZjYCWT1L+MyptRY3I1h4xq25mVWt5MFeiTqfZYvkOPTOmQE8FjrkWaG9KrZWSWOvKGJleLXv7cUXVVjVvFl7M/47fYAY5g7b7dDA/fUtw1HmIgqZnTM/ZPRs8zHCO0OfyOHOdqUOJB0bgAffbQlW9+mfeE0ZDxtSxbNnsMDTw7G0Q/CWZIr/Zmz/j0o/5nDC09GcaCvlm+qEt3KkAKee17ukE+E9pxI9/qq2GGLo4AkIX17/D6ib+ueJDLrauNTRTg/fdiFQNFQyNdya3KPC+XB2gO57qIKLO2wBOQspYzmntPCMHuX0SfIqCMBmZOrGlaFUjbNb6YIqFmSzRzPOa3dAUf3nouLmKBCZkL+U0Jm5SgVt+7z8V5P6kL+ok0pWqLbN+3VIAtZ2GWJij9d3vXxzOqXux+ESlHvT3SaP89uVaYjcowdSOZ31/H2JpCD5P7yIS9zwnyTvT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(44832011)(8676002)(8936002)(508600001)(6666004)(31696002)(2906002)(2616005)(6486002)(38100700002)(5660300002)(956004)(316002)(16576012)(66556008)(66476007)(66946007)(83380400001)(86362001)(53546011)(31686004)(186003)(26005)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmRjYjJjdXVjWWJEc3pSRU5iL2M0bHdRdHlVY3FnTU1CNXd1amJWN1lhYmsx?=
 =?utf-8?B?RWpLdmRmUC84ck5sY1JEZ2kzL0tFL2phRkV2YmVXZFlxVzI5elc4TGEvN2E5?=
 =?utf-8?B?N0FiUlhWT0tRbFZycmpMbjZ0ZUNMWlMyUExVL0wrT1ZDak15bnZnQlBoaHpW?=
 =?utf-8?B?azVMQXB3YWFKL3hESGNXalVOMEhFRktYV1RFL3BHQWs2WHBYdWRVZkRmU3A4?=
 =?utf-8?B?bTgvOHpmWHk2S1Y1NSswV3hSY1U1MHF2TDRINklxc1dhRE84a2RlY3c1Wjkr?=
 =?utf-8?B?MDFMdmdOUVBGY3BMOWh6SVNhSVc3em8yM1dhdjY2dFRZenNXdjdscGVmZkdL?=
 =?utf-8?B?YUJHYzUzcjhnYjduVjhkb0tlMWVJcWlRVVZHQUh0WHhDOFI2WjFiUFMyVUR4?=
 =?utf-8?B?TWlRSmp2aEpmVnVBL2wwa3E0TjRwUGtDTm12VHZTWGJMOFZvSitlbHNZVk8z?=
 =?utf-8?B?QmxwNlNEM1MvWkVPUHdrSWwwVWVBTzVjWVNOb0c5VlNra1NnWWVLSTZnbTU3?=
 =?utf-8?B?azRGaDRMMHBnVWdKeXdpeVkxUWNNWi9lOSsva2xrQjZkR1FSZHBNa1RXMEI3?=
 =?utf-8?B?bzdaSGRTSDM2MkxnOWdiVnVObVJ6Z0M4NVgwbk9jRWI1cHh4bnFBbHA4cElR?=
 =?utf-8?B?aUt3V2RoSS9HZDk1UmZFRFdkQ0FQOEdta1FTV2hFWEFtd0JPMENlMDVlWWFJ?=
 =?utf-8?B?Wm9hVXJrSkFsZytEUHFxSzNGY0lKcFgrVUlkaE9qbmF0YitIMlFjRTFxazNU?=
 =?utf-8?B?RytzbldxT0VnQ2dTRnpWV0dsK0YybUlCK0lMTUlEWXF5clhnUUxiTVRIL2Vn?=
 =?utf-8?B?cVhSY21yY3BnRVFEQmZGNys5RzliNTNNK1VOcTA5TmNPc3UvK2hpQXEwQ0VY?=
 =?utf-8?B?bytwclU0MDBOalRGdHpSUkhISjJLRHZBZkpjK0hiNCtuc0R4WEo3TUNEVVN4?=
 =?utf-8?B?NGVKOXJBNFY4bTFiTEo5cHU1ak4xaGl3WUVZK0t3dUpKWVNOWEQ4R0twUHBE?=
 =?utf-8?B?VHN5dWcxWGVvdlBLMFdzRlNQVzY2Rjg5eXE5cUk3Y0NLY05SVkwrSUswMG5G?=
 =?utf-8?B?dk1GTnZqU29FNlJMWnZlUXI2a0JwRnl1Wnd5WUg5NDZRYXBtcWM2ZnV2R0Zk?=
 =?utf-8?B?U2cyWkZOWmtpUHFZbHRld3NPY2V1NHVySlRoeFZsN1hjaUN6blJqV0grMzFO?=
 =?utf-8?B?VEpUODYzUFB2amhRWjJxQ0QzaGpMVFQ0M3NPWnducWxURXltNXJUVzdhSWV2?=
 =?utf-8?B?K1lpM2dFaS80K0NtM3FnRmd6SXZFOVAxbGswcFlMWDhldVdpSjc5eVZQT2hH?=
 =?utf-8?B?VnpGMUgwYWNlOFA3a0I4VnpCeFFuL1M4QTdUQVVKUWJ5Ry9SNUQ2SVduWHRx?=
 =?utf-8?B?UmJXYlJMdkNBL3daa09aY0IvTHUrRWtzWmwzRlhQaEZGaVpCaHNFQkV0VitL?=
 =?utf-8?B?VXk2NDhsNTBiTy93YmQyTGtHOHlMTDNnU21KK2s1L1c5REtnTVlDVjZOMkJn?=
 =?utf-8?B?L1gzL3p1ejY4eUNKWXQ5aUx4OFpyNGhOZWRjL2JSdlFuRWsxWlpGWlhjNDd3?=
 =?utf-8?B?ZkExYnBMUWdVeFMwQUtsWEhqVFFlMUpsUmtaS0NlQnBkNGVOZWk3THBCQzZL?=
 =?utf-8?B?VEYxV2tLeUlZSkFJZlFXWFRxNW1qL1RESUFiTkRLRHNCaldaZDVDRFRTa0dD?=
 =?utf-8?B?ZUw5ZURTMnVLMi9KWTJJckhza09YcTFlZHBER2RnYUZMNFZJVFJ0SWJ5N2do?=
 =?utf-8?B?aGFPR1R2c3ZmZVZncEx6S2U3eGhzckxudVovOGpEbmNNZGwrL0xhcjd2Z2x1?=
 =?utf-8?B?b1VTQlRvTGpRTWhtU0RjNFR4aFhJcFpQRWcrdHlMWklnOVAzTzlRUFdHQk9C?=
 =?utf-8?B?MFJabnN3NGQ1MTRYenVJcWxzVGdFbFdUOCs4MXpXR1d2eldlVkNKNkRsTlBW?=
 =?utf-8?B?SUZCcFFPZEhLaytuYzllcFlGWkRqajF1dTQ1TllkSTZGYzJoeFZzemFydnJ4?=
 =?utf-8?B?Ui8zNDNjdzQ4ZVl3cWRvMC9VVE1KK1cyVk1WMEp2TWhuUEg1UnVsdUVQaFFH?=
 =?utf-8?B?bTNFaUpNQ2dUZyt6Qkw5akllRkl2aFV5eHN4a1ZreTg1dFZhMDgwQVVIMGdR?=
 =?utf-8?B?UVZ2LzVFYndTdTgwMmFoVlY4R3FPUGViektzVmliMFV6UTlJRG5NM1hVVzdP?=
 =?utf-8?Q?3rJmpe2g5/0Ijc6pdPPZnf0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7959d0f-6d5d-4938-a9f7-08d9a2a1cede
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 10:23:29.8677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLAs4CfB1TfYllkX+kLpEcT03FsCb+IbxNkHJ07Y1nIClQ3Zjh4k/xtOt4DG6A8N5a7ODuRJwzTSuuooW1sbIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3982
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10161 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111080066
X-Proofpoint-ORIG-GUID: JcMoLydfCXoewouyRamlAxm5_OOPtOq4
X-Proofpoint-GUID: JcMoLydfCXoewouyRamlAxm5_OOPtOq4
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/11/2021 04:28, Josef Bacik wrote:
> Running with ASAN we won't pass the self tests because we leak the whole
> fs_info with btrfs filesystem show.  Fix this by making sure we close
> out the fs_info and clean up all of the memory and such.
> 

Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   cmds/filesystem.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 6a9e46d2..624d0288 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -655,6 +655,7 @@ static int cmd_filesystem_show(const struct cmd_struct *cmd,
>   {
>   	LIST_HEAD(all_uuids);
>   	struct btrfs_fs_devices *fs_devices;
> +	struct btrfs_root *root = NULL;
>   	char *search = NULL;
>   	int ret;
>   	/* default, search both kernel and udev */
> @@ -753,12 +754,8 @@ static int cmd_filesystem_show(const struct cmd_struct *cmd,
>   
>   devs_only:
>   	if (type == BTRFS_ARG_REG) {
> -		/*
> -		 * Given input (search) is regular file.
> -		 * We don't close the fs_info because it will free the device,
> -		 * this is not a long-running process so it's fine
> -		 */
> -		if (open_ctree(search, btrfs_sb_offset(0), 0))
> +		root = open_ctree(search, btrfs_sb_offset(0), 0);
> +		if (root)
>   			ret = 0;
>   		else
>   			ret = 1;
> @@ -768,7 +765,7 @@ devs_only:
>   
>   	if (ret) {
>   		error("blkid device scan returned %d", ret);
> -		return 1;
> +		goto out;
>   	}
>   
>   	/*
> @@ -779,13 +776,13 @@ devs_only:
>   	ret = search_umounted_fs_uuids(&all_uuids, search, &found);
>   	if (ret < 0) {
>   		error("searching target device returned error %d", ret);
> -		return 1;
> +		goto out;
>   	}
>   
>   	ret = map_seed_devices(&all_uuids);
>   	if (ret) {
>   		error("mapping seed devices returned error %d", ret);
> -		return 1;
> +		goto out;
>   	}
>   
>   	list_for_each_entry(fs_devices, &all_uuids, list)
> @@ -801,8 +798,10 @@ devs_only:
>   		free_fs_devices(fs_devices);
>   	}
>   out:
> +	if (root)
> +		close_ctree(root);
>   	free_seen_fsid(seen_fsid_hash);
> -	return ret;
> +	return !!ret;
>   }
>   static DEFINE_SIMPLE_COMMAND(filesystem_show, "show");
>   
> 


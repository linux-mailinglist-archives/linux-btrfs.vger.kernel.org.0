Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0805C423A16
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 10:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbhJFJAS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 05:00:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36370 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237594AbhJFJAQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Oct 2021 05:00:16 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1967gbKG003642;
        Wed, 6 Oct 2021 08:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bPpfFVmwisXuBRgRnE+lTaC7c21W8aTkfK55HMgPs6s=;
 b=X1O5g10fY+a888K4+PA4vP0O/ACvWCDSKqVUc0QFWlhfgoE4ngn8kcUA/TRVn9tUlnJF
 Uzcqlf+PcgIH8sgkasPInXq3rBTk4Y497kvI8J/mIXdfdmqY4uIB1/BKawbmBFE8drIr
 6aQSZvus79pNuA0+gq/Gx6/kfiA/behvdK4PbCPFjlq4XDy5WS6ogmNjD9z1fPZ0L2tH
 kFq3w97R5gbcGHmMEW50c9w9u84bFhakxDC52GUj20tRgcYK8uk2xYlDNGbMfuaiMj+U
 BQMgEZs1ccKfljSNQT9CbysyEGgUqM7g2SJ38MPAnfqqaKeT8HHv3hqelCRCGZCVIZQU Og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bh2dnhs12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 08:58:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1968shv4016494;
        Wed, 6 Oct 2021 08:58:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by userp3020.oracle.com with ESMTP id 3bf16unc2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 08:58:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HF/9s+1H2PtSloFc5AE17sbUKDOdxAvTaFnJboMAxBt7rCsXB42lYXcHN5ubbDybydhxqDvIvJgu8RpkLO/SNejzDS3yN/EPiu+bMCrafV7TNe3RH/h1fWS8qN2pXmm0cJmpYUZ5jDyeJgvcAGjoRxoS3DYXUljSL/anIUzvlkQV1nhMypjtyzkctTZFK7L6EmDdgbxda5Wq0ETshogqrnpzzzwdgb/AcRYj6xisvoSy5FiYV9f1XRDrwsi9t9kqxLLHWCFNLejixLAqKzh7IVqzi9GJv5jcZqZHxSzmLyb8n0SCvHbQKtFSR5Ad7ySU6j8OdCHv2zcSPJgyTvk2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPpfFVmwisXuBRgRnE+lTaC7c21W8aTkfK55HMgPs6s=;
 b=DNf5Tg4RmIjuKDwuo9mvMsQCXK5Ld2U95SoKZKCmbS88KFTKlG1uc0hyNeAXq3exqFnDMqcTWDb2PZGGa+fS+olNDlvZyg4NelGvtJz/ui8vNR/0jbejPmm/JQgZUWDNMmZu0loEN6oI94niLcnkrzonyBcnuX9BI26rMhhbaIvm3u9hHdo+Nn+t+SSLqzuKjVz6I5Q6Op5qoU4+9y/3AvbfnoqKJzyRMBFoEE3TZUlsK/bC63BeN1utmEoP3/7MXBz07vhPbOsCoPi1+nwJ/dLjgAdcN6B6KxcuZGILIYniFqhoNh9BQikbC+f/NFhXu97nu2kp5WiBBw8KbONZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPpfFVmwisXuBRgRnE+lTaC7c21W8aTkfK55HMgPs6s=;
 b=EBSGXoztynW2FQO23bBxH1UXHJx+UXcluWBygglSujd15re2oHHoZgBDTyGHSmmfizBcoXTuNjltA1Ne5LMnSNkKqQzyptgRLuPJ4vrSwWUP7v/cN56jtfKyv3aEydDyvmHLXJ2enm/bzCTz0vw+i1mKYcU+uUC8SLgIIpBM/84=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2913.namprd10.prod.outlook.com (2603:10b6:208:31::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Wed, 6 Oct
 2021 08:58:17 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 08:58:17 +0000
Subject: Re: [PATCH v4 4/6] btrfs: handle device lookup with
 btrfs_dev_lookup_args
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1633464631.git.josef@toxicpanda.com>
 <dfcc04056a9895dedad6786a4d0944fffb3d82be.1633464631.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <269829d1-f4d4-2741-22af-ee37056e1564@oracle.com>
Date:   Wed, 6 Oct 2021 16:58:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <dfcc04056a9895dedad6786a4d0944fffb3d82be.1633464631.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0107.apcprd02.prod.outlook.com
 (2603:1096:4:92::23) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR02CA0107.apcprd02.prod.outlook.com (2603:1096:4:92::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.21 via Frontend Transport; Wed, 6 Oct 2021 08:58:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d91bb9a1-81b0-40f7-fd7c-08d988a77025
X-MS-TrafficTypeDiagnostic: BL0PR10MB2913:
X-Microsoft-Antispam-PRVS: <BL0PR10MB2913E1A5E01C18669707F7F0E5B09@BL0PR10MB2913.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bfJbYzoEkb+VwCzoGAB3YztdldG/GrgGG4p0GzyslSfeKCFyVc/3/CrKe3eGVX4j7d8dhEzAGgbTfYl8WmbQQGzomW8nRtwsIMHIliaiMPJJd1POwnAegdD5xJYHp9ka0thTmSnj2vIkkGnrv0SfDXmkLzI1TIKdhEtDhbGy9dZEALcc7/PypsUOf/rHWK+VpnZ0Sg2V4+rcKYACUEoC5nu6FmFBk4FwfY2JYx3NZwtHBvBcifK2kDtIrXNbrQSKu0B6P2FO+infshzzjC1ED6OvAsNmF7Qm1FJ270Vu4a9EXdWNmEYGDp4I8YQkrqNqmEKck31xLYcsCpHWrxSUt9hBHpQbOzCdHxbfZO380BmVGoQljGYR2/SKEVsbTflj0Q0ysjueH2UNqHQnssBrd2YKeqVENSNpxt6yDn0KHMeFMEINU2wklHhLN11p+gXOW6XALMnuG64/+jCkNMBU9ZiHzM3ioMg5rd3+g92CxSR6dL+2ZQx8QOtweBaQI33BYb+ClLnav/WGUqgC8HrdpARUlHOrtscWukOoZaNbKq8XCv62wBKiw82O8y/A1lH7ewGwLaBlwlnwh3J8WHfIsfA3Dwp+2dn+/rnGlIwFx877w5Hc1WuG/pM/32gufviqton8hfSZ4qZizAjPMvbRIhvEJpqaZBLaCu8yQnNjabvM86KEzJz7vQJWl9FIS2GSpg81nuOSfjpoZ6XytiCupHwZwrBoo3fj4EsJdspMZVz1+8NHoJhZdDrisDrxQeeO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(36756003)(44832011)(16576012)(53546011)(30864003)(186003)(86362001)(66946007)(31686004)(508600001)(38100700002)(2616005)(31696002)(316002)(6666004)(8676002)(5660300002)(83380400001)(26005)(2906002)(956004)(8936002)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW5sMndZY3krRjRQc0VlWXl5TzBlQkhkT2d0L2JnR1VzdmNrR2x3MEFzK1BR?=
 =?utf-8?B?dDZ4K2tvZUJiYmx0OFhlc1lvMFdvUkowWkJnT3BaUytwSVQwZ2d3YlU2ZGdB?=
 =?utf-8?B?aStUdkdpT0tIVFRyOWFpM2phTWNBcS9rVjBZMkNmNkxOazNTL1EzNzRLREFC?=
 =?utf-8?B?RDZHb280QlYvVm0xeUpBQXpjQ3lhWTBkN0VmNE1oY0VJYnUyMndwamkrRGdQ?=
 =?utf-8?B?WEs4TnRva0xScElwd0JUb2pYTTdFUmRyRWFnS3pPb0NwZzVwT1FHY05mK00w?=
 =?utf-8?B?TVFhSVRjcXVmUzRuVlBBejhBaVhlNXl5bEt0czIzUGJrTU1KdkdVVjRQcnJ5?=
 =?utf-8?B?QVdBaldoMjZoR01xZXQ4c1hHNERxbDFqRE5pUEZMSCtiZTJvZncybGV1Ym5V?=
 =?utf-8?B?VEtoTkJKYm45d1FqM3hLc0pUUGcyMnBVQUtRSEF2UG0vZHZCTzBoR0YwYS96?=
 =?utf-8?B?QUM0TEowbStIWGJqV1N1QVNxVzdLUmNsY1JIcWZVN3RiOVNHTGxhM2JZUXRh?=
 =?utf-8?B?WlJjeU12R1FZcmlsMkhJMmRzQk8rTWR1Zy9qWjRwSHRFL0NweEttTkthbW45?=
 =?utf-8?B?NTVnK0ZOejJTYXhDRUlOMzcrUnhVbnlDbzFwM0dGZUhZNXEwME1uOEx3dTRr?=
 =?utf-8?B?ZkFsVlNMYUJaYjJScGpUd1hjcVIwbWwwb3R4ZVFBeDg5ZlRoZlJkclo1UFhL?=
 =?utf-8?B?VmlHL3N2M2RsK3BCRVZXS0c2MUxoNTNPT0l4UTZlYjdKSFpJS1FFZHhza2l3?=
 =?utf-8?B?akZoeWxpR2pQaWJZL3h1U21xVGs1dEt2RmQ0WHNLTHgwSWdvbDA3cjBRMU5v?=
 =?utf-8?B?QlgzOENOcC92MUVETDF1QXJKaGhqWVRhOU5PZ0xRSVZ6OGZMTmd2cFVmUkds?=
 =?utf-8?B?dEx1OCtuR1JFTmxzbkZreEo2MHNKSEZDZ3F3K3ZvNlo3dkE1V2VUT2lmdlR6?=
 =?utf-8?B?MnVEY055WUY1OVVnL3ZsN3RzNXRlSWdldjFRWG5hSy8xOWE0NTdvRnExVUVY?=
 =?utf-8?B?a2xFUSs4d0ZIOHZNQTZNMFJNNnVpUGVQUm03NWt0SXdZanlnTlh1Q3A1UCtX?=
 =?utf-8?B?b1BUWU9pcm5iN2pLQUFoTUtENTBtMWxXS1lFSzdSaVZlZXZTa0xZaTUrRHJ4?=
 =?utf-8?B?MzhTb0YyOXdJSXpGeTJjOGlyb3hFd2tTUEwzTG0vSGRxQ3o0MEp4S0N4ZHNF?=
 =?utf-8?B?V1V1RjhiTm1kZFdRYjQxbS9Xa0h4NHFlejVzOU1PK2plVk1RM3pndjRrRHIz?=
 =?utf-8?B?Q052aDVqcDlUVFNQR1lKdWNSSWh0cDVXamhTa1V6N3lDOWhVRmo5ZUlIemwv?=
 =?utf-8?B?U2QreTB3VFN4aTJzT2g1TnlYUEFyUlVqemxBZ2M4MmFPVHhMbFFGQnJvN3U1?=
 =?utf-8?B?d0JXV3RRNlcvVW5zbnJCMDZTcnllRFFGNFZWVlMrbUM4R1hESTZVZjBwNkpz?=
 =?utf-8?B?M3p5ZUU3eSt3QVo2azVoQWZGSkFKNGllV3NidmRkSGxuQ3RMelNnM0ZoK09U?=
 =?utf-8?B?Z0l5dG9SeGZCUGNqWFJXdSswbWRGTlZ3VTdrVWovY1VTYWJwVHZPUTFsSEVK?=
 =?utf-8?B?eFVXaWFrUEMyWTRpNzg3Ty9KTUoyamVVZGVEZDJLRFVxZXB2SkZ6QXhNMXp0?=
 =?utf-8?B?emVqWHJTaGdaalZ2UWphSmZsZEpvaDBMRDI5TFYyOTA0SGpRSjlRK2R5R2Rz?=
 =?utf-8?B?V3JrQ2R2bzl5WEpscDNzS2dDbHhtOXRKWWk0M2hJZVFIdjRnRmhXUmQ1RW5y?=
 =?utf-8?Q?qdVm2mcRHlvP/zwTuY7+r2MuYFQ6d2qcouktZgC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91bb9a1-81b0-40f7-fd7c-08d988a77025
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 08:58:17.3961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWffnSbBWmJ1DgAUssdryWiSA8mEC588IpdzMk8VOhEL0jOVZOMlgojrE1q0wvt2KfjXpuPbYlSTxRyzzv50cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2913
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060057
X-Proofpoint-ORIG-GUID: L16a7SpLjUF77Qm69r4dBNli9wkWVmud
X-Proofpoint-GUID: L16a7SpLjUF77Qm69r4dBNli9wkWVmud
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/10/2021 04:12, Josef Bacik wrote:
> We have a lot of device lookup functions that all do something slightly
> different.  Clean this up by adding a struct to hold the different
> lookup criteria, and then pass this around to btrfs_find_device() so it
> can do the proper matching based on the lookup criteria.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
>   fs/btrfs/dev-replace.c |  18 +++----
>   fs/btrfs/ioctl.c       |  13 ++---
>   fs/btrfs/scrub.c       |   6 ++-
>   fs/btrfs/volumes.c     | 120 +++++++++++++++++++++++++----------------
>   fs/btrfs/volumes.h     |  15 +++++-
>   5 files changed, 108 insertions(+), 64 deletions(-)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index d029be40ea6f..ff25da2dbd59 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -70,6 +70,7 @@ static int btrfs_dev_replace_kthread(void *data);
>   
>   int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
>   {
> +	BTRFS_DEV_LOOKUP_ARGS(args);
>   	struct btrfs_key key;
>   	struct btrfs_root *dev_root = fs_info->dev_root;
>   	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
> @@ -84,6 +85,8 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
>   	if (!dev_root)
>   		return 0;
>   
> +	args.devid = BTRFS_DEV_REPLACE_DEVID;
> +
>   	path = btrfs_alloc_path();
>   	if (!path) {
>   		ret = -ENOMEM;
> @@ -100,8 +103,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
>   		 * We don't have a replace item or it's corrupted.  If there is
>   		 * a replace target, fail the mount.
>   		 */
> -		if (btrfs_find_device(fs_info->fs_devices,
> -				      BTRFS_DEV_REPLACE_DEVID, NULL, NULL)) {
> +		if (btrfs_find_device(fs_info->fs_devices, &args)) {
>   			btrfs_err(fs_info,
>   			"found replace target device without a valid replace item");
>   			ret = -EUCLEAN;
> @@ -163,8 +165,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
>   		 * We don't have an active replace item but if there is a
>   		 * replace target, fail the mount.
>   		 */
> -		if (btrfs_find_device(fs_info->fs_devices,
> -				      BTRFS_DEV_REPLACE_DEVID, NULL, NULL)) {
> +		if (btrfs_find_device(fs_info->fs_devices, &args)) {
>   			btrfs_err(fs_info,
>   			"replace devid present without an active replace item");
>   			ret = -EUCLEAN;
> @@ -175,11 +176,10 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
>   		break;
>   	case BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED:
>   	case BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED:
> -		dev_replace->srcdev = btrfs_find_device(fs_info->fs_devices,
> -						src_devid, NULL, NULL);
> -		dev_replace->tgtdev = btrfs_find_device(fs_info->fs_devices,
> -							BTRFS_DEV_REPLACE_DEVID,
> -							NULL, NULL);
> +		dev_replace->tgtdev = btrfs_find_device(fs_info->fs_devices, &args);
> +		args.devid = src_devid;
> +		dev_replace->srcdev = btrfs_find_device(fs_info->fs_devices, &args);
> +
>   		/*
>   		 * allow 'btrfs dev replace_cancel' if src/tgt device is
>   		 * missing
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 9eb0c1eb568e..b8508af4e539 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1602,6 +1602,7 @@ static int exclop_start_or_cancel_reloc(struct btrfs_fs_info *fs_info,
>   static noinline int btrfs_ioctl_resize(struct file *file,
>   					void __user *arg)
>   {
> +	BTRFS_DEV_LOOKUP_ARGS(args);
>   	struct inode *inode = file_inode(file);
>   	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>   	u64 new_size;
> @@ -1657,7 +1658,8 @@ static noinline int btrfs_ioctl_resize(struct file *file,
>   		btrfs_info(fs_info, "resizing devid %llu", devid);
>   	}
>   
> -	device = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
> +	args.devid = devid;
> +	device = btrfs_find_device(fs_info->fs_devices, &args);
>   	if (!device) {
>   		btrfs_info(fs_info, "resizer unable to find device %llu",
>   			   devid);
> @@ -3317,22 +3319,21 @@ static long btrfs_ioctl_fs_info(struct btrfs_fs_info *fs_info,
>   static long btrfs_ioctl_dev_info(struct btrfs_fs_info *fs_info,
>   				 void __user *arg)
>   {
> +	BTRFS_DEV_LOOKUP_ARGS(args);
>   	struct btrfs_ioctl_dev_info_args *di_args;
>   	struct btrfs_device *dev;
>   	int ret = 0;
> -	char *s_uuid = NULL;
>   
>   	di_args = memdup_user(arg, sizeof(*di_args));
>   	if (IS_ERR(di_args))
>   		return PTR_ERR(di_args);
>   
> +	args.devid = di_args->devid;
>   	if (!btrfs_is_empty_uuid(di_args->uuid))
> -		s_uuid = di_args->uuid;
> +		args.uuid = di_args->uuid;
>   
>   	rcu_read_lock();
> -	dev = btrfs_find_device(fs_info->fs_devices, di_args->devid, s_uuid,
> -				NULL);
> -
> +	dev = btrfs_find_device(fs_info->fs_devices, &args);
>   	if (!dev) {
>   		ret = -ENODEV;
>   		goto out;
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index bd3cd7427391..1e29b9aa45df 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -4067,6 +4067,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
>   		    u64 end, struct btrfs_scrub_progress *progress,
>   		    int readonly, int is_dev_replace)
>   {
> +	struct btrfs_dev_lookup_args args = { .devid = devid };
>   	struct scrub_ctx *sctx;
>   	int ret;
>   	struct btrfs_device *dev;
> @@ -4114,7 +4115,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
>   		goto out_free_ctx;
>   
>   	mutex_lock(&fs_info->fs_devices->device_list_mutex);
> -	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
> +	dev = btrfs_find_device(fs_info->fs_devices, &args);
>   	if (!dev || (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) &&
>   		     !is_dev_replace)) {
>   		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
> @@ -4287,11 +4288,12 @@ int btrfs_scrub_cancel_dev(struct btrfs_device *dev)
>   int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
>   			 struct btrfs_scrub_progress *progress)
>   {
> +	struct btrfs_dev_lookup_args args = { .devid = devid };
>   	struct btrfs_device *dev;
>   	struct scrub_ctx *sctx = NULL;
>   
>   	mutex_lock(&fs_info->fs_devices->device_list_mutex);
> -	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
> +	dev = btrfs_find_device(fs_info->fs_devices, &args);
>   	if (dev)
>   		sctx = dev->scrub_ctx;
>   	if (sctx)
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 5f19d0863094..a729f532749d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -812,9 +812,13 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   
>   		device = NULL;
>   	} else {
> +		struct btrfs_dev_lookup_args args = {
> +			.devid = devid,
> +			.uuid = disk_super->dev_item.uuid,
> +		};
> +
>   		mutex_lock(&fs_devices->device_list_mutex);
> -		device = btrfs_find_device(fs_devices, devid,
> -				disk_super->dev_item.uuid, NULL);
> +		device = btrfs_find_device(fs_devices, &args);
>   
>   		/*
>   		 * If this disk has been pulled into an fs devices created by
> @@ -2323,10 +2327,9 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
>   static struct btrfs_device *btrfs_find_device_by_path(
>   		struct btrfs_fs_info *fs_info, const char *device_path)
>   {
> +	BTRFS_DEV_LOOKUP_ARGS(args);
>   	int ret = 0;
>   	struct btrfs_super_block *disk_super;
> -	u64 devid;
> -	u8 *dev_uuid;
>   	struct block_device *bdev;
>   	struct btrfs_device *device;
>   
> @@ -2335,14 +2338,14 @@ static struct btrfs_device *btrfs_find_device_by_path(
>   	if (ret)
>   		return ERR_PTR(ret);
>   
> -	devid = btrfs_stack_device_id(&disk_super->dev_item);
> -	dev_uuid = disk_super->dev_item.uuid;
> +	args.devid = btrfs_stack_device_id(&disk_super->dev_item);
> +	args.uuid = disk_super->dev_item.uuid;
>   	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
> -		device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
> -					   disk_super->metadata_uuid);
> +		args.fsid = disk_super->metadata_uuid;
>   	else
> -		device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
> -					   disk_super->fsid);
> +		args.fsid = disk_super->fsid;
> +
> +	device = btrfs_find_device(fs_info->fs_devices, &args);
>   
>   	btrfs_release_disk_super(disk_super);
>   	if (!device)
> @@ -2358,11 +2361,12 @@ struct btrfs_device *btrfs_find_device_by_devspec(
>   		struct btrfs_fs_info *fs_info, u64 devid,
>   		const char *device_path)
>   {
> +	BTRFS_DEV_LOOKUP_ARGS(args);
>   	struct btrfs_device *device;
>   
>   	if (devid) {
> -		device = btrfs_find_device(fs_info->fs_devices, devid, NULL,
> -					   NULL);
> +		args.devid = devid;
> +		device = btrfs_find_device(fs_info->fs_devices, &args);
>   		if (!device)
>   			return ERR_PTR(-ENOENT);
>   		return device;
> @@ -2372,14 +2376,11 @@ struct btrfs_device *btrfs_find_device_by_devspec(
>   		return ERR_PTR(-EINVAL);
>   
>   	if (strcmp(device_path, "missing") == 0) {
> -		/* Find first missing device */
> -		list_for_each_entry(device, &fs_info->fs_devices->devices,
> -				    dev_list) {
> -			if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
> -				     &device->dev_state) && !device->bdev)
> -				return device;
> -		}
> -		return ERR_PTR(-ENOENT);
> +		args.missing = true;
> +		device = btrfs_find_device(fs_info->fs_devices, &args);
> +		if (!device)
> +			return ERR_PTR(-ENOENT);
> +		return device;
>   	}
>   
>   	return btrfs_find_device_by_path(fs_info, device_path);
> @@ -2459,6 +2460,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>    */
>   static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
>   {
> +	BTRFS_DEV_LOOKUP_ARGS(args);
>   	struct btrfs_fs_info *fs_info = trans->fs_info;
>   	struct btrfs_root *root = fs_info->chunk_root;
>   	struct btrfs_path *path;
> @@ -2468,7 +2470,6 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
>   	struct btrfs_key key;
>   	u8 fs_uuid[BTRFS_FSID_SIZE];
>   	u8 dev_uuid[BTRFS_UUID_SIZE];
> -	u64 devid;
>   	int ret;
>   
>   	path = btrfs_alloc_path();
> @@ -2505,13 +2506,14 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
>   
>   		dev_item = btrfs_item_ptr(leaf, path->slots[0],
>   					  struct btrfs_dev_item);
> -		devid = btrfs_device_id(leaf, dev_item);
> +		args.devid = btrfs_device_id(leaf, dev_item);
>   		read_extent_buffer(leaf, dev_uuid, btrfs_device_uuid(dev_item),
>   				   BTRFS_UUID_SIZE);
>   		read_extent_buffer(leaf, fs_uuid, btrfs_device_fsid(dev_item),
>   				   BTRFS_FSID_SIZE);
> -		device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
> -					   fs_uuid);
> +		args.uuid = dev_uuid;
> +		args.fsid = fs_uuid;
> +		device = btrfs_find_device(fs_info->fs_devices, &args);
>   		BUG_ON(!device); /* Logic error */
>   
>   		if (device->fs_devices->seeding) {
> @@ -6753,6 +6755,32 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
>   	return BLK_STS_OK;
>   }
>   
> +static inline bool dev_args_match_fs_devices(struct btrfs_dev_lookup_args *args,
> +					     struct btrfs_fs_devices *fs_devices)
> +{
> +	if (args->fsid == NULL)
> +		return true;
> +	if (!memcmp(fs_devices->metadata_uuid, args->fsid, BTRFS_FSID_SIZE))
> +		return true;
> +	return false;
> +}
> +
> +static inline bool dev_args_match_device(struct btrfs_dev_lookup_args *args,
> +					 struct btrfs_device *device)
> +{
> +	ASSERT((args->devid != (u64)-1) || args->missing);
> +	if ((args->devid != (u64)-1) && device->devid != args->devid)
> +		return false;
> +	if (args->uuid && memcmp(device->uuid, args->uuid, BTRFS_UUID_SIZE))
> +		return false;
> +	if (!args->missing)
> +		return true;
> +	if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state) &&
> +	    !device->bdev)
> +		return true;
> +	return false;
> +}
> +
>   /*
>    * Find a device specified by @devid or @uuid in the list of @fs_devices, or
>    * return NULL.
> @@ -6761,30 +6789,24 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
>    * only devid is used.
>    */
>   struct btrfs_device *btrfs_find_device(struct btrfs_fs_devices *fs_devices,
> -				       u64 devid, u8 *uuid, u8 *fsid)
> +				       struct btrfs_dev_lookup_args *args)
>   {
>   	struct btrfs_device *device;
>   	struct btrfs_fs_devices *seed_devs;
>   
> -	if (!fsid || !memcmp(fs_devices->metadata_uuid, fsid, BTRFS_FSID_SIZE)) {
> +	if (dev_args_match_fs_devices(args, fs_devices)) {
>   		list_for_each_entry(device, &fs_devices->devices, dev_list) {
> -			if (device->devid == devid &&
> -			    (!uuid || memcmp(device->uuid, uuid,
> -					     BTRFS_UUID_SIZE) == 0))
> +			if (dev_args_match_device(args, device))
>   				return device;
>   		}
>   	}
>   
>   	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
> -		if (!fsid ||
> -		    !memcmp(seed_devs->metadata_uuid, fsid, BTRFS_FSID_SIZE)) {
> -			list_for_each_entry(device, &seed_devs->devices,
> -					    dev_list) {
> -				if (device->devid == devid &&
> -				    (!uuid || memcmp(device->uuid, uuid,
> -						     BTRFS_UUID_SIZE) == 0))
> -					return device;
> -			}
> +		if (!dev_args_match_fs_devices(args, seed_devs))
> +			continue;
> +		list_for_each_entry(device, &seed_devs->devices, dev_list) {
> +			if (dev_args_match_device(args, device))
> +				return device;
>   		}
>   	}
>   
> @@ -6950,6 +6972,7 @@ static void warn_32bit_meta_chunk(struct btrfs_fs_info *fs_info,
>   static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
>   			  struct btrfs_chunk *chunk)
>   {
> +	BTRFS_DEV_LOOKUP_ARGS(args);
>   	struct btrfs_fs_info *fs_info = leaf->fs_info;
>   	struct extent_map_tree *map_tree = &fs_info->mapping_tree;
>   	struct map_lookup *map;
> @@ -7026,12 +7049,12 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
>   	for (i = 0; i < num_stripes; i++) {
>   		map->stripes[i].physical =
>   			btrfs_stripe_offset_nr(leaf, chunk, i);
> -		devid = btrfs_stripe_devid_nr(leaf, chunk, i);
> +		devid = args.devid = btrfs_stripe_devid_nr(leaf, chunk, i);
>   		read_extent_buffer(leaf, uuid, (unsigned long)
>   				   btrfs_stripe_dev_uuid_nr(chunk, i),
>   				   BTRFS_UUID_SIZE);
> -		map->stripes[i].dev = btrfs_find_device(fs_info->fs_devices,
> -							devid, uuid, NULL);
> +		args.uuid = uuid;
> +		map->stripes[i].dev = btrfs_find_device(fs_info->fs_devices, &args);
>   		if (!map->stripes[i].dev &&
>   		    !btrfs_test_opt(fs_info, DEGRADED)) {
>   			free_extent_map(em);
> @@ -7149,6 +7172,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
>   static int read_one_dev(struct extent_buffer *leaf,
>   			struct btrfs_dev_item *dev_item)
>   {
> +	BTRFS_DEV_LOOKUP_ARGS(args);
>   	struct btrfs_fs_info *fs_info = leaf->fs_info;
>   	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>   	struct btrfs_device *device;
> @@ -7157,11 +7181,13 @@ static int read_one_dev(struct extent_buffer *leaf,
>   	u8 fs_uuid[BTRFS_FSID_SIZE];
>   	u8 dev_uuid[BTRFS_UUID_SIZE];
>   
> -	devid = btrfs_device_id(leaf, dev_item);
> +	devid = args.devid = btrfs_device_id(leaf, dev_item);
>   	read_extent_buffer(leaf, dev_uuid, btrfs_device_uuid(dev_item),
>   			   BTRFS_UUID_SIZE);
>   	read_extent_buffer(leaf, fs_uuid, btrfs_device_fsid(dev_item),
>   			   BTRFS_FSID_SIZE);
> +	args.uuid = dev_uuid;
> +	args.fsid = fs_uuid;
>   
>   	if (memcmp(fs_uuid, fs_devices->metadata_uuid, BTRFS_FSID_SIZE)) {
>   		fs_devices = open_seed_devices(fs_info, fs_uuid);
> @@ -7169,8 +7195,7 @@ static int read_one_dev(struct extent_buffer *leaf,
>   			return PTR_ERR(fs_devices);
>   	}
>   
> -	device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
> -				   fs_uuid);
> +	device = btrfs_find_device(fs_info->fs_devices, &args);
>   	if (!device) {
>   		if (!btrfs_test_opt(fs_info, DEGRADED)) {
>   			btrfs_report_missing_device(fs_info, devid,
> @@ -7839,12 +7864,14 @@ static void btrfs_dev_stat_print_on_load(struct btrfs_device *dev)
>   int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
>   			struct btrfs_ioctl_get_dev_stats *stats)
>   {
> +	BTRFS_DEV_LOOKUP_ARGS(args);
>   	struct btrfs_device *dev;
>   	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>   	int i;
>   
>   	mutex_lock(&fs_devices->device_list_mutex);
> -	dev = btrfs_find_device(fs_info->fs_devices, stats->devid, NULL, NULL);
> +	args.devid = stats->devid;
> +	dev = btrfs_find_device(fs_info->fs_devices, &args);
>   	mutex_unlock(&fs_devices->device_list_mutex);
>   
>   	if (!dev) {
> @@ -7920,6 +7947,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
>   				 u64 chunk_offset, u64 devid,
>   				 u64 physical_offset, u64 physical_len)
>   {
> +	struct btrfs_dev_lookup_args args = { .devid = devid };
>   	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
>   	struct extent_map *em;
>   	struct map_lookup *map;
> @@ -7975,7 +8003,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
>   	}
>   
>   	/* Make sure no dev extent is beyond device boundary */
> -	dev = btrfs_find_device(fs_info->fs_devices, devid, NULL, NULL);
> +	dev = btrfs_find_device(fs_info->fs_devices, &args);
>   	if (!dev) {
>   		btrfs_err(fs_info, "failed to find devid %llu", devid);
>   		ret = -EUCLEAN;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index c7ac43d8a7e8..fa9a56c37d45 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -452,6 +452,19 @@ struct btrfs_balance_control {
>   	struct btrfs_balance_progress stat;
>   };
>   
> +struct btrfs_dev_lookup_args {
> +	u64 devid;
> +	u8 *uuid;
> +	u8 *fsid;
> +	bool missing;
> +};
> +
> +/* We have to init to -1 because BTRFS_DEV_REPLACE_DEVID is 0 */
> +#define BTRFS_DEV_LOOKUP_ARGS_INIT { .devid = (u64)-1 }
> +
> +#define BTRFS_DEV_LOOKUP_ARGS(name) \
> +	struct btrfs_dev_lookup_args name = BTRFS_DEV_LOOKUP_ARGS_INIT
> +
>   enum btrfs_map_op {
>   	BTRFS_MAP_READ,
>   	BTRFS_MAP_WRITE,
> @@ -517,7 +530,7 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len);
>   int btrfs_grow_device(struct btrfs_trans_handle *trans,
>   		      struct btrfs_device *device, u64 new_size);
>   struct btrfs_device *btrfs_find_device(struct btrfs_fs_devices *fs_devices,
> -				       u64 devid, u8 *uuid, u8 *fsid);
> +				       struct btrfs_dev_lookup_args *args);
>   int btrfs_shrink_device(struct btrfs_device *device, u64 new_size);
>   int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *path);
>   int btrfs_balance(struct btrfs_fs_info *fs_info,
> 


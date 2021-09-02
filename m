Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303883FED17
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 13:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhIBLp3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 07:45:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43468 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233831AbhIBLp0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Sep 2021 07:45:26 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 182AqiCp029901;
        Thu, 2 Sep 2021 11:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kYyBf5yHAjMI/pfNTa5X8o55OT8/NDuM2imd+f5UDlg=;
 b=B6luj13MyBs8S9f8jCt/nwn0Z47GZzZOhzcmX5h7vN6LGkgpUnkx6KaIRrrQPjub8xTR
 j/fANwJ533oqO5H/oiS1GgIrexWrBXf1+Tzj4aFk1POynIG5t+sjTsBw17bx/k2RmTsV
 +vQLuw2dXAZioA8vsn3wxT67obsZYhXxtwuupLhziM/7au7ue3i7+vrBB2ERDYWq2p9l
 4+7r5juk7Y07gtN5KRdDsfojvJuexj8N0WNkd3X4+fR8DZu4OVawQHyJXV69UkLfWqiW
 zn3Pf1o5gVlzgX2w1pwm4D1Nl0RDVgcIXEtvMQXcOlAt8QAr81C17jBWUSCPV1QkMS5n rw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=kYyBf5yHAjMI/pfNTa5X8o55OT8/NDuM2imd+f5UDlg=;
 b=W2rArr9TpRHBUPNArZWe17vTB2xbCAfFzT0T88zNPnBcHsK3fQKHVnAasq2Etqhh7ZDO
 BR578U+ybsrBdisqf+A0AZvUDI6mwk/cV+BBvwt5DapNtHUWzCuuRrOEdi7uSafcuze/
 kl5KQhnHGg7t6QwhqArfdEumsZhNKLHDTij7+PdvgB5MMIQxdE0q3VRMdsbHZPdsmIEp
 7TDbVPKxpYLCwD0WQDDrKgGw1TMde42LJj5axz+04iQBda+MrWhbEdyihrwOB9N/Zg7X
 +H8IaA/YMFdwrN+nLriA021zSDkKI15iwAo+hqwk8hjm1b5Ie8oslqyVkQvxT93NPEzh Pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw02e9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 11:44:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 182BZjMI193449;
        Thu, 2 Sep 2021 11:44:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by aserp3020.oracle.com with ESMTP id 3atdyvdxk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 11:44:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtA72gMeZ6NxHty2hwi3q/GB5UTn50k2SWk11YzvhODMrDdy5pdxsoYE9iF4BEwPUx4QQJgzm2jrdVRjnl+ZYG0sosC1W4JdX9DcetdteDp+dfDAlvZ3LPYVO1CgFtlVwPGc6OjFQBoXUxQgCDg7f7amiFs+lAnUfakAjfYcYdPEH+ABR/pWLKUe9KE+9SqVAMrpVpKhjzo9y2yJi0gSj40vQMGdPkip2a+dCcPxIz8U1DM8m3tQZp6/xt7RE0v3nztRLfIj6LS21abGOqpAqvM++ipAjzt+5EjI53Nvwy//53kIZkPqqJO9l/NvmEM8a3oaKrHZdLAoO85D1lI/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kYyBf5yHAjMI/pfNTa5X8o55OT8/NDuM2imd+f5UDlg=;
 b=btZMhxB8W7v5K1wNFSxYvIgfrRa+5UfyFyZmvn343TNvThp8i2ol8uAhp69f5EkrOIGDrfHJI3kDLu8ttCCCgQvvie0wVSflW/XXHlQMcpjzr5EWFk6m3vhrnYEeq0V6FEvG2fbUachEGzsCNLAOsPsX0V9e9RgTXG6FsHwYa6kwfPxinEA7VkQaqblVFceSchLldr1UFYZjL3bC3dhG7NyNDgpiuaoMs3BmANJPyE1uDNj6jfRjKlagnEbyTfj3BxOmmV94LDRIYnhEd5kJ9Yk9rSnuAXJxVXJViczNDv3spc7Qp1Y2CI0db/AJRe3kdfy9FYRg9m8489hJ9atolA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYyBf5yHAjMI/pfNTa5X8o55OT8/NDuM2imd+f5UDlg=;
 b=aBv/eUikN2WrHxZbaMawnLDD0kg9rYba2qcNIXh2mZHjBmWK8lIxcLPfWYht4djhvLQlANIyUz1fllS+FRS/vMu4sa+Z8+EgHv8NFl05udS8ki2k+q2jrD+c7lJUMHI9K82bdmf6CFVPJCxwPXSjoOhZ6zFrVqO0mJTjua7rNbM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2994.namprd10.prod.outlook.com (2603:10b6:208:72::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Thu, 2 Sep
 2021 11:44:21 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%6]) with mapi id 15.20.4478.020; Thu, 2 Sep 2021
 11:44:21 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210902100643.1075385-1-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <b2f9ea09-7fdb-dd3f-2e58-3cdfed65cf12@oracle.com>
Date:   Thu, 2 Sep 2021 19:44:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210902100643.1075385-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0052.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::21)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.109] (39.109.186.25) by SG2P153CA0052.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.1 via Frontend Transport; Thu, 2 Sep 2021 11:44:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3773cc8e-183f-41c2-ea4d-08d96e070136
X-MS-TrafficTypeDiagnostic: BL0PR10MB2994:
X-Microsoft-Antispam-PRVS: <BL0PR10MB299441FE1FB3421FB6CB98F9E5CE9@BL0PR10MB2994.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jj0a9aVDeEI/K9D4+2Gt8JJL3mn+/N1CLYqtNujLOGto7Cw+l7FK0zvwXzgugHdqlKGvJrMklGto57soE98mhiS5cFjBuOZcUAEbbQBgR1euN/omSO48PKeMHXLU94BIq3o0BRdi+L67eO1KT/nWQTsAGYDa/oN/HhIGeSd/72cNrZMuJcOLwpkKHDnx4UBqe8zCM28NTXZ4JDmpsTuWvNA1u+eCxVyTAd4t7iCRQOZco1ZQpd0RBWiV1JB/6pD7xPk5tOSW/vx/L8r//iyzjXCf6YEO/DMwgBncvgGYVMNGai/z+EyI4/Upxe7sotnE2g7TJpUeUiKDtQ9hWYFHtpiEI6QFAoZAc4al+qHQgCXmmZnNl+Impxoe2gXRckXy13pRPQRQZEA9jsJ0qIJQTSdNfbTzwNHBdMgosyTp5h1STeh9tlLKIUr5ZRy7aSoAQm4haDAXS1zOLBFru9z0aSXtIvRDmdP0hnHXvo/romj/iHHm/FcoIzSmOb/rvomxi6uvDa+sx1LeAcl1sMwOu/akRau79rwHHNavY4TYzTDHRf60z9sK74PR0q9DnJZYJ+8uAWO9e9iEEvsT00AVVgmdu63gg+oU0I45yOLa/q6er0Q6Asb0OlN4hK6gn9p2aHbVQ4mHjxKGon7RvlCMEizliDsk25x+Wvb+SApHNQvzGdcncNaDRXZXyBCoJUU8xutIULQHoP/sSW2mB5DUC+EkS597+A8CCcO8aMHFTOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(376002)(39860400002)(136003)(31686004)(8676002)(66556008)(478600001)(16576012)(316002)(2906002)(5660300002)(66476007)(6666004)(186003)(66946007)(83380400001)(44832011)(86362001)(956004)(38100700002)(6486002)(36756003)(2616005)(8936002)(31696002)(53546011)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkNOcmtJRkVvdGlmeVJhSC9iVDJUVWhHbUpkL1FUWHdFeTFEMWtoM21xdTVG?=
 =?utf-8?B?ZXNncys4SlM0OFE2U01YRGVrajJ3R1JUeU1mMitzcENzeVFvcVFUQzU2OEE1?=
 =?utf-8?B?OXFPNld2RURJV2h4VGtURy9wR1Z2N1EvRzdocDBlSEZ6V1pxK1lDNTRRcnll?=
 =?utf-8?B?QllJL0oxVVE4SUl1aCtLY2szTlRzSGRtYVplcnZDUjIxM0JwUERWMk9MNUhM?=
 =?utf-8?B?WjgrTGljODJRSXEza2E5aGpFNjNXcmFPQUpjVUkycWo5a1ptYmx2V0Fybkd2?=
 =?utf-8?B?YytNOVpycGZmK3M0dm93dEFnUFdOYk5SUUVJdXBjOSs5akV1c1J1Vm1lRWR1?=
 =?utf-8?B?N2pOR0VaQnRhb1JGSzNNWWFwQjAzMWg1NkN0dG9UWE9qWUNPNEk5RUpDVnRv?=
 =?utf-8?B?VnBVTTlGLzcvVEpOeUcvTlhpaXhwVTkyVGJwYmRobXpFS0wxMGlxUU56Wld0?=
 =?utf-8?B?STlkcWVYYUVwQUJkVHNYZnZaakJ3VVhjT3RmeWV3bDhBZDcvOFJhQ0xkeHRL?=
 =?utf-8?B?Zi9aSzhTRHpmMEk4clE5M1pLeURNVTVuTHM1NWNTVmhRUVRYaW9HQkdEZ0t4?=
 =?utf-8?B?cmI5UHNQSGNxd1ZuaEJ1UVFaUHRmcFJuUUNWR3RqQ243TmN1VlZtRzd3a2xW?=
 =?utf-8?B?RVBDQlJnVjMxNzBqdjhZaGVyQjJSd3VMQmQ0VkRrSnN2SHV6QndoblBCWURk?=
 =?utf-8?B?RWY0L3BBbFBPd1AxZmgxTlEzckxnSDZJTTNlRmRTcmhWbWIxMU9tRFVGTENs?=
 =?utf-8?B?T2FTeUcrWjA3WHZlaE1nY0YxeEw5Z09wOHBvWGJxMUdxUGhPZkRXMzJOTi9D?=
 =?utf-8?B?TmRtaktJRVA5TUdRUlJsOG9idEtzbGJRdzkwUkRsV2kyZnZaNEg3VnZkVXZ1?=
 =?utf-8?B?cVZJY1BLMEY2ZVpHRkw2bkh1KzF2VFBZMk1rVHhJdm1DY1pOS0s5NCtJSE1R?=
 =?utf-8?B?YlVQN1pMU0xoelNuWEp0SkNQNkc1M21MakVoUTlpa0EzejFvdGhwOEZVb0I5?=
 =?utf-8?B?Z0NLWjNyaWhZWEpEdHFqQ01XYjR6bm1tRTAxdnkzeDVoUDIwSFZtMjBHWGxi?=
 =?utf-8?B?Q1hSUXlqN1BUei9rOEw2TW1FcVI2WXpjZ1B2QjJxVjB5REwrc0lwYlEyRDdZ?=
 =?utf-8?B?V1JsQmNtV1hWMTR0S0NPR2dIdGR1SVZFQXozSnpQa0t6aWVJRHdkYVRuaysx?=
 =?utf-8?B?QXVRWDgrMWN6K1VQTHlUcDlaYVR6ZzJlRGw2Q2Y5NXQwWG5FSC94d3lSY2tl?=
 =?utf-8?B?Sk8zc2ZncE4zZ2kvOXZqMUdseGpqdFN6Y0Q3N1p4NlZOVnROQndCUUljVlFa?=
 =?utf-8?B?YmRPTThQZFR4cks2NDREOWEzVFB5T0tNSElIWWorZFN1anozdUlBaXJtT1FE?=
 =?utf-8?B?YUVsL3RTajdSMmVZSE13dUZGaEtpS0JXREVsS0xGS1A4cGJEcThZWXFhVnor?=
 =?utf-8?B?akpCQ1ZGVGRQdlNGM3JSTDNhVW1hUGkzUEZ1ODVuaGl2TVlSZkFtNlN4cGxa?=
 =?utf-8?B?ZDh4LzVwa1NiVFpIUEp5VUEyeGFCa3dybTk4bkFLdkxYakFXT2wvKzlodGIz?=
 =?utf-8?B?M0NocXlKbEYrRVF2emNNdlQ2RmZERTMyOWxJK0JVbTJNcXAxbjBCWG9DczQ0?=
 =?utf-8?B?bW55a3kweEg3Z2JGd1pVTDRWQUJKalhCRXljblUzOFZMcis3cDV5cG01OHRL?=
 =?utf-8?B?eUx3UklKeVByRmVlM0tMVWdRNkMrRGhBbG9kbGg3S2R5eGg5K0E4LzRRZmw5?=
 =?utf-8?Q?kSK9vUNXr/zHShjzL40tBWcG0A1gMYSbuXxgRSW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3773cc8e-183f-41c2-ea4d-08d96e070136
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 11:44:21.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrPbd9cbysGYc1MSTAV3gqv8C6P9l0KO76sIpv1YZcQQzTVklC78KJRnHdrCQCPQFW2TTNu/pcN4SoiNhJ4d2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2994
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109020072
X-Proofpoint-GUID: ROH_NRNytoCK9oobODWnaOWe802CFP0H
X-Proofpoint-ORIG-GUID: ROH_NRNytoCK9oobODWnaOWe802CFP0H
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/09/2021 18:06, Nikolay Borisov wrote:
> Currently when a device is missing for a mounted filesystem the output
> that is produced is unhelpful:
> 
> Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
> 	Total devices 2 FS bytes used 128.00KiB
> 	devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
> 	*** Some devices missing
> 
> While the context which prints this is perfectly capable of showing
> which device exactly is missing, like so:
> 
> Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
> 	Total devices 2 FS bytes used 128.00KiB
> 	devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
> 	devid    2 size 0 used 0 path /dev/loop1 ***MISSING***
> 
> This is a lot more usable output as it presents the user with the id
> of the missing device and its path.

Looks better. How does this fair in the case of unmounted btrfs? Because
btrfs fi show is supposed to work on an unmounted btrfs to help find
btrfs devices.

Thx, Anand


> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   cmds/filesystem.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index db8433ba3542..ff13de6ac990 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -295,7 +295,6 @@ static int print_one_fs(struct btrfs_ioctl_fs_info_args *fs_info,
>   {
>   	int i;
>   	int fd;
> -	int missing = 0;
>   	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
>   	struct btrfs_ioctl_dev_info_args *tmp_dev_info;
>   	int ret;
> @@ -325,8 +324,10 @@ static int print_one_fs(struct btrfs_ioctl_fs_info_args *fs_info,
>   		/* Add check for missing devices even mounted */
>   		fd = open((char *)tmp_dev_info->path, O_RDONLY);
>   		if (fd < 0) {
> -			missing = 1;
> +			printf("\tdevid %4llu size 0 used 0 path %s ***MISSING***\n",
> +					tmp_dev_info->devid,tmp_dev_info->path);
>   			continue;
> +
>   		}
>   		close(fd);
>   		canonical_path = path_canonicalize((char *)tmp_dev_info->path);
> @@ -339,8 +340,6 @@ static int print_one_fs(struct btrfs_ioctl_fs_info_args *fs_info,
>   		free(canonical_path);
>   	}
>   
> -	if (missing)
> -		printf("\t*** Some devices missing\n");
>   	printf("\n");
>   	return 0;
>   }
> 


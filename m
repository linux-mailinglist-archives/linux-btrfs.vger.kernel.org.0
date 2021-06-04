Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3C339B9FE
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 15:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhFDNnK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 09:43:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55912 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhFDNnK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 09:43:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154DYCl9194850;
        Fri, 4 Jun 2021 13:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lAqWB6USfdQuH5CG31FS4zCAIvsxRmcGzYmtpx5060A=;
 b=vx09cSOvnFCOhtXsRpZ/pt/OSRqS5oEYaQCy65wp5ibc/yeHvbD8U6Ot8Iwxus0H9gTY
 mZjiIYZeFPxrsC4vQBKwvy/Vsap6KYm/BzlOmOJAsJT0BEIwELQwusGHniV6j3/fUuHx
 bY7WT3wWudx8GqyKne2t9jBnDVFKRwtSLOIk6/g91DnGScnUw+VIcvFlBaeWJqLqLaHQ
 Opa1iczQGjdEmaMON0ToIVy0Xs/h5uaL1R4FY9qwdkMz/BY9AjFPP1r+tcwsH4s9VBMH
 qtoLxXvaTA1gY5utuB7BMU8q024PgyS7O+Fiv9KXEsuEICMjQneajxzHWO/fanpHskb6 ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 38ue8pnyvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 13:41:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154DaGHM015056;
        Fri, 4 Jun 2021 13:41:20 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by userp3030.oracle.com with ESMTP id 38uar08k6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 13:41:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRm3+pj7OBXmyEsURltyvS3eNDv7LAMkdC7xGVpOrQhjnxaaGVu4lnvPiglp25aOQbx79s5RPJ9XwW4eS/ut2x0BQ7RhgMcJNjXS/dFhE+rl4qrLBHOGGqgP/i6UiD8rJx9Hh4Hv3eJP1HDqGloYocSLJizRag+fY3rgKS90/pyo9mVMqW0ToxDVTZc7sVybBAx0DSl+fqVEmqlTMJobdi5g9SrqjEBB8Ezq/bcHotU4MH83w8YEJBmVE996cPFF3UJjvuHAz9jishqTOPBAGoseg2j6gqAhzK++N+A1kWwTHj/g1iNAVfUmDYOYXMatahpNbZHNiZ+Ts9xmXtenuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAqWB6USfdQuH5CG31FS4zCAIvsxRmcGzYmtpx5060A=;
 b=DTod8iiSAzDOErn9w2ceyDaBV4jEw5tJ9tDiatTIpkPYSHpggzoRpyhLZircdgI2thQMX4l45gpcwnsXWwHHu5z2whSdCMVefX9wAQ3mV2fyWP0BWZoeExlvSiMd6+94Xg0/Sfl7ZsRIWcp6Hdw4ye7EHYRVVP+AGf+1RUOLYIry8Pjk0va2xuTYc5UZJULvcXw52wOlX/klaJMgeRgnmwE6QSl5hd3ZMlaJ1pYsaSY29dJnsvUSYQFSeylpr0H3j3I+QVMbZ1iUuHF8jG/+WPlDGAfI19EOKw/o9yzADJhQhBOscB62bwUtGNwm4lghKKQ1fuUjzxrTt+/ZkNrSFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAqWB6USfdQuH5CG31FS4zCAIvsxRmcGzYmtpx5060A=;
 b=dKP9nubj2c+ZwcxVAqyFHSICl5URagua8rgXafPEEesXCXK9g65p4GbojZQVhMqWYQN/VJ8nXeWY1GvkKIzV9HwE4FuqCKMTM+qbIo1NLSDRMikT7memO+6P6T/a0l53/zwEpqqQVKfXCXOqwdLBH/PMcGdoKvLr9iZyh/st3cM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4094.namprd10.prod.outlook.com (2603:10b6:208:11e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Fri, 4 Jun
 2021 13:41:18 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%7]) with mapi id 15.20.4195.025; Fri, 4 Jun 2021
 13:41:18 +0000
Subject: Re: [PATCH] btrfs: sysfs: export dev stats in devinfo directory
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210604132058.11334-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <5aeca0cd-c6b2-939a-6f83-7ea5722076dc@oracle.com>
Date:   Fri, 4 Jun 2021 21:41:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <20210604132058.11334-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR03CA0160.apcprd03.prod.outlook.com
 (2603:1096:4:c9::15) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR03CA0160.apcprd03.prod.outlook.com (2603:1096:4:c9::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Fri, 4 Jun 2021 13:41:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0bd7734-67c2-4737-a24b-08d9275e6e2d
X-MS-TrafficTypeDiagnostic: MN2PR10MB4094:
X-Microsoft-Antispam-PRVS: <MN2PR10MB40941AA87C03E6F2EC64306CE53B9@MN2PR10MB4094.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/9tJ/OiFqtOoyR41UbrACZFb/gtG6BvNYTNk12uHaYswZEgy+14NW3siR0mCOGtGIRrADlOll+v2PrrdTkUXY2lpWXwzEg+Au3bAkn2BPS3mybS+OsgiDnVex+MdsEN0cBdj7Xu0B4uJ0GOhcUxjvD3MQ1eC3W8OvMk0AHi8lrmHUNQFcq7xOd902zENJPLyHykfKNVGA2gl/TlC2GYcr5QHczGZSsXYspxulGv992usVaY2VT+D8CWPmoH61qPwXWY7dzuLvOQ6l3xk1XdWqK9DgTg33AWXggOUididJpczlrgXqu1XqwcgYJHRLRT9EnHjMZETDtS8aqOiRQyKS6jNelK0s8z4IZ7LIakdZh7W7Bu8ybOc7sEjTS5RGcuLZ75WxE0Ta2BVdjQzH2jEnpDwI9VUHBjwHrsLHKiQ71kEn9y2e4jgzgtb+bdIsaqkZjv3o1OSQLUnhdpifSolIO1Bndns46mvIDEkbL22NwwLut2gvMI6oicgU3/pFDchRV7WbuulRa/cSr5omsGHxv4N4GDQ4MROKZ1vtbfMonIqfuDEt73vJnWT+tc/ByM0x0P6nbCgv5jDR4UWmoDZAFfjjJh5++MZGgJzE/6eM0H9ondngPg086kQiwI1188fY7fKLAakCzxhvmVXffqQB3BU+GrqzI6qNaqqqlc/PZqokNC1gEyDTLKGsmozK9H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(346002)(396003)(366004)(6666004)(36756003)(83380400001)(8936002)(16526019)(8676002)(26005)(2906002)(186003)(5660300002)(478600001)(316002)(86362001)(6486002)(31686004)(16576012)(956004)(2616005)(31696002)(53546011)(66556008)(66476007)(66946007)(38100700002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RGVZbEJqclp5Qk5ZYmEzcE5mbHhkTmpFdzNRTm1ZZmI1TDlpVTVQWER6MkRN?=
 =?utf-8?B?aUgrZFg1M3htZ29SMzhJSjFvNndjOUY0UVpEM3hZYm1MQ0tPVkJxTGJzdGJt?=
 =?utf-8?B?Z0hMWVVISEV1WjlKdStJNE9wWmJCalJWYmNMYVRlWFhWSDhoM3F0MnoydkFB?=
 =?utf-8?B?S1VqOUNwV2hTdnIyd2o5aE90QXM0cGtaVlBOem91c0hwMUZvTnQwTEVJQ002?=
 =?utf-8?B?bnh6K3cvQnQzSUZweCtPZVE0MVhiZkgwZDhlWkw4N2ovOXJpY0MvWGdMd3dQ?=
 =?utf-8?B?cHRkbnRmSGtldEh2ZWdTWGMwdk5SRHBKdnNjN0I1SjAraU85VmZtV296VkVQ?=
 =?utf-8?B?ZVdSdXhlK0NYaGpFbXduSDYyZVlzcktQUTFIcmxrdVlsbDRyU0dKdzBlZFNV?=
 =?utf-8?B?RXJ2VENZVlFFcmRtcGlYUGp2ZitmUVFKWEVCbmcxRUlaU0JCRStQOFlHbnNl?=
 =?utf-8?B?ZUVoMTBYR0NTdUI0R25zTUJzSlhtMlJJeW4wMXRlVzB6TlpmMEdSQ3NaZllY?=
 =?utf-8?B?TWdOeWpPSm50VzIybW5FQWtKZFpMc3BJU2pjaTVKTko2TUR4YkxZQlZFZWcy?=
 =?utf-8?B?TkVFTldhQUI2blZYWkFobDlxOFpCYjkvYTNFKy9WM0Z4UnpINHE0ZDRYRTd1?=
 =?utf-8?B?ZXJqcG1zUGNOS2RvN3Vka1NydEVIQ2JoaFJCeDArUHJBWWRWR0NzQkZHRCtS?=
 =?utf-8?B?QlY0Z242S0RSNFdoK083WldpOXIzNnVUUTdNVmRHc3V6MFNIVFRBMFFkb294?=
 =?utf-8?B?WFlEVWhQUVE0MnJpVWR6NlJxdXhWQjBKSWtjeEpKTmd5dmw2MllGdWtqTGFu?=
 =?utf-8?B?VHdPdDBma0NHRklpYVpOOHdOWUp4KzNhK1pCSzhXb0VoWndjZ1J3YW1iRVkr?=
 =?utf-8?B?TXNaR2wrend3bUs5VldtbUpSSjNYWXF0dXo2RkZRT2FGVkRWSW9VMVVrODls?=
 =?utf-8?B?S1ord2RkY0hUTWtLcitDSUcxdmo4bEZYamlkMkQ4K2p0K3BPVTZEbGFoQ0lj?=
 =?utf-8?B?QUJ5QzFuZURvaTE2MlUvaU5DK1JGWTh4aDlxOG5laS9CbEpSR1huR3M2Uis3?=
 =?utf-8?B?d0tOL0dMSUlqOGdmZ1FwV09mdVpFZEo4NnZsN3FxUnlHQzhTOVp5WEtzcTFR?=
 =?utf-8?B?R3ptUDhrVkxUV3RId1ZHSkhveWhlcG1ZdlNVTHlQcENSYS94bUtPRVhBbXlp?=
 =?utf-8?B?Rk95NUJhOGt0RmR1ZU9tSllibTllaWZDdUNlWEdSalRMSlQrWUs1WENCL3V4?=
 =?utf-8?B?SStzODA4R0kxWVFJNTc0MDRadW54ZHZnSEpoRnpoWVlxZ0J5VHQwaUxGditu?=
 =?utf-8?B?MHhTUDNGbnlvdUM0WS94L2VHOEVmSHRPSkhnUHVyMzNkZU5YaVhvdFZ2VHRJ?=
 =?utf-8?B?anRqOTkvL3VvWW5MeVdweG9jRTU0czdnM3dwRnI4amxlZzQwTGo1YTlESmlX?=
 =?utf-8?B?VCtheGo4YXZocWwwc2RkcDdLeE9jTTRXVEswN1RaY2ZhZHZHQzZ6VkhYak91?=
 =?utf-8?B?K1VLNEhqMGpmZDcxeHN2ZnRDcHAxVHNPZm5kYTRNbTJnUUlGWGV1QkZSNGFw?=
 =?utf-8?B?NlJ4YUk3MEVhemZRWTl6YktJaFdWRFprcE14MUVrUWFtYnhKVmRLejQ2QmIx?=
 =?utf-8?B?Z2ZLU00xQUF2a3E1ZGNmV2pJSzIzbEtyZzJkQjJYbHlvLzd3QTNNTmZUT3RB?=
 =?utf-8?B?UWx0U3A0aTZpa3VWaW1YV2owa3h1dG5wc2R1TThFRk4vcWlFeUc3NzFqcFor?=
 =?utf-8?Q?HUkGtdByhIVcjzsMsVlqoDoJUSd/WlniJ5tUNMJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bd7734-67c2-4737-a24b-08d9275e6e2d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 13:41:18.2322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGA2ZG5kQOQpQJjj9IOkjM02LNWT11aQw34VD9ggwtC/yXtDFdHfDo/Qm6yQMklgFh1AN6faT16Pq8DrqKTwhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4094
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040105
X-Proofpoint-GUID: jnk-LNu8CA7ofXdrEcpwTdeeRHubA4UU
X-Proofpoint-ORIG-GUID: jnk-LNu8CA7ofXdrEcpwTdeeRHubA4UU
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106040105
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/6/21 9:20 pm, David Sterba wrote:
> The device stats can be read by ioctl, wrapped by command 'btrfs device
> stats'. Provide another source where to read the information in
> /sys/fs/btrfs/FSID/devinfo/DEVID/stats .

  The planned stat here is errors stat.
  So why not rename this to error_stats?

> The format is a list of
> 'key value' pairs one per line, which is common in other stat files.
> The names are the same as used in other device stat outputs.

  Nice!

Thanks, Anand

> The stats are all in one file as it's the snapshot of all available
> stats. The 'one value per file' is not very suitable here. The stats
> should be valid right after the stats item is read from disk, shortly
> after initializing the device, but in any case also print the validity
> status.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/sysfs.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 4b508938e728..3d4c806c4f73 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1495,11 +1495,39 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
>   }
>   BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
>   
> +static ssize_t btrfs_devinfo_stats_show(struct kobject *kobj,
> +		struct kobj_attribute *a, char *buf)
> +{
> +	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
> +						   devid_kobj);
> +
> +	/*
> +	 * Print all at once so we get a snapshot of all values from the same
> +	 * time. Keep them in sync and in order of definition of
> +	 * btrfs_dev_stat_values.
> +	 */
> +	return scnprintf(buf, PAGE_SIZE,
> +		"stats_valid %d\n",
> +		"write_errs %d\n"
> +		"read_errs %d\n"
> +		"flush_errs %d\n"
> +		"corruption_errs %d\n"
> +		"generation_errs %d\n",
> +		!!(device->dev_stats_valid),
> +		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_WRITE_ERRS),
> +		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_READ_ERRS),
> +		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_FLUSH_ERRS),
> +		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_CORRUPTION_ERRS),
> +		btrfs_dev_stat_read(device, BTRFS_DEV_STAT_GENERATION_ERRS));
> +}
> +BTRFS_ATTR(devid, stats, btrfs_devinfo_stats_show);
> +
>   static struct attribute *devid_attrs[] = {
>   	BTRFS_ATTR_PTR(devid, in_fs_metadata),
>   	BTRFS_ATTR_PTR(devid, missing),
>   	BTRFS_ATTR_PTR(devid, replace_target),
>   	BTRFS_ATTR_PTR(devid, scrub_speed_max),
> +	BTRFS_ATTR_PTR(devid, stats),
>   	BTRFS_ATTR_PTR(devid, writeable),
>   	NULL
>   };
> 


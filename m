Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EEE3BA2CD
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 17:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhGBPgY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 11:36:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5238 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231883AbhGBPgX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Jul 2021 11:36:23 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 162FQiYU026626;
        Fri, 2 Jul 2021 15:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=R/BUzr3LDwUNKmDb+KeYYi/fs+6vIk2JU7P/bHdBUuU=;
 b=mDJqSRRYjSE2DTtpKeuM31HBQjMgp7a8ykXYFfTM+FNI3HMgfKbiTLrK+/QwcN8ur+P0
 BZmMjFH/pJUUxXl3mZIUuhPw5UnqTLMWnXtMlK0L52KlWfXFYWwWV4N8o1mt7uUen7Sc
 j8Agh5UtCgFvh5joWzhvNRCzz7CHym67Ut66mAOXx4CdlKneWIyel1oVsjJ/IvYB4gcO
 GMzhjfPs8/FiOeDX1E4J9X3NgMmLxCYgHdQCamk/8DUarUezOyqTXihFGRKs6DH+id6X
 U2zIZHJOGvsgNv/ycGPoxqxyPTEc65X6LSNjw4lp/alJMTqfAmzxYlx5u6jakJ+7bHqi Sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39hxk30uvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 15:33:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 162FQF3V120218;
        Fri, 2 Jul 2021 15:33:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3030.oracle.com with ESMTP id 39dt9p24d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 15:33:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzgJB4XK6Btob3BWOtWOe+1Rji9TrLcitUgaRcLqvVUX7hBpvHKNUcgLH7mlHwQZlG4Mxtlksnok634BK336HyIyEixR/5XlKxQ6QX1CB5rpLBkAGPUuzsr0UH+PdT8idudQ4waGuIPTfkQroVPOclxhrAEozzrtaZSRa9Zx5wDAQEWkw6J3D/K/deLffvgQR7A/+5s0qm/GbX+olLbDD20YBfk+TUuhfWQYAxo4vx6stRF/9serlaiBOSxwktOi6s608yXfHFHcAj/vpnZdNW9z1cta7zIxwgvNK0/eyVIyoKq7vIyxnBThUrEgPPEMBYnHHom71xbL4i7N+2g9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/BUzr3LDwUNKmDb+KeYYi/fs+6vIk2JU7P/bHdBUuU=;
 b=jdRLDXS3NdWshKTZTva1CfvmKTBy+4PDs4Lf3Z5f/Jtl1vHHFIDT+np4/ccVcsVLhzchtpRMcvPV5E5bBOMY0xDvlqdYMT7bcCuMslaGHaIRWHdu6K4k+4niADqsvENPaC0oiNLCAaqrnsefH1hTqlSzufYPelxgwp5r9s94MYh3m8xMBnSI6IuXjppdiwyWkIBaxOYsj+c0uOQdbO5GG2VgTnRi9KBxpZ77ogoukMMbIgXeFxU7ZaDjnwvx70iWfAoP047vT7viBzPv/fyuXBYGvUUx26LZCda8q+DOqW+131lADHXeAv2kN6fP8IVU6snVfpt6M4VnMSaybDCzNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/BUzr3LDwUNKmDb+KeYYi/fs+6vIk2JU7P/bHdBUuU=;
 b=v625Cii5xtJY1ISeiidqoPJucr/uQt19hrcNqgAJ1KPJ/0/Z1WCBzSOQpZi2k1wVhpRiDB0svw3pojWVy/zyLiALZn6A9KXUnygrDT8yIHR77I2tIMNNRLZslgMKVxSzMkwtWc77RqroXdPDQ0H1qO9AZMVpo5cWqPEulXssLxc=
Authentication-Results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4303.namprd10.prod.outlook.com (2603:10b6:208:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Fri, 2 Jul
 2021 15:33:46 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%3]) with mapi id 15.20.4264.028; Fri, 2 Jul 2021
 15:33:46 +0000
Subject: Re: [PATCH v3] btrfs: zoned: revert "btrfs: zoned: fail mount if the
 device does not support zone append"
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <2069666c4c5f68fafe0cfefdbc880fa6b4969217.1625225912.git.johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <5c688f92-e07d-a1d7-685f-f58979ef87bc@oracle.com>
Date:   Fri, 2 Jul 2021 23:33:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <2069666c4c5f68fafe0cfefdbc880fa6b4969217.1625225912.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR03CA0159.apcprd03.prod.outlook.com
 (2603:1096:4:c9::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR03CA0159.apcprd03.prod.outlook.com (2603:1096:4:c9::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.8 via Frontend Transport; Fri, 2 Jul 2021 15:33:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf82b5d2-58ba-4928-1221-08d93d6ec7c3
X-MS-TrafficTypeDiagnostic: MN2PR10MB4303:
X-Microsoft-Antispam-PRVS: <MN2PR10MB430329F891796A5FFF11D664E51F9@MN2PR10MB4303.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:285;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BBQPh97hyTyNlQOWI1cbUwMx6DlK6vuX3fr6rFOiT6mSJbFsBQ7grT8Iw7SI0uvrQr5ucCcZUGkgQ68sS9ortpi1k9Qp3IRTJezoknGRqk4pgwesmn3mgzNOGWXhztTPOC5V3B8g1sFEGUTDOr/bXPbhwee95kug7udvFAf6HyruMDtA1DfhsiR0B9zkkcJdGaXZXMbWQjPA5k8WmxLtNXX/sXlJAoe/SCaBtAy3V+PCMrmUdbypUdmqunSNaC1TcdYHMEDEjiVTWInBAqkNqPPOXA/AcK5dEPZbWPfbbASjwT3Xgm+NIUvN5wY2m3NHyeGj5ZZ5N8d0uMSlHvNojszSySBcCltljUhDeXyzMnMKMYXMly0HEUiPa8QUbeJ2AqcdVSSVDAjqNtJiz/Vdi70wU863LnwAIgnjqegaVckHl4teRGJF0oTWrGHGMgL84RQjdC/ugGSPQa13z9UAfofvXKkNpyQW0VQowPB8ZN2gBlkXHwXzMUA4WwDgsL81VmiEkIVPG/ciFwaPq+/M20Koo+sOtoFgXt3HTOhbDxjTThm1ugTSxiN6XKec4GkirZKpe+XSX8CgvPIzNVNDFwDEwGMsxy/SIt0faTlJUi/593aKbVq++gOO0yYGgMsOo+H1ZtQQe0kVMneTDF040gNpR15GH9gIRc9y+PLJGXztk/BE6BN+T4yCsU1/inZpPTOKRdtUnKR9gAnWyZMD3mSjWszrp0rNjbefCFDESbk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(366004)(396003)(376002)(110136005)(31686004)(66556008)(6486002)(66946007)(4326008)(2616005)(38100700002)(86362001)(36756003)(316002)(54906003)(16576012)(2906002)(956004)(6666004)(31696002)(66476007)(8676002)(186003)(5660300002)(8936002)(53546011)(16526019)(83380400001)(26005)(478600001)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzJtWWExSEdscWdtbDdZL3czVzhlQ1N1VTIvaDFJQWhhSHZ4YnFLOUdtZFNy?=
 =?utf-8?B?R2R2alFocVY1Yk9mUW5tMU1WdWtVWFI5WWhPamxmYVRBRGdRTlZZWEVLOWFI?=
 =?utf-8?B?ZHNsTm4wRGY1aFNpdURudXZRQ0RWSHlvVjNLZ210Tmt0UVhpT0V3SnBpTlV1?=
 =?utf-8?B?OTU5d0Naa2piVERVQS8rTWRCK3B4Y0pZSTlUZDFya0tpU0JOczVvWVpiRVha?=
 =?utf-8?B?U045TURtV0NTSUNqdXhQb0N1aUJWL2diUFpWZHhjOWhEK3JCdGovTUZGbUtu?=
 =?utf-8?B?TU9OcEtHalFQV2F6VWlNMDdLV2xTZGFoQnlFOHJBY0VoRmJZM1k4Y2JQTmUy?=
 =?utf-8?B?TkpldERRTDRZTDYyM0l6VElmdkhrVFc3eHJlTzNsQ3hDeXNrSENRNFpFM29t?=
 =?utf-8?B?Z3lTQlVQd1FvbEpWVHRRNTV4WVI1Y1E5ZUJKM1J2SWtQRzRSeUxad2hBQnYr?=
 =?utf-8?B?Zjk4UTdLc1lNaExvZVlTdXRad0V4eDVxWTVCU1N2RXUvRnI5OEdWa3pYUEp0?=
 =?utf-8?B?R3BhUnhRVHJkOU1KaTFrczZIWklac1JSMHV5TmsvUStqRFNYNkNrQ0srbTQy?=
 =?utf-8?B?WnU2cGdlRFptbllrN2pPa2JBMkd6S2lBU0puTzZKQ0JyQXVZZUhaSUVOd01P?=
 =?utf-8?B?SGlobWowdGxQSlBMTU42L1pxbWRWWHo4enF4WHp3NDNjY2NPYkFuTVVtMTRj?=
 =?utf-8?B?cnJGZVNIbUxDdXc2bmpvVlVSY2lwYzQvRGVpeHArelVSUXhydWxmb0wyT2RO?=
 =?utf-8?B?Yk5EVlJxMWZSSkFkbVF5WGlBbkxrM3VZVk9CdXc4L1ZiZFpNVVRRNEpHQ3di?=
 =?utf-8?B?T0RiQWpFdENuclNWYjk3WWJ6dC9LMzJwUWw1alZQeVhwcTQ3ejJSQUFCYUJa?=
 =?utf-8?B?dWh4NGU1MGpHcFBrMjU4WlZyTjgxeE1DRXgxTFVKTkJIdjIrR050ZCtvU2dB?=
 =?utf-8?B?L2t4ZFhqdXBpTEs0ZU5rZWRMS284a1VhaHdHVWU0UGZXR2NtZEhlTUNRWHox?=
 =?utf-8?B?YXZDNksrMExyUXBqMERBZi9hQnlVcFRMSTROZTZ5eTVWZ0dvb1FzWUVodjVJ?=
 =?utf-8?B?NXVjZG5sRzRVMDVhWEFNL0tXZkd1VEVkNzl5d2MwdTZ1TjZ3MGMwQWZaMnVM?=
 =?utf-8?B?TG92bHRGVlhxVmtrak9GYVNXYWtRMkRiVnFWT2gxbjl0OXhsdFR2eHZhY2Rk?=
 =?utf-8?B?bkRyeEFINTRZWERWaytxdnR6czJVcWFYZmhXSTNLT2xjZTRScHAwcFVKUEUw?=
 =?utf-8?B?UE1zN1kwK2FzNkRKZXFjS1FlYjgyRStVdllKMUgySVhzQzJSV0tiWGo2L0dx?=
 =?utf-8?B?ZHRiVkFacXZUNlhMcCtOWGtSSkdhb2xISjR1V2hLdDNZT01GTWNGRWZrc2ZO?=
 =?utf-8?B?RHJZVFBGekUwUlZqM2x0Z0hrSzZlaVpnUVkvMHM2bjh3cjBkc1NyRnJ1QVlw?=
 =?utf-8?B?TjV2UTEzQ0Uzb3NpUitRMUZHV3Rzc1dtOG1mMm5RTndvV2YzZnpoS2JKTjVz?=
 =?utf-8?B?VWNQQVJ1RnR0RFY0MTBVeDR6dllONGRvbDZ5VTVVcDNIUmRybVJja2Jyb1lB?=
 =?utf-8?B?bzNlTEkyOHVQTVJEODZHbWg3UHpUeTFHdUNRNmJxcXlWaVFhb01wVDkxM05Q?=
 =?utf-8?B?REZnR3FPSGZHUzVhZ1ZWbTJyTklSVWNjaEVxclBLMERQcllJTGFUZjl6WnBv?=
 =?utf-8?B?bVhFVk1rczAwZmp3MEdZN1ZpS2lwSnRYMU5MSVVIbEJhUzlmOUR6RkYwckZj?=
 =?utf-8?Q?6kBbcgRB13w/HVxDtB3Itu9ah5RLnoswXPIHy9L?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf82b5d2-58ba-4928-1221-08d93d6ec7c3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2021 15:33:45.9451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGvLe5ZMeU2f/MgL6h2Js+heIbk3JVcqE3f6MtmWvQDMPx1G7dyC8E2KOVxAOSaP+YnsZ2KNvjgm0OAH8VqAPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4303
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10033 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107020086
X-Proofpoint-GUID: DOyAdjX2llkNjbLtvwcPKxtPIqG73Xad
X-Proofpoint-ORIG-GUID: DOyAdjX2llkNjbLtvwcPKxtPIqG73Xad
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/7/21 7:38 pm, Johannes Thumshirn wrote:
> Now that commit f34ee1dce642 ("dm crypt: Fix zoned block device support")
> is merged in master, the device-mapper code can fully emulate zone append.
> So there's no need for this check anymore.
> 
> This reverts commit 1d68128c107a ("btrfs: zoned: fail mount if the device
> does not support zone append").
> 
> Cc: Naohiro  Aota <naohiro.aota@wdc.com>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


So now zone_info::max_zone_append_size should get removed as part of the 
other patch - [PATCH v2] btrfs: zoned: remove fs_info->max_zone_append_size

Thanks, Anand

> ---
>   fs/btrfs/zoned.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 297c0b1c0634..e4087a2364a2 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -354,13 +354,6 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
>   	if (!IS_ALIGNED(nr_sectors, zone_sectors))
>   		zone_info->nr_zones++;
>   
> -	if (bdev_is_zoned(bdev) && zone_info->max_zone_append_size == 0) {
> -		btrfs_err(fs_info, "zoned: device %pg does not support zone append",
> -			  bdev);
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
>   	zone_info->seq_zones = bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL);
>   	if (!zone_info->seq_zones) {
>   		ret = -ENOMEM;
> 


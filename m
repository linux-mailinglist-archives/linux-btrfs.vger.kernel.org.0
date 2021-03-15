Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9815E33B1EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 13:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhCOL75 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 07:59:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58696 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhCOL71 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 07:59:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12FBrYQT100441;
        Mon, 15 Mar 2021 11:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wUjCu5EbZWYFBpamJHOPU4MI0oZAHXhl+Ux/N3KPCa4=;
 b=woiXcBzf8QR3w07linDqfrH7/vTZvnxDSIRT0/EeXvmwrMansy8nR+uqjM+oUBmVZaGl
 Ov3UR6TMakinJkllUtlGSZXp/HBXdHifO8HwW0l7QEoBAJVQgUWt7d9tsD7Tk0+Xdotu
 uKEXJp3aX8Nax5qki31d4kasyDsMCl5VSyjNNp6MUfDGelxPQIUWJje7BCbl+UGHuaZv
 J2JR7Z7aWnhoYVqOy0oJO+itHRX9yVfqFEh67ZHLlFru89iTk7fYNE6DlgRsNHVG3j4i
 JX4IjPP9X7ft9lbhG6oyQEdbTdHDwRcvnNtMsvkuk0JfHYmyQQSkYw4pMATjqws1+ck/ vQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 378p1nkgag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 11:59:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12FBt6K0078449;
        Mon, 15 Mar 2021 11:59:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3020.oracle.com with ESMTP id 37a4erdt3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 11:59:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isWT24jXJZCxPc55dssk7CWNGsujs61rZGqU3X7yaRZeJPbDdIvTzaDdPZKXhNUTmVcF2Te60ve3Ky9GGzOuUlptHwkDkNPD0/Ac2vJg0zDef+zY5mFBV582eWOqltOtnnj2gD1RyMHtfFfmb40doOiuK3DvfE/zDPj/Rg0hasgpZzyIQgxuI/Au3/Vn1wBxLKp9KGGQXfz1k20kN9Arym6tzCSayUYS6FQakhkE7FkGE89QFc64OV/t4PrnjjpoAlluoxQLDiDWo0KkZ3mydCEpAZuagPlaAHTvwnYNhMYkAFCOIqlNEbnzdDGp+uYmqAKkrm7AK987J/1Z1JnCVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUjCu5EbZWYFBpamJHOPU4MI0oZAHXhl+Ux/N3KPCa4=;
 b=XzLvyXVXErwv0W2aBFSCIGvg3o92o3a3/kwUFFO/TsfF3vGXyokBWbZbOKfV/xLfDtb77gP4gmruMKCZwP1t1fvfTofp9PEqNChx21c5ThSQLXDpjyUJBONcxYIGp8h3USTBPNPhva5kVetKZxHf6ADtereOVOPL+INGs8Ul9IE2tVDGp16Pcd9QOVQbl+1Q564o9wW4iE+FZtu1lLJkm6D/FGQ7IfzdNSRPKLNzMsI/BUOP10pM7Y0ypUNgfLby7OFa86gSVnEgoeEpM8YWU1sQRLvWKz2SbKtFmj8O/Frk8EMteWEXfKSSE4Z474GI4GBCpuBp70oLdRuZiNyp/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUjCu5EbZWYFBpamJHOPU4MI0oZAHXhl+Ux/N3KPCa4=;
 b=FCiSBguyp/ampjgNjIYBusi1COBccK/xS7II3ViZ71iZJ85+aiNbeQV6T0CrWtNf/bADpE/M3S/m4YvbLnn1cXb6EgUW8HbkLCb8orPvmewhgJ2gbixN/5ycbTtMK7ozixdcWli4gV0CvtN90Wfm8VPg21W058H5FrSkCVqkRt0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3426.namprd10.prod.outlook.com (2603:10b6:208:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 11:59:20 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:59:20 +0000
Subject: Re: [PATCH v2 01/15] btrfs: add sysfs interface for supported
 sectorsize
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210310090833.105015-1-wqu@suse.com>
 <20210310090833.105015-2-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <61c2ba18-c3de-a67f-046f-1f315500c8c8@oracle.com>
Date:   Mon, 15 Mar 2021 19:59:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210310090833.105015-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:a177:93a9:ccfb:d353]
X-ClientProxiedBy: SG2PR06CA0226.apcprd06.prod.outlook.com
 (2603:1096:4:68::34) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:a177:93a9:ccfb:d353] (2406:3003:2006:2288:a177:93a9:ccfb:d353) by SG2PR06CA0226.apcprd06.prod.outlook.com (2603:1096:4:68::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 11:59:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94d6ae81-5439-4511-5b00-08d8e7a9c42f
X-MS-TrafficTypeDiagnostic: BL0PR10MB3426:
X-Microsoft-Antispam-PRVS: <BL0PR10MB342627B01ECEC9F38F0361F2E56C9@BL0PR10MB3426.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QnucN5cK/nJbQFO5s1ewM2elxqQGb8r1YGC9EFP4iVucGrfauniE3V73jdrzZ4YTQZE2DjSB8eOxqZgKcYrhYZHif9vVFJxQIJGOVpCAecCQRUQD4Ew291HIW1wgdDy7siUcLxVs5hkHtdnbrmgiOp/SdB7+NGWxhb7JzleQSrX91z6ecMfQUAyVY7VSWE2frsPhFJQX2O+h4OHRPhxaCU9c2JALYmg/HBf4BNxRREgIVmHH05BIO07qVIwvVBI2XSuULdzdxF8xLYXP07anFmbaMM/gmHhmp1xHmtmshTRdP3b5Q+xSvliVFmvXgEyyk3pnOmflfksgneq/lRoggu6Jvj7hlcK5E1w6eDSubXZpJkU3RzE8DAb0PqvOiHitccRYw8qCgAE3KX1OvvL6esyf4pxgiC0SIQsJ9LoXBm0POdxqbwEoZTY9IdUbsvYY2N7uFqhTyDlygGIPNr53IPEhvGnEaqezyec8hxsDukmOBZ7D2a5uTngFWhglyuzHsC/HSF44yZB/VPBRPa/akWS0iyNmo1rIGYx0ZjJIRJh9CVm9tTpAGnk9cjpICMXPFWeG7KlVmYDtWbsw26fdgZHGqyw9/GuN80+sBwP24p9nmPcDMNdWyiuR/sxc1SxCM3SgjAWwAF6o9PJ907PMcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(396003)(346002)(366004)(2906002)(53546011)(44832011)(316002)(31696002)(86362001)(478600001)(186003)(5660300002)(8676002)(16526019)(31686004)(6486002)(36756003)(66556008)(8936002)(66476007)(2616005)(83380400001)(6666004)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dVlrVzBjdDdwYkwzWnFsMlY1bW9QTW9TSWFxK3FUUkYzSDA1L0FodHpqNjg1?=
 =?utf-8?B?YVFoUmtQLzRlaVhDR0piYnROSjVmUVZiT2JPalZhVk0wNVpmM25nU3BHQUR1?=
 =?utf-8?B?ZnRyM3pWWUFVazBCdHBlOFVJbGRKajJpRWp4OHYvSEFYQkRkVGdNd2daU2xa?=
 =?utf-8?B?bEQwVDhEakZ0TXpadDNSVVdyVng4VTc3RUoxVWliWjBpQ3NpM1dQbVFCTVN1?=
 =?utf-8?B?bDVYZWM2MkFmMXRJUHgrR2xvSjd4RTZaSkNmOE1qSWRkNFdqdHBqRG5tQXhI?=
 =?utf-8?B?aXVRZ3BWUGZtUWVGamR1N1Qzb1cyUHRFZEUrSlhjaWxvYXJvN0NMTUM1a1lX?=
 =?utf-8?B?OWM3MXpNK2NHQVJUWUZnL3RMQ1MyOFdMWEpOSG1GS1pWenhOSTNSUHZFUjFl?=
 =?utf-8?B?UTNDQTJ5VWMyWWpPYi9uL0RaUWgrVGFmdXY1WWFmZkZKTThPYmhtN05OVnFK?=
 =?utf-8?B?VDhBY2pHdklzQk85em5RSitBVHE0TnFtdmlsQzRDSjlQcmIwNDFNTkRZaFJi?=
 =?utf-8?B?bDczaWY2cVFpby9PM0VPUTBDTEJkT1h4WFh4S3RCU1pDSDdnekRlQnZPSlor?=
 =?utf-8?B?ZVVlV1B1cG9aSklWNzhxdlloZThUTW5kaHpMRlljeTRzazkzWUxGTVVLMEVK?=
 =?utf-8?B?L1U4d1Q4U0lqcm1ualREUUtIa09JZDkzVjdCaW0yd3RaalJiQU5pVlI0aWFN?=
 =?utf-8?B?anUyVDRuNWIzRkVjK3hWemcxZ003Ukp5aUNnWUkydStTMnRWV3l3Nm1wMUVI?=
 =?utf-8?B?NVRPR1MwT2F5RTdSY2tKaHJ1NXBXZzhlY1B5bTNESGhzcmRDenc5a1ZHY0ha?=
 =?utf-8?B?YSs4UXZHU3FXdlIyMnBtNlJhZ3ZuV2hZZThLZ3VOektsWWFRVG5jYXZvaFlF?=
 =?utf-8?B?WlVtVzZYVlJTY2tUa050Q2d3V0UrR0ZtTHdRNkRRN1RyK21LUlhHWkJFYjgy?=
 =?utf-8?B?T0xlRDBlRTd3K0U5akRjRTUyYWd4NjA2QmVZdTFJYnFubjF6QS9Rb0VKSHVo?=
 =?utf-8?B?T2JidlY4V0pIVzU1NEt1d0ZwUm1wNHF1S1BtVWpsT2t2Y3QxUDFUeUxoZ1ZU?=
 =?utf-8?B?MEtIOFo1d3VFbGJKMGhaaXphWU5CWnRDQ1RHQXlVZ21nb1pac0g1aC9NcG9T?=
 =?utf-8?B?K0F2YWNyelVBQWxDMEhOWWpJbTg4bW5JTWVFZ2VnZW5nMVJ5Smk5cVZWMU5H?=
 =?utf-8?B?WHZKSVQrY29TNkRpSW80M2MrOXRhelRoREhOV08zVnNSTEtrMEF5cFpzQzhQ?=
 =?utf-8?B?UjMwUWFodUxTRDNETWxjSG9TaTAvajJCYXcwREp2a3k4c3pUR1FCTVNscDll?=
 =?utf-8?B?UU5SL0VWbUxUTzJmVjhhbDdWdWMvb0h3VlBKWGRXcVEzRy9lRzBGSnd6Q1h5?=
 =?utf-8?B?ODF2THppK2pKSEdYRlhtUkZPa1AxVVh1NHlKWUErdFNLYVRIUy9WbElsUzYx?=
 =?utf-8?B?VVpGaEtVdjdYSFJ3MDJWQVVzQTVrZVVzSHFuMmFxWFh2T3lQWmFlOHl1ZXlY?=
 =?utf-8?B?QUlGbWI2WWZxNTFBb2dZSnA3Rnc3VzdENkp5Zmk1M3Jnbk4zZ0k3dCtwNXNp?=
 =?utf-8?B?NGVRSnZLREVGdTVBTlI0eXBJbXFiRVNSV0o0MlF0aVphS0RiNzdWTU1CU0d3?=
 =?utf-8?B?dHpkWWFzcnV4dVpkU0NxOHE1aFJvNXNaWCtNQ05INkdTT0lVOEQ2WDFiV01W?=
 =?utf-8?B?SmxyVGxmeGVTME5hV1U0MXpHbGN3YzBmOGxlcDZkNzQrbUZUWFlBVU1RNkJv?=
 =?utf-8?B?OU5zNjFHL3RwNVhyYUtUcjl1SGxtNWszOHM0SXBOZjlsZXhPdTBYdmwwTHg5?=
 =?utf-8?B?Nkl1NUhDaVpVTmxjSEJwMldHbWk2N2RudUM3VE94R2k4VE9kc3dzOFF6cm5s?=
 =?utf-8?Q?KYI41yk8ftXUz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d6ae81-5439-4511-5b00-08d8e7a9c42f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:59:20.6602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYZMBOveGs228JN8xri77eluWTuF9gqCxhtMlX4SMQ2wrqU2X1+DnBEU6J6J8vcle8q7/qgsAVNYOYR4vctCrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3426
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103150084
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150084
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/03/2021 17:08, Qu Wenruo wrote:
> Add extra sysfs interface features/supported_ro_sectorsize and
> features/supported_rw_sectorsize to indicate subpage support.
> 
> Currently for supported_rw_sectorsize all architectures only have their
> PAGE_SIZE listed.
> 
> While for supported_ro_sectorsize, for systems with 64K page size, 4K
> sectorsize is also supported.
> 
> This new sysfs interface would help mkfs.btrfs to do more accurate
> warning.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

Changes looks good. Nit below...
And maybe it is a good idea to wait for other comments before reroll.

>   fs/btrfs/sysfs.c | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 6eb1c50fa98c..3ef419899472 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -360,11 +360,45 @@ static ssize_t supported_rescue_options_show(struct kobject *kobj,
>   BTRFS_ATTR(static_feature, supported_rescue_options,
>   	   supported_rescue_options_show);
>   
> +static ssize_t supported_ro_sectorsize_show(struct kobject *kobj,
> +					    struct kobj_attribute *a,
> +					    char *buf)
> +{
> +	ssize_t ret = 0;
> +	int i = 0;

  Drop variable i, as ret can be used instead of 'i'.

> +
> +	/* For 64K page size, 4K sector size is supported */
> +	if (PAGE_SIZE == SZ_64K) {
> +		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%u", SZ_4K);
> +		i++;
> +	}
> +	/* Other than above subpage, only support PAGE_SIZE as sectorsize yet */
> +	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%lu\n",

> +			 (i ? " " : ""), PAGE_SIZE);
                           ^ret

> +	return ret;
> +}
> +BTRFS_ATTR(static_feature, supported_ro_sectorsize,
> +	   supported_ro_sectorsize_show);
> +
> +static ssize_t supported_rw_sectorsize_show(struct kobject *kobj,
> +					    struct kobj_attribute *a,
> +					    char *buf)
> +{
> +	ssize_t ret = 0;
> +
> +	/* Only PAGE_SIZE as sectorsize is supported */
> +	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%lu\n", PAGE_SIZE);
> +	return ret;
> +}
> +BTRFS_ATTR(static_feature, supported_rw_sectorsize,
> +	   supported_rw_sectorsize_show);

  Why not merge supported_ro_sectorsize and supported_rw_sectorsize
  and show both in two lines...
  For example:
    cat supported_sectorsizes
    ro: 4096 65536
    rw: 65536



>   static struct attribute *btrfs_supported_static_feature_attrs[] = {
>   	BTRFS_ATTR_PTR(static_feature, rmdir_subvol),
>   	BTRFS_ATTR_PTR(static_feature, supported_checksums),
>   	BTRFS_ATTR_PTR(static_feature, send_stream_version),
>   	BTRFS_ATTR_PTR(static_feature, supported_rescue_options),
> +	BTRFS_ATTR_PTR(static_feature, supported_ro_sectorsize),
> +	BTRFS_ATTR_PTR(static_feature, supported_rw_sectorsize),
>   	NULL
>   };
>   
> 


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA06632616C
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Feb 2021 11:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhBZKi3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Feb 2021 05:38:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56058 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhBZKgt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Feb 2021 05:36:49 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QAU5JR103869;
        Fri, 26 Feb 2021 10:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=AfKplaj/2G+kIa9x4rm1vcqCc9zE87NCe10Ad0OtC4w=;
 b=EGYGa4BOz2K2TuhcwPGNCy3IjcmDsb5+R3944q4Ixbe/h3uCg9D2AY9vLkJ5khdUd+bb
 OfBd0zdpgZC/TEmbTf+AX0MZh7z4SWgseNxTaSv1h1ldM4R8l01jY1cDXUvUagZYJSOM
 YhRqLL6ay+g1Z5v7utrZm/tijUWCM4k10qNqYgmAkxr/yEgFqQN5YPiQmbECaDiF0wWs
 7pLpAX+d1LGbwzgmVdILVuAlSGfiZqIbUYRL+EHSXFcDCRuV7y4bwai2TcmnA6UAdYTM
 3aeGft6TfOXX3qnob14pp/PmLJJd9rriUlUJ+5/AppJjL++OSrbOPRHjlJD1Z/lIEOku Hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36xqkf91ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 10:35:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QAUfbn025084;
        Fri, 26 Feb 2021 10:35:50 GMT
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2052.outbound.protection.outlook.com [104.47.38.52])
        by userp3030.oracle.com with ESMTP id 36ucc2f5sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 10:35:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxIemQrb4P4MX/VydvUDYKac/qQ1GHwAZT0d4DlYj6NAt8wbsND5xg6QniYIeIy/GzWLT0Q0311yUI2o3o4uez5/Vz2NMH0Rh9n/X11EKDAsz3bGVucaWoq4WKLtdt5/fGC4Dlh4rrTAO4rCsIVWmdonXVmFYm+hjsGL2VdyJQBwvSFWxcf/7Wez3+DpiwRiXEWgYIpNGEpW79qZgrfgKPjUR8S88VXv0E191BAamyOb97OhOPVaMQkr/9BFgnB3YuYaL4Awl7gx6PdkkHUMzaPadEQ5/yv8u7x3yj8ImjAVCFJecD7hLXLJnPTBoZgWCNB6HyGINdXe+YsjePJJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfKplaj/2G+kIa9x4rm1vcqCc9zE87NCe10Ad0OtC4w=;
 b=eD2E2gav9L4gSif8gw0z00At3F6bJ0mX+1K5SfBl9604n8oyW69XKspbAeSQJCid+O7u+2SH2ucfI4d+boYGU9Cs3wLuKjkUNT1I2YeEs9T2zatnrq/FlZaQbP8kkKQ9Cfz3hIhO3ax3U0m5pxCLIBxwRDy++xZpA6nX9c4sOLK/9AY69CdnWmgsU9qFMmilaLs670RPLcQ3wnDKUy1l2eA4pEG2gNwBHOIF93wS4S56VMbFaYgzAzKZKL5octTB6tgR6FsUfm8LFvNdSXd8NnmXwHPKKp1Yq+EzLAWTlqlqw8YdKZTLYtepOC+F9XbyBppInyw8EuXmeUXaO07J2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfKplaj/2G+kIa9x4rm1vcqCc9zE87NCe10Ad0OtC4w=;
 b=miHRK6+mPOKKdzG8ng+T55P5mGGfO5h9jcHWggVDdOAn8sXjAKHUypl+SNMfvQCrm0VkUXxtcMFEeBt+LV58SX61gSswGF3fMStsC9Bvq00z/tR6dN471JgU8E+N77PawQHNueuezE9+og7wgj1wc9OlrWD8Vo6JIxMuZJO7mCY=
Authentication-Results: sandeen.net; dkim=none (message not signed)
 header.d=none;sandeen.net; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4820.namprd10.prod.outlook.com (2603:10b6:208:30c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 10:35:47 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3890.022; Fri, 26 Feb 2021
 10:35:47 +0000
Subject: Re: [PATCH] fstests: make sure we rescan all devices after
 unregistering
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Cc:     Eric Sandeen <sandeen@sandeen.net>
References: <20210225055717.70679-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <95528bc7-f55c-aa67-21c8-fef9573689c7@oracle.com>
Date:   Fri, 26 Feb 2021 18:35:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <20210225055717.70679-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR01CA0096.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::22) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.102] (39.109.186.25) by SG2PR01CA0096.apcprd01.prod.exchangelabs.com (2603:1096:3:15::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Fri, 26 Feb 2021 10:35:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54e874bc-df55-4d91-1934-08d8da424724
X-MS-TrafficTypeDiagnostic: BLAPR10MB4820:
X-Microsoft-Antispam-PRVS: <BLAPR10MB4820A42D0D1F28B33C72035BE59D9@BLAPR10MB4820.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgqjmaKR9dQTuuVMGsDo7s44E59hsV/AV1Mb6OCKOjiM7oE7RCTf2lGfJ+XqiBm2GmdZegJFb9YLQ4mGcvgvTdqfATynSg3KAhCj1k1JkC7/sBoU6Ovs3M60ONe6DXnZI0zSFdpnKvPjxYn7X19DMQ468OjJybfezn2S+rMG3TwPUwVCJ0nzDlqycvujhwZKBnLY3f6MU8/gwj6OhgzJoD0pMlb78PApNOGNjQp55Y8G4WmYYxe0PYdajxdyrbrFnfb0MRiXwIBHbu8BHfD1ePe0x93fI1RyTA6xDagcpbzZDwEfa+VK1I/EkP2BnTG7KYCDy207hgxR8g9rOOVY8ZG7005zk+RPMooQQN78k31BinoX4u3ZmCb/RD2kuv2o+X37zTilL16gUq8dy6U86NM7hrTsgGqKa9jcPJlrGqjYzP1BYpg/ogEWUrfZ1j3SkUif6qythXr5aSSl4usiiv+UtGwSzPa52//ZBVV3z9ZpKdQQ2VfgefZ+dDO2EbpwvAqqaUtNh4qJnFc50MDZ1vZL6XjB1mLsilRuyIsL7h4gJjCg2ycpERJxymXe+n07TteDst+ww5yupWu7UtUg8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(39860400002)(396003)(366004)(2906002)(8676002)(31696002)(186003)(16526019)(956004)(2616005)(316002)(8936002)(26005)(16576012)(478600001)(36756003)(53546011)(66476007)(66556008)(86362001)(6666004)(44832011)(66946007)(31686004)(4326008)(5660300002)(6486002)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZTBnZXpmTTFPcHFUY0h2eEpXNlExbUczSUpGMjV0VG12YjdLYUNYVGFFa1gw?=
 =?utf-8?B?WUw0S3pleXJpdG1ZSG9uRGhLVVN5b0F3bld6aDNwMDBIbEJnUkIrMGdWTzhX?=
 =?utf-8?B?enhqVkxFakxjL05Nb05zeFZxL2xhaEpUVEFnZFhtZ3RUWUlLVUxsYjZoOVBT?=
 =?utf-8?B?NU5NbDRsNEVUWFBSMVppRGhaMkpSUGhRYmhjb2N0cTl1S1BwQ2pxM05kVzEr?=
 =?utf-8?B?eGEwK1FvYlpaVmtBVmhuVC9mcXU2NkhhZUVwN3RqVkYxTXliRTN5U1JEQ3hT?=
 =?utf-8?B?ZitMb2pXbnVsbzRIR0Riem1PU2loVU8rZjRUeUJTK0JMcVZVNFJZcEhkUkVN?=
 =?utf-8?B?ZEZ2OWhhbkViem56aWtndG11TTFrNmdUS1B6cmRFZGdvUkg3TzNWeUR4dzNJ?=
 =?utf-8?B?WjZWaHluZHZXK05nSDFFejkrMXpoZ29lRXQrUkVEemkxM2lNSU5EdUZQL0lW?=
 =?utf-8?B?VkRuMW9DdmhJd2dTdWZveThaeUZnTElFMTBMUDJBVGtJeVpNZHdNVVJLa3NZ?=
 =?utf-8?B?bTkvYmsxWW1TZnF5SFJLT2ZPdXRkTjRveW9OUkhYaWlNOFZONXhRV1NKT3Vj?=
 =?utf-8?B?c01UMTVwWkVPQmZrM0JGaUUzZG1GNUhnNlRlY21IUStIV09UeCtNMEFJZUhM?=
 =?utf-8?B?RVMxalJ2MmFoYWRWMzdHbDFoRjRiTDlCaXcrNkVTUGRPLzhNWDBGdThFTEtw?=
 =?utf-8?B?WXpic05hUHIrR2QxL2EydFUwUWwzUEp1OG5LY0tVZXZ6MEZqMG8weHM4ajdr?=
 =?utf-8?B?OXQ3QlhudWdXSSs3TC9nOWtVMzZpd3F0MmRabnl4QnluNmFaWEgrc0hOSTNa?=
 =?utf-8?B?RmlCRUVUUFEzeXprVUlKMVBTbFZISVArL3U5czhqUWVWR3NSMCswZmQyaHFs?=
 =?utf-8?B?bFRBVy83Y0JHZzdzV1lRUHY4TXJ1aGVRbnAxb1I0UFl5R3NGWGw3K1ZXamVQ?=
 =?utf-8?B?eUYvVE5EOHE1L2JreHdQZ1BmUkM4bHViT0VhN1NiV1dsSUdLQlppa2VCb0NR?=
 =?utf-8?B?WUNSWFFFWkhrTTlCOXljbFRmR0VrTkE2NVhOR09CbFFtY29uOGJGOGFMZm9m?=
 =?utf-8?B?V0xVU2N4Nk8zTVAxNHNiTVpNY3JjbHRZYXF2Zjh5bTRnOC9MMTlSSGpIQ016?=
 =?utf-8?B?cW9nSVRkUHdWckdDc2JJYk93WGdvSnpxMkZTSnU0ellDSm96L25uZ1p6WUxq?=
 =?utf-8?B?ckdMQStpV1dNR21SL0g4eTZTcWl0SityRjBkeW9JN05Yd3d3QWtsMk9JT3p1?=
 =?utf-8?B?aXhqMkJ5T04yYUQrN3pIWEZ4RGRyZEJRMUc0cUtDMkdUUmJGUy8xa0w3TzRN?=
 =?utf-8?B?QkFpOHh5Z3UvbUFpTks4RmV0eWZkOVM2eXUvRUE0Q0xHVnltT29pWlc0YnA5?=
 =?utf-8?B?WDBGN2JOdGlXbWJITjRKYm9NdHdvNnVRZDgwRFg1NXF4eFBWY2JtRXFVK3dt?=
 =?utf-8?B?M1NMNWxFUFJ6Zk1oYUZTY2tZWVg0RjN3YjFHMFhpV3NNZFMvRzRSa1pLcSt4?=
 =?utf-8?B?T2JyU0hiZnlOeUY2TGkzY3FKUkFiK1JvN1NUbFZVaHN1ME5ENDZjaHpEczZU?=
 =?utf-8?B?bnlBSkJZd1d0K01aY1dVUHVYN3d6dlgwOU9QVDRQYUlLeFVQNDArNG9lSjdt?=
 =?utf-8?B?RzFmdEdkWVlYTTgzZmovZmx1SE5mRVdmc2tRWjVzSVU1NE4ySlJQQVMxOTA3?=
 =?utf-8?B?d05xMlFOc3FXa29ONjBpcDZ2QVZIbTZCOVJLTnhEMU9QdDRTT3JPb1BWMHRL?=
 =?utf-8?Q?iSFcOGhyot34sLCJ8sCMhIUFV2lwq9Q48qaPpAD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e874bc-df55-4d91-1934-08d8da424724
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 10:35:47.2724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fI4E9E7CkdTyezV4FeuZjLgDCBiz+kOof4bdXrt6jdGdzrV3NL+MIdihvFL1wS4OLW7kr9jqtF02HrWgQycesw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4820
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260081
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260081
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/02/2021 13:57, Qu Wenruo wrote:
> There are some btrfs test cases utilizing
> _btrfs_forget_or_module_reload() to unregister all btrfs devices.
> 
> However _btrfs_forget_or_module_reload() will unregister all devices,
> meaning if TEST_DEV is part of a multi-device btrfs, after those test
> cases TEST_DEV will no longer be mountable.
> 
> This patch will introduce a new function, btrfs_rescan_devices() to undo
> the unregister, so that all later test cases can mount TEST_DEV without
> any problem.
> 
> Since we are here, also add a missing
> _require_btrfs_forget_or_module_loadable for btrfs/225.
> 
> Reported-by: Eric Sandeen <sandeen@sandeen.net>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.


> ---
>   common/btrfs    | 8 ++++++++
>   tests/btrfs/124 | 2 ++
>   tests/btrfs/125 | 2 ++
>   tests/btrfs/163 | 2 ++
>   tests/btrfs/164 | 2 ++
>   tests/btrfs/219 | 2 ++
>   tests/btrfs/225 | 3 +++
>   7 files changed, 21 insertions(+)
> 
> diff --git a/common/btrfs b/common/btrfs
> index 6d452d4d..ebe6ce26 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -411,3 +411,11 @@ _btrfs_forget_or_module_reload()
>   
>   	_reload_fs_module "btrfs"
>   }
> +
> +# Test cases which utilized _btrfs_forget_or_module_reload() must call this
> +# to make sure TEST_DEV can still be mounted. As TEST_DEV can be part of a
> +# multi-device btrfs.
> +_btrfs_rescan_devices()
> +{
> +	$BTRFS_UTIL_PROG device scan &> /dev/null
> +}
> diff --git a/tests/btrfs/124 b/tests/btrfs/124
> index c9729cb4..4588264c 100755
> --- a/tests/btrfs/124
> +++ b/tests/btrfs/124
> @@ -35,6 +35,7 @@ _cleanup()
>   {
>   	cd /
>   	rm -f $tmp.*
> +	_btrfs_rescan_devices
>   }
>   
>   # get standard environment, filters and checks
> @@ -144,6 +145,7 @@ fi
>   
>   $UMOUNT_PROG $dev2
>   _scratch_dev_pool_put
> +_btrfs_rescan_devices
>   _test_mount
>   
>   status=0
> diff --git a/tests/btrfs/125 b/tests/btrfs/125
> index 41d22d0b..d125b111 100755
> --- a/tests/btrfs/125
> +++ b/tests/btrfs/125
> @@ -34,6 +34,7 @@ _cleanup()
>   {
>   	cd /
>   	rm -f $tmp.*
> +	_btrfs_rescan_devices
>   }
>   
>   # get standard environment, filters and checks
> @@ -161,6 +162,7 @@ fi
>   
>   $UMOUNT_PROG $dev2
>   _scratch_dev_pool_put
> +_btrfs_rescan_devices
>   _test_mount
>   
>   status=0
> diff --git a/tests/btrfs/163 b/tests/btrfs/163
> index 735881c6..b6bd6906 100755
> --- a/tests/btrfs/163
> +++ b/tests/btrfs/163
> @@ -26,6 +26,7 @@ _cleanup()
>   {
>   	cd /
>   	rm -f $tmp.*
> +	_btrfs_rescan_devices
>   }
>   
>   # get standard environment, filters and checks
> @@ -102,6 +103,7 @@ replace_sprout
>   seed_is_mountable
>   
>   _scratch_dev_pool_put
> +_btrfs_rescan_devices
>   
>   status=0
>   exit
> diff --git a/tests/btrfs/164 b/tests/btrfs/164
> index 55d4a683..ad22b6a4 100755
> --- a/tests/btrfs/164
> +++ b/tests/btrfs/164
> @@ -22,6 +22,7 @@ _cleanup()
>   {
>   	cd /
>   	rm -f $tmp.*
> +	_btrfs_rescan_devices
>   }
>   
>   # get standard environment, filters and checks
> @@ -90,6 +91,7 @@ delete_seed
>   seed_is_mountable
>   
>   _scratch_dev_pool_put
> +_btrfs_rescan_devices
>   
>   status=0
>   exit
> diff --git a/tests/btrfs/219 b/tests/btrfs/219
> index 78fca035..bff6003e 100755
> --- a/tests/btrfs/219
> +++ b/tests/btrfs/219
> @@ -35,6 +35,7 @@ _cleanup()
>   	[ ! -z "$fs_img1" ] && rm -rf $fs_img1
>   	[ ! -z "$fs_img2" ] && rm -rf $fs_img2
>   	[ ! -z "$loop_dev" ] && _destroy_loop_device $loop_dev
> +	_btrfs_rescan_devices
>   }
>   
>   # get standard environment, filters and checks
> @@ -97,6 +98,7 @@ _mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
>   _mount -o loop $fs_img2 $loop_mnt1 > /dev/null 2>&1 && \
>   	_fail "We were allowed to mount when we should have failed"
>   
> +_btrfs_rescan_devices
>   # success, all done
>   echo "Silence is golden"
>   status=0
> diff --git a/tests/btrfs/225 b/tests/btrfs/225
> index 730d9645..b745b536 100755
> --- a/tests/btrfs/225
> +++ b/tests/btrfs/225
> @@ -25,6 +25,7 @@ _cleanup()
>   {
>   	cd /
>   	rm -f $tmp.*
> +	_btrfs_rescan_devices
>   }
>   
>   # get standard environment, filters and checks
> @@ -40,6 +41,7 @@ rm -f $seqres.full
>   _supported_fs btrfs
>   _require_test
>   _require_scratch_dev_pool 2
> +_require_btrfs_forget_or_module_loadable
>   
>   _scratch_dev_pool_get 2
>   
> @@ -76,6 +78,7 @@ od -x $SCRATCH_MNT/foo
>   od -x $SCRATCH_MNT/bar
>   
>   _scratch_dev_pool_put
> +_btrfs_rescan_devices
>   
>   # success, all done
>   status=0
> 


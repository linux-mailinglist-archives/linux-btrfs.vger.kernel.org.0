Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FAA41BAB8
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 01:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243182AbhI1XFG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 19:05:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47350 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243167AbhI1XFF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 19:05:05 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SMjuqc027750;
        Tue, 28 Sep 2021 23:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GbGTml15dAKtc3/GHLzNNAl3cLwdJ2xH7iXUuNt+rBE=;
 b=yNgQvCECZ6vjxagZiBymsORRGdX1TtXOdM3wpYjtaUO/8HjgJQXv+2klbLEamcb6X3sx
 XNk+fyqZOJqneRWhJ2wWWDIOeiYi2OTlBwHQ61jLdqtpce8FIEzzT+k9ZAqr+TW1iJWJ
 wNjqaVThVnTRu4OA+z3WrmOcunHDxnyQzYFMwM7T+x+9UGVhhhbmud3GTuxbugbH/2Qa
 7pbpKzeQ9xXBjAzqsgwFYLBvbWBU6HRPq2SwByaz5ao1BQt66OAvQFNDemM4/xueI6VD
 G0z7IkNJoujb/CWXuitAGDj6QvkXGdtoKnVjebbnws9FG34ODej8CTs3QHVNmo2Xyc4w jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bbj90sryw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 23:03:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18SN0SqX093324;
        Tue, 28 Sep 2021 23:03:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3030.oracle.com with ESMTP id 3bc3bj2d1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 23:03:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzV2mC84WqD/fbzRV4evV5sTUa9S6oLL4Dfl6bqS5+kmr3Oxql9pWKaVIGJ/b1tvVtxMvDYg0P7Cg41eUCacOWy0f7jG0ZTRQc8iWD78goDGdCuO9W/2EW5Ymlcuds0DDnbp+KVpkZIN9BGKDpXRI9XN3BLsEto9P8JHkN0WoymXg/b1sk4axksUhwEFWbvi6G83YEhw6otjp017lfZzb7LhOP/HUkl4BXRlIm4ymSd6U+JXPu/1RotjAfsb4YiEbbmjC25r/b1VaM231JRSzt+lY3d43gVQv2m9o+2YfuRYH+GjJsBs1i8Nwn9zoebrqNWxSCu6q/AHSmbharOnbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GbGTml15dAKtc3/GHLzNNAl3cLwdJ2xH7iXUuNt+rBE=;
 b=BhGDR3b7lESn9Ey8NM+WTIn1SwT4fxm4iWcVR4RCILdB+tqNFH36RaeUKxe5L60PoTuJUrgNV1LxKxy1wOCGZSgrK+Hb945EHTE0hXGNoYq2IWHPwY+l0LGmM2mm79shiktSanxH3VlYxWmp6CIvkBGtTLYzM1NxDJ47Ou8TpM72QNZOfjCrJas3j62MolAfrAlALZF9BhFTwyoMTXija1iYeEJLRS2nMR44bK1Ea6p5bWRd3bu1NUPhU3Z9TVm7eStY3ZNB1s41rvP8g+oo/CsufK/QjbI7zM+4FMlYqorurOPphCHqNdfYFRIGAtSFbRdezXLbTZnP4h9mC8AbAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbGTml15dAKtc3/GHLzNNAl3cLwdJ2xH7iXUuNt+rBE=;
 b=Wy4c0mqWE0GUcFp6gUjC8ltRsM6v4hliE4RAbcJrkQdYinjouwyNN3QizSkTQPM5o3HOh/Fw0zU+41vCsriE+GJAgpedxyyrl6vsT7g3mfE3B+kUT+GAchQq5v77WP1lAM4EwnoFc2Uh2a6wfgJiq8LnIeJDuQxPkKH+CvBPOIc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4285.namprd10.prod.outlook.com (2603:10b6:208:198::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Tue, 28 Sep
 2021 23:03:12 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 23:03:12 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: Ignore path device during device scan
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210928123730.393551-1-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <50f82537-0ccc-701d-215a-f45c20c0827b@oracle.com>
Date:   Wed, 29 Sep 2021 07:03:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210928123730.393551-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::29)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SGBP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend Transport; Tue, 28 Sep 2021 23:03:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06890ebc-ff79-4900-4f7a-08d982d4256f
X-MS-TrafficTypeDiagnostic: MN2PR10MB4285:
X-Microsoft-Antispam-PRVS: <MN2PR10MB428597DDCA95019300E9E5E7E5A89@MN2PR10MB4285.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8oH+7HS5SMoRrxtIW6EQULqSH/jqysi1HH6VM5ogk71jZ1t0Y7bS7NccObNlY1La13uBstlipm/GwMfLv5CF700X90SihOsMzgZ/QPuO0yMTXyXerlQ+AXHHWocORP6uT6JkmflwGIId5FuVT8WJRLYM/X8To15seR8B5W0oh1gNxqFGHvDMIU8SSwJcMgIHPY9XuZVqb6EIGb0rof2qQfps8WXs2p2npqtyvcBJkGrZUCcopoN06HLMRH6VdufEQlOsyMXhRGGk+ZkuYKGz0GEJXlJKQs91v+IGp79Jx2hNiCt4MJjzaVtb3XBn40oFlMSFM/J0w4A1O3Pi8zNNR11GMEZyOyI5Y5vDa8ajsphMHVx6ontuxzx2oND1BHQy8f04OTAt07lJdbnYiU+Lf0G6jS3oS6NRWq+2aksIoOWjyrqluO1dwDUgaHhfdOJBa3myLEBe3LqtDQ+JfCjiOMjLijgE7db/eXJ7pJrtWbED0vg8Ri6J2L8y6r3itwML6zD5JUaCtQc0dklPvMBnJ3y0hdviGOJbK4L4IYU9Q3ul/ogfFA5OP/asOwqM+OCIpzaGxWsGhMV70Y8YM8OjgjNoHeqpaszrCXiJNAAAa4fCb1d439pPyI6o1DHflUaQIt3yDYebIkYBI9bobLkTT4/aIwHGyplkQrVUFjABJOXuNnmnQmdg9sxcGgZqOsE+mNItvr48FQOB0ufb8x3wRIyi7Z7ClmhnWpWb0A69vYqJqZmjBuTmhFKZxIZK1INL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(44832011)(83380400001)(8936002)(53546011)(186003)(956004)(6486002)(36756003)(8676002)(2616005)(26005)(16576012)(66556008)(66946007)(6666004)(66476007)(2906002)(86362001)(31696002)(316002)(38100700002)(508600001)(31686004)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWV4L28vZG9JZ2tFQVdUZS9OaDNCUVcvVHZTVWNHTlllY1R3VWY2VkpHV05E?=
 =?utf-8?B?cWFHdXpzdGgwT2dXL3dlWi9zOXgxMEtUYmNJaEJKVEZGczBHMXdzT1NBbFNR?=
 =?utf-8?B?TmVpbVhRUzRqbnBEb1lPWm5CRXdhVjdWWVdqUit6RXNrS0IxcGVqU0k0eklN?=
 =?utf-8?B?Z0NRNzF5RFRQOHBQdDREYzJFQWxaRnNXdmMvUVBISEJiRGF2aGlLWXBBZzNM?=
 =?utf-8?B?ME40WlRWRVlXWjlvdVpnL2xpdDFFZDZ0SG9ha2ZqNFlpcGVIbjlKRktKM05v?=
 =?utf-8?B?NjNKODl6VENNdnhCOFhHRCsvL0RudnpFSjRQS2VELzRIQUtRZkRpcWZxNk9R?=
 =?utf-8?B?VFlwS21ZSDVHazJJdmlOOSs1VmVwbnlyd0s1aEFKSmpIczkxWjFKUEE2MDFa?=
 =?utf-8?B?em9FdkxtcUFsUVJFOVJ6MWp6VnBqa3JJMFVVR2doa1plVEtkUW9ETTRwOHE1?=
 =?utf-8?B?aUF4UDVvcVZsUDA0cDUyYzlNU0RVQzBUUzd5K0ticHI0VEdjQTZjb0tEekYv?=
 =?utf-8?B?Q2lSSzNKYW90Z2NRVnN6NWdFTVBnMmJqWVgzMWRmMHZXL3ZGYk1EeWdPY1BR?=
 =?utf-8?B?WXpkQmJiVmNoa3FMU2h5ZERSL1ZNSElyb3FMQytWaENtb094c1A2Y0pRODhC?=
 =?utf-8?B?N01iN3ZUemtLWE1tQ2RrVG9zYjJRc2xYMVh2OG9nQVhjVXg1N1g0eGNXUlYx?=
 =?utf-8?B?emc1SHIzd28yZ2gvQUFiSE40Wm5TVmlVQnc3b2tMQktheHZWV21pSXR4RFg1?=
 =?utf-8?B?T2pQNnBXRnFRcXZBQkx3K3JYeG9CeEtYWkEwS3FoT01IRmxkWXMwMFBiY1g1?=
 =?utf-8?B?UmZidFYwTTBMVHF5c0Y3MUloblJjdTUvRjF4Ymsxbm5BQkc1NkltZXAweUsr?=
 =?utf-8?B?R1lOb2J6VFJxbnlWUXNTaTVNRzZ4ZHBmczBYdGZiMlNlSFhDNnI2S1NQalBt?=
 =?utf-8?B?L2hYSFFPRmVodXZDcFBJL1pRVncxWHlxR0d0OWE5MCttV2FQdjVjaEx6Ykds?=
 =?utf-8?B?ZjQzNXVZTDBpaTdDMnBoTWNnTTZRM1RLSmpBQUplRkRwL3JuZWp0bE5zeWVF?=
 =?utf-8?B?SCtSZWFnTUpBdVc5RnFGak9NVkRQRjZ6WDZOdDl1aGpqUmJGWVVMSm52SEdv?=
 =?utf-8?B?cysyVGNLR2RXT1huRXprak1nVEZTYmxyaEx5YnRMYkQydTlycEVrOTJSNFdD?=
 =?utf-8?B?OEhJcjVweGZkQVVvUkxnRTJZL3VxbkUvcnpKVmZ6V3BoZDJvcnZWWng4NU1s?=
 =?utf-8?B?NGtVT1o3WVlnaFNJamNlbWJLWTJCVHB4R0czaFlTdHoyMzFoeWoyWk45eHdr?=
 =?utf-8?B?VThlMEVsSUJ6WFQ5ME9Ia3RZbmRQbSt0SVhYOXMwanhMbTJxR0U5RzFCQUt5?=
 =?utf-8?B?Mm1MdFF2VWxicFBremxpcDBNWGd5S3FyWjVPZGFieEhLV1pOQ2pvYXdnZnlz?=
 =?utf-8?B?QWZjTHdUSTYwN09IdTh5UzI2R1lackRzd09Ecm9vNmRyd0RRbERGQTBwTHZU?=
 =?utf-8?B?SWJ6bWVoVzdORWtQR29lWGhVV0ZVaFowQTFIRTVvbGlTbTczdkdLS1Y0T0tV?=
 =?utf-8?B?MnNZVHF3cTVWQXdqalVmMTEraTFGU2xtemNDSjc1K1NPN3ZSWDE1ajR3UGpX?=
 =?utf-8?B?V3dXb1U1Q2xJekd1NlFCeFRUTFdtK0VPSG1LRHFCNkkvNVVySHBHWWIwYjlD?=
 =?utf-8?B?V0tqRkRMdEp3dE5zem5RcHZTUURJYk1BQnFSRkxkVmVnUFNNc1BveVVpd1R5?=
 =?utf-8?Q?t1AG8XYBEgVsBKe0rvqoP7oEyIQHjt8iGt9DxHX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06890ebc-ff79-4900-4f7a-08d982d4256f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 23:03:12.3480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGC3cUOcsu7I/c32NN1n40X0F46nQQERDg6jOzD51wHIG6iaxZ0SYqCOD1yIFkZQVKUSlgoB+1rNIJhLAA7PTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4285
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10121 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280134
X-Proofpoint-GUID: umI-z3292eJKV0p-5zTctRGwbz3u51qI
X-Proofpoint-ORIG-GUID: umI-z3292eJKV0p-5zTctRGwbz3u51qI
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/09/2021 20:37, Nikolay Borisov wrote:
> Currently btrfs-progs will happily enumerate any device which has a
> btrfs filesystem on it. For the majority of use cases that's fine and
> there haven't been any problems with that.

> However, there was a recent
> report

  Could you point to the report or if it is internal?

  Kernel message has the process of name for the device scan.
  We don't have to fix the btrfs-progs end if it is not doing it.

> that in multipath scenario when running "btrfs fi show" after a
> path flap 

  It is better to use 'btrfs fi show -m' it provides kernel perspective.

  What do you mean by path flap here? Do you mean a device-path in a 
multi-path config disappeared forever or failed temporarily?

> instead of the multipath device being show the path device is
> shown. So a multipath filesystem might look like:
> 
> Label: none  uuid: d3c1261f-18be-4015-9fef-6b35759dfdba
> 	Total devices 1 FS bytes used 192.00KiB
> 	devid    1 size 10.00GiB used 536.00MiB path /dev/mapper/3600140501cc1f49e5364f0093869c763

> 
> /dev/mapper/xxx can actually be backed by an arbitrary number of path,

  It is not arbitrary it depends on the number of HBAs configured to the 
storage/LUN in a SAN.

> which in turn are presented to the system as ordinary scsi devices i.e
> /dev/sdd.

  Yeah, it is problematic. Other OSs got away with that approach by 
introducing a path consolidator between the HBA and the target driver.

> If a path flaps and a user re-runs 'btrfs fi show' the output
> would look like:

> Label: none  uuid: d3c1261f-18be-4015-9fef-6b35759dfdba
> 	Total devices 1 FS bytes used 192.00KiB
> 	devid    1 size 10.00GiB used 536.00MiB path /dev/sdd

  Kernel messages will know when we change the device path and who 
called the device scan. Could you pls put those messages here?

Thanks, Anand

> Turns out the output of this command is consumed by libraries and the
> presence of a path device rather than the actual multipath one can cause
> issues.
> 

> Fix this by relying on the fact that path devices are tagged with the
> DM_MULTIPATH_DEVICE_PATH attribute by the respective udev scripts.

> In
> order to access it an optional dependency on libudev is added, if the
> library can't be found then device enumeration will continue working
> as it was before the commit.

> Since libudev doesn't have static library
> for now support for this behavior in case of static builds is going to
> be disabled. Fallback code for static builds will come in a future
> commit.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   Makefile             |  2 +-
>   Makefile.inc.in      |  2 +-
>   common/device-scan.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   configure.ac         |  9 +++++++++
>   4 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 93fe4c2b3e08..e96f66a36b46 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -129,7 +129,7 @@ LIBS = $(LIBS_BASE) $(LIBS_CRYPTO)
>   LIBBTRFS_LIBS = $(LIBS_BASE) $(LIBS_CRYPTO)
>   
>   # Static compilation flags
> -STATIC_CFLAGS = $(CFLAGS) -ffunction-sections -fdata-sections
> +STATIC_CFLAGS = $(CFLAGS) -ffunction-sections -fdata-sections -DSTATIC_BUILD
>   STATIC_LDFLAGS = -static -Wl,--gc-sections
>   STATIC_LIBS = $(STATIC_LIBS_BASE)
>   
> diff --git a/Makefile.inc.in b/Makefile.inc.in
> index 9f49337147b8..c995aef97219 100644
> --- a/Makefile.inc.in
> +++ b/Makefile.inc.in
> @@ -27,7 +27,7 @@ CRYPTO_CFLAGS = @GCRYPT_CFLAGS@ @SODIUM_CFLAGS@ @KCAPI_CFLAGS@
>   SUBST_CFLAGS = @CFLAGS@
>   SUBST_LDFLAGS = @LDFLAGS@
>   
> -LIBS_BASE = @UUID_LIBS@ @BLKID_LIBS@ -L. -pthread
> +LIBS_BASE = @UUID_LIBS@ @BLKID_LIBS@ @LIBUDEV_LIBS@ -L. -pthread
>   LIBS_COMP = @ZLIB_LIBS@ @LZO2_LIBS@ @ZSTD_LIBS@
>   LIBS_PYTHON = @PYTHON_LIBS@
>   LIBS_CRYPTO = @GCRYPT_LIBS@ @SODIUM_LIBS@ @KCAPI_LIBS@
> diff --git a/common/device-scan.c b/common/device-scan.c
> index b5bfe844104b..2ed0e34d3664 100644
> --- a/common/device-scan.c
> +++ b/common/device-scan.c
> @@ -14,6 +14,10 @@
>    * Boston, MA 021110-1307, USA.
>    */
>   
> +#ifdef STATIC_BUILD
> +#undef HAVE_LIBUDEV
> +#endif
> +
>   #include "kerncompat.h"
>   #include <sys/ioctl.h>
>   #include <stdlib.h>
> @@ -25,6 +29,10 @@
>   #include <dirent.h>
>   #include <blkid/blkid.h>
>   #include <uuid/uuid.h>
> +#ifdef HAVE_LIBUDEV
> +#include <sys/stat.h>
> +#include <libudev.h>
> +#endif
>   #include "kernel-lib/overflow.h"
>   #include "common/path-utils.h"
>   #include "common/device-scan.h"
> @@ -364,6 +372,37 @@ void free_seen_fsid(struct seen_fsid *seen_fsid_hash[])
>   	}
>   }
>   
> +#ifdef HAVE_LIBUDEV
> +static bool is_path_device(char *device_path)
> +{
> +	struct udev *udev = NULL;
> +	struct udev_device *dev = NULL;
> +	struct stat dev_stat;
> +	const char *val;
> +	bool ret = false;
> +
> +	if (stat(device_path, &dev_stat) < 0)
> +		return false;
> +
> +	udev = udev_new();
> +	if (!udev)
> +		goto out;
> +
> +	dev = udev_device_new_from_devnum(udev, 'b', dev_stat.st_rdev);
> +	if (!dev)
> +		goto out;
> +
> +	val = udev_device_get_property_value(dev, "DM_MULTIPATH_DEVICE_PATH");
> +	if (val && atoi(val) > 0)
> +		ret = true;
> +out:
> +	udev_device_unref(dev);
> +	udev_unref(udev);
> +
> +	return ret;
> +}
> +#endif
> +
>   int btrfs_scan_devices(int verbose)
>   {
>   	int fd = -1;
> @@ -394,6 +433,11 @@ int btrfs_scan_devices(int verbose)
>   		/* if we are here its definitely a btrfs disk*/
>   		strncpy_null(path, blkid_dev_devname(dev));
>   
> +#ifdef HAVE_LIBUDEV
> +		if (is_path_device(path))
> +			continue;
> +#endif
> +
>   		fd = open(path, O_RDONLY);
>   		if (fd < 0) {
>   			error("cannot open %s: %m", path);
> diff --git a/configure.ac b/configure.ac
> index 038c2688421c..d0ceb0d70d16 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -304,6 +304,15 @@ PKG_STATIC(UUID_LIBS_STATIC, [uuid])
>   PKG_CHECK_MODULES(ZLIB, [zlib])
>   PKG_STATIC(ZLIB_LIBS_STATIC, [zlib])
>   
> +PKG_CHECK_EXISTS([libudev], [pkg_config_libudev=yes], [pkg_config_libudev=no])
> +if test "x$pkg_config_libudev" = xyes; then
> +	PKG_CHECK_MODULES([LIBUDEV], [libudev])
> +	AC_DEFINE([HAVE_LIBUDEV], [1], [Define to 1 if libudev is available])
> +else
> +	AC_MSG_CHECKING([for LIBUDEV])
> +	AC_MSG_RESULT([no])
> +fi
> +
>   AC_ARG_ENABLE([zstd],
>   	AS_HELP_STRING([--disable-zstd], [build without zstd support]),
>   	[], [enable_zstd=yes]
> 


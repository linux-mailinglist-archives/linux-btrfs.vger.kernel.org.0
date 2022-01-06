Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109EE485CCD
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 01:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245713AbiAFAFB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 19:05:01 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3926 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245752AbiAFAEu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 19:04:50 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205N4Yxo023582;
        Thu, 6 Jan 2022 00:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fFl2fl099xnVSFdccX/+giEu8RNHQuHjY3beFCMci0Y=;
 b=JEEG7+5CqYBF5klOzwF9H1+FxXXpyQi3VvhLOZZnF77tUxrxcV1ZwnKpwiX5lsSqj5g6
 tWoTIX6DrfBcHIxKkoGF/Q5jMeOeJ1e7MCDjO+el2hz+KL2v0LwgO/1iEBMvKHX5lxgY
 dq52Gv8D/wdpBakkt1AJsy05yR0KV+9yp6Zr7bZ02qeOqZCz/Nr9NPwBEtIXkAErY7Se
 yRv3/41GffYWHfnVHTpktchWCfI/24vn2FA+Qm5VyeAl12On06h2NLQMr1MY2uMpVSjg
 ZJ9TtWrqd0PXU5XGk+cM/p7GVH7YaKRhvOnPNHCAPb9rdkJ0xuUdbIeniPH9BNHiZ65V wA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpeg2gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 00:04:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205Ntm87187222;
        Thu, 6 Jan 2022 00:04:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3030.oracle.com with ESMTP id 3ddmqbtqnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 00:04:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwrQ5bCGd7nztVMWusKaBkzw4QROzy5O+w8TLr6wG+HghydIeD6w/NTCHF7tTNEdLG7NlXa0uYZ4iYEDxYdeBAaky8YB7FYbFTdNz+hufw6cgVkNLdDIjopclA5HwQI8rAxuyA8G+JbkB5CbPCS0TSyTt8uPR+itML4OLYPLsbkDuvHGdbM9V3jeQoGtXWNxERN0UGaJM/bI1+DAOUfWw1BgL7Bu7fRnlykKk1V1LFulp2BFbCaILgCKAPA8X8uRTdz5rUzPPGOnsmsy0cu17mJ+ebfvHDTphwaEMiQ3uGf/EDE72A2GZYMbvZqkuQcLKCifqS9XXgCetkPjxMBkzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFl2fl099xnVSFdccX/+giEu8RNHQuHjY3beFCMci0Y=;
 b=EUBAz9Yi6PV5o3h2d4duI+7O7XJpkyvdaOqPq95cwtJ0xTSQIvdkDKIFQdpg2yVg5ZAb1EODvF6T6D4SsLE884PUMetCyiuUkddn0zSk5rFf723J9m1omB8amNwVUlNqEVSlVZ6hEhQkdUF7guaMz5e2pmfCGgdLVIdxiHdXit8B51xr8cGFEgSZz5LtGqcqdiQgeemLKtKT9dBr++DCtJTA3mjuxEX96BJ0aVc4dCTpp8qGZSADDvD9oJULDt57SixKIavN2nUCvVSA6f49djHbC7I/UzHHCvTEZ5OchVMRy3lfUPBxGeYsDFR4gqIhMs+cGnGkOMt6EvxV1Tg+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFl2fl099xnVSFdccX/+giEu8RNHQuHjY3beFCMci0Y=;
 b=owhWVWiW9Mm/GI/iwknwOvVAez1GNu6cSmSsdX6/ya+TYPMAf/E4xiMfxdCT/XF3mkd5I9zYR7g3pbz0VrBokTdFdjwXzAOobP9Wffue12a7R1LBOme8ocYDjN0KG1gV1TVQmIVY7SW19v/BGIGF3EqiS1KutaPbSzikTY11sKY=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4223.namprd10.prod.outlook.com (2603:10b6:208:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 00:04:43 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4844.017; Thu, 6 Jan 2022
 00:04:43 +0000
Message-ID: <98a34772-990c-5e8e-5402-a6d857fc0292@oracle.com>
Date:   Thu, 6 Jan 2022 08:04:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 0/2] btrfs-progs: read device fsid from the sysfs
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     David Sterba <dsterba@suse.com>
References: <cover.1634598659.git.anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <cover.1634598659.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::36) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0254d865-33a6-42fa-9397-08d9d0a823cd
X-MS-TrafficTypeDiagnostic: MN2PR10MB4223:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB42234F3E8E256EC116CEB4C5E54C9@MN2PR10MB4223.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anCBohpWSmx/MDW6m1lLvmoUIPb8PdhZ1V/TKjW/3H6Xkm2dFviyuPELZcZ7eKjlorwJzSlPw97FSrGVA4/zI2KE97SS1j181XwhZ8RQKioV9tpXWN0M4yCUeESy+TawjaO9EDxjmNaQfnQU0QtI/pMUqkHwQpf9TDaOwn/+rXtDkwVPjGJsAXCx4xGs/hoxNqvkwkHsiRrRb7ao/B/sjKhZ12qN7/HzaCQ5ObKiGkDy6gcfjuSL8HShY088gVImM0g37FMOirUcoQ53zqldd5Rpg/K3va2XggDZL9iBKxmxab29Gf64Y9Mg+O4Vu2nwA77zi2zWWaJy4HQrQDw2rro8B5xpxNkVmCqqfBKHqDXuP012pv+SfARnyGfKul5m/c2LAn9P3by5D4jtnO4LNP2wiejI8I5bMUbaLruinHkYfO+NdJFxmUdw9EG5hkj231JbrCrl/RBzV/KA77gvGXC5IkbzBrPLXPUBr5Cw6wlreJp5fH6+GT5jDQMxabIBNsxrFREljR4pzVjRNUPqbYom6+BIpd4foNLX+xUq6PRGzJB/Oc2YyC4XAXCWKLzlBYInWu5vfJRCkTiO0Wc0j7SbeRRInQh09aVSC8DD/JeJ/RB45tXbMhp6cCR/QqUKAlcGuCRgXm4wpgEFcZ8b9AM98PO01+R360NXMGQ7Q2cQXO9pysP2KA576E969QP3Gtm7xQApwu4GTO5fqg5K11Ts4yOvqD2yM4f3ddOiMmg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(86362001)(316002)(31696002)(508600001)(31686004)(66556008)(6506007)(66476007)(6486002)(66946007)(53546011)(8676002)(4326008)(44832011)(38100700002)(2616005)(6512007)(5660300002)(6916009)(8936002)(6666004)(2906002)(83380400001)(186003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkpteW81ZjhRZGN0SmhaaittWldSR2UyT2tMVVdWT0d0RzF3OVhGVkJQa2tV?=
 =?utf-8?B?TDBzTTRGV3NoRkxkZUhvOTN3Mm5ZOGZiVm1PMFhlaGVJK0ZaQ1VqYVFjRldL?=
 =?utf-8?B?VFVJV0MzTDh5eGF1eWxVUmZGTi9kc3NIcFFieFdmK1EwUjZkMmZPLy90TG5I?=
 =?utf-8?B?ZjJBYXJWcXYyOGs5YnArdHNFQzFhbFEwa3ZkQUoyaktzeTdJcUUrekwycUNm?=
 =?utf-8?B?aTRYUnR1dWRicHkzUVllUFp3YW5QN21oZzdMQjRLL2UzN2ZXekFYb2RVODkz?=
 =?utf-8?B?amV6V2hQVjdSSTh3aHF2Y0lnait2R2JOYStMLzVxUjRFc00rMTF5bk5DZGxy?=
 =?utf-8?B?a203VC9CTDhkQWlJQjVCT1pNUENDeWFrM3BnVUNzOWZzb0JtK2d4K3lTdjJZ?=
 =?utf-8?B?NFdaenZiWFUzQUNCQThqcERhN0tUVXF1d1ZRMm5yUVRKeVZGNUxURTdLU0xS?=
 =?utf-8?B?UjczL3BUeE5LZFVwL0RtY3Y3cVFyVG85WE9uRUNlSGo2YzNnSFdoVUdsSE5J?=
 =?utf-8?B?TEhhZ2JKVlF0YWt5cnBVR3E1VUdHTE40Y1lGMkFaTGo2RjMrUHdldGpZWTlH?=
 =?utf-8?B?K0pVQThMVlVFUTZITEI1NUE4YTFzQlRzcjNpck4rb0VtMHRJUDRsUHllb1RW?=
 =?utf-8?B?WTBxMzFiNW5hQ29yMkhmVjlEU2IyZFdJUC9tRTNwSjFyYmtrWmV4TnJabG9r?=
 =?utf-8?B?eG5KdDBmWTAvTW12ajNhQTBuN1N0Q2gzMHorSEFMV1JUWU13aUFlMFFaeVJS?=
 =?utf-8?B?R0hVOVlLcGc5SHVDR1h0U0xZeFJvRDI2Um9xcEpLWVh5azdybjVQQVducEhl?=
 =?utf-8?B?L1FkcVVHaWFwYVFCWmcwbmIyYUU0SnFGU0NnN3k2M2wxY3ozKzZGd041Yy9Q?=
 =?utf-8?B?Vm5SYTdwTUpjL0JMc0lZdThRV29jSEkwRzhZTEtEUitxanpFdHIwYjViVjBy?=
 =?utf-8?B?MERWUWVEM2dmdEIzZllJeTEvQXhGZFBBQWJaOGx0RVUvZXFXRHFVOGo1cEdj?=
 =?utf-8?B?VDdaRUFQM09WSmpxSm9rRzFKUmExSStUUnVxbnl2NDhBQmFTSFZGZWpqc0g3?=
 =?utf-8?B?YWRyallyZHNBOW16YkdpMkpxUXNNSHpPcUpDeG82RFhRemF6ZFA2ejI4V1dx?=
 =?utf-8?B?YUtmQXNEdWpSVGdZRUZydjdsUUlJOWJ1d2NpRW9yaGk5aDA3MVVrM2JqdUM3?=
 =?utf-8?B?YkNZNGpiUTVUMmdoSmFPMG5Ob2dJdDY3cmwyc3JKVHZDdEg5bzEreFFka29i?=
 =?utf-8?B?eWhzWUZIcXVyMnVOUkpuTVdGaUVMZEdkMU0wMi9DUW9jL2o3bWNRYmNUcEVz?=
 =?utf-8?B?UG1jYUlzZnhtN2dPWWl4RThnVlA4K2hvMzNTNXoyb1BTek90L0I1R2FveXp4?=
 =?utf-8?B?aGZsUDMvSGJ3MzJ5aFlJM0I3azJkNUdKMXpJYzVqVnBjNmNMR2tPVVNiSWZh?=
 =?utf-8?B?UXF0eGNlc1h4ZDZmT3lUZkRzTGVmOHJXS1gwRHM0cEN3S2h3U1ExZU91bTNL?=
 =?utf-8?B?SVhpQmQzc0dkRU9QcHAyVmVsZC80SWI2cjkrMHFxakF1QnppZkl3R2JWb001?=
 =?utf-8?B?UkZaa1UwVEJ6NEp4RlBmUm5qdVIvNHNsR1pONHo2UzlpeGZaYVRLZTBwaWZ0?=
 =?utf-8?B?YTd6TmFPZFZVTGtXZVUyNklub1J4L3FWdFdpOE9wa2xpYUh3bGlDNFg0OVFW?=
 =?utf-8?B?UStubXFnRlh0QkdFOGNlMVZiNGVJNmhPV1RiaVhQRVNFUmIvZFVtbWxCem1z?=
 =?utf-8?B?dGFncXFCV3JtelVQNDFITTlSWTB2QmZUSm9wV2pUSkdiV0VYVE11a2h0L1JY?=
 =?utf-8?B?bGdYWkNFRk5SVllzMXZoUmFhSXdnM1d3SWM4anhQZ2pzL2Z2YVJncjkyN2VN?=
 =?utf-8?B?RXBMZTlVb1NHNkIwTkdRYmNObVFhWTFkZUpsMW5wMHF0a2dTb2xtNTdXcFlt?=
 =?utf-8?B?WTVRcTFLMkN6UXZCYTdvRDNLZjFFUVRrY2pMQ3c5ek1LUmJFMFdIZmdCV0FR?=
 =?utf-8?B?QnhPQmd3TzBDWXJUUmdZdWtRQmt1bHFBR0NhUzh6UU4xTFFyeW5SSXpFR2pI?=
 =?utf-8?B?N3lLWDJuWURuaFBnekx0OXNwRkN4YnZKNkQvTW44Szd0UkhmczVzZjJqVktW?=
 =?utf-8?B?TEJKc3dOeVUzNFU4bFN0NFhpd0VoRnBFM2IzOWRHckJMcEZDczhhUmNPOVYr?=
 =?utf-8?Q?ZMWd0vsnceOnhga2laFaHmw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0254d865-33a6-42fa-9397-08d9d0a823cd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 00:04:42.8718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MW29QwpKC0MhUUrClrJDfqszMYBmMbfsumnIU0R95SEorL/VfOyHlPY6g4qy7xSM6BFUhdpPfOhgFJwylrJzOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4223
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201050152
X-Proofpoint-ORIG-GUID: NhUCDcLW1A3-5AwetG5H8Es3Oc-SJnpG
X-Proofpoint-GUID: NhUCDcLW1A3-5AwetG5H8Es3Oc-SJnpG
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Gentle ping?

The related kernel patch is already in misc-next.
I don't find this btrfs-progs patch-set in the devel branch.

Thanks, Anand


On 19/10/2021 08:23, Anand Jain wrote:
> The following test case fails as it trying to read the fsid from the sb
> for a missing device.
> 
>     $ mkfs.btrfs -f -draid1 -mraid1 $DEV1 $DEV2
>     $ btrfstune -S 1 $DEV1
>     $ wipefs -a $DEV2
>     $ btrfs dev scan --forget
>     $ mount -o degraded $DEV1 /btrfs
>     $ btrfs device add $DEV3 /btrfs -f
> 
>     $ btrfs fi us /btrfs
>       ERROR: unexpected number of devices: 1 >= 1
>       ERROR: if seed device is used, try running this command as root
>   
> The kernel patch [1] in the mailing list provided a sysfs interface
> to read the fsid of the device, so use it instead.
> 
>   [1]  btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
> 
> This patch also retains the old method that is to read the SB for
> backward compatibility purposes.
> 
> Anand Jain (2):
>    btrfs-progs: prepare helper device_is_seed
>    btrfs-progs: read fsid from the sysfs in device_is_seed
> 
>   cmds/filesystem-usage.c | 47 ++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 42 insertions(+), 5 deletions(-)
> 

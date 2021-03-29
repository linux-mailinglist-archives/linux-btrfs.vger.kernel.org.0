Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA1934C23B
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 05:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhC2Ddy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 23:33:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60696 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhC2DdU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 23:33:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12T3Ob9U097721;
        Mon, 29 Mar 2021 03:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Rkrta8jLQRFROFkxHDIp7trk86ALkAWTZ5YdeBtzvtA=;
 b=u+y+9YL8BxzE/2UP/96ioU/I94Xpr3sZORvo07NaHKlzxasmZ2lziRVGV8KnnUmRPMhj
 HMLrCo6sxYsSKMF/LP0xBtYr4xxInfjjcCBgdBDw5i05vmHU7FDK0DRUrA6jeL23ZhvO
 a/1uERLawrIkMHYjcnIdt27F0zfcgqumUwoFiKchQUCrf+/Wvq/ZzTI3vSqB4DvuEnWe
 nC1JmQKYsipA63f+CGdSkyIWBtrGxSYKxxKBJU6+BNIpOAYb8ECYVprKR+ZOZhD2Np+i
 VA3k8aP/6/pb1bI984XqomukmqWA838aBPyykhwM+lphCTtef0LlOnwutm4zTOJDSlfh 3g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37hwbna3sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 03:33:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12T3OgJf023331;
        Mon, 29 Mar 2021 03:33:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3020.oracle.com with ESMTP id 37jekwmdvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 03:33:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIE178uJhMDxciqpxBPVAQPGIP7h751z9nY5P0qy1FGAZ2ISXPR2g99XrsBtEK3TEVQv3WI0Fi8SE9/dInRs1UmayiSUYhP/bYwdhHs2OcfS+OnQc/Z9EayIB6Dq2aQYSrNaGF21POryJcn2bV9j24dKsfm+bzdYUx9hqDATAb5sqQExoWffs0nbd8F1S47WRBISF8GfVth6iXA1hEuX99tjHCJGsK6xjM7tQPcD3wSzoSt4xoauBEysMGoqNW5xLJvcXt/36QAdXp0oeDEyUjXQs6b+TW3ONo7oGvQUaKGD8PEGFQrA/itL1RfHA8+Un2OKAotLVuAAGuV+SqpNHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rkrta8jLQRFROFkxHDIp7trk86ALkAWTZ5YdeBtzvtA=;
 b=LH4PBN8IXvsyH1Ca/12OajmOIh/B4nBCnNHfQHDOdNHAnDEIU7B++J+pjdHzOE3tI24e/YyaVxRfqEImyPl8WuCFW0Og9KIppruxCO5wvE9hzcpIbTqCon1XDlLhg6BJa7f9Y2FbS0Pz6xvP+3CAweep3G2qqAWp2TtFCn6NNUqaUyIF1uMxgepHKrk39K558TfIT9HSEZRiUQwdTOn+4jTxi7iQNivXGLbFInbQ3ZeGlRjQiWjZnYiC+4jEdwFVvKzdGc1ZKf7EFbBCJpou3MhfPS2JLDCL4sdwWkIaVe1pzxHLOywmzWXPhssl8/pvrLY16D/LBllrF1P2tCd6UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rkrta8jLQRFROFkxHDIp7trk86ALkAWTZ5YdeBtzvtA=;
 b=UkW5veZiiaWxM82hspxxxHzOf5qVR9SliezRRgIOnvor3tbuHUOfUtv04ZG3d1XOpMdc5BuOs4okPGEJ7KA7ftA81557OOfv6Un3QKZYgYmBghpa4DDKn8DuF9ONxY/kuIXBhYtrS8IAl51opUkvZUWUU+XJ5hIuZFAISpROh+E=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4095.namprd10.prod.outlook.com (2603:10b6:208:11b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Mon, 29 Mar
 2021 03:33:13 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076%6]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 03:33:13 +0000
Subject: Re: [PATCH 0/1] zoned: moving superblock logging zones
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <cover.1615773143.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <814c44b8-b700-7878-a881-f89cd99982e8@oracle.com>
Date:   Mon, 29 Mar 2021 11:33:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <cover.1615773143.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:d853:d2aa:de3d:de6c]
X-ClientProxiedBy: SG2PR03CA0163.apcprd03.prod.outlook.com
 (2603:1096:4:c9::18) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:d853:d2aa:de3d:de6c] (2406:3003:2006:2288:d853:d2aa:de3d:de6c) by SG2PR03CA0163.apcprd03.prod.outlook.com (2603:1096:4:c9::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16 via Frontend Transport; Mon, 29 Mar 2021 03:33:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88843004-81ef-4af3-f148-08d8f2636197
X-MS-TrafficTypeDiagnostic: MN2PR10MB4095:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4095858CEDBBDB310BB50B54E57E9@MN2PR10MB4095.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MBesma+j/IadIEr0nft7dAHf5YwqtENl2VuDu8WAycmSk+Qwcz9kpntRHPssYFoPNcIRCWR2yzMMy6FBxSAt61olxdLtsAEPySKQorINcPEKeuHEHO6p1XXhNLdr+iWxnTtIsc+IbL+ojnYmvdkpj8S8HivzXL+Bzy0LtwAvEe/PWn9vKFf9jqKmISN1btpvW+fakrZoS463DaLp32XCeM2ZqOB7SmVQbFfNYwerG8O2Zp+We15E4iC6FBchuRvVcsSSkIYE7JVaVqmqTfyr01pZYxF9HUbGx26K6qMaV7b6ep2j53VuVQpY3ZCS6lG3Q2QauxrsIOcocnGWv9QGrMAyCgJTHtO/BxFALllmjh75GA1dOWx3sQ6pVz0BLMGO/Vm8W4euCDVVIImRwiDa6qaUBhxZu4SavWlFEZl+GvA2zplWudkogVUNoeE58q97KH0WXErXPqAFsiQuCB0GjTzp2jBiH/S3ztpT5K1Y6LoWPGEJJpo+tT0ZoTY04LR4B9yLq2QI41YjSW+4/UuivKpY9uq7mYDOlXVQPSTTaP7yWppZPSs4e05r5qgi/BDoSXQTAA0ETK3WkbJ/VyWaUxOSe7kAYbp7VSa9yAUUegsconHmfLGFBTjkKmy/eXadvptkCNBVopMCRVOnovLk3I98MsCLG6Bx1W0IbvzVD+j+5ppwZaeTeoaoluFlSSKNm7uCwfVj/iow5ltgq+2oUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(39860400002)(136003)(5660300002)(66946007)(86362001)(66476007)(186003)(16526019)(66556008)(8676002)(2616005)(478600001)(36756003)(53546011)(83380400001)(38100700001)(44832011)(31686004)(6486002)(2906002)(316002)(31696002)(6666004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VE5FUzlYVDBqSjF6Wmp5WmpsdExqcUdXUXpxOVo2SWRDR2Rza1JGbExBNE1U?=
 =?utf-8?B?dENGUDczeG1JUktDam5PeUdaVnlra2M0Q0pVOU5YOGZ1YVFVZUpIYmlyRmln?=
 =?utf-8?B?cVlrVTlTVmtidGFnWVF4MG5tdU9wMTQzRTdVNEVhSU1KS0MyYXhOVS9BdTZm?=
 =?utf-8?B?UVhXcXRNOFoxYWRueitWSnVIcW8rVzNVaEtjUFkzTXdwRmovNk85VHFiMzFx?=
 =?utf-8?B?dHVmWFJSZUhPK2o5cTQzYmRjYWtyc3dyUzVVTWV5T3RlbDlNWmNPZDBWR01C?=
 =?utf-8?B?enBSb1dsUVVkdDZ5SThQU1JkVTNNdU5hUUVrcG55aEkyWmFQNjBxQmNIMDFV?=
 =?utf-8?B?VE9ubDQzQkRseFgrWEJnZmpZNUpSK0lUZDZYWW5mS2RsM3N3R0wrU0srQ0xF?=
 =?utf-8?B?cndCZ2pPTTVLVU9rRFVBSnFVUFNrQ1luUnFxNXVHSndON1JmYnpzWUlpWTUv?=
 =?utf-8?B?Z1ZhU1UzSEs3N1lzRFppUWN4L3U1cXcrZGt0K1hiRHZXSnNZekNRNm00ZTkx?=
 =?utf-8?B?V28yUEhObFdodUxGSkxXeU4wZExVaTdIbEFEUjdwSjZRVkVpaFBVMjFtbWVq?=
 =?utf-8?B?bCtIUUZvZFFQUFFablk1VE1iMzFaMmpoSTBhbDNpUkJqeDVLblBXOFQ1dDFT?=
 =?utf-8?B?WDUwaE9Gd0I5SFVVR0k1bWFIOUdMeThLM3V3OHpTdTJTNEl4NjVVUTNRYnk4?=
 =?utf-8?B?Y2VZazBhNmdHN0FsRURGSHJQekJqc2JPcDlRVVhlQjIvdjdkQkIvVWJUcFVo?=
 =?utf-8?B?MHRqWmVOM0lrNUlzYU4xY3dScEV2TFk5d3ljNVU4QTZiaHoyckM2Lyt4a25u?=
 =?utf-8?B?SDU5YWFsMWFGY29kdVZWL052aTdseE14M0p4QWtTYVFIaGZKcFl5RUVFK3ZH?=
 =?utf-8?B?VWY0V3l4a1NqekdwcXRUSHFTcTJQTUNVM2RSSE1VRkVQbEczR0NrRkxuUW9B?=
 =?utf-8?B?Q1NXVXl0RkMvUHIybElFK0JrRTUrSEpGOWZZVGRJVGhNNW02eWdKNzFHbXlU?=
 =?utf-8?B?ay9vQlpnaXltYlpyNTlZRkwrVUdOSWxleWNqY01VN3RnWGNWYzd2akJLNm5K?=
 =?utf-8?B?NWJjd2RVL0pFZ2NOYXJ4TlRrMkRvc3NBZFprTXNzem8vMzIyZWhPVmVJcjZ0?=
 =?utf-8?B?ay9yQzRMTDEvQndKaXMvbkw4SWgyK1FxZ09NRytIZmY2aDBqQmpwTWRwdDZo?=
 =?utf-8?B?am9vSmlFaW5wTTk1TTlteUE2WXdmT1JLcVZwNmV2VWpjT2lvUGZFS0NIN3hY?=
 =?utf-8?B?d0hyUDZjRFBIditJeUtqOTA2bUhTRXA1SjVvaFB2NTBTVHMzM1d6aW4xT0hY?=
 =?utf-8?B?U2NtNTZEeXN1WUdOdGRBQ0gyTWs3NzVjclQwQ3JrZUZMdlNRSjZOcldHL21x?=
 =?utf-8?B?eUVadkFDWElHVXp4NE5HMEcxU2tuRmJSZ3MvZ1hMbFFvYU9wWG51VzVsM3RW?=
 =?utf-8?B?ZWhBNi94dVNKOHZ3Z1lDa0JRS2xrV2U2TW9PVWNCQTFmSjgzd29PVEVzd1dE?=
 =?utf-8?B?ZURXb0g4RVpkMCtiUVZQdjkrOG00Nm5UTW45aThtaUtlaUI0R052K3BhSVNH?=
 =?utf-8?B?S2ZqUzNqODlwTzd6cjhHaDkrRzk0RHVtYVNjK0RBT3lVYnlkVUZDQjhIV1hK?=
 =?utf-8?B?empVNEZxSjFVaEMyVTZEZTUxdVJGSEYreTloQTJDUzk3N3NXenM0M29Vcnh2?=
 =?utf-8?B?eXRBZmhYS3RDV1QwUjRXNGtRTkdTck1NNXdPUmI5ZmJKcWxUamFxM1d1ZENv?=
 =?utf-8?B?djRhMmRYdVFyc2JLQUVaT0xabXdKb2hxOHpwamxwdU5KdzNIOWYrY0tRU3FD?=
 =?utf-8?B?bDRRYmVrMXJROWRhM1d5YlhXTUs5bTA3UXBpT1hiOWZWQVQraVFCQUJwMW5B?=
 =?utf-8?Q?yB8KyJ1SjxqMA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88843004-81ef-4af3-f148-08d8f2636197
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 03:33:12.9282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ev46n7bCS4Fvp7dQONvIGrRN2qKmh0C3JomS/dbDmKZWkCvZ39gfeHtqjEm3kgYQXE5gciPKcNStxV4bT0Jgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4095
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9937 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290025
X-Proofpoint-GUID: 4WNIU0HwJFCw8Pu2rfbIX3UhwvTTxVj9
X-Proofpoint-ORIG-GUID: 4WNIU0HwJFCw8Pu2rfbIX3UhwvTTxVj9
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9937 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 clxscore=1015
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290025
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/03/2021 13:53, Naohiro Aota wrote:
> The following patch will change the superblock logging zones' location from
> fixed zone number to fixed LBAs.
> 
> Here is a background of how the superblock is working on zoned btrfs.
> 
> This document will be promoted to btrfs-dev-docs in the future.
> 
> # Superblock logging for zoned btrfs
> 
> The superblock and its copies are the only data structures in btrfs with a
> fixed location on a device. Since we cannot overwrite these blocks if they
> are placed in sequential write required zones, we cannot use the regular
> method of updating superblocks with zoned btrfs.

  Looks like a ZBC which does the write pointer reset and write could 
have helped here.

> We also cannot limit the
> position of superblocks to conventional zones as that would prevent using
> zoned block devices that do not have this zone type (e.g. NVMe ZNS SSDs).
> 
> To solve this problem, we use superblock log writing. This method uses two
> sequential write required zones as a circular buffer to write updated
> superblocks. Once the first zone is filled up, start writing into the
> second zone. When both zones are filled up and before start writing to the
> first zone again, the first zone is reset and writing continues in the
> first zone. Once the first zone is full, reset the second zone, and write
> the latest superblock in the second zone. With this logging, we can always
> determine the position of the latest superblock by inspecting the zones'
> write pointer information provided by the device. One corner case is when
> both zones are full. For this situation, we read out the last superblock of
> each zone and compare them to determine which copy is the latest one.
> 
> ## Placement of superblock logging zones
> 
> We use the following three pairs of zones containing fixed offset
> locations, regardless of the device zone size.
> 
>    - Primary superblock: zone starting at offset 0 and the following zone
>    - First copy: zone containing offset 64GB and the following zone
>    - Second copy: zone containing offset 256GB and the following zone
> 
> These zones are reserved for superblock logging and never used for data or
> metadata blocks. Zones containing the offsets used to store superblocks in
> a regular btrfs volume (no zoned case) are also reserved to avoid
> confusion.
> 
> The first copy position is much larger than for a regular btrfs volume
> (64M).  This increase is to avoid overlapping with the log zones for the
> primary superblock. This higher location is arbitrary but allows supporting
> devices with very large zone size, up to 32GB. But we only allow zone sizes
> up to 8GB for now.
> 
> ## Writing superblock in conventional zones
> 
> Conventional zones do not have a write pointer. This zone type thus cannot
> be used with superblock logging since determining the position of the
> latest copy of the superblock in a zone pair would be impossible.
> 
> To address this problem, if either of the zones containing the fixed offset
> locations for zone logging is a conventional zone, superblock updates are
> done in-place using the first block of the conventional zone.
> 
> ## Reading zoned btrfs dump image without zone information
> 
> Reading a zoned btrfs image without zone information is challenging but
> possible.
> 
> We can always find a superblock copy at or after the fixed offset locations
> determining the logging zones position. With such copy, the superblock
> incompatible flags indicates if the volume is zoned or not. With a chunk
> item in the sys_chunk_array, we can determine the zone size from the size
> of a device extent, itself determined from the chunk length, num_stripes,
> and sub_stripes.  With this information, all blocks within the 2 logging
> zones containing the fixed locations can be inspected to find the newest
> superblock copy.
> 
> The first zone of a log pair may be empty and have no superblock copy. This
> can happen if a system crashes after resetting the first zone of a pair and
> before writing out a new superblock. In this case, a superblock copy can be
> found in the second zone of a log pair. The start of this second zone can
> be found by inspecting the blocks located at the fixed offset of the log
> pair plus the possible zone size (4M [1], 8M, 16M, 32M, 64M, 128M, 256M,
> 512M, 1G, 2G, 4G, 8G [2])[3]. Once we find a superblock, we can follow the
> same instruction above to find the latest superblock copy within the zone
> log pair.
> 
> [1] 4M = BTRFS_MKFS_SYSTEM_GROUP_SIZE. We cannot mkfs on a device with a
> zone size less than 4MB because we cannot create the initial temporary
> system chunk with the size.
> [2] The maximum size we support for now.
> [3] The zone size is limited to these 11 cases, as it must be a power of 2.
> 
> Once we find the latest superblock, it is no different than reading a
> regular btrfs image. You can further confirm the determined zone size by
> comparing it with the size of a device extent because it is the same as the
> zone size.
> 
> Actually, since the writing offset within the logging buffer is different
> from the primary to copies [4], the timing when resetting the former zone
> will become different. So, we can also try reading the head of the buffer
> of a copy in case of missing superblock at offset 0.
> 
> [4] Because mkfs update the primary in the initial process, advancing only
> the write pointer of the primary log buffer
> 
> ## Superblock writing on an emulated zoned device
> 
> By mounting a regular device in zoned mode, btrfs emulates conventional
> zones by slicing the device with a fixed size. In this case, however, we do
> not follow the above rule of writing superblocks at the head of the logging
> zones if they are conventional. Doing so would introduce a chicken-and-egg
> problem. To know the given btrfs is zoned btrfs, we need to read a
> superblock to see the incompatible flags. But, to read a superblock
> properly from a zoned position, we need to know the file-system is zoned a
> priori (e.g. resided in a zoned device), leading to a recursive dependency.
> 
> We can use the regular super block update method on an emulated zoned
> device to break the recursion. Since the zones containing the regular
> locations are always reserved, it is safe to do so. Then, we can naturally
> read a regular superblock on a regular device and determine the file-system
> is zoned or not.
> 
> Naohiro Aota (1):
>    btrfs: zoned: move superblock logging zone location
> 
>   fs/btrfs/zoned.c | 40 ++++++++++++++++++++++++++++++----------
>   1 file changed, 30 insertions(+), 10 deletions(-)
> 


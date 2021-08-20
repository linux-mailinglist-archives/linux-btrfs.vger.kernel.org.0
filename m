Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7B83F2B47
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 13:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbhHTLef (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 07:34:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26416 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240027AbhHTLef (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 07:34:35 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17KBG0Eb006305;
        Fri, 20 Aug 2021 11:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AuNykrFYb2FsgVwd0qHOdwA5QtDi9ct8d1cjXVLkqwo=;
 b=C/D1QUKBz5LHMuY/vGuOdibC2YLDTeUQLSxvs/IncMw+8bnSA0cGKoOAVB5OrGR2SyxO
 iuGxKE3msMUBYkul42xrnG/66YcO61pxwzAFxvYHUZmxY05XsD5/C70G8Ol59yhbio/z
 D+Jq9lHyPYBdTx0ZXorBoePRGAvGnVtqZp61UNsmxeqFqoUX//GO2YnARrkxffaae3h6
 vos2aoffl1DqFVqKf6lCvVE2JRbV6GggNSpIJTZc+MVtfr88tVH025KzWtToSsE/5gkk
 fc7jtA6ytJnw5htcBP8lpRnBHQdEFbDXBH8OuH/NCgaTstJLuOilxImwrnXZtJJU6YNc gQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=AuNykrFYb2FsgVwd0qHOdwA5QtDi9ct8d1cjXVLkqwo=;
 b=s/Xq8vgdPPQZS11VQcjtYEmw6sl4RXdU0DwCGLS9v7xRL/qYwXi/NklKolVjlVDtKT9+
 l5cN1EcU5qdGjT7vYU/tyoGe0oVKkxdU2xIWWSEJrzT/Rg6oQhwbJSp0VZ+wHIC9nv4i
 lt2QLMbTfj9EaxEXoP3me+nubUiAhzk+MJQ9BoKMXNp4tYSDU4ZXB4fH0WG2CP3aUSi4
 ujKQAw0yeh9MCR2cPwefuu2BQ6scdiho6PPnrSHGC2qW7nTm1WMBtlYpO5d5CL6hnxXT
 BezAxH4c0C24tlnS+1p8+/Wo29nt+L0vDn+Bt38mwVIhG1bMEXsbWWYVd9ThX+ulGREa EQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agykmnr0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 11:33:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17KBF680008098;
        Fri, 20 Aug 2021 11:33:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by aserp3030.oracle.com with ESMTP id 3ae3vncufk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 11:33:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4UtnKvsAZL2bLahsctCoMk5djjdffJaauYkK56e7NSz7GherZ+B9lA3wg4nD4N1mI5JDrFwQr4K39WdMCOdfxaEeK9werwnM4aFIE/ePF0JR0pDVx9TMGrIdJ6JU/nERW75c69JXUkwjjdQewSEJ+ILuIRBoDgDG16wwYRD6+Ugl0Yz/uYxtiG6A9b746o7I52k5eNkUKX03wKmnQad0DkO3KCIPk0CLk6vbP/Sk3QHhmUS+5F/y6nkJURdA0JP41jFJYjBiU7G1X1tLw6ynXrDeOfBnLQFViXrRnOgpx2QKzCsORsklB+27fGFkLXzbiKyxcvkD3ELzgF+9kYwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuNykrFYb2FsgVwd0qHOdwA5QtDi9ct8d1cjXVLkqwo=;
 b=mOYBciRRvB45ek4TItHQCe/YBIepcILmA3wxL9vj3+Z61v6Hs6T+qO5YkHMNyhD1Gm4zCDhbBNMrBF7xMlW0szCnh72hkvgGz0dtH+fZCSt0bmmXa9KLT4lYtKCKImgs93wyFfhE2CE1z2afSyxJqH/h3edAFjzLAQvhS9TuS80h+WaQ76gDKmJWzINsiUhnLmGwyFOsdh7ozSb4Jv1T2i9XGyYcXLPd+z4C9HLXct14/rlj6IW63Z/QpzN0hof21hGpu9L8BQr/z+60Zt2SyLJDwK2AaeMQ1qdBRwtgULrsjuiRgQIhzbljrHgjs7k1EcXLMorBpYmflcG7dqQ3cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuNykrFYb2FsgVwd0qHOdwA5QtDi9ct8d1cjXVLkqwo=;
 b=0A83LPPVHEG3grbkAxq7FIgTQop/Xgh5H/kxsp4mPpMwT+QMdQg727D/VIa91Vdbbcg5GeC5UQL2jIi9z9cb85IUUXappy+aVkf1wsK8Z3D/ZHIPPovaBAizJs4NIJWBzspiVUoGRofCF09HQMRVUowBnEuXpvCozn5M01XPHcI=
Authentication-Results: damenly.su; dkim=none (message not signed)
 header.d=none;damenly.su; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4094.namprd10.prod.outlook.com (2603:10b6:208:11e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Fri, 20 Aug
 2021 11:33:06 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Fri, 20 Aug 2021
 11:33:06 +0000
Subject: Re: [PATCH v3 0/4] btrf_show_devname related fixes
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, l@damenly.su
References: <cover.1629458519.git.anand.jain@oracle.com>
Message-ID: <7171ca39-8f57-4646-face-70d3d23fbf02@oracle.com>
Date:   Fri, 20 Aug 2021 19:32:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <cover.1629458519.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0160.apcprd06.prod.outlook.com
 (2603:1096:1:1e::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0160.apcprd06.prod.outlook.com (2603:1096:1:1e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 11:33:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4803cefe-8a1a-4df7-6399-08d963ce475d
X-MS-TrafficTypeDiagnostic: MN2PR10MB4094:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4094879745B6C07490D67D4EE5C19@MN2PR10MB4094.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 36u2lVlExmgcATV3vssQfZFpVIbiFX2pTelfFJ7aXxAulzLpJzeS9tvq1V7lQOhPBYf+hich3AXf9O4uZDLkjMMJmKgI0MbFTZP2XMF2zfHXN6MkJ7f2NuplS/V79bBgtim4SMgu6OMS3b+7HTpTqBEhN5+aQBaEk/nuFzbskgnoLRIsTXRoVVQHaFCgMJcdAvHD3TTCD3P3VbYm8Monx/sndkfOiVWp5L9ivGvR2/5ND8/+3Sqj84CUoBYYDB+7TTBq8Y6ZrBTmUGpCZW7IXvYrt+ZsjzkEwMeU3vqJB4IyyYHsOSmlWTIy+oYL+y5v79kFaqkekBufeRBxADu3HbjH7n596GaRURcLsGg4IHoQBBANnW2FXVR23VS73rTtV1tbj7qApUUMjcSzFpDi2zWsPlgsv8BeBIf32k0OrBO4NhR9ZyhPQooT1BU15qMp5pdqx/QyT+BK+uZlfs9NjFZeI3xJ3476RgQ0vfAUmCcfScqnZxdAPMpqAd2+9Oeajb4N0cB5drufNSSuENsKie1fLmLEVvIdqKhPEaM3GHusJC55iEZxBAEZtljcAPD0e/MbUcHsbs7zRGIEXcWSdv0L5KmEyQ4v22/xStmCqyZQjoBcHixNlqABPsF/qXCRL19UhbhRiUrm1T2gJ1AQVQRWKNUfRMdBxFWgkj5Tndi0UW/Oh8b/a7L2zqoH1FihBO/PVeVHDGmDhG9VKnzpRQuVJxNT4slez/MjX/USGl0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(66556008)(31686004)(36756003)(86362001)(31696002)(6666004)(53546011)(26005)(186003)(66946007)(956004)(44832011)(8676002)(8936002)(5660300002)(83380400001)(6916009)(2616005)(498600001)(16576012)(38100700002)(4326008)(4744005)(6486002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU9yWjJYcU9MNUl6Q3RDcEI3ZWJZYkMwakdEMW5EaDBaUitEckEwZTludHFS?=
 =?utf-8?B?K2ZLLzJUUkZwb2RuSis0VUIyZlhMQzVYeTk3dTQvVHJGL0ZncDNNZExOaDc0?=
 =?utf-8?B?N0NEN0cvaWw2c0htVWtkbFBOc0d4SHpGcml3MHBIU3h4SHdIajNYUE9ZWVZa?=
 =?utf-8?B?eXBHUlpSbVF6K2h6cExjcm1uclZ2dDA0b0w5YXBWeXVsREdmem9lS2g5U3Jl?=
 =?utf-8?B?WjdPWmlxdUNFai9HYWE3N3NNNGdiWFN4bE82ekRpM2pWcXRDYk1sb2hJdEpz?=
 =?utf-8?B?cG9BbWM0SmNUMm1CT1lzdHZ0ODRDTDJSajhxeGgwNWFWR0FtTVNjM0V6RGFU?=
 =?utf-8?B?U0Uza0lkRUlyU1VoMGxSakszTyt6Rm1qT2JWcFFMbmlwMXZjanF6UVM0Ri9M?=
 =?utf-8?B?YlByaFRobDRESDJCbmZKNERQZXBkUGxwUnFtTjhNaDRSL2Y2Q0RVVlhFeDh0?=
 =?utf-8?B?bkxuaHM4dTZpbkN5UGRaaUZPbHJSenNPRzV6NFdZcnFRZXh2Y1AxMSsxOFdy?=
 =?utf-8?B?MWVVRGFSdzY2WG4wUlVFVmE2THkwMWpCR3BsbzVyVENuZS95dUhDeG1STE1w?=
 =?utf-8?B?cCtCVDJlNEowVWR1S29NN2xzeWxMckxHdmFMN0lwMUcrakQxeS9hY2ZNTjhJ?=
 =?utf-8?B?dndIK1JLemtJOHhGVjRNekQ0bHR0anZ6VWlSdFZMUWwwejhGR2RqNGU5RXdu?=
 =?utf-8?B?YzRPL1lCYzR2ZVhjYjFpelFKTDNHaDYzR2ZwY29QNWlBNHY2cWJqM2pXS3V6?=
 =?utf-8?B?VmdSL3ZoUFlKczYyZUlMbFM1SW4wWlpTU1J6UjBYL1ZzTnZoRllBWjJNSmpW?=
 =?utf-8?B?bHlFQUNCcFhmSmJPSzI0bjQ4dldaTlI1Z3JPZXdMclVGMDcxa3NzOG1OcFhS?=
 =?utf-8?B?TXJNWXlxRndIRFVBV1FUYS9RZzBIVjRRdjlJY25ZRFZnM2xFWHBNL1pycGV3?=
 =?utf-8?B?dlM5L2d6M29zYU9uaWsvejh1azJzL2FpS3JxWWRwNWh2dGJaZ25mc3FPM05n?=
 =?utf-8?B?SGdkT3N4bkp4cXg5WXZFZUlyR1AvWVo3RUlBQTBWY0RWUGlubi82Ny9sOGNG?=
 =?utf-8?B?NlhOUEhPaTVJYVpuZDdKSGtIM3RmZGx0bHBFSm1ETFh2aFRhTW9UU0J1cTVT?=
 =?utf-8?B?UlArWS9raUFVZkFFQXV2UGw5R0JveTZtN1FCK2J1K0R5M2lMcDdGYXFucEtN?=
 =?utf-8?B?alZwa1hPL0lWUElseVdzcUVUS0Y1Q0U0Z1Y1dzRsWkx3RnNESnJ2UmpzU25H?=
 =?utf-8?B?cnlSVDFJc2J0eTdUaC9zZTRIWnUwakdoMDRzT1djN1NIZC9MbTNJdXZtbVNV?=
 =?utf-8?B?dllrOHBnVzVORTRwYVY5U1B6eEJHZEU0OWhiSzRKb3Z4ODdDRGVpS2NReTgw?=
 =?utf-8?B?OTNCMlE3aEo2NEJsb0FjRlltTWROOGVJVXQ5eU5Bbk5RUGJ4aS9ldnE5UFpp?=
 =?utf-8?B?Ynd5VWYxa3A1TVZJL05UQ3dyUDI4OEN2aXJJQ2NXbkRCbDBiU1hrSjMxOE03?=
 =?utf-8?B?ZEZQVHBHTUJHcThqWUx1SzlqSVhzc21nM0JwSDdXUGJySFk0V1REU3Uyc1Zm?=
 =?utf-8?B?YnNXMGlUTkVLak1LdlVST2s4VGY1cE1HRXJxbE9CdC9QUHE2aXptdzRadmhZ?=
 =?utf-8?B?Q1RrQXBwVmZ0bTZqQmZwcDU1TWEvU2kzTEQxL1M5bEc0QU5OM1l3cWFGeFF3?=
 =?utf-8?B?TXVTRkR3V1Z2WGl1K3RGemVIY2l4aDdYRHcrbDJucmE3Mnp1SHhUajJVOWMw?=
 =?utf-8?Q?u8kcRyiWonT7Tt7alRofvFXXLERn0/ZAuDhMvIQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4803cefe-8a1a-4df7-6399-08d963ce475d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 11:33:06.2317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVBT03uWhDXTAT+tPeXiKLRaJ+NGvrd4MvVU648GDIhJZFw5bPaPPE2zCuFDuXNGBIS1f+Mh+NV0lRmp43EZtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4094
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108200061
X-Proofpoint-ORIG-GUID: 4Nl-2J8uLw6ZEBNZbDjpdzBApKkWDqrR
X-Proofpoint-GUID: 4Nl-2J8uLw6ZEBNZbDjpdzBApKkWDqrR
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Please consider patches 1/4 and 3/4 as RFC.
The reason for the RFC is in the individual patches.

Thanks.

On 20/08/2021 19:28, Anand Jain wrote:
> These fixes are inspired by the bug report and its discussions in the
> mailing list subject
>   btrfs: traverse seed devices if fs_devices::devices is empty in show_devname
> 
> v3:
>   Fix rcu_lock in the patch 3/4
> 
> Anand Jain (4):
>    btrfs: consolidate device_list_mutex in prepare_sprout to its parent
>    btrfs: save latest btrfs_device instead of its block_device in
>      fs_devices
>    btrfs: use latest_dev in btrfs_show_devname
>    btrfs: update latest_dev when we sprout
> 
>   fs/btrfs/disk-io.c   |  6 +++---
>   fs/btrfs/extent_io.c |  2 +-
>   fs/btrfs/inode.c     |  2 +-
>   fs/btrfs/procfs.c    |  6 +++---
>   fs/btrfs/super.c     | 26 ++++----------------------
>   fs/btrfs/volumes.c   | 19 +++++++++++--------
>   fs/btrfs/volumes.h   |  2 +-
>   7 files changed, 24 insertions(+), 39 deletions(-)
> 

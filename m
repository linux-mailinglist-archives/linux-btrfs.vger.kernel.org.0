Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2214913E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 03:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244121AbiARCC0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 21:02:26 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58368 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236398AbiARCCZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 21:02:25 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20HHn1mW028920;
        Tue, 18 Jan 2022 02:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GEcRZuZmTrTiujq8FBbLgK8UN177EoEu7OHQ/FcSdaw=;
 b=KLfsH6KeQJFOlBLTVFZz0j9kCJFNCuf5DWmsQ/WcL4Hj7tCbayhiCD3W/sUo9DG/yBnv
 KvyxlBi4AjLuX5n+1s6oQpqtBIvmxV+rVfN/67xhBiTG5dcbNfUTMUchlAqhv6v6Cg1w
 7ecpRg9lxzMPZwhyQNPbRKK/abweU3pxTwFXB/lUar/Y8SKE4So1HdwpzSmCtRxxuLRD
 p8eklpZiUzFMfsBG5n+CDIjE0Y73Hl2OIjLGZdr6Mom2yiIdDA9c8IFF3kwJoU7Pteux
 kG8QE5AjB3d5nPcO6Xcg/VCVFRwFhSFnr9VOetJcGo0+YXjdNbtOOmly/Xh7XHFgUqxd NQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc52rn6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 02:02:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20I1uLBr143181;
        Tue, 18 Jan 2022 02:02:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3020.oracle.com with ESMTP id 3dkp33gt00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 02:02:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y67Gq8sAqEIqGnbXElqbYffaHE14PrfnccfoBmS7PlVh1n+rAemARqYMTrwHTsdtHdYNRg8KzgXOv8z6KahMWPxE8qPCjvReMr9GCMo8m2uxNkflHBuq8f8/kwVIta/u3eAjxYfpy+oESRyxYItviZ2LYf/74Cf6UYQXQiZf9B1aSws3NTE3dMzSuSjBffT7du0I6/QiX0Rb9xmAFxv0pMv+YpYIK1NM/xfwHIxd3Ny2oX8MeM39L3KHDViBxPGa9NDE8MrORc3Dj4ZxefUn1UR5qCgieWz9yG2k/GYGeNzNW03zJpVRNwG8prQ/AvI4CbIb686Gx/8+ayp+LFPUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEcRZuZmTrTiujq8FBbLgK8UN177EoEu7OHQ/FcSdaw=;
 b=KRbFejBpioRj37kyoLXc9x8HHzO5/f6TH1Zj8/cZR6GCZS5oKAEEVvm8j0pxRD6RH+GN+VAkQwPavqRdLX+viku42e223Etf/VxCEMU5k2M2X7Oj/DdG/oY/S1cQHZtBbQwDjrKcST08IJswqIQdQz/Hj0tsbCfMJY2gIOIev0TL1oPGEJDSx8HNR30PJSrA6wWC8A1m6nWzxMGUopUPyCEYNd4xL7VGYyVl7XIbfYoOGQSju148DCU89b4Pj4Unc5UxLCqsdx+XsRzSifqPn0/9zwixsoN93bQnWHWYfPOHPtjSULb1Dkr4c+AF+EaNyKGBx8TyzWHd8cZLs/V0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEcRZuZmTrTiujq8FBbLgK8UN177EoEu7OHQ/FcSdaw=;
 b=muiAzKd/pLTSdVbOkWAJh9BsDbU8+rfrv+bHP/jaifW8t0ooUxGzjSj+N8stPsN/sy7g3+Vd9PsFMmjy8VQ2ZNV4kKPWiwft/mkDf/KzuuVGwREfUgkN4C346SjbTILGyt6YUcPIAbhPeB7vTsz32k3dsAGKMraamgfOfsWNuvE=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MWHPR10MB1437.namprd10.prod.outlook.com (2603:10b6:300:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 02:02:09 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%7]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 02:02:09 +0000
Message-ID: <715e9ffb-1ade-1a67-0b23-7522c587bcfa@oracle.com>
Date:   Tue, 18 Jan 2022 10:02:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 0/4] btrfs: match device by dev_t
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.com
Cc:     josef@toxicpanda.com, nborisov@suse.com, l@damenly.su,
        kreijack@libero.it, linux-btrfs@vger.kernel.org
References: <cover.1641963296.git.anand.jain@oracle.com>
In-Reply-To: <cover.1641963296.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0138.apcprd06.prod.outlook.com
 (2603:1096:1:1f::16) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d4fa82d-abb4-43d2-e20b-08d9da2688e0
X-MS-TrafficTypeDiagnostic: MWHPR10MB1437:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1437DE54C16DAAF65742D80FE5589@MWHPR10MB1437.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pgkr+ulgg3JOr4D2aaNWzqIIvnffFvKZMmx63Gg5I9uni9kAwglS9otMvWeUbTLoxybJBPCmbUF8eihHihWYAI1g9gsT5iYLQPc0wKvxZ2DmGwkuKGg0Ji7qFuZ1ItciYpvRHborLMhcVSyhHhmoljaMAP9Ymt0WstGXMJjzxgcsWu11vTMUnlSubP9e62aDa1ePxVD/aW86lOA4N5RYoOBYXmHMJpsonQSJtTIV8nwRzM0gpHefZ2KDzYZzeREsDSJZ9larGM8mls9jdVQaSgtbSTGcQsfkKIBNFKIChIForGA09dWJF81b5iU6KPvblePCvEFUPA+65Y5Qkoy3DdIWmpSkAn2n0PedYDpMGdP1ff92+rRCjcwyQEDl0qcFpppJW0ti5hVgnQuQ5dyX+kT9kdXZY3Pu9l49PY3sfepooYx1sY78Ck5XcnrL6qZjd5+ii1Oq0evw7XwtYf/2CevgUYu6TLg8hyLXm4kwnSSrw6oG+m7nErFHlvodnHIQBWV0cSir/5FwamOYxvo5seo8Fp8WZv+hdDsentssNF1yxOpxqeHCuysOXfHlZYYsv250HFtxsCfk8TwwNGZinqC5gVmejinTPMB+N5eZanbqBnNQ8KlEjGRdhBwe91Ozm/TqGARkvcVG/eFCi0j3mt4wihNDCZOGrkNC50OWqaQbPd0VcdY+bYE/caxHTkHYZX2ecMdT6Jxn56wxHq6iozxePt0s4PGlvz5/kN5hOcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(6486002)(6512007)(86362001)(31696002)(5660300002)(2906002)(508600001)(44832011)(186003)(66556008)(6916009)(26005)(36756003)(6506007)(8936002)(8676002)(53546011)(83380400001)(66476007)(38100700002)(2616005)(4326008)(316002)(31686004)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0Rranl0YmIwOVJEWjNIaVFFQzQzUUZld1AxY0NJRnJaYTVwQ2JyU1h2d2wy?=
 =?utf-8?B?U1NJdTNMQUltdXkvQ2lxZ0pySTcvbFkxTy9IY1hWS1RSQlZVbkdiYmIyaE9R?=
 =?utf-8?B?c1dGT3B1MFFCMEZKTVVRWFB5NzVsazlJNEFJekhqUXZPNS93ekpYVzBBbXpS?=
 =?utf-8?B?akdpamRBK3JDN3RjWjhicFNhbmNzREMwRmxCOHRsV3lFNEZiRm93OG1nYUJk?=
 =?utf-8?B?bWpiQU95cEVTVWhQOEFRYmxLM1AzbmxhUmJhMzRlRmZrK2NIN0E2amptRVN6?=
 =?utf-8?B?UFZ6UlJ0YjNXajdQMDdGZDhzbUV0ZjhpcEU1N1Y3Qk5XdXhtYld0Ym1KZkR0?=
 =?utf-8?B?Y3QvdjNWWlc0QU1IdGg0cFVNYVNGem5lUTNsS3p5WUx5bWVvaDQyZHZGb3pH?=
 =?utf-8?B?TkYrWEphRm02WTRpNUN2SXVFd1RlU0lQdlBJWnhFdzEvTndJU3I3SENGNUNz?=
 =?utf-8?B?SDQzOXhhaGFiM3Nla1VlcjJnL2diQU9yY2tGbU9USnI4Um1mdzdYMEJkTTNK?=
 =?utf-8?B?VVJrckFSb2xmOVkrRG41Slp4UXNEaFFoeUhlOVExcnJoWWpTVTUwVXAyYjd6?=
 =?utf-8?B?VE51TmJ1SFduZFdsZTFpQzJzdjY5VFNiV01uTWhqVVZuZU52VjB1ZVlkNFll?=
 =?utf-8?B?Q0lxVVJtYTcxOTE3dDRGa2REZFhFcHpyanZLSTFKZ01JYklWOFdaeDRIZ1Ju?=
 =?utf-8?B?ZDUxYlZSd0VCb2lKSVhCQjczNWJSN0xLNi82cnorZHB0NElxUGoybGVPV0ps?=
 =?utf-8?B?TG9EZDdCa0ZVbTFLZnkzOVdySGc5dXdUQ2FvN1J3VVRXZlRrNmlJY2FqR2RP?=
 =?utf-8?B?T2F0cXV6ZUFsdkdJVTVwNXJuQ25uV2hFVHBTc3dzc2lobjh5MDRnZHdqclJo?=
 =?utf-8?B?UEk2OWlJZXVQOTZKVkNSdEtrK0NjZldBUE9xYVFWZXZNbThXd0x5UXJrUHdq?=
 =?utf-8?B?MDlTVWFUbU96dThMdzNoWVR6Um1VNWorbkVEZkNDcjNlUjZ2UXNHZlZSdDhx?=
 =?utf-8?B?QVJPRVdwWmFEdjhJSXpEV0V3NDgxTkpZUk8rdDNxRGl1bisxWmRWRmlaYlFZ?=
 =?utf-8?B?ZEUyMGQrcmpqVVdGSVYrakl1TXhIeEpnZjA5aDhJM2h1a1poeVIxcEdKdnRJ?=
 =?utf-8?B?SzNSaXMzNW1tbVJKdlY4UEs1NVE5a2FGYWNvdlVjV0JybFJMdHRyMWF1Um5a?=
 =?utf-8?B?TmJlYllYb21iOWd2Z2NIUVhkNHJGUFkybURzWUltNmN2NXFVYkpiVnZqNTY2?=
 =?utf-8?B?WWRidWswb3dGZTcydjVOM1RFVHVodzJZbis3Sy9aZ29iTUk1eGNld1ZnQTFi?=
 =?utf-8?B?SnNnS3VWbStRZGlLcENaVm1maVVYbE83TStxTFdoZm9NaHV4RXNKQ214MmFo?=
 =?utf-8?B?b05ZWFhtd3N2Nnk0aWNKKzdUdXpNRG1qa2pyNnNKYU5Cb3g5ZUs5NFIvcTFL?=
 =?utf-8?B?aWFJemVSWVhCNEpwWHpNVTJzM0pabHl4ejFSRkxFT2hiOHNnNmhlTHNzd3I2?=
 =?utf-8?B?SDBpV0ZHV01saUdpRWFESWduL2tIUktHSm9jTTg3S1BnOFQreW1LZjV3cTJU?=
 =?utf-8?B?QXVVWUcxVGs3RStZMWZVSEc3Z2RsWEFIanFSdlYyV2ZmT0h4TWd4WW5RTnlv?=
 =?utf-8?B?VGw1NlVWZS9Qc0gxWmwwT2JyNUxwd0FRODBXRVhxQjhHbHlxZTlOcDd4S2hX?=
 =?utf-8?B?aTdxYllqR01YdEx3SlFCdllvWHdZRHNlODIxMlV6Q2oraE51TTMyWm1zNEFI?=
 =?utf-8?B?TkdDaFkwZWZ2bWpCZDVyV2YyQnZoQTNQckZjdzBCajRJWC95V2dJWHc1K3ND?=
 =?utf-8?B?NmRmbEFyampjUlRicFVpNTZWTk8xVjFuWis2K1pGZDVDSWhVMVNwWVpGcDFC?=
 =?utf-8?B?dWVYcU5NeUVXN1lTZERXeFp4K2p6RUg2aGZUNUhOY1ExUU1xQUM2ZURQMjNF?=
 =?utf-8?B?MHRzV09SS1BWajlWNCtXMmFpYXhPUkRmeW0wY2FheVVGd0pQN0daSlJjN0Ix?=
 =?utf-8?B?b0puWTQ4RllwSDh6SisxMW84WFVkeTg5a0QwSW9waWhnNUFjMWlCZEZRZzBE?=
 =?utf-8?B?SFBzdUFSMGxJdXZJbm9rR05ucFJNS3o5Z3luTVpyRUhUNDlOYkFKS0FKM2sz?=
 =?utf-8?B?K3pQZFQvbitaWkRiL2tlR1Z3NGNLZ3lOc1pWRmFaZ2Z3eEJGR00zZVplbDZn?=
 =?utf-8?Q?jh0Od7npfG2kiaOf4IYMDvA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4fa82d-abb4-43d2-e20b-08d9da2688e0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 02:02:09.3593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEBZX8c5y3J1ZfPsY8qYPcpfGmQah3CuPMwK5rQKYO3IBrMno3ATWTasnddTZyB17yHbbK5GbdajjGMFkzR+7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1437
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10230 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180010
X-Proofpoint-GUID: 9PwDG9eyODPGgVP7pPvMBYhzHaZ1SfN1
X-Proofpoint-ORIG-GUID: 9PwDG9eyODPGgVP7pPvMBYhzHaZ1SfN1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


David, Gentle ping about this patch set.
Thanks, Anand


On 12/01/2022 13:05, Anand Jain wrote:
> v5: Patch 1/4 device_matched() to return bool; absorb errors in it to false.
>       Move if (!device->name) into device_matched().
>      Patch 2/4 fix the commit title and add a comment.
>      Patch 3/4 add more comment about btrfs_device::devt.
>      
> v4: Return 1 for device matched in device_matched()
>      Use scnprintf() instead of sprintf() in device_matched()
>      Change log updated drop commit id
>      Use str[0] instead of strlen()
>      Change logic from !lookup_bdev() to lookup_bdev == 0
> 
> v3: Added patch 3/4 saves and uses dev_t in btrfs_device and
>      thus patch 4/4 removes the function device_matched().
>      fstests btrfs passed with no new regressions.
> 
> v2: Fix
>       sparse: warning: incorrect type in argument 1 (different address spaces)
>       For using device->name->str
> 
>      Fix Josef suggestion to pass dev_t instead of device-path in the
>       patch 2/2.
> 
> --- original cover letter -----
> Patch 1 is the actual bug fix and should go to stable 5.4 as well.
> On 5.4 patch1 conflicts (outside of the changes in the patch),
> so not yet marked for the stable.
> 
> Patch 2 simplifies calling lookup_bdev() in the device_matched()
> by moving the same to the parent function two levels up.
> 
> Patch 2 is not merged with 1 because to keep the patch 1 changes local
> to a function so that it can be easily backported to 5.4 and 5.10.
> 
> We should save the dev_t in struct btrfs_device with that may be
> we could clean up a few more things, including fixing the below sparse
> warning.
> 
>    sparse: sparse: incorrect type in argument 1 (different address spaces)
> 
> For using without rcu:
> 
>    error = lookup_bdev(device->name->str, &dev_old);
> 
> 
> Anand Jain (4):
>    btrfs: harden identification of the stale device
>    btrfs: redeclare btrfs_free_stale_devices arg1 to dev_t
>    btrfs: add device major-minor info in the struct btrfs_device
>    btrfs: use dev_t to match device in device_matched
> 
>   fs/btrfs/dev-replace.c |  3 ++
>   fs/btrfs/super.c       |  8 ++++-
>   fs/btrfs/volumes.c     | 67 +++++++++++++++++-------------------------
>   fs/btrfs/volumes.h     |  7 ++++-
>   4 files changed, 43 insertions(+), 42 deletions(-)
> 

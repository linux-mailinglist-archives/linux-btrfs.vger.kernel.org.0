Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE399391119
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 08:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbhEZG7j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 02:59:39 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47844 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhEZG7i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 02:59:38 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14Q6dEma158505;
        Wed, 26 May 2021 06:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=FvgZc8IXi2fzT7A0u4bxqvnbPoWWHPyfp5jf7jhIUxk=;
 b=Z/boqxZZtdtPrszDLACG0JA6IpIwy0Inssuyne+O++iH7UY2p6VpAXjrPzUSa2gO9uqB
 d5osT0Azmz9LB90OLOTwTcb0P3zY+OXKCy1N6JFlf5RCQ0xyq5jgCjxLoQmVfJBZiXfH
 0qGEQEq5rWz/bAPuMAS/6m1lJfnmY8ZtWURj4LRNu7Pgy9LhHacozOCt8bNk9/rncDZc
 s5zXIKdhBzXGP1Ors+MfEGpvrLu6s8GPqFg77kabcCs4Sijz04HtvSYRmhNxujsbaxXp
 MzCYLdshovNz4zAMxT2XdTlzlWkDxRpgGIdYVaQQ3tofdHke3hAUm1qt1wwIjk7d0Hts mw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 38pqfcg305-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 06:58:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14Q6f1Ca169028;
        Wed, 26 May 2021 06:58:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3020.oracle.com with ESMTP id 38rehc3utg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 06:58:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hv2l8RoAVNeuml9mMaMMcq3qLkwAEvaq5lMKnJ6GcPXgmHPrSjgK3iqyPI7ETWtVw1aQaqZgZOQXaIFq8p/ZfqGAsjl/DCWfff0pWFkyDkQIOFVmYFAwXmfP2yZt84Oh4cTJ3LD95KSWXgJg5aL1y/PPhem573Qlevq7cql9PPkWSbddeI69+RFGkYkdkT0dlvVICWAvGQkDKpfRdECGEp/0PuYCucgDoHXBkIDDUSdQI9drGw7Zdf0PTl+mjQg0/YmUBGXpM/CNai6twRaNRInC0PWEsb7R147EZ0/+uhMzsAqVztqS+49max+XNCS8nP6UY/S3VVXOEoe98SNdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvgZc8IXi2fzT7A0u4bxqvnbPoWWHPyfp5jf7jhIUxk=;
 b=iXnV5yRu12slgkDXAarzBxuhjSuI/clCrQp/4EAtBcWUSlnsX2Q+xQ5TLoxiYh+Wug4w2xVQArlSrSpNk4lL1jaJEBpeoilcBa11Z1LQwrDErAJjXiJ5v6qkvMLta+VgaqP+tgAWxTYhqmePc+fz5yU34jd1+SdADBimjFMLZQ+3ShUfPYs2PVE8lmwOlij/w/KuONYMDaac41Si96oUFxP1F6rx5zr8Q9soeOLqT/TehKgIgm3NEPl5wwFBn3PWmwNi5Igxzvorn+UangOpPfeCYHidgctnOzNUdQTmbLIZ6D6dGuMx13yMXwGLt1PK8C405GeBunFuG2y4X78BVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvgZc8IXi2fzT7A0u4bxqvnbPoWWHPyfp5jf7jhIUxk=;
 b=xri+AIX9EPr30MtMtt4bs1ClotGM1DwlI664r0YVPWKGI4BOHaNmdg8aToBLXfHsRhVSPiRUvmnxK7Yb6+fIOOgS1zH/1ZBNUCFiRmSbFU6HN4Fh9iwcJ5v1/RZMCzCk5eLT2QubNI90yCOwY8w3sXtMaG10Jr/dTM6yim1qzIw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2915.namprd10.prod.outlook.com (2603:10b6:208:74::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Wed, 26 May
 2021 06:57:59 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%8]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 06:57:59 +0000
Subject: Re: [PATCH 3/9] btrfs: clear log tree recovering status if starting
 transaction fails
To:     David Sterba <dsterba@suse.com>
References: <cover.1621961965.git.dsterba@suse.com>
 <2a572b691dd9f79de5649894dd24ea555913e1c7.1621961965.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <bb7b7439-99d7-67ab-a734-39e27586fbb7@oracle.com>
Date:   Wed, 26 May 2021 14:57:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <2a572b691dd9f79de5649894dd24ea555913e1c7.1621961965.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:c97e:3e12:797:83c8]
X-ClientProxiedBy: SG2PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:3:1::24) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:c97e:3e12:797:83c8] (2406:3003:2006:2288:c97e:3e12:797:83c8) by SG2PR0401CA0014.apcprd04.prod.outlook.com (2603:1096:3:1::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 06:57:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb26e361-bbf0-41ed-3e07-08d9201398f6
X-MS-TrafficTypeDiagnostic: BL0PR10MB2915:
X-Microsoft-Antispam-PRVS: <BL0PR10MB29151FAF3AB08F9226D4CEF4E5249@BL0PR10MB2915.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NEclqaYa++oXD1ZlT6BkOrxTpq35c2bORR7I0cR83O3M7fM4cSlHuzvsXrTx/epCeK5FAukrnpBXb43SluPL5LtwK6XAdGVGl5ZbBZrFZ6G1ylJD/aI6cDSQCwQYAVk5/f2xDeBDw79ljK0YjLIrHjLy+C9lbl5rw2Rj1fipGTZYYL9O9W3BY9RsONayWq9dCY4OPGZRlvnTI1tYfjqvZzpFrGvneCaWlwFc+v1e9gtiAU9GsL1A4XHj0pP5Am/xFKJBa3aguXsGeirOH52b6aza/sgkWKOyOlvic7aQeXY/uuOA6fHf8QkESw0R04gI4tTKFoZymjsTuitjYtcdWpPGM1LgmcgJ+p4E08KqWdpobYfsE7jptaC+HjjX2AqMvE4cC8sOt7X0Y+7ixsZfi+bCG62sLYP6SXDyPKg7qBZPeTAguMDhEx3YiavbAcayvGvyPgXG3KUw67hB6iNs33GXFlBXrMfBlEiFwbz2ZyIFnmxKROVZFEdB/QQvnzLkKh4Pan1obBzt37VbpHDVclDJYsC7r/ET+BuzxQoXUDh4R73JR4Uv6y0IiB0TOhtCP+J86+vA0+PHqk8fzwTryGHPQvmZDJ/cPTVEBZIbRs+VxjreujwinvSY6fhPtcF7zPVFcD8SMpAyyKQnGv6JB3KlCeZPX9jK65vQIxd4F3Lri3Tkc2NyPbf+5wn0Q3Zi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(136003)(39860400002)(376002)(478600001)(83380400001)(6916009)(66476007)(5660300002)(6666004)(186003)(316002)(53546011)(38100700002)(2906002)(66556008)(31686004)(8936002)(66946007)(4326008)(8676002)(44832011)(6486002)(31696002)(86362001)(36756003)(2616005)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d2NtOVJnZWRGclhuMlk5TWZzR2R5Qmw1U1o1QTlDY2VxN3k4emNpelFHTmZ4?=
 =?utf-8?B?R29ZbWV1RGlHcElhR0VyOHROOW9CMzlSdndpV0o0ZC9TbEhoTjl0N1VsbSt2?=
 =?utf-8?B?aWdZNTZwK2hxVzIrb1V5bExWalplbS93OVV0WFZUZTF5ZndYb0FIUDhwMFlq?=
 =?utf-8?B?emxjOUlHUHk0WlUvOHUwZXBqVWwzRHI0dTN5TkJxQ2ExVHk0S29HclgzaFdV?=
 =?utf-8?B?dnVIWGFNdHlvcndWZEppVEZKdWpReU5MNFdpOWhYUGZFWjJLbTJlbDNSRWRm?=
 =?utf-8?B?Uzg4amRpTk9BRVFjc2ZjTHkvcHc0M1BsZHU5cHFVamozdGx4RS9tYzVsZ0RY?=
 =?utf-8?B?eXM0WFFsb3BiaXpjcWl2WXFWbVVGbGlLRVRld21aeHNiTkNTNlp6U1ZWM0lH?=
 =?utf-8?B?VmRJMXJNY1hGV2pYMGVFcXBBdWVrMXJPWXhNSG4vblJuVU5UZVlKQmxlQVRP?=
 =?utf-8?B?d1lsa1F6REpES25MOTkyanlvbHpqNzAxcTY5WGE2TDIvZHh2NjhOeHdQMW5U?=
 =?utf-8?B?b3F2ZE16U2dhVnpCRkRBWEN0SnZKcXN6ZC85MzZRdVdPcklKdkEybFpYVnIx?=
 =?utf-8?B?OEQ2ZVpzUXFVaG5NTmg3Q2NJblhRZHo2VXpzWXMxMHV4NVFGbGllRlNtS1Ew?=
 =?utf-8?B?alRPUW1FazZJbVFKU1BvdzdGRDNsNHR1NDNpRFU5ZUYxL0N0RGFJUm16WFZU?=
 =?utf-8?B?U2NiYkVNK1plZm1SdWZaL3NOc2xkdFhGeWk1b1RVN1dVT0JSMWZUYWJ1WldS?=
 =?utf-8?B?L2F0Wm43NmwrbDY5Uzh4YU9TZnltVjRROEx3blpNQVRnSWdtUnVpaHBGVlpr?=
 =?utf-8?B?UUJ1TThQbnBwOTh2UGlXMTk5VERGY3h2RWFNK1ltaEhJZHU2MG5VRnBFeDNY?=
 =?utf-8?B?bXR5K3EvbHQ4bGVTcmorajNKTlIrK09kVG9oVjRicks5SEd0a0h4WGsxNEZC?=
 =?utf-8?B?dTM4UnJvTE1QSVVFOW1nUElLbnU1R0dibHVGTk9qWGVRelczdk1EY3J6UlVZ?=
 =?utf-8?B?NHlTQ3VHaWhqdVFZa3ZxMTQvQlhiRk1rbUdPNC90UUhZRUQyamVmekhHbVQv?=
 =?utf-8?B?dVJNQkJuRitDY3RTMllObllTS1dyZERaQnBrYVFnNVh1cFFYT0FwU3VYcldV?=
 =?utf-8?B?V2VSUTNjUEtXNkxSSEhnaytYMmwwcTRHRHRoL1UvSm1PblRhRXRHOWNtMVEx?=
 =?utf-8?B?MjhtREJlSUpSRU9UaTRXcWtHckF3ZVZKZEsxNlh5anA2S1hLaE1WZExuUE5u?=
 =?utf-8?B?MWlkekVRYitjTDY5SkRLNWJaU2lJWXRZMjZhRUJuVzl5V2E3eHVSSndXRDcr?=
 =?utf-8?B?YWEveVY1VWRSbTc1WnI1bDRUaGVCTmI0R0EvSUlIQzh5eWhydmEzZG9LenU5?=
 =?utf-8?B?aEV3akhzVFNFQXpKbVI2QmVybHcyQUREVVlaZ0dBTE1QME8yMXVRUmNuRlIz?=
 =?utf-8?B?My95NE5qVDd4eldDNVNQY0VCTlV2WUFnRW1tZWp4cTVoOGRLQklPSENIS1pB?=
 =?utf-8?B?L1N3aVJMRUdTOW5oMXhCZWplNEJ3TzVwMFZ2TGZEdCtsZUJvSWQwbnZZZXhl?=
 =?utf-8?B?U2dLYXBOT2cyTzgzdk9LVXFWSTNPdytiVVUwVHlGQkRFenNiaEEyYTBJaDQr?=
 =?utf-8?B?SnNwRTZmNy9MYXRXMm9uck1GTndHeUt4bTRyM01BTThJUE5vc0t4bHdSWlpl?=
 =?utf-8?B?Z21hWlRnbTN4TUF5UHh6RVVjcXV2TXFIWVFSTDYxVFk3NUVNUEl1VFI3L3ZL?=
 =?utf-8?B?cDl1bFBxaHovSnVablZwaDFIcDZKL1NhU2ZCUzZKZitWa1NaY0E5b2JJS21p?=
 =?utf-8?B?WENyRzczYlQ4Tlh2Yk1KYWpsZkhETXBzck9ub3FkTU1vVlFpaWVldk0ycTI1?=
 =?utf-8?Q?VIdhxw0Eh9n3a?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb26e361-bbf0-41ed-3e07-08d9201398f6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 06:57:59.6888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slylocf4JH03Q8j/xscDPKt8ijw2BUx5mhYJplnDdR8MauuSEDtVacArmyfm7bZgSkkDq3SzO205CgcBMAKUow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2915
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260044
X-Proofpoint-ORIG-GUID: mJ1NmkOywo7GFaOm4OEotnP5cweCNvG-
X-Proofpoint-GUID: mJ1NmkOywo7GFaOm4OEotnP5cweCNvG-
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260044
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/05/2021 01:08, David Sterba wrote:
> When a log recovery is in progress, lots of operations have to take that
> into account, so we keep this status per tree during the operation. Long
> time ago error handling revamp patch 79787eaab461 ("btrfs: replace many
> BUG_ONs with proper error handling") removed clearing of the status in
> an error branch. Add it back as was intended in e02119d5a7b4 ("Btrfs:
> Add a write ahead tree log to optimize synchronous operations").
> 
> There are probably no visible effects, log replay is done only during
> mount and if it fails all structures are cleared so the stale status
> won't be kept.
> 
> Fixes: 79787eaab461 ("btrfs: replace many BUG_ONs with proper error handling")
> Signed-off-by: David Sterba <dsterba@suse.com>

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.

> ---
>   fs/btrfs/tree-log.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index c6d4aeede159..5c1d58706fa9 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -6372,6 +6372,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
>   error:
>   	if (wc.trans)
>   		btrfs_end_transaction(wc.trans);
> +	clear_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags);
>   	btrfs_free_path(path);
>   	return ret;
>   }
> 


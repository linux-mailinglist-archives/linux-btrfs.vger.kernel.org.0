Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFB776BB39
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 19:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjHARaE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 13:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjHARaD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 13:30:03 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A84F5
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 10:30:02 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371H6IZP026643;
        Tue, 1 Aug 2023 10:29:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=oAtjeFK+TdG/Itvkv44uG97Q0yV1MDaqF7/C0RW/3h4=;
 b=RIs1h9V/gIUdcQfkkM72OxgMVlcF5KJAXjGJ2EenRtg2aVjoVI8CBbnCr3/H5uO6ismD
 nLZR7Vs1b/IP78/8iUF+uLpysIUcUszCQoDeTElGkpxe5TT91P2uf+MzWKFVgOuGkb43
 fS4yBjLIkiTqlQdQIME9HnFUMaH6z7eRle1zZGwlbzZ168piKIXgK894zm0xz7CvSTGQ
 dVroGDqKQkXKdCQO9MVKhtUIHLQdZfikv3csVq20347G5rmgiLKRN1Wv+Epab1Kpvzxp
 NcCOqySAAAWynbvLfIL9rCPm0EORCTwoChSLbgs9+8ehf9yJ5LsMtAB7xO8molB6UNa3 KQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3s6se0p3kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 10:29:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LP3fXKdexLDV2sNTtSq20Ziyj0Va9bn/L4IP4GoMlvHbjg9PiNtELvat1TqjVz4oS8OCbdkyygqav81WgislC2KVbWpyOiXYyKQc42Y3LniqKBB/82kef47t+kB0LDsLAHLZksUJU6td3y/dkRLngJ7o1Sj1KDi5AV/Du3Ai5NuymrjzvI/hi9S+fegNTyE+VH6QFzSSSClYBhKd96dOJpIDjyn9vS/+ykQrZP8Cg4peXLCQHv/CDb3ih4W0wd5lj5JFyN89QKKtMpU2ZHIQQtMplsY36S//YWdKYCnv1znqIJIdP/uWUH8fQQHrWwPIi0vlvXrEM/PyNnYFTWDRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAtjeFK+TdG/Itvkv44uG97Q0yV1MDaqF7/C0RW/3h4=;
 b=c7dWaucv4K22c0uszUqNQQv7OpcHHg1FLi1QaDw613uRKcMqNJNZeopHVrMlV+TWvbXrWmh/8Czk22u5Ont7G9f0IFv5wJyfEIXl/ZbI6Pn6PAMBKREk6pl6N8Ge7G1StgOlozCrRbEvIrDyvQZ1AEvvcoPBCG5vqHwSmolt26/pwJMUVfVmTjtJIP/V4Nc9sfUx/yA1ete/geMb+tPMqHDpl+OQhplfbifZi72gPMro6sRULl0vd9pcBtfLt9HJb5Fm70UbNrM0S+myigHYTpoczP1xedIBywFfCxiNS9rh6smCUfvdQiBJITWWFxexG2gPivvcsjcbP+ln70nxMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by BLAPR15MB3873.namprd15.prod.outlook.com (2603:10b6:208:254::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 17:29:53 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::63a9:9663:f1f:fb80]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::63a9:9663:f1f:fb80%5]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 17:29:53 +0000
Message-ID: <1a01a6ad-5374-a9f6-ee69-df78cae87428@meta.com>
Date:   Tue, 1 Aug 2023 13:29:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] Btrfs: only subtract from len_to_oe_boundary when it
 is tracking an extent
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, josef@toxicpanda.com
References: <20230801162828.1396380-1-clm@fb.com>
 <20230801164242.GA13927@lst.de>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <20230801164242.GA13927@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:208:160::21) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|BLAPR15MB3873:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c4d88a-20fe-4d3e-d870-08db92b4eacc
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hhzwq+3RBcVveI3DtmnfcU4/oUdLHc4Z1qztFxxkg8n0us2cQ9yNb7ukOzEOiFfKPbU4/EzHefulSGGtBRFP7xQtz7/1bSj9U2PMxHvj1/LD0SB8GcAqFmu+4gfJg+PfsBbCGNbWSuNwHcYdXV06pFz9m7IoCTaFd/pmIa4JXTOa/OneTVsAT+O+apwQFpGroWjEcvO1KsBhRvJ3HUX9gdk8GFBZqLOU2a8lLlQBd692/DFKZU+fHxzgzYfN1SUcAg14DS9G9Cd1nB2eeYxf2hJJPkSoY1nWlCHTlScEi6K+eJmf7FKHw+S8NobMSi3ymGwM+7+QXftQVweqFQBQ6HNBG8cAIKyAGMLGjFb3IHSSfvNlszA+J3KdmbG0rQoGLsyeGBytbgCuwt/L7qygL6NPDfFuE/zf7m3ScF5yPRJOVaPtqI7sBlUxZQHRDyM06Td5dt9WqLk5SPYMaM0kgH4R0AC67CTjeGa/N+EC3ao6wDGCbuRc6l7jj8dwmNc020h1GzRhTu0LrOOhwmot9EB2G6mSoQg3kXiJ6fSoFHTPzz9PocQmx1blRKP+LCNvlKoSmJgClB5UMF6IsqkBHvd8e0oExQNXD0maE6Nv3pGBnh0Taq+aSuIbJbaR8a1RtVBSY6cQOVSDs8svMGB29A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199021)(31686004)(2616005)(5660300002)(36756003)(38100700002)(2906002)(83380400001)(478600001)(8676002)(186003)(6506007)(53546011)(8936002)(6512007)(6486002)(41300700001)(31696002)(86362001)(66946007)(110136005)(66556008)(66476007)(4326008)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OCtaWSt1WUZNdjBJRXk1ZkkvQVNldmQ3QktpRERLVWVCNDNHMUN3TUlOcVBY?=
 =?utf-8?B?NVF6TFoybCtPbHJoVXk1V1Y2aVBUaytFNWVrOE1sRWk5OTFRTC9SS0tZcVVT?=
 =?utf-8?B?ZHp5SzhIK0Z3VlpyWGFZUlBvSFBVVTREMGFraGU4M3oxd2h0WXlBZXEyZjdz?=
 =?utf-8?B?OWtjbllwaEpJWnlkVjBNaDI5NUdrc3Y5U051QWFlQlR3YitxaEU3am9aNTF6?=
 =?utf-8?B?eFdvVzNkNzAzWERGTnhLOEV2MUw1REMrb0s3TVJ3QVIyaWttaHN2SEIzS3hL?=
 =?utf-8?B?OGJQbWVVeDFla1B3U0ZNQjdIRkZhc04rOS9Ba3RTWEpoeUZXbjJ6MkM2WEtO?=
 =?utf-8?B?NFMrRGNYVG5vL0lpVno0dWZpQmtBZ3pIVk1tb3RvTFVRb2ttQ1p5d3doUWRk?=
 =?utf-8?B?eFFkdFJzNjF2by9lOFcrUFV2bVo3SlVTc0Z6bEtSRlBoOVFTWmR6bTAzN0cz?=
 =?utf-8?B?cUFUNEhDbUJtd0ZycTNEZWxhMXZwVEd2S044d2s2OU1BNmh3WlBOVkFoSHpr?=
 =?utf-8?B?VWNsVlpzVWF5YndqOXd6azVDalFXQ2pFWVlVc3VjcGdMTHd0Ry8yNFJ4dW9W?=
 =?utf-8?B?SjhNU3BYc3NVOUVNVHNXc0N5bm9FL3kyTnlhcFlIL1NxSHNmYjB3L2J4ZnNn?=
 =?utf-8?B?dk9BNHV5ZzVYWnY3dzdsM1RCdVIzcVl5dUc1K3Q4K0ZxR2pEYTA3ZEZJN3hT?=
 =?utf-8?B?cmxMOE54UTllRzFjdnlzc0dHc2NseVd1anRpek96SDFZbDV6R3BXZnRZd2xl?=
 =?utf-8?B?aTdSL25aaEtHWHoxRkMzYXFBK01PdjBtMk1LTHNvQ1UrVWRpUzVUczNlbHdB?=
 =?utf-8?B?ZFZLVEtuOTh4bUE5VXUvR0VrUmxnUkdsZHA2TmU3ZFN2TUgwUGhaSktqbjdK?=
 =?utf-8?B?Q0czOCtycFVuY2toeDl2cC85U1FCNmI5SWl1QnNjM1hlYk5BTmZzZFlGR3dX?=
 =?utf-8?B?R2luQ3IxMWNYcmswT0czRGtHMXcwSlhQVHpXNm5XSkVHb0tkMGtUN3NIaU8v?=
 =?utf-8?B?U015ZHFoQmFGWnpJeWdQbVpCcXpRa2VzWHgxZ2RmU29obUZKVUFRNzVRaTdE?=
 =?utf-8?B?YnF0TnRad1U2OVhWNEVYaExsdFBWd05Qb0V0NGoyMUFjeDVVQ1pnR1JYNUxB?=
 =?utf-8?B?SUhSRVI2ckxZYzdjZjY5akp0a1YyYUpsdHYzVmdhMEFpL1NaSlZOMThiNDZY?=
 =?utf-8?B?YnE0RVRHaDhDbEZrOE4vdUpqTVk4YlpCOThKams4QjV0OTUyNVI3OTNyUFNH?=
 =?utf-8?B?YXl4VXVJenRTYVFJMjZXWEo2ZjluZjBONGlWM1BOR0tRR1ViQTYvNnozSXNJ?=
 =?utf-8?B?c1RoRGR0YXExdlZXWmpCaXJYRmRCZ2YweUVmcUUvcVRVTWtXZ1lwTVpiWDEv?=
 =?utf-8?B?Z1lBYUJmSDFwRFJLa2hqS3phYlYybzIwQnN5K0VaVEZ0N0hvNEVWM3Z4Mm80?=
 =?utf-8?B?VThtdnBGREVuTlZJWDFjekpOSzJjVDVFZmZOSFd3Zno5WUVFdUFOUWNQL3pl?=
 =?utf-8?B?VmtRVzUzMDREeWxJQ0g1VlBRQzNPNEZNT1o1VWlHSVB0QS9KUjl6dkhzR0RM?=
 =?utf-8?B?TG5kc2pOMXVYc1FUQTZwcGVLZ2FIOGdLZ2w5Zmp2TDNhdGtjSlIxbitKS1A4?=
 =?utf-8?B?VjZLTnBDMEpSMGliUEp4WGRkcE4rVkJiVkRoL1hONWZCcm1nS3d3REd1NlpK?=
 =?utf-8?B?Z21IS1NUaXpyOGw3aU04ZFpKL3JOTC9yQ3d1R3czSDNySEN5aE5KRWxhMXJZ?=
 =?utf-8?B?cEhSeGtXZWhmRFZYbVR3VDNOc3IwOWpDK093Q09FSzk2VXV1L2ZxamczcDR6?=
 =?utf-8?B?S0dnQy9Gc0JmZkpBUlN3R1FML2hURkc5WW1WU0M0YmhDaWl2ZXpEQnlFUzJo?=
 =?utf-8?B?L2FSK0VzRjZMSUx1VCtRaC9pb3dUWE5Uc3NWbkZXWVVwa3NWU1FlL1RLZmFJ?=
 =?utf-8?B?aXcvVzRqOG9uVnpWK1l3NVpOMmlPaTlQU2NNS3dML1doQ2toSVl4SnZ1SVRs?=
 =?utf-8?B?ZmxURFdreGl5Uk02WDBUM0w3UHdKNTFVNlNJVE5hQVNxK0h1U3QyVWZjK3Jt?=
 =?utf-8?B?OFVjSXhQWno3dHdCdjI5dTFXNUpCWWxHV3I1R2RWbktJOWRISEdleEVlNVFa?=
 =?utf-8?B?dysyeGdFNFBvVWh2NjBRSk1tVFRneEtnNGFEalA0R3QwaEdwU245RTdvL3FO?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c4d88a-20fe-4d3e-d870-08db92b4eacc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 17:29:53.5664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RBnbUP9M+qD4CT41kFyyLhFhAX6uUp11UeYUNZWUrsQCYWPRtCq0j10A4XrPGop
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3873
X-Proofpoint-GUID: rtqng8IQEFPnUv9FhrZ9hNQ_HFy-yuzz
X-Proofpoint-ORIG-GUID: rtqng8IQEFPnUv9FhrZ9hNQ_HFy-yuzz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_15,2023-08-01_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/1/23 12:42 PM, Christoph Hellwig wrote:
> On Tue, Aug 01, 2023 at 09:28:28AM -0700, Chris Mason wrote:
>> +		 * When len_to_oe_boundary is U32_MAX, the cap above would
>> +		 * result in a 4095 byte IO for the last page riiiiight before
>> +		 * we hit the bio limit of UINT_MAX.  bio_add_page() has all
>> +		 * the checks required to make sure we don't overflow the bio,
>> +		 * and we should just ignore len_to_oe_boundary completely
>> +		 * unless we're using it to track an ordered extent.
>> +		 *
>> +		 * It's pretty hard to make a bio sized U32_MAX, but it can
>> +		 * happen when the page cache is able to feed us contiguous
>> +		 * pages for large extents.
>> +		 */
>> +		if (bio_ctrl->len_to_oe_boundary != U32_MAX)
> 
> So I don't know the btrfs extent allocator, but what is the maximum
> size of an extent?

The actual max extent size is limited to one chunk, which right now is
max 10G and then we round down for various reasons.  The disk format is
all u64s, so it really comes down to checks like this one in
find_lock_delalloc_range():

u64 max_bytes = fs_info ? fs_info->max_extent_size : BTRFS_MAX_EXTENT_SIZE;

(BTRFS_MAX_EXTENT_SIZE is 128MB)

In practice we're less aggressive than XFS about trying really hard to
layout big extents on disk, and the max size we'll find is what we
collect via delayed allocation.

So, taking the swapfile from my repro:

        item 5 key (257 INODE_REF 256) itemoff 15857 itemsize 18
                inode ref index 2 namelen 8 name: swapfile
        item 6 key (257 EXTENT_DATA 0) itemoff 15804 itemsize 53
                extent data disk byte 1104150528 nr 134217728
                extent data offset 0 nr 134217728 ram 134217728
                extent compression(none)
        item 7 key (257 EXTENT_DATA 134217728) itemoff 15751 itemsize 53
                extent data disk byte 1238368256 nr 134217728
                extent data offset 0 nr 134217728 ram 134217728
                extent compression(none)
        item 8 key (257 EXTENT_DATA 268435456) itemoff 15698 itemsize 53
                extent data disk byte 1372585984 nr 134217728
                extent data offset 0 nr 134217728 ram 134217728
                extent compression(none)
        item 9 key (257 EXTENT_DATA 402653184) itemoff 15645 itemsize 53
                extent data disk byte 1506803712 nr 134217728
                extent data offset 0 nr 134217728 ram 134217728
                extent compression(none)

But these are all contig on disk:

# filefrag -v /btrfs/swapvol/swapfile
Filesystem type is: 9123683e
File size of /btrfs/swapvol/swapfile is 8589934592 (2097152 blocks of
4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0.. 2097151:     269568..   2366719: 2097152:
last,eof
/btrfs/swapvol/swapfile: 1 extent found

> Could there be an U32_MAX sized extent that could
> be hitting this?

For writes, I didn't actually audit the way we're setting
len_to_oe_boundary vs U32_MAX.  BTRFS_MAX_EXTENT_SIZE should save us
from any single wild extents.

But especially for reads, we'll end up collapsing contiguous areas on
disk into a single bio even if they span extents.

> In other words, what about adding an explicit flag
> to bio_ctrl when to check the boundary, and just don't bother with
> len_to_oe_boundary at all if it isn't set.
> 

Yeah, I'm just using (len_to_oe_boundary == U32_MAX) as the explicit
flag, but your idea above is basically where I started.  I actually
started at len_to_oe_boundary = ROUND_DOWN(U32_MAX, PAGE_SIZE), but then
I realized I'd have to actually think about sub-page blocksizes and went
to the flag idea.

Especially since the code is going away, I'd prefer a minimal change and
a big comment, but I don't actually have strong opinions.

-chris


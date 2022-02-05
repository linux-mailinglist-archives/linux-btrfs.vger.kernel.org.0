Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443704AA4E7
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 01:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378358AbiBEAKT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 19:10:19 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:33950 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378698AbiBEAKO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Feb 2022 19:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1644019813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XZjZ6cv3DPk1deO9D+tdpm2vfVxn6Ht94VFgU8XxzUw=;
        b=ZPE2GQMsuVnaUku1zutQW3l5MiMj+CD4LlYi+19VUKaxhOiWjT4m3hnaN44lY3QpbxYz08
        cDrAeGUY5dPBfRdFwAFTnfUxJtKPA4R+8BZWHF0MKtGywzrPjIqihdD7kKWvwEXhpOTpn0
        /GnVCVH31X95oOGkW42mL57JLLx7ndA=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-p-hVFmosNB6AqPQsQLEgYQ-1; Sat, 05 Feb 2022 01:10:12 +0100
X-MC-Unique: p-hVFmosNB6AqPQsQLEgYQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nyi3HWZGEO2Pz9Yk20wc85ObXSE6QFYSpgyNJcBQxnVGc9Za4BO5ZcgxgElFN1cOvXn8LvirxDzl6NnuKffQZKLW+cbARZqrQ9uoDK74fm9dOYX+Mhf2NkP+C/M/MJS/nB33eBAg3SbarxfYVecVM62pjeXkCC3qZ91p4uHTSPkTtFv0JX2CEdwZOQ+kLU+r37qkIbN/0j24Wdfo1cEr4mlDqgZDzbzceskeS8pAZemIv2unPIGDKYw0dbvR1/F7OYSPIwba2rjvfkWaB5x25IVx0NkCP3V7gq8J2kTJ6FKiW6R7rDwCkPWLKW77idtS9DdYIGu64y+hCkClV2NTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZjZ6cv3DPk1deO9D+tdpm2vfVxn6Ht94VFgU8XxzUw=;
 b=oNWx4cPv2QWbTDltEkWUV279f05opXmIMNwhOYccz7NxyZxzLSRPmqkkO5VI2LWg+bDb1VNe+3H0i84mCNSE7MBJD/mZwoYwmQp0b8+EZuOQa5jPMTfgfxPHw3ErFQDsGw9ZzfPDIfwtZLM1nLNiXRbuIzXFQaOryjCdp45dxRvUPmqLnTv3VKgMerG+75bFEB2Oz2FqxnnXvk1TdknBJdyhm1BqhdKU7pbAtw4fes2nfhaGudXViVLexoerSM9RcpGlE//58qw20EeL9rG3bG62IcmItPaL9Ehrxvsy/YJK5cnl3LgnKKp1GJhCsd1JPvOUhaGaKm3v8I2XcOp+uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by VI1PR04MB6032.eurprd04.prod.outlook.com (2603:10a6:803:fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Sat, 5 Feb
 2022 00:10:10 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::18db:1eae:719e:ef4e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::18db:1eae:719e:ef4e%7]) with mapi id 15.20.4951.012; Sat, 5 Feb 2022
 00:10:10 +0000
Message-ID: <8f42d9a1-e005-9b45-c4f8-c14cbfdaa9f0@suse.com>
Date:   Sat, 5 Feb 2022 08:10:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1643961719.git.wqu@suse.com>
 <Yf1gVUTezMEviTPU@debian9.Home>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2 0/5] btrfs: defrag: don't waste CPU time on non-target
 extent
In-Reply-To: <Yf1gVUTezMEviTPU@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::19) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c47c03ca-2660-41d0-1062-08d9e83bdf99
X-MS-TrafficTypeDiagnostic: VI1PR04MB6032:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB60325852D32CD9C1BA99AF70D62A9@VI1PR04MB6032.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eF+jVqjFThY9nOb41T3C/7DCf5h615suzvLGT11mQFwFTaFtMHtrnhyd6h/pCWfjXagpebWGcZXMA7C7IRVeLCbtJDjAxql0dsohiOpXL2It3OXJRwqp0AbwZFcyUpEk8XJjtBemmzpg/V6qK3x3KFWZVfCR7NlatM3To7PNqJzkQZhnalsBuOZbS73N1jflo21fPWokslomBu5vSLW2avnrC0mKZkEEYP382xFQ+ftSoGvgpYCC40HypmqCSEuoGn8tZJixDNakZ3w1vzwAq+XVaBiSScf83VUEPl1P3nF4i8Y3M6JYT0UjWPBD4ubZRp8K2Sfr41Z1ncEchTZA/0aIu/6ZeBPKviMpLZIOi0A8frg6EwctLKz5A3OYmpBuPxzKPB8GfcOAODWTqnludPNHQUXm4ZlMrUX2bMrD8yWoMVX3BDMewzX85eAoiO//h0udHRlPTz43MA6Fgv6I9XmM1S4rGoV/QjS/TTbdTGPxFk2DKTimqYO1vgYP5l9ROphj/HmlpFvQtDTEF1tMhqArICAXCpgPcbzuzxq0v7IcntFbx36tgsWIm4jc7QVGdrGMNnshQBPR0s+5HBpg91DuLCZYtLBUZ/733w7xXL0RpfI9R94v4ZJdxZzkpSjiaap4klhl/chBAlO7LcTaEshm7OuMwrYhOIt15PplZy5ggvlBokm3iNB9uC2oC5+WnK1hxjGaDu2aSyoOvkO3TnuvcCXpwLNq2zFWlYVva3KArbZ9W2iHT4DUluwVQMWJATmu13j+LHTC8AD1Mj85kFcTf9yC7JTV/Mhi/g6XBgPp8tLc0mvy5ygWXmoIq35/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(26005)(5660300002)(186003)(6506007)(508600001)(31686004)(36756003)(966005)(38100700002)(4326008)(6486002)(6666004)(8936002)(66476007)(66556008)(8676002)(66946007)(86362001)(31696002)(6512007)(2616005)(2906002)(83380400001)(6916009)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUJSV0ZIL2UrckJtTFlkVlJXNHNqWGRUTTBTMXo3MWd4WHp6NmhXOVRqcC9p?=
 =?utf-8?B?UCtWTTBGY2lpdWphQTRENmtUaW1OTW1tcitNR05lR2c1Qkk3dm5CT3hSVVN6?=
 =?utf-8?B?VWpId1diM2hnQmhXSkM3Ty9CRFNyWWREaXBjd0pzaERRWnZWVS8zRDQ4YjVa?=
 =?utf-8?B?Zko3eFVmZSsrL1J4NS9iNFcyVnIxeU1SZEQ1ZERuTEJ3THMveVcvR3JaR2FL?=
 =?utf-8?B?SDFLdk9qK2NnWkR2ZTBDMHFGMGRnQ1dwZDh3c2lZa3ZENitWano1SFYvcTlL?=
 =?utf-8?B?RmU4eERBMmEzQW1ZSnUyODNJdEF4a3krdTc3UW9aN0VSQ2wrZVhDQWF1Wlph?=
 =?utf-8?B?V3BEenpxVmx4Qm5TUnMvVEZxaFhkZUVPZXF0Wnh1bEdxUGt5SFkyZ0lIa1dZ?=
 =?utf-8?B?WG12WkV5OEgrZGhOd2hUeXBJQ3VMeTU5Z0RtdHVwM0gvRVJaSzlEeUhlNVRv?=
 =?utf-8?B?eHdnV1gxb2xVVmh6QUlzbnM3elVVdnpVN0lBVis4emdyd3NtakZWM1J0U1RJ?=
 =?utf-8?B?b2hzMlNPR0dTaTl0cmx3QnJtNXFtUndVV3JnT2ZOcXg1d3dQNDB5TjduaVNn?=
 =?utf-8?B?NmNVVnZkaUR5dm1CSzBZYytsbllhT0hhR1RES2JvRDRGVC84T2dwMTRLb2Ry?=
 =?utf-8?B?aUZzenUreGtrOGNEcmdGVTY4UE14RWthZ1NhWWNHRmlHVzE2akFrUDhwQXI4?=
 =?utf-8?B?SGo1UVhTU1FteUp5aW15aU1DcjF6SXlaVmZSWmw2cEVZOVkxelpLaFhHS2Fs?=
 =?utf-8?B?ZmNLeTRaOUlPOEdsb1ZEN2cyeUxIUmNzS1MxZWtNVVgvRUxnN3ROa3NhaitU?=
 =?utf-8?B?OGpCRE9zYXc2bWJ5dnkzZGlWaTh5OFpvT21welFBOVhZZStCWmJlOWlzTnp3?=
 =?utf-8?B?WncyNjZjck0wZXlkYzhUd3VxOG1JMjNyNFlBYytQTStmc083dlZEcmNhQlhx?=
 =?utf-8?B?R0FEbjIyd1krYUt1Y2RMTXZQdEhlMTlveEdEOUJrMjBrSzBpZXcwT1BMVEl3?=
 =?utf-8?B?VjROL3BmdnY2YkNFOWJoR1RLTFI4N3BQK3RTcmg3KzRoMGM2Q25ZQU9PbWk1?=
 =?utf-8?B?MlhBTjFjMHRzKzFndTZ3bzFDMnlDQmFpQXNtUlUzdmMvOFZRekYzWDhTWFNt?=
 =?utf-8?B?azNyazFFRmZ1NDVqYXdWQlEyYS84Vmh5dW50SUEvc0hlNVV5cXNFejl5bmxH?=
 =?utf-8?B?cEZDbVpHN1JsV2dwQXllcmFHM0dhTUZldXZNOWhFZVJQb050N0cyRTlYRDhD?=
 =?utf-8?B?M0p3NEh6Vm5UOHhKTEJkMWRIZEZtcDV3RE1vV2VVK3B0Z0s3eXlWU3ErTzU5?=
 =?utf-8?B?ZDhEOVdVa09SYlNFejFLaXgyU1JnMXRRMHZOcWJXVUM5MHFlRGNJZTErNjhZ?=
 =?utf-8?B?L0pUVFhJMGlXbkNOeWlDL3J4MW9qWHg0SjQ2KzIrczUvbitrS3gxL1MxK0Mw?=
 =?utf-8?B?RHhJZlJSeFNmUTMrUFVScCtrdEtsRExyTlRLTkpaU2VGQkIxZURXM01IcHcy?=
 =?utf-8?B?VFFxQVNrOEJlOU5mZWZaR0VVUUpna0JhQVZwRjZvaEF1SHhrazF6NUdxUTJx?=
 =?utf-8?B?VTlDanBHSjhjd1MzYmVBUUd6UmFQM3VOREVuVXpUdTRIYmh6RUlCTUVHNkxj?=
 =?utf-8?B?Q2pGTmNneE00bklhbk85MkhWWFBFeUdzZFUweUdpaTZWL2tqRFB5RkEwT1NX?=
 =?utf-8?B?ckZJcVJYdWNEQU1kRWVKTHJhUm5PbGZOeWlRSGgzNWc4b0dQNTJ2bEJET2Fq?=
 =?utf-8?B?aFFCSDdHZndYakk5UGVHbVNPdU1maEV6ZmF0VU9wbG1UVXIxeVRLUmVIV2ho?=
 =?utf-8?B?NHlleFpzdHFsNGVDK0RxNjlYQlpqK3llWjFtNHROZnRCclNDK2ZkdDhZenZq?=
 =?utf-8?B?MDNkNmlad0RKclBxWEJvMm5ZNmtkYU9LbjA1Njl2VVJ2TkhRd0NLTk9aUnhm?=
 =?utf-8?B?TXZwQVFFRXhuZDJEbDlWYnVQLy92N2NPNmk1cWZyeVBwTTBaQVp4NnlEZlVM?=
 =?utf-8?B?djZ2M0lzVzJuVnZ1TDFNbnd2MnVIeHNwblZUbWZWbU9WRkp6NWpKUC93OGps?=
 =?utf-8?B?TWZPcU9OSUtoU2c3Vy8xVTN1Yk5nakZhS0UwRXNsN0tOb1l3MzFTTFoxbDFJ?=
 =?utf-8?Q?3xnc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47c03ca-2660-41d0-1062-08d9e83bdf99
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 00:10:10.2794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6HtRUQn5ZRf6dwx8ru3LbZuezVhA1Dn2liB5IWDDaU4A+hQ69yX9uP+gd/xbN4u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6032
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/5 01:20, Filipe Manana wrote:
> On Fri, Feb 04, 2022 at 04:11:54PM +0800, Qu Wenruo wrote:
>> In the rework of btrfs_defrag_file() one core idea is to defrag cluster
>> by cluster, thus we can have a better layered code structure, just like
>> what we have now:
>>
>> btrfs_defrag_file()
>> |- defrag_one_cluster()
>>     |- defrag_one_range()
>>        |- defrag_one_locked_range()
>>
>> But there is a catch, btrfs_defrag_file() just moves the cluster to the
>> next cluster, never considering cases like the current extent is already
>> too large, we can skip to its end directly.
>>
>> This increases CPU usage on very large but not fragmented files.
>>
>> Fix the behavior in defrag_one_cluster() that, defrag_collect_targets()
>> will reports where next search should start from.
>>
>> If the current extent is not a target at all, then we can jump to the
>> end of that non-target extent to save time.
>>
>> To get the missing optimization, also introduce a new structure,
>> btrfs_defrag_ctrl, so we don't need to pass things like @newer_than and
>> @max_to_defrag around.
>>
>> This also remove weird behaviors like reusing range::start for next
>> search location.
>>
>> And since we need to convert old btrfs_ioctl_defrag_range_args to newer
>> btrfs_defrag_ctrl, also do extra sanity check in the converting
>> function.
>>
>> Such cleanup will also bring us closer to expose these extra policy
>> parameters in future enhanced defrag ioctl interface.
>> (Unfortunately, the reserved space of the existing defrag ioctl is not
>> large enough to contain them all)
>>
>> Changelog:
>> v2:
>> - Rebased to lastest misc-next
>>    Just one small conflict with static_assert() update.
>>    And this time only those patches are rebased to misc-next, thus it may
>>    cause conflicts with fixes for defrag_check_next_extent() in the
>>    future.
>>
>> - Several grammar fixes
>>
>> - Report accurate btrfs_defrag_ctrl::sectors_defragged
>>    This is inspired by a comment from Filipe that the skip check
>>    should be done in the defrag_collect_targets() call inside
>>    defrag_one_range().
>>
>>    This results a new patch in v2.
>>
>> - Change the timing of btrfs_defrag_ctrl::last_scanned update
>>    Now it's updated inside defrag_one_range(), which will give
>>    us an accurate view, unlike the previous call site in
>>    defrag_one_cluster().
>>
>> - Don't change the timing of extent threshold.
>>
>> - Rename @last_target to @last_is_target in defrag_collect_targets()
>>
>>
>> Qu Wenruo (5):
>>    btrfs: uapi: introduce BTRFS_DEFRAG_RANGE_MASK for later sanity check
>>    btrfs: defrag: introduce btrfs_defrag_ctrl structure for later usage
>>    btrfs: defrag: use btrfs_defrag_ctrl to replace
>>      btrfs_ioctl_defrag_range_args for btrfs_defrag_file()
>>    btrfs: defrag: make btrfs_defrag_file() to report accurate number of
>>      defragged sectors
>>    btrfs: defrag: allow defrag_one_cluster() to large extent which is not
> 
> The subject of this last patch sounds odd. I think you miss the word "skip"
> before "large" - "... to skip large extent ...".
> 
> Looks fine, I left some minor comments on individual patches.
> Thinks that can be eiher fixed when cherry picked, or just in case you
> need to send another version for some other reason.
> 
> So:
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Thanks.
> 
> So something unrelated to this patchset, but to the overall refactoring
> that happened in 5.16, and that I though about recently:
> 
> We no longer use btrfs_search_forward() to do the first pass to find
> extents for defrag. I pointed out before all its advantages (skipping
> large file ranges, avoiding loading extent maps and pinning them into
> memory for too long periods or even until the fs is unmounted for
> some cases, etc).
> 
> That should not cause extra IO for the defrag itself, only maybe indirectly
> in case extra memory pressure starts triggering reclaim, due to extent maps
> staying in memory and not being able to be removed, for the cases where
> there are no pages in the page cache for the range they cover - in that case
> they stay around since they are only released by btrfs_releasepage() or when
> evicting the inode. So if a file is kept open for long periods and IO is
> never done for ranges of some extent maps, that can happen.
> 
> By getting the extent maps in the first pass, it also can result in extra
> read IO of leaves and nodes of the subvolume's btree.
> 
> This was all discussed before, either on another thread or on slack, so just
> summarizing.

Yep, we're on the same page for that.

> 
> The other thing that is related, but I only through about yesterday:
> 
> Extent maps get merged. When they are merged, their generation field is set
> to the maximum value between the extent maps, see try_merge_map(). That means
> the checks for an extent map's generation, done at defrag_collect_targets(),
> can now consider extents from past generations for defrag, where before, that
> could not happen.

Oh! That's indeed a completely valid reason for the extra data write IO!

Although there is still something concerning me, as the same report you 
mentioned later is using compression.

I guess there is either some preallocation for the workload, thus it 
mostly kills the compression for inodes with PREALLOC flag.

Anyway, your analyse looks very solid to me, and adds extra priority to 
add back the original behavior.

Thanks,
Qu

> 
> I.e. an extent map can represent 2 or more file extent items, and all can have
> different generations. This can cause a lot of surprises, and potentially
> resulting in more IO being done. Before the refactoring, when btrfs_search_forward()
> was used, we could still consider extents for defrag from past generations, but
> that happened only when we find leaves that have both new and old file extent
> items. For the leaves from past generations, we skipped them and never considered
> any of the extents their file extent items refer to. So, it could happen before
> but to a much smaller scale/extent.
> 
> Just a through, since there's now a new thread with someone reporting excessive
> IO with autodefrag even on 5.16.5 [1]. In the reported scenario there's a very
> large file involved (33.65G), so possibly a huge amount of extents, and the effects
> of extent map merging causing extra work.
> 
> [1] https://lore.kernel.org/linux-btrfs/KTVQ6R.R75CGDI04ULO2@gmail.com/
> 
> 
>>      a target
>>
>>   fs/btrfs/ctree.h           |  22 +++-
>>   fs/btrfs/file.c            |  17 ++-
>>   fs/btrfs/ioctl.c           | 224 ++++++++++++++++++++++---------------
>>   include/uapi/linux/btrfs.h |   6 +-
>>   4 files changed, 168 insertions(+), 101 deletions(-)
>>
>> -- 
>> 2.35.0
>>
> 


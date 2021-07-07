Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32AB3BE470
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jul 2021 10:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhGGIbt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jul 2021 04:31:49 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:44962 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230109AbhGGIbt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Jul 2021 04:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1625646548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4rrD3dUUTbhwVOMjR5OIES+GTRm1GMd5zXuNf0bJLqA=;
        b=aI3XkJ/069UxmeU7gXqGAsd/XOp7Fr1IiqPX4KU4hUqkujEj8NKrEs/heLJxsQQKkQvrg+
        hc4gh158xc7mG+5ycq0qeFAJCSEsIgW+lsPQFZ7sL7M056LGvWWj+Le42ty1y2RAhC1Zu9
        icP722jaHkfo8uQYNJAW/A+j+6nlOkQ=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2057.outbound.protection.outlook.com [104.47.1.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-40-VJkdJBNcO3yWH8LRksDiGQ-1; Wed, 07 Jul 2021 10:29:07 +0200
X-MC-Unique: VJkdJBNcO3yWH8LRksDiGQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIb3Ro6OQk+Ot/jrKsTcwZuzcqcooqxoEiWAw618jA0Mf5SCWMpx9ZojIhB0U1sj+aJbTcL9D5beyLM8e6nnC1mKnd6CSNwpJHz+Ev+IlJT94M3qUzVjjRqac5QQSoS7cxqAKDyhN6hTeZiNQXw6Br+36PMN1tcS1X5NEfhDgdLBQfmpjGOeuQYsyxsjAbLW4uP3wOoIy2JKccMiu1SJRQJmd+gNonT36y7bXP9Lc0i8dbI+3rNxrDOaHvt2JtnA10fRnAFX0p9sUgQelgsnXAgtwpCNyViOrP4huGOskjJuj7BxOrOKnjimQHguDo5mpeKDtBGoYnzxo/0w0Y8gFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ARuj0/q6w8c5+HaiKozZ2fY+oyMaDR6khkwZbShvCI=;
 b=DfuswSjYh9LL4X7n5/LlTXTAeFONqvkOqbEUdDhxoCXKNmfzVrALj8H84kijDtmyw19LkVcarB/5A7PbbaevitjGBLVJrncZxk8lY2fX6AZIf6ezuRyfdGB/0nYeLYAAEBgHvd9BG6lqPVOhw0puy6b6iXvH8orS6dALg6p3r2RCVvwc/vyx5tBmv6KKqyX8mF+8W9M45z55iPqS/ahE40Hh4X1teYcOmeY/mrMt7WgEX6WhLfFFRyRlirDx9LJ6epHsXkKNlIGmFMvyCHVHolHHJgAOo25l7isOkSYFKoemA46DAXiKh/W/fgtEvF3sVRaD4PktpfDWR4xO8xltGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB7990.eurprd04.prod.outlook.com (2603:10a6:20b:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Wed, 7 Jul
 2021 08:29:06 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 08:29:06 +0000
Subject: Re: [PATCH v6 00/15] btrfs: add data write support for subpage
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
References: <20210705020110.89358-1-wqu@suse.com>
Message-ID: <5ad76de9-d1df-cafa-f5c3-44e316e0fb23@suse.com>
Date:   Wed, 7 Jul 2021 16:28:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210705020110.89358-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:a03:331::16) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0071.namprd03.prod.outlook.com (2603:10b6:a03:331::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 08:29:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60954775-00a3-4124-11d3-08d941214898
X-MS-TrafficTypeDiagnostic: AS8PR04MB7990:
X-Microsoft-Antispam-PRVS: <AS8PR04MB799014CCBE66046ADFF9CEFCD61A9@AS8PR04MB7990.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: neInI1P6lEYBog2HzVM6ZTQG2Z7qWHbV8mOzV8OeIUBxk/PmQC3uTMRdFmZWuvGhZ25t181/6PEt2ATJ53fUdzRjC7+rKTlTlL8V1OXJmh8Z/DTPNQ0nDRgzGsnEPdgj3o1bW+AWZzx+8o5rxmSaPj+83gAASddppFUb/9czyfv+uKkKROwauw4rah4LdMVUkl0teoC/NdBBB1L7YQ5Iys110kcxLQR+WwexHFit/yvrzs3QGrom5hLhrgCxvgrNar4Z07LMg8eReexhDTipWaZpuJEXR3SDCTBamF/otR/DvpyxA6iZUjyptRlHEu5upexGRVhpS+pT1HBr2fkalDsnzV1DwpAlp5IzhlthqSm7leeStys2FdOrpOXkJQfCXgAzz2KRFXuY6HWdXB+7Eh9b7ikgVqq97S9k3Sl8cidDYGkmh8hpm3Rcef5T51j6u/HL+oVX1D9m//c4/n86zoZffwbEgHaVYLiKy81K4iXQsFyNfSnAFiy+96706EYDeGtn4MalL/SA7SuYtP3T5CHtHW81Rp1e+YpifBkpS4ekBEBKpJX2ce9QzPcQrqmi53krhQEE+AXRtZGonCAKkz4USAWV3sAanjsD7kByUM7jUYGKQ55li23SLqeS9gk/e3eOccPmZ1MLi5IrqsqAElRrYlO49Wcib9VuX4RMvvrFa9Hge9hbiUNxu2zjYLrFlw3BD4f8ufHiqe6ldcaYBH43zEd6Q0gY/vq+2i7j3f99V/q97PglYm7qoGACCQtQe5ldTaFDiVoEiJFOgQfkSEBtVEYR2GdwMWMBPCfJbU8evDCYg9txcBCbZK2+zpuHcQ5r6WWhds+qBq4vaT0kTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(366004)(39850400004)(16576012)(8936002)(956004)(83380400001)(31696002)(6916009)(316002)(966005)(6706004)(2906002)(38100700002)(66946007)(478600001)(6666004)(5660300002)(8676002)(86362001)(36756003)(31686004)(26005)(186003)(6486002)(66556008)(2616005)(66476007)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sQ49epMQ2dGtfVU1//ZNnClnW6AaUjum9gHIIq7Q9KbEk5Js3bKzdUB7mbmK?=
 =?us-ascii?Q?B68sz+WX4Qz0i7BoOlC/hLPSLvHZi+6yiw2qDPst9T6gRE1KokcHdD15OKEO?=
 =?us-ascii?Q?JOxsnPTc8bFDjZYS2mb39ZULIKdbEnVTBn/Agtw/MypasP/XW1Ga6AkAOTiT?=
 =?us-ascii?Q?ybGvg1XWFnHONzElOsqWaXDL7rG/vMPx8SO23p8YSH/l5gZZ2qFGXEWFahcL?=
 =?us-ascii?Q?lwSgUyQFCM/gAxWiAdPU/mIOgEwyUDNLTBMQJBbmgxYVmgRBmcy4kq1ee81D?=
 =?us-ascii?Q?yfW+bgRJAWelguH5lFk46VX8MrfVpWMI9tA67Q4RkKtt/XtcEgVlaHYDIXuz?=
 =?us-ascii?Q?CsUKLfg33WTr8qXULgLz71U4VJp+ItvF3QjKzQOC+xvez45yWoq9TlNbTeQc?=
 =?us-ascii?Q?ax7G6iJiBd1jPb/hqLEz2r0lAlkJ+PEbUeC0a1jUhoWhdjm2NJ+GwJVjB4ID?=
 =?us-ascii?Q?fFeEvxsoX9CuKIsJXv4VqaEkY4pU03b0SC1VJzlP1hHu403xL/m3r68+PoCl?=
 =?us-ascii?Q?JgcOqtMk1aMCQeIqhPH1xQYLI/AbD++lcvHwAWki70Ttl3qpDjt+pKbvnvTo?=
 =?us-ascii?Q?49iIRSMoS1ak7fb7dprwIcBq76qslZERR8mRYFNpfCi4Sa267ECibuXSF6uf?=
 =?us-ascii?Q?Mwm3skgSp3xTGaVR+P5AMXerqf8d10/rMfkhzvkOv43+eqXby34fLUoZSNkX?=
 =?us-ascii?Q?o0RN+6a1Ijgnc+mnVaxDCfEu4AKxcnW4vtbU4nJfzhSSCuTGwJ/rl/xAJamh?=
 =?us-ascii?Q?dnSDXwJdV40d8w/aQopOpEpsscIxbufrX2EDwp45p5w3Of/1820agRiJJfJo?=
 =?us-ascii?Q?7qJAQ0Q1sfPp6vkkTRS8iquQ0h5xiEvBlrRrwoRJTSusQd6fsZ91Vx7jHUZ/?=
 =?us-ascii?Q?JIp3GFR8nPJ9iV8B6bwHpaYuyaXHaFBiB4T4W8RUYtUaET/q77F/9LoWHx5v?=
 =?us-ascii?Q?D8+L4qL+sInxFiBYuPwF/8VKVbVSaHHNJhf1n+YGlgrAJaKy9PqZ0dmOcrYB?=
 =?us-ascii?Q?UIZVyvvaYY5w/7b3R3ahNHW7HEBHD+FvHhSIv+HafNX6OXnh7DyyXaLIcLuR?=
 =?us-ascii?Q?KeB518sbKHQgJ6+EusZda4XJJOnJ8tCgYmEjddv0YLD8rkKrHoNlLzOy+SIB?=
 =?us-ascii?Q?AkApYPwe/hsKfltm9Tl9JPrx3iJBO4SfN3yepxkXWyNX1eCd8UWpPvWlim/L?=
 =?us-ascii?Q?2CH9ovWRB+RcvRRZmKv6QS/s1Vr8/dBVYX9riBAMxeW1MSQbccQWYLpBbCrU?=
 =?us-ascii?Q?/4H8pB7pQa2jdRsfcIjyqASCj3Hz3v9iGXKvcx+ktOxBBPKkLOvqAfBYVAV0?=
 =?us-ascii?Q?G8T+M2BNGJ46qJDi6qaBv5Dr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60954775-00a3-4124-11d3-08d941214898
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 08:29:06.0583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHnHtFaAQpJGrLPKQDfJOoGNX2KYdeLWs9s+6MpEyjQ3N1TwZo7S4XNjGwk0/YaQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7990
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/5 =E4=B8=8A=E5=8D=8810:00, Qu Wenruo wrote:
> This much smaller patchset can be fetched from github:
> https://github.com/adam900710/linux/tree/subpage
>=20
> And thanks him again for fixing up the small typos and style problem in
> my old patches. Almost no patch is no untouched, really appreciate the
> effort.
>=20
> These patchset is targeted at v5.15 merge window.
> There are 11 patches pending for a while, and not touched, thus they
> should be pretty stable and safe.
>=20
> While there are 4 new patches, two of them are straightforward small
> fixes, the remaining 2 are a little scary as they reworked the core code
> of compression.
>=20
> But the rework should improve the readabilty thus make reviewing a
> little easier (as least I hope so).
>=20
> =3D=3D=3D Current stage =3D=3D=3D
> The tests on x86 pass without new failure, and generic test group on
> arm64 with 64K page size passes except known failure and defrag group.
>=20
> For btrfs test group, all pass except compression/raid56/defrag.
>=20
> For anyone who is interested in testing, please use btrfs-progs v5.12 to
> avoid false alert at mkfs time.
>=20
> =3D=3D=3D Limitation =3D=3D=3D
> There are several limitations introduced just for subpage:
> - No compressed write support
>    Read is no problem, but compression write path has more things left to
>    be modified.

Well, without proper testing just for compression read, it turns out=20
compression read path has more bugs than I thought.

The latest bug exposed during subpage compression write support is, the=20
add_rd_bio_pages().

Obviously it has tons of hard coded PAGE_SIZE, and can easily cause=20
ASSERT() for readers accounting.
As it added locked page without proper subpage::readers account updated.

For this case, I'm already crafting a proper fix for that.

But on the other hand, I'm not sure what's the proper way to introduce a=20
fix for v5.15 window.

Should I just disable readahead for compression read (which just needs=20
two lines to return 0 for subpage case in add_ra_bio_pages())?

Or should I add the proper fix into the patchset?

Thanks,
Qu

>=20
>    I'm already working on that, the status is:
>    * Split compressed bio submission
>      Patchset submitted, since it's also cleaning up several BUG_ON()s, i=
t
>      has a better chance to get merged.
>      But I'm not in a hurry to push this part into v5.14, especially
>      not before the initial subpage enablement.
>=20
>    * Fix up extent_clear_unlock_delalloc() to avoid use subpage unlock
>      for pages not locked by subpage helpers
>      WIP
>=20
>    * Testing
>=20
> - No inline extent will be created
>    This is mostly due to the fact that filemap_fdatawrite_range() will
>    trigger more write than the range specified.
>    In fallocate calls, this behavior can make us to writeback which can
>    be inlined, before we enlarge the isize, causing inline extent being
>    created along with regular extents.
>=20
>    In fact, even on x86_64, we can still have fsstress to create inodes
>    with mixed inline and regular extents.
>    Thus there is a much bigger problem to address.
>=20
> - No support for RAID56
>    There are still too many hardcoded PAGE_SIZE in raid56 code.
>    Considering it's already considered unsafe due to its write-hole
>    problem, disabling RAID56 for subpage looks sane to me.
>=20
> - No defrag support for subpage
>    The support for subpage defrag has already an initial version
>    submitted to the mail list.
>    Thus the correct support won't be included in this patchset.
>=20
>    Currently I'm not pushing defrag patchset, as it's really not
>    the priority, and still has rare bugs related to EXTENT_DELALLOC_NEW
>    extent bit.
>=20
> =3D=3D=3D Patchset structure =3D=3D=3D
> Patch 01~04:	Subpage fixes for compression read path
> Patch 05~06:	Support for subpage relocation
> Patch 07~14:	Subpage specific fixes and extra limitations
> Patch 15:	Enable subpage support
>=20
> =3D=3D=3D Changelog =3D=3D=3D
> v2:
> - Rebased to latest misc-next
>    Now metadata write patches are removed from the series, as they are
>    already merged into misc-next.
>=20
> - Added new Reviewed-by/Tested-by/Reported-by tags
>=20
> - Use separate endio functions to subpage metadata write path
>=20
> - Re-order the patches, to make refactors at the top of the series
>    One refactor, the submit_extent_page() one, should benefit 4K page
>    size more than 64K page size, thus it's worthy to be merged early
>=20
> - New bug fixes exposed by Ritesh Harjani on Power
>=20
> - Reject RAID56 completely
>    Exposed by btrfs test group, which caused BUG_ON() for various sites.
>    Considering RAID56 is already not considered safe, it's better to
>    reject them completely for now.
>=20
> - Fix subpage scrub repair failure
>    Caused by hardcoded PAGE_SIZE
>=20
> - Fix free space cache inode size
>    Same cause as scrub repair failure
>=20
> v3:
> - Rebased to remove write path prepration patches
>=20
> - Properly enable btrfs defrag
>    Previsouly, btrfs defrag is in fact just disabled.
>    This makes tons of tests in btrfs/defrag to fail.
>=20
> - More bug fixes for rare race/crashes
>    * Fix relocation false alert on csum mismatch
>    * Fix relocation data corruption
>    * Fix a rare case of false ASSERT()
>      The fix already get merged into the prepration patches, thus no
>      longer in this patchset though.
>   =20
>    Mostly reported by Ritesh from IBM.
>=20
> v4:
> - Disable subpage defrag completely
>    As full page defrag can race with fsstress in btrfs/062, causing
>    strange ordered extent bugs.
>    The full subpage defrag will be submitted as an indepdent patchset.
>=20
> v5:
> - Rebased to latest misc-next branch
>=20
> v6:
> - Rebased to latest misc-next branch
>    The 11 existing patches have no conflicts at all.
>=20
> - Added four patches related to compression read path
>    This involves:
>    * One small fix for extent map grabbing
>    * One preparation to remove GFP_HIGHMEM
>      kmap()/kunmap() is not removed yet, as it's only for later
>      subpage related decompression path rework.
>    * Rework btrfs_decompress_buf2page() and lzo_decompress_bio()
>      btrfs_decompress_buf2page() handles the copying of decompressed data
>      to inode pages, without proper subpage handling, we can copy
>      decompressed data to wrong location
>      lzo_decompress_bio() needs a sectorsize related fix to handle
>      padding zeros.
>      Since we're here, I just reworked the code to make more rooms for
>      proper comments.
>=20
>      These two rework looks scary, and touches the core functions of
>      compression, thus Josef gave me extra tests runs on them and no
>      regression found.
>=20
>      But still they definitely deserve more review.
>=20
> Qu Wenruo (15):
>    btrfs: grab correct extent map for subpage compressed extent read
>    btrfs: remove the GFP_HIGHMEM flag for compression code
>    btrfs: rework btrfs_decompress_buf2page()
>    btrfs: rework lzo_decompress_bio() to make it subpage compatible
>    btrfs: extract relocation page read and dirty part into its own
>      function
>    btrfs: make relocate_one_page() to handle subpage case
>    btrfs: fix wild subpage writeback which does not have ordered extent.
>    btrfs: disable inline extent creation for subpage
>    btrfs: allow submit_extent_page() to do bio split for subpage
>    btrfs: reject raid5/6 fs for subpage
>    btrfs: fix a crash caused by race between prepare_pages() and
>      btrfs_releasepage()
>    btrfs: fix a use-after-free bug in writeback subpage helper
>    btrfs: fix a subpage false alert for relocating partial preallocated
>      data extents
>    btrfs: fix a subpage relocation data corruption
>    btrfs: allow read-write for 4K sectorsize on 64K page size systems
>=20
>   fs/btrfs/compression.c | 152 ++++++++++----------
>   fs/btrfs/compression.h |   5 +-
>   fs/btrfs/disk-io.c     |  13 +-
>   fs/btrfs/extent_io.c   | 209 ++++++++++++++++++++--------
>   fs/btrfs/file.c        |  13 +-
>   fs/btrfs/inode.c       |  78 +++++++++--
>   fs/btrfs/ioctl.c       |   6 +
>   fs/btrfs/lzo.c         | 210 ++++++++++++----------------
>   fs/btrfs/relocation.c  | 308 +++++++++++++++++++++++++++--------------
>   fs/btrfs/subpage.c     |  20 ++-
>   fs/btrfs/subpage.h     |   7 +
>   fs/btrfs/super.c       |   7 -
>   fs/btrfs/sysfs.c       |   5 +
>   fs/btrfs/volumes.c     |   8 ++
>   fs/btrfs/zlib.c        |  18 +--
>   fs/btrfs/zstd.c        |  12 +-
>   16 files changed, 661 insertions(+), 410 deletions(-)
>=20


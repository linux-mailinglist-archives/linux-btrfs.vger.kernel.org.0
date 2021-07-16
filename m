Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFCD3CB515
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 11:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhGPJPR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 05:15:17 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:20080 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231244AbhGPJPP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 05:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1626426739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CHGBbQlxVlZ6NDDUjNBVSzxnUsc6pYsNflCkl8wC79s=;
        b=Z27SvUJ4eUOA7P4Vssd6ci4yacFwJbU4gIyeQhBv6dJm+2my1xejiPT/g5azMrFOx5XYjk
        c5rcNQzl3pvo5aTMea+nk5eXo7x4qZG0vqyLLvCXx7UweeCjf2O+6KLsTwvbmPGe9aWB/+
        21ufdWKfD8VN5ceNY7JMO62nMLZYWRY=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-1-S0ms0UhcMMKPkRpJ9Z1RIw-1;
 Fri, 16 Jul 2021 11:12:18 +0200
X-MC-Unique: S0ms0UhcMMKPkRpJ9Z1RIw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XW9Oj4nIXPSRafISIjXJ8rsJKfX8wKxHfipE9SXrwh7XHPtT2O/Ah4qPyeZR63Ts8JuzVLNnGL9MCbWCcbqK1xYUIs8wk+RUpnafw8/+RcOcThzWf1N8ePUZuE4FHWTSIdCWygKPvdwKDmNZxDdWH+m8HKzv1NxK9uzletwMZr60cS0ODhaWG+jDuzoKCptWW31gbV4VEmUb00FVIOlsP7RucHY2Wqp+XHLsAtpyJcrmkUKsNpbtv4HThyCdoLe8ZhkAklxVoqsQNt3mwB5icDtd4UjB3avqCd4kND8QDoOIAYPeRAEqmNeg88RvbBlzajhn5WiFPX2vvfVsPRSX6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Am9HIUSmxldHY8nxH+vwgD/PDABV1s3WYtqCgjUb1/4=;
 b=Th854NCudl0u4Z5PknTxdUVlW10WZislCOZgdvoEPFTqIpTVYxlfQ7QfQYWh+exyOS+TQCa9rOJZcmPUx8O84P3rsZj/Qt8m1sH/KmvD9crDs0+QNoZk5X3isN6FnHO23dUzvC3xCcxa63M7ykR0ckL79MY8d4GL/dEklfjFglzh/dlmMwDRvhbzrTrRAVTZLneXsPtyYJeBZ/3Z01HpFnIzkzog8K49FofiRrY3MUDp4YqeRjGZb1OjnXXvlpgQ0kHnbuIIkn2qbeW1HCJT+VuLKgt5VfhKa/o1RGO3/QeKfJuvzmJOSaQgopHLWhI/NYEWdeqwEIb59KVvTgv40g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM7PR04MB6870.eurprd04.prod.outlook.com (2603:10a6:20b:107::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Fri, 16 Jul
 2021 09:12:16 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 09:12:16 +0000
Subject: Re: [PATCH 00/27] btrfs: limited subpage compressed write support
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210713061516.163318-1-wqu@suse.com>
Message-ID: <e9d5c7b5-c078-850f-3441-1c0097eb73d3@suse.com>
Date:   Fri, 16 Jul 2021 17:11:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210713061516.163318-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0176.namprd05.prod.outlook.com
 (2603:10b6:a03:339::31) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0176.namprd05.prod.outlook.com (2603:10b6:a03:339::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend Transport; Fri, 16 Jul 2021 09:12:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85fb7db1-5dde-41ca-eabe-08d94839ce63
X-MS-TrafficTypeDiagnostic: AM7PR04MB6870:
X-Microsoft-Antispam-PRVS: <AM7PR04MB6870FD88F40185E1E75BCCA5D6119@AM7PR04MB6870.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5ugeZbtQDenvwUVONHDYTXA5X1iVeCbOqFWHZVdVBrWQGlYDPjtS+TvCHiW4UpId4zvgkYXg+5RXA5G44LN1uaIdtYA/SNzJ+S8MHEs5az3yrOaIp74oEtvpnrIBS9XJriH5egLjANPqUnehyyqEBATC551Uv+qesA8uFusqdf/BtiTheVc+BeQvZSljXiW+Af5tO8GwK09bwbq7qJnDAJh4vAW4y9WvoLwyUAtNi38O6Mjl8YSDEfrdSKv4rIHJiEVZNsQZPxQi3sJMdZY5Chl/EG1kXeZ6t08DPR74J2kagSl0zaa/uiPOzwDAzgGNB1CqHT4EWMGgyNZp/Eh9g5DP/Mh0H7zvlLTiY4xsL5lxzeUSGp5iM6m6n638t4SjSrOTuJ9LSQASx0AOy3XusqHVdZOEvd6plejwo7ytgofYDBliTQXA7Bwx08PgoOsIp5Jc88PDPKBGsJTbLzvhJFSz8qBoMsMu0SMMd2RwpEcLJF1g5x8bNplt8mkpILbSCiVdD4PWq1N9i86ag5YOLMN01Gay5Hcd5MU+G16BPrlguoENLHoSx8RvBMHsXic2IsNP8/yMyGJm5zsY5TT7EggsO4FIMD4FfYi9NSehFBtaYM5PPtfnxQU1zeLuvIgDi/+amUxcCqfNOhZ/0cJOc1Y2Z4wD+kHEcmcsbk6hPuzmf7rEB3HIcomclPJrDmjO1fbZa27lHehgmHARV8LaO3nfL0UinnaDSqzvMq10bo0qqWfna8FdO6cP3j8VAMef9ns935y+H0bH/c3w8GzldNgBXP1SPG50+9mZdNRQpvecZOcTo/69IGMn58UXJTGR+gvJQ2mFvgl/v2sDMM8xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39850400004)(376002)(136003)(396003)(366004)(31686004)(2906002)(26005)(38100700002)(66476007)(66556008)(66946007)(83380400001)(36756003)(6666004)(8936002)(31696002)(5660300002)(86362001)(186003)(8676002)(6706004)(6916009)(16576012)(316002)(6486002)(478600001)(966005)(2616005)(956004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UVGPPCNO0a7ufz9wsFPIXXnYW7EFG4+ioNQOdClDjVv6ikBFZUOMPAVcz0Z0?=
 =?us-ascii?Q?qfCP9dGR5eulEU9ol5a3YubASKBOthO+zzCMRprGyvK3ER/Tz9x+b/VBTVmu?=
 =?us-ascii?Q?zbgRqZH5VihKJu5RJfmQCmYfP+PrBtS7DREgXQXS+OhyKdxNFp83ZF/gf9qP?=
 =?us-ascii?Q?8X2YAPFuR7erJZ9lIFezTrIaEcvGxtTwFrnABXcXPA3207ttgE09MaxplcOr?=
 =?us-ascii?Q?91GF5N3TxAmzP80AQnEpfat1I8Dkh+TsF5bNn26IzYj3hn9HbWQ2tTmknoih?=
 =?us-ascii?Q?Wgu+nzVGW0oDFH9lt3v78sN5ewEmB8/qThNzftEqePDHk1+14pyTQNh0kb7k?=
 =?us-ascii?Q?kK2T7PDgWfUZDvXPvjVDFBUoYdF5sPHuz4N1TyL+Ot8mTjnmqo6KdfBrdDPD?=
 =?us-ascii?Q?qABM+rKD2rTTHx4GA9fBHd6iRR76IRg/hq1J3xRRO7cgef+rA9Fblar8q/pS?=
 =?us-ascii?Q?T3WkMb8RfVglnVmREj1wYx4vS1a8Jngw4ocLLu2gyDJOaEpZ4EtomKpgKWqT?=
 =?us-ascii?Q?oGf+3IO+gGXmd0VOHBxQg1XWQGXv8QlByUoKnUZFWc1mQXuPYD5ha8m/sNUo?=
 =?us-ascii?Q?FxteGyQdVifotRCkO87+GI4LKdAGHDOXhs7lZGXvrMZowVXG+BiQEucrL0w/?=
 =?us-ascii?Q?y33jlqjUHTH5N58+Soip1GcRAOUo2baFsngHuWMJfq4awG3V639v1/cBG0cW?=
 =?us-ascii?Q?6/Tuzp8fzxyNoAqYwkOZ+M/B2KE4NeK3FtDz2olQNyMmcI129gqIV1q2CF9/?=
 =?us-ascii?Q?nENBWdbGp8PUOOAEmUwy/QnHb2WGNfFe/ZnM7KANlA59bTH5TvA559us66a1?=
 =?us-ascii?Q?SmjJcuZpP4LqIgOkRo5q6EpAO8NRq0e3QDkD6yiNvA0A/NCVz+95nheE4rij?=
 =?us-ascii?Q?yRxkpDcrWCJLNTR1KJqIHbLCMUQwEO1YdIjcg2eL45mlBfSfh7ZhkMPeC0aM?=
 =?us-ascii?Q?00htIwjVBtC6RT/Cc0/fc/64B3Cu3Fi/8kb4FTGP678Y2tSib3q0gbZ2Iqbn?=
 =?us-ascii?Q?UedrAJo8sjHFoltPCjqdgw7M9nmOF41XP2HV8ijVTPtxOCBiiJWkLjtYyLTi?=
 =?us-ascii?Q?tO1Bi/LxtJBjeL7Ye3TqJM38tUQzlB3peLw4DyhtY/rEJcgTWx8zVYU/tP53?=
 =?us-ascii?Q?toSNWPHJO9NjlbetbvfCNhxwDWnyOWvGOhuioJcXf1u/v+HDet79eUvDU0yu?=
 =?us-ascii?Q?zzBMAYY1+D0xJ9ucMCEmBPrrXFXMNr+W/c9wcyRH7aCG2XToIxx47eIqilSQ?=
 =?us-ascii?Q?Cn6pEUWGkn7kuudT03ntVtuXs1yzfzjuq7ttZtbmPyHQefSLqL31tAiS9kYk?=
 =?us-ascii?Q?i6GdyAjtnd1J1FKkOr/SXp6a?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fb7db1-5dde-41ca-eabe-08d94839ce63
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 09:12:16.5871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeItA/8h4DvvcV0YDkwDEz1tUtYBFq5t/LGGf5JOzFhSVM6J4CRYBhdsouTQAnBS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6870
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/13 =E4=B8=8B=E5=8D=882:14, Qu Wenruo wrote:
> The patchset can be fetched from github:
> https://github.com/adam900710/linux/tree/compression
>=20
> The branch is based on the previously submitted subpage enablement
> patchset.
> The target merge window is v5.16 or v5.17.
>=20
> =3D=3D=3D What's working =3D=3D=3D
>=20
> Delalloc range which is fully page aligned can be compressed with
> 64K page size and 4K sector size (AKA, subpage).
>=20
> With current patchset, it can pass most "compress" test group, except
> btrfs/106, whose golden output is bound to 4K page size, thus test case
> needs to be updated.

It turns out that, btrfs/160 has a very high chance to crash due to=20
ordered extent tree inconsistency.
This is only exposed when running with "-o compress" mount option.

Will fix all the bugs exposed during full fstests run with "-o compress"=20
mount option.

Thanks,
Qu

>=20
> And as a basic requirement, 4K page size systems still pass the regular
> fstests runs.
>=20
> =3D=3D=3D What's not working =3D=3D=3D
> Delalloc range not fully page aligned will not go through compression.
>=20
> That's to say, the following inode will go through different write path:
>=20
> 	0	32K	64K	96K	128K
> 	|///////////////|	|///////|
> 			|		\- Will not be compressed
> 			|
> 			\- Will be compressed
>=20
> This will reduce the chance of compression obviously.
>=20
> But all involved patches will be the basis for later sector perfect
> compression support.
>=20
> The limitation is mostly introduced by two factors:
>=20
> - How we handle the locked page of a async cow delalloc range
>    Currently we unlock the first page unconditionally.
>    Even with the patchset, we still follows the behavior.
>=20
>    This means we can't have two async cow range shares the same
>    page.
>    This can be enhanced to use subpage::writers, but the next
>    problem will prevent us doing so.
>=20
> - No way to ensure an async cow range not to unlock the page while
>    we still have delalloc range in the page
>=20
>    This is caused by how we run delalloc range in a page.
>    For regular sectorsize, it's not a problem as we have at most one
>    sector for a page.
>=20
>    But for subpage case, we can have multiple sectors in one page.
>    If we submit an async cow, it may try to unlock the page while
>    we are still running the next delalloc range of the page.
>=20
>    The correct way here is to find and lock all delalloc range inside a
>    page, update the subpage::writers properly, then run each delalloc
>    range, so that the page won't be unlocked half way.
>=20
> =3D=3D=3D Patch structure =3D=3D=3D
>=20
> Patch 01~04:	Small and safe cleanups
> Patch 05:	Make compressed readahead to be subpage compatble
> Patch 06~14:	Optimize compressed read/write path to determine stripe
> 		boundary in a per-bio base
> Patch 15~16:	Extra code refactor/cleanup for compressed path
>=20
> Patch 17~26:	Make compressed write path to be subpage compatible
> Patch 27:	Enable limited subpage compressed write support
>=20
> Patch 01~16 may be a good candidate for early merge, as real heavy
> lifting part starts at patch 17.
>=20
> While patch 01~04 are really small and safe cleanups, which can be
> merged even earlier than subpage enablement patchset.
>=20
>=20
> Qu Wenruo (27):
>    btrfs: remove unused parameter @nr_pages in add_ra_bio_pages()
>    btrfs: remove unnecessary parameter @delalloc_start for
>      writepage_delalloc()
>    btrfs: use async_chunk::async_cow to replace the confusing pending
>      pointer
>    btrfs: don't pass compressed pages to
>      btrfs_writepage_endio_finish_ordered()
>    btrfs: make add_ra_bio_pages() to be subpage compatible
>    btrfs: introduce compressed_bio::pending_sectors to trace compressed
>      bio more elegantly
>    btrfs: add subpage checked_bitmap to make PageChecked flag to be
>      subpage compatible
>    btrfs: handle errors properly inside btrfs_submit_compressed_read()
>    btrfs: handle errors properly inside btrfs_submit_compressed_write()
>    btrfs: introduce submit_compressed_bio() for compression
>    btrfs: introduce alloc_compressed_bio() for compression
>    btrfs: make btrfs_submit_compressed_read() to determine stripe
>      boundary at bio allocation time
>    btrfs: make btrfs_submit_compressed_write() to determine stripe
>      boundary at bio allocation time
>    btrfs: remove unused function btrfs_bio_fits_in_stripe()
>    btrfs: refactor submit_compressed_extents()
>    btrfs: cleanup for extent_write_locked_range()
>    btrfs: make compress_file_range() to be subpage compatible
>    btrfs: make btrfs_submit_compressed_write() to be subpage compatible
>    btrfs: make end_compressed_bio_writeback() to be subpage compatble
>    btrfs: make extent_write_locked_range() to be subpage compatible
>    btrfs: extract uncompressed async extent submission code into a new
>      helper
>    btrfs: rework lzo_compress_pages() to make it subpage compatible
>    btrfs: teach __extent_writepage() to handle locked page differently
>    btrfs: allow page to be unlocked by btrfs_page_end_writer_lock() even
>      if it's locked by plain page_lock()
>    btrfs: allow subpage to compress a range which only covers one page
>    btrfs: don't run delalloc range which is beyond the locked_page to
>      prevent deadlock for subpage compression
>    btrfs: only allow subpage compression if the range is fully page
>      aligned
>=20
>   fs/btrfs/compression.c           | 678 ++++++++++++++++++-------------
>   fs/btrfs/compression.h           |   4 +-
>   fs/btrfs/ctree.h                 |   2 -
>   fs/btrfs/extent_io.c             | 123 ++++--
>   fs/btrfs/extent_io.h             |   3 +-
>   fs/btrfs/file.c                  |  20 +-
>   fs/btrfs/free-space-cache.c      |   6 +-
>   fs/btrfs/inode.c                 | 455 +++++++++++----------
>   fs/btrfs/lzo.c                   | 280 ++++++-------
>   fs/btrfs/reflink.c               |   2 +-
>   fs/btrfs/subpage.c               |  85 ++++
>   fs/btrfs/subpage.h               |  10 +
>   fs/btrfs/tests/extent-io-tests.c |  12 +-
>   13 files changed, 996 insertions(+), 684 deletions(-)
>=20


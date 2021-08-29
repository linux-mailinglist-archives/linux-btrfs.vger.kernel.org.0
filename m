Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7660F3FA96E
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 08:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhH2GRq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 02:17:46 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:53530 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229889AbhH2GRp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 02:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1630217812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a4pWENoriMP3z30oSWGehrJq1mCS1v9CgsYFdbJSUMw=;
        b=W/G5iVnULjvLkmWtqwlKqBIRUZLIpQb6CpK8LVBhKq64T7KgAxTrU21fMTha2Y7nkaQLDo
        BuMzWCStTyxxbbsmxcOTgxffcfuBbyb5eFzvdYz1tpFJeew36f5Pp7nUIIBU/LWVUu0h5G
        RO1uetu1bjQySegZnwUSH1Rrk/nfhtY=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2059.outbound.protection.outlook.com [104.47.4.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-14-XQkJ0gHBOce8KWrK_N36SQ-1; Sun, 29 Aug 2021 08:16:51 +0200
X-MC-Unique: XQkJ0gHBOce8KWrK_N36SQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daYQUSRT0K6wRdf8y1b9aBfFWfJEOoefm0w1j5iiXOCIwDWmahQ2wae3K6PIkaKSpSqCVfb2avyzmOsEMq0k8plWPiFxMxX6oZSB68cTOrTmUpE5ZWw5cPlN4ZFt7Z9QgdIeBv0kO3RgGgCcqqVRfwFcfSwtm4oSEYL4I1mOF5PZuC6VLQrPfgHcjnvXT9+ke10OG772zGQSJbzZu1he6lSKZk3gPy6QRoXikxpjpWniC2FJi/Wgk74qcUiKU8AdVMfwBzb/mmQm+ZpD8WQB1lEHCK//R0Dzv0jaPX7IeR+5FYpHrEOID3wTuktX7GasbBw699b/Fg/Es0nyCXSH5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1OfxdZKfbrkut7WyZpBTkKGd3hBXYmp2htgPUyfafQ=;
 b=RjXU3BojCQSSFIzzeYDnIK+ABlMkJxIxSrG3Giyb1W42zcrkRZv4QNWXP4V28P7FZhp8drsOWvKMmM1o/JcTs9BwkLRSk9gM6jI9HJhPtiRZRTlXfCB+kG5Uw5XBTpTtEkrRQCKucFrQtrjwn98hv9d7gBp9zx3qUkjxWHBQxj4vqFRHzlueCELVeC5mvdmFkH0O3lE7FmndQ4Uwkz+zBvN47JCVp9vqIoCLd3JLowI4W0YuQio/uTPzgtoUfqLzvfyQ3AKOVO3caWNwlzULP1cqkOtrewyY+Vfq9KrP28u57kr1d74XU881FxTSwbFGTfwafI1OCrIqmmbHUS3v8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4040.eurprd04.prod.outlook.com (2603:10a6:209:50::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Sun, 29 Aug
 2021 06:16:50 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%4]) with mapi id 15.20.4457.024; Sun, 29 Aug 2021
 06:16:50 +0000
Subject: Re: [PATCH v2 00/26] btrfs: limited subpage compressed write support
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210829052458.15454-1-wqu@suse.com>
Message-ID: <268292ab-d93b-7a86-b9c0-424c66669266@suse.com>
Date:   Sun, 29 Aug 2021 14:16:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210829052458.15454-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0173.namprd05.prod.outlook.com
 (2603:10b6:a03:339::28) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0173.namprd05.prod.outlook.com (2603:10b6:a03:339::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.10 via Frontend Transport; Sun, 29 Aug 2021 06:16:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b57df78d-3304-4f84-23c3-08d96ab49644
X-MS-TrafficTypeDiagnostic: AM6PR04MB4040:
X-Microsoft-Antispam-PRVS: <AM6PR04MB4040D2D8E92D11A8FE6E05A2D6CA9@AM6PR04MB4040.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyEG7DOBuKoxAaBGuzJz+MkuIs6qE3qg5GwlSco1fK18nNXF3FjgxOtiCc5mattEiYf8KNjcuvy1zLipI7eGKAC2RXl8NGyGRWh9hCQnHo+fB5neNogXCb3wH3mo+hUNEGGNtE0VOI63mYc8dlqe4kZLaE4ibDzCfbo7+ImxwxF+t5i4FgdQm98Kh4WpU+MZ3HvNnfhu2JZ/Pzrz8uXYdbH5fOItBVRsVsyOhZ6fFp0fnDgcAQgR8kl/blQUAUYsz8PGjkgjO4UxsaqO0tDiMWM+ywojOnDKIRH/VqkIzP96zLs7KGNMk/g8ilzU9WwDMqAJsOg1Z06i83jX637hUFTRSVMnVP+sk7PCavPATH02xYerjjZ+Tsyp6AHXJDKbr8Lz8BsxUVmR+yhMAjWf2l/DD3PFXYvw4rDejWf84aS6yyCGHf4UJT5uKawFAQAjm+wb9IwfJ63BlMtyltB+t7X0BLMJUXiia/mLFWZRzWdYnsVnPilUF6UCJuR3Di0FPwMrzPdjeFdEW1fnia06nRLkYifYPJL884PA5hLqtmGfFvH9usmcYY/ZpXqSJdo8quo+aayXywCRtup8SPJItSaPW6ifY/4ruSKG7xwO8YaPdHWMVIRLRin6xpLVVQ8ESMm4gW9oFbb8d4RyXrxEyNOrHVhiDoncGk4yIiFHOFw7za/ICSdFWjAj8krYnNe3sl42NsUkRoe9QbdO1R2IG2SrQjk4Tl1ESPeV7hpbd+Ut0eTaBVkdpefkm8o9vCFyQ3jwzZ8jOavqzSeA+N01mPuW61ddHg8S+5PTkMu0yvJ1FOv/LrQ7VOSW4Pbkt+up3j4WhmZ1zerm7Dc4zF5Gnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(366004)(136003)(376002)(8676002)(38100700002)(6486002)(6706004)(66476007)(36756003)(2906002)(8936002)(66556008)(478600001)(6916009)(956004)(66946007)(5660300002)(26005)(83380400001)(316002)(6666004)(16576012)(86362001)(31686004)(31696002)(186003)(966005)(2616005)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UhrBIEcukG3jB/F1SVSDRx0wqSNDKauqbv44BXId94Mh4npxQiuv4EmHzCMJ?=
 =?us-ascii?Q?/wse4qLJ0EAfghHtfDtBB6A55WYTW2wO14fXpRQVKB7lgTwfgADHtDudaV0E?=
 =?us-ascii?Q?QM/AfQiZ3Hp2R6iF9zaX9U9pV37H44IECjq52ELH+pud2Rp//4dADXrgZ5nb?=
 =?us-ascii?Q?/oLAHcNmgGF3EqTQvGc08P6eue9bkx1B9N3WvYZ1fhZL/hNaxnkFHNy0uvao?=
 =?us-ascii?Q?aTNSOH+/xkWuV7Y63XouahOPfUBiL9Krpp5oKIalU9q3+8GbKOxLPCAzIDPD?=
 =?us-ascii?Q?GH9VrPOIYfkNeQUJ5f46uj/XYLsgjsTBeppZrnQMEU/cWCfMa/Y/xp0KYenl?=
 =?us-ascii?Q?BHxQlqnZG3xrKzCxBcDL+YLDhchtz8j92w6+1AQ+UIx9PmvIeFfupM5RkUja?=
 =?us-ascii?Q?3/HtoMvAB+SQAfCPWf178njPIFLAYAuhbn+5Czwszw3NrkRIPfJbdwPKiV+h?=
 =?us-ascii?Q?ZfJPx/UM+ivFnWylKOeaiIDvF8QfR2dtITzF6v8ABlygJIJIle2tOMK68//c?=
 =?us-ascii?Q?Z4KWbcXnWNx1nnRXFJx4ZUVPUYHtwi4EApltxJDv4geVv3cxRuJDPk7Fkx5m?=
 =?us-ascii?Q?UrkENYA9XsaEVE5EiHIzuwaQjGReOIdWdMxah3AkAtpx6jVAJrkDBL8zR+Op?=
 =?us-ascii?Q?X7N7Vyo/uYx3yoQhS2IL+i9aoESFG5cfIqNArPtmVzlwKoMAutTBqxh5kqlo?=
 =?us-ascii?Q?GbuR4sk+JHiAHOZvt5bK1fagH2u6D55xioPeTDCrOksM2OJesT6iAqCnYLSX?=
 =?us-ascii?Q?P//oeBPyoIW5i4OzrHn/pFFhNkukGTDgPM5iR91HU0pORyL4yRBRYuN2qpeg?=
 =?us-ascii?Q?yyg6mjjGhLc6uQxG1T9Kn5viRcNkdBnnynNsFGhYbJpyMlrulivXeYY/v1CH?=
 =?us-ascii?Q?3fhsUKR45yFzWlc93IOIYLtJOcXIWb+5M+PsKPmuJOhE+choJ8P4JpKG7+Ii?=
 =?us-ascii?Q?P26goVpWKRVjG7k1drqJ7O1JnXVFc1vD2p8Gfu3h3qNBna1M1KknlrwW8Kt5?=
 =?us-ascii?Q?GeBFJ1bEu8ArUaT6ki3vE3MmSLo33Q8aYpFJb+ZPyPHqxbBYA5f9WwL1k4Kt?=
 =?us-ascii?Q?kQTVqlxhHFDpOQKnl0hi7dk+HTVPc3OCjeoSVeHvwt3Sn2CITC1xzcdTLljm?=
 =?us-ascii?Q?fSJAaO4cVbQjyLM1xjGg6co2YF9jRHeBBcJi0zB3F6M5Fe3QmSIZRB7HgVHn?=
 =?us-ascii?Q?I0VoZudkscVoiicjUSlUfk8yLOYpqb8W+UZkf4ACSRvKP/q5aNzYe1MAr0Nn?=
 =?us-ascii?Q?wk3lZwfEOaGYMfW5HU84j4CpAT2wk0xB/D8cmJY7FnnzgbsT/3KXvgqzML+h?=
 =?us-ascii?Q?pz1rfNMqqkX9IsBPXpckp0Rm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57df78d-3304-4f84-23c3-08d96ab49644
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2021 06:16:49.9153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5UMRvm9tKDCrAuMyD/Zy244O3VwTB5xYeJwXbBr0goFQch/QlrjnuiBT95moiGv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4040
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/29 =E4=B8=8B=E5=8D=881:24, Qu Wenruo wrote:
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
>=20
> And as a basic requirement, 4K page size systems still pass the regular
> fstests runs.
>=20
> =3D=3D=3D What's not working =3D=3D=3D
>=20
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
> Patch 17~25:	Make compressed write path to be subpage compatible
> Patch 26:	Enable limited subpage compressed write support
>=20
> Patch 01~16 may be a good candidate for early merge, as real heavy
> lifting part starts at patch 17.
>=20
> While patch 01~04 are really small and safe cleanups, which can be
> merged even earlier than subpage enablement patchset.
>=20
> While the patches 06~14 is quite some refactor, it may be needed for the
> read-only support for compression.
> As the read-time bio split is also a critical part for read-only
> compressed data support.
>=20
> I don't have any good idea to push those read path fixes to v5.15
> branches for now.
> Maybe I need to craft a hot-fix for read-write support.

Forgot the changelog:

v2:
- Rebased to latest misc-next
   Conflicts are caused by compact subpage bitmaps and refactored bool
   parameters for @uptodate.

   All tested on aarch64 machines.

Thanks,
Qu
>=20
> Qu Wenruo (26):
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
>    btrfs: add subpage checked bitmap to make PageChecked flag to be
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
>    btrfs: don't run delalloc range which is beyond the locked_page to
>      prevent deadlock for subpage compression
>    btrfs: only allow subpage compression if the range is fully page
>      aligned
>=20
>   fs/btrfs/compression.c           | 676 ++++++++++++++++++-------------
>   fs/btrfs/compression.h           |   4 +-
>   fs/btrfs/ctree.h                 |   2 -
>   fs/btrfs/extent_io.c             | 123 ++++--
>   fs/btrfs/extent_io.h             |   3 +-
>   fs/btrfs/file.c                  |  20 +-
>   fs/btrfs/free-space-cache.c      |   6 +-
>   fs/btrfs/inode.c                 | 452 +++++++++++----------
>   fs/btrfs/lzo.c                   | 280 ++++++-------
>   fs/btrfs/reflink.c               |   2 +-
>   fs/btrfs/subpage.c               | 102 ++++-
>   fs/btrfs/subpage.h               |   4 +
>   fs/btrfs/tests/extent-io-tests.c |  12 +-
>   13 files changed, 1002 insertions(+), 684 deletions(-)
>=20


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792CD3D5794
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhGZJvb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:51:31 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:39108 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231646AbhGZJva (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1627295518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VEYiOHabRKRp9pR47AhmWXJcGcJ72wwUQrykYa97KWo=;
        b=jfpCBZPklnWQ4EUZtahyCpHAo41KRip7N1Mq+n7jM8aLt3xRiv4l80tUIK2CVL131TWXVB
        botvj4q2A1kjN3aplTp/cUVlrVdiDxYwU5QW4tXPX2jGRl+6celTgMb0G0/8oz54RiN8Wh
        BYNQ7MBnHUdgN3kQ6TYehst6E1kNiZw=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2055.outbound.protection.outlook.com [104.47.6.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-29-NFHmbwuEMRKgIjRMUKpMwQ-1; Mon, 26 Jul 2021 12:31:56 +0200
X-MC-Unique: NFHmbwuEMRKgIjRMUKpMwQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtH9GhglcD9sBOJy+W32eAM6SGKI2y9wQQtURiv0XVB6SaolG/PhIDfMJpYGWEW9H3VIOIfHzMokUhRXHXy3p7UWJlV0Zvvt/fDWwqT1ez2szP0scK1rgMbAUzeOvXzNCCodKJMoev29mi6+BF8JIrPWYz/VFciT4kjEATXfcJhVysG3tB90QoX3CcBMmO0Rsavfgy0U0Dm8J+BBhe2fj8HCqY3YdEwN/xXc86TLoZsbsRZQFoOXCUmIbkNWENXcOWY8P0TZhgHQQopLjCpjCxj2h9oja3FI6YG8xYri1wZCGzHYjLIB5pnmSA4v4S1X81zCtsgWPO/yo5L4TWnkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IqFpRx2q+ouV0g03+h2vP7fGQUaCI3itPXaUenpREQ=;
 b=advxTiqLUgTj+aLGb/1PR5dmYCF3HNhTAPM9hoOAFdrzC+zOdejiP5qs3DnZ8Olwed7NSw5+zT6KD3uHofR9dmYgb3vWhFi2Wn+g9INn+CFuBPZpI8j/CMlpUqxWojk8CBwwVAtJGYaaGK0SKXxlYKTnXKRajmvlSTDmmxuRFzBk/TaqpEx0bz/3LH2xRtz2azyoHZ/MxGLW5pQnVEts5/ZgrT6R1sE5cO6HR8BxdJrAc/pDDKYZ2sUNNuneKBpHQz9I2lCd9rLRdgkWB2iaDi6Gvgo3FZbdbfKn8k/ZzTGqt2bN2TmQToRL+QqepX0bXk3cHnpflkgRbKgkfGWI4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB8038.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.31; Mon, 26 Jul
 2021 10:31:55 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 10:31:55 +0000
Subject: Re: [PATCH v8 00/18] btrfs: add data write support for subpage
To:     Neal Gompa <ngompa13@gmail.com>
CC:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210726063507.160396-1-wqu@suse.com>
 <CAEg-Je-AVYOAHhwmOSKxtwXXBnwFKStBBQhkNaWkw23goG5_5A@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <788878ac-164f-8c9c-dbb4-3283323c74e8@suse.com>
Date:   Mon, 26 Jul 2021 18:31:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CAEg-Je-AVYOAHhwmOSKxtwXXBnwFKStBBQhkNaWkw23goG5_5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR16CA0032.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::45) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR16CA0032.namprd16.prod.outlook.com (2603:10b6:a03:1a0::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 10:31:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d135664-def2-463e-7577-08d95020971b
X-MS-TrafficTypeDiagnostic: AS8PR04MB8038:
X-Microsoft-Antispam-PRVS: <AS8PR04MB8038DD8C334EF721B1FDF3F2D6E89@AS8PR04MB8038.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c3L8ebp2kojLJnQ4LCuQBnBl6pSG8PSb1Qi34XrQWcymYW3BxuuigKtNxkMRRRnZqcO3TXJdPRWOzTuXmdGHwJd0R2fzCC2+SrEb/CiYRItPgVGU2gmcw64h8W4MXP0rBNm3b1nYte33zz6UsTKXebWy2nSJSz916Rm2zyhEz1c1yw+utaVqNNMlVWADuSmLtkjBPpoPeiu02PeyOPLgmFvKEd4S4gR5r+1C97bLaSt0Txf5GP5uPSGmKquOyVbRAlr89MQ681hqvodOEFb+AkdszZSsrZQpyg9nFedkOR/8GtmKnSPfzo7DT7HUE4/uU67utncdd2UoZVeni9g9SNbeikXfZLa7QqtflmHREXoEt8nvvWnnnMM9DIuZle7TuSzo33Z8qjZ8Dxnee0hX63XouTvgMUhW9gHv/0HjpIKDq3VoPxZ4SM1GDNQ4FBvlTto2KJVZ+tFh9TjnDWa30XPhqua7PhOovaQwMxLAexk+6QwIeVBlJ/WAzErfS047fh3WWUpOq/dTcpxouu0VmsUyj1iTRdhdW8OblxL2sgK+Obd6Km+R8B/SRIP4Xobd5NNl3hygtapUnHD3TZJw94MMiZ2+Vu1Rekrt4TBnng+sdTpdYZPfRvrHWGtdfVsMfNPuvgFKZ3l0x03TkWd8ZzzoV8zAHzYEp+za5TDHH0PnF5eysjikA2pYcqVry5doMQZbZdPGjqp2YeQet0n33nTqhzB+aliHHb5bl0M5X5MTvknQbY+Q2yb2gtgzMKhlWtt7pvdsAO/kk7jdVhhQX27BYHo53FbvtB6EauurA37x6gbyYrt/CY51Pofrn61lb5DRlrSYcd5nzGmQ27eP/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(376002)(366004)(39850400004)(16576012)(966005)(6916009)(31686004)(5660300002)(8936002)(2616005)(956004)(8676002)(6706004)(66476007)(66946007)(66556008)(6666004)(4326008)(478600001)(53546011)(6486002)(316002)(38100700002)(186003)(86362001)(26005)(36756003)(31696002)(2906002)(83380400001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a1CIK07O/OMASaEibjymwr6UGWVGohOQOOc1ApVaMIpeRxRm0DPgqJQr6cHP?=
 =?us-ascii?Q?pIYDi63O6KukEnj6kMQu++WzCEwIp8QQPl0aTC93MWZT20AMDJ8Z8vANpNbZ?=
 =?us-ascii?Q?bobbBvvjW0AyZC7ge4TN8aImGRM9oyDAhy2JmpWyQQMYEychIdYZxqzTGs6P?=
 =?us-ascii?Q?Qkcz4E/FzqqfOEluoCLzOSZX3gjtNkuroWD5Rg1zoskwuBm+CbP4Hbni2wDN?=
 =?us-ascii?Q?zQ7l1WdOao/ZxO0MwHN2FH9clUOTOUhn6QP13S36EVWSJaE+K/kywOqLr6Lh?=
 =?us-ascii?Q?oEFvzU5ecEFPQgdTwt7+QQpm0WVIyW1lX5nEqT0y4n+hUOhIaU/jTfBj5hBz?=
 =?us-ascii?Q?oecNnwBahW0nCOKipAPr8O4AMRViI32+cIst+5HSwgPf3OHkd0eoIXuI6MsR?=
 =?us-ascii?Q?JW9kFrPoarzExEVZJHliR165szNGXuZSQVwU3BgO9bE96D4UTkhzxNQSysbj?=
 =?us-ascii?Q?UD9VpsOywE65lqxDXCIloBYZC2ghxk593HMLykRFNLm1y068zupWuCbRSjlp?=
 =?us-ascii?Q?FjMwSxDzOE0ELtMw7mgkYBYderPQVeFgT3vfglxk2tFWovZsyd0OXyWtNF1H?=
 =?us-ascii?Q?FiPmITUmRS8Ono3x1Hf6ImUNIOXyAAJ1osHuSHoStcIjZdEP44w4hMiYSTzo?=
 =?us-ascii?Q?59MjzkW7mItulbCl9zqlJ4XesiySV6Ypm2uRkG7N8HguYAg8miewWz4EVzaM?=
 =?us-ascii?Q?4mt+Zis7FJ36quWdGOA5VgMvVNE7x2tLaykOMbGA2MQmNPNuSzKYzpi2gvEs?=
 =?us-ascii?Q?7QPf2R2wP8CqCedOCpRm2dypw38kxQtowIaaQQVvwpVbEYY1oFdJw5VUGnhF?=
 =?us-ascii?Q?y7/oe8TYfcOoPFS4zbCoEsMRA0gwrT3UUYKOzJxRwaKfyDCJUYicyE7p1baK?=
 =?us-ascii?Q?foowWe+3oFCWMnuZFPrafpIeONq2BLYExGoehd2ND44R71amW107IzQty0XD?=
 =?us-ascii?Q?s4Km6D4B2p6DMFLbiR3XizY3oDt7supvKL232YDBhgpupiIksRPwnatBrcJn?=
 =?us-ascii?Q?k9ZzOhtRv+of9+z+JX7B+DHmEzTeqrEyWaGdimYg+QmblEpKLXg8OW298/ji?=
 =?us-ascii?Q?45rEYVTERxO7DMyMPSube/O3H4p0DaPPEpbySn4m7p9S8L6k8n47gkJVErev?=
 =?us-ascii?Q?q2AdO1sXjZQe1cW9f7aFg/1Sg6ZNeIq05YP2xl/CVWwUIUoIWW31deLpHjhC?=
 =?us-ascii?Q?W3ImK+h77L2k1XLwNHlqYXbyiYiYRo2NwrT3HNlVbej/rIAPPPtoSZcGsmJT?=
 =?us-ascii?Q?WlLH8Xacb4EsyEIKz137N6WKgDz8UjiKx7l3ku8XhqJrdSSHD8OBQj6kN9vU?=
 =?us-ascii?Q?+bFTXIWYUA4U+Nniq+GqM/g5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d135664-def2-463e-7577-08d95020971b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 10:31:55.4836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kARgpU5swu8mMAZYwDs/6LykZG+mQee5bPX1pS5/KznSy2BuauzM9fQm6oMHw2Nb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8038
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/26 =E4=B8=8B=E5=8D=886:08, Neal Gompa wrote:
> On Mon, Jul 26, 2021 at 2:36 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> This much smaller patchset can be fetched from github:
>> https://github.com/adam900710/linux/tree/subpage
>>
>> These patchset is targeted at v5.15 merge window.
>> There are 11 subpage enablment patches pending for a while, and not
>> touched, thus they should be pretty stable and safe.
>>
>> While there are 7 new patches, 4 of them are straightforward small
>> fixes, the remaining 2 are a little scary as they reworked the core code
>> of compression.
>> The final new patch is a special write path hotfix, aiming to make btrfs
>> subpage writeback more robust against tests like dm-dust.
>>
>> The rework should improve the readabilty thus make reviewing a
>> little easier (as least I hope so).
>>
>> =3D=3D=3D Current stage =3D=3D=3D
>> The tests on x86 pass without new failure, and generic test group on
>> arm64 with 64K page size passes except known failure and defrag group.
>>
>> For btrfs test group, all pass except compression/raid56/defrag.
>>
>> For anyone who is interested in testing, please use btrfs-progs v5.12 to
>> avoid false alert at mkfs time.
>>
>> =3D=3D=3D Limitation =3D=3D=3D
>> There are several limitations introduced just for subpage:
>> - No compressed write support
>>    Read is no problem, but compression write path has more things left t=
o
>>    be modified.
>>
>>    Already have a version passing all test groups with "-o compress"
>>    mount option.
>>    Will be addressed in later patchset.
>>
>=20
> If you already have this working, why not include it in the patch series?

This patchset is for v5.15 merge window, while the compression is only=20
targeted no later than v5.16.

Furthermore, that patchset is pretty big, 28 patches.

Combining them together would create a 46 patches set, no one will be=20
happy to do any review on that.

Thanks,
Qu
>=20
>> - No inline extent will be created
>>    This is mostly due to the fact that filemap_fdatawrite_range() will
>>    trigger more write than the range specified.
>>    In fallocate calls, this behavior can make us to writeback which can
>>    be inlined, before we enlarge the isize, causing inline extent being
>>    created along with regular extents.
>>
>>    In fact, even on x86_64, we can still have fsstress to create inodes
>>    with mixed inline and regular extents.
>>    Thus there is a much bigger problem to solve.
>>
>> - No support for RAID56
>>    There are still too many hardcoded PAGE_SIZE in raid56 code.
>>    Considering it's already considered unsafe due to its write-hole
>>    problem, disabling RAID56 for subpage looks sane to me.
>>
>> - No defrag support for subpage
>>    The support for subpage defrag has already an initial version
>>    submitted to the mail list.
>>    Thus the correct support won't be included in this patchset.
>>
>>    Currently I'm not pushing defrag patchset, as it's really not
>>    the priority, and still has rare bugs related to EXTENT_DELALLOC_NEW
>>    extent bit.
>>
>> =3D=3D=3D Patchset structure =3D=3D=3D
>> Patch 01~06:    Subpage fixes for compression read path
>> Patch 07~07:    Support for subpage relocation
>> Patch 09~16:    Subpage specific fixes and extra limitations
>> Patch 17:       Enable subpage support
>> Patch 18:       Subpage specific write path fix
>>
>> =3D=3D=3D Changelog =3D=3D=3D
>> v2:
>> - Rebased to latest misc-next
>>    Now metadata write patches are removed from the series, as they are
>>    already merged into misc-next.
>>
>> - Added new Reviewed-by/Tested-by/Reported-by tags
>>
>> - Use separate endio functions to subpage metadata write path
>>
>> - Re-order the patches, to make refactors at the top of the series
>>    One refactor, the submit_extent_page() one, should benefit 4K page
>>    size more than 64K page size, thus it's worthy to be merged early
>>
>> - New bug fixes exposed by Ritesh Harjani on Power
>>
>> - Reject RAID56 completely
>>    Exposed by btrfs test group, which caused BUG_ON() for various sites.
>>    Considering RAID56 is already not considered safe, it's better to
>>    reject them completely for now.
>>
>> - Fix subpage scrub repair failure
>>    Caused by hardcoded PAGE_SIZE
>>
>> - Fix free space cache inode size
>>    Same cause as scrub repair failure
>>
>> v3:
>> - Rebased to remove write path prepration patches
>>
>> - Properly enable btrfs defrag
>>    Previsouly, btrfs defrag is in fact just disabled.
>>    This makes tons of tests in btrfs/defrag to fail.
>>
>> - More bug fixes for rare race/crashes
>>    * Fix relocation false alert on csum mismatch
>>    * Fix relocation data corruption
>>    * Fix a rare case of false ASSERT()
>>      The fix already get merged into the prepration patches, thus no
>>      longer in this patchset though.
>>
>>    Mostly reported by Ritesh from IBM.
>>
>> v4:
>> - Disable subpage defrag completely
>>    As full page defrag can race with fsstress in btrfs/062, causing
>>    strange ordered extent bugs.
>>    The full subpage defrag will be submitted as an indepdent patchset.
>>
>> v5:
>> - Rebased to latest misc-next branch
>>
>> v6:
>> - Rebased to latest misc-next branch
>>    The 11 existing patches have no conflicts at all.
>>
>> - Added four patches related to compression read path
>>    This involves:
>>    * One small fix for extent map grabbing
>>    * One preparation to remove GFP_HIGHMEM
>>      kmap()/kunmap() is not removed yet, as it's only for later
>>      subpage related decompression path rework.
>>    * Rework btrfs_decompress_buf2page() and lzo_decompress_bio()
>>      btrfs_decompress_buf2page() handles the copying of decompressed dat=
a
>>      to inode pages, without proper subpage handling, we can copy
>>      decompressed data to wrong location
>>      lzo_decompress_bio() needs a sectorsize related fix to handle
>>      padding zeros.
>>      Since we're here, I just reworked the code to make more rooms for
>>      proper comments.
>>
>>      These two rework looks scary, and touches the core functions of
>>      compression, thus Josef gave me extra tests runs on them and no
>>      regression found.
>>
>>      But still they definitely deserve more review.
>>
>> v7:
>> - Rebased to latest misc-next branch
>>    With HIGHMEM cleanup already in misc-next, one patch can be dropped.
>>
>>    With extra Reviewed-by: tags and fixes.
>>
>> - Added 3 more fixes for subpage compression read path:
>>    * Sticky @this_bio_flag
>>      Preivoulys in btrfs_do_readpage() @this_bio_flag is only used once
>>      as one page only contains one sector.
>>      But for subpage case, we need to reset this flag, or after reading
>>      one compressed extent, next uncompressed extent will be treated as
>>      compressed and causing problems.
>>
>>    * NULL pointer fix for csum verification for compressed extent
>>      For compressed extent, we rely on PageChecked to skip csum
>>      verification for compressed read.
>>      But that flag only works for full page, no subpage helper yet.
>>      Thankfully we can easily skip compressed read as it never populate
>>      io_bio::csum.
>>
>>    * Disable readahead for compressed read
>>      It will be properly enabled in write path, since for 64K page size,
>>      we at most readahead two pages, the readahead is way less effective=
,
>>      and we can afford to skip the readahead completely for subpage case=
.
>>
>> v8:
>> - Rebased to latest misc-next branch
>>    No conflicts
>>
>> - Add a new hotfix to make __extent_writepage() to ignore IO error
>>    To enhance the error handling for subpage write path.
>>    As subpage adds new cases to trigger the error branch while IO errors
>>    are already handled by bio, no need to error out early and trigger
>>    another existing (but harder to fix) bug in write path.
>>
>> Qu Wenruo (18):
>>    btrfs: properly reset @this_bio_flag in btrfs_do_readpage() to avoid
>>      inheriting old bio flags to next extent
>>    btrfs: fix NULL pointer dereference when reading two compressed exten=
t
>>      inside the same page
>>    btrfs: disable compressed readahead for subpage
>>    btrfs: grab correct extent map for subpage compressed extent read
>>    btrfs: rework btrfs_decompress_buf2page()
>>    btrfs: rework lzo_decompress_bio() to make it subpage compatible
>>    btrfs: extract relocation page read and dirty part into its own
>>      function
>>    btrfs: make relocate_one_page() to handle subpage case
>>    btrfs: fix wild subpage writeback which does not have ordered extent.
>>    btrfs: disable inline extent creation for subpage
>>    btrfs: allow submit_extent_page() to do bio split for subpage
>>    btrfs: reject raid5/6 fs for subpage
>>    btrfs: fix a crash caused by race between prepare_pages() and
>>      btrfs_releasepage()
>>    btrfs: fix a use-after-free bug in writeback subpage helper
>>    btrfs: fix a subpage false alert for relocating partial preallocated
>>      data extents
>>    btrfs: fix a subpage relocation data corruption
>>    btrfs: allow read-write for 4K sectorsize on 64K page size systems
>>    btrfs: unify the error paths in __extent_writepage() for subpage and
>>      regular sectorsize
>>
>>   fs/btrfs/compression.c | 160 +++++++++++----------
>>   fs/btrfs/compression.h |   5 +-
>>   fs/btrfs/disk-io.c     |  13 +-
>>   fs/btrfs/extent_io.c   | 262 ++++++++++++++++++++++++++---------
>>   fs/btrfs/file.c        |  13 +-
>>   fs/btrfs/inode.c       |  92 ++++++++++--
>>   fs/btrfs/ioctl.c       |   6 +
>>   fs/btrfs/lzo.c         | 196 ++++++++++++--------------
>>   fs/btrfs/relocation.c  | 308 +++++++++++++++++++++++++++--------------
>>   fs/btrfs/subpage.c     |  20 ++-
>>   fs/btrfs/subpage.h     |   7 +
>>   fs/btrfs/super.c       |   7 -
>>   fs/btrfs/sysfs.c       |   5 +
>>   fs/btrfs/volumes.c     |   7 +
>>   fs/btrfs/zlib.c        |  12 +-
>>   fs/btrfs/zstd.c        |   6 +-
>>   16 files changed, 720 insertions(+), 399 deletions(-)
>>
>> --
>> 2.32.0
>>
>=20
>=20


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB64265DC1
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Sep 2020 12:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgIKKYi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Sep 2020 06:24:38 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:55224 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbgIKKYT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Sep 2020 06:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1599819856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=KLn39jl+vIqJet/n9LryG1PCZ0drbUx3/p+Qn7tUV/Y=;
        b=Wbx6ENaSvu4Di23WHjb+rn+IWfqDWTfaH/RnRE+xXSbapsyPH/Mu4MkRsHZGqZqNa2dts0
        d6RWhw39t6JmGq6oTE2WAKXdqjdKQApcgCser8Vt8ZYGenzoD/k/DKEnVWD01/5CdS1yF5
        zNxfsXs8vKhjrOfUiI/Q3NZVyu64T9c=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2059.outbound.protection.outlook.com [104.47.8.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-11-Ugl0P_u0NFesT1y-niZ4kA-1; Fri, 11 Sep 2020 12:24:14 +0200
X-MC-Unique: Ugl0P_u0NFesT1y-niZ4kA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mORWtehgRZ50pWAFJMZnw4153YmFc5mUpw2bpNEjvzlKMluYYOYUhcw66N3yf0+C1w+C5mHgWFi0nfLZf4vT/hF7Xd5zfTAQgNLWyxDbXL0CGKspyUfA5YPdm5DCf/lKud81rwxnidJVlwwp1V1BpkfZb2tK/NvIA+btgisIqEO6lTs1h6Q3uisYsaMitiltVviKMZkQR72thmZ/1M8WZWhcaMXkf3eZSHuwDFj3+FCSP+jM4NOcRqqZzt2EZh/ABegb0oFn4HozzbA27ecoxteI78whuqgmdrrJ7u2qVAWlu9JP5VdKlGtDWFFHisGYrQxkZNp5Zl9ymhQ5aihqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlHEaBUO8vC75JlChQxUwh12VXbRhrK+hjBVNAFLIAY=;
 b=m6ouWqwknwH7MbN0tEJzJ5RbhUoV5g1i+5hADKRoRD37PqGvMMWLjrGt3J/G3Va66VMxbG/rHUw/IcUMIUIftH2PkAkVbbA2Qz6HByI2QAbQhL7EfFXj6xQQ/CzwjXHRuo0xBWI3vhLNNprB0B0jA84QQQBTqUorXWo1J7m9MRUrv+ySVgE4HzmTThhP3kpd0HgHhljby8GsoYxGYXF/EDtjsJFQusVDmI/qiKWso/oQW9tHUhmWYX6yaXCNfBxJ8k1xtMr/Ev09P8XjGlfRaHiVwZcf/y6WIK1b7tbMhmlpDVcrPBp3Qa3+jgnyTh0PzGgds42MmQp9w4uGbWYyww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 10:24:14 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 10:24:14 +0000
Subject: Re: [PATCH 00/17] btrfs: add read-only support for subpage sector
 size
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20200908075230.86856-1-wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <41181cb3-8168-1dea-a414-58d879965a23@suse.com>
Date:   Fri, 11 Sep 2020 18:24:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200908075230.86856-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::18) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0077.namprd05.prod.outlook.com (2603:10b6:a03:e0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend Transport; Fri, 11 Sep 2020 10:24:12 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed89482a-5721-49c8-b664-08d8563cd4b2
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:
X-Microsoft-Antispam-PRVS: <AM0PR04MB70449C35936FD7E86AEF081CD6240@AM0PR04MB7044.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xbr2X4AnrO77k6zS4ygK3hNgjm+vX6T7MdxK9fi0MAfuTOKaKfPpzTtyVghYyoSYSikQ120bNZ1n0vkdweyO4o/Kv0H0wE2/1rUAsQWHUQgyxbEV698pMgvC/Qzeydc5ytzSabQlQmt1WUG8U2yyJNDvbE2J2m0Vpp1E6fWQuFHL3bYUTEvP1UirQGyJOhSU3px8cwCUwXmX5cScpm/8Ah/sOcJ5itMgSZAfwTCD0UvYyDiYLydl3DtY7MpmCO/gN1gXML9jYJ4MD57yEDNSoREBC0atl00UTC8l3BYN59nnumovbQ5tVu5qf97fCzrr8pO1QkLCtEbzK2EpTywXCcBadRJi/SZgsm1kcWcZjyQfb5A+l4hUpKXsSB6UfMYCoWhqdyGc8od24v4AuDdxI3NAzqMse1XizUOEaj6oxG/5ItT9NoU9BATaOiq+egN/4kxt3jp2x4bTumT1ZfNIk98a7PnaNHXLkvP7/jSfjhg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(39860400002)(346002)(396003)(8676002)(31686004)(6666004)(478600001)(66556008)(186003)(83380400001)(16526019)(2906002)(26005)(966005)(52116002)(66476007)(16576012)(6916009)(31696002)(66946007)(36756003)(2616005)(316002)(5660300002)(8936002)(6706004)(86362001)(956004)(6486002)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ApHrrxj8X7WhjIHb0lW/BCoBIqSiY88gTBbZRoM6quIHTC13WqyFQNdxUmk9KzzTODJIztcxc+hKV5+f5MNzfdUwJrTcAAD+/fNmqN9cLIQCwohM0g/q3iUN8HVZ3T97O/qKo9aUTUfy5Dih/xLuX5vSfthCg5fgwUX02JZzdlTF5rjZN1lw+9yQTbMFWa/MvYEWGa1cGwy8t0IKhpAuwdf8Y+kWd0DKW2yXa/0UPx+Wy3NILt1i2Z/BgDH6wPB8ogaXXXU714lR0ZO8vemYdzggFeIe50FHReHbIzCBSpVWhezM3hsE6Q13fFmNtfgw29b0pcFv5Yz++YQ9mTuI6h63j4+SceYZqJgIxs78JZMwHwvcKLMt0ijpDcx8zv2sRD7abKbGsZnCvEe5Jkq0vA2pbExC8D0QAx5y18EUpoLIOQJthjTsdrIrsCIsF6oxXmygu54GuA3Z+V3XKZMKTF7OxDulJUXRucaae0QHtZxaj+gBDNDzzHOgK7DSbu88E+997KlzSIzzUNdt846WNqVfnQAFyamCW5oU45Pi+wW0XoJJG1c00cewxKRo9tHr2PDnrDkKkhGSmKI0zqeA+8p/NX4ciFAZpuXi/xX5bZdc66Fjf6PX5fuydmYA2WUKIIGDxrOkTRibgmDALj5avA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed89482a-5721-49c8-b664-08d8563cd4b2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 10:24:14.1272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlSbYvAGpvZTKFg3StoOsyCnxCcWkqmpb3kA3VXPytK+9WmKR2Y6BtiMujlCI8CS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7044
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/8 =E4=B8=8B=E5=8D=883:52, Qu Wenruo wrote:
> Patches can be fetched from github:
> https://github.com/adam900710/linux/tree/subpage
>=20
> Currently btrfs only allows to mount fs with sectorsize =3D=3D PAGE_SIZE.
>=20
> That means, for 64K page size system, they can only use 64K sector size
> fs.
> This brings a big compatible problem for btrfs.
>=20
> This patch is going to slightly solve the problem by, allowing 64K
> system to mount 4K sectorsize fs in read-only mode.
>=20
> The main objective here, is to remove the blockage in the code base, and
> pave the road to full RW mount support.
>=20
> =3D=3D What works =3D=3D
>=20
> Existing regular page sized sector size support
> Subpage read-only Mount (with all self tests and ASSERT)
> Subpage metadata read (including all trees and inline extents, and csum c=
hecking)
> Subpage uncompressed data read (with csum checking)
>=20
> =3D=3D What doesn't work =3D=3D
>=20
> Read-write mount (see the subject)
> Compressed data read
>=20
> =3D=3D Challenge we meet =3D=3D
>=20
> The main problem is metadata, where we have several limitations:
> - We always read the full page of a metadata
>   In subpage case, one full page can contain several tree blocks.
>=20
> - We use page::private to point to extent buffer
>   This means we currently can only support one-page-to-one-extent-buffer
>   mapping.
>   For subpage size support, we need one-page-to-multiple-extent-buffer
>   mapping.
>=20
>=20
> =3D=3D Solutions =3D=3D
>=20
> So here for the metadata part, we use the following methods to
> workaround the problem:
>=20
> - Introduce subpage_eb_mapping structure to do bitmap
>   Now for subpage, page::private points to a subpage_eb_mapping
>   structure, which has a bitmap to mapping one page to multiple extent
>   buffers.
>=20
> - Still do full page read for metadata
>   This means, at read time, we're not reading just one extent buffer,
>   but possibly many more.
>   In that case, we first do tree block verification for the tree blocks
>   triggering the read, and mark the page uptodate.
>=20
>   For newly incoming tree block read, they will check if the tree block
>   is verified. If not verified, even if the page is uptodate, we still
>   need to check the extent buffer.
>=20
>   By this all subpage extent buffers are verified properly.
>=20
> For data part, it's pretty simple, all existing infrastructure can be
> easily converted to support subpage read, without any subpage specific
> handing yet.
>=20
> =3D=3D Patchset structure =3D=3D
>=20
> The structure of the patchset:
> Patch 01~11: Preparation patches for metadata subpage read support.
>              These patches can be merged without problem, and work for
>              both regular and subpage case.
> Patch 12~14: Patches for data subpage read support.
>              These patches works for both cases.
>=20
> That means, patch 01~14 can be applied to current kernel, and shouldn't
> affect any existing behavior.
>=20
> Patch 15~17: Subpage metadata read specific patches.
>              These patches introduces the main part of the subpage
>              metadata read support.

For the last 3 patches, it turns out that, we may get rid of
page::private pointer completely, and greatly simplify the bits handling
by relying on extent_io_tree.

So if possible, please ignore these last 3 patches for now. They would
be the backup solution if the extent_io_tree idea doesn't go well.

Thanks,
Qu
>=20
> The number of patches is the main reason I'm submitting them to the mail
> list. As there are too many preparation patches already.
>=20
> Qu Wenruo (17):
>   btrfs: extent-io-tests: remove invalid tests
>   btrfs: calculate inline extent buffer page size based on page size
>   btrfs: remove the open-code to read disk-key
>   btrfs: make btrfs_fs_info::buffer_radix to take sector size devided
>     values
>   btrfs: don't allow tree block to cross page boundary for subpage
>     support
>   btrfs: handle sectorsize < PAGE_SIZE case for extent buffer accessors
>   btrfs: make csum_tree_block() handle sectorsize smaller than page size
>   btrfs: refactor how we extract extent buffer from page for
>     alloc_extent_buffer()
>   btrfs: refactor btrfs_release_extent_buffer_pages()
>   btrfs: add assert_spin_locked() for attach_extent_buffer_page()
>   btrfs: extract the extent buffer verification from
>     btree_readpage_end_io_hook()
>   btrfs: remove the unnecessary parameter @start and @len for
>     check_data_csum()
>   btrfs: extent_io: only require sector size alignment for page read
>   btrfs: make btrfs_readpage_end_io_hook() follow sector size
>   btrfs: introduce subpage_eb_mapping for extent buffers
>   btrfs: handle extent buffer verification proper for subpage size
>   btrfs: allow RO mount of 4K sector size fs on 64K page system
>=20
>  fs/btrfs/ctree.c                 |  13 +-
>  fs/btrfs/ctree.h                 |  38 ++-
>  fs/btrfs/disk-io.c               | 111 ++++---
>  fs/btrfs/disk-io.h               |   1 +
>  fs/btrfs/extent_io.c             | 538 +++++++++++++++++++++++++------
>  fs/btrfs/extent_io.h             |  19 +-
>  fs/btrfs/inode.c                 |  40 ++-
>  fs/btrfs/struct-funcs.c          |  18 +-
>  fs/btrfs/super.c                 |   7 +
>  fs/btrfs/tests/extent-io-tests.c |  26 +-
>  10 files changed, 633 insertions(+), 178 deletions(-)
>=20


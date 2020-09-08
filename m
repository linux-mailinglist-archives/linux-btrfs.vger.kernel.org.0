Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9938260CF1
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 10:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgIHIEa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 04:04:30 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:53250 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729721AbgIHIEC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Sep 2020 04:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1599552234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=IamS5hiiI1tkw7ZSO3dnyN20fDkN6N3w0Gjs94exZ3I=;
        b=AXLN+6IwPZeTMnQ2BcdXahNT4LX6ww3Z+2xRGSzIHVkGWhjtBTRUS7Pc/Jf04jfB76q020
        joN4eKPclEYk3I5u/xPWjffILj8X4KmjWZt3eX8fxaRsVvS+11VCsh97UqMOrvyTXChQld
        eDNPE5lL81y9p8CUfSDqYO8tS6yOzJs=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2059.outbound.protection.outlook.com [104.47.0.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-27-RRwr_kQKPUqhaNEgDR2n3w-1; Tue, 08 Sep 2020 10:03:53 +0200
X-MC-Unique: RRwr_kQKPUqhaNEgDR2n3w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jc5xgMF6uL7oxG2XpeFiUwqJaLTErYzmJPMlE4SRlfR2CRRY2P262RRVC4tx+hBcJAEL8Qh5lmd0CeG69KjvHPpUUzzInaPE5HUnlzhgY4Vm7c8loWE6Ln0CMfOE11nREWHHfLwgCNB0rlZSg8sxzqAaQAPWADLcjrk/vuF1M0czErYst8pheriCrvyHzGn5T4M5npjFR7qq8XPBtWGBmu2GDNsLJlsJ8dA4nOCsZOUxcPaZtv7y0QvjJ5QoPiUZ63A292T7BcnDBWqHw7YiWlj97IMUK62GveKcG7WxtFpNlR/9u1mVhxE3B8+OnLB49CXHG+NeXSNpv3Jh1EWwVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzQIRLusFn4On5+0g4qFiHWcvU1m6JZc7acWLV5342U=;
 b=W5hal5y0slpaVdS55Dm1Q9tgGq6vkyAdukdnsJb94zuMCWq7zwlqrnbOz4GqS4j2mChtLFBznIhjalr+xltmV/LpxKyzIzDUWrSKRDBz/+VCQymbnt4x8rXzvM8hSwYGmIqGFBcQ3yQhALkCcbORLLltwCbzkh43NxKdZU+Tv39VzFpYDlTSWzTutKZI05jbFuaEyAeVNb2exRAexeA3AKJZRAD6kFerhq/b1wJWxrph6CRtX5KId5NDOkrbLq7vy8pudPBJAPgc1ypiS3RDOpBO3fjF6Oq/FW9+/0xT7yemeIVsXjHUGt8E0ttfmwkbbhkQVicen/UH1zs/57o1Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM4PR0401MB2274.eurprd04.prod.outlook.com (2603:10a6:200:50::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 08:03:51 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 08:03:51 +0000
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
Message-ID: <cb45023c-a2e3-d9c0-22cd-113f77b840f3@suse.com>
Date:   Tue, 8 Sep 2020 16:03:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200908075230.86856-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:217::16) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY3PR04CA0011.namprd04.prod.outlook.com (2603:10b6:a03:217::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Tue, 8 Sep 2020 08:03:50 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f17810e-ae1d-44f3-de65-08d853cdb921
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2274:
X-Microsoft-Antispam-PRVS: <AM4PR0401MB22748B6F3D5C24F1F6D77205D6290@AM4PR0401MB2274.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUZGVXf6oknQ4kDFu8E/LriDKXzOHWkTaTT3RY9TJUS3fwpHl/0lHn+MU+YIPd1lFgUvHfT5QwMy6c/ECLhIEEcjNKG0p/3Mn1qawcDtS+t5a5dj+OKHZKy9FG6hDy5zyb8YK6Yv0lj8lN9UUim9J9YPLNgnW4Ze49n4CQhg6NyeciRTX1ywyDzziyLGjQyGWQv9q8c/9sEovlzRtUKbHew8rV+u/fLHlJk72Sdrf9nJW353We13IuojZHINjAKlnGYQf/jysRDzoQYAKxdpMOLLPfcG/E8OS5XvbDv2WQ7usiY9dCkRjaRFX5ZXV4EAiFuFY3KsUpKJO96QI3afVqNpcv/gSjrKQ6ZxlRheYDOWG7NyYssODE4cy3v6LoQ0QnSanUbYIheJcUzAxoEp5NL4SRhv0oC7CTKKqFXiRlXZfzTAmTUEKmVwbWQNTWt1T/zIDecYWUOzKfBPFiu8N5Ij9F+Z7Gbb6Bd7m23RIgU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(366004)(346002)(396003)(478600001)(8936002)(5660300002)(66476007)(36756003)(66946007)(66556008)(86362001)(6666004)(316002)(31696002)(8676002)(52116002)(966005)(6486002)(16576012)(6706004)(6916009)(16526019)(31686004)(26005)(956004)(2906002)(83380400001)(186003)(2616005)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5FWz8OUk6uffYXyDzL+A/nR/Fy4l30q4VWXTjEFg6MF2Dp4lKsN/+jVK4bmWm4XDCrpxMzr0veA2E+E6JzexAAq/eLcOi7nfpnj13+wRAw8OPDlKdTJHRxmEzmF8iPIsVqQsUbYrlvX6MdRjW0QaqEe9ENxyGNyQ9Ij/Pij6QNVG+6fr+fhP4HEODOu28L2VibHRUK5VyT6dSargMRChmtnLMUPiLH+BlqXspZMbERv/glCPp3/eHJTBXSR3VqYJOSC+vtRAeYmcrAPmcXFwUd2g7aqNEfXap338hc3kQlbEsJsMbK5acB0rqige11fxv9oSXT6Kxg7xMNwTzjLNCjbW8axNcy3dATGOfHGAXriWkuyf7BZEgdXrgmzS7L5s4F5jZfPxl7UGXA2CYFt974NDeHgz/ZDr8A6ThQeF4jMPEgLr+ZfFNFMjWqZ8FypQo0X5iHH9ytRm0tfUT/fNgLH5S2FXgLhJNuU+Nm3kJ4IrSZD3fv49lro/W1wF3MX8ZNpL9yh/0XmLShgNkS33L0gFmo9w1fgBFm2OH1I36xX/eg3cdac3OY//Ok9vWbzEUo46gEDNgDAA0WKqYAGqnLHR5Hzo8SiSnt1KFuhXjEVJnS5z3iDkp/Dw8vW8sma0qzvcu2Zm3eAoH8xWki2tUQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f17810e-ae1d-44f3-de65-08d853cdb921
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 08:03:51.4039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AnjcxLtyBh0pPi34JCI+vdi3TLZR/hi1kbTvi1vMzIRLmT3PkAkrVWgWJb86PhE+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2274
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

This is pretty different from what Chanda submitted several years ago.

Chanda chooses to base its work on Josef's attempt to kill btree_inode
and use kmalloc memory for tree blocks.
That idea is in fact pretty awesome, it solves a lot of problem and
makes btree read/write way easier.

The problem is, that attempt to kill btree_inode is exposing a big
behavior change, which brings a lot of uncertainty to the following
development.

While this patchset choose to use the existing btree_inode mechanism to
make it easier to be merged.

Personally speaking, I still like the idea of btree_inode kill.
If we could get an agreement on the direction we take, it would be much
better for the future.

Thanks,
Qu
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


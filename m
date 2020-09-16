Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B65626B970
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 03:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgIPBgC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 21:36:02 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:38842 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726166AbgIPBgB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 21:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1600220156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=GjHc26vjUQpSvJcD9BqamFF+L5aVE05irxdCQ1SLALA=;
        b=XrT+u6HXDH5I2TFSzeZoD9d8en0Sq3QQKIknP6NyKPZPutI48NDpVWQfZ9gKZERmZeMEYM
        sI16+/aadyi+zhxl7NcK0M5u2uVZakI/O5V6B/aF0449Oa0CpdOvxHMl+OaFaS0sESWRqd
        y3IgeqftFAgHiWq4hDGWRmJyfZ2rfUM=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-14-Y4e5ZfWTNvCfyfqzDGjOQg-1; Wed, 16 Sep 2020 03:35:55 +0200
X-MC-Unique: Y4e5ZfWTNvCfyfqzDGjOQg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGA5k/svtWH8sX+c3/C/NcocGzCylvuVrTA/SOQzfSQk9RYjjWua1wrAVvnUTk03ac3rXbbvbCEOJPH+4Gv/B3DzaJL4zD5oUUdGRBnJ/EN8hz72TMZfY2WiVtGREsVGt7b8E0LKkQBxCslmvj3yJixwYa5qex5lvJScOZbaVVvMfQGF0tDen6XhCl5oUJHVOAcUQry3yHWtRQyp0PmyNtL40xcDq3QWtxQju0c35J8rN0n7eKy3I/J2Lji4BbYFSiKajg/2D0i5aNYV4ZxA7Yilm9TC9FQn8Amlao9bWnIqYPzPA8PWh8VjHrGw0jDV4DtFPjhWuNn7LnaPSnwbkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjHc26vjUQpSvJcD9BqamFF+L5aVE05irxdCQ1SLALA=;
 b=HnEAQkzjgY3Ngo7cmSXIan4BtNafcqN1e7RG6I8sZybC5Yza9qnIsjdbJ3C8gQWRxUuGYYMO4ktm2AsqgB4tA54JfW9U6eYweRLxmrgTJ18o6qFttq3snGPtZwxWB75NsnZe4Rv+GZIKv5iaUgqwm/IiikUiC9/R0viS1bkCxjNn9RMnZKPpknWjjaah8cVz1fJf0eW1wkxqb1KyMIHd6oNpQMiS0tVUv3CetXEggmfgHuWg14vEG3A6ru8Mu74H8QPoZMXwDukxXiJkehzfx6UJfO0Btzh7wgqRFccBjyixnZTL/MDQrRFILt/ZC6r7liamjoUbFhBuhzO35c1Yzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM8PR04MB7235.eurprd04.prod.outlook.com (2603:10a6:20b:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 16 Sep
 2020 01:35:54 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 01:35:53 +0000
Subject: Re: [PATCH v2 00/19] btrfs: add read-only support for subpage sector
 size
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20200915053532.63279-1-wqu@suse.com>
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
Message-ID: <12ecf2f9-c262-8b00-2165-486684ba2fef@suse.com>
Date:   Wed, 16 Sep 2020 09:35:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200915053532.63279-1-wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="A8qr5xnb70D6AFypRjuoIbmI8M0w2zarx"
X-ClientProxiedBy: BY5PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::27) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR17CA0014.namprd17.prod.outlook.com (2603:10b6:a03:1b8::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Wed, 16 Sep 2020 01:35:52 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 563f9bad-c51e-4aeb-aab3-08d859e0d9cc
X-MS-TrafficTypeDiagnostic: AM8PR04MB7235:
X-Microsoft-Antispam-PRVS: <AM8PR04MB7235DF7C3F0C793F87614AB3D6210@AM8PR04MB7235.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxd8+3r9YXWVZtSMg7ECJmM8uHj24k84jYsO8KUHlwu3KkS6nA30yNWCHZdmViE93wMj3MJsZV9JTNyZu+xlsNODyHcy0rUn8F2F4/1r9KAuco4IArVPmzaGkbwBC+z2NaCSR9CgnTL8Qry+GzEQy7/JJ2N3r5dquiRtXw9sPR0FGme//ujmWvLTear6TuMf17Z3V1DmW+j4JvHQDELgfB7/nzc7IrGtliOXvsK5IYRkRLl5yz3mRttYaVxvVBw9K1xjHI3yQl8qLI1yonJminDYLL+fVYQHKZ9qYnTiW+9ZbQC28E9d/0nuOifJDhMZKz4WQFw5anILGrz4l0xcJLgOBe0QNXG7SIgxqX0ex7pSKM7Zxx2oHNXawcV2SAuG/iCoRMjcW5VRUPqp4kFpwR/Z8VZoyIcw8E+4jlqvSucs5hXuiqs4A0VSD8tisUyZvB5UaIPRfFtF99jFI+5F/XOyPDXH3GQOgb1LUtE3gfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(346002)(366004)(396003)(6666004)(8936002)(66556008)(66476007)(8676002)(21480400003)(66946007)(2906002)(86362001)(966005)(6916009)(6706004)(235185007)(33964004)(2616005)(52116002)(31686004)(956004)(26005)(186003)(16526019)(478600001)(31696002)(36756003)(316002)(5660300002)(83380400001)(6486002)(16576012)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: KwIrIqdEAE0BbkGkkLUSdSG9sMYLC+JS7ONmZuifqTIip4WHtC0yTlE3plMwKWTwEmcTXQ3uZbnDM9oPUJTcUH1IAO5h1ioEwRAK3EzUMXSaIRZ1vNiFGFgxAwQyAvrdX3/z5mFhNXqJWapkM8eKBhRUQWDK+fJWvNqduoqUjbc4Xs5lqrwsqHvNFnxKfpP8FuCri1yKYzANedIAh26GD+pkCSki8cS6dA16jZ4Znb8fvTqAgkoSqgeBHEqJLopwu+iAmd7xIn8e1hEsC9yVfCSFF+aX4u82cXEqOjmVtctpqLdSjeaom/3CNITYSFhi0YZo6g6bcfEG746cPcG057ZftCfi1ipHBagAnyt94yPezBYQHgCvewEJcgwuRVUYKUw40jHO6kDIXVSwp5UbP7Cp+z6ntxHAsbRRyw5mcegGGQRUWS4h6IcaEXDcscBDdXErOseHj30QyVhju/mL9eYq6JOPJpNzJ34/wem2un8ZL6QJaxiOcQa2h4eoHvqDdZeB2T6gXBw17viJPkq/OEOK7f67tmglpCQioLI0bUAkAZOjyJ7l5fPD4KK5Dct5zSxQxft/YkH3HIWnEM5MYtZ7GuUs5KMdTmh5aNHwYTDgwfPKy8thDI7C7Dg4p8LzuqNNKGjuoJZYzNYiWLCmfA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563f9bad-c51e-4aeb-aab3-08d859e0d9cc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 01:35:53.7288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLWpQ8IhonlxoxMTlZ8ufN5Ksb8iBKSddm8o9hwa+mToWGf22IMrSydRY3XNxryn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7235
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--A8qr5xnb70D6AFypRjuoIbmI8M0w2zarx
Content-Type: multipart/mixed; boundary="GByO2CO80eQurFQu1XFxoTmPYON73xaXu"

--GByO2CO80eQurFQu1XFxoTmPYON73xaXu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/15 =E4=B8=8B=E5=8D=881:35, Qu Wenruo wrote:
> Patches can be fetched from github:
> https://github.com/adam900710/linux/tree/subpage
>=20
> Currently btrfs only allows to mount fs with sectorsize =3D=3D PAGE_SIZ=
E.
>=20
> That means, for 64K page size system, they can only use 64K sector size=

> fs.
> This brings a big compatible problem for btrfs.
>=20
> This patch is going to slightly solve the problem by, allowing 64K
> system to mount 4K sectorsize fs in read-only mode.
>=20
> The main objective here, is to remove the blockage in the code base, an=
d
> pave the road to full RW mount support.
>=20
> =3D=3D What works =3D=3D
>=20
> Existing regular page sized sector size support
> Subpage read-only Mount (with all self tests and ASSERT)
> Subpage metadata read (including all trees and inline extents, and csum=
 checking)
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
>   This means we currently can only support one-page-to-one-extent-buffe=
r
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
> - Completely rely on extent_io_tree for metadata status/locking
>   Now for subpage metadata, page::private is never utilized. It always
>   points to NULL.
>   And we only utilize private page status, other status
>   (locked/uptodate/dirty/...) are all ignored.
>=20
>   Instead, page lock is replayed by EXTENT_LOCK of extent_io_tree.
>   Page uptodate is replaced by EXTENT_UPTODATE of extent_io_tree.
>   And if a range has extent buffer is represented by EXTENT_NEW.
>=20
>   This provides the full potential for later RW support.
>=20
> - Do subpage read for metadata
>   Now we do proper subpage read for both data and metadata.
>   For metadata we never merge bio for adjacent tree blocks, but always
>   submit one bio for one tree block.
>   This allows us to do proper verification for each tree blocks.
>=20
> For data part, it's pretty simple, all existing infrastructure can be
> easily converted to support subpage read, without any subpage specific
> handing yet.
>=20
> =3D=3D Patchset structure =3D=3D
>=20
> The structure of the patchset:
> Patch 01~15: Preparation patches for data and metadata subpage read sup=
port.
>              These patches can be merged without problem, and work for
>              both regular and subpage case.
> 	     This part can conflict with Nikolay's latest cleanup, but
> 	     the conflicts should be pretty controllable.
>=20
> Patch 16~19: Patches for metadata subpage read support.
> 	     The main part of the patchset. It converts metadata to
> 	     purely extent_io_tree based solution for subpage read.
>=20
> 	     In theory, page sized routine can also be converted to
> 	     extent_io_tree. But that would be another topic in the
> 	     future.
>=20
> The number of patches is the main reason I'm submitting them to the mai=
l
> list. As there are too many preparation patches already.

For the missing changelog:
v2:
- Migrating to extent_io_tree based status/locking mechanism
  This gets rid of the ad-hoc subpage_eb_mapping structure and extra
  timing to verify the extent buffers.

  This also brings some extra cleanups for btree inode extent io tree
  hooks which makes no sense for both subpage and regular sector size.

  This also completely removes the requirement for page status like
  Locked/Uptodate/Dirty. Now metadata pages only utilize Private status,
  while private pointer is always NULL.

- Submit proper subpage sized read for metadata
  With the help of extent io tree, we no longer need to bother full page
  read. Now submit subpage sized metadata read and do subpage locking.

- Remove some unnecessary refactors
  Some refactors like extracting detach_extent_buffer_pages() doesn't
  really make the code cleaner. We can easily add subpage specific
  branch.

- Address the comments from v1

Thanks,
Qu
>=20
> Qu Wenruo (19):
>   btrfs: extent-io-tests: remove invalid tests
>   btrfs: remove the unnecessary parameter @start and @len for
>     check_data_csum()
>   btrfs: calculate inline extent buffer page size based on page size
>   btrfs: remove the open-code to read disk-key
>   btrfs: make btrfs_fs_info::buffer_radix to take sector size devided
>     values
>   btrfs: don't allow tree block to cross page boundary for subpage
>     support
>   btrfs: update num_extent_pages() to support subpage sized extent
>     buffer
>   btrfs: handle sectorsize < PAGE_SIZE case for extent buffer accessors=

>   btrfs: make csum_tree_block() handle sectorsize smaller than page siz=
e
>   btrfs: add assert_spin_locked() for attach_extent_buffer_page()
>   btrfs: extract the extent buffer verification from
>     btree_readpage_end_io_hook()
>   btrfs: extent_io: only require sector size alignment for page read
>   btrfs: make btrfs_readpage_end_io_hook() follow sector size
>   btrfs: make btree inode io_tree has its special owner
>   btrfs: don't set extent_io_tree bits for btree inode at endio time
>   btrfs: use extent_io_tree to handle subpage extent buffer allocation
>   btrfs: implement subpage metadata read and its endio function
>   btrfs: implement btree_readpage() and try_release_extent_buffer() for=

>     subpage
>   btrfs: allow RO mount of 4K sector size fs on 64K page system
>=20
>  fs/btrfs/btrfs_inode.h           |  12 +
>  fs/btrfs/ctree.c                 |  13 +-
>  fs/btrfs/ctree.h                 |  38 +++-
>  fs/btrfs/disk-io.c               | 217 ++++++++++++++----
>  fs/btrfs/extent-io-tree.h        |   8 +
>  fs/btrfs/extent_io.c             | 376 +++++++++++++++++++++++++++----=

>  fs/btrfs/extent_io.h             |  19 +-
>  fs/btrfs/inode.c                 |  40 +++-
>  fs/btrfs/ordered-data.c          |   8 +
>  fs/btrfs/qgroup.c                |   4 +
>  fs/btrfs/struct-funcs.c          |  18 +-
>  fs/btrfs/super.c                 |   7 +
>  fs/btrfs/tests/extent-io-tests.c |  26 +--
>  13 files changed, 642 insertions(+), 144 deletions(-)
>=20


--GByO2CO80eQurFQu1XFxoTmPYON73xaXu--

--A8qr5xnb70D6AFypRjuoIbmI8M0w2zarx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9ha+YACgkQwj2R86El
/qhkfgf7BAbZ1AOS8MtB6gBuEwcEYlOEUtksmuzp0s6NrPi1xTp3FeKsFwYflJg7
HNDFEZ7Jart3saOghA1kWbQlab7Yicozbhv4qG4gLICbkMmRVCOZ/3sRE3YnRyrY
k+0eRFtwF8sayfSD9h2C1JckZJeIFHR2smMVv9UrsjfQiE3nnUZsACFfEGQ2CtJU
n/upqWjnP01e/9mQHnHCZGQADz13JMsboXI1ssdc6Vubj1zHw+VKWFNW1nI0bSIT
DDVhXiFrfymfGTKclhWr8oGCCJalbnB2fKTkmywmTURg4/ThesoKdFRb5GmdKXgT
4O4DdULcvIPTYOLbDPROcB1fOAfDcg==
=rLX8
-----END PGP SIGNATURE-----

--A8qr5xnb70D6AFypRjuoIbmI8M0w2zarx--


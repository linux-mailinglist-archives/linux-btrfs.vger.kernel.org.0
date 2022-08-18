Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACFA59818B
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 12:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244094AbiHRKkq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 06:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238978AbiHRKkp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 06:40:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF536CF54
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Aug 2022 03:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660819238;
        bh=F+xM4H+x41ikUfVV0VswCTgA1nR6DEwVAKJpMcZhdU8=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=dOq+UdejEdLlgsk/hlASFRan3/CxGSEyL2fuA4D6icEGHrYdXAMgdeVoGACSM2Slg
         poruEkjQvC4uYkTb+gCrA3YzvBQadegPFqtNi+LCeah1EZChD1Z4Z57t7hvlxCLw1I
         JOHSOtZf8BrNkoE+8b6rXfU/VnBBD9uBEUwbvk4I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbRfl-1nneNL0SCn-00bsTy; Thu, 18
 Aug 2022 12:40:38 +0200
Message-ID: <fe02d56b-f2cf-d9d7-8929-5744f11ce82c@gmx.com>
Date:   Thu, 18 Aug 2022 18:40:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Stefan Roesch <shr@fb.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20211203220445.2312182-1-shr@fb.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v6 0/4] btrfs: sysfs: set / query btrfs chunk size
In-Reply-To: <20211203220445.2312182-1-shr@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S/ff0djZGX2mfSp+/J8qFyrI4H0P3EQOpCuovVx5+xTwrf4/5tq
 ToLgHExRRmc0G73Rllha6r0wocM5pZdSI6S3voGwY/zEWDkx3n3RwJ0B5tJ8dGTkuB+I0/6
 zmwc5SsfHkCNfDhYKZF/uGsPm9CTDJAPF3JnRohA+kaVsC8Ag0s8hnRywXQDWgTn9fyLwjF
 pwkSgtMlT6FLMZLCNvj5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kFrG8p8MmS0=:mHTQMENl0Ovs3USFtKWXI5
 V27veu0xsv+ZI0R/ikP4B6cZLLskkWNtDq5Ophn4/kOmbgUzb6fVGP24+B4/pQRDpgYDxsjE6
 geRl/CgFVN89WQcBGxiPYFfrgdFbdcag9XCAVoL8p15TAyGP9+sNcURn2C5FVdm2UaQ1Yt+Zv
 gQPZSzglrGN4sbFi69cGFanwpWWQ40TVmwwZE3I8JxkafsLSZFvAhoPmtcnQ6qe4I+nlWlnc1
 Eybx8SopJ5Y7QS2X1aTWoC9xrVKc+FhlD7/H9cDybDaegCwrKlijvw63XqQJxVv4uWE0Zwdg8
 kycStXuou2F2TI4Hwe3wIlTMSPYTbJlvuK8W74S42Zd5WIsbmRrKVH5b9MhmqyawVgwMsFIZA
 4wpVWVhEj2Iu34LRN+6ykDMAxlYqj/j9s2GE3ow2OUNsm9god09RAUNUtnrxUQdWhrNmHMgOY
 PmCbtkwh6WyzqPRphfjGhaC8kLj3dfgTaPNVi6PDX+GGi8VEcUAsJ6BS7bVN9ab4qFIBsTELG
 7lpNnOOKu39xkx64DaWIMO9FECWv2vv8AYe/r0wZPaNmmnKnsHgN4vwdWlSAJkUqc6y25U+Sd
 oRUiOQv7vJ0XuertMUz4/kLvEIDFLIJksoemuJqZ7n01ED47TJbF+L2wXzTyi67bQO9W7QN8A
 4Uvc7OeVJzrxXieFD1l4TgsmcVTcuSKBltId9U+nnzieBHMKoQPCsybA/Zb+MXZqn5vlA3T2R
 EUojrvfo7kTeI8sfVlsK1+ngzNjGqzcokvsS0gzbzbkMNE/05D6WnVGDXhRLiIo51GBp1G2/4
 vZmTtPbY2wJBUWMV5AioyTRh2uBJLLz64qYTvbr6DXmwZIMrpDcK0XwrHlKxdiFdFixmvzAF+
 ucZjqmBQgJpbUwCT5lGYwNQeLOfkBS0SY2V1ujxDMfbyZDOJkVbTi/yjsJSi5Iudk2UW6zDb+
 tce7VmhE172IR3jO0yZHRSUeldx9RwrQ2Zx2hW0yJzZrxaQg4Y7WmEsek/tI1QE9kaAl1+PLV
 2aRfHAf0AwF4o5r5bJqeuZctrf4R/VvnwIxB5LqRCWV6QcHFOsL1Irj1hKBK6SxnevWbbSGR0
 3c9MIFsOsdZ5LOti0Z/pmDh8tKeQdfWKkhwIAJSmcFas+I4zLiDdKWhKA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/4 06:04, Stefan Roesch wrote:
> The btrfs allocator is currently not ideal for all workloads. It tends
> to suffer from overallocating data block groups and underallocating
> metadata block groups. This results in filesystems becoming read-only
> even though there is plenty of "free" space.
>
> This is naturally confusing and distressing to users.
>
> Patches:
> 1) Store the chunk size in the btrfs_space_info structure

I guess it's too late, since the series is already in upstream, but I
believe we need to do some more review on this feature.

Firstly, I don't believe a single chunk_size (even it's per space-info)
is good enough.

The default chunk allocator has both checks on stripe_size and
chunk_size, but the series only added chunk_size knob, missing
stripe_size one.

It would be much better to add another stripe_size knob for it.

> 2) Add a sysfs entry to read and write the above information
> 3) Add a sysfs entry to force a space allocation

Any idea on how we handle the auto-reclaim on empty bgs?
AKA, what's preventing the newly allocated bgs from being immediately
reclaimed?

I didn't see any special handling in the 3rd patch.

> 4) Increase the default size of the metadata chunk allocation to 5GB
>     for volumes greater than 50GB.

It would be better to also allow users to tweak the size threshold.
(E.g. allowing a knob for threshold on different chunk/stripe size
limits, along with above mentioned stripe size knob).

Thanks,
Qu
>
> Testing:
>    A new test is being added to the xfstest suite. For reference the
>    corresponding patch has the title:
>      [PATCH] btrfs: Test chunk allocation with different sizes
>
>    In addition also manual testing has been performed.
>      - Run xfstests with the changes and the new test. It does not
>        show new diffs.
>      - Test with storage devices 10G, 20G, 30G, 50G, 60G
>        - Default allocation
>        - Increase of chunk size
>        - If the stripe size is > the free space, it allocates
>          free space - 1MB. The 1MB is left as free space.
>        - If the device has a storage size > 50G, it uses a 5GB
>          chunk size for new allocations.
>
> ---
> v6: - Update btrfs_force_chunk_alloc_store to use tree_root
>        instead of extent_root.
> V5: - Changed the field name in the btrfs_space_info struct from
>        default_chunk_size to chunk_size and made it atomic
>      - Removed the compute_chunk_size_zoned function
>      - Added further checks when writing /sys/fs/btrfs/<id>/allocation/<=
type>/chunk_size
>      - Removed the ability to query /sys/fs/btrfs/<id>/allocation/<type>=
/force_alloc_chunk
>
> V4: - Patch email contained duplicate entries.
>
> V3: - Rename sysfs entry from stripe_size to chunk_size
>      - Remove max_chunk_size field in data structure btrfs_space_info
>      - Rename max_stripe_size field to default_chunk_size in data
>        structure btrfs_space_info
>      - Remove max_chunk_size logic
>      - Use stripe_size =3D chunk_size
>
> V2:
>     - Split the patch in 4 patches
>     - Added checks for zone volumes in sysfs.c
>     - Replaced the BUG() with ASSERT()
>     - Changed if with fallthrough
>     - Removed comments in space-info.h
> --
> Stefan Roesch (4):
>    btrfs: store chunk size in space-info struct.
>    btrfs: expose chunk size in sysfs.
>    btrfs: add force_chunk_alloc sysfs entry to force allocation
>    btrfs: increase metadata alloc size to 5GB for volumes > 50GB
>
>   fs/btrfs/space-info.c |  41 ++++++++++++
>   fs/btrfs/space-info.h |   3 +
>   fs/btrfs/sysfs.c      | 152 ++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/volumes.c    |  28 +++-----
>   4 files changed, 205 insertions(+), 19 deletions(-)
>
>
> Signed-off-by: Stefan Roesch <shr@fb.com>
> base-commit: 87c673b657a7e4784fb7274a77a8529712232d0c

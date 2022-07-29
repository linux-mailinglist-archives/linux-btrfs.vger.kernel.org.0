Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4198E58565C
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jul 2022 23:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238936AbiG2VBt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jul 2022 17:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiG2VBr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jul 2022 17:01:47 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECEA87363
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jul 2022 14:01:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B1CF332003CE;
        Fri, 29 Jul 2022 17:01:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 29 Jul 2022 17:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1659128504; x=1659214904; bh=EUSnX91sSB
        FnJo25207aBzdpp1bN6mC7ZKB0g+TI6y4=; b=E73p6SBuumvbKqHGrRNPV2lavn
        DdlNwzs/0X4OPnmx8VtzUaTUwzkEDtg0KO38Gyd4T0EklT3FhAGfdrrpmS2lJtMz
        cvalFd4hVPuB4prYFnanvETGjAFn50cAfEtnNMPG+pn4uydAYn0vZdnzb3BfRxAx
        hVn2eTdI9pmHrMxAm+Uq2Zcx7cgC8KRZ0DW8ifnbSEghJI9larmKPWCnVyjHuEWg
        VX6cQr/trk/ZYk4xQsGwaHo7oLfPMCzT2bBS2eyLZXw9rbSgL/7RtnTCN6tXX8+Y
        Xxgkkyb6Atn4mnQTeA8lxk4IcTDWhcJ7X5ahehOo9xfdAM9Q9iCJiGu+atAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659128504; x=1659214904; bh=EUSnX91sSBFnJo25207aBzdpp1bN
        6mC7ZKB0g+TI6y4=; b=GnN//dE0i37Z98rMxjVIhkiTEKyky/LRMtYWAEPa2PVv
        BCVITEMmys0x0HisokubEGe+fhNBXsmilJNOA9NVfpMb22o/Z/SGm7nL12cUkukd
        k+iH35ORr793NQsVMvCNsOFbBTD9NKSi4yuV1ItjQqn7T0wemi3SVzit3gW5Kgz5
        Yfec5ZXRW5wIaZqPasRM8PrU2STxRcQx0g1DBrQmnKn6fB6CYR7edqwLRI6rmePG
        VYZGONiu1cazoU7DtaMjmAeIz58BQkkmiB4twzZxVolL0wwSzb2ugOIa//wkRGtt
        VWdindPHgDbv2q8vSisW+sCB9YdVPCtsd//FsLfpFg==
X-ME-Sender: <xms:t0rkYlu0xuiMLbqvKzEZQgemygo8xsXn4UgEYFnfVSKz97JKsG931Q>
    <xme:t0rkYueofhgObxwgyN1B_C_HV5IkKLtLRl3GGVt9tFnnoCbPh9EIaktmec_phV2vm
    rosI59WuMLtDjEaB5s>
X-ME-Received: <xmr:t0rkYozMATgedoqpvcVOON2k0syeKqn7OaltNzjWagr36D6CEQBb6PeKMmorL-YfmxiRx-kIffQiKWTous6009SCDxPzfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddujedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epgfefudefheegjeefjeekueegudeuhfeijeefieegvddvgeffkefhteejkeejuddunecu
    ffhomhgrihhnpehprghsthgvsghinhdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:t0rkYsNLfbSuEAde-OGOo7rLPRcVjRoZ2SdXMDgdeIi1XRWSsXy-HA>
    <xmx:t0rkYl84cpnuOb1Tiktf9NOgfuZ4r1tkZu1ohrA9-CQQxm-xdJi48Q>
    <xmx:t0rkYsX2wc4ZyiGoJVT6u6r8ELjcioMXGbzjhUqvTAMhHAmPISWJWw>
    <xmx:uErkYiFvzwLWZKiAuPKdImIDThT1ubVTYsbgyqz8X7kPlW_aqUwEGA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Jul 2022 17:01:43 -0400 (EDT)
Date:   Fri, 29 Jul 2022 14:01:41 -0700
From:   Boris Burkov <boris@bur.io>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Selectable checksum implementation
Message-ID: <YuRKtV7ZyyrjT/uS@zen>
References: <cover.1659116355.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1659116355.git.dsterba@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 29, 2022 at 07:42:42PM +0200, David Sterba wrote:
> Add a possibility to load accelerated checksum implementation after a
> filesystem has been mounted. Detailed description in patch 3.

I naively attempted to use this on my test VM and it blew up in mount.

What I ran:
mkfs.btrfs -f $dev --csum sha256
mount $dev $mnt

I got this oops:
https://pastebin.com/DAbSem7K

which indicates a null pointer access in this code:
(gdb) list *open_ctree+0x3c9
0xffffffff8210634e is in open_ctree (fs/btrfs/disk-io.c:2437).
2432
2433            /*
2434             * Find the fastest implementation available, but keep the slots
2435             * matching the type.
2436             */
2437            if (strstr(crypto_shash_driver_name(fs_info->csum_shash[CSUM_DEFAULT]),
2438                       "generic") != NULL) {
2439                    fs_info->csum_shash[CSUM_GENERIC] = csum_shash;
2440                    clear_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
2441            } else {

So I suspect the problem is in btrfs_init_csum_hash. Looking at it, two
things come to mind:
1. the old code used the name from the allocated hash, maybe we need to
check that against "generic" instead of the DEFAULT
2. we never set the DEFAULT entry to anything, so it isn't clear to me
how the use of the checksum would work after this (which it does seem to
do, to csum the super block).

Running misc-next, it mounted and reported it was using sha256-generic:
$ cat /sys/fs/btrfs/8ffa8559-f6c4-41d3-a806-c12738367d72/checksum
sha256 (sha256-generic)

I have not yet figured out how to get the virtio accel stuff to actually
work in the VM, so I haven't tested the happy case yet, but I figured
this report would be interesting on its own.

For further info, lsmod is empty on this VM. And here are the contents
of /proc/crypto:
https://pastebin.com/mZW6tq29

Hope that's helpful, and apologies if I didn't use the API correctly...

> 
> v2: rebased on misc-next
> 
> David Sterba (4):
>   btrfs: prepare more slots for checksum shash
>   btrfs: assign checksum shash slots on init
>   btrfs: add checksum implementation selection after mount
>   btrfs: sysfs: print all loaded csums implementations
> 
>  fs/btrfs/check-integrity.c |   4 +-
>  fs/btrfs/ctree.h           |  13 ++++-
>  fs/btrfs/disk-io.c         |  30 +++++++----
>  fs/btrfs/file-item.c       |   4 +-
>  fs/btrfs/inode.c           |   2 +-
>  fs/btrfs/scrub.c           |  12 ++---
>  fs/btrfs/super.c           |   2 -
>  fs/btrfs/sysfs.c           | 101 +++++++++++++++++++++++++++++++++++--
>  8 files changed, 141 insertions(+), 27 deletions(-)
> 
> -- 
> 2.36.1
> 

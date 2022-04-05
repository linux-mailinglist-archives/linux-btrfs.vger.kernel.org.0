Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B384F479C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 01:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350005AbiDEVOV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 17:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457667AbiDEQb2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 12:31:28 -0400
X-Greylist: delayed 414 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Apr 2022 09:29:29 PDT
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11772BF006
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 09:29:28 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id 9062175F;
        Tue,  5 Apr 2022 16:22:31 +0000 (UTC)
Date:   Tue, 5 Apr 2022 21:22:30 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Marc MERLIN <marc@merlins.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220405212230.28db3079@nvm>
In-Reply-To: <20220405014259.GG5566@merlins.org>
References: <20220405001325.GB5566@merlins.org>
        <CAEzrpqcb2jHehpnrjxtNJ4KWW3M5pvJThUNGFZw78=MBNdTG5g@mail.gmail.com>
        <20220405001808.GC5566@merlins.org>
        <CAEzrpqfKaXjk7J_oAY0pSL4YPy_vw5Z0tKmjMPQgQSd_OhYwXA@mail.gmail.com>
        <20220405002826.GD5566@merlins.org>
        <CAEzrpqeHa7tG+S_9Owu5XYa0hwBKJPVN2ttr_E_1Q4UV8u0Nmg@mail.gmail.com>
        <20220405005809.GE5566@merlins.org>
        <CAEzrpqfjTUoK9fi43tLZaJ9mkBewAqcUH77di7QipH9Vj6AB0g@mail.gmail.com>
        <20220405011559.GF5566@merlins.org>
        <CAEzrpqfGF3O6gZTqGVN+iju92=8Zemz09_AJN2nvy2yHUmYyGg@mail.gmail.com>
        <20220405014259.GG5566@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 4 Apr 2022 18:42:59 -0700
Marc MERLIN <marc@merlins.org> wrote:

> And shit, I got distracted and sent the text output to
> /dev/mapper/dshelf1a, so I clobbered about 30K of the device. 
> I'm assuming there was probably something there?
> 
> Script started on Mon 04 Apr 2022 18:36:51 PDT
> 1;37mgargamel:/var/local/src/btrfs-progs-josefbacik#m ./btrfs-inspect-internal dump-tree -b 13577821667328 &>/dev/mapper/dshelf1a
> btrfs inspect-internal dump-tree: not enough arguments: 0 but at least 1 expected

It doesn't appear like it would write 30K to the device, it failed right away
since you didn't *specify* the device; the above output was to STDERR, and
there would be no writes to STDOUT (i.e. the device). Did you check the
content of /dev/mapper/dshelf1a (with less -f, for example)?

I know Josef said this is no prolem, but anyways. :)

-- 
With respect,
Roman

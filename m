Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05F44F4780
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 01:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbiDEVL6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 17:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573272AbiDESlH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 14:41:07 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2676120BE2
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 11:39:07 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id A31832ADA6D; Tue,  5 Apr 2022 14:38:59 -0400 (EDT)
Date:   Tue, 5 Apr 2022 14:38:59 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Marc MERLIN <marc@merlins.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <YkyMw/7zjzctH0X/@hungrycats.org>
References: <CAEzrpqcb2jHehpnrjxtNJ4KWW3M5pvJThUNGFZw78=MBNdTG5g@mail.gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405014259.GG5566@merlins.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 04, 2022 at 06:42:59PM -0700, Marc MERLIN wrote:
> On Mon, Apr 04, 2022 at 09:22:26PM -0400, Josef Bacik wrote:
> > Ok lets try again with -b 13577821667328, and if the owner doesn't say
> > ROOT_TREE try 13577775284224 and then 13577814573056.  Thanks,
> 
> EXTENT_TREE, FS_TREE, and FS_TREE
> 
> And shit, I got distracted and sent the text output to
> /dev/mapper/dshelf1a, so I clobbered about 30K of the device. 
> I'm assuming there was probably something there?

First superblock is at 64K, and the first 1M of every device is unused.
A 30K write at the beginning will overwrite nothing important to btrfs.

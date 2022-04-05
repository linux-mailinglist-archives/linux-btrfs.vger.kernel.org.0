Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4580A4F5446
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 06:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442147AbiDFEqv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 00:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1586729AbiDFACC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 20:02:02 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2152424A6
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 15:29:38 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:48730 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nbrg8-0003Qu-Qh by authid <merlins.org> with srv_auth_plain; Tue, 05 Apr 2022 15:29:36 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nbrJY-00E9Pd-IN; Tue, 05 Apr 2022 15:06:16 -0700
Date:   Tue, 5 Apr 2022 15:06:16 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220405220616.GB3307770@merlins.org>
References: <20220405001808.GC5566@merlins.org>
 <CAEzrpqfKaXjk7J_oAY0pSL4YPy_vw5Z0tKmjMPQgQSd_OhYwXA@mail.gmail.com>
 <20220405002826.GD5566@merlins.org>
 <CAEzrpqeHa7tG+S_9Owu5XYa0hwBKJPVN2ttr_E_1Q4UV8u0Nmg@mail.gmail.com>
 <20220405005809.GE5566@merlins.org>
 <CAEzrpqfjTUoK9fi43tLZaJ9mkBewAqcUH77di7QipH9Vj6AB0g@mail.gmail.com>
 <20220405011559.GF5566@merlins.org>
 <CAEzrpqfGF3O6gZTqGVN+iju92=8Zemz09_AJN2nvy2yHUmYyGg@mail.gmail.com>
 <20220405014259.GG5566@merlins.org>
 <20220405212230.28db3079@nvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405212230.28db3079@nvm>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 05, 2022 at 09:22:30PM +0500, Roman Mamedov wrote:
> On Mon, 4 Apr 2022 18:42:59 -0700
> Marc MERLIN <marc@merlins.org> wrote:
> 
> > And shit, I got distracted and sent the text output to
> > /dev/mapper/dshelf1a, so I clobbered about 30K of the device. 
> > I'm assuming there was probably something there?
> > 
> > Script started on Mon 04 Apr 2022 18:36:51 PDT
> > 1;37mgargamel:/var/local/src/btrfs-progs-josefbacik#m ./btrfs-inspect-internal dump-tree -b 13577821667328 &>/dev/mapper/dshelf1a
> > btrfs inspect-internal dump-tree: not enough arguments: 0 but at least 1 expected
> 
> It doesn't appear like it would write 30K to the device, it failed right away
> since you didn't *specify* the device; the above output was to STDERR, and
> there would be no writes to STDOUT (i.e. the device). Did you check the
> content of /dev/mapper/dshelf1a (with less -f, for example)?

Yeah, good point.
I checked it and it only has one line clobbered:
btrfs inspect-internal dump-tree: not enough arguments: 0 but at least 1 expected

then it's filled with 0's.

So I lost only the first sector, and it's not been used. All good. 
(that happened in another command as like you said the command I pasted
couldn't have done this)

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

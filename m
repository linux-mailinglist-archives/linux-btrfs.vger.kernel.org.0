Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F554F1C4F
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Apr 2022 23:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381081AbiDDV01 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 17:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379831AbiDDSMy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 14:12:54 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C013EA8F
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 11:10:57 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:48698 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nbRAF-0005XP-7z by authid <merlins.org> with srv_auth_plain; Mon, 04 Apr 2022 11:10:55 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nbRAF-00C00g-23; Mon, 04 Apr 2022 11:10:55 -0700
Date:   Mon, 4 Apr 2022 11:10:55 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220404181055.GW1314726@merlins.org>
References: <20220329171818.GD1314726@merlins.org>
 <dffec23f-bef1-30e2-83fc-b3fb9bb5f21e@gmail.com>
 <20220330143944.GE14158@merlins.org>
 <20220331171927.GL1314726@merlins.org>
 <Ykoux6Oczf6+hmGg@localhost.localdomain>
 <20220404010101.GQ1314726@merlins.org>
 <20220404150858.GS1314726@merlins.org>
 <CAEzrpqc1yvK+v5MSiCxPRxX2c27xPsO5POMPJ8OuQaN4u1y2wA@mail.gmail.com>
 <20220404174357.GT1314726@merlins.org>
 <CAEzrpqc7P7pxkdSw8eS-nCkn1h5ztQC7C=MewJdmT6Mr5OJX-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqc7P7pxkdSw8eS-nCkn1h5ztQC7C=MewJdmT6Mr5OJX-A@mail.gmail.com>
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

On Mon, Apr 04, 2022 at 01:53:56PM -0400, Josef Bacik wrote:
> Can you do
> 
> btrfs check --chunk-bytenr 21053440 /dev/whatever
 
I assume you meant chunk-root

gargamel:~# btrfs check --chunk-root 21053440 /dev/mapper/dshelf1a
Opening filesystem to check...
No mapping for 13577814573056-13577814589440
Couldn't map the block 13577814573056
Couldn't map the block 13577814573056
bad tree block 13577814573056, bytenr mismatch, want=13577814573056, have=0
Couldn't read tree root
ERROR: cannot open file system


gargamel:~# btrfs check --chunk-root 21069824 /dev/mapper/dshelf1a
Opening filesystem to check...
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
leaf parent key incorrect 13577821667328
ERROR: could not setup extent tree
ERROR: cannot open file system

> also I can't seem to find output from a normal btrfs check run, can I
> see that as well?  I'm curious if we could just tell the super block
> the right transid for this and everything would be ok.  Thanks,

gargamel:~# btrfs check /dev/mapper/dshelf1a
Opening filesystem to check...
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
leaf parent key incorrect 13577821667328
ERROR: could not setup extent tree
ERROR: cannot open file system

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

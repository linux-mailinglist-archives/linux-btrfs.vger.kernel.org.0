Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA0E527B41
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 02:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbiEPA6D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 May 2022 20:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiEPA6B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 May 2022 20:58:01 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A8C65AB
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 17:58:00 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:50636 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nqP3g-0005dO-5u by authid <merlins.org> with srv_auth_plain; Sun, 15 May 2022 17:58:00 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nqP3f-002hHJ-Vt; Sun, 15 May 2022 17:58:00 -0700
Date:   Sun, 15 May 2022 17:57:59 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220516005759.GE13006@merlins.org>
References: <CAEzrpqfpXVBoWdAzXEYG+RdhOMZFUbWBf6GKcQ6AwL77Mtzjgg@mail.gmail.com>
 <20220515144145.GB13006@merlins.org>
 <CAEzrpqcVRJFS6HN4L7=tu0Z8SA+E2GsLJzWEADRK3iJvdVy4EA@mail.gmail.com>
 <20220515153347.GA8056@merlins.org>
 <CAEzrpqcZQVWwt1JSDg6z44dBYKW6fmmXmOTFoXiDWpoGXxufwQ@mail.gmail.com>
 <20220515154122.GB8056@merlins.org>
 <CAEzrpqc6MyW0t1H9ue_GQL-1AhgpWfumBfj3MK0eGstwJ3R1aw@mail.gmail.com>
 <20220515212951.GC13006@merlins.org>
 <20220515230147.GD13006@merlins.org>
 <CAEzrpqdbjeTYEy16KbzJ39bBkd8rkNTHA2n53UXHG-CdeUo6xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdbjeTYEy16KbzJ39bBkd8rkNTHA2n53UXHG-CdeUo6xw@mail.gmail.com>
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

On Sun, May 15, 2022 at 08:01:02PM -0400, Josef Bacik wrote:
> Huh, did this pop during the btrfs check?  We can just delete that guy
 
Yes, just at the end, when it looked finished

> btrfs-corrupt-block -d "1,204,941709328384" -r 3 <device>
> 
> and then you should be good, unless there are other dangling dev
> extents that need to be removed.  Thanks,

Is that bad?
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1,204,941709328384" -r 3 /dev/mapper/dshelf1
FS_INFO IS 0x56044c4bd600
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x56044c4bd600
Error searching to node -2

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

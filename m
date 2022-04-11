Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8FB4FB16E
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 03:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244266AbiDKBjj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Apr 2022 21:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbiDKBji (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Apr 2022 21:39:38 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894A944A07
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Apr 2022 18:37:26 -0700 (PDT)
Received: from [206.181.83.18] (port=58318 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1ndizb-0001Yq-3R by authid <merlins.org> with srv_auth_plain; Sun, 10 Apr 2022 18:37:23 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1ndizZ-007F62-QB; Sun, 10 Apr 2022 18:37:21 -0700
Date:   Sun, 10 Apr 2022 18:37:21 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220411013721.GN3307770@merlins.org>
References: <11970220.O9o76ZdvQC@ananda>
 <20220407052022.GC25669@merlins.org>
 <20220407162951.GD25669@merlins.org>
 <CAEzrpqdeph1AM74habMeOg_VURv5AFvZZ-9aUM9ZVEkM+-3Xkg@mail.gmail.com>
 <CAEzrpqdjKE3ehKjEqWOuBHPuScpjDG+B7r81SP1Vd+G8RVK6rA@mail.gmail.com>
 <20220408102209.GG25669@merlins.org>
 <CAEzrpqf+64jMsWnddCuoiVPEWyHOK+U3cGJMHrFAdHRn2Vbd0g@mail.gmail.com>
 <CAEzrpqf1etZPKDrNexLLerdz3zXUai-zOfj8=LXzjbxdwiom0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqf1etZPKDrNexLLerdz3zXUai-zOfj8=LXzjbxdwiom0g@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-Broken-Reverse-DNS: no host name for IP address 206.181.83.18
X-SA-Exim-Connect-IP: 206.181.83.18
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 08, 2022 at 04:09:34PM -0400, Josef Bacik wrote:
> Course the last 10% takes the longest, but I corrupted a local file
> system and ran it to shake out all the stupid bugs.  Go ahead and pull
> and run
> 
> ./btrfs rescue tree-recover /dev/whatever
> 
> and then *hopefully* you can just run btrfs check --repair, but it may
> fail out with a "btrfs unable to find ref byte", which is what I was
> seeing locally.  I'm fixing that but it's tricky and may be a while.
> If you hit that then go ahead and use --init-extent-tree
> --init-csum-tree and let it ride.  Thanks,

Sorry for the delay, too many things this weekend and I didn't do Email.

gargamel:/var/local/src/btrfs-progs-josefbacik# git log | head -5
commit 580e1b4db52a0ec98661bec7310450d84ea1f441
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Fri Apr 8 16:07:48 2022 -0400

    handle fstree's differently

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
Ignoring transid failure
FS_INFO IS 0x558174d9cbc0
Ignoring transid failure
Ignoring transid failure
Ignoring transid failure
Ignoring transid failure
Ignoring transid failure
Ignoring transid failure
Couldn't find the last root for 8
ERROR: failed to read block groups: Input/output error
FS_INFO AFTER IS 0x558174d9cbc0
deleting slot 94 in block 21069824
FS_INFO IS 0x558174e1f430
Ignoring transid failure
Ignoring transid failure
Ignoring transid failure
Ignoring transid failure
Ignoring transid failure
Ignoring transid failure
Couldn't find the last root for 8
ERROR: failed to read block groups: Input/output error
FS_INFO AFTER IS 0x558174e1f430
Found completely clean tree for 3 in backup root, replacing
ERROR: Still have update after a repair loop, bailing
Tree recover failed


Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

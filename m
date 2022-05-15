Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C60527A63
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 May 2022 23:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiEOV3y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 May 2022 17:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiEOV3x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 May 2022 17:29:53 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F56DE089
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 14:29:52 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:50632 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nqLoF-0005Xd-Lm by authid <merlins.org> with srv_auth_plain; Sun, 15 May 2022 14:29:51 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nqLoF-002QwN-Fm; Sun, 15 May 2022 14:29:51 -0700
Date:   Sun, 15 May 2022 14:29:51 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220515212951.GC13006@merlins.org>
References: <20220513144113.GA16501@merlins.org>
 <CAEzrpqfYg=Zf_GYjyvc+WZsnoCjiPTAS-08C_rB=gey74DGUqA@mail.gmail.com>
 <20220515025703.GA13006@merlins.org>
 <CAEzrpqfpXVBoWdAzXEYG+RdhOMZFUbWBf6GKcQ6AwL77Mtzjgg@mail.gmail.com>
 <20220515144145.GB13006@merlins.org>
 <CAEzrpqcVRJFS6HN4L7=tu0Z8SA+E2GsLJzWEADRK3iJvdVy4EA@mail.gmail.com>
 <20220515153347.GA8056@merlins.org>
 <CAEzrpqcZQVWwt1JSDg6z44dBYKW6fmmXmOTFoXiDWpoGXxufwQ@mail.gmail.com>
 <20220515154122.GB8056@merlins.org>
 <CAEzrpqc6MyW0t1H9ue_GQL-1AhgpWfumBfj3MK0eGstwJ3R1aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqc6MyW0t1H9ue_GQL-1AhgpWfumBfj3MK0eGstwJ3R1aw@mail.gmail.com>
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

On Sun, May 15, 2022 at 11:48:00AM -0400, Josef Bacik wrote:
> Fixed, thanks,

Thanks, that was a whole lot quicker, less than 1h vs many days.


Recording extents for root 165098
processed 1015808 of 108756992 possible bytes, 0%
Recording extents for root 165100
processed 16384 of 49479680 possible bytes, 0%
Recording extents for root 165198
processed 491520 of 108756992 possible bytes, 0%adding a bytenr that overlaps our thing, dumping paths for [76300, 108, 0]
misc/add0/file
doing an insert of the bytenr
doing an insert that overlaps our bytenr 10467695652864 8675328
processed 983040 of 108756992 possible bytes, 0%
Recording extents for root 165200
processed 16384 of 49479680 possible bytes, 0%
Recording extents for root 165294
processed 16384 of 49479680 possible bytes, 0%
Recording extents for root 165298
processed 524288 of 108756992 possible bytes, 0%WTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths 10467695652864 8675328
misc/add0/file
processed 1015808 of 108756992 possible bytes, 0%
Recording extents for root 165299
processed 16384 of 75792384 possible bytes, 0%
Recording extents for root 18446744073709551607
processed 16384 of 16384 possible bytes, 100%
doing block accounting
doing close???
Init extent tree finished, you can run check now

Progress! :)

Now check --repair will be running for while, will report back...

Deleting bad dir index [76854,96,27] root 163921
Deleting bad dir index [78134,96,26] root 163921
Deleting bad dir index [76854,96,28] root 163921
Deleting bad dir index [76854,96,30] root 163921
Deleting bad dir index [76854,96,32] root 163921
repairing missing dir index item for inode 86629
repairing missing dir index item for inode 86630
repairing missing dir index item for inode 86638
repairing missing dir index item for inode 86748
repairing missing dir index item for inode 86759
repairing missing dir index item for inode 86760
repairing missing dir index item for inode 86766
repairing missing dir index item for inode 87909
repairing missing dir index item for inode 87912
repairing missing dir index item for inode 87977
repairing missing dir index item for inode 87978
repairing missing dir index item for inode 87979
repairing missing dir index item for inode 87981
repairing missing dir index item for inode 87982
repairing missing dir index item for inode 87983
repairing missing dir index item for inode 87984
repairing missing dir index item for inode 87985
repairing missing dir index item for inode 87986
repairing missing dir index item for inode 87987
repairing missing dir index item for inode 87988
repairing missing dir index item for inode 87989
repairing missing dir index item for inode 95246
repairing missing dir index item for inode 95699
repairing missing dir index item for inode 95701
repairing missing dir index item for inode 95703
repairing missing dir index item for inode 78946
repairing missing dir index item for inode 78947
repairing missing dir index item for inode 78948
repairing missing dir index item for inode 78949
repairing missing dir index item for inode 78950
repairing missing dir index item for inode 78951
repairing missing dir index item for inode 78952
repairing missing dir index item for inode 78953
repairing missing dir index item for inode 78954
repairing missing dir index item for inode 78955
repairing missing dir index item for inode 78956
repairing missing dir index item for inode 78957
repairing missing dir index item for inode 78958
repairing missing dir index item for inode 78959
repairing missing dir index item for inode 78960
repairing missing dir index item for inode 78961
repairing missing dir index item for inode 78962
repairing missing dir index item for inode 78963
repairing missing dir index item for inode 78964
repairing missing dir index item for inode 78965
repairing missing dir index item for inode 78966
repairing missing dir index item for inode 78967
repairing missing dir index item for inode 78968
repairing missing dir index item for inode 78969
repairing missing dir index item for inode 78970
repairing missing dir index item for inode 78971
repairing missing dir index item for inode 78972
repairing missing dir index item for inode 78973
(...)

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

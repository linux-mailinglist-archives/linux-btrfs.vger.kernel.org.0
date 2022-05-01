Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCD25164F0
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 May 2022 17:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbiEAPZ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 May 2022 11:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiEAPZ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 May 2022 11:25:58 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805A6286C3
        for <linux-btrfs@vger.kernel.org>; Sun,  1 May 2022 08:22:32 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58354 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nlBP5-0003nW-Lh by authid <merlins.org> with srv_auth_plain; Sun, 01 May 2022 08:22:31 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nlBP5-00EVbc-DY; Sun, 01 May 2022 08:22:31 -0700
Date:   Sun, 1 May 2022 08:22:31 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220501152231.GM12542@merlins.org>
References: <20220429185839.GZ29107@merlins.org>
 <CAEzrpqdpTXvDCmo-7H6QU1BKXM+fcG6ZdfHzQj0+=+7kcgkuOw@mail.gmail.com>
 <20220430022406.GH12542@merlins.org>
 <CAEzrpqdiYrbG4FDyoR1=HFZ-d12kD6mF-szxE-e+M-9ahKWd8A@mail.gmail.com>
 <20220430130752.GI12542@merlins.org>
 <CAEzrpqc3jBA4gRiLuYWFgs8zu_XrNDZ_JS+d2J_TN2a-sivO=w@mail.gmail.com>
 <20220430231115.GJ12542@merlins.org>
 <CAEzrpqe9Kh7k6n_ohyjgeMm4Pvy6tNCoKBXBPKhtcC5CrVfexw@mail.gmail.com>
 <20220501045456.GL12542@merlins.org>
 <CAEzrpqe-92ZV-YqL8v9z1TV4wnqbVUjroTMsvC86z6Vws3Rb6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqe-92ZV-YqL8v9z1TV4wnqbVUjroTMsvC86z6Vws3Rb6A@mail.gmail.com>
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

On Sun, May 01, 2022 at 07:28:10AM -0400, Josef Bacik wrote:
> > processed 81920 of 109445120 possible bytes
> > Recording extents for root 165299
> > processed 16384 of 75792384 possible bytes
> > Recording extents for root 18446744073709551607
> > processed 16384 of 16384 possible bytes
> > doing block accounting
> > doing close???
> 
> Ok must be in the block accounting stuff which has 0 prints, fixed
> that up.  Thanks,

Recording extents for root 18446744073709551607
processed 16384 of 16384 possible bytes
doing block accounting
ERROR: update block group failed
FIX BLOCK ACCOUNTING FAILED -1
ERROR: The commit failed???? -1

doing close???
ERROR: commit_root already set when starting transaction
extent buffer leak: start

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

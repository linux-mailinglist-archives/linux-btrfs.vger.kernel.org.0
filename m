Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EEC52751B
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 May 2022 05:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiEOC5K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 May 2022 22:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiEOC5H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 May 2022 22:57:07 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDD23EA96
        for <linux-btrfs@vger.kernel.org>; Sat, 14 May 2022 19:57:06 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:50616 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nq4RM-0007QV-Aa by authid <merlins.org> with srv_auth_plain; Sat, 14 May 2022 19:57:04 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nq4RL-000rvM-Vx; Sat, 14 May 2022 19:57:04 -0700
Date:   Sat, 14 May 2022 19:57:03 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220515025703.GA13006@merlins.org>
References: <20220511000815.GK12542@merlins.org>
 <CAEzrpqcPdf8kNjywtGY-OKDAm-87o+1QDh0qX+0mOSV3D4WEqQ@mail.gmail.com>
 <20220511014827.GL12542@merlins.org>
 <CAEzrpqfzXn0sZNVDud4UfysxvF4mgbq_a_ToJioDFz2wE-d3Rw@mail.gmail.com>
 <20220511150319.GM29107@merlins.org>
 <CAEzrpqcT0fObDa8XFWtvzeqCKom42t5o+xE9atmFjWyHCHmb=g@mail.gmail.com>
 <20220511160009.GN12542@merlins.org>
 <CAEzrpqdO4FX0A1b9xYycJQuMsvzUegSLcze4hpkMOD9dn2F-pQ@mail.gmail.com>
 <20220513144113.GA16501@merlins.org>
 <CAEzrpqfYg=Zf_GYjyvc+WZsnoCjiPTAS-08C_rB=gey74DGUqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfYg=Zf_GYjyvc+WZsnoCjiPTAS-08C_rB=gey74DGUqA@mail.gmail.com>
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

On Fri, May 13, 2022 at 12:16:02PM -0400, Josef Bacik wrote:
> Once Sarah is asleep I'll look at the code, we can probably make this
> go faster, but you've got a lot of data so I expect it's going to take
> some time.  Thanks,

It's still running on my side, almost 4 days. Is there any way to know
whether I'm close to 100%, or not really?

numbers go up and down, so it's not converging towards a bigger number.

checksum verify failed on 12511716491264 wanted 0xb8b7d979 found 0xca46ff1e
checksum verify failed on 12511716409344 wanted 0x67a73a8d found 0xbdc10807
checksum verify failed on 12511716638720 wanted 0x001ed505 found 0x4af8413f
checksum verify failed on 12511724437504 wanted 0x275e729d found 0xe4908156
checksum verify failed on 13577574744064 wanted 0x93a1e209 found 0x29d35de7
checksum verify failed on 12512041566208 wanted 0xe16cec19 found 0xbb3739bd
checksum verify failed on 913014784 wanted 0x4c3d9d32 found 0x561dcfd3
checksum verify failed on 15646027530240 wanted 0x9969c0a6 found 0x7dfb22f6
checksum verify failed on 9227783651328 wanted 0xc6a441d7 found 0x7b82e991
checksum verify failed on 9227783700480 wanted 0x03f1307a found 0xd2d1a1c4
checksum verify failed on 9227817467904 wanted 0x253e13f0 found 0xb2ca98f5
checksum verify failed on 12511748128768 wanted 0x5a02792e found 0x2fd56fdb
(...)
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

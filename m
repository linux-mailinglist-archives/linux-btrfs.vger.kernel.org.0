Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0D1651251
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Dec 2022 20:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiLSTAA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Dec 2022 14:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiLSS7b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Dec 2022 13:59:31 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF63315F13
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Dec 2022 10:58:08 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2BJIuwmm007412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 13:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1671476220; bh=RFYpf1lUt2kjrcfQ+/2ycS2gcHCJh59ToZCUVIUKSuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=J4iaKh88PbnWNk/7khBmPPvJOFuKlhoVNrt2P9Q+TdSzGo2hnK3I5kGUjEdiqpwtm
         QvpSWcWA7pW0ckyZnVX7xqn1o9ewfdnDjS3ddKH1MRiiPhcnoHpJTg3EaRldt0XTeE
         VQuNd3ewg4y3FfXHe00MiKlVZvuzjGKcBwl5bY8R5IElL0xitl8S2f+/Mp0hGk+i4J
         wGcMwDcYHO708nTWW7D2meIu8KpythaHUwo/u5hWfvhaKzvca3ZdO8GJ/GGJT5IApt
         bsCD5hbWcgLXc1EOdkfvUflp/mtpxAED+BulqiY9/A4TnpqNuW+fkhe2wT0uwcMifE
         t9mCMvbbvlvwA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A5F3B15C3511; Mon, 19 Dec 2022 13:56:58 -0500 (EST)
Date:   Mon, 19 Dec 2022 13:56:58 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: report: always save the dmesg as system-err if
 KEEP_DMESG is set
Message-ID: <Y6Cz+trxF6JtubwN@mit.edu>
References: <20221216065121.30181-1-wqu@suse.com>
 <Y6Ch1Qq9op2tmB1U@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6Ch1Qq9op2tmB1U@magnolia>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 19, 2022 at 09:39:33AM -0800, Darrick J. Wong wrote:
> On Fri, Dec 16, 2022 at 02:51:21PM +0800, Qu Wenruo wrote:
> > When KEEP_DMESG is set to "yes", we will always save the dmesg of any
> > test case (no matter if it passed or not) into "$seqnum.dmesg".
> > 
> > But this KEEP_DMESG behavior doesn't affect xunit report.
> > 
> > This patch will make xunit report to follow KEEP_DMESG setting.

This may be dangerous; if the XML file is too large, the XML parser
may end up rejecting the whole XML file because otherwlse a too-large
XML file can trigger a denial of service attack[1].  (This is why I
implemented "xunit-quiet".)

[1] https://gitlab.com/gitlab-org/gitlab/-/issues/25357

So if you are running a large number of tests (e.g., "-g auto") it
might very well that adding dmesg for all tests might very well end up
bloating the XML file to the point where it will be unmangeable.  For
example, this is the size for my syslog file after running "-g auto"
on the "xfs/quota" config:

-rw-r----- 1 tytso primarygroup 10316684 Aug 25 10:35 ae/syslog

The syslog file for all of the xfs configs are 9-10 megabytes each.
If I combined the 12 xfs configs that we run into a single xunit JML
file with the dmesg output, this would be *guaranteed* to blow out
most XML parsers.

Personally, I find that a better solution is to use the syslog daemon
to save the dmesg output for all of the tests into a single file.  I
prefer this for three reasons:

  * The single file is more compressibls compared to having it broken
    out into separate $seqnum.dmesg files.
  * By keeping dmesg and other test artifacts separate from the xml
    file I can archive the xml file for a much larger period of time,
    (perhaps indefinitely) while allowing the much more volunumous
    test artifacts to be archived for a shorter time (say, 3-6 months).
  * When there are test isolation issues, it's not uncommon for a
    previous test to fail with some kind of global or cgroup-specific
    OOM-kill, or when I'm testing on bare metal with real hardware
    where hardware failures is a Thing, being able to look for unusual
    kernel messages before the start of a particular test can often be
    quite revealing.  
    
Cheers,

						- Ted

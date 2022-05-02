Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A5C5177C6
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 22:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385725AbiEBUMU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 16:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381589AbiEBUMT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 16:12:19 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31BCBC9C
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 13:08:49 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58376 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nlcLh-0007UH-5z by authid <merlins.org> with srv_auth_plain; Mon, 02 May 2022 13:08:49 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nlcLg-00HFTo-Vs; Mon, 02 May 2022 13:08:48 -0700
Date:   Mon, 2 May 2022 13:08:48 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220502200848.GR12542@merlins.org>
References: <20220430231115.GJ12542@merlins.org>
 <CAEzrpqe9Kh7k6n_ohyjgeMm4Pvy6tNCoKBXBPKhtcC5CrVfexw@mail.gmail.com>
 <20220501045456.GL12542@merlins.org>
 <CAEzrpqe-92ZV-YqL8v9z1TV4wnqbVUjroTMsvC86z6Vws3Rb6A@mail.gmail.com>
 <20220501152231.GM12542@merlins.org>
 <CAEzrpqeiWrW6NbWLmUiWwE96sVNb+H0bEXmaij1K-HJQ38vL7w@mail.gmail.com>
 <20220502012528.GA29107@merlins.org>
 <CAEzrpqdWyOivUQ3ZtE2DS-ME7=Fs_UJN=nzA_VhosS5o3bZ+Uw@mail.gmail.com>
 <20220502173459.GP12542@merlins.org>
 <CAEzrpqdK1oshgULiR8z-DhJ71vOfXJz3aZNTJRJ1xeu3Bmz9-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdK1oshgULiR8z-DhJ71vOfXJz3aZNTJRJ1xeu3Bmz9-A@mail.gmail.com>
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

On Mon, May 02, 2022 at 03:07:09PM -0400, Josef Bacik wrote:
> > Sure thing:
> > Recording extents for root 165299
> > processed 16384 of 75792384 possible bytes
> > Recording extents for root 18446744073709551607
> > processed 16384 of 16384 possible bytes
> > doing block accounting
> > couldn't find a block group at bytenr 15847955365888 total left 1073217536
> > ERROR: update block group failed 15847955365888 1073217536 ret -1
> > FIX BLOCK ACCOUNTING FAILED -1
> > ERROR: The commit failed???? -1
> >
> > doing close???
> > ERROR: commit_root already set when starting transaction
> > extent buffer leak: start 13576823767040 len 16384
> > Init extent tree failed
> >
> 
> Wtf, that's definitely in the range of block groups that I've seen
> printed.  I added some more stuff, hoping the tree search is just
> broken.  Thanks,

Recording extents for root 163303
processed 81920 of 75792384 possible bytes
inserting block group 15731991248896
inserting block group 15733064990720
inserting block group 15734138732544
inserting block group 15735212474368
inserting block group 15736286216192
inserting block group 15737359958016
inserting block group 15738433699840
inserting block group 15739507441664
inserting block group 15740581183488
inserting block group 15741654925312
inserting block group 15742728667136
inserting block group 15743802408960
inserting block group 15744876150784
inserting block group 15745949892608
inserting block group 15747023634432
inserting block group 15748097376256
inserting block group 15749171118080
inserting block group 15750244859904
inserting block group 15751318601728
inserting block group 15752392343552
inserting block group 15753466085376
inserting block group 15754539827200
inserting block group 15755613569024
inserting block group 15756687310848
inserting block group 15757761052672
inserting block group 15758834794496
inserting block group 15759908536320
inserting block group 15760982278144
inserting block group 15762056019968
inserting block group 15763129761792
inserting block group 15764203503616
inserting block group 15765277245440
inserting block group 15766350987264
inserting block group 15767424729088
inserting block group 15768498470912
inserting block group 15769572212736
inserting block group 15770645954560
inserting block group 15771719696384
inserting block group 15778162147328
inserting block group 15779235889152
inserting block group 15780309630976
inserting block group 15781383372800
inserting block group 15782457114624
inserting block group 15783530856448
inserting block group 15784604598272
inserting block group 15785678340096
inserting block group 15786752081920
inserting block group 15787825823744
inserting block group 15788899565568
inserting block group 15789973307392
inserting block group 15791047049216
inserting block group 15792120791040
inserting block group 15793194532864
inserting block group 15794268274688
inserting block group 15795342016512
inserting block group 15796415758336
inserting block group 15797489500160
inserting block group 15798563241984
inserting block group 15799636983808
inserting block group 15800710725632
inserting block group 15801784467456
inserting block group 15802858209280
inserting block group 15803931951104
inserting block group 15809300660224
inserting block group 15810374402048
inserting block group 15811448143872
inserting block group 15812521885696
inserting block group 15813595627520
inserting block group 15814669369344
inserting block group 15815743111168
inserting block group 15816816852992
inserting block group 15817890594816
inserting block group 15818964336640
inserting block group 15820038078464
inserting block group 15821111820288
inserting block group 15822185562112
cache 15738433699840 15739507441664 in range no
cache 15739507441664 15740581183488 in range no
cache 15740581183488 15741654925312 in range no
cache 15741654925312 15742728667136 in range no
cache 15742728667136 15743802408960 in range no
cache 15743802408960 15744876150784 in range no
cache 15744876150784 15745949892608 in range no
cache 15745949892608 15747023634432 in range no
cache 15747023634432 15748097376256 in range no
cache 15748097376256 15749171118080 in range no
cache 15749171118080 15750244859904 in range no
cache 15750244859904 15751318601728 in range no
cache 15751318601728 15752392343552 in range no
cache 15752392343552 15753466085376 in range no
cache 15753466085376 15754539827200 in range no
cache 15754539827200 15755613569024 in range no
cache 15755613569024 15756687310848 in range no
cache 15756687310848 15757761052672 in range no
cache 15757761052672 15758834794496 in range no
cache 15758834794496 15759908536320 in range no
cache 15759908536320 15760982278144 in range no
cache 15760982278144 15762056019968 in range no
cache 15762056019968 15763129761792 in range no
cache 15763129761792 15764203503616 in range no
cache 15764203503616 15765277245440 in range no
cache 15765277245440 15766350987264 in range no
cache 15766350987264 15767424729088 in range no
cache 15767424729088 15768498470912 in range no
cache 15768498470912 15769572212736 in range no
cache 15769572212736 15770645954560 in range no
cache 15770645954560 15771719696384 in range no
cache 15771719696384 15772793438208 in range no
cache 15778162147328 15779235889152 in range no
cache 15779235889152 15780309630976 in range no
cache 15780309630976 15781383372800 in range no
cache 15781383372800 15782457114624 in range no
cache 15782457114624 15783530856448 in range no
cache 15783530856448 15784604598272 in range no
cache 15784604598272 15785678340096 in range no
cache 15785678340096 15786752081920 in range no
cache 15786752081920 15787825823744 in range no
cache 15787825823744 15788899565568 in range no
cache 15788899565568 15789973307392 in range no
cache 15789973307392 15791047049216 in range no
cache 15791047049216 15792120791040 in range no
cache 15792120791040 15793194532864 in range no
cache 15793194532864 15794268274688 in range no
cache 15794268274688 15795342016512 in range no
cache 15795342016512 15796415758336 in range no
cache 15796415758336 15797489500160 in range no
cache 15797489500160 15798563241984 in range no
cache 15798563241984 15799636983808 in range no
cache 15799636983808 15800710725632 in range no
cache 15800710725632 15801784467456 in range no
cache 15801784467456 15802858209280 in range no
cache 15802858209280 15803931951104 in range no
cache 15803931951104 15805005692928 in range no
cache 15809300660224 15810374402048 in range no
cache 15810374402048 15811448143872 in range no
cache 15811448143872 15812521885696 in range no
cache 15812521885696 15813595627520 in range no
cache 15813595627520 15814669369344 in range no
cache 15814669369344 15815743111168 in range no
cache 15815743111168 15816816852992 in range no
cache 15816816852992 15817890594816 in range no
cache 15817890594816 15818964336640 in range no
cache 15818964336640 15820038078464 in range no
cache 15820038078464 15821111820288 in range no
cache 15821111820288 15822185562112 in range no
cache 15822185562112 15823259303936 in range no
cache 15823259303936 15824333045760 in range no
cache 15824333045760 15825406787584 in range no
cache 15825406787584 15826480529408 in range no
cache 15826480529408 15827554271232 in range no
cache 15827554271232 15828628013056 in range no
cache 15828628013056 15829701754880 in range no
cache 15829701754880 15830775496704 in range no
cache 15830775496704 15831849238528 in range no
cache 15831849238528 15832922980352 in range no
cache 15832922980352 15833996722176 in range no
cache 15833996722176 15835070464000 in range no
cache 15835070464000 15836144205824 in range no
cache 15836144205824 15837217947648 in range no
cache 15837217947648 15838291689472 in range no
cache 15838291689472 15839365431296 in range no
cache 15839365431296 15840439173120 in range no
cache 15840439173120 15841512914944 in range no
cache 15842586656768 15843660398592 in range no
ERROR: update block group failed 15847955365888 1073217536 ret -1
FIX BLOCK ACCOUNTING FAILED -1
ERROR: The commit failed???? -1

doing close???
ERROR: commit_root already set when starting transaction
extent buffer leak: start 13576823816192 len 16384
Init extent tree failed

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

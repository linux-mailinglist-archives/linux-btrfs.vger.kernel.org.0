Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461CB542254
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiFHFK5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 01:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiFHFKH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 01:10:07 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BFC1CE783
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 19:12:46 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nylBd-0004K9-6V by authid <merlin>; Tue, 07 Jun 2022 19:12:45 -0700
Date:   Tue, 7 Jun 2022 19:12:45 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220608021245.GD22722@merlins.org>
References: <20220607204406.GX22722@merlins.org>
 <CAEzrpqccYbdBNs6gYDzZRw17D1O6tPU=9w1vLvDVOjJeMDuazw@mail.gmail.com>
 <20220607212523.GZ22722@merlins.org>
 <CAEzrpqex0PRGZA3_gaoUhpPb-7cpi-gi_mo1S3F=0xxKNptpEA@mail.gmail.com>
 <20220607233734.GA22722@merlins.org>
 <CAEzrpqcVO99HbrhmtABUENRCm4HEsyg3+T3oK33DZFuXamwqgA@mail.gmail.com>
 <20220608000700.GB22722@merlins.org>
 <CAEzrpqe79F=-0T7Q3dqb62J6+kcisOjnWP+aLkkY0z+EJY-m9Q@mail.gmail.com>
 <20220608004241.GC22722@merlins.org>
 <CAEzrpqdq8zTBQaw_VneL4rfZn0JseUiwvtfwXQx0jq=DYBCFFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdq8zTBQaw_VneL4rfZn0JseUiwvtfwXQx0jq=DYBCFFw@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 07, 2022 at 09:31:28PM -0400, Josef Bacik wrote:
> > doing close???
> > extent buffer leak: start 11160502779904 len 16384
> > extent buffer leak: start 15645018308608 len 16384
> > Init extent tree failed
> 
> I swear first thing I'm doing after all this is updating the shared
> code.  Try again please,

It went farther:

processed 163840 of 1064960 possible bytes, 15%
Recording extents for root 5
processed 65536 of 10960896 possible bytes, 0%
Recording extents for root 7
processed 16384 of 16570974208 possible bytes, 0%
Recording extents for root 9
processed 16384 of 16384 possible bytes, 100%
Recording extents for root 161197
processed 131072 of 108986368 possible bytes, 0%
Recording extents for root 161199
processed 196608 of 49479680 possible bytes, 0%
Recording extents for root 161200
processed 180224 of 254214144 possible bytes, 0%
Recording extents for root 161889
processed 196608 of 49446912 possible bytes, 0%
Recording extents for root 162628
processed 49152 of 49463296 possible bytes, 0%
Recording extents for root 162632
processed 114688 of 94633984 possible bytes, 0%
Recording extents for root 163298
processed 49152 of 49463296 possible bytes, 0%
Recording extents for root 163302
processed 98304 of 94633984 possible bytes, 0%
Recording extents for root 163303
processed 131072 of 76333056 possible bytes, 0%
Recording extents for root 163316
processed 98304 of 108544000 possible bytes, 0%
Recording extents for root 163920
processed 16384 of 108691456 possible bytes, 0%
Recording extents for root 164620
processed 49152 of 49463296 possible bytes, 0%
Recording extents for root 164623
processed 311296 of 63193088 possible bytes, 0%
Recording extents for root 164624
processed 933888 of 108822528 possible bytes, 0%
Recording extents for root 164629
processed 622592 of 108838912 possible bytes, 0%
Recording extents for root 164631
processed 16384 of 49430528 possible bytes, 0%
Recording extents for root 164633
processed 16384 of 75694080 possible bytes, 0%
Recording extents for root 164823
processed 131072 of 63193088 possible bytes, 0%
Recording extents for root 18446744073709551607
processed 16384 of 16384 possible bytes, 100%
doing block accounting
couldn't find a block group at bytenr 20971520 total left 180224
cache 11106814787584 11107888529408 in range no
cache 11108962271232 11110036013056 in range no
cache 11110036013056 11111109754880 in range no
(...)
cache 15929559744512 15930633486336 in range no
cache 15930633486336 15931707228160 in range no
cache 15931707228160 15932780969984 in range no
cache 15932780969984 15933854711808 in range no
cache 15933854711808 15934928453632 in range no
ERROR: update block group failed 20971520 180224 ret -1
FIX BLOCK ACCOUNTING FAILED -1
ERROR: The commit failed???? -1

doing close???
ERROR: commit_root already set when starting transaction
extent buffer leak: start 15645020913664 len 16384
Init extent tree failed

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB8C542610
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiFHEIG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 00:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiFHEGV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 00:06:21 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C36729DC19
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 18:24:31 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nyjmT-0003WE-Je by authid <merlin>; Tue, 07 Jun 2022 17:42:41 -0700
Date:   Tue, 7 Jun 2022 17:42:41 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220608004241.GC22722@merlins.org>
References: <20220607195744.GV22722@merlins.org>
 <CAEzrpqdp7JUPvpGrbctiLQY_qZpks7HyOSg4eNY=5xifErzy3A@mail.gmail.com>
 <20220607204406.GX22722@merlins.org>
 <CAEzrpqccYbdBNs6gYDzZRw17D1O6tPU=9w1vLvDVOjJeMDuazw@mail.gmail.com>
 <20220607212523.GZ22722@merlins.org>
 <CAEzrpqex0PRGZA3_gaoUhpPb-7cpi-gi_mo1S3F=0xxKNptpEA@mail.gmail.com>
 <20220607233734.GA22722@merlins.org>
 <CAEzrpqcVO99HbrhmtABUENRCm4HEsyg3+T3oK33DZFuXamwqgA@mail.gmail.com>
 <20220608000700.GB22722@merlins.org>
 <CAEzrpqe79F=-0T7Q3dqb62J6+kcisOjnWP+aLkkY0z+EJY-m9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqe79F=-0T7Q3dqb62J6+kcisOjnWP+aLkkY0z+EJY-m9Q@mail.gmail.com>
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

On Tue, Jun 07, 2022 at 08:32:33PM -0400, Josef Bacik wrote:
> > processed 622592 of 108838912 possible bytes, 0%
> > Recording extents for root 164631
> > ERROR: failed to insert the ref for the root block -17
> > wtf
> > it failed?? -17
> 
> That shouldn't happen.  I reworked the code a bit and added some
> debugging, re-run init-extent-tree please.  Thanks,

processed 196608 of 63193088 possible bytes, 0%
searching 18446744073709551607 for bad extents
processed 16384 of 16384 possible bytes, 100%
Recording extents for root 3
processed 180224 of 0 possible bytes, 0%
Recording extents for root 1
ERROR: commit_root already set when starting transaction
ERROR: error starting transaction
doing close???
extent buffer leak: start 11160502779904 len 16384
extent buffer leak: start 15645018308608 len 16384
Init extent tree failed

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  

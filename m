Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8312153B1A4
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 04:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiFBBz3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 21:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiFBBz2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 21:55:28 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D093325F434
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 18:55:27 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nwa3a-00041d-2S by authid <merlin>; Wed, 01 Jun 2022 18:55:26 -0700
Date:   Wed, 1 Jun 2022 18:55:26 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220602015526.GM22722@merlins.org>
References: <20220601214054.GH22722@merlins.org>
 <CAEzrpqduFy+7LkgWyyEnvYLgdJU6zDEWv25JM-niOg9tjmZ3Nw@mail.gmail.com>
 <20220601223639.GI22722@merlins.org>
 <CAEzrpqdfz5FMFDiBbb1mrUTXqxNvJ2RkuqJCdE2VQ6op01k61g@mail.gmail.com>
 <20220601225643.GJ22722@merlins.org>
 <CAEzrpqe7Fm8d62GnRs5EZeggkbXdsF2JCxkSOWnQAU+pzFtG9g@mail.gmail.com>
 <20220601231008.GK22722@merlins.org>
 <CAEzrpqen1AXAYBq0M0LVzB8AVXMhAD_ve1Yj_+e=kPyCfdUiow@mail.gmail.com>
 <20220602000637.GL22722@merlins.org>
 <CAEzrpqc_Z=aqbfNHL_r=8X1=-Kvdqrmdzrd04M-n=79s7Mi26A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqc_Z=aqbfNHL_r=8X1=-Kvdqrmdzrd04M-n=79s7Mi26A@mail.gmail.com>
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

On Wed, Jun 01, 2022 at 09:23:30PM -0400, Josef Bacik wrote:
> Ah ok I'm not confused anymore, try that now.  Thanks,

Better:

(...)
Found missing chunk 15672935448576-15674009190400 type 0
Found missing chunk 15772793438208-15773867180032 type 0
Found missing chunk 15773867180032-15774940921856 type 0
Found missing chunk 15774940921856-15776014663680 type 0
Found missing chunk 15776014663680-15777088405504 type 0
Found missing chunk 15777088405504-15778162147328 type 0
adding bg for 20971520 8388608
Unable to find block group for 0
Unable to find block group for 0
Unable to find block group for 0
Inserting chunk 14823605665792wtf transid 2582704 ret -28
ERROR: Couldn't insert item
doing close???
ERROR: attempt to start transaction over already running one
extent buffer leak: start 22593536 len 16384
Recover chunks tree failed
[Inferior 1 (process 1930) exited with code 0344]

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAE553BAD6
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 16:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbiFBOgI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 10:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiFBOgI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 10:36:08 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79446281850
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 07:36:07 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nwlvi-0006fQ-TC by authid <merlin>; Thu, 02 Jun 2022 07:36:06 -0700
Date:   Thu, 2 Jun 2022 07:36:06 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220602143606.GR22722@merlins.org>
References: <20220601231008.GK22722@merlins.org>
 <CAEzrpqen1AXAYBq0M0LVzB8AVXMhAD_ve1Yj_+e=kPyCfdUiow@mail.gmail.com>
 <20220602000637.GL22722@merlins.org>
 <CAEzrpqc_Z=aqbfNHL_r=8X1=-Kvdqrmdzrd04M-n=79s7Mi26A@mail.gmail.com>
 <20220602015526.GM22722@merlins.org>
 <CAEzrpqfMD1+c-datNzDWppr62NBz7vDHybeXqg55DVVDAiqAdQ@mail.gmail.com>
 <20220602021617.GP22722@merlins.org>
 <CAEzrpqfKbEvZh1td=UW6HGJ1x3htSVL1jo49KzcJPu+OSYt4jQ@mail.gmail.com>
 <20220602142112.GQ22722@merlins.org>
 <CAEzrpqdJHDte6jc7-ykD-wnuFe8_xB-Y4e97C-o5B-G-1Nnksw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdJHDte6jc7-ykD-wnuFe8_xB-Y4e97C-o5B-G-1Nnksw@mail.gmail.com>
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

On Thu, Jun 02, 2022 at 10:27:59AM -0400, Josef Bacik wrote:
> 
> Ooops, helps if I use the new flag I added.  Thanks,

Good news?

Inserting chunk 15486104371200
Inserting chunk 15487178113024
Inserting chunk 15488251854848
Inserting chunk 15671861706752
Inserting chunk 15672935448576
Inserting chunk 15772793438208
Inserting chunk 15773867180032
Inserting chunk 15774940921856
Inserting chunk 15776014663680
Inserting chunk 15777088405504
WARNING: reserved space leaked, transid=2582704 flag=0x2
bytes_reserved=180224
doing close???
WARNING: reserved space leaked, flag=0x2 bytes_reserved=180224
Recover chunks succeeded, you can run check now
[Inferior 1 (process 21907) exited normally]

What check do I run now?
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  

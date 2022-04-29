Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB88513FDA
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 02:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353409AbiD2A7m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 20:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345344AbiD2A7l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 20:59:41 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B1C4D24B
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 17:56:25 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nkEvo-0006mH-NG by authid <merlin>; Thu, 28 Apr 2022 17:56:24 -0700
Date:   Thu, 28 Apr 2022 17:56:24 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220429005624.GY29107@merlins.org>
References: <20220428162746.GR29107@merlins.org>
 <CAEzrpqcL_ZyvenVuO4re9qCS2rLnGbsiz0Wx9zUH_UaZY9uVDA@mail.gmail.com>
 <20220428202205.GT29107@merlins.org>
 <CAEzrpqfHjAn7X9tMm6jAw8NJiv3vsvYioXj9=cjMqNcXjFhSdA@mail.gmail.com>
 <20220428205716.GU29107@merlins.org>
 <CAEzrpqduAKibaDJPJ6s7dCAfQHeynwG6zJwgVXVS_Uh=cQq2dw@mail.gmail.com>
 <20220428214241.GW29107@merlins.org>
 <CAEzrpqd0deCQ132HjNJC=AKQsRTXc=shnAmHfs0BR9pWiD4mhg@mail.gmail.com>
 <20220428222705.GX29107@merlins.org>
 <CAEzrpqeQrSrMgGLh0F34fVj8dnzJQF7kv=XSBKcD92oHyV8-gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqeQrSrMgGLh0F34fVj8dnzJQF7kv=XSBKcD92oHyV8-gA@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 28, 2022 at 07:24:22PM -0400, Josef Bacik wrote:
> > inserting block group 15835070464000
> > inserting block group 15836144205824
> > inserting block group 15837217947648
> > inserting block group 15838291689472
> > inserting block group 15839365431296
> > inserting block group 15840439173120
> > inserting block group 15842586656768
> > processed 1556480 of 0 possible bytes
> > processed 49152 of 0 possible bytesadding a bytenr that overlaps our
> > thing, dumping paths for [4088, 108, 0]
> 
> Oh huh, we must not have a free space object for this, in that case lets do
> 
> ./btrfs-corrupt-block -d "4088,108,0" -r 2 /dev/whatever
> 
> and then do the init.  Thanks,

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "4088,108,0" -r 2 /dev/mapper/dshelf1
FS_INFO IS 0x558c0e536600
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x558c0e536600
Error searching to node -2

not good news I assume?

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  

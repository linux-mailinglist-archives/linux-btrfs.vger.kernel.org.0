Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446377234B7
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 03:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjFFBqv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 21:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbjFFBqt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 21:46:49 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA23127
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 18:46:39 -0700 (PDT)
Received: from svh-gw.merlins.org ([76.132.34.178]:39610 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1q6Kq1-0008Ch-Jd by authid <merlins.org> with srv_auth_plain; Mon, 05 Jun 2023 18:46:38 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1q6LmO-00CVZQ-Ss; Mon, 05 Jun 2023 18:46:36 -0700
Date:   Mon, 5 Jun 2023 18:46:36 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: How to find/reclaim missing space in volume
Message-ID: <20230606014636.GG105809@merlins.org>
References: <20230605162636.GE105809@merlins.org>
 <9bfa8bb6-b64e-d34f-f9c8-db5f9510fc29@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bfa8bb6-b64e-d34f-f9c8-db5f9510fc29@gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 76.132.34.178
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 05, 2023 at 08:00:02PM +0300, Andrei Borzenkov wrote:
> On 05.06.2023 19:26, Marc MERLIN wrote:
> > I have this:
> > sauron [mc]# df -h .
> > Filesystem         Size  Used Avail Use% Mounted on
> > /dev/mapper/pool2  1.1T  853G  212G  81% /mnt/btrfs_pool2
> > sauron [mc]# btrfs fi show .
> > Label: 'btrfs_pool2'  uuid: fde3da31-67e9-4f88-b90d-6c3f6becd56a
> > 	Total devices 1 FS bytes used 847.89GiB
> > 	devid    1 size 1.04TiB used 890.02GiB path /dev/mapper/pool2
> > sauron [mc]# btrfs fi df .
> > Data, single: total=878.00GiB, used=843.85GiB
> > System, DUP: total=8.00MiB, used=128.00KiB
> > Metadata, DUP: total=6.00GiB, used=4.04GiB
> > GlobalReserve, single: total=512.00MiB, used=0.00B
> > 
> 
> btrfs filesystem usage -T is usually more useful than both the above
> commands.
sauron:/mnt/btrfs_pool2# btrfs fi usage -T .
Overall:
    Device size:		   1.04TiB
    Device allocated:		 890.02GiB
    Device unallocated:		 177.73GiB
    Device missing:		     0.00B
    Used:			 851.85GiB
    Free (estimated):		 211.93GiB	(min: 123.07GiB)
    Data ratio:			      1.00
    Metadata ratio:		      2.00
    Global reserve:		 512.00MiB	(used: 0.00B)

                     Data      Metadata System               
Id Path              single    DUP      DUP       Unallocated
-- ----------------- --------- -------- --------- -----------
 1 /dev/mapper/pool2 878.00GiB 12.00GiB  16.00MiB   177.73GiB
-- ----------------- --------- -------- --------- -----------
   Total             878.00GiB  6.00GiB   8.00MiB   177.73GiB
   Used              843.79GiB  4.03GiB 128.00KiB      

> > sauron:/mnt/btrfs_pool2# du -sh *
> > 599G	varchange2
> > 598G	varchange2_ggm_daily_ro.20230605_07:57:43
> > 4.0K	varchange2_last
> > 599G	varchange2_ro.20230605_08:01:30
> > 599G	varchange2_ro.20230605_09:01:43
> > 
> > I'm confused, the volumes above are snapshots with mostly the same data
> > (made within the last 2 hours) and I didn't delete any data in the FS
> > (they are mostly identical and used for btfrs send/receive)
> > 
> > Why do they add up ot 600GB, but btrfs says 847FB is used?
> > 
> 
> Each subvolume references 600G but it does not mean they are the same 600G.
> If quota is enabled, "btrfs quota show" may provide some more information,
> otherwise "btrfs filesystem du" shows shared and exclusive space (you need
> to pass all subvolumes in question to correctly compute shared vs
> exclusive).

Right, I did check/know that the snapshots shared the same data, but it 
doens't hurt to confirm:

sauron:/mnt/btrfs_pool2# btrfs filesystem du -s *
     Total   Exclusive  Set shared  Filename
 597.57GiB    20.00KiB   588.75GiB  varchange2
 597.57GiB     4.00KiB   588.75GiB  varchange2_ggm_daily_ro.20230605_09:59:26
 597.57GiB       0.00B   588.75GiB  varchange2_last
 597.57GiB     4.00KiB   588.75GiB  varchange2_minly.20230605_17:30:33
 597.57GiB       0.00B   588.75GiB  varchange2_minly.20230605_17:35:32
 597.57GiB       0.00B   588.75GiB  varchange2_minly.20230605_17:40:32
 597.57GiB     4.00KiB   588.75GiB  varchange2_minly.20230605_17:45:32
 597.57GiB     4.00KiB   588.75GiB  varchange2_minly.20230605_17:50:32
 597.57GiB     4.00KiB   588.75GiB  varchange2_minly.20230605_17:55:32
 597.57GiB       0.00B   588.75GiB  varchange2_minly.20230605_18:00:32
 597.57GiB       0.00B   588.75GiB  varchange2_minly.20230605_18:05:32
 597.57GiB     8.00KiB   588.75GiB  varchange2_minly.20230605_18:10:32
 597.57GiB    16.00KiB   588.75GiB  varchange2_ro.20230605_10:01:40
 597.57GiB    12.00KiB   588.75GiB  varchange2_ro.20230605_11:01:31
 597.57GiB     4.00KiB   588.75GiB  varchange2_ro.20230605_13:01:28
 597.57GiB     4.00KiB   588.75GiB  varchange2_ro.20230605_14:01:30
 597.57GiB     4.00KiB   588.75GiB  varchange2_ro.20230605_15:01:29
 597.57GiB     4.00KiB   588.75GiB  varchange2_ro.20230605_16:01:32
 597.57GiB     4.00KiB   588.75GiB  varchange2_ro.20230605_17:01:31
 597.57GiB       0.00B   588.75GiB  varchange2_ro.20230605_18:02:02
sauron:/mnt/btrfs_pool2# df -h .
Filesystem         Size  Used Avail Use% Mounted on
/dev/mapper/pool2  1.1T  853G  212G  81% /mnt/btrfs_pool2


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

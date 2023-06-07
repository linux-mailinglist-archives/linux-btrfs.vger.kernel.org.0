Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6182C726996
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 21:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjFGTR2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 15:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjFGTR1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 15:17:27 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D161BE2
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 12:17:26 -0700 (PDT)
Received: from svh-gw.merlins.org ([76.132.34.178]:58402 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1q6xiN-0005jX-Ry by authid <merlins.org> with srv_auth_plain; Wed, 07 Jun 2023 12:17:20 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1q6yem-000BE1-07; Wed, 07 Jun 2023 12:17:20 -0700
Date:   Wed, 7 Jun 2023 12:17:19 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Roman Mamedov <rm@romanrm.net>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: How to find/reclaim missing space in volume
Message-ID: <20230607191719.GA12693@merlins.org>
References: <20230605162636.GE105809@merlins.org>
 <9bfa8bb6-b64e-d34f-f9c8-db5f9510fc29@gmail.com>
 <20230606014636.GG105809@merlins.org>
 <295ce1bb-bcd7-ebdf-96b2-230cfeff5871@gmail.com>
 <20230606164139.GK105809@merlins.org>
 <20230606232558.00583826@nvm>
 <543d7cf5-96c1-a947-6106-250527b4b830@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <543d7cf5-96c1-a947-6106-250527b4b830@gmx.com>
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

On Wed, Jun 07, 2023 at 10:12:30AM +0800, Qu Wenruo wrote:
> For the ghost subvolumes, it can be confirmed with "btrfs ins dump-tree
> -t root", then looking for ROOT_ITEMs with "refs 0".
> 
> I'm not sure if it is the case.
> 
> Another possible cause is extent bookends, this needs something like
> btrfs quota to confirm, and not much we can do if there are snapshots.
> (If no snapshots, it's possible to defrag and free up such bookend extents).

unfortunately the system rebooted overnight, so I lost the state where
sync was hung.
On the plus side, this seems to have fixed the issue:

sauron:/mnt/btrfs_pool2# btrfs fi usage -T .
Overall:
    Device size:		   1.04TiB
    Device allocated:		 857.02GiB
    Device unallocated:		 210.73GiB
    Device missing:		     0.00B
    Used:			 589.30GiB
    Free (estimated):		 470.78GiB	(min: 365.42GiB)
    Data ratio:			      1.00
    Metadata ratio:		      2.00
    Global reserve:		 512.00MiB	(used: 0.00B)

                     Data      Metadata System               
Id Path              single    DUP      DUP       Unallocated
-- ----------------- --------- -------- --------- -----------
 1 /dev/mapper/pool2 845.00GiB 12.00GiB  16.00MiB   210.73GiB
-- ----------------- --------- -------- --------- -----------
   Total             845.00GiB  6.00GiB   8.00MiB   210.73GiB
   Used              584.95GiB  2.18GiB 112.00KiB            
sauron:/mnt/btrfs_pool2# df -h .
Filesystem         Size  Used Avail Use% Mounted on
/dev/mapper/pool2  1.1T  590G  471G  56% /mnt/btrfs_pool2

I know it's hard to say after the fact, but have you seen issues where snapshot delete
space cleanup would get stuck and 
btrfs subvolume sync `pwd`
would hang forever (until reboot) ?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

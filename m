Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EB4722C73
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 18:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjFEQ0k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 12:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjFEQ0j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 12:26:39 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66087CD
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 09:26:38 -0700 (PDT)
Received: from svh-gw.merlins.org ([76.132.34.178]:53128 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1q6C64-0002Oz-Lh by authid <merlins.org> with srv_auth_plain; Mon, 05 Jun 2023 09:26:37 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1q6D2S-00BghS-Qb; Mon, 05 Jun 2023 09:26:36 -0700
Date:   Mon, 5 Jun 2023 09:26:36 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     linux-btrfs@vger.kernel.org
Subject: How to find/reclaim missing space in volume
Message-ID: <20230605162636.GE105809@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 76.132.34.178
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have this:
sauron [mc]# df -h .
Filesystem         Size  Used Avail Use% Mounted on
/dev/mapper/pool2  1.1T  853G  212G  81% /mnt/btrfs_pool2
sauron [mc]# btrfs fi show .
Label: 'btrfs_pool2'  uuid: fde3da31-67e9-4f88-b90d-6c3f6becd56a
	Total devices 1 FS bytes used 847.89GiB
	devid    1 size 1.04TiB used 890.02GiB path /dev/mapper/pool2
sauron [mc]# btrfs fi df .
Data, single: total=878.00GiB, used=843.85GiB
System, DUP: total=8.00MiB, used=128.00KiB
Metadata, DUP: total=6.00GiB, used=4.04GiB
GlobalReserve, single: total=512.00MiB, used=0.00B


sauron:/mnt/btrfs_pool2# du -sh *
599G	varchange2
598G	varchange2_ggm_daily_ro.20230605_07:57:43
4.0K	varchange2_last
599G	varchange2_ro.20230605_08:01:30
599G	varchange2_ro.20230605_09:01:43

I'm confused, the volumes above are snapshots with mostly the same data
(made within the last 2 hours) and I didn't delete any data in the FS
(they are mostly identical and used for btfrs send/receive)

Why do they add up ot 600GB, but btrfs says 847FB is used?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

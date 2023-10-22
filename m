Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B947D2376
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Oct 2023 16:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjJVO6v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Oct 2023 10:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjJVO6u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Oct 2023 10:58:50 -0400
X-Greylist: delayed 513 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 Oct 2023 07:58:47 PDT
Received: from shin.romanrm.net (shin.romanrm.net [146.185.199.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDC7E1
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Oct 2023 07:58:47 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by shin.romanrm.net (Postfix) with SMTP id B52333FA15;
        Sun, 22 Oct 2023 14:50:08 +0000 (UTC)
Date:   Sun, 22 Oct 2023 19:50:06 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Reindl Harald <h.reindl@thelounge.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: BTRF: no free space
Message-ID: <20231022195006.7915ea1a@nvm>
In-Reply-To: <2856c6f2-8d3c-412b-a012-a8151a4b1392@thelounge.net>
References: <2856c6f2-8d3c-412b-a012-a8151a4b1392@thelounge.net>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, 22 Oct 2023 12:43:57 +0200
Reindl Harald <h.reindl@thelounge.net> wrote:

> this is a *new* filesystem and somewhere in the middle of the night at 
> 10% usage a large rsync stopped because BTRF thinks the filesystem is 
> full - how is this possible in 2023?
> 
> Metadata, DUP: total=1.00GiB, used=945.61MiB
> 
> -----------------
> 
> defaults,noatime,compress-force=zstd:15,ssd,ssd_spread,nodiscard,nobarrier,noexec,nosuid,nodev,commit=60
> 
> adding "clear_cache" which solved such issues in the past eve refuses to 
> mount it
> 
> [root@arrakisvm:~]$ mount /mnt/fileserver-backup/
> mount: /mnt/fileserver-backup: mount(2) system call failed: No space 
> left on device.
> 
> -----------------
> 
> [root@arrakisvm:~]$ df
> Filesystem     Type   Size  Used Avail Use% Mounted on
> /dev/sdd1      btrfs  2.0T  209G     0 100% /mnt/fileserver-backup
> 
> [root@arrakisvm:~]$ btrfs fi df /mnt/fileserver-backup
> Data, single: total=1.95TiB, used=207.05GiB
> System, DUP: total=8.00MiB, used=224.00KiB
> Metadata, DUP: total=1.00GiB, used=945.61MiB
> GlobalReserve, single: total=512.00MiB, used=0.00B

1) Report your kernel version

2) Retry without "ssd" and especially without "ssd_spread". The weird thing
here is that it appears the FS has allocated the entire unused space as "data"
chunks, leaving no space for any new metadata chunk. Personally I don't have
any other guess for the cause aside from the rarely-used (and little-tested?)
ssd_spread option. Of course still a bug even if so.

-- 
With respect,
Roman

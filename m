Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2B47D23C6
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Oct 2023 17:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjJVPtY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Oct 2023 11:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVPtX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Oct 2023 11:49:23 -0400
X-Greylist: delayed 3548 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 Oct 2023 08:49:20 PDT
Received: from shin.romanrm.net (shin.romanrm.net [IPv6:2a11:27c0:1f5::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFC2A7
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Oct 2023 08:49:20 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by shin.romanrm.net (Postfix) with SMTP id B70373FA15;
        Sun, 22 Oct 2023 15:49:17 +0000 (UTC)
Date:   Sun, 22 Oct 2023 20:49:17 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Reindl Harald <h.reindl@thelounge.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: BTRF: no free space
Message-ID: <20231022204917.7744389f@nvm>
In-Reply-To: <62e47536-671a-4ef1-a703-27be2692b124@thelounge.net>
References: <2856c6f2-8d3c-412b-a012-a8151a4b1392@thelounge.net>
        <20231022195006.7915ea1a@nvm>
        <62e47536-671a-4ef1-a703-27be2692b124@thelounge.net>
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

On Sun, 22 Oct 2023 17:40:05 +0200
Reindl Harald <h.reindl@thelounge.net> wrote:

> >> [root@arrakisvm:~]$ btrfs fi df /mnt/fileserver-backup
> >> Data, single: total=1.95TiB, used=207.05GiB
> >> System, DUP: total=8.00MiB, used=224.00KiB
> >> Metadata, DUP: total=1.00GiB, used=945.61MiB
> >> GlobalReserve, single: total=512.00MiB, used=0.00B
> > 
> > 1) Report your kernel version
> 
> 6.5.7-100.fc37.x86_64
> 
> > 2) Retry without "ssd" and especially without "ssd_spread". The weird thing
> > here is that it appears the FS has allocated the entire unused space as "data"
> > chunks, leaving no space for any new metadata chunk. Personally I don't have
> > any other guess for the cause aside from the rarely-used (and little-tested?)
> > ssd_spread option. Of course still a bug even if so.
> 
> no - it allocated METADATA
> Metadata, DUP: total=1.00GiB, used=945.61MiB

In your output I see that 1.95 TB was allocated for data chunks, even if only
207 GB of those are used for actual data. My guess was that this was
preventing the creation of one more metadata chunk when it was needed, which
broke everything.


-- 
With respect,
Roman

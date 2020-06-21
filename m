Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C91202BFB
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Jun 2020 20:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgFUSTe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Jun 2020 14:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbgFUSTd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Jun 2020 14:19:33 -0400
Received: from tartarus.angband.pl (tartarus.angband.pl [IPv6:2001:41d0:602:dbe::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8753BC061794
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Jun 2020 11:19:32 -0700 (PDT)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1jn4Yx-0004L9-NB
        for linux-btrfs@vger.kernel.org; Sun, 21 Jun 2020 20:19:27 +0200
Date:   Sun, 21 Jun 2020 20:19:27 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     linux-btrfs@vger.kernel.org
Subject: Re: weekly fstrim (still) necessary?
Message-ID: <20200621181927.GA16529@angband.pl>
References: <20200621054240.GA25387@tik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200621054240.GA25387@tik.uni-stuttgart.de>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 21, 2020 at 07:42:40AM +0200, Ulli Horlacher wrote:
> On SLES a weekly fstrim is done via a btrfsmaintenance script, which is
> missing on Ubuntu.
> 
> For ext4 filesystem an explicite fstrim call is no longer neccessary, what
> about btrfs?
> Shall I call fstrim via /etc/cron.weekly ?

Both ext4 and btrfs may or may not auto-discard in the write path, depending
on mount option.  A lot of disks handle such frequent small discards poorly
-- usually with a greatly decreased performance, although data loss in not
unknown.

If you test your disk and know that it is happy with tons of small discards,
then the discard mount option is good for you.  Otherwise, you want to do
large discards once in a while -- be it a day or a week.

Not discarding at all is a bad idea on most disks.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ in the beginning was the boot and root floppies and they were good.
⢿⡄⠘⠷⠚⠋⠀                                       -- <willmore> on #linux-sunxi
⠈⠳⣄⠀⠀⠀⠀

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D2544A4FE
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 03:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241949AbhKIC5X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 21:57:23 -0500
Received: from tartarus.angband.pl ([51.83.246.204]:56324 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241851AbhKIC5V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 21:57:21 -0500
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1mkHFI-00A1HG-ST
        for linux-btrfs@vger.kernel.org; Tue, 09 Nov 2021 03:52:24 +0100
Date:   Tue, 9 Nov 2021 03:52:24 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     linux-btrfs@vger.kernel.org
Subject: Bug#998840: Strange warning when deleting subvolume as non-root user
Message-ID: <YYniaHjEO9ssCiGq@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

----- Forwarded message from Boris Kolpackov <boris@codesynthesis.com> -----
Date: Mon, 8 Nov 2021 16:01:53 +0200
From: Boris Kolpackov <boris@codesynthesis.com>
Subject: Bug#998840: Strange warning when deleting subvolume as non-root user

Package: btrfs-progs
Version: 5.14.1-1

After upgrading from btrfs-progs 5.7-1 with Linux kernel 5.7.6 to
btrfs-progs 5.14.1-1 with Linux kernel 5.14.9-2 (from current testing)
I see the following strange new warning when deleting the subvolume as
non-root user (the filesystem is mounted with user_subvol_rm_allowed):

WARNING: cannot read default subvolume id: Operation not permitted

The subvolume deletion succeeds.

To reproduce, mount a btrfs filesystem with user_subvol_rm_allowed,
say, on /mnt and then (assuming non-root user is called nonroot):

# chown nonroot:nonroot /mnt
# su - nonroot
$ cd /mnt
$ btrfs subvol create test
Create subvolume './test'
$ btrfs subvol delete test
WARNING: cannot read default subvolume id: Operation not permitted
Delete subvolume (no-commit): '/mnt/test'

Any idea what's going on here and how to get rid of this warning?
It adds quite a bit of noise to our logs.


----- End forwarded message -----


Reproduces for me both on 5.14 kernel+progs and 5.15.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ Vat kind uf sufficiently advanced technology iz dis!?
⢿⡄⠘⠷⠚⠋⠀                                 -- Genghis Ht'rok'din
⠈⠳⣄⠀⠀⠀⠀

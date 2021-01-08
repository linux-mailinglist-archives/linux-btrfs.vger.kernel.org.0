Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4242EEE31
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jan 2021 08:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbhAHH5G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 8 Jan 2021 02:57:06 -0500
Received: from mail.eclipso.de ([217.69.254.104]:39116 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbhAHH5G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 Jan 2021 02:57:06 -0500
Received: from mail.eclipso.de (www1.eclipso.de [217.69.254.102])
        by mail.eclipso.de with ESMTP id 1E7FEF80
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Jan 2021 08:56:24 +0100 (CET)
Date:   Fri, 08 Jan 2021 08:56:24 +0100
MIME-Version: 1.0
Message-ID: <e0efe804fd52b0838bf69b01f6e7a784@mail.eclipso.de>
X-Mailer: eclipso / 7.4.0
From:   " " <Cedric.dewijs@eclipso.eu>
Subject: should btrfs reserve some space for root, so a normal user can't cause
        "no space left" problems?
Reply-To: " " <Cedric.dewijs@eclipso.eu>
To:     <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have done a test where I filled up an entire btrfs raid 1 filesystem as a normal user. Then I simulated a failing drive. it turned out I was unable to replace the drive, as raid1 need free space on both drives. See this mail for details [1]

I can understand the technical reasoning behind the requirement of both drives having some free space. But why does btrfs by default allow a normal, non root user to completely fill up the drive? Maybe it's a good idea to reserve some blocks on the filesystem that are only available for the root user, much like ext4 does that (via tune2fs [-m reserved_blocks_percent] and [-r reserved_blocks_count])

[1] https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg92550.html

---

Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!



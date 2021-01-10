Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722D62F0676
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Jan 2021 11:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbhAJKfJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 10 Jan 2021 05:35:09 -0500
Received: from mail.eclipso.de ([217.69.254.104]:56116 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbhAJKfI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Jan 2021 05:35:08 -0500
Received: from mail.eclipso.de (www1.eclipso.de [217.69.254.102])
        by mail.eclipso.de with ESMTP id 2B0AFF34
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Jan 2021 11:34:27 +0100 (CET)
Date:   Sun, 10 Jan 2021 11:34:27 +0100
MIME-Version: 1.0
Message-ID: <0440549b7c78763ce787b03341ca5b9f@mail.eclipso.de>
X-Mailer: eclipso / 7.4.0
From:   " " <Cedric.dewijs@eclipso.eu>
Subject: btrfs send / receive via netcat, fails halfway?
Reply-To: " " <Cedric.dewijs@eclipso.eu>
To:     <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

­I'm trying to transfer a btrfs snapshot via the network.

First attempt: Both NC programs don't exit after the transfer is complete. When I ctrl-C the sending side, the receiving side exits OK.

btrfs subvolume delete /mnt/rec/snapshots/*
receive side:
# nc -l -p 6790 | btrfs receive /mnt/rec/snapshots
At subvol 0

sending side:
# btrfs send  /mnt/send/snapshots/0 | nc -v 127.0.0.1 6790
At subvol /mnt/send/snapshots/0
localhost [127.0.0.1] 6790 (hnmp) open



Second attempt: both nc programs exit ok at snapshot 0,1,2, but snapshot3 fails halfway, and 4 fails, as 3 is not complete. 
receive side:
# nc -l -p 6790 | btrfs receive /mnt/rec/snapshots
At subvol 0
# nc -l -p 6790 | btrfs receive /mnt/rec/snapshots
At snapshot 1
# nc -l -p 6790 | btrfs receive /mnt/rec/snapshots
At snapshot 2
# nc -l -p 6790 | btrfs receive /mnt/rec/snapshots
At snapshot 3
read(net): Connection reset by peer
ERROR: short read from stream: expected 49183 read 10450
# nc -l -p 6790 | btrfs receive /mnt/rec/snapshots
At snapshot 4
ERROR: cannot find parent subvolume
write(stdout): Broken pipe

sending side:
# btrfs send  /mnt/send/snapshots/0 | nc -v -c 127.0.0.1 6790
At subvol /mnt/send/snapshots/0
localhost [127.0.0.1] 6790 (hnmp) open
# btrfs send -p /mnt/send/snapshots/0 /mnt/send/snapshots/1 | nc -v -c  127.0.0.1 6790
At subvol /mnt/send/snapshots/1
localhost [127.0.0.1] 6790 (hnmp) open
# btrfs send -p /mnt/send/snapshots/1 /mnt/send/snapshots/2 | nc -v -c  127.0.0.1 6790
At subvol /mnt/send/snapshots/2
localhost [127.0.0.1] 6790 (hnmp) open
# btrfs send -p /mnt/send/snapshots/2 /mnt/send/snapshots/3 | nc -v -c  127.0.0.1 6790
At subvol /mnt/send/snapshots/3
localhost [127.0.0.1] 6790 (hnmp) open
# btrfs send -p /mnt/send/snapshots/3 /mnt/send/snapshots/4 | nc -v -c  127.0.0.1 6790
At subvol /mnt/send/snapshots/4
localhost [127.0.0.1] 6790 (hnmp) open
write(net): Connection reset by peer




---

Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!



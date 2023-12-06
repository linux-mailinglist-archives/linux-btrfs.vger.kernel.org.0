Return-Path: <linux-btrfs+bounces-722-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC46D8078EB
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 20:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C5E7B21014
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 19:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69276E2D8;
	Wed,  6 Dec 2023 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="0XHSktNv"
X-Original-To: linux-btrfs@vger.kernel.org
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Dec 2023 11:52:27 PST
Received: from smtp.tiscali.it (santino.mail.tiscali.it [213.205.33.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99467FA
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Dec 2023 11:52:27 -0800 (PST)
Received: from venice.bhome ([84.220.171.3])
	by santino.mail.tiscali.it with 
	id K7rM2B00T04l9eU017rMWX; Wed, 06 Dec 2023 19:51:22 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.cz>,
	Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 0/4] RFC: add the btrfs_info helper
Date: Wed,  6 Dec 2023 20:32:41 +0100
Message-ID: <cover.1701891165.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.43.0
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
	t=1701892282; bh=/Py/Q3SFsBIS7vXoE3drYtcYTpe97S9QxCVIzK1/9zk=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=0XHSktNvLuk9NWdm/9BXD75XMVAXXiOZGdlIzkw5yheJagQkH7C9WemFG37yyIxxk
	 TrU7zso0d5Xi9Up/XmJ4P0eGnG1rt33WExRcr0aQgE8zDVztEH7miQ6l5T+D10Cvqb
	 oVBEhAzwZ8CPUMFsdD7aCSlvud30HMY76r+zTe8U=

From: Goffredo Baroncelli <kreijack@inwind.it>

The aim of this patches set is to add some helper to query the layout
of a btrfs filesystem.

A btrfs filesystem may be composed by multiple disks, and several
mountpoints on which different subvolumes are mounted.

Sometime we need to know the devices list starting from a path, or
a path starting from a device.

These helpers allow to know all the information of a filesystem like
- UUID
- Label
- Mountpoints list (if mounted), and for each mountpoint
   - subvolume
   - options
- Devices list, and for each device
   - major, minor
   - device name
   - partuuid, uuid_sub 
   - devid (if the user is root)

And it is possible to build these information giving any of:
- a path (if mounted)
- UUID
- Label
- partuuid
- uuid_sub


These helpers uses only libblkid and /proc/self/mountinfo to extract all
these information. It is not required to be root; if the user is root
it is returned also the devid of a device.

The first patch add the helpers. From the second patch there are two new
commands ('btrfs fi info' and 'btrfs fi get-info') and an enachement of 
'btrfs fi label', which can be used passing both a device or a path,
 or UUID=<uuid>, LABEL=<label>... ; before the user has to pass a path
if the filesystem is mounted, and a device otherwise. This command
refuse to work with a device when the fielsystem is mounted, which is
not very user friendly.

The goal is to enanche some btrfs commands that now force the user to
pass a device or a path even when it is possible to pass any valid
reference to a btrfs filesystem (like UUID or Label).

BR

Goffredo Baroncelli (4):
  btrfs-info: some utility to query a filesystem info
  new command: btrfs filesystem info [<path>...]
  new command: btrfs filesystem get-info ...
  btrfs-progs: 'btrfs fi label' using a dev instead of a path

 Makefile                  |    1 +
 cmds/filesystem.c         |  141 +++++
 common/btrfs-info.c       | 1036 +++++++++++++++++++++++++++++++++++++
 common/btrfs-info.h       |  220 ++++++++
 common/filesystem-utils.c |   51 +-
 5 files changed, 1437 insertions(+), 12 deletions(-)
 create mode 100644 common/btrfs-info.c
 create mode 100644 common/btrfs-info.h

-- 
2.43.0



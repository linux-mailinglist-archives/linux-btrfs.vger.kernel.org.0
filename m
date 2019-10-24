Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3DDE2835
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 04:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391430AbfJXCej (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 22:34:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38922 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfJXCej (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 22:34:39 -0400
Received: by mail-qk1-f193.google.com with SMTP id 4so21959146qki.6;
        Wed, 23 Oct 2019 19:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rCbbBeI2mrlE99eAAhqWdNCOhdnLzoQ596t+H8kOQ94=;
        b=CWBgBcklTcLn5N9+5T3lhBBa8/2KvbnIHecMFx8Sn6ezg4ntO94DQXxmtoALyatiuu
         JpqJ7sESPaZHgaiPheOA4Bjnov8uP2W/FBskCBzYYQMnw4ovuj51lDUgd4SgqaCEfMh1
         kNC38pL30X8jA6eqeM0GPzTKRZs1kP/Q+8l6UBpGFcgpqZ7xW/7zBKPDFIHBgwZpgCkH
         cyd6Q1XW/oKB8i4ChYU61oA1FbbXm3DfyNo9ugf+9YThwiZeYVpzA3P4y4Of+dmS2ZFD
         m9epYsfEkDzfx1xZQ6FPTOAR2/UoCZcgzMnX1BtclhbRK91KJJaIKs+Cw3SbFNNejn/N
         glbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rCbbBeI2mrlE99eAAhqWdNCOhdnLzoQ596t+H8kOQ94=;
        b=jeGhE4eccQ+F9lsWwAfKxBxVZtwcQ0A7zc3MO7aRPYFvZFfBRrYgVLfc/vDEmvw5HK
         0QiVbDNqiWFdqIOswlTvFrUjMCsgX5hiowUrog5RLWplnuT3uTU+sTV08nX/17YoPu7y
         KpwMr8Yq7N6nmNHRdAC9cWsQzVxECYQmjkvQUmi+DrLtUMEFIofLB6drklIcQckY4Cbb
         TrP7ix3y5BYNQQlo+6bVdbDW5rAtUG5i7h0tV/sWqYVnObzUa0/yr43/49BLmVPQrtTt
         pC1ld6p3WzeRs1df+xtzKiKLG6RLEb7TRMU+1S3HcmzoW/+awi4DYpnyp9dAuxzb501f
         /cdg==
X-Gm-Message-State: APjAAAVfpy+ekNcIS5Z5tc30ZlyLAFt6cLSbwUkzwfrOncaRhfIjaZDF
        SNb6Nch6n5QSVUZpjd7pruJ3LwCn
X-Google-Smtp-Source: APXvYqw+V9P8bgtlsBvYAp2Zw06lp4vJkz8+U8vjUyxESApoZj4w5UguZkhj9rCVeIZzsjbpgTHBdA==
X-Received: by 2002:a37:2fc1:: with SMTP id v184mr11964494qkh.18.1571884477856;
        Wed, 23 Oct 2019 19:34:37 -0700 (PDT)
Received: from localhost.localdomain ([186.212.94.31])
        by smtp.gmail.com with ESMTPSA id q16sm10252495qke.22.2019.10.23.19.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 19:34:37 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, mpdesouza@suse.com
Subject: [PATCH 0/5] btrfs: send uevent on subvolume add/remove
Date:   Wed, 23 Oct 2019 23:36:31 -0300
Message-Id: <20191024023636.21124-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Hey guys,

these patches make btrfs to send an uevent to userspace whenever a subvolume is
added/removed. The changes are pretty straightforward. This patchset was based
in btrfs-misc-next.

The first patch adds an additional argument to btrfs_kobject_uevent to receive a
envp, and just forward this argument to kobject_uevent_envp.

Patch number 2 creates a new function that will be called by patches 4 and 5 to
setup the environment variable to be set to userspace using uevent. These two
environment variables are BTRFS_VOL_{NEW,DEL} and BTRFS_VOL_NAME. The first
variable will have the value 1 for subvolume add/remove (only one will be
exported, so udev can distinguish the event), and the second one hold the name
of the subvolume being added/removed.

Feel free to suggest any other useful information to be exported to userspace
when adding/removing a subvolume.

Patches 3 and 5 call btrfs_vol_uevent to send the event on subvolume add/remove.

Patch 4 creates a helper function to distinguish a subvolume from a snapshot,
since the same function is used to delete both. This function is used in patch
5.

Thanks for you reviews!

Marcos Paulo de Souza (5):
  btrfs: sysfs: Add envp argument to btrfs_kobject_uevent
  btrfs: ioctl: Introduce btrfs_vol_uevent
  btrfs: ioctl: Call btrfs_vol_uevent on subvol creation
  btrfs: ctree.h: Add btrfs_is_snapshot function
  btrfs: ioctl: Call btrfs_vol_uevent on subvolume deletion

 fs/btrfs/ctree.h   | 14 ++++++++++++++
 fs/btrfs/ioctl.c   | 39 ++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/sysfs.c   |  7 +++++--
 fs/btrfs/sysfs.h   |  3 ++-
 fs/btrfs/volumes.c |  2 +-
 5 files changed, 60 insertions(+), 5 deletions(-)

-- 
2.23.0


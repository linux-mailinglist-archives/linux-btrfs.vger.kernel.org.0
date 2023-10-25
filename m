Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E527D6E0C
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Oct 2023 16:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbjJYNvA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Oct 2023 09:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjJYNu5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Oct 2023 09:50:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E581C193;
        Wed, 25 Oct 2023 06:50:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32d9effe314so3874748f8f.3;
        Wed, 25 Oct 2023 06:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698241852; x=1698846652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bdWLFJvjkN5xqchCHJQE5KjwjkwTlLwpf/JvggF+Xvc=;
        b=VS7HmIQ/XB7lJsHcS0BHRfHgAMtOPQjZ9lo9s28jE7Eq53Izx4eaG/582MiL0IOGHx
         UxjV7XRzckL5oQSdFSSzPD/Fpg3QN4R2ERWA8HtNwLdjNmJQqvXcHOVDlZba1HFCnSs2
         mLnlT0Isn/1LFWXsFoYDD1gjTlWxelR4oqh/UyZBtafwO9ggNatzZZ/Lvx+KKhelB8iw
         zKz6GTSiBhovYqmd6kyo5eDjxrLwyKDGSorhesuGCRl1pPywJAzZRD2ZbTDfXPWHWxOe
         65cG68DiyaR0odZrX/clupPdUeyk4PLEH0IJ22AAfcysi6TBatYq+AWA/yfhe1xDSR+8
         9/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698241852; x=1698846652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdWLFJvjkN5xqchCHJQE5KjwjkwTlLwpf/JvggF+Xvc=;
        b=i9LEg7/UJBUA5CXUID+zdXZIya8grAlSyeqzyaLUjthO88VMLVGK3mtBjuREamKzFn
         x9DcOrXGWbma7tI9pkmPa1UyCtkfAm98KOYODgo5psYk2tpEfj/MGLRfL8ZhQXPurvbb
         8o7SmhAcT2K0Lm9hzmSQYjOwjyKmrLcJjbdYkfWeOA54mefllP2DnX60ewGYN1lngmkk
         nZP5t+EvPDpY3R3TFgbfYRHqUjapF/ql/jwTDspzY5YIwEOkX1xmdpixiuAP+XKrDhcx
         JZjwhyR6B8pXTMyKeHnX+OGf/0Q1mC8TCoFRgW38MeR72W9IQHyui5hDivcYJoHO58k0
         WJ/g==
X-Gm-Message-State: AOJu0YwXMKVrS4FlHh/JUWN65smYhWLDZChXX5kHhTnRX+im1GvAFppV
        SyK3VMjVNw7Q8tPjghu6/F8=
X-Google-Smtp-Source: AGHT+IEhBTIo+Z148nVMLs51PxKVcuadUHcZTPXSi+vNJZjLH15bqvvIzsMcjKcJLvk4rVqhk9r5GA==
X-Received: by 2002:a5d:6310:0:b0:32d:84c7:2f56 with SMTP id i16-20020a5d6310000000b0032d84c72f56mr12167341wru.21.1698241852036;
        Wed, 25 Oct 2023 06:50:52 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id t8-20020adff048000000b0032dc2110d01sm12143673wro.61.2023.10.25.06.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 06:50:51 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] fanotify support for btrfs sub-volumes
Date:   Wed, 25 Oct 2023 16:50:45 +0300
Message-Id: <20231025135048.36153-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Jan,

This patch set implements your suggestion [1] for handling fanotify
events for filesystems with non-uniform f_fsid.

With these changes, events report the fsid as it would be reported
by statfs(2) on the same objet, i.e. the sub-volume's fsid for an inode
in sub-volume.

This creates a small challenge to watching program, which needs to map
from fsid in event to a stored mount_fd to use with open_by_handle_at(2).
Luckily, for btrfs, fsid[0] is uniform and fsid[1] is per sub-volume.

I have adapted fsnotifywatch tool [2] to be able to watch btrfs sb.
The adapted tool detects the special case of btrfs (a bit hacky) and
indexes the mount_fd to be used for open_by_handle_at(2) by fsid[0].

Note that this hackacry is not needed when the tool is watching a
single filesystem (no need for mount_fd lookup table), because btrfs
correctly decodes file handles from any sub-volume with mount_fd from
any other sub-volume.

Christian is targeting the patches on vfs.f_fsid to the second part
of the 6.7 merge window.

If I get an ACK from you and from btrfs developers, perhaps these
patches could also make it to 6.7.

The btrfs patch could go independently via btrfs tree after the vfs
patch is merged, as does the fanotify patch, but it is my preference
to get ACKs and queue them all in the same vfs PR.

Thanks,
Amir.

[1] https://lore.kernel.org/r/20230920110429.f4wkfuls73pd55pv@quack3/
[2] https://github.com/amir73il/inotify-tools/commits/exportfs_encode_fid

Amir Goldstein (3):
  fs: define a new super operation to get fsid
  btrfs: implement super operation to get fsid
  fanotify: support reporting events with fid on btrfs sub-volumes

 Documentation/filesystems/locking.rst |  2 ++
 Documentation/filesystems/vfs.rst     |  4 ++++
 fs/btrfs/super.c                      | 33 ++++++++++++++++++---------
 fs/notify/fanotify/fanotify.c         | 28 +++++++++++++++++------
 fs/notify/fanotify/fanotify_user.c    | 14 ++++++++----
 fs/statfs.c                           | 14 ++++++++++++
 include/linux/fs.h                    |  1 +
 include/linux/statfs.h                |  2 ++
 8 files changed, 76 insertions(+), 22 deletions(-)

-- 
2.34.1


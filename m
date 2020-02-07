Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A32C915581B
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 14:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgBGNID (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 08:08:03 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:39762 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGNID (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 08:08:03 -0500
Received: by mail-wm1-f51.google.com with SMTP id c84so2688956wme.4
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Feb 2020 05:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=56RggjH/8yZ3LfnBr12TXJJBmiTfeXwXMzspZ6stiBo=;
        b=vNKFma0QkVRqyiDNF6POosx4pMxjUk4E00c8vjh8lZzSd8wSh6z7LrHv7m9RbSZQ4R
         AdsiaICmejZzXlhTizxJ5P89f8AlyXtlP/fyzrYuwjr8hZWECBkvEwyWpHrL6n1srBfJ
         pEq0tkN8oiZEYaalqbeT9yKFwycNDFvQzLcAH0Oue+8cpc0SD9ehRtsWlMDVJFWHBwVl
         /+am7H1+WyzMN2QRg+AKyb5cblJwfLpu2EkyeY1CIAAaKjZB7e5ayStVSB4umxmZI/WL
         SrgZa51NOVgAfiUj6Tl+m1MKAjuW+icaS5KerufEzaTBJvfWpVjjGtJCPcT842O4YZVc
         Vucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=56RggjH/8yZ3LfnBr12TXJJBmiTfeXwXMzspZ6stiBo=;
        b=amDvUF6zn70NkPrKwxyW65GfKMv37a7GXoNDBuc/GpSyN1Pj5PvdGapzluXwRegAFT
         LUJDqeyxMB26g//H7lICyuBlldVsuiE9po+46ZS/igZzdLT8nFy8yzJqeThpI7kGH6qU
         hvYvbYBaKNgqBsQC66+DaYjFDUeQp8fJeOIv9XyxLYHqSFr8GNi1IND6LSseNY4zsdva
         Z5wU6WbSdPVMMQ9GPgi2fsBe1qWVSMxZv0cCjExe8Ww7xXJr4/55cyXwkRmXhu428JHF
         B6fV7yyecJVvKB5qGqHD//T0yrZJOQ9UnXUQ0DnDKk5h7ssaOZsa+MYfrxiffxLLVWA+
         dtSA==
X-Gm-Message-State: APjAAAXs3QetAGSWdEUP2YHRmG0qwzSUeFZkoacczNV2lJHgiBvpBPus
        06470eLOIXc4AnAej4DyShuJDG6J
X-Google-Smtp-Source: APXvYqwnwe9/fYUMEVUmGzCxOk2xhLn73UXCP5uCDG2KlklNE5vxaq6yb7HueVUHp5jGoIC0yPS5Sg==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr4325471wmg.20.1581080880548;
        Fri, 07 Feb 2020 05:08:00 -0800 (PST)
Received: from hephaestus.suse.de ([186.212.94.124])
        by smtp.gmail.com with ESMTPSA id n1sm3260702wrw.52.2020.02.07.05.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 05:07:59 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCHv2 0/4] btrfs-progs: Add BTRFS_IOC_SNAP_DESTROY_V2 support
Date:   Fri,  7 Feb 2020 10:10:24 -0300
Message-Id: <20200207131028.9977-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Second version of the patchset, which pairs with v3 of kernel changes.

Changes from v1:
* Moved subvolid member to the same union containing name and devid (David)
* Dropped patch that was bumping the libbtrfsutils version (David, Wenruo)

Marcos Paulo de Souza (4):
  btrfs-progs: add IOC_SNAP_DESTROY_V2 to ioctl.h
  libbtrfsutil: add IOC_SNAP_DESTROY_V2 to ioctl.h
  libbtrfsutil: Introduce btrfs_util_delete_subvolume_by_id_fd
  cmds: subvolume: Add --subvolid argument to subvol_delete

 Documentation/btrfs-subvolume.asciidoc        |  8 ++-
 cmds/subvolume.c                              | 53 ++++++++++++++++---
 ioctl.h                                       |  8 ++-
 libbtrfsutil/btrfs.h                          |  7 ++-
 libbtrfsutil/btrfsutil.h                      | 11 ++++
 libbtrfsutil/subvolume.c                      | 16 ++++++
 tests/misc-tests/038-delete-subvolume/test.sh | 40 ++++++++++++++
 7 files changed, 134 insertions(+), 9 deletions(-)
 create mode 100755 tests/misc-tests/038-delete-subvolume/test.sh

-- 
2.24.0


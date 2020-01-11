Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02095137B60
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2020 05:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgAKEmU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 23:42:20 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:47091 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbgAKEmU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 23:42:20 -0500
Received: by mail-qt1-f171.google.com with SMTP id g1so3976118qtr.13;
        Fri, 10 Jan 2020 20:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J0sJVAN3gBq5JWygMJYvwY9iqjJDlXLRXymz1OSvD80=;
        b=q8RZ5FkpddH4SHFgC2U9XNuMRzam9VOfLDhMrgenWFkfSG93VB0tXhWbkiisvnL3Gn
         HNwtharRVnKJVL6ep62UQBTuPdW1vXFnBBd0AdjnfTPpSZHy9bphAhNRza/xiqoStSKB
         +NsQird3usHa0OcqFJ80AV74ik8rcJE/YYc2ncHv2rLlU1lB77jJ77vxpj3u4fDmCFW4
         jDwg/+BY8hbEr73oBVB2kueVpf9VbZQGqXCdgm7JIrbsh1XoBqj4GUdR+CaOq54CkOor
         6eHEgMcSS7pkizyeJLmgjt+XtwCTBPe/ZLLN3vHpJyZdnjGnq3H6IbGACMktLbc5lEMI
         ou8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J0sJVAN3gBq5JWygMJYvwY9iqjJDlXLRXymz1OSvD80=;
        b=OZj1L1rNbK8xXFAGQQfyKnUIva3NuYWLr1+zuOr790bx7yS7VTnRP8TH7MpXwhkUTt
         1E7+jzuXN82U7lF+09s/Wh/JSJedleBQ+FPv7oYoF0x0DBJnTzEp/Dgv/M4ZXo6TZknh
         jDLKdMsyWPqa9OaziW4KRwQTZSKsRKLNcwtBR9N9H+m5YoBEcBJs0ebTTksEcNsFDMTg
         XlVGZZWwQraNC83+vPv7E+9Hws/xyWMEX0WmeT9e6PNrB7jMPop6Fl5N+1WVNIrMmXlQ
         SXFEfdzRp81Z0lsgsHVAJ5kuHVNN4d8rA0MwPD1To1P3aU67bxBbmyWn1kF9jJ8zUCsP
         NWQQ==
X-Gm-Message-State: APjAAAXlpN/LNErNWcJO97BN7wUE5KHHajcbHCqv3sJM1jUdCb9RKyWl
        +zPpOQ4yMGKvA9A+DaZm8uW2cWFX
X-Google-Smtp-Source: APXvYqyQX+VYRwmzG1Tjrg/EJl5BoZX7d6QiHlgRh0DNAKOP8ajl5/uXJm8g20DIaO3EjnmpTzGwpA==
X-Received: by 2002:aed:3f77:: with SMTP id q52mr5576966qtf.248.1578717739273;
        Fri, 10 Jan 2020 20:42:19 -0800 (PST)
Received: from localhost.localdomain (200.146.48.138.dynamic.dialup.gvt.net.br. [200.146.48.138])
        by smtp.gmail.com with ESMTPSA id s20sm1861162qkg.131.2020.01.10.20.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 20:42:18 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
Subject: [PATCH 0/2] fs: btrfs: Introduce deleting subvolume by subvolid
Date:   Sat, 11 Jan 2020 01:39:40 -0300
Message-Id: <20200111043942.15366-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

The first patch separates the subvolume lookup and deletion into a new function,
and second only get the dentry related to the subvolume id and calls this
function.

Please let me know if these patches need improvement. Thanks!

Marcos Paulo de Souza (2):
  btrfs: ioctl: Move the subvolume deleter code into a new function
  btrfs: Introduce new BTRFS_IOC_SNAP_DESTROY_V2 ioctl

 fs/btrfs/ctree.h           |   8 +++
 fs/btrfs/export.c          |   4 +-
 fs/btrfs/ioctl.c           | 119 ++++++++++++++++++++++++++++---------
 fs/btrfs/super.c           |   2 +-
 include/uapi/linux/btrfs.h |  12 +++-
 5 files changed, 113 insertions(+), 32 deletions(-)

-- 
2.24.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43381326FB1
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Feb 2021 01:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhB1AD0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 27 Feb 2021 19:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhB1AD0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 27 Feb 2021 19:03:26 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222A2C06174A
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Feb 2021 16:02:46 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d11so8744124qtx.9
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Feb 2021 16:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=52l/8LWCYd6EbDGxrPxwErd4MV2QgGGRJkesvS4wFTA=;
        b=qJSA4z+Dg8s8RVVK3Lb9d+NAtdVClNAtgzi5VW561lhnQ3b4805YN5sfLJAfJvXN83
         o8UBMjlc8TCSFQSlAELSn40HJPDA6r4slr8hFV/AN3M5xGG544p9kEnrio8CaEfgkcVV
         x79y/Y13Ack5s5C7hsJ3EglCN2IEtUFSaZm/edD5npkkXM9Xg07lWiByOOaX2GW6YRHc
         DWUserboLMJBUHalxp63tuW1DTl4uO+3iPCi7tMJTo7CPMgDCLAYKQAQilC7vnAljE7v
         VXBpaNXhiDnitYFnZaHlWKVSkTucSCHWKeZGVyzvox6Cs5wCZTbHwKZ/yjV5hD4ML7M+
         8I3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=52l/8LWCYd6EbDGxrPxwErd4MV2QgGGRJkesvS4wFTA=;
        b=QwM1h2YkJymkacK1Gf4AFHBF2Puo6dJS16wD1kvGI9w3pr3VUaojk/lLOGdzEm0oR8
         grzgKyNlit+Nbj3mS3a0AuMHqOi27BA+++1ULvP44WzGMtn9r5yQca40M62sLMg6Mbny
         EGjpzSVoufQqFgys8m5+xRk41/rnPoaFf+TxcNKCAtaedY9TxYeqfSg5FeM59stSziCI
         alCu5MDpxq4FIU6q1Eanl+woi7v0GaObxVw/C6zXyTI0wkK/cLTnufmr/aOPJtF2MuA6
         gEMmG7evvjlXbNXjW0m1MQfEfGLSsNuf5a3ZXq9+wOk0gMNsUNG+uW2sIIMh8uVyudIk
         Kx0A==
X-Gm-Message-State: AOAM530i3xfBvZB4yYuOPKUJADQN9rbyAt8vFzuqHP9mZuHp55oICXHp
        sCOsLCeauNH2kM4kNxyOzUcfT1Q23skNNQ==
X-Google-Smtp-Source: ABdhPJxmaKeLtqk0W1loYLwV7LnyePF223lMzWqdHcKqUoicTQOlzqafgDJA5SbwCeX7jrZ7vFfOLw==
X-Received: by 2002:ac8:5d50:: with SMTP id g16mr8051374qtx.321.1614470563926;
        Sat, 27 Feb 2021 16:02:43 -0800 (PST)
Received: from localhost.localdomain ([81.198.235.160])
        by smtp.gmail.com with ESMTPSA id t71sm9543942qka.86.2021.02.27.16.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 16:02:43 -0800 (PST)
From:   =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: [PATCH 0/1] btrfs-progs: Implement dump-raw command
Date:   Sun, 28 Feb 2021 02:04:47 +0200
Message-Id: <20210228000448.41694-1-davispuh@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently there doesn't seem to be any tool to dump raw contents of a block,
so here I implemented such command.
It also shows info about block's location which is useful if there's a need
to patch block directly on disk.
It's based on dump-tree command - basically copied it with some changes.


Usage example:

$ btrfs inspect dump-raw -b 5242880 /dev/sdx | hexdump -n 64
btrfs-progs v5.10.1
block 5242880, mirror 0: reading 16384 bytes from device b0e0bb24-c654-4d79-872c-ad195bf995f1 at offset 5242880
0000000 1dbb f93d 69d7 d129 0000 0000 0000 0000
0000010 0000 0000 0000 0000 0000 0000 0000 0000
0000020 b993 bc9b 9fff 6e41 62ac dc4e 31e1 6adc
0000030 0000 0050 0000 0000 0001 0000 0000 0100
0000040


Can also dump corrupted block from speciific mirror

$ btrfs inspect dump-raw -b 5357568 --force -m 1 /dev/sdy | hexdump -n 64
btrfs-progs v5.10.1
block 5357568: using mirror 1 from 2 mirrors
block 5357568, mirror 1: reading 16384 bytes from device 002aa837-9fea-4b7a-9455-9be943bae1f5 at offset 5357568
checksum verify failed on 5357568 found 8242B9AD6E5A1308 wanted F1D148C22AF2D15B
0000000 d15b 2af2 48c2 f1d1 0000 0000 0000 0000
0000010 0000 0000 0000 0000 0000 0000 0000 0000
0000020 af51 62c3 876d 984a 0fbc 9237 8d29 ec8d
0000030 c000 0051 0000 0000 0001 0000 0000 0100
0000040


Dāvis Mosāns (1):
  btrfs-progs: Implement dump-raw command

 Android.mk              |   3 +-
 Makefile                |   3 +-
 cmds/commands.h         |   1 +
 cmds/inspect-dump-raw.c | 341 ++++++++++++++++++++++++++++++++++++++++
 cmds/inspect.c          |   1 +
 5 files changed, 347 insertions(+), 2 deletions(-)
 create mode 100644 cmds/inspect-dump-raw.c

-- 
2.30.1


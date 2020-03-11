Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8562D1812C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 09:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgCKIR0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 04:17:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45176 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgCKIRZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 04:17:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id m15so748360pgv.12
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 01:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MuzmrD0c0ZFm46FLr9vaZUDaWwP5NimKdT1tayynHds=;
        b=opAl3TBUfQNfp9rHVqSN58uThaRBnPWZsMHBaUO2lK/z8G18jQOhfM5GANh120fSZw
         2eDSUNzKJingd4zlq3uAsvnM9nV1/7krArCEicH0g5KakiNytlCxC3r5BY/vsubxCa7S
         9atvZNFppsfiXlepPAGhyz4OnFrptR1ajXIEz4OTAsN/gdaeRov/AqiA2Y0FErGiu+0q
         VMfrjfsBDc/CrVvornV84Qm9JrezN0fHJuzwjxfYS9rE960sKNtiA48DYm1+tkprF++P
         glg5HmZ3WDhrMpmK+2DcI+AssW9PgQm+evagwJmgXpaA8JkiTxnNuEFErZf+R3CywtGP
         XsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MuzmrD0c0ZFm46FLr9vaZUDaWwP5NimKdT1tayynHds=;
        b=gYLOjp00BuxTYFTLWNHRFO1DRTmnifhKZjWvM2FUgVQBAQPTKCKSb8sKHPkRWfTlzo
         LvU0qCEhzVKiMury5o34TPBjVVZm4FTAU+ydLqqQ9Iqz5/GKtk3CMvNgwASCk0X36+6r
         /W3QWu7nnaBSN/RhJoBMeRRoEtiGejFccpzSZoOYOGSN3RwfKKTKB3IYczKseBsYSj0V
         qE0ZKqCk4HXJ1+XAktStT2MPrXsDZ5pYAYN2zifVSwaQaVhV3tALeleFTjloVeie3E+H
         pPK4gNK0cyVHxfPkUbHd3GrFL5o0NUSCreZ06GtNdF0laoVgNx0ini+YkpiyHZlzy9uV
         E3pw==
X-Gm-Message-State: ANhLgQ3wG0NKzg4Uk9AG0SsW7APeKeLLHM1NWhmG4sDoxk9J6ICXHBJ3
        +/7GtgM5W5Lh7ZF1WJXVXEFNI6Rzwm4=
X-Google-Smtp-Source: ADFU+vurtjkBATn6JDz5iEt2TS0gdTPi0hoeWtZMNVawgVj9eM0hCIysYz/lvJrpTetrpKv1b9g6VA==
X-Received: by 2002:aa7:8283:: with SMTP id s3mr1729019pfm.106.1583914642405;
        Wed, 11 Mar 2020 01:17:22 -0700 (PDT)
Received: from vader.hsd1.wa.comcast.net ([2601:602:8b80:8e0::14a2])
        by smtp.gmail.com with ESMTPSA id j8sm4692039pjb.4.2020.03.11.01.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 01:17:21 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Filipe Manana <fdmanana@gmail.com>
Subject: [PATCH RESEND v2 0/3] btrfs-progs: fix clone from wrong subvolume
Date:   Wed, 11 Mar 2020 01:17:08 -0700
Message-Id: <cover.1583914311.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hi,

This is a resend of [1] from last July fixing a bug when the same
subvolume is received multiple times. It appears that the series got
lost at some point.

The only changes from v2 are adding Filipe's reviewed-bys and removing
the strdup cleanup patch that was already merged. Based on the devel
branch.

Thanks!

1: https://lore.kernel.org/linux-btrfs/cover.1563822638.git.osandov@fb.com/

Omar Sandoval (3):
  btrfs-progs: receive: remove commented out transid checks
  btrfs-progs: receive: don't lookup clone root for received subvolume
  btrfs-progs: tests: add test for receiving clone from duplicate
    subvolume

 cmds/receive.c                                | 43 ++++---------------
 .../test.sh                                   | 34 +++++++++++++++
 2 files changed, 42 insertions(+), 35 deletions(-)
 create mode 100755 tests/misc-tests/038-receive-clone-from-current-subvolume/test.sh

-- 
2.25.1


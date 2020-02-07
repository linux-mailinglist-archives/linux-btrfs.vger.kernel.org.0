Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98696155837
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 14:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgBGNRN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 08:17:13 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:50485 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGNRN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 08:17:13 -0500
Received: by mail-wm1-f54.google.com with SMTP id a5so2582684wmb.0;
        Fri, 07 Feb 2020 05:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SBHu5U0uvH5H56CpCyXRGzMU6jSsuBweVkooO6pytvM=;
        b=a1r7Rsr01qt8/44a9yHgGJB7k4UF+IS1/I1DWAq//+X37B6nBuk3B2C2hPTWMizS4B
         GpOpDxPsSb3ha1DC4Li7Gqj4Jsz7p/f5KKPwobRnIEY8sfRzgiTFjVdkZ6UJzZMl7no6
         ToJsrRVaMsxufhpA8JzY0FQ+0IfKNfpFOodRTPw/obB/cSOeTFm6gnpvuvnTMPZR1u1h
         9WBmhoMCF81AgKK0XBwBN0kqGEVySodDlwspiKSfjPIyi0NkGHXQvXR4zAW/2+BdHkgk
         yY3IfFnKSnxGL5vW3i8HfjIW7A8k0mSsYXUu9m4R/5iPAjytQYJRrSVff9onpH22cXLj
         ghDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SBHu5U0uvH5H56CpCyXRGzMU6jSsuBweVkooO6pytvM=;
        b=Vz60LmaEpevB1ezy6kxjd7v5XvrB2+XrdKsfwbCkC4Lmtv1nowJUhhBCiJ1dESnMre
         iTeWMoGCnjkEpkaeoWvMPX568CiuqMr6iqvd/ZN8qhB0iOf+OSlmE5G+RCtmZzYa7rHh
         FxHoflCRjXnbnW9hAdxptxUYc78SFPMWOMszUgh7ZqhFYUA639tGdvKBMIq61mEglomq
         xtlzDsCeY33t8pHX7tEiZQtYH25ab4eGPF+SXffJ/IUIQHX8mIsYAzvRubYMZOSOPIea
         1KGKPcstDbIxQQ9GfKwrD+fwf9GafE7kky8CQs1S8tW50K8Ca5J5a04eLXs2QABm/BQ/
         q+4Q==
X-Gm-Message-State: APjAAAVR3KDu5Z+jPGRE4TAB4XZKb5XRy9WvOm8QsFJbJ/u34Mra+SCW
        ChiDUI0grFTIHgnmFtrgh8BbzlQG
X-Google-Smtp-Source: APXvYqwKmDv4sn4PGGwUhak7t0g3oY+dqcvWHoPLK1Sdlo6QjScFBa64DXd2qn9YEMY9OxQ2cidNdA==
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr4541898wma.171.1581081431048;
        Fri, 07 Feb 2020 05:17:11 -0800 (PST)
Received: from hephaestus.suse.de ([186.212.94.124])
        by smtp.gmail.com with ESMTPSA id i204sm3472723wma.44.2020.02.07.05.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 05:17:10 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCHv2 0/2] btrfs: Test subvolume delete by id feature
Date:   Fri,  7 Feb 2020 10:19:49 -0300
Message-Id: <20200207131951.15859-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Changes from v1:
* Added some prints printing what is being tested
* The test now uses the _btrfs_get_subvolid to get subvolumeids instead of using
  plain integers
* New patch expanding the funtionality of _require_btrfs_command, which now
  check for argument of subcommands

Marcos Paulo de Souza (2):
  common: btrfs: Improve _require_btrfs_command
  btrfs: Test subvolume delete --subvolid feature

 common/btrfs        | 13 ++++++--
 tests/btrfs/203     | 73 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/203.out | 14 +++++++++
 tests/btrfs/group   |  1 +
 4 files changed, 99 insertions(+), 2 deletions(-)
 create mode 100755 tests/btrfs/203
 create mode 100644 tests/btrfs/203.out

-- 
2.24.0


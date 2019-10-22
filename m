Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07C88DFAB1
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 04:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbfJVCAa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 22:00:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33855 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730084AbfJVCA3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 22:00:29 -0400
Received: by mail-qt1-f196.google.com with SMTP id e14so4632076qto.1
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 19:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nEJhim5jOn4CFdUjVPqORmgLxjhJl6lCqmH9P2Nu+mo=;
        b=W+9Qdqi6QGhSQ4SQv7KMX22y3oRq0np4yhGdqoFOEAB25W1RSdHTKgYlL/LrgoPxfC
         d0S/PkjrM2yPXnNth1m+BHLxfMFYsAMADJxUfVo6IyAIinjRA6epZnvbE3g2UVV6YR9R
         OPakSbnLsKgWP9WQu0uwFg9fYXLpsZQW84BOIHwHMfGWEw7em2x36OUg036833RBzlgs
         6r/w/MawcJifvpARJyEIjFoeEbpo6Rbo+zg+zU/OMyOEb07wPrUG99gsJGtrcQaYz69D
         NFCFARMhrOXaofyh3dQ9bJEZofFsqkcsVdQLp+9GJgxkIFkCiSqjYmLoYE572YEcLyaH
         UzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nEJhim5jOn4CFdUjVPqORmgLxjhJl6lCqmH9P2Nu+mo=;
        b=NkNOa9WOm7MXOI2VQxJ+uvBMSIQ1jw26h550I4SFDsazT11BKU3xdlvAfjl8nTpyok
         yD9cCK1YaH7+3flcYR/9xxrq+HEPCpYgKSJ/fx7WheNIScrIuQvuG5pShcpJEbKQnyCA
         xq24B5mrbL9nx+kmVIzkiK2Miphz3ce2O+VMOMYIRepuBZT80EOnhHC9tVPfNIK68hUh
         32rKAl8+sXHlENuqd6NcMSBH3XUNn6BQfs3eZutyGWksBXDBSsc+1kXc9puShOpXX0dY
         X+9bj8A0U9+ynfNwPob8SLICV9no1p3RVpAkfHMrClyT3WE34D2P6B/iAwxSMUOQWK1/
         vvEg==
X-Gm-Message-State: APjAAAUXktkh3Pna3Qoqh96EEFSWjfpvulwpcVBD0raaZ/aEKj/H9cmJ
        vsKIs1PawjgnXSvqWKtsxUrFaXF/
X-Google-Smtp-Source: APXvYqyaC2x58r4xnwYFszilY6yhW0hjcEk4VZmfBIS+c13cgvpA6r0zOgfGtTq8nAo3w2I2aISe2w==
X-Received: by 2002:a0c:ed50:: with SMTP id v16mr829093qvq.30.1571709628680;
        Mon, 21 Oct 2019 19:00:28 -0700 (PDT)
Received: from localhost.localdomain (189.26.180.57.dynamic.adsl.gvt.net.br. [189.26.180.57])
        by smtp.gmail.com with ESMTPSA id t65sm8511120qkh.23.2019.10.21.19.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 19:00:27 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 0/2] btrfs-progs: Setting implicit-fallthrough by default
Date:   Mon, 21 Oct 2019 23:02:26 -0300
Message-Id: <20191022020228.14117-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

While compiling btrfs-progs using clang I found an issue using
__attribute__(fallthrough), which does not seems to work in clang.

To solve this issue, the code was changed to use /* fallthrough */, which is the
same notation adopted by linux kernel.

Once these places were changed, -Wimplicit-fallthrough was set in Makefile, to
avoid further implicit-fallthrough cases being added in the future.

Marcos Paulo de Souza (2):
  btrfs-progs: utils: Replace __attribute__(fallthrough)
  btrfs-progs: Makefile: Add -Wimplicit-fallthrough

 Makefile       |  1 +
 common/utils.c | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.23.0


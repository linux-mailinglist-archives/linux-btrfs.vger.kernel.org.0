Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E600EA7D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2019 00:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfJ3Xep (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 19:34:45 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:38077 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfJ3Xep (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 19:34:45 -0400
Received: by mail-qt1-f171.google.com with SMTP id t26so5888644qtr.5
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2019 16:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fxs3iL2P1F8nhyciPWnBsloO1dJBce81yUAvrCgl62w=;
        b=l+7l9Gbh+RkaDD4WpxMqClGXKpZoN3GM6nBhyv61uVfJsdPj59zYFpyb+CO3OARCcZ
         WqyBWVzJrSzO1qRcBpADmhzt1sIbflLoJBYpviNZCIlZtZ8CcmwboCKXzmBXIJnj/c0Y
         DkoAnfcvLgBbSRdkdKcXfykYBV23RFhdeO6oZKiXakllb8DHauBs+Y39sIWujwU2byzp
         4YsbtDAISVlDA7zSPjTmZxDUV4dxy0erTHDrDLOTVONqEpyNVir4zxwczOYlEZNgcY4w
         pk9y9m6AqL9QeczJ+2lh/CwL+YNWcGSOMn1R1Yzzm2dCoKLebFgfTGMbYJ5ERnj9sVHm
         p0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fxs3iL2P1F8nhyciPWnBsloO1dJBce81yUAvrCgl62w=;
        b=anQqD/EJRQovl9xgSl6q/9fehHqtrQq8WX5wXMIHOVw+Iyv82JLqrmFTw6LmD6sPUj
         eHfAoy8/ceRHxtClainBtEyBPMFpTE6kgDYqYi9cIR3G6dkiqEOLxtrytdqX4dNIR9Y1
         HHnM7W0Th0mhTVHbQ9gRGM/8a8YALGxGGzjDppeQJ7ZZa3doIZ6EIB0Di5nRS8NeJj2a
         Nvq07ChChawo4BExwLRda8roiXC2xobO8J3oaTag+OAPBAPTaUvg0KM5NswQ1V8Zeexm
         7ur9Y5zCGXk55Gb4ab0wsF0Qr43k+NwbmoR7aNZQeIaZeb5GAW62tXj1WvfE411hMeYt
         djpA==
X-Gm-Message-State: APjAAAW3lueherq4YKxFlEC1jeMfC6GfvA0cqTgPAJwkKw1GTvAmtpu4
        CTZHJysWafTZhSCVQxLnKZw=
X-Google-Smtp-Source: APXvYqyuHzk9r7nCNEYzgGofrz0jb3dKZ6VhE2tygZzgHRdZ6sTZaMr1k0BUuB5MUF6axC8tGGEpXA==
X-Received: by 2002:ac8:21b5:: with SMTP id 50mr2729892qty.60.1572478483769;
        Wed, 30 Oct 2019 16:34:43 -0700 (PDT)
Received: from localhost.localdomain (179.187.204.103.dynamic.adsl.gvt.net.br. [179.187.204.103])
        by smtp.gmail.com with ESMTPSA id c185sm820317qkf.122.2019.10.30.16.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 16:34:42 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org, mpdesouza@suse.com,
        anand.jain@oracle.com
Subject: [PATCH btrfs-progs 0/2] balance: check balance errors on background
Date:   Wed, 30 Oct 2019 20:36:39 -0300
Message-Id: <20191030233641.30123-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

The first patch removes the close/open operation of stderr, so we can receive
errors of balance when starting in the background.

The second patch waits up to three seconds after started the balance process, to
check is some problem happened to the balance process. This is done only when
the user issues the "balance start" in background mode.

This was tested by issuing running "btrfs balance start --background
--full-balance <path>", when the balance started, issue the same command again
in the same terminal:

# ./btrfs balance start --background --full-balance /mnt
# ./btrfs balance start --background --full-balance /mnt
ERROR: error during balancing '/mnt': Operation now in progress

These two patches together fixes the issue 167[1].

Please review,
Thanks.

[1]: https://github.com/kdave/btrfs-progs/issues/167

Marcos Paulo de Souza (2):
  btrfs-progs: balance: Don't set stderr to /dev/null on balance_start
  btrfs-progs: balance: Verify EINPROGRESS on background balance

 cmds/balance.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

-- 
2.23.0


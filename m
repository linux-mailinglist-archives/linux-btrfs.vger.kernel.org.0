Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B911A9C248
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Aug 2019 08:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfHYGFP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Aug 2019 02:05:15 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:40820 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfHYGFP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Aug 2019 02:05:15 -0400
Received: by mail-wm1-f46.google.com with SMTP id c5so12605381wmb.5
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Aug 2019 23:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n6Ay3Gg8oFq1MU4PjK8NHUusNrGo+Q7oZdgTa7YoJhY=;
        b=hMOGh8ft561rnGifi7B5H59LucUJdc+iClsQveUYNvH35hojwYt8oiea5jQkdUS2cN
         ZItJjOUlDS12f1hw9v83wjr2vfsEL/vf/U9Ch+RhYa7oE8NnvxK1W/IaLr0kgULbtLWh
         jUiXAj4H3e+IGABkga2ipSdohJejU4g9LhmY34QP6AcWY/IrTo/aQmuL7VC9QwhrCWe6
         Q7WeqxSZ+/N465Qxzikd+9I9J6p1hvwHZB/dz4AuRH6LpRSt2kZKxXFblAUq5fXyt4Iz
         NpwmIpdrwA+lGDiC1OhaYgpM3GlmhX5mBsLqg2meG3s52O5vR6YAHSf6VGDuONgFKbc1
         I9hw==
X-Gm-Message-State: APjAAAUIgYVTD3ddBFid3vfPdkenaxvmfBWj6uNhSu0TyyIt/Moh2ND+
        yG4aEao1BZoJ7/YiJoxFIwksQWix
X-Google-Smtp-Source: APXvYqyW468fqORTeKD9cXWWm1LDBwIh7NqiFNO8p6z6MFzp7mK/ny5L25vnJY2RTJt6EX9rE/mthA==
X-Received: by 2002:a7b:c241:: with SMTP id b1mr14747967wmj.165.1566713113426;
        Sat, 24 Aug 2019 23:05:13 -0700 (PDT)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id u186sm20217232wmu.26.2019.08.24.23.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 23:05:12 -0700 (PDT)
From:   Vladimir Panteleev <git@vladimir.panteleev.md>
To:     linux-btrfs@vger.kernel.org
Cc:     Vladimir Panteleev <git@vladimir.panteleev.md>
Subject: [PATCH 0/1] btrfs-progs: docs: document btrfs-balance exit status in detail
Date:   Sun, 25 Aug 2019 06:02:55 +0000
Message-Id: <20190825060256.20529-1-git@vladimir.panteleev.md>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The `balance status` exit code is a bit of a mess, and the opposite of
pause/cancel/resume. I assume it's too late to fix it, so documenting
it is the best we can do.

Vladimir Panteleev (1):
  btrfs-progs: docs: document btrfs-balance exit status in detail

 Documentation/btrfs-balance.asciidoc | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.23.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0796088B6B
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2019 14:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfHJMlV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Aug 2019 08:41:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50862 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfHJMlV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Aug 2019 08:41:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so8173390wml.0
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Aug 2019 05:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ViXmGX9f3VL4mNZjzMpptTzSxP1ysjXhXuZxdmeJtBA=;
        b=ifb4a1RacZlLrqWgwmpp647RM6e//Nfu9bQ0gxwwbnajndJBXtA9wFneo5pVEKGyVy
         lHhIUww4Y0Xp8uZxdQa6QB+hgdGf72pYEX+pTSUpRTaAxvkWLH8NN8Cb6JC3NbnV8Ui5
         78wFZ4SOYXq7GY6GlrqsRTPJUdoEPnAu1FTy5S8yj12kK5nxaynjz8jtX5JfrN3hZFIx
         kIKnAPP1acR1LM3DDi9k2yrnsvQrW0ugI6LDwyYBsW2UWZydig8HF1bSZBX5EL/7KJ75
         MxFyxAIb/nLTe8ZqT2iwLFCAdFzxeJPKngToEtV3/elAJip81oa/s2sPi4T3erWaFYAP
         rCzA==
X-Gm-Message-State: APjAAAWNgEK9z7BLi4cENep/eyKSB/1cZQDdNI45OyX/xHB0WtaCW9zW
        F28utpJqbHwMSlnIp95POG0IrFqhVow=
X-Google-Smtp-Source: APXvYqxhk0f+i++h2r+xD4W13+TUqTwH59KXlGvnFiPPDfvL/HsOdEGoMQNhE/+jVlkf/trNDgFStw==
X-Received: by 2002:a7b:c310:: with SMTP id k16mr16002776wmj.133.1565440879387;
        Sat, 10 Aug 2019 05:41:19 -0700 (PDT)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id p13sm32060364wrw.90.2019.08.10.05.41.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 05:41:18 -0700 (PDT)
From:   Vladimir Panteleev <git@thecybershadow.net>
To:     linux-btrfs@vger.kernel.org
Cc:     Vladimir Panteleev <git@thecybershadow.net>
Subject: [PATCH 0/1] btrfs: Add global_reserve_size mount option
Date:   Sat, 10 Aug 2019 12:41:00 +0000
Message-Id: <20190810124101.15440-1-git@thecybershadow.net>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

This is a follow-up to my previous thread titled ""kernel BUG" and
segmentation fault with "device delete"". Since my last message there,
I discovered that the problem I was seeing was solved merely by
increasing the size of the global reserve to 1G. I don't claim to have
anywhere near a complete understanding of btrfs, its implementation,
or the problem at hand, but I figured a bad patch is better than no
patch, so here's a patch which does allow working around my problem
without building a custom kernel. Or, if anyone has better ideas how
to understand or address this problem, I'd be happy to help or test
things.

Vladimir Panteleev (1):
  btrfs: Add global_reserve_size mount option

 fs/btrfs/block-rsv.c |  2 +-
 fs/btrfs/ctree.h     |  3 +++
 fs/btrfs/disk-io.c   |  1 +
 fs/btrfs/super.c     | 17 ++++++++++++++++-
 4 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.22.0


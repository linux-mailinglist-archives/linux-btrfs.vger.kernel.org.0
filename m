Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C432E7CD0
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Dec 2020 22:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgL3Vql (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Dec 2020 16:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgL3Vql (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Dec 2020 16:46:41 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33908C061575
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Dec 2020 13:45:56 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c124so6009045wma.5
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Dec 2020 13:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/kbVtG9+aGsr44Zrtbqkbn+LIP6L6fp4kSH2R8701XE=;
        b=Cr1Y17z/exiurhuFY6Pbw763XwbO2cQtAmhdoKUuvXpfxnQ2AJlJxQnN8tZcPVfvwI
         BBlsVX/TWEBzgPFF5+Uf2aMsMP//MxFjBRv3fYLtv4sdYc83z0bRB0rTzMnXBv6oeCVI
         ss+pYhxZ2KcPMItt+ZnzcDzRo78F4xr/xO1J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/kbVtG9+aGsr44Zrtbqkbn+LIP6L6fp4kSH2R8701XE=;
        b=h3hxZndpgDM6QAsQLVVwVXudW0AMQztSUDdX939XZsc2nPjr0L6ZUHYBqB0Rmda0OD
         vB3ufyAIJiMXAG5OffQgeqK2PT4oyG5W6C6Vy7mjoyt1whwQIO0X2W3CUI8cTCUuvE2a
         qosiB4aPiqgqiCAAu/e0/EJHcUx7vKZs0apTyn7boPEuVqEn6mgZ7coGu2h3A6ZBUjPA
         YmGbJhZotJCuHNS88rDVN9POjtv6TamtpQNIJDz4m8S0UnU3S4VcxAzyJOMoY0X313LH
         urLAbgCqdbTpJqn7AmDVwOiwFgGF22DrL9yEs6atAKKUIBy1Tzm+HFOYhr++fyxMZ9bw
         g5tw==
X-Gm-Message-State: AOAM530AqrefcIfqxMYaMbqUCQeigO/PxTNTf4DpZiw9on5PboHEM7Qn
        1UeYIQ+JtShcnMA0gKawaUZU2g==
X-Google-Smtp-Source: ABdhPJwmWH9sv8kVx66i/Zig3WzfuPqiSDd5ysSSfSorYVgQ2t4wrzU0rEZtrhkOUVb/l94N+FDjPw==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr9373821wmj.61.1609364754774;
        Wed, 30 Dec 2020 13:45:54 -0800 (PST)
Received: from dev.cfops.net (165.176.200.146.dyn.plus.net. [146.200.176.165])
        by smtp.gmail.com with ESMTPSA id r7sm8749894wmh.2.2020.12.30.13.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 13:45:53 -0800 (PST)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        dm-crypt@saout.de, linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, ebiggers@kernel.org,
        Damien.LeMoal@wdc.com, mpatocka@redhat.com,
        herbert@gondor.apana.org.au, kernel-team@cloudflare.com,
        nobuto.murata@canonical.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        mail@maciej.szmigiero.name
Subject: [PATCH v2 0/2] dm crypt: some fixes to support dm-crypt running in softirq context
Date:   Wed, 30 Dec 2020 21:45:18 +0000
Message-Id: <20201230214520.154793-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Changes from v1:
0001: Handle memory allocation failure for GFP_ATOMIC

Ignat Korchagin (2):
  dm crypt: use GFP_ATOMIC when allocating crypto requests from softirq
  dm crypt: do not wait for backlogged crypto request completion in
    softirq

 drivers/md/dm-crypt.c | 135 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 120 insertions(+), 15 deletions(-)

-- 
2.20.1


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362DE2C8968
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 17:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgK3Q0U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 11:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgK3Q0U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 11:26:20 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEDFC0613CF
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 08:25:39 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so17001762wrx.5
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 08:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EWt0zeDGvpTBd6Fr48UiLjmgXXPRNwIyzX8P2MCW/Y=;
        b=pqt68uIBC1CjgKVsHoe87ct0XoBKxNI34dMTP6ENlpkDblfWh95NfZS4ZIbIxcXKyT
         yODy63MhAbiXRpvbzviV21uWVFXssw2HuUDoenMGdm689oJKbLnSxHnc2EFgi0vCv0xg
         XzKFNIU6o4lP8ga1YzNhHw7q0I0ji5BObE2GDnRYZcgQCbKhBdCoP/9D/hdjTzaxQFW5
         kXPSxd1Ee4GlzlQFyTJm7Ix7tZtexUT3onsYCceYFdWHi5qxThDiJ392I3rGTbxVfI5T
         Pgc+JDeJwLdSqw6/TUBqR2VT8noL41tOqpZsvOAaDTJd0fNnxsoge6ilNduOhoYMkhFa
         9Yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EWt0zeDGvpTBd6Fr48UiLjmgXXPRNwIyzX8P2MCW/Y=;
        b=Xn63EvOYLdd3LK3m+TFu3H3llFw3TUWgZWL6z32NwIsxkeFnYXU1ZKxgHgeTJZofrJ
         SW/CedS3uZMdG6E1V4hNjK6vZT6tEjuDopmhT8m64nI+aBdxeLgtCmEad+Pg2wJ6/kF0
         /KGfprscXIfNa8ELnQgWmTia+37S6E0+DxqNiZ9htevzmI/ryeZN/W7v43CzFiygn2/1
         T2juKrGjgsfga3+4tbTXspX3MPDG9e8AH20o6mJJv0CKgECMxC828MldktToJ08MrNmK
         Rh957Ez6Ydq6gH6DDbmqwGXvAhu+fAapNJ4ZrQp4MqBu/1KgrNnOZYqCXT8k0WXhWepX
         sIxg==
X-Gm-Message-State: AOAM530NoNmofmPobXG4z0Zuhr7JrwADWXpNry5RWctJCUM+s3AxTUdQ
        PZgbs+WWQNa+sErzHefv9dE=
X-Google-Smtp-Source: ABdhPJy6voqltom6AQwOplT6PRhDPUzlioXcZIZLoLHQ+cOA6YaYzogfJmm3KDZYEFmRRsGiioUF7g==
X-Received: by 2002:a5d:548b:: with SMTP id h11mr29357919wrv.306.1606753538469;
        Mon, 30 Nov 2020 08:25:38 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id l16sm29539476wrx.5.2020.11.30.08.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 08:25:38 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] mild btrfs async discard fix
Date:   Mon, 30 Nov 2020 16:22:15 +0000
Message-Id: <cover.1606752605.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The first fixes torn reads, that is not very important but costs us
nothing. The second optimises out extra spinlocking that may be useful
for high discard rates.

Pavel Begunkov (2):
  btrfs: fix racy access to discard_ctl data
  btrfs: don't overabuse discard lock

 fs/btrfs/discard.c | 54 +++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

-- 
2.24.0


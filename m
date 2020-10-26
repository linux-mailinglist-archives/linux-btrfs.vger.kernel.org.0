Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B1929984D
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Oct 2020 21:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgJZU5e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 16:57:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33323 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgJZU5b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 16:57:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id j62so7824145qtd.0
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 13:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s8goIMshVGTiL5yw77X5Z5Fho3dPThHTqRO6LjTgbzw=;
        b=kBoVkee0YivZdzaO3ATBWOTVcAPq+ECQu7WdGb6VulbQrsGu6qRpWDL+Q3gT+VrCEB
         pQxtQtrzCSUFw8ZXz5x7ELNM9+Gwt8zwDrcQJETmubaGDPNU1agI9dQNwOOYD2vMpGA+
         pytQ3L43E/+X8kz+AY1swJ4N7AHct4py1g/J0mIlQC425mWgTCxTBqqO7BApHh/JvKJs
         PeovmdFBC8J0OaaQUOakyd/xxQHz7e6VXlUafVjt3naA6G6hO0wUqdkJ572tBSjWyBJe
         4HE4PH9DpetFO44DZ704fAwWepKA9Fs4xkwXlHI3UcrzQp+u90YenUD44BKaIPE1kjD7
         FtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s8goIMshVGTiL5yw77X5Z5Fho3dPThHTqRO6LjTgbzw=;
        b=Jnz7wcIzybVrzKzsVTFd0cReceHY7/x/OZcEEhJEdT4ORFCOz7Wdu5WvG0o/tX/MzM
         yQMkPBdiZPApPyuUnaul8kKy5Abz5OzzFUoQywAxSncAyOXBvHMChbHRASm243/V/OI+
         +Y+I3RbzjcFefR7R4ywFe97dFkodGyuFKw127M5/SucuMsoIH+jTYCI8zk4zzr0Ssf5h
         2buvw13HO23jUj+wekqSraichoQsaaG2q5q4R6C02sgstZd+9SrLxliySxZXGXLcnxEa
         zOrPpK/Q8ymdwfpV/E2W+ZYPQ4wYt+u/NaFygfVONyfnh4cUzBzPiLVdHH4826hIPIEK
         m9Nw==
X-Gm-Message-State: AOAM530yXxZ1N6b5n8B2/eEDe2ERTIUKqzKEezUmtO4KrpKtED7rZcWQ
        nJSy5DLvYC9gFLnnrdvZprv3cCGN3cQXotGA
X-Google-Smtp-Source: ABdhPJzSgI9oY8fi3xbw4MHgwHuLLmCQZ0QKo1sexY7XcAnNUTtR4QrWCIKiNQDVaivV01+Alt/j/w==
X-Received: by 2002:ac8:760f:: with SMTP id t15mr20685349qtq.35.1603745849760;
        Mon, 26 Oct 2020 13:57:29 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w6sm7399683qkb.6.2020.10.26.13.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 13:57:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 0/2] Some block rsv fixes
Date:   Mon, 26 Oct 2020 16:57:25 -0400
Message-Id: <cover.1603745723.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- change the logic to max(1, root level), as generally we do not walk down into
  level 0 for the merge, with the exception for root level == 0.

--- Original email ---

Hello,

Nikolay has noticed that -o enospc_debug was getting some warnings in
btrfs_use_block_rsv() on some tests.  I dug into them and one class is easy to
fix as it's a straight regression.  The other one is going to require some more
debugging, so in the meantime here's the two patches I have so far that can be
merged.  The first is just to make my life easier when debugging these problems,
and the second is the actual regression fix.  It should probably be tagged for
stable as well since the regression was backported to stable.  Thanks,

Josef

Josef Bacik (2):
  btrfs: print the block rsv type when we fail our reservation
  btrfs: fix min reserved size calculation in merge_reloc_root

 fs/btrfs/block-rsv.c  | 3 ++-
 fs/btrfs/relocation.c | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.26.2


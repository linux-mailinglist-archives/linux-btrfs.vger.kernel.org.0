Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC74184FBD
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 20:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgCMT6N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 15:58:13 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:40425 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgCMT6N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 15:58:13 -0400
Received: by mail-qk1-f169.google.com with SMTP id j2so1857154qkl.7
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 12:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I81pMnXmi70dJmB3Ir5Xlco2TaNCgwDWOuxedC+YQS8=;
        b=iuw84SbRfPKkty0rLsKBOt4BuePZ4YHN5eQWgwXz/DQU0j5LPkxhJnCC8uwMxMPJfH
         nBbevHth4B52O0pIJLWAH9dcDl8fohsKpU87cHwcOzaH8jN6BKwat2sBqSc8wgpsuOuP
         OuEAQP1arQM4n3fH2eUGcQgea2egZjOv0NorzHxbwlN/JDMXUfrE4/ceR3Dr02ds+nSp
         lbWqnoE/mzUjFpnrgb+b+2LwnvFdjVLtByOd198TAU5ZAoGwQ82N9EPyBEvY8n2XA7hu
         5qNrOlDJxYgvJ4F6VYj9vwaJqC3GkQ69qz+P4gki0oNHepbWyIgyEP8yA+Z1TvDqzjDb
         uGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I81pMnXmi70dJmB3Ir5Xlco2TaNCgwDWOuxedC+YQS8=;
        b=q8tMjv89fauH+p6AFjpYLiTPy8e85PvBCG4ma7Mb8qNQ9tq9ck9JgW8tXKSH4FUpmB
         CGtnwxlV8uvOOQOprQ1EOYOzBKVQ+b+1o/G+3Q8hXrczooETJWlx6bZrkH5QkWXFV/jI
         GAQD0XbKDHeUiEjFGwF/uOZwQdVQmT9Bu6iEunj8CyUFKcTF+z5kSA85pEHDzjOiXkLt
         EBBgJDitTqlJi9bl9ntVMEIoFl5yPIHik5zeiSEOsaCFWvzli6JH+u2v1p0VXoIUEDAk
         37UiSMUqMYaLSVZDKHmQC3sy8nNtjP9UIwF4eqYfWB14FlouQsUXNB8bXCAlx7VA+S1k
         e91w==
X-Gm-Message-State: ANhLgQ3H4HA3xcR/2eAWu8fj+uD1wfaBGPnO2Lcfo5ifg/QBdSNokiDy
        sDj8GMJtFE93/t2Pf0Bg+EpyLDKVELeIOw==
X-Google-Smtp-Source: ADFU+vvNHfmEm0QdX0ppaoXRF0d9RCXx9x3s4Cgbm9vpxFEWwNyMGoqIRRaLoBxwPCr/bIu5JyDKKQ==
X-Received: by 2002:a05:620a:49:: with SMTP id t9mr15149387qkt.248.1584129491545;
        Fri, 13 Mar 2020 12:58:11 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g4sm8461360qki.8.2020.03.13.12.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:58:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/5][v2] Deal with a few ENOSPC corner cases
Date:   Fri, 13 Mar 2020 15:58:04 -0400
Message-Id: <20200313195809.141753-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v1->v2:
- Dropped "btrfs: only take normal tickets into account in
  may_commit_transaction" because "btrfs: only check priority tickets for
  priority flushing" should actually fix the problem, and Nikolay pointed out
  that evict uses the priority list but is allowed to commit, so we need to take
  into account priority tickets sometimes.
- Added "btrfs: allow us to use up to 90% of the global rsv for" so that the
  global rsv change was separate from the serialization patch.
- Fixed up some changelogs.
- Dropped an extra trace_printk that made it into v2.

----------------------- Original email --------------------------------------

Nikolay has been digging into a failure of generic/320 on ppc64.  This has
shaken out a variety of issues, and he's done a good job at running all of the
weird corners down and then testing my ideas to get them all fixed.  This is the
series that has survived the longest, so we're declaring victory.

First there is the global reserve stealing logic.  The way unlink works is it
attempts to start a transaction with a normal reservation amount, and if this
fails with ENOSPC we fall back to stealing from the global reserve.  This is
problematic because of all the same reasons we had with previous iterations of
the ENOSPC handling, thundering herd.  We get a bunch of failures all at once,
everybody tries to allocate from the global reserve, some win and some lose, we
get an ENSOPC.

To fix this we need to integrate this logic into the normal ENOSPC
infrastructure.  The idea is simple, we add a new flushing state that indicates
we are allowed to steal from the global reserve.  We still go through all of the
normal flushing work, and at the moment we begin to fail all the tickets we try
to satisfy any tickets that are allowed to steal by stealing from the global
reserve.  If this works we start the flushing system over again just like we
would with a normal ticket satisfaction.  This serializes our global reserve
stealing, so we don't have the thundering herd problem

This isn't the only problem however.  Nikolay also noticed that we would
sometimes have huge amounts of space in the trans block rsv and we would ENOSPC
out.  This is because the may_commit_transaction() logic didn't take into
account the space that would be reclaimed by all of the outstanding trans
handles being required to stop in order to commit the transaction.

Another corner here was that priority tickets could race in and make
may_commit_transaction() think that it had no work left to do, and thus not
commit the transaction.

Those fixes all address the failures that Nikolay was seeing.  The last two
patches are just cleanups around how we handle priority tickets.  We shouldn't
even be serializing priority tickets behind normal tickets, only behind other
priority tickets.  And finally there would be a small window where priority
tickets would fail out if there were multiple priority tickets and one of them
failed.  This is addressed by the previous patch.

Nikolay has put these through many iterations of generic/320, and so far it
hasn't failed.  Thanks,

Josef


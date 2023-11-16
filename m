Return-Path: <linux-btrfs+bounces-153-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BDF7EE38A
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 16:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0183B20C1E
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 15:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7C4341B9;
	Thu, 16 Nov 2023 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3E3130
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Nov 2023 06:59:52 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-da3b4b7c6bdso854123276.2
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Nov 2023 06:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146790; x=1700751590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kq6h45tmwWIrAXcowPnzDQPe4RbtD5ZS6HHICzLi5bc=;
        b=g/f8dTS3dYClDz7mmptgXnGhJ/p3vwgtDLjdAoORkRzDes5Y9SVXv+YVYcSPNXlOo0
         Z9q3235gr3O8riiSIYSfy23uG4n0od3V4OF5+5QWRYAPOMkRPneWWAIvUYPhYpSjB1YG
         LpK52tO5hEGBnNhTJDrdoVuv85/3Y0Lcd8SDW4w75VsS/muS+/kMVZawhDz6itRyTMU9
         zqOe9A2yTSJMBl4wM+Qi2uVLAR18CFyegh+eQJDlzRtkpkLsaMyV0yvDD9pGwDI1HetC
         sFUi4lmiPW7FlEsZSo7Pjw1+APc0rLuj8VBbW9gf6oOTBwYpYteRWW4aKnRAnmngHYcs
         G9hA==
X-Gm-Message-State: AOJu0YwuRpik86G2tc/hTtdyavyx6uA/AgW8TUUE6MXcI+5HACpq0MTV
	MP6ps+7bBrGObnKzZrd6DwSB99UuQ5v8rBw/NJo=
X-Google-Smtp-Source: AGHT+IFbWJsplzXplNxUmh0z83CNBLrC22SKvGA216hXLAG798dahnC3znBHPiKOQ3STIK3lOdWnOA==
X-Received: by 2002:a25:50c1:0:b0:da1:5a1a:e79c with SMTP id e184-20020a2550c1000000b00da15a1ae79cmr14763620ybb.50.1700146790340;
        Thu, 16 Nov 2023 06:59:50 -0800 (PST)
Received: from Belldandy-Slimbook.infra.opensuse.org (ool-18e49371.dyn.optonline.net. [24.228.147.113])
        by smtp.gmail.com with ESMTPSA id m1-20020ad44d41000000b00670c7fd09cbsm1430642qvm.95.2023.11.16.06.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 06:59:49 -0800 (PST)
From: Neal Gompa <neal@gompa.dev>
To: Linux BTRFS Development <linux-btrfs@vger.kernel.org>
Cc: Neal Gompa <neal@gompa.dev>,
	Anand Jain <anand.jain@oracle.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.cz>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Davide Cavalca <davide@cavalca.name>,
	Jens Axboe <axboe@fb.com>,
	Asahi Lina <lina@asahilina.net>,
	Asahi Linux <asahi@lists.linux.dev>
Subject: [PATCH v3 0/1] Enforce 4k sectorize by default for mkfs
Date: Thu, 16 Nov 2023 09:50:58 -0500
Message-ID: <20231116145933.2707486-1-neal@gompa.dev>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Fedora Asahi SIG[0] is working on bringing up support for
Apple Silicon Macintosh computers through the Fedora Asahi Remix[1].

Apple Silicon Macs are unusual in that they currently require 16k
page sizes, which means that the current default for mkfs.btrfs(8)
makes a filesystem that is unreadable on x86 PCs and most other ARM
PCs.

This is now even more of a problem within Apple Silicon Macs as it is now
possible to nest 4K Fedora Linux VMs on 16K Fedora Asahi Remix VMs to enable
performant x86 emulation[2] and the host storage needs to be compatible for
both environments.

Thus, I'd like to see us finally make the switchover to 4k sectorsize
for new filesystems by default, regardless of page size.

The initial test run by Hector Martin[3] at request of Qu Wenruo
looked promising[4], and we've been running with this behavior on
Fedora Linux since Fedora Linux 36 (at around 6.2) with no issues.

=== Changelog ===

v3: Refreshed cover letter, rebased to latest, updated doc references for v6.7

v2: Rebased to latest, updated doc references for v6.6

Final v1: Collected Reviewed-by tags for inclusion.

RFC v2: Addressed documentation feedback

RFC v1: Initial submission

[0]: https://fedoraproject.org/wiki/SIGs/Asahi
[1]: https://fedora-asahi-remix.org/
[2]: https://sinrega.org/2023-10-06-using-microvms-for-gaming-on-fedora-asahi/
[3]: https://lore.kernel.org/linux-btrfs/fdffeecd-964f-0c69-f869-eb9ceca20263@suse.com/T/#m11d7939de96c43b3a7cdabc7c568d8bcafc7ca83
[4]: https://lore.kernel.org/linux-btrfs/fdffeecd-964f-0c69-f869-eb9ceca20263@suse.com/T/#mf382b78a8122b0cb82147a536c85b6a9098a2895

Neal Gompa (1):
  btrfs-progs: mkfs: Enforce 4k sectorsize by default

 Documentation/Subpage.rst    | 15 ++++++++-------
 Documentation/mkfs.btrfs.rst | 13 +++++++++----
 mkfs/main.c                  |  2 +-
 3 files changed, 18 insertions(+), 12 deletions(-)

-- 
2.39.2



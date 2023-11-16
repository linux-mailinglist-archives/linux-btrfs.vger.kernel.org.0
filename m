Return-Path: <linux-btrfs+bounces-155-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687CD7EE4E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 17:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C279D2811A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 16:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21DE3A8EB;
	Thu, 16 Nov 2023 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1910193
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Nov 2023 08:02:46 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b52360cdf0so541441b6e.2
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Nov 2023 08:02:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700150565; x=1700755365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vr5Pddkz52KLaIVcaovRBt/aE9k8hc0RxMR8HkFe6f4=;
        b=Xv7XwPLxTiJMS62BldP/8tfzTNQSUf1dKXyG2odZCAjichhzVfHhltXPOCGUnu7Fof
         KA2BJSwuczAn3MU+gf09qCfrqvuE0BQfVQZS8HTCqmfYqyLRx2OhHguHxeQ6RQFv+Yj8
         q/736ObI+g0wkODCr3PUh2sayNxTqVoSYprbXJ6a6VW544lL8bdBjKkr9X67svG7N5HU
         rq9/pFxj0prD1Oj7UmI/5Ent3t11Hg/h9RedC9UEyVo2s9giD4DmP4uZh7+QQPmbtqfy
         BduyIwcVDtorqNd2SOMfH37srHd5ZGO8eFIn36SIPtrT8Qd4Uztog1Sj2b1Tj+cHxfjE
         79Sw==
X-Gm-Message-State: AOJu0YwArqbaqVsjPVaAXT3RvGwNiWqb7fMgGLp7Y19nndfkhtbQMouK
	tBYa1himWOyAmmPjYJ1QKXzLzHWfyR0a2hn3/vk=
X-Google-Smtp-Source: AGHT+IEzeg6XYelO6a2TD1JwyM7LdQMSfZEmNUkLmy0GZalsDy39V/BBn/HOvP0ruoVICBYpE09NKg==
X-Received: by 2002:a05:6808:211:b0:3b2:db2d:7b3d with SMTP id l17-20020a056808021100b003b2db2d7b3dmr15956548oie.33.1700150564883;
        Thu, 16 Nov 2023 08:02:44 -0800 (PST)
Received: from Belldandy-Slimbook.infra.opensuse.org (ool-18e49371.dyn.optonline.net. [24.228.147.113])
        by smtp.gmail.com with ESMTPSA id dj11-20020a056214090b00b00671248b9cfcsm1436868qvb.67.2023.11.16.08.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 08:02:44 -0800 (PST)
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
Subject: [PATCH v4 0/1] Enforce 4k sectorize by default for mkfs
Date: Thu, 16 Nov 2023 11:02:23 -0500
Message-ID: <20231116160235.2708131-1-neal@gompa.dev>
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
possible to nest 4K Fedora Linux VMs on 16K Fedora Asahi Remix machines to
enable performant x86 emulation[2] and the host storage needs to be compatible
for both environments.

Thus, I'd like to see us finally make the switchover to 4k sectorsize
for new filesystems by default, regardless of page size.

The initial test run by Hector Martin[3] at request of Qu Wenruo
looked promising[4], and we've been running with this behavior on
Fedora Linux since Fedora Linux 36 (at around 6.2) with no issues.

=== Changelog ===

v4: Fixed minor errors in the cover letter and patch subject

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



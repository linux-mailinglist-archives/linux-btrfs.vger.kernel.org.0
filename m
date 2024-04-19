Return-Path: <linux-btrfs+bounces-4438-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288A08AB4ED
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 20:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD8C1C221F1
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 18:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B4413BC3A;
	Fri, 19 Apr 2024 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="NFMAwfzH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4250A1E502
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550638; cv=none; b=VmOFTx0XXUBzVcsF8mO1TZ+RUTaEoeRW70jEo8llYxu/Om4yVsTlYki1MLmMUDKMqMKUzGIBq/KGnbPi8N3zHyF/tGb3g6/QuVgfKet732oBi3JS0kWtkm96sioMlApFUw4Pp8DrFga8elj2j2EpAWsRAa7z+mt6EwBPFHnn/OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550638; c=relaxed/simple;
	bh=pCYJ6Oz4T6xz3f5I0NEL4ZcWg7XAMN87SBEhEdLuz3c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UtGFysU+URZ+TdZiznfuYglC86IXRnhcvy38u9rR/j/2eQ3mq9z2HzTxax+gg+TIQtSx4n6T8WaxkFBHG9Xp5UUnngdLbgA/PmhGydj9id/Q8v/a9fwqVPc9a05lAOLIqu4iJ7KQuXQH+kG0TLSCarOEW3QDazTHJ0QfnYYk3Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=NFMAwfzH; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78f05035f56so151001785a.3
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 11:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713550635; x=1714155435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=829jv5Wn+XVIlcclgW/PYz6mP+OAl1y0r0VqrgyHkPo=;
        b=NFMAwfzHXq3AZJEHuq35sc6xxTz+Cpj2v5dfRnoQ4JIo/KUQCcRYaGH0ef5O9w/7AT
         Y05R1cxhAj9ypncoHU46N5dRFlec1woq0/RhxHGNRpT3MAt8F0P/CxYWscWicl6Nw3AM
         FL3jenXeXIFRR+uRjQpxXjvcKcJdSrzoNX9SRKkdzw8m2ShenZxJ76/3dWViDKr63OZu
         ThNnLTYJrokgrTZ/3OwZ+A3ku/JaTFALz0cpuTRZhpsgl0IiO1qLCxXWqsrCUMA6KBen
         Ra5TSo03ZAEe8RjdLduu3ug6LAqfqIZErWH3jjsf596MOQCuq16Z1T9FkwEmzjAnd78m
         aOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550635; x=1714155435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=829jv5Wn+XVIlcclgW/PYz6mP+OAl1y0r0VqrgyHkPo=;
        b=CPe/lIiNAz+rgUh10rYVVe3UaS8AYegq6pxp+FNOB4uceOoLZRSITCZ5+CpEV2clDP
         VDWYYQpwmZG5NbvMDyueZU1wO1ELYU+33VZ2td+2H8Z0F6B7lQckLBC3STooPjnBOQDl
         BavgHGML5LUw+jPoh3q+rrLd0AX/6IenkeURe1CBD90YtiND3u69pRpvkSy0M1XozJPi
         x2RvrCXmkUV4c45nlwfjb7ntbJ4khehLdoGI3uIKl48HskXRBOmXT5akoyuNRLZDAYR2
         g08ySpLf9xv4fTjGcvPF5kotvLSLG8Rdi3l/ZAcy3K5S4Nyokzd0tPt15vLRU3UKcE3q
         3Mqw==
X-Gm-Message-State: AOJu0YyMIq5eKOj40jOWqFk7/M6z6tmch0RxM6BXpIBCOTSBk3Rm5S+F
	/mrlWML4aKahq1uqa4HTNMekHrS42wGqoQ0Eo0fvQR5lIvpQKPBvWgLzAZeOWxcFlAwKp92qsZ8
	w
X-Google-Smtp-Source: AGHT+IFzrRCYcv/J+FbQqJk6+u6p36wnpnGnRJwcL994qMn6TWH0n8c5+723uKVaDCrRG8qZSCkrGA==
X-Received: by 2002:a05:620a:5e52:b0:78f:6bd:15ce with SMTP id ya18-20020a05620a5e5200b0078f06bd15cemr3412931qkn.17.1713550634858;
        Fri, 19 Apr 2024 11:17:14 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id os22-20020a05620a811600b0078eccebcea1sm1810441qkn.17.2024.04.19.11.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:17:14 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 00/15] btrfs: snapshot delete cleanups
Date: Fri, 19 Apr 2024 14:16:55 -0400
Message-ID: <cover.1713550368.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

In light of the recent fix for snapshot delete I looked around at the code to
see if it could be cleaned up.  I still feel like this could be reworked to make
the two stages clearer, but this series brings a lot of cleanups and
re-factoring as well as comments and documentation that hopefully make this code
easier for others to work in.  I've broken up the do_walk_down() function into
discreet peices that are better documented and describe their use.  I've also
taken the opportunity to remove a bunch of BUG_ON()'s in this code.  I've run
this through the CI a few times as I made a couple of errors, but it's passing
cleanly now.  Thanks,

Josef

Josef Bacik (15):
  btrfs: don't do find_extent_buffer in do_walk_down
  btrfs: push ->owner_root check into btrfs_read_extent_buffer
  btrfs: use btrfs_read_extent_buffer in do_walk_down
  btrfs: push lookup_info into walk_control
  btrfs: move the eb uptodate code into it's own helper
  btrfs: remove need_account in do_walk_down
  btrfs: unify logic to decide if we need to walk down into a node
  btrfs: extract the reference dropping code into it's own helper
  btrfs: don't BUG_ON ENOMEM in walk_down_proc
  btrfs: handle errors from ref mods during UPDATE_BACKREF
  btrfs: replace BUG_ON with ASSERT in walk_down_proc
  btrfs: clean up our handling of refs == 0 in snapshot delete
  btrfs: convert correctness BUG_ON()'s to ASSERT()'s in walk_up_proc
  btrfs: handle errors from btrfs_dec_ref properly
  btrfs: add documentation around snapshot delete

 fs/btrfs/ctree.c       |   7 +-
 fs/btrfs/disk-io.c     |   6 +-
 fs/btrfs/extent-tree.c | 507 +++++++++++++++++++++++++++--------------
 3 files changed, 338 insertions(+), 182 deletions(-)

-- 
2.43.0



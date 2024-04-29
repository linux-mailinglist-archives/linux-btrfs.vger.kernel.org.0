Return-Path: <linux-btrfs+bounces-4603-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60DB8B59ED
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02EAA1C2388B
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 13:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E7F6E60E;
	Mon, 29 Apr 2024 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="U2Ud1Y55"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2525F861
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397398; cv=none; b=e8D7M9mHCSSqYXnIVPFXL2/1jwXKRnB4OO/SVgISyfXF/H9zRJbSf08Xirl7/dqrH+S4xNe/s9bkyCb0UuszI6QIJOn5xYGSnO1FPL3cGZuqhis9pKa9Vb1Ufm9qtWI/junT2GjO2pInBQxHTRJIli292tpL5Lna8ALzcPnyXnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397398; c=relaxed/simple;
	bh=ykyFJNO+IN0VT6fr+4JGPU49zOkNv0Wlh9oJ53jBmNY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dE0umFw0CmDTHgynxj+vTTGwUJIVHmcFpOpxZu9oW+wrBVIh4gwvz+2+ytK4cLs5jrwGN9bpQFKaH7EFpApepMF6lK0kE2AgreRtbpON8iqMP6jLxn0/q1CelYNDdXu3KM+OrbunKbhfjz4d751ZJamJpBoR9ibWy9vimqJt4iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=U2Ud1Y55; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78efd533a00so329549885a.0
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 06:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1714397395; x=1715002195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VqR2ctA4Mf90pia68dQ+SfsbzvTJv8sUAWs1JdkaUvw=;
        b=U2Ud1Y55T0bKkF8CxhT0vfi1kU/yuzqBK3QySRBsniBEKTyGUb16vr4RLWSDRk+HCH
         CkK6N7nPsaBoYMGZ0dTerfaJ6RALTBgpFQirm+Zs+8GMiI35p8qo+qaEUiR/5QEYTESm
         3YXOJvfOFuWu59jEDX8PcrFWKAy2eFm8aA+M8MtbGEeZNrqGswnNnxaX7J9Ej02qYHk+
         YhNM6fUev0qLLSDyaRGmiZsyXEf/371UjMi0VVMDYXJmPLsqlyblwmsq+Zot58WKO10t
         QliJ7WU8tYFQtqu1i42sCozLyaN5oINlYNvVFu54vk02uR46uGvy6rz/RyrGsTVX+nLw
         bN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397395; x=1715002195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqR2ctA4Mf90pia68dQ+SfsbzvTJv8sUAWs1JdkaUvw=;
        b=eIdl6JD4H3E5MzopDG49T8sHYozQdrT20rHLNQlYtZypAvVWn3RICiTAyY5ptzwKxg
         fHy+fSnO4dQusisjAP1QmHYWGne37z2jU2wHQ/vC1Ilv4rfUnGEh3jgBatQIuhI36t0P
         ZBPBHxoBK9D1wH5rpjHUSl5CQE8v9dwt6H4obxCfuLB8DwsAqsiE+3CDZLsErxvIGi+5
         Aa6l9GMv4KCMiHclf/pbxCVEhbmK+qNw7Akj3kVnbbI6x1b4mc/AeEvzPAVXJwFvh/pz
         faT4I57xAUmdC5n1tsIIBkkJ3ymncius08QI1ppNS0XFCWpg3ZVR7z6RacjPGo8ibrbf
         M9aw==
X-Gm-Message-State: AOJu0YwqfBD4Rhth+KLtAYljIW57K79qyd5rDsBeWSfGUBJ+zSa1KV9p
	0W35TqLzGDZEu2QRYwQfDe8bCTE2liZ1ZzanJKyKNWWlZEFRuYrLL/rX0kocwlebxlhlDV7r0iH
	L
X-Google-Smtp-Source: AGHT+IENNR8DvTSOnlIdpY7cfKolid/5tP2nL+s30lhJ1Wlxm2wLW6pgej7RPjiEnDWu9f8W/b4ncw==
X-Received: by 2002:a05:6214:501c:b0:6a0:ca16:b625 with SMTP id jo28-20020a056214501c00b006a0ca16b625mr4363245qvb.3.1714397395248;
        Mon, 29 Apr 2024 06:29:55 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c15-20020a0cf2cf000000b00698d06df322sm10423479qvm.122.2024.04.29.06.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:29:55 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 00/15] btrfs: snapshot delete cleanups
Date: Mon, 29 Apr 2024 09:29:35 -0400
Message-ID: <cover.1714397222.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1->v2:
- Simply removed the btrfs_check_eb_owner() calls as per Qu's suggestion.
- Made the 0 reference count error be more verbose as per Dave's suggestion.

--- Original email ---

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
  btrfs: remove all extra btrfs_check_eb_owner() calls
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
 fs/btrfs/disk-io.c     |   4 -
 fs/btrfs/extent-tree.c | 514 +++++++++++++++++++++++++++--------------
 3 files changed, 342 insertions(+), 183 deletions(-)

-- 
2.43.0



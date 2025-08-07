Return-Path: <linux-btrfs+bounces-15913-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F84B1DFDA
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 01:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082AB6280B5
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Aug 2025 23:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953EF26B76A;
	Thu,  7 Aug 2025 23:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ds92zFPX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D9626B0B6
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Aug 2025 23:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754610844; cv=none; b=toa4wq+6gZsDlp5itE9G0sztcOytxWY25YkuXDkuCs2FMKMFpNj+RC1c5igoRsGBtHa90uayLMGcT4OFQhZ/zWnK5e1oSWXVQdpl56/LQJpm5n4dQEXJ8g6SIKKwPtljS3j2EouFG+ji2qClaFo91/YjAYOHLgBJG9jprfHCsf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754610844; c=relaxed/simple;
	bh=UbTtG9CHcbAZudM9eXQpgSsHJ9FkmGLW0cW6u0R/ao0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Nm7/FyBH41YS+KZMeCOs7yYxU54NwpPBUO2NQ8S7AnIq8Nl7TBuxuHnMgTA1yXfaz/P9uDy87xZ1C7OBH1Qjz6aO+qlRtp1sLqgkMH3v4EKpFPAwPEmEiPb6XBvU6xRTM2yEM84mEmLHR46/z10/JcKk1sEoK9oRxHaVMYu7GY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ds92zFPX; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-71b76c2f903so15729067b3.3
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Aug 2025 16:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754610842; x=1755215642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+sc2VKa3WKd9lYVy9QaWVNNeyMKfMiWg4ZmE7U5LoA=;
        b=ds92zFPXFKX2YgtkRr9AvJ++xWZyK2lmLfTWJUjqwoDTQiz3GzwfZy3ULNPErod2+z
         Rh2psUludXM1Myrgp8qxhaCC6CeDn2/mjptVELPNC/gl1kWr7ZJqOFzA8yp9o+Izuj8Q
         IvFOsmmClqNtGm5/zJk0gMmVOWfwHmE6EE4Ff2p1VQfokWskxxSzBaJrujJsObaZOlt9
         x51eL9W5ZZTivCEzyA1W9yWjqTzEpARXUgV8JeKKgMsHxCbTL/FPD1WGBJztJsPEhqj2
         TY6BvGa37qFrqff6jM8J0ZP4KC3NNzqwuejfneEjthHq5u2by61gY39SmDG+/JGl0EPG
         3HTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754610842; x=1755215642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+sc2VKa3WKd9lYVy9QaWVNNeyMKfMiWg4ZmE7U5LoA=;
        b=PgVtbVLX1dJijYqtMvWqyH+q8SasZxgPfLp3gJLrTSzh3BNcy86T1bqZqke6UXR28l
         N0Hp+UfHIjLG4FMr7ei5BkYB5gKRpN6CnHsgcmmeYH/rySGwMwhyHmMtOG8/P5MmyN4c
         hHMtkJidXfzNDlAHjWryWGOJpFLFAWyE4xHvTGOQoB6J+newEP7NSzWF8mgyIDBQjHiX
         K+1ByVSShhnTxIzqtnmvD/qv7KmaQ81R/JZUSOrbbbobmJu7NVuFVM6croW2w+WYjg4j
         keoQX82r2+vfJCdB7mAOawxz+vsrqYSJ1o+H6Jj75/fMC35uBfdPBZ3l48B4n+32WoTr
         KpkQ==
X-Gm-Message-State: AOJu0YzbkRvHjkdmmJhkCIsvx6iGT1FlyTprMSmNjFO9ATKi3AWZzO1x
	sA7E+d3D+1Asl6ZWpEEftO0k9YlVvQDN8Rrz1s8rDmSVbZKi1OMUWbzsHwr/IIYn
X-Gm-Gg: ASbGncvoMRRnk06XTThKKu877/Scc2inZZJiOZ3uDjAN8sfVppYOszhbJCc/rDAyGYc
	sAayzoEYD5J9buOSi3zTVDLG35un42tgyAENKNFPvOwpNw8TwvQe/mhBDuRJ3PpnyaXiy3qDmR5
	IaKKDlpZaz3+n1gwWUOuDHPVb6dgLYs0FC2hmvzQFSt41V26BpItGcYy2DlMsLQS4EO9muWpzAx
	uiM7l4eVIZ0lLLKXiRsw1mEY4RDVl/MKiJPvdIrLluVKq3lLbLfOF7hMK8jElndDHwy95jxw0Tb
	15pIaGqtDOix8HZjgGTHzKeAsvj6wOJ4Jyre7BsvHnhcufCi2emxySdFhDOtErj+YhgitQ8obma
	PLRzq9KltvuSgqiiRfQ==
X-Google-Smtp-Source: AGHT+IGOq7xlb49L6yTx5PW9muf6Qc6rQzGvfAACnEXRRYdsf25kuQetpiiuQTSSlqC1Dg/nRZ80LQ==
X-Received: by 2002:a05:690c:4:b0:71a:186:59af with SMTP id 00721157ae682-71bf0e50542mr12120597b3.30.1754610842024;
        Thu, 07 Aug 2025 16:54:02 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:43::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3f5e08sm49227847b3.27.2025.08.07.16.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 16:54:01 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 0/3] btrfs: ref_tracker for delayed_nodes
Date: Thu,  7 Aug 2025 16:53:53 -0700
Message-ID: <cover.1754609966.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The leading btrfs related crash in our fleet is a soft lockup in
btrfs_kill_all_delayed_nodes caused by a btrfs_delayed_node leak.
This patchset introduces ref_tracker infrastructure to detect this
leak. I'm mirroring the way REF_VERIFY is setup with a Kconfig and
a mount option. I've run a full fstests suite with ref_tracker enabled
and experienced roughly a 7% slowdown in runtime.

Changelog:
v1: https://lore.kernel.org/linux-btrfs/fa19acf9dc38e93546183fc083c365cdb237e89b.1752098515.git.loemra.dev@gmail.com/
v2: https://lore.kernel.org/linux-btrfs/20250805194817.3509450-1-loemra.dev@gmail.com/T/#mba44556cfc1ae54c84255667a52a65f9520582b7

v2->v3:
- wrap ref_tracker and ref_tracker_dir in btrfs helper structs
- fix long function formatting
- new Kconfig CONFIG_BTRFS_FS_REF_TRACKER + ref_tracker mount option
- add a print to expose potential leaks
- move debug fields to the end of the struct

v1->v2:
- remove typedefs, now functions always take struct ref_tracker **
- put delayed_node::count back to original position to not change
  delayed_node struct size
- cleanup ref_tracker_dir if btrfs_get_or_create_delayed_node
  fails to create a delayed_node
- remove CONFIG_BTRFS_DELAYED_NODE_REF_TRACKER and use
  CONFIG_BTRFS_DEBUG

Leo Martins (3):
  btrfs: implement ref_tracker for delayed_nodes
  btrfs: print leaked references in kill_all_delayed_nodes
  btrfs: add mount option for ref_tracker

 fs/btrfs/Kconfig         |  12 +++
 fs/btrfs/delayed-inode.c | 193 ++++++++++++++++++++++++++++-----------
 fs/btrfs/delayed-inode.h |  93 +++++++++++++++++++
 fs/btrfs/fs.h            |   1 +
 fs/btrfs/super.c         |  13 +++
 5 files changed, 257 insertions(+), 55 deletions(-)

-- 
2.47.3



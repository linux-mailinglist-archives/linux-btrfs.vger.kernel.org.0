Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDF5E8EEE9
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 17:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733305AbfHOPAg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 11:00:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36038 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732284AbfHOPAg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 11:00:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id z4so2650281qtc.3
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2019 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OYSGbo2poQ0qyt6wJ+tE5Kkt4rIGLn9ysUdvvgi22no=;
        b=zza1nWLqebk1iLYNx5DS/OPhn1g6yu4ArIKnhwdPTCIcaeVddPkl5mfdlpd1bImjV+
         w7kAzpGzt8V5DPBxk7YsF2MpoGGtQfz369QlMNyJtTG15np6SeD/drrj9jY1HDJJQbFu
         74vKDJBdU6FB0WDFrpBm0FH55Ax0bwCmVl1vc2df+i0e/Fi4szGh6mEfel4CgSUnvAwD
         2N95zRRPbMR3HfLht3mIMDkE9ut3736ZhH5WaBzPNqm2M2SY0WD2Vs/xeFWhQ6mN1BF5
         xF35CfxVR/BfZoNDnbdJ6uqPb6oMOds56tnpJl6nryKsjaxRlrBsft4BOLv4LXFozkMu
         X+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OYSGbo2poQ0qyt6wJ+tE5Kkt4rIGLn9ysUdvvgi22no=;
        b=HsuOH+seBVv0lSMolGin+8rNimXz1jt1P/5kjwZy3GICQqNoOtp602QY10ziawGuGX
         2z5dR5GiCuN2d9X0xlNSYKDph6Mn2tHP+OaJOyICo6rc5yqAIWl9bfE9aJCbLiYUt/3r
         he78bTczNVrbyMy5npRTcIr5df1MTvuH4BxCqI4ChVRQPfqF5ucbD5M+Zfgk04pho5ID
         hVL+G9vl23qsCZIvONSJzfBPa1xeHVGrCHK+3wlVyZOpTZUnRNQwRO/FzKeEQIYZLb6V
         UdBcpzK0EMNnPxSFhFzjRgnZokJkEu4Y2EoJ4CR3lOC7C674bLDobIzlS0pm8t//+BTi
         4MaA==
X-Gm-Message-State: APjAAAW3w7JASyCP8JN5jwIVKr2EBtKdHlgVmY5E1JO6eCUuyZfgJb6a
        fbfgS7uNGsZ6bi9KGzX2uT6YnaFWdZzLGw==
X-Google-Smtp-Source: APXvYqxi1UeJYsp7Y9vq4l18226mn7ewUonKzQ3VzvTO0TmybLaOEJbsDXkr2BZgcBh0OOVoL3TAZw==
X-Received: by 2002:a05:6214:3a5:: with SMTP id m5mr3580174qvy.7.1565881234678;
        Thu, 15 Aug 2019 08:00:34 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k2sm1420787qtq.84.2019.08.15.08.00.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 15 Aug 2019 08:00:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/2] fstests: make generic/500 xfs+ext4 only
Date:   Thu, 15 Aug 2019 11:00:31 -0400
Message-Id: <20190815150033.15996-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I recently fixed some bugs in btrfs's enospc handling that made it start
failing generic/500.

The point of this test is to make the thin provisioned device run out of
space, which results in an EIO being seen on a device from the file
systems perspective.  This is fine for xfs and ext4 who's metadata is
being overwritten and already allocated on the thin provisioned device.
They get an EIO on data writes, fstrim to free up the space, and keep it
going.

Btrfs however has dynamic metadata, so the rm -rf could result in
metadata IO being done on the file system.  Since the thin provisioned
device is out of space this gives us an EIO, and we flip read only.  We
didn't remove the file, so the fstrim doesn't recover space anyway, so
we can't even fstrim and remount.

Make this test for ext4/xfs only, it just simply won't work right for
btrfs in it's current form.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/generic/500 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/500 b/tests/generic/500
index 201d8b9f..1cbd9d65 100755
--- a/tests/generic/500
+++ b/tests/generic/500
@@ -44,7 +44,7 @@ _cleanup()
 rm -f $seqres.full
 
 # real QA test starts here
-_supported_fs generic
+_supported_fs xfs ext4
 _supported_os Linux
 _require_scratch_nocheck
 _require_dm_target thin-pool
-- 
2.21.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5DC612F2D5
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 03:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgACCJh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 21:09:37 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:44037 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgACCJh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 21:09:37 -0500
Received: by mail-pf1-f181.google.com with SMTP id 195so22012919pfw.11
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 18:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=thGWRtVFIS3EMmzgNyiLWzntk1xqsrAkpmv3t5hgL3E=;
        b=c7xks0gkUvyL+kynnFiE1TgnzKu9I/EKiw+0D1hf+RFBZVRL5jrdkPvpv1n4htRoht
         I4XNqqz68cc8vAb0f7uR4bCZpmskPMJtX9BGxN48HnrNHjCbwfyWTPBlGfpzPAq1zsoA
         G67cQW/7GOdGlP666JWNJH1TYDtcyJuR+0r1N6hUOerbdOYP2It2gGAxOpxEENMNNmmp
         M+m5wHT5YJgbVdL/QYxD4Xp+aBPIHOrY1/y1FReufGalWa0O8UCZmcOaDsMDfETR9uYf
         3M2wLJo+56kaKmLNcOM7pG3Hy1jcMymWc1q+3tMLRAjcCM+9IzCJscIfs+dGIyhY6WBA
         +x3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=thGWRtVFIS3EMmzgNyiLWzntk1xqsrAkpmv3t5hgL3E=;
        b=Xe0sxNM3JbAftNHnimrTt0cvaIa0YTxt8iUK/mavdYSmMGICO2ejRmA5L8Hp+3sO8u
         tUoSFwPnFT3KNv7FODfBYC4Vb2dKRtDblqiXuixquGfkNFAMDVrIxb4Eru8M3WdKU2ie
         KZaI0kkFLcMVHZwW8YdkA1Y8/D4DJ+mTw9o8Gk3DxYhZP+7UKos6/je8Ofq9etnraplV
         70k9lixRPKADyFDAvJtWpYsVNPPTadWgtFoFCUdQJs7ZgN6oP1NOkPzxzwgzn9Jb0eul
         XSGHtPjDuESbhObg+dgyUdsOjWbFOnYrq1BYsixWhGT5c4mqvVhy/+IqCm0Sm2Ysxb3Q
         TlDA==
X-Gm-Message-State: APjAAAVnuV79/QNNPe+QH8zX+rNQunr2suPuixOKzmDP7gNpstnzbCzj
        feOPPkVRzGRZG1SZrYDSH9qmbMoBBqE=
X-Google-Smtp-Source: APXvYqyA9/rfy4p91YIUuULAk1WU9JOma4BQzhLE9uRwWuWPvlVeOcM3x9VPxM//ZhJX97MLcsSVRA==
X-Received: by 2002:a63:f814:: with SMTP id n20mr92174245pgh.318.1578017376828;
        Thu, 02 Jan 2020 18:09:36 -0800 (PST)
Received: from localhost.localdomain ([191.248.111.235])
        by smtp.gmail.com with ESMTPSA id o6sm59764152pgg.37.2020.01.02.18.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 18:09:35 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
Subject: [btrfs-progs PATCHv3 0/3] tests: do not fail if dm-thin is missing
Date:   Thu,  2 Jan 2020 23:12:12 -0300
Message-Id: <20200103021215.30147-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This is the third version, which basically removes the last patch, as suggested
by David, and reworks the first one, by keeping the $SUDO_HELPER call and adding
the setup_root_helper function call before calling $SUDO_HELPER. The tests 005
and 017 are now skipped when triggered in a kernel without dm-thin.

Please review.

Original message:

these patchset is trying to fix the issue 192[1] by checking if dm-thin exists,
and if it's not available, skip the test. In the last patch, the same is done
for dmsetup. Feel free to ignore the last patch if you think we should stop the
tests if dmsetup isn't available.

Thanks!

[1]: https://github.com/kdave/btrfs-progs/issues/192

Marcos Paulo de Souza (3):
  tests: common: Add check_dm_target_support helper
  tests: mkfs: 017: Use check_dm_target_support helper
  tests: mkfs: 005: Use check_dm_target_support helper

 tests/common                                      | 15 +++++++++++++++
 .../005-long-device-name-for-ssd/test.sh          |  1 +
 .../test.sh                                       |  1 +
 3 files changed, 17 insertions(+)

-- 
2.24.0


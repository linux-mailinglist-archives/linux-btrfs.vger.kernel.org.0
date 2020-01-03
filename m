Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3011812F2D8
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 03:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgACCJp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 21:09:45 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:44180 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbgACCJp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 21:09:45 -0500
Received: by mail-pg1-f171.google.com with SMTP id x7so22743165pgl.11
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 18:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80N844XMKIxI9lCIsPMKOzA3L+8oeZaB7DuEByty7Do=;
        b=JqvL9aXar/tiCQZnX1Jl3ElV1vtlnFWGBUJcgiBlkwmf31TUM7NGA9foVkE2+WqJap
         eHGX/fm4C/nC1uRz0GxtJiqYP2D7AhmxeMY1dPq9bW1aWzbdSl+wnLm9gXKfnTbiB0H7
         2loRPhPiEZvLLqol+T4yY36PyDY05j0xa5d5l66rpPoZ8TD3gs0fBbSATe4dCC3vpDwn
         jqO/SqOjxL3lINQrYdiZ6dQfuHLbFDPpkJpvzA7sNbVnmgEn7UiZyoyt+Go6B5h5chX1
         ApQsJwcRZOJQJEapiWuiG8Hhn/Ca1NDQxpBm43Qg6aMgWkW3lsQJXA67+ZASAa/6lKDW
         rlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80N844XMKIxI9lCIsPMKOzA3L+8oeZaB7DuEByty7Do=;
        b=Kg+8loJwp7V2bYHxuIBw76OqLKY3l0sw67ryt6wixdbtRWjUvBLwM1jFxSbUnwPwW3
         s9Bm5qVWOmYdsH+bUv92ElB5w3uMfV7W27ayVYQxd3ubB5X+csihGkhk5szDFcI0NLyA
         RvCPS8YIfQsw2SO4Xpb8851c6x7q2yWgTZFOSTqgzvP7i0klV/zo0v4pjLy1L88hLYvt
         5O8vcZkrNydlbtoV9fAhjc8YwvOrva6hTHJJbnFGCutZxhBbl2v7vh2vIx/2zEI1XG9Q
         SS+9Y8zbdf3oBcMn77w9bBUTad4vvErB80HXRnUC0iiIUqs+Xc23RxVTqjcMhH5k0POV
         yJZQ==
X-Gm-Message-State: APjAAAXJd+aVrv470Z+08gIEL5g4BQgle/1sIURFOY0EtKjuI9Ef8AoU
        UjIGfks/36RNV9IzibGCkS9m6RaPOlY=
X-Google-Smtp-Source: APXvYqyQWioxG75kSulcxSwGh5xR81oczf++YmEsCdKFSWFBvy0VQTeTMJTyII/nIMCEDcPC3XDQcQ==
X-Received: by 2002:a63:eb02:: with SMTP id t2mr93539711pgh.289.1578017384505;
        Thu, 02 Jan 2020 18:09:44 -0800 (PST)
Received: from localhost.localdomain ([191.248.111.235])
        by smtp.gmail.com with ESMTPSA id o6sm59764152pgg.37.2020.01.02.18.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 18:09:43 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
Subject: [btrfs-progs PATCHv3 3/3] tests: mkfs: 005: Use check_dm_target_support helper
Date:   Thu,  2 Jan 2020 23:12:15 -0300
Message-Id: <20200103021215.30147-4-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200103021215.30147-1-marcos.souza.org@gmail.com>
References: <20200103021215.30147-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This way we ensure the linear target is available and skip the test.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/mkfs-tests/005-long-device-name-for-ssd/test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh b/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
index e7a1ac45..329deaf2 100755
--- a/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
+++ b/tests/mkfs-tests/005-long-device-name-for-ssd/test.sh
@@ -5,6 +5,7 @@ source "$TEST_TOP/common"
 
 check_prereq mkfs.btrfs
 check_global_prereq dmsetup
+check_dm_target_support linear
 
 setup_root_helper
 prepare_test_dev
-- 
2.24.0


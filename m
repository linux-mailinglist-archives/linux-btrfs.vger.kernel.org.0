Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB81812F2D7
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 03:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgACCJn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 21:09:43 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:39150 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbgACCJm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 21:09:42 -0500
Received: by mail-pg1-f172.google.com with SMTP id b137so22748757pga.6
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 18:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9f7024WrI3Omlk1eVTEOqarVd/Nh5MuM4mAVbLa9Mbw=;
        b=XroIjPBFBIGCDSqYK2rBw+bzcgT6FbOwtftu1o3g7HvkGqti0t8HoFMVSoDULMNg7P
         p8cZJpR4v96V3Zjd8ijtM+1xeGgdQrI5twyOQ8Trd1Hp5eXbA+pFHBbGYL36izmfGUCK
         3pLV9UkW//o2RimOsVSNUK2KsSa1TSEluxdvxlUjnscayMIPDYGN7XdqyCxBKBB1vz9K
         Xsuc5g43zQ0Vp4btYU3JDETKYBwmGMPtpm9liLw3R5RxIR9NzEewfMbSlEzej/wBxkRd
         Yqt9vG8U0cWTjUqCmwomERSkeq3N5pXEKhW8/S10AHCRyC5pIVWl6R0bCr6VeAAQ8UhK
         otZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9f7024WrI3Omlk1eVTEOqarVd/Nh5MuM4mAVbLa9Mbw=;
        b=dKUqd/JyisNF9gtT9U4set1mspEpgMpDZ3a6lZCFq3FXGYYZbpPdPAotsUErwQXXvY
         /31voBQF7xnPfHcTund4B1g9KwTwhRZaBeHpLWuBQqNab/z2Viv/sz0Y6kFjFZw1VDbo
         xaqbEohRramMtUhaEVeL8t/AuUSnn3CzMd2Ju8hxlc2RoQM+tlT/DmnnnCt8sTjzHnGs
         vHMDr/aCyKV1gPwK1VbK/3m4iWe/dPz4yA5qojlbzXOTTidk/3vUTenvg2sUAmlkUnan
         wCSigXegI9Ctx6JB6qKR8cy780Z8iONVxaqN1qfMEyYHW1If4hPn/gSM7qTnSUTSaDBy
         CFgQ==
X-Gm-Message-State: APjAAAUqySzZlMOX2Pu1oJSgbimuIDYL4Sgbh7UgVcxby1wkl2RkAfsl
        sjAToNUknVijkqGATo4OyM8UDd1CZaI=
X-Google-Smtp-Source: APXvYqz2mDaXb1t+e/bCtpo0JVAsgI7/yX1lJIAt2EksRRzDznvY8uVpgePheUkI2kvGmUjk05hk3A==
X-Received: by 2002:a62:3343:: with SMTP id z64mr89016365pfz.150.1578017381893;
        Thu, 02 Jan 2020 18:09:41 -0800 (PST)
Received: from localhost.localdomain ([191.248.111.235])
        by smtp.gmail.com with ESMTPSA id o6sm59764152pgg.37.2020.01.02.18.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 18:09:41 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com
Subject: [btrfs-progs PATCHv3 2/3] tests: mkfs: 017: Use check_dm_target_support helper
Date:   Thu,  2 Jan 2020 23:12:14 -0300
Message-Id: <20200103021215.30147-3-marcos.souza.org@gmail.com>
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

If dm-thin or dm-linear are not supported, let's skip the test altogether
instead of throwing an error.

Issue: #192

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 .../017-small-backing-size-thin-provision-device/test.sh         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/mkfs-tests/017-small-backing-size-thin-provision-device/test.sh b/tests/mkfs-tests/017-small-backing-size-thin-provision-device/test.sh
index 32640ce5..91851945 100755
--- a/tests/mkfs-tests/017-small-backing-size-thin-provision-device/test.sh
+++ b/tests/mkfs-tests/017-small-backing-size-thin-provision-device/test.sh
@@ -7,6 +7,7 @@ source "$TEST_TOP/common"
 check_prereq mkfs.btrfs
 check_global_prereq udevadm
 check_global_prereq dmsetup
+check_dm_target_support linear thin
 
 setup_root_helper
 prepare_test_dev
-- 
2.24.0


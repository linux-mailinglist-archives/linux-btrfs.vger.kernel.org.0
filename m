Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E35E41143B1
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 16:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfLEPen (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 10:34:43 -0500
Received: from mail-pj1-f48.google.com ([209.85.216.48]:39413 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfLEPem (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 10:34:42 -0500
Received: by mail-pj1-f48.google.com with SMTP id v93so1437124pjb.6
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 07:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBqssDWid5kSZYsGXvtqv/P21KuWVrXmG18GmADihQ4=;
        b=YgMGssNbx733h+S23TwCqTHyCK8/oBKjYInxg1mQE0/u3iHsZzQfN/cpBHOV9bxJYJ
         crTFlzl4aMse2R0kPcSCrt8bzaiHBlcxJNbyGuaG/t4MJtrfPGoEl/Kd4Tj+tSYxc/3U
         4PKQd2207BV+83dieg7hzgwRgnJchoopGeQhZMT7G2up2EpGcfINujC3xlijiwgTj2Fh
         lB7t8P+7r6aNsl341sMaIhCbzEFoLYyxCkSTciHncPs1y7j0ceCg+joFWL+0MVMl0jm7
         D3JGtsQVomwtHsxKyrU2AzeNbhWiY70NZLkTYsOWlYK3dzQXZq39JetR3M4RSHij5BjM
         g5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBqssDWid5kSZYsGXvtqv/P21KuWVrXmG18GmADihQ4=;
        b=NbVYiVFtHwAvNY58gpqTnF+1rDOGQuqbsk2ZIO2TsYxwZveCrKbU2uZ/ibL7gvJg2x
         SmcHaNE/PE7Ya+YPzRUnAhw0c+zL5TaGI/i/fMnYu1fVHB7pUvZmQ0rV9bTxHnhRbsgT
         KezES/j6un+bZYpbvJjefeuLcgSAY3jPc38yA0kXYvo/WeObLxnpGJgTizYwEcpM4cCb
         HaLUc8U5r7L8wOx01RIX+OtmWZbWzOxHrIgiePK6b4+9H3T6mwbjl0GJSuYONSTUm9tH
         a3HhaTWZtQ8u8X7NHuXds6sZvN/vXDFyrf1DtoCVazkqu2KhTIbctVYioTqbzjYFUjcB
         M0LA==
X-Gm-Message-State: APjAAAVnmxIWVIzFS8UFC5maMcnO44yUoM630mQLvJWMjPnVoFN6HHKd
        hwEpunjPa8feB83QjfEcBZ0+FMjf
X-Google-Smtp-Source: APXvYqwc17l3pFBfQs6nBDmf6U0MvKswuGbQu7TxXomWjeH3y5iwGVtxreyCrI/fCzghkttaTGg+mg==
X-Received: by 2002:a17:902:82c3:: with SMTP id u3mr8999386plz.73.1575560081890;
        Thu, 05 Dec 2019 07:34:41 -0800 (PST)
Received: from hephaestus.prv.suse.net ([179.185.217.252])
        by smtp.gmail.com with ESMTPSA id z130sm12286914pgz.6.2019.12.05.07.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 07:34:41 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 1/2] btrfs-progs: mkfs-tests: Set $csum so mkfs.btrfs does not fail
Date:   Thu,  5 Dec 2019 12:36:46 -0300
Message-Id: <20191205153647.31961-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tests/mkfs-tests/020-basic-checksums-mount/test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/mkfs-tests/020-basic-checksums-mount/test.sh b/tests/mkfs-tests/020-basic-checksums-mount/test.sh
index 41ef5417..b7252786 100755
--- a/tests/mkfs-tests/020-basic-checksums-mount/test.sh
+++ b/tests/mkfs-tests/020-basic-checksums-mount/test.sh
@@ -12,6 +12,7 @@ prepare_test_dev
 
 test_mkfs_mount_checksum()
 {
+	csum=$1
 	run_check_stdout $SUDO_HELPER "$TOP/mkfs.btrfs" -f --csum "$csum" "$TEST_DEV" | grep -q "Checksum:.*$csum"
 	run_check $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super "$TEST_DEV"
 	run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
-- 
2.23.0


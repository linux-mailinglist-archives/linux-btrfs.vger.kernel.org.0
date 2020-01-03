Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17EF212F73C
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 12:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgACL33 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 06:29:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55446 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbgACL33 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jan 2020 06:29:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so8096196wmj.5;
        Fri, 03 Jan 2020 03:29:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tmqzLslb6L779oXexaa6bDxetpW67XU58Vd325R8/dk=;
        b=LHnVFm8NiRrEB2zpdkbRGe4AsjO4E6sIqesbjzl+6gLdezkowW/mnGB7CYrsTRdkOp
         0UU/hyCg4UQ5KuOC0qJ1o5o3i/8ew+WZt3VxkRyqWigbTfwDMZxhXo9jaU5dSYle/XK/
         rd5Q+FSWVaLYF67rLzxbLbBfNQpELmlM0ls/x/X18Sihtx83ywXEc0JBwrVtRbQyvlqu
         sPzQnUBnZWtIN1PtdPsfhp5p+U41HTNwr/Mv/vaUJhDxu5si/Ca6x6cM4yLFN1NMLO1S
         9e6mD8vGn5pKu0GMDRhpm0J4TvDAPYH594szy1RzpAt/AJIF+V/X72xQQCJ5MqweDXXM
         TI1g==
X-Gm-Message-State: APjAAAXg+OKhspzTDDlwfzqNDpd5bW1oVYtLCt0fcTxd1Uejz2ofkR4v
        lQ9PAKwpJioVJ68szsJalN0=
X-Google-Smtp-Source: APXvYqzcGd1O5Tej9V2s6gSu8GzGlgNve6nRrPepp23GH+eQAXzrxt0QaMXC6EhEjPVHYF2JUxZE5g==
X-Received: by 2002:a05:600c:220e:: with SMTP id z14mr19212200wml.114.1578050967602;
        Fri, 03 Jan 2020 03:29:27 -0800 (PST)
Received: from linux-t19r.fritz.box (ppp-46-244-218-95.dynamic.mnet-online.de. [46.244.218.95])
        by smtp.gmail.com with ESMTPSA id w22sm11308657wmk.34.2020.01.03.03.29.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 03:29:27 -0800 (PST)
From:   Johannes Thumshirn <jth@kernel.org>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH] btrfs/139: require 2GB scratch dev
Date:   Fri,  3 Jan 2020 12:29:05 +0100
Message-Id: <20200103112905.1078-1-jth@kernel.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In my testing on 1GB zram devices btrfs/139 usually fails with
ENOSPC.

Add a requirement for 2GB scratch devices (empirically measured).

Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 tests/btrfs/139 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/btrfs/139 b/tests/btrfs/139
index 5664617c..2f84c811 100755
--- a/tests/btrfs/139
+++ b/tests/btrfs/139
@@ -31,6 +31,9 @@ _cleanup()
 # remove previous $seqres.full before test
 rm -f $seqres.full
 
+# We at least need 2GB of free space on $SCRATCH_DEV
+_require_scratch_size $((2 * 1024 * 1024))
+
 _supported_fs btrfs
 _supported_os Linux
 _require_scratch
-- 
2.16.4


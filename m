Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFAB815F7C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 21:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgBNUee (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 15:34:34 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45057 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbgBNUee (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 15:34:34 -0500
Received: by mail-qt1-f193.google.com with SMTP id d9so7827555qte.12
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2020 12:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cMd6saOdi3DDi8CRdIOgvhgNU02W4rGFc1+0LI1/+d0=;
        b=2R68OHPhYM3u7KgG8bg0Q84oJu4niwMadwOI8C2lZzmZOr0zTYIhKSLLgJekCBKJMQ
         +rEMXC54PABqI/MQ/x8fH/2ppC9ZTgzAh2VSahPAErbc6kd3fW/OhCdRWfXaxbhmWCNQ
         I14y+wyQOIQuLFYkaOuckpdexiGIK0UzvDGrb5uVzQb5IXcDar8WkK5XJ94CCMygrCd6
         rj5MGGgWl/sRrxDOifX3KcW6yxEwfELHMKpANcIOCtKU+PCwhBbJhnogjxHH0UPP+pyZ
         E2Fvp04/8xRbRBq02XlTg8951qe/xQVnR17MvKpnWF1gUb8VowOvFzpuLAV81dmYvbHF
         b3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cMd6saOdi3DDi8CRdIOgvhgNU02W4rGFc1+0LI1/+d0=;
        b=X3lN+s3cHPPJorbjfkz4m0rPG8W1zPOWQ5Mq/KLqca+LHPOURj7TAE2WemLApbP+M9
         mmKzJ35UEUf3qfDbgF7EouDt0jBVyLQ37N0Yz18mkMD23L4eHVh4d2WWjzjx0NB/4b1+
         oZ2yBBLwua9fwqb8zm1qBMpu+6oDCy+JG7IgTE2X8iPI9oXvgaeHDG1fbhAVtJD7udxh
         IgIXT0F8KrCevvoD8ruyMzFtPogUYGHWvMjmW68fOTlgZxemzhbbVVE7Ofhq3GYj6stq
         vG+C9rw3R2KpLSHZiTjmhuCfR8af87o6WIAWIRI37vM0eSyXiuY+VR3s0RMbDlbUFnJz
         VoYA==
X-Gm-Message-State: APjAAAUhJA7dzWzLpn4LlXjCeyZ0gaCFTpiH4r/hw8LlNFk4CFhNmYAy
        0T4uX5e/2iabi93In4RH+TPSdOQhmyg=
X-Google-Smtp-Source: APXvYqw9un91A7rs7cHgHwlgL91WG5yFjRh/Ns9R0eZwuuRXy2lXRhl7A/nX/IxTPowMGclaY3Jy5Q==
X-Received: by 2002:ac8:67d7:: with SMTP id r23mr4070356qtp.20.1581712472948;
        Fri, 14 Feb 2020 12:34:32 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z5sm4216026qta.7.2020.02.14.12.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:34:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH] xfstests: add a CGROUP configuration option
Date:   Fri, 14 Feb 2020 15:34:31 -0500
Message-Id: <20200214203431.24506-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I want to add some extended statistic gathering for xfstests, but it's
tricky to isolate xfstests from the rest of the host applications.  The
most straightforward way to do this is to run every test inside of it's
own cgroup.  From there we can monitor the activity of tasks in the
specific cgroup using BPF.

The support for this is pretty simple, allow users to specify
CGROUP=/path/to/cgroup.  We will create the path if it doesn't already
exist, and validate we can add things to cgroup.procs.  If we cannot
it'll be disabled, otherwise we will use this when we do _run_seq by
echo'ing the bash pid into cgroup.procs, which will cause any children
to run under that cgroup.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 README |  3 +++
 check  | 17 ++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 593c1052..722dc170 100644
--- a/README
+++ b/README
@@ -102,6 +102,9 @@ Preparing system for tests:
              - set USE_KMEMLEAK=yes to scan for memory leaks in the kernel
                after every test, if the kernel supports kmemleak.
              - set KEEP_DMESG=yes to keep dmesg log after test
+             - set CGROUP=/path/to/cgroup to create a cgroup to run tests inside
+               of.  The main check will run outside of the cgroup, only the test
+               itself and any child processes will run under the cgroup.
 
         - or add a case to the switch in common/config assigning
           these variables based on the hostname of your test
diff --git a/check b/check
index 2e148e57..07a0e251 100755
--- a/check
+++ b/check
@@ -509,11 +509,23 @@ _expunge_test()
 OOM_SCORE_ADJ="/proc/self/oom_score_adj"
 test -w ${OOM_SCORE_ADJ} && echo -1000 > ${OOM_SCORE_ADJ}
 
+# Initialize the cgroup path if it doesn't already exist
+if [ ! -z "$CGROUP" ]; then
+	mkdir -p ${CGROUP}
+
+	# If we can't write to cgroup.procs then unset cgroup
+	test -w ${CGROUP}/cgroup.procs || unset CGROUP
+fi
+
 # ...and make the tests themselves somewhat more attractive to it, so that if
 # the system runs out of memory it'll be the test that gets killed and not the
 # test framework.
 _run_seq() {
-	bash -c "test -w ${OOM_SCORE_ADJ} && echo 250 > ${OOM_SCORE_ADJ}; exec ./$seq"
+	_extra="test -w ${OOM_SCORE_ADJ} && echo 250 > ${OOM_SCORE_ADJ};"
+	if [ ! -z "$CGROUP" ]; then
+		_extra+="echo $$ > ${CGROUP}/cgroup.procs;"
+	fi
+	bash -c "${_extra} exec ./$seq"
 }
 
 _detect_kmemleak
@@ -615,6 +627,9 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	  echo "MKFS_OPTIONS  -- `_scratch_mkfs_options`"
 	  echo "MOUNT_OPTIONS -- `_scratch_mount_options`"
 	fi
+	if [ ! -z "$CGROUP" ]; then
+	  echo "CGROUP        -- ${CGROUP}"
+	fi
 	echo
 	needwrap=true
 
-- 
2.24.1


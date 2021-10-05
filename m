Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3376B421B9F
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 03:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhJEBRR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 21:17:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33988 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbhJEBRE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 21:17:04 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8BB142025F
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Oct 2021 01:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633396513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RxMESj0DPYskXGIRWeUBmyZ+XED3JrCZp/Q1RAFgf1M=;
        b=tF+Aoqh7XWLVMfi0xe0cydBlJTjtcgW6nROptcic0XuIfKCNTjlNb8thMo0B4J/e99K+FO
        NV/Qqfr0t9ayJAsThfazF0qIXYxx0UZ7+5bRHRxSQEMBQfn3kftgR/DowpWhckph/o/nJb
        617zpITuS81Q4LR7uP9PYXR0Z8n9/Kc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C742A13B51
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Oct 2021 01:15:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e8VTIiCnW2HEcAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Oct 2021 01:15:12 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/2] btrfs-progs: receive: introduce new --clone-fallback option
Date:   Tue,  5 Oct 2021 09:14:53 +0800
Message-Id: <20211005011455.24121-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When parent stream and incremental stream are received with different
nodatasum mount options, any clone opeartion in the incremental stream
will be rejected by kernel.

There are more situations to cause clone failure, like receiving a stream
on a fs with different sectorsize.

Thus this patchset will introduce a new option, --clone-fallback, for
btrfs receive to fall back to buffered write when clone failed.

This fall back behavior will only happen if the new option is explicitly
specified, as such behavior can hide some send bugs, and under most sane
cases users don't need such option.

Also add a test case for the new option.

Changelog:
RFC->v1:
- Introduce a new option for the fallback behavior
  To avoid hide send bugs.

- Hide the warning message behind -v option
  Since we have a special option for it thus users are aware of what
  they are doing, there is no need to output such warning by default.

- Add a new test case for it

v2:
- Add the missing help string for --clone-fallback option

- Rephrase the words in comments and commit messages

- Add run_check_remount_test_dev() helper

v3:
- Add an overview of failed clone operations for --clone-fallback option

- Update doc words again

Qu Wenruo (2):
  btrfs-progs: receive: fallback to buffered copy if clone failed
  btrfs-progs: misc-tests: add test case for receive --clone-fallback

 Documentation/btrfs-receive.asciidoc          | 13 +++
 cmds/receive.c                                | 80 ++++++++++++++++++-
 tests/common                                  |  9 +++
 .../049-receive-clone-fallback/test.sh        | 58 ++++++++++++++
 4 files changed, 157 insertions(+), 3 deletions(-)
 create mode 100755 tests/misc-tests/049-receive-clone-fallback/test.sh

-- 
2.33.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D299319F044
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 08:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgDFGLL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 02:11:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:42768 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgDFGLL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Apr 2020 02:11:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DE54FABF5
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Apr 2020 06:11:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs-progs: tests: Enahance INSTRUMENT coverage
Date:   Mon,  6 Apr 2020 14:11:04 +0800
Message-Id: <20200406061106.596190-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset will enhance INSTRUMENT coverage for all btrfs related
commands.

Since now INSTRUMENT would also cover a lot of btrfs inspect-dump
comands, fix some test cases where INSTRUMENT output could easily
pollute them.


Now fsck/convert/misc/mkfs all pass with
INSTRUMENT="valgrind --leak-check=full".

Changelog:
v2:
- Pass INSTRUMENT as space split command

- Unset previous cmmd_array in expand_command()
  Instead of unsetting it.

- Use local variable @i in expand_command()
  To fix misc/004

- Add extra commands for INSTRUMENT coverage
  This incldues btrfstune, btrfs-corrupt-block, btrfs-image,
  btrfs-select-super, btrfs-find-root.

- Fix test cases which uses run_check_stdout without filtering

Qu Wenruo (2):
  btrfs-progs: tests: Don't use run_check_stdout without filtering
  btrfs-progs: tests: Introduce expand_command() to inject aruguments
    more accurately

 tests/common                                  | 179 +++++++++---------
 tests/misc-tests/004-shrink-fs/test.sh        |   2 +-
 .../009-subvolume-sync-must-wait/test.sh      |   2 +-
 .../013-subvolume-sync-crash/test.sh          |   2 +-
 .../024-inspect-internal-rootid/test.sh       |  14 +-
 .../031-qgroup-parent-child-relation/test.sh  |   4 +-
 6 files changed, 102 insertions(+), 101 deletions(-)

-- 
2.26.0


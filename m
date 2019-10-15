Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87640D7A0E
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 17:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbfJOPmx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 11:42:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:44480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731093AbfJOPmx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 11:42:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D85C3B4B8;
        Tue, 15 Oct 2019 15:42:51 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 0/2] Support patches for btrfs backup root rework
Date:   Tue, 15 Oct 2019 18:42:47 +0300
Message-Id: <20191015154249.21615-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Here are two patches which I cooked up while working on the kernel side of backup
root retention code. The first one fixes '-m <bytenr> -f generation' options to 
btrfs-corrupt-block, allowing me to simulate backup root corruption. 

The second patch is a test case which sanity checks the implementation. It suceeds
both before and after my rework of the kernel code. 

Nikolay Borisov (2):
  btrfs-progs: corrupt-block: Refactor tree block corruption code
  btrfs-progs: tests: Test backup root retention logic

 btrfs-corrupt-block.c                              | 108 +++++++++++----------
 .../misc-tests/038-backup-root-corruption/test.sh  |  50 ++++++++++
 2 files changed, 107 insertions(+), 51 deletions(-)
 create mode 100755 tests/misc-tests/038-backup-root-corruption/test.sh

-- 
2.7.4


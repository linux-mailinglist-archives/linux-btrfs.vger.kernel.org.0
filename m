Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9B34467DB
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 18:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhKER2i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 13:28:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50982 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbhKER2g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 13:28:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 328F621892
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 17:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636133155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ga0kiMY/4CTSJ9IMwogH7FDYnYmExCjS22ypa/BkqB8=;
        b=K7lIzux5VZt2+XJnGPDLXMGvxs6QMfoY9uOI+C0uKRKs6PPZja7OhD5nRY4WdO9sMun8XX
        NLMlxUx6RoY0oIcAP/qc09NrQBUUDR1451cENjnnYyXqbXsi3T6AVtRJu9qNEzpWfHhoEa
        ew6E2IU/HKopAIBtrCf45d2cLUBmm18=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2C2422C14A
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 17:25:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1E313DA799; Fri,  5 Nov 2021 18:25:17 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.15
Date:   Fri,  5 Nov 2021 18:25:17 +0100
Message-Id: <20211105172517.15055-1-dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.15 have been released.

Changelog:

* mkfs: new defaults!
  * no-holes
  * free-space-tree
  * DUP for metadata unconditionally
* libbtrfsutil
  * add missing profile defines
* libbtrfs
  * minimize its impact on the other code, refactor and separate implementation
    where needed, cleanup afterwards, reduced header exports
* documentation
  * introduce sphinx build and RST versions of manual pages, will become the
    new format and replace asciidoc
* fixes:
  * fix warning regarding v1 space cache when only v2 (free space tree) is
    enabled
* other
  * lots of cleanups and refactoring
  * zoned mode uses direct io for file backed images
  * new and updated tests

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

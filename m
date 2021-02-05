Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE64310A48
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 12:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhBELa3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Feb 2021 06:30:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:39362 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231902AbhBEL1m (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Feb 2021 06:27:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612524417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=eQIofa30cCkN7y4ClsGB9bbxRDn4Y+mTe8fkzhscrjs=;
        b=KTAwrTVqNW9QKHYmK5vcKeUnFZ96ke7L17FlmMVcJDgqCqDsLmF8bis+jMTz6zed2wZ1uT
        tJjgF/anul/SarMmDNrNbDpJmMCznNYiFFKsu/eraLdRN6wh8vxGS15vcFk8Vkqi6N4oVm
        k1WgxiMEsEadf3UfO+JX7fL0Db5OhmQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D994FACBA
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Feb 2021 11:26:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7F726DA7DE; Fri,  5 Feb 2021 12:25:06 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 5.10.1
Date:   Fri,  5 Feb 2021 12:25:06 +0100
Message-Id: <20210205112506.4274-1-dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 5.10.1 have been released.

The static build got broken due to libmount added in 5.10, this works now. The
minimum libmount version is 2.24 that is not available on some LTS distros like
CentOS 7. The plan is to bring the support back, reimplementing some libmount
functionality and dropping the dependency again.

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

David Sterba (6):
      btrfs-progs: build: fix linking with static libmount
      btrfs-progs: tests: add support to test the .static binaries
      btrfs-progs: docs: clarify scrub requiring mounted filesystem
      btrfs-progs: INSTALL: update build dependencies
      btrfs-progs: update CHANGES for 5.10.1
      Btrfs progs v5.10.1

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF8A43FFDF
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Oct 2021 17:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhJ2P4u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 11:56:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41986 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJ2P4t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 11:56:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3377D212FE
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Oct 2021 15:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635522860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=lFI5nuo4Q3md4jio7vyayVfMO8UfzZVl1oBBIOT/UN8=;
        b=T9dT007bq6Utwq/+7S8ekHEgeHTXSArFkduaPMwWDqC2aDJ11FIXMMKuE7xCXs6NlwNigE
        XWC2zpxsr+5Sr/vJStj2xrXnxWF/iiMYCPYhTbNAT2KRDiK6ozFCbnGWESo4QCL0mNzGp8
        +9EADttZYygTN3bOm2ClykmMwTDUw74=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2D411A3B81
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Oct 2021 15:54:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 07DABDA7A9; Fri, 29 Oct 2021 17:53:46 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs pre-release 5.15-rc1
Date:   Fri, 29 Oct 2021 17:53:46 +0200
Message-Id: <20211029155346.19985-1-dsterba@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

this is a pre-release of btrfs-progs, 5.15-rc1 (version tag is v5.14.91).

The proper release is scheduled to next Friday, +7 days (2021-10-05).

The noticeable changes are in the mkfs defaults:

  * no-holes
  * free-space-tree
  * DUP for metadata unconditionally

This is based on numerous user requests and discussions, and after long period
where the respective features have been in released kernels.

Other changes:

* libbtrfs - minimize its impact on the other code, refactor and separate
  implementation where needed, cleanup afterwards, reduced header exports

* documentation - introduce sphinx build and RST versions of manual pages, will
  become the new format and replace asciidoc
  (Preview at https://deleteme12545.readthedocs.io/en/latest/index.html)

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git


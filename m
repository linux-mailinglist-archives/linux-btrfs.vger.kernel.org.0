Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E4D3549B6
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 02:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241670AbhDFAgP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Apr 2021 20:36:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:54088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230309AbhDFAgP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Apr 2021 20:36:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617669367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Eoqme7/6FuIaiaCZdx4Q+vHe5jqj74GizKzf/xvxPs8=;
        b=JY4CueWsEba/gB4A/2Za/nQg654J06F8Y3DKBn5HwZzSqZ/fsWahPMIz06WMSbbWkAv5s4
        r6t/scEvThFDjtDEEwQVp1y+UdnMxbEnqh9b9Z3HeSGWna8g6clrXtHW9SQe9MjsCu6nhJ
        Jp8W1KCKWZHwP6J6HMWQ229ZO0C4vlQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 62834ACC4
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Apr 2021 00:36:07 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: the missing 4 patches to implement metadata write path
Date:   Tue,  6 Apr 2021 08:35:59 +0800
Message-Id: <20210406003603.64381-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When adding the comments for subpage metadata code, I inserted the
comment patch into the wrong position, and then use that patch as a
separator between data and metadata write path.

Thus the submitted metadata write path patchset lacks the real functions
to submit subpage metadata write bio.

Qu Wenruo (4):
  btrfs: introduce end_bio_subpage_eb_writepage() function
  btrfs: introduce write_one_subpage_eb() function
  btrfs: make lock_extent_buffer_for_io() to be subpage compatible
  btrfs: introduce submit_eb_subpage() to submit a subpage metadata page

 fs/btrfs/extent_io.c | 293 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 263 insertions(+), 30 deletions(-)

-- 
2.31.1


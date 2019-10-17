Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE60DAB29
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 13:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406044AbfJQL2n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 07:28:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:52712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405872AbfJQL2n (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 07:28:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18E53B372;
        Thu, 17 Oct 2019 11:28:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 586E8DA808; Thu, 17 Oct 2019 13:28:53 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Minor tracepoints cleanups
Date:   Thu, 17 Oct 2019 13:28:53 +0200
Message-Id: <cover.1571311653.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David Sterba (2):
  btrfs: tracepoints: drop typecasts from printk
  btrfs: tracepoints: constify all pointers

 include/trace/events/btrfs.h | 80 ++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 41 deletions(-)

-- 
2.23.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C70967E170
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2019 19:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387869AbfHARw1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 13:52:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:45910 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727508AbfHARw1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Aug 2019 13:52:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6A46AD17
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2019 17:52:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3EE27DA7D9; Thu,  1 Aug 2019 19:52:59 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Unused code cleanups
Date:   Thu,  1 Aug 2019 19:52:59 +0200
Message-Id: <cover.1564681931.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David Sterba (2):
  btrfs: remove unused btrfs_device::flush_bio_sent
  btrfs: remove unused key type set/get helpers

 fs/btrfs/ctree.h   | 10 ----------
 fs/btrfs/volumes.h |  1 -
 2 files changed, 11 deletions(-)

-- 
2.22.0


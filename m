Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B55ABE7F
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2019 19:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404313AbfIFRPj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Sep 2019 13:15:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:36508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391025AbfIFRPi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Sep 2019 13:15:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF155AD4B
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2019 17:15:37 +0000 (UTC)
From:   Mark Fasheh <mfasheh@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] Relocation/backref cache cleanups
Date:   Fri,  6 Sep 2019 10:15:30 -0700
Message-Id: <20190906171533.618-1-mfasheh@suse.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Relocation caches extent backrefs in an rbtree (the 'backref cache').  The
following patches move the backref cache code out of relocation.c and into
it's own file.  We then do a straight-forward cleanup the main backref cache
function, build_backref_tree().  No functionality is changed in these
patches.

These patches are part of a larger series I have, which speeds up qgroup
accounting by using the same backref cache facility.  That series is not
quite ready, however I wanted to see about getting these cleanup patches
upstreamed as they are nicely self contained and benefit the readability of
the code.

All feedback is appreciated.
        --Mark


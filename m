Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B697AC6BD
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Sep 2023 08:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjIXGOn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Sep 2023 02:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjIXGOm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Sep 2023 02:14:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAC4101
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Sep 2023 23:14:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 12F972184B
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Sep 2023 06:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695536073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CBV8uAtruFT6WPbScsFkt7GEzJccxjNIRFAjyexOyKE=;
        b=HzdGZWt9RCFUqF5JTgSE8U3+wgxEs3JhLfTVn3dQnZKVGG+sR9QPyk1ynaTofam+dUsOpJ
        FL6L/2iGAOCkhcX8HktsHGGDtL91ctZpkzSjMFlrrOa9lBUfqF/m5V4lZ9q5/i4sT7pqWJ
        DZpF1FeEQJWvfeW/WpTxAGBAaj9HTEA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46091138FE
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Sep 2023 06:14:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9xz3AcjTD2X+CgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Sep 2023 06:14:32 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: introduce 3 debug sysfs interface to tweak the error handling behavior
Date:   Sun, 24 Sep 2023 15:44:11 +0930
Message-ID: <cover.1695535440.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

During a very interesting (and weird) debugging session, it turns out
that btrfs will ignore a lot of write errors until we hit some critical
location, then btrfs started reacting, normally by aborting the
transaction.

This can be problematic for developers

As sometimes we want to catch the earlies sign, continuing without any
obvious errors (other than kernel error messages) can make debugging
much harder.

On the other hand, I totally understand if just a single sector failed
to be write and we mark the whole fs read-only, it can be super
frustrating for regular end users, thus we can not make it the default
behavior.

So this patchset would introduce the following sysfs entries under
/sys/fs/btrfs/<uuid>/debug/:

- allow_backup_super_failure
  RW, binary (0 or 1), determines if btrfs would tolerace backup super
  blocks writeback failure.
  If set to 1 and a failure is hit, btrfs would treat backup super
  blocks writeback failure as critical (the same level as primary super
  blocks).

  The default value is 1, so the default behavior is not changed.

  NOTE: this doesn't mean such failure would immediately lead to
  trasaction abort. Check `super_failure_tolerance` for more details.

- allow_data_failure
  RW, binary (0 or 1), determines if btrfs would tolerace data sectors
  writeback failure.
  If set to 1 and a failure is hit, btrfs would flip read-only
  immediately.

  The default value is 1, so the default behavior is not changed.

- super_failure_tolerance
  RW, s8, determines the tolerance for devices super blocks writeback.

  Btrfs allows "nr_devices - 1" devices to fail their super blocks
  writeback. This means if we have 5 disks, btrfs allows 4 to fail their
  super block writeback.

  If the value >= 0, the value itself would be the tolerance.
  If the value < 0, nr_devices + the value would be the tolerance.
  If value + nr_devices is still minus, btrfs would allow all devices
  to fail their super blocks writeback (aka, very dangerous)

  The default value is -1, to match the existing behavior.

There would be another one for btrfs bio layer, but I have found
something weird in the code, thus it would only be introduced after I
solved the problem there, meanwhile we can discuss on the usefulness of
this patchset.

Qu Wenruo (3):
  btrfs: introduce allow_backup_super_failure sysfs interface
  btrfs: introduce super_failure_tolerance sysfs interface
  btrfs: introduce allow_data_failure sysfs interface

 fs/btrfs/disk-io.c   | 35 +++++++++++++---
 fs/btrfs/extent_io.c |  8 +++-
 fs/btrfs/fs.h        | 23 ++++++++++
 fs/btrfs/inode.c     |  9 +++-
 fs/btrfs/sysfs.c     | 99 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 167 insertions(+), 7 deletions(-)

-- 
2.42.0


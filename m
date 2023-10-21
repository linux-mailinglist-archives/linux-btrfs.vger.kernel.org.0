Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAEC7D1D85
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Oct 2023 16:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjJUOm0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Oct 2023 10:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjJUOmZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Oct 2023 10:42:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B3DD52
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Oct 2023 07:42:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2DBAB1FD63
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Oct 2023 14:42:21 +0000 (UTC)
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E89992C21E
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Oct 2023 14:42:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 28B1DDA8A7; Sat, 21 Oct 2023 16:35:30 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.5.3
Date:   Sat, 21 Oct 2023 16:35:28 +0200
Message-ID: <20231021143530.7730-1-dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.60)[~all];
         RCPT_COUNT_ONE(0.00)[1];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         TO_DN_NONE(0.00)[];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
         RCVD_NO_TLS_LAST(0.10)[];
         R_DKIM_NA(0.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz];
         BAYES_HAM(-0.23)[72.55%]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: 2DBAB1FD63
X-Spam: Yes
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 6.5.3 have been released.  There are bugfixes and some new
options or commands, update is recommended.

Changelog:

   * mkfs:
      * add short aliases for -O specification, block-group-tree (bgt),
        free-space-tree (fst), raid-stripe-tree (rst)
      * don't try to resize the image (namely when backed by file) when --rootdir
        contains sparse file larger than the image
      * also copy xattr/permissions/ugid/timestamps of the top --rootdir directory
      * add new option --device-uuid to let user specify exact uuid of the
        device item (only for single device filesystems)
   * check:
      * on zoned devices, use correct super block offsets when repairing
      * check inline extent refs order
   * subvolume create: add new option --parent to create missing path
     components of the given path (like mkdir -p)
   * rescue clear-ino-cache: new command moved from 'btrfs check' implementing
     the same as option --clear-ino-cache (to be deprecated and removed in the
     future)
   * dump-tree: allow '-' in tree identifier names for option -t
   * btrfstune:
      * drop short option and add long option to enable squota
      * tune space reservation and batch size for block-group-tree conversion
   * scrub status: print correct value of "Bytes scrubbed" for unfinished runs
   * qgroup show: fix crash when attempting to print path of stale qgroups
   * experimental features:
      * move build of raid-stripe-tree out for testing but it's still considered
        experimental
   * other:
      * shell completion updates
      * sync raid-stripe-tree code with kernel
      * build fixes
      * new and updated tests

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.5.2

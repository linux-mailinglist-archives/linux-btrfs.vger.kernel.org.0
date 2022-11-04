Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0566061A11C
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Nov 2022 20:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiKDThW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Nov 2022 15:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKDThV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Nov 2022 15:37:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4EB45083
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Nov 2022 12:37:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5653621907
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Nov 2022 19:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667590639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/8SL2uhxqD0ICsGbJgF2zWC3Fn8m6H46T1h+1moxU6Y=;
        b=Gibc537sBqWLwiQQQ7QgSU/4wuQ9DOwYDi89xArqPypULfFiacPJuVQjMjXnKU7IJJiOu1
        2qmyvTIKy26SQpeIrXvPLLXc9j4eGQQDjDNvOXV3EQSWch/4YwNcYKxwpK18t/B0ihIsH6
        eqOY9EGEYUgQuuq/XkiiwCQLLnRuJHc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4CED72C141
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Nov 2022 19:37:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1567EDA70D; Fri,  4 Nov 2022 20:36:59 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.0.1
Date:   Fri,  4 Nov 2022 20:36:59 +0100
Message-Id: <20221104193659.10924-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 6.0.1 have been released. This is a bugfix release.

Changelog:
  * send: minor speed up for v2 due to increased buffer size
  * resize: invalid command line options fail with error code
  * quota rescan:
    * add long options --status and --wait
    * new option to wait but don't start rescan
  * qgroup show: print path by default, updated format
  * qgroup: new subcommand clear-stale, remove qgroups without their subvolumes
  * experimental:
    * add warnings to commands that have it enabled (mkfs, image, btrfstune)
  * other:
    * documentation, help text, error message updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

David Sterba (23):
      btrfs-progs: docs: add 6.0 development statistics
      btrfs-progs: docs: fix version when send v2 was introduced
      btrfs-progs: btrfstune: move -b option to experimental build
      btrfs-progs: mkfs: fix compat version of block-group-tree
      btrfs-progs: add warning helper for experimental build
      btrfs-progs: btrfstune: add warning when experimental functionality is used
      btrfs-progs: warn when an experimental functionality is used
      btrfs-progs: subvol delete: update EPERM error message
      btrfs-progs: quota rescan: add long options for status and wait
      btrfs-progs: unify naming of subvolume command definitions
      btrfs-progs: qgroup show: print subvolume path by default
      btrfs-progs: qgroup show: adjust printed path format
      btrfs-progs: qgroup show: print pretty names of columns
      btrfs-progs: qgroup show: adjust column widths and names
      btrfs-progs: qgroup: new command to delete stale qgroups
      btrfs-progs: tests: add case for clearing stale qgroups
      btrfs-progs: unify naming of qgroup subvolid helpers
      btrfs-progs: replace strerror(errno) with %m in printf formats
      btrfs-progs: qgroups: update help texts
      btrfs-progs: subvol: fix help text reference to subvolume
      btrfs-progs: tests: update stream version checks in misc/058
      btrfs-progs: update CHANGES for 6.0.1
      Btrfs progs v6.0.1

Jeff Mahoney (2):
      btrfs-progs: quota: add -W option to rescan to wait without starting rescan
      btrfs-progs: qgroup: add path to show output

Josef Bacik (1):
      btrfs-progs: properly test for send_stream_version

Nikolaos Chatzikonstantinou (1):
      btrfs-progs: docs: also mention no compression for swapfile

Qu Wenruo (1):
      btrfs-progs: print-tree: follow the supported flags when printing flags

Sidong Yang (1):
      btrfs-progs: resize: return error value from check_resize_args()

Tamara Schmitz (1):
      btrfs-progs: docs: fix option name misspelling

Wang Yugui (1):
      btrfs-progs: send: sync splice buf size with kernel when proto 2


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70AA6F5321
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 10:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjECI3K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 04:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjECI3H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 04:29:07 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D1926A0
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 01:29:05 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 48B7858780BEC; Wed,  3 May 2023 10:29:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 4704060C1EAB2
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 10:29:03 +0200 (CEST)
Date:   Wed, 3 May 2023 10:29:03 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     linux-btrfs@vger.kernel.org
Subject: Unprivileged snapshot removal after unpriv. snapshot creation
Message-ID: <715r77s6-pp14-5q68-2258-nn87n1701no6@vanv.qr>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Bug report.

System:

Linux 6.2.12 (openSUSE Tumbleweed x86_64); I believe it has no patches 
that modify btrfs behavior w.r.t. snapshots.

Observed:

f3:/mnt $ btrfs sub create 1
Create subvolume './1'
f3:/mnt $ btrfs sub snap 1 2
Create a snapshot of '1' in './2'
f3:/mnt $ btrfs sub del 2
WARNING: cannot read default subvolume id: Operation not permitted
Delete subvolume (no-commit): '/mnt/2'
ERROR: Could not destroy subvolume/snapshot: Operation not permitted
WARNING: deletion failed with EPERM, you don't have permissions or send 
may be in progress
f3:/mnt $ ls -al
total 16
drwxrwxrwt  1 root    root      4 May  3 10:09 .
drwxr-xr-x 18 root    root    262 Apr 26 18:33 ..
drwxr-xr-x  1 jengelh jengelh   0 May  3 10:09 1
drwxr-xr-x  1 jengelh jengelh   0 May  3 10:09 2

Expected:

Succeed in deleting the snapshot that I just created.

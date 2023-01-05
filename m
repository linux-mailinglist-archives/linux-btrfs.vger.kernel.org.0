Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CBB65F3C8
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 19:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjAESeW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Jan 2023 13:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbjAESeO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Jan 2023 13:34:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38152564CE
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 10:34:13 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CC5265D90E
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 18:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672943651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ht2lodpt5D606ntjY1PwsGF3132q4Nt6jGZbACm4YMI=;
        b=pquIGYTZM9n8Av/P/a+QT35KjNk9uXvkBxe//JI67Ee+d+/zQaK7T42rw7vUe/Q14WiDg4
        icRGvgbOGxRbgSSpFWtMfYaskJ1g8dSIqj9Wkd4yKg3wx5/QKHKpUrvEjkHEtXHU9qp2kg
        ijgapvuF+nL0lu96F0P35Xx1Ld1mguM=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C190F2C141
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 18:34:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 28C74DA7A3; Thu,  5 Jan 2023 19:28:41 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.1.2
Date:   Thu,  5 Jan 2023 19:28:41 +0100
Message-Id: <20230105182841.18741-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 6.1.2 have been released. This is a bugfix release.

The fixes in 6.1.1 were not correct, there was a separate copy of ioctl.h for
the public header but it was already patched in a different commit and I did
not notice that. The fixes have been verified by other people so hopefully it's
all for 6.1.

Changelog:

   * revert libbtrfs changes to v6.0.2, fix remaining build problems

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

Shortlog:

David Sterba (7):
      btrfs-progs: libbtrfs: revert to v6.0.2 ioctl.h
      btrfs-progs: libbtrfs: use own copy of kerncompat.h
      btrfs-progs: libbtrfs: move version.h to the directory
      btrfs-progs: libbtrfs: move libbtrfs.sym to the directory
      btrfs-progs: inspect: add build conditionals around list-chunk
      btrfs-progs: update CHANGES for 6.1.2
      Btrfs progs v6.1.2


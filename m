Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E84A41D950
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 14:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350691AbhI3MIW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 08:08:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58170 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350662AbhI3MIV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 08:08:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6CD2120024;
        Thu, 30 Sep 2021 12:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633003598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9+D1g3O5aIZ7rQrwIMkDWJ7dqryr6caUiuPOMXmkIec=;
        b=lhCKt6+12ZbTsmqyrxCRr3tFmn5wxVBDrmMQ6sN5w80zxQEAnexRom2gHBTE3Q2d9BQxzg
        unxyVLC86L9wHBz2ugS1Zii6fglMecLB3eqI1H3Q1kApqBcGmHakZPm7CIm5kJvQ7dpILN
        L2YtxXyqwZkN+DMg5mcVi+7I1d9Vk6E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FCB113B05;
        Thu, 30 Sep 2021 12:06:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1MrkDE6oVWHDLwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 30 Sep 2021 12:06:38 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 0/3] Ignore path devices in multipath setups
Date:   Thu, 30 Sep 2021 15:06:31 +0300
Message-Id: <20210930120634.632946-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch set improves the scanning behavior of btrfs-progs such that devices
which represent paths to a multipath device will be ignored when scanning. There
was an internal report that this causes problems with libstorage-ng. The behavior of
showing path devices diverges from the kernel, where on mounted filesystem only
the actual multipath device will be shown.

Changes in V2:

* Split build system related changes to the first patch of the series.

* Eliminated function names starting with __

* Instead of defining an 'if' always implement sane behavior of is_path_device
based on the state of the systems

* Eliminated special constant and started using PATH_MAX.


Nikolay Borisov (3):
  btrfs-progs: Add optional dependency on libudev
  btrfs-progs: Ignore devices representing paths in multipath
  btrfs-progs: Add fallback code for path device ignore for static build

 Makefile             |  2 +-
 Makefile.inc.in      |  2 +-
 common/device-scan.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
 configure.ac         |  9 +++++
 4 files changed, 95 insertions(+), 2 deletions(-)

--
2.17.1


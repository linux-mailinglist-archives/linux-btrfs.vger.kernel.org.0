Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA2C66C222
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 15:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjAPOYs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 16 Jan 2023 09:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjAPOXP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 09:23:15 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B3A39BA7
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 06:08:05 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 35CB2820CB4
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 14:07:57 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 24ADD821492
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 14:07:56 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1673878076; a=rsa-sha256;
        cv=none;
        b=lPqA+2IzC2Zj7dmFjgea/lIWXdKGBQKo9I+Azw+f8+tvVnVlc3ET/5zQfjNsF+PdsCt7dD
        xW/v6kD/buA8o5oucdr/CzWKD9oQtR89jUN2AD3CTBE4rw/Ghk/NTsrxEyryO3u38N82Wu
        L1ZMcsrtEppa5IPXEKKdnrc/pXuIGxDREeUvzYo1edQTMwToBj427EYHmrkgXoddAUktG9
        DjGpNmaikzs9xmf5v/FagcdEaEAuWzfPEG5EjnUpGAdWN69HVhWtnMQ6ap/Q/llNZD94rF
        Q1MsfvhMuz5rJCReOfdvVCd+IqFW9QyHDqM5UxpAxy9o9RQYmmEEqbjoxnFQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1673878076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p2RqiExJoaWyoNKgscMU5hMMXxvw5O3jMDknyInZnG4=;
        b=1hNdE5reqG1YwIa7xKt6kHABzbzWE5vm5QvyBa78ojyZDM/EuPPxo4OWPekCzeVG20TZDN
        /ZUiZRVQqMWgzuRjF/m7KnHLm/kIoesjhaw8gbGFhXAQZcmPwmP/w3mE69byfHq75BoWnD
        FnuLLd92WfI2r/MrPXkIa1oFt9QmyHn/wzABiZSiTC+X4Be0g00fTOmS8TnRSrOzQ5+YM9
        osqKUoBmI7S1fW6f1buSreL75pCc60ZWXOsXarBVssvpaY0GlqFoYZ3jYutS7wLEUbUhBh
        c2bNfd+xD/PSLwRQCHUKgz2puBKhltG6UaWWNceQTa2i4qYcvfpDnRd8ymNtnw==
ARC-Authentication-Results: i=1;
        rspamd-6f569fcb69-8qq87;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Cold-Bottle: 01d60afa2c100a00_1673878076850_862700060
X-MC-Loop-Signature: 1673878076850:1233690367
X-MC-Ingress-Time: 1673878076850
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.97.74.30 (trex/6.7.1);
        Mon, 16 Jan 2023 14:07:56 +0000
Received: from p5b071e4a.dip0.t-ipconnect.de ([91.7.30.74]:48772 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1pHQ9O-0006dT-Q5
        for linux-btrfs@vger.kernel.org;
        Mon, 16 Jan 2023 14:07:54 +0000
Message-ID: <afabf6cea649902733684575037e718f151a2ce1.camel@scientia.org>
Subject: [PATCH] btrfs-progs: docs: improve space cache documentation
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-btrfs@vger.kernel.org
Date:   Mon, 16 Jan 2023 15:07:49 +0100
In-Reply-To: <bddd724d-649b-aa3b-9a97-f415fe7b6afd@gmx.com>
References: <2269684.ElGaqSPkdT@lichtvoll.de>
         <bddd724d-649b-aa3b-9a97-f415fe7b6afd@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

- "Wipe" in storage terms is often understood as some kind of secure deletion.
  Use "remove" instead in order to indicate that the space cache is fully
  removed (and not just cleared and then e.g. automatically rebuild).

- The --clear-space-cache option for btrfs check actually clears the whole space
  cache, just as documented.
  Thus move any documentation about the clear_cache mount option not doing so
  for v1 to that.
  Instead, refer to the mount option.

- Also note that when clear_cache is used with v1, the free space cache for
  block groups that are modified gets always cleared, but rebuilt only if
  nospace_cache is not used.

Signed-off-by: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
---
 Documentation/btrfs-check.rst      | 12 ++----------
 Documentation/ch-mount-options.rst | 18 +++++++++++++++---
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/Documentation/btrfs-check.rst b/Documentation/btrfs-check.rst
index bca0e7f8..1bd35fe2 100644
--- a/Documentation/btrfs-check.rst
+++ b/Documentation/btrfs-check.rst
@@ -79,17 +79,9 @@ SAFE OR ADVISORY OPTIONS
         superblock is damaged.
 
 --clear-space-cache v1|v2
-        completely wipe all free space cache of given type
+        completely remove the free space cache of the given version
 
-        For free space cache *v1*, the *clear_cache* kernel mount option only rebuilds
-        the free space cache for block groups that are modified while the filesystem is
-        mounted with that option. Thus, using this option with *v1* makes it possible
-        to actually clear the entire free space cache.
-
-        For free space cache *v2*, the *clear_cache* kernel mount option destroys
-        the entire free space cache. This option, with *v2* provides an alternative
-        method of clearing the free space cache that doesn't require mounting the
-        filesystem.
+        See also the *clear_cache* mount option.
 
 --clear-ino-cache
         remove leftover items pertaining to the deprecated inode map feature
diff --git a/Documentation/ch-mount-options.rst b/Documentation/ch-mount-options.rst
index 3536a5bb..c9b64f19 100644
--- a/Documentation/ch-mount-options.rst
+++ b/Documentation/ch-mount-options.rst
@@ -86,8 +86,19 @@ check_int, check_int_data, check_int_print_mask=<value>
         for more information.
 
 clear_cache
-        Force clearing and rebuilding of the disk space cache if something
-        has gone wrong. See also: *space_cache*.
+        Force clearing and rebuilding of the free space cache if something
+        has gone wrong.
+
+        For free space cache *v1*, this only clears (and, unless *nospace_cache* is
+        used, rebuilds) the free space cache for block groups that are modified while
+        the filesystem is mounted with that option. To actually clear an entire free
+        space cache *v1*, see ``btrfs check --clear-space-cache v1``.
+
+        For free space cache *v2*, this clears the entire free space cache.
+        To do so without requiring to mounting the filesystem, see
+         ``btrfs check --clear-space-cache v2``.
+
+        See also: *space_cache*.
 
 commit=<seconds>
         (since: 3.12, default: 30)
@@ -348,7 +359,8 @@ space_cache, space_cache=<version>, nospace_cache
         implementation, which adds a new b-tree called the free space tree, addresses
         this issue. Once enabled, the *v2* space cache will always be used and cannot
         be disabled unless it is cleared. Use *clear_cache,space_cache=v1* or
-        *clear_cache,nospace_cache* to do so. If *v2* is enabled, kernels without *v2*
+        *clear_cache,nospace_cache* to do so. If *v2* is enabled, and *v1* space
+        cache will be cleared (at the first mount) and kernels without *v2*
         support will only be able to mount the filesystem in read-only mode.
 
         The :doc:`btrfs-check(8)<btrfs-check>` and `:doc:`mkfs.btrfs(8)<mkfs.btrfs>` commands have full *v2* free space
-- 
2.39.0


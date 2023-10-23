Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E677D3C16
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Oct 2023 18:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjJWQRb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Oct 2023 12:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbjJWQR0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Oct 2023 12:17:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9417310D;
        Mon, 23 Oct 2023 09:17:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7C5611FE28;
        Mon, 23 Oct 2023 16:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698077841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=DjohuKj/JGQK/JzPuzdWq8JAOGu9hR/RcVdBLoZV2Xs=;
        b=D/ToyYk/YtdRkQwUH+7vrDLV/MMenf3MPC0A0+RGYUGlHMWT1e649KlyKvQgdW+9uuRWxv
        xP0TICmNLKY8GUFmazr+lyH5Cw9VKg4L+vlpG5cRlkm64malEYuYcHV/HBi0UmDks3k9r9
        2ll4KzozOuXe/VvfEY35yuH/R0VBoRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698077841;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=DjohuKj/JGQK/JzPuzdWq8JAOGu9hR/RcVdBLoZV2Xs=;
        b=buB8aXQcYJ0HkzvkR7cmX1seo2j1fIl9XFxw6bNJDQFpW4nBf169/cf3XVkVYVb8Khh255
        dTpOwsxnn5WFtqBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51A00139C2;
        Mon, 23 Oct 2023 16:17:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WY2yEpGcNmXbKwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 23 Oct 2023 16:17:21 +0000
Date:   Mon, 23 Oct 2023 18:10:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     torvalds@linux-foundation.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 6.6-rc8
Message-ID: <cover.1698076832.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.84
X-Spamd-Result: default: False [-5.84 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-1.74)[93.41%]
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

one more fix for a problem with snapshot of a newly created subvolume
that can lead to inconsistent data under some circumstances. Kernel 6.5
added a performance optimization to skip transaction commit for
subvolume creation but this could end up with newer data on disk but not
linked to other structures.

The fix itself is an added condition, the rest of the patch is a
parameter added to several functions.

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 8a540e990d7da36813cb71a4a422712bfba448a4:

  btrfs: fix stripe length calculation for non-zoned data chunk allocation (2023-10-15 19:00:59 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.6-rc7-tag

for you to fetch changes up to eb96e221937af3c7bb8a63208dbab813ca5d3d7e:

  btrfs: fix unwritten extent buffer after snapshotting a new subvolume (2023-10-23 17:17:30 +0200)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs: fix unwritten extent buffer after snapshotting a new subvolume

 fs/btrfs/backref.c    | 14 +++++++++-----
 fs/btrfs/backref.h    |  3 ++-
 fs/btrfs/ctree.c      | 21 ++++++++++++++++-----
 fs/btrfs/ctree.h      |  3 ++-
 fs/btrfs/relocation.c |  7 ++++---
 5 files changed, 33 insertions(+), 15 deletions(-)

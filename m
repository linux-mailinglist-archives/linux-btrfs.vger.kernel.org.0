Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D90731C2E
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jun 2023 17:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343921AbjFOPK2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jun 2023 11:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345229AbjFOPKH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jun 2023 11:10:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135A8273C
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jun 2023 08:10:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4CF652242C;
        Thu, 15 Jun 2023 15:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686841805;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=zVHx/np3JGWTujEibxc/YSiOJVv636y/9jPj8ZgQBJ8=;
        b=aO/xXndS88roUDO5ZmV7+VZ6xxZyQE6O7zYhKM9QfW0jk0oa1QjsJ7jxI/qTCGCzdZEaVX
        C3GvSHbBMfD8YXqmRnV2q39/evJoK+NImilZW34d5l3IvHwzPjYalrNGpYs1YmR3dkXZZw
        SwMjLGrFYuAQsqqGrHnIf02oBjBWpG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686841805;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=zVHx/np3JGWTujEibxc/YSiOJVv636y/9jPj8ZgQBJ8=;
        b=lGWhfoSKd55KoEQo3zPO3D8VqM/gsDJ5A/sW2jQDLJ3i5RilwKvCskcjqXM77hC+gLesMx
        M0+6kn4mNgHKh2BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2448D13A32;
        Thu, 15 Jun 2023 15:10:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WwAQB80pi2SpDQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 15 Jun 2023 15:10:05 +0000
Date:   Thu, 15 Jun 2023 17:03:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.3.2
Message-ID: <20230615150344.GW13486@suse.cz>
Reply-To: dsterba@suse.cz
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs-progs version 6.3.2 have been released. This is a bugfix release.

Changelog:

   * build: fix mkfs on big endian hosts
   * mkfs: don't print changed defaults notice with --quiet
   * scrub: fix wrong stats of processed bytes in background and foreground mode
   * convert: actually create free-space-tree instead of v1 space cache
   * print-tree: recognize and print CHANGING_FSID_V2 flag (for the
     metadata_uuid change in progress)
   * other:
      * documentation updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

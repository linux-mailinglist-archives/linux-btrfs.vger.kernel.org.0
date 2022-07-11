Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283C9570C9F
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 23:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiGKVVM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 17:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiGKVVL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 17:21:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63142A716;
        Mon, 11 Jul 2022 14:21:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 696A422AB2;
        Mon, 11 Jul 2022 21:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657574468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=BrBDvl4qC4LTS72QHk/hrHRE5XNXQVEeAobhMNDASnU=;
        b=r/ycO6YwLIT/Nm+rYaY6umt8Vo7zdVhhQpFUG2p3wZgGrxdkjTAkivKMwSnVz3sXw3RZuI
        JGfCozr6mDWu+p83F5s/4bF0fc7sSbEBs99y9M3KcMcIb45hd9SAJcH1PsjM1ucP9nfdlu
        InPp3N3vz/+6x5SDWbyDqMDpH0IHEb0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 383EA13524;
        Mon, 11 Jul 2022 21:21:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q/6RDESUzGIuWwAAMHmgww
        (envelope-from <dsterba@suse.com>); Mon, 11 Jul 2022 21:21:08 +0000
Date:   Mon, 11 Jul 2022 23:16:19 +0200
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 5.19-rc7
Message-ID: <cover.1657571742.git.dsterba@suse.com>
Mail-Followup-To: David Sterba <dsterba@suse.com>,
        torvalds@linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a few more fixes that seem to me to be important enough to get merged
before release, described below. Please pull, thanks.

- in zoned mode, fix leak of a structure when reading zone info, this
  happens on normal path so this can be significant

- in zoned mode, revert an optimization added in 5.19-rc1 to finish a
  zone when the capacity is full, but this is not reliable in all cases

- try to avoid short reads for compressed data or inline files when it's
  a NOWAIT read, applications should handle that but there are two,
  qemu and mariadb, that are affected

----------------------------------------------------------------
The following changes since commit 037e127452b973f45b34c1e88a1af183e652e657:

  Documentation: update btrfs list of features and link to readthedocs.io (2022-06-21 14:47:19 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.19-rc6-tag

for you to fetch changes up to b3a3b0255797e1d395253366ba24a4cc6c8bdf9c:

  btrfs: zoned: drop optimization of zone finish (2022-07-08 19:18:00 +0200)

----------------------------------------------------------------
Christoph Hellwig (1):
      btrfs: zoned: fix a leaked bioc in read_zone_info

Filipe Manana (1):
      btrfs: return -EAGAIN for NOWAIT dio reads/writes on compressed and inline extents

Naohiro Aota (1):
      btrfs: zoned: drop optimization of zone finish

 fs/btrfs/inode.c | 14 +++++++++++++-
 fs/btrfs/zoned.c | 34 ++++++++++++++--------------------
 2 files changed, 27 insertions(+), 21 deletions(-)

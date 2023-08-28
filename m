Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B59378B4D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 17:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjH1Pxv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 11:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjH1PxV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 11:53:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2FB10C
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 08:53:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5E2AB1F37E;
        Mon, 28 Aug 2023 15:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693237997;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gzGySwEVCoxx4oKExAz0i3mh/JKJvWT409HH66HvXLQ=;
        b=yWuKNgL1SqPR+ajTTzyocvXWV5nMpt3NP9KgoY89fBt0P7TN7MVFwOAkmg+EBp9gTt8q7Z
        qvlGMl0uWiwQ6WE1OAxOr+9Uy6E27Aro5lNit4BvHerYtPA7yTdzOJZMgKYxxOIEBmN78h
        SfE1qmSZuQjEoZnNAM74j/81UQTXnKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693237997;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gzGySwEVCoxx4oKExAz0i3mh/JKJvWT409HH66HvXLQ=;
        b=xFUwXNTHpt4cVsWQEkfmJOoOca7uXTeSeYoNr6XiQVYPdGuQAtTpoVvYnAGumsHWfNNZbV
        QlKSW5AgPVQxrqDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3968B13A11;
        Mon, 28 Aug 2023 15:53:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qHQ1De3C7GRZEQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 28 Aug 2023 15:53:17 +0000
Date:   Mon, 28 Aug 2023 17:46:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tests: fix random mkfs.btrfs failure due to
 loopdev cache
Message-ID: <20230828154642.GE14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <aa3f3c927b62d1da51166efafa856e18d01cc1ac.1692861033.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa3f3c927b62d1da51166efafa856e18d01cc1ac.1692861033.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 24, 2023 at 03:13:04PM +0800, Anand Jain wrote:
> Sometimes, I randomly see failures like below.
> 
>     [TEST/fsck]   013-extent-tree-rebuild
> failed: /Volumes/ws/btrfs-progs/mkfs.btrfs -f /Volumes/ws/btrfs-progs/tests/test.img
> test failed for case 013-extent-tree-rebuild
> make: *** [Makefile:484: test-fsck] Error 1
> 
> Looks like losetup -D failed because the device busy, however if ran
> again it would successeed, possible that loop device is still writing
> to the backing store.
> 
> Using losetup directio option as below it never reproduced so far.

That's interesting that it makes it work because in the command of test
013-extent-tree-rebuild the helper prepare_loopdevs() is not used at all
and mkfs works on the file directly.

The default TEST_DEV is a plain file and transparently mounted as loop
device by run_check_mount_test_dev by -o loop, which uses defaults for
losetup. And the direct io is off by default, there's no mount option
for that.

I'm not sure how to fix that, I want to let the test suite run without
the need for a block device. A fix could be on the test level to force
the TEST_DEV to be a loop device, but handling it transparently inside
the mount/umount helpers may be fragile.

We could add helpers for tests that need a block device, which would
mean the prepare and cleanup calls. Alternatively the on-exit function
that can be done via signal traps can be used but then it's for test
case updated anyway.

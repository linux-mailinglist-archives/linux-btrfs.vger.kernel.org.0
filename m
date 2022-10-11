Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CA75FB050
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 12:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJKKUU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 06:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJKKUT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 06:20:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B60E3740F
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 03:20:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 191C11F8BA;
        Tue, 11 Oct 2022 10:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665483616;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ib6Kh88VVtBqNur6sQRPGxW0rjMVnkldifv0LUHztZY=;
        b=ND+YHrYm8dsNILEmWuOgU1ryEUVrTTP9sZgG9Rk8hCDZFUHpbba7yAyy6kw3An3Nnhc/lD
        oep8ZSjj7y5LfCrkl2jSBugx36Xw1Ay6p7uZlEmf5pDzv48lKJppxSmqRQkXB0EMJWfLUV
        lx309yFf9aiJP91zDXjRQWj8ba3vUJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665483616;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ib6Kh88VVtBqNur6sQRPGxW0rjMVnkldifv0LUHztZY=;
        b=8/tQqZAOtLXvkYjuP7pMXOrSZg/wexyXvL+udXv1HEXp0L4jy8o5LnkJ0VVSr8+Is4Z/Z9
        PPLGzecY29zMnFDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E79CE139ED;
        Tue, 11 Oct 2022 10:20:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VF91N19DRWPxEgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Oct 2022 10:20:15 +0000
Date:   Tue, 11 Oct 2022 12:20:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 12/16] btrfs: remove fs_info::pending_changes and related
 code
Message-ID: <20221011102010.GL13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663175597.git.josef@toxicpanda.com>
 <8bffbf3b43fb56ce03776e779f4d166e42d9b297.1663175597.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bffbf3b43fb56ce03776e779f4d166e42d9b297.1663175597.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 14, 2022 at 01:18:17PM -0400, Josef Bacik wrote:
> Now that we're not using this code anywhere we can remove it as well as
> the member from fs_info.

So it looks like we don't have any mount options or on/off features that
would utilize the pending infrastructure, the last one was inode_cache.
There was a patchset [1] to enable some features from sysfs that would
break things if it would be set immediately. In case we'll need that
kind of logic again the patch can be reverted, but for the current use
it can be replaced by the single state bit to do the commit.

[1] https://lore.kernel.org/linux-btrfs/1422609654-19519-1-git-send-email-quwenruo@cn.fujitsu.com/

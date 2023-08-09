Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9C9775EDC
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 14:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjHIM0y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 08:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHIM0x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 08:26:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B37C1BF7
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 05:26:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C661721863;
        Wed,  9 Aug 2023 12:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691584010;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=norwBq2bDw9FZL9v0R5sRqlSf1HET1AWxwz+XWkSBSA=;
        b=oiMaOdJxIVgbEWfgUgOzOBgcsbXvIAtZvyrFe6Cc/R1PIsViLJshEfeXByc15ml/d1HpDt
        UnHziRT805IdR3s1cSjS471an7+kH3NlFdn+mRBhAwGrNrjblNgjE5m49cgbuxTkI8Omhv
        Nq2BlftfOYcJR8sG6e7KNKy2MPCQGLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691584010;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=norwBq2bDw9FZL9v0R5sRqlSf1HET1AWxwz+XWkSBSA=;
        b=oRfZQTCIuIuppE2xyVEaov7O8N4SA2OD3EBuGckgpcSmszFMApUt1l1EOm+WutPwJ19Vjw
        bpAbRdQm9eWtn+Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AFEDE133B5;
        Wed,  9 Aug 2023 12:26:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jg8YKgqG02T1bQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 09 Aug 2023 12:26:50 +0000
Date:   Wed, 9 Aug 2023 14:26:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tests/misc/058: reduce the space
 requirement and speed up the test
Message-ID: <ZNOGCSts6w4tm9nI@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <173e7faa9202a5d3438cd5bbdca765708f3bc729.1691477705.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173e7faa9202a5d3438cd5bbdca765708f3bc729.1691477705.git.wqu@suse.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 08, 2023 at 02:55:21PM +0800, Qu Wenruo wrote:
> [BUG]
> When I was testing misc/058, the fs still has around 7GiB free space,
> but during that test case, btrfs kernel module reports write failures
> and even git commands failed inside that fs.
> 
> And obviously the test case failed.
> 
> [CAUSE]
> It turns out that, the test case itself would require 6GiB (4 data
> disks) + 1.5GiB x 2 (the two replace target), thus it requires 9 GiB
> free space.
> 
> And obviously my partition is not that large and failed.

The file sizes were picked so the replace is not too fast, this again
depends on the system. Please add more space for tests.

> [FIX]
> In fact, we really don't need that much space at all.
> 
> Our objective is to test "btrfs device replace --enqueue" functionality,
> there is not much need to wait for 1 second, we can just do the enqueue
> immediately.

This depends on the system and the sleep might be needed if the first
command does not start the first replace. The test is not testing just
the --enqueue, but that two replaces can be enqueued on top each other.
So we need the first one to start.

> So this patch would reduce the file size to a more sane (and rounded)
> 2GiB, and do the enqueue immediately.

I'm not sure that the test would actually work as intended after the
changes. The sleeps and dependency on system is fragile but we don't
have anything better than to over allocate and provide enough time for
the other commands to catch up.

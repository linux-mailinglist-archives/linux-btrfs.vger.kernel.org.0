Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED45616980
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Nov 2022 17:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiKBQod (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Nov 2022 12:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiKBQoC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Nov 2022 12:44:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD9314D32
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 09:39:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0F3E61F855;
        Wed,  2 Nov 2022 16:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667407164;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vq+3zLHMoWwy3zR37363snMUwstd4Tyry9rgZYDAU9o=;
        b=pf4OeJ1Dc24rKEB5sYKm891f6C0alhUgVvJn6DI5DzF9eufNfa7v9n45SMLefHkWnkqwVg
        InVzM8dz761JmJQBE0q81QA+x2vwjhCeE3rwk35INI8ei+7Bj2VGPStX6J/+O8jL2qamxZ
        ajffH2zU6Wf06j5dAzcNufJUSghR3os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667407164;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vq+3zLHMoWwy3zR37363snMUwstd4Tyry9rgZYDAU9o=;
        b=s8400cTqpitQLSHaygBjnIH+W1WaIXbAO+PpzLqm9yFDORqtOmqUPP74LDoPViMYP479W4
        LTIpVPqnqsIouGDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D61A613AE0;
        Wed,  2 Nov 2022 16:39:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JJ/5MjudYmOCKAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 02 Nov 2022 16:39:23 +0000
Date:   Wed, 2 Nov 2022 17:39:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: fixes for nowait buffered writes
Message-ID: <20221102163905.GI5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1667392727.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667392727.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 02, 2022 at 12:46:34PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A couple fixes for the recently added support for nowait buffered writes.
> Trivial stuff, one of the bugs was reported sometime ago by the lkp test
> robot.
> 
> Filipe Manana (2):
>   btrfs: fix nowait buffered write returning -ENOSPC
>   btrfs: fix inode reserve space leak due to nowait buffered write

Added to misc-next, thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26F06C275A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 02:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjCUBUj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 21:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjCUBUi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 21:20:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05B38699
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 18:20:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F19B921A7C;
        Tue, 21 Mar 2023 01:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679361508;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AdZ1Pf0ggwAQvkSNt1WfYQ8placg0x8ZVfKmB9nYV2E=;
        b=Kfc0QpLtMjJtlvFih5+PZpkWFH803O0lH6xBzYRHzf7TjZpXa/H+Da9uU8ueOg+/G8ho8s
        16PoiFNZIbOtjOHKje45hJVRhqRUrNCONhsQlFjMbwWL1e4yVx4Wo8vUcQiQ8N9VVfUjB1
        FqKEEQXoS5QGlt3WW+udUV9lRhhCz7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679361508;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AdZ1Pf0ggwAQvkSNt1WfYQ8placg0x8ZVfKmB9nYV2E=;
        b=6IgjjsyD2L/mdpS/YJxk5wsvu6dn2Nav7BC5VugZw53EkWE43eD4sVqDQeTS7o1XIZTyRD
        nYVzsk7yad1FkBBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D35B213416;
        Tue, 21 Mar 2023 01:18:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K8WhMuQFGWTBXgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Mar 2023 01:18:28 +0000
Date:   Tue, 21 Mar 2023 02:12:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 12/12] btrfs: scrub: switch scrub_simple_mirror() to
 scrub_stripe infrastructure
Message-ID: <20230321011219.GN10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1679278088.git.wqu@suse.com>
 <ddc0a6d6370e79d76cdedb3108d018c2efaebaa7.1679278088.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddc0a6d6370e79d76cdedb3108d018c2efaebaa7.1679278088.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 20, 2023 at 10:12:58AM +0800, Qu Wenruo wrote:
> Switch scrub_simple_mirror() to the new scrub_stripe infrastructure.
> 
> Since scrub_simple_mirror() is the core part of scrub (only RAID56
> P/Q stripes doesn't utilize it), we can get rid of a big hunk of code,
> mostly scrub_extent() and scrub_sectors().

On a second look, I think this patch can stay as is with the removed
code, just list all the completely removed functions in the changelog.
This should be enough to know what to ignore should we need to start
debugging from this patch.

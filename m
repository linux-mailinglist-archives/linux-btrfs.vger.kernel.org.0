Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DB3779250
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 17:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjHKPAS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 11:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjHKPAR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 11:00:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40D910FE
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 08:00:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B8CA31F890;
        Fri, 11 Aug 2023 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691766015;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Tz5oYxGooDtinJ6PF2pvRCkV66o+mYsnYjllobPzYM=;
        b=KH9obeq6VKnoqX5PLZc8uCH/icaFPw4WCNICC+b1V7LRA2MCU4ootXuHUXV1Fi+eKFXhZu
        bKOZ//fdt0EwxJWI+rjh2Ptc4zBqeN4pjf586zWrVQVWrnUAAd5icpy9jXMUYgIEMfPs6R
        o3iIQH28mXwkfOl1bsJ3nVSzgWQmqoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691766015;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Tz5oYxGooDtinJ6PF2pvRCkV66o+mYsnYjllobPzYM=;
        b=0IEsq9Fsr8iijfruw0oqizeJGhXG7OITwUe5ex9+kvge8cvR+4eTJhP+ICdWY1LDg0W08G
        lDd5qmeaoVEx0KDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A96013592;
        Fri, 11 Aug 2023 15:00:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z1LjJP9M1mRhKAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Aug 2023 15:00:15 +0000
Date:   Fri, 11 Aug 2023 16:53:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs-progs: tests false alerts fixes
Message-ID: <20230811145350.GP2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1691533896.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691533896.git.wqu@suse.com>
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

On Wed, Aug 09, 2023 at 06:40:40AM +0800, Qu Wenruo wrote:
> This is the resent and aggregate version of the fixes I sent but mostly
> eaten by the recent vger down time.
> 
> Those are small fixes for the false alerts I hit during my local runs.
> 
> Most of them are subtle fixes, only the last one is more like an
> optimization.
> 
> Qu Wenruo (4):
>   btrfs-progs: tests/mkfs/005: use udevadm settle to avoid false alerts
>   btrfs-progs: tests/misc/030: do not require v1 cache for the test case
>   btrfs-progs: tests/misc/046: fix false alerts on write detection

This one was not in the first batch so I've added it now, thanks.

>   btrfs-progs: tests/misc/058: reduce the space requirement and speed up
>     the test

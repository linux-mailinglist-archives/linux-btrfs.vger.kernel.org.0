Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A3967BFA4
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 23:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjAYWLZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 17:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjAYWLY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 17:11:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F00E272E
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Jan 2023 14:11:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 23CD01F895;
        Wed, 25 Jan 2023 22:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674684682;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rk8l5RdAFXmBAnGAuWQiwaHwwx7gmXTwtNWJKr9oLek=;
        b=zp1ch5Yf+V4ftjPtplgqvL4bQ0EUvNsUeMUWuqMmEO8hBOPAMdJw1xYwOLpsTMlJIivLDE
        ob/nuwv5KOmObxWIYlrddeqP+Rk/mB8MUFiQhfJGWLbSVwjULgbZooM83FCfk39Xbw9X1M
        yceq7ZNDsFdFy/dN9mIrbCbdUo8JGaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674684682;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rk8l5RdAFXmBAnGAuWQiwaHwwx7gmXTwtNWJKr9oLek=;
        b=KmA/+SYCKthEEPn/wMLL9gz9JYdpXEwisGb3bi+w2R/YBd8fQQU8dRk8xOFiXlCIg4pMBx
        PcZhztyHjOk9XuDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 077E11339E;
        Wed, 25 Jan 2023 22:11:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y8oBAQqp0WMVMAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 25 Jan 2023 22:11:22 +0000
Date:   Wed, 25 Jan 2023 23:05:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/2] btrfs: block group size class load fixes
Message-ID: <20230125220539.GY11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1674679476.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674679476.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 25, 2023 at 12:50:31PM -0800, Boris Burkov wrote:
> The original size class loading logic was totally broken.
> 
> Patch 1 fixes it.
> Patch 2 adds sysfs visibility to size classes so that we don't mess up
> this badly in the future (and can test it in xfstests now).
> 
> Boris Burkov (2):
>   btrfs: fix size class loading logic
>   btrfs: add size class stats to sysfs

There's still time to replace the orignial patches, you can send me
incremental diffs or resend the whole series.

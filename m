Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BFB65B1D2
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jan 2023 13:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjABMKn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Jan 2023 07:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjABMKj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Jan 2023 07:10:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8A16246;
        Mon,  2 Jan 2023 04:10:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A6E4720D55;
        Mon,  2 Jan 2023 12:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672661435;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9rYew4XXsoCgW1ul1qCY89TbND+PF+8fwJQ+0o43dLE=;
        b=qzJtrZABDyNcM7PxoubU53A+Qffw1pFQIvwahtQEKuT4lvwkV+vRUwXIJFwllMrFy/LO+U
        G/h/A5BTaIyShhOqptte1BDkRFEikgz+7wQL3wDnl5jY1u7KSBh6s65AkqSRV+2C/uhzPX
        KLq0AFscLEqCsyXtIyZ0w5AzeEROSeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672661435;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9rYew4XXsoCgW1ul1qCY89TbND+PF+8fwJQ+0o43dLE=;
        b=HKQF8w8/aGsLHi8djqxRVgjnI5kjPUzUwPATh64ERalZltp47fzlSPYHGMlroqncc2S3vd
        5N0TEFryNTFwzNDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CD03139C8;
        Mon,  2 Jan 2023 12:10:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8AgLDrvJsmM+CAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Jan 2023 12:10:35 +0000
Date:   Mon, 2 Jan 2023 13:05:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Tom Rix <trix@redhat.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        nathan@kernel.org, ndesaulniers@google.com, wqu@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] btrfs: handle -Wmaybe-uninitialized with clang
Message-ID: <20230102120505.GA11562@suse.cz>
Reply-To: dsterba@suse.cz
References: <20221230175507.1630431-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230175507.1630431-1-trix@redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 30, 2022 at 12:55:07PM -0500, Tom Rix wrote:
> The clang build reports this error
> error: unknown warning option '-Wmaybe-uninitialized'; did you mean '-Wuninitialized'? [-Werror,-Wunknown-warning-option]
> make[3]: *** [scripts/Makefile.build:252: fs/btrfs/super.o] Error 1
> 
> -Wmaybe-uninitialized is a gcc only flag.  Move to setting with cc-option.
> 
> Fixes: 1b19c4c249a1 ("btrfs: turn on -Wmaybe-uninitialized")
> Signed-off-by: Tom Rix <trix@redhat.com>

Folded to the patch, thanks.

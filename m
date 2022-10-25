Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAA860CBDD
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 14:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiJYMaB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Oct 2022 08:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiJYM36 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Oct 2022 08:29:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A358A0311
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 05:29:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2A2DE22042;
        Tue, 25 Oct 2022 12:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666700995;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D8dm8iZHS03zHM1xpsqFuDkmY55zEgbwRYaiK75Gr/4=;
        b=EMbOGBaiFaC5koXoE3WcGF1TRpS+fWLLBNwifk8JSOa5AxaRxARZd23vxQ1wwDsYPFMgtq
        y+8Ll0F2s88iryTw64iaoeWLi0RrG1q8HaTUn4gJarpLyD3y6lhapVKeKjdCOUBs8OxPKg
        SfvxCxuO4SiQUzvLzZAEu9c4e//G9vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666700995;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D8dm8iZHS03zHM1xpsqFuDkmY55zEgbwRYaiK75Gr/4=;
        b=sefrFREHSywWTzA4M4wm/ZxqVpIOgg5tLpBv7UHjBGY7BMnnPeEWAiOrWQguJt7SR0c2as
        a3nBXAjUKQ2FvmAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09F1D13A64;
        Tue, 25 Oct 2022 12:29:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sm59AcPWV2OSGwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 25 Oct 2022 12:29:55 +0000
Date:   Tue, 25 Oct 2022 14:29:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: remove unused function prototypes
Message-ID: <20221025122941.GI5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <36f49ea2d8cca64fde3bce26feff36b7fbee540f.1666642537.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36f49ea2d8cca64fde3bce26feff36b7fbee540f.1666642537.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 24, 2022 at 04:16:14PM -0400, Josef Bacik wrote:
> I wrote the following  coccinelle script to find function declarations
> that didn't have the corresponding code for them
> 
> @funcproto@
> identifier func;
> type T;
> position p0;
> @@
> 
> T func@p0(...);
> 
> @funccode@
> identifier funcproto.func;
> position p1;
> @@
> 
> func@p1(...) { ... }
> 
> @script:python depends on !funccode@
> p0 << funcproto.p0;
> @@
> print("Proto with no function at %s:%s" % (p0[0].file, p0[0].line))

There seems to be postprocessing still needed, running it on individual
files can't work as the prototypes are in another file. All in one file
*.h + *.c makes it possible but there were still too many false
positives. Anyway, in the end there are only the 4 prototypes left.
Added to misc-next, thanks.

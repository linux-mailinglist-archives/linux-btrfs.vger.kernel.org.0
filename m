Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9874FFADD
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 18:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiDMQHW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 12:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbiDMQHT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 12:07:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316F74F446;
        Wed, 13 Apr 2022 09:04:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CEEF52160E;
        Wed, 13 Apr 2022 16:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649865894;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4XLAbSyVXPKjSGZzX2V8mPUgpCPzkvji4+ZrbQVbWJU=;
        b=F/WT8vAqEWEcZeODhRqAMAWopyLiVbiuSVwKrvlT6VgfTD5SGW7u3tOusWJmsmQ3ddjgZM
        /IpxNFBn7pDOiwkC0Lppwnoj1ljxUw/pQhodDFmvEWBlXrYVVY0jybzuPCZ1GsFSDe6Apy
        lnXfjOI5Eb4DEwOZJ4FMAY/k7DvwZPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649865894;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4XLAbSyVXPKjSGZzX2V8mPUgpCPzkvji4+ZrbQVbWJU=;
        b=QM6xjLy0S7b49acN22RVsLVqYO+9S8On+wHsiYmO1TMGWRsLtpDNC889tTU+8xektbqnWl
        k7a7351XVpycikDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97D0F13AB8;
        Wed, 13 Apr 2022 16:04:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VTQqJKb0VmKQQAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Apr 2022 16:04:54 +0000
Date:   Wed, 13 Apr 2022 18:00:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Schspa Shi <schspa@gmail.com>, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, terrelln@fb.com
Subject: Re: [PATCH v2] btrfs: zstd: use spin_lock in timer callback
Message-ID: <20220413160047.GL15609@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Schspa Shi <schspa@gmail.com>, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, terrelln@fb.com
References: <20220411135136.GG15609@suse.cz>
 <20220411155540.36853-1-schspa@gmail.com>
 <09c2a9ce-3b04-ed94-1d62-0e5a072b9dac@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09c2a9ce-3b04-ed94-1d62-0e5a072b9dac@suse.com>
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

On Wed, Apr 13, 2022 at 05:58:41PM +0300, Nikolay Borisov wrote:
> 
> 
> On 11.04.22 г. 18:55 ч., Schspa Shi wrote:
> > This is an optimization for fix fee13fe96529 ("btrfs:
> > correct zstd workspace manager lock to use spin_lock_bh()")
> > 
> > The critical region for wsm.lock is only accessed by the process context and
> > the softirq context.
> > 
> > Because in the soft interrupt, the critical section will not be preempted by the
> > soft interrupt again, there is no need to call spin_lock_bh(&wsm.lock) to turn
> > off the soft interrupt, spin_lock(&wsm.lock) is enough for this situation.
> > 
> > Changelog:
> > v1 -> v2:
> > 	- Change the commit message to make it more readable.
> > 
> > [1] https://lore.kernel.org/all/20220408181523.92322-1-schspa@gmail.com/
> > 
> > Signed-off-by: Schspa Shi <schspa@gmail.com>
> 
> Has there been any measurable impact by this change? While it's correct it does mean that
>   someone looking at the code would see that in one call site we use plain spinlock and in
> another a _bh version and this is somewhat inconsistent.

I think it would be hard to measure the impact, maybe in some kind of
load the _bh version would be unnecessarily blocking some other threads.

Regarding the used locking primitives, I'll add a comment about that to
the function, it is indeed inconsistent and not obvious from the
context.

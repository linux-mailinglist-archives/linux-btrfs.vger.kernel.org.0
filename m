Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AE377A1F8
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Aug 2023 21:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjHLTYR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Aug 2023 15:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjHLTYR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Aug 2023 15:24:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD83171C
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Aug 2023 12:24:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AF48021921;
        Sat, 12 Aug 2023 19:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691868258;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gxcQYEjv9a/XTKMLRsrgaE9pjojo2XTBMcEP8+hG8R8=;
        b=r8RUmcS+kwRB0Tfc1GT/66warXOPXO4m46fQT9ExSUY+8nJj9TNQaW0KgPRF79Yadc60Wx
        bHo4fm8Peqz86U71CEY05b8kiKxADQvionV2oAGsdOGLwQxG72Cqk0ogHtBZ3Re+k2uVaD
        HtHeCfEqKcDYP0OfSY37xM8NTugbE5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691868258;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gxcQYEjv9a/XTKMLRsrgaE9pjojo2XTBMcEP8+hG8R8=;
        b=u33jgvPGBDWSWMTnfLNM6MCLV5tBhtVkcFfwME/ZpqRGs8fCQmokgDjqVNriHyb8p8n1Ht
        +2RqwF7mZF8xeSCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86EB113274;
        Sat, 12 Aug 2023 19:24:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bY80IGLc12RKSwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Sat, 12 Aug 2023 19:24:18 +0000
Date:   Sat, 12 Aug 2023 21:17:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: remove v0 extent handling
Message-ID: <20230812191752.GC2420@suse.cz>
Reply-To: dsterba@suse.cz
References: <2c8a0319e27ae48e0c0a6cedfd412382a705780e.1691751710.git.wqu@suse.com>
 <20230811144334.GO2420@twin.jikos.cz>
 <40896c57-d318-4800-a06a-48f9cf809f4e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40896c57-d318-4800-a06a-48f9cf809f4e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 12, 2023 at 07:08:39AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/8/11 22:43, David Sterba wrote:
> > On Fri, Aug 11, 2023 at 07:02:11PM +0800, Qu Wenruo wrote:
> >> The v0 extent item has been deprecated for a long time, and we don't have
> >> any report from the community either.
> >>
> >> So it's time to remove the v0 extent specific error handling, and just
> >> treat them as regular extent tree corruption.
> >>
> >> This patch would remove the btrfs_print_v0_err() helper, and enhance the
> >> involved error handling to treat them just as any extent tree
> >> corruption.
> >
> > We added the helper in 2018, so it's about 5 years ago, without any
> > reports so yeah let's remove it for good, thanks.
> >
> > There are still remaining references to BTRFS_EXTENT_REF_V0_KEY in the
> > tracepoints and in ctree.h,
> 
> Tracepoints are what I missed, but I didn't hit any "_V0" or "_v0"
> inside fs/btrfs/ directory.

Yeah, I got me a few times in the past, compilation errors, so I know
that I have to look there too.
> 
> > at least the tracepiont should be deleted
> > but we may need to  keep the ctree.h defintion documented so we don't
> > reuse the key number yet. I can fix that in the commit.
> 
> We need the definition for sure, but IIRC it's in uapi now.

I moved the definition to a comment so it's greppable but it would
create a build error. I've checked debian code search and it seems that
there's only strace using the direct definition so this might break it
but I'd rather let them fix it once than we keep the definition around.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD6D5FB0BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 12:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJKKs6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 06:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiJKKsu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 06:48:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F468A1D0
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 03:48:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D73491F8D1;
        Tue, 11 Oct 2022 10:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665485327;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AxhNjRWlHP0qUYaHdyF2UuehBaiRsBboHO9O1NoR2F0=;
        b=RHgXud05F0aLu7gicurU19c+iH1o5nKF/sPSUcZS2Of3DFz951e35hxOtV0Cjl8nZDbNDz
        8rN56V8PsLV8UNm4/pA+xXe7ck+P1N31/nMipWCI3kg8tB+rGLVIQcr1aG0yReaYfe/xjp
        3R/bfWr1mTn+tG3QdqlaIog4zcREd0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665485327;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AxhNjRWlHP0qUYaHdyF2UuehBaiRsBboHO9O1NoR2F0=;
        b=Pnb/Pkt1NDHR7MuQImjnQ6l+3tztMUcnPbv8Ec86czPpaMkQpJXLf0gsZIk6FGoMY0pACO
        JHlFvSD+Fu5YuCCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC29D13AAC;
        Tue, 11 Oct 2022 10:48:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wt38KA9KRWM+IQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Oct 2022 10:48:47 +0000
Date:   Tue, 11 Oct 2022 12:48:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 00/16] btrfs: split out larger chunks of ctree.h
Message-ID: <20221011104842.GO13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663175597.git.josef@toxicpanda.com>
 <6887ace2-0427-e1fb-89ac-e13bc0b84317@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6887ace2-0427-e1fb-89ac-e13bc0b84317@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 15, 2022 at 05:51:12PM +0800, Qu Wenruo wrote:
> On 2022/9/15 01:18, Josef Bacik wrote:
> >    btrfs: move accessor helpers into item-accessors.h
> 
> Oh my god, I have "accessors.h" in my btrfs-fuse project from day 1, 
> finally can see it in upstream btrfs.

Good for you, you don't have to repeat the same mistakes and copy the
file naming scheme in a fresh project, that's the advantage. In an
actively developed yet old code base it's not for free. We basically
have to stop for one dev cycle and do only cleanups and renaming and
this will haunt us for years when doing backports. I'm not looking
forward to that but we need it.

> But one thing to mention is, "item" looks more leaf oriented, while I 
> believe node accessors would also be in the same header?
> 
> Thus what about just plain "accessors.h"?

Yeah probably accessors.h will be the final name.

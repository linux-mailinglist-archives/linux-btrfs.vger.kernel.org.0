Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626C663B0CD
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 19:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiK1SLT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 13:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbiK1SLA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 13:11:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930A55EFB2
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 09:54:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1383F21AB5;
        Mon, 28 Nov 2022 17:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669658037;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HGbNvkOureDRIgEbX0q7prBKBe0lCrGh0DdKvEd1i4E=;
        b=bBLAVT8tuz5NZBxtb2t9UagYU+ijv/LAGu+llsjo6DqKHu0YrILWvxhmKlYGp2hKG9w+fC
        8fKrq8tH+6Fv9YQnaCOH83Xd1/ay+C71xbiQAPx4JQWiyQY4z8nw6kAg5YNVkrTKljlKnj
        WrfqM04Y5kq6Sg61tTt6GM4F7lH04Sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669658037;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HGbNvkOureDRIgEbX0q7prBKBe0lCrGh0DdKvEd1i4E=;
        b=XtUkBpAUO/7WqwCDLEqtmGuHp3z/bpSDthOSc2Mi6nSZd55QOMxQ1GhvdfMTZqucdassWm
        I/ZsS5+0A5OYsYCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1E0913273;
        Mon, 28 Nov 2022 17:53:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IpQTMrT1hGOYEwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 28 Nov 2022 17:53:56 +0000
Date:   Mon, 28 Nov 2022 18:53:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 04/29] btrfs-progs: use -std=gnu11
Message-ID: <20221128175323.GT5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1669242804.git.josef@toxicpanda.com>
 <d14df29fe513f2ee0cd0290407da381824af239e.1669242804.git.josef@toxicpanda.com>
 <e88cbf8f-7f98-9642-d9b8-44ec1d4f9e2c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e88cbf8f-7f98-9642-d9b8-44ec1d4f9e2c@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 28, 2022 at 01:49:36PM +0530, Anand Jain wrote:
> On 11/24/22 04:07, Josef Bacik wrote:
> > The kernel switched to this recently, switch btrfs-progs to this as well
> > to avoid issues with syncing the kernel code.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >   Makefile | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index 475754e2..aae7d66a 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -401,7 +401,7 @@ ifdef C
> >   			grep -v __SIZE_TYPE__ > $(check_defs))
> >   	check = $(CHECKER)
> >   	check_echo = echo
> 
> 
> > -	CSTD = -std=gnu89
> > +	CSTD = -std=gnu11
> 
> We have one btrfs-progs source code compiling for kernels 4.x, 5.x and 
> 6.x; I am not yet sure if this will remain compatible, any idea?

Yes, the compatibility will remain and centos7 has 4.8 gcc as a lower
bound for the versions.

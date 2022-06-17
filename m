Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EED54F907
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 16:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiFQOTB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 10:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiFQOTA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 10:19:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150CE1129
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 07:18:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C97D21FDEA;
        Fri, 17 Jun 2022 14:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655475537;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZTCkL43p1P6xP2lvzoMi9iwv0tORAjm0m5XLDVXIBK4=;
        b=GyjHaXAascivTjfj0n6zUoKT6ctHSvziX+xVs32glwGeh33RDeGGkLcvvI/ady4ZUczrxd
        HBdczzmbJM83I+KpPIjCvwvnqDpDysZ7GjuF22H1hqH3RfxwSUnUAInPUxQb+Jf7lBP0rh
        p5WncrWQU+BohRy5K7bH5F7Jp/GSj/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655475537;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZTCkL43p1P6xP2lvzoMi9iwv0tORAjm0m5XLDVXIBK4=;
        b=wd5hiTDEQ8JTQPf5oqj0/rbD7ynCLWvfUIyH7kmUmTYqy9N1uKahCVoOi+pEShr/8owEgt
        syN6xnRHDZqnonBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EAA81348E;
        Fri, 17 Jun 2022 14:18:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7FNTIVGNrGKAKwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 17 Jun 2022 14:18:57 +0000
Date:   Fri, 17 Jun 2022 16:14:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Stefan Roesch <shr@fb.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Josef Bacik <josef@toxicpanda.com>, boris@bur.io
Subject: Re: [PATCH v1 3/3] btrfs: add force_chunk_alloc sysfs entry to force
 allocation
Message-ID: <20220617141422.GK20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stefan Roesch <shr@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Josef Bacik <josef@toxicpanda.com>, boris@bur.io
References: <20220208193122.492533-1-shr@fb.com>
 <20220208193122.492533-4-shr@fb.com>
 <20220404170221.GU15609@twin.jikos.cz>
 <3b9bd6b6-ac63-6f8f-85a0-30ddd86f47d8@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b9bd6b6-ac63-6f8f-85a0-30ddd86f47d8@fb.com>
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

On Thu, Jun 16, 2022 at 01:59:47PM -0700, Stefan Roesch wrote:
> On 4/4/22 10:02 AM, David Sterba wrote:
> > On Tue, Feb 08, 2022 at 11:31:22AM -0800, Stefan Roesch wrote:
> > Starting transaction from sysfs callbacks is not considered safe due to
> > potentially heavy operations going on, taking locks etc. and should be
> > done in the follwing way:
> > 
> > 	btrfs_set_pending(fs_info, COMMIT);
> > 	wake_up_process(fs_info->transaction_kthread);
> > 
> >> +	if (!trans)
> >> +		return PTR_ERR(trans);
> >> +	ret = btrfs_force_chunk_alloc(trans, space_info->flags);
> > 
> > Similar here, check the function, it does a lot of things, this is not
> > safe from sysfs context.
> > 
> > This will need to be done somewhere early in the transaction commit
> > after setting a new pending bit here in sysfs, like the
> > btrfs_set_pending(..., COMMIT) does.
> > 
> 
> I discussed this with Josef and Boris. Using a work queue to process these
> requests seems to be more adequate then using pending transaction flags.
> Any thoughts?

I've left is as is, commit from sysfs though it's not safe, the file is
available only under debug.

Otherwise, the patches have been in misc-next with my fixups so you
don't need to resend.

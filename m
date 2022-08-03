Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B359588C78
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 14:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbiHCMzn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 08:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbiHCMzl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 08:55:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E692B9A
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 05:55:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CD69A1FA04;
        Wed,  3 Aug 2022 12:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659531338;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Q0XsPXHdg4GsuIaamR2/9sJzpkUEtJmy99RmxhjP0A=;
        b=2wAaGhEfJGPg+oh1U62+Aalv9GY8pKWSFjzDFk/uH0buQMW3B+HinswzhrUmRIEjmdroOF
        46b59iuT28wq/cPIUnAxbVb8KcU2kaBMduiHfnwd0D4z4EwlWmOiHnwiDen5/JExBR4H8f
        UYGtOrk+MdsefcW5jJBla7M8bmhgy6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659531338;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Q0XsPXHdg4GsuIaamR2/9sJzpkUEtJmy99RmxhjP0A=;
        b=sYIcHzPKvKiVDpkIL2grJLTbQcdtTnrKPia54Zj+9avYVJ/EC1ypxMwa1f0omdi+SGFoS3
        2D4zBR7CHzRX9pDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A84B213AD8;
        Wed,  3 Aug 2022 12:55:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /soaKEpw6mIgbgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 03 Aug 2022 12:55:38 +0000
Date:   Wed, 3 Aug 2022 14:50:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: scrub: small enhancement related to super
 block errors
Message-ID: <20220803125036.GB13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1659423009.git.wqu@suse.com>
 <20220802142234.GL13489@twin.jikos.cz>
 <6c1700f0-7389-268c-1d15-4f35288a2b9a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c1700f0-7389-268c-1d15-4f35288a2b9a@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 03, 2022 at 06:18:20AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/8/2 22:22, David Sterba wrote:
> > On Tue, Aug 02, 2022 at 02:53:01PM +0800, Qu Wenruo wrote:
> >> Recently during a new test case to verify btrfs can handle a fully
> >> corrupted disk (but with a good primary super block), I found that scrub
> >> doesn't really try to repair super blocks.
> >
> > As the comment says, superblock gets overwritten eventually, I'm not
> > sure we need to start the commit if it's found to be corrupted.
> 
> The problem is, if someone like me to expect scrub to repair everything
> it can, thus doing scrub (to repair) then scrub (to check), then the
> second scrub still report super block error is definitely not expected.

That's a good point, scrub should fix what it could. That the superblock
could be skipped is an optimization but for a correctness feature it's
not the main criteria.

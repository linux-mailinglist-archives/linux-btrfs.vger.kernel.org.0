Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F3D5BF945
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Sep 2022 10:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiIUIaf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 04:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiIUIab (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 04:30:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3A752DFD
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 01:30:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A54CF1F38D;
        Wed, 21 Sep 2022 08:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663749026;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LjyahwoQenxhAUvNIhpD9aWbdyL2ltlnjc+FSj8nKSI=;
        b=hzW3tPkZRbLY47VxEZhRJl99uP1Vt/Imf0EjP/dZEvTA7yPyyN4lXgfrahfTVN+kQjT3dJ
        /5sHc3sTjHl9iEkN/7dl6lfXPgBxekypjxnut2GDJ8anfhxQHWBPi30JialpU/pDmMybFO
        r3yHDif7ayFn8QaI5rLQ31xp6izhfVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663749026;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LjyahwoQenxhAUvNIhpD9aWbdyL2ltlnjc+FSj8nKSI=;
        b=//NiRoh+kUfD2wqZ/2nhV1DbV/XdRhHzxKfmfmjbpMwdu13/MtHnoxOP4D4dO5/1CVVodU
        uIULdfU/uru6UqAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8818D13A89;
        Wed, 21 Sep 2022 08:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SSlIIKLLKmMHKwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 21 Sep 2022 08:30:26 +0000
Date:   Wed, 21 Sep 2022 10:24:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: balance: fix some cases wrongly parsed as
 old syntax
Message-ID: <20220921082454.GZ32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220914055846.52008-1-wangyugui@e16-tech.com>
 <0f631df8-321d-023a-85fd-c80817affbbb@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f631df8-321d-023a-85fd-c80817affbbb@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 14, 2022 at 03:11:04PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/9/14 13:58, Wang Yugui wrote:
> > Some cases of 'btrfs balance' are wrongly parsed as old syntax.
> > 
> > an example:
> > $ btrfs balance status
> > ERROR: cannot access 'status': No such file or directory
> > 
> > currently, only 'start' is successfully excluded in the check of old syntax.
> > fix it by adding others in the check of old syntax.
> > 
> > Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> 
> The old code is over 10 years.
> 
> Can we just remove it completely?

I hope everybody uses the new syntax so it's time to remove support for
the old one, but we should still leave some warning in place suggesting
what's the preferred way and then remove it completely in a few
releases.

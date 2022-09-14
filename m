Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5A55B8A97
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 16:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiINOdM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 10:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiINOdK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 10:33:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6CC5F999
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 07:33:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4048933923;
        Wed, 14 Sep 2022 14:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663165986;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=phJUsNIfJbHfOteLi5KuY2Dyey0mRmFaVuE1Vsknk+Q=;
        b=FdnNioRgtXoTrfinuTdHuX4n+n5N++q+c9RPisfTjFI3iSLNx7sW0A6rXmr9x99FMOKS1S
        yDtO2ZAiAnhEbpDRBq3sCM9iwME2E8i8ZTtB6Z5orTtEgy7lbVxREMJmcZNczqBok+RkFN
        FDfPBxWR1PlthmqUFUnlURKJuIbxepc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663165986;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=phJUsNIfJbHfOteLi5KuY2Dyey0mRmFaVuE1Vsknk+Q=;
        b=Lu/qQ1EAY0hWxWNLVkjh4D9IE+t9lpAQiiHty4ZoqjzwMjPsvoku6MSgDPGCTQ9VIWXUWM
        +n5FAhWUkAwHStCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22072134B3;
        Wed, 14 Sep 2022 14:33:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xFdmByLmIWOYNwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 14 Sep 2022 14:33:06 +0000
Date:   Wed, 14 Sep 2022 16:27:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Mariusz Mazur <mariusz.g.mazur@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Is scrubbing md-aware in any way?
Message-ID: <20220914142738.GN32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAGzuT_3UVJuXeDjQ4CtM77TO2C6WoBAiWyyBi59_wcv3p7znzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGzuT_3UVJuXeDjQ4CtM77TO2C6WoBAiWyyBi59_wcv3p7znzA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 13, 2022 at 04:15:26PM +0200, Mariusz Mazur wrote:
> Hi, it's my understanding that when running a scrub on a btrfs raid,
> if data corruption is detected, the process will check copies on other
> devices and heal the data if possible.
> 
> Is any of that functionality available when running on top of an md
> raid?

No, the type of block device under btrfs is considered the same in all
cases, except zoned devices, so any advanced information exchange or
control like devices reporting bad sectors or btrfs asking to repair the
underlying device by its own means.

> When a scrub notices an issue, does it have any mechanism of
> telling md "hey, there's a problem with these sectors" and working
> with it to do something about that or is it all up to the admin to
> deal with the "file corrupted" message?

It's up to the admin. I've looked if there's some API outside of the
md-raid implementation, but there's none so it would have to be created
first in for the btrfs <-> md cooperation.

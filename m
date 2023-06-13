Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7488172E7E0
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 18:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240406AbjFMQJK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 12:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242760AbjFMQJJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 12:09:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916391985
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 09:09:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3E67C22508;
        Tue, 13 Jun 2023 16:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686672547;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8s1YafDgOUumLXY4AWSGt+DvjWhx6tYW2U6HrWgd8N8=;
        b=s6mMdXuB0xmXdFn/yBW8RvfqospkcT8tK3jBddLo+vGkBuN2eby0kpJ/E5ug0v8SziyhPs
        jnDwHry0YbAl9TyHJHiZZDa0TOi51XWYoE/nEx9TUcAg49iXaT9OfNsuciHNYeXQ/wrX05
        pOoLFdWEnP6nL8xKoRaOp2ASrqO8lg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686672547;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8s1YafDgOUumLXY4AWSGt+DvjWhx6tYW2U6HrWgd8N8=;
        b=dEVZBqay1m2zaXGvcdXpIfHZBp/PHvjhv6BpZ9kcRkCNWeA5CHO+BYYAqdSe1ZnBD/XkiO
        UhTohHFVtjHN43DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D47713483;
        Tue, 13 Jun 2023 16:09:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UgtSBqOUiGTkNQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 13 Jun 2023 16:09:07 +0000
Date:   Tue, 13 Jun 2023 18:02:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Regression that causes data csum mismatch
Message-ID: <20230613160247.GK13486@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <da414ecc-f329-48ec-94d2-67c94755effb@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da414ecc-f329-48ec-94d2-67c94755effb@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 13, 2023 at 02:26:39PM +0800, Qu Wenruo wrote:
> Hi,
> 
> Recently I am testing scrub preparing for the incoming logical scrub.
> 
> But I noticed some rare and random test cases failure from scrub and
> replace groups.
> 
> E.g. btrfs/072 has a chance of failure around 1/30.

I'd like to get a list of tests that could potentially reproduce it.  I've
started 072 in a loop but given the frequency and also a possible other
factors this probably won't be enough.

> Initially I thought it's my scrub patches screwing things up, but with
> more digging, it turns out that it's real data corruption.
> 
> After scrubbing found errors, btrfs check --check-data-csum also reports
> csum mismatch.

It would be good to share the updates to fstests with the tests. I've
added the data csum check to _check_btrfs_filesystem.

> Furthermore this is profile independent, I have see all profiles hitting
> such data corruption.

How does the corruption look like?

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D2977969F
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 20:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjHKSEQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 14:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjHKSEQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 14:04:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8002706
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 11:04:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 99F9D218E0;
        Fri, 11 Aug 2023 18:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691777054;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Fv/3Dc4aFfNMyVxBvFGgkdPhKkqTI5CsQcCGocXJCw=;
        b=g19wlVzUYwVeYn1n2BYNt0CNa2nVt7/yZfD3KWpsWGV8raVQDDrcUaum+3pn8kniqVRlMI
        5KumxVdXRMbFdTvaifQlFHBtWgzmkGQrpx0KY3RFSMPNAPFGSczW3LD997ce3JJeK3tqd2
        NTWvHVh60QT4gyybUupaIdOWtLLalZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691777054;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Fv/3Dc4aFfNMyVxBvFGgkdPhKkqTI5CsQcCGocXJCw=;
        b=4ktj5ybwkWUnmh0Hhf+d/6K1K4dcZ+ytDCYeVg9ldkoPH1dmc6+FILe1EOJBVVq4FXW614
        8maimmg2DJhB7hAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73B2F13592;
        Fri, 11 Aug 2023 18:04:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zLsgGx541mQ9bAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Aug 2023 18:04:14 +0000
Date:   Fri, 11 Aug 2023 19:57:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tests: not_run for global_prereq fail
Message-ID: <20230811175749.GA2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <149265ca8a94688008c1cda96c95cf83ac55950c.1690024017.git.anand.jain@oracle.com>
 <20230727165157.GG17922@twin.jikos.cz>
 <155356de-ddfc-118c-eaaa-9dca8f2401a1@oracle.com>
 <12e88a5b-59d1-4403-f9b6-37ec23866e77@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12e88a5b-59d1-4403-f9b6-37ec23866e77@oracle.com>
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

On Fri, Jul 28, 2023 at 11:51:18AM +0800, Anand Jain wrote:
> On 28/07/2023 11:39, Anand Jain wrote:
> > On 28/07/2023 00:51, David Sterba wrote:
> >> On Tue, Jul 25, 2023 at 05:43:54PM +0800, Anand Jain wrote:
> >>> Prerequisite checks using global_prereq() aren't global, so why
> >>> fail and stop further test cases? Instead, just don't run them.
> >>
> >> I'd rather let the whole testsuite run, a missing global prerequisity
> >> means the environment is not set up properly, so this fail as intended.
> >> If you look what kind of utilities are checked in that way it's eg. dd,
> >> mke2fs, chattr, losetup. All are supposed to be available on a common
> >> system so it's not expected to fail.
> >>
> >> If there's some less common utility and a test which could be optional
> >> then this should be a special case, which would require a new helper.
> > 
> > I would prefer using check_global_prereq() to verify all the mandatory
> > prerequisites at once.
> > 
> > If each test case checks for a different binary using
> > check_global_prereq() and it fails during that test case, we have to
> > restart, which becomes messy.
> 
>   Commit 'btrfs-progs: tests: add script to check global prerequisities'
>   addressed the messy situation mentioned above.
> 
> > The support for mkreiserfs on OL was removed, causing the test case
> > to abruptly stop in the middle.
> 
>   Is there a way to skip the test cases?

No, though there's the newly added TEST_FROM=test that skips all tests
preceding the one. Skipping a given class of tests would make sense,
though the easiest thing would be to skip by the directory name, so e.g.
TEST_SKIP=*resiserfs* that would be a followup filter after TEST.

Aloso we can mark the reiserfs tests as obsolete as the package are
being dropped from distros (openSUSE Tumbleweed does not ship it
anymore) and kernel support for reiserfs is going to be removed next
year. I don't want to add some generic infrastructure just for that so
I'll think about something simple like silently skipping the tests by
default.

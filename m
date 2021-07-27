Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564A73D71AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 11:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbhG0JFm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 05:05:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50332 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbhG0JFl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 05:05:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5B9CD200E4;
        Tue, 27 Jul 2021 09:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627376741;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AK6Z1ESnln5hAltD/AQpRJ6IclTultGtDAXI2fWJ520=;
        b=v/TZSM3pgACA7XYxKl7K5Y38mEjHi6nmOT7tH+QjC0QiYjkmystgLVXof1j8XWAtR3kIwC
        Nase/Pf2lXVm1NBUmntRomBhhlR5hzaPCqbqcSA+W4rRIMHQtIHNmwXKELdkbY+YegL3xJ
        R/G5tvDemzv6WtcyHVqvhSpLelUWTXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627376741;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AK6Z1ESnln5hAltD/AQpRJ6IclTultGtDAXI2fWJ520=;
        b=CqGmfGVCeI9iTZLt0etb6oyN8MyNeUo7GlwWWD59EjsURqjjBkrrlCQZ/Bq4MQ0qIY2PNC
        W45K/vPhknmz0UAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3ED14A3B84;
        Tue, 27 Jul 2021 09:05:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0BE68DA8CC; Tue, 27 Jul 2021 11:02:57 +0200 (CEST)
Date:   Tue, 27 Jul 2021 11:02:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Jorge Bastos <jorge.mrbastos@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Maybe we want to maintain a bad driver list? (Was 'Re: "bad tree
 block start, want 419774464 have 0" after a clean shutdown, could it be a
 disk firmware issue?')
Message-ID: <20210727090256.GL5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Jorge Bastos <jorge.mrbastos@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAHzMYBT+pMxrnDXrbTJqP-ZrPN5iDHEsW_nSjjD3R_w3wq5ZLg@mail.gmail.com>
 <20210721174433.GO19710@twin.jikos.cz>
 <8b830dc8-11d4-9b21-abe4-5f44e6baa013@gmx.com>
 <20210722135455.GU19710@twin.jikos.cz>
 <20210724231527.GF10170@hungrycats.org>
 <CAJCQCtSc8x3xLKb2yyBchgvMn-0ecGi56CEDtQcFD74WyEOzUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtSc8x3xLKb2yyBchgvMn-0ecGi56CEDtQcFD74WyEOzUw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 24, 2021 at 09:34:23PM -0600, Chris Murphy wrote:
> On Sat, Jul 24, 2021 at 5:16 PM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > SSDs are a different story:  there are so many models, firmware revisions
> > are far more diverse, and vendors are still rapidly updating their
> > designs, so we never see exactly the same firmware in any two incident
> > reports.  A firmware list would be obsolete in days.  There is nothing
> > in SSD firmware like the decade-long stability there is in HDD firmware.
> 
> It might still be worth having reports act as a counter. 0-3 might be
> "not enough info", 4-7 might be "suspicious", 8+ might be "consider
> yourself warned".
> 
> But the scale could be a problem due to the small sample size.

That's a good idea, I've started something on
https://btrfs.wiki.kernel.org/index.php/Hardware_bugs
using the mentioned WD and firmware as first exapmle.

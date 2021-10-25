Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A604397A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 15:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhJYNhL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 09:37:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38666 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhJYNhK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 09:37:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E8FEA1FD3A;
        Mon, 25 Oct 2021 13:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635168887;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=30//mepYQYYj8ow4C4+Ze1MsOJdxi+wpQG0oH+bBS2M=;
        b=dvM6CKfM9Fy73ZDZdLEdr2mMlnjF+K+KubhfnMF4Ix2wbxJRReHhB8rWCM2Qa/PZkc9tja
        Utlp3XWvoSFZQjifTrDjmQ92rJrf10Vx5nFGKrwdXh8bXp5YW/VeLown3ychqyXz93kYN6
        TpXc8Iuo3euEfTf1Fh5Co6wyMGoZrOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635168887;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=30//mepYQYYj8ow4C4+Ze1MsOJdxi+wpQG0oH+bBS2M=;
        b=D+TPtp0R0mAmIr/LHR/v/oD0IRvy3sxgBW7aaEpKoQG5+Ps1eHvbw74ewYLtvtcQKUO4TK
        UHLNkOCOzY/BpOBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E2BA7A3B87;
        Mon, 25 Oct 2021 13:34:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0F786DA7A9; Mon, 25 Oct 2021 15:34:16 +0200 (CEST)
Date:   Mon, 25 Oct 2021 15:34:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs.wiki.k.org and git-based update workflow
Message-ID: <20211025133416.GO20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20211022141200.GK20319@twin.jikos.cz>
 <CAEg-Je_j=3JgTon1NpNF2PzzWHMracyOWAYHv4CBGoq420f2oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEg-Je_j=3JgTon1NpNF2PzzWHMracyOWAYHv4CBGoq420f2oQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 22, 2021 at 11:42:14AM -0400, Neal Gompa wrote:

> It'd probably be good if we could eventually convert it to
> Sphinx-based documentation like the rest of the Linux kernel
> documentation. We could use readthedocs or reuse btrfs.kernel.org for
> this.

The way sphinx docs are presented is a bit differnt (more linear whan
the wiki pages web), but I think it could improve discoverability of the
deeper pages. I'm not sure it's suitable for all the content that's
currently on the wiki, there are some free-form looking pages, but eg.
manual pages or FAQ are good candidates.

The only thing that bothers me is that spinx needs RST, yet another
markup language. I haven't found convertors asciidoc -> rst, but the
format is simple and some of the sturucture can be scripted.  It does
not conflict with the goal to have the sources in git and we could have
both output formats, wiki and readthedocs. So, thanks for the suggestion.

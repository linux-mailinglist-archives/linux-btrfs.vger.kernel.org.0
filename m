Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301B538E7B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 May 2021 15:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhEXNfD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 May 2021 09:35:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:45846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232409AbhEXNfC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 May 2021 09:35:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621863214;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7x9We72PXrhiwH7SJFNZHCwLtsU/MhnMP1wqWBKq+ro=;
        b=oyfjGruHrUs6o2kwM1qVZnaCGi4ZtP3BRtl0it4s3np3vTfnyAKHVIDp3ksss7WOYMAOkf
        QPAJSHepFTpCkLssJvXZfpbkSCNVYOVyh8AvX73slzrgtk4Nc/L9nr2EVTQm4iDVKJ1i3U
        uiBiqwmLVrhuH2fwlPP5lssopO/N7Qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621863214;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7x9We72PXrhiwH7SJFNZHCwLtsU/MhnMP1wqWBKq+ro=;
        b=QWjVrEVgwkMcsNaT+qpoyWTZr4nrMmtasbRb5tD/HFjA3RBYQuDXgcWVLcol+lIlNQ20bC
        aCAogVZ/0buqXDDg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EE87EAC11;
        Mon, 24 May 2021 13:33:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DCC81DA72C; Mon, 24 May 2021 15:30:55 +0200 (CEST)
Date:   Mon, 24 May 2021 15:30:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] btrfs: zoned: fix compressed writes
Message-ID: <20210524133055.GS7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621351444.git.johannes.thumshirn@wdc.com>
 <1220142568f5b5f0d06fbc3ee28a08060afc0a53.1621351444.git.johannes.thumshirn@wdc.com>
 <563c1ac3-abf3-3f60-dbdf-362ebc69eb28@toxicpanda.com>
 <92273193-366c-8121-c2f6-26c885d77ead@gmx.com>
 <3cba8426-5574-0da7-28bd-aa90eb9f18b8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3cba8426-5574-0da7-28bd-aa90eb9f18b8@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 24, 2021 at 09:04:40PM +0800, Qu Wenruo wrote:
> > This is the interesting part, it means we are just one sector beyond the
> > stripe boundary.
> > Definitely a sign of changed bio submission timing.
> >
> > Just like the code:
> >
> > +        if (pg_index == 0 && use_append)
> > +            len = bio_add_zone_append_page(bio, page, PAGE_SIZE, 0);
> > +        else
> > +            len = bio_add_page(bio, page, PAGE_SIZE, 0);
> > +
> >           page->mapping = NULL;
> > -        if (submit || bio_add_page(bio, page, PAGE_SIZE, 0) <
> > -            PAGE_SIZE) {
> > +        if (submit || len < PAGE_SIZE) {
> >
> > The code has changed the timing of bio_add_page().
> >
> > Previously, if we have submit == true, we won't even try to call
> > bio_add_page().
> >
> > But now, we will add the page even we're already at the stripe boundary,
> > thus it causes the extra sector being added to bio, and crosses stripe
> > boundary.
> >
> > This part is already super tricky, thus I refactored
> > submit_extent_page() to do a better job at stripe boundary calculation.
> 
> BTW, I can also reproduce the problem in btrfs/027 using the latest
> misc-next branch.
> 
> Thus to workaround the problem, I'm using the following diff, feel free
> to fold in to the offending patch.

The patch is now in master so we'll need a proper fix.

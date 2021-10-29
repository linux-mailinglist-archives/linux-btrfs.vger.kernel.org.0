Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDDE43FEDA
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Oct 2021 17:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhJ2PCm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 11:02:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38890 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ2PCm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 11:02:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BA91921977;
        Fri, 29 Oct 2021 15:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635519612;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U8fTZhDabONM+9gZNFAkwGAG2sHN0GZyal7eI4ulnVc=;
        b=eHhJrL4UzP5YnqK9IBsPuzI7HDIuylywoevgv8E1C0xZPQvtV9Makz6gPg4syFFPIpE5Y8
        xYUZy8K0tolu15YuNJfLjfyrVIyhBrG07OD7TkWTU09+AwV5h3ScPz+Xlj0uo5r+wCa75g
        GAcy3JcIH68S8BXliN1SPX6SJDnJrY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635519612;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U8fTZhDabONM+9gZNFAkwGAG2sHN0GZyal7eI4ulnVc=;
        b=rsCWc0cGAK8Z6T48Br22d1NinAKo52lSNxusAen8pER9QnZDL/XRJgnEyx1FnoIwbOm0w9
        UhWsG6bk1A/g75Cw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B20CEA3B84;
        Fri, 29 Oct 2021 15:00:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A7F93DA7A9; Fri, 29 Oct 2021 16:59:39 +0200 (CEST)
Date:   Fri, 29 Oct 2021 16:59:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs.wiki.k.org and git-based update workflow
Message-ID: <20211029145939.GE20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20211022141200.GK20319@twin.jikos.cz>
 <CAEg-Je_j=3JgTon1NpNF2PzzWHMracyOWAYHv4CBGoq420f2oQ@mail.gmail.com>
 <20211025133416.GO20319@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025133416.GO20319@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 25, 2021 at 03:34:16PM +0200, David Sterba wrote:
> On Fri, Oct 22, 2021 at 11:42:14AM -0400, Neal Gompa wrote:
> 
> > It'd probably be good if we could eventually convert it to
> > Sphinx-based documentation like the rest of the Linux kernel
> > documentation. We could use readthedocs or reuse btrfs.kernel.org for
> > this.
> 
> The way sphinx docs are presented is a bit differnt (more linear whan
> the wiki pages web), but I think it could improve discoverability of the
> deeper pages. I'm not sure it's suitable for all the content that's
> currently on the wiki, there are some free-form looking pages, but eg.
> manual pages or FAQ are good candidates.
> 
> The only thing that bothers me is that spinx needs RST, yet another
> markup language. I haven't found convertors asciidoc -> rst, but the
> format is simple and some of the sturucture can be scripted.  It does
> not conflict with the goal to have the sources in git and we could have
> both output formats, wiki and readthedocs. So, thanks for the suggestion.

A preview of the manual pages is here

https://deleteme12545.readthedocs.io/en/latest/

It's a temporary location because btrfs.readthedocs.io was not free but
I'm in the process of claiming it.

The RST is not much different from the asciidoc syntax so I converted
all the manual pages, the RTD is directly from the devel branch in
btrfs-progs. I'll full switch to RST after 5.15 release, there are some
formatting artifacts still to solve but right now the result is
pleasant.

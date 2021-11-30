Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC05C463D18
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Nov 2021 18:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhK3RrM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Nov 2021 12:47:12 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41034 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhK3RrM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Nov 2021 12:47:12 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 704C01FD59;
        Tue, 30 Nov 2021 17:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638294232;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OAH6Zis+BqQWS2EeYhykS4HcbqaingpifguH1BfdQmg=;
        b=ytbhirnsZn8x3wmS7B5k95SxPQF9AJgzE7WqbSUmMv3fF3EHVWZnlwKsYZLnIEh6oyNcRn
        S8eic7g3Pc/0PA9TYVPABaWvIEVbR2AyDArPNEuHaS8HeiAIt0JKcFbg6cc5OtVmvHm4l1
        TohMpFHP6mieNkxQexu/Rx9DGQLSYJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638294232;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OAH6Zis+BqQWS2EeYhykS4HcbqaingpifguH1BfdQmg=;
        b=UFTjaReV4xIJ4TtAcYzmR18wZU/iTmMPdkCuPIwSANxX25Lw6RzukcP3obsikiPP2WFmWM
        00PYY51jo2NDKEDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 66AE3A3B81;
        Tue, 30 Nov 2021 17:43:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3E931DA7A3; Tue, 30 Nov 2021 18:43:41 +0100 (CET)
Date:   Tue, 30 Nov 2021 18:43:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v3] btrfs-progs: filesystem: du: skip file that
 permission denied
Message-ID: <20211130174340.GJ28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <20211122155411.10626-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122155411.10626-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 22, 2021 at 03:54:11PM +0000, Sidong Yang wrote:
> This patch handles issue #421.

The issue is about descending to mount points, while you add handling of
permissions. Is it referring to the right issue?

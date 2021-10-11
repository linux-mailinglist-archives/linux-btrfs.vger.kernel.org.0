Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAED429718
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 20:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhJKStt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 14:49:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39134 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhJKStl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 14:49:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 344DA22101;
        Mon, 11 Oct 2021 18:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633978060;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RsZu/nB4AyaJgxDVoe1L8na9GR4LVs+KM1FG/z4zWOA=;
        b=KY8EPjkTwXWY3DeOU6QtXFf5oRlOM3sHaLq6/YCVYuqK3OpQxbJNt3eEugNqbYsNJUDTSM
        1W6c+1b40h6BqHnlLygS8MMLXnUMb8MrwTKN0eibHeiuPvRZd0RVKMEVpjc99ZtZqDvOxW
        0DfT3Gl1yi6NfR5/HmNTKtOoxqoJst0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633978060;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RsZu/nB4AyaJgxDVoe1L8na9GR4LVs+KM1FG/z4zWOA=;
        b=ZicdOAA6Qm1n3t6ZXGT1A9sWNrM+O1Lauq+r+sS6NlABrS+ptttIBW+5eWJcyuD4cLmgro
        yuECuicLaikvrdBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2A5F2A3B84;
        Mon, 11 Oct 2021 18:47:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C196BDA781; Mon, 11 Oct 2021 20:47:16 +0200 (CEST)
Date:   Mon, 11 Oct 2021 20:47:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     kreijack@inwind.it
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 00/10] btrfs-progs: mkfs fixes and prep work for
 extent tree v2
Message-ID: <20211011184716.GT9286@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, kreijack@inwind.it,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629749291.git.josef@toxicpanda.com>
 <20210825135839.GK3379@twin.jikos.cz>
 <03ae7a36-dbc9-bfad-6ec7-45e929f862a7@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03ae7a36-dbc9-bfad-6ec7-45e929f862a7@libero.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 11, 2021 at 08:35:53PM +0200, Goffredo Baroncelli wrote:
> On 8/25/21 3:58 PM, David Sterba wrote:
> > On Mon, Aug 23, 2021 at 04:14:45PM -0400, Josef Bacik wrote:
> [...]
> > Even with the "if (EXTENT_TREE_V2)" in place it becomes the
> > implementation and given that I haven't read the whole design doc for
> > that I'm worried that once I find time for that and would suggest some
> > changes the reply would be "no I did it this way, it's implemented,
> > would require too many changes".
> 
> Just for curiosity, is there anywhere a design doc for extent tree v2 ?

https://github.com/btrfs/btrfs-todo/issues/25 but it's more like an
ongoing discussion than a polished design doc, that's about to be a
result of that some day.

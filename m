Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4713ABD97
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jun 2021 22:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhFQUkQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Jun 2021 16:40:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53004 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhFQUkQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Jun 2021 16:40:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 89F4F21AF0;
        Thu, 17 Jun 2021 20:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623962287;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kYyKSTdUgBCU0HK4a5OG+mzQEA7L9wr5zj0mwizFkL0=;
        b=1R4VFLC/G7g4Ue6+qWqXC8t1NsMBNL+wOpcjFTSWI5vxbpCcnf9b9bzr/av4riVnwUyT6r
        LSZG6HFbbE11NSlY95x5D8DXnJ9lR0VlmsLJMGuFqvvFK4pFAAcwWV3fMq2f44OeuBt2fH
        ZTmFBlyFq9Drsj/PwzuuIRqPsbNTvvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623962287;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kYyKSTdUgBCU0HK4a5OG+mzQEA7L9wr5zj0mwizFkL0=;
        b=VZuapddWqcjUbPubikrIsEPd7GvJm3QDmV0VP9nXKGimxp0NXmowfspzMUq3Uoc2ypWKB1
        kvJwd50N6AYS6mAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EEEA2A3B85;
        Thu, 17 Jun 2021 20:38:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BA239DAEB9; Thu, 17 Jun 2021 22:35:18 +0200 (CEST)
Date:   Thu, 17 Jun 2021 22:35:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] btrfs: tests: remove unnecessary oom message
Message-ID: <20210617203518.GZ28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Zhen Lei <thunder.leizhen@huawei.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210617083053.1064-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617083053.1064-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 17, 2021 at 04:30:53PM +0800, Zhen Lei wrote:
> Fixes scripts/checkpatch.pl warning:
> WARNING: Possible unnecessary 'out of memory' message
> 
> Remove it can help us save a bit of memory.

Well, we have a few more messages in tests regarding failed memory
allocations.  Though I've never seen one in practice, I think it's not
a big deal to have that one here as well. The failures in the testsuite
are intentionally verbose and saving a few bytes in optional development
feature hardly bothers anyone.

Where bytes can be saved are error messages for the same type of error,
that I've implemented in the past, see file fs/btrfs/tests/btrfs-tests.c
array test_error that maps enums to strings.

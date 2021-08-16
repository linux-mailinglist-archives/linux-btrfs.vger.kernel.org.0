Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDCC3ED2A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 12:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbhHPKzz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 06:55:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57792 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbhHPKzb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 06:55:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4804E21DEB;
        Mon, 16 Aug 2021 10:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629111299;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nal/cRZ5NMLhIj4xkU7/+STGkWLp7eWWzDW/l8CAPj4=;
        b=U9fBhPdh44P7fJi/rp4ciM/Oj9QS5j73jkhTkDgg7HVU6qRHp6E8VZyrKNK9FseXouzXVG
        d9yQuYXhWRa3pRuYNzkPupIP38Jt1DL5LfcTtLvGdEPDgELgT/6gYd3cl2CpYlJhZ4EOc3
        4qX+5NNdFRxd4Be9hBPaXzXUeym48wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629111299;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nal/cRZ5NMLhIj4xkU7/+STGkWLp7eWWzDW/l8CAPj4=;
        b=t4RzTsZOxMlh9fo0tM125xF1eWNKM/bsdUbSYUfBTFV6Z0OO5N2wr+2uBlot2l7LEcgEvg
        N1Bb/ICJ6D6qFhCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4060EA3B8E;
        Mon, 16 Aug 2021 10:54:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 780E1DA72C; Mon, 16 Aug 2021 12:52:03 +0200 (CEST)
Date:   Mon, 16 Aug 2021 12:52:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: 5.14-0-rc5, splat in block_group_cache_tree_search while
 __btrfs_unlink_inode
Message-ID: <20210816105202.GV5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <CAJCQCtQEp1a=sf8hO7zL5PHz-7NLjMv-A2nXGCEkNCos+nVA6Q@mail.gmail.com>
 <20210816102022.GU5047@twin.jikos.cz>
 <1e15b3ab-e3a3-548b-86a7-c309deed0f12@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e15b3ab-e3a3-548b-86a7-c309deed0f12@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 16, 2021 at 01:27:35PM +0300, Nikolay Borisov wrote:
> 
> 
> On 16.08.21 г. 13:20, David Sterba wrote:
> > On Fri, Aug 13, 2021 at 10:33:05PM -0600, Chris Murphy wrote:
> >> I get the following call trace about 0.6s after dnf completes an
> >> update which I imagine deletes many files. I'll try to reproduce and
> >> get /proc/lock_stat
> >>
> >> [   95.674507] kernel: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> > 
> > The message "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low" is related to
> > lockdep and not a btrfs problem, but it appears from time to time and as
> > Johannes said either increase the config variable, or ignore it.
> > 
> 
> But is not a bug if code triggers it? I.e I think it's a signal of
> misbehaving code. CC'ed PeterZ who can hopefully shed some light on this.

Maybe it's a bug, maybe it's a misconfigured build. Somebody (I don't
remember the name) asked for logs and how often it happened, that I
provided and nothing happened and the warning still shows up.

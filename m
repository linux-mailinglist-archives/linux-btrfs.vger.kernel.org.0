Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D96A3967E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 20:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhEaS2F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 14:28:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:48492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232741AbhEaS2C (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 14:28:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622485581;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MsJAvMeATwBSt4Ty3Ruh8rCIuUGCnH0BqPRrvcpJypM=;
        b=Q8VAvJ/tnA11pTq7CgubYSRR1wJFf/q3R6llC6iMYPH3YIdkl38uG8YIdt6OSHHlX8hlig
        Yl/N7LMxNpSeSsH/anaeey6XYv2inr19Xd7CSop1RD/bdY71iV2fDmYzghyId0j1LHWhw2
        QpDuREYyel5eGdUVjCWPh5ULbFFq0V4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622485581;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MsJAvMeATwBSt4Ty3Ruh8rCIuUGCnH0BqPRrvcpJypM=;
        b=m19YpBywnQODeanTFM043l/SOfjWY7viz3MnVvHxrq9NYxZ+8i4y3XsyYVpVcG8HMT6e2Q
        UiCwy4as21VYKPAQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4AC2FB4F8;
        Mon, 31 May 2021 18:26:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AC4AFDA791; Mon, 31 May 2021 20:23:41 +0200 (CEST)
Date:   Mon, 31 May 2021 20:23:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/6] btrfs: introduce try-lock semantics for exclusive op
 start
Message-ID: <20210531182341.GB31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621526221.git.dsterba@suse.com>
 <9a99c2204e431bc7a40bd1fb7c26ebb5fa741910.1621526221.git.dsterba@suse.com>
 <dc12e388-70b9-1349-1e20-85a7fc60d350@oracle.com>
 <20210528123041.GA14136@suse.cz>
 <e17818ca-aef9-36b9-7677-cc49f24ea21e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e17818ca-aef9-36b9-7677-cc49f24ea21e@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 29, 2021 at 09:48:46PM +0800, Anand Jain wrote:
> On 28/05/2021 20:30, David Sterba wrote:
> > On Thu, May 27, 2021 at 03:43:46PM +0800, Anand Jain wrote:
> >> On 21/05/2021 20:06, David Sterba wrote:
> > The code flow is the same.
> > 
> 
> Oh. Ok, now I understand your POV.
> 
> I looked up the document to check what it says, and it matched with
> my understanding too, as below.
> 
> https://www.kernel.org/doc/htmldocs/kernel-locking/trylock-functions.html
> -----
> ::
> They can be used if you need no access to the data protected with the 
> lock when some other thread is holding the lock.
> ::
> ----
> 
> Mainly ...trylocks are non-blocking/non-waiting locks.
> 
> However, btrfs_exclop_start_try_lock() can be blocking.

I see, the blocking is there. It should be unnoticeable in practice as
it's locking only a few instructions. The semantics is slighly different
than a plain lock as it needs to check if the exclusive operation is
locked, not the lock itself. If it had to be a true nonblocking trylock,
it would have to check the exclusive_operation value unlocked and either
bail if it's different or recheck it again under lock. This sounds more
complicated than we need.

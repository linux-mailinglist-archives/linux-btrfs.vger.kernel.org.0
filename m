Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E221390576
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 17:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhEYPbn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 11:31:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:37054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230433AbhEYPbn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 11:31:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621956612;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mOJEmx1GGo/qpBiBuUtnSAcMIAQfPmcTuPwJezWI0gY=;
        b=TCpaojBMG7fl7z2gBDUpZjDEpe4wXZqgPApTqg3Ri/CBbjFmtX2XqyZMSD8VhbFZx43YQ7
        9UakUA86NS00cXX8cf2qzMN/UAv35hhtzhcXwzbBzMCgr2lwwGSKH7JjoTgOyYQxeWhDzA
        rKz+hU2UMXQYNN9FVX5COHMJB6YuYv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621956612;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mOJEmx1GGo/qpBiBuUtnSAcMIAQfPmcTuPwJezWI0gY=;
        b=hx1mN1NVsGbdKx39bxvPo8grWsYbszVZmiD+jk+I2O6EyhL43rP/RttR+kV5FFlYyWuwjm
        cG1OIpcotJyVvECQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CDACFAE99;
        Tue, 25 May 2021 15:30:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 65E7BDA72C; Tue, 25 May 2021 17:27:36 +0200 (CEST)
Date:   Tue, 25 May 2021 17:27:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/3] btrfs: always abort the transaction if we abort a
 trans handle
Message-ID: <20210525152736.GZ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1621523846.git.josef@toxicpanda.com>
 <d794156bd3368d635913610dbe03c1fc727e297f.1621523846.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d794156bd3368d635913610dbe03c1fc727e297f.1621523846.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 20, 2021 at 11:21:31AM -0400, Josef Bacik wrote:
> While stress testing our error handling I noticed that sometimes we
> would still commit the transaction even though we had aborted the
> transaction.
> 
> Currently we track if a trans handle has dirtied any metadata, and if it
> hasn't we mark the FS as having an error (so no new transactions can be
> started), but we will allow the current transaction to complete as we do
> not mark the transaction itself as having been aborted.
> 
> This sounds good in theory, but we were not properly tracking IO errors
> in btrfs_finish_ordered_io, and thus committing the transaction with
> bogus free space data.  This isn't necessarily a problem per-se with the
> free space cache, as the other guards in place would have kept us from
> accepting the free space cache as valid, but hi-lights a real world case
> where we had a bug and could have corrupted the filesystem because of
> it.
> 
> This "skip abort on empty trans handle" is nice in theory, but assumes
> we have perfect error handling everywhere, which we clearly do not.
> Also we do not allow further transactions to be started, so all this
> does is save the last transaction that was happening, which doesn't
> necessarily gain us anything other than the potential for real
> corruption.
> 
> Remove this particular bit of code, if we decide we need to abort the
> transaction then abort the current one and keep us from doing real harm
> to the file system, regardless of whether this specific trans handle
> dirtied anything or not.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

I've checked logs what would be the effects of leaving out the message
printed by the unused transaction. Getting rid of it sounds like an
improvement as it's not adding any information, the first transaction is
noisy and that's where the problem happens. Additional messages about
the abort are confusing, so yeah. Besides, the updates to trans->dirty
lack any serialization so it's quite unreliable anyway.

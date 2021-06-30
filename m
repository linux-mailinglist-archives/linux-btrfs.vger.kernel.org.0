Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837B13B88E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 21:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhF3TCo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 15:02:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33162 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbhF3TCl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 15:02:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 549391FEE4;
        Wed, 30 Jun 2021 19:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625079611;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H/NRxJ3qkpsFTtWU+micFrlScP9YbvKOPOJlLTNx3Hs=;
        b=eb3/b6wOiGxvti7dB9XKmYBjLPmXtKzxLDG9RhegyMWJw6ggVUZiwCkMfNQ3S4b+ZjHuJc
        2S5/vZuJrxz56Vf9/oof7SJTqBrIJJkTC5Qsmb35MongY0Q1portwPwWySAQ6gLF/snVOi
        7oJLjWpYo48QVtE1/K1tFir9HuzCKYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625079611;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H/NRxJ3qkpsFTtWU+micFrlScP9YbvKOPOJlLTNx3Hs=;
        b=z5GGAMHgkXyLdBkle9QTLjsapdQ4Lgeus+Mc8hqwykMtYjMaENdaLjU/PJDPNlUedqQwow
        bA2Iw3616GJ8CaCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4DB43A3B85;
        Wed, 30 Jun 2021 19:00:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2E759DA6FD; Wed, 30 Jun 2021 20:57:41 +0200 (CEST)
Date:   Wed, 30 Jun 2021 20:57:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/3] btrfs: commit the transaction unconditionally for
 ensopc
Message-ID: <20210630185741.GS2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1623421213.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623421213.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 11, 2021 at 10:23:07AM -0400, Josef Bacik wrote:
> Hello,
> 
> While debugging early ENOSPC issues in the Facebook fleet I hit a case where we
> weren't committing the transaction because of some patch that I hadn't
> backported to our kernel.
> 
> This made me think really hard about why we have may_commit_transaction, and
> realized that it doesn't make sense in it's current form anymore.  By-in-large
> it just exists to have bugs in it and cause us pain.  It served a purpose in the
> pre-ticketing days, but now just exists to be a giant pain in the ass.
> 
> So rip it out.  Just commit the transaction.  This also allows us to drop the
> logic for ->total_bytes_pinned, which Nikolay noticed a problem with earlier
> this week again.  Thanks,
> 
> Josef Bacik (3):
>   btrfs: rip out may_commit_transaction
>   btrfs: rip the first_ticket_bytes logic from fail_all_tickets
>   btrfs: rip out ->total_bytes_pinned

For the record, this has been picked before merge and is now in 5.14-rc.

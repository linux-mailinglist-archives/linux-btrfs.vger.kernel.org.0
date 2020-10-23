Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465A1297566
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 18:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751589AbgJWQ6A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 12:58:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:34396 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S461384AbgJWQ6A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 12:58:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C78C7AB95;
        Fri, 23 Oct 2020 16:57:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 65831DA7F1; Fri, 23 Oct 2020 18:56:26 +0200 (CEST)
Date:   Fri, 23 Oct 2020 18:56:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     dsterba@suse.com, a.darwish@linutronix.de,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] btrfs: convert data_seqcount to seqcount_mutex_t
Message-ID: <20201023165626.GK6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Davidlohr Bueso <dave@stgolabs.net>,
        dsterba@suse.com, a.darwish@linutronix.de,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
References: <20201021201724.27213-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021201724.27213-1-dave@stgolabs.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 21, 2020 at 01:17:24PM -0700, Davidlohr Bueso wrote:
> By doing so we can associate the sequence counter to the chunk_mutex
> for lockdep purposes (compiled-out otherwise) and also avoid
> explicitly disabling preemption around the write region as it will now
> be done automatically by the seqcount machinery based on the lock type.

Thanks, the enhanced seqlock is new to me and makes sense regarding
lockdep. I've added a comment to mention the mutex association and added
it to misc-next.

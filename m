Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B5F3B82C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 15:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbhF3NVk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 09:21:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41604 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbhF3NVk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 09:21:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BAE5222517;
        Wed, 30 Jun 2021 13:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625059150;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gYZGXxqO/nkDgpOJ95M+sZsLfp17MyPzZb3pMKA4Yvc=;
        b=nq1JqcTDVRhhGuNu+bbF8yR51C9QEBkgZXCCHkVzlOzg471S5v2kaCTJcRxX48Cks7FgRY
        XW5DuoCpRa/l7rGwjMdFB0hp2FVdu1NnY8g+IwgvolN2aQZXHhSCcevgDoLCdbpe7wUfC3
        zfFvqjVvlCmtDPT1IXQiJWdPALi4Wb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625059150;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gYZGXxqO/nkDgpOJ95M+sZsLfp17MyPzZb3pMKA4Yvc=;
        b=wB9wVyrgBvfh3YiPYrleqwhnoi1tlEI7Gvt3ovZZYEdoIDMxSbNzxBwbnksXROA202aouT
        pTuBfjrZgM+/vLBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B46E5A3B8F;
        Wed, 30 Jun 2021 13:19:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B4717DA7A2; Wed, 30 Jun 2021 15:16:40 +0200 (CEST)
Date:   Wed, 30 Jun 2021 15:16:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: allow BTRFS_IOC_SNAP_DESTROY_V2 to remove
 ghost subvolume
Message-ID: <20210630131640.GM2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210628101637.349718-1-wqu@suse.com>
 <20210628101637.349718-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628101637.349718-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 28, 2021 at 06:16:37PM +0800, Qu Wenruo wrote:
> There is a report from the mail list that some subvolumes don't have any
> ROOT_REF/BACKREF and has 0 ref.
> But without an ORPHAN item.

Do you have link to the mail report?

> Such ghost subvolumes can't be deleted by any ioctl but only rely on
> btrfs-progs to add ORPHAN item.

Is there a way to list such subvolumes from progs?
> 
> Normally kernel only needs to gracefully abort/reject such corrupted
> structure, but in this case we have all the needed infrastructures and
> interface to allow BTRFS_IOC_SNAP_DESTROY_V2 to delete it.
> 
> So add the ability to delete such ghost subvolumes to
> BTRFS_IOC_SNAP_DESTROY_V2.

So this is only extending the functionality and we don't need to handle
backward compatibility.

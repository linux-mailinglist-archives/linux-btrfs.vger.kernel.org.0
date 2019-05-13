Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65AB21BC26
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 19:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfEMRqJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 13:46:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:45552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726669AbfEMRqI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 13:46:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F09E5AD33;
        Mon, 13 May 2019 17:46:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B1104DA851; Mon, 13 May 2019 19:47:07 +0200 (CEST)
Date:   Mon, 13 May 2019 19:47:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix kobject error path memleaks
Message-ID: <20190513174707.GH3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, "Tobin C. Harding" <tobin@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190513033912.3436-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513033912.3436-1-tobin@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 13, 2019 at 01:39:10PM +1000, Tobin C. Harding wrote:
> Is it ok to send patches during the merge window?

Yes (depends on subsystem), the feedback for patches that are not fixes
could be delayed after the merge window closes.

> Applies on top of
> Linus' mainline tag: v5.1, happy to rebase if there are conflicts.
> 
> While auditing kobject_init_and_add() calls throughout the kernel it was
> found that btrfs potentially has a couple of memleaks in the error path
> code for kobject_init_and_add().
> 
> Failing calls to kobject_init_and_add() should be followed by a call to
> kobject_put() since kobject_init_and_add() always calls kobject_init().
> 
> Of note, adding kobject_put() causes the release method to be called if
> kobject_init_and_add() fails.  For patch #1 this means we don't have to
> manually free the space_info or call percpu_counter_destroy() since
> these are both done by the release method.  In the second patch, I
> believe the added call to kobject_put() fits in with the fs_devices
> lifecycle assumptions of open_ctree() but please could you review since
> I am new to this code.

We use the cleanup-after-error pattern where it's up to the callee to
clean up, so it's right to do it like as you did. Patches added to the
queue that's for 5.2-rcX. Thanks.

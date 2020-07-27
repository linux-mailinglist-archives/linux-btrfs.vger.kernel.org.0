Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFE922F2AA
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 16:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgG0OIB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 10:08:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:48556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbgG0OH7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 10:07:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60EDBAE47;
        Mon, 27 Jul 2020 14:08:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D36F6DA701; Mon, 27 Jul 2020 16:07:29 +0200 (CEST)
Date:   Mon, 27 Jul 2020 16:07:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: fix root leak printk to use %lld instead of
 %llu
Message-ID: <20200727140729.GM3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200722160722.8641-1-josef@toxicpanda.com>
 <20200722160722.8641-2-josef@toxicpanda.com>
 <20200723142041.GD3703@twin.jikos.cz>
 <ce52445d-b104-252c-005f-9bc13b2141d7@gmx.com>
 <20200727140314.GL3703@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727140314.GL3703@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 27, 2020 at 04:03:14PM +0200, David Sterba wrote:
> On Fri, Jul 24, 2020 at 08:40:17AM +0800, Qu Wenruo wrote:
> > Nope. We won't have that many roots.
> > 
> > In fact, for subvolumes, the highest id is only 2 ^ 48, an special limit
> > introduced for qgroup.
> 
> It's not a hard limit and certainly can have subvolumes with numbers
> that high. That qgoups interpret the qgroup in some way is not a
> limitation on subvolumes. We'll have to start reusing the subvolume ids
> eventually, with qgroups we can on.

Let me rephrase without the typos:

It's not a hard limit and we certainly can have subvolumes with numbers
that high. That qgroups interpret the qgroup id in some way is not a
limitation on subvolumes. We'll have to start reusing the subvolume ids
eventually, when qgroups are turned on.

(The comment about 2^32/2^48 was incorrect.)

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0DF328CD3
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Mar 2021 20:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbhCAS7o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Mar 2021 13:59:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:38994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236762AbhCAS52 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Mar 2021 13:57:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24E04AD57;
        Mon,  1 Mar 2021 18:56:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7CF02DA7AA; Mon,  1 Mar 2021 19:54:52 +0100 (CET)
Date:   Mon, 1 Mar 2021 19:54:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6/6] btrfs: Simplify code flow in
 btrfs_delayed_inode_reserve_metadata
Message-ID: <20210301185452.GA7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210222164047.978768-1-nborisov@suse.com>
 <20210222164047.978768-7-nborisov@suse.com>
 <20210301161532.GV7604@twin.jikos.cz>
 <7129f1a4-ba72-c35e-7a77-0ead54f7fede@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7129f1a4-ba72-c35e-7a77-0ead54f7fede@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 01, 2021 at 06:20:29PM +0200, Nikolay Borisov wrote:
> 
> 
> On 1.03.21 г. 18:15 ч., David Sterba wrote:
> > On Mon, Feb 22, 2021 at 06:40:47PM +0200, Nikolay Borisov wrote:
> >> btrfs_block_rsv_add can return only ENOSPC since it's called with
> >> NO_FLUSH modifier. This so simplify the logic in
> >> btrfs_delayed_inode_reserve_metadata to exploit this invariant.
> > 
> > This seems quite fragile, it's not straightforward to see from the
> > context that the NO_FLUSH code will always return ENOSPC. I followed a
> > few calls down from btrfs_block_rsv_add and it's well hidden inside
> > __reserve_bytes. So in case it's an invariant I'd rather add an
> > assertion, ie. ASSERT(ret == 0 || ret == -ENOSPC) so at least we know
> > when this gets broken. Otherwise looks ok.
> 
> Fair enough, I'm fine with it. In any case we no longer return eagain
> when reserving. either we succeed or we return ENOSPC - either because
> we don't have space and we can't flush or because even after the
> flushing machinery did its work a ticket still couldn't be satisfied, in
> which case we failed it hence ENOSPC got returned.

Yeah but this is a precaution when somebody reworks the flushing logic
yet another time and suddenly EAGAIN or whatever else can become the
return code again. Hunting such bugs can be quite difficult as it
depends on the runtime state and the space stat on disk etc.

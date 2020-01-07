Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 748CD132FC3
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 20:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgAGToq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 14:44:46 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:34667 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGTop (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 14:44:45 -0500
Received: from webmail.gandi.net (webmail19.sd4.0x35.net [10.200.201.19])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPA id 68C77C0008;
        Tue,  7 Jan 2020 19:44:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 Jan 2020 22:44:43 +0300
From:   Cengiz Can <cengiz@kernel.wtf>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] fs: btrfs: prevent unintentional int overflow
In-Reply-To: <20200107160124.GY3929@twin.jikos.cz>
References: <20200103184739.26903-1-cengiz@kernel.wtf>
 <20200106155328.GK3929@twin.jikos.cz>
 <16f809ac7e8.2bfa.85c738e3968116fc5c0dc2de74002084@kernel.wtf>
 <20200107160124.GY3929@twin.jikos.cz>
Message-ID: <41f24d3d838e66cd4d1746916905bcb6@kernel.wtf>
X-Sender: cengiz@kernel.wtf
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello David!

On 2020-01-07 19:01, David Sterba wrote:
> It's not a runtime overhead but typecasts should not be needed in
> general and when there's one it should be there for a reason. Sometimes
> it's apparent and does not need a comment to explain why but otherwise 
> I
> see it as "overhead" when reading the code. Lots of calculations done 
> in
> btrfs fit perfectly to 32bit, eg. the b-tree node or page-related ones.
> Where it matters is eg. conversion from/to bio::bi_sector to/from btrfs
> logical addresses that are u64, where the interface type is unsigned
> long and not a fixed width.

Thanks for sharing that. As I said, I'm relatively new to btrfs 
internals.

> The size constraints of the variables used in the reported expression
> are known to developers so I tend to think the typecast is not
> necessary.

Agreed.

> Maybe the static checker tool could be improved to know the
> invariants, that are eg. verified in fs/btrfs/disk-io.c:validate_super.

That's something that I will do some research on.

We can ignore this patch.

Thank you!

-- 
Cengiz Can
@cengiz_io

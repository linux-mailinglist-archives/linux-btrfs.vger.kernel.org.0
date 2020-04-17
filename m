Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0F31AE265
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 18:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDQQmH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 12:42:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:39936 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgDQQmG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 12:42:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 536E7AE21;
        Fri, 17 Apr 2020 16:42:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 13225DA727; Fri, 17 Apr 2020 18:41:24 +0200 (CEST)
Date:   Fri, 17 Apr 2020 18:41:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, nborisov@suse.com
Subject: Re: [PATCH v2 1/2] Btrfs: fix memory leak of transaction when
 deleting unused block group
Message-ID: <20200417164124.GS5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org, nborisov@suse.com
References: <20200417144012.9269-1-fdmanana@kernel.org>
 <20200417153615.23832-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417153615.23832-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 17, 2020 at 04:36:15PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When cleaning pinned extents right before deleting an unused block group,
> we check if there's still a previous transaction running and if so we
> increment its reference count before using it for cleaning pinned ranges
> in its pinned extents iotree. However we ended up never decrementing the
> reference count after using the transaction, resulting in a memory leak.
> 
> Fix it by decrementing the reference count.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Use btrfs_put_transaction() and not refcount_dec(), otherwise we are
>     not really releasing the memory used by the transaction in case its
>     refcount is 1. Stupid mistake.

I missed it too. As Nik pointed out on IRC, the API should be consistent
so that for put there's a get, or refcount_inc/refcount_dec. In this
case there's non-trivial work on the put side, so the wrappers make
sense.

A good example may be btrfs_get_block_group/btrfs_put_block_group, same
as for the transaction.

Trivial wrappers around plain _inc/_dec wouldn't be so great, but in
case there's eg refcount_dec_and_test + kfree, then I think this can be
considered a good pattern.

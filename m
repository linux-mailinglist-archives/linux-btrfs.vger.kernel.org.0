Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416472CF323
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Dec 2020 18:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgLDRbJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Dec 2020 12:31:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:33674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgLDRbI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Dec 2020 12:31:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9D5A1ADCA;
        Fri,  4 Dec 2020 17:30:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 04A73DA7E3; Fri,  4 Dec 2020 18:28:53 +0100 (CET)
Date:   Fri, 4 Dec 2020 18:28:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: don't try to wait flushing if we're
 already holding a transaction
Message-ID: <20201204172853.GX6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201204012448.26546-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204012448.26546-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 04, 2020 at 09:24:47AM +0800, Qu Wenruo wrote:
> There is a chance of racing for qgroup flushing which may lead to
> deadlock:
> 
> 	Thread A		|	Thread B
>    (no trans handler hold)	|  (already hold a trans handler)
> --------------------------------+--------------------------------
> __btrfs_qgroup_reserve_meta()   | __btrfs_qgroup_reserve_meta()
> |- try_flush_qgroup()		| |- try_flushing_qgroup()
>    |- QGROUP_FLUSHING bit set   |    |
>    |				|    |- test_and_set_bit()
>    |				|    |- wait_event()
>    |- btrfs_join_transaction()	|
>    |- btrfs_commit_transaction()|
> 
> 			!!! DEAD LOCK !!!
> 
> Since thread A want to commit transaction, but thread B is hold a
> transaction handler, blocking the commit.
> At the same time, thread B is waiting thread A to finish it commit.
> 
> This is just a hot fix, and would lead to more EDQUOT when we're near
> the qgroup limit.
> 
> The root fix would to make all metadata/data reservation to happen
> without a transaction handler hold.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.

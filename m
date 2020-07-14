Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A77121F387
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jul 2020 16:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgGNOKm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jul 2020 10:10:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:57518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgGNOKm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jul 2020 10:10:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7E22B04F;
        Tue, 14 Jul 2020 14:10:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2B1DADA790; Tue, 14 Jul 2020 16:10:18 +0200 (CEST)
Date:   Tue, 14 Jul 2020 16:10:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     trix@redhat.com
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs : fix memory leak in add_block_entry
Message-ID: <20200714141017.GQ3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, trix@redhat.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200707132908.10987-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707132908.10987-1-trix@redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 07, 2020 at 06:29:08AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis flags this error
> 
> fs/btrfs/ref-verify.c:290:3: warning: Potential leak of memory pointed to by 're' [unix.Malloc]
>                 kfree(be);
>                 ^~~~~
> The problem is in this block of code
> 
> 		if (root_objectid) {
> 			struct root_entry *exist_re;
> 
> 			exist_re = insert_root_entry(&exist->roots, re);
> 			if (exist_re)
> 				kfree(re);
> 		}
> 
> There is no 'else' block freeing when root_objectid == 0
> 
> So add an 'else'
> 
> Fixes: fd708b81d972 ("Btrfs: add a extent ref verify tool")
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Added to misc-next, thanks.

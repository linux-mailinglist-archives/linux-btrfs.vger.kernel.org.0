Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7913217643C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 20:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgCBTrn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 14:47:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:37250 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCBTrn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 14:47:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 67766AC6E;
        Mon,  2 Mar 2020 19:47:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B8622DA733; Mon,  2 Mar 2020 20:47:19 +0100 (CET)
Date:   Mon, 2 Mar 2020 20:47:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Rename __btrfs_alloc_chunk to btrfs_alloc_chunk
Message-ID: <20200302194719.GT2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200302102925.359-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302102925.359-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 02, 2020 at 12:29:25PM +0200, Nikolay Borisov wrote:
> Having btrfs_alloc_chunk doesn't bring any value since it
> encapsulates a lockdep assert and a call to find_next_chunk. Simply
> rename the internal __btrfs_alloc_chunk function to the public one
> and remove it's 2nd parameter as all callers always pass the return
> value of find_next_chunk. Finally, migrate the call to
> lockdep_assert_held so as to not lose the check.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.

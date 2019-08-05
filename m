Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2F6824A8
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 20:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfHESHJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 14:07:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:54616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728824AbfHESHJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 14:07:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9D5F8AC7F;
        Mon,  5 Aug 2019 18:07:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EF33FDABC7; Mon,  5 Aug 2019 20:07:40 +0200 (CEST)
Date:   Mon, 5 Aug 2019 20:07:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Hans van Kranenburg <hans@knorrie.org>
Cc:     linux-btrfs@vger.kernel.org,
        Hans van Kranenburg <hans.van.kranenburg@mendix.com>
Subject: Re: [PATCH] btrfs: clarify btrfs_ioctl_get_dev_stats padding
Message-ID: <20190805180740.GF28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Hans van Kranenburg <hans@knorrie.org>,
        linux-btrfs@vger.kernel.org,
        Hans van Kranenburg <hans.van.kranenburg@mendix.com>
References: <20190803213634.32736-1-hans@knorrie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190803213634.32736-1-hans@knorrie.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 03, 2019 at 11:36:34PM +0200, Hans van Kranenburg wrote:
> From: Hans van Kranenburg <hans.van.kranenburg@mendix.com>
> 
> In commit c11d2c236cc26 the get_dev_stats ioctl was added.
> 
> Shortly thereafter, in commit b27f7c0c150f7, the flags field was added.
> However, the calculation for unused padding space was not updated, which
> also invalidated the comment.
> 
> Clarify what happened to reduce confusion and wasted time for anyone
> implementing this.
> 
> Signed-off-by: Hans van Kranenburg <hans.van.kranenburg@mendix.com>

Reviewed-by: David Sterba <dsterba@suse.com>

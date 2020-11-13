Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3562F2B1F7E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgKMQED (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:04:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:33638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgKMQED (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:04:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81DA8ABD9;
        Fri, 13 Nov 2020 16:04:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 98698DA87A; Fri, 13 Nov 2020 17:02:19 +0100 (CET)
Date:   Fri, 13 Nov 2020 17:02:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: correctly deal with error updating inode when
 inserting inline extent
Message-ID: <20201113160219.GB6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <d3a62f4e2c8877427d5b80a454f89577b45726b4.1605208477.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3a62f4e2c8877427d5b80a454f89577b45726b4.1605208477.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 12, 2020 at 07:21:04PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When adding an inline extent, if the we failed to update the inode we must
> abort the transaction if the failure reason is not -ENOSPC, since we are
> now in an inconsistent state if that is the case. If the failure reason is
> -ENOSPC, we should not abort the transaction and we should set the return
> value to 1, so that we fallback to the normal writeback path, where we try
> to create a non-inline extent.
> 
> This used to be the case before my recent patch that has the subject:
> 
>   "btrfs: update the number of bytes used by an inode atomically"
> 
> But it clearly missed that error handling detail. So just fix that up so
> that the previous, and correct, behaviour is preserved.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> David, can you please fold this into the original patch?
> Thanks.

Folded, thanks.

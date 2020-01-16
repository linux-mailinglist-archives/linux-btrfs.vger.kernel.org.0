Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8D4E13DD1D
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 15:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgAPOMt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 09:12:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:56150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgAPOMt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 09:12:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 30920AA35;
        Thu, 16 Jan 2020 14:12:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B4A3FDA791; Thu, 16 Jan 2020 15:12:33 +0100 (CET)
Date:   Thu, 16 Jan 2020 15:12:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: always copy scrub arguments back to user space
Message-ID: <20200116141233.GW3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200116112920.30400-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116112920.30400-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 16, 2020 at 11:29:20AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If scrub returns an error we are not copying back the scrub arguments
> structure to user space. This prevents user space to know how much progress
> scrub has done if an error happened - this includes -ECANCELED which is
> returned when users ask for scrub to stop. A particular use case, which is
> used in btrfs-progs, is to resume scrub after it is canceled, in that case
> it relies on checking the progress from the scrub arguments structure and
> then use that progress in a call to resume scrub.
> 
> So fix this by always copying the scrub arguments structure to user space,
> overwriting the value returned to user space with -EFAULT only if copying
> the structure failed to let user space know that either that copying did
> not happen, and therefore the structure is stale, or it happened partially
> and the structure is probably not valid and corrupt due to the partial
> copy.
> 
> Reported-by: Graham Cobb <g.btrfs@cobb.uk.net>
> Link: https://lore.kernel.org/linux-btrfs/d0a97688-78be-08de-ca7d-bcb4c7fb397e@cobb.uk.net/
> Fixes: 06fe39ab15a6a4 ("Btrfs: do not overwrite scrub error with fault error in scrub ioctl")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to 5.5-rc queue, thanks.

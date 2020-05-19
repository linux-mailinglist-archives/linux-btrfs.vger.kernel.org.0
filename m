Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FD71D971E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 May 2020 15:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgESNHG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 May 2020 09:07:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:46530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbgESNHF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 May 2020 09:07:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 91078AF7F;
        Tue, 19 May 2020 13:07:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AC09ADA7AD; Tue, 19 May 2020 15:06:10 +0200 (CEST)
Date:   Tue, 19 May 2020 15:06:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Btrfs: include error on messages about failure to
 write space/inode caches
Message-ID: <20200519130610.GC18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200518163411.18660-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518163411.18660-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 18, 2020 at 05:34:11PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently the error messages logged when we fail to write a free space
> cache or an inode cache are not very useful as they don't mention what
> was the error. So include the error number in the messages.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

1 and 2 added to misc-next, thanks.

As the 2nd patch fixes a problem introduced in this dev cycle it's ok
push it as a regression fix. But as we're at rc6 I'd prefer to postpone
it for the merge window time, unless it's really annoying and hinders
testing.

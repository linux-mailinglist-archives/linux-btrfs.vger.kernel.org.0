Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDC9180CD4
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 01:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgCKAcz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 20:32:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:47946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbgCKAcz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 20:32:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 115B7B0B7;
        Wed, 11 Mar 2020 00:32:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 19216DA7A7; Wed, 11 Mar 2020 01:32:29 +0100 (CET)
Date:   Wed, 11 Mar 2020 01:32:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove block_rsv parameter from
 btrfs_drop_snapshot
Message-ID: <20200311003228.GB12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200310094351.23680-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310094351.23680-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 10, 2020 at 11:43:51AM +0200, Nikolay Borisov wrote:
> It's no longer used following 30d40577e322 ("btrfs: reloc: Also queue
> orphan reloc tree for cleanup to avoid BUG_ON()"), so just remove it.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.

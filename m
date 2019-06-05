Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAC02360AD
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2019 17:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfFEP7l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jun 2019 11:59:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:54996 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728516AbfFEP7l (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jun 2019 11:59:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8525CAF7D
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jun 2019 15:59:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F0337DA866; Wed,  5 Jun 2019 18:00:31 +0200 (CEST)
Date:   Wed, 5 Jun 2019 18:00:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Cleanup BTRFS_COMPAT_EXTENT_TREE_V0
Message-ID: <20190605160031.GB9896@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190529072723.31027-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529072723.31027-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 29, 2019 at 03:27:23PM +0800, Qu Wenruo wrote:
> BTRFS_COMPAT_EXTENT_TREE_V0 is introduced for a short time in kernel,
> and it's over 10 years ago.
> 
> Nowadays there should be no user for that feature, and kernel has remove
> this support in Jun, 2018. There is no need for btrfs-progs to support
> it.
> 
> This patch will remove EXTENT_TREE_V0 related code and replace those
> BUG_ON() to a more graceful error message.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Applied, thanks.

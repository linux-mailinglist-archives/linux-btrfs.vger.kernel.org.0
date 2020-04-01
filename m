Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2E119B4F8
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Apr 2020 19:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbgDAR5o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Apr 2020 13:57:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:53466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732121AbgDAR5n (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Apr 2020 13:57:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B532CAD57;
        Wed,  1 Apr 2020 17:57:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E82FBDA727; Wed,  1 Apr 2020 19:57:08 +0200 (CEST)
Date:   Wed, 1 Apr 2020 19:57:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: check: Sanitize the return value for qgroup
 error
Message-ID: <20200401175708.GX5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200330070159.50077-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330070159.50077-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 30, 2020 at 03:01:59PM +0800, Qu Wenruo wrote:
> [BUG]
> btrfs check can return strange return value for shell:
>  [Inferior 1 (process 48641) exited with code 0213]
> 					      ^^^^
> 
> [CAUSE]
> It's caused by the incorrect handling of qgroup error.
> 
> qgroup_report_ret can be -117 (-EUCLEAN), using that value with exit()
> can cause overflow, causing return value not properly recognized.
> 
> [FIX]
> Fix it by sanitize the return value to 0 or 1.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3433B29083B
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 17:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410009AbgJPPXb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 11:23:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:51632 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409697AbgJPPXb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 11:23:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1883FB7F6;
        Fri, 16 Oct 2020 15:23:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AB7B4DA7C3; Fri, 16 Oct 2020 17:22:01 +0200 (CEST)
Date:   Fri, 16 Oct 2020 17:22:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH] btrfs: Use round_down while calculating start position
 in btrfs_dirty_pages()
Message-ID: <20201016152201.GV6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20201014145545.10878-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014145545.10878-1-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 14, 2020 at 09:55:44AM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> round_down looks prettier than the bit mask operations.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

1 and 2 added to misc-next, thanks.

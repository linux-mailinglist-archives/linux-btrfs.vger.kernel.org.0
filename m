Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE334255E93
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Aug 2020 18:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgH1QHc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Aug 2020 12:07:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:47360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbgH1QHc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Aug 2020 12:07:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35B4CB032;
        Fri, 28 Aug 2020 16:08:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B9685DA6FD; Fri, 28 Aug 2020 18:06:21 +0200 (CEST)
Date:   Fri, 28 Aug 2020 18:06:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: remove the unused variable in
 check_chunks_and_extents_lowmem()
Message-ID: <20200828160621.GR28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200826004734.89905-1-wqu@suse.com>
 <20200826004734.89905-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826004734.89905-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 26, 2020 at 08:47:34AM +0800, Qu Wenruo wrote:
> The variable @root is only set but not utilized, while we only utilize
> @root1.
> 
> Replace @root1 with @root, then remove the @root1.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

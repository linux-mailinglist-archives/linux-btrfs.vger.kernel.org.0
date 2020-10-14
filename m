Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB3128E108
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Oct 2020 15:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbgJNNJz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Oct 2020 09:09:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:50940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbgJNNJy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Oct 2020 09:09:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B75F2AC4D;
        Wed, 14 Oct 2020 13:09:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A3DC6DA7C3; Wed, 14 Oct 2020 15:08:26 +0200 (CEST)
Date:   Wed, 14 Oct 2020 15:08:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH] btrfs: Calculate num_pages, reserve_bytes once in
 btrfs_buffered_write()
Message-ID: <20201014130826.GL6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20200925203638.28890-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925203638.28890-1-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 25, 2020 at 03:36:38PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Cleanup.
> 
> write_bytes can change in btrfs_check_nocow_lock(). Calculate variables
> such as num_pages and reserve_bytes once we are sure of the value of
> write_bytes so there is no need to re-calculate.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Added to misc-next, thanks.

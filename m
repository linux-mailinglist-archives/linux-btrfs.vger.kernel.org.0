Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7D9713135C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 15:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgAFOLA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 09:11:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:34392 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgAFOLA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 09:11:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1C9D8ADEB;
        Mon,  6 Jan 2020 14:10:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C4D95DA78B; Mon,  6 Jan 2020 15:10:49 +0100 (CET)
Date:   Mon, 6 Jan 2020 15:10:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove unnecessary wrapper get_alloc_profile
Message-ID: <20200106141049.GF3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
References: <20200102161457.20216-1-jth@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102161457.20216-1-jth@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 02, 2020 at 05:14:57PM +0100, Johannes Thumshirn wrote:
> btrfs_get_alloc_profile() is a simple wrapper over get_alloc_profile().
> The only difference is btrfs_get_alloc_profile() is visible to other
> functions in btrfs while get_alloc_profile() is static and thus only
> visible to functions in block-group.c.
> 
> Let's just fold get_alloc_profile() into btrfs_get_alloc_profile() to
> get rid of the unnecessary second function.
> 
> Signed-off-by: Johannes Thumshirn <jth@kernel.org>

Added to misc-next, thanks.

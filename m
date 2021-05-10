Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC8A379785
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 21:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhEJTTD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 15:19:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:45120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230466AbhEJTTD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 15:19:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5150DAED7;
        Mon, 10 May 2021 19:17:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 69F82DB228; Mon, 10 May 2021 21:15:28 +0200 (CEST)
Date:   Mon, 10 May 2021 21:15:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: let check_async_write return bool
Message-ID: <20210510191528.GZ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <ac35b9ba276cf4eefcf9641a19eaabae715f6d2d.1620659830.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac35b9ba276cf4eefcf9641a19eaabae715f6d2d.1620659830.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 11, 2021 at 12:17:26AM +0900, Johannes Thumshirn wrote:
> The 'check_async_write' function is a helper used in
> 'btrfs_submit_metadata_bio' and it checks if asynchronous writing can be
> used for metadata.
> 
> Make the function return bool and get rid of the local variable async in
> btrfs_submit_metadata_bio storing the result of check_async_write's tests.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

With the suggested name applied to misc-next, thanks.

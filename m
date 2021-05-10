Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B18379451
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 18:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhEJQoD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 12:44:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:33008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231420AbhEJQoB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 12:44:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC3B9B16D;
        Mon, 10 May 2021 16:42:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E537FDB226; Mon, 10 May 2021 18:40:26 +0200 (CEST)
Date:   Mon, 10 May 2021 18:40:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: let check_async_write return bool
Message-ID: <20210510164026.GW7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <ac35b9ba276cf4eefcf9641a19eaabae715f6d2d.1620659830.git.johannes.thumshirn@wdc.com>
 <daaa1507-8dc5-14fa-d588-856c1439b9f1@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <daaa1507-8dc5-14fa-d588-856c1439b9f1@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 10, 2021 at 07:29:39PM +0300, Nikolay Borisov wrote:
> 
> 
> On 10.05.21 г. 18:17, Johannes Thumshirn wrote:
> > The 'check_async_write' function is a helper used in
> > 'btrfs_submit_metadata_bio' and it checks if asynchronous writing can be
> > used for metadata.
> > 
> > Make the function return bool and get rid of the local variable async in
> > btrfs_submit_metadata_bio storing the result of check_async_write's tests.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Nit: Won't it make it more clear if the function is named
> "should_write_async" or something along those lines?

Yeah that sounds better and more consistent with other check_* or
should_* helpers.

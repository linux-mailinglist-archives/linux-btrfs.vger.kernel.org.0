Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102E9226367
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jul 2020 17:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgGTPeg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jul 2020 11:34:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:57474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgGTPeg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jul 2020 11:34:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC4A9AC24;
        Mon, 20 Jul 2020 15:34:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 47742DA781; Mon, 20 Jul 2020 17:34:10 +0200 (CEST)
Date:   Mon, 20 Jul 2020 17:34:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     robbieko <robbieko@synology.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix page leaks after failure to lock page for
 delalloc
Message-ID: <20200720153410.GG3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, robbieko <robbieko@synology.com>,
        linux-btrfs@vger.kernel.org
References: <20200720014209.11485-1-robbieko@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720014209.11485-1-robbieko@synology.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 20, 2020 at 09:42:09AM +0800, robbieko wrote:
> From: Robbie Ko <robbieko@synology.com>
> 
> When locking pages for delalloc, we check if it's dirty and mapping still
> matches, if it does not match, we will return -EAGAIN and release all
> pages.
> 
> Signed-off-by: Robbie Ko <robbieko@synology.com>

Nice catch, added to misc-next, thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABFE397E63
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 17:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfHUPRX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 11:17:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:56108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726371AbfHUPRX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 11:17:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6FCFBAEF6
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2019 15:17:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 25297DA7DB; Wed, 21 Aug 2019 17:17:48 +0200 (CEST)
Date:   Wed, 21 Aug 2019 17:17:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/6] btrfs: Streamline code in run_delalloc_nocow in case
 of inline extents
Message-ID: <20190821151747.GM18575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190805144708.5432-1-nborisov@suse.com>
 <20190805144708.5432-5-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805144708.5432-5-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 05, 2019 at 05:47:06PM +0300, Nikolay Borisov wrote:
> The extent range check right after the "out_check" label is redundant,
> because the only way it can trigger is if we have an inline extent. In
> this case it makes more sense to actually move it in the branch
> explictly dealing with inlines extents. What's more, the nested
> 'if (nocow)' can never be true because for inline extents we always do
> CoW and there is no chance 'noco' can be true, just remove that check.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

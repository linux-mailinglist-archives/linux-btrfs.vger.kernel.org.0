Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80CED84B9D
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 14:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfHGM3k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 08:29:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:43304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729722AbfHGM3g (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Aug 2019 08:29:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF77FAC51;
        Wed,  7 Aug 2019 12:29:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AFAA2DA7D7; Wed,  7 Aug 2019 14:30:06 +0200 (CEST)
Date:   Wed, 7 Aug 2019 14:30:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: trim: Check the range passed into to prevent
 overflow
Message-ID: <20190807123006.GR28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190528082154.6450-1-wqu@suse.com>
 <8c3ba53e-7718-514a-2d1a-765e84e0a75d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c3ba53e-7718-514a-2d1a-765e84e0a75d@gmx.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 07, 2019 at 08:03:41PM +0800, Qu Wenruo wrote:
> Gentle ping?
> 
> Thanks to the discussion with Anand, I find this patch is not merged yet.

I had the patch marked as dropped as it was during the trim range
changes. Reading the discussion again it's ok to merge and I'll add it
to the queue.

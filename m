Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE027FB98
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 15:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbfHBN4G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 09:56:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:36182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730204AbfHBN4G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Aug 2019 09:56:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9738DAEF1;
        Fri,  2 Aug 2019 13:56:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0C836DADC0; Fri,  2 Aug 2019 15:56:38 +0200 (CEST)
Date:   Fri, 2 Aug 2019 15:56:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/25] btrfs: migrate the block group code
Message-ID: <20190802135638.GW28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
References: <20190620193807.29311-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 20, 2019 at 03:37:42PM -0400, Josef Bacik wrote:
> This is the series to migrate the block group code out of extent-tree.c.  This
> is a much larger series than the previous two series because things were much
> more intertwined than block_rsv's and space_info.  There is one code change
> patch in this series, it is
> 
> btrfs: make caching_thread use btrfs_find_next_key

I've merged 1-10 (ie. up to the patch mentioned above) as it applied
cleanly on current misc-next, the rest produced some conflicts.

Although most of the code is moving from a file to file, I fixed the
coding style as this is the perfect opportunity to update code that does
not change often.

If you're going to send more patchsets like that, please do another pass
after copy&paste of the code. Also note that the SPDX header in new .c
files uses the weird // comments, unlike headers that use /* */ .

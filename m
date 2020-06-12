Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251751F78CB
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 15:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgFLNeH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 09:34:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:44086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgFLNeG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 09:34:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 28B6AACCC;
        Fri, 12 Jun 2020 13:34:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1D69BDA7C3; Fri, 12 Jun 2020 15:33:57 +0200 (CEST)
Date:   Fri, 12 Jun 2020 15:33:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Greed Rong <greedrong@gmail.com>
Subject: Re: [PATCH] btrfs: Share the same anonymous block device for the
 whole filesystem
Message-ID: <20200612133357.GT27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Greed Rong <greedrong@gmail.com>
References: <20200612064237.13439-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612064237.13439-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 12, 2020 at 02:42:37PM +0800, Qu Wenruo wrote:
> Currently btrfs uses unique anonymous block device for each root, which
> sometimes can be overkilled, especially considering how lightweight
> btrfs snapshot is.

In my understanding the subvolumes must have a unique anon bdev
associated, to appear as different inode number namespaces. This goes
back to the beginning and we can't change that. See 3394e1607eaf870eb.

> Although this brings a big user visible interface change, before this
> patch each subvolume has its own bdev for stat(), now all subvolumes
> shares the same bdev.
> I'm not sure how many users will be affected.

A 'big user visible interface change' should be a strong sign to do the
research first before writing the code.

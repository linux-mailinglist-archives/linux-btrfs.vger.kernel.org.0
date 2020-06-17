Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC041FD1E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 18:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgFQQW6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 12:22:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:41890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgFQQW6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 12:22:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 919E3B06B;
        Wed, 17 Jun 2020 16:23:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C167CDA728; Wed, 17 Jun 2020 18:22:46 +0200 (CEST)
Date:   Wed, 17 Jun 2020 18:22:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: Remove hole  check in
 prealloc_file_extent_cluster
Message-ID: <20200617162246.GO27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200617091044.27846-1-nborisov@suse.com>
 <20200617091044.27846-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617091044.27846-2-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 17, 2020 at 12:10:42PM +0300, Nikolay Borisov wrote:
> Extents in the extent cluster are guaranteed to be contiguous as such
> the hole check inside the loop can never trigger. In fact this check
> was never functional since it was added in 18513091af948 which came
> after the commit introducing clustered/contiguous extents: 0257bb82d21b.

Please use full commit references like 18513091af94 ("btrfs: update
btrfs_space_info's bytes_may_use timely").

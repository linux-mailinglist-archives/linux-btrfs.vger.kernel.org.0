Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95149E219B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 19:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfJWRRD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 13:17:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:40188 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727079AbfJWRRD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 13:17:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BFDACAFF1;
        Wed, 23 Oct 2019 17:17:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0B997DA734; Wed, 23 Oct 2019 19:17:13 +0200 (CEST)
Date:   Wed, 23 Oct 2019 19:17:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove btrfs_bio::flags member
Message-ID: <20191023171713.GE3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191023070447.6899-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023070447.6899-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 03:04:47PM +0800, Qu Wenruo wrote:
> This member is not used by any one, just remove it.

What's the patch that removed the last use? This should be in patches
that remove struct members. Otherwise good, every byte removed counts.

I've briefly checked 'void *private', but looks like it can be removed
as well, it's holds bi_private of the first_bio (btrfs_map_bio) and it's
read in btrfs_end_bbio, but bbio is accessible and so bbio->private is
bbio->orig_bio->bi_private.

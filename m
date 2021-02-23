Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2CE322BE4
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 15:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhBWOEx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Feb 2021 09:04:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:40244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232461AbhBWOEN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Feb 2021 09:04:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BEDF2ADDB;
        Tue, 23 Feb 2021 14:03:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 781B7DA7AA; Tue, 23 Feb 2021 15:01:29 +0100 (CET)
Date:   Tue, 23 Feb 2021 15:01:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Unlock extents in btrfs_zero_range in case of
 errors
Message-ID: <20210223140129.GV1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210223132042.1198894-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223132042.1198894-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 23, 2021 at 03:20:42PM +0200, Nikolay Borisov wrote:
> If btrfs_qgroup_reserve_data returns an error (i.e quota limit reached)
> the handling logic directly goes to the 'out' label without first
> unlocking the extent range between lockstart, lockend. This results in
> deadlocks as processes try to lock the same extent.
> 
> Fixes: a7f8b1c2ac21 ("btrfs: file: reserve qgroup space after the hole punch range is locked")
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.

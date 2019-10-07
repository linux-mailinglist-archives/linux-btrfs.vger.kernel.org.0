Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45470CE9A7
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 18:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfJGQqY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 12:46:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:54622 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728976AbfJGQqX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 12:46:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D61DAC38;
        Mon,  7 Oct 2019 16:46:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6795FDA7FB; Mon,  7 Oct 2019 18:46:37 +0200 (CEST)
Date:   Mon, 7 Oct 2019 18:46:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: tree-checker: False alerts fixes for log trees
Message-ID: <20191007164637.GH2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191004093133.83582-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004093133.83582-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 04, 2019 at 05:31:30PM +0800, Qu Wenruo wrote:
> There is a false alerts of tree-checker when running fstests/btrfs/063
> in a loop.
> 
> The bug is caused by commit 59b0d030fb30 ("btrfs: tree-checker: Try to detect
> missing INODE_ITEM").
> For the full error analyse, please check the first patch.
> 
> The first patch will give it a quick fix, so that it can be addressed in
> v5.4 release cycle.
> 
> The 2nd patch is a more proper patch, with refactor to reduce duplicated
> code and add the check to INODE_REF item.
> But it's pretty large (+72, -41), not sure if it's suitbale for late
> -rc.
> 
> Also current write-time tree checker error message is too silent, can't
> be caught by fstests nor a quick glance of dmesg. And it doesn't contain
> enough info to debug.
> 
> So to enhance the error message, and make it more noisy, the 3rd patch
> will enhance the error message.
> 
> Qu Wenruo (3):
>   btrfs: tree-checker: Fix false alerts on log trees
>   btrfs: tree-checker: Refactor prev_key check for ino into a function
>   btrfs: Enhance the error outputting for write time tree checker

Patch 1 folded to the original patch and 2 and 2 now in misc-next,
thanks.

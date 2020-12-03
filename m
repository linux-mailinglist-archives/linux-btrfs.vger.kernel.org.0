Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F292CDB61
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 17:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbgLCQgJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 11:36:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:45152 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727996AbgLCQgJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 11:36:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0E81DAC2E;
        Thu,  3 Dec 2020 16:35:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 13F18DA6E9; Thu,  3 Dec 2020 17:33:55 +0100 (CET)
Date:   Thu, 3 Dec 2020 17:33:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: Remove logic for !crc_check case
Message-ID: <20201203163354.GQ6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201203080949.3759006-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203080949.3759006-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 03, 2020 at 10:09:48AM +0200, Nikolay Borisov wrote:
> Following removal of the ino cache io_ctl_init will be called only on
> behalf of the freespace inode. In this case we always want to check
> crcs so conditional code that dependen on io_ctl::check_crc can be
> removed.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> David,
> 
> Here are 2 patches that followup based on your feedback of the ino removal
> feature, I have run a full xfstest run to validate them.

Thanks, added after the ino removal in misc-next.

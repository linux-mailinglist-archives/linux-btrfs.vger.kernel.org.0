Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA232D6173
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 17:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387749AbgLJQP7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 11:15:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:33502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733260AbgLJQP6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 11:15:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 16ED5AF1F;
        Thu, 10 Dec 2020 16:15:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7FAFCDA842; Thu, 10 Dec 2020 17:13:40 +0100 (CET)
Date:   Thu, 10 Dec 2020 17:13:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: cmd-subvolume: set subvol_path to NULL
 after free
Message-ID: <20201210161340.GE6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org
References: <20201207090755.16161-1-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207090755.16161-1-l@damenly.su>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 07, 2020 at 05:07:55PM +0800, Su Yue wrote:
> User reported that `btrfs subvolume show -u -- /mnt` causes double free.
> 
> 
> Pointer subovl_path was freed in iterations but still keeps old value.
> In the last iteration, error BTRFS_UTIL_ERROR_STOP_ITERATION returned,
> then the double free of subvol_path happens in the out goto label.
> 
> Set subvol_path to NULL after each free() in the loop to fix the issue.
> 
> Links: https://github.com/kdave/btrfs-progs/issues/317
> Signed-off-by: Su Yue <l@damenly.su>

Thanks, added to devel.

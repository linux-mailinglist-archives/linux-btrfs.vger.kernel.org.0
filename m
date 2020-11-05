Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342F92A89FE
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 23:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbgKEWif (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 17:38:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:35510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732035AbgKEWie (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 17:38:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BDC17AB8F;
        Thu,  5 Nov 2020 22:38:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BD83ADA6E3; Thu,  5 Nov 2020 23:36:54 +0100 (CET)
Date:   Thu, 5 Nov 2020 23:36:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Nikolay Borisov <nborisov@suse.com>, wqu@suse.com
Subject: Re: [PATCH RESEND v2 1/3] btrfs: drop never met condition of
 disk_total_bytes == 0
Message-ID: <20201105223654.GO6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Nikolay Borisov <nborisov@suse.com>, wqu@suse.com
References: <cover.1604372688.git.anand.jain@oracle.com>
 <682907bcd58ffeece1a76c6ec3b866139a6381bd.1604372689.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <682907bcd58ffeece1a76c6ec3b866139a6381bd.1604372689.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 03, 2020 at 01:49:42PM +0800, Anand Jain wrote:
> btrfs_device::disk_total_bytes is set even for a seed device (the
> comment is wrong).

That's where I'm a bit lost. It was added in 1b3922a8bc74 ("btrfs: Use
real device structure to verify dev extent").

> The function fill_device_from_item() does the job of reading it from the
> item and updating btrfs_device::disk_total_bytes. So both the missing
> device and the seed devices do have their disk_total_bytes updated.
> 
> Furthermore, while removing the device if there is a power loss, we could
> have a device with its total_bytes = 0, that's still valid.

Ok, that's the condition that the commit mentioned above used to detect
the device and to avoid doing the tree-checker verification.

> So this patch removes the check dev->disk_total_bytes == 0 in the
> function verify_one_dev_extent(), which it does nothing in it.

Removing a check that supposedly does notghing, but the referenced
commit says otherwise.

> And take this opportunity to introduce a check if the device::total_bytes
> is more than the max device size in read_one_dev().

If this is not related to the the check removal, then it should be an
independent patch explaing in full what is being fixed. As I read it
this should be independent as it's checking the upper bound.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBFE4557C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 10:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243210AbhKRJPu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 04:15:50 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56550 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245010AbhKRJPj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 04:15:39 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0E5B51FD29;
        Thu, 18 Nov 2021 09:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637226758;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kw6ZxJNkxKjdGq1ChNnyoww3nrYBTnlHXQuQRVD7rXw=;
        b=JgBPMIiD7x+8hpIn/A+DixORmwkYzr8HNj99UcPfUMHiQ/FH7+pINfFB+eJ6mtXSQU9DfT
        rp1YKiSAm+7Z7mlHU9ZWVU6DSLKyd8kFPTOfInw+G8M+Q2Z99qQFbqT8XKu2Wzd7HA1VXe
        +Rfhpc0POY0ZlEkNhIZYzNvs7L893Go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637226758;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kw6ZxJNkxKjdGq1ChNnyoww3nrYBTnlHXQuQRVD7rXw=;
        b=AH/dnhZRfOv7DoCEbkWfwQY5D47d7bQYMSDFxUBC7bgpyf2330uaMVqT989zc5uNzxGQRn
        WSMvrpPNcJs9VfDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 073C0A3B85;
        Thu, 18 Nov 2021 09:12:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B25CBDA799; Thu, 18 Nov 2021 10:12:33 +0100 (CET)
Date:   Thu, 18 Nov 2021 10:12:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Fix calculation of chunk size for RAID1/DUP profiles
Message-ID: <20211118091233.GW28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211116140206.291252-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116140206.291252-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 16, 2021 at 04:02:06PM +0200, Nikolay Borisov wrote:
> Current formula calculates the stripe size, however that's not what we want
> in the case of RAID1/DUP profiles. In those cases since chunkc are mirrored
> across devices we want the full size of the chunk. Without this patch the
> 'btrfs fi usage' output from an fs which is using RAID1 is:
> 
> 	<snip>
> 
> 	Data,RAID1: Size:2.00GiB, Used:1.00GiB (50.03%)
> 	   /dev/vdc	   1.00GiB
> 	   /dev/vdf	   1.00GiB
> 
> 	Metadata,RAID1: Size:256.00MiB, Used:1.34MiB (0.52%)
> 	   /dev/vdc	 128.00MiB
> 	   /dev/vdf	 128.00MiB
> 
> 	System,RAID1: Size:8.00MiB, Used:16.00KiB (0.20%)
> 	   /dev/vdc	   4.00MiB
> 	   /dev/vdf	   4.00MiB
> 
> 	Unallocated:
> 	   /dev/vdc	   8.87GiB
> 	   /dev/vdf	   8.87GiB
> 
> 
> So a 2 gigabyte RAID1 chunk actually will take up 4 gigabytes on the actual disks
> 2 each. In this case this is being miscalculated as taking up 1gb on each device.
> 
> This also leads to erroneously calculated unallocated space. The correct output
> in this case is:
> 
> 	<snip>
> 
> 	Data,RAID1: Size:2.00GiB, Used:1.00GiB (50.03%)
> 	   /dev/vdc	   2.00GiB
> 	   /dev/vdf	   2.00GiB
> 
> 	Metadata,RAID1: Size:256.00MiB, Used:1.34MiB (0.52%)
> 	   /dev/vdc	 256.00MiB
> 	   /dev/vdf	 256.00MiB
> 
> 	System,RAID1: Size:8.00MiB, Used:16.00KiB (0.20%)
> 	   /dev/vdc	   8.00MiB
> 	   /dev/vdf	   8.00MiB
> 
> 	Unallocated:
> 	   /dev/vdc	   7.74GiB
> 	   /dev/vdf	   7.74GiB
> 
> 
> Fix it by only utilising the chunk formula for profiles which are not RAID1/DUP.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to devel, thanks.

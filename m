Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF71D31FEA1
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 19:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhBSSOe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 13:14:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:44024 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhBSSO2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 13:14:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EEDBFABAE;
        Fri, 19 Feb 2021 18:13:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 80E5EDA6FC; Fri, 19 Feb 2021 19:11:49 +0100 (CET)
Date:   Fri, 19 Feb 2021 19:11:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH v3] btrfs-progs: filesystem-resize: make output more
 readable
Message-ID: <20210219181149.GI1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20210219171818.10170-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219171818.10170-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 19, 2021 at 05:18:18PM +0000, Sidong Yang wrote:
> This patch make output of filesystem-resize command more readable and
> give detail information for users. This patch provides more information
> about filesystem like below.
> 
> Before:
> Resize '/mnt' of '1:-1G'
> 
> After:
> Resize device id 1 (/dev/vdb) from 4.00GiB to 3.00GiB
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Code-wise it looks good, but I tried a simple test and it does not work:

# truncate -s 4g image
# mkfs.btrfs image
# mount -o loop image mnt
# btrfs fi resize -1G mnt
ERROR: cannot find devid: 0

while running the same command with the installed system 'btrfs' resizes
the fs: "Resize '.' of '-1G'".

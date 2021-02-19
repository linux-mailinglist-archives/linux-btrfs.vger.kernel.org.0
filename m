Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417E931FB64
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 15:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhBSOvw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 09:51:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:60892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhBSOu4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 09:50:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E46F2ACBF;
        Fri, 19 Feb 2021 14:50:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 83CD3DA6EF; Fri, 19 Feb 2021 15:48:17 +0100 (CET)
Date:   Fri, 19 Feb 2021 15:48:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz, kernel-team@fb.com
Subject: Re: [PATCH 0/3] btrfs-progs: rescue: Add create-control-device
 subcommand
Message-ID: <20210219144817.GD1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Daniel Xu <dxu@dxuuu.xyz>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1604013169.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1604013169.git.dxu@dxuuu.xyz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 29, 2020 at 04:17:35PM -0700, Daniel Xu wrote:
> This patchset adds a new `btrfs rescue create-control-device` subcommand
> that acts as a convenient way to invoke:
> 
> 	# mknod --mode=600 c 10 234 /dev/btrfs-control
> 
> on systems that don't have `mknod` installed or when you're lazy.

Well, I don't think the part 'lazy' applies.

The whole thing with the control device is simpler that I originally
thought. On a system without loaded btrfs module there's no
/dev/btrfs-control. This is correct because the device node is created
at load time or when btrfs_interface_init is called.

Creating just the device node makes no sense because there's nothing
handling it. Once module is loaded it appears and works as expected.

The only case where the rescue command makes sense is when the module is
loaded, device node creatd and then manually deleted. This is possible
but highly unlikely. For that reason the rescue command still has some
sense but the reasoning needs to reflect how it's related to the module
status.

As this is docs update only, I'll fix that myself, no need to resend.

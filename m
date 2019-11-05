Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 913A3F0382
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2019 17:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfKEQ5A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Nov 2019 11:57:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:44980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727830AbfKEQzv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Nov 2019 11:55:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75662AC7B;
        Tue,  5 Nov 2019 16:55:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7080DDA796; Tue,  5 Nov 2019 17:55:56 +0100 (CET)
Date:   Tue, 5 Nov 2019 17:55:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH] btrfs: rename btrfs_block_group_cache
Message-ID: <20191105165556.GM3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <07674c79220c9f8fdb4588ad339a0af9515640cd.1572373079.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07674c79220c9f8fdb4588ad339a0af9515640cd.1572373079.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 29, 2019 at 07:20:18PM +0100, David Sterba wrote:
> The type name is misleading, a single entry is named 'cache' while this
> normally means a collection of objects. Rename that everywhere. Also the
> identifier was quite long, making function prototypes harder to format.
> 
> Suggested-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
> 
> To avoid conflicts with patches pending for the upcoming merge window,
> I'm going to apply it among the last ones.

No pending patches for 5.5 so I'm adding this one to misc-next.

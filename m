Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61163EC1C0
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2019 12:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfKAL10 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Nov 2019 07:27:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:38574 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfKAL10 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Nov 2019 07:27:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 477AEAD5C;
        Fri,  1 Nov 2019 11:27:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A724DDA783; Fri,  1 Nov 2019 12:27:33 +0100 (CET)
Date:   Fri, 1 Nov 2019 12:27:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Fix block groups read which may skip
 certain block groups
Message-ID: <20191101112733.GM3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191030072711.73858-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030072711.73858-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 30, 2019 at 03:27:11PM +0800, Qu Wenruo wrote:
> Previous patch "btrfs-progs: Refactor btrfs_read_block_groups()" lacks a
> fix which is in kernel counter part but not in btrfs-progs.
> 
> It doesn't reset the key.offset used to search next block group, thus
> btrfs-progs can skip certain block groups items.
> 
> This can fail fsck/039 test case.
> 
> Please fold this fix into that patch.

Folded, thanks.

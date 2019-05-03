Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA87131F6
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2019 18:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfECQRU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 May 2019 12:17:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:33072 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727226AbfECQRU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 May 2019 12:17:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA376AF1C;
        Fri,  3 May 2019 16:17:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AD615DA885; Fri,  3 May 2019 18:18:19 +0200 (CEST)
Date:   Fri, 3 May 2019 18:18:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: don't double unlock on error in btrfs_punch_hole
Message-ID: <20190503161818.GK20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190503151007.75525-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503151007.75525-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 03, 2019 at 11:10:06AM -0400, Josef Bacik wrote:
> If we have an error writing out a delalloc range in
> btrfs_punch_hole_lock_range we'll unlock the inode and then goto
> out_only_mutex, where we will again unlock the inode.  This is bad,
> don't do this.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.

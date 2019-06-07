Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05AF338BA9
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2019 15:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfFGNar (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jun 2019 09:30:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:55594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727862AbfFGNaq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Jun 2019 09:30:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C8A98AFBE
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2019 13:30:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 63BD1DA849; Fri,  7 Jun 2019 15:31:36 +0200 (CEST)
Date:   Fri, 7 Jun 2019 15:31:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] Extent buffer lock cleanups
Message-ID: <20190607133136.GD30187@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1559233731.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559233731.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 30, 2019 at 06:30:57PM +0200, David Sterba wrote:
> There are 3 atomics that don't need to be, all related to writes where
> the exclusivity is guaranteed by the lock.
> 
> David Sterba (3):
>   btrfs: switch extent_buffer blocking_writers from atomic to int
>   btrfs: switch extent_buffer spinning_writers from atomic to int
>   btrfs: switch extent_buffer write_locks from atomic to int
> 
>  fs/btrfs/extent_io.c  |  6 ++---
>  fs/btrfs/extent_io.h  |  6 ++---
>  fs/btrfs/locking.c    | 62 +++++++++++++++++++------------------------
>  fs/btrfs/print-tree.c |  6 ++---
>  4 files changed, 37 insertions(+), 43 deletions(-)

Added to misc-next.

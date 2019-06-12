Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7F894285D
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 16:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409199AbfFLOEw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 10:04:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:37982 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407368AbfFLOEw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 10:04:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E134CB01F;
        Wed, 12 Jun 2019 14:04:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8BF8BDA88C; Wed, 12 Jun 2019 16:05:41 +0200 (CEST)
Date:   Wed, 12 Jun 2019 16:05:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrea.parri@amarulasolutions.com, peterz@infradead.org,
        paulmck@linux.ibm.com
Subject: Re: [PATCH 1/2] btrfs: Implement DRW lock
Message-ID: <20190612140541.GL3563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrea.parri@amarulasolutions.com, peterz@infradead.org,
        paulmck@linux.ibm.com
References: <20190606135219.1086-1-nborisov@suse.com>
 <20190606135219.1086-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606135219.1086-2-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 06, 2019 at 04:52:18PM +0300, Nikolay Borisov wrote:
> A (D)ouble (R)eader (W)riter lock is a locking primitive that allows
> to have multiple readers or multiple writers but not multiple readers
> and writers holding it concurrently. The code is factored out from
> the existing open-coded locking scheme used to exclude pending
> snapshots from nocow writers and vice-versa. Current implementation
> actually favors Readers (that is snapshot creaters) to writers (nocow
> writers of the filesystem).
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/Makefile   |  2 +-
>  fs/btrfs/drw_lock.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/drw_lock.h | 23 +++++++++++++++

In v2, please use locking.[ch] instead of new files.

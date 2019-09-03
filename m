Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16D11A68B0
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 14:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfICMhv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Sep 2019 08:37:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:58450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728994AbfICMhv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Sep 2019 08:37:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF030B028;
        Tue,  3 Sep 2019 12:37:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D3BB9DA8CD; Tue,  3 Sep 2019 14:38:09 +0200 (CEST)
Date:   Tue, 3 Sep 2019 14:38:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        mpe <mpe@ellerman.id.au>, Brian King <brking@linux.vnet.ibm.com>,
        chandan <chandan@linux.vnet.ibm.com>,
        sachinp <sachinp@linux.vnet.ibm.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [mainline][BUG][PPC][btrfs][bisected 00801a] kernel BUG at
 fs/btrfs/locking.c:71!
Message-ID: <20190903123809.GC2752@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        mpe <mpe@ellerman.id.au>, Brian King <brking@linux.vnet.ibm.com>,
        chandan <chandan@linux.vnet.ibm.com>,
        sachinp <sachinp@linux.vnet.ibm.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1567500907.5082.12.camel@abdul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567500907.5082.12.camel@abdul>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 03, 2019 at 02:25:07PM +0530, Abdul Haleem wrote:
> Greeting's
> 
> Mainline kernel panics with LTP/fs_fill-dir tests for btrfs file system on my P9 box running mainline kernel 5.3.0-rc5
> 
> BUG_ON was first introduced by below commit

Well, technically the bug_on was there already the only change is the
handling of the updates of the value.

> commit 00801ae4bb2be5f5af46502ef239ac5f4b536094
> Author: David Sterba <dsterba@suse.com>
> Date:   Thu May 2 16:53:47 2019 +0200
> 
>     btrfs: switch extent_buffer write_locks from atomic to int
>     
>     The write_locks is either 0 or 1 and always updated under the lock,
>     so we don't need the atomic_t semantics.

Assuming the code was correct before the patch, if this got broken one
of the above does not hold anymore:

* 0/1 updates -- this can be verified in code that all the state
  transitions are valid, ie. initial 0, locked update to 1, locked
  update 1->0

* atomic_t -> int behaves differently and the changes of the value get
  mixed up, eg. on the instruction level where intel architecture does
  'inc' while p9 does I-don't-know-what a RMW update?

But even with a RMW, this should not matter due to
write_lock/write_unlock around all the updates.

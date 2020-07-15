Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035C1220DCB
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jul 2020 15:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbgGONOf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jul 2020 09:14:35 -0400
Received: from [195.135.220.15] ([195.135.220.15]:43124 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1731457AbgGONOf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jul 2020 09:14:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4E164AD46;
        Wed, 15 Jul 2020 13:14:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 819FDDA790; Wed, 15 Jul 2020 15:14:11 +0200 (CEST)
Date:   Wed, 15 Jul 2020 15:14:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        Nokolay Borisov <nborisov@suse.com>
Subject: Re: [RFC] btrfs: volumes: Drop chunk_mutex lock/unlock on
 btrfs_read_chunk_tree
Message-ID: <20200715131411.GX3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        Nokolay Borisov <nborisov@suse.com>
References: <20200714172153.12956-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714172153.12956-1-marcos@mpdesouza.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 14, 2020 at 02:21:53PM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> In volumes.c there are comments stating that chunk_mutex is used to
> protect add/remove chunks, trim or add/remove devices. Since
> btrfs_read_chunk_tree is only called on mount, and trim and chunk alloc
> cannot happen at mount time, it's safe to remove this lock/unlock.
> 
> Also, btrfs_ioctl_{add|rm}_dev calls set BTRFS_FS_EXCL_OP, which should
> be safe.

I've analyzed it in
https://lore.kernel.org/linux-btrfs/20200512232827.GI18421@twin.jikos.cz/
and an ioctl gets called during mount with the seeding device. I don't
see it mentioned in your changelog.

The BTRFS_FS_EXCL_OP do not affect that because there's only one the
device add at this time.

> Dropping the mutex lock/unlock solves the lockdep warning.

Yes, but the question is if this is also correct :) Right now I don't
see how the excl_op flag is relevant here.

The patch proposed in
https://lore.kernel.org/linux-btrfs/20200513194659.34493-1-anand.jain@oracle.com/
has some issues, I tried to fix them back then but for some reason I
don't remember the patch did not work as expected.

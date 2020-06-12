Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BEE1F7C1F
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 19:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFLRNY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 13:13:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:49904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgFLRNX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 13:13:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 93BBDADF8;
        Fri, 12 Jun 2020 17:13:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A30D1DA7C3; Fri, 12 Jun 2020 19:13:15 +0200 (CEST)
Date:   Fri, 12 Jun 2020 19:13:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Greed Rong <greedrong@gmail.com>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: BTRFS: Transaction aborted (error -24)
Message-ID: <20200612171315.GW27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Greed Rong <greedrong@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <CA+UqX+NTrZ6boGnWHhSeZmEY5J76CTqmYjO2S+=tHJX7nb9DPw@mail.gmail.com>
 <20200611112031.GM27795@twin.jikos.cz>
 <a7802701-5c8d-5937-1a80-2bcf62a94704@gmx.com>
 <20200611135244.GP27795@twin.jikos.cz>
 <CA+UqX+OcP_S6U37BHkGgzyDVNAud5vYOucL_WpNLhfU-T=+Vnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+UqX+OcP_S6U37BHkGgzyDVNAud5vYOucL_WpNLhfU-T=+Vnw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 12, 2020 at 11:15:43AM +0800, Greed Rong wrote:
> This server is used for network storage. When a new client arrives, I
> create a snapshot of the workspace subvolume for this client. And
> delete it when the client disconnects.

NFS, cephfs and overlayfs use the same pool of ids, in combination with
btrfs snapshots the consumption might be higher than in other setups.

> Most workspaces are PC game programs. It contains thousands of files
> and Its size ranges from 1GB to 20GB.

We can rule out regular files, they don't affect that, and the numbers
you posted are all normal.

> About 200 windows clients access this server through samba. About 20
> snapshots create/delete in one minute.

This is contributing to the overall consumption of the ids from the
pool, but now it's shared among the network filesystem and btrfs.

Possible explanation would be leak of the ids, once this state is hit
it's permament so no new snapshots could be created or the network
clients will start getting some other error.

If there's no leak, then all objects that have the id attached would
need to be active, ie. snapshot part of a path, network client
connected to it's path. This also means some sort of caching, so the ids
are not returned back right away.

For the subvolumes the ids get returned once the subvolume is deleted
and cleaned, which might take time and contribute to the pool
exhaustion. I need to do some tests to see if we could release the ids
earlier.

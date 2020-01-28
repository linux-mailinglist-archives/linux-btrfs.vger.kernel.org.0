Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C0E14BEAE
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2020 18:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgA1RgN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 12:36:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:49802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgA1RgN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 12:36:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 71D85AE2B;
        Tue, 28 Jan 2020 17:36:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 09E82DA730; Tue, 28 Jan 2020 18:35:52 +0100 (CET)
Date:   Tue, 28 Jan 2020 18:35:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCHv2] btrfs: Introduce new BTRFS_IOC_SNAP_DESTROY_V2 ioctl
Message-ID: <20200128173552.GC3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200127024817.15587-1-marcos.souza.org@gmail.com>
 <20200128173100.GA16464@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128173100.GA16464@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 28, 2020 at 09:31:00AM -0800, Christoph Hellwig wrote:
> On Sun, Jan 26, 2020 at 11:48:17PM -0300, Marcos Paulo de Souza wrote:
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > This ioctl will be responsible for deleting a subvolume using it's id.
> > This can be used when a system has a file system mounted from a
> > subvolume, rather than the root file system, like below:
> 
> Isn't BTRFS_IOC_SNAP_DESTROY_BY_ID a better name?

I'd prefer to keep it V2 as a more flexible ioctl than just to delete
by id. There are other _V2 ioctls that use matching
btrfs_ioctl_vol_args_v2 structure. In case we want to implement
recursive subvolume deletion we'd have to introduce yet another ioctl
number compared to just a new flag and support both by-name and by-id.
Sounds like a lot of duplication.

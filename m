Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D2916828E
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 17:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgBUQCX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 11:02:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:49488 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgBUQCX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 11:02:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0D7FBAE2C;
        Fri, 21 Feb 2020 16:02:22 +0000 (UTC)
Message-ID: <90b60b225c4775e7b2df6956b508f53ce2a68708.camel@suse.de>
Subject: Re: [PATCHv3] btrfs: Introduce new BTRFS_IOC_SNAP_DESTROY_V2 ioctl
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     dsterba@suse.cz, Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org,
        hch@infradead.org, josef@toxicpanda.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Date:   Fri, 21 Feb 2020 13:05:20 -0300
In-Reply-To: <20200221144426.GJ2902@twin.jikos.cz>
References: <20200207130546.6771-1-marcos.souza.org@gmail.com>
         <20200221144426.GJ2902@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 2020-02-21 at 15:44 +0100, David Sterba wrote:
> On Fri, Feb 07, 2020 at 10:05:46AM -0300, Marcos Paulo de Souza
> wrote:
> > Also in this patch:
> > * export get_subvol_name_from_objectid, adding btrfs suffix
> 
> I've split this part from the patch so the actual change is only the
> new
> ioctl

Good, thanks.

> 
> > * add BTRFS_SUBVOL_SPEC_BY_ID flag
> > * add subvolid as a union member in struct btrfs_ioctl_vol_args_v2.
> 
> and ported the patch on top of the vol args flag cleanups I sent
> today.
> This should be all the kernel side needs for the subvolume by-id
> deletion. The patches will be in for-next and moved to misc-next
> soon.

Thanks! 

> Thanks.


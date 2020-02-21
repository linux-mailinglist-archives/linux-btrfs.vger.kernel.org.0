Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C6A168097
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 15:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgBUOoq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 09:44:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:55648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbgBUOoq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 09:44:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 78AF1B01D;
        Fri, 21 Feb 2020 14:44:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AFB46DA70E; Fri, 21 Feb 2020 15:44:26 +0100 (CET)
Date:   Fri, 21 Feb 2020 15:44:26 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org,
        hch@infradead.org, josef@toxicpanda.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCHv3] btrfs: Introduce new BTRFS_IOC_SNAP_DESTROY_V2 ioctl
Message-ID: <20200221144426.GJ2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org,
        hch@infradead.org, josef@toxicpanda.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200207130546.6771-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207130546.6771-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 07, 2020 at 10:05:46AM -0300, Marcos Paulo de Souza wrote:
> Also in this patch:
> * export get_subvol_name_from_objectid, adding btrfs suffix

I've split this part from the patch so the actual change is only the new
ioctl

> * add BTRFS_SUBVOL_SPEC_BY_ID flag
> * add subvolid as a union member in struct btrfs_ioctl_vol_args_v2.

and ported the patch on top of the vol args flag cleanups I sent today.
This should be all the kernel side needs for the subvolume by-id
deletion. The patches will be in for-next and moved to misc-next soon.
Thanks.

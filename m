Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B613818513C
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgCMVdR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:33:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:43364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727459AbgCMVdR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:33:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6AFB2AD81;
        Fri, 13 Mar 2020 21:33:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 45F8CDA7A7; Fri, 13 Mar 2020 22:32:50 +0100 (CET)
Date:   Fri, 13 Mar 2020 22:32:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: Remove transid argument from
 btrfs_ioctl_snap_create_transid
Message-ID: <20200313213250.GS12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200313152320.22723-1-nborisov@suse.com>
 <20200313152320.22723-3-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313152320.22723-3-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 13, 2020 at 05:23:19PM +0200, Nikolay Borisov wrote:
> btrfs_ioctl_snap_create_transid no longer takes a transid argument, so
> remove it and rename the function to __btrfs_ioctl_snap_create to
> reflect it's an internal, worker function.

Hm, this use of an underscored version does not look all great to me.
You're right that it's a worker, so it could get a completely new name.
The functions directly handling the ioctls have _ioctl_ in their name
but in this case I don't think it's necessary and gives us more freedom
to come up with a better name. I don't have a suggestion for now.

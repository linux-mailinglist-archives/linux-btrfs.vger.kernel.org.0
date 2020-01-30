Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2498414DC6F
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 15:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgA3OHR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 09:07:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:51484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgA3OHR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 09:07:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4172CAC66;
        Thu, 30 Jan 2020 14:07:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 359FCDA84C; Thu, 30 Jan 2020 15:06:57 +0100 (CET)
Date:   Thu, 30 Jan 2020 15:06:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs: Implement DRW lock
Message-ID: <20200130140657.GT3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200130125945.7383-1-nborisov@suse.com>
 <20200130125945.7383-5-nborisov@suse.com>
 <7c1530e7-85a0-e4c7-3ae5-770c5f9c18b2@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c1530e7-85a0-e4c7-3ae5-770c5f9c18b2@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 30, 2020 at 03:37:26PM +0200, Nikolay Borisov wrote:
> > +int btrfs_drw_lock_init(struct btrfs_drw_lock *lock)
> > +{
> > +	int ret;
> > +
> > +	ret = percpu_counter_init(&lock->writers, 0, GFP_KERNEL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	atomic_set(&lock->readers, 0);
> > +	init_waitqueue_head(&lock->pending_readers);
> > +	init_waitqueue_head(&lock->pending_writers);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(btrfs_drw_lock_init);
> 
> I have the functions EXPORT_SYMBOL since I have an internal patch which
> is hooking this code to locktorture. SO they can be removed.

You can make the exports conditional, #ifdef LOCKTORTURE.

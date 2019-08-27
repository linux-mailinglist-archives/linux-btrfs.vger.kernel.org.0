Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 854039EF42
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 17:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfH0PpS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 11:45:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:44764 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbfH0PpS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 11:45:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 59154AED0
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 15:45:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A4F97DA8D5; Tue, 27 Aug 2019 17:45:40 +0200 (CEST)
Date:   Tue, 27 Aug 2019 17:45:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: Make btrfs_find_name_in_backref return
 btrfs_inode_ref struct
Message-ID: <20190827154540.GO2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190827114630.2425-1-nborisov@suse.com>
 <20190827114630.2425-2-nborisov@suse.com>
 <20190827141341.GJ2752@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827141341.GJ2752@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 27, 2019 at 04:13:41PM +0200, David Sterba wrote:
> On Tue, Aug 27, 2019 at 02:46:28PM +0300, Nikolay Borisov wrote:
> >  			ret = btrfs_find_name_in_backref(log_eb, log_slot, name,
> > -							 namelen, NULL);
> > +							 namelen) != NULL;
> 
> Isn't there a less confusing and obscure way to do that?

As patch 3/3 does, ret = !!btrfs_..., I'll switch to it where needed.

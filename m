Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA2A4B792
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 14:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbfFSMC2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 08:02:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:43584 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726246AbfFSMC2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 08:02:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F37F2AF50
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 12:02:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C768DDA88C; Wed, 19 Jun 2019 14:03:14 +0200 (CEST)
Date:   Wed, 19 Jun 2019 14:03:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6/6] btrfs: lift bio_set_dev from bio allocation helpers
Message-ID: <20190619120314.GC8917@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1560880630.git.dsterba@suse.com>
 <78e6abb1da3bb93961254526172dc70138f8f39b.1560880630.git.dsterba@suse.com>
 <d36987c6-2e18-5b2e-0760-0cf151446586@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d36987c6-2e18-5b2e-0760-0cf151446586@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 19, 2019 at 10:02:53AM +0300, Nikolay Borisov wrote:
> 
> 
> On 18.06.19 г. 21:00 ч., David Sterba wrote:
> > The block device is passed around for the only purpose to set it in new
> > bios. Move the assignment one level up. This is a preparatory patch for
> > further bdev cleanups.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> Albeit I'd go as far as suggesting to make btrfs_bio_alloc a void
> function similar to the generic bio alloc functions. It should be up to
> the callers of bio alloc functions to initialize the bio in one place.
> Even after your patch initialization is split across btrfs_bio_alloc and
> its caller which seems a bit idiosyncratic.

The bio_set_dev will go away (device for a bio is set right before it's
submitted), so there will be only the allocation and the code as before.

Some kind of split is probably inevitable, btrfs_bio_alloc needs the
bioset that's private to extent_io.c and the callers know what to set to
bi_opf etc. Maybe, as I'm looking at it now, btrfs_bio_alloc can take
the value for opf, private and end_io as argument. All the callsites
fill these three. That would make it consistent.

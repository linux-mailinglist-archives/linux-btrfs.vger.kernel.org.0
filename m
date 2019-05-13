Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 468891B0CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 09:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfEMHGW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 03:06:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:36144 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727415AbfEMHGW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 03:06:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F3755AE44
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2019 07:06:20 +0000 (UTC)
Date:   Mon, 13 May 2019 09:06:20 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/17] btrfs: don't assume ordered sums to be 4 bytes
Message-ID: <20190513070620.GB12653@x250>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190510111547.15310-6-jthumshirn@suse.de>
 <9f6864d5-9659-a121-5de1-3e5993eabef8@suse.com>
 <12f8e39d-99e5-3244-a61a-71819ed5586f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12f8e39d-99e5-3244-a61a-71819ed5586f@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 10, 2019 at 04:27:38PM +0300, Nikolay Borisov wrote:
> >>  			if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
> >>  				ret = btrfs_lookup_bio_sums(inode, comp_bio,
> >> -							    sums);
> >> +							    (u8 *)sums);
> > 
> > This cast (and other similar) are plain ugly. Imho we first need to get
> > the code into shape for later modification. This means postponing sha256
> > patch and instead focusing on first getting the code to use u8 where
> > relevant. Otherwise such cleanup is going to be postponed for "some time
> > in the future" will is unlikely to ever materialize.
> 
> Oh, so you fix that in the next patch. Okay, disregard this then.

Exactly. There are some intermediate temporary hacks in the prep patches of
the series, but they're not persistent.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

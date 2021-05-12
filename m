Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0740537BADE
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 May 2021 12:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhELKkd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 06:40:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:60676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230184AbhELKkc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 06:40:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 26DF7AFAA;
        Wed, 12 May 2021 10:39:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3E5CCDAF37; Wed, 12 May 2021 12:36:54 +0200 (CEST)
Date:   Wed, 12 May 2021 12:36:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: check for minimal needed number of zones
Message-ID: <20210512103653.GO7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210512075305.19048-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512075305.19048-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 12, 2021 at 04:53:05PM +0900, Johannes Thumshirn wrote:
> In order to create a usable zoned filesystem a minimum of 5 zones is
> needed:
> 
> - 2 zones for the 1st superblock
> - 1 zone for the system block group
> - 1 zone for a metadata block group
> - 1 zone for a data block group
> 
> Some tests in xfstests create a sized filesystem and depending on the zone
> size of the underlying device, it may happen, that this filesystem is too
> small to be used. It's better to not create a filesystem at all than to
> create an unusable filesystem.

Agreed, though there's no spare zone for relocation once any of them
becomes unusable (which is a known problem and can happen for any zone
count). Once this gets solved the limit will be increased accordingly.

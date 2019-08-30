Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E855A39DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2019 17:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfH3PGg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Aug 2019 11:06:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:57252 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727781AbfH3PGg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Aug 2019 11:06:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8DBA4AEC4;
        Fri, 30 Aug 2019 15:06:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 84CA7DA809; Fri, 30 Aug 2019 17:06:57 +0200 (CEST)
Date:   Fri, 30 Aug 2019 17:06:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] btrfs: support xxhash64 checksums
Message-ID: <20190830150657.GP2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190830113611.16865-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830113611.16865-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 30, 2019 at 01:36:07PM +0200, Johannes Thumshirn wrote:
> Now that Nikolay's XXHASH64 support for the Crypto API has landed and BTRFS is
> prepared for an easy addition of new checksums, this patchset implements
> XXHASH64 as a second, fast but not cryptographically secure checksum hash.
> 
> For changelogs, please see the individual patches.
> 
> David Sterba (1):
>   btrfs: sysfs: export supported checksums
> 
> Johannes Thumshirn (3):
>   btrfs: turn checksum type define into a enum
>   btrfs: create structure to encode checksum type and length
>   btrfs: add xxhash64 to checksumming algorithms

I'll add 1 and 2 to misc-next as they aren't risky, xxhash will wait
until the code freeze. The sysfs export needs more work but it's not
urgent now, would be ok with the rest of hash updates.

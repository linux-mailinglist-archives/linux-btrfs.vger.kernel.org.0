Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECF02F7F9F
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jan 2021 16:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbhAOPca (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jan 2021 10:32:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:57998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbhAOPc3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jan 2021 10:32:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 78356B720;
        Fri, 15 Jan 2021 15:31:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A4DB7DA7D5; Fri, 15 Jan 2021 16:29:54 +0100 (CET)
Date:   Fri, 15 Jan 2021 16:29:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     waxhead <waxhead@dirtcellar.net>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: Why do we need these mount options?
Message-ID: <20210115152954.GH6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, waxhead <waxhead@dirtcellar.net>,
        linux-btrfs@vger.kernel.org
References: <208dba68-b47e-101d-c893-8173df8fbbbf@dirtcellar.net>
 <20210114163729.GY6430@twin.jikos.cz>
 <e9257bae-b744-42a7-1fc3-39b3ea676898@dirtcellar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9257bae-b744-42a7-1fc3-39b3ea676898@dirtcellar.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 15, 2021 at 01:02:12AM +0100, waxhead wrote:
> > I don't think the per-subvolume storage options were ever tracked on
> > wiki, the closest match is per-subvolume mount options that's still
> > there
> > 
> > https://btrfs.wiki.kernel.org/index.php/Project_ideas#Per-subvolume_mount_options
> > 
> Well how about this from our friends archive.org ?
> http://web.archive.org/web/20200117205248/https://btrfs.wiki.kernel.org/index.php/Main_Page
> 
> Here it clearly states that object level mirroring and striping is 
> planned. Maybe I misinterpret this , but I understand this as (amongst 
> other things) configurable storage profiles per subvolume.

I see. The list on the main page is supposed to list features that we could
promise to be implemented "soon". For all the ideas there's the specific
project page wher it does not matter too much when it will implemented, it's
kind of a pool.

In the wiki edit that removed the object-level storage I also removed
(https://btrfs.wiki.kernel.org/index.php?title=Main_Page&diff=prev&oldid=33190)

* Online filesystem check
* Object-level mirroring and striping
* In-band deduplication (happens during writes)
* Hot data tracking and moving to faster devices (or provided on the generic VFS layer)

For each of the task there's nobody working on that, to my knowledge,
though there was some interest and maybe RFC patches in the past.

The object-level storage idea/task can be added to the Project_ideas
page, so it's not lost.

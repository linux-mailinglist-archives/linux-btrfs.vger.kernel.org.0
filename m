Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B773FB024E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 19:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfIKRBS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 13:01:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:42790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728937AbfIKRBR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 13:01:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A5ADAE3A;
        Wed, 11 Sep 2019 17:01:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4EB7CDA7D9; Wed, 11 Sep 2019 19:01:39 +0200 (CEST)
Date:   Wed, 11 Sep 2019 19:01:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: drop unique uuid test for btrfstune -M
Message-ID: <20190911170139.GH2850@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190906005025.2678-1-anand.jain@oracle.com>
 <f3d33e1d-803e-34a5-4dfa-7eeceec6177c@suse.com>
 <232bccd3-3623-8ee9-18db-98edf7cd2e25@oracle.com>
 <673ba386-debc-96e9-311e-4c3c0abd89d0@suse.com>
 <41b5b682-e67f-40d6-93cb-75e4889a4b06@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41b5b682-e67f-40d6-93cb-75e4889a4b06@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 10, 2019 at 01:12:43PM +0800, Anand Jain wrote:
> 
> Nikolay,
> 
> >>> This is intended. Otherwise it's an open avenue for the user to shoot
> >>> themselves in the foot.
> >>
> >>   I don't understand how?
> 
>   Again. Any idea how? Is there any test case?
> 
>   <snip>
> 
> > UUID, by definition, are Unique. What you want to is
> > to toss the Unique part, meaning we'll really be left with some sort of
> > ID. What's more - the UUID is used by libblkid to populate the available
> > devices so not making it unique can cause subtle bugs.
> 
> - Irrespective of the fstype, when fs image file is copied/snapshot-ed
>    the fsid is indeed going to be duplicate.
> 
> - xfs and btrfs kernel doesn't allow duplicate fsid to be mounted which
>    is fair and accepted. (I remember fixing the duplicate fsid bugs in
>    the kernel, just fyi if you are concerned about them).
> 
> - ext4 kernel does allow duplicate fsid to be mounted.
> 
> - btrfstume -M <uuid> isn't the place to check if the fsid is a
>    duplicate. Because, libblkid will be unaware of the complete list of
>    fs images with its fsid.

I don't understand this part. Blkid tracks the device iformation, like
the uuid, and the cache gets updated. So what does 'will be unaware of
the complete list' mean?

If it's on the same host it's a matter of keeping the cache in sync with
the actual devices.

> - As I said before, its a genuine use-case here where the user wants to
>    revert the fsid change, so that btrfs fs root image can be booted.
>    Its up-to the user if fsid is duplicate in the user space, as btrfs
>    kernel rightly fails the mount if its duplicate fsid anyways.

Reverting the uuid is fine and requiring the uuids to be unique is
preventing the users doing stupid things unknowingly. You seem to have a
usecase where even duplicate uuids are required but I'm afraid it's not
all clear how is it supposed to work. A few more examples or commands
would be helpful.

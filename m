Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2C0177DE7
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 18:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgCCRou (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 12:44:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:49862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730810AbgCCRor (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 12:44:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 373A2AE5E;
        Tue,  3 Mar 2020 17:44:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 22CC7DA7AE; Tue,  3 Mar 2020 18:44:23 +0100 (CET)
Date:   Tue, 3 Mar 2020 18:44:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH] btrfs-progs: convert, warn if converting a fs which
 won't mount
Message-ID: <20200303174422.GM2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <1582877026-5487-1-git-send-email-anand.jain@oracle.com>
 <af69d1ab-4609-d603-980c-b8a6cfb87f43@gmx.com>
 <39c3e381-b49e-a571-d058-a01734b8b4a9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39c3e381-b49e-a571-d058-a01734b8b4a9@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 28, 2020 at 05:06:52PM +0800, Anand Jain wrote:
> On 2/28/20 4:27 PM, Qu Wenruo wrote:
> > On 2020/2/28 下午4:03, Anand Jain wrote:
> >> On aarch64 with pagesize 64k, btrfs-convert of ext4 is successful,
> >> but it won't mount because we don't yet support subpage blocksize/
> >> sectorsize.
> >>
> >>   BTRFS error (device vda): sectorsize 4096 not supported yet, only support 65536
> >>
> >> So in this case during convert provide a warning and a 10s delay to
> >> terminate the command.
> > 
> > This is no different than calling mkfs.btrfs -s 64k on x86 system.
> > And I see no warning from mkfs.btrfs.
> > 
> > Thus I don't see the point of only introducing such warning to
> > btrfs-convert.
> > 
> 
> I have equal weight-age on the choices if blocksize != pagesize viz..
>    delay and warn (this patch)
>    quit (Nikolay).
>    keep it as it is without warning (Qu).
> 
>   Here we are dealing with already user data. Should it be different
>   from mkfs?
>   Quit is fine, but convert tool should it be system neutral?

The delays should be used in exceptional cases, now we have it for check
--repair and for unfiltered balance. Both on user request because
expecting users to know everything in advance what the commands do has
shown to be too optimistic.

Refusing to allow the conversion does not make much sense for usability,
mising the unmounted and mounted constraints.

A warning might be in place but there's nothing wrong to let the user do
the conversion.

I've tried mkfs.ext4 with 64k block size and it warns and in the
interactive session wants to confirm that by the user:

  $ mkfs.ext4 -b 64k img
  Warning: blocksize 65536 not usable on most systems.
  mke2fs 1.45.5 (07-Jan-2020)
  img contains a ext4 file system
	  created on Tue Mar  3 18:41:46 2020
  Proceed anyway? (y,N) y
  mkfs.ext4: 65536-byte blocks too big for system (max 4096)
  Proceed anyway? (y,N) y
  Warning: 65536-byte blocks too big for system (max 4096), forced to continue
  Creating filesystem with 32768 64k blocks and 32768 inodes

  Allocating group tables: done
  Writing inode tables: done
  Creating journal (4096 blocks): done
  Writing superblocks and filesystem accounting information: done

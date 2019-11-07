Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76DDFF38D9
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2019 20:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfKGTlq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Nov 2019 14:41:46 -0500
Received: from aurora.thatsmathematics.com ([162.209.10.89]:53194 "EHLO
        aurora.thatsmathematics.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbfKGTlq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 Nov 2019 14:41:46 -0500
Received: from moneta (unknown [50.28.189.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by aurora.thatsmathematics.com (Postfix) with ESMTPSA id 0C2E47E200;
        Thu,  7 Nov 2019 19:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=thatsmathematics.com;
        s=swordfish; t=1573155705;
        bh=KMjiYCPuCf+yJ1fI1gdtawPZkvwk/Euw0v7TGEJabnY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=N+T3l2u8fofFim32E+QrOwF4FlrS1GP84aRqGG8sPcL4IwWusEBH1D6OoC7AyYUG3
         MC5i9p5VXKUEtq/GxQVC/2hJF79pzaO1rTZfl1TpEgH3gWXWgVsCZ098NQHaMwqH/G
         2AVYTYMEvrd3p3Nur+i2imsPMHOPMvfj1EI8xdPk=
Date:   Thu, 7 Nov 2019 14:41:44 -0500 (EST)
From:   Nate Eldredge <nate@thatsmathematics.com>
X-X-Sender: nate@moneta
To:     Remi Gauvin <remi@georgianit.com>
cc:     linux-btrfs@vger.kernel.org
Subject: Re: Defragmenting to recover wasted space
In-Reply-To: <cc5fba8b-baf3-f984-c99d-c5be9ce3a2d9@georgianit.com>
Message-ID: <alpine.DEB.2.21.1911071419570.3492@moneta>
References: <alpine.DEB.2.21.1911070814430.3492@moneta> <cc5fba8b-baf3-f984-c99d-c5be9ce3a2d9@georgianit.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-44035990-1573155553=:3492"
Content-ID: <alpine.DEB.2.21.1911071439500.3492@moneta>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-44035990-1573155553=:3492
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.1911071439501.3492@moneta>

On Thu, 7 Nov 2019, Remi Gauvin wrote:

> On 2019-11-07 9:03 a.m., Nate Eldredge wrote:
>
>> 1. What causes this?  I saw some references to "unused extents" but it
>> wasn't clear how that happens, or why they wouldn't be freed through
>> normal operation.  Are there certain usage patterns that exacerbate it?
>
> Virtual Box Image files are subject to many, many small writes... (just
> booting windows, for example, can create well over 5000 file fragments.)
> When the image file is new, the extents will be very large.  In BTRFS,
> the extents are immutable. When a small write creates a new 4K COW
> extent, the old 4k remains as part of the old extent as well.  This
> situation will remain until all the data in the old extent is
> re-written.. when none of that data is referenced anymore, the extent
> will be freed.

Thanks, Remi.  This is very helpful in understanding what is going on.  In 
particular, I didn't realize that extents are immutable even when there is 
only one reference to them (I have no snapshots or reflinks to these 
files).

I guess this also means that in the worst case, if I want to overwrite the 
entire file "in place" in a random order, I actually need additional free 
space equal to the file's size, until I get around to defragging.  That's 
rather counterintuitive for somebody used to traditional filesystems.

>> 5. Is there a better way to detect this kind of wastage, to distinguish
>> it from more mundane causes (deleted files still open, etc) and see how
>> much space could be recovered? In particular, is there a way to tell
>> which files are most affected, so that I can just defragment those?
>
> Generally speaking, files that are subject to many random writes are
> few, and you should be well aware of the larger ones where this might be
> an issues,, (virtual image files, large databases, etc.)  These files
> should be defragmented frequently.  I don't see any reason not run
> defrag over the whole subvolume, but if you want to search for files
> with absurd fragments, you can always use the find command to search for
> files, run the filefrag command on them, then use whatever tools you
> like to search the output for files with thousands of fragments.

Okay.  Defragmenting is kind of inconvenient, though, and I suppose it 
involves some extra wear on the SSD since data is really being moved. 
There's also the issue, as I understand it, that defragmenting will break 
up existing reflinks, which in some other situations I may really want to 
keep.

In fact, it seems that somehow what I really want is for the file to be 
*completely* fragmented, so that every write replaces an extent and frees 
the old one.  On an SSD I don't really care if the data blocks are 
actually contiguous.  It seems perverse, but even if there is more 
overhead, it might be worth it when I don't have a lot of free space to 
spare.  I don't suppose there is any way to arrange that?

Thanks again!

-- 
Nate Eldredge
nate@thatsmathematics.com
--8323329-44035990-1573155553=:3492--

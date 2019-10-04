Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8FA5CB7C6
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 12:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfJDKBO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 06:01:14 -0400
Received: from mail.render-wahnsinn.de ([176.9.37.177]:39678 "EHLO
        mail.render-wahnsinn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfJDKBO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Oct 2019 06:01:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with robert.krig@render-wahnsinn.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=render-wahnsinn.de;
        s=dkim; t=1570183263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EUz2WmbFPs5GJpYqdjzuE5m6q+DizCEX9lYyCL3NTeQ=;
        b=V2Ybsfs7QXuUluKNIeLjVegVKol5jMEZWlcK+kCWckqaBJbiZBm2uN8bdHmHrf0pFpRhnV
        DkDAk2zD4LuaC5dIzfojWw755F1uMz9ef0HjhuqMnk01aYJgj6r8Ibpe0eHf7LXlxJ0L/g
        EztunchJ8vD+RgpUFdHR+NL5srCGtZblYeAb1WrCl0E+ooTkp8q0JNPGxwyNDpyPvTtM5o
        SUVU6+EZ+dAyrDWQpSVltSQc2mQLUgQLW4YhgUwLr9ZAXf/Z1aO5CxkUC6oRa0LzRg3Tn/
        Y8HBHrUyn6074cvF8XyFWlVsSU8QE/k/JgSRfvf6cHCNNeT/BFgTR7pv8ZbZ0w==
Message-ID: <acd2ed4f712ab8b5f258e2d61536ccaf572f6629.camel@render-wahnsinn.de>
Subject: Re: BTRFS Raid5 error during Scrub.
From:   Robert Krig <robert.krig@render-wahnsinn.de>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Linux Btrfs <linux-btrfs@vger.kernel.org>
Date:   Fri, 04 Oct 2019 12:00:54 +0200
In-Reply-To: <CAJCQCtRGCqTOseT2PcHpSv=SOKZBt9trSMkkZ5-KSTZTW4dKog@mail.gmail.com>
References: <804e7e93a00dfe954222e4f8dc820a075d9ccb79.camel@render-wahnsinn.de>
         <0fdd1282-f370-b55e-0c3f-486ad8673bcd@suse.com>
         <3616237f8d39c87abcc9b118b8441cfecf36eeb6.camel@render-wahnsinn.de>
         <CAJCQCtQcKRN09wpbSmguNQ8bSq5VZEk2JNwLOWcsAK7YYJD2YA@mail.gmail.com>
         <273d41c4d05283aaa658d9c374e7c43199b0aac3.camel@render-wahnsinn.de>
         <498f23ebd3889618cb3faedf04c72ff059553121.camel@render-wahnsinn.de>
         <CAJCQCtRGCqTOseT2PcHpSv=SOKZBt9trSMkkZ5-KSTZTW4dKog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=render-wahnsinn.de; s=dkim; t=1570183263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EUz2WmbFPs5GJpYqdjzuE5m6q+DizCEX9lYyCL3NTeQ=;
        b=mr3Ql4smb+rfivgY3l28FJLUH4QyB51iHuwjdLJ3fdqmyE6vkdXPAlUlKD9IT/6zoCCQk7
        Bz4wgq0BLOFrJhbasjtfxzpzIfY2bwxFrpH57ucemClpHTQJ0NVEFzRgACmWm+a08GijrX
        3bAr3hqL5LdcDMYXwY0gXLdSe94VSFfS2yGOQrEHFCRLltFSWTMmHc7ISR/Jl15cYr/W0W
        UmKD5IIDNDpbMxpePrfa730EjvvI38ElNv5mKZXMkbDYrLjh3lGZHVDXoIu9jSgPtoCo+e
        kgbKXTBJlzCvMjIeiIhCkWVAIweaRMGY4IUYbsnvKWCXKnwI49gLE/WbvQSBAQ==
ARC-Seal: i=1; s=dkim; d=render-wahnsinn.de; t=1570183263; a=rsa-sha256;
        cv=none;
        b=DdFndJgULPVdHwFMua1CYWD99jzMJiF25BamUH5+oSIV4fiDeXS1FSbm2/T5kWvctuxP1L
        /5+CmlrVSoi7ax/DGJkfF6q1BkKk3hkwwMxikHu0oeji1nu8O2hFOaa8/FoZ303CNOtXDv
        wfwJJ4ZCUjxI3oZrAps2Eukqp/lwrMGoTlSlRTKQJsGeiYLp0LPs5gIqV9Cz8fHyo6Xsrg
        p2Yp+2tfZq4gcU+Oe87/nk+NyZgfmHAFVuSqZvNI+2lqa9YyFcP1ixDaqXEgkNLNk/p6gv
        aJRB2KGhyHC5ajZvbDAd/dBPX7+d/IL1mHfD93VJ1Dd4L1dZi9Fw3ijKLzQt5A==
ARC-Authentication-Results: i=1;
        mail.render-wahnsinn.de;
        auth=pass smtp.mailfrom=robert.krig@render-wahnsinn.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you all for your help so far.

I'm doing backups at the moment. My other Server is a ZFS system. I
think what I'm going to do, is to have this system, that's currently
BTRFS RAID5 migrated to using ZFS and once that's done, migrate my
backup system to BTRFS RAID5. That way I can still experiment with
BTRFS Raid5, but starting from scratch is not so problematic, since
it's a backup system and not being actively used.

I'm still going to try the steps you mentioned with btrfs check --
repair and see what that's going to spit out.


Am Donnerstag, den 03.10.2019, 14:18 -0600 schrieb Chris Murphy:
> On Thu, Oct 3, 2019 at 6:18 AM Robert Krig
> <robert.krig@render-wahnsinn.de> wrote:
> > By the way, how serious is the error I've encountered?
> > I've run a second scrub in the meantime, it aborted when it came
> > close
> > to the end, just like the first time.
> > If the files that are corrupt have been deleted is this error going
> > to
> > go away?
> 
> Maybe.
> 
> 
> > > > > Opening filesystem to check...
> > > > > Checking filesystem on /dev/sda
> > > > > UUID: f7573191-664f-4540-a830-71ad654d9301
> > > > > [1/7] checking root items                      (0:01:17
> > > > > elapsed,
> > > > > 5138533 items checked)
> > > > > parent transid verify failed on 48781340082176 wanted 109181
> > > > > found
> > > > > 109008items checked)
> > > > > parent transid verify failed on 48781340082176 wanted 109181
> > > > > found
> > > > > 109008
> > > > > parent transid verify failed on 48781340082176 wanted 109181
> > > > > found
> > > > > 109008
> 
> These look suspiciously like the 5.2 regression:
> https://lore.kernel.org/linux-btrfs/20190911145542.1125-1-fdmanana@kernel.org/T/#u
> 
> You should either revert to a 5.1 kernel, or use 5.2.15+.
> 
> As far as I'm aware it's not possible to fix this kind of corruption,
> so I suggest refreshing your backups while you can still mount this
> file system, and prepare to create it from scratch.
> 
> 
> > > > > Ignoring transid failure
> > > > > leaf parent key incorrect 48781340082176
> > > > > bad block 48781340082176
> > > > > [2/7] checking extents                         (0:03:22
> > > > > elapsed,
> > > > > 1143429 items checked)
> > > > > ERROR: errors found in extent allocation tree or chunk
> > > > > allocation
> 
> That's usually not a good sign.
> 
> 
> 
> > > > > [3/7] checking free space cache                (0:05:10
> > > > > elapsed,
> > > > > 7236
> > > > > items checked)
> > > > > parent transid verify failed on 48781340082176 wanted 109181
> > > > > found
> > > > > 109008ems checked)
> > > > > Ignoring transid failure
> > > > > root 15197 inode 81781 errors 1000, some csum missing48
> > > > > elapsed,
> 
> That's inode 81781 in the subvolume with ID 15197. I'm not sure what
> error 1000 is, but btrfs check is a bit fussy when it enounters files
> that are marked +C (nocow) but have been compressed. This used to be
> possible with older kernels when nocow files were defragmented while
> the file system is mounted with compression enabled. If that sounds
> like your use case, that might be what's going on here, and it's
> actually a benign message. It's normal for nocow files to be missing
> csums. To confirm you can use 'find /pathtosubvol/ -inum 81781' to
> find the file, then lsattr it and see if +C is set.
> 
> You have a few options but the first thing is to refresh backups and
> prepare to lose this file system:
> 
> a. bail now, and just create a new Btrfs from scratch and restore
> from backup
> b. try 'btrfs check --repair' to see if the transid problems are
> fixed; if not
> c. try 'btrfs check --repair --init-extent-tree' there's a good
> chance
> this fails and makes things worse but probably faster to try than
> restoring from backup
> 


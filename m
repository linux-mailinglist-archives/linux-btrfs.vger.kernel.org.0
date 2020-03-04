Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89562178A99
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 07:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgCDGc2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 01:32:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33295 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgCDGc2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Mar 2020 01:32:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id x7so924882wrr.0
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Mar 2020 22:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ocqiAnhh2bZlEwOiWQC7d7qP8qRWSfn04t/IJ1medhs=;
        b=O1rAgK4qZddsnA/m2mxC75959Gei8k7YD+/cBQSQls8ebDt1CfY5YXAgzstE4C37UM
         ic7pDrbcOmJyRnXOJAtA4utK7M6GMgP7o7OF7JzxiifWsWMXxaMOFY1dnxAeV7ygHENc
         dxPN24aGeuX0x+SsOV8Y/l99I5/hSk0htzuFEyGFMa979ObLUvhK4gZNsrt4f6svcut+
         p0fIgMkN/Y5cup1IkkpEikuffa63uZYziHJNFHZ2t/uXzZgB1Q+wuk0zOZOwfPV/eScK
         IxzTTeP/SI6EHzdwDAI3QAiKFTXMag7n5JQ7HLHWOSUel1FxNlZRb3fFugrrpccp/iA/
         HATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocqiAnhh2bZlEwOiWQC7d7qP8qRWSfn04t/IJ1medhs=;
        b=Mb9jEQZJ3+JShAZHR73APnE9jktYYPA28rq9uoBFo/nkj2slAPV1MmLx2fkk+v7xH2
         yG9JwZWPxTTgg7JLdYiNChVhVam5tVe/xc+7jiMQIp/tljdOFTXDzFq4dnVOGsvLj7Vq
         ifaD/iU8Cx3z6MfZAKpi26asONZGbmaKPouoiKoX1OGnrUpLJmXF3/31cumDO2DR78Il
         3WBSU0xv0vAlJ2yShMIwRL1UtdZgdeI0Q8LXp66GNLzAwY8Hz7CKBfgFb2U62efN4oao
         55u2ThxrxiJoWCL9mUd1seTqgeKsjE6ZXX6rjPUSP7LAELrMmeylTqytmfSmvKzkBoAR
         WPzg==
X-Gm-Message-State: ANhLgQ2i/KYW2CgGq1jVOMgd1kM3OLPQ33N7rWGJjQsCpp4J7pWpmtxN
        dZnfA4+ftQIJ5fB3e6WTPgaav1ciicgF+iC30MREtIHyG9o=
X-Google-Smtp-Source: ADFU+vtKWJ4Z8dJ4uSaUb1JsCVFjtqFeE5IPYGPdnRzfFAoOweGC58iL7Q3FpN6hflqTooOfbmNe4ojK3meDM2g0tBU=
X-Received: by 2002:a5d:6881:: with SMTP id h1mr2256460wru.236.1583303544106;
 Tue, 03 Mar 2020 22:32:24 -0800 (PST)
MIME-Version: 1.0
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com> <CAAW2-Zfz8goOBCLovDpA7EtBwOsqKOAP5Ta_iS6KfDFDDmn47g@mail.gmail.com>
 <60fba046-0aef-3b25-1e7d-7e39f4884ffe@gmx.com> <CAAW2-ZdczvEfgKb++T9YGSOMxJB+jz3_mwqEt2+-g0Omr7tocQ@mail.gmail.com>
 <CAG_8rEfjNPwT4g2DwbS9atsurLvYazt7aV4o77HGv-fssNmheQ@mail.gmail.com>
 <CAJCQCtTYBOUDmWBAA4BAenkyZS6uY+f6Ao33uHMmr_16M_1Buw@mail.gmail.com>
 <CAG_8rEcXpWUyUqmi3fe8BicZXQODJP2ZS69Z=BBcBPfAQBuSHA@mail.gmail.com>
 <CAJCQCtR7prMai9dYndLZ4Wg4tSL7kHZaLLK8c5p_4fDG2qoYnA@mail.gmail.com> <CAG_8rEf-kdju-OPhVUVWF8qNMM=xiUnWuBgODiwzGnRMzJYNpg@mail.gmail.com>
In-Reply-To: <CAG_8rEf-kdju-OPhVUVWF8qNMM=xiUnWuBgODiwzGnRMzJYNpg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 3 Mar 2020 23:32:04 -0700
Message-ID: <CAJCQCtTz-KW4WLJtcX9NGSPiCmCZ81_bXE+YBhn2_DocvnefZw@mail.gmail.com>
Subject: Re: USB reset + raid6 = majority of files unreadable
To:     Steven Fosdick <stevenfosdick@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Jonathan H <pythonnut@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 3, 2020 at 4:40 PM Steven Fosdick <stevenfosdick@gmail.com> wrote:
>
> On Sat, 29 Feb 2020 at 06:31, Chris Murphy <lists@colorremedies.com> wrote:
>
> > s/might/should
>
> I do think it is worth looking at the possibility that the "write
> hole", because it well documented, is being blamed for all cases that
> data proves to be unrecoverable when some of these may be due to a bug
> or bugs.  From what I've found about the write hole this is because of
> uncertainty over which of several discs actually got written to so
> when copies don't match there is no way to know which one is right.
> In the case of a disc failure, though, surely the copy that is right
> is the one that doesn't involve the failed disc?  Or is there
> something else I don't understand?

a. the write hole doesn't happen with raid1, and your metadata is
raid1 so any file system corruption is not related to the write hole
b. the write hole can apply to your raid5 data stripes, but this is a
rare case that happens with a crash or power failure during write and
causes a stripe to be incompletely rewrite when it's being modified.
That's rare conventional raid5, more rare on btrfs, but it can happen.
c. to actually be affected by the write hole problem, the stripe with
mismatching parity strip must have a missing data strip such as a bad
sector making up one of the strips, or a failed device. If neither of
those are the case, it's not the write hole, it's something else.
d. before there's a device or sector failure, a scrub following a
crash or power loss will correct the problem resulting from the write
hole



> I did try running a scrub but had to abandon it as it wasn't proving
> very useful.  It wasn't fixing the errors and wasn't providing any
> messages that would help diagnose or fix them some other way - it only
> seems to provide a count of the errors it didn't fix.

It can't fix them when the file system is mounted read only.


>  That seems to
> be general thing in that there seem plenty of ways an overall 'failed'
> status can be returned to userspace, usually without anything being
> logged.  That obviously makes sense if the request was to do something
> stupid but if instead the error return is because corruption has been
> found would it not be better to log an error?

The most obvious case of corruption is a checksum mismatch (the
onthefly checksum for a node/leaf/block compared to the recorded
checksum). Btrfs always reports this.

Parity strips are not checksummed. If parity is corrupt, it's only
corrected on a scrub (or balance). They're not used during normal read
operations. Upon degraded reads, parity is used to reconstruct data.
Since there's no checksum, the parity is trusted, and bad parity will
cause a corrupt reconstruction of data, and that corruption fails
checksum - and Btrfs will tell you about it, and also EIO.

So that leaves the less obvious cases of corruption where some
metadata or data is corrupt in memory, and a valid checksum is
computed on already corrupt data/metadata, and then written to disk.
Now when Btrfs reads it, there's no checksum mismatch, and yet there
is corruption. For metadata reads, the tree checker has gotten quite a
bit better lately at sanity checking metadata. For data, well you're
out of luck, the application will have to sanity check it and if not,
then the data is just corrupt - but it's no different than any other
file system. At least Btrfs gave you a chance. But that's the gotcha
of bad RAM or other sources of bit flips in the storage stack.


> > That looks like a bug. I'd try a newer btrfs-progs version. Kernel 5.1
> > is EOL but I don't think that's related to the usage info. Still, tons
> > of btrfs bugs fixed between 5.1 and 5.5...
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/fs/btrfs/?id=v5.5&id2=v5.1
> >
> > Including raid56 specific fixes:z
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/fs/btrfs/raid56.c?id=v5.5&id2=v5.1
>
> This was in response to posting dodgy output from btrfs fi usage.  My
> output was from btrfs-progs v5.4 which, when I checked yesterday,
> seemed to be the latest.  I am also running Linux 5.5.7.  It may have
> been slightly older when the disk failed but would still have been
> 5.5.x

From six days ago, your dmesg:

Sep 27 15:16:08 meije kernel:       Not tainted 5.1.10-arch1-1-ARCH #1

Actually what I should have asked is whether you ever ran 5.2 - 5.2.14
kernels because that series had a known corruption bug in it, fixed in
5.2.15

> Since my previous e-mail I have managed to get a 'btrfs device remove
> missing' to work by reading all the files from userspace, deleting
> those that returned I/O error and restoring from backup.  Even after
> that the summary information is still wacky:
>
> WARNING: RAID56 detected, not implemented
> Overall:
>     Device size:   16.37TiB I
>     Device allocated:   30.06GiB
>     Device unallocated:   16.34TiB
>     Device missing:      0.00B
>     Used:   25.40GiB
>     Free (estimated):      0.00B (min: 8.00EiB)
>     Data ratio:       0.00
>     Metadata ratio:       2.00
>     Global reserve: 512.00MiB (used: 0.00B)
>
> is the clue in the warning message?  It looks like it is failing to
> count any of the RAID5 blocks.

I think btrf filesystem usage doesn't completely support raid56 is all
it's saying.

'btrfs fi df' and 'btrfs fi show' should show things correctly

>
> Point taken about device replace.  What would device replace do if the
> remove step failed in the same way that device remove has been failing
> for me recently?

I don't understand the question. The device replace command includes
'device add' and 'device remove' in one step, it just lacks the
implied resize that happens with add and remove.



> I'm a little disappointed we didn't get to the bottom of the bug that
> was causing the free space cache to become corrupted when a balance
> operation failed but when I asked what I could do to help I got no
> reply to that part of my message (not just from you, from anyone on
> the list).

The free space cache isn't that important. It can be discarded and
reconstructed. It's an optimization. I don't think it's checksummed
anyway, instead corruption is determined by mismatching
generation/transid? So it may not literally be corrupt, it's just
ambiguous whether it can be relied upon, therefore it's marked for
reconstruction.



-- 
Chris Murphy

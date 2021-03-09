Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0063A333000
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Mar 2021 21:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhCIUew (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Mar 2021 15:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhCIUed (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Mar 2021 15:34:33 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23223C06174A
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Mar 2021 12:34:33 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d15so18374120wrv.5
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Mar 2021 12:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dOxHW/GbbAsly7jZSxcLIJhw5pW08E82ypr69Zy/VTw=;
        b=M4ctl7sjB3kHP2pidCC1l2qV57h/4dyGLZwMyuxRuSyK3GpHsc90uXC0O2w/AyMuEz
         09dPb74XDoo3461k8IjqmnwvylQAaMoje5NIXcXMoRwVOG3rAPVgAUsrIQy78jYHVhzr
         OQwHiPV7O+39ovf3jXNABpNdojQJxi1J8RDjeQl3mVC9A2nCGliuxLXtKr1L8z+ktUhX
         BJOmZibj+s0yWTjvljWkZ4djaVo3Gs3u4gwcP5F+KvgiqzMf9D9w5+Ecw7cEqO4yx8jy
         TA6Mugrk7ZWq4FlEu41RQ7BG1ZmFbKxm9skoS4yQE5BM9wOtLnZCOh5KroOzu4/GQ5ot
         fJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dOxHW/GbbAsly7jZSxcLIJhw5pW08E82ypr69Zy/VTw=;
        b=Ympwl8g2veV0UZO9xTb+bs/SbAVcASa9O2XL8F6fp3TI/PAJZy+6uQJKpI52Fgn9lb
         7+RPhqyWV6aopyhbgjEEzcpZNxU7GA3CTBZt7DGcH6qx8ke905KZhr/MTO+vkRzj09k6
         t3zv6fGLAmPpAEtmRqom69Odc3r22FQy6RFdu9PqKzE2Ty30d5/9NnYGqrGiDBcQ1Ud+
         Mx3oziUQhImxCMcZ7nisGLhLfx5/z9vWHrsAEEb7YJq5kEWt+6oSgSQ9dgH9GFDgNx37
         5A1MKBOXHFkvMhW0jno43+d1dqHAGC8jqkysyP8Vu/jQk5Mrvxyk4Isa/xQwsmkrMqSV
         7Tbw==
X-Gm-Message-State: AOAM530CPZrm4aypqO8wBUkBtOGyQsJKC7K7v9RIEfiRv28f7nIsx0va
        pCwR+Nim2m1tpfnmKyfBk3lnn02DyHbxHe2ZBovmxg==
X-Google-Smtp-Source: ABdhPJyfw+gjS4/PmwWPw6+dPLM6Eq1b/VYB759eJ8KEHfyF/8Nd1qDHRRTmu+kwDGkWq1AmubATbwY0QC6fP3iy9YM=
X-Received: by 2002:a5d:42ca:: with SMTP id t10mr30022023wrr.274.1615322071763;
 Tue, 09 Mar 2021 12:34:31 -0800 (PST)
MIME-Version: 1.0
References: <CALS+qHMo-XVzXKEfd44E6BG7TPnWKT+r2m7p1wFtFs5XjQApEA@mail.gmail.com>
 <CAJCQCtT38_0Uk7_V-EnfJ-qj4dheJnqVcWEZEKvVRsw6tY5VDg@mail.gmail.com>
 <CAJCQCtRkPa7GSjqOBs95ZsJL04o-FBXhgB6xH5KwP+TgupjCnw@mail.gmail.com>
 <CALS+qHOg89Qtd26NFC4WT+SCv_VxH_k3Erk4=a_pzEMdKZ1Kbw@mail.gmail.com>
 <CAJCQCtRAdn5GsMOGW8VP9K5ysQLepdBT5nt+dtp5UBabQ5yh0A@mail.gmail.com>
 <CALS+qHN8cL1sQt4kjP_n_TrzqO84qV5X-hP2zhnRLjigTq0g2g@mail.gmail.com>
 <CAJCQCtR8pXnfVwrtBEvbvm8qrDwMyqyckZyNNgrSwO8++ShfdA@mail.gmail.com>
 <CALS+qHN7hyFzKZHrMj5_95pPTPR9sEgwqzgVqxFK70fs5FW4xA@mail.gmail.com>
 <CAJCQCtRWRq-AR1+hF03W0q+bG3sO618p6GzTtN1EWCJijzKe9g@mail.gmail.com> <CALS+qHPDYFU2mrzudR8w057Vo33NZ=YsRWJUYmAFUih1pWbz-w@mail.gmail.com>
In-Reply-To: <CALS+qHPDYFU2mrzudR8w057Vo33NZ=YsRWJUYmAFUih1pWbz-w@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 9 Mar 2021 13:34:15 -0700
Message-ID: <CAJCQCtSDsVgrMnunviuAbgC_QFfOTDKdyRD1S=-5-Fbnv3EzBA@mail.gmail.com>
Subject: Re: All files are damaged after btrfs restore
To:     Sebastian Roller <sebastian.roller@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 9, 2021 at 10:03 AM Sebastian Roller
<sebastian.roller@gmail.com> wrote:

> I found 12 of these 'tree roots' on the volume. All the snapshots are
> under the same tree root. This seems to be the subvolume where I put
> the snapshots.

Snapshots are subvolumes. All of them will appear in the root tree,
even if they're organized as being in a directory or in some other
subvolume.

>So for the snapshots there is only one option to use
> with btrfs restore -r.

It can be done by its own root node address using -f or by subvolid
using -r. The latter needs to be looked up in a reliable root tree.
But I think the distinction may not matter here because really it's
the chunk tree that's messed up, and that's what's used to find
everything. The addresses in the file tree (the subvolume/snapshot
tree that contains file listings, inodes, metadata, and the address of
the file) are all logical addresses in btrfs linear space. That means
nothing without the translation to physical device and blocks, which
is the job of the chunk tree.

>But I also found the data I'm looking for under
> some other of these tree roots. One of them is clearly the subvolume
> the backup went to (the source of the snapshots). But there is also a
> very old snapshot (4 years old) that has a tree root on its own. The
> files I restored  from there are different -- regarding checksums.
> They are also corrupted, but different. I have to do some more
> hexdumps to figure out, if it's better.

Unfortunately when things are messed up badly, the recovery tools may
be looking at a wrong or partial checksum tree and it just spits out
checksum complaints as a matter of course. You'd have to inspect the
file contents themselves, the checksum warnings might be real or
bogus.
> > OK this is interesting. There's two chunk trees to choose from. So is
> > the restore problem because older roots point to the older chunk tree
> > which is already going stale, and just isn't assembling blocks
> > correctly anymore? Or is it because the new chunk tree is bad?
>
> Is there a way to choose the chunk tree I'm using for operations like
> btrfs restore?

Looks like the answer is no. The chunk tree really has to be correct
first before anything else because it's central to doing all the
logical to physical address translation. And if it's busted and can't
be repaired then nothing else is likely to work or be repairable. It's
that critical.



> I already ran chunk-recover. It needs two days to finish. But I used
> btrfs-tools version 4.14 and it failed.

I'd have to go dig in git history to even know if there's been
improvements in chunk recover since then. But I pretty much consider
any file system's tool obsolete within a year. I think it's total
nonsense that distributions are intentionally using old tools.

>
> root@hikitty:/mnt$ btrfs rescue chunk-recover /dev/sdf1
> Scanning: DONE in dev0
> checksum verify failed on 99593231630336 found E4E3BDB6 wanted 00000000
> checksum verify failed on 99593231630336 found E4E3BDB6 wanted 00000000
> checksum verify failed on 124762809384960 found E4E3BDB6 wanted 00000000
> checksum verify failed on 124762809384960 found E4E3BDB6 wanted 00000000
> checksum verify failed on 124762809384960 found E4E3BDB6 wanted 00000000
> checksum verify failed on 124762809384960 found E4E3BDB6 wanted 00000000
> bytenr mismatch, want=124762809384960, have=0
> open with broken chunk error
> Chunk tree recovery failed
>
> I could try again with a newer version. (?) Because with version 4.14
> also btrfs restore failed.

It is entirely possible that 5.11 fails exactly the same way because
it's just too badly damaged for the current state of the recovery
tools to deal with damage of this kind. But it's also possible it'll
work. It's a coin toss unless someone else a lot more familiar with
the restore code speaks up. But looking at just the summary change
log, it looks like no work has happened in chunk recover for a while.

https://btrfs.wiki.kernel.org/index.php/Changelog


> > btrfs insp dump-t -t 1 /dev/sdi1
> >
> > And you'll need to look for a snapshot name in there, find its bytenr,
> > and let's first see if just using that works. If it doesn't then maybe
> > combining it with the next most recent root tree will work.
>
> I am working backwards right now using btrfs restore -f in combination
> with -t. So far no success.

Yep. I think it comes down to the chunk tree needing to be reasonable
first, before anything else is possible.


-- 
Chris Murphy

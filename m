Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8426332CC3
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Mar 2021 18:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhCIRDW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Mar 2021 12:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhCIRDL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Mar 2021 12:03:11 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64701C06174A
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Mar 2021 09:03:11 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id p10so12809566ils.9
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Mar 2021 09:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqmWFmoxl8Q9rRhs74uMQblCP73UfYpphOgIi0cUKiQ=;
        b=nlWNOlnv6z++YaG4qKq2eSyoIEQ07NdQ83sHJ7sPFrFC7KD0Aun+ebeMMgweGj4dbb
         RzLOhlIdrpihMPz/s9UqL5M+lvIoE7+tfIA9tknJXJlfRyh7f4JwFOz9Z+lriWaIFrkQ
         Bo9hK8ZT/oY7FXUeogclu4mmNHSDKo+wkQA67SXLTtfsbFX6LH+E4+z2xxZrQXe4opZD
         D0SM7gCS6Nxz2NKaA4ufAc8z788mz/jDiByjEvU1ImwkzE7GiNg2KP0nx2NKGqy4d+n0
         I704+rYuBgt6OHtjx50l2R1iz2Rb6imkBLfCfgPMojdxiGhcJUw8GnQntx6gjxnSe3Ls
         vuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqmWFmoxl8Q9rRhs74uMQblCP73UfYpphOgIi0cUKiQ=;
        b=mFmlmNu4UBuTrVWaJfyTv6OVvF1pxMg2DgpOoc4fDetCGiV8cCiNMTpo4Lg1XYUzQW
         DpQ91FX8sQo8M9PnWsEmCh6NkW3oBzgPwVfVCL+HdZN/wFZZwqzeth+8VLUYBKLnmcd4
         PVdEAgONvCqzZlbFRunhfQ2UI5pVVHRmedpdJpnzjoPiuGMJwA3XJtAeCv4OAAmw95la
         N7dYrwFhgHCrWJU4BGVz384q1N2XcWexqdgtkOMIYPkWt3bY/BAd5ogeZuTH+wLSYew0
         wRpQqRflK/qFRuvf2z0oojOAvMge1uekoLkCf09h3bC8mXbL3gkoL7gevn4uwdGWfRnJ
         UNVQ==
X-Gm-Message-State: AOAM530TEWJLo5GXbih9aqW4Wm1TEI5qUXcizuEifjI0iII8S12oVcio
        C6j120pzvPjyZEsVFFuu++Qg5bP/vIKYwFEfF9O95qLTWw2kBg==
X-Google-Smtp-Source: ABdhPJyV4Lq8phd2Y14MRp24ufkDj8sPK/6xpyap5GHph5i8Q/bLOBxlz4xYEWqfhPMlAfPm2vb+rqdiDBDZWfI4rL4=
X-Received: by 2002:a05:6e02:216f:: with SMTP id s15mr25752514ilv.81.1615309390488;
 Tue, 09 Mar 2021 09:03:10 -0800 (PST)
MIME-Version: 1.0
References: <CALS+qHMo-XVzXKEfd44E6BG7TPnWKT+r2m7p1wFtFs5XjQApEA@mail.gmail.com>
 <CAJCQCtT38_0Uk7_V-EnfJ-qj4dheJnqVcWEZEKvVRsw6tY5VDg@mail.gmail.com>
 <CAJCQCtRkPa7GSjqOBs95ZsJL04o-FBXhgB6xH5KwP+TgupjCnw@mail.gmail.com>
 <CALS+qHOg89Qtd26NFC4WT+SCv_VxH_k3Erk4=a_pzEMdKZ1Kbw@mail.gmail.com>
 <CAJCQCtRAdn5GsMOGW8VP9K5ysQLepdBT5nt+dtp5UBabQ5yh0A@mail.gmail.com>
 <CALS+qHN8cL1sQt4kjP_n_TrzqO84qV5X-hP2zhnRLjigTq0g2g@mail.gmail.com>
 <CAJCQCtR8pXnfVwrtBEvbvm8qrDwMyqyckZyNNgrSwO8++ShfdA@mail.gmail.com>
 <CALS+qHN7hyFzKZHrMj5_95pPTPR9sEgwqzgVqxFK70fs5FW4xA@mail.gmail.com> <CAJCQCtRWRq-AR1+hF03W0q+bG3sO618p6GzTtN1EWCJijzKe9g@mail.gmail.com>
In-Reply-To: <CAJCQCtRWRq-AR1+hF03W0q+bG3sO618p6GzTtN1EWCJijzKe9g@mail.gmail.com>
From:   Sebastian Roller <sebastian.roller@gmail.com>
Date:   Tue, 9 Mar 2021 18:02:34 +0100
Message-ID: <CALS+qHPDYFU2mrzudR8w057Vo33NZ=YsRWJUYmAFUih1pWbz-w@mail.gmail.com>
Subject: Re: All files are damaged after btrfs restore
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> > Would it make sense to just try  restore -t on any root I got with
> > btrfs-find-root with all of the snapshots?
>
> Yes but I think you've tried this and you only got corrupt files or
> files with holes, so that suggests very recent roots are just bad due
> to the corruption, and older ones are pointing to a mix of valid and
> stale blocks and it just ends up in confusion.
>
> I think what you're after is 'btrfs restore -f'
>
>        -f <bytenr>
>            only restore files that are under specified subvolume root
> pointed by <bytenr>
>
> You can get this value from each 'tree root' a.k.a. the root of roots
> tree, what the super calls simply 'root'. That contains references for
> all the other trees' roots. For example:
>
>     item 12 key (257 ROOT_ITEM 0) itemoff 12936 itemsize 439
>         generation 97406 root_dirid 256 bytenr 30752768 level 1 refs 1
>         lastsnap 93151 byte_limit 0 bytes_used 2818048 flags 0x0(none)
>         uuid 4a0fa0d3-783c-bc42-bee1-ffcbe7325753
>         ctransid 97406 otransid 7 stransid 0 rtransid 0
>         ctime 1615103595.233916841 (2021-03-07 00:53:15)
>         otime 1603562604.21506964 (2020-10-24 12:03:24)
>         drop key (0 UNKNOWN.0 0) level 0
>     item 13 key (257 ROOT_BACKREF 5) itemoff 12911 itemsize 25
>         root backref key dirid 256 sequence 2 name newpool
>
>
>
> The name of this subvolume is newpool, the subvolid is 257, and its
> address is bytenr 30752768. That's the value to plug into btrfs
> restore -f

I found 12 of these 'tree roots' on the volume. All the snapshots are
under the same tree root. This seems to be the subvolume where I put
the snapshots. So for the snapshots there is only one option to use
with btrfs restore -r. But I also found the data I'm looking for under
some other of these tree roots. One of them is clearly the subvolume
the backup went to (the source of the snapshots). But there is also a
very old snapshot (4 years old) that has a tree root on its own. The
files I restored  from there are different -- regarding checksums.
They are also corrupted, but different. I have to do some more
hexdumps to figure out, if it's better.

> The thing is, it needs an intact chunk tree, i.e. not damaged and not
> too old, in order to translate that logical address into a physical
> device and physical address.

> > > OK so you said there's an original and backup file system, are they
> > > both in equally bad shape, having been on the same controller? Are
> > > they both btrfs?
> >
> > The original / live file system was not btrfs but xfs. It is in a
> > different but equally bad state than the backup. We used bcache with a
> > write-back cache on a ssd which is now completely dead (does not get
> > recognized by any server anymore). To get the file system mounted I
> > ran xfs-repair. After that only 6% of the data was left and this is
> > nearly completely in lost+found. I'm now trying to sort these files by
> > type, since the data itself looks OK. Unfortunately the surviving
> > files seem to be the oldest ones.
>
> Yeah writeback means the bcache device must survive and be healthy
> before any repair attempts should be made, even restore attempts. It
> also means you need hardware isolation, one SSD per HDD. Otherwise one
> SSD failing means the whole thing falls apart. The mode to use for
> read caching is writethrough.

Hmm. Lessons learned there. This server handles the home-directories
of our personal workstations on which we work on  quite large files (>
5 GiB). So combining write-caching with 2x 10GBit Ethernet was quite
good -- regarding performance.

>
> >         backup 0:
> >                 backup_tree_root:       122583415865344 gen: 825256     level: 2
> >                 backup_chunk_root:      141944043454464 gen: 825256     level: 2
>
>
> >         backup 1:
> >                 backup_tree_root:       122343302234112 gen: 825253     level: 2
> >                 backup_chunk_root:      141944034426880 gen: 825251     level: 2
>
> >         backup 2:
> >                 backup_tree_root:       122343762804736 gen: 825254     level: 2
> >                 backup_chunk_root:      141944034426880 gen: 825251     level: 2
>
> >         backup 3:
> >                 backup_tree_root:       122574011269120 gen: 825255     level: 2
> >                 backup_chunk_root:      141944034426880 gen: 825251     level: 2
>
> OK this is interesting. There's two chunk trees to choose from. So is
> the restore problem because older roots point to the older chunk tree
> which is already going stale, and just isn't assembling blocks
> correctly anymore? Or is it because the new chunk tree is bad?

Is there a way to choose the chunk tree I'm using for operations like
btrfs restore?

> On 72 TB, the last thing I want to recommend is chunk-recover. That'll
> take forever but it'd be interesting to know which of these chunk
> trees is good. The chunk tree is in the system block group. It's
> pretty tiny so it's a small target for being overwritten...and it's
> cow. So there isn't a reason to immediately start overwriting it. I'm
> thinking maybe the new one got interrupted by the failure and the old
> one is intact.

I already ran chunk-recover. It needs two days to finish. But I used
btrfs-tools version 4.14 and it failed.

root@hikitty:/mnt$ btrfs rescue chunk-recover /dev/sdf1
Scanning: DONE in dev0
checksum verify failed on 99593231630336 found E4E3BDB6 wanted 00000000
checksum verify failed on 99593231630336 found E4E3BDB6 wanted 00000000
checksum verify failed on 124762809384960 found E4E3BDB6 wanted 00000000
checksum verify failed on 124762809384960 found E4E3BDB6 wanted 00000000
checksum verify failed on 124762809384960 found E4E3BDB6 wanted 00000000
checksum verify failed on 124762809384960 found E4E3BDB6 wanted 00000000
bytenr mismatch, want=124762809384960, have=0
open with broken chunk error
Chunk tree recovery failed

I could try again with a newer version. (?) Because with version 4.14
also btrfs restore failed.

> btrfs insp dump-t -t 1 /dev/sdi1
>
> And you'll need to look for a snapshot name in there, find its bytenr,
> and let's first see if just using that works. If it doesn't then maybe
> combining it with the next most recent root tree will work.

I am working backwards right now using btrfs restore -f in combination
with -t. So far no success.

Sebastian

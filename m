Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCA633057C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 01:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhCHA5L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Mar 2021 19:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbhCHA4t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Mar 2021 19:56:49 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D799EC06174A
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Mar 2021 16:56:48 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id a25-20020a1cf0190000b029010b1cbe2dd0so2737254wmb.2
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Mar 2021 16:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3t/dWKZGOQWNxy3BuBV6qPdZN3kVYk1NYoL5h4J/aA=;
        b=Xog6x9SFsl8KRVxZNxrXmSxKDE4lMLWSL2bFCaExMAzjYPMIHEcHEJ1G8mUkVpVoVN
         HluS8tDziNi7XDfJFfJ5ALSWzVGTkFMvrA3/Ai++qdskCt0zG1BOw/rQWCdrivwlEk5P
         wzNikiqdT7Rfcku45dRg1Lj0py1ussBSqpdAfVo50fOeUDpRVLMJaW7oCF77ycqGmoi7
         lF6QhF6V9p12wz5IOZREwdun7Omk9uqnZBDFZO60nnV5RSXhiihoFI/SM4dLRPeQ6ATQ
         2iO4Mf4J8LSgz2voBzaiugxZmI0u4rFb+9xUcKPLo9iBzmhm6RxpHGiv1eFseXGmu0hg
         CXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3t/dWKZGOQWNxy3BuBV6qPdZN3kVYk1NYoL5h4J/aA=;
        b=qXlBrArIqIwXh4mQTLfB44b5AzLGrE3PsEIOJLD6XxkwDz+QmVvbh4MctcC2EpgonU
         k0BRqOaGkF399E4W2qhmuyiViCx6yOETGtsp0U+wLC+RJ9l9T2yZ3oKfX4qls6NYejKS
         9OXS9PfUV4wYOnDLvFLN5rKunu8683o60WAbIseY1Iflpc2MXtoZ/jm6SmkNhTGhQBOu
         Mi145aS6l4XYR1QUWvtTUWj0/DMoNm1Oc5QdrwDddaMBGPdZj35+YLHRyEhIywd4iV+y
         p/nH2kFv+Q8/CNgD4IR9SfksH98vRrElbOCVnvQLjMbsO5c/18+Pv+FNw763HUGEU/IJ
         QAOw==
X-Gm-Message-State: AOAM532YbB661Xu5KaIpGYOOE8m2hd5FbhH/a40yJLb+u4jVS3LPCXdu
        BK9CixO/WMTrUhvXW+34iNDa/D+Klqfszzef2JwWEg==
X-Google-Smtp-Source: ABdhPJz7Nv4kT/dBmMBgrdXs7UbzbKEQc4Z2oYzdmkpPiCqjOJrllzFF11hzKDR2W3UEJCxo+6ukIFM2vWoAW0Bfo1k=
X-Received: by 2002:a1c:bdc2:: with SMTP id n185mr19889915wmf.128.1615165006595;
 Sun, 07 Mar 2021 16:56:46 -0800 (PST)
MIME-Version: 1.0
References: <CALS+qHMo-XVzXKEfd44E6BG7TPnWKT+r2m7p1wFtFs5XjQApEA@mail.gmail.com>
 <CAJCQCtT38_0Uk7_V-EnfJ-qj4dheJnqVcWEZEKvVRsw6tY5VDg@mail.gmail.com>
 <CAJCQCtRkPa7GSjqOBs95ZsJL04o-FBXhgB6xH5KwP+TgupjCnw@mail.gmail.com>
 <CALS+qHOg89Qtd26NFC4WT+SCv_VxH_k3Erk4=a_pzEMdKZ1Kbw@mail.gmail.com>
 <CAJCQCtRAdn5GsMOGW8VP9K5ysQLepdBT5nt+dtp5UBabQ5yh0A@mail.gmail.com>
 <CALS+qHN8cL1sQt4kjP_n_TrzqO84qV5X-hP2zhnRLjigTq0g2g@mail.gmail.com>
 <CAJCQCtR8pXnfVwrtBEvbvm8qrDwMyqyckZyNNgrSwO8++ShfdA@mail.gmail.com> <CALS+qHN7hyFzKZHrMj5_95pPTPR9sEgwqzgVqxFK70fs5FW4xA@mail.gmail.com>
In-Reply-To: <CALS+qHN7hyFzKZHrMj5_95pPTPR9sEgwqzgVqxFK70fs5FW4xA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 7 Mar 2021 17:56:30 -0700
Message-ID: <CAJCQCtRWRq-AR1+hF03W0q+bG3sO618p6GzTtN1EWCJijzKe9g@mail.gmail.com>
Subject: Re: All files are damaged after btrfs restore
To:     Sebastian Roller <sebastian.roller@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 7, 2021 at 6:58 AM Sebastian Roller
<sebastian.roller@gmail.com> wrote:
>
> Would it make sense to just try  restore -t on any root I got with
> btrfs-find-root with all of the snapshots?

Yes but I think you've tried this and you only got corrupt files or
files with holes, so that suggests very recent roots are just bad due
to the corruption, and older ones are pointing to a mix of valid and
stale blocks and it just ends up in confusion.

I think what you're after is 'btrfs restore -f'

       -f <bytenr>
           only restore files that are under specified subvolume root
pointed by <bytenr>

You can get this value from each 'tree root' a.k.a. the root of roots
tree, what the super calls simply 'root'. That contains references for
all the other trees' roots. For example:

    item 12 key (257 ROOT_ITEM 0) itemoff 12936 itemsize 439
        generation 97406 root_dirid 256 bytenr 30752768 level 1 refs 1
        lastsnap 93151 byte_limit 0 bytes_used 2818048 flags 0x0(none)
        uuid 4a0fa0d3-783c-bc42-bee1-ffcbe7325753
        ctransid 97406 otransid 7 stransid 0 rtransid 0
        ctime 1615103595.233916841 (2021-03-07 00:53:15)
        otime 1603562604.21506964 (2020-10-24 12:03:24)
        drop key (0 UNKNOWN.0 0) level 0
    item 13 key (257 ROOT_BACKREF 5) itemoff 12911 itemsize 25
        root backref key dirid 256 sequence 2 name newpool



The name of this subvolume is newpool, the subvolid is 257, and its
address is bytenr 30752768. That's the value to plug into btrfs
restore -f

The thing is, it needs an intact chunk tree, i.e. not damaged and not
too old, in order to translate that logical address into a physical
device and physical address.





>
> > OK so you said there's an original and backup file system, are they
> > both in equally bad shape, having been on the same controller? Are
> > they both btrfs?
>
> The original / live file system was not btrfs but xfs. It is in a
> different but equally bad state than the backup. We used bcache with a
> write-back cache on a ssd which is now completely dead (does not get
> recognized by any server anymore). To get the file system mounted I
> ran xfs-repair. After that only 6% of the data was left and this is
> nearly completely in lost+found. I'm now trying to sort these files by
> type, since the data itself looks OK. Unfortunately the surviving
> files seem to be the oldest ones.

Yeah writeback means the bcache device must survive and be healthy
before any repair attempts should be made, even restore attempts. It
also means you need hardware isolation, one SSD per HDD. Otherwise one
SSD failing means the whole thing falls apart. The mode to use for
read caching is writethrough.


>         backup 0:
>                 backup_tree_root:       122583415865344 gen: 825256     level: 2
>                 backup_chunk_root:      141944043454464 gen: 825256     level: 2


>         backup 1:
>                 backup_tree_root:       122343302234112 gen: 825253     level: 2
>                 backup_chunk_root:      141944034426880 gen: 825251     level: 2

>         backup 2:
>                 backup_tree_root:       122343762804736 gen: 825254     level: 2
>                 backup_chunk_root:      141944034426880 gen: 825251     level: 2

>         backup 3:
>                 backup_tree_root:       122574011269120 gen: 825255     level: 2
>                 backup_chunk_root:      141944034426880 gen: 825251     level: 2

OK this is interesting. There's two chunk trees to choose from. So is
the restore problem because older roots point to the older chunk tree
which is already going stale, and just isn't assembling blocks
correctly anymore? Or is it because the new chunk tree is bad?

On 72 TB, the last thing I want to recommend is chunk-recover. That'll
take forever but it'd be interesting to know which of these chunk
trees is good. The chunk tree is in the system block group. It's
pretty tiny so it's a small target for being overwritten...and it's
cow. So there isn't a reason to immediately start overwriting it. I'm
thinking maybe the new one got interrupted by the failure and the old
one is intact.

Ok so the next step is to find a snapshot you want to restore.

btrfs insp dump-t -t 1 /dev/sdi1

And you'll need to look for a snapshot name in there, find its bytenr,
and let's first see if just using that works. If it doesn't then maybe
combining it with the next most recent root tree will work.


-- 
Chris Murphy

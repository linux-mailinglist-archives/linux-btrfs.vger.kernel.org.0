Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD03B39C620
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Jun 2021 08:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFEF7t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Jun 2021 01:59:49 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:40670 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhFEF7t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Jun 2021 01:59:49 -0400
Received: by mail-lf1-f54.google.com with SMTP id w33so17288722lfu.7
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Jun 2021 22:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/TMKt1vz2yxQfR44nraDhRCGhELOpEPek0prmsDDnQ=;
        b=U0bYlY9CIKmU+RKKaruKPZwuMf6rmcpuVjAFeslsoHqKhSWEYrW6AXWXy5/wLzLH5f
         wHXKsJSWCEAb4UDvlxbRVsrCt+FsYsYh7sIya06rFVtaq1trE9d5piXwzd3oIelmq131
         I7B+t9DVhEdcaAdJPCVyENb1ynnlrsExT01E2enCHDMZ1++C/VH5iONqDnpbPltoXsBm
         wJdQijM+vY6ykOzOlpMGHBHTJ727URBRZGqGn/jdTOMsZ0++QMCWKWl4sAlsoOd5mUtp
         9tLqUROU+XbFUX38kkqStI7FrSiLQeMvMLs9OHepNfdhaTS2OImEl9NiATgb6lrAL2U+
         eUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/TMKt1vz2yxQfR44nraDhRCGhELOpEPek0prmsDDnQ=;
        b=iw7f9RtDW2fBSgE8XnSNaN7s+IsxRi4zRiLvze6usvyT2LazPZJk4GKzlsxVAoJFqv
         t1jw9N6JjJvffOHfUfVGLymjhjey4uJUHj9BTsDozsBGlxGrmPNjHG4ORyHXjmzQWDE3
         VCKtsQO7UcCZeyUR4hSfqChDoTOBzwlNo0QAz8JJRAlb2jBrN2aClGOxijlEZbAMuntW
         jQnnVLYICtj93UgtMMO3C1dckpmkr+C03yJTjDGfzCfWSBd0GB4Tn0xw5KUZriypcHp7
         XJU6uGQKpAuPxAFrG6ZutVvEnp5rGMvaPEjCoPJB8cQclo7SOa1q46J2Ep+eL59N45eo
         mlPw==
X-Gm-Message-State: AOAM532JWmhL9/qDBSdESIiXYkHyGE3ElCYEyA6PZ2lTprM5vJPkvRWh
        sQFAtr6uZ3MFcJ/SkpPJUmsgtKKh6CnA1mP++I+p9g/Crqs=
X-Google-Smtp-Source: ABdhPJyHU32dhvrw9keJqUTgxXDv4yjMNaeFj3S57E7F7/PVyBl83SPnYAnlMCLe71AGwWkVrYC5j2KFzcB9UQ1gIHo=
X-Received: by 2002:a05:6512:1327:: with SMTP id x39mr5050278lfu.37.1622872620963;
 Fri, 04 Jun 2021 22:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnHSEkr0N_hnxvm89prL3vObYgvVoPFHLL4Z7wnQCSem6hB_A@mail.gmail.com>
 <CAGnHSEkeu1hW-7YQO0HrYK__aY-eMdxfgSbcOTvnMu3jUcu4iw@mail.gmail.com> <20210604201630.GH11733@hungrycats.org>
In-Reply-To: <20210604201630.GH11733@hungrycats.org>
From:   Tom Yan <tom.ty89@gmail.com>
Date:   Sat, 5 Jun 2021 13:56:49 +0800
Message-ID: <CAGnHSEk-+2tA21+sN4dioYbs_u4m_NiLPkG8u6ONJS=JbCACoA@mail.gmail.com>
Subject: Re: reflink copying does not check/set No_COW attribute and fail
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org, bug-coreutils@gnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As far as I'm concerned, inheriting an attribute from the source inode
isn't a "surprising" behavior. Rather it seems pretty "natural" to me.
And I don't think whether the attribute is "dangerous" changes that,
because if you consider it "dangerous", shouldn't you "watch out"
anyway when you try to make a clone of a source with such an
attribute?

If we see it from the way that, the kernel does not make the
destination inherit nodatasum just to make reflink succeed as much as
possible, but rather it just by design inherit nodatacow (for the
reason of being NOT surprising), then there's no concern in whether
they should "decoupled" when we implement the inheritance. (Like we
can't set only nodatasum with `chattr either. It's simply out of the
scope then.)

I don't know if we can do that based on whether the reflink mode is
always. Though we can fallback to "normal" copy when the source has
nodatasum (and/or nodatacow), personally I don't find it less
surprising than inheriting nodatacow all the time.

By the way, what will `chattr -C` do exactly if the file/inode had
nodatacow? Is the behavior different when it is / there is a reflink?

On Sat, 5 Jun 2021 at 04:16, Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Fri, Jun 04, 2021 at 10:37:35PM +0800, Tom Yan wrote:
> > Also cc'ing bug-coreutils@gnu.org.
> >
> > On Fri, 4 Jun 2021 at 22:33, Tom Yan <tom.ty89@gmail.com> wrote:
> > >
> > > Hi all,
> > >
> > > I've just bumped into a problem that I am not sure what the expected
> > > behavior should be, but there seems to be something flawed.
> > >
> > > Say I have a file that was created with the No_COW attributed
> > > (inherited from the directory / subvolume / mount option). Then if I
> > > try to do a reflink copy, the copying will fail with "Invalid
> > > argument" if the copy has no one to inherit the No_COW attribute from.
>
> Correct.  nodatacow implies nodatasum, and you cannot reflink an extent
> from a nodatasum inode into a datasum inode.
>
> The result of allowing this would be a file that has some extents
> that have csums, and some that do not.  Making this work would make
> reading from such a file worse (i.e. make it slower, or fail to detect
> corruption in metadata).  It's possible to solve some of those problems
> (or at least contain them in inodes that are known to have mixed csum
> and non-csum data), but first someone would have to make the case that
> this is worth the effort to support.
>
> > > For example:
> > > [tom@archlinux mnt]$ sudo btrfs subvol list .
> > > ID 256 gen 11 top level 5 path a
> > > ID 257 gen 9 top level 5 path b
> > > [tom@archlinux mnt]$ lsattr
> > > ---------------------- ./a
> > > ---------------C------ ./b
> > > [tom@archlinux mnt]$ lsattr b/
> > > ---------------C------ b/test
> > > [tom@archlinux mnt]$ du -h b/test
> > > 512M    b/test
> > > [tom@archlinux mnt]$ lsattr a/
> > > [tom@archlinux mnt]$ cp --reflink=always b/test a/
> > > cp: failed to clone 'a/test' from 'b/test': Invalid argument
> > > [tom@archlinux mnt]$ lsattr a/
> > > ---------------------- a/test
> > > [tom@archlinux mnt]$ du a/test
> > > 0    a/test
> > > [tom@archlinux mnt]$ du --apparent-size a/test
> > > 0    a/test
> > > [tom@archlinux mnt]$ rm a/test
> > > [tom@archlinux mnt]$ sudo chattr +C a/
> > > [tom@archlinux mnt]$ cp --reflink=always b/test a/
> > > [tom@archlinux mnt]$ lsattr a/
> > > ---------------C------ a/test
> > > [tom@archlinux mnt]$ cmp b/test a/test
> > > [tom@archlinux mnt]$
> > >
> > > I'm not entirely sure if a reflink copy is supposed to work for a
> > > source file that was created with No_COW, but apparently it is.
>
> Snapshots are also allowed for nodatacow files.  The extents that are
> shared become implicitly datacow until they are not shared any more.
>
> Snapshots are deferred reflink copies, so it would be difficult to
> allow one and not the other.  Disallowing both seems overly restrictive
> (e.g. with such a restriction, it would not be possible to use 'btrfs
> send' or make a snapshot on a subvol that contains any nodatacow file).
>
> btrfs did disallow both operations for swap files, so it could be possible
> to disallow both reflinks and snapshots for nodatacow files, but AFAIK
> nobody wants that (some people even want the swapfile restrictions to
> go away someday).
>
> > > The
> > > problem is just that the reflink copy also needs to have the attribute
> > > set, yet it cannot inherit from the source automatically.
>
> reflink can only reflink copy from one nodatasum file to another nodatasum
> file, or from one datasum file to another datasum file.
>
> An empty inode can be changed from datacow to nodatacow (or vice versa)
> using the fsattr ioctl, which simultaneously changes the file from
> datasum to nodatasum if the filesystem was not mounted with the nodatasum
> mount option.
>
> There is a possible kernel enhancement here:  when an empty inode is the
> dst of a reflink, automatically change the reflink dst inode's nodatasum
> flag to match the reflink src inode's nodatasum flag.  If the dst inode
> is not empty and the inode datasum flags do not match, then reject the
> reflink with EINVAL as before.
>
> It's not clear whether this should apply only to nodatasum or also to
> nodatacow.  reflink doesn't need src and dst agreement on nodatacow,
> so the dst inode could be a nodatasum+datacow file.  Unfortunately all
> the userspace tools including coreutils can only see the nodatacow
> inode bit, not the nodatasum bit, so the lack of csums on the dst file
> would be invisible.  The kernel cannot know the user's intent from the
> available information.
>
> It's not clear that we want the kernel to be implicitly changing
> inode attribute bits like this--especially bits that disable integrity
> features like nodatasum.  There is precedent for changing fsattrs with
> the no-compress inode flag, but that flag doesn't disable csums, and
> this one would.
>
> One could also make the opposite case:  it should always be an error to
> do anything that would put data in a datasum file without csums, the
> existing behavior is correct, and should not be changed.  The problem
> with this argument is that users can't see the datasum inode bits,
> so it's not clear that the EINVAL is a data protection mechanism.
>
> > > I wonder if this is a kernel-side problem or something that coreutils
> > > missed? It also seems wrong that when it fails there will be an empty
> > > destination file created.
>
> Normally coreutils will fall back to simple copy if --reflink=auto
> is used.  --reflink=always is the user's explicit request for "reflink
> or nothing, please."  The user correctly got nothing, as requested.
>
> On other filesystems, reflink on a nodatacow file might make a simple
> copy in the kernel--in which case you are no better off than if you had
> used --reflink=auto.
>
> coreutils could propagate the source inode nodatacow fsattribute to
> the destination inode if it intends to use reflink to copy the data.
> That would be the userspace equivalent of the kernel enhancement I
> suggested above.  It would probably match user expectations better--no
> hidden surprises for non-coreutils use cases, and all the affected inode
> attribute bits are necessarily visible in userspace.
>
> fsattr propagation could be quite complicated for coreutils to implement
> correctly in general, as some fsattrs should not be propagated this way,
> and other filesystems may have different restrictions.  Some fsattrs must
> be set before the data is written (e.g. -c for compression), others must
> be set after the data is written (e.g. -i for immutable), and some are
> a matter of user intent (e.g. should a simple copy be compressed if the
> source is not?  Depends on the intended use of the copy).
>
> On other filesystems this userspace behavior might trigger the opposite
> of the intended kernel behavior, causing reflink to always fall back to
> simple copy because the dst inode's nodatacow attribute is set.
>
> Ideally btrfs will not force coreutils to do one thing on btrfs and the
> opposite thing on other filesystems, so it might be worthwhile to hack
> around this in the kernel as proposed above.  There is precedent for
> that--btrfs falls back to simple copy in reflinks of inline extents,
> more or less for the sole purpose of making cp --reflink=always not fail
> so randomly.
>
> > > Kernel version: Linux archlinux 5.12.8-arch1-1 #1 SMP PREEMPT Fri, 28
> > > May 2021 15:10:20 +0000 x86_64 GNU/Linux
> > > Coreutils version: 8.32
> > >
> > > Regards,
> > > Tom

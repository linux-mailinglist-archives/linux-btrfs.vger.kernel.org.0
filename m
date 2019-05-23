Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E29B28433
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2019 18:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbfEWQq5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 May 2019 12:46:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35562 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731042AbfEWQq5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 May 2019 12:46:57 -0400
Received: by mail-lf1-f66.google.com with SMTP id c17so4918068lfi.2
        for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2019 09:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VflfizDzrT/K5gSDv2UvNZqEdm0gc3E5ZGvNXO7kz18=;
        b=rJjtKudchWY6IPlSx6ufE3fGM1sQLg0ewsF6puKrNykd/7sLK2pATUdWXU6HByOWiQ
         XAgnA9XSo8kVWMbZ/62SgYt6RCyE14EGzZKBrBp2Nn+3H1v/7fdaxDk4V3Kpq08c5R1L
         GI1xBetp5VdCtZkTRdTafXjLRpyEgWKngjlswtS1+AMX2w2rFqofgcizGAnplp5cdv4r
         0idZ9K7bAuuzPlxCzBpM7zYcGM5Q+ElFi+lnh5DSHStQ6LSlA1xpVvn8k9KOjPcTmXBg
         m39HCTvLthOtRTP7gWU8SCCtZA1P0b8RAAi6FPFq5Yo4H/m4Zde+EgSYTVQSrICRrP8U
         ZgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VflfizDzrT/K5gSDv2UvNZqEdm0gc3E5ZGvNXO7kz18=;
        b=BlZCuZM1rsJl1l89maT97IGiUsacTDyCMbFXOvSEk8F7t0K/cjNG5QgbWmQlFU9wUY
         iD1joAyKntq5E0PjGeyEvwf0Rnjxyfegb8dd6mLCWs//SwwG/JKrna7OPlAREm0VeOCY
         wi2kjWCUvHqElIIMGTRX1uO91EqyED5cWIa4mIIr130NcHEPzXGQ7Mo9T+lHNEKU5ofU
         EqnyO1sFLduBv3rBLnUOx/NZR6vtQvN/ZePNRj84w0CKgLIzPoJ+Plu2fFvt/roC6uen
         /LBiUPGP6TLFUIt7zEW9vjhp5PieOW6EPwdn5hYxkkR5BdN7rX78FiuUnr3amSzROvO9
         K+lw==
X-Gm-Message-State: APjAAAXSaPO8SrEqae0uRALpfCBZqcOVvv83f622gNMs8fEUC5WcN9LH
        zDilq65mXtMc4gwH3K8rI8fkqUhewx9DUzMa0wVVnw==
X-Google-Smtp-Source: APXvYqxZN8Afh8Ld3iM8rTBLTib1gMam4yIbfOs2Q2J37Gzb39Kn1ra2tByby8l5OliqQilLvb7ooDEN9U6eqg0BxEw=
X-Received: by 2002:a19:9150:: with SMTP id y16mr1314154lfj.106.1558630016208;
 Thu, 23 May 2019 09:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAN4oSBeEU+rmCS8+WwriGz0KoPR=Xa6KvjH=gGriFaxVNZHf6Q@mail.gmail.com>
 <8ccec20a-04b1-4a84-6739-afd35b4ab02e@gmail.com> <CAJCQCtTp5d+VxsQmVv68VdmCsxSVpi-_c6LJjS_T=xx3GXz9Fg@mail.gmail.com>
 <20190523163452.GB10771@angband.pl>
In-Reply-To: <20190523163452.GB10771@angband.pl>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 23 May 2019 10:46:45 -0600
Message-ID: <CAJCQCtTX+=U1B2a9ykqyRYD3=BBaXQTbDa_s=kpBcEiKStzm+w@mail.gmail.com>
Subject: Re: Citation Needed: BTRFS Failure Resistance
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Chris Murphy <lists@colorremedies.com>,
        "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 23, 2019 at 10:34 AM Adam Borowski <kilobyte@angband.pl> wrote:
>
> On Thu, May 23, 2019 at 10:24:28AM -0600, Chris Murphy wrote:
> > On Thu, May 23, 2019 at 5:19 AM Austin S. Hemmelgarn
> > > BTRFS explicitly requests write barriers to prevent that type of
> > > reordering of writes from happening, and it's actually pretty unusual on
> > > modern hardware for those write barriers to not be honored unless the
> > > user is doing something stupid (like mounting with 'nobarrier' or using
> > > LVM with write barrier support disabled).
> >
> > 'man xfs'
> >
> >        barrier|nobarrier
> >               Note: This option has been deprecated as of kernel
> > v4.10; in that version, integrity operations are always performed and
> > the mount option is ignored.  These mount options will be removed no
> > earlier than kernel v4.15.
> >
> > Since they're getting rid of it, I wonder if it's sane for most any
> > sane file system use case.
>
> A volatile filesystem: one that you're willing to rebuild from scratch (or
> backups) on power loss.  This includes any filesystem in a volatile VM.
>
> Example use case: a build machine, where the build filesystem wants btrfs
> for snapshots (the build environment several minutes to recreate), yet with
> the environment recreated weekly, a crash can be considered an additional
> start of a week. :)
>
> Or, some clusters consider a crashed node to be dead and needing rebuild;
> the filesystem's contents will be cloned from a master anyway.
>
> In all of these cases, fsyncs can be ignored as well.

I would not mind a mount option to ignore application fsync and
fdatasync, while maintaining the Btrfs data->metadata->super write
order guarantee. I'd expect that would be a more commonly preferred
use case than volatile/disposable file systems. But what do you
suppose the real world performance increase is between the former and
latter?


-- 
Chris Murphy

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6FCBA4690
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Sep 2019 01:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfHaXjr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Aug 2019 19:39:47 -0400
Received: from augustus.math.duke.edu ([152.3.25.8]:32916 "EHLO math.duke.edu"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728327AbfHaXjr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Aug 2019 19:39:47 -0400
X-Virus-Scanned: amavisd-new at math.duke.edu
Received: from [192.168.101.7] (cpe-76-182-105-20.nc.res.rr.com [76.182.105.20])
        (authenticated bits=0)
        by math.duke.edu (8.14.4/8.14.4) with ESMTP id x7VNdjoW027903
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 31 Aug 2019 19:39:46 -0400
Message-ID: <cab4c26799caa8f4f9516124b5448840245a2811.camel@math.duke.edu>
Subject: Re: block corruption
From:   Rann Bar-On <rann@math.duke.edu>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Date:   Sat, 31 Aug 2019 19:39:45 -0400
In-Reply-To: <CAJCQCtQRDfMb6=RtT5rNDSj_QT_nJXYx3C-Zzi9baPykHTrDDA@mail.gmail.com>
References: <bdd368bc2e910523525c54844c5c47dd877f1a0d.camel@math.duke.edu>
         <98252ab04af29eecf51b6c9ecb7f258df56c93ba.camel@math.duke.edu>
         <CAJCQCtQRDfMb6=RtT5rNDSj_QT_nJXYx3C-Zzi9baPykHTrDDA@mail.gmail.com>
Organization: Duke University Mathematics Department
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Sat, 2019-08-31 at 17:04 -0600, Chris Murphy wrote:
> On Sat, Aug 31, 2019 at 2:26 PM Rann Bar-On <rann@math.duke.edu>
> wrote:
> > I just downgraded to kernel 4.19, and the supposed corruption
> > vanished.
> > This may be related to
> > 
> > https://www.spinics.net/lists/linux-btrfs/msg91046.html
> > 
> > If I can provide information that would help fix this issue, I'd be
> > glad to, but I cannot upgrade back to kernel 5.2, as I can't risk
> > this
> > system.
> 
> 5.2 has more strict checks for corruption, exposing the rare case
> where metadata in a leaf is corrupt but the checksum was properly
> computed.
> 
> > > Btrfs v3.17
> 
> This is old. I suggest finding a newer version of btrfs-progs,
> ideally
> latest stable version is 5.2.1. Definitely don't use --repair with
> this version. It's safe to use check --readonly (which is the
> default)
> with this version but probably not that helpful to devs.
> 

Not really sure why that said 3.17:

$ btrfs --version
btrfs-progs v5.2.1 

Anyway, running btrfs --repair on the file system didn't do anything to
fix the above errors.

I removed at least one of the corrupt files (the only one that was mode
0) using kernel 4.19.

Happy to help further if I can. What would you suggest as far as fixing
this or reporting it usefully? If you believe 5.2 isn't causing the
corruption, but rather, just exposing it, I'm more than happy to
experiment with it.

Rann

> 


> 


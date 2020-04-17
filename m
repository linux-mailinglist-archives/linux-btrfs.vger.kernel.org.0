Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033481AD45C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 04:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgDQCMe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 22:12:34 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.36]:25088 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728969AbgDQCMd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 22:12:33 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 0C7B2400C9276
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 21:12:32 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id PGUajiHyg1s2xPGUajLSa4; Thu, 16 Apr 2020 21:12:32 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=id2ptJnAXOCcmAaHxMs6pbDtap1U6usfKCBZCAa0PLc=; b=Iqz6xb0ZTEj4EBFwBeFrIAs8m4
        Z08+UdO+Okn6w5jvimov7Y6emF53VDYMhjMMwMxOduujs60kc+rkSy+e19EeIjpMzSNMC9QgfSUBH
        TRdRdheoGphIXySx98JZVn38Jn10S7o0FKGrbd2tDWqNtb+m/jx1kCmWgArlPTosBzCnvd/TAbUu3
        8HScXN+dYGDKvcnAqIwFEvSyxXi1GAIAVRji34rrM8lSJRGp5nxiF+x5Dhu8KXz8+OrbGMt8trWaT
        MpUVDRE8YwYE9utOJuw+/vdC/NbG/tuAM95KXfYl08o3/A7Slk9QwzS25gI5kXz+B9Y9G5DxN5UIG
        2HWtMaMA==;
Received: from [177.132.134.142] (port=51354 helo=[192.168.0.172])
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jPGUZ-002j8A-HC; Thu, 16 Apr 2020 23:12:31 -0300
Message-ID: <b1854ac17381cda81e40b29fd8d4035d798b908c.camel@mpdesouza.com>
Subject: Re: [PATCHv3 0/3] btrfs-progs: Auto resize fs after device replace
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     devel@roosoftl.ltd.uk,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Thu, 16 Apr 2020 23:15:48 -0300
In-Reply-To: <706b6fae-94d6-62bf-d52e-d0db057e3bd3@casa-di-locascio.net>
References: <20200416004642.9941-1-marcos@mpdesouza.com>
         <706b6fae-94d6-62bf-d52e-d0db057e3bd3@casa-di-locascio.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 177.132.134.142
X-Source-L: No
X-Exim-ID: 1jPGUZ-002j8A-HC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.172]) [177.132.134.142]:51354
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 1
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 2020-04-16 at 07:18 +0100, devel@roosoftl.ltd.uk wrote:
> On 16/04/2020 01:46, Marcos Paulo de Souza wrote:
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> >
> > Changes from v2:
> > * Fixed the code format after moving function resize_filesystem in
> patch 0001
> >   (suggested by David)
> > * Sorted the resize_filesystem function prototype in patch 0001
> (suggested by
> >   David)
> > * Changed the -a into long argument --autoresize in patch 0002
> (suggested by
> >   David)
> > * Translate srcdev if the argument is not a devid (suggested by
> David)
> > * This also changes the way we use the ioctl, now only passing
> devid to the
> >   kernel, instead of passing the path and letting the kernel to
> translate
> > * Add tests to check the autoresize functionality
> >
> > Changes from v1:
> > * Reworded the help message and the docs telling the user that the
> fs will be
> >   resized to it's max size (suggested by Qu)
> > * Added a warning message saying that the resize failed, asking the
> user to
> >   resize manually. (suggested by Qu)
> >
> > Both changes were done only in patch 0002.
> >
> > Anand suggested this job to be done in kernel side, atomically, but
> as I
> > received a good review from Qu I decided to send a v3 of this
> patchset.
> >
> > Please review, thanks!
> >
> > Original cover-letter[1]:
> > These two patches make possible to resize the fs after a successful
> replace
> > finishes. The flag -a is responsible for doing it (-r is already
> use, so -a in
> > this context means "automatically").
> >
> > The first patch just moves the resize rationale to utils.c and the
> second patch
> > adds the flag an calls resize if -a is informed replace finishes
> successfully.
> >
> > Please review!
> >
> > Marcos Paulo de Souza (3):
> >   btrfs-progs: Move resize into functionaly into utils.c
> >   btrfs-progs: replace: New argument to resize the fs after replace
> >   btrfs-progs: tests: misc: Add some replace tests
> >
> >  Documentation/btrfs-replace.asciidoc        |   5 +-
> >  cmds/filesystem.c                           |  58 +----------
> >  cmds/replace.c                              | 105 +++++++++++++---
> ----
> >  common/utils.c                              |  60 +++++++++++
> >  common/utils.h                              |   2 +
> >  tests/misc-tests/039-replace-device/test.sh |  56 +++++++++++
> >  6 files changed, 192 insertions(+), 94 deletions(-)
> >  create mode 100755 tests/misc-tests/039-replace-device/test.sh
> >
> Hmm,
> 
> 
> Does this take into account if different raid levels are used for
> data
> and meta data. When I last was upgrading a fs with larger drive it
> was
> not just a case of making the over all file size different I had to
> also
> change the ratio of metadata to data. And then I had to balance a
> whole
> lot (which found a bug in memory at the time)

What do you mean about "ratio of metadata to data"? The new disk will
receive the same content of the old disk, so, it the metadata wasn't
balanced before the replace, it might be a good idea to execute balance
after adding a maybe larger disk.

Can you please describe in more details you problem, or the problem you
had at the time you did the replace last time? It seems it's not
related to the resize itself, so these patches do not change the
current behavior.

> 
> 
> How do you deal with these edge cases ? Especially if you replacing
> with
> a smaller disk and then have to shrink the metadata ratio?

Replace does not accept a smaller disk to replace a larger one.

> 
> 
> Just curious.

Me too. These patches were meant to help people to avoid executing two
different command for a pretty common action, all details behind
replace and resize are the same, it's just a "helper" to make users to
use the full capacity of a newly added disk.


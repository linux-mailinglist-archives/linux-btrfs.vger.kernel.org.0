Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1E32A5989
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 23:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbgKCUlI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 3 Nov 2020 15:41:08 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:51043 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730300AbgKCUlG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 15:41:06 -0500
Received: from [192.168.177.174] ([91.63.191.240]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1Ma1D8-1koKqo34tg-00VwZC; Tue, 03 Nov 2020 21:40:30 +0100
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>,
        lakshmipathi.ganapathi@collabora.com
Subject: Re[2]: parent transid verify failed: Fixed but re-appearing
Cc:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Date:   Tue, 03 Nov 2020 20:40:40 +0000
Message-Id: <em37950c9c-2dbf-41b9-89cd-2390bc503bd1@desktop-g0r648m>
In-Reply-To: <20201103194045.GB28049@hungrycats.org>
References: <em2ffec6ef-fe64-4239-b238-ae962d1826f6@ryzen>
 <20201021134635.GT5890@hungrycats.org>
 <em85884e42-e959-40f1-9eae-cd818450c26d@ryzen>
 <20201021193246.GE21815@hungrycats.org>
 <em33511ef4-7da1-4e7c-8b0c-8b8d7043164c@desktop-g0r648m>
 <20201021212229.GF21815@hungrycats.org>
 <emeabab400-3f6d-4105-a4fd-67b0b832f97a@desktop-g0r648m>
 <20201021213854.GG21815@hungrycats.org>
 <em26d5dfe8-37cb-454c-9c03-a69cfb035949@desktop-g0r648m>
 <emf9252c3e-00b0-4c4a-a607-b61df779742f@desktop-g0r648m>
 <20201103194045.GB28049@hungrycats.org>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/8.0.3385.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:aUGDKZLIYT0M7ln2X35KffGtM5m2z3nhJ6eWJ4iETnsPXBTgpSW
 4d8tEu89RO+dwCEXngYrz0v/k2MFD2x2x+mm/0q5LYkf4GEtVVUR+AenZi4rOJdBC/JcImc
 GTOrFwCEB70P3haQamikCfGL6xVtJRyx7rnIYmFOHDivMhDKdONbe0Y+cEA2aOPX3Jd18nZ
 jR5R8u6YrKTBSWJmMmTRQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7nrBFJZPP7E=:Mwi2yZfIcGV3di+PZiLO2k
 ZOZzd46tec+QEe7iLRNrKgss+xvcEW+ve1zK3l4DhCNjd0ZfiDxss/EztxZcD6rHEL2KUJHvX
 KNBw4VDKWyoTxbUaF76gjAuuGlrCGjzB1cFr1wBFzdMyY9Q+vweHEM6jvlSyNEKO8+iAKPC6A
 RMAM5ir+9k47HTfHLA+KoYTPOvT+0hneD5vwZT43HjKACL6xygSbIF3ssMxcQslNIR7PV4DDm
 KuTPFb/LaktPPNSFgNk8p+uozz/gfADcxq+cVIDPungBGOWb9mY9Sf80YE2X/QPSv0SaGGUMf
 MHWvvtpt7MiRv1Opj97sdi7HK0ijnbcPC5fH9NJy1PWfrcvFJf8PLO3VgpSz6DD6lHjYwY7Aa
 PoC0f2hvi11aOO3xejKvyxqDBzyvvII+zq/t7my2MURVFt4SYFOP2KB60f5JIzNf4BDzW/436
 xAbTj1Havw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Zygo, hello Lakshmipathi,

@Lakshmipathi: as you suggested I consulted the BTRFS-Mailing list on 
this issue:
https://github.com/Lakshmipathi/dduper/issues/39

Zygo was so kind to help me and he suspects the error to lie within 
dduper.
>>  > > Sure, more scrubs are better.  They are supposed to be run regularly
>>  > > to detect drives going bad.
>>  > btrfs scrub start -Bd /dev/sda1
>>  >
>>  >
>>  > scrub device /dev/sda1 (id 1) done
>>  >         scrub started at Wed Oct 21 23:38:36 2020 and finished after 13:45:29
>>  >         total bytes scrubbed: 6.56TiB with 0 errors
>>  >
>>  > But then again:
>>  > dduper --device /dev/sda1 --dir /srv/dev-disk-by-label-DataPool1/dduper_test/testfiles -r --dry-run
>>  > parent transid verify failed on 16500741947392 wanted 358407 found 358409
>>  > Ignoring transid failure
>
>Wait...is that the kernel log, or the output of the dduper command?
>
It is on the commandline once I run the command; thus I suspect it is 
the dduper output. But of course sometimes the Kernel-Messages appear 
directly on the commandline. I do not know how to tell.

>
>commit 3e5f67f45b553045a34113cafb3c22180210a19f (tag: v0.04, origin/dockerbuild)
>Author: Lakshmipathi <lakshmipathi.ganapathi@collabora.com>
>Date:   Fri Sep 18 11:51:42 2020 +0530
>
>file deduper:
>
>     194 def btrfs_dump_csum(filename):
>     195     global device_name
>     196
>     197     btrfs_bin = "/usr/sbin/btrfs.static"
>     198     if os.path.exists(btrfs_bin) is False:
>     199         btrfs_bin = "btrfs"
>     200
>     201     out = subprocess.Popen(
>     202         [btrfs_bin, 'inspect-internal', 'dump-csum', filename, device_name],
>     203         stdout=subprocess.PIPE,
>     204         close_fds=True).stdout.readlines()
>     205     return out
>
>OK there's the problem:  it's dumping csums from a mounted filesystem by
>reading the block device instead of using the TREE_SEARCH_V2 ioctl.
>Don't do that, because it won't work.  ;)
I trust you on this ;-) But I am surprised I am the only one reporting 
this issue. Will it *always* not work, or does it not work in some cases 
and my situation is making it extremely unlikely to work?
>
>The "parent transid verify failed" errors are harmless.  They are due
>to the fact that a process reading the raw block device can never build
>an accurate model of a live filesystem that is changing underneathi it.
>
>If you manage to get some dedupe to happen, then that's a bonus.
>
>
>>  >
>>  > > >  Anything else, I can do?
>>  > >
>>  > > It looks like sda1 might be bad and it is working by replacing lost
>>  > > data from the mirror on sdj.  But this replacement should be happening
>>  > > automatically on read (and definitely on scrub), so you shouldn't ever
>>  > > see the same error twice, but it seems that you do.
>>  >
>>  > Well, it is not the same error twice.
>
>Earlier you quoted some duplicate lines.  Normally those get fixed after the
>first line, so you never see the second.
>
I see.

Regards,
Hendrik


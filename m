Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B92C5114044
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 12:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfLELoz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 06:44:55 -0500
Received: from adalind.mkaito.net ([147.75.80.235]:32824 "EHLO
        adalind.mkaito.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbfLELoz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 06:44:55 -0500
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mkaito.net; s=mail;
        t=1575546293; bh=WrR0lUFCeiZzd/jqOTr/md5cOH5qNd9kyvpezrE/EhA=;
        h=In-Reply-To:Date:Subject:From:To;
        b=emvPDJqNBYaRgXJn36ATZuUcsOnDxaObsx+IJm/Eet2Y6CoYgFk+OTl0VvOHPDBnU
         r8mI6hU6ZSTGkN/zU7x7Zn78Jq7OBO4ViUcBar6u2LyVEJcghpQWap7ZccFGJZ6lu9
         v6YZFjLO5SRKT31gxjjYh7Z/A9uEnbollO4Ud6vg=
Content-Type: text/plain; charset=UTF-8
Originaldate: Wed Dec 4, 2019 at 1:32 PM
Originalfrom: "Nikolay Borisov" <nborisov@suse.com>
Original: =?utf-8?q?=0D=0A=0D=0AOn_4.12.19_=D0=B3._13:04_
 =D1=87.,_Christian_H=C3=B6?= =?utf-8?q?ppner_wrote:=0D=0A>_Hello,=0D=0A>_
 =0D=0A>_I'm_writing_because_t?=
 =?utf-8?q?he_kernel_wiki_page_relating_to_this_error[1]_says_to=0D=0A>_wr?=
 =?utf-8?q?ite_here_first.=0D=0A>_=0D=0A>_I'm_(was)_running_Arch_Linux,_ke?=
 =?utf-8?q?rnel_5.4.1,_btrfs-progs_5.3.1=0D=0A>_=0D=0A>_Yesterday_during_u?=
 =?utf-8?q?sage,_the_root_file_system_remounted_read-only._I_was=0D=0A>_du?=
 =?utf-8?q?mb_enough_to_react_by_rebooting_the_machine,_when_I_was_greeted?=
 =?utf-8?q?_by_the=0D=0A>_following_error:=0D=0A>_=0D=0A>_[__25.634530]_BT?=
 =?utf-8?q?RFS_critical_(device_nvme0n1p2):_corrupf_leaf:_block=3D81014523?=
 =?utf-8?q?4944...=0D=0A=0D=0AHow_come_you_omitted_exactly_the_most_useful?=
 =?utf-8?q?_error_that_could_have=0D=0Apointed_at_the_problem_=3F_If_the_d?=
 =?utf-8?q?ata_is_intact_on-disk_and_the_leaf=0D=0Achecker_triggered_this_?=
 =?utf-8?q?means_you_likely_have_faulty_ram.=0D=0A=0D=0A>_[__25.634793]_BT?=
 =?utf-8?q?RFS_error_(device_nvme0n1p2):_block=3D810145234944_read_time_tr?=
 =?utf-8?q?ee_block_corruption_detected=0D=0A>_[__25.634961]_BTRFS_error_(?=
 =?utf-8?q?device_nvme0n1p2):_in_=5F=5Fbtrfs=5Ffree=5Fextent:3080:_errno?=
 =?utf-8?q?=3D-5_IO_failure=0D=0A>_[__25.635042]_BTRFS_error_(device_nvme0?=
 =?utf-8?q?n1p2):_in_btrfs=5Frun=5Fdelayed=5Frefs:2188:_errno=3D-5_IO_fail?=
 =?utf-8?q?ure=0D=0A>_[__34.653440]_systemd-journald[483]:_Failed_to_torat?=
 =?utf-8?q?e_/var/log/journal/8f7037b10bbd4f25aadd3d19105ef920/system.jour?=
 =?utf-8?q?nal=0D=0A>_=0D=0A>_After_booting_to_live_media,_I_checked_SMART?=
 =?utf-8?q?,_badblocks,_`btrfs_check=0D=0A>_--readonly`_and_`btrfs_scrub`.?=
 =?utf-8?q?_All_came_back_clean._I_conclude_that_this=0D=0A>_is_a_false_po?=
 =?utf-8?q?sitive,_and_have_downgraded_the_kernel_to_5.3.13_as_a=0D=0A>_wo?=
 =?utf-8?q?rkaround.=0D=0A>_=0D=0A>_How_can_I_provide_more_information_to_?=
 =?utf-8?q?help=3F=0D=0A>_=0D=0A>_[1]:_https://btrfs.wiki.kernel.org/index?=
 =?utf-8?q?.php/Tree-checker#How=5Fto=5Fhandle=5Fsuch=5Ferror=0D=0A>_=0D?=
 =?utf-8?q?=0A?=
In-Reply-To: <6c2d09ca-1483-cd82-c906-e30731baa39f@suse.com>
Date:   Thu, 05 Dec 2019 11:44:52 +0000
Subject: Re: False alert: read time tree block corruption
From:   =?utf-8?q?Christian_H=C3=B6ppner?= <chris@mkaito.net>
To:     "Nikolay Borisov" <nborisov@suse.com>,
        <linux-btrfs@vger.kernel.org>
Message-Id: <BYXGJQLT1XWR.HBSX91ABW4YE@cryptbreaker>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed Dec 4, 2019 at 1:32 PM, Nikolay Borisov wrote:
> How come you omitted exactly the most useful error that could have
> pointed at the problem ?

My bad. Here's the full text:

:: running early hook [udev]
Starting version 244-1-arch
:: running hook [udev]
:: Triggering uevents...
[     4.474941] hid-generic 003:0D8C:0005.0001: No inputs registered, leavi=
ng
:: performing fsck on '/dev/nvme0n1p2'
:: mounting '/dev/nvme0n1p2' on real root
[     6.153174] BTRFS critical (device nvme0n1p2): corrupt leaf: block=3D20=
9407475712 slot=3D110 extent bytenr=3D224368013312 len=3D262144 invalid gen=
eration, have 94071693158288 expect (0 3890273]
[     6.153252] BTRFS error (device nvme0n1p2): block=3D209407475712 read t=
ime tree corruption detected
[     6.153421] BTRFS critical (device nvme0n1p2): corrupt leaf: block=3D20=
9407475712 slot=3D110 extent bytenr=3D224368013312 len=3D262144 invalid gen=
eration, have 94071693158288 expect (0 3890273]
[     6.153462] BTRFS error (device nvme0n1p2): block=3D209407475712 read t=
ime tree corruption detected
[     6.153495] BTRFS error (device nvme0n1p2): failed to read block groups=
: -5
[     6.230015] BTRFS error (device nvme0n1p2): open_ctree failed
mount: /new_root: wrong fs type, bad option, bad superblock on /dev/nvme0n1=
p2, missing codepage or helper program, or other error.
You are being dropped into an emergency shell.
sh: can't access tty: job control turned off
[rootfs ]#


> If the data is intact on-disk and the leaf
> checker triggered this means you likely have faulty ram.

The data on disk seems fine. System boots with kernel 5.3.13, `btrfs
scrub` and `btrfs check --readonly` report no errors, nor have there
been any further issues during normal usage.

I'll run memtest overnight and report back.

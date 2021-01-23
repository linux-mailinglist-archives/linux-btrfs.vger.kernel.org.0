Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F28301531
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jan 2021 13:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbhAWMaO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 23 Jan 2021 07:30:14 -0500
Received: from mail.cobios.de ([193.142.191.78]:52394 "EHLO mail.cobios.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbhAWMaM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 07:30:12 -0500
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Jan 2021 07:30:11 EST
Received: from cloud.cobios.de (unknown [192.168.78.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.cobios.de (Postfix) with ESMTPSA id D57FA666D4
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Jan 2021 13:22:11 +0100 (CET)
MIME-Version: 1.0
Date:   Sat, 23 Jan 2021 12:22:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: RainLoop/1.14.0
From:   alexino@cobios.de
Message-ID: <50f51b01788af83b1bf542f2089a56fe@cobios.de>
Subject: performance implications of btrfs filesystem sync vs btrfs
 subvolume snaphot
To:     linux-btrfs@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello everybody :)

first time participant on linux-btrfs@vger.kernel.org mailinglist, 
hence please excuse (yet tell me about) any problems. thank you.

My question/topic is:
Wanting to generate backups of a btrfs filesystems on a running system
it seems that using `btrfs subvolume snapshot` would be a possible way
to make certain that data kept in RAM (i.e. buffer/cache) would be 
synced to the disk.  

Reading this mailing list I stumpled upon this:

>> Subject:    Re: freezes during snapshot creation/deletion -- to be expected? (Was: Re: btrfs based backup?)
>> From:       Zygo Blaxell <ce3g8jdj () umail ! furryterror ! org>
>>
>> [..]
>>
>> Snapshot create has unbounded running time on 5.0 kernels.  The creation
>> process has to flush dirty buffers to the filesystem to get a clean
>> snapshot state.  Any process that is writing data while the flush is
>> running gets its data included in the snapshot flush, so in the worst
>> possible case, the snapshot flush never ends (unless you run out of disk
>> space, or whatever was writing new data stops, whichever comes first).
>> [..]

Now I wonder that if `btrfs filesystem sync` would be a viable alternative 
to `btrfs subvolume snapshot`, with respect of not having to risk a 
"snapshot flush never ends" situation? 

My layman perception is that.

1) "btrfs on-disk-persistet data is ideally alway non-corrupted". Since
changes are commited via COW and hence in a atomic fashion, meaning that
at worst data on disk is outdated, but never corrupt. (unless hardware or 
blockdevice issues )

2) btrfs filesystem sync or sync(1) should flush data out from memory
to disk - which would once finished - lead to a "more recent" consistent
data on disk. 

3) btrfs subvolume snapshot implies a sync

Are those perceptions roughly correct?

If so I am unsure if the issue with a "neverending flush" is related to
the btrfs filesystem sync and consequently relying on btrfs filesystem 
sync as alternative to btrfs snapshot to prevent "a neverending flush"
is not a possibility. 

Tahnk yo and best regards,

Alexander Mahr

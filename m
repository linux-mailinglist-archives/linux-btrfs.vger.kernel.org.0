Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261A822B8F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jul 2020 23:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgGWVsc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jul 2020 17:48:32 -0400
Received: from ns.bouton.name ([109.74.195.142]:44522 "EHLO mail.bouton.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgGWVsc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jul 2020 17:48:32 -0400
X-Greylist: delayed 505 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Jul 2020 17:48:31 EDT
Received: from [192.168.0.39] (adsl.bouton.name [82.234.193.23])
        by mail.bouton.name (Postfix) with ESMTP id C4169B84C;
        Thu, 23 Jul 2020 23:40:05 +0200 (CEST)
Subject: Re: Error: Failed to read chunk root, fs destroyed
To:     Davide Palma <dpfuturehacker@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAPtuuyEM7YZe8oaqhLivMJLshcsuQWvGuvrmHO1=5ZhYVN7hHA@mail.gmail.com>
From:   Lionel Bouton <lionel-subscription@bouton.name>
Message-ID: <b92eebb7-7a19-c853-f79c-f5eae669c817@bouton.name>
Date:   Thu, 23 Jul 2020 23:40:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPtuuyEM7YZe8oaqhLivMJLshcsuQWvGuvrmHO1=5ZhYVN7hHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Le 23/07/2020 à 23:15, Davide Palma a écrit :
> Hello,
> What happened:
>
> I had a Gentoo linux install on a standard, ssd, btrfs partition.
> After I removed lots of files, I wanted to shrink the partition, so i
> shrunk it as much as possible and started a balance operation to
> squeeze out more unallocated space. However, the balance operation was
> not progressing. (the behaviour was identical to the one described
> here https://www.opensuse-forum.de/thread/43376-btrfs-balance-caught-in-write-loop/
> ). So I cancelled the balance and, following a piece of advice found
> on the net, created a ramdisk that worked as a second device for a
> raid1 setup.
>
> dd if=/dev/zero of=/var/tmp/btrfs bs=1G count=5
>
> losetup -v -f /var/tmp/btrfs
> btrfs device add /dev/loop0 .
>
> I tried running the balance again, but, as before, it wasn't
> progressing. So I decided to remove the ramdisk and reconvert the now
> raid1 partition to a single one.

I probably won't be able to help but while this is fresh in your memory
please try to remember the exact sequence.

If I'm not mistaken the sequence of operations above isn't enough to
store data in raid1 block groups.

After device add you should still be using the same allocation policy as
the one chosen during mkfs. By default this should be :
metadata/system : dup,
data : single.

If that's indeed the case, removing the loop device later on will indeed
break the filesystem as several metadata block groups will be entirely
missing (dup will probably have allocated the two duplicates on the loop
block device where space was available).

If you managed to create raid1 block groups the exact sequence of events
will probably be useful for more knowledgeable people.

Best regards,

Lionel

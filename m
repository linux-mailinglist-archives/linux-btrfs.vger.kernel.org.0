Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE13E6064F
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 15:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbfGENDd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 09:03:33 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:37024 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbfGENDc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jul 2019 09:03:32 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id CF966142BC4; Fri,  5 Jul 2019 14:03:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1562331809;
        bh=UDz6aG7GlbGLVhAegZDOkl8/7+LAER8ANsEfXDmPKCo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dupIWUBJfA8Gd9n3NzgE64ibFMMf1ZH1UZl87HdPBhLPeedmNk7HA8bItcNLg8nd2
         qrLsYUeSk4jl+e1zeld5JUOQGZvDmvLnjfL/oWEIucSoAC6k3xp0LI9bPFtbBk1sb2
         6EprC1JzTq8973D622SryYMmM3SG9B3FJiaDl0QXancCdThdoOgDewu45bOrAkWuI1
         ls5Nu+LMFRIg0l33oCGuG3Yc9XYMOJtlk9XVue4DijmI1yHDxR1XuqtWMavk9sYGh/
         JHmWaU0FSw9ALJ314CTnTgi9fhyPXGEpNdz6Tpz9qy57+gUg8n4bq0ULVj9PaOtNVn
         s9QTrIqFBYXuQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 9E3AD142BC2;
        Fri,  5 Jul 2019 14:03:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1562331807;
        bh=UDz6aG7GlbGLVhAegZDOkl8/7+LAER8ANsEfXDmPKCo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Iy/igmwOUtYtOuN+rEMMExzaaWUR1QW5XcV/4UyJ9zMQdjMVnfNHV7M/8xn6FCZfj
         6J/4ZxFPWA1Osbm4Xf+f4JBkhxzZGCRXgbqMuY5PDJMLQpUUnNicWYKpLtqdwH77tz
         NLdNRTq6yPufn1IDUPifb1TJB3wf+k9hxDl8fzt0jBrYhPsokyZO+stjs27yf+PM5O
         BhZnqyoDIuHp1GvpRtmc5mTgK1EpqfzoBsNYsyZ8m3cWHDQPyFx9bVayRtQS094405
         zwAaNvuLt3RNFQuDGOrbIvIyB4eJ6grzAgw/tJTdG94XPBmZPzwvBV4yt751tCMbBE
         REmu2DlFibyrA==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 4771512243;
        Fri,  5 Jul 2019 14:03:26 +0100 (BST)
Subject: Re: snapshot rollback
To:     Remi Gauvin <remi@georgianit.com>,
        Ulli Horlacher <framstag@rus.uni-stuttgart.de>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190705103823.GA13281@tik.uni-stuttgart.de>
 <20190705110614.GA14418@tik.uni-stuttgart.de>
 <f0f13684-8975-721f-5c91-fe3043065634@georgianit.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <2d977161-275a-a3e4-1cda-d7221ef12da9@cobb.uk.net>
Date:   Fri, 5 Jul 2019 14:03:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <f0f13684-8975-721f-5c91-fe3043065634@georgianit.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/07/2019 12:47, Remi Gauvin wrote:
> On 2019-07-05 7:06 a.m., Ulli Horlacher wrote:
> 
>>
>> Ok, it seems my idea (replacing the original root subvolume with a
>> snapshot) is not possible. 
>>
> ...
> It is common practice with installers now to mount your root and home on
> a subvolume for exactly this reason.  (And you can convert your current
> system as well.  Boot your system with a removable boot media of your
> choice, create a subvolume named @.  Move all existing folders into this
> new subvolume.  Edit the @/boot/grub/grub.cfg file so your Linux boot
> menu has the @ added to the paths of Linux root and initrd.

Personally, I use a slightly different strategy. My basic principle is
that no btrfs filesystem should have any files or directories in its
root -- only subvolumes. This makes it easier to do stuff with snapshots
if I want to.

For system disks I use a variant of the "@" approach. I create two
subvolumes when I create a system disk: rootfs and varfs (I separate the
two because I use different btrbk and other backup configurations for /
and /var). I then use btrfs subvolume set-default to set rootfs as the
default mount so I don't have to tell grub, etc about the subvolume (I
should mention that I put /boot in a separate partition, not using btrfs).

In /etc/fstab I mount /var with subvol=varfs. I also mount the whole
filesystem (using subvolid=5) into a separate mount point
(/mnt/rootdisk) so I can easily get at and manipulate all the top-level
subvolumes.

Data disks are similar. I create a "home" subvolume at the top level in
the data disk which gets mounted into /home. Below /home, most
directories are also subvolumes (for example, one for my main account so
I can backup that separately from other parts of /home). I mount the
data disk itself (using subvolid=5) into a separate mount point:
/mnt/datadisk -- which I only use for doing work with messing around
with the subvolume structure.

It sounds more complicated than it is, although it is not supported by
any distro installers that I am aware of. And you should expect to get a
few config things wrong while setting it up and will need to have an
alternative boot to use to get things working (a USB disk or an older
system disk). Particularly if you want to use btrfs-over-LVM-over-LUKS.
And don't forget to fully update grub when you think is working and then
test it again without your old/temporary boot disk in place!

Basically, I make many different subvolumes and use /mount to put them
into the places they should be in the filesystem (except for / for which
I use set-default). The real btrfs root directory for each filesystem is
mounted (using subvolid=5) into a separate place for doing filesystem
operations.

I then have a cron script which checks that every directory within the
top level of each btrfs filesystem (and within /home) is a subvolume and
warns me if it isn't (I use special dotfiles within the few top-level
directories which I don't want to be their own subvolumes).

Contact me directly if you would find my personal "how to set up my
system and root disks, for debian, using btrfs-over-lvm-over-luks" notes
useful.

Graham

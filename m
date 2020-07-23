Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499E822BAAE
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jul 2020 01:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgGWXug (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jul 2020 19:50:36 -0400
Received: from ns.bouton.name ([109.74.195.142]:35416 "EHLO mail.bouton.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgGWXug (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jul 2020 19:50:36 -0400
Received: from [192.168.0.39] (adsl.bouton.name [82.234.193.23])
        by mail.bouton.name (Postfix) with ESMTP id E9405B84C
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jul 2020 01:50:34 +0200 (CEST)
From:   Lionel Bouton <lionel-subscription@bouton.name>
Subject: Re: Error: Failed to read chunk root, fs destroyed
Cc:     linux-btrfs@vger.kernel.org
References: <CAPtuuyEM7YZe8oaqhLivMJLshcsuQWvGuvrmHO1=5ZhYVN7hHA@mail.gmail.com>
 <b92eebb7-7a19-c853-f79c-f5eae669c817@bouton.name>
 <CAPtuuyGHcpqmCgQeXb6841zK=JLiHmJwJ80OdxKPFJ1KH=q=hw@mail.gmail.com>
Message-ID: <afcc2974-b85b-1963-4a8f-e06727d1b567@bouton.name>
Date:   Fri, 24 Jul 2020 01:50:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPtuuyGHcpqmCgQeXb6841zK=JLiHmJwJ80OdxKPFJ1KH=q=hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Le 23/07/2020 à 23:51, Davide Palma a écrit :
> Dear Lionel,
>
> > I probably won't be able to help but while this is fresh in your memory
> > please try to remember the exact sequence.
>
> I wish I could give you the .bash_history file,  but the sequence is
> the one I wrote. I tried running many balances before the ramdisk
> stuff by starting with -musage=0 and -dusage=0 and got to about 30
> before it started looping, I don't think this is useful but now you
> have 100% of my memory :)
>
> > If that's indeed the case, removing the loop device later on will indeed
> > break the filesystem as several metadata block groups will be entirely
> > missing (dup will probably have allocated the two duplicates on the loop
> > block device where space was available).
>
> Doesn't this defeat the whole point of raid1?

My point is that I saw nothing that pointed to raid1 being used on your
filesystem in the list of steps you described. I understand it was your
intent to use raid1 (although it isn't clear why as you didn't provide a
link for the advice you were following) but I'm not sure you actually did.

Simply adding a device to a BTRFS filesystem doesn't convert your
filesystem block groups it only adds usable space. You'd need to use a
balance command for converting the block groups to raid1.
Something like :
btrfs balance start -mconvert=raid1 -dconvert=raid1 <yourfs>

Best regards,

Lionel

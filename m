Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29CDD18116D
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 08:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgCKHHN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 03:07:13 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43391 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgCKHHM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 03:07:12 -0400
X-Originating-IP: 82.67.131.7
Received: from [192.168.1.167] (unknown [82.67.131.7])
        (Authenticated sender: swami@petaramesh.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 83ED320002;
        Wed, 11 Mar 2020 07:07:10 +0000 (UTC)
Subject: Re: (One more) BTRFS damaged FS... Any hope ?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <55a1612f-e9af-dabd-5b91-f09cb1528486@petaramesh.org>
 <CAJCQCtT+_ioV6XAUgPyD++9o_0+6-kUgGOF7mpfVHEyb7runsA@mail.gmail.com>
 <3234bc4b-6e93-c1f7-9ed4-a45173e22dd5@petaramesh.org>
 <CAJCQCtR-SUsiE5L8ba=pKHbJyQ9X3sTSBJ6vV0-X0-58nV-fxw@mail.gmail.com>
 <b99b8106-2aa9-e288-e637-d79a200da278@petaramesh.org>
 <CAJCQCtR6DnpkmgOnDY8GmO3T86Bk7ASmpGXTUmbdi9DVwdtMoQ@mail.gmail.com>
 <56e26938-3c85-f879-2f30-44283a6df5d1@petaramesh.org>
 <CAJCQCtTR0ADQXAC2g1kj1hFdpdPYwapOQnsqwfVnw7OzmSCq8w@mail.gmail.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Autocrypt: addr=swami@petaramesh.org; prefer-encrypt=mutual; keydata=
 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
 BtUAN08OPA==
Message-ID: <73179c04-69f1-d638-13f8-7a2001264140@petaramesh.org>
Date:   Wed, 11 Mar 2020 08:07:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTR0ADQXAC2g1kj1hFdpdPYwapOQnsqwfVnw7OzmSCq8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi again Chris,

Le 11/03/2020 à 00:12, Chris Murphy a écrit :
> 
> Maybe some extent tree corruption. I'm thinking that the older kernel
> without an extensive tree checker won't care, and eventually things
> may get worse and unworkable again. But it might work for a while?

> What kernel version was it at the time of the problem? I see btrfs-progs 4.15.1

Actually I checked and the kernel itself was 5.3, only the tools are
4.15 - Yes that's Mint, you can install a newer kernel but the toolchain
is the distro's... The same goes for Ubuntu or Debian...

But a 5.3 kernel is actually pretty recent.

>> You could change fstab to include these two mount options:
> 
> flushoncommit,notreelog
> 
> The first probably won't slow things down, might help improve
> consistency if there's a crash; where the second will likely make
> certain things slower because it turns off fsync optimization and
> requires full sync each time.

Uh... The kid's got an old computer and I cannot consider anything that
would slow things down more than they already are...

As I could, thanks to you, mount the FS, I rsync'd it completely to
another one and saw that only 2 files from the python3 package and a
couple dozens from a flatpak cache were corrupt or missing. No big deal.

So I reformatted the original disk with its original uuid, recreated the
subvols, restored everything back into place, put the disk in another
laptop and it booted like a charm.

I then just reinstalled python3, ran system updates and voilà.

Now I only need to drop the SSD back into the little girl's ole PC.

Thanks again, without your kind assistance I would have been doomed to a
full reinstall and the kid would had lost her files - being a kid's
machine, no regular backups...

However a FS that badly dies is an issue anyway.

Not for a rant, but I've considered BRFS to be « slow but extremely
reliable » for at least 6 years.
And I certainly wouldn't have expected it to die because of a system
crash or power fail.

With time it became faster BUT in the past year I've already completely
lost 4 BTRFS filesystems on different machines, most from the 5.2 kernel
bugs and I don't consider this acceptable from an FS anybody would deem
“reliable”.

This plus the ugly “zero free space” bug in 5.3... I actually wonder
what's going on with BTRFS development...

Kind regards and thanks again.

ॐ

-- 
Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E

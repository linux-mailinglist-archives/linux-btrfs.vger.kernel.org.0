Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E801E4AAEE
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 21:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbfFRTPa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 15:15:30 -0400
Received: from ns211617.ip-188-165-215.eu ([188.165.215.42]:58154 "EHLO
        mx.speed47.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727386AbfFRTP3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 15:15:29 -0400
Received: from rain.speed47.net (nginx [192.168.80.2])
        by box.speed47.net (Postfix) with ESMTPSA id E44E6324F;
        Tue, 18 Jun 2019 21:15:27 +0200 (CEST)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1560885327;
        bh=vznsupef09BHIYvn89ftA9FraHUvFjq5+tRbkhcOyeQ=;
        h=Date:From:Subject:To:Cc:In-Reply-To:References;
        b=C19pqlqFp5QREOrrCyMoXlN5ARJqPeyR+jzZ6xAMT/GiROjL79RyT5GfkqAJPcNKz
         3rG6nXQnSJWAD9D+KXboEH7u8jyjjJa1J0ewzPcAAaRvAcOBs8I8R7uhVl6elC2nJH
         kCmLn1gNZ5fnhwMS0HZJ5c5rpjJVxnPqr3l1z7uM=
MIME-Version: 1.0
Date:   Tue, 18 Jun 2019 19:15:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.1
From:   "=?utf-8?B?U3TDqXBoYW5lIExlc2ltcGxl?=" <stephane_btrfs@lesimple.fr>
Message-ID: <97d71a1c6b16fec6a49004db84fac254@lesimple.fr>
Subject: Re: Rebalancing raid1 after adding a device
To:     "Hugo Mills" <hugo@carfax.org.uk>
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <20190618184501.GJ21016@carfax.org.uk>
References: <20190618184501.GJ21016@carfax.org.uk>
 <16b6bd72bc0.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

June 18, 2019 8:45 PM, "Hugo Mills" <hugo@carfax.org.uk> wrote:=0A=0A> On=
 Tue, Jun 18, 2019 at 08:26:32PM +0200, St=C3=A9phane Lesimple wrote:=0A>=
> [...]=0A>> Of course the solution is to run a balance, but as the files=
ystem is=0A>> now quite big, I'd like to avoid running a full rebalance. =
This=0A>> would be quite i/o intensive, would be running for several days=
, and=0A>> putting and unecessary stress on the drives. This also seems=
=0A>> excessive as in theory only some Tb would need to be moved: if I'm=
=0A>> correct, only one of two block groups of a sufficient amount of=0A>=
> chunks to be moved to the new device so that the sum of the amount=0A>>=
 of available space on the 4 preexisting devices would at least equal=0A>=
> the available space on the new device, ~7Tb instead of moving ~22T.=0A>=
> I don't need to have a perfectly balanced FS, I just want all the=0A>> =
space to be allocatable.=0A>> =0A>> I tried using the -ddevid option but =
it only instructs btrfs to work=0A>> on the block groups allocated on sai=
d device, as it happens, it=0A>> tends to move data between the 4 preexis=
ting devices and doesn't fix=0A>> my problem. A full balance with -dlimit=
=3D100 did no better.=0A> =0A> -dlimit=3D100 will only move 100 GiB of da=
ta (i.e. 200 GiB), so it'll=0A> be a pretty limited change. You'll need t=
o use a larger number than=0A> that if you want it to have a significant =
visible effect.=0A=0AYes of course, I wasn't clear here but what I meant =
to do when starting=0Aa full balance with -dlimit=3D100 was to test under=
 a reasonable amount of=0Atime whether the allocator would prefer to fill=
 the new drive. I observed=0Aafter those 100G (200G) of data moved that i=
t wasn't the case at all.=0ASpecifically, no single allocation happened o=
n the new drive. I know this=0Awould be the case at some point, after Ter=
abytes of data would have been=0Amoved, but that's exactly what I'm tryin=
g to avoid.=0A=0A> The -ddevid=3D<old_10T> option would be my recommendat=
ion. It's got=0A> more chunks on it, so they're likely to have their copi=
es spread=0A> across the other four devices. This should help with the=0A=
> balance.=0A=0AMakes sense. That's probably what I'm going to do if I do=
n't find=0Aa better solution. That's a bit frustrating because I know exa=
ctly=0Awhat I want btrfs to do, but I have no way to make it do that.=0A=
=0A> Alternatively, just do a full balance and then cancel it when the=0A=
> amount of unallocated space is reasonably well spread across the=0A> de=
vices (specifically, the new device's unallocated space is less than=0A> =
the sum of the unallocated space on the other devices).=0A=0AI'll try wit=
h the old 10T and cancel it when I get 0 unallocatable=0Aspace, if that h=
appens before all the data is moved around.=0A=0A>> Is there a way to ask=
 the block group allocator to prefer writing to=0A>> a specific device du=
ring a balance? Something like -ddestdevid=3DN?=0A>> This would just be a=
 hint to the allocator and the usual constraints=0A>> would always apply =
(and prevail over the hint when needed).=0A> =0A> No, there isn't. Having=
 control over the allocator (or bypassing=0A> it) would be pretty difficu=
lt to implement, I think.=0A> =0A> It would be really great if there was =
an ioctl that allowed you to=0A> say things like "take the chunks of this=
 block group and put them on=0A> devices 2, 4 and 5 in RAID-5", because y=
ou could do a load of=0A> optimisation with reshaping the FS in userspace=
 with that. But I=0A> suspect it's a long way down the list of things to =
do.=0A=0AExactly, that would be awesome. I would probably even go as far =
as=0Awriting some C code myself to call this ioctl to do this "intelligen=
t"=0Abalance on my system!=0A=0A--=0ASt=C3=A9phane.

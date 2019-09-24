Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4AA8BD4CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 00:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442025AbfIXWGA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 18:06:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43239 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387542AbfIXWGA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 18:06:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id q17so3801435wrx.10
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 15:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pFLw3dOLxeFgzYiPL8w1yRI/k1zaMjRSFNs6w7fx+lg=;
        b=MksNmbY6OTWNWpOAtt/ab+ytvcuYW/GPUy9eQMcbTeTBfOHDoWiSTRjTHYX1yhA1r5
         G0QRk6EnoLFS5FvE/8WYFqa9G1A+X7ldkuqbwzLjJdxDtUCJ9hRty+TcaR2PuV7A5dV5
         pEkPl5J42uiKtTjci08ppnL1Tg1cEVxnL80BddWhAj6vs8ADqDdwE5FwY40c2GKYx+ob
         FYYxp9vfmN7Ja9RM2vu0qqkQ5MnTSWCHaVBgK0uIvhk7qhxoueGDQcPdw3VQXcRnI0rE
         kgTXFMCzSQOY3iCVLvos7jP+Zw0xjte9PEI9/e4ZMK9aS03ZQP5ihA5Xfz0W08ru4+a6
         F3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pFLw3dOLxeFgzYiPL8w1yRI/k1zaMjRSFNs6w7fx+lg=;
        b=Va1ttM7opWfBWYYS/QDCBm38NBJDUaqkQddQfu46CopBykVDrbDTvkYkkYLJPqKIyW
         TyeH8IGD9psSPKe4c8eOybOFnPO+0SDzVGZdYePlbN0ArkJihF9Jqnthk8OC5GD+5Qvf
         WTFJ4QPFNxTV8ViTx/fqeGpFtQrdcS/3O8SHICXUDwav84fQudx77Oaka56kBh3zkrlf
         pXEIRChnCtCmEK9C22nYsfuh8fTzSmW2zvmjbHXHwnzLghlahw5kE6cvSfLGbcKjdylJ
         oDjgrbyMcANdENj3CJ3o9297Kp8wCwnfEU114KB0Th5cjLxbYAUQds+p5umW+OQL7mds
         U0Bw==
X-Gm-Message-State: APjAAAUPLVuuczuTfx/Zy02i22YIapr1ThLKvpUX8WprnwzXlMwB1ylD
        +ZrYUofsa8uol/Ah+0g9pjvcIRGQ9LZpf2jvebujXA==
X-Google-Smtp-Source: APXvYqzH5i0nvYUY+Mpxd4OamygpysyqHPNFTYttdsaNYxk5Ld8zwyTmINYNLaUr9CgYAiXPNZS/zgJu31bqlF9SU0I=
X-Received: by 2002:a5d:4241:: with SMTP id s1mr5102615wrr.101.1569362756754;
 Tue, 24 Sep 2019 15:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <000f01d5723b$6e3d0f70$4ab72e50$@gmail.com> <CAJCQCtSCJTsk1oFrWObUBpw-MXArQJHoJV3BeBk0Nfv_-AoS8g@mail.gmail.com>
 <003f01d5724c$f1adae30$d5090a90$@gmail.com> <CAJCQCtTwjUok145SqnbwfBYKipVhcV7J94HX9Lx4mgaFV3FaBA@mail.gmail.com>
 <005301d572dd$e378c7a0$aa6a56e0$@gmail.com>
In-Reply-To: <005301d572dd$e378c7a0$aa6a56e0$@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 24 Sep 2019 16:05:45 -0600
Message-ID: <CAJCQCtSZA+nT9813paB=AGFH2yf7mT1i+vErotL8ur_UiYzjqw@mail.gmail.com>
Subject: Re: BTRFS checksum mismatch - false positives
To:     hoegge@gmail.com
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 7:42 AM <hoegge@gmail.com> wrote:
>
> Sorry forgot root when issuing commands:
>
> ash-4.3# btrfs fi show
> Label: '2016.05.06-09:13:52 v7321'  uuid: 63121c18-2bed-4c81-a514-77be2fba7ab8
> Total devices 1 FS bytes used 4.31TiB
> devid    1 size 9.97TiB used 4.55TiB path /dev/mapper/vg1-volume_1

OK so you can do
# pvs

And that should show what makes up that logical volume. And you can
also double check with

# cat /proc/mdstat


> Data, single: total=4.38TiB, used=4.30TiB
> System, DUP: total=8.00MiB, used=96.00KiB
> System, single: total=4.00MiB, used=0.00B
> Metadata, DUP: total=89.50GiB, used=6.63GiB
> Metadata, single: total=8.00MiB, used=0.00B
> GlobalReserve, single: total=512.00MiB, used=0.00B

Yeah there's a couple of issues there that aren't problems per se. But
with the older kernel, it's probably a good idea to reduce the large
number of unused metadata block groups:

# btrfs balance start -mconvert=dup,soft /mountpoint/    ##no idea
where the mount point is for your btrfs volume

that command will get rid of those empty single profile system and
metadata block groups. It should complete almost instantly.

# btrfs balance start -musage=25 /mountpoint

That will find block groups with 25% or less usage, move and
consolidate their extents into new metadata block groups and then
delete the old ones. 25% is pretty conservative. There's ~89GiB
allocated to metadata, but only ~7GiB is used. So this command will
find the tiny bits of metadata strewn out over those 89GiB and
consolidate them, and basically it'll free up a bunch of space.

It's not really necessary to do this, you've got a ton of free space
left, only 1/2 the pool is used

9.97TiB used 4.55TiB

>
> Synology indicates that BTRFS can do self healing of data using RAID information? Is that really the case if it is not a "BTRFS raid" but a MD or SHR raid?

Btrfs will only self heal the metadata in this file system, because
there's two copies of metadata. It can't do self heal on data. That'd
be up to whatever lower layer is providing the RAID capability and
whether md or lvm based, it depends on the drive itself spitting out
some kind of discrete read or write error in order for md/lvm to know
what to do. There are no checksums available to it, so it has no idea
if the data is corrupt. It only knows if a drive complains, it needs
to attempt reconstruction. If that reconstruction produces corrupt
data, Btrfs still detects it and will report on it, but it can't fix
it.



-- 
Chris Murphy

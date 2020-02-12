Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 262CA15A89F
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 13:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgBLMDk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 07:03:40 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39819 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgBLMDk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 07:03:40 -0500
Received: by mail-ua1-f66.google.com with SMTP id 73so752912uac.6
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 04:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=kRTPc07RG677gSXn1WMANRvQTgOmL4qRD6HHQlzIS0I=;
        b=fMGys7k/DdIsQwTzKOYDvgkzyYQLlSCno90CDHe2oyRzsakRguRWQXWBY2unVsvjWC
         mSgr6kUCa2PKCYnZ7lWyjpMGFyokG4j2k7l/GhZ+eY4VGMIzgqIGQXRynCcc+mzRxytE
         E8yyYpxvqIXbnQrhtrSwh3Krr9lmsYRAvduSGbrFDwt7ePlx5/6MZKFHnEf5MQqu1an7
         0TF4zB02862xqEmGgm3SrKqa2hx3M1TrNRuqBhAONNXiow75g1+ugAdYtdxFeNFZ8SbI
         6t5kJopK45NV1OLuMyy7R3jrAUV/Wo6sh1p9HbA5qbejWO/tgc59ScEJXOtvARAozuFg
         Y+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=kRTPc07RG677gSXn1WMANRvQTgOmL4qRD6HHQlzIS0I=;
        b=FnVJmNWDnFIh/paJbjaRVX3ca2+MlPG6GWU6H8x2F2kF+qH25JAeiHTBaTtAfKbEyZ
         PlnRWYjASzR8Pv+b5BqqgYVrYV0TWJ4xzXk26GTBsAYk9BQtQL7pGNi+bh3S4hrDyNGn
         YYgFsT9hPo7PCxgi4akiTu5RUjjxp5QmYW2ox7OKJgsdssqMCeWbi3S6V+pBLXqNL8UY
         2O2tr1euOilZDr+514w2iQVQ50siKMeP/pu4MdmdGlOugblMbBwN0qyVBfU0Qw/LsPp0
         JDdH6dXCjyBgBALPMH4CT7wSNcQpa9k1segQ9sN0ZmU8bn0L6oo/35ghr698y7Bq+RRt
         p1gg==
X-Gm-Message-State: APjAAAWPb3wqg1E9zoQwENNd/Q9JSprtufg5DD3tpBOQUk4NdUYNgIXy
        XkRUtp56XknEQ37CoY/Hl1kJ8BqJOTPvHhEuP7B5Jw==
X-Google-Smtp-Source: APXvYqx3tLOBOaOZd+uU+2Vu3s3241dFss7BjOn6hWZz9LLrVsIn5+fjZn2tQivzIcj9pmHKTIzKaqUFDxeqrILZLt4=
X-Received: by 2002:ab0:2a93:: with SMTP id h19mr4157163uar.27.1581509018276;
 Wed, 12 Feb 2020 04:03:38 -0800 (PST)
MIME-Version: 1.0
References: <20200207093818.23710-1-ethanwu@synology.com> <20200207093818.23710-2-ethanwu@synology.com>
 <0badf0be-d481-10fb-c23d-1b69b985e145@toxicpanda.com> <c0453c3eb7c9b4e56bd66dbe647c5f0a@synology.com>
 <20200210162927.GK2654@twin.jikos.cz> <5901b2be7358137e691b319cbad43111@synology.com>
 <aeb36a34-bc9c-8500-9f36-554729a078fc@gmx.com> <20200211182159.GD2902@twin.jikos.cz>
 <c3b0f59840b81f4dd440264fb4276d9f@synology.com>
In-Reply-To: <c3b0f59840b81f4dd440264fb4276d9f@synology.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 12 Feb 2020 12:03:27 +0000
Message-ID: <CAL3q7H6uHhs8r1+f+e_Ae+a4WDZnXLWStOhwH_fEk65A0Gi3qw@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: backref, only collect file extent items
 matching backref offset
To:     ethanwu <ethanwu@synology.com>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 12, 2020 at 11:34 AM ethanwu <ethanwu@synology.com> wrote:
>
> David Sterba =E6=96=BC 2020-02-12 02:21 =E5=AF=AB=E5=88=B0:
> > On Tue, Feb 11, 2020 at 12:33:48PM +0800, Qu Wenruo wrote:
> >> >> 39862272 have 30949376
> >> >> [ 5949.328136] repair_io_failure: 22 callbacks suppressed
> >> >> [ 5949.328139] BTRFS info (device vdb): read error corrected: ino 0
> >> >> off 39862272 (dev /dev/vdd sector 19488)
> >> >> [ 5949.333447] BTRFS info (device vdb): read error corrected: ino 0
> >> >> off 39866368 (dev /dev/vdd sector 19496)
> >> >> [ 5949.336875] BTRFS info (device vdb): read error corrected: ino 0
> >> >> off 39870464 (dev /dev/vdd sector 19504)
> >> >> [ 5949.340325] BTRFS info (device vdb): read error corrected: ino 0
> >> >> off 39874560 (dev /dev/vdd sector 19512)
> >> >> [ 5949.409934] BTRFS warning (device vdb): csum failed root -9 ino =
257
> >> >> off 2228224 csum
> >>
> >> This looks like an existing bug, IIRC Zygo reported it before.
> >>
> >> Btrfs balance just randomly failed at data reloc tree.
> >>
> >> Thus I don't believe it's related to Ethan's patches.
> >
> > Ok, than the patches make it more likely to happen, which could mean
> > that faster backref processing hits some race window. As there could be
> > more we should first fix the bug you say Zygo reported.
>
> I added a log to check if find_parent_nodes is ever called under
> test btrfs/125. It turns out that btrfs/125 doesn't pass through the
> function. What my patches do is all under find_parent_nodes.
> Therefore, I don't think my patch would make btrfs/125 more likely
> to happen, at least it doesn't change the behavior of functions
> btrfs/125 run through.

Yep, test btrfs/125 doesn't trigger backreference walking.
Backreference walking is used by fiemap, send, the logical ino ioctls,
scrub (in error paths to get a path for an inode), and qgroups. The
test doesn't use any of these features.

I've seen that test fail for the same reason once as well, so it's
definitely not caused by your patches.

Thanks.

>
> Is it easy to reproduce in your test environment?
>
> Thanks,
> ethanwu



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

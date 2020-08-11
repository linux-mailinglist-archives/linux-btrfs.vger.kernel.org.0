Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B582414A5
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 03:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgHKBsu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 21:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgHKBst (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 21:48:49 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89533C061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 18:48:49 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 9so1172278wmj.5
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 18:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S2j34lTpbzspDY+ZyqDr4gApM+bfTf9T2qudVgijqRc=;
        b=dVx9VHLSnsi2KDpJtS2TtoYfioNlyyOwSAjGRixvoyIMW9Cbzu0hzZ/cUqLacZFZSh
         mVg47LedU7v2aXeSaCzU6TqwyZl4gk1Cf5ad/NxXh13dyo7VUNMzfdaKyjVcW2IpaKQD
         HZo6MvtexJFoD2aLQn7Oez4S3O7+694MQ7iieRrKTssTconuV5rwrdb4ZKUqX6FZKKju
         /d+9OgFFZg1rBnq7xTzqGZa7UXIuvvHH48ZTvp2z5LYoXX42AQvfzGBkLTAsTSH6G6Yj
         Ogmbf9hmwBKK90SfNEbNIefX6M2JPgjR9NP7U6rELldfjWMnosnSyqUGbqg9+plQzXo7
         N8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S2j34lTpbzspDY+ZyqDr4gApM+bfTf9T2qudVgijqRc=;
        b=XVK5C+GDnexeXFdB4n6mb0r9hxe5cPhQ2vkplNGgvm0pAVPqDaPZdBMCKVwOKaWgCh
         6c7dQKxbN08RWO1uZSwXMpPcwVSwLGZ5hO3R28KLS/E6raUSIq66bMK/RpGYu+0rPxIN
         ldJSRnYFgjy3k1CVMaV+HZKIvs0QOdvZc0Nj3CnseivtRCla4PGyuY/MVgHq0U2bCelw
         JCTAGt2dLZCIAA0Mj443xgpJWzx6WxkWNLJcdNwJf3gUjqy1P6Q2VwXb7qz8B5HFyDry
         L6Kt73vd+HyC+DryUQT3qkNORypNW+Rjr0ZhD6A8uInqUPBwn5viR1NjdQFdRpgjJBgQ
         zezg==
X-Gm-Message-State: AOAM532NbFwzETWvqUOLBxck1LBXvIUGsN/SOZXe2LBNredCONbo+3PR
        WaGc1cWAq9AadrCaSKmW2PO/vUQz+B5xjgWrbBXVMT2ku9c=
X-Google-Smtp-Source: ABdhPJwJ8B7jsrfiY9NrU0fjWP7fucdxT/nMLGMXdzaDBHSGHFcYEn7WvcTnJPR0FOxX4yEBg8+9xUFdRR+gsA5RbzI=
X-Received: by 2002:a7b:cb50:: with SMTP id v16mr1740007wmj.11.1597110527875;
 Mon, 10 Aug 2020 18:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <3dc4d28e81b3336311c979bda35ceb87b9645606.camel@dallalba.com.ar>
 <4c967884-2252-a21d-a994-80df64a7e6ef@suse.com> <9863afbc619489c98693a4e1d02a38136f5c2ef3.camel@dallalba.com.ar>
In-Reply-To: <9863afbc619489c98693a4e1d02a38136f5c2ef3.camel@dallalba.com.ar>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 10 Aug 2020 19:48:19 -0600
Message-ID: <CAJCQCtS09avevjWuQcy-_9xBdA7zAo_4h81MaRS30btZDJNhAw@mail.gmail.com>
Subject: Re: raid10 corruption while removing failing disk
To:     =?UTF-8?Q?Agust=C3=ADn_Dall=CA=BCAlba?= <agustin@dallalba.com.ar>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 10, 2020 at 7:19 PM Agust=C3=ADn Dall=CA=BCAlba
<agustin@dallalba.com.ar> wrote:
>
> On Mon, 2020-08-10 at 11:21 +0300, Nikolay Borisov wrote:
> > This suggests you are hitting a known problem with reloc roots which
> > have been fixed in the latest upstream and lts (5.4) kernels:
> >
> > 044ca910276b btrfs: reloc: fix reloc root leak and NULL pointer
> > dereference (3 months ago) <Qu Wenruo>
> > 707de9c0806d btrfs: relocation: fix reloc_root lifespan and access (7
> > months ago) <Qu Wenruo>
> > 1fac4a54374f btrfs: relocation: fix use-after-free on dead relocation
> > roots (11 months ago) <Qu Wenruo>
> >
> >
> > So yes, try to update to latest stable kernel and re-run the device
> > remove. Also update your btrfs progs to latest 5.6 version and rerun
> > check again (by default it's a read only operations so it shouldn't
> > cause any more damage).
>
> I have tried again with the 5.8.0 kernel and btrfs-progs v5.7 (which
> I've compiled statically on a different machine and used only for btrfs
> device remove and btrfs check). The system still goes read-only when I
> attempt to remove the failing drive, but it doesn't oops in this
> version.
>
> This version of btrfs check finds many more problems, however the
> 'checksum verify failed' line looks supicious: instead of `found
> BAB1746E wanted A8A48266` it prints `found 0000006E wanted 00000066`
> like if the checksums had been truncated to 8 bits before printing.


6E =3D 1101110
66 =3D 1100110

So it's a bit flip. I think newer versions of found/wanted are only
showing what's different, maybe someone will confirm it. 'btrfs check
--repair' can usually fix most cases of bit flips in metadata. I'm not
sure about the other problems, if they're related or fixable.

Top candidate is bad RAM but it could be something else. Best to start
doing a memtest86+, newer the better. If it's bad RAM sometimes it'll
find it in a couple hours, and other times, a few days which is
definitely annoying.


--=20
Chris Murphy

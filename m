Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 277F5139DA7
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 00:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgAMXwL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 18:52:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35771 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbgAMXwL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 18:52:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so11731890wmb.0
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2020 15:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4XwA5iMCWqTlIPtce3l96REe+1kMbl+YEAYuLXtxAEQ=;
        b=damVoUALcS2t128o+7qNDbDg2/Y/aUeDEt1ziu99QBCgH2JI7Erg8bkd2yulvuGDmD
         YILlobWlSXd5cq0oKYXcY2ChyAXys2Mnx6oDGXkAe6CmGuWr8waFDIAIfLqaIE5TsSg7
         XCoCKAUeixUkcu5d9GwZCyPOBK/4q1UtGP0oSJiWzfgAcN//mKdq+dnn1YcbPOl4QVs1
         dJ6Yod/Ewr+hP3jvhw35DP8uj7WFlmwWkc4uG/a3SNbP7mTCMljQHfF/Dazi7XRqQIB4
         +9v3Uv2to2sFdFga5/hCA0sP4rSwcJcaLuACXrZ10JySxXwMfspTGLKp4tx+XrzICAQI
         m1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XwA5iMCWqTlIPtce3l96REe+1kMbl+YEAYuLXtxAEQ=;
        b=Mm0oE9KhHydi8j3E75XqHML7U91jDCjJlwJkQUfgThmh8dTskisVX6+CkjtjDx6NWy
         vbhQlhnrcCDbkiRzdvHDyb+W5iSrq7hb8eMXgQdMhI130nYnt6gvIrI9XeqDGwX2ouWD
         hJtaOZZpk2ugONf60gbAWLoaHAXwa4byrx6L0QG3OfzJiIBZEhtddX+bUf7kr2Pq6ive
         w7ZS89nckqGEiD+DXKUaJEJ45OtkN0zvg2eVfeHPF0S3Hs4WuSwtjOqR4LG7c7V7HNNJ
         IupvO6FokU3DWoww99aXqOtiFLtpdtdq1j/1xl5RJ6TOpYXWXkgjVrCiJyEOtUiMLUVE
         lROA==
X-Gm-Message-State: APjAAAXAX2vFgGdcKyO02YWV/jikxf212ouA0ejMkrbwTLtb2EeaWWvE
        OKv0cLtaIXhHsfNi/zEIBzmUsMkqZ2daYMbHS7wRAgPujvoqbg==
X-Google-Smtp-Source: APXvYqx0IuE1YxCNd+cAB9ERL83CfEsLje8QTSwTMJhOBMFSwFy5AQzjhx6SfOd51s/msnb5l9jxqevb4gUOGOq5SU4=
X-Received: by 2002:a1c:61c1:: with SMTP id v184mr22842876wmb.160.1578959529750;
 Mon, 13 Jan 2020 15:52:09 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.99999.375.2001131400390.21037@trent.utfs.org>
 <CAJCQCtS9rx0M30zLxkND5MYTwLEPxYG=8BuRB3b1Bi8Vr3KTqg@mail.gmail.com>
 <alpine.DEB.2.21.99999.375.2001131514010.21037@trent.utfs.org>
 <CAJCQCtShpdS81pvc1m26yPmriaE7_3=MZTFkbXknp9+Wehwr5w@mail.gmail.com> <alpine.DEB.2.21.99999.375.2001131532180.21037@trent.utfs.org>
In-Reply-To: <alpine.DEB.2.21.99999.375.2001131532180.21037@trent.utfs.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 13 Jan 2020 16:51:53 -0700
Message-ID: <CAJCQCtR53D88H9--ZRLS-xATZs3zyZXMQwgvGhcuVoKDW1aCaw@mail.gmail.com>
Subject: Re: file system full on a single disk?
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 13, 2020 at 4:38 PM Christian Kujau <lists@nerdbynature.de> wrote:
>
> On Mon, 13 Jan 2020, Chris Murphy wrote:
> > > Well, I received some ENOSPC notifications from various apps, so it was a
> > > real problem.
> >
> > Oh it's a real problem and a real bug. But the file system itself is OK.
>
> Ah, OK. Good to know.
>
> > > For now, the balancing "helped", but the fs still shows only 391 GB
> > > allocated from the 924 GB device:
>
> The first "balance start --full-balance /" finshed, with the following
> message, of course:
>
>    ERROR: error during balancing '/': No space left on device
>
> But afterwards at least "df" was happy and reported 48% usage again. While
> writing the last email I started another "balance start --full-balance /"
> to balance the extents that could not be balanced before because the file
> system was at 100%. But this failed with the same message and now I'm back
> to square one:


That's why I suggesting cancelling the balance.


>
> =============================================================
> # btrfs filesystem df -h /
> Data, single: total=391.00GiB, used=386.38GiB
> System, single: total=32.00MiB, used=80.00KiB
> Metadata, single: total=2.00GiB, used=1.55GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
>
> # df -h /
> Filesystem             Size  Used Avail Use% Mounted on
> /dev/mapper/luks-root  825G  389G     0 100% /
> =============================================================
>
> Sigh. I can't reboot right now, will do later on and will try another
> balance now.

While it won't make things worse, it won't make it better either.

Use mount option metadata_ratio=1 instead; man 5 btrfs if you want to
know more about it's doing.

The bug is a consequence of a series of older bugs that got exposed in
5.4 with a change in how metadata is overcommitted, so now all those
older bugs will get fixed, but in the meantime the problem is more
likely triggered if you have recently balanced metadata block groups.


-- 
Chris Murphy

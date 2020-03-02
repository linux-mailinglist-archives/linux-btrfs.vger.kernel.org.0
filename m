Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 741E817658B
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 22:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgCBVD3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 16:03:29 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:51870 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgCBVD2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Mar 2020 16:03:28 -0500
Received: by mail-wm1-f51.google.com with SMTP id a132so632328wme.1
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2020 13:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTEsypi0vapzRDBTwJfHJBhW7C+MzpmIIwzqIbZls7s=;
        b=blSduI8W3JkBeqMYpiBsndtZePt+STJznNb9rH5b960BjcJHKs9EqnGrtMvTS5PL/Y
         kd/3fI/DO/3FeHgU/OHoYEdmz4yGgI+qDGCyKkY75BuiRSPNyQaxhttG+pYFaQ0NtkRI
         07fOpHUuarkJiPaDvb1dZwUsfGQkXuZh+pUDsbfGdVtJv83k0nqQDEveTicm0F4ohkKp
         nqlEspje7AnFKNoMusBgqQVmm4PE7AyBHp9mjVD4H8BSplP/xfz25YLtv93Cjw2IdVab
         q3/m3hhO5neajBRgyyvmixm+eZPEg1O/y0TrEqauPEdvxn3LKuRzAy55Q5FqlLotgWFJ
         C5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTEsypi0vapzRDBTwJfHJBhW7C+MzpmIIwzqIbZls7s=;
        b=KEogJf2+Nv9+lcMAgililbJplBaCzBIbbbhP0d5RTL4NYev3MGxeT0JENzuMqtgQVS
         xPWVdI+5CvpkLVPhkV2ukW1yenIYt1jeSJ7eWht3DuDaOznFL0m+5b+IPxx+OHFO8ht4
         m0K6GFbz0e1pnKKGYbvPcgPK5p0SxDfnE7T2VXnXXXGW8ckZIc83N2gNRWrsSjsOtlYE
         TMyK2i1GF2Z7QMX0pSlIAZuIcnfWc5WdHt6kDWTAtV3D121UUGwSWxBVHsjmYP1KMUl/
         aCfa6SJmm5IVkmwRYNpDOCMiuWfH4K9TDTaE6MlZAsLM9a6Z5+Qinhf2pYK/WgYF8+ZV
         5jdw==
X-Gm-Message-State: ANhLgQ1pQ2YQpxFVDfwmQpd2MxzCh4vi25F3TWXVm27GT0kKKWGw41SL
        ykdzPeJjqUlxHOV4k81Vwn/xVLchoEf38Jl4oIzaYA==
X-Google-Smtp-Source: ADFU+vt+IgzIfwC72jdRG8JIlNT0mUPcgiDBb8po5IUkIUXR5Q/VNT9P146lWL8MSLY2coe9amVZdp0ggQgKbxdtzso=
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr286971wmf.168.1583183006719;
 Mon, 02 Mar 2020 13:03:26 -0800 (PST)
MIME-Version: 1.0
References: <56ef4bcdd854a9dde3cbe2f5760592ed@wpkg.org> <CAJCQCtTq_ccnhV9BPU3CA08=m6LDtSxgyve_GUckpPB2HKC1fw@mail.gmail.com>
 <fdcfef7036565db2d2fb26d715dce0c1@wpkg.org>
In-Reply-To: <fdcfef7036565db2d2fb26d715dce0c1@wpkg.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 2 Mar 2020 14:03:10 -0700
Message-ID: <CAJCQCtQ0DU5uv0pwJSxRfpc1-bWQnRvtZ07u8JYD8y9jUs=hvg@mail.gmail.com>
Subject: Re: balance conversion from RAID-1 to RAID-10 leaves some metadata in RAID-1?
To:     Tomasz Chmielewski <mangoo@wpkg.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 2, 2020 at 12:39 AM Tomasz Chmielewski <mangoo@wpkg.org> wrote:
>
> On 2020-03-02 15:29, Chris Murphy wrote:
> > On Sun, Mar 1, 2020 at 3:41 AM Tomasz Chmielewski <mangoo@wpkg.org>
> > wrote:
> >>
> >> To my surprise, some metadata is still RAID-1 - is it expected?
> >
> > I'd say it's not expected but also balance is pretty complicated. Try
> >
> > 'btrfs balance start -dconvert=raid10,soft /mountpoint/'
> >
> > What does dmesg report for that command? And are those raid1 bg's
> > converted to raid10? I don't think it should matter in this case, but
> > what's the btrfs-progs version?
>
> I did one more balance, for metadata only:
>
> btrfs balance start -dconvert=raid10 /mountpoint/

Sorry mine had a typo too; should be '-mconvert=raid10,soft /mountpoint/'

>
> And it fully converted the remaining RAID-1 metadata to RAID-10.
>
> Still, a bit "weird".

Yep, I think Hugo's guess is a likely explanation.

-- 
Chris Murphy

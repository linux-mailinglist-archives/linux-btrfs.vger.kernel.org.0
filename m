Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8411B614
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 14:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfEMMh2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 08:37:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50725 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfEMMh1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 08:37:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id f204so8195699wme.0
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2019 05:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7T7n43LuEMQx+dqE5rHBue34882MIhG3Ed/fbkUzR2s=;
        b=nEaGVA8s34QNDE8QFsXfLw1/aYBA80k1eDpry1EW4MpMWvNBmQOYDP+SrWh5V7jvX1
         yKFH9E3FJOZM93WWvwMqu12masvRMiQxgTLTOTNsBJYxl8UpdBkN4jp7OqwASn7Vjb0i
         YPoiMxzOBmFQJOXwgvFPl1H8t6bpwUJ7+CwczCHc6qx+fg5aAwYTA03kZ3D4DM/XgKEB
         ln8ui16ZMU/ANBkfwfnPK/yebzNhrWOobRCgwDJMQl35IW2n/2XiK7WDmRKZGr11feh0
         bDJtzmFZ3bVrr+FGvS2jciTcDAi3W0po8Mcx7MKqF2orKfQ8TFBGfQuFiJrqLXo20rUg
         LWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7T7n43LuEMQx+dqE5rHBue34882MIhG3Ed/fbkUzR2s=;
        b=oDWz8pvjmz6JXH3qehnYB23J3O6d4TFDSCBvZ2YNPyXB4aLbKTy+E4BQvYShMI8oSP
         kXQscDddgqYZEg715tDOn8nYz5U4823H9IomeWcXQ5Tq7nLcp3sRwpmOoK0P0sSBy3EI
         gEGW0NmtHPI+gb8gx8fyS1ck+o8YjtPT0EC2gI0vhF9SDJREIknv4mYalE+AieInZnmH
         sfp9FK+W1lJU4g7x09VFh/QI03iHjQsi4p/HLRUOGFurFzH9Yfmj9BRp/jQGRZXHAvq4
         buRpc1wMNYwsHDbO2+aZepgQeX8dwLUQJjyD7mfYy8ioZiTpuNhPj3obtk1iQjYtn49N
         DAwQ==
X-Gm-Message-State: APjAAAXBVWsncMgGa7WdhpT3/+pZbDhv3QGSMeQZg3B/euwahZ1YsjG5
        A1fPtiFT8hB5VTG/QT8Ikb+CNt7FGzNBJVeQ2T1+9tmG
X-Google-Smtp-Source: APXvYqzDwH/Q66ieFJpjy7XjnrdJYeTy27DkJy3iixqdO5skgWaIeHWHYEtLplwswrCJZRY7WAgzGA3xjl7AD4zr6lk=
X-Received: by 2002:a7b:c846:: with SMTP id c6mr7228032wml.0.1557751046068;
 Mon, 13 May 2019 05:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj_TLB=bqYmt6imjS-QU7OUtvGzatcVDZeCeCj1EfJA-3neKQ@mail.gmail.com>
 <CAJCQCtSED29gxLsLD6FqPx87c63LdZO8TUhZPbVWEw8+a57MSQ@mail.gmail.com>
In-Reply-To: <CAJCQCtSED29gxLsLD6FqPx87c63LdZO8TUhZPbVWEw8+a57MSQ@mail.gmail.com>
From:   Patrik Lundquist <patrik.lundquist@gmail.com>
Date:   Mon, 13 May 2019 14:37:13 +0200
Message-ID: <CAA7pwKNAN8FpjNv10YO6B4yrqxeDiqKo71tpv4bDAQimDm1LMQ@mail.gmail.com>
Subject: Re: Howto read btrfs stack trace?
To:     =?UTF-8?B?T3R0byBLZWvDpGzDpGluZW4=?= <otto@seravo.fi>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 7 May 2019 at 22:43, Chris Murphy <lists@colorremedies.com> wrote:
>
> On Mon, May 6, 2019 at 10:22 AM Otto Kek=C3=A4l=C3=A4inen <otto@seravo.fi=
> wrote:
> >
> > kernel:       Not tainted 4.4.0-146-generic #172-Ubuntu
>
> Old kernel, a developer may not reply. This list is for upstream
> development so the normal recommendation is to try a newer kernel and
> see if the problem still happens. If it still happens, it's still a
> bug. If it doesn't happen, probably has been fixed in a newer kernel
> but hard to say which one without deep Btrfs knowledge of all the
> chances since 4.4 which really is a long time ago, tens of thousands
> of commits have happened since then.

At least install the Hardware Enablement stack if you use Btrfs in an
old Ubuntu LTS release.

https://wiki.ubuntu.com/Kernel/LTSEnablementStack

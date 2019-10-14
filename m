Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 803E3D68E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 19:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfJNRyu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 13:54:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35383 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbfJNRyu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 13:54:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id y21so17627398wmi.0
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2019 10:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mzcwLVmfV/FUmWW2Cu3SOniaKIGNTx91Rv30p0aDkRM=;
        b=rjsj4eitsK3OxBzLYZoQQyMPvcvN4qe6q9cX9P5EtaPr4CS1Axpxc9AlZGh4voBvx5
         ea4N4u7wmuxjee7IoGYFhCiIzhkfdM4jSep1yK+oQKDuOeSSqJ3HRqE01nHhV7hwpNKV
         sgotATzi62nUA+V8JT4RGjEF/nZvbOvLVTuFpxi9Cw7TIFaKuxrrfoTaB3/uKwV71TW2
         2SNSviygHZaicUq6oDrs4B/4tcCBoxQZ9+9dXEmxQPvNdeCDWb6OvdIHtreE7984YlR+
         v6TdYYWIFIWPwDW8aMNXPpv77L030oZo6d6hRSCOfg1xtIUevGogGqcMfDADqzN8Mf4o
         oQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mzcwLVmfV/FUmWW2Cu3SOniaKIGNTx91Rv30p0aDkRM=;
        b=sDdtKcxAwYyRAc12dZ6o9GOCu0hMw9MbBtoQBgQA8ss58TyPLH6WObkmSXzfbzCb5Y
         WjXpRrLwzbOzc4tsPdBoqbMJ4WmG9aLwMUbHjNvHqzazxOeFHt5HTkkwqMtH9+w7aQcN
         bUyYKFRezP128mPoNU+vEOSjqpx7gnxj0O89vnWlOVsuD7lKvCYK1h8mPvheK13L+Qie
         SkH16ixnPTd1YZQakUeU5mKevxGBsdZ2rIcJuUeCuXl1V9XFplAJjEXBZtlN55+/Sc+F
         0sMWzPCBe9N6sxrWwkndgQ28tciwkVhieNiT/I4Kf5+QstyDngOTPotZDddr3IUZ1bqt
         WADw==
X-Gm-Message-State: APjAAAWUrkcDhACxjkzWqT9AMfDBFpqkUIGCCJCrPQGN3l5LIT5Oml4d
        BmK8fC2al51Lch7LUxG7sKiwIKOiRZOmHot7hnYiNPwzotQ=
X-Google-Smtp-Source: APXvYqwpkJWCud2zvnByv1ZBpBXDsoTpAvN7kvswAhGcKL10/TNBq0YaWAQFhgAm6maYqD1kXWT8C+Ckq8SBAwBpBpw=
X-Received: by 2002:a7b:c629:: with SMTP id p9mr16328580wmk.65.1571075688403;
 Mon, 14 Oct 2019 10:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <CAL3q7H4peDv_bQa5vGJeOM=V--yq1a1=aHat5qcsXjbnDoSkDQ@mail.gmail.com>
 <ce6a9b8274f5af89d9378aa84e934ce3f3354acd.camel@scientia.net>
 <CAL3q7H5qNE4rizN14qmgrAwtju9KRHspKxo3S-PoTcSUvXYuew@mail.gmail.com>
 <8c0f8fff-5032-07b6-182c-1663d6f3f94e@petezilla.co.uk> <CACzgC9gvhGwyQAKm5J1smZZjim-ecEix62ZQCY-wwJYVzMmJ3Q@mail.gmail.com>
 <CACzgC9iSOraUua7YtPz-gsvNRF_6Fp3mvkBenETMsVNwnjvuuQ@mail.gmail.com>
In-Reply-To: <CACzgC9iSOraUua7YtPz-gsvNRF_6Fp3mvkBenETMsVNwnjvuuQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 14 Oct 2019 11:54:31 -0600
Message-ID: <CAJCQCtTmtQQi1BRpzRgRezuFm6ps9S1+BBwNkB4+H5WhcyYyag@mail.gmail.com>
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     Adam Bahe <adambahe@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 13, 2019 at 8:07 PM Adam Bahe <adambahe@gmail.com> wrote:
>
> > Until the fix gets merged to 5.2 kernels (and 5.3), I don't really recommend running 5.2 or 5.3.
>
> I know fixes went in to distro specific kernels. But wanted to verify
> if the fix went into the vanilla kernel.org kernel? If so, what
> version should be safe? ex:
> https://cdn.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.3.6
>
> With 180 raw TB in raid1 I just want to be explicit. Thanks!

It's fixed upstream stable since 5.2.15, and includes all 5.3.x series.



-- 
Chris Murphy

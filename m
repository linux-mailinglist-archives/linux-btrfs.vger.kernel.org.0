Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDDA2170D63
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 01:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgB0Amz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Feb 2020 19:42:55 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:38438 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgB0Amz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Feb 2020 19:42:55 -0500
Received: by mail-wm1-f42.google.com with SMTP id a9so1432892wmj.3
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2020 16:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vK9tQ5yPKpkH9EyQ/s9cCH2fNYhknElzyGcBEOhCx8M=;
        b=qPt8WO9+N092bIEYdrqpVIzImRsKqQf5APUUDMCWNMgeGo+/9GsedhAID3fJkLirap
         DiC6AZdesBzBRMjyanU1o3H0QzQp8mGO57b4VQ+CIGdwL8YMLXcJDX1cMfA19tgL0qrq
         LWG0MAezMibkehc5FUk62+Ta2Kp5fTdoW4C8b5ppScGHAhQcqrqM/HIU2ZPmN2kShCOQ
         meGYdniYhivjUjTnBmSHNRuE4nzmmFBoGu9+7otQVwEVCvSvd12Xyh1kv7cAuWUBr0Wf
         fARCQup90uFiZNntwVypEAVuH55/KTulrL44Ak7mYAGfzT/qF6945pRZLXOLeqnv8e4P
         OP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vK9tQ5yPKpkH9EyQ/s9cCH2fNYhknElzyGcBEOhCx8M=;
        b=hSuZeGpcsEwMDbgKzzPbmCKN8tzTY70LwKy7irpfpDgLpeXhY6ADXubIWvb4ufxSDS
         vCVlMHp4hrbdKM6TQL7KRoUttiHFL9VArY6nOSpUCaUXAQHmjnUvh04GHh5HXzjDiqdV
         jXxuzq+1rhK/gQUTa65Jwwn5gJRGP66MUhkDBq3tZ8TI9hQuyu52hTUrUaSYTnc3rjwH
         RXpJrzreEjNwKbKOQ4tC/AIp3RcsSlARlkk6B4zOH4u1T+RbEgqidWDAHU82XwEP3OZU
         IrWeZ4TEDSf09KMaL+NBKQdKQCI+gbsotwxN4ZHayPWnZoFVTUPrS8XioKrgUX0jLZrh
         C/mg==
X-Gm-Message-State: APjAAAXBUejLqZCYzIvq3FGgOqLlO6VRji8gC+80Z4sAINolpcbYVq19
        D+q8XxpTDSTYg6r7r/BQw2meQrvqeUwLh9RapBFpfA==
X-Google-Smtp-Source: APXvYqwPZf4SAD+/nSJ9jUNCQTYddiyWSLEX+PiL+KvhfYe55cvXt5eYrOrZvTLpjOa520TPvm5GzIZ2KG1fZq5BqM4=
X-Received: by 2002:a05:600c:20f:: with SMTP id 15mr1573620wmi.128.1582764172937;
 Wed, 26 Feb 2020 16:42:52 -0800 (PST)
MIME-Version: 1.0
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com> <CAAW2-Zfz8goOBCLovDpA7EtBwOsqKOAP5Ta_iS6KfDFDDmn47g@mail.gmail.com>
 <60fba046-0aef-3b25-1e7d-7e39f4884ffe@gmx.com> <CAAW2-ZdczvEfgKb++T9YGSOMxJB+jz3_mwqEt2+-g0Omr7tocQ@mail.gmail.com>
 <CAG_8rEfjNPwT4g2DwbS9atsurLvYazt7aV4o77HGv-fssNmheQ@mail.gmail.com> <CAG_8rEddjjA2kta486kZ7B9J7s4F5twyqrxL-kff783atxSFXQ@mail.gmail.com>
In-Reply-To: <CAG_8rEddjjA2kta486kZ7B9J7s4F5twyqrxL-kff783atxSFXQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 26 Feb 2020 17:42:37 -0700
Message-ID: <CAJCQCtRNumWrBAM905cyd0GWJnBfFo=AbjFPKyMr236xooefpw@mail.gmail.com>
Subject: Re: USB reset + raid6 = majority of files unreadable
To:     Steven Fosdick <stevenfosdick@gmail.com>
Cc:     Jonathan H <pythonnut@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 26, 2020 at 4:15 PM Steven Fosdick <stevenfosdick@gmail.com> wrote:
>
> then after mounting degraded, add a new device and attempt to remove
> the missing one:

Sorry. I misread this as just removing the missing device. I didn't
catch that you had first added a new device first. That's OK.

But it's still better to use 'btrfs replace' command for this, because
it has quite a lot of shortcuts to do the rebuild much faster.

-- 
Chris Murphy

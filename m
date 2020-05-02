Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13E51C23D4
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 09:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgEBHU5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 03:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726488AbgEBHU4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 03:20:56 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1B1C061A0C
        for <linux-btrfs@vger.kernel.org>; Sat,  2 May 2020 00:20:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id w14so5525818lfk.3
        for <linux-btrfs@vger.kernel.org>; Sat, 02 May 2020 00:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x2fHBi/oZzP45u6AhVS8mARkQuClfrhO5pMz/gW6/xE=;
        b=Pk2UHi+CDAhh0iYtkLOw0q9lNJMPEALwMLXAWl+HZjcpJAvTozoXw/zE4a0AYlWWWl
         a7+/C2aZB27satp7fLFvgCAItlTnxXgYNPzor28cs9z9sIP1/YcPnROeTBi2stdVr71x
         wjYtyiztoSVf6fwKPAdf4dlS+xBDlmWYWA+SWe7ehrmi0g4bOmdqHjNiNf/cQsFMNHFd
         plDzOPZYlBTppleYEkL/Q33yZh+/T7W7oI8EjXde7N372lLu2ht25nafBTm3lfsE4CKq
         LvzbF8TuyYfuCqGhS6jXuQ0i02lBOorTEWJ0woSHe1ZV30lElQl2RqzyP8j/ar4bdJjv
         a6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2fHBi/oZzP45u6AhVS8mARkQuClfrhO5pMz/gW6/xE=;
        b=tdllJ/MCir8HbDSphUxExMdS03zTnbKsLitjRdptv1iF4OqJsQQq4EZWdNdATe9Tw/
         R0ElGPMxfxeoXYfbekGwNLLUuGk2XzlhQiSB0giV0LXvosFZJl2QGLuk3G98xwKM2tte
         ujPr0UuIYRVTOcvoiR1+lKuHMkXbGVk36nUajIn5FHvp7HUUtlG2p0R0AeQUr4PMn3Ty
         pb9xro+DxVaK5rwbnPal7wCVsCU2Chz9j6+l0c2C0gG2rXJr6QgwY1GwncMdDoW3Bi1j
         vXnKFlTGUXgmTlIohNbeMYkrYOt9HpzwSE7zMLySRlo2KQzaXGWhFSgupG0iT9kFOVRh
         NsUg==
X-Gm-Message-State: AGi0PuYiHRoYfVfj44RPugw1+oCIzQOtWe3DlZfi/46fbYq9EAvzvS5S
        +Q4P5h+R2f6ZTzsg44XDd9L6+bHW1BL1K38ak4v6o/8ujGM=
X-Google-Smtp-Source: APiQypIDAp5Lm7vbcWKuhSfsGj3gXvsOmjFsoWOqs6elX77kNFraZWQeyFP2AiXsLI81NKgB631OTxI19WqXFc5bK5w=
X-Received: by 2002:a19:c515:: with SMTP id w21mr4844140lfe.186.1588404054199;
 Sat, 02 May 2020 00:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net> <r8f4gb$8qt$1@ciao.gmane.io>
 <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net> <20200502033509.GG10769@hungrycats.org>
 <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <20200502060038.GK10769@hungrycats.org> <SYBPR01MB389730010988EC44E7D109EE9EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
In-Reply-To: <SYBPR01MB389730010988EC44E7D109EE9EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
From:   Phil Karn <karn@ka9q.net>
Date:   Sat, 2 May 2020 00:20:42 -0700
Message-ID: <CAMwB8mhGkcM3DCTusuHAi-cQcr-FrA5cq4hVYfv+65zn_QjAig@mail.gmail.com>
Subject: Re: Extremely slow device removals
To:     Paul Jones <paul@pauljones.id.au>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

So I'm trying to figure out the advantage of including RAID 1 inside
btrfs instead of just running it over a conventional (fs-agnostic)
RAID subsystem.

I was originally really intrigued by the idea of integrating RAID into
the file system since it seemed like you could do more that way, or at
least do things more efficiently. For example, when adding or
replacing a mirror you'd only have to copy those parts of the disk
that actually contain data. That promised better performance. But if
those actually-used blocks are copied in small pieces and in random
order so the operation is far slower than the logical equivalent of
"dd if=disk1 of=disk2', then what's left?

Even the ability to use drives of different sizes isn't unique to
btrfs. You can use LVM to concatenate smaller volumes into larger
logical ones.

Phil

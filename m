Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9442F1A74
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2019 16:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732176AbfKFPxL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Nov 2019 10:53:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40335 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfKFPxL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Nov 2019 10:53:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id e3so9507570plt.7
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Nov 2019 07:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1fizV1YE05/lRni0cbIbi9Bm8JNFW1OZSzaCiOatlNE=;
        b=oBOTBINseDshhti7cb4CsSl6/0eD8HUizci23ZYCOeXRLT+CyTtZQUaBIpfENf2j8T
         muN1b99wcQ1b31ZCunZxMXERFwk/dB1e3MSZDTLUdSWquGBi/AqT6JYIw0sDlEmxVwGO
         Cr+VL9C5lvmu0WHL8+C9ZW4IFqdV0bbsUeSuXtQQaKdCiAac8V8E3MK6XPPlXvXieTk8
         AF2idDSC7Lh/wcl09yQl4+QswpRycXNMvzI5tflOxHSUYoZa1L3ZL0b08iIHvPIwRKSC
         5A61qrLV7pH3+QveqfqmSK6A4Ir8C4Namfy2UyiUS2W+3J2c8gOyCqeML7FdumUq77M1
         0Qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1fizV1YE05/lRni0cbIbi9Bm8JNFW1OZSzaCiOatlNE=;
        b=oLkoCQMHD4QQd2ryJwkVT9jTa+mGxnwEL3RO0JE6jMA7qb5KcKWWXaLhoE+5cM+dvp
         107mpRxiEl20yDJB6m6apPsvOo0EfQ2644QRNHst8RZKhzjjeXCziQMDauwuJVUtmxyI
         PPCW32+B5EFftmIpD+GjRkvVzBoN/OQkld5DZVtIu5FyD6AFGOtmxCapw6229O0f/8VZ
         dQ0+C/2IMCgZkA9PkKvsVYf9iPS/0RNZwaNKxPunJVrYSDOxmMPKCvUZazLpScWpdPLS
         Ev6nFZxyl+/UMvRxFCW60rnVEE9W8MH4u25cY7g1RgDR2H4vUpeHjyTBHRf19NOP8N9R
         2qRg==
X-Gm-Message-State: APjAAAXVr5suE1/0K+4a4Krxjv7cukcP/sDLfnKAKaVcAX8xOQ7en2eM
        RbinfDkBDVZg6NgdS9X3QJdT02Ela3jynu1xWsw=
X-Google-Smtp-Source: APXvYqzRt6ANWN2xqYaXFRQ/AlCvVhxkaaZKu+UWA2nOMkMNuHy5keHeBtrWzjKwVQXfFEmMQlDfOnAC9o3pzAVv27M=
X-Received: by 2002:a17:902:9a0a:: with SMTP id v10mr430623plp.190.1573055590287;
 Wed, 06 Nov 2019 07:53:10 -0800 (PST)
MIME-Version: 1.0
References: <CAJjG=74frVNMRaUabyBckJcJwHYk33EQnFRZRa+dE3g-Wqp5Bg@mail.gmail.com>
 <187ab271-f2be-9e96-e73a-0f6f3e97655a@gmx.com>
In-Reply-To: <187ab271-f2be-9e96-e73a-0f6f3e97655a@gmx.com>
From:   Sergiu Cozma <lssjbrolli@gmail.com>
Date:   Wed, 6 Nov 2019 17:52:33 +0200
Message-ID: <CAJjG=77Csw5P4q1sPeinoT=y=9Gy=FUr88NK2mJH72OBExnHgQ@mail.gmail.com>
Subject: Re: fix for ERROR: cannot read chunk root
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, thanks for taking the time to help me out with this.

The history is kinda bad, I tried to resize the partition but gparted
failed saying that the the fs has errors and after throwing some
commands found on the internet at it now I'm here :(

Any chance to recover or rebuild the chunk tree?


On Wed, Nov 6, 2019, 13:34 Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/11/5 =E4=B8=8B=E5=8D=8811:04, Sergiu Cozma wrote:
> > hi, i need some help to recover a btrfs partition
> > i use btrfs-progs v5.3.1
> >
> > btrfs rescue super-recover https://pastebin.com/mGEp6vjV
> > btrfs inspect-internal dump-super -a https://pastebin.com/S4WrPQm1
> > btrfs inspect-internal dump-tree https://pastebin.com/yX1zUDxa
> >
> > can't mount the partition with
> > BTRFS error (device sdb4): bad tree block start, want 856119312384 have=
 0
>
> Something wiped your fs on-disk data.
> And the wiped one belongs to one of the most essential tree, chunk tree.
>
> What's the history of the fs?
> It doesn't look like a bug in btrfs, but some external thing wiped it.
>
> Thanks,
> Qu
>
> > [ 2295.237145] BTRFS error (device sdb4): failed to read chunk root
> > [ 2295.301067] BTRFS error (device sdb4): open_ctree failed
> >
>

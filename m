Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17FCFBD474
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 23:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfIXVqR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 17:46:17 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:50779 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437852AbfIXVqR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 17:46:17 -0400
Received: by mail-wm1-f48.google.com with SMTP id 5so2050218wmg.0
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 14:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cDy6FqKVBQAkyMpruiTZXRFv62yD0TO5lPBsB4vWP8w=;
        b=Z0XmXPnM4M59NK3YqZ57I+oEGiXrvghe3eEIE8mDLk1vgW3S3RVeJIoHvpwtGP5Ez6
         Ao/yOu1dTX8prSjm3TzEvr4GMxXwIxEzoeb30kcIfe0WedmcJsD1MAgyFVe47x0WFQmg
         KRKtJEpq1xrBBepa0vJXXqBQDWAzyXAYWyBEQWrToeCD5+CG+e1FdPl/yycIwzpj3RFp
         2PFvoghaxrBi58xPlHeeNJ24b7f9t7FT8PqL1qHJmMVCKEsGhXwCD1sc4irg5MVT5s9C
         qdj8QTjD7GAyt531fswGWgvmYMx6+WSvrQHCste6dLzr5y1SvAe+hAOkia6k7gFlA3hM
         wMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cDy6FqKVBQAkyMpruiTZXRFv62yD0TO5lPBsB4vWP8w=;
        b=RHzVyserBEgTEleGa1o/eAxHSTQ1mZyFHMX74qP7he8CkLV47ZzWtBu+PApEZ/Tyci
         dhpl4ctRCyq2RZL51qxkUCYtEvQPYXbCLUuUU8iZRgETwdY3DYdMHUZFRS93dZcA+6Nu
         nBaQl9elr2/aavpea1kwZo/9K0tZaanhXm1BUFVvhGhhVUe50SzOGIQU7ENixULX5XX4
         TOL30PgW6Xdz7rtufxtpdpbzSFGvIQxkV5PP8rtigciMq1cdvooZcnh5JKNEqLcvKIgu
         KGYM7Y1+oO/lPzIoMkiqVYBnOTIpWdf+e2ZTS9A7tLC1DVm5H6C6aYbYpEgksUy/pf5Q
         nx3A==
X-Gm-Message-State: APjAAAUUNnc818sebkl1ICAXOQfoeZ+ik3Z0Dj79fS5RGNNDKHd+z96T
        oqEpgHCW2Axe8H8FMPkxC9trgzHgXDT2prHClf9bVfHaPUpN/A==
X-Google-Smtp-Source: APXvYqy27FKbxB7VKHOw/vjr8slTIGvlCs+nrD8w1oi3l3j2GU75qVPPQUrVawsL0fO/vcqQCt+vQQ/cwKGz+5aLvGs=
X-Received: by 2002:a1c:4886:: with SMTP id v128mr2789875wma.176.1569361575716;
 Tue, 24 Sep 2019 14:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <000f01d5723b$6e3d0f70$4ab72e50$@gmail.com> <CAJCQCtSCJTsk1oFrWObUBpw-MXArQJHoJV3BeBk0Nfv_-AoS8g@mail.gmail.com>
 <003f01d5724c$f1adae30$d5090a90$@gmail.com> <CAJCQCtTwjUok145SqnbwfBYKipVhcV7J94HX9Lx4mgaFV3FaBA@mail.gmail.com>
 <001601d572ba$90591b60$b10b5220$@gmail.com>
In-Reply-To: <001601d572ba$90591b60$b10b5220$@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 24 Sep 2019 15:46:04 -0600
Message-ID: <CAJCQCtTjWAHd=tu8TuURGEYBMP0=RCeYaJ=-r1KY9YjdEUpNNQ@mail.gmail.com>
Subject: Re: BTRFS checksum mismatch - false positives
To:     hoegge@gmail.com
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 3:29 AM <hoegge@gmail.com> wrote:
>
> # btrfs fi show
> gives no result - not when adding path either
>
> # btrfs fi df /volume1
> Data, single: total=3D4.38TiB, used=3D4.30TiB
> System, DUP: total=3D8.00MiB, used=3D96.00KiB
> System, single: total=3D4.00MiB, used=3D0.00B
> Metadata, DUP: total=3D89.50GiB, used=3D6.63GiB
> Metadata, single: total=3D8.00MiB, used=3D0.00B
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> Here is the log:
> https://send.firefox.com/download/5a19aee66a42c04e/#PTt0UkT53Wrxe9EjCQfrW=
A (password in separate e-mail)
> I have removed a few mac-addresses and things before a certain data (that=
 contained all other kinds of info). Let me know if it is too little.

I think they were having problems, I kept getting 502 errors, and then
reached the download retries limit I bet.



>
> Concerning restoring files - I should have all originals backed up, so as=
sume I can just delete the bad ones and restore the originals. That would t=
ake care also of all the checksums, right? But BTRFS does not do anything t=
o prevent the bad blocks from being used again, right?

We don't know if they're bad sectors or not yet. That would be shown
by libata as a read or write error. A read error, md will handle by
reconstructing the data from parity and write it back to the drive.
And at that time the drive firmware will determine if the write
succeeds or not and if not it'll internally mark that physical sector
as bad and remap the LBA for that sector to a different reserve
physical sector.


> I'll ask Synology about their stack.
>
> I can't find sysfs on the system - should it be mounted uner /sys ? This =
is what I have:

# echo check > /sys/block/mdX/md/sync_action

replace the X with the raid you're checking - this is a bit different
if they're using LVM raid.



--=20
Chris Murphy

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFFD2D3B12
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Dec 2020 06:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgLIFxU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Dec 2020 00:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgLIFxU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Dec 2020 00:53:20 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FB5C0613CF
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 21:52:40 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id k14so387812wrn.1
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 21:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJoQ/HS83gx6bEB6CMbdfsYomnwuNsnvQ/NwaCCblwo=;
        b=HZxPqlkiiPu51DTN4tOJWx40Urd+nEu9GZ0SV7cxiOmM/SQSLaBM3eqwW8MV725uN5
         0lJTebWW44Hn/IebyBs9TW/HFl7QV0Js7ozwigxsOKJSY54YxomXF5zr/PptIQGbnVdq
         W1aCeeFan5lLSF6eYOplRZqJ4cOgqS9KzmqA4jvhhqU36kh6wjDBNOq+i7SlT2Pv9WEx
         0X30CpOgrFRThMKnbAcgoQzDKR3LnlepaycgXDWQ376qEfnpBizEMFT2z+C5rRVgluWb
         2wgRBo+O6UgzTf6r+e5p/ciiOaKX0baUJdS8184QZT7qaJQASgDatRinXJ3BfUcoHToE
         V4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJoQ/HS83gx6bEB6CMbdfsYomnwuNsnvQ/NwaCCblwo=;
        b=JgqQZM/2kT++JOSTbuXUXvHeSCkr6RJ2E0Ug8SDNggKzuOpQXnnCEpK2LQX2m2QDNh
         yQ0DYT5TrHLDiuwdshXPbq+5I240IL82kIv0VaNVsB/b5SB46vjT/1hJOtx5unGGvv43
         FwgE5MF79/aoSRcAHsBKiXX6GwtRdg4HjF0g0DqBBRkJVU33vKiVQI7OEA5BnjZzGJ6R
         8n3RS06L9DYip0LM6+b0a2PS+ETOeNI5yhfrDT8i423UGw1xGwKYSWMmoeFYHUTZyOSW
         9kZvfUHfEGS/1fHi4B4lkhdcr3EucxhYTTfyTzxt4ZISWLB2YxQzo1zv5Lgodgzmz5Q1
         48Kg==
X-Gm-Message-State: AOAM532o+WKU35LOlbNbVjeAsEm6n9ZWeaKdOCsNE2a7aKdv0TIixk2/
        lesMlrhXLoip6gu/wPm7Sc4ZvrH76l0UnuHlH0V6xNfg4OZJ4vLL
X-Google-Smtp-Source: ABdhPJyKDhtTT8xsQM9/5T2GVf5EeOFoZFV99JWf84/Wk8SQRV3FLlLch6dn9uXxQQQ60ZlqSHfDner1bIn4ZIo89Dk=
X-Received: by 2002:a5d:488d:: with SMTP id g13mr700005wrq.274.1607493158733;
 Tue, 08 Dec 2020 21:52:38 -0800 (PST)
MIME-Version: 1.0
References: <CAD7Y51gpvZ79nVnkg+i3AuvT-1OiXj0eaq2-aig38pGmBtm-Xw@mail.gmail.com>
 <CAJCQCtS0HVBQZ1-=oAhvYnywUVuhjS__8qf553YMoRWriabADg@mail.gmail.com>
 <CAD7Y51imT3BhQzMHqVUB=ZMcAQiSPoG8E8HZMVmpggzjDgN9fA@mail.gmail.com>
 <CAD7Y51i=mTDnEWEJtSnUsq=xqbEtGC2NP0Yo4vAcPkSu+Wq+Rg@mail.gmail.com> <CAD7Y51hdeJVNBAYQXxvf=kUOKh_KYX286Hzoy-qJ8izn+crVtQ@mail.gmail.com>
In-Reply-To: <CAD7Y51hdeJVNBAYQXxvf=kUOKh_KYX286Hzoy-qJ8izn+crVtQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 8 Dec 2020 22:52:22 -0700
Message-ID: <CAJCQCtSTgxdjwXs+hKbka1s8YUJxuGxqHVTdCkV0bAasp8Zz4g@mail.gmail.com>
Subject: Re: corrupted root, doesnt check, repair or mount
To:     Daniel Brunner <daniel@brunner.ninja>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 8, 2020 at 5:30 PM Daniel Brunner <daniel@brunner.ninja> wrote:
>
> Hi again,
>
> do the outputs of said commands help in finding the issue?

Not really.

The btrfs super blocks are valid and are the same. So at least those
three locations aren't affected by this problem.

btrfs superblock reports:
total_bytes
29202801745920 is 27197.2 GiB
bytes_used
17674898116608 us 16461.0 GiB

mdadm superblock reports:
  Array Size : 39065219072 (37255.50 GiB 40002.78 GB)  this is
40002784329728 bytes
Used Dev Size : 9766304768 (9313.87 GiB 10000.70 GB)

 # blockdev --getsize64 /dev/mapper/bcache0-open
40002767544320 is 37255.4804611206055

Array size minus bcache size
40002784329728 - 40002767544320 = 16785408 is ~16.0078125 MiB

Is it normal for the mdadm array to be bigger than the bcache device?
I have no idea. I don't know enough about bcache operation.

But the btrfs file system is at least smaller than both the bcache
device and array. So maybe it's safe? Ideally they are the same size
but smaller Btrfs than array size isn't bad in that it won't break it.

However, I don't know why Btrfs report ~16T used, and yet mdadm thinks
~9T is used. That seems like a big deal.

Based on the description, this isn't a Btrfs problem. The file system
shrink happened first? And it succeeded? And then you used mdadm to
shrink the array and now btrfs won't mount anymore. So it seems to me
the problem is either with the mdadm array or bcache, and I don't know
enough about either one of them to help figure out what is wrong. And
you'd have to know what's wrong first, to know how to fix it.

You could ask on both linux-raid@ and bcache lists.


>
> This corrupted fs blocks my homeserver usage and if the data is not
> recoverable, i would start all over again.
> I do not have enough disks to backup the current corrupted state.
>
> Losing the data would mean about 10 years of hamstering/collecting
> stuff would be lost (only some parts are backed up externally),
> so if there is any chance of recovering I would keep the machine
> offline until any new ideas pop up.

The data is there. The questions remain: what exactly did happen? and
what exactly should have happened? If you can infer the first
question, you can reverse it and get back to the data. But I don't
understand the relationship between bcache and mdadm, it's a bit
complicated and that makes recovery more difficult.



-- 
Chris Murphy

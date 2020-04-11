Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452401A5398
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Apr 2020 21:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgDKT7c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Apr 2020 15:59:32 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:39425 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgDKT7c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Apr 2020 15:59:32 -0400
Received: by mail-wm1-f52.google.com with SMTP id y24so6002390wma.4
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Apr 2020 12:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2EIxb7bqRyMzgnz51nm8IqOq2zxJo84+mVYBGP8lfYs=;
        b=fgk4RXk+vTQ7jTN70UqGweIHYkaTGSgpY31kc1E4NpQeoqb6UdTBWbFlXSlVREcwNa
         3PIhvEbmH8PYLrxzcigWVVweq8N4uTXFnigSPXCY+cgdFgJIWlQ0VF4qe8UeMLBiiPDm
         H2BxMI7etWmnxoV8chV6g/mf7vEFy2+p6TRCNC96xddcV6HunxwQunV61zI2Om9NwFqa
         fwrhNomfi9ABbaqkCjfxeh2vxXcmFUpKnoT3U/dnqna1R6GmTLbbozknQ1JrAWyNOu6b
         VH0OKCdlzCd9zVrWZPDqk9ozGHBCcqpyxxqgS/LDpHOGrA+R1R+aGC+nhpiFBamlegRU
         NaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2EIxb7bqRyMzgnz51nm8IqOq2zxJo84+mVYBGP8lfYs=;
        b=aOmlkkQIqhw1mMUVnOH1GW/BOMxq9S+IEeObvcvWYKQELZdagoHCPGEYE2eQnxMO3i
         u2DmQtDUkSx7u3jAaeGY/SlgJKM4nk+TSscVkeDgVZrR78IsF+gTUxL6Z/H35rq5Sc5g
         xWICAO+ukVe9yeZ/P62pBp+tn8ebv2W5pi8aPueE7khIdFhRQ1cjGb2gg7LyheDmaixo
         E9JMMaaA001z6pXGRIhZm808jtEycPTeRJTNrXzViMNw23pEdZcgTahKLn04aBvSxnKj
         ynWmql+kykGsKccmTDa4Kz6zgtHWLD9yMtp7hq/++EDkT6noDQaTS57mHU5RytocfHzL
         2TLQ==
X-Gm-Message-State: AGi0PuZxjQjJ6/Oz6S3L/aO2DBmzGWYYwT13z/9dvjAiOYFa22zutqqp
        46LajRwypOzJ57Q/fhRsnO2/QjQ1Boo/mlTfGGtBbQ==
X-Google-Smtp-Source: APiQypI+N1Li9MPpsKkR7TeW16Rb7J5Mib36XcX/HhEz7QiFDhK+6FsnrD7vS8EmMJ/QZ2GzfhZ+3IEJBQbXT4ViAj8=
X-Received: by 2002:a1c:6455:: with SMTP id y82mr3833273wmb.128.1586635169184;
 Sat, 11 Apr 2020 12:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <6a1c8ce0-ce2a-698d-dcc6-0657a125dae4@gmail.com>
 <20200409043245.GO13306@hungrycats.org> <e1ed482f-158a-650a-f586-d8ad0310157d@gmail.com>
 <20200409230724.GM2693@hungrycats.org> <a4c5fcd2-c6cd-71e2-560e-9c7290e0c47d@gmail.com>
In-Reply-To: <a4c5fcd2-c6cd-71e2-560e-9c7290e0c47d@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 11 Apr 2020 13:59:13 -0600
Message-ID: <CAJCQCtRGOJQrQf-QhXDnHf5P32ihixZ=8_D8+Bu+vxSUdj4oNQ@mail.gmail.com>
Subject: Re: btrfs freezing on writes
To:     kjansen387 <kjansen387@gmail.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I don't know how much the size of the metadata chunk matters with
this, but I see 256M, 512M, and 1G metadata chunks on my file systems.

Try this for length only, which is in bytes:
$ sudo btrfs insp dump-t -t chunk /dev/nvme0n1p7 | grep METADATA

This will show the entire item, A5 might be needed to show both
devuuids, since you're using raid1, and might want to know on which
device the chunk is located; the devuuid is found in the superblock.
$ sudo btrfs insp dump-t -t chunk /dev/nvme0n1p7 | grep -A4 -B1 METADATA



Chris Murphy

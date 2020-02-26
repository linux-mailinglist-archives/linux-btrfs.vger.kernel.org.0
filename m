Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4171016F485
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2020 01:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgBZAvu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Feb 2020 19:51:50 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:32799 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgBZAvu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Feb 2020 19:51:50 -0500
Received: by mail-yw1-f67.google.com with SMTP id 192so1576715ywy.0
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2020 16:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wo3lCBt9pZnMbwb8HmOYJTnEPAmG8pMlMQAzN56fDSw=;
        b=aow32dVxAkXf4VQ5DyHbPS2C3qcVT0dcGeml06XAQLMLEB86aYrQC7HPyDbjR+qNmN
         sa5Y1TC3qOCOVNpzgE6E3rhiVZ5bvVyacCXzSOkN3YfmitVNPCE2T3X5J/8ajq9D3oBa
         naTmMOQhy32MPkrR4DEvboH3r9ZS3pYNxVr2kyeMXHf189B09Q4IEuF+cyvPyHFHX8z3
         eOEfZ9RTETcQDJvkd6Q5FoxEwAmgb3y0pgxBGGbinNQpcmvw/72RANYfFK8PAoIY6CvK
         QxfNfOeCNAUpc4SLBWZCSgXnnRHPg9l9lE4D4vDZBL+TVOtwAmbrol/CDWYxoxod4Maq
         2qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wo3lCBt9pZnMbwb8HmOYJTnEPAmG8pMlMQAzN56fDSw=;
        b=OhY6f+J5bdpAuQPV30JGuglrpjHK0otLb2itMD2mX8Vd7bhMaTuYWDuPzDilCTbSeY
         vUSYcL7ZDdwNeKaiERbPBwJXLlBvKkZOFJOH/OMm7cKXZFO6TW4ikETtkjNl0zu5UUZd
         pfWCR0q9f3qRZS1CzWXtgaRAaJ7HTbDgtiOfLq4hdrwTXLM81vwhxzVgfJHvNBPx+gFi
         zHINWnIH09NhJcU/4eoIPWSjolDP7JE7kGzm6FmQ8hcYy7gIiddVTevoyBIvTl3gb2bl
         nugXUzULVZhtfTnAG/9Hll2ZkR86OdF3igixOGStktNAxAbX6cxriJHc0R9xMJgvmagY
         J1PA==
X-Gm-Message-State: APjAAAVyOqlJ5fvVIaGZmmjrD3BUfoQFtNhbOThiRZVhcRVUyjkdlOmC
        lAikBEY1X/VbJCYGNC8C9BJyE0AhSmbILnDqHeU=
X-Google-Smtp-Source: APXvYqx133Wb7KL4p40fKOTMWAtO+l+6JkuAMEYX7uwBeb/xmvXwtGrLCc8T39hHg+YKDJtt0FLucXKi7BK2yWdW+dQ=
X-Received: by 2002:a25:8804:: with SMTP id c4mr2235443ybl.387.1582678309834;
 Tue, 25 Feb 2020 16:51:49 -0800 (PST)
MIME-Version: 1.0
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com>
In-Reply-To: <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com>
From:   Steven Fosdick <stevenfosdick@gmail.com>
Date:   Wed, 26 Feb 2020 00:51:38 +0000
Message-ID: <CAG_8rEf4BQpBPkYQywhMgg8Mw=-R8fs1KkE=n5qAz5XKevNM5Q@mail.gmail.com>
Subject: Re: USB reset + raid6 = majority of files unreadable
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc:     Jonathan H <pythonnut@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 25 Feb 2020 at 23:59, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> On 2020/2/26 =E4=B8=8A=E5=8D=884:39, Jonathan H wrote:
> > [  +2.697798] BTRFS warning (device sdb): csum failed root -9 ino 257
> > off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 1
> > [  +0.003381] BTRFS warning (device sdb): csum failed root -9 ino 257
> > off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 2
> > [  +0.002514] BTRFS warning (device sdb): csum failed root -9 ino 257
> > off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 4
> > [  +0.000543] BTRFS warning (device sdb): csum failed root -9 ino 257
> > off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 1
> > [  +0.001170] BTRFS warning (device sdb): csum failed root -9 ino 257
> > off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 2
> > [  +0.001151] BTRFS warning (device sdb): csum failed root -9 ino 257
> > off 2083160064 csum 0xd0a0b14c expected csum 0x7f3ec5ab mirror 4
>
> This is a different error.
> This means data reloc tree is corrupted.
> This somewhat looks like an existing bug. especially when all rebuild
> result the same csum.

This looks remarkably similar to the errors I am getting that prevent
removing a failed device from the array, except in my case it is only
the found value is the same in the whole set of messages, the expected
value varies.  Do you know if/when this bug was/will be corrected?
Can the reloc tree be repaired/rebuilt?

Here are the messages I am getting:

Feb 22 20:08:01 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 261 off 1494745088 csum 0x8941f998 expected csum
0x99726972 mirror 2
Feb 22 20:08:01 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 261 off 1494749184 csum 0x8941f998 expected csum
0x4c946d24 mirror 2
Feb 22 20:08:01 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 261 off 1494753280 csum 0x8941f998 expected csum
0x3cacfa54 mirror 2
Feb 22 20:08:01 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 261 off 1494757376 csum 0x8941f998 expected csum
0x453f4f60 mirror 2
Feb 22 20:08:01 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 261 off 1494761472 csum 0x8941f998 expected csum
0x5630f6fa mirror 2
Feb 22 20:08:01 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 261 off 1494765568 csum 0x8941f998 expected csum
0xbf215c7a mirror 2
Feb 22 20:08:01 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 261 off 1494769664 csum 0x8941f998 expected csum
0x242df5b3 mirror 2
Feb 22 20:08:01 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 261 off 1494773760 csum 0x8941f998 expected csum
0x84d8643c mirror 2
Feb 22 20:08:01 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 261 off 1494777856 csum 0x8941f998 expected csum
0xcd4799e3 mirror 2
Feb 22 20:08:01 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 261 off 1494781952 csum 0x8941f998 expected csum
0x84e72065 mirror 2


Regards,
Steve.

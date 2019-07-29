Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDF6E793AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 21:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfG2TUp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 15:20:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42449 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbfG2TUp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 15:20:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id x1so13161737wrr.9
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2019 12:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vX49INcmmLrvTviB9rPwp8Mp4TIMamo+j6PYJ+aDTr0=;
        b=DUKEYGaw8DjNQzzvL3FGl59Kc4DilazQMj6pKSriSeZcuhybmhc4qd34ydjqAI5oNm
         UzOHwHSNM1hVYJQW+gEfhJH14GeNSCRJEPYIlx85svQqvZKHr4MjvvxThBxbNlpvVjKi
         szuzHPGh6jvyY9/nf8GbtubBTGm1ZoAlukxNqKMGmb821Qt/LIJ3BRup0f1ExwstVy0z
         TM3ld4OY1rlwWoAWPTi9PpcurKz2OGkOymPvcZiTD2aV7XZK2wi6lMqEf2fMKZbPjIZC
         v7+WxOsxdyXwi+1ZyIxX+wUOjhM9sPS6SILKswveJEA1e+JATyuot5FCLDXbHIz06pn3
         SB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vX49INcmmLrvTviB9rPwp8Mp4TIMamo+j6PYJ+aDTr0=;
        b=hGf2hK3hA1aHfTU5Sng6Tr5ZphiT/z69GPJz+E/q2Zm8kHyeU5tAwCKmx4zO9QZwaD
         e4fT5BAL04nZeaDZx7IXY8QFLYVNmvQtVZkS3b+G+Rh2IJoN++AxIWQIjI2dkf2hUsMj
         0FQuGB6zK72vicITZ3csEd/OK2oRqzVk1tMmAjXoSlN7GkSF8ARXiB7N28WT8+5R4w9x
         EtLIsZwm2tpqPinG5v/i4BwIsieZiitypwn7qnb1YxRnaByHrmJiJozQZ4x2XGUvmNSp
         yMpceItnDjyNjpC5Tz8RUdelVIyoMfYOwZ2+oWZg5p+7bdfV/nyOsUCrgEA7k9MD2Fg8
         85Tw==
X-Gm-Message-State: APjAAAURhAZ7AcL8/caTyRUM5/OOdCwoPxtkofft1j1GbSK5O3z//dEx
        VDgPZZchVMyqw+jCLlNoEn9kzPxHjL0Vf1s8ZxY=
X-Google-Smtp-Source: APXvYqwO5QLZb3KvPKQKIXBO5Nhru0xKtt+FhCtO0LtjZpiLGbTjCT9Wu59tasQ3jMJhzXCc5hFiEg1veiP8rzryJ2o=
X-Received: by 2002:adf:f851:: with SMTP id d17mr122836754wrq.77.1564428043534;
 Mon, 29 Jul 2019 12:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <c336ccf4-34f5-a844-888c-cd63d8dc5c4e@petaramesh.org> <0ce15d14-9f30-ac83-0964-8e695eca8cbd@gmx.com>
 <325a96b2-e6a4-91e3-3b07-1d20a5a031af@petaramesh.org> <49785aa8-fb71-8e0e-bd1d-1e3cda4c7036@gmx.com>
 <39d43f92-413c-2184-b8da-2c6073b5223f@petaramesh.org> <b7037726-14dd-a1a2-238f-b5d0d43e3c80@petaramesh.org>
 <71bc824e-1462-50ef-19b1-848c5eb0439d@gmx.com> <a08455f0-0ee0-7349-69b3-9cdd00bfe2aa@petaramesh.org>
 <fc26d1e5-ea31-b0c9-0647-63db89a37f53@gmx.com> <4aa57293-3f60-8ced-db14-ed38dff7644b@petaramesh.org>
 <43dc92e7-cd13-81db-bbe5-68affcdd317b@gmx.com> <a74e3ba6-7106-f2c5-383e-1f75621605a5@petaramesh.org>
 <c5fb61ef-05dc-2bd4-a0aa-d86358d7b82a@gmx.com> <5fd82812-22cf-253e-312a-1cfc33f4dfff@petaramesh.org>
 <e8a4ca58-0b5e-96ee-1fa5-552ad7e55785@petaramesh.org>
In-Reply-To: <e8a4ca58-0b5e-96ee-1fa5-552ad7e55785@petaramesh.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 29 Jul 2019 13:20:32 -0600
Message-ID: <CAJCQCtRgZht7Eh3L_kXfnvLH4WDNMvXXr=EK-9Bn-1tsRKRERg@mail.gmail.com>
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     =?UTF-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 29, 2019 at 9:05 AM Sw=C3=A2mi Petaramesh <swami@petaramesh.org=
> wrote:
>
> On 7/29/19 4:55 PM, Sw=C3=A2mi Petaramesh wrote:
> > Well  All the errors I detailed today happen on the SAME FS, and this f=
s
> > is a BTRFS that was created on a new HD with a recent kernel (surely >=
=3D
> > 4.19) only a few months ago.
> >
> > And the errors I have one this one, As far as I can tell, look exactly
> > like what happened on the same machines SSD as soons as I installer a
> > 5.2 kernel...
>
> Plus I just decided to =E2=80=9Cbtrfs check=E2=80=9D the SSD FS from my m=
achine (not yet
> showing errors), which I completely reformatted using 5.2 3 days ago
> (after having fully tested the SSD error-free itself)...
>
> And btrfs check tells me that this FS is now completely corrupt as well
> :-(((
>
> The list of files in error has been scrolling for five minutes now :-(((

Without both dmesg and btrfs check output it's not very useful. I've
got a case where a file system scrubs fine and btrfs check complains,
but turns out it's because of nocow files that are compressed via
defrag path. The files are fine, there is no corruption, it's just
noise. But the only way to know it is to always include the full dmesg
and check output - I personally think snippets and trimmed logs are
annoying. In this case we don't actually have anything to go on,
therefore the problem could be anything, therefore we need all the
information available.

It seems unlikely drive related, as so many drives are involved. Same
for logic board or RAM. I think these days with ext4 and XFS using
checksumming for metadata, that if it were device-mapper or blk-mq
related, they too would see errors. And yet of course many people are
using kernel 5.2 with Btrfs and aren't having problems. So, it's just
inherently tedious work to narrow down what's causing the problem.

I think it's totally reasonable to go back to 5.1 for a while and make
certain the problems aren't happening there. If they are, then I start
to wonder about noisy power since you have so many different drives
and setups affected. Some of the strangest problems I have ever seen
in computing were directly attributed to noise on the power line.




--=20
Chris Murphy

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEC5330AC4
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Mar 2021 11:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhCHKCa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Mar 2021 05:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhCHKCP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Mar 2021 05:02:15 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE77BC06174A
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Mar 2021 02:02:14 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 7so10791427wrz.0
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Mar 2021 02:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HAstQn014DtoPWA9PeEp+LJZ/sh/+qIa4zMBvLwAEvU=;
        b=Ro//alRLwy+qWCA7/JNvnL/zLvoDXuQui9arelOSegH8BvG5rMHEvaMUFC4Ymvwe6U
         cxeZ7iiS8M+xkhZXjPEmb18WQgF35RO6n6GsRm1TsPI17y3JPXbWEWgNe4Buj/omx9+b
         pX/COT8J2+tA0BvfRDfcND9I/l8YIRvukmzsSsmM8x7Zp9Ap1mEgHyXz5m3Gh3pnoChb
         hueO1WWZBlZp6eHeg7jHC9B2jWb8RUebPPr/p/jwiwgx7+0ui+iyM194cveZXLEvye60
         O2vcIDwkuZHkcwEfpNiG82C7ati6pljjcnj578W1+7MTj4yRePAkiaNNLs2D1eEpi/uy
         j6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HAstQn014DtoPWA9PeEp+LJZ/sh/+qIa4zMBvLwAEvU=;
        b=Bj7rFlTZ6o6aMKeoaZKutyjoJ/PxFTG0MJdTnDmZrZRKqlWzK5ROexi385jYCzQJlq
         HZgroHVmvq1wKT0qXNtJ9E0pYOgdM3BU+PYnFRQYvVD62CYk/L2rCvPN2iyUPQgv4QBm
         I9OqjBj8Ou4Z3+L1RzFYl8qzSO6cRBTkknRcoULuwvnHwzOy+ErfDGxnNepIt7bcplPh
         XvX8KYX4fOTwrYzwFrhADUwk2vFp1HP9IviEsYQxVUWxt0X1bNa44+a4TUf4KkfIrQxp
         vDub5bmWJkZMaOyy5+RHxk126rQzyeM+YQeUZ/he5bQFdIDMbMXFYaO3NwZlTd0SkW4s
         37Iw==
X-Gm-Message-State: AOAM5304odnrNPtXFpYZPnDlBeGa9VeDFUsE5TXVRuf6gF75w3BStfx2
        7GBw36bzRw4jTrn5kcsZsTPkYv3VIbNIlPYTP4gu5dl5hvA=
X-Google-Smtp-Source: ABdhPJwMSEapjJ/yL4kGJRcMxV7qWcqjXhBQsaiTqyzo76JnGt7djPCRTTo9oGoJtBU8Lx18cuLYQHUUiVUcTJH+FYM=
X-Received: by 2002:a05:6000:2cf:: with SMTP id o15mr21559282wry.184.1615197733398;
 Mon, 08 Mar 2021 02:02:13 -0800 (PST)
MIME-Version: 1.0
References: <CABBhR_6Y=H6Eujw51xkt6_fjAQFjdcp5trVgjtbrNf9iMDxZ0g@mail.gmail.com>
 <PH0PR04MB74168E7E65BDF004A6C06BB39B939@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CABBhR_6mO2e2Bu2TLGTCjY-xG3+Yu34visp9+uqdvKUvpVhG-g@mail.gmail.com>
 <100894a0-51c5-6ba9-7688-32203cb822c6@gmx.com> <6c73793c-e855-12c5-9214-7baddbc840c7@gmx.com>
In-Reply-To: <6c73793c-e855-12c5-9214-7baddbc840c7@gmx.com>
From:   chil L1n <devchill1n@gmail.com>
Date:   Mon, 8 Mar 2021 11:02:02 +0100
Message-ID: <CABBhR_7xkonR0AzhKqm4zeY6rKtr04hVn5u_2Nnr9XJ=-f1bOg@mail.gmail.com>
Subject: Re: btrfs error: write time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

Thanks for some explanation.
Personally, I prefer binary to compare bit-level changes.
Actually, I also miscounted. I count 3 bit flips. Isn't that extremely
unlikely, assuming that each bit flip is independent?
Nonetheless, I'm running another RAM test with memtester and 6GB RAM
blocks.... still no errors.
Will post an update later today.

--=20
Cheers,

Chillin

On Mon, Mar 8, 2021 at 10:33 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/3/8 =E4=B8=8B=E5=8D=885:23, Qu Wenruo wrote:
> >
> >
> > On 2021/3/8 =E4=B8=8B=E5=8D=884:56, chil L1n wrote:
> >> Hi Johannes,
> >>
> >> Thanks for the advice. I'm running memtester now. This will take some
> >> time as the machine has 32GB RAM.
> >> Regarding your explanation, I count two bit position differences, not
> >> 1. Can you explain your reasoning?
> >
> > It looks like Johannes missed one 0, and caused some confusion.
> >
> > With 0 padded correctly, the result is:
> >
> > 3276800 =3D 0b1100100000000000000000
> > 1310720 =3D 0b0101000000000000000000
>
> Oh, no, the value is correct.... It's my hex diff incorrect...
> >
> > That's why I prefer to use hex:
> > 3276800 =3D 0x320000
> > 1310720 =3D 0x140000
> > diff    =3D 0x200000
>
> The diff is 0x260000 (xor).
>
> But that can still be an indication of bitflip, on that 0x200000 part.
>
> As the current key should be larger than previous key, one bit flip at
> 0x200000 can cause the problem and trigger the tree-checker.
>
> Thanks,
> Qu
> >
> > Definitely one bit flipped.
> >
> > Thanks,
> > Qu
> >
> >>
> >> Thanks,
> >>
> >> chill
> >>
> >>
> >> On Mon, Mar 8, 2021 at 9:41 AM Johannes Thumshirn
> >> <Johannes.Thumshirn@wdc.com> wrote:
> >>>
> >>> On 06/03/2021 10:11, chil L1n wrote:
> >>>> [2555511.868642] BTRFS critical (device sda4): corrupt leaf: root=3D=
258
> >>>> block=3D250975895552 slot=3D78, bad key order, prev (256703 108 3276=
800)
> >>>> current (256703 108 1310720)
> >>>> [2555511.868650] BTRFS error (device sda4): block=3D250975895552 wri=
te
> >>>> time tree block corruption detected
> >>>
> >>> This /might/ be a memory bitflip:
> >>>
> >>> 3276800 =3D 0b1100100000000000000000
> >>> 1310720 =3D 0b101000000000000000000
> >>>
> >>> I guess the highest bit did flip so it should have been:
> >>> 3407872 =3D 0b1101000000000000000000
> >>>
> >>> (3407872 - 3276800) / 4096.0
> >>> 32.0
> >>>
> >>> Can you run a memtest on the machine to check if the RAM is ok?
> >>>
> >>> Byte,
> >>>          Johannes

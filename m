Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F2F401D39
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 16:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243510AbhIFOnY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 10:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238717AbhIFOnX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Sep 2021 10:43:23 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A4FC061575
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Sep 2021 07:42:19 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id a15so8983155iot.2
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Sep 2021 07:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wyrick.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kYshG7jiCIvPt3o5rXfAcXLAzIaejvXHcwE+7+CJlko=;
        b=Z/ccUs3OREsdsBQbcouxqVauyy7+Lal2/J0zkwX2lCwQ1jejqgl2p3ATJvPyImr3/F
         0nohC/cbouKtRFp7Ta5QFIdytQhIv3/32oaaz1IOCyX09nnJxBSQdxFxc98bV2uVllVn
         1/xKT/9RkQWeVgHOhrESRs43HcnRKuDjPXZNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kYshG7jiCIvPt3o5rXfAcXLAzIaejvXHcwE+7+CJlko=;
        b=Pbdv36SQOO7Eovp1eI8+590VVffrwSDvdDX0qt9dEeIrn+OpWoaokS6IWXxISBNHvY
         zhhttI9OPYOP+1oKyc48rsD4XRksGliSrlFGRaB5snXrg8Pxwp6JQp/cBO827ywv8gvf
         mlRgONzkSrno4cchNii26DeUZI2IhHVswl7QY0cksZpTUT7ljIEIPpp4Yc5ugWJfZNY8
         WHkohdPqwwNUfrtP7FxM4lHecvFBKXMf3MUJ/+njvai2t/Sxf2u1TfeyaAgjAbK0TqEo
         6kQu6bx++jTPqNfwLECg0iKek9hQOmH+C+JuCg0ZldvHGsa8jeNcWGrkSHiPTzvMgKvf
         BGGg==
X-Gm-Message-State: AOAM530XYvwyqXaMn0DUTA4+SvzaTt6DJY26PSEdhxOceMmXGBtu8Mdn
        n7hgckzPboaBLFsIXGbzMasm6SIGPSHPHw==
X-Google-Smtp-Source: ABdhPJyOrIvRbFrncaIvCeUfOqvgUhqwdLtH5FG9ZNyaNx9no3Ko7/QwWk3LHa9EUBbHS2U8tv9XlA==
X-Received: by 2002:a6b:6a14:: with SMTP id x20mr9644729iog.177.1630939338310;
        Mon, 06 Sep 2021 07:42:18 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id v3sm4566165ilg.54.2021.09.06.07.42.17
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 07:42:18 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id n24so8967337ion.10
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Sep 2021 07:42:17 -0700 (PDT)
X-Received: by 2002:a05:6638:399:: with SMTP id y25mr10934601jap.23.1630939337685;
 Mon, 06 Sep 2021 07:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAA_aC9-ZAdGC15HY-Q0S-N2M1OukST5BjAk9=WsD+NArCkCFUA@mail.gmail.com>
 <3139b2df-438c-ba40-2565-1f760e6d1edb@gmx.com> <9c2afb5f-e854-d743-3849-727f527e877b@gmx.com>
 <CAA_aC99-C8xOf7EAvJAMk2ZkYSaN2vyK7YFMw06utQ0T+tsh9A@mail.gmail.com> <6e03129e-f8c8-a00b-2afe-97a82d06c11e@gmx.com>
In-Reply-To: <6e03129e-f8c8-a00b-2afe-97a82d06c11e@gmx.com>
From:   Robert Wyrick <rob@wyrick.org>
Date:   Mon, 6 Sep 2021 08:42:06 -0600
X-Gmail-Original-Message-ID: <CAA_aC98OWWQHT8vGMQcDMHmsCEVZ+Aw30SdMeqrAa=y1qrV72w@mail.gmail.com>
Message-ID: <CAA_aC98OWWQHT8vGMQcDMHmsCEVZ+Aw30SdMeqrAa=y1qrV72w@mail.gmail.com>
Subject: Re: Next steps in recovery?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

42+ hours of memtest86+, no errors detected.  4 passes complete.
Is that good enough?

On Sun, Sep 5, 2021 at 4:03 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/9/6 =E4=B8=8A=E5=8D=8812:00, Robert Wyrick wrote:
> > Running memtest86+ now....  20 hours in.  No errors yet.
> > Thanks for the analysis.  I'll let this run for another day or so.
>
> Just to mention, since 5.11 btrfs kernel module has the ability to
> detect most high bitflip before writing tree blocks to disks.
>
> Thus even with less reliable RAM, it's still more reliable than nothing.
>
> But still, with the existing errors, the RAM test is still an essential
> one before doing anything.
>
> Thanks,
> Qu
> >
> >
> > On Fri, Sep 3, 2021 at 12:53 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
> >>
> >>
> >>
> >> On 2021/9/3 =E4=B8=8B=E5=8D=882:48, Qu Wenruo wrote:
> >>>
> >>>
> >>> On 2021/9/3 =E4=B8=8A=E5=8D=8810:43, Robert Wyrick wrote:
> >>>> I cannot mount my btrfs filesystem.
> >>>> $ uname -a
> >>>> Linux bigbox 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed Aug 11
> >>>> 15:58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> >>>> $ btrfs version
> >>>> btrfs-progs v5.4.1
> >>>
> >>> The tool is a little too old, thus if you're going to repair, you'd
> >>> better to update the progs.
> >>>>
> >>>> I'm seeing the following from check:
> >>>> $ btrfs check -p /dev/sda
> >>>> Opening filesystem to check...
> >>>> Checking filesystem on /dev/sda
> >>>> UUID: 75f1f45c-552e-4ae2-a56f-46e44b6647cf
> >>>> [1/7] checking root items                      (0:00:59 elapsed,
> >>>> 2649102 items checked)
> >>>> ERROR: invalid generation for extent 38179182174208, have
> >>>> 140737491486755 expect (0, 4057084]
> >>>
> >>> This is a repairable problem.
> >>>
> >>> We have test case for exactly the same case in tests/fsck-test/044 fo=
r it.
> >>
> >> Oh, this invalid extent generation is already a more direct indication
> >> of memory bitflip.
> >>
> >> 140737491486755 =3D 0x8000002fc823
> >>
> >> Without the high 0x8 bit, the remaining part is completely valid
> >> generation, 0x2fc823, which is inside the expectation.
> >>
> >> So, a memtest is a must before doing any repair.
> >> You won't want another bitflip to ruin your perfectly repairable fs.
> >>
> >> Thanks,
> >> Qu
> >>>
> >>>
> >>>> [2/7] checking extents                         (0:02:17 elapsed,
> >>>> 1116143 items checked)
> >>>> ERROR: errors found in extent allocation tree or chunk allocation
> >>>> cache and super generation don't match, space cache will be invalida=
ted
> >>>> [3/7] checking free space cache                (0:00:00 elapsed)
> >>>> [4/7] chunresolved ref dir 8348950 index 3 namelen 7 name posters
> >>>> filetype 2 errors 2, no dir index
> >>>
> >>> No dir index can also be repaired.
> >>>
> >>> The dir index will be added back.
> >>>
> >>>> unresolved ref dir 8348950 index 3 namelen 7 name poSters filetype 2
> >>>> errors 5, no dir item, no inode ref
> >>>
> >>> No dir item nor inode ref can also be repaired, but with dir item and
> >>> inode ref removed.
> >>>
> >>> But the problem here looks very strange.
> >>>
> >>> It's the same dir and the same index, but different name.
> >>> posters vs poSters.
> >>>
> >>> 'S' is 0x53 and 's' is 0x73, I'm wondering if your system had a bad
> >>> memory which caused a bitflip and the problem.
> >>>
> >>> Thus I prefer to do a full memtest before running btrfs check --repai=
r.
> >>>
> >>> Thanks,
> >>> Qu
> >>>
> >>>> [4/7] checking fs roots                        (0:00:42 elapsed,
> >>>> 108894 items checked)
> >>>> ERROR: errors found in fs roots
> >>>> found 15729059057664 bytes used, error(s) found
> >>>> total csum bytes: 15313288548
> >>>> total tree bytes: 18286739456
> >>>> total fs tree bytes: 1791819776
> >>>> total extent tree bytes: 229130240
> >>>> btree space waste bytes: 1018844959
> >>>> file data blocks allocated: 51587230502912
> >>>>    referenced 15627926712320
> >>>>
> >>>> I've tried everything I've found on the internet, but haven't
> >>>> attempted to repair based on the warnings...
> >>>>
> >>>> What more info do you need to help me diagnose/fix this?
> >>>>
> >>>> Thanks!
> >>>> -Rob
> >>>>

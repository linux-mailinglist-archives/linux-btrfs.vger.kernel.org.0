Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6909B35F49D
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Apr 2021 15:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351155AbhDNNNt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Apr 2021 09:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244296AbhDNNNs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:13:48 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E87C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Apr 2021 06:13:26 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id i11so4297764qvu.10
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Apr 2021 06:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=piLLGk+QI/Cn78X+HQNfdiFBuegNyVYAoLnv276hPws=;
        b=qDuBvU8Er9a5iME9agAwFGQBN9fAOnO8Xd7Bb+maMKBa8+l0Gn96eDF4/ldPZ6eKGH
         a1zJm9j73mkbS/9IB4mMqYk3vWqeIeRBjsX2IgMsB0RHi1OT10gliYjSb5HsDrJtkBD9
         FSnd8AxaDoT37CWoHc3Pmib7TSh4NyG6AaCkUW36KWrvQgwFOe36yAGRdydlsUBHUOE8
         FizOJKJe63WqNAt13kC8gJ1/LbkTYwWn6LyyQMVlftG3e++G3hpQPhRILvlxtMNfv9s4
         tXcOhcWDKN/JfK596t1qNqOmiTagCH6hg33Kjx6ZVzl6JeVGdFrsVHWN7FY/63bNLOTs
         LAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=piLLGk+QI/Cn78X+HQNfdiFBuegNyVYAoLnv276hPws=;
        b=jjSf+r/+BZP1n5eIgZvB4YBNJGpMfSKuGgB2sLLADjaXtl9vql6girrNKTQMO1MLeT
         59vQxrCP540U06xsf9iiKkdZdTtg+pQfbzcCTsrjUOD+UOr0ht1TaKbRDF5ruW1c7Rc0
         8RkSsQH4u56eGlg8aYgBiLJliu0KxVeLXmF6Jx63xViifM0QRWSvne1M18izF/JpNxmW
         iOYtozXCiVdtMBa9ldfCGGPt5wOUROi9eD4mX34A+pSnlobCLEOHRSvJA+Ek1kWroXGm
         xgAqY71Hh8eRWlPEV5hcSrRWhAvLZURZET6MdwOcD8dds1LpclRx+CoTh2sn9XcOAIFS
         VDlg==
X-Gm-Message-State: AOAM531/265G2j2v+NYd2mqWLACF/nnhSXavxqCqjoq3EgRytzaD/jcx
        wSCWPMyFj+O+ErxCLOeSjktbaZ2H4OcPXFNnc3c=
X-Google-Smtp-Source: ABdhPJxGtbRm9BnHYysNqVscfIA/xuil347xgLDNl8R9IrAQd/+tf0naBbbUhKut4C5KF6lqBaGrYTRufVkF5pw6zrE=
X-Received: by 2002:ad4:5767:: with SMTP id r7mr37340948qvx.27.1618406006093;
 Wed, 14 Apr 2021 06:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617962110.git.johannes.thumshirn@wdc.com>
 <459e2932c48e12e883dcfd3dda828d9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com>
 <CAL3q7H4SjS_d5rBepfTMhU8Th3bJzdmyYd0g4Z60yUgC_rC_ZA@mail.gmail.com>
 <PH0PR04MB741605A3689AA581ABC6CF3E9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H55vudYBNFGHWWuWCaeMLuVm8HjbBsmTYD7KQP_dKEKOQ@mail.gmail.com>
 <PH0PR04MB7416DD1B232F797944ADD6EC9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB7416807F6FA29B03EF6A4A7A9B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H5xZLhHrBPJb5jwe8ZxAv=XfFC05kcw5-WqBySQP4uTBg@mail.gmail.com>
 <PH0PR04MB74167FB19522DBEB1F70E80D9B4F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H6Bgqkdf8Z+xRBH8C=XxtrGzXyNUf6BHaLw54LZb3Agsg@mail.gmail.com>
 <PH0PR04MB7416EE187963A0D7718D57979B4E9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB7416BE8A6029E3E6FAF8664E9B4E9@PH0PR04MB7416.namprd04.prod.outlook.com>
In-Reply-To: <PH0PR04MB7416BE8A6029E3E6FAF8664E9B4E9@PH0PR04MB7416.namprd04.prod.outlook.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 14 Apr 2021 14:13:15 +0100
Message-ID: <CAL3q7H7y2msez3J09S2L1dGmAoXmXfRgpqJNULMCCxxMjt7DHw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] btrfs: discard relocated block groups
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 14, 2021 at 2:00 PM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 14/04/2021 13:23, Johannes Thumshirn wrote:
> > From how I understand the code, yes. It's a quick test, so let's just d=
o it
> > and see what breaks.
> >
> > I'd prefer to just drop the ->ro check, it's less special casing for zo=
ned
> > btrfs that we have to keep in mind when changing things.
>
> OK, no this doesn't work, because btrfs_start_trans_remove_block_group() =
has
> this ASSERT(em && em->start =3D=3D chunk_offset);, but btrfs_remove_block=
_group()
> from relocation has already called remove_extent_mapping().

Ah bummer.
Well your previous proposal is reasonable.

Thanks for checking it.

>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

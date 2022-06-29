Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD21560083
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 14:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiF2Mxj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 08:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiF2Mxi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 08:53:38 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198F126560
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 05:53:38 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id z1so7280143qvp.9
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 05:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/4bff15D+nY/gHRlKW2uLNIt4hIWR6BwmCkO+OKY2JY=;
        b=bjxYUzrN+ACXmAzWcgEKqpuWfySTW6JwiMhM9Tf622JeZxWQusqKkjNkjacADEGnt4
         aM3LAyGKsi3S5AVB9AqHgzd1X/ad2ih2ksBATvBDhezpvMNX7tkRI8h6H2YJgU1Km6lq
         kcW25hDLpvhTfCeXPxoZbbDB2jPWWpigcIKV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/4bff15D+nY/gHRlKW2uLNIt4hIWR6BwmCkO+OKY2JY=;
        b=ewrpAqjsRFJHGYvM5t8HgJpqSblm9s26g2a3fKcCWOpb7/9eLE3onSYiKYunBokW2i
         1BlLIMiHK+AclykNt4xZ15TEJHLSjpyiw9FqsjWQz842JH94aUalfU7Z4dz1WxXw5gkR
         y96KEbFVX2YeoXr9JWtxQnr75wEb85lRu93TVMmPxiAdRFBlTGdRirP6yLp1oY93gIvd
         VKMLNmha7OFVbZy8BHj99hAXC84GkGKJ3iqRoT70lze4DM6On+y3i6l3Siwx3Zpo029R
         IxwPgTi7CTo5kjeIQLa/0ae3nJn3qfrqpv4eFqOL5gco7jxMDslp2j3+ZX8DCvKq9ryJ
         /xnA==
X-Gm-Message-State: AJIora86TlrXX+HKi/yOlpGvIZRp/bkyi4pa6VVAgidtpiC6Uig72TeQ
        AVlfnZ1sN/zAEdSohuhT9DyPfA==
X-Google-Smtp-Source: AGRyM1v4wuMFHQhhOaVqEyWZEijAcwxUejvBWDUdHQeQBzSWPvdSO7BWNBpROZNlam4ucAkAL5fufw==
X-Received: by 2002:a05:622a:354:b0:317:7a1d:ce4e with SMTP id r20-20020a05622a035400b003177a1dce4emr2244347qtw.419.1656507217043;
        Wed, 29 Jun 2022 05:53:37 -0700 (PDT)
Received: from bill-the-cat (cpe-65-184-195-139.ec.res.rr.com. [65.184.195.139])
        by smtp.gmail.com with ESMTPSA id 196-20020a3704cd000000b006a6ae9150fesm12637186qke.41.2022.06.29.05.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 05:53:36 -0700 (PDT)
Date:   Wed, 29 Jun 2022 08:53:34 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, u-boot@lists.denx.de, marek.behun@nic.cz,
        linux-btrfs@vger.kernel.org, jnhuang95@gmail.com,
        linux-erofs@lists.ozlabs.org, joaomarcos.costa@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH 0/8] u-boot: fs: add generic unaligned read handling
Message-ID: <20220629125334.GC1146598@bill-the-cat>
References: <cover.1656401086.git.wqu@suse.com>
 <20220628141708.GJ1146598@bill-the-cat>
 <8728cb97-6bb6-fae9-025b-42bd1a439386@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hCRFYJKfs6IGypzU"
Content-Disposition: inline
In-Reply-To: <8728cb97-6bb6-fae9-025b-42bd1a439386@gmx.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--hCRFYJKfs6IGypzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 29, 2022 at 09:40:58AM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2022/6/28 22:17, Tom Rini wrote:
> > On Tue, Jun 28, 2022 at 03:28:00PM +0800, Qu Wenruo wrote:
> > > [BACKGROUND]
> > > Unlike FUSE/Kernel which always pass aligned read range, U-boot fs co=
de
> > > just pass the request range to underlying fses.
> > >=20
> > > Under most case, this works fine, as U-boot only really needs to read
> > > the whole file (aka, 0 for both offset and len, len will be later
> > > determined using file size).
> > >=20
> > > But if some advanced user/script wants to extract kernel/initramfs fr=
om
> > > combined image, we may need to do unaligned read in that case.
> > >=20
> > > [ADVANTAGE]
> > > This patchset will handle unaligned read range in _fs_read():
> > >=20
> > > - Get blocksize of the underlying fs
> > >=20
> > > - Read the leading block contianing the unaligned range
> > >    The full block will be stored in a local buffer, then only copy
> > >    the bytes in the unaligned range into the destination buffer.
> > >=20
> > >    If the first block covers the whole range, we just call it aday.
> > >=20
> > > - Read the aligned range if there is any
> > >=20
> > > - Read the tailing block containing the unaligned range
> > >    And copy the covered range into the destination.
> > >=20
> > > [DISADVANTAGE]
> > > There are mainly two problems:
> > >=20
> > > - Extra memory allocation for every _fs_read() call
> > >    For the leading and tailing block.
> > >=20
> > > - Extra path resolving
> > >    All those supported fs will have to do extra path resolving up to 2
> > >    times (one for the leading block, one for the tailing block).
> > >    This may slow down the read.
> >=20
> > This conceptually seems like a good thing.  Can you please post some
> > before/after times of reading large images from the supported
> > filesystems?
> >=20
>=20
> One thing to mention is, this change doesn't really bother large file rea=
d.
>=20
> As the patchset is splitting a large read into 3 parts:
>=20
> 1) Leading block
> 2) Aligned blocks, aka the main part of a large file
> 3) Tailing block
>=20
> Most time should still be spent on part 2), not much different than the
> old code. Part 1) and Part 3) are at most 2 blocks (aka, 2 * 4KiB for
> most modern large enough fses).
>=20
> So I doubt it would make any difference for large file read.
>=20
>=20
> Furthermore, as pointed out by Huang Jianan, currently the patchset can
> not handle read on soft link correctly, thus I'd update the series to do
> the split into even less parts:
>=20
> 1) Leading block
>    For the unaligned initial block
>=20
> 2) Aligned blocks until the end
>    The tailing block should still starts at a block aligned position,
>    thus most filesystems is already handling them correctly.
>    (Just a min(end, blockend) is enough for most cases already).
>=20
> Anyway, I'll try to craft some benchmarking for file reads using sandbox.
> But please don't expect much (or any) difference in that case.

The rework sounds good.  And doing it without any real impact to
performance either way is good.

--=20
Tom

--hCRFYJKfs6IGypzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmK8S00ACgkQFHw5/5Y0
tyyL7gv/RsMcVnrx02hMQxtQG4UuktxMz9gftbRFDC6xJrV5olnwzqgRXOxT1I3c
Yeabw66LR0XBog1E5UDnGIw/aDwahB5Zv74EHl912Y42PHSRSvV1ILacCih+tyW7
YgzHCnikt6Dp0D6yd9KK+RUxGfCGrD2izWjrpBhKJJkSOAXVMwdTxZyDkf67/Pjq
CCQ4Lc35o45BwBB9bZ1NIQl6FQQ/pXxHADu5Ttnk2ZaHycF07UYsCddvkqD2+kjC
Ta+LLKXGT10FwFEGJwAInRk8oY9xre0wuTbDtMUzGRJry7If65si9KRTWoiQ5Ffq
3zwKTQqr6rL0hvVRDvGdWbTGICd86eANHdkJhRl1ZO5XrsouyZGgH6KB1XPgHk0O
hwANXxtXOnI2sYLN7vCe2zfkOlr+iz5Bx+a7Up/hbrXlhA8YRNba+i1036edcHmg
hhpzbSu4nCJRJVuKakQpg5LSUx5PvCfr7RVp6FHVXf8bdtj1AkrQZnp73DrzJOmK
PrVMFS+t
=W9My
-----END PGP SIGNATURE-----

--hCRFYJKfs6IGypzU--

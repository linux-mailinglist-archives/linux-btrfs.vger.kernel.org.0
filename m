Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D117534AFC2
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 21:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCZUEH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 16:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhCZUEA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 16:04:00 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F15C0613AA;
        Fri, 26 Mar 2021 13:04:00 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id o5so6546296qkb.0;
        Fri, 26 Mar 2021 13:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=YtjDErUVkDl+bV3TbtSZEkUyABM9izmWrCvJOp/BLCY=;
        b=B4uI4dgAG4uTFxs8tejlf5xv9EY33Hix90ae5C11SwKMpw7Z8x0L4XIMJYQNvwGgQi
         jRWD8POuCeWwSp342IBMzMOOMJlFU7NyFFJrOXWxNyPPR+DZqi7nNLUnRIoI14VqQ2qd
         sw29BLajVRrk7qidLnbM3NNCmnUxXtMS+9mhv+t/1T411ZRxtcB5QYI6hxr6kWaMA4tj
         jPBv2R23mRiA3740fLLCB6UJZwI0KBt1ODMYreas2kq39L6DXCdadSfW2bRWevQq+3m5
         bksOKnREAAMwMuxkci963ucpMA2FzT6kYY88OKLaucpbhioDBEmTQ5mikVx97vHR/glQ
         fdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=YtjDErUVkDl+bV3TbtSZEkUyABM9izmWrCvJOp/BLCY=;
        b=cpZ9m3y+KbNiBXzE/kQnYTX8OAbRidLQohEJG3X9Aj4Ehsvw3lQrN7FpC3GquomoRH
         RytZvZ/QLPFNUY3uZsjNER/JVncOAKXLuhwUyVaQIjO+IeytLNQfOm1qCXvwQa6YqyOI
         H+Kg2Xjl/TsIdmxj20bgRz33Ly3UWyPhMdbgJ7pDx+OjCDuGmPgHlXZldvjXMY8gbqCV
         5nL+/sduYZBeel8prMenY83yxeyHdkd63k8x43aBasb3CXeyQYBI7E5Rg62vKypr4XCF
         jUicGVtEfmrpwst4Q0b2FjYnMl9XZRhEAwxHcgIioFAg3QF9PN0/uwgD0vK3coPpZ37K
         SgcQ==
X-Gm-Message-State: AOAM5318Pu/ACRSgdIv6xSYOAe38l5EU9ADY7SgWgySXdABXL3fqbOQO
        Zuy3hO1ssM8tqEpO/7VkajI=
X-Google-Smtp-Source: ABdhPJwoL029RnHLd9K5b8v546luBiVUqoZQP8dymvdcPS/2l0spEEefsVjsrU5ehsP54s7MbSWWSA==
X-Received: by 2002:a37:7b41:: with SMTP id w62mr14618737qkc.256.1616789039541;
        Fri, 26 Mar 2021 13:03:59 -0700 (PDT)
Received: from Gentoo ([156.146.58.30])
        by smtp.gmail.com with ESMTPSA id x7sm567804qtp.10.2021.03.26.13.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 13:03:58 -0700 (PDT)
Date:   Sat, 27 Mar 2021 01:33:48 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] btrfs: Fix a typo
Message-ID: <YF4+JMxVIEzR+wZd@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210326005932.8238-1-unixbhaskar@gmail.com>
 <20210326134732.GN7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xLctaF9xbflfJ32r"
Content-Disposition: inline
In-Reply-To: <20210326134732.GN7604@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--xLctaF9xbflfJ32r
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 14:47 Fri 26 Mar 2021, David Sterba wrote:
>On Fri, Mar 26, 2021 at 06:29:32AM +0530, Bhaskar Chowdhury wrote:
>>
>> s/reponsible/responsible/
>
>So this is exactly what I don't want to see happen - one patch per typo.
>I tried to explain it in the previous patch, please either fix all typos
>under fs/btrfs or don't bother.

As I mentioned in my previous correspondence to , I have my way of doing thing
. The problem is , you are getting accustomed with some specific method and
you are thinking that is the "only way" of doing the "right thing" . Please ,
think others are also think in different way too.

The goal to make it looks good and productive...don't you think so???

..and I said I do bother ,it's just not about this specific segment but about
the whole kernel.

Or is it some sort of special flow brtfs subsystem are following , which I am
not aware off??

Please do let me.

--xLctaF9xbflfJ32r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBePiEACgkQsjqdtxFL
KRVdVAf/ad+EA/8ylvI3jm+Z36L0iJOfuBfl3ODx2DaSqb3hSqwV8jVvbp14jefr
/VwJ8yl9ggMEJRq/xHqcnz0CMTRzHUeZQK5SpYYA+B5UeWkEV98I/GthJxC4V4vZ
U8DVlErh6DAqOqoIaL8YysGAOL+AEYq0NrC5MSAuCFXvYJbNWS2Up1wv6e3vgCXo
BQhV4FtvhxGlaptqoCFZzh1t8EbNkC24w2LXJLif3sDxloOlYfSzv8avhHFgEgCo
ajE1S0c/jSRWIwamwY6QwcUGnFXCvy2MrjAVSIrOi81zXOTtoudidRslRDSMcwwX
FXRmhsAE0k1yfNqd/bRg0RmLS6lveA==
=q5x3
-----END PGP SIGNATURE-----

--xLctaF9xbflfJ32r--

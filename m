Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6549134993A
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 19:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhCYSKX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 14:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhCYSKO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 14:10:14 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B5FC06174A;
        Thu, 25 Mar 2021 11:10:14 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id f12so2366426qtq.4;
        Thu, 25 Mar 2021 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=/6SWvIJu+0uLxhQqVku0aZlP13gE85T161W5/S7zZ7U=;
        b=fXa3Dy1Ery2SLZz+aGbHmSnq+wXdFEDuawOLcXHD6efegEPSIUnEF5LBvnOnOqbYU3
         YT4SoaV0uCjXaBM04q9EFYCOgjQokicFbMJV2NqmJ0UpTpWxlBXIrPUeTcLhS3relvbl
         F9ADXW70koGGiupsK995b1OJZI72lj7RHGgfkBEZCP7zHmHIjE0KwIkIA+As0dTDo6tk
         lb2QEwcGuWO5oKyva2iqz/IQeGvm2SNo5XEK48AuESU/7tKIrLKfxsgYI1n8eflRVvWW
         z6+5oBSkVFzZaFd5IfbT0kS/1iNbJJ/5MYxtVF73oo0bU1NumZJdpSSjv3MFep5vfCCs
         rwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=/6SWvIJu+0uLxhQqVku0aZlP13gE85T161W5/S7zZ7U=;
        b=m/gtIWCU4S+3KOxRbTq7gbezlGpu0W6vlfHpLoKBkZRoMKQTTdYUQNI5zROmh3/WZI
         gGTrWm5TZJ0Lv/Uv999eeeuLckiQfhPqlTuqS+nsjAmknHMqzZqn7xp/rPx5M9U//mam
         L5sXfdnkYudEjZy1HAGzJGgtqw9O2HI7GoHQRYT+bJLdQlBaOnHhSqX5BWS5smZ9rgnF
         bXYhUehdTNl4O3n1itLAA2xD1JKy9jgsT4zYfhNn1Ls9LJ13yEHxMZDz2CM4AWq6w98d
         Qbr2uNJtuQ9r3i5a5v1pZa879luVR16pExBn0f6s7khY7Y9M0MMK/1yRN2A7XpDpM3g9
         mxnQ==
X-Gm-Message-State: AOAM531CpcNgG0Grq37IDbDIhvp1EUhHA5Ez2j9IjbLXKD2YKt5XTq23
        9sekDMn+tpXH7MqQ1vaot7A=
X-Google-Smtp-Source: ABdhPJz4jg+ctpyXdH+xOLhwOl+Pjcqbwac86+pw8U0uKrsUWYD9wozE/xa+D+faWjI2bb0FT7Wbsg==
X-Received: by 2002:a05:622a:188:: with SMTP id s8mr8843491qtw.42.1616695813366;
        Thu, 25 Mar 2021 11:10:13 -0700 (PDT)
Received: from Gentoo ([37.19.198.30])
        by smtp.gmail.com with ESMTPSA id k4sm4765687qke.13.2021.03.25.11.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 11:10:12 -0700 (PDT)
Date:   Thu, 25 Mar 2021 23:40:04 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] btrfs: fixed rudimentary typos
Message-ID: <YFzR/E+GFlrYyxdm@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
References: <20210325042113.12484-1-unixbhaskar@gmail.com>
 <20210325124954.GL7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4+ei7imosTzY1wM8"
Content-Disposition: inline
In-Reply-To: <20210325124954.GL7604@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--4+ei7imosTzY1wM8
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 13:49 Thu 25 Mar 2021, David Sterba wrote:
>On Thu, Mar 25, 2021 at 09:51:13AM +0530, Bhaskar Chowdhury wrote:
>>
>> s/contaning/containing
>> s/clearning/clearing/
>
>Have hou scanned the whole subdirectory for typos? We do typo fixing
>about once a year in one big patch and won't fix them one by one.

Once a year???? You must be kidding! that is not good whatever the workflow
you have .

--4+ei7imosTzY1wM8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBc0fgACgkQsjqdtxFL
KRXn/AgAwju/uI4Zo31VoTAAVODhOvg/3dFAo5dLEpbUaavRJqzBxoj0QRPbhR5A
zGnvBua6LzAX2te0YpAiH9NHcZoJGb3eZcWh1VVvXjKn/9OxjBzmYYYBrh3rxrql
iBCrsgZVzZdtfTndJPVPmO0fJ/C5QjbBSsXA3aVTYMuNs9c2eBAsIhWbDpShDB3a
zKeXG50ElXcmLBPytmrbHlDk87TcniA41Qet4I+yMLUo9PW9TyQBCnbJUcnvB4lQ
lnj8EEw8foILtV3CwOszAnAFCaiRsNQfJkpJoNntSwzc+j2PnL1n8jojubAH8MEx
hY1MPkYBhdr0apG2JT9jQjT+mMmfcQ==
=8Thx
-----END PGP SIGNATURE-----

--4+ei7imosTzY1wM8--

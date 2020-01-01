Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 557AD12DFC4
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2020 18:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgAARke (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jan 2020 12:40:34 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:36780 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgAARkd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jan 2020 12:40:33 -0500
Received: by mail-ed1-f54.google.com with SMTP id j17so37400408edp.3
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jan 2020 09:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=um1oywd9lANypIHSVXVjO6j7qwEjdehhd0Re1FmDLzU=;
        b=HcUXpS2WsNmowMLMxSOfJTuF+9K1s0ZHDTmji5i6EUVBQVBh9ETBJNH3ZZiUtKyT/0
         IY6gRppc3pxHNpfXUeRfF7ak+WcmYHnLwb2BTQ4RILpatJOFWPLlgQUTv5cnTORCV4TF
         Vsv+KgJ3iSZdCkABVrcL6uanvHLBbozMJfKaXbp64lmYX/ep8jpiJxfygscKVsKTFa9v
         an6I2OIZUAZiRvPZiyDt0j1wf+ecfDI0JJ0To97x3PKVK98u/Tpv7hCSge+HmZO+Y5Wg
         Cz3QToTxuKQn0Z+D82nyeazNcyNKqzGM2Kc2hdvFjnZnJiImN50Te5s6fFPGg3rKvO9V
         cWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=um1oywd9lANypIHSVXVjO6j7qwEjdehhd0Re1FmDLzU=;
        b=g7iOE2ZpEju4GVdeV264XF9sN+QvcLmCgJmPpEIrxzBYbGAzi8VTsvbz6gXETuXBFr
         fSrviFgTAlluSXb4bjzzjQS8FBB0PP1AsxyGPyTI2falXAFaZNGthUI6cXQGlz2qnyMt
         uW9oM2XYEvJpdBjt3FgWmWdFU+g6qo8nXXnq+tEwzS0kEP+HBPfRbu2eaWV27LDa3AUC
         K8PQiZQ3wtvORYAmMvi1jZnMLksgGyk5HYFASYoIHqS25CGD5TDI+t3CG1f4h/q0JK6d
         Fx2UDA7Si7GE4oIZJVOmVC10fqEsLo9ccUmMxacslTiQaT3CP60AJgMeeWIc+3BiIx21
         EgaQ==
X-Gm-Message-State: APjAAAXvH5ape00CEt8ztPOUg5MNKewizTqcPz8neUU2Zd+JcfOtGSTP
        ahaD2UWOTWl/mN4cHKngvbo54XNH
X-Google-Smtp-Source: APXvYqwMiNTAuyGAMpqahwu69MjOQNXCuDEibG+79Jf05XULEU98Pe7ZICamHVNYzvL5TUBDchGrow==
X-Received: by 2002:aa7:da03:: with SMTP id r3mr83286640eds.163.1577900431196;
        Wed, 01 Jan 2020 09:40:31 -0800 (PST)
Received: from [192.168.14.56] (i577AF605.versanet.de. [87.122.246.5])
        by smtp.googlemail.com with ESMTPSA id m5sm6397532ede.10.2020.01.01.09.40.30
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jan 2020 09:40:30 -0800 (PST)
Subject: Re: repeated enospc errors during balance on a filesystem with spare
 room - pls advise
To:     linux-btrfs@vger.kernel.org
References: <495cfb98-7afd-a36d-151b-d7cc58f1d352@gmail.com>
 <7461874b-dc8d-4939-c4ae-fbab486750b3@gmail.com>
 <20191231225848.GI13306@hungrycats.org>
From:   Ole Langbehn <neurolabs.de@gmail.com>
Autocrypt: addr=neurolabs.de@gmail.com; prefer-encrypt=mutual; keydata=
 mQGiBELi5x8RBACTGJvigUyuTnZw57+evWAPnKkUPyc10mfIxxdb9LubuGdu/wY/GNv8JN5x
 LRgTW1a0e2832wwPqNxge5askrwRYqz9upMdZThHV3GwTdd8X+6SQONR9Sh6VPHskMd0lDuJ
 H7lyyjzd0dsO5B3jU2Or8wyFJIT24qJAERNSegjfQwCg2X0wqrydxGacWSG1gSZolOruC5sD
 /inO3AYHyrqnFcqp8XqVnG2TbMCt80/g+t4B8rfH8s1Tsqu/Ls/H6fj9uyz48+BbcjDcOVEg
 +BJCvZZYaBvd13ALItjw/hKyjdB5E1hbdPO2Y64RQtXl9lKaQsKwWGvfkO8BY1Q04F3gboGc
 RSX40rQQ3iXJKg3WtU2eG1TYAmYeA/49+eal3mVe1PWL+UDMKDaY1dgSSS7x2aPgSTU6QUQW
 A53s79otUUW4Xrpt4/oVUmXiXBpB49kFlQupO3lUzZ/QXf40cQonc+lAwS1dWlvvlnzQrLd1
 ieG1cg0dDNUp6/lzytUqDyBrnngzcVzqC3rQRrFF7QPCHoH5wZzZsWCuHrQ5T2xlIExhbmdi
 ZWhuIChzZWNvbmRhcnkgcHJpdmF0ZSkgPG5ldXJvbGFicy5kZUBnbWFpbC5jb20+iGIEExEC
 ACIFAkwwXnwCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEKMYFNw/P7oRzk4AoKQY
 GdPt6oPDixWzH0FC3b9nMl68AKCjxx843gMxpFj625sHcwRBZp8b1bkCDQRC4udyEAgAp++N
 0t2qtC3+rzQelEJ75CZXm3g++HsvYloq3/NwyBt3DtDQQ8hKzVBMu1EWv7SrL1JcJsCIKMhi
 WUz1sn7jRYzjGdS89b+fy49ckvDYmY+/h5A8kIwxJrnk2or3xVKpJe8WJhZFCo+wd46izR1x
 4x3mkN70DqOIR2hFS/61mWz0Vl5QgiFbeax7o6Ns+hX3U4doBFbayL9zLajlIGnoIP3g9iwR
 OZ64NG9iWuDpDfwspKzKMLTSEfBDPBW5liUFpuEAN9Q3/25kU+RtpguaDCFzo8RAfVxPsnWi
 QnAS2P8+1J2Cvef8mVZkAObWwPD+qC9kpxxuMdthM2KpbBccTwADBQf/X7Y8OqL+DuwWjZ61
 4tBx5gTT0qclHaoAoIgZbDHjxhV05Bo8R/buCq4xKqLLor2kN8YyOv6zm3N95zTYOVAaXCLc
 9q2H8EvkkHSL7t/iLFHeMVQZIBaQKzwR8eBTo3Tn3Us+/KIlp5XZwHviaDSf5LuGxvP539yM
 m5rYigml6YeRx7m8BeLzuew3icyRSzhJ+v/93W4ZOmYhOQxTbcHZ+sIA1ZG1zR0HDrQ9pNYP
 MJYFrVrMO7BNdxAkitUpJis4lNJskf8ZbtZAX1jSykEnw8FFJHG9nD3sbJPHDRPqbTUwlc3P
 twhIKd8BkbiGDmBDGMMLEiVKCmOvmcXztBCgI4hJBBgRAgAJBQJC4udyAhsMAAoJEKMYFNw/
 P7oRQcsAn2bNrSFKEo+BjRjsop2hLPdhWJJ/AKCmytKxEQy0s1iKiIbshDWFevjd2A==
Message-ID: <15a133b6-5569-2caa-e303-051f503acfe2@gmail.com>
Date:   Wed, 1 Jan 2020 18:40:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191231225848.GI13306@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="jqMJyVH9LOZjHEIz2tzH6Q7Zybmj69Kpo"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jqMJyVH9LOZjHEIz2tzH6Q7Zybmj69Kpo
Content-Type: multipart/mixed; boundary="IIInXOIokcqgr3Mz1dvbIKT5dLmKumpLD"

--IIInXOIokcqgr3Mz1dvbIKT5dLmKumpLD
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Thanks for the insights (also in other responses).

On 31.12.19 23:58, Zygo Blaxell wrote:
> Two workarounds:
>=20
> 	- use 5.3.18 instead of 5.4.6
>=20
> 	- use the 'metadata_ratio=3D1' mount option after balancing a few
> 	data block groups

Switched back to 5.3.18. Since the space bug (at least the external/df
part) was solved for me before switching, I did not need to do anything
further. A full(100%) data balance succeeds successfully now.

> In your other mail you indicated you were running a full balance.  Full=

> balances are never useful(*) and will make this specific situation wors=
e.
>=20
> A full balance includes a metadata balance.  The primary effect
> of metadata balance is to temporarily reduce space for metadata.
> Reducing metadata space causes an assortment of problems for btrfs,
> only one of which is hitting the 5.4 free space bug.  For all but a few=

> contrived test cases, btrfs manages metadata well without interference
> from balance.  Too much metadata balancing (i.e. any at all) can make
> a filesystem truly run out of metadata space on disk--a condition that
> is sometimes difficult to reverse.

In my situation, my observation was that when I hit the space bug, I had
12GB meta reserved, 10.x used. The first balance lifted reserved space
up to 13GB and I have not seen the issue afterwards. So from practice/my
observations, it fixed the issue (also see Swamis response). I will take
into account your insights in the future, though, and try to not balance
metadata.

Cheers,

Ole


--IIInXOIokcqgr3Mz1dvbIKT5dLmKumpLD--

--jqMJyVH9LOZjHEIz2tzH6Q7Zybmj69Kpo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSXTCBs9o76qfz+ccijGBTcPz+6EQUCXgzZjQAKCRCjGBTcPz+6
EdCKAJ9JyLsHfxRPxat7HgDearDZErIlWACfVPbCr4zGWYg60S2qtyMH8fBhQEE=
=foVj
-----END PGP SIGNATURE-----

--jqMJyVH9LOZjHEIz2tzH6Q7Zybmj69Kpo--

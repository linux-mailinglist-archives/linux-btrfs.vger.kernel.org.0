Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E74AA12D9A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Dec 2019 16:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfLaPKn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Dec 2019 10:10:43 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41921 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaPKn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Dec 2019 10:10:43 -0500
Received: by mail-ed1-f67.google.com with SMTP id c26so35440245eds.8
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Dec 2019 07:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=B8V6mo+vvU+/EfcCunYp6TjzYOLvdPhoRlfbKqgtxuc=;
        b=SZPyEo7oBk04uDDeSYRpOmzHCTo2oztQ3bS0BJ9fPepJv7KEErctZ1B841AcpNuFdM
         3eAH49oUn9g24h9jDTd/HYlOtz6BqDK5bQOi/cf2GkORRgDWpwnzQhyPIqu3HG0nQMsI
         VoLDg26URQVL2i2CDJexicQuw5mkirUSWPloFBO6VWNLwCzFOkxMRfFQIm6llEVH7Wyq
         29KjUKJ1v4wvkxSdmyp6u66RRvVJo90qNu3jHzhdkCJNrUl+40MxfE+c59cUWAKoqcjU
         h3X6gvP9BjrtO5CZeAItp99xC9FduwE+YvwqFJhFApC3FuNPLNYnJkHWFnCoLCz1Lz6X
         rrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=B8V6mo+vvU+/EfcCunYp6TjzYOLvdPhoRlfbKqgtxuc=;
        b=krDCo+43aMK8GzpERnlkmuo8ut81po9DI7vETy0lzchndaAz7p7rGzCiNzeJmDIaPH
         K8eNP8uz+kI7BmjKE28Eeh68/5nyXUSLTtHvpgE5Buz3dQvOX+n9Q9JIlpEwPBKH2G+S
         dE8CiwYEQnQfyef2S78An9+uWgnPq51trj7D6Gud2IpKO1TcUqhGH4R2UafftMw0n6Bn
         Z1C04ZpSD1VGzFbehYZMpHDXkM7aPpUIilXvDJeM2cp1fWSx/e9VXxAitOQ0eAk8546q
         GNJ38hS8BQWz3BFqGBmTA1Hqog4VvgcFcrt1qtjNLTjGLXHB6aCcZUx52Xg8wAymBjmK
         nxDg==
X-Gm-Message-State: APjAAAXMiBryM0i44otjYZ1ttX31h+/vhyIKMuq65pnKDzxIju9pKBC8
        211rufPaBcfWEojechUIIs9S9cZ6
X-Google-Smtp-Source: APXvYqzSbpXpdkMf7TlHYPlqdjPnvz8lrCn6cE2wPGjYPht7diwnX359uVOE4Do1RJ7HQhpy6YqeBQ==
X-Received: by 2002:a05:6402:502:: with SMTP id m2mr77387682edv.121.1577805041688;
        Tue, 31 Dec 2019 07:10:41 -0800 (PST)
Received: from [192.168.14.56] (mue-88-130-92-235.dsl.tropolys.de. [88.130.92.235])
        by smtp.googlemail.com with ESMTPSA id x3sm5924787edr.72.2019.12.31.07.10.40
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Dec 2019 07:10:40 -0800 (PST)
Subject: Re: repeated enospc errors during balance on a filesystem with spare
 room - pls advise
From:   Ole Langbehn <neurolabs.de@gmail.com>
To:     linux-btrfs@vger.kernel.org
References: <495cfb98-7afd-a36d-151b-d7cc58f1d352@gmail.com>
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
Message-ID: <7461874b-dc8d-4939-c4ae-fbab486750b3@gmail.com>
Date:   Tue, 31 Dec 2019 16:10:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <495cfb98-7afd-a36d-151b-d7cc58f1d352@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="FB1r5mP2wbQFOQnYHx9eUeop0uXV2sY6C"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FB1r5mP2wbQFOQnYHx9eUeop0uXV2sY6C
Content-Type: multipart/mixed; boundary="IKco3ZKV6t2yl5CMa9rA8TLcwunTueuk6"

--IKco3ZKV6t2yl5CMa9rA8TLcwunTueuk6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Excuse me for adding more information in a second mail:

# uname -a
Linux leo 5.4.6-gentoo #1 SMP PREEMPT Sun Dec 22 10:27:05 CET 2019
x86_64 Intel(R) Core(TM) i7-8850H CPU @ 2.60GHz GenuineIntel GNU/Linux

# btrfs --version
btrfs-progs v5.4


--IKco3ZKV6t2yl5CMa9rA8TLcwunTueuk6--

--FB1r5mP2wbQFOQnYHx9eUeop0uXV2sY6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSXTCBs9o76qfz+ccijGBTcPz+6EQUCXgtk8AAKCRCjGBTcPz+6
EQWeAKCit/RYVGFc5RivDth7jHxIW0scjwCg2NG3mjEDjVcxcP1dzoJsAiW6kWU=
=VMqe
-----END PGP SIGNATURE-----

--FB1r5mP2wbQFOQnYHx9eUeop0uXV2sY6C--

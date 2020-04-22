Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCC91B3A34
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 10:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgDVIfA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 04:35:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:50245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgDVIe7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 04:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587544488;
        bh=ay07BZl4As/SsCyB5h9qVSVCsdphbWCwVslwwrZPOtU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SSKIlGSEPbE7W0q0yzDPwX0mzcjbq/tQ8NuYluOABUJfZTtYhoL0TE8mxETvJwvVZ
         mTmPzTQWCt0S01o/0B9L+zLbrySA1cFCApQNO1GU1sQGVF9L1AF4Edxy8fBAHaYJmh
         xqPJlfE3/HuiTML8GLpHtJlLq9Ec6oH8lSfrj7S8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYvY2-1jeUf13lmi-00Up5N; Wed, 22
 Apr 2020 10:34:48 +0200
Subject: Re: [PATCH U-BOOT 03/26] fs: btrfs: Cross-port btrfs_read_dev_super()
 from btrfs-progs
To:     Marek Behun <marek.behun@nic.cz>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        u-boot@lists.denx.de
References: <20200422065009.69392-1-wqu@suse.com>
 <20200422065009.69392-4-wqu@suse.com> <20200422102653.0dee168f@nic.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <5888e1c8-6586-9eb3-5bda-fd81b33ff2b0@gmx.com>
Date:   Wed, 22 Apr 2020 16:34:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422102653.0dee168f@nic.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Z9jFIyhKU7i7XoA23SXyyLTpsVyNmHviK"
X-Provags-ID: V03:K1:SRu/UnOzjG89di9SUJZsqmn6tqlzzkJl28di0GbvsmJGaRdjjFm
 tFbUJKrglCisZvfLeLeeASZ6Rj83oj7/HR4LDVReH3xq7S0VJxmUKovNRinp32TC7bjpXGt
 g1/fSqLgKnYud91F2HPKZjTJbKNeBgIo420UY2g25Goh5zd4EQGxPe2lfNTfpj+ANYCdqIc
 gOCFOLRtVfvR1mCDqkR/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+EOzpHvXkOE=:iim5y8AtzMatXW0ZdWA2Ql
 f+3M3pdAXgPoXC4zuI/w6wsamtYzyi6y37udJBw1RqTavtyGDmrtfY3KprxG3CFGnhsLG2aDi
 LyYYUTzxhwLxjOMa0EsQ54q0DD7XTjx3YyohXrUmTsI/+ezCxFCpk/dXJqagclT7F8YULaonv
 vTWg/SEC1vrxe+2YqTmREZRpcbrgiOpjPUzFOFZQILpHEBpVCttPAIJAI84vZXJa7MWwBMk8v
 PdkGIKhGmPOGW5Wn5CpKWOCdUfuE/ZEZn7D0eyli/Fn0YFCmxqLiUqfC7objXIWAMOY9uu2El
 bmbxbHORomYCoXShM2kUDpjpxfCJndWijwcX416OXdsu9AbgHrVfMSByz5G64CiRzylQ44cCS
 ut6RYMqUEosQ5maMW8UTe1WtefAXAeI306Rzp3vPl2l6+ko+CVvTZpFil19iVM2b00S8IqepV
 dvAjva58V7MDcbFhuUslz4SkNJXnTYmc/HAbHHKVVnCGtfZLyVZoaRabDNL7V2pe0VoLDHZwn
 42Ypl+zLEPUsOC/BPXdlBu5H+y5uCnD/nZLJlrFCN/1az6dY9aI6niREl1lBtzfaj4D8uRFfl
 NDIPug+rL9suobdEd0IeBdLmOnGjmicZ5hrjAmS+cRqTRI4etxDFZqIJaDq3FWS2WGvCS74ph
 EP7ibEi5X8owewCIlcqzmZK+jSviwNxvzLeAfnJzmGumLSpGETZ6jbAmwWNA/qWHZYpkMCG8k
 jijZIT5XqhYe3cPw34MpKhB5kaMlHs/NFowoDUiNFOtGakImN66hiRdZ94xq9/y/8lThG7Chk
 D+ADj85Xc/IYRQlMPMXjBPCFQaymmr4IN1JGwt6jnDBIqQSNgAB07lYVOd9z8GMZCMDZ3f7f9
 2i2orC1Nh/1sVBSFiH62lefvNozXDRqkbhKEmuj779M8AiTye5wCAqX/1FEfbl9TzaOuECjhf
 zFjx3LO5xekpZbKFQHUwsRAgYFbHVmRoWd0C3PBFmI3jFFW4a93hZbzt7P+AfrjUJIvutzR98
 SdD6s0PvYgl8ub+Wb5zKv8aLbktR1u9l3fKyF4AU4As+jxInC6DASkLlak6t2F9G/JZ/CAbcM
 RuOs4/5y6fOi6YTOlDjavNjAtWo5P8Q/pg02r1R0WeIrBmQZjxZ09hFOOUVXcwL5vbhUGauS9
 pPL6DTux9Wfeg3IFGu2kAFW1/wU0HMu9ZDKOeOXZVGSCohkKF6/rOIxm/YcV2JYJDiEtUwC+X
 NnHEkynkUWMhetw+o
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Z9jFIyhKU7i7XoA23SXyyLTpsVyNmHviK
Content-Type: multipart/mixed; boundary="FxO7Obre8tlAi8stwZ6owqtNGUAhRfWw2"

--FxO7Obre8tlAi8stwZ6owqtNGUAhRfWw2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/22 =E4=B8=8B=E5=8D=884:26, Marek Behun wrote:
> On Wed, 22 Apr 2020 14:49:46 +0800
> Qu Wenruo <wqu@suse.com> wrote:
>=20
>> +/* A simple wraper to for error() from btrfs-progs */
>> +#define error(...) { printf(__VA_ARGS__); printf("\n"); }
>=20
> Is this from btrfs-progs?

Nope, anything in compat.h is mostly for different projects to share the
same code.

> I don't like these macros much, I prefer to use static inline functions=
=2E
>=20
> static inline void error(const char *fmt, ...)
> {
> 	printf(fmt, __builtin_va_arg_pack());
> 	printf("\n");
> }

That looks much better, especially we can tell compiler that we want
printf check on the parameters.

Thanks,
Qu

>=20
> Attribute for printf can be added to check printf specifiers:
>   __attribute__((format (__printf__, 1, 2)))
>=20
> It is possible that this won't compile when optimizations are disabled.=

> In that case more attributes are needed
>   __always_inline __attribute__((__gnu_inline__))
> These could be defined as a macro in include/linux/compiler-gcc.h
>   #define __gnu_inline __always_inline __attribute__((__gnu_inline__))
>=20
> Marek
>=20


--FxO7Obre8tlAi8stwZ6owqtNGUAhRfWw2--

--Z9jFIyhKU7i7XoA23SXyyLTpsVyNmHviK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6gAaMACgkQwj2R86El
/qjEpAf+N0IdFykDVeeEj7kdhBvHrZiQ22dsVz5iSchIfzTqfbnvzV7xWFg3AGgk
I+UpR+aa8KrdqEtzHFik4WhRtDImrFM6yWCkbn1XC01v0hg+Tyi5I6GMIwsqRIrY
GEfwPrj35ZqQSTl5VTvkMc+YUciIk38uE6HD0R3yvlhQK3OnzVqJZWGyJumqU8h/
tuWZYYd6WKz0iKBdFxi4HAtCChzfUn16bLeqAE0vCcf9gKFHZv+hrLrE/cMWk7/9
V8WqkLLagvjx/oyolvc1DlGi0xkqG5dcgYxoYnIHDhz/CI9LEh8SHRSNk6JRPTYZ
iQfa9WU6kF0ZeQWeW1DKhrlC/QqQQQ==
=allU
-----END PGP SIGNATURE-----

--Z9jFIyhKU7i7XoA23SXyyLTpsVyNmHviK--

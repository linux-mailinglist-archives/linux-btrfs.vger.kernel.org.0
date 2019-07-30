Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDD87AD84
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 18:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfG3Q2M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 12:28:12 -0400
Received: from smtp-36.italiaonline.it ([213.209.10.36]:49909 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbfG3Q2L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 12:28:11 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jul 2019 12:28:10 EDT
Received: from venice.bhome ([94.38.71.147])
        by smtp-36.iol.local with ESMTPA
        id sUr2haJmBf6jXsUr2h0bpv; Tue, 30 Jul 2019 18:20:00 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1564503600; bh=Z57so/p4k634TY23TDYJxQamtp2mcEMwjz67DTKPi5Y=;
        h=Reply-To:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=m0O98wF84zMNAJ1ZrPNaLCxQbxZPCzN8ilkALnA8uLw1xkntHNI2157OkGoEhQog2
         IdVhOalElwDAHa3X9yY+t8qKjtHFHJNPp3FjLo4Ac0MuL1Ph53skWGxOJ6m7HMpZXg
         MIsPzeyuZNwfSkx97jhTX+dEud/AuDldJcg9qB4LU8pHDsJCwq5QCqJYvgbLVaF/DJ
         Nb6aEYk0zabCrFdvyzjH6oPsP/Ee/J8eS9r++ngNVm6Y0CkbaC2PwmWSUGgvLaMD0m
         Faw5iBUSqBVp5SsbYWtkavpObFFs+QrKRcTOG1lCmBSk70znXqGnOdEesT+H1Vepcn
         J5IMuB6JWCLvQ==
X-CNFS-Analysis: v=2.3 cv=Y8EpTSWN c=1 sm=1 tr=0
 a=U6LzxGO83prFNIYJkwuscQ==:117 a=U6LzxGO83prFNIYJkwuscQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=QU2KpexNyc-gy-gGB10A:9
 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 00/14 RFC] Btrfs: Add journal for raid5/6 writes
To:     Torstein Eide <torsteine@gmail.com>
References: <CAL5DHTFA8G5fq=BQ7N7qQimesjygKTiBR2qZF4YBRAsAjB_L5Q@mail.gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
Openpgp: preference=signencrypt
Autocrypt: addr=kreijack@libero.it; keydata=
 mQINBFCBjk8BEADu0/Wq3RUaW9xXLkvv10HPt13XeA5Kso23CVg6ngNvpNy2jDyBAxKxgYpe
 D0YzGHB1p/TKP5/XXe5WPkNGHEYebo0WxjSBujFhDp1HCeuClieLH/itT92OFbw5MMa3EGRk
 pqOV/4EGslgdNaSwxLr6JGjRCOabweKIDBs44fGPUKVbT6D3q3i+l+ZGabREzlGzvmtztPyr
 PMcnWc2UPDqzj0s4w7nOH5wHzVD6yee7GotWF8BzWrYNytHQknO7YbTF9dpcyTCVNWFxL9U7
 6iweJL1CZONgLxjsl7uWFKM0zL24hhekMoghOOUyoT+UQa0h3EaXO6HH62fd+tqXM4vH67dX
 s/ToK+qvSbZQfFh8hZsNUxCLBsKKAP7N7nNLaxuMVEfpupqjrbGSvJUI3lngCAMrRPd7IkyT
 FUppDMjVlmA+oOMJs/MAfJ9CdsA14+2a+8Hoqrt2XU/gk19GGtAiZ6JG8V8xOx8ha2pCuQ9u
 2UM/kRc97k/cAsibxwGZE/TdUFv0uGMR2KjAbPlsRg8fQcyuVA8FnJwfoBRXRCSEWe/riuip
 cFc8UjcPZcfGXSifzIpWFc3q3WIF67CCEhwgQLPgkq5y6/KONY2we2hYXiucE0l6JNLUcIi1
 ZI0HAqo9ZsQTuRX+OoM0Er6gf4KTrgtEiXGB1sQ9ZAZiIU+4+QARAQABtDBHb2ZmcmVkbyBC
 YXJvbmNlbGxpIChnaGlnbykgPGtyZWlqYWNrQGxpYmVyby5pdD6JAlUEEwECAD8CGwMGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheAFiEEu/UWEAtk2sZffReyDtqbN4uC4LUFAlzIjRQFCRAJ
 ZbgACgkQDtqbN4uC4LU9phAAppEOgUdZhk1CgRC3kKDyI3w3ukwm43F4OEc18kXax66L7ARE
 GCboMLOq9AmOaSilMlUEY/3atiElgEeIU+Af7mzT5O7lQLo3fT/OG0QrsKs5cGGDtK2wKkHD
 ACsJ3OrfdO8mMY/ZiQD0VL46n4rA3OHOBAZCGPwgHYajojm1+nWd28Csc3fafTcik+bwh8iG
 wjQs4gygECCUieYqatOR9B1R89cRNsS/o2gFnv4UgMG8ZsAZj/wWBBGjS0XiBj8xrgLcJo4O
 bS4xi/T/quc6wbXekS8AAgf6vvtDKdcBhhaILES0x2nqNF7ofJ6PNe9vrwtw+z+quUMqSU+5
 GHzvly03Veo3exAVl9C4R48w2/c6d/1qdNwrStzseGacxviyPsk7GoJL/wKW51+k0ntdxIT+
 UDNZ3xdcFLdw+tYO8RF4FLmydm4WivWvlydOS6/D0U72xy5dWdAJOAoRRKnLyZgHwYP975rT
 EwwF3PDpyASTpPLungJ3UNtaKpqAfAprfgVKvkolUqgMqRhXAsgukV7OiRu2qPNYLGyP2Ijj
 NIGE9/yZjfxeHgXWwYr0faFJPSnU71MAkRH0XzNkv5MQc4fHqtCyDf2+BU3UAF5YsvGy2zbP
 a/U85HuvA4Vt3zpEy43NNPI0OQul377XjfGZmWcdqF13tNB0fJnAnDwTlTe5Ag0EUIGOTwEQ
 AMMPbyrahlAtk2sr5APDPLXuDaIKw5h5dcuWaQj9yuOhDtnd0nGi9OYROMs6M4lfy4HK0mfO
 Ruw3cvMrzBUMozS54WIWPzkYfUXN87Jy9zEZ+T+FwRI2QEWPp3k2iZLkGqXaLREqvwHLXfcm
 dyJbRinI7sCBgAWh48S3vdIiXIcER18LaNBlLaCxyWZcMfSOoIS8x0LlTEjlXFhwCq+OvCL1
 3AV10dgCT2TZnknbIdf6nFBXiSqg1hDhopevMkXetuKMytSEwlE4Ik6CPO35RrG+ApxhryQk
 MG/+kk/RnI80A54POtU8IkHyh/hpNzu3PNWQ4sc6klOY4eBoXBc5oSLzXJXCAP8usALJ8tan
 8wjGv6OYQxxpPUqKiCOmdLkQY8Q254cyNAx4akW4D1CasTqyHQu529AagXogFN8Ou9b+iTSt
 sEMGMROQlAwtTywU27XdZO1RJFr8jw8ikk0EoZEy+KOajjyUWR/V+BhrtEbbKNr3oENZP5Bg
 r4otUlxpCFPyTTnBb2wcTTn9pbfz78UvmtCDyBeZuixnsRQ3oaGFq5g16jPHZaMawDNtwAUZ
 cbjHIleMGAtagFmRJqeqUOqS4zcotwafKDoaesbr8970D2xF8SblRS6RkI31q6xxgs87n7Gl
 oQYOAjJf8rc89+9r3e2yqfTrstuCxQIqgYMPABEBAAGJAh8EGAECAAkCGwwFAlaGex0ACgkQ
 DtqbN4uC4LXNbRAA1qhcKi/wLf3HCsevNqvYCnZLo4/u/ZgIOKkUK2Ebajb314zN93UeJQZX
 dyhCDKFWgboeL8OySLze5/kT944NhJbn40LI7fHE1qEtSCDjCIi3SU+zRpJTM0mx4kuw3d9b
 6swzuWybSrAoxZuq24R9BKfVwUvZ+IIjasNkAxDTXoY3jsEHFzEv8qZBrR1BWcdhJbIAtnb2
 zKug/HGZ5aAmlBlYggoX+XqGKlZg6jnF4d6BjV2SSxaKuEyTY+KwYQ8dY8754sxhCvv1LZal
 l8pDvoEfF/6dyOMA7K2IuD5uYf90cOjrgM1TaMTKvdvS6hm6TveYXXXK582XeU7C0G/BvWYn
 BM3MdMVsnTMp50HRE4/rMdLzgFxcdiAnqTB4RDfcTcUdlMY4lQfTOSKVS8iuLQYbNyjc80vu
 FKc5qNRAnzQrXk9BkCuSzJaNXvoKrHknDGqzM1MHjarfkQofMMKwg90Ji/bKHoHVGzp8rfKY
 hfOTIAnzXIyegjQWXmnXiZ17OnCnSNIJuCw6OduueVSXtXqbUX1D8M28VLfrh3HWpCLLUR+j
 zcbKI1trRLZsFjj5uBkiTT/f/3jnp8OPiEywQ6vcm5YVZfYbHIx1sM1fKH0HrvfFCx4ANVAA
 5jG0MHwu2J/zJsFM0V7L9V9sRCgXNbLjeL/OJ8PLNY7UTVFAEaw=
Message-ID: <d877329a-0f50-e3be-19b3-4ea774b1c2be@libero.it>
Date:   Tue, 30 Jul 2019 18:20:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAL5DHTFA8G5fq=BQ7N7qQimesjygKTiBR2qZF4YBRAsAjB_L5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHhkXmh3gjqosoXJdBAXYk/tsNNZn0q3VS3mKUN3lFyrONuttAPgMVRqyNddjKv//cOOKkpoH0ZKdmVvyxiUllz3r/T6uELXyrT1hoR/7BK9cMCrPBid
 yuPmQQffngUV/EPd2TrZlPX3MMA4jFgq8BaL9mEUO+yz0mrE50ouMm9dKDVBVBpCG0QC/4Z/jHPbNxpbUFOglIrVjyxmHEq5aOw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30/07/2019 16.48, Torstein Eide wrote:
> Hi
> Is there any news to implementing journal for raid5/6 writes?
> 
I think that you should ask to ML. I am (was) occasional contributor than a active btrfs developers.

BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

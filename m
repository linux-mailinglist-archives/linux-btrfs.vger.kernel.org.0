Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19523CEFDD
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 01:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239226AbhGSWrT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 18:47:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:43907 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376295AbhGSVZj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 17:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626732365;
        bh=m1RoUt6wke5q3c8LSjSBb3+h9rkh9hgn8OjVlKJAwXw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AHIwxq7mw5RteWS2WddQIYAfub2eeRCGG4QolciFyIRbrUX/KD64NyKX+ZnWjK1IQ
         t+Aj47V4WZg0N3zzWFxapNsSEU0PMDYe+8xRaMvLbYmGXZeO8OijIgkfY7tq/kDjBR
         RgICo7nIyR8E16OUMXIV/T3Bv+R6KEFX0SQwyKnw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MnJlW-1lMKUq16Ae-00jEkQ; Tue, 20
 Jul 2021 00:06:05 +0200
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20210719071337.217501-1-wqu@suse.com> <YPWF5iqB0fOYZd9K@mit.edu>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <8588de9d-b4e9-0d4a-4ea4-41a6673ddcd5@gmx.com>
Date:   Tue, 20 Jul 2021 06:06:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPWF5iqB0fOYZd9K@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E8MYtYTYzMbP9+7FUaLtqglI8z95VQ6jAsk7oDRtoWYTsGZcB6L
 TpQKzzbfJi0JkY2vw+F/cZIWsRXjpeM+H6VEQQmK5ZRdHuAn7Zm/K2G6nqfJl8kKiAMhZzd
 e6rfEYJAzLsZv6LBGAJ50JQZsw2Yt/BVuQ3Tr2IpirAQBo29h1ehkVjtZFCu6QEGEIUQi9Y
 oIO8dveyPsF7JN3lTV0+Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9Hx14OjWEy8=:tI4SzxaW3EWqJDNh0esH4g
 dv1TUAZS/xMFhJKwSO+h9Li3CjadCVnGRd5qzCaN8LRWchwJSnfwT0DQe0yKrIi89bMrd7r1l
 EGSeyNVw4ndIFdg/MLKGi+w5qfwztRjfpB24Y+BcY25gfCtXnJyCZZi8tN6Fp3jqdJZq0qOg7
 8hGlKntSDA2GpH4paSmWG8u3DTDo8yDaFKTgpPTbCO/jEEVLiJXUzYRqgQaJDGjQboyNeqdG6
 g4MbV+KJYc3hcqx0Ufhel+p1UaoMDKA5lxZLr41//vTxB8AKFi32GovPfyvImXuEm4uk3gnyc
 59buUUL96PYLjg5d/DieH3QQyBD7FZQ2SIF7NUOs7S0ldMcvDQlYInkRu3psu6dEApJaAubxQ
 G01HR+Fs2iuXrZuGffYwcmfcg7uVIQ3aNp8WDyR/44C+xEEyNjE7lYzw0d+A4bqb92+zbQ/ey
 55yDTGNEYu1u1rp48qPUwHCu5EVIyYSG7O2owWVYNuQgJdLtPJppD2nyMaJpBjxsvgFBhDCo5
 IkcRdjYNsr4yeFiNWBiizWokag8w0a2Z0gMrMDLrrA4sxYge42KFgbNb6vtY6xwv/BNIlNCM0
 Mlmy5rByehRho0t5Z7MO/RwooPRbDlxz3F6P+EokbVhCXgv6zQc7KTD/jl+nZ4UuCxOH7DJyl
 MX4r2hocoFoJRpQutccsOYSvY6iTuC8zgtVLKa9ptzDHTg/6Ez2jslovTqZRlAFbi4NYCG3+2
 KG2A+3tZpQnWLeMhs9YmwKWayfFxStMUKTgpOw0Ih4NrzfJrUGFd544J9NeLoUuikokiw+1Br
 NKmoEc0dP3VQJYqDa2Sde3AFZDMKwrCkKO4IpJnbUPSlftwyAFVnw2+uwxJaAUrjuUVrquZc6
 37WOtNfBIhQ3LL6DfR035sgbPcdhbohnhRs1VXrN0Voz040NKA8vUd203ngISW5zMbqDG3qHs
 Mnjk0/Sfg1xtlTteCUMw1w1SdedNIVBA6o4Iz4l4O6exdh1mXIQCnq0XvlHBFR2B1rhU2kczN
 J16Z+20d/Uf5cZIU2UNeifbXkGpJxwmueFoGhUVIQslOhgAhi0DApMkU2T73c6mVCzFcdwxfK
 mlJYNUVaVKx/1U7Z1DlD3Mibvb9iL5PhNZNZVIzNcs8D0kYq60gG7HidA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/19 =E4=B8=8B=E5=8D=8810:02, Theodore Y. Ts'o wrote:
> On Mon, Jul 19, 2021 at 03:13:37PM +0800, Qu Wenruo wrote:
>> This patch will allow fstests to run custom hooks before and after each
>> test case.
>
> Nice!   This is better than what I had been doing which was to set:
>
> export LOGGER_PROG=3D/usr/local/lib/gce-logger
>
> ... and then parse the passed message to be logged for "run xfstests
> $seqnum", and which only worked to hook the start of each test.
>
>> diff --git a/README.hooks b/README.hooks
>> new file mode 100644
>> index 00000000..be92a7d7
>> --- /dev/null
>> +++ b/README.hooks
>> @@ -0,0 +1,72 @@
>> +To run extra commands before and after each test case, there is the
>> +'hooks/start.hook' and 'hooks/end.hook' files for such usage.
>> +
>> +Some notes for those two hooks:
>> +
>> +- Both hook files needs to be executable
>> +  Or they will just be ignored
>
> Minor nit: I'd reword this as:
>
> - The hook script must be executable or it
>    will be ignored.
>
>> diff --git a/check b/check
>> index bb7e030c..f24906f5 100755
>> --- a/check
>> +++ b/check
>> @@ -846,6 +846,10 @@ function run_section()
>>   		# to be reported for each test
>>   		(echo 1 > $DEBUGFS_MNT/clear_warn_once) > /dev/null 2>&1
>>
>> +		# Remove previous $seqres.full before start hook
>> +		rm -f $seqres.full
>> +
>> +		_run_start_hook
>
> I wonder if it would be useful to have the start hook have a way to
> signal that a particular test should be skipped.  This might allow for
> various programatic tests that could be inserted by the test runner
> framework.

Currently it's impossible, as the design is to prevent any hook to
interrupt the test.

But if we allow test case to return its result, then it should be not
hard to make us to skip test cases using start hook.

I can enhance the next version to do that, but that also means any error
inside the hook will bring down the whole test run.

Not sure the trade-off is worthy then.

Thanks,
Qu
>
> (E.g., this is the 5.4 kernel, we know this test is guaranteed to
> fail, so tell check to skip the test)
>
> 	      	      	       	    	- Ted
>

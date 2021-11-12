Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D0244E57B
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 12:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbhKLLV6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Nov 2021 06:21:58 -0500
Received: from mout.gmx.net ([212.227.17.21]:36229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233883AbhKLLV4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Nov 2021 06:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636715941;
        bh=LQt848926u9K6z7uSyjawdWGk+7+Ibi1hqPvmT9+JiQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BQH8ZiF/ZQ+fuafhg/2xgF5eBCvANbyVpbp03Yvoxgc85lyOeMpt1AQaRPaScfBcB
         iBmBQJJM+EA+n7D8lHTtPyjkwQ+9FLFU1bnpQInqbtEg/qZbCtbTzzow4FYrOpo3Zn
         VEkDEBO4feNjSoh1O/8eaSDI2QVaTSKtsQHGjgys=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMGRK-1n1N2Y39DK-00JGzu; Fri, 12
 Nov 2021 12:19:01 +0100
Message-ID: <c52e4c15-591e-aa7a-1d42-aa5c2a3c3958@gmx.com>
Date:   Fri, 12 Nov 2021 19:18:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] fstests: btrfs/049: add regression test for
 compress-force=lzo mount option
Content-Language: en-US
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20211112023535.21370-1-wqu@suse.com>
 <CAL3q7H4s=KqcwstvzV5GXCbfcyXASvtY5FbNYyEFoxW=ZtfeEA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H4s=KqcwstvzV5GXCbfcyXASvtY5FbNYyEFoxW=ZtfeEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E78s50iho+P/yjD7wqV2cL+veNDtvL5FIaEp4y6YgLdrzhziaM7
 4aF0Xs/4bhWNIBPYYdi5TsJf1l2+leQCUB+2OFv4fzjbvCpHgvPXHkkVPFh9eNdPz0LAOUE
 1zdGiJgQQeX2RZgUp8ILkgHEqU31Zu0LFXl+mt1z0SMJMwSOY31EYQtQJhNCgVDfIspVU9R
 4dGIySTzGPfqQd9pMP0IQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d3nxGOxovx8=:Ml+QEuQvIxBxy+4uwIikOt
 xvp5xpXxZWgMQUSgg78+o5eHtzMoTB0xo8rSqTX/0CJPWQf6fpgmio12ILI+xGwsmD/IfjrGW
 9BCUUYQu3WlLvMJ8eNsK/16PoDvS7V/xmJsI5cQDagc76ItADawjdq8MMvauSkG21MNtzqKzx
 FmgXcDc5GAHypiRf7xA561rXY8//OLFzZDYA/UGcVPTzK6Sr7pYVsNORs6w02EcbGdg1rTnqd
 0e7ohfNIglaULfMQy0MLN1g2Lyf+GJ5AcvA4GACUWNHUqPdEsd90z+FMsFbtJU0VRtG+Zm5Fu
 Pam2kb7dgT7UQbITxWb0EVkzDZuReXLvoZHub4UvIPmDOwXbo2ZOxV4Qybs6O1+o2mbTIy/Rm
 b4EmRgHYMPiF0DHJSFj4IHntjnucobhlbOei661y26Jp44Bx+LBNCEn8N7YVrwsfJD5xBVmJZ
 sJFlF3QiHRW/TxJceU3JDuW/RX62NlZNiSuxxxDb4IHktBvOh3398Iamu6XULBCrdlt7WsJ3V
 2sQTcub07BwUE86gsKgZDrxjeHOBURH6xO5u/4pSg/Y5nRMP0MNQcnRhgUY/HNskMXn6EjqY9
 WpkxwqwbnwVyx8pRpfKeEMRUo5tvc2Kc2CujmVQ1p5AjG3BI/FQarOxYBM+NPhKqTnBNrBrht
 a+AqqDHDAkiPqaRbm4gTB3ktRibnjrLrUnMaCzjcadWzNLBMGTXOxFslzq2X/0Hr2I++Rh3rJ
 jLD5jxSDH+Tc+CsH3B5ILuIRaD0IYTUqilRdBdLJvfp3bytnX2IlFfxXZJhn6ZImdcA6KBDH8
 BHyjwjHZBC+l8aEbsDrYJVZ5g+lwrqfOnSGqqJwBhVH+kCTlGF7MHTGE3MuTYVyNdDqtaxxH7
 CEqJAN+mt7r6f82nfo1DzMF7HEVaiO8GTRgpelnQ51dhQZC953CGZ6XxXFLLXcfCiw7bgV48q
 hM85kdNLo4GG9jqrNAGlo6UDxrbf1i0CdrD+nykB5MnOhc6H0lwO9Kgvj0KlRoc2uDK4X8PYM
 J8bRjRuIxZxWUOOlO9zIs29uvMBlUXFXfhs1sSrNv29eKxuuxFHBVaL7xsd0ONHxIzl3ZugJQ
 TzrFXplbEm8tl0=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/12 18:51, Filipe Manana wrote:
> On Fri, Nov 12, 2021 at 2:36 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Since kernel commit d4088803f511 ("btrfs: subpage: make lzo_compress_pa=
ges()
>> compatible"), lzo compression no longer respects the max compressed pag=
e
>> limit, and can cause kernel crash.
>>
>> The fix is titled "btrfs: fix a out-of-boundary access for
>> copy_compressed_data_to_page()".
>>
>> This patch will add such regression test for compress-force=3Dlzo mount
>> option against incompressible data.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/049     | 41 +++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/049.out |  1 +
>>   2 files changed, 42 insertions(+)
>>   create mode 100755 tests/btrfs/049
>>
>> diff --git a/tests/btrfs/049 b/tests/btrfs/049
>> new file mode 100755
>> index 00000000..5a73f738
>> --- /dev/null
>> +++ b/tests/btrfs/049
>> @@ -0,0 +1,41 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 049
>> +#
>> +# Test if btrfs will crash when compress-force=3Dlzo hits incompressib=
le data
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick compress dangerous
>> +
>> +# Override the default cleanup function.
>> +# _cleanup()
>> +# {
>> +#      cd /
>> +#      rm -r -f $tmp.*
>> +# }
>> +
>> +# Import common functions.
>> +# . ./common/filter
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_require_scratch
>> +
>> +_scratch_mkfs >> $seqres.full
>> +_scratch_mount -o compress-force=3Dlzo
>> +
>> +$XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 4k" $SCRATCH_MNT/file > /=
dev/null
>
> While at it, instead of just having the minimum to trigger that
> specific bug, it would also be good to:
>
> 1) Try with zlib and zstd, instead of only lzo. This way it will help
> more easily catch any future regression with those algorithms;
>
> 2) Instead of redirecting to /dev/null and ignoring if we are actually
> writing what we are supposed to do, can we verify that we write all
> the bytes - i.e. that there's no short write?
>
> 3) After unmount, we could also mount the fs again and check if we are
> able to read exactly what we tried to write - that the write was
> persisted and we're not reading from the page cache.

That would be a pretty good generic advice for all regression tests.

Would try to keep these advices in mind for all future tests.

Thanks,
Qu
>
> Thanks.
>
>
>> +
>> +# With kernel commit d4088803f511 ("btrfs: subpage: make lzo_compress_=
pages()
>> +# compatible"), the kernel would crash when writing back above data.
>> +_scratch_unmount
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/049.out b/tests/btrfs/049.out
>> index cb0061b3..c69568ad 100644
>> --- a/tests/btrfs/049.out
>> +++ b/tests/btrfs/049.out
>> @@ -1 +1,2 @@
>>   QA output created by 049
>> +Silence is golden
>> --
>> 2.33.0
>>
>
>

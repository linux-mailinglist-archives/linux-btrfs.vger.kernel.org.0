Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC996539E0
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Dec 2022 00:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiLUXs1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Dec 2022 18:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLUXs0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Dec 2022 18:48:26 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FBE2333A
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 15:48:24 -0800 (PST)
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2E1G-1okS6w2Pq2-013h8O; Thu, 22
 Dec 2022 00:48:17 +0100
Message-ID: <4531be20-470e-9984-6535-fd822c6c157e@gmx.com>
Date:   Thu, 22 Dec 2022 07:48:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Oliver Neukum <oneukum@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <148b838a-897a-90d6-7e6b-564238d58eb0@suse.com>
 <ddc034c6-655d-c3f1-8d69-544b743b7ac9@gmx.com>
 <3dbe35f1-0815-73d9-f53e-86aacabf13e8@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: recurring corruption with latest kernels
In-Reply-To: <3dbe35f1-0815-73d9-f53e-86aacabf13e8@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HAXEHVGhp5JMpfOtcikjmOi2+dTJ5iV1zOoXKKNNwe5wuij4nAC
 1IsyaEgra8iUOoiNz6VECKKXBMzgCwkbGkemA0AxH9rLlcOh7QSUTBA8pAFUVYvk3+kaiC2
 ZjmKUzJ1+AG1bUitarS5JmH/7HISJFOFOQkb3gj5zjJs5uuP8Xjn5AGWRhNgVxSn1Oxxf4F
 a1DUknj8umSlQWANOPTlw==
UI-OutboundReport: notjunk:1;M01:P0:L8gqEAopjnU=;pJsIDMIglPPqgDYLTkfWt5zlSwC
 SxdQlSMuxWX+BKpZ6nO9UNQpKXsofHtT2+q/pU/S0IfHW+fxfWabwNuL45WM+sXUkZg57Aocu
 mymmlxTXXh7yHyR90MiweWns2NA2PLtJFfSb5cZ3iRfBrFJZpFz0Jl0drzBuA+Q42v/EmG244
 bbazN5Ecmfd+UOAZ5NP7IrrRkQsiAYaLyrjKs8bHexdFKEwU/ZDkKylk+kc2+kzdZ8BDYT9Eq
 1vanPg1/L60WDVWHXfQvubwrvF6AU5WT7nDba/mBBmK8iegV3+QKnwsahGn4xIMv2QMx8fPVs
 J4QnWehN/XpRzGGn8AG1JtfxWmmmW/ifRQGScxPKF5aM7HCE8Ff1rtgicxFN03/snCsqrDTap
 +Dx2yUvK67AYUw798W7tOOuQan9fYyfcCKzYcaryJqsN6mf9yTuXCRC0LsP7JBit0DzQ/PCED
 z6U5rY0/mxqE8mLyv4R3y5wQ9WW9NJKyDLc1yn3fUXDHzQ1g5XREYtmo9YcOr2mVEo7x49wON
 OhcK7FPEBTqa1YwlWZttL9ev03HfmcuGffALYR3b6QMi7mrMiqJK8kBCeNGQGBellBr9ekdQe
 OhuMJRLNBR2VCVbVnCZmIN07tRTISA8o9NiCCaHmvkXODV0u0WLlA3QPcv/Ncf7jyRIrVSR3m
 89sz4Q8sOOgqYJ6gWSvh1AbWtY80PMyRmhEppAqEwEHI8IQGHcTZAduopBoy/wxaOUJvqE3qd
 IDW2D2Aj/D6vluzxprze8f4QwzMFeigUqELwuGBi4egGZgHdI4+Lq4RG8Bmh1sJiTSFChm1Kg
 ofDITuQP2ey1QeGO92fh1MVXqrO8SzwUZxaYz/jTn2XL2SaVmklzEfq5T0MUd43h4i+5WFZcZ
 mrer4eCLznRZ1CTJtYj5sKNBP2ZehO6Fp4VF98VmpbKez+4PTXZ4gJscRxd9Bqy79FbUM5K3j
 huiRCtRZ0sv6OttY2GPO41x0nnU=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/21 23:00, Oliver Neukum wrote:
> 
> 
> On 21.12.22 02:29, Qu Wenruo wrote:
> 
> Hi,
> 
> I am sorry that I did not include full dmesg. I am afraid I cannot 
> recover it now.
> However, the issue has reoccured, albeit without a full warning. I am 
> including
> a full dmesg.
> I find it quite uninformative. Any suggestions on debug option I should
> enable?

And when the problem happens, what else did you see in your workload?

The system hangs or the fs falls to read-only?

> 
>> Please give a full dmesg, not just the WARNING, which is useless in 
>> this particular case.
>>
>>>
>>> Upon check I am getting an error in pass 7.
>>
>> And fulll btrfs check --readonly output.
>>
> 
> Here you are (of this time):
> 
>      Regards
>          Oliver
> 
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p2
> UUID: 6b557439-a722-46c6-b9fa-e3395a5f4d40
> Rescan hasn't been initialized, a difference in qgroup accounting is 
> expected
> Counts for qgroup id: 0/257 are different
> our:        referenced 27094540288 referenced compressed 27094540288
> disk:        referenced 27127427072 referenced compressed 27127427072
> diff:        referenced -32886784 referenced compressed -32886784
> our:        exclusive 27094540288 exclusive compressed 27094540288
> disk:        exclusive 27127427072 exclusive compressed 27127427072
> diff:        exclusive -32886784 exclusive compressed -32886784
> Counts for qgroup id: 0/259 are different
> our:        referenced 1518755840 referenced compressed 1518755840
> disk:        referenced 1530195968 referenced compressed 1530195968
> diff:        referenced -11440128 referenced compressed -11440128
> our:        exclusive 1518755840 exclusive compressed 1518755840
> disk:        exclusive 1530195968 exclusive compressed 1530195968
> diff:        exclusive -11440128 exclusive compressed -11440128
> found 154172760064 bytes used, no error found

Only qgroup mismatch, a very small problem, and can be easily fixed by a 
"btrfs qgroup rescan".

But I didn't see the extra prompt on the currently checked items, I 
guess the progs is not uptodate?

If possible, a uptodate btrfs-progs build and check output would be more 
helpful. (You can use tumbleweed ISO as liveCD and run btrfs check on 
the fs).

And the interesting part in dmesg is not much:

   BTRFS warning (device nvme0n1p2): block group 389723193344 has wrong 
amount of free space
   BTRFS warning (device nvme0n1p2): failed to load free space cache for 
block group 389723193344, rebuilding it now

This shows that the space cache is not correct, and it needs rebuild.

This may indicate a problem, as we rely on space cache to do a lot of 
COW work, if that's the case, I'd recommend to at least clear all the 
space cache by:

   # btrfs check --clear-space-cache v1 /dev/nvme0n1p2


The other related message is:

   BTRFS warning (device nvme0n1p2): error accounting new delayed refs 
extent (err code: -5), quota inconsistent

This is a qgroup specific error, it shows that qgroup is unable to do a 
backref look up.

Normally this would mean something wrong in the backref walk code.
It may be some corrupted extent tree, which can also be caused by bad cache.

Anyway, we need newer btrfs check output to determine.
And if no errors from newer btrfs check (except the qgroup one), then 
you may want to clear the v1 cache and check if the problem would happen 
again.

Thanks,
Qu

> total csum bytes: 123424284
> total tree bytes: 791822336
> total fs tree bytes: 586547200
> total extent tree bytes: 54788096
> btree space waste bytes: 134346049
> file data blocks allocated: 153505906688
>   referenced 153221865472
> 

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE6B56B316
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jul 2022 09:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbiGHHEj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 03:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbiGHHEi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 03:04:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E5F6B241
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 00:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657263873;
        bh=/wTJ8+RneV+637G6cDHuL47sk2p+arUJzG5UThT4pps=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Jk3fZe5uY0AqNcwc1M4XXHTxJl/j2LxFzfPNgtSx/SuRlTiq2WP7Y6EloD0bmFNNg
         7SsSv2UDeqNaLzQ18jSv3YZF94vtRhEU3tNKkbMQ3rFWJvXcpRQROQUmP2cqeg+KD4
         THLK5HjgpvKj62QPVc/sAWGTSDC4P7dJY7WTxb4g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfYPY-1ngxw026Ei-00g3Jc; Fri, 08
 Jul 2022 09:04:33 +0200
Message-ID: <c7c50f16-92de-c9d2-d665-40f9556c6c80@gmx.com>
Date:   Fri, 8 Jul 2022 15:04:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: BTRFS critical (device md126): corrupt node: root=1
 block=13404298215424 slot=307, unaligned pointer, have 12567101254720864896
 should be aligned to 4096
Content-Language: en-US
To:     Denis Roy <denisjroy@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <1d43c273-5af3-6968-de18-d70a346b51aa@suse.com>
 <BD6F70A8-17FB-40E3-87DE-E185049DEA2E@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <BD6F70A8-17FB-40E3-87DE-E185049DEA2E@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dPzxWfAMLQM1o8LxeBkE7fmkDcU9gXJqV/xbATZjoTuCyui0543
 cOFNXfkacPB0l1OHHrRNFH9OHkU6wwvMrvqoa4hTqGF6U3pLOOEOKltf1sk/9YtX0/RcwHA
 HKSEXcG+xeN1XRa536IRe3J0IZb4M/XMWkfFhihZbkrkcjp+jibhv9QZNlDYmhHMV78ohYQ
 1MbJjZP+AoRwEAphM6Miw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lDGuBYMsPCQ=:U65MBbL2i8POaqFCBmt58S
 kT/w1KfAGIgz9OHRxdG+Hs7crHmBwYIXVebRxfZmQedBfypJgF17e7FNjoI12IVXcDPTHBVUH
 9Y4psdDkHA+908XU85rXNnURAxOzMyazF+9/GXPRkWSmDtgyNGzVuc7n5ifVtFNAYiYACrCGp
 TUxojRZ85jARKE5+0qtkqS5J0W2SbROJDqp0sFgV96OyD7/fTkJuYfUQVFo1cNxNvVKES3/Yi
 gIFT7V6Sba2MCl8RJEd9QCykNrWJ5Bkgx2WkC5Dgly9Y3qvWkRLhagmnRfxL4BoskQGMlQXhz
 x3I6eK6VxkkiWhbXldtIGS8Wt2RGyvE4nKiYE16zJ2BhVzQ8a4yJrqksVgTDKyTkf5QqoRaxp
 KWTLbx3tn7wbo6Dywy3TqBssKt1sL1cnnHxm40d1PrQQi84SMKqRaqjk/Rjw8UdgaI0rMb5Zd
 N322JPIznCOmm8UVLNbJPCw9iAmg1RB6TK4NYN868fHWfWRGraibBozcDgA8+oRtOQM11tb2c
 j7wKgo5smk0IvRtdFxtacluKW+8e4IgnIlW6bWaUeOzcyOPqDgLLLn3mmLw74KAxYz5qcsIop
 z+nkhvZo768vb9JIWMKnYH1Vp+JHErsPOBfwYeRS3t+FKEygBr3Z0XokqbnRjt8XscBaIjuOW
 5KDdGP9lXnJ/wR4RGSTa57i/GybOCA6Ji82RzH/6kNPalkp88P1k2nnuBuYDZ65tCO5rT/OQk
 NZqKjezsDcHcCIBVYufqgxY212hXLKEWTP8VYTw1Es36Yl8pwZu+dxLqST0mbaJZHsxC3xehH
 fuuHmSL5pY1GR/ZSxN8AglARBP8HcA/FNL1xmDrUP1OvHMfh9ZGS/VL8Ra7A/tArEH2kcyO98
 GDfOUghHmBVNLVg9ehlwXP1U028LivtSBOv5fAjGpmKIm5l5Qc5fJ44u8dwNuP6Qm3B9q4y5m
 HMhGuBd1NKVMCZStxmuU7DBwDdHhl3LsaxX1vh0i5XVTdE2UxfK9H0ZEiVtp8mps3n9MbahHN
 9amGpC3uEv7R0RH4gHAhUxyQOF5ogITVLaleuy/sdg78rVcg0E9xxfXqGQ8iPaqWn5uOHnvrw
 Rwx87ZFHujODu59mWLKp97OzEVWa1zYI10AtDFoQNWJkIqa7WQ3WfMfBA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/8 14:20, Denis Roy wrote:
> Ok, great. How do I do that?

Considering you're using a vendor specific firmware/hardware, I don't
have any good suggestion, other than upgrade to the latest version the
vendor provides, and hope they upgraded the kernel.

Or you may want to jump into the rabbit hole of running a common distro
on the NAS hardware so that you have full control of the system, but
lose all the out-of-box experience provided by those NAS vendors.


For the corrupted fs, you may want to run btrfs check (latest version
recommended) and post it.
Then we may be able to decide if the fs can be repaired properly.

Thanks,
Qu
>
> Sent from my iPhone
>
>> On Jul 8, 2022, at 2:01 AM, Qu Wenruo <wqu@suse.com> wrote:
>>
>> =EF=BB=BF
>>
>>> On 2022/7/8 13:50, Denis Roy wrote:
>>>      key (7652251795456 EXTENT_ITEM 72057594063093760) block 125671012=
54720864896 (383517494345729) gen 72340209471334675
>>>      key (2959901138859622420 EXTENT_CSUM 3664676558733568) block 2234=
066886193184768 (68178310735876) gen 18374696375462128179
>>>      key (1153765929541501184 EXTENT_CSUM 0) block 0 (0) gen 0
>>>      key (0 UNKNOWN.0 0) block 0 (0) gen 0
>>
>> The above dump shows the tree node is completely corrupted by some weir=
d data.
>>
>> The offending slot is not aligned, and its offset (extent size for EXTE=
NT_ITEM) is definitely not correct.
>>
>> But the offset looks like a bitflip:
>>
>> hex(72057594063093760) =3D '0x100000001800000'
>>
>> Ignoring the high bit, 0x1800000 is completely sane for the size of an =
data extent.
>>
>> The next slot even has incorrect type, (EXTENT_CSUM) should not occur i=
n
>> extent tree, but this time I can not find a pattern in the corrupted ty=
pe.
>>
>> The offset, 3664676558733568, is also not aligned but without a solid c=
orruption pattern.
>>
>> And finally we have an UNKNOWN key, which should not occur there at all=
.
>>
>>
>> So this looks like that tree node is by somehow screwed up in the middl=
e.
>> I don't have any clue how this could happen, but considering the checks=
um still passed, it must happen at runtime.
>>
>>
>> For now, I can only recommend to go kernel newer than 5.11 which introd=
uced mandatory write-time tree block sanity check, and should reject such =
bad tree block before it can be written to disk.
>>
>> Thanks,
>> Qu

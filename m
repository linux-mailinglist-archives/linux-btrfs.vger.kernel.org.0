Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE85790488
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Sep 2023 02:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351432AbjIBAke (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Sep 2023 20:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240699AbjIBAke (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Sep 2023 20:40:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78105107;
        Fri,  1 Sep 2023 17:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693615221; x=1694220021; i=quwenruo.btrfs@gmx.com;
 bh=Ic0QQvdg0PnMZ6LyQzziXKPxqPtWETQ+PnYFb1xC6oU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=iCTm728BNoJiJZuQSecKff/bJxGNkP8keEcxmQZfGPY56EZroNg32wJScy2MOUGiDKDKZ0W
 WhfjGUJcqhA66JJNeFJTVLAfunXMZrx+aBX9vEJXm08gPMETcuz2hPbm4TS2TSA9fUuFvsHvo
 8+Zi9ACNglP9bENEtIPFmtgMSQswVQ4opATJ9GBHXp0LEBsD9AYxtflCSEjPRzpq1B5tRlxfq
 sEpZAlynoB3HxNEj4Gb/P15ok0VguJpatCLfpXoRV+kLoC5K+TvKiPi2ovoe5tN3n1UpniLB+
 bB0jnYSOAdopFwet6+69xJQjVYJ0xKQmURGAC0wbvSK6eJtL5njA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MV63q-1qCUK248IA-00S7qN; Sat, 02
 Sep 2023 02:40:21 +0200
Message-ID: <f7925e65-5d8a-43b4-962c-07e1050abaad@gmx.com>
Date:   Sat, 2 Sep 2023 08:40:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/282: skip test if /var/lib/btrfs isnt writable
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20230824234714.GA17900@frogsfrogsfrogs>
 <20230901193609.yy7isx4pv6ax4g2k@zlang-mailbox>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20230901193609.yy7isx4pv6ax4g2k@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jBPvYyGD1BTrWXETabrXcx0iAbGdKCtZ7C+8AIO43Ui8s3jSM6+
 gWkjVUpoROxD+qU/R3QoM7X2jGLDCidRwI/t3oi/+zjd5oE8MK3grp3c+WJyNelsTIuQNym
 WiLkDfYDL82su1BYNAkHPbLHARIwTZbo/ijm9Ell90cMC+Fg2nggeNX3tr804OuLZLL673I
 i6gvqflXdBi6TXxb6DjIQ==
UI-OutboundReport: notjunk:1;M01:P0:fILqIvsawPs=;7PgTK17iffuUXVbKXnvkL5wVE7H
 fqDDqpSv7gJIH6C7y+sWwGDTcsh/PNNeLTX71Y62Ir2MzOFVDFIcG5gRQtW1QWX7MYNmOlOBl
 Cmb1NU2Tu2sP9rhFDKzkq4YzDTd1RQgiNwUQ8GP+R+f6AISNuwO9hReUCIwn8U40rHkMHFfXZ
 YlIUiRYzrKPbpl6Jh01+N9qFe6tIZuBAu0TIZILNj80IuvQZMNy+cwQQBxwj4obCOVROdnifd
 a/krIi43ShicRplNpSb1kh1FrWhYgod2jvDDv6775RO2qq4OsBbl4JWqe3dK5NI+Dcomi2KRP
 HEqr6avA76zBBYXAS1flr+n1DasPNi6Hfeeo+3Ii1qIqnctFk62yWVAE3O2pvHWo6yOmpZNu4
 AouJGS0ItWRuj7NGRNoH0UFYMWgNBGDf5EoJNLowcU9jvfoeAUMfV7CjV+8qtL15Emt0Vndbv
 6TUUcf84rxd7wzluSWYaet6XFe2J1KoqXC6wkoMrk90ZZgFje2Mp9GTrRNJKC/PTJdKqmX7QP
 acBTyC76YGmpzqBXDWqmY1CUhUSxjx2sdYi5s1HZck0JUlh+qFiGMJWwHXSpO0s8rXrtW7HJv
 028BkeeBaJsKOEL1KfZqJH+f5Nh4FlXDk+uEtSw5veUAjD6K8y9fxBTgoEHuK/5L4rzT4rqeQ
 NvArfbt+lPqMn8+oJwBRFy05Nh0uhTBkVYFu5VVEV/Jw2czHwyIhTjiwL6O97IVEKj3z/6Num
 ocQlEENa5NwB4T6xAhnNZ375GxVx6P+cEUlrnOl9g371+qBYx0dwHH4Y+k4rTZQFhYTzbe80c
 72w38DgGEqMOVGMnbH9iSv+1TW6YxlbQcgnEDlc4Wboq/bfrvrqBlmpEmTQSJGWgWKda5MsRX
 LmQ4N7cRGX9eM4/Usoa70FHJHcvoeuzRhz78BuH8hqy0nX8GbGoTDD1E5A6t/3DgBBvvbDCXu
 mmIwoj5vd4yvhAEjgiPxIrp16RA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/2 03:36, Zorro Lang wrote:
> On Thu, Aug 24, 2023 at 04:47:14PM -0700, Darrick J. Wong wrote:
>> From: Darrick J. Wong <djwong@kernel.org>
>>
>> I run fstests in a readonly container, and accidentally uninstalled the
>> btrfsprogs package.  When I did, this test started faililng:
>>
>> --- btrfs/282.out
>> +++ btrfs/282.out.bad
>
> I can't merge this patch, it fails:
>
>    Applying: btrfs/282: skip test if /var/lib/btrfs isnt writable
>    error: 282.out: does not exist in index
>    Patch failed at 0001 btrfs/282: skip test if /var/lib/btrfs isnt writ=
able
>    ...
>
> How can you generate this patch with btrfs/282.out.bad?

It's the diff format in the commit message confusing "git am".

You can add extra space(s) in the commit message so that "git am" can
understand what's going on.

Thanks,
Qu
>
> Thanks,
> Zorro
>
>> @@ -1,3 +1,7 @@
>>   QA output created by 282
>>   wrote 2147483648/2147483648 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +WARNING: cannot create scrub data file, mkdir /var/lib/btrfs failed: R=
ead-only file system. Status recording disabled
>> +WARNING: failed to open the progress status socket at /var/lib/btrfs/s=
crub.progress.3e1cf8c6-8f8f-4b51-982c-d6783b8b8825: No such file or direct=
ory. Progress cannot be queried
>> +WARNING: cannot create scrub data file, mkdir /var/lib/btrfs failed: R=
ead-only file system. Status recording disabled
>> +WARNING: failed to open the progress status socket at /var/lib/btrfs/s=
crub.progress.3e1cf8c6-8f8f-4b51-982c-d6783b8b8825: No such file or direct=
ory. Progress cannot be queried
>>
>> Skip the test if /var/lib/btrfs isn't writable, or if /var/lib isn't
>> writable, which means we cannot create /var/lib/btrfs.
>>
>> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
>> ---
>>   tests/btrfs/282 |    7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tests/btrfs/282 b/tests/btrfs/282
>> index 980262dcab..395e0626da 100755
>> --- a/tests/btrfs/282
>> +++ b/tests/btrfs/282
>> @@ -19,6 +19,13 @@ _wants_kernel_commit eb3b50536642 \
>>   # We want at least 5G for the scratch device.
>>   _require_scratch_size $(( 5 * 1024 * 1024))
>>
>> +# Make sure we can create scrub progress data file
>> +if [ -e /var/lib/btrfs ]; then
>> +	test -w /var/lib/btrfs || _notrun '/var/lib/btrfs is not writable'
>> +else
>> +	test -w /var/lib || _notrun '/var/lib/btrfs cannot be created'
>> +fi
>> +
>>   _scratch_mkfs >> $seqres.full 2>&1
>>   _scratch_mount
>>
>>
>

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C9D7A573A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Sep 2023 04:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjISCHg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 22:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjISCHe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 22:07:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB3B10E
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 19:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695089244; x=1695694044; i=quwenruo.btrfs@gmx.com;
 bh=oWFr/IWslf1Z/e9dvPtOwXq36IEw1+97UatQTvsXpKs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=fA+5chWj9ILqk2MVwYOh5rHlLP/KHw+EGuYjJwUlxR4XqIYHvX2F0dxsBEnttojq6LnXSBIENef
 /8t+HX0Cths1Sd21sb08Acs8SPeGWqqF4DkOitXoIWc2MtD43CURnJqYIxMF2+QjB0pocFAwF1Ku8
 uVZgqh/YY8TywUOLmOrBjZehcXx1iPgy8yyE2DR8S72sV+YYl8cipqN0RB2rBQ1UT0kvWiEv2V2sl
 HckM4zLr1shbe/RQjEC6gPkyxf57aNXbL5RthIte/TrBIQWV5hcMZnmn/qtrkhaa9fZfERdFYqudv
 ge4vm/jhS9uHJN3q+YrF1mUgXFWCUtZ/NUgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTRMs-1r7ppP3b3s-00TlDn; Tue, 19
 Sep 2023 04:07:24 +0200
Message-ID: <b22174ff-55c9-45f9-96bb-3b83abfc9c85@gmx.com>
Date:   Tue, 19 Sep 2023 11:37:20 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] btrfs: extent_io: do extra check for extent buffer
 read write functions
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     Dan Carpenter <dan.carpenter@linaro.org>, wqu@suse.com,
        linux-btrfs@vger.kernel.org
References: <b07914e7-137c-4549-97cb-2a0c3e757a04@moroto.mountain>
 <20230915190047.GH2747@twin.jikos.cz>
 <fd5920d6-f56d-443a-8b03-4dc34d488b62@gmx.com>
 <20230918165730.GK2747@twin.jikos.cz>
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
In-Reply-To: <20230918165730.GK2747@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vw8wVnhVyLPVQNgOi8PefRx5fhoZG8ZMJx4mCQdHot9CDMUSrQE
 pA9C1Rgp/DkEFMnPg93Q1e1AUCL4SQjlgDR+llgN9BkNUPg4sFFxzRxu9W6aiP7rDZ9x5B+
 X5j67YTzdYhHZYF7D657ylS/IcGuzM0nnltah92QiZJKDFjcJAQVNMXHvztgEd6eVXaiQbY
 ZIwSg2xgvQb6ifE5MtVmw==
UI-OutboundReport: notjunk:1;M01:P0:mAGd4+3WhEM=;u0pzfiKP96NmDsHFx2jKZg35nKJ
 QKasNDbBG/LHlfJq4sGOV08IrWbGL8/fuSXlp8u5N6jaCV1MkkEIKkwaC0sIys5bVmKT0AhYG
 nlF7fqcbAvOUmmYbwfY/MD8m/xhJw0FGNI1ux/opq4HAMOYQDGoaF9m0qeNKcgzyJIJfLEVbA
 c/04LX56ptOI+g5GL/Anb0eamJByNrRlSpMO5haM4eITGYyWhvn/FREGj0zpPaTYWjbMkwuBp
 LVB7H8YX1Ai/75Zoah6XAqy8aO1sOg4e53MzNH11PiY4SagWaCWS57w4JedSFld10DW4TYT6r
 fNWaYwx3rN2oNIgpwF/6NkO2vF+JY1PAajD5qCPhsz6vU+1mNZ8rTBdpziSIrqWQY7mfKVOY7
 WRp2SZeAkHk5G3I5fZWYZIw7hezujPejzIQtI91swr4Gvx/P9REVJ9YIGy1/yTt+tOcE6IYLi
 F59mZC8/yGco+67NKsA11O/O8wu+G7bMl2bNCEubyZxXWwP7Z55ks3pJeiz2Mhwc61EuuFg8w
 bQJsiPsfRvcdfzkzmy43mWsnxnhSwkulfIo6CkDitWaAyo+5GaNsEyebV2btPYNIdg922YCJJ
 P7Joq8/lLlkwPInh5vYYHLdod3l2yQIR93YL2wc9VxsE6XKHzSjalyEDWEyMQeGKU/9JRTYUW
 8ZaugQQEt4xMyEFDpvXAxG4tdG+3sBiTaxBALaPTQWsaavENENcN+/QNJCDsQpAqLCK0UtVvG
 7iW8X/uc+5Cqwmn0jTeDnFLrU/DLi1BaDdyeM01Hqqo2aU1WI4qRaMno7lZiu30XqViLaFOuw
 kVbFElWLjPjotE8dXO5Ngc53Rau0F3yz5wwJbbPaXBqb1rjDrO1IpdHx8ZiFoiUuT15uKZLx/
 4GVY8Baxa76CP5bGO8dbjBoI4lC6I/9hoStKi0LKfrEo+Pd7WQskIGPRjcTrJRPHwJQ3VV+2l
 Gz1NXrLIA3hFURED+9JQWQF0cD0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/19 02:27, David Sterba wrote:
> On Sat, Sep 16, 2023 at 06:41:12AM +0930, Qu Wenruo wrote:
>>
>>
>> On 2023/9/16 04:30, David Sterba wrote:
>>> On Fri, Sep 15, 2023 at 10:10:13AM +0300, Dan Carpenter wrote:
>>>> Hello Qu Wenruo,
>>>>
>>>> The patch f98b6215d7d1: "btrfs: extent_io: do extra check for extent
>>>> buffer read write functions" from Aug 19, 2020 (linux-next), leads to
>>>> the following Smatch static checker warning:
>>>>
>>>> fs/btrfs/print-tree.c:186 print_uuid_item() error: uninitialized symb=
ol 'subvol_id'.
>>>> fs/btrfs/tests/extent-io-tests.c:338 check_eb_bitmap() error: uniniti=
alized symbol 'has'.
>>>> fs/btrfs/tests/extent-io-tests.c:353 check_eb_bitmap() error: uniniti=
alized symbol 'has'.
>>>> fs/btrfs/uuid-tree.c:203 btrfs_uuid_tree_remove() error: uninitialize=
d symbol 'read_subid'.
>>>> fs/btrfs/uuid-tree.c:353 btrfs_uuid_tree_iterate() error: uninitializ=
ed symbol 'subid_le'.
>>>> fs/btrfs/uuid-tree.c:72 btrfs_uuid_tree_lookup() error: uninitialized=
 symbol 'data'.
>>>> fs/btrfs/volumes.c:7415 btrfs_dev_stats_value() error: uninitialized =
symbol 'val'.
>>>>
>>>> fs/btrfs/extent_io.c
>>>>     4096  void read_extent_buffer(const struct extent_buffer *eb, voi=
d *dstv,
>>>>     4097                          unsigned long start, unsigned long =
len)
>>>>     4098  {
>>>>     4099          void *eb_addr =3D btrfs_get_eb_addr(eb);
>>>>     4100
>>>>     4101          if (check_eb_range(eb, start, len))
>>>>     4102                  return;
>>>>                           ^^^^^^^
>>>>
>>>> Originally this used to memset dstv to zero but now it just returns.
>>>> I can easily just mark that error path as impossible.  These days
>>>> everyone with a brain zeros their stack variables anyway so it should=
n't
>>>> affect anyone who doesn't deserve it.
>>>
>>> Thanks, this explains the other errors reported on linux-next with
>>> possibly uninitialized variables.
>>
>> Mind me to fix those uninitialized variables?
>> Or should I just revert to the old behavior?
>
> I'd like to keep the branch in for-next so please fix the warnings.

Unfortunately these warnings are not complete.

I checked all the read_extent_buffer() callers, almost all of them needs
some initialization.

One example in split_item() of ctree.c:

static noinline int split_item()
{
	char *buf;

	buf =3D kmalloc();
	read_extent_buffer(leaf, buf, );
}

In above case, if the read range is invalid, then @buf is just garbage.

I'm not sure if we should fix all call sites, it looks a little
impractical (over 70 call sites).

Thus I'd prefer to reset the target memory to zero if the range is invalid=
.

> Also
> please s/continuous/contiguous/. We can then continue the discussion
> regarding the allocator behaviour.

I guess you're talking about the extent buffer allocator (going vm
mapped memory to skip cross-page handling).
However this patch is years old and already in upstream.

Thanks,
Qu

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01C77931E4
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 00:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjIEWTm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 18:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjIEWTm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 18:19:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00383FA
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 15:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693952375; x=1694557175; i=quwenruo.btrfs@gmx.com;
 bh=iuxXolzv1lyh0FfvCIoK6+Jh33ZNTrxXKv8GrJ2Q+3c=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ogaxraWPTAW32XlrYCWo7x628GQAMx9XVmgs+GaxbUUA1URJFmSWR+b4LJq/sham6GR3joI
 E/rUmng8Bymy5x0f+8iwqrZTT1E5tAH/81MocJYIpzO0pn/Lf9JhODFt9KR69qFWVtdR15I9o
 kYVV7OKBBAlZgkM3Eka/O81bDelZF5PjkcQcvzPHgVtMzVJrd2Q0f9BgngCmHhX1XeoMOGWVa
 u40U/ksmNmmwSsLtHxxt5r79viwg39YAFwy6hRQPQL+4hf5Kr7osub2aY7clqvCICiiSeav1n
 ZwL+OWFFKvnBmFZufzFfOmn+vKcLRYpD/bdhWw2SBmgSkA/Yd/WQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTiTt-1qE6cV2dBt-00U4Jv; Wed, 06
 Sep 2023 00:19:35 +0200
Message-ID: <2c59efaf-f46a-4ab4-9360-a64917267c2d@gmx.com>
Date:   Wed, 6 Sep 2023 06:19:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: qgroup: prealloc btrfs_qgroup_list for
 __add_relation_rb()
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <ca35f1e6134d6e14abee25f1c230c55b1d3f8ae0.1693534205.git.wqu@suse.com>
 <20230905124610.GW14420@twin.jikos.cz>
Content-Language: en-US
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
In-Reply-To: <20230905124610.GW14420@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6c3KvKKfgq/2AVQ8ZTkOsICWvEp+mz46bcnTNnvb1xv5RjI98tW
 Kp5ots7XZrAo7IpqTQ7zjsyvYQMI/QOWPB8izW51Tx2WDKYvYQAskaaoRq/AaPCMAQki5iW
 Vrv/nptiKLPvm8G2A2R4ONaWMwrkX0In8IRW4cszh5OxcY3cv5QwvcSjH9K5jZOkCzGknpF
 gSQPtXKy/c2GrK0b31k5g==
UI-OutboundReport: notjunk:1;M01:P0:oXcuc37c5w0=;fR6jiIcyAZ/wZ+gSGcMYC1Q6dlt
 6p6t7Ta8PCmHNGI3px9ir7b65lMEEZC6OhJ9E5T7HhpwR2rorrDImRQaPVFoBQNXYa4sUisgF
 uPi3cdkeqCH6y5FUH21Pc4FK91i6K5xYlwjdkjowJuCFo/09Sl0FWMTsvaFF0wupHCK5wYXva
 5C7Jcku0bUIdA/aU9d4J155spOIwEnaWCFX0hS5QBIf4jDGIqoONje/whGIRSgOR2EwnjHQID
 SNh1uvoljSXWXGcKWFI5ePbnWhlcvYU0vOJUO9px8+2VaR3EB8mpmbUF83DQvWvrQhfGx2hHW
 nS7DSJ1BJ6TuHgiMRol7bdIsJH5XqNg7SVLq/R0UDYqM+y72je8r1uq2WF7o08yl98+4+soqz
 6H1mpAmoi6lEDLrFFJ3Bm8Pzy53ADoabo8iiJWmZyAfX5kZuBJ6NpYXupKzO5gp4f+TafUp2v
 OlC0Q917UufSsPmfVXGYmMRDtuRQQJr8ZU/ck2FOq/XaQIPz+Sscumvd/le6ZqTCnXrSs51SO
 by6uHjfYtERVU13Vi3yANIdWjbn/O7KFrff1NnOoWnOlB6rPM01Uj9nEHKTrgiGiedbDrIXwA
 ZkWPtLmX74xlzHO9A/H9S2YuAkPTyQmJHJoLzKsph9YQcx6qaYoCZRRjnwOudI06I1199ZFkR
 DBt5Jqpv4hBh9JkkL5f9lniDjvA29S9Qv9VcQX1tEHdm4tMfBU//wuqSz7O2DXHRNK4w7O3w7
 i9LAlygL1KjPmh0m6pCeKopZyNHkl/6thpvtfnoVnPFAgaOX0EQkEYF7AHblqFxEt3H3tuNTO
 vudp+mrXdNJcqkZhArnhSYR5g8RjciWpyzIaDhtOl8uBmSul9J1pi3BXZzY0Wc537h/LvWefU
 VL+Ybg8M5asQ5/PPToDlZtRUr3x2XboVJrSEod7GECI6ZkIzclOAOszkGNfVKpFxT7YGjmST8
 8DsgUZ5M28rrwGf7dle+sA9ZYOw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/5 20:46, David Sterba wrote:
> On Fri, Sep 01, 2023 at 10:11:16AM +0800, Qu Wenruo wrote:
>> Currently we go GFP_ATOMIC allocation for qgroup relation add, this
>> includes the following 3 call sites:
>>
>> - btrfs_read_qgroup_config()
>>    This is not really needed, as at that time we're still in single
>>    thread mode, and no spin lock is held.
>>
>> - btrfs_add_qgroup_relation()
>>    This one is holding spinlock, but we're ensured to add at most one
>>    relation, thus we can easily do a preallocation and use the
>>    preallocated memory to avoid GFP_ATOMIC.
>>
>> - btrfs_qgroup_inherit()
>>    This is a little more tricky, as we may have as many relationships a=
s
>>    inherit::num_qgroups.
>>    Thus we have to properly allocate an array then preallocate all the
>>    memory.
>>
>> This patch would remove the GFP_ATOMIC allocation for above involved
>> call sites, by doing preallocation before holding the spinlock, and let
>> __add_relation_rb() to handle the freeing of the structure.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> This does not seem to apply cleanly on anything recent, neither master,
> misc-next (with unrelated patches) or the series cleaning GFP_ATOMIC
> from qgroups. The last mentioned series looks good so far so I'm about
> to merge it soon so you can then refresh this patch on top of that.

That's a little weird, as this patch is the last one from my
qgroup_mutex branch.

And this patch doesn't really touch anything from the qgroup iterator
part, thus I don't know why it doesn't apply cleanly.

But for sure, I can refresh it when needed.

Thanks,
Qu

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D25558B5C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 00:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiFWWqN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 18:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiFWWqM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 18:46:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4A72F037
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 15:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656024366;
        bh=nRc0l9asNm+daYXEG5iARyfIxMd4MdYd1FqMjwACDJk=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=TRXyER3Tdwm2199l5vFBYsav3uueMIwIcajQcdNrU12EuCY0uAXMaDIWFeNYaSYpk
         udSk8HXhACtF42dZqjPDTc+Kuhne0tOSINSKD3WMf2xCXqEzAebGmfKyC4OgHpynmP
         f4pK9wp+Cw1Y6yzUgRQ4fR6WzyRQ+9VstcEVxZAs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6Daq-1o2JjJ1wsa-006bJq; Fri, 24
 Jun 2022 00:46:06 +0200
Message-ID: <7a42092f-9534-e54c-174e-8aaf17509d4b@gmx.com>
Date:   Fri, 24 Jun 2022 06:46:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220623080858.1433010-1-nborisov@suse.com>
 <56e24cb5-c085-3b17-203e-56007008a8ae@gmx.com>
 <20220623141954.GP20633@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Criteria for mount messages. (was "Re: [PATCH] btrfs: remove skinny
 extent verbose message")
In-Reply-To: <20220623141954.GP20633@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VNGU0JWx3G9vpzCZlA21t5G8FNPde9h9jKG5jmGKsKMGLdUjnTH
 rIbIgeSNLxkjize8aNGfUJKpwgjJWOhpOn8ive73kP3SUGJhR5LdXfWLe71qicihKYMa4ch
 4LxgC9Ar8HISkD+6WIgLoqZI+uOIF2MEBtHh3IZQAQGTIKZSI36Zb3kU45kSxPTpZQBTh2/
 q7x43yjHAnEtqVBR3m2Gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kWkNaN6vFyk=:kynsVmCPejs65sOvDtkyoW
 cKCZv9bHXWS0o5JLRJB3gYoeGuMnO/nbBQQDhYXYsvDaQ/rsyDg4L4tW/7OofCYmolpATy2hE
 dsYb6EquBX24PDr6DwdHejEaIB8Ip0E5iEAK5MNX9H35pJJH/Hl+FM9EmYj7f9tQS0PuV1WOH
 riuCJnN7tHf/jchU3uYhJLH32L7KCtjJO6qBBQp0rRZc7vMxnvA7hSGympMtn0fzscNgPNhDe
 p6BjvwyinnXv2MWZ1b6RvBj3q5/bjyw3BNLJiZ9zeGGSovUT7JDZNk5SRqAcp7v8xQL5m3Vqh
 k9YE8uftTVOFyKwDnq96rp9AUvllks6ZbtmApabO2XOspvHM8YWj3ZI7c5zuIdSipjQolBg3U
 veV3sX0MT6Hva2S1XOJ4EocNnt7hi/EKaJDrl1i1TBI+MkZzLrXbzVatapP12MJ8gNK3gLfnE
 gaHEWLpgqFx+UcNI6BJPeTlUOanNjwOxIm+2wtgiqi4JsWCHImb6gKaTm2itCZ7xf4pb1u+qY
 drSU82fsqFoZCjXI2NLK9j2tNNCp++N/qRqAgcYN/7aqzrXyYabrxTw3KtiNcq/+B956wBnR4
 DRemaC8rJeB2ctBiplgvS3fA5S4p5AJ8XCQG5T286hXoY19PeNm8UoLFoN9hBQ43TFIomYMva
 wbReSGQ+/TWuW1zqcwn+9BpNSQfi4LhJ2T/DV5E6cbp/9kTOPM7mLuf3Qk6Zxcr9iAPQhFubn
 eC4s8sZWdxvB23SqNBy3GTIZB2HkOKBh+iqP4rM2ic4mLTF/K9D+QobuIMMSH6jUVMNoOIqKb
 lkUbKh+nh+Ac1IRYZNhnV0FMBVGS5yiH3uxWPo3J+v9xKiwjusZluDO8YWJCBWtwnWfQIgvxy
 AWIBsdPgxQPjp8Sm9GeRNeR5d/9iWMULgE66NnOeKqBHo7/bcFF/Jb/Q5+r5a+bDxlF4SrmFt
 UW6R3jtp9L+AmofaSqQrK91i3Qkfy8BOKw00IzJO6SHEN+npsMCxCTIDXlHUStVAbUA7JMRFC
 bpBQ9njWfCd8yt+Hmjd2b6OiFctk4dDxjjBYsl42d2ErjCY1QwXgw/upUCPDaRiati/+KsoJv
 EBccKJ8DPQ3WKWNtsk6i5gfDe2+jxkke8hahnxScJHbvDrIl8RVG+8JXw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/23 22:19, David Sterba wrote:
> On Thu, Jun 23, 2022 at 04:22:27PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/6/23 16:08, Nikolay Borisov wrote:
>>> Skinny extents have been a default mkfs feature since version 3.18 i
>>> (introduced in btrfs-progs commit 6715de04d9a7 ("btrfs-progs: mkfs:
>>> make skinny-metadata default") ). It really doesn't bring any value to
>>> users to simply remove it.
>>>
>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>
>> Looks fine to me.
>>
>> But this means we need to define the level of (in)compat flags we want
>> to show in the dmesg.
>
> Yes and we haven't done that so far so we should have some guidelines.
>>
>> By default, we have the following lines:
>>
>>    BTRFS info (device loop0): flagging fs with big metadata feature
>>    BTRFS info (device loop0): using free space tree
>>    BTRFS info (device loop0): has skinny extents
>>    BTRFS info (device loop0): enabling ssd optimizations
>>    BTRFS info (device loop0): checking UUID tree
>>
>> For "big metadata" it's even less meaningful, and it doesn't even have
>> sysfs entry for it.
>
> There's an entry in the global features but 'big_metadata' does not
> appear in the per-filesystem directory.
>
>> For "free space tree" it may be helpful, but if one is really concernin=
g
>> about the cache version we're using, it's better to go sysfs other than
>> checking the kernel dmesg.
>
> The logged messages are a bit different as they could be stored and then
> used for analysis. For new features it makes more sense to log them, I
> think eg. the free space tree messages have been useful when debugging
> the online conversion that took a few patches to get right.
>
>> For "SSD", it's a good thing to output.
>
> Agreed.
>
>> For "UUID" tree, it's definitely not useful, even for developers.
>
> Agreed.
>
>> For skinny metadata it's the one you're cleaning.
>
> Though I've sent patch to make it only debug I agree that this has
> little value and don't object to removing it completely.
>
>> So I guess you can clean up more unnecessary mount messages then?
>
> The criteria I'd use for adding/removing the messages are vaguely like
> that:
>
> - does the user want to know a particular feature is in use? this is
>    namely when we're introducing something and want to verify what's
>    happening

I'd say this is not that important.

In fact, there is a pretty bad example from the past, BIG_METADATA.

It's just we're supporting larger nodesize, it doesn't even bother users
that much, nor really need a incompat flag at all.

Another example is from recent subpage feature, it doesn't need any
incompat/compat RO flags at all, the only reason we're outputting
message for subpage is, it's not tested as much as native page size.

If we can ensure enough test coverage (already getting better and better
coverage) that experimental message would definitely go away.


Thus my idea criteria would be:

- Would this feature bring bad impact to end users?
   If the feature is only bringing good impact, it should not be output.

   Thus in this way, v2 cache nowadays should also be skipped, as it's
   already well tested, and no real disadvantage at all.

>
> - can the option have an impact on the filesystem behaviour?  eg. like
>    ssd, but we tend to log almost all mount options already
>
> - if there's a value for developer, the level should be debug, otherwise
>    info

I'd say, considering how hard to enable debug messages, it doesn't
really make much sense for developers.

Thus unfortunately such debugging info would still better to be at info
level, just in case it's something like dying message and/or the user
can not easily reproduce it.

But we may want a much shorter (even it means less human readable), less
noisy output.

Thus I'd say, we may want to output hex incompat/compat RO/compat flags
just in one line during mount, instead of current one feature per-line
behavior.

By this, it provides more debug info, but still way shorter, and way
more expandable.

Thanks,
Qu
>
> - remove messages if a feature is on by default for a long time and does
>    not bring any other value, eg. the mixed_backref, big_metadata or
>    skinny extents;
>    the respective sysfs files may need to stay as they could be used for
>    runtime detection even after a long time, eg. in some testsuite
>    collecting testcases over time but likely not updating them, removal
>    should be done on case-by-case basis

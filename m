Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFA4267C42
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Sep 2020 22:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgILUg1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Sep 2020 16:36:27 -0400
Received: from mailrelay4-3.pub.mailoutpod1-cph3.one.com ([46.30.212.13]:63551
        "EHLO mailrelay4-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgILUg1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Sep 2020 16:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=wuL3aBwIjodg3K7712d+eEPPWSQ0n+IltBFPoh2zz5U=;
        b=CTwQ6Fya1lo9z05/h8m19k3eJYf4sNAzqFY9mj+vRckjbsuzFlVNUbyifinsq59Evt/i7pKeExgIM
         fjfKgv4gUma50LsgWYQ/bvsE5iuAD1zJzCTuh06PxN3kdKYtUFUwtwag4eHk6Wz5+ml8I7ySVQUc0V
         m2y6KFCWHUNCKa0XeCTvB5Ml26NDzRNUruWbYhTebtF+eokBiAKLYOxR/6eeLahNbXSc/AK7iPd7wF
         IakD/KA88BnxyvW7rAuTTPcAY7FvV8YOQlid4DL/Jw2Ie00xUxBMsIHh7upmbCc42eKdmnY15oXPL+
         x/KVJDDraxDHULcmX0wKDxgxx9B0rTA==
X-HalOne-Cookie: 3218d5c2081d8188aeb3adb5771faead4ca763a8
X-HalOne-ID: 9f853089-f537-11ea-a2a9-d0431ea8bb10
Received: from [192.168.0.10] (h-131-138.a357.priv.bahnhof.se [81.170.131.138])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 9f853089-f537-11ea-a2a9-d0431ea8bb10;
        Sat, 12 Sep 2020 20:36:23 +0000 (UTC)
Subject: Re: Changes in 5.8.x cause compsize/bees failure
To:     fdmanana@gmail.com, Oliver Freyermuth <o.freyermuth@googlemail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <632b888d-a3c3-b085-cdf5-f9bb61017d92@lechevalier.se>
 <dccf4603-ee16-37e0-11b2-d72f8956a74b@googlemail.com>
 <CAL3q7H4s1W33DovgTJRAr3qTh+wjPZqbiHUjmvPMqQ=rce8YMQ@mail.gmail.com>
From:   A L <mail@lechevalier.se>
Message-ID: <dd56f3c9-000f-52b3-b290-1db2ad9b7d3a@lechevalier.se>
Date:   Sat, 12 Sep 2020 22:36:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4s1W33DovgTJRAr3qTh+wjPZqbiHUjmvPMqQ=rce8YMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-09-12 21:45, Filipe Manana wrote:
> On Sat, Sep 12, 2020 at 6:27 PM Oliver Freyermuth
> <o.freyermuth@googlemail.com> wrote:
>> Am 12.09.20 um 19:13 schrieb A L:
>>> I noticed that in (at least 5.8.6 and 5.8.8) there is some change in Btrfs kernel code that cause them to fail.
>>> For example compsize now often/usually fails with: "Regular extent's header not 53 bytes (0) long?!?"
>> I noticed the same after upgrade from 5.8.5 to 5.8.8 and reported it to compsize:
>>   https://github.com/kilobyte/compsize/issues/34
>> However, since it's userspace breakage, indeed it's probably a good idea to also report here.
>>
>> Since you see it with 5.8.6 already and I did not observe it in 5.8.5, this should pin it down to the 5.8.6 patchset.
>> Sadly, I don't have time at hand for a bisect at the moment, and at first glance, none of the commits strikes me in regard to this issue (I don't use qgroups on my end).
>>
>>> Bees is having plenty of errors too, and does not succeed to read any files (hash db is always empty). Perhaps this is an unrelated problem?
>>>
> Can any of you try the following patch and see if it fixes the issue?
>
> https://pastebin.com/vTdxznbh
>
> Thanks.

I applied the patch on kernel 5.8.8-gentoo and it fixed my problems with 
both bees and compsize.

Thanks Filipe!

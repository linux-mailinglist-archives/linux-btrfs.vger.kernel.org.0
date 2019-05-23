Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB7628522
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2019 19:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbfEWRlR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 May 2019 13:41:17 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:56109 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731195AbfEWRlR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 May 2019 13:41:17 -0400
Received: by mail-it1-f195.google.com with SMTP id g24so4251069iti.5
        for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2019 10:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6sTHKNGRuM/VnYKyuBelJXMR+E+nqM5Lt5CLox7BkBY=;
        b=cKlOOFIsajacGQ7A75qCS+iFU0XLFGVokAwIVgOb3XgUAH3iGhlY5EgMJ1pH33wIfh
         gn4oUxDUPSvIE0MK/9SZeeLUtSjt2OQw6wiCPVNxOroDOg6q5QVGFK+umFA9jmmyA36b
         8GTfDOwKD+9qzYaJmujNS9onfHXVLTnb3XS3mPj5Hb7U9spmXZhpk5bRVg3cufnaw5z6
         cXSfx+kdqxTRQdDSx/ue3BzD2rMyiF8hKsSSeQ0KaG7Iud8Z8cnYS33jCbmhbsw3zDQc
         T+pP5I0965USSU5xmeIzMDpA01lbQqi+RChuPaGdMZTV6C8/DWigKrAJgHifcj30TKMz
         Atrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6sTHKNGRuM/VnYKyuBelJXMR+E+nqM5Lt5CLox7BkBY=;
        b=jgv1PPY4gPntt+ov97PVuyUUV93g4McZG6UHTHmraHyU0vtEnpHghSfYV9qpLA5XrF
         zAYmvm1kZs5tMaeprIKCzkl3XCkq0j5TV+Lq/9VFCNBDpVfHqAtVAkmwYkasyf/qNMfS
         JE22La+lv7vmLhknvLSMCKB90JYw63Eyipgg0Bg0/SfxYJUT/nNMs7qjuVGNFtV5NrDV
         xJaR6/zDBKWmm/lYsqfJ04tN/U6ZQTuNl5YPKzGup1Bu8PLW71mFt3Z/gIgdvIkoXZPG
         dtAQrq6+z5NCUPsV5U/ICcoAUGATI3J+V/dqUUi0HnMR6xcRoidF2ltCiHUyK8GINqmk
         qSlA==
X-Gm-Message-State: APjAAAUQr3SN0sDwUzm8/smxs372e+SoJTQtmJ8n0VURDP77s2S84xZ4
        BXPZiGTX1YJJg8AnfiVDUXG55qwcMbtnjg==
X-Google-Smtp-Source: APXvYqzrvUZRGI4eoCKY3hQaWNpMp89zpJv0OLsEDQnIQIZDwzj5kb06zf66eucOvzWlICeQEB8aJw==
X-Received: by 2002:a02:cb50:: with SMTP id k16mr8565579jap.38.1558633275855;
        Thu, 23 May 2019 10:41:15 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id j125sm54908itb.27.2019.05.23.10.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 10:41:15 -0700 (PDT)
Subject: Re: Citation Needed: BTRFS Failure Resistance
To:     Martin Raiber <martin@urbackup.org>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAN4oSBeEU+rmCS8+WwriGz0KoPR=Xa6KvjH=gGriFaxVNZHf6Q@mail.gmail.com>
 <8ccec20a-04b1-4a84-6739-afd35b4ab02e@gmail.com>
 <CAJCQCtTp5d+VxsQmVv68VdmCsxSVpi-_c6LJjS_T=xx3GXz9Fg@mail.gmail.com>
 <979559b5-1fb5-debd-e101-6e4227348426@gmail.com>
 <0102016ae5bf1e51-7cedfda5-aff2-4ecb-801b-ec8c04ce84b5-000000@eu-west-1.amazonses.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <2ef383f2-7d70-406c-eb60-6d45a6f8f86f@gmail.com>
Date:   Thu, 23 May 2019 13:41:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0102016ae5bf1e51-7cedfda5-aff2-4ecb-801b-ec8c04ce84b5-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-05-23 13:31, Martin Raiber wrote:
> On 23.05.2019 19:13 Austin S. Hemmelgarn wrote:
>> On 2019-05-23 12:24, Chris Murphy wrote:
>>> On Thu, May 23, 2019 at 5:19 AM Austin S. Hemmelgarn
>>> <ahferroin7@gmail.com> wrote:
>>>>
>>>> On 2019-05-22 14:46, Cerem Cem ASLAN wrote:
>>>>> Could you confirm or disclaim the following explanation:
>>>>> https://unix.stackexchange.com/a/520063/65781
>>>>>
>>>> Aside from what Hugo mentioned (which is correct), it's worth
>>>> mentioning
>>>> that the example listed in the answer of how hardware issues could
>>>> screw
>>>> things up assumes that for some reason write barriers aren't honored.
>>>> BTRFS explicitly requests write barriers to prevent that type of
>>>> reordering of writes from happening, and it's actually pretty
>>>> unusual on
>>>> modern hardware for those write barriers to not be honored unless the
>>>> user is doing something stupid (like mounting with 'nobarrier' or using
>>>> LVM with write barrier support disabled).
>>>
>>> 'man xfs'
>>>
>>>          barrier|nobarrier
>>>                 Note: This option has been deprecated as of kernel
>>> v4.10; in that version, integrity operations are always performed and
>>> the mount option is ignored.  These mount options will be removed no
>>> earlier than kernel v4.15.
>>>
>>> Since they're getting rid of it, I wonder if it's sane for most any
>>> sane file system use case.
>>>
>> As Adam mentioned, it's mostly volatile storage that benefits from
>> this.  For example, on the systems where I have /var/cache configured
>> as a separate filesystem, I mount it with barriers disabled because
>> the data there just doesn't matter (all of it can be regenerated
>> easily) and it gives me a few percent better performance.  In essence,
>> it's the mostly same type of stuff where you might consider running
>> ext4 without a journal for performance reasons.
>>
>> In the case of XFS, it probably got removed to keep people who fancy
>> themselves to be power users but really have no clue what they're
>> doing from shooting themselves in the foot to try and get some more
>> performance.
>>
>> IIRC, the option originally got added to both XFS and ext* because
>> early write barrier support was a bigger performance hit than it is
>> today, and BTRFS just kind of inherited it.
> 
> When I google for it I find that flushing the device can also be
> disabled via
> 
> echo "write through" > /sys/block/$device/queue/write_cache
Disabling write caching (which is what that does) is not really the same 
as mounting with 'nobarrier'.  Write caching actually improves 
performance in most cases, it just makes things a bit riskier because of 
the possibility of write reordering (which barriers prevent).
> 
> I actually used nobarrier recently (albeit with ext4), because a steam
> download was taking forever (hours), when remounting with nobarrier it
> went down to minutes (next time I started it with eatmydata). But ext4
> fsck is probably able to recover nobarrier file systems with unfortunate
> powerlosses and btrfs fsck... isn't. So combined with the above I'd
> remove nobarrier.
> 
Yeah, Steam is another pathological case actually, though that's mostly 
because their distribution format is generously described as 
'excessively segmented' and they fsync after _every single file_.  If 
you ever use Steam's game backup feature, you'll see similar results 
because it actually serializes the data to the same format that is used 
when downloading the game in the first place.

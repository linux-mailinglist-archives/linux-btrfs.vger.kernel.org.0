Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4129714E45C
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 21:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgA3U7g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 15:59:36 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33518 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3U7g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 15:59:36 -0500
Received: by mail-qk1-f193.google.com with SMTP id h23so4456317qkh.0
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2020 12:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ixGw1ywlyIk5qysx1Siang/5JmKN1PqUKZn4iT+jYg8=;
        b=1Dgr2dnj152ToMcT/dwB8+N88+gA770EFePW0LkV4lZNAD+7sntmwZ38LBpngo/SPo
         LZ5oIWxs58bG24UtCR8Uyznb4j4MqOctjJPliYHDhTL8uEQlBkN6ftaVVoJvB0dvDNar
         mNuRn7pXYCGlDMTVJGWZ9qzwxYTdhgoPSmgcW6w+KUUbJsZrqnkeD6s5LdwGZFa8HGNO
         Qy32VskgSFXlMRUNuaW0HEI71GF4gnk11zhAgsIOSRDwnR8VSK7sfMbEGeJRSxy9wUYd
         oplhy6qpGjWhUfN55/UE/d9gauXEx+euBrQOFu+R9XtNX3341+1Umn1d1+S0UKs4Cme9
         OgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ixGw1ywlyIk5qysx1Siang/5JmKN1PqUKZn4iT+jYg8=;
        b=NWh6EUCJEd1qW6a5TlisDAYD6n9dIHIaKzilsU/HY1ccyQinb369GxEPyhezW6UfES
         5pOCTX1cCJb+zzUI8Ke4hoSOc9RUZ8ANrMg9n6z/nQp0HIjgZkmK76ncwTc1q/3Z7Elm
         3UrpbrrhGyjrSVYLZhKJQREjXQD5haXkO5FbkqFidfMtAP+IoDzdgYOxHnD3rPpIgh/6
         hSXsd8mf7gLDw8zxc34hQmz9+AABPsZ8WlTNIMwmf3epLllEnJ03AlxvYaW/QlOOEdqG
         DTjA8w6r/JFMIhPK/obCmmoOqTCeO/65JYODg4w/v+RfgbT1UcKcg2rKj5fRrQ4a6hR3
         OtHA==
X-Gm-Message-State: APjAAAVGbFGgFi1CP3tSB6gwGMJXiURwczZbq+KTRzhNpFs1dSMOxKOL
        YeEu1oPzntJAKjymoPaWOnNvKOcq1rcm5Q==
X-Google-Smtp-Source: APXvYqyIlVul+9IdO3TcWu0C9pViBhBoL9c5WjKbKOvOZuTQ4yzDcFEdPkioDT3U8tB78NJsreikyQ==
X-Received: by 2002:a05:620a:796:: with SMTP id 22mr7139498qka.419.1580417972932;
        Thu, 30 Jan 2020 12:59:32 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e13sm3684168qtq.26.2020.01.30.12.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 12:59:32 -0800 (PST)
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
To:     Chris Murphy <lists@colorremedies.com>,
        Martin Steigerwald <martin@lichtvoll.de>
Cc:     Martin Raiber <martin@urbackup.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <112911984.cFFYNXyRg4@merkaba> <10361507.xcyXs1b6NT@merkaba>
 <CAJCQCtQgqg2u78q2vZi=bEy+bkzX48M+vHXR00dsuNYWaxqRKg@mail.gmail.com>
 <21104414.nfYVoVUMY0@merkaba>
 <CAJCQCtSgK1f3eG5XzaHmV+_xAgPFhAGvnyxuUOmGRMCZfKaErw@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ab7f3087-7774-7660-1390-ba0d8e6d7010@toxicpanda.com>
Date:   Thu, 30 Jan 2020 15:59:31 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSgK1f3eG5XzaHmV+_xAgPFhAGvnyxuUOmGRMCZfKaErw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/30/20 3:18 PM, Chris Murphy wrote:
> On Thu, Jan 30, 2020 at 1:02 PM Martin Steigerwald <martin@lichtvoll.de> wrote:
>>
>> Chris Murphy - 30.01.20, 17:37:42 CET:
>>> On Thu, Jan 30, 2020 at 3:41 AM Martin Steigerwald
>> <martin@lichtvoll.de> wrote:
>>>> Chris Murphy - 29.01.20, 23:55:06 CET:
>>>>> On Wed, Jan 29, 2020 at 2:20 PM Martin Steigerwald
>>>>
>>>> <martin@lichtvoll.de> wrote:
>>>>>> So if its just a cosmetic issue then I can wait for the patch to
>>>>>> land in linux-stable. Or does it still need testing?
>>>>>
>>>>> I'm not seeing it in linux-next. A reasonable short term work
>>>>> around
>>>>> is mount option 'metadata_ratio=1' and that's what needs more
>>>>> testing, because it seems decently likely mortal users will need
>>>>> an easy work around until a fix gets backported to stable. And
>>>>> that's gonna be a while, me thinks.
>>>>>
>>>>> Is that mount option sufficient? Or does it take a filtered
>>>>> balance?
>>>>> What's the most minimal balance needed? I'm hoping -dlimit=1
>>>>
>>>> Does not make a difference. I did:
>>>>
>>>> - mount -o remount,metadata_ratio=1 /daten
>>>> - touch /daten/somefile
>>>> - dd if=/dev/zero of=/daten/someotherfile bs=1M count=500
>>>> - sync
>>>> - df still reporting zero space free
>>>>
>>>>> I can't figure out a way to trigger this though, otherwise I'd be
>>>>> doing more testing.
>>>>
>>>> Sure.
>>>>
>>>> I am doing the balance -dlimit=1 thing next. With metadata_ratio=0
>>>> again.
>>>>
>>>> % btrfs balance start -dlimit=1 /daten
>>>> Done, had to relocate 1 out of 312 chunks
>>>>
>>>> % LANG=en df -hT /daten
>>>> Filesystem             Type   Size  Used Avail Use% Mounted on
>>>> /dev/mapper/sata-daten btrfs  400G  311G     0 100% /daten
>>>>
>>>> Okay, doing with metadata_ratio=1:
>>>>
>>>> % mount -o remount,metadata_ratio=1 /daten
>>>>
>>>> % btrfs balance start -dlimit=1 /daten
>>>> Done, had to relocate 1 out of 312 chunks
>>>>
>>>> % LANG=en df -hT /daten
>>>> Filesystem             Type   Size  Used Avail Use% Mounted on
>>>> /dev/mapper/sata-daten btrfs  400G  311G     0 100% /daten
>>>>
>>>>
>>>> Okay, other suggestions? I'd like to avoid shuffling 311 GiB data
>>>> around using a full balance.
>>>
>>> There's earlier anecdotal evidence that -dlimit=10 will work. But you
>>> can just keep using -dlimit=1 and it'll balance a different block
>>> group each time (you can confirm/deny this with the block group
>>> address and extent count in dmesg for each balance). Count how many it
>>> takes to get df to stop misreporting. It may be a file system
>>> specific value.
>>
>> Lost the patience after 25 attempts:
>>
>> date; let I=I+1; echo "Balance $I"; btrfs balance start -dlimit=1 /daten
>> ; LANG=en df -hT /daten
>> Do 30. Jan 20:59:17 CET 2020
>> Balance 25
>> Done, had to relocate 1 out of 312 chunks
>> Filesystem             Type   Size  Used Avail Use% Mounted on
>> /dev/mapper/sata-daten btrfs  400G  311G     0 100% /daten
>>
>>
>> Doing the -dlimit=10 balance now:
>>
>> % btrfs balance start -dlimit=10 /daten ; LANG=en df -hT /daten
>> Done, had to relocate 10 out of 312 chunks
>> Filesystem             Type   Size  Used Avail Use% Mounted on
>> /dev/mapper/sata-daten btrfs  400G  311G     0 100% /daten
>>
>> Okay, enough of balancing for today.
>>
>> I bet I just wait for a proper fix, instead of needlessly shuffling data
>> around.
> 
> What about unmounting and remounting?
> 
> There is a proposed patch that David referenced in this thread, but
> it's looking like it papers over the real problem. But even if so,
> that'd get your file system working sooner than a proper fix, which I
> think (?) needs to be demonstrated to at least cause no new
> regressions in 5.6, before it'll be backported to stable.
> 
> 

The file system is fine, you don't need to balance or anything, this is purely a 
cosmetic bug.  _Always_ trust what btrfs filesystem usage tells you, and it's 
telling you that there's 88gib of unallocated space.  df is just wrong because 5 
years ago we arbitrarily decided to set b_avail to 0 if we didn't have enough 
metadata space for the whole global reserve, despite how much unallocated space 
we had left.  A recent changed means that we are more likely to not have enough 
free metadata space for the whole global reserve if there's unallocated space, 
specifically because we can use that unallocated space if we absolutely have to. 
  The fix will be to adjust the statfs() madness and then df will tell you the 
right thing (well as right as it can ever tell you anyway.)  Thanks,

Josef


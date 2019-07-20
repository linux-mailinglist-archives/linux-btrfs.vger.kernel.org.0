Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35C976EF24
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jul 2019 12:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfGTK73 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Jul 2019 06:59:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39854 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfGTK73 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Jul 2019 06:59:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so34577963wrt.6
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Jul 2019 03:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uN9Q5qJ3W4UuGIO9rCvXlXI2NzwtVnyy0zLF6E8O4Rk=;
        b=Q4B+mz3nURXEHqiium+TbZZNM+lHdOWw9EQu9Cl49JSchquQsnfCTqKawNk1o4G0Ck
         1XZyXpnd5pC/i3/V/2oaRldsMubzY+mvZcUW1BoZnxAsZBPAkzV2PMP5+Z8ksP/2vpc/
         A2zmfyCPHuRX3C0XgbcQIOdKKipgOuCSC/JNcHkIhFTiBgkMzegOTfWV2xAdgGpKBUAw
         bIc7ooyqxonExt1FU0gFsggTDlK6Vz6vkX73h1rxyn5c2hru1sHv8jGdtEN3PyC0ehJl
         icZfTbX1ZQJzuSW25x4eIbgurKP756ImnY3R2b58daYpxpdV+v2TvE/yF4P3sz67ptn1
         WGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uN9Q5qJ3W4UuGIO9rCvXlXI2NzwtVnyy0zLF6E8O4Rk=;
        b=DzKjFrXs6iiByr729R9/sPiCierbmJkxgcsR60rC4FPAbWyFUgOb2tbCWE6j9+SaeM
         HxIB3J4saR7l4+gaLEwSX/rdvNEj6OHaVFL7Sd178rDi7MRuB+JGwhsOiJ2ev+lFgCu3
         ysGQumpwdXqslyUOehxrfWx3n31/Ul+G7NRkeY5o4WgNCeEwoenWfEbr4DqK745yarJQ
         ucnUsAjfXTpT/N9YqPQkyGfIm6Q7o4gmhYPXNg87vhYBkvPAgT+lGReTg2GRByb3FFS3
         k+aViaxucrQMuK03EBJ+uovQDQidplPvTMMKsfRClpZBUOthExyQRGaORwd4vWatY+Bb
         frHg==
X-Gm-Message-State: APjAAAV/5V54wLcZTVBjwLzAeCkCSMChD98Hq2O0t9ovkHyfQsz9PA3W
        AZqdXtuFiv5tB+pmN+nwu5YPZM6RkVk=
X-Google-Smtp-Source: APXvYqxHHEAX5+P+ot8moZKvMvIJwwIKVb/Se3saiRgOj+2T/c0umvIv0GhlZjnjmm0h/WS/jPtp5w==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr49869470wrm.55.1563620366095;
        Sat, 20 Jul 2019 03:59:26 -0700 (PDT)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id x129sm29597518wmg.44.2019.07.20.03.59.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 03:59:25 -0700 (PDT)
Subject: Re: "kernel BUG" and segmentation fault with "device delete"
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
 <8e009a0c-2c82-90c5-807a-bf3477e0b07a@gmx.com>
 <8c221f86-b550-fcd6-aef1-13570270a559@gmail.com>
 <4a7c1c7b-bc1e-4aba-7a9d-581c0272aa86@gmx.com>
From:   Vladimir Panteleev <thecybershadow@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thecybershadow@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFar2yQBCADWo1C5Ir1smytf7+vWGCEoZgb/4XKkxrp+GUO7eJO8iYCWHTmCPZpi6p/z
 y6eh+NYcDQSRzKA99ffgdN+aT8/L6d63pYdsgtDmX/yrFWyLOVgW62LQpC/To4MTJAIgY/Rg
 /VjdifOJtYFvr+BKJwFCTfcviy4EQjsfHLnyJjvL9BiCXfSBXASc/Gn9WOTL5ZNpk4TStGXO
 +/2PIKeg228LtJ5vc/vemBo4hcjJv9ttX7dCebpSAbNo7GgOs8XNgJU2mEcra3IMT15dGk0/
 KpGMx7bMinTIlxx/BAGt5M5w8OnNi4p2AcKzvH18OTE7Lssn5ub8Ains32hbUFf18hJbABEB
 AAG0K1ZsYWRpbWlyIFBhbnRlbGVldiA8Z3BnQHRoZWN5YmVyc2hhZG93Lm5ldD6JAVEEEwEI
 ADsCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AWIQS77RsIjO1/lYkX++hQBPD60FFXbQUC
 WJ9eKQIZAQAKCRBQBPD60FFXbX0yB/9PEcY3H9mEZtU1UVqxLzPMVXUX5Khk6RD3Jt8/V7aA
 vu8VO4qwmnhadRPHXxVwnnVotao9d5U1zHw0gDhvJWelGRm52mKAPtyPwtBy4y3oXzymLfOM
 RIZxwxMY5RkbqdgWNEY7tCplABnWmaUMm5qDIjzkbEabpiqGySMy2gy6lQHUdRHcgFqO+ceZ
 R7IOPEh2fnVuQc5t1V56OHHRQZMQLgGupInST+svryv2sfr5+ZJqtwWL3nn8aFER6eIWzDDu
 m9y2RZnykbfwd56c81bpY6qqZtHkyt0hImkOwOiBj3UWtJvgZ95WnJ8NBPHPcttgL3vQTsXu
 BRYEjQZln81tuQENBFar2yQBCADFGh8NqHMtBT8F4m/UzQx0QAMDyPQN3CjKn67gW//8gd5v
 TmZCws2TwjaGlrJmwhGseUkZ368dth5vZLPu95MVSo2TBGf+XIVPsGzX6cuIRNtvQOT5YSUz
 uOghU0wh5gjw7evg7d0qfZRTZ2/JAuWmeTvPl66dasUoqKxVrq5o2MXdYkI6KoSxTsal3/36
 ii5cl2GfzE+bVAj3MB8B0ktdIZCHAJT8n+8h10/5TD5oEkWjhWdATeWMrC2bZwFykgSKjY/3
 jUvmfeyJp56sw5w3evZLQdQCo+NWoFGHdHBm0onyZbgbWS+2DEQI+ee0t6q6/iR1tf8VPX2U
 LY0jjiZ7ABEBAAGJAR8EGAEIAAkFAlar2yQCGwwACgkQUATw+tBRV200GQf8CaQxTy7OhWQ5
 O47G3+yKuBxDnYoP9h+T/sKcWsOUgy7i/vbqfkJvrqME8rRiO9YB/1/no1KqXm+gq0rSeZjy
 DA3mk9pNKvreHX9VO1md4r/vZF6jTwxNI7K97T34hZJGUQqsGzd8kMAvrgP199tXGG2+NOXv
 ih44I0of/VFFklNmO87y/Vn5F8OfNzwiHLNleBXZ1bMp/QBMd3HtahZVk7xRMNAKYqkyvI/C
 z0kgoHYP9wKpSmbPXJ5Qq0ndAJ7KIRcIwwDcbh3/F9Icj/N3v0SpxuJO7l0KlXQIWQ7TSpaO
 liYT2ARnGHHYcE2OhA0ixGV3Y3suUhk+GQaRQoiytw==
Message-ID: <811c2c41-e795-9562-0e8b-033b404bf43d@gmail.com>
Date:   Sat, 20 Jul 2019 10:59:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4a7c1c7b-bc1e-4aba-7a9d-581c0272aa86@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I've done a few experiments and here are my findings.

First I probably should describe the filesystem: it is a snapshot 
archive, containing a lot of snapshots for 4 subvolumes, totaling 2487 
subvolumes/snapshots. There are also a few files (inside the snapshots) 
that are probably very fragmented. This is probably what causes the bug.

Observations:

- If I delete all snapshots, the bug disappears (device delete succeeds).
- If I delete all but any single subvolume's snapshots, the bug disappears.
- If I delete one of two subvolumes' snapshots, the bug disappears, but 
stays if I delete one of the other two subvolumes' snapshots.

It looks like two subvolumes' snapshots' data participates in causing 
the bug.

In theory, I guess it would be possible to reduce the filesystem to the 
minimal one causing the bug by iteratively deleting snapshots / files 
and checking if the bug manifests, but it would be extremely 
time-consuming, probably requiring weeks.

Anything else I can do to help diagnose / fix it? Or should I just order 
more HDDs and clone the RAID10 the right way?

On 06/07/2019 05.51, Qu Wenruo wrote:
> 
> 
> On 2019/7/6 下午1:13, Vladimir Panteleev wrote:
> [...]
>>> I'm not sure if it's the degraded mount cause the problem, as the
>>> enospc_debug output looks like reserved/pinned/over-reserved space has
>>> taken up all space, while no new chunk get allocated.
>>
>> The problem happens after replace-ing the missing device (which succeeds
>> in full) and then attempting to remove it, i.e. without a degraded mount.
>>
>>> Would you please try to balance metadata to see if the ENOSPC still
>>> happens?
>>
>> The problem also manifests when attempting to rebalance the metadata.
> 
> Have you tried to balance just one or two metadata block groups?
> E.g using -mdevid or -mvrange?
> 
> And did the problem always happen at the same block group?
> 
> Thanks,
> Qu
>>
>> Thanks!
>>
> 

-- 
Best regards,
  Vladimir

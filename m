Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 997DD60E99
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2019 05:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfGFDiE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 23:38:04 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:55266 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfGFDiD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jul 2019 23:38:03 -0400
Received: by mail-wm1-f50.google.com with SMTP id p74so7787615wme.4
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2019 20:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JecVb3StA1nEEEsKWhKIqS8fCJ2SfTRHdsWDkVHp4pU=;
        b=pPgS9TX6wUHERYgM+kuDvj9FakEpyCKCj0ooOE+SOnBQMQj5fxg11RRHHfMhTiZ8EV
         rZhjNlrZ5z7j76fwUE86Y3QrwNpa/i4hQJBUSec7kfYPeZ04vGN+6BvxzDsk820ikaxJ
         AOEc91q3XCN+JImGs+BBt/074hCmYtQa/CvBYzsPuFClm9XGyYWCyq9BVjn5PjukK2Vq
         HhKB2hpi/eR5sNRQLhEt78m07Sko2FFHgOrRVnXWKpDWzMWjez2ds+5La+hq+ONOhQqO
         kglR0buQTf8S2RdsYe1gzSkauPnszMIP3hH5lVeHNIqLdvQBwL7JqRql5fOMqme6KXEi
         /EJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JecVb3StA1nEEEsKWhKIqS8fCJ2SfTRHdsWDkVHp4pU=;
        b=sklnsmg5JWyu8BTGMif3pNc2B+NZzUfRjBejUclkHvnviFJgoXK8Ih/0rIuntyJIps
         51Eiq0XWwLDon6mmkDjykI07wyU4CgcCkrYHT6FIUhE9cmA1tKuZEGKyuhx/y42zKeCG
         8oxLKDzVU1UW7aXskS1slZ6W0HxtD2TljFb5oa2rqYKNIXQQOWBhY6aI23Hjexn9KFBw
         KvxAwqa1usZTUy2himmmdDQF9Ultnu5PEvmVYdWZh9cpiYwF+elDOOF+nvdtd0TUaiFD
         nEjeacdLETXnVx3r407+99RsYqoSX7JRjxpPaEQtGY3jfIUJPnm1fhPqjEZydVJuhSpz
         1iJA==
X-Gm-Message-State: APjAAAXFZGZssOZlU2XEzTJlIYSYVkT+tDS9rhp6tUO9WB9NG9Xbp1WF
        IKMCFfPDzsFa4aP90UNryOaulK52yHw=
X-Google-Smtp-Source: APXvYqzBgoHw3YdfPPzSsPXQE/zKCbAkQLtY7MfW4qyNdeB6egbDnlT1xqvx2Zx5l6XF8hRadreukA==
X-Received: by 2002:a1c:8017:: with SMTP id b23mr5624194wmd.117.1562384280611;
        Fri, 05 Jul 2019 20:38:00 -0700 (PDT)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id f70sm673730wme.22.2019.07.05.20.37.59
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 20:37:59 -0700 (PDT)
Subject: Re: "kernel BUG" and segmentation fault with "device delete"
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
 <CAJCQCtRhXukLGrWTK1D5TLRhxwF6e31oewOSNDg2TAxSanavMA@mail.gmail.com>
 <a4920d21-3c90-9a96-9b44-f90d7b5eed3a@gmail.com>
 <CAJCQCtS87cQV4PWuDRaQmmY-N03XmGqN2hh8EQv8BqqVGRuxbw@mail.gmail.com>
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
Message-ID: <0212c1f0-f02d-bf0f-5748-b1332b6bbfad@gmail.com>
Date:   Sat, 6 Jul 2019 03:37:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtS87cQV4PWuDRaQmmY-N03XmGqN2hh8EQv8BqqVGRuxbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/07/2019 02.38, Chris Murphy wrote:
> On Fri, Jul 5, 2019 at 6:05 PM Vladimir Panteleev
> <thecybershadow@gmail.com> wrote:
>> Unfortunately as mentioned before that wasn't an option. I was
>> performing this operation on a DM snapshot target backed by a file that
>> certainly could not fit the result of a RAID10-to-RAID1 rebalance.
> 
> Then the total operation isn't possible. Maybe you could have made the
> volume a seed, and then create a single device sprout on a new single
> target, and later convert that sprout to raid1. But I'm not sure of
> the state of multiple device seeds.

That's an interesting idea, thanks; I'll be sure to explore it if I run 
into this situation again.

>> What I found surprising, was that "btrfs device delete missing" deletes
>> exactly one device, instead of all missing devices. But, that might be
>> simply because a device with RAID10 blocks should not have been
>> mountable rw with two missing drives in the first place.
> 
> It's a really good question for developers if there is a good reason
> to permit rw mount of a volume that's missing two or more devices for
> raid 1, 10, or 5; and missing three or more for raid6. I cannot think
> of a good reason to allow degraded,rw mounts for a raid10 missing two
> devices.

Sorry, the code currently indeed does not permit mounting a RAID10 
filesystem with more than one missing device in rw. I needed to patch my 
kernel to force it to allow it, as I was working on the assumption that 
the two remaining drives contained a copy of all data (which turned out 
to be true).

> Wow that's really interesting. So you did 'btrfs replace start' for
> one of the missing drive devid's, with a loop device as the
> replacement, and that worked and finished?!

Yes, that's right.

> Does this three device volume mount rw and not degraded? I guess it
> must have because 'btrfs fi us' worked on it.
> 
>          devid    1 size 7.28TiB used 2.71TiB path /dev/sdd1
>          devid    2 size 7.28TiB used 22.01GiB path /dev/loop0
>          devid    3 size 7.28TiB used 2.69TiB path /dev/sdf1

Indeed - with the loop device attached, I can mount the filesystem rw 
just fine without any mount flags, with a stock kernel.

> OK so what happens now if you try to 'btrfs device remove /dev/loop0' ?

Unfortunately it fails in the same way (warning followed by "kernel 
BUG"). The same thing happens if I try to rebalance the metadata.

> Well there's definitely something screwy if Btrfs needs something on a
> missing drive, which is indicated by its refusal to remove it from the
> volume, and yet at same time it's possible to e.g. rsync every file to
> /dev/null without any errors. That's a bug somewhere.

As I understand, I don't think it actually "needs" any data from that 
device, it's just having trouble updating some metadata as it tries to 
move one redundant copy of the data from there to somewhere else. It's 
not refusing to remove the device either, rather it tries and fails at 
doing so.

> I'm not a developer but a dev very well might need to have a simple
> reproducer for this in order to locate the problem. But the call trace
> might tell them what they need to know. I'm not sure.

What I'm going to try to do next is to create another COW layer on top 
of the three devices I have, attach them to a virtual machine, and boot 
that (as it's not fun to reboot the physical machine each time the code 
crashes). Then I could maybe poke the related kernel code to try to 
understand the problem better.

-- 
Best regards,
  Vladimir

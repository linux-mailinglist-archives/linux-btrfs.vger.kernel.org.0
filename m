Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55572962C1
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2019 16:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfHTOqy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 10:46:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38484 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbfHTOqy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 10:46:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id m125so2901209wmm.3
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2019 07:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RXUHCt+otnDxgHMic1fD3fF02MQAgEfumVAlVRDYIus=;
        b=KotSOLzvrJ7mM81gwLglm5wkx+STfQ5x/TcnS0+FOUzBRWN4nAyv5uF0e5h3H0x9H3
         8txSMdgQJD0DF4K5p7vnYjj7zgDumi8JBTXWwbQ1m1c7M1NtHbWw2MQd7ZIIZ1j4XcQ0
         4klizKHogfJ8TjkXccCh5ujiSBPb7Z6ZioFkGfQN/aX8l0vVwcf2qZ6EkQaTHLsInED3
         tSz9ZA8xW89UWS7082vjO+LXDzsXMINJ33NeyPYFNYTvPyFLBu1LaJLOwtK+DjSIfNqU
         lM268Z0OjzJVLh3i1oTP7p2gZpk3ewl/C9uQLg00PlwphY2S/NBo6hB02Nvf6VZ+Tuxf
         i+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RXUHCt+otnDxgHMic1fD3fF02MQAgEfumVAlVRDYIus=;
        b=QCtN5wxYlSFOdsQUW+YXZsMgxoBfGe1nyrXXgyz4+JYXqopdLMFgoYhTDSjFv2Dwh/
         AER+F5GJsR+39LZ/JPxJyM7f0n/qWfym9JEci0Lhx9JyziDjbswsabE8mQqH/WJwgD/B
         UY9QccuEd0/ushFxm/XGmTBoyEXR/bTp/L0+Xjr6g7wyGhqXCeb/gRp8OVft7DxAXw3z
         3ZtoUmqLlwey8R/SLMLGs56kbxmJZwP5VWVkuVfhb1WCSaG9fkwvsrBzZ8xWC3AEyzZ/
         zStg88miPtlvk5dg8FRxgDANBv9eAloCAdo77Nx0GQ2gaHip+fOgWEu7QDajb7QVlVBt
         7YHA==
X-Gm-Message-State: APjAAAXWGjfseYsAejY547KPkw381phfN/JGydQxjj9yxqe+qTq+3BZ+
        zhCxr3LOQxXzqEUhcCxwNWpF42Rv
X-Google-Smtp-Source: APXvYqwpqkMVrTWOzoYIgIMNpL1AkUhtyTx+VZ6lfQKe79ZsPIsOWyXiy/qlzy4G9DILsndo+lzcvQ==
X-Received: by 2002:a05:600c:2102:: with SMTP id u2mr374641wml.105.1566312411468;
        Tue, 20 Aug 2019 07:46:51 -0700 (PDT)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id j17sm16193768wru.24.2019.08.20.07.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 07:46:50 -0700 (PDT)
Subject: Re: [PATCH] btrfs-progs: balance: check for full-balance before
 background fork
To:     dsterba@suse.cz, Vladimir Panteleev <git@panteleev.md>,
        linux-btrfs@vger.kernel.org
References: <20190817231434.1034-1-git@vladimir.panteleev.md>
 <20190820143258.GS24086@twin.jikos.cz>
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
Message-ID: <447e353b-a2c8-efbe-bead-5d27656cba8d@gmail.com>
Date:   Tue, 20 Aug 2019 14:46:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820143258.GS24086@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

On 20/08/2019 14.32, David Sterba wrote:
> On Sat, Aug 17, 2019 at 11:14:34PM +0000, Vladimir Panteleev wrote:
>> - Don't use grep -q, as it causes a SIGPIPE during the countdown, and
>>    the balance thus doesn't start.
>>
> This needs -q, otherwise the text appears in the output of make. Fixed.

What of the SIGPIPE problem mentioned in the commit message?

If using -q is preferred despite of that, then probably the note about 
it should be removed from the commit message, and the "cancel" 
afterwards should probably be removed as well (along with its note in 
the commit message too), as the SIGPIPE will prevent the balance from 
ever starting.

Perhaps redirecting the output of grep to /dev/null is a better option.

 > Applied, thanks.

Not a big issue but for some reason my email address was mangled 
(@panteleev.md instead of @vladimir.panteleev.md). Looks fine when I 
look at https://patchwork.kernel.org/patch/11099359/mbox/.

-- 
Best regards,
  Vladimir

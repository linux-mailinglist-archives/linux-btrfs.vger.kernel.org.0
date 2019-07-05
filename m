Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F91D60138
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 09:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfGEHBc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 03:01:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46553 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfGEHBc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jul 2019 03:01:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so4098994wru.13
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2019 00:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k9X+wX3ZPhv6nMbmqHsAuKT9K45wvxwSWr6NCiU2oqA=;
        b=JlJYzuc4HPMC39/wrPhpYXtPWsz0GN46H2Eaj3HqcmSDqQyIym6IvkPMj2pFWxB1be
         4s9M2fqZvQCF5G+Le5ce3NlY7O82RyDY9zyD1ltljMYusdH7xzERvphDwaXk8dXdF9vj
         tMGv831OSomywmS9tm6HNXzQHzkDc9NZW19+UDvMkJFxBs4h3rIP5wyWE8ocgpzXyZ2R
         tnxQvHcPo6LGDG33P6elHEcUWE/J33wAt5nKJCBnA/GgjF0KX31+zfdWGCgtdJyp58m3
         bLpS9gaRdf2j+IkCj5gTefQgYe/peOMjLpAIMEe6UfPrki2o5Ei2cSplEW1hOJxkc1rI
         iKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=k9X+wX3ZPhv6nMbmqHsAuKT9K45wvxwSWr6NCiU2oqA=;
        b=KTmi+fxtuiD1pSntkI+hFsTcqtW/Y8Qd44Rw+K6mehPd18/bAJffpOw7EVOsUaLLRn
         RviAOyJ/m7R8NifZiX3pPOf5aXxheMfZELwLMxQkIrdvVuegdEfvBx2IWGqXxQl1HK06
         Hp2pUy+EVQE4tjlnhsuzc6m4cTgWMDLrrvK34Vt2hkK16JnhVjILqjYPGp07CSzNwGCs
         TpwiLYa50pX3DowqtEYUuV0HQhP393m+9C+w7OAPjavBLMZ0YSdq50YZqIsEsRpDHr1i
         WRAFn/md9qc/rXLlVbdQFaGK5340zB2ygQrd/seRWCXrWtDhYBOYNZpdMrzHJCr2wUWM
         Sjog==
X-Gm-Message-State: APjAAAV49QwhTarqmLE+yS9hV6ifOysRGMcC8MzToK63pMzKW3/nj94j
        BMTpJxPHFVAdeSuScxE0fdz2NRiRQZ4=
X-Google-Smtp-Source: APXvYqwdG5uLX2TU/5Ao9HC9ltZz5M2lXwdffhjRx1AoYMP5rtyzbQAeXGYKgmaRQCz2536iPEog1Q==
X-Received: by 2002:a5d:5507:: with SMTP id b7mr2322680wrv.35.1562310089707;
        Fri, 05 Jul 2019 00:01:29 -0700 (PDT)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id 60sm11537405wrc.68.2019.07.05.00.01.28
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 00:01:29 -0700 (PDT)
From:   Vladimir Panteleev <thecybershadow@gmail.com>
Subject: Re: "kernel BUG" and segmentation fault with "device delete"
To:     linux-btrfs@vger.kernel.org
References: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
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
Message-ID: <29148fbd-c751-bbb4-3d9b-1abf90a26ae6@gmail.com>
Date:   Fri, 5 Jul 2019 07:01:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/07/2019 04.39, Vladimir Panteleev wrote:
> The process reached a point where the last missing device shows as 
> containing 20 GB of RAID1 metadata. At this point, attempting to delete 
> the device causes the operation to shortly fail with "No space left", 
> followed by a "kernel BUG at fs/btrfs/relocation.c:2499!", and the 
> "btrfs device delete" command to crash with a segmentation fault.

Same effect if I try to use btrfs-replace on the missing device (which 
works) and then try to delete it (which fails in the same way).

Also same effect if I try to balance the metadata (balance start -v -m 
/mnt/a).

At this point this doesn't look like it is at all related to RAID10 or 
btrfs_check_rw_degradable, just a bug somewhere with handling something 
weird in the filesystem.

I'm out of ideas, so suggestions welcome. :)

-- 
Best regards,
  Vladimir

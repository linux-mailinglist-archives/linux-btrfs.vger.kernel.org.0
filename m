Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAEE60457
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 12:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfGEKUn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 06:20:43 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:38619 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbfGEKUn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jul 2019 06:20:43 -0400
Received: by mail-wr1-f54.google.com with SMTP id p11so3861149wro.5
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2019 03:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dJSQexVDoTuno6rKmdK3N05oW7K4z3FSFbHOlYB6/34=;
        b=Zp1K3S/5P2uLJG8tnXSi1GjBGbBO4oM4VmtIVQoHT72FGy5ZFz5e5qnO81+8SAxFTz
         H2TUw1WcMF6LMaEZhZt5yYRDVxrhGXRXXv3RIQpqSGDsloPlbnQWXu+3w4ajtVaX/CkX
         F3nyZmC1KuW5P+N9EAKalfcUZ1/51FAE6mHYfC+lmoclPOTn1fJn4/ktkAqLBkOgGXai
         uU5XjsPADcaWF5WW0OVrp6zLhPLXkrvxwg9vgxokO96mHY/WP+N2c8NlxLb0JgtsbNbm
         6Qhyi2wHyceN6QTPWwTxpp2r+0Sk/a4jxobHFLNB8ziFisWOkMJYEcl2Owt72+kSiQgi
         Tb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dJSQexVDoTuno6rKmdK3N05oW7K4z3FSFbHOlYB6/34=;
        b=hrV0KEhuJt1VI8jOhJMF7Q9VGJ10myumsQyncObSWytn2Uses9sc8e1huMNJqzIV/I
         9Pxeo9zwrPJPqrgHvXIAVkARGPVOkJ77h01PdufVScyM8LIPwCGVg08D51us4Xbatl7x
         K2pSDzJ966vno61NSoy/i4fNSXxssx/wXUXxziXNV4I84Fraa54/z2jf20I5Tx4JfFYI
         KmY6cXit1IGz8HoDqzpS7s+u6cWO/jx4oFb1W1HnfrPLZ0k+Yu6eaf07S2ZikQRJvaCg
         VcmwgeGQbyqI837QC0QSK6UZCGAwiGtSTuvE9GYnW1BVlMTcfU3fuWS+1dsEQrFRi7du
         xOQQ==
X-Gm-Message-State: APjAAAVxi1Bvm1g8NaBUEICi1eX6kcf+5etvxdO+wnvT8imvQ5NtAlMt
        aXMuZqrTfWG3yLB2PCpoLibiKVEtFuA=
X-Google-Smtp-Source: APXvYqz+AzaAx4TC5lMP/wLn2h8dEFOB/JCWI/TlgXFBbBhSI0lE40r3uS9Z0z1pQz6MIsSPdIRo1Q==
X-Received: by 2002:a5d:5492:: with SMTP id h18mr3445273wrv.212.1562322040759;
        Fri, 05 Jul 2019 03:20:40 -0700 (PDT)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id r16sm22298270wrr.42.2019.07.05.03.20.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 03:20:40 -0700 (PDT)
Subject: Re: "kernel BUG" and segmentation fault with "device delete"
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
 <CAA91j0W+UhJ2O+K1SJs3JaOfzkCnRhWgGjfFxXju5_sUsCj18A@mail.gmail.com>
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
Message-ID: <a0d34e0a-f2bb-abd5-bb6f-f82a8d2da190@gmail.com>
Date:   Fri, 5 Jul 2019 10:20:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAA91j0W+UhJ2O+K1SJs3JaOfzkCnRhWgGjfFxXju5_sUsCj18A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/07/2019 09.42, Andrei Borzenkov wrote:
> On Fri, Jul 5, 2019 at 7:45 AM Vladimir Panteleev
> <thecybershadow@gmail.com> wrote:
>>
>> Hi,
>>
>> I'm trying to convert a data=RAID10,metadata=RAID1 (4 disks) array to
>> RAID1 (2 disks). The array was less than half full, and I disconnected
>> two parity drives,
> 
> btrfs does not have dedicated parity drives; it is quite possible that
> some chunks had their mirror pieces on these two drives, meaning you
> effectively induced data loss. You had to perform "btrfs device
> delete" *first*, then disconnect unused drive after this process has
> completed.

Hi Andrei,

Thank you for replying. However, I'm pretty sure this is not the case as 
you describe it, and in fact, unrelated to the actual problem I'm having.

- I can access all the data on the volumes just fine.

- All the RAID10 block profiles had been successfully converted to 
RAID1. Currently, there are no RAID10 blocks left anywhere on the 
filesystem.

- Only the data was in the RAID10 profile. Metadata was and is in RAID1. 
It is also metadata which btrfs cannot move away from the missing device.

If you can propose a test to verify your hypothesis, I'd be happy to 
check. But, as far as my understanding of btrfs allows me to see, your 
conclusion rests on a bad assumption.

Also, IIRC, your suggestion is not applicable. btrfs refuses to remove a 
device from a 4-device filesystem with RAID10 blocks, as that would put 
it under the minimum number of devices for RAID10 blocks. I think the 
"correct" approach would be first to convert all RAID10 blocks to RAID1 
and only then remove the devices, however, this was not an option for me 
due to other constraints I was working under at the time.

-- 
Best regards,
  Vladimir

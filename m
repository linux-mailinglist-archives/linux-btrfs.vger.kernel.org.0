Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C43525BCEA
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 10:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgICIQZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 04:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbgICIQF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 04:16:05 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17597C061244
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Sep 2020 01:16:05 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lo4so2564503ejb.8
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 01:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OP41J3YaucZ4OT9mOgxdXkObix7bLc7j3d0u8mQqOgw=;
        b=mGT3w0Oot/KlQIwuYU/HQN2lLg8mwS4oxQyqx6Xp8ktS/elx8est5pFki695Bt3x9B
         xs5Hvs/rGZUnoyn7Grhohp/T4SulhnwoiHe+l8TYMpYlhABWVRFthCXFou1Unk0cSG8z
         KcKlUv/8REYATNoaS1It84SAF6R+WUUf4vLKVtKnmw+YJRmElNYZGekOOUF2QPVBYuOm
         zl0L4OfwiLkAjUzjYFNTnp4lnxuwUe2y+jbLPzODSiCktOJZqUdXP766NZG5p29lgXEk
         1D4dvTodJbQ8bPppjHzhPW/DPZ4a3dA4C8FCxOu5tfcnJXoMkfjNAUdVZ07Y+KMIQ4B2
         arzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OP41J3YaucZ4OT9mOgxdXkObix7bLc7j3d0u8mQqOgw=;
        b=Giri60Vs0gQ/sEwW4fxYMIOo/vFeDNW83oPKOiFuZzaqQQNr3crw9iibNX6UA8vZGC
         5b0P/QwZfGjxuSl+l56CXSLUjaJ/UTaiL0RvIYdpAynKyITN7RBfR8ltHUFV796VcSOF
         HxivHBoeeu66HUUWTExojj1R3QqPcgL6pdF189hwxv+ORrKZ5BsvrhSd5KFIhLTcGMAo
         UCo/M4DLOvH6tdJSEuyxPMY4Q2XgSg7r00FetZUB6D9FCv4y0EI+va7tQlQtWM7sc8bv
         ey9uRuTmwILgEeQ4ilGnubxgr50YiFpO73dZw1b6wpdh/A3tlQJIaigQ//d7VMOv3Bkb
         OcdQ==
X-Gm-Message-State: AOAM532ZavgwTFQHH0dj5eDR0oTG0fZGl/mUIaHNiejTlByEfCuwT/oY
        izoCAv3OMoZvFxTVIVoh/4kxSNKvKzKEUQ==
X-Google-Smtp-Source: ABdhPJxcGiIoxnCkZbZ+2yJacQdqYMah//gltyOqAJ92S1/ePG/a/NDGd20xsmWBXGbZluxNxJjMZw==
X-Received: by 2002:a17:906:9382:: with SMTP id l2mr869187ejx.513.1599120963287;
        Thu, 03 Sep 2020 01:16:03 -0700 (PDT)
Received: from ?IPv6:2003:d3:c710:2000::b87? (p200300d3c71020000000000000000b87.dip0.t-ipconnect.de. [2003:d3:c710:2000::b87])
        by smtp.gmail.com with ESMTPSA id z5sm2408953ejm.111.2020.09.03.01.16.02
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 01:16:02 -0700 (PDT)
From:   Johannes Rohr <jorohr@gmail.com>
Subject: Re: kernel BUG at fs/btrfs/relocation.c:437!
To:     linux-btrfs@vger.kernel.org
References: <28e01acb-a8b8-6801-ee49-94e56d7371aa@gmail.com>
Autocrypt: addr=jorohr@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFT1gLABCADcwcj45ysOenaLb8+pkjeb+6oC5IZQ5rgf42l8tCfU6mwwTyaHI/OE9f1f
 pClmX+dkEFp9HjFK6e33St+HgcXsmarEpVkGVB1oLwhnECuBngqJLbopXL8QfgVkjaNq2aF9
 QfR0W2F8BlNDllnJ8q3MToY3RQ2BSkYvsekCS9zJ+8cFrZohpTa9hvtD2tDdHk48A8GaxA7Q
 CZm3FSbzXEFuGH4TZ4P407b6prXfU8LidTCrkluuM44LhqTGRXmtuVg6jU9vOrkcz8fflGtq
 Orziu8O32iiL9HU1Oo2wX/vXq9wANj9PAp+cOknXVAH/MeYSIPqo+0pc6ObZxufYyUehABEB
 AAG0IEpvaGFubmVzIFJvaHIgPGpvcm9ockBnbWFpbC5jb20+iQFOBBMBCAA4FiEEQGpo2KXp
 zZlAiCX9BQuNsh71kW8FAliYN80CGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQBQuN
 sh71kW8GRgf9GKnsiEasxb/0/ngspsDBFCT2GROrA+Qqz7cp14hZVtOkm6nJ7wshAYy+UGfl
 ovPRi3D3JG/RJvBQHi+rYIBrROOOVbj704AC5oFCUwsFs6pKcnwlRaodIo9u4ZgiYOkNln12
 UJxuPL1v7J1ccgypP3ufFZaH9gJGssZtajyQkeCRCKNbBPIbXMSnsTWBqyB4AulnyAwVFJAc
 4yga8FaJtiDV334tt2TBNw80yqtDczjbjq/tJkcR5VlzVLpPXpbJ8FCL7K945MmN2fpWgWvj
 WtqEfnsSW/y1x7OfDWQ8CG1szKc6HVsqkRNQwksJapIdresC2dNe7oT+m9bn0+RWIrkBDQRU
 9YCwAQgAu86uORuwnEMOhc1poBRsvWns7G0eMd0vdSaiSAPaP8pQrgTC16wBXJXPxPIhIzfs
 PnGvHgv21BhGcBRcQ7Ybh56dXnWBuKMNnIz2PcMEdHfjd/NG0SDRZdEl/Eztk143kXxsjMTo
 10sGHPVJOFIVG1L9K2XcZ/M4SvvR5rSYW2obRbCtT3EkNAcyynA/xKtOhsAFkCVjO4twytQv
 Og9rpn02bBrjZqaTCHPzVl7ZpjVD6oykY8uJrgKc4EGMouH3WitZppkWSqaB1hgJp78CjwkB
 12mT+YcIoM6xzAIklBzKK4qaV1elHhd5clhbDuSpGor/KJcyolx5hbMFwrT+jQARAQABiQEf
 BBgBAgAJBQJU9YCwAhsMAAoJEAULjbIe9ZFvhS8H/3hMmBhanQeDumAndrJI14228G9QUSW2
 SO92Uzlek/mQwRbIg/+nkLn2aC4RkEYqox+AuQA7TqX+OS7JjFVS9vtsn2ZM+kgvMpzUaKO5
 aCjqiyXB4Q3pvg2t46SeuiV1Y3cbyhAH6gzCOei/IMguhYIqNAsf7bf2drN5e1uMHpzJHrBK
 KugcR5bTfAVQzwnOMPQtPH4mRe7cALp04t4rxSZUiC9Xw9s38oK+Ewk/TtjBEFg4VTDMHdcE
 B65jlCq15bGxaOSwZbDzx/exLNq41HM3xygY7XFgAdyE6FJLvUc5ehqTjiwsIx3BioRMOTzd
 5n0x4xeJ5v4w63j4mSxbZu4=
Message-ID: <acde1884-0080-39d6-5e20-60f5f02eaf38@gmail.com>
Date:   Thu, 3 Sep 2020 10:15:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <28e01acb-a8b8-6801-ee49-94e56d7371aa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sorry for nagging, but since I got no replies and neither found any
other reports that refer to line 437 of fs/btrfs/relocation.c I thought
I should ask again.

This is about a system running Ubuntu 20.04, uname -a says:

Linux ida.rooot.de 5.4.0-45-generic #49-Ubuntu SMP Wed Aug 26 13:38:52
UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

That's a kernel package that was released 31 Aug.

I can reproduce the bug by running btrfs balance start /home -musage=70

After a few seconds, the command terminates with a segfault, dmesg
output is here:
https://gist.github.com/vasyugan/340d9cd2292e3122c1d7773df718a234

The core lines in dmesg seem to be:

[32387.616248] ------------[ cut here ]------------

[32387.616249] kernel BUG at fs/btrfs/relocation.c:437!

[32387.616271] invalid opcode: 0000 [#1] SMP PTI
[32387.616180] BTRFS error (device sdc2): couldn't find block
(4853431877632) (level 1) in tree (19918) with key (986 96 124)


There is nothing about an IO error in dmesg, so to me as a layman this
doesn't look like physical damage.

Yet when I repeat the command, it always names the same block.

I have of course run scrub, which as I understand it, does the same that
an  offline btrfs check  would do, it finds no errors.

It would be awesome if anyone could take this up.

I have submitted the bug to bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=209143

Cheers,

Johannes


Am 01.09.20 um 10:18 schrieb Johannes Rohr:
> Dear devs,
>
> I tried to replace an SSD with bad S.M.A.R.T. status and since I don't
> have physical access to the server, I first wanted to remove it from the
> RAID 1 (which has 4 SSDs) and then erase it.
>
> I ran "btrfs device delete /dev/sda2 /". After a while, the command
> terminated with a segfault and the system hung. I waited for 30 minutes.
> Fortunately, it could be resurrected with a hard reset.
>
> dmesg, as this happened, reports that a block on a different SSD, on
> /dev/sdc can't be found.
>
> See full backtrace here:
> https://gist.github.com/vasyugan/340d9cd2292e3122c1d7773df718a234
>
> Now I am afraid that if sda is just removed physically, then marked as
> degraded and swapped for a new SSD using the btrfs replace command, this
> might also go bad  because of the block that can't be found.
>
> Does any of you have advice on what to do? From the backtrace I don't
> even understand if the issue is a physical problem with sdc (whose
> S.M.A.R.T. values are just fine) or whether this is another btrfs bug
> and if you, if there is any way to work around it.
>
> We are running Ubuntu 20.04, the kernel is 5.4.0-45-generic, Ubuntu's
> version number is: 5.4.0-45.49. It was released yesterday and was
> supposed to have a relocation relate bug fixed, see
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1889669
>
> I suppose, this is a separate issue. Should I report a bug? If so, where?
>
> Thanks a lot in advance for your support!!!
>
> Johannes
>
>
>


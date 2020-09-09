Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B272630FE
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 17:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbgIIPw5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 11:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730694AbgIIPwc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Sep 2020 11:52:32 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C3AC061238
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Sep 2020 07:51:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id e23so3998309eja.3
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Sep 2020 07:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:autocrypt:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=Iyo6KdIiohNine7AsqkG34GgStmcZN+vja/vM9R7Igc=;
        b=fzKYw9xH/juJJIeD7S85HGwywY6gSHnQSPz2i8wOxDraiJz2gX/g7CJ7iJfRCtgkn0
         hV35erqQ5ZdIs6a1Gu3g3ojwauaCTt25Qkd5NkDWoPSf6qGx+bhBbk2W5ybdj7r+bZxV
         bwt8bRCh7eZdt/VIYj0cVQMMXar1KIwrztA+5ZKi0zOa6WveFHeOGPUQTSV0zvJ8FLpa
         rdZuUP+f181QiKR3kpgoffpsH3DipAzpg56sdPE1dTXEDK+lrnZ5lg1zEiVIKdUSSbpe
         Og3yCfVQy6Ea0J7aBJW9z44BkLdhKEDUFTZynXZFnQ5owK+6xopGgHtT7RduAiWELjwv
         nCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:autocrypt:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=Iyo6KdIiohNine7AsqkG34GgStmcZN+vja/vM9R7Igc=;
        b=YKMbglFUz7neYQ46oBi2tKlLsdWTodGatpT3zlQYB7MQ6Bxr9HHywWk4DFneVbhovY
         DPpKrM9L2xMj3Crg/8vTM6FNUQbGCfwgUjp30EBQT/FOhSYg77e0OlaahsTXngUOWTjm
         66LvTNDUDLKV1b8S70Ri/hl0fn8h0H5B+ULx+tO9VEPQAokI4M/MsVQKkCEFr2LAnZPT
         SqFpgkgV/zRiS9cltE0e9ObwBe+xD/mVFoXVq/c6Q82jbiMJwzchcU1L4K/KrjYzgkne
         9TdawtP1RvRF41n+1zI/2E6QD+/Mz6s0RjdVLb30i8YoRGYTiOEPmNjEfyu5VzrFnZsY
         q38w==
X-Gm-Message-State: AOAM532iyDFqlXPEAIb4+hXFk0qxSbMatIr/EjyyTyUO9q9mxWtCkTeU
        nQud8PZxkUJHNWQFlC/U8OO+wdxK2IOh5A==
X-Google-Smtp-Source: ABdhPJz65jpQDv1bpDpRKQJnxas0mQK+0A++SF6UdV2Ohq08CC/hAsmPAoVrMzY1RLEgrkggk20TIw==
X-Received: by 2002:a17:907:7206:: with SMTP id dr6mr4213434ejc.546.1599663111632;
        Wed, 09 Sep 2020 07:51:51 -0700 (PDT)
Received: from ?IPv6:2003:d3:c72d:9a00::b87? (p200300d3c72d9a000000000000000b87.dip0.t-ipconnect.de. [2003:d3:c72d:9a00::b87])
        by smtp.gmail.com with ESMTPSA id u23sm2668867ejc.108.2020.09.09.07.51.50
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 07:51:50 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Johannes Rohr <jorohr@gmail.com>
Subject: backref mismatch / backpointer mismatch
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
Message-ID: <0219bbee-9ca3-135a-8a2f-5d616000c1e0@gmail.com>
Date:   Wed, 9 Sep 2020 16:51:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear all,

Last night I did a readonly offline check of our server's file system
and I got a bunch of backref mismatch / backpointer mismatch errors.

Since everybody is warning NOT to use btrfsck --repair, I wonder what
options I have of fixing this issue, short of reformatting the whole disk=


All the info (uname -a, btrfs fi usage, btrfs check output) is here:

https://gist.github.com/vasyugan/45471206df5d9981f51b9bbf9362508f

Thanks so much in advance for your advice,

Johannes




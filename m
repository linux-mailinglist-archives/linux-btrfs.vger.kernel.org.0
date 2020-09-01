Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827B6258A36
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 10:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgIAIS5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 04:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgIAIS4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 04:18:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1D4C061244
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 01:18:56 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bo3so366984ejb.11
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Sep 2020 01:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:autocrypt:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=J5hrqa9RUnnkSXoTTyuCoKBR3koPi0njtoaWa/WjS+8=;
        b=IT0K8vFvu5Qgl7Ujw6e7xVEaVF/NASSpx9P5YTaf370GxtgLjtR73WlrTzvWDM4aVw
         PSlko0mk30yzQ6gSH1+5zw7sE6vTc0n2D9z+Jvxrlwc8rvDklh2A6QSTdRLm0DfQqtvZ
         qCQHbk4Y6MVQdbURRo9Mq1qsDYS6AcdlGKT8PjbiFSqF057XCZT5LVP3lh3YOZddr+aN
         GsSOP/lXVRW0B2JbRsD531U3ZmQ1rSs1WbEWMGndECa2usHzJBGIrBHBt1Sr13RNipP+
         CQ3jBfo5IUh2o6IGUnZFpoAENEECa+pzEBbjj0Q36vAin3eNBzO9efVYzgjx77UZmD6p
         33ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:autocrypt:to:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=J5hrqa9RUnnkSXoTTyuCoKBR3koPi0njtoaWa/WjS+8=;
        b=tV3T/pXt4hxu/Xxx3U40d4G54GIVfzb3pKjgMjjdKurR83Sp4f7RvG85wi/+oO+WzW
         MGwE1YBQUYMnfgg8pzn92o7iB1F4zc0BMdfb4eIX5U/2AyLP5ADFdOXDlKX/oaqL8XV0
         3D7p8eIJbW6iT33yYPBU+pXoYOVUhZLWDOA2GXYLicv/q1xqbCe33U72Osz8IyQ8clB7
         u6CHY2hxQ8VKa4lUBzYukFQmjGn2v4oSmydYTcQpjChw9e1nA1jFk6IXpwApyxjQ4oPj
         4npR48U7j7Oe07RXQhyM/lJFnqh9RU6lKPbb8RvMA4EIMi34zL7M0PQ0vYj7i+P/5vUH
         SGUA==
X-Gm-Message-State: AOAM530c0Ff6HgvYmJXi0Zd52hYMoFLq4CHjUsinXNWpWnTg1TsNnRCu
        tHwfEU43bPK4hc15P6JJ2qog1pARI1E72A==
X-Google-Smtp-Source: ABdhPJz+3X6Mi/RlytxRjalW3hKeGRlr5vwmNLA/pdL+WLmdQCOiuVfROIZPPtTPupJHRnfAhD1euw==
X-Received: by 2002:a17:906:69d5:: with SMTP id g21mr420715ejs.461.1598948334048;
        Tue, 01 Sep 2020 01:18:54 -0700 (PDT)
Received: from ?IPv6:2003:d3:c710:2000::38b? (p200300d3c7102000000000000000038b.dip0.t-ipconnect.de. [2003:d3:c710:2000::38b])
        by smtp.gmail.com with ESMTPSA id e8sm442755edy.68.2020.09.01.01.18.52
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 01:18:53 -0700 (PDT)
From:   Johannes Rohr <jorohr@gmail.com>
Subject: kernel BUG at fs/btrfs/relocation.c:437!
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
To:     linux-btrfs@vger.kernel.org
Message-ID: <28e01acb-a8b8-6801-ee49-94e56d7371aa@gmail.com>
Date:   Tue, 1 Sep 2020 10:18:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear devs,

I tried to replace an SSD with bad S.M.A.R.T. status and since I don't
have physical access to the server, I first wanted to remove it from the
RAID 1 (which has 4 SSDs) and then erase it.

I ran "btrfs device delete /dev/sda2 /". After a while, the command
terminated with a segfault and the system hung. I waited for 30 minutes.
Fortunately, it could be resurrected with a hard reset.

dmesg, as this happened, reports that a block on a different SSD, on
/dev/sdc can't be found.

See full backtrace here:
https://gist.github.com/vasyugan/340d9cd2292e3122c1d7773df718a234

Now I am afraid that if sda is just removed physically, then marked as
degraded and swapped for a new SSD using the btrfs replace command, this
might also go bad=C2=A0 because of the block that can't be found.

Does any of you have advice on what to do? From the backtrace I don't
even understand if the issue is a physical problem with sdc (whose
S.M.A.R.T. values are just fine) or whether this is another btrfs bug
and if you, if there is any way to work around it.

We are running Ubuntu 20.04, the kernel is 5.4.0-45-generic, Ubuntu's
version number is: 5.4.0-45.49. It was released yesterday and was
supposed to have a relocation relate bug fixed, see
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1889669

I suppose, this is a separate issue. Should I report a bug? If so, where?=


Thanks a lot in advance for your support!!!

Johannes




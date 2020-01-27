Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D02414ABDE
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 22:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgA0V7i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jan 2020 16:59:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38071 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgA0V7i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jan 2020 16:59:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so13547018wrh.5
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2020 13:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WVm3EgU8kjPX61IvxFfA/82RO+tDvUX8Dfe8nWTuPzg=;
        b=Vue2O+cCwYe7TIWIm3DDZj9oBWHuluEykZXPd3lNr5WgWzJnjPHAswkFyWgWXXgPzx
         HPsHrUxyKEfQliBddwl1wJTGZMSjtCWNBZFbgt4hglcUqzKOk4Vihz8dh6+MqF/TPxCf
         v2zfiEBqNZwF4BucrKfF2DcntbNpCIR5JWTlPOUaT5Mk5fAf5Ca6rQLA2LGR067SsBtk
         o0L7/cTq9Vtbj4hwyW5Dh+vcqlTuuoRXJVPB1uhmmHZG/II2P0K3rUxx/zYTjeRtuJEM
         NVsCM0MD8KxXSB3J4j/4t/j6lADr/bavSOE35vQFlk96B4r9P9REI9v1x4zy6SpU14Xm
         9bwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WVm3EgU8kjPX61IvxFfA/82RO+tDvUX8Dfe8nWTuPzg=;
        b=L6XziTVVjB2vQHwIYDvK8LP3OlPOiN1xLezt4pYFTl7wm8V7VZBFur+ILVD3BDqK2S
         /JxniGjlJoS072B/Bgnh3a5uMfwDce34E+S6PLzENz4E89xCQc9ejooy/VSlf017IcED
         5Xtd/Lq3tJOAOOkb8ohl47QxSmaZIfBKQGP6X3EXDeZ2bd64Wn7k3BQpIKv3SYh/xrPK
         yjP8i/Kst1/mvqgHuhAM+iMuVt1UfZ2zqSf3DDYoC23fZUgx/7sR2CORTroAH0kYsRRZ
         VIb0m1PyOM9nWhe9rHCDgpe9KzRnn2w8RZ8a9Aj8o52+zuijWbAVqKjx6rqqebg3GRcx
         fb7g==
X-Gm-Message-State: APjAAAV0KWnbbTE1qF74vfztD+VsbY7F3Ls/zei8y/xVejCuwf92qTgl
        /lwL9s5zL8RjS6JUD2lF2083FBbgXfw=
X-Google-Smtp-Source: APXvYqyJadTDvQU5zkwdmmBx8n5lUvo1ytyMwAw5EdfsStM55wOTdQ5iAp9yEEKocgRyHYKpqtdmjg==
X-Received: by 2002:adf:a48e:: with SMTP id g14mr24433769wrb.409.1580162374404;
        Mon, 27 Jan 2020 13:59:34 -0800 (PST)
Received: from ?IPv6:2a01:e0a:1f1:c2f1:c5ba:1dac:b80:6348? ([2a01:e0a:1f1:c2f1:c5ba:1dac:b80:6348])
        by smtp.gmail.com with ESMTPSA id q10sm228047wme.16.2020.01.27.13.59.33
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 13:59:33 -0800 (PST)
Subject: Re: Endless mount and backpointer mismatch
References: <c541f131-c60b-4957-0f86-3039da69f788@gmail.com>
 <CAJCQCtShdXA2SRkHvfRAS8EVLRRzCmJ3HA-Ynk=uOEc+9XD7iQ@mail.gmail.com>
To:     linux-btrfs@vger.kernel.org
From:   Pepie 34 <pepie34@gmail.com>
Autocrypt: addr=pepie34@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <46459688-6aed-7ec5-0bdd-97ff76fc13cb@gmail.com>
Date:   Mon, 27 Jan 2020 22:59:33 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.24)
 Gecko/20100317 Thunderbird/2.0.0.24 Mnenhy/0.7.5.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtShdXA2SRkHvfRAS8EVLRRzCmJ3HA-Ynk=uOEc+9XD7iQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: fr-FR
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Le 27/01/2020 =C3=A0 22:48, Chris Murphy a =C3=A9crit=C2=A0:
> On Mon, Jan 27, 2020 at 2:20 PM Pepie 34 <pepie34@gmail.com> wrote:
>> Dear BTRFS community,
>>
>> I've a raid 1 setup on two luks encrypted drives for 4 years that serv=
es
>> me as btrbk backup target from an other computer.
>> There is a lot of ro snaptshots on it.
>>
>> I've mistakenly launched a balance on it which was extremely slow and
>> tried to cancelled it.
>> After two days of cancelling without results, I decided to power off t=
he
>> computer.
>>
>> After the reboot, even with the skip_balance mount option, the mountin=
g
>> is endless, no error in the kernel message and it never mounts.
>>
>> What I have done so far:
>> - mount the volume with the ro option (fast to mount, data OK).
>> - scrub in ro mode, no error found
>> - btrfs check
>> In the extent check  there is plenty of errors like this :
>> =3D>
>> ref mismatch on [9404816285696 32768] extent item 6, found 5
>>
>> incorrect local backref count on 9404816285696 parent 5712684302336
>> owner 0 offset 0 found 0 wanted 1 back 0x55f371ee1ad0
>> backref disk bytenr does not match extent record, bytenr=3D94048162856=
96,
>> ref bytenr=3D0
>> backpointer mismatch on [9404816285696 32768]
>> <=3D
>> No errors in other checks, though checking "quota groups" is very slow=
=2E
>>
>> What should I do ? btrfs check --repair ?
>> btrfs check --init-extent-tree ?
>> btrfs --clear-space-cache ?
> None of the above.
>
> What kernel version and btrfs-progs? Newer kernels should have better
> performance with quota enabled and many snapshots, even though I think
> that combination is still not advised for performance reasons. Older
> kernel might have a known bug related to the behavior you're
> experiencing, but we need to know the versions.
>
>
>
Kernel : 4.19.0-6-amd64 #1 SMP Debian 4.19.67-2+deb10u2 (2019-11-11)
x86_64 GNU/Linux
btrfs-progs: 4.20.1-2

I'm on debian buster.

Note that I don't really care about perf now, I mainly want to mount r/w
my volume.
With the same setup raid1 / luks=C2=A0 / quota, it was fast to mount and =
use
before the failed balancing.
(mount took about 2s... )
Now it is not mounting at all (except with ro)

Best regards,

Pepie 34


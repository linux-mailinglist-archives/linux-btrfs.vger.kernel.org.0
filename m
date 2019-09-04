Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B18CA885F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 21:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfIDOEm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 10:04:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40090 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730462AbfIDOEm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 10:04:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id c3so21416082wrd.7
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2019 07:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liland-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nJaepZZ5xlKO8bduTqYrd6o2LBkXoWDQ16HBxSNozZE=;
        b=SilKxmPupPbgx0wAXqDmjJnrGEq0nmD6o2vLFr9QeI1leMMycF+/PqFslzhtITcmSx
         jDzNcqdsWnoMthSViZw/88vl5gyEsWzzkwVasDENMlDhjGoxgFhgy/h2cjZ+UkZWnN1x
         F/5zbRh34QoPuQXOjBesLn/aknUBClevbE5XUyMeiofvWg/l0tFoP6zTxgWXqhug12WM
         1uiw9B6+0UjG9A/Hi0w4XctDqnMDwWtu2/3XORtRXFp9jEV8TpxJFnFHFfMND3KN6ZeS
         C1V0WziXuwGcWCkH8oU7mpHXrXeXA0dK5uwHoIIp1cMXWPFn7wtAbTu6cE6yvDqtU/4A
         u5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nJaepZZ5xlKO8bduTqYrd6o2LBkXoWDQ16HBxSNozZE=;
        b=YgZFltEAxAFTgRZMqFXNChUlTWbiD+4uwGcTDC8tQ5rRMYOzq2fJTmDf6rdjM3JdWD
         RFq9qrGNe3fp1UwcDcDBxOtKSO9BLmPUL19bdMRKQWme8DurxPej5D5yk8Gma6yCuKRY
         AZ5AVWq125gqRGZxu1aI4HnZ7xKdINmvHZy/P5Tu4HxYX5FZ7zW9UVqpQDhOPTbd7biL
         6RGdNsi98VZrPPUOAptgw4K5TLHBw2Cd/UvCt/NJy7NJSYa4yZbuURW0e4Q7BvPe65cI
         +IUC7+DkFhEjtN9ppj+K6gdtqtxj4Xk9L6YNPYwdtasnOpAIDlOI+VpfkuFQfpVo7ZDd
         RAFw==
X-Gm-Message-State: APjAAAW27npOcfRTci/B8aPOzFA7ekaJJSiRdNzh+qG/OrMeL4x8+G2P
        EVCHz0DzR9w8l3HuC5OD4ILtXYM2KNUDEWJ3B/ueEgp7BSBK9XTR40KJzhsLozr3hrRYXlcNUQi
        uBmG6846hMbVPAtQNuHXlVjyu
X-Google-Smtp-Source: APXvYqyaFf8Xb5fQt+G6UxAG9tMYhSnAdObTpMHQanqXWbPlaBuXSgYv0Mi8GUSQdXAaJQwsuvcDhw==
X-Received: by 2002:adf:e784:: with SMTP id n4mr32541039wrm.144.1567605880605;
        Wed, 04 Sep 2019 07:04:40 -0700 (PDT)
Received: from [192.168.0.140] ([62.218.42.34])
        by smtp.gmail.com with ESMTPSA id q124sm5064332wma.5.2019.09.04.07.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 07:04:40 -0700 (PDT)
Subject: Re: Unmountable degraded BTRFS RAID6 filesystem
To:     Piotr Szymaniak <szarpaj@grubelek.pl>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <f58d5ec1-4b38-ad8b-068d-d3bb1f616ec2@liland.com>
 <CAJCQCtTqetLF1sMmgoPyN=2FOHu+MSSW-MGsN6NairLPdNmK+g@mail.gmail.com>
 <c57b8314-4914-628c-f62b-c5291a6be53c@liland.com>
 <CAJCQCtT5WecG26YXE6EVwhv52xSY_sm8GqgLDoQbZBUom4Pw7Q@mail.gmail.com>
 <3d683d4c-375a-e5ed-ebd7-188c2b10f925@liland.com>
 <20190904123539.GG31890@pontus.sran>
From:   Edmund Urbani <edmund.urbani@liland.com>
Message-ID: <07006aed-fd74-0ab5-f17a-dedbb7b86722@liland.com>
Date:   Wed, 4 Sep 2019 16:04:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190904123539.GG31890@pontus.sran>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/4/19 2:35 PM, Piotr Szymaniak wrote:
> On Wed, Sep 04, 2019 at 08:18:09AM +0200, Edmund Urbani wrote:
>> *snip*
>> The timeout under /sys is 30 for all of them.
>>
>> I am not sure what you mean by SCT ERC value and where to look for that.
>> Here's all the info smartctl gives me about sda:
> Try:
> smartctl -l scterc /dev/ice
>
> ie. one of my drives (also WD Red) outputs:
> $ smartctl -l scterc /dev/sdb
> smartctl 7.0 2018-12-30 r4883 [x86_64-linux-4.19.62] (local build)
> Copyright (C) 2002-18, Bruce Allen, Christian Franke, www.smartmontools.o=
rg
>
> SCT Error Recovery Control:
>            Read:     70 (7.0 seconds)
>           Write:     70 (7.0 seconds)
>
> SCT ERC value should be lower then the value in /sys.
>
>
> Best regards,
> Piotr Szymaniak.

Ok, thanks. Mine also all have 7 seconds set.

Kind regards,
=C2=A0Edmund

--=20
*Liland IT GmbH*


Ferlach =E2=97=8F Wien =E2=97=8F M=C3=BCnchen
Tel: +43 463 220111
Tel: +49 89=20
458 15 940
office@Liland.com
https://Liland.com <https://Liland.com>=C2=A0



Copyright =C2=A9 2019 Liland IT GmbH=C2=A0

Diese Mail enthaelt vertrauliche und/oder=20
rechtlich geschuetzte=C2=A0Informationen.=C2=A0
Wenn Sie nicht der richtige Adressat=20
sind oder diese Email irrtuemlich=C2=A0erhalten haben, informieren Sie bitt=
e=20
sofort den Absender und vernichten=C2=A0Sie diese Mail. Das unerlaubte Kopi=
eren=20
sowie die unbefugte Weitergabe=C2=A0dieser Mail ist nicht gestattet.=C2=A0

This=20
email may contain confidential and/or privileged information.=C2=A0
If you are=20
not the intended recipient (or have received this email in=C2=A0error) plea=
se=20
notify the sender immediately and destroy this email. Any=C2=A0unauthorised=
=20
copying, disclosure or distribution of the material in this=C2=A0email is=
=20
strictly forbidden.


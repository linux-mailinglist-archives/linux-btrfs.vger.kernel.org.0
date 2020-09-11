Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B5C265DD7
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Sep 2020 12:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgIKK3i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Sep 2020 06:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgIKK3g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Sep 2020 06:29:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0994C061573
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Sep 2020 03:29:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e16so10988920wrm.2
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Sep 2020 03:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cVqD1iKA4+GqIY+Xphkq5i7OdQvOFXNUkDxlLeoakOw=;
        b=lBUGe7YctY6IOLbO1D9RE9lqbyaUpatYY4amO3doEuqlkzHv/FneJ5PGaeegU54yqT
         2W59Yobx+w0kL8B2dlYNHdLAHV/3H9zhMV3MYcOILqIa07GjLpHeEJtLfJiXO4g9bCla
         nKN2pjuFYJIPpr/2ldMxyQIZbmHjucvrCl9qjiHhor0Qda9uIudAWrQNGzTRDajoBqpk
         /6JF9jpQc2+LCOiVR2Its1DFxETwpYJwwPTmaAgpBt2sP3eoTKy4IGpC/Im0VWaiCZFZ
         /+DgP0AK8xVP8IxmtCbbHNdO7LMR3wwCR9Zlt/qz2NoV9be3ANIXMe7bKaxsEORHThBQ
         o/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cVqD1iKA4+GqIY+Xphkq5i7OdQvOFXNUkDxlLeoakOw=;
        b=WDpnFpkvxYAGl+55OIGlKY/NJHTX6nijjKonV5UI5/1bEiJWRC5JKA3xDTFkepDeci
         S1lluguaJTHSFo4LktQ+YVwEtFGD6eo2xj0NJcRNrgnM6THRxR22RAPbopdHn1j/X7DL
         bJ7Hsae+xlOuPdshshObmPtYX0rBN8vsn6vIU34kJfDPuGon96MpOIcwUI1O5rv33kZd
         WFiGioFzd1uMO2gTalXc7y4rDU00lN1LKvP0MlOldk/c/XfEM0+UoGdvDFxl/S2PVHBG
         hyXf5kpOhraUzO9bAZqn5NvINAoJj7KeTB+F3FAQUU1xB8LZsvcUotYVO1UKfHVwYrXz
         y2iw==
X-Gm-Message-State: AOAM533BfjFWtQOKiSliug+aF7BOdQWPv3Ms11apV8naBguayhlFbMYx
        YbopK9Hkb71FfE49H6POHRSj8Y8hc5A=
X-Google-Smtp-Source: ABdhPJwJ0gWhC3e4g9JJm7xZE9LfMuSq2Ichx8FyGEyLf8DUyWZGv7sY9QoanhPsdtBnih2xGZ6u7w==
X-Received: by 2002:a5d:5089:: with SMTP id a9mr1482337wrt.118.1599820174111;
        Fri, 11 Sep 2020 03:29:34 -0700 (PDT)
Received: from ?IPv6:2001:718:2:119a:147:32:132:32? ([2001:718:2:119a:147:32:132:32])
        by smtp.gmail.com with ESMTPSA id b18sm3875196wrn.21.2020.09.11.03.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 03:29:33 -0700 (PDT)
Subject: Re: No space left after add device and balance
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <9224b373-82ee-60c4-4bd1-be359db75ea1@gmail.com>
 <CAJCQCtQYSPO6Wd2u=WK-mia0WTjU0BybhhhhbT5VZUczUfx+JQ@mail.gmail.com>
From:   =?UTF-8?Q?Miloslav_H=c5=afla?= <miloslav.hula@gmail.com>
Message-ID: <d1339a91-0a04-538c-59ca-30bc05b636a5@gmail.com>
Date:   Fri, 11 Sep 2020 12:29:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQYSPO6Wd2u=WK-mia0WTjU0BybhhhhbT5VZUczUfx+JQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: cs
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dne 10.09.2020 v 21:18 Chris Murphy napsal(a):
> On Wed, Sep 9, 2020 at 2:15 AM Miloslav Hůla <miloslav.hula@gmail.com> wrote:
> 
>> After ~15.5 hours finished successfully. Unfortunetally, I have no exact
>> free space report before first balance, but it looked roughly like:
>>
>> Label: 'DATA'  uuid: 5b285a46-e55d-4191-924f-0884fa06edd8
>>           Total devices 16 FS bytes used 3.49TiB
>>           devid    1 size 558.41GiB used 448.66GiB path /dev/sda
>>           devid    2 size 558.41GiB used 448.66GiB path /dev/sdb
>>           devid    4 size 558.41GiB used 448.66GiB path /dev/sdd
>>           devid    5 size 558.41GiB used 448.66GiB path /dev/sde
>>           devid    7 size 558.41GiB used 448.66GiB path /dev/sdg
>>           devid    8 size 558.41GiB used 448.66GiB path /dev/sdh
>>           devid    9 size 558.41GiB used 448.66GiB path /dev/sdf
>>           devid   10 size 558.41GiB used 448.66GiB path /dev/sdi
>>           devid   11 size 558.41GiB used 448.66GiB path /dev/sdj
>>           devid   13 size 558.41GiB used 448.66GiB path /dev/sdk
>>           devid   14 size 558.41GiB used 448.66GiB path /dev/sdc
>>           devid   15 size 558.41GiB used 448.66GiB path /dev/sdl
>>           devid   16 size 558.41GiB used 448.66GiB path /dev/sdm
>>           devid   17 size 558.41GiB used 448.66GiB path /dev/sdn
>>           devid   18 size 837.84GiB used 448.66GiB path /dev/sdr
>>           devid   19 size 837.84GiB used 448.66GiB path /dev/sdq
>>           devid   20 size 837.84GiB used   0.00GiB path /dev/sds
>>           devid   21 size 837.84GiB used   0.00GiB path /dev/sdt
>>
>>
>> Are we doing something wrong? I found posts, where problems with balace
>> of full filesystem are described. And as a recommendation is "add empty
>> device, run balance, remove device".
> 
> It's raid10, so in this case, you probably need to add 4 devices. It's
> not required they be equal sizes but it's ideal.
> 
>> Are there some requirements on free space for balance even if you add
>> new device?
> 
> The free space is reported upon adding the two devices; but the raid10
> profile requires more than just free space, it needs free space on
> four devices.

I didn't realize that. It makes me sense now. So we are probably "wrong" 
with 18 devices. Multiple of 4 would be better I guess.

Thank you!

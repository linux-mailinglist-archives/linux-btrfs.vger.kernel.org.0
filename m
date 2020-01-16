Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB9613D2D1
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 04:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgAPDhv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 22:37:51 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:35597 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729275AbgAPDhu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 22:37:50 -0500
Received: by mail-wr1-f50.google.com with SMTP id g17so17671818wro.2
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 19:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LjfyyFK6MFUMR7wFcPc8C4p2HdKSAF00tVaMekc4of8=;
        b=pIeadvQa9DU01+QCKWw/dMm4lT9/btJQV/e5dlg8M4CD4x9E4zVn+8SX2zQBZTZoWt
         TOrTdCfHF8BU6xd40X7seoT8ItelCUP3CFXqDzZ0ksYH7kyRaO9/eysFSV6dKhmceWR6
         q2bIHyD1pn5Pe7hKwLH/VeYisKx5qk+2F1waZttH/MDjogIMvCPKTHJioDyoiPF8vfSF
         1s4bjLmqhZr+MWG7h4PvNaMH0csHjgfDqcbGj3b3RDAacC59DaZ2QSZXi55BEyG4UKbr
         gHvXS++mBPYygBCwiP/DP4NQsTyvaWRPi38AqFlSHaZpm8ifA04M3u5ksZQOR+uAre8N
         RjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LjfyyFK6MFUMR7wFcPc8C4p2HdKSAF00tVaMekc4of8=;
        b=PrO7t6z3g9ZCkGPndk5XmTGbGVTpryZTKV9xkdi8nob9+o4w3NEF9+mVYkJRfOhIYZ
         Iarc9bvUfVv/xY16GBpIX7vfHVfe3ZA0IieA127vUlPWXqzAiIfkcVkG4D3sFrBxom+K
         UcMqker2q/8vN2vCWX2OC6ep+5xK3gSk+FRM+dqLbqY2/+tlWs278y0SYIG01ogrHGBT
         Z+MrJ3Am5CEDmetztxMh2jzzDPLv4GS5NUHIm9ifUuYP+Wjw5w8YBsAm6KjRpj0DS0XM
         Fxl9VJV6+pIbuAoXu4yxmgXsxD8zoeq5SduazDmRcONI4KHkV2tC+kfaUQfw0JCRCdXS
         ZF1g==
X-Gm-Message-State: APjAAAVaXtLHkHYZq3GfmgshWKBeE6p7rJnJCvixr65i4fSbZbNZ53YG
        /KR3KKA86xKLooE/MfRw/bEMaBAU
X-Google-Smtp-Source: APXvYqxKQ00tS3ANV7LsbPuYNPLNvdvqNPb14hIkaCmVF4i0UuGRR2Hxfitq4KFSRmaFxhyjq50LWg==
X-Received: by 2002:a05:6000:1142:: with SMTP id d2mr619245wrx.253.1579145868439;
        Wed, 15 Jan 2020 19:37:48 -0800 (PST)
Received: from ?IPv6:2a02:6d40:2bd5:9400:a4c6:4441:b628:8711? ([2a02:6d40:2bd5:9400:a4c6:4441:b628:8711])
        by smtp.googlemail.com with ESMTPSA id g9sm27467271wro.67.2020.01.15.19.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 19:37:47 -0800 (PST)
Subject: Re: read time tree block corruption with kernel 5.4.11
To:     Christoph Anton Mitterer <calestyo@scientia.net>,
        linux-btrfs@vger.kernel.org
References: <f2f96d17-7473-8a24-2702-37e5217ad665@googlemail.com>
 <ba2dcbb0085b186c6df859a4f5db415597fe2f8e.camel@scientia.net>
From:   Oliver Freyermuth <o.freyermuth@googlemail.com>
Autocrypt: addr=o.freyermuth@googlemail.com; prefer-encrypt=mutual; keydata=
 mQINBFLcXs0BEACwmdPc7qrtqygq881dUnf0Jtqmb4Ox1c9IuipBXCB+xcL6frDiXMKFg8Kr
 RZT05KP6mgjecju2v86UfGxs5q9fuVAubNAP187H/LA6Ekn/gSUbkUsA07ZfegKE1tK+Hu4u
 XrBu8ANp7sU0ALdg13dpOfeMPADL57D+ty2dBktp1/7HR1SU8yLt//6y6rJdqslyIDgnCz7+
 SwI00+BszeYmWnMk5bH6Xb/tNAS2jTPaiSVr5OmJVc5SpcfAPDr2EkHOvkDR3e0gvBEzZhIR
 fqeTxn4+LfvqkWs24+DmYG6+3SWn62v0xw8fxFjhGbToJkTjNCG2+RhpcFN8bwDDW7xXZONv
 BGab9BhRTaixkyiLI1HbqcKovXsW0FmI8+yW3vxrGUtZb4XFSr4Ad6uWmRoq2+mbE7QpYoyE
 JQvXzvMxHq5aThLh6aIE3HLunxM6QbbDLj9xhi7aKlikz5eLV5HRAuVcqhBAvh/bDWpG32CE
 SfQL0yrqMIVbdkDIB90PRcge7jbmGOxm8YVpsvcsSppUZ9Y8j/rju/HXUoqUJHbtcseQ7crg
 VDuIucLCS57p2CtZWUvTPcv1XJFiMIdfZVHVd2Ebo6ELNaRWgQt8DeN4KwXLHCrVjt0tINR9
 zM/k0W26OMPLSD6+wlFDtAZUng2G8WfmsxvqAh8LtJvzhl2cBwARAQABtC9PbGl2ZXIgRnJl
 eWVybXV0aCA8by5mcmV5ZXJtdXRoQGdvb2dsZW1haWwuY29tPokCPAQTAQIAJgIbAwcLCQgH
 AwIBBhUIAgkKCwQWAgMBAh4BAheABQJTHH5/AhkBAAoJECZSCVPW7tQjXfMP/j+WZ1cqg6Ud
 CUbcWYWm8ih1bD61asdkl8PG55/26QSRPyaR+836+cpY+etMDbd82mIyFnjHlqjGjmO8fr0H
 h4/SUS1Jut54y4CdJ62xG8O8Mkt/OVgEQnfv1FYKr+9MxhVrd3O1s/bubbj3WEyRwtK5NVpi
 vBTSdHwpfEPsnwUA+qeFINtp2EovaJaWvtjL+H8CmNXM9H3p4/PSzQGioaJB/qjDfvS6fwZU
 aUUdgXjtKwYl+9YTPuxVgmfmItNLjncpCXR5ZVA7Nwv3BFZGdbxLZ185yXgN/AjGHoZrjVfr
 /q+jfuhcR04kiKItugvZ7HhYyeBGcOyPexg6g0BqIxN42KAj4lfAnPOIHEPV0ZG279xUkdA3
 TP/aeM8a1rmVoH2vtQT0vAL8y2s7oy0sqVETjG5OmqWzjhzEUJLxuNhXX6dUDrzPB5VeCi2h
 P1b7Wz3AdskNyCK7zR9fipMi7olL+vAdnylfz404mDYy57OppmVxk19Tqm+DE5SHKG/sLIFi
 0+I6CBOLyVRZUob0duauP6V3uv4dkDU6noKV5vr9CJ2DzMCsREOH5DepoTi0QwmVGTISq9pE
 TRfbsjRNt9rCZq2RSFMmBBOsfsTALqH57oXYdkDcY+54DtZyz1vX1IW60tGtjkGhIdSRktlH
 /g3WSB6VUHeHwc6y3xaQ5wU/uQINBFLcXs0BEACU2ylliye1+1foWf9oSkvPSCMZmL1LMBAa
 d7Jb51rrBMl4h3oRyNQ95w9MXnA9RMk+Y6oKCQc6RS+wMKtglWgYzTw7hdORO5TX1qWri8KI
 sXinHLtQVKqlTp6lKWVX57rN4WhFkRh7yhN32iVV9d3GBh9H189HqLIVNbS3G8D83VerLO7L
 H+VIRjHBNd6nakw8AMZnvaIqiWv9SM9Kc7ZixCEcU5r3gzd1YB3N7qyJJyAcYHbGe6obZuov
 MiygoRQE3Pr7Ks7FWiR/lCFc3z1NPbIWAU2LTkLVk2JosRWuplT7faM5fzg0tLs6q9pFuz/6
 htP9c9xwZZFe+eZo247UMBwrptlugg2Yxi/dZirQ3x7KFJmNbmOD1GMe6GDB6JVO4mAhUAN4
 xpsRIukj2PMCRAMmbN/KOusCdh2XDrNN0Zr0Xo6fXqxtvLFNV/JLky2dkXtiGGtK27D76w23
 3J2Xv/AIdkTOdaZqvk8rP2zoDq8ImOiC05yfsiSEeAS++pVczrGD0OPm3FTwhusbPDsamW42
 GWu+KaNSARo0D1r9Mek4HIeErO4gqjuYHjHftNifAWdyFR9IMy4TQguiGrWMFa1jDSbYA/r+
 w3mzYbU8m1cy6oiOP1YIVbhVShE6aYzQ4RLx38XAXfbfCum/1LGSSXctcfVIbyWeDixUcKtM
 rQARAQABiQIfBBgBAgAJBQJS3F7NAhsMAAoJECZSCVPW7tQj8/kP/RHW+RFuz8LXjI0th/Eq
 RFkO4ZK/ap6n1dZpKxDbsOGWG8pcAk2g7zmwDB9oFjE4sy3O1EvDqyu68nRfBcZf1Xw1kh2Z
 sMo2D5e7Sn6jkyKTNYNztyL5GBcnXwlG/XIQvAwp4twq/8lB/Mm5OgfXb7OijyYaqnOdn7rO
 4P6LgSMdA73ljOn7duazNrr4AGhzE28Qg/S4Jm5hrSn6R/hQGaISsKxXewsKRafQsIny7c97
 eDZ3pD4RYVpFOdSVhMGmzcnNq3ETyuDITwtgP0V4v9hJbCNU1zV2oEq5tTQM2h0K8jL3WvPM
 wZ3eOxet7ljrE7RxaKxfixwxBny9wEm8zQAx1giFL7BbIc7XR2bJ3jMTmONO2mM4lj49Cjge
 pvL4u227FCG+v+ezbVHDzYPCf9TYo17Ns5tnso/dMKVpP6w5ZtIYXxs1NgPxrSTsBR9I9qE0
 /cJpiDJPuwTvg78iM5MvliENLUhYV+5j+Xj+B5v/pyPty/a1EW9G+m4xpQvAyP8jMWI8YJJL
 8GIuPyYGiK/w2UUbReRmQ8f1osl6yFplOdvhLLwVyV/miiCYC2RSx1+aUq3kJAr627iOPDBP
 SVyF8iLJoK9BFHqSrbuGQh5ewEy6gxZMVO8v4D/4nt/vzj5DpmzyqKr58uECqjztoEwXPY+V
 KB7t2CoZv5xo0STm
Message-ID: <3778c13f-a0b3-70d3-a09f-ce704e5c01fc@googlemail.com>
Date:   Thu, 16 Jan 2020 04:37:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ba2dcbb0085b186c6df859a4f5db415597fe2f8e.camel@scientia.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear Chris,

Am 16.01.20 um 02:57 schrieb Christoph Anton Mitterer:
> On Wed, 2020-01-15 at 23:04 +0100, Oliver Freyermuth wrote:
>> I have recently upgraded to 5.4.11 from a 5.3 kernel and now also hit
>> the dreaded read time tree block corruption
> 
> Is there some known corruption bug in 5.4?

I don't think so / don't know, but the tree checker became more sensitive as compared to 5.3, so I dreaded this message after I saw the density of such reports
from other users growing on the list in the past months. 

My only overlap with an earlier report seems to be that I had a situation of high memory pressure in the past weeks on the machine. 
Two other machines I run with very similar setups and significantly longer runtimes have not shown any issues. 

The affected node has the lowest runtime of the three, "but it ran fine with Kernel 5.4 for a while" and now suddenly detected the corruption in old data extens quickly after bootup.
I don't find any issues with memtext86+. 
So I'll keep an eye on the machine. At this point, anything else would be guesswork. 

Cheers,
	Oliver

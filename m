Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCAF6AABD7
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2019 21:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfIETSF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Sep 2019 15:18:05 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:53574 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfIETSF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Sep 2019 15:18:05 -0400
Received: by mail-wm1-f54.google.com with SMTP id q19so4025048wmc.3
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Sep 2019 12:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liland-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Hw+p/Z4xG0JF/9VRuAQFzBJNkBGZ/jVjfzgwqnZ2/4Y=;
        b=UKjKM7xOArGx9JduWL7/uwSxgnJa23Mskd1LZAEsk9rnaqMY6nJCZUGOclbC+89chm
         glodaGBdwsPDkf16dkop4KryIg3iwI3pIfLoP/k90ZjeJbf4uE1kdN09PTZQIU2s0XAz
         YzdEtwwecQop90+RRgBtmFQ77biGDSMcKq95vbDovJ+rB4/OQQ8kRToLYlrD+y3qhjgL
         iHJXkav1N2upBKwdWlogVOAGOvAR5EUIbgJ5ZKUWT7107VIZgUAR4ljMEct6sYJLV8gE
         BaGKiFETyTTq779yzPXcSTcn8Kjx2RWkOS9ANDLZixiDvi8apxmmTxYLmQsT/Yb+Jc6e
         LYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Hw+p/Z4xG0JF/9VRuAQFzBJNkBGZ/jVjfzgwqnZ2/4Y=;
        b=bQ1IowJux//KL7LOnea59PRbS4luyPhs7a0ZSlw6UaCvP2vrs+TVCq2QBwhvmDAiqA
         YI17QC1GPz3ccs7Pjae9vqTTJMUVROpqvCXKA1P6QTkTzX2K63ZH7erugzDpMFjEntdy
         93y28igbhGvmGBDt+FOQv94PdC6T+Whl/yWN0LZdnUENJ3gQt/lIjYZCP4voz452Q9TO
         T7UYn4xLSRQnQTJswXdeo3V/rbCts8VTpZO0WLPPm0P7OaU1/wvSZqv0aPRNYgHAAAN2
         9kWauLO093tmsTqy67l6SWnorU28fDjjLorOEMRi2HNW9iwVO/rP31JMl8XNU3dTmyNt
         F8ig==
X-Gm-Message-State: APjAAAVDa3nAdrSSFqAWYkolVrckF4IQ2HooFBby11QLisoP2rlYzQUK
        6e8Nqjsxvh8jMsOclhbe7UnDa4UYSG0katzIEAU9A2RG8TNZktz3UdAotHstHWITvi8t0tmByng
        hCf/sAwXNOfG3EEExHAPXmA==
X-Google-Smtp-Source: APXvYqxThCK+dqmwXVQNwV+1IHimdCOL0a30clK1Nz9TOCFVVDZGk4eMaxMeXQZkHbY8iI35VKmqUQ==
X-Received: by 2002:a1c:1dd4:: with SMTP id d203mr4378969wmd.45.1567711082542;
        Thu, 05 Sep 2019 12:18:02 -0700 (PDT)
Received: from [192.168.42.1] (84-112-118-202.cable.dynamic.surfer.at. [84.112.118.202])
        by smtp.gmail.com with ESMTPSA id a192sm4303140wma.1.2019.09.05.12.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 12:18:01 -0700 (PDT)
Subject: Re: Unmountable degraded BTRFS RAID6 filesystem
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <f58d5ec1-4b38-ad8b-068d-d3bb1f616ec2@liland.com>
 <CAJCQCtTqetLF1sMmgoPyN=2FOHu+MSSW-MGsN6NairLPdNmK+g@mail.gmail.com>
 <c57b8314-4914-628c-f62b-c5291a6be53c@liland.com>
 <CAJCQCtT5WecG26YXE6EVwhv52xSY_sm8GqgLDoQbZBUom4Pw7Q@mail.gmail.com>
From:   Edmund Urbani <edmund.urbani@liland.com>
Message-ID: <51d54d67-bfd3-ee18-d612-330d07d9f714@liland.com>
Date:   Thu, 5 Sep 2019 21:17:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtT5WecG26YXE6EVwhv52xSY_sm8GqgLDoQbZBUom4Pw7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 04.09.2019 07:36, Chris Murphy wrote:
>
>>>
>>>> I have tried all the mount / restore options listed here:
>>>> https://forums.unraid.net/topic/46802-faq-for-unraid-v6/page/2/?tab=3D=
comments#comment-543490
>>> Good. Stick with ro attempts for now. Including if you want to try a
>>> newer kernel. If it succeeds to mount ro, my advice is to update
>>> backups so at least critical information isn't lost. Back up while you
>>> can. Any repair attempt makes changes that will risk the data being
>>> permanently lost. So it's important to be really deliberate about any
>>> changes.
>> I'll let you know, when I have the new kernel up and running.
> I think you should have all the original drives installed, and try to
> mount -o ro first. And if that doesn't work, try -o ro,degraded, and
> then we'll just have to see which drive it doesn't like.

Things are finally looking up. I have replaced both sdb and sdf with=20
ddrescue'd copies. sdb had some 10MB bad sectors and sdf 8KB which could=20
not be recovered.

I am now able to mount the volume again. :)

btrfsck /dev/sda1

Opening filesystem to check...
Checking filesystem on /dev/sda1
UUID: 108df6ea-2846-4a88-8a50-61aedeef92b4
[1/7] checking root items
checksum verify failed on 34958760591360 found E4E3BDB6 wanted 00000000
checksum verify failed on 34958760591360 found E4E3BDB6 wanted 00000000
parent transid verify failed on 34958760591360 wanted 3331734 found 1544337
checksum verify failed on 34958760591360 found 04DEBA71 wanted B9FBE54D
checksum verify failed on 34958760591360 found 04DEBA71 wanted B9FBE54D
bad tree block 34958760591360, bytenr mismatch, want=3D34958760591360,=20
have=3D27967614209536
ERROR: failed to repair root items: Input/output error

Anyway, I am about to mount it read-only again to try and backup a few=20
things. And once I am done with that, should I run btrfs scrub?

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


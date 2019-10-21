Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61D17DF150
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 17:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfJUP16 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 11:27:58 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:53537 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfJUP16 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 11:27:58 -0400
Received: by mail-wm1-f49.google.com with SMTP id i16so13819352wmd.3
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 08:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liland-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Brl5AWXM71hF9rdolS1WFaiWGE9ik+7jokzQG/KsuDM=;
        b=2GFdufV7DqvAvwWXHZ0fBdpy+jd/29qudH8kUCz1vG4seueZX7Ntnq4FrW/HW3YJVY
         0CFhJdS++M+WxBvRsgUP+Z189l2aLgkKZD89lHaAgNKLQPKkoNFlyLLKVSkba217rx2M
         KSD6LIOodQgqdyNnZX4zXKKcDKpj9QbkazpBKcjTSF1JsOpMhHafssat2m+1AJ6hiDHZ
         3sqaNsZ9X13q7x4rNu2fJtOF24UfpZcbpCq4CYWT97AUABJX2+mdaZrgZErE6zH5uxjc
         tj0l/y0ekCNFZLZpy1sPaWaxvyRMFGY0Pqgd096Z/XzzrMlxcPqOcPVKeyvJs56Rpyxa
         xBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Brl5AWXM71hF9rdolS1WFaiWGE9ik+7jokzQG/KsuDM=;
        b=c0/IFw/TBlNgBGQQOZ82+Tj/TU2tIk5g31ngj9gV1GwJXWGwxz39nmAU3Qe4jWYFwC
         bkXruc7f0dO/ylA5QeGlXnLDFhoI+iz7FJ2ScBlGV2O18xwDpiYcN6XIKL3ToODxJS9O
         Fbm5S+tLSSGE/jLMUryCNOYohNJiLpWYDr72b6sbT1kwkE2yIlTd0DJWAK4JgudRvJeJ
         4ACbYJSKzZd9G5AchlaRWeCl7Y/6tSp3d0cthlFeaeBWfc+VVBpZ51BK9GkSHYLNLdAL
         qkLaX244gmouEfz61Noq2yQtIGg/3D/4Q4HlL9zWFxcfBQzLpj8OoDMMzjCGvxhg/pmD
         mslg==
X-Gm-Message-State: APjAAAWcqnLthaQy8su4Zo9sdCoJF0NUSGuMjLzYqhJDqHbJg2bWgeuK
        BbJ31iwV01spqnjCitBx/BgagmQMGwrZW8ye0NGkktSVJhVAIpdJ0Gl542xh8F31eAWaJfpRuBw
        HgUJhnUlLfy7XogzffHxM+zs/P7o=
X-Google-Smtp-Source: APXvYqxEDTiF/cB1zsyOS9Te3Xt14xmljgPltE0eq8O1jnQ0JZFoW4WfjdEr7QVFJiQ2lVd8PT6uug==
X-Received: by 2002:a1c:3b42:: with SMTP id i63mr18502856wma.37.1571671676418;
        Mon, 21 Oct 2019 08:27:56 -0700 (PDT)
Received: from [192.168.0.121] ([62.218.42.35])
        by smtp.gmail.com with ESMTPSA id f83sm15109030wmf.43.2019.10.21.08.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 08:27:55 -0700 (PDT)
Subject: Re: MD RAID 5/6 vs BTRFS RAID 5/6
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <b665710c-5171-487b-ce38-5ea7075492e4@liland.com>
 <20191016194237.GP22121@hungrycats.org>
From:   Edmund Urbani <edmund.urbani@liland.com>
Message-ID: <067d06fc-4148-b56f-e6b4-238c6b805c11@liland.com>
Date:   Mon, 21 Oct 2019 17:27:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191016194237.GP22121@hungrycats.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/16/19 9:42 PM, Zygo Blaxell wrote:
>
> For raid5 I'd choose btrfs -draid5 -mraid1 over mdadm raid5
> sometimes--even with the write hole, I'd expect smaller average data
> losses than mdadm raid5 + write hole mitigation due to the way disk
> failure modes are distributed. =20

What about the write hole and RAID-1? I understand the write hole is most
commonly associated with RAID-5, but it is also a problem with other RAID l=
evels.

You would need to scrub after a power failure to be sure that no meta data =
gets
corrupted even with RAID-1. Otherwise you might still have inconsistent cop=
ies
and the problem may only become apparent when one drive fails. Can we be ce=
rtain
that scrubbing is always able to fix such inconsistencies with RAID-1?

Regards,
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


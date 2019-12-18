Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0B8E124C61
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 17:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfLRQDx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 11:03:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38847 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfLRQDx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 11:03:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so2889477wrh.5
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2019 08:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liland-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=t/pnXy8vI2aowQ8T32GI6hY4nQbDPvZtn5+bAa69Frc=;
        b=l4BZj08bk9NMO+LLm+/IfitVdQ7WaLG9pnrnE63ZAOfo/9AjBBJp/CNPfVLTJnFn7G
         HtCSuY8NBSoySHovoCUn2CR6BcdbcK6DLkkIF7nwQSgfRo9W/28CGHaW2obJrSfGfs8G
         eClmiE44QO0MPbHuFOvkRdo7ukJo1BM9l4a9m5I2oemsI6HRpoVPi8CY/9TjF+g/2rDZ
         cw/2/4xy9jB/S0cnG6JxPpF+asFbD9u69z3poNpXkCgtXa5mmsCAKdqDUKlZeDJ8pBn4
         QdmrAnjgrGHDRB5CHQab/PZ9LFSmMxtCHTctM697CGg04PD+Sb0HbZz7j0BzFNKy3dgV
         CgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=t/pnXy8vI2aowQ8T32GI6hY4nQbDPvZtn5+bAa69Frc=;
        b=h7lKxv4pzzkMsspo0fk4AMzdfKameA6RiQIG1+H2RKGWIs0McQbjy63fPe5gb6Ucjo
         czAoEdJyg0phxM9kOB2lVk/T+A+mwRwKg2Iaw6czXCMXRo4owje02UoPlHg01dNYNl07
         qz9t1LTLhAypHI5tmuxTOirQeKYkecb3UIPUfpXLKB5yLeYy+tH6vcdCw2AgFqE/3znS
         s1wPwJzq0UKF7pkEeuMFRjSXnoRrYLj1O2gJSRjdVGXGbsX4LPz2xb3MUPdZ626KHFxn
         xPs+RKI2aVmbqaCZjq94GMX41BbY4vCEbYVfl6U5xFVVaXVcOMWCA/QNTtEYaLSnbn7Y
         Fisg==
X-Gm-Message-State: APjAAAVKTL7lCo8AjntZ7Tc7cujB7/T5BKqFJ8IF6mALgDHGoIBNUd0o
        dndR3Ya93RACOiPb/Ei+yo15v9BldSdJFEt7wNxyACtsc8ommYnzvHX2NAkG05FIThKZamhnZSa
        OMF+NkalkZRiUJ+5/NYXIq515p8Q=
X-Google-Smtp-Source: APXvYqyjbIP5M0P91asE9H2MuxIQR0oj8/SbgzWhLHzqDa4+c1e+sIFx5FUyWGfbClJ+yCvX4ZgOiw==
X-Received: by 2002:a5d:5452:: with SMTP id w18mr3515395wrv.333.1576685030838;
        Wed, 18 Dec 2019 08:03:50 -0800 (PST)
Received: from [192.168.0.137] ([62.218.42.35])
        by smtp.gmail.com with ESMTPSA id n3sm2963789wrs.8.2019.12.18.08.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 08:03:50 -0800 (PST)
Subject: Re: Btrfs wiki appears to be down
To:     Paul Richards <paul.richards@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAMosweh1AsdGg2CNPiA7uUYS5FMUkTP5c6RcNdrDwu+VkmfV+g@mail.gmail.com>
From:   Edmund Urbani <edmund.urbani@liland.com>
Message-ID: <a7c9f543-0e51-e34b-be24-63cc3c38ced1@liland.com>
Date:   Wed, 18 Dec 2019 17:03:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMosweh1AsdGg2CNPiA7uUYS5FMUkTP5c6RcNdrDwu+VkmfV+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/18/19 3:08 PM, Paul Richards wrote:
> I'm not sure who to route this to, but the Btrfs wiki pages appear to
> be down.  Various URLs are returning HTTP 503 for me.  Tested from
> different machines and connections.
>
> https://btrfs.wiki.kernel.org/index.php/Main_Page
>
> https://btrfs.wiki.kernel.org/index.php/FAQ

It's not just the Btrfs wiki. The entire kernel wiki seems to be down.

(503 Service Unavailable: Back-end server is at capacity)


--=20
*Liland IT GmbH*


Ferlach =E2=97=8F Wien =E2=97=8F M=C3=BCnchen
Tel: +43 463 220111
Tel: +49 89=20
458 15 940
office@Liland.com
https://Liland.com <https://Liland.com>=C2=A0
=20
<https://twitter.com/lilandit>=C2=A0 <https://www.instagram.com/liland_com/=
>=C2=A0=20
<https://www.facebook.com/LilandIT/>

**Auch in der Vorweihnachtszeit wird=20
die Nachhaltigkeit von uns gelebt - anstatt Weihnachtsgr=C3=BC=C3=9Fe per P=
ost zu=20
versenden, schonen wir W=C3=A4lder und Ressourcen und w=C3=BCnschen Ihnen a=
uf diesem=20
Wege eine stressfreie und besinnliche Vorweihnachtszeit.**

**We also=C2=A0 live=20
sustainability in the Christmas season - instead of sending Christmas=20
greetings by mail, we protect our forests and resources and wish you a=20
stress-free and jolly season.**

Copyright =C2=A9 2019 Liland IT GmbH=C2=A0

Diese=20
Mail enthaelt vertrauliche und/oder rechtlich geschuetzte=C2=A0Informatione=
n.=C2=A0

Wenn Sie nicht der richtige Adressat sind oder diese Email irrtuemlich=C2=
=A0
erhalten haben, informieren Sie bitte sofort den Absender und vernichten=C2=
=A0
Sie diese Mail. Das unerlaubte Kopieren sowie die unbefugte Weitergabe=C2=
=A0
dieser Mail ist nicht gestattet.=C2=A0

This email may contain confidential=20
and/or privileged information.=C2=A0
If you are not the intended recipient (or=20
have received this email in=C2=A0error) please notify the sender immediatel=
y and=20
destroy this email. Any=C2=A0unauthorised copying, disclosure or distributi=
on of=20
the material in this=C2=A0email is strictly forbidden.

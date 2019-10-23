Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA97CE20A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 18:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404708AbfJWQcL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 12:32:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41856 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403862AbfJWQcL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 12:32:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id p4so22828033wrm.8
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 09:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liland-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=K2xvIgIomuhRkjMboE+rbpmRgaddDUn5FeGa6Iwlg58=;
        b=GppzvdHDOk5LbTDSwLxtQpNQgKePRH2zzaoIEH8aeUumBSJT/SH7qNqSEfs0Ivk78E
         Y0Wk3r8NCX5o0FAD9EdHZwy3jSNe6jg7cKQMxzA3m9UQZLQ+/zKU2FaHyd8h6DMtXGcO
         A/p0Jb3ezJBw8ToHkOxDGAYVTWCqmzRg37HWpCkfmUZvRN1Xe9Uyg5pTK7rrFFQX+UQ3
         jmUTWoAb8zeG4jbQ88VBL6oISHh5PJURG5wRD7vh0bYYdXvKhYpefT7Uz+JdeW5G0xb3
         DEN61kGZbxqUEquwQeAJR+gyDG9kgYLozlvvxgw0dyAUUw1yw64Yn96v9FQNM4r0Nqm/
         Yi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=K2xvIgIomuhRkjMboE+rbpmRgaddDUn5FeGa6Iwlg58=;
        b=YFCYbEDSjae8IFJfY9sCVoc4UhGhRH1dZ+4hOBa+GQMGE/Ayn0BC2OvJub9EkMUTNK
         9ZtJktYnIxYJp4qaC9ocs7wYjx58LOSiAZMbU93lRnhoFMxudIIyCqNZ7zzViIhpEx/l
         U8UkcLrMfUYtzppmDC9qCY3GH+Grz25k34Fbd4BId7BwkYoMbNhAtDgmy69khficNkcS
         Q3wFJ+qKQRCkHWXUf02LtwIH7aWkQzvGm90br8lrBbar8SgDUKmn3aZg7sw6MCZHNrrm
         SCMO96empSIf3pIsCzGJk5dC76o1fgTglIpusGYKX/oPdy0DzpueSkiPQJONDFHv+OOG
         kztQ==
X-Gm-Message-State: APjAAAWb4zV70By9bObi2tu9nTD7bKfIMwoeLYGmKeqVU297YBPsY62e
        cFYSezQlAqs7DdQHN1tq3ISAkz5sjYC9IAhbNJ0fnZ+c2VVzQVW9D/4JJGj0WBxQVG102XFFHAT
        eQ3FhDNAxvKhJRM1iKtj6XmKa
X-Google-Smtp-Source: APXvYqwKWIfNUtGB8VUN8aOAAypiLbpNUGlywyPrUNago1vMOeVfgwMYHlBWUzWi8e8kdBv3NTKoZA==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr9469503wrs.358.1571848327260;
        Wed, 23 Oct 2019 09:32:07 -0700 (PDT)
Received: from [192.168.0.121] ([62.218.42.35])
        by smtp.gmail.com with ESMTPSA id r1sm16476051wrw.60.2019.10.23.09.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 09:32:06 -0700 (PDT)
Subject: Re: MD RAID 5/6 vs BTRFS RAID 5/6
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <b665710c-5171-487b-ce38-5ea7075492e4@liland.com>
 <20191016194237.GP22121@hungrycats.org>
 <067d06fc-4148-b56f-e6b4-238c6b805c11@liland.com>
 <20191021193417.GP24379@hungrycats.org>
From:   Edmund Urbani <edmund.urbani@liland.com>
Message-ID: <81f11e36-fd40-967c-74e8-f5c29803dacf@liland.com>
Date:   Wed, 23 Oct 2019 18:32:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191021193417.GP24379@hungrycats.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/21/19 9:34 PM, Zygo Blaxell wrote:
> On Mon, Oct 21, 2019 at 05:27:54PM +0200, Edmund Urbani wrote:
>> On 10/16/19 9:42 PM, Zygo Blaxell wrote:
>>> For raid5 I'd choose btrfs -draid5 -mraid1 over mdadm raid5
>>> sometimes--even with the write hole, I'd expect smaller average data
>>> losses than mdadm raid5 + write hole mitigation due to the way disk
>>> failure modes are distributed. =20
>> What about the write hole and RAID-1? I understand the write hole is mos=
t
>> commonly associated with RAID-5, but it is also a problem with other RAI=
D levels.
> Filesystem tree updates are atomic on btrfs.  Everything persistent on
> btrfs is part of a committed tree.  The current writes in progress are
> initially stored in an uncommitted tree, which consists of blocks that
> are isolated from any committed tree block.  The algorithm relies on
> two things:
>
> 	Isolation:  every write to any uncommitted data block must not
> 	affect the correctness of any data in any committed data block.
>
> 	Ordering:  a commit completes all uncommitted tree updates on
> 	all disks in any order, then updates superblocks to point to the
> 	updated tree roots.  A barrier is used to separate these phases
> 	of updates across disks.
>
> Isolation and ordering make each transaction atomic.  If either
> requirement is not implemented correctly, data or metadata may be
> corrupted.  If metadata is corrupted, the filesystem can be destroyed.

Ok, the ordering enforced with the barrier ensures that all uncommitted dat=
a is
persisted before the superblocks are updated. But eg. a power loss could st=
ill
cause the superblock to be updated on only 1 of 2 RAID-1 drives. But I assu=
me
that is not an issue because mismatching superblocks can be easily detected
(automatically fixed?) on mount. Otherwise you could still end up with 2 RA=
ID-1
disks that seem consistent in and of themselves but that hold a different s=
tate
(until the superblocks are overwritten on both).=C2=A0

> The isolation failure affects only parity blocks.  You could kill
> power all day long and not lose any committed data on any btrfs raid
> profile--as long as none of the disks fail and each disk's firmware
> implements write barriers correctly or write cache is disabled (sadly,
> even in 2019, a few drive models still don't have working barriers).
> btrfs on raid5/6 is as robust as raid0 if you ignore the parity blocks.
I hope my WD Reds implement write barriers correctly. Does anyone know for =
certain?




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


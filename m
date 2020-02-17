Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED382161D9F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 23:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgBQWzT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 17:55:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39568 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgBQWzT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 17:55:19 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so21642656wrt.6
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2020 14:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x+w3uBlU+REmyjXq7pdfo+wNv+b/HzSpzk/6HDeba/o=;
        b=plWY3ydeVgxN42jvNIRTsrGY7mldckv5VA3yB8Fda9/Mf/fFmwbaBm4QSi0j6rA+2j
         i4mqKi72CErD4478ImTyLDr01O7tUSO9wBoVMU/9DorNz1YzNv8A7Ze2VInvAnrV3dUM
         RsCVnTGRTGiSOVZL5cD3ikEBC8dOmSKX3uLZUDY0srjz7pM8/RAh1bXgyHxRxIDTPpmu
         vmbICUXlL20KkkdmyQLVoj2k3gi8hm2TeSFTUiA0toDdn1MwH1GQ8Md8wpZ6LZ3hCLkp
         /dkea43tXwn4rBCoGubwCEBnzQL5di05so0xTS0wWRujoi7TCyLN4OAQSNRBgfB70Dpb
         k4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x+w3uBlU+REmyjXq7pdfo+wNv+b/HzSpzk/6HDeba/o=;
        b=QKgMr3XyCULSjL0pxOB+O/EMSH+qw8pX45GuDxJa6UYwe4uijDbVqXMj14goLJT8n0
         V0VhhlIdUiO8QewZ9NZTyOZfuQ3RZYR7XTzli6dTvJCx4uDhpyQqVM442Dh+O4FV5iFc
         RfhwGlSRRajZ7JiwRIqiF/FWejfk2OaSQI2uPgftuqbvS1rmjGO7hc0KyoWOgzB6LbHy
         ZC+s38SCNVbM61m6Co0zGCEfLTZyQw7Unch94KuKyv5Hjm0R39QrDkarYfHRNh0QElb0
         ZrezVwp3IlqEBt+L/pT6x645y3Idhe6kpl1Wm/OOTk5f+QxYaiOQz58TIBML7z4a5wwX
         7Mnw==
X-Gm-Message-State: APjAAAWZYmkiAnUWmrxsb2HTGh9KCMyfAkBVJlTgMjSWy9ySqIpAjnuw
        M+Hx8O5Tv6pwlOd32UjqaJwOu3N/rhnK7Q8DBEuOxFfOC80=
X-Google-Smtp-Source: APXvYqwIPncdo9v9C/Eh8VZ2/fhKjRqHl1u0mee8FK78bggNdjB65RatLw1rzOCppYZuXvRhHF+U5wLEaqMBImompyg=
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr23733444wrp.236.1581980118023;
 Mon, 17 Feb 2020 14:55:18 -0800 (PST)
MIME-Version: 1.0
References: <8fb8442b-dbf9-4d4b-42bb-ce460048f891@sfelis.de>
In-Reply-To: <8fb8442b-dbf9-4d4b-42bb-ce460048f891@sfelis.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 17 Feb 2020 15:55:02 -0700
Message-ID: <CAJCQCtSUxC8uF5fAFSOGUDHfRJCY_x8uCSGZ_r_63961Tb17+g@mail.gmail.com>
Subject: Re: kernel incompatibility?
To:     Simeon Felis <simeon_btrfs@sfelis.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 16, 2020 at 2:25 AM Simeon Felis <simeon_btrfs@sfelis.de> wrote=
:
>
> I had a btrfs raid1 running on raspbian (linux 4.19 arm) which overheated=
. To fix corruptions I attached the raid1 on my workstation (linux 5.5 x86_=
64) and performed scrub, defrag and --full-balance (not necessarily in this=
 order) and fixed the corruptions.
>
> Back on raspbian a mount fails:
>
> root@omv:~# mount /dev/disk/by-label/URAID /mnt/URAID/
> mount: /mnt/URAID: wrong fs type, bad option, bad superblock on /dev/sda1=
, missing codepage or helper program, or other error.
>
> dmesg-4.19 attached.

Because you get this on 4.19.97 (which is the latest kernel on Arch
for ARM v7l), but it mounts OK on 5.5 on x86_64, I'm suspicious it's
an arch specific bug. I don't offhand see any applicable updates
through 4.19.103 that would fix this problem.

It might be interesting to know if kernel 4.19.97 on x86_64 has this
same problem.

[   26.841239] Btrfs loaded, crc32c=3Dcrc32c-generic
[   26.845640] BTRFS: device label URAID devid 7 transid 1254652 /dev/sda1
[   26.851548] BTRFS: device label URAID devid 8 transid 1254652 /dev/sdb1
[   27.301605] BTRFS info (device sda1): disk space caching is enabled
[   27.301620] BTRFS info (device sda1): has skinny extents
[   27.304203] BTRFS critical (device sda1): unable to find logical
4306137776128 length 4096
[   27.312686] BTRFS critical (device sda1): unable to find logical
4306137776128 length 4096
[   27.321193] BTRFS critical (device sda1): unable to find logical
4306137776128 length 4096
[   27.329714] BTRFS critical (device sda1): unable to find logical
4306137776128 length 4096
[   27.338227] BTRFS critical (device sda1): unable to find logical
4306137776128 length 4096
[   27.346637] BTRFS critical (device sda1): unable to find logical
4306137776128 length 4096
[   27.355110] BTRFS error (device sda1): failed to read chunk root
[   27.408326] BTRFS error (device sda1): open_ctree failed

I suggest running a (read-only no repair) 'btrfs check' using
btrfs-progs 5.4 on x86_64 and see if it complains about anything. And
also the output of a superblock, 'btrfs insp dump-s /dev/' for either
device.

--=20
Chris Murphy

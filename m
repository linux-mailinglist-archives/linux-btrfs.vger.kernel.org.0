Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A20F8F9903
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 19:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfKLSos (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 13:44:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38527 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLSos (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 13:44:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id z19so4095279wmk.3
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2019 10:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=IX9pjmQNDmfEw4TTOz27/lyq7vGYZYB/DY//VliEV/8=;
        b=1FrJAXsB+zDzEAAUy2NTd9zNwQ6o1Edytv4x8spn62LMpzKVTWKLlq73MmyTv81Jao
         jUNx/uds5tG5cffwFHqZCOoB5j8o11B66wJJKyqa4YMGpzCqfsgmzd4iqk+VNFahQigg
         5Nv7lhy3yhFs0x4dL5LkArHqRw8sMth4NStgNirPVNfN5R4LNLewVLILf+HZHeCvNxn7
         PMS2CCmX7Nohw9Sz//RgG0TwX/bxoknMRNW0fwa6AFI8nyhH9HB+pRW6EDSmOjXG1bXz
         ZWgqQCAyicgnVWPLiK20I5s0spgbxj8CQIMtV9DTqy6UQOEATGpJ8y7aYP+xM8ukHW/Y
         NM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=IX9pjmQNDmfEw4TTOz27/lyq7vGYZYB/DY//VliEV/8=;
        b=R1FZBBHPF3tMxZAfkPGUA2BWBgM1xPVZz624nTWjmq1bQsdueLD1xmsWJwj7iS/y3y
         cd5m0YtetgXYoL+1+41sqjvOC9dIK8B+ki7Ne959/KpCST3yYdHH8bGrFYYkD+uoj0tD
         S9+I4qBmX9gqC4aCiEj7Qd3gbmRyZa98zLhGe1+v3yx3HnzEgm5VH1iCm1Od6kBgqA90
         soKbVv3EF+eQung4qP6Celsyqf81Mkw0NKAKBeDpQ6/xH1q4J26PoZyw6QX26qZw6cOr
         ERuDycgsu1HczlFEC0cmnrhs4lIWQ1mlW95t/a13u08uU7n0SsDpoCG88u8XHNxskVkn
         nTzw==
X-Gm-Message-State: APjAAAWxhq9Tnx9vzpjhNE4rkA7GNqO79BqdKHd43XQeSTjpd62FaXoV
        Kmorp/p8YYwTRInOYi2TXybv9Q0WnX2W/KZD6+z61g==
X-Google-Smtp-Source: APXvYqwDnSnyBEyynLDc4Vq/A9coOtGABpdxrqULQNi7nA7NiRR+gSdmBlbS4oP59ZoEPOVea9vLyhYzHziP7bLymq8=
X-Received: by 2002:a05:600c:2383:: with SMTP id m3mr5201392wma.66.1573584284594;
 Tue, 12 Nov 2019 10:44:44 -0800 (PST)
MIME-Version: 1.0
References: <0JG8IAF11@briare1.fullpliant.org>
In-Reply-To: <0JG8IAF11@briare1.fullpliant.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 12 Nov 2019 18:44:09 +0000
Message-ID: <CAJCQCtR7dL3yb+x3_ZF46U6Pbdn20257pBpwGBAErq8wubNVfw@mail.gmail.com>
Subject: Re: Avoiding BRTFS RAID5 write hole
To:     Hubert Tonneau <hubert.tonneau@fullpliant.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 12, 2019 at 2:28 PM Hubert Tonneau
<hubert.tonneau@fullpliant.org> wrote:
>
> Hi,
>
> In order to close the RAID5 write hole, I prepose the add a mount option that would change RAID5 (and RAID6) behaviour :
>
> . When overwriting a RAID5 stripe, first convert it to RAID1 (convert it to RAID1C3 if it was RAID6)
>
> . Have a background process that converts RAID1 stripes to RAID5 (RAID1C3 to RAID6)
>
> Expected advantages are :
> . the low level features set basically remains the same
> . the filesystem format remains the same
> . old kernels and btrs-progs would not be disturbed
>
> The end result would be a mixed filesystem where active parts are RAID1 and archives one are RAID5.
>

Interesting idea. It would be a compat_ro feature at worst, plausibly
it could be a compat feature, just without the guarantees offered by
the feature if using an older kernel.

Thing is, I'm not sure it's possible to convert just one stripe. I
think the minimum conversion unit is the block group. What is the
performance penalty if only full stripe writes were allowed? If
there's never RMW for a stripe, it avoids the write hole in the first
place. For some workloads the performance may be bad, in which case
the option to do COW as raid1 or raid1c3, later converting it to
raid56 would be better. In effect it'd be using raid1 for performance
and safety, and raid5 for efficiency.

I think most people would prefer raid1, 2 or 3 copies, for metadata,
by default, in lieu of raid56.


-- 
Chris Murphy

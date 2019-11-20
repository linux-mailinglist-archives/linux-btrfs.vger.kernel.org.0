Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E33C1042B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 18:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfKTR73 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 12:59:29 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:42693 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfKTR73 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 12:59:29 -0500
Received: by mail-wr1-f41.google.com with SMTP id a15so913649wrf.9
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 09:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3N8QwAodFV/KpUdXe9P7ka7MRSoHyrBOap3xFmv+AJA=;
        b=Bqj77wb7r278pKbbI1u96pAafwAuNyYHYE6fkd0+n/VqPVz26ZDd4odLY80Guo8yOk
         9pzk104M/baDlG63z+bvcvBUJMPcyFAntZoOgF3SPNI3t00yanMHzVxAHuMRl/Uslplt
         gWMQe7OofqYC8asCmK4y41d/BqON3NZ0NKWznKw0AKoKaU9iVmhTqhQ59hPoZiNUlS4p
         q1ot73fr+2mVkcFlLazgRBjwBfV4eahT7GWkxko+rTwQnNw+77GscoHAyoQ9m+q8sFe0
         ABc+WeWrfeDCtDUzDyTb8I1D3wCwFUJ2/Il4PPt7n6lpBO9JgZfjKwRfze9lhE7O6kBn
         TLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3N8QwAodFV/KpUdXe9P7ka7MRSoHyrBOap3xFmv+AJA=;
        b=dJEq0s5vrAugO30qrylYwtQPV8DzGjxkwZfE1rt7TD1AF08m3uKLeJuVPqxIywEZXi
         CUKDh9mir2m4U2Q9kGLIvPWpS3N92QcrjsjPeIGQgBDojtCVgnczx6NKBnhZAgI7JUJb
         mS4cLy+VGR/srsJOzssO+2PAsvUFO0gedOPtQqWoDVAuo6eMMJB6reaHvtyeKjokUNpB
         /h0y7u104RNigVw0sm7EIA2hfMnaaGgk0Q8cS7v3GUQRRIG8qCbSgdSVZS5/fUScq6L/
         B+5p2LVOHZ0vBj04br4+/XIzBQ6ZMmMpMvyaZYAzIjAOCfYiiLgic/9lf2yMoaIVsuTH
         ElHw==
X-Gm-Message-State: APjAAAWM1fhWRmSy24Mp/sSU44J7qFAOCwk0vqq7Dj+abq5R+u10D+mg
        HQ+/K4UIu/M264eaf2XAva00FCs3
X-Google-Smtp-Source: APXvYqy5XHXEpcSDX9wZml7FPOomT7zEYU6kwDUndpHy+98qm7sRg6vPCktfWydz/avJdy8auoeO6g==
X-Received: by 2002:adf:d844:: with SMTP id k4mr4910257wrl.333.1574272765934;
        Wed, 20 Nov 2019 09:59:25 -0800 (PST)
Received: from [131.220.167.200] (lt-freyermuth.physik.uni-bonn.de. [131.220.167.200])
        by smtp.googlemail.com with ESMTPSA id h124sm36040wmf.30.2019.11.20.09.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 09:59:24 -0800 (PST)
Subject: Re: freezes during snapshot creation/deletion -- to be expected?
 (Was: Re: btrfs based backup?)
To:     Christian Pernegger <pernegger@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20191112183425.GA1257@tik.uni-stuttgart.de>
 <7f628741-b32e-24dc-629f-97338fde3d16@googlemail.com>
 <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
From:   Oliver Freyermuth <o.freyermuth@googlemail.com>
Autocrypt: addr=o.freyermuth@googlemail.com; prefer-encrypt=mutual; keydata=
 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
 KB7t2CoZv5xo0STm
Message-ID: <2e4d827d-9c63-500a-3534-57d6c95760d8@googlemail.com>
Date:   Wed, 20 Nov 2019 18:59:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I'm using a ~4 year old laptop, 4 cores (+4 HT), 32 GB RAM,
Crucial mSATA SSD and don't notice neither the snapshotting nor the deletion of snapshots nor the transferring at all
(been doing this for years now). 

I'm running kernel 5.3 now, but have also been on 5.0 some time ago (but I'm on Gentoo, not Ubuntu). So I'd say this is not normal. 

The first thing you'd need to check is when exactly it happens - btrbk logs the steps it is doing. Does it happen during the snapshotting, transferring,
or deletion of snapshots? Anything in the kernel log? 

Did you run a deduplication tool on the BTRFS volumes, or use quotas? These are the only things which come to my mind which can cause high CPU load here
(but in any case, nothing should "block"). 

Cheers,
	Oliver


Am 20.11.19 um 17:36 schrieb Christian Pernegger:
> Hello,
> 
> I've decided to go with a snapshot-based backup solution for our new
> Linux desktops -- thank you for the timely thread --, namely btrbk.
> A couple of subvolumes for different stuff, with hourly snapshots that
> regularly go to another machine. Brilliant in theory, less so in
> practice, because every time btrbk runs, the box'll freeze for a few
> seconds, as in, Firefox and LibreOffice, for instance, become entirely
> unresponsive, games hang and so on. (AFAICT, all it does is snapshot
> each subvolume and delete ones that are out of the retention period.)
> 
> I'm aware that having many snapshots can impact performance of some
> operations, but I didn't think that "many" <= 200, "impact" = stop
> dead and "some operations" = light desktop use. These are decently
> specced, after all (Zen 2 8/12 core, 32 GB RAM, Samsung 970 Evo Plus).
> What I'm asking is, is this to be expected, does it just need tuning,
> is the hardware buggy, the kernel version (Ubuntu 18.04.3 HWE, their
> 5.0 series) a stinker, something else awry ...?
> 
> Cheers,
> C.
> 

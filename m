Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0B711BBD6
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 19:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbfLKSiD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 13:38:03 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:39086 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfLKSiD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 13:38:03 -0500
Received: by mail-wm1-f44.google.com with SMTP id d5so6578870wmb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2019 10:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lIL3/IPGPxPH1XP2vvboocirNCVAeNwvDhqeW8pCsaI=;
        b=NIddKzx3ZPosIZTrIB2kM96OWiMJ7C2i9lT3bpLttOedmELPF7RKVsxoaJ6NEvSLpP
         +2IoP6fvoHKqL7ekjpHPVQagC53s6IiiBJzd9Igm94bEAeShMKl8bw3ezHSy0xOjk2nE
         ey0VCeXJqQ4peO/tt8rFDvvEk/0ubS6K+97qLHoDo9bK34u8lhexZbIPGRjJgazdpMJc
         j+/RdtFIKvKHAHk+YziiMo5XUdgMJvd6irQdKLLvs/UmXWDg4DrC5Gchrbxya7gbYq0b
         QrLfI6TuohYrADxuRgQ3BppMCVa5Zfu6xbC0jSIf42L2aniJQ0hYolWjmzh4so5Iwogr
         BCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIL3/IPGPxPH1XP2vvboocirNCVAeNwvDhqeW8pCsaI=;
        b=QBD9ssNe/W2WWoDZmooH5SfviZWO2Tg1ixdDEYR0LzYpjUaSHfcFYxJO6T5qpvTDDq
         9xEXF0+m/gmm/Rs2hRnSf4wFi2xouxlKb9bNcktlK2Lq1Rz+Y4zkldt8OPRO3PVYBvu1
         YrL9Sl00Y/dc/iF+5balCEsNRFZlGpx5Wm/MfRlewbgGVrou9bMcaZ8PfL5OaPxAbh5g
         vhYvotAO4+6BYyfL54+WHb2SbzVanOGuKEy+wT+zdVMFCW/swxYwmjDlOlCny7jULR04
         j/3Hvu8TxOYI1UbsvRAIUe7QFubmbuc7DlK6GoKZWAaB1NIwgvVB6jwq6qcdGHJtmbWE
         DEUQ==
X-Gm-Message-State: APjAAAVRTRufuQgKmH7FUSydcEzLeDCsMKJeFa0q7Q7r9dP6xuKANGEl
        lT9q4hvMY/PWPUnYK6PRlT07eJfHr2M80COg5XF8sDFvliABsg==
X-Google-Smtp-Source: APXvYqyF0mMWj+5R3zW8nSKkX3iP0snBcnZ6VwI2q6jqSKy3XY2sFhrbav1Xb38fKAwnPjd0BtturI1QI/Qy90PY4Hw=
X-Received: by 2002:a1c:ed09:: with SMTP id l9mr1462516wmh.101.1576089480786;
 Wed, 11 Dec 2019 10:38:00 -0800 (PST)
MIME-Version: 1.0
References: <CAN4oSBdH-+BmSLO7DC3u-oBwabNRH2jY2UUO+J0zdxeJTu5FCg@mail.gmail.com>
In-Reply-To: <CAN4oSBdH-+BmSLO7DC3u-oBwabNRH2jY2UUO+J0zdxeJTu5FCg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 11 Dec 2019 11:37:44 -0700
Message-ID: <CAJCQCtTq4xwyqo_2sFkh+M63GX8MEDq5zGuRr9ZUptO+-KVCYw@mail.gmail.com>
Subject: Re: Is it logical to use a disk that scrub fails but smartctl succeeds?
To:     Cerem Cem ASLAN <ceremcem@ceremcem.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 11, 2019 at 6:11 AM Cerem Cem ASLAN <ceremcem@ceremcem.net> wrote:
>
> This is the second time after a year that the server's disk throws
> "INPUT OUTPUT ERROR" and "btrfs scrub" finds some uncorrectable errors
> along with some corrected errors. However, "smartctl -x" displays
> "SMART overall-health self-assessment test result: PASSED".
>
> Should we interpret "btrfs scrub"'s "uncorrectable error count" as
> "time to replace the disk" or are those unrelated events?
>
> Thanks in advance.

This is a bit old, and there are more recent papers on better
approaches. But as it relates to only SMART attributes correlating to
failures, it demonstrates there's a big window where failures can
happen and SMART gives no advance warning.
https://www.usenix.org/legacy/events/fast07/tech/full_papers/pinheiro/pinheiro_old.pdf

If you are doing 'smartctl -t long' or similarly have smartd
configured to do the long test periodically, and if that test never
shows a failure, that means the drive thinks it's doing a good job :D
If you assume the drive's error detection is working, then no errors
detected by the drive means the data on the drive is the data the
drive computed the checksum on. That leaves the drive's own
controller, memory cache, and everything before that (connectors,
cables, logic board controller, logic board RAM, probably not CPU
memory or the CPU itself or you'd have a ton of problems) which could
contribute to corruption of the data that Btrfs could detect that the
drive firmware will assume is correct.

-- 
Chris Murphy

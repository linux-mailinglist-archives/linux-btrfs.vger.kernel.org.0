Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A67233D88
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 04:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbgGaC55 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 22:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731245AbgGaC55 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 22:57:57 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7705C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jul 2020 19:57:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r4so23681589wrx.9
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jul 2020 19:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=leneGARjFWctSUpkiGJ2y8hil/ArfJEvwqqbxBf/fxs=;
        b=XhRSPBv3bh8DuDKEZ5VsWadk3WFwcWH5B2TVx0FyxQtwyhl/yZ8LWUQsgf3hdH3J/k
         /+f/4KJ37LJEh9fB5IovBFINvuyrmxdfRRhTrgooUdrfdi8e4Oa7DsYqlFjT2i9sOWUR
         jhUSX8HAde0LMHctInzArQ7UP+7X1+lkV0mRZJwbe6FUOPX+DoE+j4gbZoyytReUvGXS
         8WTQdawYzMaQvlAEkURpA5ZBeYDK9eDqSqxbbk7kRLOCm9J3TbZHDpCcNhi6KsKeK4MW
         /8it0l2NIrmM9oWocv2yp/2DYnBBOLn+E5gP09jsr4w3jw4NqIzQ7MHx/Zrzhpt8VeEz
         Rffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=leneGARjFWctSUpkiGJ2y8hil/ArfJEvwqqbxBf/fxs=;
        b=af24r2m8Ugvf1vrKx9vDXk0d98h8REp3PO8rB1FcdVLJUGOmvfJ5uvQ/Orb7HzwMYZ
         FeF8DIdsvUBO1KhdDgAHkvI9ZcW4fNhcvGLTYNyyqQaU2fuVCa/FdqS9rIBXJAuXQYtY
         50MHb1FIPBbVWQdvzQLomMhE7pTdYCcg54RErgRatkN+h8p/YHpY0j/T86Gm2AkktLN5
         NgndfOSy3dz1MMnxxIkb0W91LcO8/RP5C7h9w4ovDmfwldGeTf/WbSwf78WMSsAT7Hml
         6xrosMP80VnTFecbTU22ngQrUUf5EKMUdUepNHgvp2+N2N4QW0kAKk6KQyay6UhHj2MX
         bQbw==
X-Gm-Message-State: AOAM533LMwaSizp01DswCRudqPcj2nhOmpg3xoLN7NwfD/tNQ/vsCu3+
        evcyLOlr26gkd4LGNV+JKeTiSh8m2tDxrWZs8xCElQ==
X-Google-Smtp-Source: ABdhPJxcWKppvrgrSsjqVj5vicZSotD9c9z1ziY02O7jEDNYhmVOTJ4p5U6468+p6iERQZw48RT7aWPjoE2Uh2afWNs=
X-Received: by 2002:adf:f806:: with SMTP id s6mr1416074wrp.252.1596164275445;
 Thu, 30 Jul 2020 19:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200731001652.GA28434@dcvr>
In-Reply-To: <20200731001652.GA28434@dcvr>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 30 Jul 2020 20:57:38 -0600
Message-ID: <CAJCQCtS6fHYGBiHpqAJPu+-EoSzEKZ5YEaj4QjNxqPvO+JTACw@mail.gmail.com>
Subject: Re: raid1 with several old drives and a big new one
To:     Eric Wong <e@80x24.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

(first attempt did not go to the list)


On Thu, Jul 30, 2020 at 6:16 PM Eric Wong <e@80x24.org> wrote:
>
> Say I have three ancient 2TB HDDs and one new 6TB HDD, is there
> a way I can ensure one raid1 copy of the data stays on the new
> 6TB HDD?

Yes. Use mdadm --level=linear --raid-devices=2 to concatenate the two
2TB drives. Or use LVM (linear by default). Leave the 6TB out of this
regime. And now you have two block devices (one is the concat virtual
device) to do a raid1 with btrfs, and the 6TB will always get one of
the raid1 chunks.

There isn't a way to do this with btrfs alone.

When one of the 2TB fails, there's some likelihood that it'll behave
like a partially failing device. Some reads and writes will succeed,
others won't. So you'll need to be prepared strategy wise what to do.
Ideal scenario is a new 4+TB drive, and use 'btrfs replace' to replace
the md concat device. Due to the large number of errors possible with
the 'btrfs replace' you might want to use -r option.

Following successful replace, an option is to break the 2x 2TB mdadm
concat apart, send the dead drive off for grinding, and the good 2TB
you can add as a 3rd device to the Btrfs. If it dies, same thing.
Preferably use 'btrfs replace' - it's faster and more reliable than
'btrfs delete missing'.

And on second thought...

You might do some rudimentary read/write benchmarks on all three
drives. I haven't found btrfs to be fussy about speed differences
between raid1 member drives. But if it turns out either of the 2TB's
are slower than the 6TB, you could do raid0 instead of linear. If so,
I suggest either 32Kib or 64KiB for mdadm --chunk size. Default is
512KiB. Not great for metadata centric workloads.

Of course, if one of them dies, the error behavior will be quite a lot
more consistent, EIO on every other 64KiB strip. So you'll definitely
want -r option when doing the replace.

--
Chris Murphy

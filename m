Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E3714D34A
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 23:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgA2WzY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 17:55:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45622 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgA2WzY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 17:55:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id a6so1496044wrx.12
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 14:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EznpRLs7RFg4ZMDAxC2xBQThWwUyRVbVXYJ0ap9ubEc=;
        b=MVBuGUShCfiV9nuccbzH6CZjiLFz5sVpTzrhkm8grk5I+EbIltgE62QX5owENsN93C
         npRtXEau+LboM3OSv/Nzw907PKWJQlA7EpMLeywDhnQN00c1hnDWeKl94K3xyy9QJUGc
         7A3twbvbKYD2P3965v+tljPhEYkkCmDz+8SKn4U2xehqFhKgK/J4ej6CYaxne9rqW3hy
         RzDo61qQ6Plt951Fw8oqiXc8xGG2mSkli58Rczw6pMNhmnuY6lZQy5S8RWr4rtb5Sx/1
         FovRFXlFLC4EEI4sPbKIdEq9dESOwbCPxsekfFAHwzKmZyPZUWgA8mVXLdDdhWrtVf6C
         dtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EznpRLs7RFg4ZMDAxC2xBQThWwUyRVbVXYJ0ap9ubEc=;
        b=p59mZR0DCx4NVXlp8iKRkrAJLS49aAZ4ouwCI8iM0hSQkozFhJzD3atBf8TX84x6Te
         o3pVSYOZaCy2QbkW+47lPBhMco3BZa7s5vmeWo5cZP5l4cP37QPjy4shFpwXJs8Ki8Ms
         0WJAAcnDhsrTJJBbFeeRwbm/tTnPaekMAvAMqFWuqblJ6YPPPu4ZLWbLq/RWJMUMyRJx
         rwV5ZNanfAGNf+P5jjYtNoNc/DHzX3ECE2HBMI7HWb6GCuD4qvL4VHHTN8Tz0Fg+Srh7
         aTvRJyM4VG8CAfYOqWcBIjjybxWZ0qO5DLP4HemLz16ofCB2zw4QMwdu2+kPKD4k46K5
         /UMw==
X-Gm-Message-State: APjAAAXPwGlGQhxGz7mMZtLyjcWMktsrjN7NhlwQ9EDUQVseRabRKMUO
        8hnvl51MXW/B4kq/KMXVSeacaOCU9HEF8aP4ZmZmbhWjcKiMUg==
X-Google-Smtp-Source: APXvYqyHghGCbufCgC6IYwN9ufhFTJFdZEW00CcJDl3U4w8h8PyzURbmfZhzVGdqfxrZNR2qZI7Bb051OxwK8MFNlpg=
X-Received: by 2002:adf:f308:: with SMTP id i8mr1261837wro.42.1580338522428;
 Wed, 29 Jan 2020 14:55:22 -0800 (PST)
MIME-Version: 1.0
References: <112911984.cFFYNXyRg4@merkaba> <0102016ff2e7e3ad-6b776470-32f1-4b3d-9063-d3c96921df89-000000@eu-west-1.amazonses.com>
 <2049829.BAvHWrS4Fr@merkaba>
In-Reply-To: <2049829.BAvHWrS4Fr@merkaba>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 29 Jan 2020 15:55:06 -0700
Message-ID: <CAJCQCtSVqMBONCuwea_9i6xBkzOHSkCSoEAaDi2aH+-CLnNwBg@mail.gmail.com>
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Martin Raiber <martin@urbackup.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 29, 2020 at 2:20 PM Martin Steigerwald <martin@lichtvoll.de> wrote:
>
> So if its just a cosmetic issue then I can wait for the patch to land in
> linux-stable. Or does it still need testing?

I'm not seeing it in linux-next. A reasonable short term work around
is mount option 'metadata_ratio=1' and that's what needs more testing,
because it seems decently likely mortal users will need an easy work
around until a fix gets backported to stable. And that's gonna be a
while, me thinks.

Is that mount option sufficient? Or does it take a filtered balance?
What's the most minimal balance needed? I'm hoping -dlimit=1

I can't figure out a way to trigger this though, otherwise I'd be
doing more testing.


-- 
Chris Murphy

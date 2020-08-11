Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5372415E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 07:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgHKFGJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 01:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgHKFGJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 01:06:09 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7585CC06174A
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 22:06:07 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id p4so10673412qkf.0
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 22:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dallalba.com.ar; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Ss6NUbYB0ne37lm/R9hXTF//HSdDlNFXaOV8dHNsUCU=;
        b=cnmlLDMysFb4wKiZbIEtRs4AA1vG3wzKivcCt9R2nLnCdEG8RTPGODbN6/q+Ja3WKF
         MRB3hWdvt30kKpb/biR9PK8YldLjZjO+xQZzgR7bQjtOnzkVpNK84YOhYv1EUb/31jN3
         WfaORcEMsK+mD0mSp5LO7qXKXdnGyB11TFyyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Ss6NUbYB0ne37lm/R9hXTF//HSdDlNFXaOV8dHNsUCU=;
        b=Tr0zN+x89wmkRsIfg4G5m6GKn4ZDfHG6Qhk7+CkbkPIkfExMNLPeK6iow96B1Oyed8
         GHLA8Nf0xmN0EZvFPekICepRrVBeVGgF7uyjV5y/Ube3j8okvADZ8f97wZ+WqWyqh7Jb
         zuRE4GUUtTzlhMDuS/IIg2VqrGx1pR1mRkCUlYchPi4Nuq9SYY7S4HKZnptBSv79+tcX
         bYglRXtmeIYLvHSbxy5L0f1UZYsp7PSMPl6AtowTs3n+6SZpp84kr+G36hla/PlbW9kN
         G60DSwmXQOzxzyVMDHZp3GlBdcO3uHCNC7oiY09R8wgkVq6OUqcTS0RAFU2Qmn0K59Rr
         x0AA==
X-Gm-Message-State: AOAM530ClmLIpEXZx3TLezFEsSZLIPS+p8RB2bZ9yCJ8SaefpSOotEx6
        Y6lEyX2GLrCC4eECHiDH5M5688mbdA==
X-Google-Smtp-Source: ABdhPJy90DSPsBztLC8JDlUhNvHY1OR+iE1MhFXnkoKpOnHkvBQFWEPmqZuHoH8LudHkeSfJdKR6Hw==
X-Received: by 2002:a05:620a:1122:: with SMTP id p2mr30930498qkk.45.1597122366097;
        Mon, 10 Aug 2020 22:06:06 -0700 (PDT)
Received: from atomica ([2803:9800:a011:8d29:1c34:b9ea:ffe4:fab6])
        by smtp.gmail.com with ESMTPSA id i18sm17436817qtv.39.2020.08.10.22.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 22:06:05 -0700 (PDT)
Message-ID: <dc0bea2ee916ce4d1a53fe59869b7b7d8868f617.camel@dallalba.com.ar>
Subject: Re: raid10 corruption while removing failing disk
From:   =?UTF-8?Q?Agust=C3=ADn_Dall=CA=BCAlba?= <agustin@dallalba.com.ar>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date:   Tue, 11 Aug 2020 02:06:02 -0300
In-Reply-To: <CAJCQCtReHKtyjHL2SXZXeZ4TwdXf-Ag2KysSS0Oan5ZDMzm8OQ@mail.gmail.com>
References: <3dc4d28e81b3336311c979bda35ceb87b9645606.camel@dallalba.com.ar>
         <CAJCQCtReHKtyjHL2SXZXeZ4TwdXf-Ag2KysSS0Oan5ZDMzm8OQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 2020-08-10 at 20:34 -0600, Chris Murphy wrote:
> On Mon, Aug 10, 2020 at 1:03 AM Agustín DallʼAlba
> <agustin@dallalba.com.ar> wrote:
> > Hello!
> > 
> > The last quarterly scrub on our btrfs filesystem found a few bad
> > sectors in one of its devices (/dev/sdd), and because there's nobody on
> > site to replace the failing disk I decided to remove it from the array
> > with `btrfs device remove` before the problem could get worse.
> 
> It doesn't much matter if it gets worse, because you still have
> redundancy on that dying drive until the moment it's completely toast.
> And btrfs doesn't care if it's spewing read errors. 

By 'get worse', I mean another drive failing, and then we'd definitely
lose data. Because of the pandemic there was (and still is) nobody on
site to replace the drive, and I won't be able to go there for who
knows how many months.

> Do you have a complete dmesg for this time period? Because (a) bad
> sectors should not exist on a recently scrubbed system (b) even if
> they do exist, during device removal it's a read error like any other
> time, and btrfs grabs the copy instead. Slowness suggests to me there
> is a timing mismatch between SCT ERC and the default SCSI command
> timer. It leads to lengthy delays and prevents bad sectors from being
> properly fixed.

I have a _partial_ dmesg of this time period. It's got a lot of gaps in
between reboots. I'll send it to you without ccing the list. The
failing drive is an atrocious WD green for which I forgot to set the
idle3 timer, that doesn't support SCT ERC and lately just hangs forever
and requires a power cycle. So there's no way around the slowness. It
was added on a pinch a year ago because we needed more space. I
probably should have ask someone to disconnect it and used 'remove
missing'.

> > # btrfs check --force --readonly /dev/sda
> > WARNING: filesystem mounted, continuing because of --force
> > Checking filesystem on /dev/sda
> > UUID: 4d3acf20-d408-49ab-b0a6-182396a9f27c
> > checksum verify failed on 10919566688256 found BAB1746E wanted A8A48266
> > checksum verify failed on 10919566688256 found BAB1746E wanted A8A48266
> 
> So they aren't at all the same, that's unexpected.

What do you mean by this?

> My advice is to mount ro, backup (or two copies for important info),
> and start with a new Btrfs file system and restore. It's not worth
> repairing.

Sigh, I was expecting I'd have to do this. At least no data was lost,
and the system still functions even though it's read-only. Do you think
check --repair is not worth trying? Everything of value is already
backed up, but restoring it would take many hours of work.

Thanks for all the information, I hope you have a good day.


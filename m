Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF0176F67
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 18:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfGZQ5E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 12:57:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36867 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbfGZQ5E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 12:57:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so48232459wme.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2019 09:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Se9+fkfs7FxS+u1WCH6rB22zCHTmI/5wv110SeiQhI8=;
        b=TCarBlfCn7Mu+CbH4qluWYQQcwFXO1meSjVqCYK9f0ZQqtl3rGnQp9QiAQmsKXbgot
         Eyd/CeCOL6nsUa+1wg55OJskMLKE3gKeali9OvUSqPi84II6fWwQkiTipuxzjwZNahC7
         CqWdGLEyl60zx8fUO2qwOrcLZhilMa0jzz4sWW+lhu7K6HkdjKPS/qsLeSKP1Dykby+B
         hf/kQRtXriPTsAhspblCUKW5T/uXDsf1rsx2BGW/mOhgfsKHEJmR/YIUzsrbhmP9ODPL
         lizCauMssSCw+DZvxhnBpyEi1Siqfdlf/v1VZ1G0L2jiwHHFEjk80aWF+6828XwnfsXk
         GWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Se9+fkfs7FxS+u1WCH6rB22zCHTmI/5wv110SeiQhI8=;
        b=BWPsO+4kn/CwRqFzZNhFMH7AafNBAZHxg63myhK7uW3eh/UoCFDT4jyZO/qLnH84ul
         +FM3ceeRTii9bMkQF74DRscjSJleehuGgkRGvx/OpTsPc5XPW3gqeQDTKKzzj55dQFoA
         CfseoDuzpMnQBXoAue92YsHwwUhKa5UPjtAO9dbR4J/trLSKW+YaYrhQONR+7tDNY7s6
         YPeeECPBeJq7E07mN0xGB2ONx9+1j/64bRPy+3DSBuTFzEGScQjQ2P/Z19MfuXli6uVi
         AvCz89BqIL91huAk8F7KdnPiADh80tfqRwqYf5hjVAcaPwRabUPN8CP34sz9F88YBXxs
         kT7w==
X-Gm-Message-State: APjAAAUSxevOAacS1ms7j60gvM7H4nxM2JJoa+SGqIIjY+wUbv48HzSD
        P/UIQTD2/dAFUF8wYF6LzzmJI5fKHDiRjKZZId3u1SVpI68=
X-Google-Smtp-Source: APXvYqxGLHltfft569dvZ3A7aw9Ns/KEBjN70ZgfIZXHub23c6g+cu5TgXUGhdopUf8nlrLsnJmL8HXfrIwdfpgmZ+c=
X-Received: by 2002:a7b:ce95:: with SMTP id q21mr87445869wmj.65.1564160221662;
 Fri, 26 Jul 2019 09:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190703135405.kwzg2am7voldx7ac@macbook-pro-91.dhcp.thefacebook.com>
 <20190703211210.GJ16275@worktop.programming.kicks-ass.net> <20190705134727.q62geiy4sniol4gg@macbook-pro-91.dhcp.thefacebook.com>
In-Reply-To: <20190705134727.q62geiy4sniol4gg@macbook-pro-91.dhcp.thefacebook.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 26 Jul 2019 10:56:50 -0600
Message-ID: <CAJCQCtTs-Lag_r-e6FEw1nRug3qymry15XBDjD_Rtv0QXdG05A@mail.gmail.com>
Subject: Re: Need help with a lockdep splat, possibly perf related?
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks like Fedora have run into this in automated testing, and think
it's causing OS installations to hang, which would be a release
blocking bug. Is this really a Btrfs bug or is it something else that
Btrfs merely is exposing?
https://bugzilla.redhat.com/show_bug.cgi?id=1733388

I've seen a variation of this splat since kernel 5.0.0 so it doesn't
seem like a new issue and I haven't experienced any deadlocks. So I'm
a little skeptical that this is just now causing only installs to hang
on just one distribution. But there's no clear evidence why the hang
happens. Just this suspicious lockdep warning pointing the finger at
Btrfs. If it's not Btrfs, it would be useful to know that Fedora folks
need to keep looking for the actual problem even though the hangs
don't happen on ext4 or XFS.

5.2rc2
https://lore.kernel.org/linux-btrfs/CAJCQCtS4PRWU=QUY87FRd4uGE_wA+KSSLW+2e_9XDs5m+RYzsQ@mail.gmail.com/

5.0.0rc6
https://lore.kernel.org/linux-btrfs/CAJCQCtTAiLK8rcs+MtzkSAGRwmSDvZN52XaMyemCH4O_4VQ1zQ@mail.gmail.com/



-- 
Chris Murphy

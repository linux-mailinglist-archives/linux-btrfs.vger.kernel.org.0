Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4971B9645
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Apr 2020 06:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgD0Etp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Apr 2020 00:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726172AbgD0Etp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Apr 2020 00:49:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DC9C061A0F
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Apr 2020 21:49:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x4so18022207wmj.1
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Apr 2020 21:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tIdklTNZyDahkb7M6hBQXwSZ6YcalTTFlV13UI8MVw=;
        b=iPDYXk8UE3i/mOqCtcFuSV3aAUKc5hxRvmSdZfcgJ6g4cBDhoeYheqSvbQcEhlPcgc
         g3+yFcSIZdkWugr8WMY10nDp8mtGK4GAByQiWScvNuczCPSy92Ychi/KdcGSrmu8iP0u
         MBnaD8a7V2Hc/J0tecxV80daGAScHVPIYOXV5ZY25Q1UAsaY8ZTdQEKvlKCMnr+2VgB+
         IxeGHyT7p7BS4voqMGUagNzTumpBJkkKyE5BtAT7jHeiWT8dRZ+DcB2+aZqbJqfJab1D
         z6B1DwBTry03HGes8FBQ89nLoNMgm/WzEVJQL5cAIFbScxn665haI+cWLw7itTb650E1
         Jyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tIdklTNZyDahkb7M6hBQXwSZ6YcalTTFlV13UI8MVw=;
        b=f7EZpek1xHbLnHvLpFny71ilXt4RWTef/ll9Yn2WXcBNbC5lhHMZGXhpNOb9HwCa4N
         bFKo7suoAH6LimqVjY8RS5n7peRUloxVbYl3phnFcuz4VM/hZRMNVqQsVwnlLkS5pSZ3
         rrlBdpIO/XhpXBqhL6UdSrpxwqSvY3YtN9nVVIBPvu37wJy2xNvcUBE6BYNQtr37jceE
         QWfWZJFIIenbAIEudwg2Zs0/Q6aWrSPxKdIq9AKolONyntQkNcZ3s0GJVzO8zwbYvPnX
         fuUbkZBJP/ZZxulz8haM6M2iD+sJ14Cm3jrGYtURPaZ/rHubNq1AppB8uNlYrq+9zfv8
         3dKw==
X-Gm-Message-State: AGi0PuZkHS5Gf0zZuzMeaXb3DJwZkpeaMRBfi3Y/Is2HCu73WuptiELT
        oyUOZ/9Fw+Ee41jItMJqS3vQi601rQ2xctzEtEnCbg==
X-Google-Smtp-Source: APiQypKBBEcgT8HSAcYYPYd2wiMk3wKOu+6Nyu35rM43Vq5PZvZRLx81J/3dSY/7YE5l6B5PHFK/hpgTtc8qs+bqxcg=
X-Received: by 2002:a1c:7c13:: with SMTP id x19mr23773362wmc.124.1587962983459;
 Sun, 26 Apr 2020 21:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAEg-Je8zM4xq7GEG+cphKkR6wjquwG3jv9bbJ88chzrZUEzuYg@mail.gmail.com>
 <59e1e1e4-b856-8784-3c4d-3fbd7a724cf8@suse.com> <7512bb89-65b1-edcb-9572-6afa2e07fd2e@harmstone.com>
In-Reply-To: <7512bb89-65b1-edcb-9572-6afa2e07fd2e@harmstone.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 26 Apr 2020 22:49:27 -0600
Message-ID: <CAJCQCtRbSyoRy+mb-bqvqWqOuNs+81xfuqMyGgQnwtuFm9TjZQ@mail.gmail.com>
Subject: Re: Btrfs native encryption
To:     Mark Harmstone <mark@harmstone.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 26, 2020 at 8:25 AM Mark Harmstone <mark@harmstone.com> wrote:
>
> Last thing I heard was that Omar Sandoval at Facebook was looking into it. I never heard anything back about my patches, though.

I think the biggest difficulty with that patchset isn't as much the
patchset, but the bandwidth of people who can review it. It was a
complex patchset and didn't use fscrypt. (For reasons that are
explained, but then also at least originally the Btrfs maintainers
wanted to initially implement an fscrypt/VFS approach. Maybe it's too
difficult.)

I'm curious whether Omar is working on something and what the time
frame could plausibly be. In the meantime, other approaches are being
explored, based on LUKS encrypted loop mounted files, as in
https://systemd.io/HOME_DIRECTORY/

Btrfs has advantages here, including asynd discards and online fs
resize, in case someone wants to attempt to manage the ensuing fantasy
of sparse backing files. The loss of dedup and reflink doesn't seem to
be a problem because it can't be done with encrypted extents anyway.

-- 
Chris Murphy

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A281C7BE6
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 May 2020 23:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgEFVFK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 17:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728821AbgEFVFK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 May 2020 17:05:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C00C061A0F
        for <linux-btrfs@vger.kernel.org>; Wed,  6 May 2020 14:05:09 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v12so2517635wrp.12
        for <linux-btrfs@vger.kernel.org>; Wed, 06 May 2020 14:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=msb6EzObLxrxF1+v3KvqZmxjvRVeh1jtjVBsqxSv0j8=;
        b=NXaXiuEYFV2r4IA3fC9waWumUS7adAJ2+rKNkbpnI/aNoV7Zoha/eE04QAjp2OrUbX
         vHBlhGu0W8u2j3UJi8Fw3MxnYj7IdqehQOfGlWkALfPAiXKtT2GEjJGtxwpc4koLIBXC
         gTrYDGhEIuVgg8kS1pHl9KhTRmj09KnKmvnzX1f/2vAfiF6XN1NxhMaA5FBv6ciN63sR
         aAP8Bothstp5lPQe5UymJNFqVi6meojq7uaYOlUZjl7GHh61iM4guelkEoF3+368LYl2
         4I4ZER/Vw9q52MIFqzDyBuk90sYO1Rrghq9w+kyAwfA+1VT/OlNozkBUJMUE4yNiw5nI
         TlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=msb6EzObLxrxF1+v3KvqZmxjvRVeh1jtjVBsqxSv0j8=;
        b=sRxcbo7eEXjBErarItZofoms4I7BypDV/uYFDTMiEGHuSFP6XZ8fTNrAjVQeMCutGK
         oLL1L6LMvn83Eeo03UcNdAPAdK9dfQe2Rlb8JtMqyACtv8i78kMDNJury2nyvWfD7XJo
         h1NPY7rn6hek1TEbYr1gjFnCSkcodYW4qMFVq3zZBFVBeAOMSSqVipn9lXxyeVaqDfHY
         F/Uq7+Dzlm5OEdB15lrERrBfvN20sBV2l0EvCIZJR7BW/gojiUrSpVZISh1efgs7XaQo
         vRWLPO614CTHaQBW9nFOFmE0aJlettWtCtehdH/F5X8ELKAtcf3Pm3cKVYtMLmn+Dp2p
         7Gww==
X-Gm-Message-State: AGi0PuYdrwaI06ysNVsZJutepzN9HMMkm7luD+m4w447NbcFuVLGqsGC
        RG4TdsviBGuiyQTsp9wMcrjTZSOhPNiFznL2C/DIPeSlZ94=
X-Google-Smtp-Source: APiQypJIuD1ISUANLm2StLMDTIJgnbiZ6C2jjI+8DSsdY5RRd5BKNpdo6m4npvwOsmrJ+FQ4LEwot86nNHDJKZS45E0=
X-Received: by 2002:a5d:51cb:: with SMTP id n11mr8957771wrv.236.1588799108490;
 Wed, 06 May 2020 14:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTp+DJ3LQhfLhFh0eFBPvksrCWyDi9_KiWxM_wk+i=45w@mail.gmail.com>
 <CAJCQCtSJWBy23rU2L8Kbo0GgmNXHTZxaE2ewY1yODEF+SKe-QA@mail.gmail.com>
 <2ae5353b-461b-6a87-227c-f13b0c2ccfe2@suse.com> <CAJCQCtT6rnH75f8wC8uf+-NnxEsZtmoRhM9cE37QTR0TF6xqJQ@mail.gmail.com>
 <CAJCQCtSCzD-RtGH1tJjNN=PBgUfJARy0r1p1Ln0pU1eRNTmR9w@mail.gmail.com> <CAJCQCtQu4ffJYuOUWkhV_wR7L0ya7mTyt0tuLqbko-O8S+1fmg@mail.gmail.com>
In-Reply-To: <CAJCQCtQu4ffJYuOUWkhV_wR7L0ya7mTyt0tuLqbko-O8S+1fmg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 6 May 2020 15:04:52 -0600
Message-ID: <CAJCQCtT=rStKTwUc86FyAp8C0D8eoRvgKHWYC3+e=fLJxJNUZA@mail.gmail.com>
Subject: Re: 5.6, slow send/receive, < 1MB/s
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 5, 2020 at 11:48 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> btrfs-progs-5.6-1.fc32.x86_64
> kernel-5.6.8-300.fc32.x86_64
>
> I've created a new file system, filled it with ~600G, set the seed
> flag, and I'm creating a sprout by adding a 2nd device and removing
> the 1st. This used to go at device speeds. Today it's running at
> ~35M/s where I expect 95-120M/s. I don't know that it's related to
> send/receive performance.

Same brand new file system, and a second new file system, doing
send/receive with a single snapshot (no other snapshots or subvolumes
related to it) and I'm seeing this same abysmal performance. ~5MB/s
send. The instant I do 'perf top -g -U' on the send process, the send
performance increases 10x to over 50MB/s. As soon as I quit perf top,
abysmal performance. Both of these drives scrub at ~100M/s. I'm not
sure what's going on or how to get more information but it's a
regression.

I'll attach a few perf top text files to the next email.

-- 
Chris Murphy

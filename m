Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D57420A8F
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 14:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhJDMGI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 08:06:08 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:42986 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhJDMGH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 08:06:07 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id CF1CA1E006F2;
        Mon,  4 Oct 2021 15:04:17 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1633349057; bh=LUBjn25IerK9OBp/qE7H97M10Ha7H7kRRBu8q/O/4CY=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=AxLY4NFmYM+O4erFHBRDHfVzp/VP9L7VFs7NV4fO2qvAzDOGYL+MFKwyYNwzYyi73
         KLpRbjXgWoVFePWgVoYXxiBfAAWFpWW2fU7dgaxSBm8LWtO7KIQTFBwAzGVTZr8Igw
         a0zgTaA2lsffC1mkenTkhUDWxj9/1U8ndaZ3o4vI=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id C649D1E006F0;
        Mon,  4 Oct 2021 15:04:17 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id uXQzXSu47MAx; Mon,  4 Oct 2021 15:04:17 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 4699C1E006ED;
        Mon,  4 Oct 2021 15:04:17 +0300 (EEST)
Received: from nas (unknown [117.62.175.41])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 049091BE0ACA;
        Mon,  4 Oct 2021 15:04:13 +0300 (EEST)
References: <CAJCQCtT+OuemovPO7GZk8Y8=qtOObr0XTDp8jh4OHD6y84AFxw@mail.gmail.com>
 <20210921195632.GR9286@twin.jikos.cz>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     dsterba@suse.cz
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: 5.15.0-rc1 armv7hl Workqueue: btrfs-delalloc btrfs_work_helper
 PC is at mmiocpy LR is at ZSTD_compressStream
Date:   Mon, 04 Oct 2021 19:57:25 +0800
In-reply-to: <20210921195632.GR9286@twin.jikos.cz>
Message-ID: <v92d3sjs.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWetewt38GpVL57oiJmmsm5Un2eDUSOFf08TVhKpnGtzU3i5og==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Tue 21 Sep 2021 at 21:56, David Sterba <dsterba@suse.cz> wrote:

> On Mon, Sep 20, 2021 at 06:13:07PM -0600, Chris Murphy wrote:
>> https://kojipkgs.fedoraproject.org//work/tasks/8820/75928820/oz-armhfp.log
>
>> 00:09:50,679 EMERG kernel:[<c08bd768>] (mmiocpy) from 
>> [<c089c314>]
>> (ZSTD_compressStream+0x184/0x294)
>
> The last function to fail is inside ZSTD implementation in 
> kernel.
> If btrfs passes wrong data to zstd we'd see that also on non-arm 
> builds,
> so guessing by mmiocpy as a copy-something function it could be 
> some
> sort of alignment problem that works on x86_64 but throws an 
> exception
> on arm as it's stricter about alignment.

It's about 32bits platforms. There is another report about x86 
cpu.
And it's reproduciable by running btrfs/004 (lzo and zstd)in x86 
VM.
In my arm64, all things are fine.
And the bisection result is the highmem related patchset
'[PATCH 0/6] Remove highmem allocations, kmap/kunmap'.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=214565

--
Su

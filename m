Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF3031D027
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 19:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhBPSWg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 13:22:36 -0500
Received: from ns.bouton.name ([109.74.195.142]:57712 "EHLO mail.bouton.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhBPSWf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 13:22:35 -0500
Received: from [192.168.0.39] (82-65-239-81.subs.proxad.net [82.65.239.81])
        by mail.bouton.name (Postfix) with ESMTP id 49543B84C;
        Tue, 16 Feb 2021 19:21:54 +0100 (CET)
Subject: Re: performance recommendations
To:     "Pal, Laszlo" <vlad@vlad.hu>,
        Leonidas Spyropoulos <artafinde@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAFTxqD_-OiGjA3EEycKwKGteYPmA6OjPhMxce8f1w8Ly=wd2pg@mail.gmail.com>
 <e70bbe98-f6dc-9eaa-8506-cd356a1c2ed8@suse.com>
 <CAFTxqD9E2egJ22MorzXPAHaNDKg5QoEBK=Cd4ChOdT6Odiy6Rg@mail.gmail.com>
 <aeed56c3-e641-46a1-5692-04c6ae75d212@gmail.com>
 <CAFTxqD-SpnKBRY9Ri9xWFfNgWuHYVggYwCPdyXgF6ipUAzxNTg@mail.gmail.com>
 <20210216174906.iv5ylu3p7jn347kb@tiamat>
 <CAFTxqD_RgvZTPCZywE28nW==PjT5N68_8q7zr1Te-VAiHMp1oQ@mail.gmail.com>
From:   Lionel Bouton <lionel-subscription@bouton.name>
Message-ID: <fc5db83a-1e2b-2653-e402-a52907573b6b@bouton.name>
Date:   Tue, 16 Feb 2021 19:21:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAFTxqD_RgvZTPCZywE28nW==PjT5N68_8q7zr1Te-VAiHMp1oQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Le 16/02/2021 à 19:01, Pal, Laszlo a écrit :
> Hi,
>
> Thank you. If I have to clone, I think I'll just get rid of the
> machine and recreate with some other file system. I'm aware, this is
> my fault -lack of research and time pressure-, but I think if I can
> boot it with the old kernel I'll keep it running as long as it can and
> I'll use this time to create another, better designed machine.
>
> Answering your question regarding the ctree, no there is nothing else
> in the log but when I check dmesg on the booted rescueCD during mount,
> I can see some similar message "btrfs transaction blocked more than
> xxx seconds" and the the end "open_ctree", so it seems I really have
> some file system corruption as the root cause (maybe created by some
> bugs in the old code, or some unexpected reboot)

From experience systemd has mount timeouts which will result in
open_ctree errors with healthy but slow filesystems.
IIRC x-systemd.mount-timeout=infinity in fstab can be used to avoid
these errors.

Best regards,

Lionel

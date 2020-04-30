Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F5B1C04FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 20:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgD3Skl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 14:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726272AbgD3Skl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 14:40:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E008BC035494
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 11:40:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c12so3180420wrp.0
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 11:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Imib8HtevgXiNHVegU9csGPIuVwVvFPzUVZEXhsSGI0=;
        b=uA2rUdn6IXuntR3/4uyTjEAVLF2ga1isoRQPa0DdKS5G+BZb2bhcO6sCl1Udjer2hM
         U/Uf7ObrLkGxjD9EVU5UP3HjS7SM83JT/Oq+rhIVm929zsEvve/0VMkafE4DySoOxc+d
         kbBasglLglyn6XiG2HswK1HHxv0iW0/EUm6d/orby/vPAaBbv/3OKyQEJuk4d2UaY7Xu
         BolplsbI9KWiHjFggBSpTB1Ly0gvvg8q8c/XI+bPgKD9pDWECa3HKbDoLsPBIE0Pm6zP
         AiDtC28uig1xQyHfaYQEMYFwi+grGbDtwTG4DZZpxuBMlHvFMRX9UP5w6ZoX7wSYQKBp
         wiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Imib8HtevgXiNHVegU9csGPIuVwVvFPzUVZEXhsSGI0=;
        b=ngZQ9+7GrLpQ8ZMUM3TY1/Pdlz13V673I9JQb6mUumpheYfe1n9SP848Eag4j7ckJZ
         OpGnthr2oMPqdj8afeHQc8kGXjvUK1D+kMCSDhjF4y3FBRo2UyNiabvSUvxxyNz9aQ4k
         T4E9QUI7avTrukaOIhTtyDGGywCK2ErWAIHdqCtI0kZCFZhH5ZUizE0/SBfcOdN76eQk
         XKoaC+oHzZ0PkCJnAUJZRBtNor7MdugYrsVs+mz1YyWSU8U5GVOQ0ZAv3aMXdmCI56ym
         MSlj2GsahuejyG1PXN1F61BLA4U0On0f+TYULSnLyrD6/OTcPWLrjOidSJHIBoJLTVwM
         vq5A==
X-Gm-Message-State: AGi0PuaQ8nyQ3MXJLNeecHbNTqvfATPYEdw7K/oH9h5fkRnvTTnUEkOc
        jM1M/GxINeWRHr0wYq6W+QDUh5W/bmA7+gTc4v/gLNaR6kM=
X-Google-Smtp-Source: APiQypJX85NUejPxh2FsT6wuM5ZcndqdbqdRFmqTmFjT14Bcce+M36jYze4ocRXXfDlupORSIlDE1ZZ5VzYiy5j3n9s=
X-Received: by 2002:adf:e702:: with SMTP id c2mr5596380wrm.252.1588272037782;
 Thu, 30 Apr 2020 11:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net> <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
In-Reply-To: <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 30 Apr 2020 12:40:21 -0600
Message-ID: <CAJCQCtQqdk3FAyc27PoyTXZkhcmvgDwt=oCR7Yw3yuqeOkr2oA@mail.gmail.com>
Subject: Re: Extremely slow device removals
To:     Phil Karn <karn@ka9q.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 30, 2020 at 11:31 AM Phil Karn <karn@ka9q.net> wrote:
>
> Any comments on my message about btrfs drive removals being extremely slow?

It could be any number of things. Each drive has at least 3
partitions so what else is on these drives? Are those other partitions
active with other things going on at the same time? How are the drives
connected to the computer? Direct SATA/SAS connection? Via USB
enclosures? How many snapshots? Are quotas enabled? There's nothing in
dmesg for 5 days? Anything for the most recent hour? i.e. journalctl
-k --since=-1h

It's an old kernel by this list's standards. Mostly this list is
active development on mainline and stable kernels, not LTS kernels
which - you might have found a bug. But there's thousands of changes
throughout the storage stack in the kernel since then, thousands just
in Btrfs between 4.19 and 5.7 and 5.8 being worked on now. It's a 20+
month development difference.

It's pretty much just luck if an upstream Btrfs developer sees this
and happens to know why it's slow and that it was fixed in X kernel
version or maybe it's a really old bug that just hasn't yet gotten a
good enough bug report still, and hasn't been fixed. That's why it's
common advice to "try with a newer kernel" because the problem might
not happen, and if it does, then chances are it's a bug.

> I started the operation 5 days ago, and of right now I still have 2.18
> TB to move off the drive I'm trying to replace. I think it started
> around 3.5 TB.

Issue sysrq+t and post the output from 'journalctl -k --since=-10m'
in something like pastebin or in a text file on nextcloud/dropbox etc.
It's probably too big to email and usually the formatting gets munged
anyway and is hard to read.

Someone might have an idea why it's slow from sysrq+t but it's a long shot.

> Should I reboot degraded without this drive and do a "remove missing"
> operation instead? I'm willing to take the risk of losing another drive
> during the operation if it'll speed this up. It wouldn't be so bad if it
> weren't slowing my filesystem to a crawl for normal stuff, like reading
> mail.

If there's anything important on this file system, you should make a
copy now. Update backups. You should be prepared to lose the whole
thing before proceeding further.

Next, disable the write cache on all the drives. This can be done with
hdparm -W (cap W, lowercase w is dangerous, see man page). This should
improve the chance of the file system on all drives being consistent
if you have to force reboot - i.e. the reboot might hang so you should
be prepared to issue sysrq+s followed by sysrq+b. Better than power
reset.

We don't know what we don't know so it's a guess what the next step
is. While powered off you can remove devid 2, the device you want
removed. And first see if you can mount -o ro,degraded and check
dmesg, and see if things pass a basic sanity test for reading. Then
remount rw, and try to remove the missing device. It might go faster
to just rebuild the missing data from the single copies left? But
there's not much to go on.

Boot, leave all drives connected, make sure the write caches are
disabled, then make sure there's no SCT ERC mismatch, i.e.
https://raid.wiki.kernel.org/index.php/Timeout_Mismatch

And then do a scrub with all the drives attached. And then assess the
next step only after that completes. It'll either fix something or
not. You can do this same thing with kernel 4.19. It should work. But
until the health of the file system is known, I can't recommend doing
any device replacements or removals. It must be completely healthy
first.

I personally would only do the device removal (either remove while
still connected or remove while missing) with 5.6.8 or 5.7rc3 because
if I have a problem, I'm reporting it on this list as a bug. With 4.19
it's just too old I think for this list, it's pure luck if anyone
knows for sure what's going on.


-- 
Chris Murphy

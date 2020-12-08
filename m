Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12A82D2160
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 04:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgLHDSV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 22:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgLHDSU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 22:18:20 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F036C061749
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 19:17:40 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id c1so2820496wrq.6
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 19:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uC5z1qNiNZcJm6cxMQWK/o7Nx5tEO8P5D0RjHzhgcIM=;
        b=tNjDz98M4KzqHis6IiIZYnMBl4xdTxTgMTJRNBBJECK9RNikhgT+eqx2X2g6msGGP0
         /E0aJwqOqGme2elkPrHl9+B+c7xtH2xpcrBCtHEDoZNZ/zASgyGmwIpWK+Auol1NysFn
         JiiBddqTOpSfwrW0gUzzlE7glvvwp326gIXM1Ui3f9XBkBCCz8dTiyLuUibN7ue7qrkz
         2452kv+/3RlgwXu0ajDmCNAD1JsbfDEzRZmV2LzjJkw0ddwpTBfXwtjCLhut431LY2+c
         MQj4YgE1kYyJ7UiwjwJKs9GPKocanYfpyG7LAgUtvajC/yhw042Jx5/TRVK/2RTR8GqL
         OMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uC5z1qNiNZcJm6cxMQWK/o7Nx5tEO8P5D0RjHzhgcIM=;
        b=ZzWozxVaBwyF+P4AsEhz9s20AMV20DhO0cbjpxyajb+obe7DOYxzkSoBOiEyA22xck
         4vJPnWfLt86c18DihppNq1qSXmhIlrVmKyg7APe21KxVLTXqRbZhwYeOm+Wg4TMmi0VB
         24+6FkpicjfvO5aCn+jsBDmfMqnNO63nX9pd08ouvox5y8qof5LPQuSqNnMffBKPMjdC
         zu7DjvPmutZT9yRYYxc1q6aYiP6xPvAiyDwyObipK+ZE5RCuK8LX6CBwi7VUhE4Cn3lI
         jaMfhuivvO8DrbHBLBci9BeJfx/dA4oHONJ4SGvPbmQj5Q0ptiYgXfBqDv1an1WfBlDb
         o3Xg==
X-Gm-Message-State: AOAM530aykVk/aiN5taJzLgsng80JCLpbZg4WUPZwwXPv2UrqEThGdum
        huVhGO6Az6oLRA4wmxfdXCZ+CfF8ADo5C+Pwbu/yVAN76Wl7h7ar
X-Google-Smtp-Source: ABdhPJwDq1QKtepDDn/ZVbD1uHvGtAowNOe8xfiiQRet+Qc6CeHgACJZSRUecIigDBUEx+pIWTTBTeryVdm8gHFWiyQ=
X-Received: by 2002:adf:e2ca:: with SMTP id d10mr20011371wrj.65.1607397458754;
 Mon, 07 Dec 2020 19:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20201208010653.7r5smyo6vloqk7qv@vanvanmojo.kallisti.us>
In-Reply-To: <20201208010653.7r5smyo6vloqk7qv@vanvanmojo.kallisti.us>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 7 Dec 2020 20:17:22 -0700
Message-ID: <CAJCQCtQe=1m-43Fg_QQ8eOjWyTjHibs_0yiBFg=+wVQBUc_NMw@mail.gmail.com>
Subject: Re: tree-checker corrupt leaf error
To:     Ross Vandegrift <ross@kallisti.us>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 7, 2020 at 6:47 PM Ross Vandegrift <ross@kallisti.us> wrote:
>
> Hello,
>
> I've got a single-device btrfs filesystem that fails to mount and I'm
> not sure how to proceed:
>
> [  118.556075] BTRFS: device label backup devid 1 transid 55709 /dev/dm-21
> [  118.581857] BTRFS info (device dm-21): use zlib compression, level 3
> [  118.581858] BTRFS info (device dm-21): disk space caching is enabled
> [  120.035857] BTRFS info (device dm-21): enabling ssd optimizations
> [  120.037493] BTRFS critical (device dm-21): corrupt leaf: root=5 block=3420303224832 slot=18 ino=265, invalid inode transid: has 140301292396544 expect [0, 55710]
> [  120.065595] BTRFS critical (device dm-21): corrupt leaf: root=5 block=3420303224832 slot=18 ino=265, invalid inode transid: has 140301292396544 expect [0, 55710]

$ printf '%x %x\n' 140301292396544 55710
7f9a70b1e000 d99e

Looks like it's just garbage, not a bit flip. It'd be useful to know
if there are other issues:

$ sudo btrfs check --check-data-csum /dev/sdXY

This is read-only.

>
> The fs has been in use for a while with no obvious issue until now.  I
> got this message after upgrading from 4.19.118 -> 5.9.6 (from debian
> stable -> debian stable backports).  Nothing was done to this fs under
> 5.9 aside from trying to mount.  A different fs was converted from ext4
> and mounted.
>
> The wiki suggests reverting to the working kernel, so I rebooted into
> 4.19.160 (stable was updated) - but now I get the same error on 4.19.

I'm going to guess it was due to a bug in an older kernel and it just
got exposed by a newer kernel, and bad luck that it's now also visible
with the old kernel. It could also be some kind of device (firmware)
bug that got hit at one time, but is just now seen by the kernel.

>
> The list archives point to using `btrfs inspect-internal inode-resolve`
> to find problematic files and copying-then-deleting them.  But since I
> cannot mount, this doesn't work.

It might be possible to use a backuproot, but with rw it's possible it
makes things worse if it actually uses a stale tree.

mount -o ro,usebackuproot

Does that mount?

If so, at least you can update your backups. Only then is it OK to try
btrfs check --repair because while it should be safe, it can make
things worse.

Also I recommend using a recent btrfs-progs. 5.9 is current, and I
probably wouldn't use less than version 5.6.

If it doesn't mount, and if you don't have recent backups, and have
data to get out, then this is the territory of btrfs restore.

https://btrfs.wiki.kernel.org/index.php/Restore

That's quite tedious to figure out. It might help to ask on #btrfs and
wait for a reply, because sometimes there's a lot of back and forth to
iterate.

This is what I recently came up with for recovering a weechat log due
to a bad sector:

# btrfs restore -v -i -r 298 --path-regex
"/(|home(|/chris(|/.weechahttps://btrfs.wiki.kernel.org/index.php/Restoret(|/logs(|/irc.freenode.#btrfs.weechatlog)))))$"
/dev/sdb2 .

The hard part for me is the regex. OK also finding out that I wanted
root ID (subvolume) 298 is a pain also. There's a patch to make
listing subvolumes offline better, but it didn't make it into 5.9

https://lore.kernel.org/linux-btrfs/547cf7d97e32b542f4a552c7319b167dd6b94403.1603758365.git.dxu@dxuuu.xyz/

There is a way to figure out the ID to name mapping using
inspect-internal dump-tree and grep *but* it depends on your layout.
And you have to know a bit about btrfs internals, which again is
easier to figure out by IRC. Anyway, this should get better with
kernel 5.11 which will have a much better read-only rescue mount
option so hopefully we can by pass all this low level method stuff.


-- 
Chris Murphy

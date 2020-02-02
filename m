Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B34B14FF02
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Feb 2020 20:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgBBT4w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Feb 2020 14:56:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38262 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgBBT4w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Feb 2020 14:56:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so15306908wrh.5
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Feb 2020 11:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GGPHZrmfqckR3+PehfRD5MALpm96/TC+7LXgyyq/zmA=;
        b=okMtlRdPiVoosSI1nxstVDTtDOsp2rtIRINiKDZYmSMkBM9pisctdIxl3L7TDMH+k4
         oBXmsNJ+tV01mhFHghMsbOeCyJCmIRJ8cfFgvPAOOgF8XSJ3UAS+ZnH7PcGQHbIrrC9B
         nhvWRqj+eAgW4GlF8k597Ypf9F3RbXpQ72PtpJoqmWYG5cafdr3wd8Ao60V0rwJSYSTi
         3PCqA5qZcl7WamNF3w+xPsEdg/1qZK+601FaNMOrtC4qKj+MDMheX0N3oSWekz10OoGc
         JkYeT0f1sVBVhrxXsbYd52vVDIrKJFbGAjnUQ54gwTdXIR1YVAk3n9AjaSrCPQK3LfJd
         JPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GGPHZrmfqckR3+PehfRD5MALpm96/TC+7LXgyyq/zmA=;
        b=UZwBt+dEgIlbB9DbCgpwrOD8BbBqfNKaVtFseySPdVEDueEXtbx2sORJ5PpgBbUcE0
         1Da0Mb5VN7t1NFGf28LElUIjphlrRHmcflegN4Jx1QuNjp/ICMclPuWMfATbgzXRXEdb
         zlQQqHrtoIIMOnAoTblQfz8WyK6SQYCXREobU0j/U++1GPpnhELrKy6DQ5TvENiUhISa
         yRCH5MZLfRCIvMvJbeMhq7XPW4h6hM+bTpVO2HXPF3CBXet4jhmdear8Qe6oQkZWxt0n
         zXgyrESm74QnQOvllIytUVxauyyXExjrFpWG6UbyuHLOOOcv93M6AfeJ5BCZ9wK9T6bX
         b4jw==
X-Gm-Message-State: APjAAAVWEQXdc+pL+Fn+rxNFillZuNeLWeerlEJdABinog9UL86FuaGY
        rQ2/QMrA/oC2pN15XJpnkinYloFZiwKAiKrIrg5QO4KRaXM=
X-Google-Smtp-Source: APXvYqwGuGfRanHTFtlcNZw+1VPPowEs97YcHowXfzjXpR8v249MwqpTQXgSkvG9pUSe6bDDVUwxxokZHTC6c5H7L0w=
X-Received: by 2002:adf:ab14:: with SMTP id q20mr11087336wrc.274.1580673409932;
 Sun, 02 Feb 2020 11:56:49 -0800 (PST)
MIME-Version: 1.0
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
In-Reply-To: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 2 Feb 2020 12:56:34 -0700
Message-ID: <CAJCQCtR0hzV+9S7cggGUUTtp4R1WdnSwzsOp=9fTnxvzn3Stmw@mail.gmail.com>
Subject: Re: My first attempt to use btrfs failed miserably
To:     Skibbi <skibbi@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 2, 2020 at 5:45 AM Skibbi <skibbi@gmail.com> wrote:

> root@rpi4b:~# dmesg |grep btrfs
> [223167.290255] BTRFS: error (device dm-0) in
> btrfs_run_delayed_refs:2935: errno=-5 IO failure
> [223167.389690] BTRFS: error (device dm-0) in
> btrfs_run_delayed_refs:2935: errno=-5 IO failure
> root@rpi4b:~# dmesg |grep BTRFS

The entire unfiltered dmesg is needed. This older kernel doesn't have
new enough Btrfs tree checker code to help determine what the problem
is.

> [203285.351377] BTRFS error (device sda1): bad tree block start, want
> 31457280 have 0

> [203285.466743] BTRFS info (device sda1): read error corrected: ino 0
> off 32735232 (dev /dev/sda1 sector 80320)

> [218811.383208] BTRFS error (device dm-0): bad tree block start, want
> 50659328 have 7653333615399691647

These happening together suggest lower storage stack failure. Since
kernel messages are filtered it only shows that Btrfs is working as
designed, complaining about known bad file system metadata. But
because it's filtered, it's not clear why the metadata has gone bad.

> [223167.290255] BTRFS: error (device dm-0) in
> btrfs_run_delayed_refs:2935: errno=-5 IO failure

More suggestion of IO failure, whether physical device or logical
layer in between Btrfs and physical device. Btrfs trusts the storage
stack *less* than other file systems, by design. It's a kind of canary
in the coal mine. Other file systems assume the storage stack is
working, so they're less likely to complain. Only recent versions of
e2fsprogs will format ext4 using metadata checksumming enabled. The
kind of problems you're reporting look so bad and happen so fast I'd
expect a good chance you'd reproduce the same problem with any
metadata checksumming file system, if you have new enough progs to
enable them.

-- 
Chris Murphy

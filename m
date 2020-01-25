Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDB4214978D
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jan 2020 20:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgAYTqd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jan 2020 14:46:33 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:45053 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgAYTqd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jan 2020 14:46:33 -0500
Received: by mail-wr1-f50.google.com with SMTP id q10so6094542wrm.11
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Jan 2020 11:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i+NBtAzpxrQEqjAjghmYKcmC6lEu25Hydh1KeVejEwI=;
        b=kjk5LzN4ZmScRqPcXxV1l7xjGKV8Rn0BZG2mWXjdrFVvkeItFyHVgCzK2v2NIQ4ADn
         verWYAWxv6j/uX+gIh82ESUTM1bvxfEMbIOEe9TpMX22IgW0W5F+QJxmryhDP+d+rKTv
         qGXmBulXlk4+aOVETRgw3YpNAhobwnrh9PCSfdPQsFk084L1yfR562WuwfnH6VdiyMK3
         3SgVw7uqEFP4nTBRnVtj7KOwXvay8cqh4biHUHvkjEY160w9ehZC/y5DzdZ3iuKoXy4E
         sFXwZL9o9+glJyAILhD35eDLFFkI8rxhp7jAH1uDBptebYbfYXUKmkj/pQtz0FlS5xA+
         nyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i+NBtAzpxrQEqjAjghmYKcmC6lEu25Hydh1KeVejEwI=;
        b=VyHWjebDSK0I46+oe7WDphT1dofgxFw1YLWMK9CxSFp0DacZo0x1oZFY8D/6reHyQb
         0OcJY7IQNlhtdBEYSyQxE5FdepwB36K2UenthiiH8B/EYplQj+PcqeaWAWENtIhykOgB
         1cY2y/11ep6pDqFM30TLRXZ7cupRQ+ViMB7xrWLMAGcPeNXE0hwuxGsLSSjRDggaBRxU
         H84ezZ2nY6V1nbH8g61a32SQ+Ah0rofCM6Q609czA84wvfZ0NYY4RYy0z9hnANxC8OT9
         jizpwBg6oR1DMm/K+ELkpQbkQgGxHMpBpEPSmu6pIxs8OINmHAE7z0o9Y/uq7WTTiBsT
         UpBA==
X-Gm-Message-State: APjAAAUPhk42U5al9EnSPIOSHwc1/UcXEZgUdEjAvDeshavyN+YHumsX
        jkGE9Yyi+LziNVS2V77zP54Utra8FdWW/8mCWhZ2HD48mfs1kA==
X-Google-Smtp-Source: APXvYqx5JK9Wi8So7IKe3/G4odvH6CiwbYADL0ZC9/782xUvxlaiWERZfDPIPUfsU/OUhQ5iYfK86vkyRcbZOPQ64y0=
X-Received: by 2002:adf:fa43:: with SMTP id y3mr11585674wrr.65.1579981591376;
 Sat, 25 Jan 2020 11:46:31 -0800 (PST)
MIME-Version: 1.0
References: <em16e3d03d-97be-4ddb-b4a4-6a056b469f20@ryzen>
In-Reply-To: <em16e3d03d-97be-4ddb-b4a4-6a056b469f20@ryzen>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 25 Jan 2020 12:46:15 -0700
Message-ID: <CAJCQCtRuM782pQtd=GYXaWK+71M8D-qg4q-ieMJU3nwYTHVasQ@mail.gmail.com>
Subject: Re: Broken Filesystem
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 25, 2020 at 4:34 AM Hendrik Friedel <hendrik@friedels.name> wrote:
>
> total tree bytes: 131072

and

>
> btrfs-find-root /dev/sda
> Superblock thinks the generation is 8
> Superblock thinks the level is 0
> It did not finish even in 54 hours

I agree with the recommendations thus far. But this generation sticks
out for me, along with the total tree bytes. It suggests this device
has recently been formatted?

Anyway, I advise poking around and making no changes to anything: no
--repair, no rw mount. Only do things that are read-only or are
completely reversible. Many data loss stories are the result of making
changes, "repairs" that end up making the problem much worse, more
complicate, impossible to reverse - and then what might have been
possible to recover, no longer (practically) possible. I suggest
asking the owner to reconstruct a detail version of every single step
they took since the volume was in working order.

-- 
Chris Murphy

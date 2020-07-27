Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E9322E3CF
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 04:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgG0CFF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Jul 2020 22:05:05 -0400
Received: from static.214.254.202.116.clients.your-server.de ([116.202.254.214]:50342
        "EHLO ciao.gmane.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgG0CFF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Jul 2020 22:05:05 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcfb-btrfs-devel-moved1-3@m.gmane-mx.org>)
        id 1jzsVi-0002ko-1O
        for linux-btrfs@vger.kernel.org; Mon, 27 Jul 2020 04:05:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-btrfs@vger.kernel.org
From:   Andrew Skretvedt <andrew.skretvedt@gmail.com>
Subject: defrag/compression: will it break reflinks on kernel 4.15.0?
Date:   Sun, 26 Jul 2020 20:59:11 -0500
Message-ID: <rflcdf$bc5$3@ciao.gmane.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
X-Mozilla-News-Host: news://news.gmane.org
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I've started experimenting with compression on a btrfs filesystem. I'd
like to use 'zstd'.

I'm on linux kernel 4.15.0.

I have a handful of snapshots and I know that if all the reflinks will
be broken, I won't have enough space to keep them all. So the choice I'm
facing is that breaks will happen; I should delete enough snapshots to
ensure space is sufficient, or breaks won't happen and I can leave my
snapshots alone.

Background detail and deeper questions:

I *was* on v4.4 of the userspace tools (ubuntu btrfs-tools package).
I'm *now* on v5.4.1 of these tools (ubuntu btrfs-progs package) via some
careful cherry-picking from a newer release to keep all dependencies
satisfied.

I began by adjusting mount options to include "compress=zstd"; this was
fine. I understand that new writes are getting compressed (if passed by
the compressibility heuristic). But, I understand that to compress
what's already present, I have to issue defrag command(s) with -c. I was
set to go forward and tripped over requesting -czstd, as v4.4 of the
tools didn't support zstd, and I didn't notice. This is what prompted me
to make the tools upgrade.

The manpage "btrfs-filesystem" includes:

> Warning
> Defragmenting with Linux kernel versions < 3.9 or ≥ 3.14-rc2 as well
> as with Linux stable kernel versions ≥ 3.10.31, ≥ 3.12.12 or ≥ 3.13.4
> will break up the reflinks of COW data

I thought I was prepared for this, but now I want to try to be more
certain about what will happen if I start issuing 'defrag -czstd'
commands. Because version 3.x kernels are mentioned several times at
specific subversions, the warnings only apply to newer sub-subversions
of them. I *think* that my 4.15.0 kernel will *not break* reflinks.

Is that correct?

Extra questions:

I see that the userspace tools' version tracks along with the kernel
version. Is it a mistake to use a newer version of the tools than the
running kernel, i.e. should I drop back to v4.15 of the tools?

>From the wiki, I understand that while zstd support was added in kernel
4.14, user-selection of compression level in zstd was not added until
kernel 5.1. So I cannot use mount options like "compress=zstd:3" on
kernel 4.15. BUT, can I yet do "defrag -czstd:3" since I'm running
v5.4.1 tools? Or, must I (should I) just stick to -czstd and accept the
default level it would use. What is that for zstd?

Thanks.

-- 
OpenPGP 0xC6901B2A6C976BB3 (https://keys.openpgp.org)

-- 
OpenPGP 0xC6901B2A6C976BB3 (https://keys.openpgp.org)


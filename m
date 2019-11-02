Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7FFBECF77
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Nov 2019 16:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfKBPYa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Nov 2019 11:24:30 -0400
Received: from rin.romanrm.net ([91.121.75.85]:59164 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfKBPYa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 Nov 2019 11:24:30 -0400
Received: from natsu (natsu.2.romanrm.net [IPv6:fd39:aa:7359:7f90:e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 87F2920373;
        Sat,  2 Nov 2019 15:24:28 +0000 (UTC)
Date:   Sat, 2 Nov 2019 20:24:33 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Brian Hansen <dulanic@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: reflink copy now works with nocow?
Message-ID: <20191102202433.1ca92ea5@natsu>
In-Reply-To: <CAMiuOHWtjJdeKmkEV-kx+GRk_VskXEKMZoJWD5z7acapqeDE-A@mail.gmail.com>
References: <CAMiuOHXH1ic6Mcz+o1uWLNMCK+iCinhR+nnZ8N1wTHQoEms-7Q@mail.gmail.com>
        <20191102193624.3411de0d@natsu>
        <CAMiuOHWtjJdeKmkEV-kx+GRk_VskXEKMZoJWD5z7acapqeDE-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 2 Nov 2019 10:09:27 -0500
Brian Hansen <dulanic@gmail.com> wrote:

> So I'll need to setup a script to remove C when moving
> directories.

The only way to un-nocow a +C file is to physically rewrite it into a new
copy. The +C attribute can be removed on existing files only if they are 0
bytes in size.

> Unless there is a easier way to deal with this?

Try a different/newer kernel version, as noted in my message all of this
doesn't seem to matter anymore, and nocow files can now be reflinked (or +C is
not working anymore and they aren't actually nocow).

-- 
With respect,
Roman

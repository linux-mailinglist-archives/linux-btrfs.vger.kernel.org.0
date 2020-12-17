Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6F32DD2A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 15:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgLQOMy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 09:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgLQOMv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 09:12:51 -0500
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80D6C061794
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:12:10 -0800 (PST)
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 76D5580C;
        Thu, 17 Dec 2020 14:12:07 +0000 (UTC)
Date:   Thu, 17 Dec 2020 19:12:07 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Ulli Horlacher <framstag@rus.uni-stuttgart.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: how to extend a btrfs disk image?
Message-ID: <20201217191207.17243c40@natsu>
In-Reply-To: <20201217123008.GA22831@tik.uni-stuttgart.de>
References: <20201217123008.GA22831@tik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 17 Dec 2020 13:30:08 +0100
Ulli Horlacher <framstag@rus.uni-stuttgart.de> wrote:

> root@fextest:/nfs/rusnas/fex# mount disk1.btrfs /mnt/tmp
> root@fextest:/nfs/rusnas/fex# df -TH /mnt/tmp
> Filesystem     Type   Size  Used Avail Use% Mounted on
> /dev/loop2     btrfs   16T  3.7M   16T   1% /mnt/tmp

You see here 'mount' has transparently created a 'loop device' for you in order
to mount the FS.

> Now I want to extend this filesystem, but this approach fails:
> 
> root@fextest:/nfs/rusnas/fex# touch disk2.btrfs
> root@fextest:/nfs/rusnas/fex# truncate -s 16TB disk2.btrfs
> root@fextest:/nfs/rusnas/fex# btrfs device add /nfs/rusnas/fex/disk2.btrfs /mnt/tmp
> ERROR: /nfs/rusnas/fex/disk2.btrfs is not a block device

Since file is not a block device, here you have to do the same manually. See
documentation for 'losetup'.

-- 
With respect,
Roman

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9095B35B21C
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Apr 2021 09:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhDKHKw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Apr 2021 03:10:52 -0400
Received: from rin.romanrm.net ([51.158.148.128]:60648 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhDKHKv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Apr 2021 03:10:51 -0400
Received: from natsu (natsu2.home.romanrm.net [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 6F7B444;
        Sun, 11 Apr 2021 07:10:34 +0000 (UTC)
Date:   Sun, 11 Apr 2021 12:10:34 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Paul Leiber <paul@onlineschubla.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Parent transid verify failed (and more): BTRFS for data storage
 in Xen VM setup
Message-ID: <20210411121034.373468ac@natsu>
In-Reply-To: <CAJCQCtRqaxE6k9JGK+xSF-onTcVTjageC4dWoPdD+RARMK652w@mail.gmail.com>
References: <FRYP281MB058285E8F1BD4B521817F6CFB0729@FRYP281MB0582.DEUP281.PROD.OUTLOOK.COM>
        <20210410194842.71f49059@natsu>
        <CAJCQCtRqaxE6k9JGK+xSF-onTcVTjageC4dWoPdD+RARMK652w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 10 Apr 2021 17:06:22 -0600
Chris Murphy <lists@colorremedies.com> wrote:

> Right. The block device (partition containing the Btrfs file system)
> must be exclusively used by one kernel, host or guest. Dom0 or DomU.
> Can't be both.
> 
> The only exception I'm aware of is virtiofs or virtio-9p, but I
> haven't messed with that stuff yet.

If you want an FS that allows a block device to be mounted by multiple machines
at the same time, there are a few:
https://en.wikipedia.org/wiki/Clustered_file_system#Shared-disk_file_system

-- 
With respect,
Roman

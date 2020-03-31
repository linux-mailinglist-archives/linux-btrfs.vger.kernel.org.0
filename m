Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05963199CB4
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 19:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgCaRRw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 13:17:52 -0400
Received: from len.romanrm.net ([91.121.86.59]:33126 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgCaRRw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 13:17:52 -0400
Received: from natsu (natsu.40.romanrm.net [IPv6:fd39:aa:c499:6515:e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id 7DD7D4032E;
        Tue, 31 Mar 2020 17:17:49 +0000 (UTC)
Date:   Tue, 31 Mar 2020 22:17:49 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Eli V <eliventer@gmail.com>
Cc:     Paul Jones <paul@pauljones.id.au>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Victor Hooi <victorhooi@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Using Intel Optane to accelerate a BTRFS array? (equivalent of
 ZLOG/SIL for ZFS?)
Message-ID: <20200331221749.52b10248@natsu>
In-Reply-To: <CAJtFHUSjwBKGyjSQfB-aZwsvV=4AcnG+-h5uF_4zmBOESxd=hA@mail.gmail.com>
References: <CAMnnoULAX9Oc+O3gRbVow54H2p_aAENr8daAtyLR_0wi8Tx7xg@mail.gmail.com>
        <a9b73920-65d5-b973-8578-9659717434b5@gmail.com>
        <SYBPR01MB38978D6654705941C50AF95E9ECB0@SYBPR01MB3897.ausprd01.prod.outlook.com>
        <CAJtFHUSjwBKGyjSQfB-aZwsvV=4AcnG+-h5uF_4zmBOESxd=hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 31 Mar 2020 13:01:09 -0400
Eli V <eliventer@gmail.com> wrote:

> Another option is to put the 12TB drives in an mdadm RAID, and then
> use the mdadm raid & the ssd for btrfs RAID1 metadata, with SINGLE
> data on the the array. Currently, this will make roughly half of the
> meta data lookups run at SSD speed, but there is a pending patch to
> allow all the metadata reads to go to the SSD. This option is, of
> course, only useful for speeding up metadata operations. It can make
> large btrfs filesystems feel much more responsive in interactive use
> however.

If you're not taking advantage of Btrfs-side features for RAID, then might as
well run LVM Cache on top of mdadm, and then Btrfs on top of the
cached LV.
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/logical_volume_manager_administration/lvm_cache_volume_creation
https://lukas.zapletalovi.com/2019/05/lvm-cache-in-six-easy-steps.html

Or Bcache, which is the same concept, but I do not suggest it over LVM cache
due to perceived lower code quality, i.e. many data loss bugs, at least in the
past. And as the 2nd article mentions, you can't un-bcache a block device,
even if the cache device is disabled, the metadata cannot be removed. Unlike
LVM where it is easy to switch back an LV to a plain uncached one.

-- 
With respect,
Roman

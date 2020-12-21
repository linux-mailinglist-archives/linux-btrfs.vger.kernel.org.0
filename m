Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFCD2DFF0B
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Dec 2020 18:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgLURho (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Dec 2020 12:37:44 -0500
Received: from rin.romanrm.net ([51.158.148.128]:59046 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgLURho (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Dec 2020 12:37:44 -0500
Received: from natsu (unknown [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id DF1CA848;
        Mon, 21 Dec 2020 17:37:01 +0000 (UTC)
Date:   Mon, 21 Dec 2020 22:37:01 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Remi Gauvin <remi@georgianit.com>
Cc:     Claudius Ellsel <claudius.ellsel@live.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: WG: How to properly setup for snapshots
Message-ID: <20201221223701.0845e9ad@natsu>
In-Reply-To: <a68cd516-d6a2-b7ee-744b-d1b0ee83c2df@georgianit.com>
References: <AM9P191MB165033908B55F8312178D90AE2CB0@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
        <AM9P191MB1650A1159D554207CB5D738AE2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
        <a68cd516-d6a2-b7ee-744b-d1b0ee83c2df@georgianit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 21 Dec 2020 12:05:37 -0500
Remi Gauvin <remi@georgianit.com> wrote:

> I suggest making a new Read/Write subvolume to put your snapshots into
> 
> btrfs subvolume create .my_snapshots
> btrfs subvolume snapshot -r /mnt_point /mnt_point/.my_snapshots/snapshot1

It sounds like this could plant a misconception right from the get go.

You don't really put snapshot* "into" a subvolume. Subvolumes do not actually
contain other subvolumes, since making a snapshot of the "parent" won't
include any content of the subvolumes with pathnames below it.

As such there's no benefit in storing snapshots "inside" a subvolume. There's
not much of the "inside". Might as well just create a regular directory for
that -- and with less potential for confusion.

* - keep in mind that "snapshot" and "subvolume" mean the same thing in Btrfs,
    the only difference being that "snapshot"-subvolume started its life as
    being a full copy(-on-write) of some other subvolume.

-- 
With respect,
Roman

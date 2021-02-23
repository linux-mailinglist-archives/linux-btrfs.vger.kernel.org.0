Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94531322BC3
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 14:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhBWN4N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Feb 2021 08:56:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:33890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230457AbhBWN4L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Feb 2021 08:56:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AD9CCAF1E;
        Tue, 23 Feb 2021 13:55:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4F088DA7AA; Tue, 23 Feb 2021 14:53:30 +0100 (CET)
Date:   Tue, 23 Feb 2021 14:53:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH 1/4] btrfs: add ioctl BTRFS_IOC_DEV_PROPERTIES.
Message-ID: <20210223135330.GU1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <cover.1614028083.git.kreijack@inwind.it>
 <d48a0e28d4ba516602297437b1f132f2a8efd5d2.1614028083.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d48a0e28d4ba516602297437b1f132f2a8efd5d2.1614028083.git.kreijack@inwind.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 22, 2021 at 10:19:06PM +0100, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> This ioctl is a base for returning / setting information from / to  the
> fields of the btrfs_dev_item object.

Please don't add a new ioctl for properties, they're using the xattr as
interface alrady.

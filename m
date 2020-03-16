Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C62C71875D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Mar 2020 23:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbgCPW4w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Mar 2020 18:56:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:49748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732840AbgCPW4w (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Mar 2020 18:56:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 33738ADB3;
        Mon, 16 Mar 2020 22:56:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7DB12DA726; Mon, 16 Mar 2020 23:56:23 +0100 (CET)
Date:   Mon, 16 Mar 2020 23:56:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Johannes.Thumshirn@wdc.com
Subject: Re: [PATCH] btrfs-progs: Fix xxhash on big endian machines
Message-ID: <20200316225623.GU12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, Johannes.Thumshirn@wdc.com
References: <20200316090512.21519-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316090512.21519-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 16, 2020 at 11:05:12AM +0200, Nikolay Borisov wrote:
> xxhash's state and results are always in little, but in progs after the
> hash was calculated it was copied to the final buffer via memcpy,
> meaning it'd be parsed as a big endian number on big endian machines.
> This is incompatible with the kernel implementation of xxhash which
> results in erroneous "checksum didn't match" errors on mount.
> 
> Fix it by using put_unaligned_le64 which always ensures the resulting
> checksum will be copied in little endian format as the kernel expects
> it.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206835
> Fixes: f070ece2e98f ("btrfs-progs: add xxhash64 to mkfs")
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to devel, thanks.

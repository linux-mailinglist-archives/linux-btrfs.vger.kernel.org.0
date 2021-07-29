Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852363DAA0F
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 19:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhG2RZo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 13:25:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45430 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhG2RZn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 13:25:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8AA82201F1;
        Thu, 29 Jul 2021 17:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627579539;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FxofLmdrcuoFgpkytCsVLa0Dht2gvpgAW55F2C4BPKg=;
        b=1RtZVRoeQFwfk1fb8rCvByHm3c79q+SyyeymNdMgGLIOQGMGo5DEZaAdqQGICmT1ZTAiga
        tsbRvFrTR6VCorai/U0tiUwKBAmh2lq3NW0baKpahzCLOcV4A5vEh2xSxFOcWw7Yod1lWn
        mcIfdLyk34ebHcS6jZUAx4CGvqQJn1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627579539;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FxofLmdrcuoFgpkytCsVLa0Dht2gvpgAW55F2C4BPKg=;
        b=jJ0aiogEuLqQ3aUtDrPUqIl5JPETXyDEmM6hziX/QJiQzwh/Bew4sgsDlT1TwEsLmzMcOp
        DKZ3UCxWy1bMgPAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 87C3DA3B85;
        Thu, 29 Jul 2021 17:25:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B00B8DA882; Thu, 29 Jul 2021 19:22:53 +0200 (CEST)
Date:   Thu, 29 Jul 2021 19:22:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 3/7] btrfs: Allocate btrfs_ioctl_get_subvol_info_args on
 stack
Message-ID: <20210729172252.GZ5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20210727211731.23394-1-rgoldwyn@suse.de>
 <2200f9340973d627ee304ac4470f5921061266f9.1627418762.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2200f9340973d627ee304ac4470f5921061266f9.1627418762.git.rgoldwyn@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 04:17:27PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Instead of using kmalloc() to allocate btrfs_ioctl_get_subvol_info_args,
> allocate btrfs_ioctl_get_subvol_info_args on stack.
> 
> sizeof(btrfs_ioctl_get_subvol_info_args) = 504

I'm not sure about this one, it's a lot and it's not a perf critical
ioctl. Reading information about a subvolume can potentially trigger a
lot of reads in a cold state, thus triggering all the deep call chains.

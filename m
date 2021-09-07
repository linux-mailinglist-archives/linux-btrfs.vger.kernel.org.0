Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9472F4027BE
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 13:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbhIGL2H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 07:28:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37244 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhIGL2F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 07:28:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5A5F521ECA;
        Tue,  7 Sep 2021 11:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631014018;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VopjGxLBGMdkMQpR+D+EgcZ8U1BF/nJUotQgqEX7vdc=;
        b=k3Bo7Paox/Pcrkp3s5JKPo8uqBMqNUM4hFCa0gUTT9Kj9Yg+ikLE2Wm1SjGbU+tHm31/zI
        jcbjxSjUajtn0DIPWjHXtOZcHrrGufbgnB4xjjC1tKsOI0tKLqE2ODUFzchdiT8tvMaSjD
        AUVaEvNCsf+3iRAbQJegXo7zQLQcX/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631014018;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VopjGxLBGMdkMQpR+D+EgcZ8U1BF/nJUotQgqEX7vdc=;
        b=ecb4cjyr+OlRb9/8lWYj9WvlG2ZTRDKI7wBtwHC38MnGa1K6KTCAeyLgZ8zPWtXYapiafR
        fiZzldnX/9Vgi7CQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 53329A3B91;
        Tue,  7 Sep 2021 11:26:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6D9F5DA7F3; Tue,  7 Sep 2021 13:26:54 +0200 (CEST)
Date:   Tue, 7 Sep 2021 13:26:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix mount failure due to past and transient
 device flush error
Message-ID: <20210907112653.GK3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <f9dfa4183e5c84f71c3f50d504e3d6cdc43b0ae9.1630919202.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9dfa4183e5c84f71c3f50d504e3d6cdc43b0ae9.1630919202.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 06, 2021 at 10:09:53AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When we get an error flushing one device, during a super block commit, we
> record the error in the device structure, in the field 'last_flush_error'.
> This is used to later check if we should error out the super block commit,
> depending on whether the number of flush errors is greater than or equals
> to the maximum tolerated device failures for a raid profile.
> 
> However if we get a transient device flush error, unmount the filesystem
> and later try to mount it, we can fail the mount because we treat that
> past error as critical and consider the device is missing. Even if it's
> very likely that the error will happen again, as it's probably due to a
> hardware related problem, there may be cases where the error might not
> happen again. One example is during testing, and a test case like the
> new generic/648 from fstests always triggers this. The test cases
> generic/019 and generic/475 also trigger this scenario, but very
> sporadically.
> 
> When this happens we get an error like this:
> 
>   $ mount /dev/sdc /mnt
>   mount: /mnt wrong fs type, bad option, bad superblock on /dev/sdc, missing codepage or helper program, or other error.
> 
>   $ dmesg
>   (...)
>   [12918.886926] BTRFS warning (device sdc): chunk 13631488 missing 1 devices, max tolerance is 0 for writable mount
>   [12918.888293] BTRFS warning (device sdc): writable mount is not allowed due to too many missing devices
>   [12918.890853] BTRFS error (device sdc): open_ctree failed
> 
> So fix this by making sure btrfs_check_rw_degradable() does not consider
> flush errors from past mounts when it is being called at open_ctree() for
> the purpose of checking if devices are missing, and clears the record of
> such past errors from the devices. Any path during the mount that can
> trigger a super block commit (replaying log trees, conversion from free
> space cache v1 to v2) must do the usual checks for device flush errors,
> just like before.

Why did you choose to set the global bit instead of passing a parameter.
AFAICS it's only checked inside btrfs_check_rw_degradable so no deep
call stacks where passing that would be cumbersome.

I've also noticed that all callers of btrfs_check_rw_degradable pass
NULL to failing_dev, so that could be cleaned up before adding another
parameter.

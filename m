Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4881E3D8E6F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 15:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbhG1NAx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 09:00:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43784 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbhG1NAw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 09:00:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 351D91FFAB;
        Wed, 28 Jul 2021 13:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627477250;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qBVxtrSmWVlOscO72s3n1kpnLDIq1UYxTJT1qArgmmQ=;
        b=v9G2MRBI9ZC4oh0wXp76nkFZulbeIh/X9Kl1ZGYf/vBtLRwjYZPKCWMjGaRiT7QKYSZ90s
        i2rYnube6FOkbpHqj9DPbp0cx+VKOZb1YjHEpJqCBf25YPC8FoasiJ5BPJ1X7OLwnWRPBA
        sU8h+anD6jFn6PPXXnDbdwGz2vDQy+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627477250;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qBVxtrSmWVlOscO72s3n1kpnLDIq1UYxTJT1qArgmmQ=;
        b=+dVFHCK5TxbazeQB9uIkp8YvmgS+oT8ugRDKduJ54Ig3smLynu17XhzYkBjIKnruYW57R2
        r6oB1pCP3NPKd9Bg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1D3ACA3B93;
        Wed, 28 Jul 2021 13:00:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 49595DA8A7; Wed, 28 Jul 2021 14:58:05 +0200 (CEST)
Date:   Wed, 28 Jul 2021 14:58:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        anand.jain@oracle.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] btrfs: fix rw device counting in
 __btrfs_free_extra_devids
Message-ID: <20210728125805.GE5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, anand.jain@oracle.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
References: <20210727071303.113876-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727071303.113876-1-desmondcheongzx@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 03:13:03PM +0800, Desmond Cheong Zhi Xi wrote:
> When removing a writeable device in __btrfs_free_extra_devids, the rw
> device count should be decremented.
> 
> This error was caught by Syzbot which reported a warning in
> close_fs_devices because fs_devices->rw_devices was not 0 after
> closing all devices. Here is the call trace that was observed:
> 
>   btrfs_mount_root():
>     btrfs_scan_one_device():
>       device_list_add();   <---------------- device added
>     btrfs_open_devices():
>       open_fs_devices():
>         btrfs_open_one_device();   <-------- writable device opened,
> 	                                     rw device count ++
>     btrfs_fill_super():
>       open_ctree():
>         btrfs_free_extra_devids():
> 	  __btrfs_free_extra_devids();  <--- writable device removed,
> 	                              rw device count not decremented
> 	  fail_tree_roots:
> 	    btrfs_close_devices():
> 	      close_fs_devices();   <------- rw device count off by 1
> 
> As a note, prior to commit cf89af146b7e ("btrfs: dev-replace: fail
> mount if we don't have replace item with target device"), rw_devices
> was decremented on removing a writable device in
> __btrfs_free_extra_devids only if the BTRFS_DEV_STATE_REPLACE_TGT bit
> was not set for the device. However, this check does not need to be
> reinstated as it is now redundant and incorrect.
> 
> In __btrfs_free_extra_devids, we skip removing the device if it is the
> target for replacement. This is done by checking whether device->devid
> == BTRFS_DEV_REPLACE_DEVID. Since BTRFS_DEV_STATE_REPLACE_TGT is set
> only on the device with devid BTRFS_DEV_REPLACE_DEVID, no devices
> should have the BTRFS_DEV_STATE_REPLACE_TGT bit set after the check,
> and so it's redundant to test for that bit.
> 
> Additionally, following commit 82372bc816d7 ("Btrfs: make
> the logic of source device removing more clear"), rw_devices is
> incremented whenever a writeable device is added to the alloc
> list (including the target device in btrfs_dev_replace_finishing), so
> all removals of writable devices from the alloc list should also be
> accompanied by a decrement to rw_devices.
> 
> Fixes: cf89af146b7e ("btrfs: dev-replace: fail mount if we don't have replace item with target device")
> Reported-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
> Tested-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> Reviewed-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks.

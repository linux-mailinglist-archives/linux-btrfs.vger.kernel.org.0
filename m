Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FB53FE90D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 08:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238732AbhIBGE0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 02:04:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38520 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236874AbhIBGEU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 02:04:20 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D22C51FF67;
        Thu,  2 Sep 2021 06:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630562601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LTLmPfLhpcsdYYu5CUNwxv+HzVziY/qZhunkWD5q2aA=;
        b=T1C4GbMAUFoBjxuhRP+88HteQdiBH/sST4oQamCD7/tyCrcwh7sZxEhMYrsMK9GYl5ElLa
        DcAyUqfXw6sMtkHl+991OIKURjoGWHXpJ+4ixNxYsglHN+o1Gosh+JRoUXWhq3WuExPX0v
        2tetdH77iKMuv7rUVPb0V17yoMCvOLU=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id AB6721389C;
        Thu,  2 Sep 2021 06:03:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id duY9JylpMGEfKAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 02 Sep 2021 06:03:21 +0000
Subject: Re: how to replace a failed drive?
To:     Tomasz Chmielewski <mangoo@wpkg.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <b0bda3d5dba746c48bb264bea8ebc1cc@virtall.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <d1322a26-9e12-ec2e-1351-43b35aed30ea@suse.com>
Date:   Thu, 2 Sep 2021 09:03:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b0bda3d5dba746c48bb264bea8ebc1cc@virtall.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2.09.21 г. 1:07, Tomasz Chmielewski wrote:
> I'm trying to follow
> https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices#Replacing_failed_devices
> to replace a failed drive. But it seems to be written by a person who
> never attempted to replace a failed drive in btrfs filesystem, and who
> never used mdadm RAID (to see how good RAID experience should look like).
> 
> What I have:
> 
> - RAID-10 over 4 devices (/dev/sd[a-d]2)
> - 1 disk (/dev/sdb2) crashed and was no longer seen by the operating system
> - it was replaced using hot-swapping - new drive registered itself as
> /dev/sde
> - I've partitioned /dev/sde, so that /dev/sde2 matches the size of other
> btrfs devices
> - because I couldn't remove the faulty device (it wouldn't go below my
> current number of devices) I've added the new device to btrfs filesystem:
> 
> btrfs device add /dev/sde2 /data/lxd
> 
> 
> Now, I wonder, how can I remove the disk which crashed?
> 
> # btrfs device delete /dev/sdb2 /data/lxd
> ERROR: not a block device: /dev/sdb2

Right, this happens because, indeed, progs currently expects the path to
the device can be found. Your case clearly demonstrates this is not
always the case when a crash has occurred. So let me try and cook up a
fix for you.


<snip>

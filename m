Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B765395748
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 10:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhEaIp5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 04:45:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40044 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEaIp4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 04:45:56 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AA8CD2191F;
        Mon, 31 May 2021 08:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622450655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lpqD11VwesnaooS9bUD7mS99zEZv3FlhamNQHMGYvQI=;
        b=mLYlwA1rehtmtebSlslOtmInELrnvOGW3O5Mq6WCJRk/3t0kGCHV1ErUN2W6b7tpLtfBST
        A+JgbTrWACnrCFWuKCB3+C52Ldbo49vz/DBKbd/gBUr7xvu8HPIXTXqGAUQwGzsq29QJG/
        0p+vrV2dopwNAMVEBgRlVOgRmLUpCoU=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id A078D118DD;
        Mon, 31 May 2021 08:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622450653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lpqD11VwesnaooS9bUD7mS99zEZv3FlhamNQHMGYvQI=;
        b=a0ECcmvE9ydE/OV9EcLul4CdIAVzDdOSyEAbwHRlXO/SRirG6s9uCnu8nWVikjprNl+ZjZ
        /dX41I44BCBBFT5/NTsnQt9zPx+hTWDTJ8PjBWHP+6uUqYglpc63LUBUxkaKFqdRlXw1x2
        FDaquQEtJCAlx9Msq/aWp0e3ZjJL0Eo=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id NFXXJNyhtGCKPgAALh3uQQ
        (envelope-from <nborisov@suse.com>); Mon, 31 May 2021 08:44:12 +0000
Subject: Re: [syzbot] kernel BUG in assertfail
To:     syzbot <syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000f9136f05c39b84e4@google.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <21666193-5ad7-2656-c50f-33637fabb082@suse.com>
Date:   Mon, 31 May 2021 11:44:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <000000000000f9136f05c39b84e4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Authentication-Results: imap.suse.de;
        none
X-Spam-Level: **
X-Spam-Score: 2.50
X-Spamd-Result: default: False [2.50 / 100.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9f3da44a01882e99];
         TAGGED_RCPT(0.00)[a6bf271c02e4fe66b4e4];
         MIME_GOOD(-0.10)[text/plain];
         SURBL_MULTI_FAIL(0.00)[syzkaller.appspot.com:server fail];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         RCPT_COUNT_SEVEN(0.00)[7];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 31.05.21 г. 10:53, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1434a312 Merge branch 'for-5.13-fixes' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=162843f3d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9f3da44a01882e99
> dashboard link: https://syzkaller.appspot.com/bug?extid=a6bf271c02e4fe66b4e4
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com
> 
> assertion failed: !memcmp(fs_info->fs_devices->fsid, fs_info->super_copy->fsid, BTRFS_FSID_SIZE), in fs/btrfs/disk-io.c:3282

This means a device contains a btrfs filesystem which has a different
FSID in its superblock than the fsid which all devices part of the same
fs_devices should have. This can happen in 2 ways - memory corruption
where either of the ->fsid member are corrupted or if there was a crash
while a filesystem's fsid was being changed. We need more context about
what the test did?

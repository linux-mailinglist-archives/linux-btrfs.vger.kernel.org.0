Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876F148D82A
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jan 2022 13:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbiAMMoL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 07:44:11 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52948 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiAMMoL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 07:44:11 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 15AD81F387;
        Thu, 13 Jan 2022 12:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642077850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H47L3rg//pVN9sfDTAxSs9Q2IPJp/bp4d+dDtcluhd8=;
        b=mQQfN6p3MktiOsUx+Dk2vUCd/LoLNO3W+sFS07jHdfGdDUE7m4e60o1J45i+nk5AQf+jl9
        lXGzAbmvxQMJhwg5zDcMquM5bp8AmhRlb6qrZzgOg09YszJdwshMhBkfjqy7SYCYn1/6/I
        claj0azZm3NSZnTLy9S+0wCpTETU6D0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB6DF13BF7;
        Thu, 13 Jan 2022 12:44:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O/bWJpke4GFJSgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 13 Jan 2022 12:44:09 +0000
Subject: Re: [PATCH] btrfs: fix deadlock between quota disable and qgroup
 rescan worker
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20220113104029.902200-1-shinichiro.kawasaki@wdc.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <771b37ca-8ac3-1038-29ae-1655884a1e37@suse.com>
Date:   Thu, 13 Jan 2022 14:44:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113104029.902200-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.01.22 г. 12:40, Shin'ichiro Kawasaki wrote:
> Quota disable ioctl starts a transaction before waiting for the qgroup
> rescan worker completes. However, this wait can be infinite and results
> in deadlock because of circular dependency among the quota disable
> ioctl, the qgroup rescan worker and the other task with transaction such
> as block group relocation task.
> 
> The deadlock happens with the steps following:
> 
> 1) Task A calls ioctl to disable quota. It starts a transaction and
>    waits for qgroup rescan worker completes.
> 2) Task B such as block group relocation task starts a transaction and
>    joins to the transaction that task A started. Then task B commits to
>    the transaction. In this commit, task B waits for a commit by task A.
> 3) Task C as the qgroup rescan worker starts its job and starts a
>    transaction. In this transaction start, task C waits for completion
>    of the transaction that task A started and task B committed.
> 
> This deadlock was found with fstests test case block/115 and a zoned
> null_blk device. The test case enables and disables quota, and the
> block group reclaim was triggered during the quota disable by chance.
> The deadlock was also observed by running quota enable and disable in
> parallel with 'btrfs balance' command on regular null_blk devices.
> 


In btrfs_qgroup_rescan_worker can't we make the check for
BTRFS_FS_QUOTA_ENABLED be done _before_ starting the transaction by
refactoring the body of the loop? Even better will be to move the
FS_QUOTA_ENABLED check in rescan_should_stop. That way transaction
commit/quota disable will be delayed until the end of the current
qgroup_rescan_leaf invocation, no?

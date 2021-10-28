Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5EC143DCF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 10:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhJ1IdV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 04:33:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48564 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhJ1IdV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 04:33:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EE609218D6;
        Thu, 28 Oct 2021 08:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635409853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZTnPHTPFMKu1TggzqDXa2IvEQs7DgXiE3AVSC0nwX8=;
        b=Q3N4R9QCZA683eGNL/JK4xeYVQY9ix6RXchqRRHdpOIRS1NKdaH+MmEhs62/G/Af67q7Lm
        xQA0G2RGzQ5KTjuQ7czFy83WfB/b3F/4wDVnr8QRyqldzxC77yOg+p028La/AMBrs+qVwD
        fcgGailDnlogxodl22NS/hWEvK+zrtw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8D56139BE;
        Thu, 28 Oct 2021 08:30:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8dJyLr1femEOOgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 28 Oct 2021 08:30:53 +0000
Subject: Re: [PATCH] btrfs: Don't set balance as a running exclusive op in
 case of skip_balance
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20211027135334.19880-1-nborisov@suse.com>
 <7231b62b-7b84-d061-f3bb-fea0fbf891d9@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <3c2b79b8-f78e-9978-44a2-d96fcbf775f5@suse.com>
Date:   Thu, 28 Oct 2021 11:30:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7231b62b-7b84-d061-f3bb-fea0fbf891d9@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28.10.21 г. 10:57, Anand Jain wrote:
> On 27/10/2021 21:53, Nikolay Borisov wrote:
>> Currently balance is set as a running exclusive op in
>> btrfs_recover_balance in case of remount and a paused balance. That's a
>> bit eager because btrfs_recover_balance executes always and is not
>> affected by the 'skip_balance' mount option. This can lead to cases in
>> which a user has mounted the filesystem with 'skip_balance' due to
>> running out of space yet is unable to add a device to rectify the ENOSPC
>> because balance is set as a running exclusive op.
>>
>> Fix this by setting balance in btrfs_resume_balance_async which takes
>> into consideration whether 'skip_balance' has been added or not.
>>
> 
> Hmm, no. I roughly remember it was purposefully to avoid replacing
> intervened with the half-completed/paused balance. As below.
> Not sure if it is ok now?
> 
> Before patch: Can't replace with a paused balance.
> 
> ------------
> $ btrfs bal start --full-balance /btrfs
> balance paused by user
> 
> $ btrfs rep start /dev/vg/scratch1 /dev/vg/scratch0 /btrfs
> ERROR: unable to start device replace, another exclusive operation
> 'balance' in progress
> 
> $ mount -o remount,ro /dev/vg/scratch1 /btrfs
> $ mount -o remount,rw,skip_balance /dev/vg/scratch1 /btrfs
> 
> $ btrfs rep start /dev/vg/scratch1 /dev/vg/scratch0 /btrfs
> ERROR: unable to start device replace, another exclusive operation
> 'balance' in progress
> 
> $ umount /btrfs
> $ mount -o skip_balance /dev/vg/scratch1 /btrfs
> 
> $ btrfs rep start /dev/vg/scratch1 /dev/vg/scratch0 /btrfs
> ERROR: unable to start device replace, another exclusive operation
> 'balance' in progress
> ------------
> 
> 
> After patch: Replace is successful even if there is a paused balance.

That's a fair point, so the patch needs to be augmented such that only
ADD is allowed but other exclusive ops are not. I will look into it.

<snip>

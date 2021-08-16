Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51623ED1EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 12:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhHPK2I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 06:28:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49546 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhHPK2I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 06:28:08 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F21FA1FF3F;
        Mon, 16 Aug 2021 10:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629109655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xLBptYsuP78AkiZkqOMR04RxazAwqraZ2o8ruNI0WIw=;
        b=Dd/lQU+KJMC5BKaARqxTGevDeFlbOm/9Khea//zBALnDmNPqGMpQ4EJec1ridDY+FHsRaS
        OS1DVtATOQvB2Oo/e2tFKLgqNV1gCYn7d3ygQXHelYRhH53t6NqC9nInbhgC9XnBgMZUci
        hBSK4MDnl3fFZslvrVCVK8By/MsMn5g=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B5C4E136A6;
        Mon, 16 Aug 2021 10:27:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id YJCqKZc9GmHdCwAAGKfGzw
        (envelope-from <nborisov@suse.com>); Mon, 16 Aug 2021 10:27:35 +0000
Subject: Re: 5.14-0-rc5, splat in block_group_cache_tree_search while
 __btrfs_unlink_inode
To:     dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtQEp1a=sf8hO7zL5PHz-7NLjMv-A2nXGCEkNCos+nVA6Q@mail.gmail.com>
 <20210816102022.GU5047@twin.jikos.cz>
Cc:     Peter Zijlstra <peterz@infradead.org>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <1e15b3ab-e3a3-548b-86a7-c309deed0f12@suse.com>
Date:   Mon, 16 Aug 2021 13:27:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816102022.GU5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16.08.21 г. 13:20, David Sterba wrote:
> On Fri, Aug 13, 2021 at 10:33:05PM -0600, Chris Murphy wrote:
>> I get the following call trace about 0.6s after dnf completes an
>> update which I imagine deletes many files. I'll try to reproduce and
>> get /proc/lock_stat
>>
>> [   95.674507] kernel: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> 
> The message "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low" is related to
> lockdep and not a btrfs problem, but it appears from time to time and as
> Johannes said either increase the config variable, or ignore it.
> 

But is not a bug if code triggers it? I.e I think it's a signal of
misbehaving code. CC'ed PeterZ who can hopefully shed some light on this.

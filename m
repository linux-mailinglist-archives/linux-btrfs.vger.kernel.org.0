Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0CA3EFE4D
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 09:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbhHRHzb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 03:55:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47236 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239119AbhHRHz3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 03:55:29 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B2CF622046;
        Wed, 18 Aug 2021 07:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629273293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=colFvJxrPe7DiDKrNpM7KohPGzcy7Ebt8ZyReMUgPzY=;
        b=FHzAypluh2ET2RrR7RbgUm+hXs1/uPpZw3McqWCZqytKPH0raZDh8KTXHuDrB5lI7kAckx
        iAYZlA90GrlkgLMvv2l1rtniSTWoKoG2dGRQSdQUSlooBlPZKN4W8IoYg74ZraxAlg0WGf
        bfo72+HdMBHXH9Bsu3JRH9IEq/ANomg=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 828C413357;
        Wed, 18 Aug 2021 07:54:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id /KciHc28HGGpBAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Wed, 18 Aug 2021 07:54:53 +0000
Subject: Re: fstests btrfs/232 cause kworker rcu_gp CPU stalls on linux
 5.4.141
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org,
        anand.jain@oracle.com
References: <20210818152913.813E.409509F4@e16-tech.com>
 <20210818153723.8142.409509F4@e16-tech.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <d0531cfc-acd2-ebdb-175d-59233a05830c@suse.com>
Date:   Wed, 18 Aug 2021 10:54:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818153723.8142.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18.08.21 г. 10:37, Wang Yugui wrote:
> Hi,
> 
> We gathered the output of of 'sysrq-trigger t'  again.
> 

Well you are running some vendor-specific kernel based off 5.4 Also you
seem to be using qgroups and are likely missing a bunch of fixing around
try_flush_qgroup and transactions deadlock:

f9baa501b4fd btrfs: fix deadlock when cloning inline extents and using
qgroups (4 months ago) <Filipe Manana>
ae396a3b7ad0 btrfs: simplify commit logic in try_flush_qgroup (6 months
ago) <Nikolay Borisov>
4d14c5cde5c2 btrfs: don't flush from
btrfs_delayed_inode_reserve_metadata (6 months ago) <Nikolay Borisov>
ae5e070eaca9 btrfs: qgroup: don't try to wait flushing if we're already
holding a transaction (9 months ago) <Qu Wenruo>
6f23277a49e6 btrfs: qgroup: don't commit transaction when we already
hold the handle (9 months ago) <Qu Wenruo>

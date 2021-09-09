Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268E44045C5
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Sep 2021 08:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbhIIGsJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Sep 2021 02:48:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42932 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhIIGsI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Sep 2021 02:48:08 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC5BB201AA;
        Thu,  9 Sep 2021 06:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631170018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GnYyTvBEw16PJR3pZJ+D3K55G7jNf/JCYIyOrMzQuc0=;
        b=HgozMrITjTsT6aHPyZ9lLHECIjFRu/0Gvvr6dSDvLMuTICWnwgMUQmHdzIj8WoZtQ864yo
        Q0nebCj2NS5cL57D3U+fJJDUwkbTqXo2ok4S77mn1UFaKxPGxDA77Wae4yAVskp06IHHNI
        ItfDIxT9eq8c+HCu3exFUzly/DhmPLw=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9EDDD13727;
        Thu,  9 Sep 2021 06:46:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 3XKsI+KtOWHGXwAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 09 Sep 2021 06:46:58 +0000
Subject: Re: [PATCH v2] btrfs: Remove received information from snapshot on
 ro->rw switch
To:     Graham Cobb <g.btrfs@cobb.uk.net>, dsterba@suse.cz,
        Martin Raiber <martin@urbackup.org>,
        linux-btrfs@vger.kernel.org
References: <20210908135135.1474055-1-nborisov@suse.com>
 <0102017bc64308e0-f75c4f13-349c-4c2c-a77d-f037340f07c1-000000@eu-west-1.amazonses.com>
 <20210908183312.GU3379@twin.jikos.cz>
 <44c16ed8-89fe-a38b-0304-a84dfd4a5335@cobb.uk.net>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <50fea163-afe6-bb4a-04c5-f3e4ed4c6bd3@suse.com>
Date:   Thu, 9 Sep 2021 09:46:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <44c16ed8-89fe-a38b-0304-a84dfd4a5335@cobb.uk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.09.21 г. 0:24, Graham Cobb wrote:
> 
> On 08/09/2021 19:33, David Sterba wrote:
>> On Wed, Sep 08, 2021 at 04:34:47PM +0000, Martin Raiber wrote:
> 
> <snip>
> 
>>> For example I had the problem of partial subvols after a sudden
>>> restart during receive. No problem, just receive to a directory that
>>> gets deleted on startup then move the subvol to the final location
>>> after completion. To move the subvol it needs to be temporarily set rw
>>> for some reason. I'm sure there is some better solution but patterns
>>> like this might be out there.
>>
>> Thanks, that's a case we should take into account. And there are
>> probably more, but I'm not using send/receive much so that's another
>> reason why I've been hesitant to merge the patch due to lack of
>> understanding of the use case.
>>
> 
> This seems to be an important change to make, but is user-affecting. A
> few ideas:
> 
> 1) Can it be made optional? On by default but possible to turn off
> (mount option, sys file, ...) if you really need to retain the current
> behaviour.

But the current behavior is buggy and non-intentional so it should be
rectified. Basically we've made it easy for users to do something which
they shouldn't really be doing, they then bear the consequences and come
to the mailing list for support thinking something is broken.

> 
> 2) Is there a way to engage with the developers and user community for
> popular tools which make heavy use of snapshotting and/or send/receive
> for discussion and testing? For example, btrbk, snapper, distros.
> 
> 3) How about adding an IOCTL to allow the user to set/delete the
> received_uuid? Only intended for cases which really need to emulate the
> removed behaviour. This could be a less complex long term solution than
> keeping option 1 indefinitely.
> 
> Graham
> 

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE30404088
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 23:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343946AbhIHVa0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 17:30:26 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:52162 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhIHVaZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 17:30:25 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 293A29B800; Wed,  8 Sep 2021 22:29:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1631136556;
        bh=EBaINxoKgVaAoeRM4JYCNQy/jb5GC8DxRS8rbrFr7ic=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=lEmIh3VSEcNV+hey7X9H1Hy0ovc77bX8dcL/BlYrtbMSHPpXBae/82yIiIa27kSS6
         wqOp79NKbVZrxPd+tntZsnNUrXjkXf5H+jo06IMu+Ky7Cs+iGEWjhedh8NpANbwiCV
         OKqD+E3Fe1U45jf7kO2s1pfYMkZqcOOra94FGd5lS6SpsaAgyGNd/A25RC6jCZQRVm
         3BSbKEh4qNBYImywEHDO/kgWGFevkgRyMewpJCukFDuavMMsrOuuaS4JkRZ24EuNlJ
         WfwFYX+mg3cnxk197lj0hC4D4XK/osRnsSkJSk+UW2ozqRRwIAkv+j5zOrYSjqeZaZ
         P2AD3m5MyNgdA==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-6.8 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 594B09B800;
        Wed,  8 Sep 2021 22:24:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1631136255;
        bh=EBaINxoKgVaAoeRM4JYCNQy/jb5GC8DxRS8rbrFr7ic=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=Nabr2CED57COhcmsgrJUkGHHx+libd2FvJX7rdgqMJDGH+tX4ALh+nXhDf01v9eeO
         EAEOqsPQIO33PxUmXfas2Wu8dPxPxHfF1j0rxTKHmU2m+6PEsukADs3hgEMj9xMUuO
         B0xWU9TJYfoZXEFmpLky//XdRLfCB6L8ZLmLQjfXKryCKz3YL0xmUkDrROBizMrdSe
         PR7c4MdVnYyODbzFLFd49KHyY9KJ++lMNtpzMHjZuIJPvzhv0ioWEsJg398O5I2RW6
         wV73bu2CJxDCIv6Gkl5pjHKpmhmPpYdMP/WMRNh0bfNDtH3YpHznl142vU86LXC/Eg
         WOCMxnRRj4RbQ==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id F217F2947D2;
        Wed,  8 Sep 2021 22:24:14 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     dsterba@suse.cz, Martin Raiber <martin@urbackup.org>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210908135135.1474055-1-nborisov@suse.com>
 <0102017bc64308e0-f75c4f13-349c-4c2c-a77d-f037340f07c1-000000@eu-west-1.amazonses.com>
 <20210908183312.GU3379@twin.jikos.cz>
Subject: Re: [PATCH v2] btrfs: Remove received information from snapshot on
 ro->rw switch
Message-ID: <44c16ed8-89fe-a38b-0304-a84dfd4a5335@cobb.uk.net>
Date:   Wed, 8 Sep 2021 22:24:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210908183312.GU3379@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 08/09/2021 19:33, David Sterba wrote:
> On Wed, Sep 08, 2021 at 04:34:47PM +0000, Martin Raiber wrote:

<snip>

>> For example I had the problem of partial subvols after a sudden
>> restart during receive. No problem, just receive to a directory that
>> gets deleted on startup then move the subvol to the final location
>> after completion. To move the subvol it needs to be temporarily set rw
>> for some reason. I'm sure there is some better solution but patterns
>> like this might be out there.
> 
> Thanks, that's a case we should take into account. And there are
> probably more, but I'm not using send/receive much so that's another
> reason why I've been hesitant to merge the patch due to lack of
> understanding of the use case.
> 

This seems to be an important change to make, but is user-affecting. A
few ideas:

1) Can it be made optional? On by default but possible to turn off
(mount option, sys file, ...) if you really need to retain the current
behaviour.

2) Is there a way to engage with the developers and user community for
popular tools which make heavy use of snapshotting and/or send/receive
for discussion and testing? For example, btrbk, snapper, distros.

3) How about adding an IOCTL to allow the user to set/delete the
received_uuid? Only intended for cases which really need to emulate the
removed behaviour. This could be a less complex long term solution than
keeping option 1 indefinitely.

Graham

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2883FC768
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 14:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhHaMj5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 08:39:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51432 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhHaMj5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 08:39:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 860C122240;
        Tue, 31 Aug 2021 12:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630413541;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f2ohMeFmeZ8EQAw0r5nu+IId8wVa5fP57NfcDcInm+c=;
        b=v27qbZtoqtJs1+rnLnTZCb4811HHlH4/ZEwextkrNZgPDcJImWQsnAT4TXrOgoMD6bUpJH
        5fusClo2khAAxm0Neui4HXpKykW5MphIGy4VU4Iw4Xfz5JiyAep5oUpRLYrQHbZs/xKrmT
        jYy1hwofBtFlSp+dR/ISAxB9+eYnlOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630413541;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f2ohMeFmeZ8EQAw0r5nu+IId8wVa5fP57NfcDcInm+c=;
        b=7RiQ+CfqqcWoodXSivBX8fkU51QMA02H9aRHlGQ/qjDxC9PWRu602swgh/XFKkwiLBT+26
        td0lnJv9TIrcOrBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7FBDAA3B9C;
        Tue, 31 Aug 2021 12:39:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BF3A2DA8C1; Tue, 31 Aug 2021 14:36:10 +0200 (CEST)
Date:   Tue, 31 Aug 2021 14:36:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: 5.13.8, enospc with 6G unused
Message-ID: <20210831123610.GJ3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtSXKHSToLeOOconR_nKeuk8RjGjT7_z2QvV9=2zHfYB6g@mail.gmail.com>
 <CAJCQCtSjuEg8LAedxaqpRCOEq5BgegB7=QVJP8Sq3iZUFWn1rw@mail.gmail.com>
 <CAJCQCtQPvw23CGvR307L-VyPSpZi3ovC3N+xp7OaMNrxSWir_w@mail.gmail.com>
 <CAJCQCtSC4mx6cNf3mGDOEeWhJaTXK8s+WNWRTRDMt99k8O3LPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtSC4mx6cNf3mGDOEeWhJaTXK8s+WNWRTRDMt99k8O3LPw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 30, 2021 at 02:40:27PM -0600, Chris Murphy wrote:
> Following the add device, filtered balance, remove device dance:
> 
> Overall:
>     Device size:                  27.52GiB
>     Device allocated:             21.52GiB
>     Device unallocated:            6.00GiB
>     Device missing:                  0.00B
>     Used:                         21.15GiB
>     Free (estimated):              6.30GiB      (min: 6.30GiB)
>     Free (statfs, df):             6.30GiB
>     Data ratio:                       1.00
>     Metadata ratio:                   1.00
>     Global reserve:               55.50MiB      (used: 0.00B)
>     Multiple profiles:                  no
> 
> Data,single: Size:21.01GiB, Used:20.70GiB (98.56%)
>    /dev/mapper/luks-4ac739d9-8d73-4913-89ac-656c79f89835          21.01GiB
> 
> Metadata,single: Size:520.00MiB, Used:456.52MiB (87.79%)
>    /dev/mapper/luks-4ac739d9-8d73-4913-89ac-656c79f89835         520.00MiB
> 
> System,single: Size:4.00MiB, Used:16.00KiB (0.39%)
>    /dev/mapper/luks-4ac739d9-8d73-4913-89ac-656c79f89835           4.00MiB
> 
> Unallocated:
>    /dev/mapper/luks-4ac739d9-8d73-4913-89ac-656c79f89835           6.00GiB
> 
> 
> So it's back to functional again but does seem like some kind of bug
> that it had not allocated another metadata block group sooner when it
> could have. Once all the space was locked up as data bg's, it was
> inevitably going to get stuck like this.

That the metadata chunks don't get allocated timely in advance is sort
of known and not fixed to my knowledge. Also, it's the reason why free
space tree is not yet default.

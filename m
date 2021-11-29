Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869F6461CA6
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 18:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346182AbhK2RZ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 12:25:56 -0500
Received: from w1.tutanota.de ([81.3.6.162]:35270 "EHLO w1.tutanota.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242293AbhK2RXz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 12:23:55 -0500
Received: from w3.tutanota.de (unknown [192.168.1.164])
        by w1.tutanota.de (Postfix) with ESMTP id 8C011FBF397
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Nov 2021 17:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1638206436;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
        bh=C5YI1Cz9ays7FPZs53j/TiC6UcZ0Uou5+iCu/3/MFpA=;
        b=ofLRgKfvieMDLHSmepsG9GaXp7aMT7Qix3Qy+fu35aWfdQXCCnA3QO2CHj3Q68OO
        Uvhw2rqjmF7AdSnv5Z5hUhsaV9M3THsxtxzq/VIHILj/OSs0rkAw7FQ9Wa12UuFZ7JK
        eGT3EwNV5lbNc2ai8wXYJJE7sqI+n/TpfoY3zbT6Wk4KaWhtl2YmsZ08AswpZsDJtPg
        Tz27pyTYbOqQsTDSiJOBJs9dYalhIOTYOVJIw/3/lCZK46FfPYCOnMqR0Rqe03K19dq
        Vc6hEwzy1J9tv75+9wMl4YZ3lxY+8ZiFz70VU0hw52iWWMhieYLqDnv/47OoDUXomFU
        H5s75AzaBg==
Date:   Mon, 29 Nov 2021 18:20:36 +0100 (CET)
From:   Borden <borden_c@tutanota.com>
To:     linux-btrfs@vger.kernel.org
Message-ID: <Mpghb5T--3-2@tutanota.com>
In-Reply-To: <87mtlnaq2p.fsf@vps.thesusis.net>
References: <MpesPIt--3-2@tutanota.com> <87r1azashl.fsf@vps.thesusis.net> <MpgNwtq--3-2@tutanota.com> <87mtlnaq2p.fsf@vps.thesusis.net>
Subject: Re: Connection lost during BTRFS move + resize
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

29 Nov 2021, 11:20 by phill@thesusis.net:
> Theoretically it shouldn't be too hard.  It's just a matter of deciding
> on a location where you can safely record the checkpoint information and
> then update the checkpoint between blocks.  That's how LVM handles
> moves safely.  In the worst case, you restart the move at the last
> checkpoint and just waste some time copying data that was already copied
> but not checkpointed.
>
Thanks again. In those other utilities, since the logs get written to a plain text file of the user's choosing, and partition moving should be offline, anyhow, it would be reasonable to expect the user to provide a safe location to stash a checkpoint file.

And, of course, if the user chooses to manipulate the file and/or forego it altogether, their funeral.
Not sure if it's a feature worth requesting, but it would keep people like me from bothering the list with these Hail Mary support requests, so probably be net-cost negative.

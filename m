Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0946D90448
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 16:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfHPO7e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 10:59:34 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:15993 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfHPO7e (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 10:59:34 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46960z1nmWz9v05y;
        Fri, 16 Aug 2019 16:59:31 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=SwguTCzY; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id oIYrMznhkI2g; Fri, 16 Aug 2019 16:59:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46960z0Wzgz9v05x;
        Fri, 16 Aug 2019 16:59:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565967571; bh=QzBQvuU27IG1FFZD0blGRcB6IDCr/14dULk17F/vjN8=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=SwguTCzYkjeZxTd7cw4B17Cn9PpPUYs/aLJZ0dSQRN+UDCrJk0tRyhrDpj8jBAv1L
         uaA22sEp8FIiaocd8tUtllA0981oLMolUFLJAcLUMWqtiAW4PhESMuBj8cZpk3I6TR
         kXnL80Tnv9LpQYEu5ENS0MUE6odqhVkbZrySRwMg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C2D8C8B78A;
        Fri, 16 Aug 2019 16:59:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4WT5c70SmVZm; Fri, 16 Aug 2019 16:59:32 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AD4008B754;
        Fri, 16 Aug 2019 16:59:32 +0200 (CEST)
Subject: Re: [Bug 204371] BUG kmalloc-4k (Tainted: G W ): Object padding
 overwritten
To:     bugzilla-daemon@bugzilla.kernel.org
References: <bug-204371-206129@https.bugzilla.kernel.org/>
 <bug-204371-206129-GvRQpDzlfW@https.bugzilla.kernel.org/>
Cc:     linux-btrfs@vger.kernel.org
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e20943a9-d1a5-0a49-9917-e7b31674c703@c-s.fr>
Date:   Fri, 16 Aug 2019 16:59:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bug-204371-206129-GvRQpDzlfW@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Le 16/08/2019 à 16:38, bugzilla-daemon@bugzilla.kernel.org a écrit :
> https://bugzilla.kernel.org/show_bug.cgi?id=204371
> 
> --- Comment #34 from Erhard F. (erhard_f@mailbox.org) ---
> On Fri, 16 Aug 2019 08:22:31 +0000
> bugzilla-daemon@bugzilla.kernel.org wrote:
> 
>> https://bugzilla.kernel.org/show_bug.cgi?id=204371
>>
>> --- Comment #32 from Christophe Leroy (christophe.leroy@c-s.fr) ---
>> Then see if the WARNING on kfree() in  btrfs_free_dummy_fs_info() is still
>> there.
> With latest changes there are no complaints of the kernel any longer. btrfs
> selftests pass, mounting and unmounting a btrfs partition works without any
> suspicious dmesg output.
> 

That's good news. Will you handle submitting the patch to BTRFS file 
system ?


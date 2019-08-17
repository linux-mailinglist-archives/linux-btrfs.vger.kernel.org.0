Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBD090F5E
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Aug 2019 10:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfHQIJt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Aug 2019 04:09:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64712 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfHQIJt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Aug 2019 04:09:49 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 469Xsk4XFmz9typx;
        Sat, 17 Aug 2019 10:09:46 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=PFmZ3tEw; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id sNvX-0_3f_4K; Sat, 17 Aug 2019 10:09:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 469Xsk3PNRz9typs;
        Sat, 17 Aug 2019 10:09:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566029386; bh=pVI9gY6iiTOKFqgekWFv504Tf/QYksOUjRjQFOu2kD0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=PFmZ3tEwbCcnorGnd5QrmBxwxFFSuDEhTO5ZjS4uBLNisb+UKUNsl94HoIWJQIWXF
         bOBEfuKIST6lerMbAPKSPdZzybS4qFVQ/HaIuSoZO3dGUCBsiLoMn8RJkAXWz528uW
         yVq0TMp+3G9mqWqk98b8zsX+IrJ6HBJWVGviJp44=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9214B8B793;
        Sat, 17 Aug 2019 10:09:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Lp6brMJxdad5; Sat, 17 Aug 2019 10:09:47 +0200 (CEST)
Received: from [192.168.232.53] (unknown [192.168.232.53])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EAA278B790;
        Sat, 17 Aug 2019 10:09:46 +0200 (CEST)
Subject: Re: [Bug 204371] BUG kmalloc-4k (Tainted: G W ): Object padding
 overwritten
To:     bugzilla-daemon@bugzilla.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-btrfs@vger.kernel.org, erhard_f@mailbox.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <bug-204371-206035@https.bugzilla.kernel.org/>
 <bug-204371-206035-O9m4mwJN9f@https.bugzilla.kernel.org/>
From:   christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <e8b5b450-bdb2-6be8-8b14-bd76b81de9a0@c-s.fr>
Date:   Sat, 17 Aug 2019 10:09:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bug-204371-206035-O9m4mwJN9f@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 190816-4, 16/08/2019), Outbound message
X-Antivirus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Le 30/07/2019 à 20:52, bugzilla-daemon@bugzilla.kernel.org a écrit :
> https://bugzilla.kernel.org/show_bug.cgi?id=204371
> 
> --- Comment #2 from Andrew Morton (akpm@linux-foundation.org) ---
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).

Reply all replies to bugzilla-daemon@bugzilla.kernel.org only.


[...]


> 
> cc'ing various people here.

Hum ... only got that email through the bugzilla interface, and CC'ed 
people don't show up.


> 
> I suspect proc_cgroup_show() is innocent and that perhaps
> bpf_prepare_filter() had a memory scribble.  iirc there has been at
> least one recent pretty serious bpf fix applied recently.  Can others
> please take a look?
> 
> (Seriously - please don't modify this report via the bugzilla web interface!)
> 

Haven't got the original CC'ed list, so please reply with missing Cc's 
if any.

We have well progressed on this case.

Erhard made a relation being this "Object padding overwritten" issue 
arising on any driver, and the presence of the BTRFS driver.

Then he was able to bisect the issue to:

commit 69d2480456d1baf027a86e530989d7bedd698d5f
Author: David Sterba <dsterba@suse.com>
Date:   Fri Jun 29 10:56:44 2018 +0200

     btrfs: use copy_page for copying pages instead of memcpy

     Use the helper that's possibly optimized for full page copies.

     Signed-off-by: David Sterba <dsterba@suse.com>



After looking in the code, it has appeared that some of the said "pages" 
were allocated with "kzalloc()".

Using the patch https://patchwork.ozlabs.org/patch/1148033/ Erhard 
confirmed that some btrfs functions were calling copy_page() with 
misaligned destinations.

copy_page(), at least on powerpc, expects cache aligned destination.

The patch https://patchwork.ozlabs.org/patch/1148606/ fixes the issue.

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus


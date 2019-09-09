Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 368C9AD234
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2019 05:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbfIIDcS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Sep 2019 23:32:18 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:44547 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387479AbfIIDcS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 8 Sep 2019 23:32:18 -0400
X-Greylist: delayed 1155 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Sep 2019 23:32:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Content-Type:Reply-to:
        Subject:To:From:Message-ID:Date:Sender:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=J4B8/94hkCWOLREaFCgqSL9l0PrQAic4FGy5T6UK/9U=; b=0VUCw3N2bug3Piy/SCK2+ExpUg
        aBcZlVaBWs0TzcFvNtI5asLWNN1aGZD/o3jB35jPvHGQqRDpgSEqGTxpk/afmMYzw9oOt0dbOSLLH
        QbcoJ/vnL2wrzeuP9ZNqDAOiH+8nn1DA6LsYkakMZs0bvKMzGKVt9y2P7iKGCJjF35XVryahcwBFT
        BIptXIkKNgs+owveIGkUM8BuJmSQ+TNxihBCSBmNsyw0RU1id+KaRA9p8JSk/xfcSa3zRHyLv4m7m
        CgoH/BFGplPSLK0fYSNdTceKZfLQPMRCffhtkomJ0o66aaWZuOJb/03zVfb0Qg9E9EMx7/2APh+2X
        VlnTXLYw==;
Received: from [::1] (port=56306 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <webmaster@zedlx.com>)
        id 1i7A6r-003Dvm-9R
        for linux-btrfs@vger.kernel.org; Sun, 08 Sep 2019 23:13:02 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Sun, 08 Sep 2019 23:12:57 -0400
Date:   Sun, 08 Sep 2019 23:12:57 -0400
Message-ID: <20190908231257.Horde.d0Er24HBTrPxDmnxpCc_T0V@server53.web-hosting.com>
From:   webmaster@zedlx.com
To:     linux-btrfs@vger.kernel.org
Subject: Feature requests: online backup - defrag - change RAID level
Reply-to: webmaster@zedlx.com
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server53.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - zedlx.com
X-Get-Message-Sender-Via: server53.web-hosting.com: authenticated_id: zedlryqc/from_h
X-Authenticated-Sender: server53.web-hosting.com: webmaster@zedlx.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hello everyone!

I have been programming for a long time (over 20 years), and I am  
quite interested in a lot of low-level stuff. But in reality I have  
never done anything related to kernels or filesystems. But I did a lot  
of assembly, C, OS stuff etc...

Looking at your project status page (at  
https://btrfs.wiki.kernel.org/index.php/Status), I must say that your  
priorities don't quite match mine. Of course, the opinions usually  
differ. It is my opinion that there are some quite essential features  
which btrfs is, unfortunately, still missing.

So here is a list of features which I would rate as very important  
(for a modern COW filesystem like btrfs is), so perhaps you can think  
about it at least a little bit.

1) Full online backup (or copy, whatever you want to call it)
btrfs backup <filesystem name> <partition name> [-f]
- backups a btrfs filesystem given by <filesystem name> to a partition  
<partition name> (with all subvolumes).

- To be performed by creating a new btrfs filesystem in the  
destination partition <partition name>, with a new GUID.
- All data from the source filesystem <filesystem name> is than copied  
to the destination partition, similar to how RAID1 works.
- The size of the destination partition must be sufficient to hold the  
used data from the source filesystem, otherwise the operation fails.  
The point is that the destination doesn't have to be as large as  
source, just sufficient to hold the data (of course, many details and  
concerns are skipped in this short proposal)
- When the operation completes, the destination partition contains a  
fully featured, mountable and unmountable btrfs filesystem, which is  
an exact copy of the source filesystem at some point in time, with all  
the snapshots and subvolumes of the source filesystem.
- There are two possible implementations about how this operation is  
to be performed, depending on whether the destination drive is slower  
than source drive(s) or not (like, when the destination is HDD and the  
source is SDD). If the source and the destination are of similar  
speed, than a RAID1-alike algorithm can be used (all writes  
simultaneously go to the source and the destination). This mode can  
also be used if the user/admin is willing to tolerate a performance  
hit for some relatively short period of time.
The second possible implementation is a bit more complex, it can be  
done by creating a temporary snapshot or by buffering all the current  
writes until they can be written to the destination drive, but this  
implementation is of lesser priority (see if you can make the RAID1  
implementation work first).

2) Sensible defrag
The defrag is currently a joke. If you use defrag than you better not  
use subvolumes/snapshots. That's... very… hard to tolerate. Quite a  
necessary feature. I mean, defrag is an operation that should be  
performed in many circumstances, and in many cases it is even  
automatically initiated. But, btrfs defrag is virtually unusable. And,  
it is unusable where it is most needed, as the presence of subvolumes  
will, predictably, increase fragmentation by quite a lot.

How to do it:
- The extents must not be unshared, but just shuffled a bit. Unsharing  
the extents is, in most situations, not tolerable.

- The defrag should work by doing a full defrag of one 'selected  
subvolume' (which can be selected by user, or it can be guessed  
because the user probably wants to defrag the currently mounted  
subvolume, or default subvolume). The other subvolumes should than  
share data (shared extents) with the 'selected subvolume' (as much as  
possible).

- If you want it even more feature-full and complicated, then you  
could allow the user to specify a list of selected subvolumes, like:  
subvol1, subvol2, subvol3… etc. and the defrag algorithm than defrags  
subvol1 in full, than subvol2 as much as possible while not changing  
subvol1 and at the same time sharing extents with subvol1, than defrag  
subvol3 while not changing subvol1 and subvol2… etc.

- I think it would be wrong to use a general deduplication algorithm  
for this. Instead, the information about the shared extents should be  
analyzed given the starting state of the filesystem, and than the  
algorithm should produce an optimal solution based on the currently  
shared extents.

Deduplication is a different task.

3) Downgrade to 'single' or 'DUP' (also, general easy way to switch  
between RAID levels)

Currently, as much as I gather, user has to do a "btrfs balance start  
-dconvert=single -mconvert=single
", than delete a drive, which is a bit ridiculous sequence of operations.

Can you do something like "btrfs delete", but such that it also  
simultaneously converts to 'single', or some other chosen RAID level?

## I hope that you will consider my suggestions, I hope that I'm  
helpful (although, I guess, the short time I spent working with btrfs  
and writing this mail can not compare with the amount of work you are  
putting into it). Perhaps, teams sometimes need a different  
perspective, outsiders perspective, in order to better understand the  
situation.

So long!


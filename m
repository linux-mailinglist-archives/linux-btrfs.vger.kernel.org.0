Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DC22E8FCF
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jan 2021 05:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbhADE3z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Jan 2021 23:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbhADE3y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 Jan 2021 23:29:54 -0500
X-Greylist: delayed 332 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 03 Jan 2021 20:29:14 PST
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [IPv6:2001:690:2100:1::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E0FC061574
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Jan 2021 20:29:14 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id BC552603AAC2
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jan 2021 04:22:58 +0000 (WET)
X-Virus-Scanned: by amavisd-new-2.11.0 (20160426) (Debian) at
        tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
        by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavisd-new, port 10025)
        with LMTP id ccukotkgQih3 for <linux-btrfs@vger.kernel.org>;
        Mon,  4 Jan 2021 04:22:56 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [IPv6:2001:690:2100:1::b3dd:b9ac])
        by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 20CC5603AAC0
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jan 2021 04:22:56 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tecnico.ulisboa.pt;
        s=mail; t=1609734176;
        bh=pMLVgk3ysqWrVeOs1k/K86AJkb6UHeXJg4CSZ4z3PQ8=;
        h=Date:From:To:Subject;
        b=Gun49dGc1ITP8dqJD9mgc116Mm1cY5diSBehbLhl6dYRHgdsbaP61YvbXSGJTaQON
         +LEyGOSRAragWOOjbFM7TKdxzkKARpondJEyTXKaq8N7NOUAbdbwHf1L53n6aiHov2
         NCp6o7AbqfgYauhCNnVPSqo5wh3jQv8PFbhg62Kw=
Received: from webmail.tecnico.ulisboa.pt (webmail3.tecnico.ulisboa.pt [IPv6:2001:690:2100:1::912f:b135])
        (Authenticated sender: ist186945)
        by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 039EE360070
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jan 2021 04:22:55 +0000 (WET)
Received: from vs1.ist.utl.pt ([2001:690:2100:1::33])
 by webmail.tecnico.ulisboa.pt
 with HTTP (HTTP/1.1 POST); Mon, 04 Jan 2021 04:22:55 +0000
MIME-Version: 1.0
Date:   Mon, 04 Jan 2021 04:22:55 +0000
From:   =?UTF-8?Q?Andr=C3=A9_Isidro_da_Silva?= 
        <andreisilva@tecnico.ulisboa.pt>
To:     linux-btrfs@vger.kernel.org
Subject: tldr; no BTRFS on dev, after a forced shutdown, help
Message-ID: <1bdca54c9a0c575288f2c509246e5a96@tecnico.ulisboa.pt>
X-Sender: andreisilva@tecnico.ulisboa.pt
User-Agent: Roundcube Webmail/1.3.15
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I might be in some panic, I'm sorry for the info I'm not experienced 
enough to give.

I was in a live iso trying really hard to repair my root btrfs from 
which I had used all the space avaiable.. I was trying to move a /usr 
partition into the btrfs system, but I didn't check the space available 
with the tool, instead used normal tools, because I didn't understand or 
actually thought about how the subvolumes would change... sorry this 
isn't even the issue anymore; to move /usr I had a temporary /usr copy 
in another btrfs system (my /home data partition) and so mounted both 
partitions. However this was done in a linux "boot fail console" from 
which I didn't know how to proper shutdown.. so I eventually forced the 
shutdown withou umounting stuff (...), I think that forced shutdown 
might have broken the second partition that now isn't recognized with 
btrfs check or mountable. It might also have happen when using the live 
iso, but the forced shutdown seemed more likely, since I did almost no 
operations but mount/cp. This partition was my data partition, I thought 
it was safe to use for this process, since I was just copying files from 
it. I do have a backup, but it's old so I'll still lose a lot.. help.

I ended up giving up on my system partition after this happens to my 
/home, I'm reinstalling in a ext4 for the time being, so I should have a 
system running to fill in logs missing from this mail written from my 
phone haha.

Regards,

André

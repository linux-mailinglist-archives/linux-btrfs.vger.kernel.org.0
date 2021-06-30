Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759663B8724
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 18:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhF3Qim (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 12:38:42 -0400
Received: from www378.your-server.de ([78.47.166.48]:38578 "EHLO
        www378.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhF3Qil (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 12:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bock.nu;
        s=default2006; h=MIME-Version:Content-Type:In-Reply-To:Subject:To:From:
        Message-ID:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:References;
        bh=S4TWDHvKMWNehg1WWjnRdLDnYBfcQFNoHp6IMi2jBJ8=; b=UBFHj0cz+yeiPBhSrZX7aET2ys
        Ymi+/Ai6g6Z4vwrEvDP3rXgKniwVwNUMItdUpt1SHAsy03+gQAvBK9xODJqLDkr90hoBAW4UaNcAY
        kVqygISKISFt/8GWDUQaLHq6hGPa4fNt6w9KnvmI2NKZFKjbENK7HTppLEOvNBIAfppa4IU5PCcYT
        6fDFkVZW3oTHFWtRmVC6LWY37hTmG/GnuF81x6dxoszd/VB9PQVH3z92g1JwTpIisFD7F5FvNakdC
        4MrEA+4X7U1OVhxLL/lLEvgr+UPBQTMjAFjjoegRgn6KnRT6WqywsNfmdL3q9aeGMQFDOQPKn38Ca
        v6hcfljA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www378.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <bernhard@bock.nu>)
        id 1lydC6-0008rj-6G
        for linux-btrfs@vger.kernel.org; Wed, 30 Jun 2021 18:36:10 +0200
Received: from [192.168.0.31] (helo=webmail.your-server.de)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-CHACHA20-POLY1305:256)
        (Exim 4.92)
        (envelope-from <bernhard@bock.nu>)
        id 1lydC6-000060-4a
        for linux-btrfs@vger.kernel.org; Wed, 30 Jun 2021 18:36:10 +0200
Received: from p200300C98F393300800dE988D2EfCd9F.dip0.t-ipconnect.de
 (p200300C98F393300800dE988D2EfCd9F.dip0.t-ipconnect.de
 [2003:c9:8f39:3300:800d:e988:d2ef:cd9f]) by webmail.your-server.de (Horde
 Framework) with HTTPS; Wed, 30 Jun 2021 18:36:10 +0200
Date:   Wed, 30 Jun 2021 18:36:10 +0200
Message-ID: <20210630183610.Horde.ynUK_R3E05jP-kbHcUJxSir@webmail.your-server.de>
From:   Bernhard Bock <bernhard@bock.nu>
To:     linux-btrfs@vger.kernel.org
Subject: Re: recover from BTRFS critical: corrupt leaf: invalid extent
 length
In-Reply-To: <20210630112105.Horde.--esBg1nCMcX5WI6c4tluy4@webmail.your-server.de>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-Authenticated-Sender: bernhard@bock.nu
X-Virus-Scanned: Clear (ClamAV 0.103.2/26217/Wed Jun 30 13:10:04 2021)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Bernhard Bock <bernhard@bock.nu> wrote:
> I found one of our servers with a read-only btrfs this morning.
> dmesg says:
>
> BTRFS critical (device dm-1): corrupt leaf: block=6404379377664  
> slot=66 extent bytenr=3138606432256 len=18446619972284938920 invalid  
> extent length, have 18446619972284938920 expect aligned to 4096
> ...
> BTRFS error (device dm-1): block=6404379377664 write time tree block  
> corruption detected


looks like all is well.

After a reboot, btrfsck didn't find any errors any more. Additionally,
btfs-scrub also completed without errors.

Seems like the write time btrfs corruption checks found everything before
committing to disk. Possibly a memory error despite ECC RAM?

To any future readers having similar problems: Do not trust any checks / log
statements before reboot if you encounter possible btrfs corruption.

All the best,
Bernhard



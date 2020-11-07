Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237D42AA658
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Nov 2020 16:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgKGPiU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Nov 2020 10:38:20 -0500
Received: from krystal1.wisercloud.co.uk ([185.53.58.188]:43100 "EHLO
        krystal1.wisercloud.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgKGPiU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Nov 2020 10:38:20 -0500
X-Greylist: delayed 1519 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Nov 2020 10:38:19 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=petezilla.co.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wrx0Mj3qLl9ca3xuwcHUJFIIY5Q5ItMTom35QOa7l4M=; b=HjL9fnzoH5lSMNIFmhPsh1A4Z3
        hTi73O8DGCX6vNu/4nbr4XuffEDpxk+FjE9alN9r6r9Gc6Z6+rzfCaS8ZI1ZIXzNAvfcoB01/w9eO
        IrmHS5DhXjNQf3yMfgwPPAqwGfkDLOrruthZfxHCMIp4x1qeiPF6INfiLOozy/qALiTa6GG5jod0R
        qjqdvSQwt2niYxxNAhzq5/E61xwf2S//Q6zIDvjQEyVKTTBkIiObu9cPUxwkqBp5bnHZGI6Qoj2Bk
        b9ZxHrtfDoKy41i4EfPKhgSe0+ijXwZGbdyyqOAB2e/oo0jra9LcXmYexg+gVaoMn5QRsr1IkiX9A
        TK+kkGJQ==;
Received: from cpc76102-ando7-2-0-cust287.15-1.cable.virginm.net ([80.7.33.32]:49270 helo=phoenix.exfire)
        by krystal1.wisercloud.co.uk with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <pete@petezilla.co.uk>)
        id 1kbPtj-0026eo-Eu
        for linux-btrfs@vger.kernel.org; Sat, 07 Nov 2020 15:12:59 +0000
To:     linux-btrfs@vger.kernel.org
From:   Pete <pete@petezilla.co.uk>
Subject: Move from 5.9.3 kernel to 5.4.75?
Message-ID: <7d436bf1-80d2-a298-d124-e9385fb6ef42@petezilla.co.uk>
Date:   Sat, 7 Nov 2020 15:12:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-0.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - krystal1.wisercloud.co.uk
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - petezilla.co.uk
X-Get-Message-Sender-Via: krystal1.wisercloud.co.uk: authenticated_id: pete+petezilla.co.uk/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: krystal1.wisercloud.co.uk: pete@petezilla.co.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Is there an impact for btrfs for moving from a 5.9.3 kernel to 5.4.75
kernel?  I'm using raid1 or single (more than one file system), no 1c2
or 1c3 etc, space_cache_v2 and zstd compression.  The reason is that I'm
trying to see if this fixes another problem - but breaking my file
system is a major concern.

thanks,

Pete

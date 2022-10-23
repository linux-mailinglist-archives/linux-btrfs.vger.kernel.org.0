Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B7F609204
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Oct 2022 11:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJWJce (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Oct 2022 05:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJWJcc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Oct 2022 05:32:32 -0400
Received: from fallback16.mail.ru (fallback16.mail.ru [94.100.177.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932AA748E0
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Oct 2022 02:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=tFVhL6SEBGmTc6cK9+ms5XpCWWOm3HMub7/xNmthRO0=;
        t=1666517550;x=1666607550; 
        b=KPWFFnlA6s+1P2zdfUMRTcv+mmTsGdc0qHOrYFJ0Bo2jzUIPB7JN2uW7sL6ZnMQfDU95MqVMCkqiHwuOClp5T03a1nA/R8vnODY1V91JxRTG/gRxX9i5jfubXyRB5q6jFiUz/sk0Ez8aXD0s6rnI5ofmn1o2/5qPLy5c9USTI3oE+1KkvV0Ia2K026wMm3vJVfyf2hlC/RH+rfc4DVbmjGOnfAyGnW3lJf1pYQ+Uc/2Kp9B/6CdTykMc8xyrsgh0/6LFEOtgD8KQBUHj+ckNEnnCLmZ36qvBpB5wOqpFAF88jfyE3KKU0fGz3/rHNGksJUZZCCyc5viPnAh+AcfDJQ==;
Received: from [10.161.64.51] (port=58748 helo=smtp43.i.mail.ru)
        by fallback16.i with esmtp (envelope-from <Nemcev_Aleksey@inbox.ru>)
        id 1omXLI-00044s-LK
        for linux-btrfs@vger.kernel.org; Sun, 23 Oct 2022 12:32:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=tFVhL6SEBGmTc6cK9+ms5XpCWWOm3HMub7/xNmthRO0=;
        t=1666517548;x=1666607548; 
        b=fVBq3kil2kX0TZIc/PxitWXf8EOBobzZ3wW7o1SYxxtA5qq7efkRF8flurK6FNRS3pNUhXv2a7Ivama1yUndqLDfpfduyQQKnZziEOzZOSPi/CsBwoFsbOs1D6la27A4lg6BM6ukRT2APdryI/u0s8sb2GWvGwOXLzT/nRHneEqPzbjA5fIFOcA8Ed0Jl7xDBFuL7jncy3f1R1dKCjmDAYZkzPxKDfxSFgv9mjAx+TtDyAbnvwG8DAP7cEoDGxoDDseohQgCFKEk1eC9thAoIYyn6gOnGCmragOYaJp8QT6yBEeZ7jCK6RA4pcnhFJFkLkK8lKGrsbjCntaxBTrE5Q==;
Received: by smtp43.i.mail.ru with esmtpa (envelope-from <Nemcev_Aleksey@inbox.ru>)
        id 1omXLF-0003WQ-Et; Sun, 23 Oct 2022 12:32:25 +0300
Message-ID: <3f97ee58-4f52-7660-a9b3-916598d6a463@inbox.ru>
Date:   Sun, 23 Oct 2022 12:32:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: Is it safe to use snapshot without data as 'btrfs send' parent?
To:     Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
References: <d87ce800-670e-9ca2-b524-8b20678abd9b@inbox.ru>
 <d59f04b3-9b79-905c-dca9-5fc4ce7be0a9@gmail.com>
Content-Language: en-US
From:   Nemcev Aleksey <Nemcev_Aleksey@inbox.ru>
In-Reply-To: <d59f04b3-9b79-905c-dca9-5fc4ce7be0a9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD97F9382DBE49763098323D2A359ECCDA6C66D0405163BEBA5182A05F538085040B73A72658F7B652EC7BE321ABB5B30C64ADAECCB8DC82F30EE9C9864BD426D77
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE745C0EDBD94D46193EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F5B2F26146BDF5648638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D885AE7EB527476D2DFD44E243A4A2F1586F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE78C9B9C945842D50B9FA2833FD35BB23D9E625A9149C048EEC8105B04EFE076282CC0D3CB04F14752D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B1F8789D36234D406A471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC2CD69D500EDEFCED3AA81AA40904B5D9CF19DD082D7633A078D18283394535A93AA81AA40904B5D98AA50765F790063782B44B642D65F314D81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F7900637FD0F910194CD92996D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F79006372A9AD9AFD12E543BEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D347215713CF3EEE9D19A28F4EDFBB240AE456711225DCE4DF890AE26C0E8BFD0FAE014218F93A723A41D7E09C32AA3244C17787B8412F76CAA477C32641C3F2069BBA718C7E6A9E042729B2BEF169E0186
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojzTU6WtcYg0vQNEZX7oJBhQ==
X-Mailru-Sender: 00097D31F91C944B825D48F09EF66297D7B0A4CF98998B0D1266A970C0B4BD7922B2497C5550960534915EAF49CC4078BE96CC90913223B28141B1B0B1FAE8F2B1D210AF280BDE3A90E1A63FA06EF59E02DB81B281332CC10D4ABDE8C577C2ED
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B41D0D107CA78B22788DADC62E504B0F5D830060AF6CE1FB0A049FFFDB7839CE9E1EDFD276309BA9D87DDABD9DD3C7082BBE5ECF17B18E6D1B841A7FA69D9FB43F
X-7FA49CB5: 0D63561A33F958A5988B595BAFFD282134857BE4553A8DEBDB832CD452BA40BECACD7DF95DA8FC8BD5E8D9A59859A8B6A096F61ED9298604
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdJleViSEgp/THmJQasgPEjA==
X-Mailru-MI: 800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

23.10.2022 10:01, Andrei Borzenkov wrote:
 > On 23.10.2022 00:13, Nemcev Aleksey wrote:
 >> So I can't just remove unused files to free space on my PC if I keep
 >> parent snapshots for incremental backups on this PC).
 >
 > You only need to keep one latest snapshot to implement incremental 
forever backup.
Yes, I'm already keeping one latest snapshot on original FS for each 
subvolume.
 >
 >> I need to do another backup, then remove snapshot left from previous
 >> backup from my PC to free up space.
 >>
 >
 > Yes, that is what every backup software that supports snapshots does.
 >
 >
 >> # Initial full backup:
 >> # Create temporary snapshot
 >> btrfs subvolume snapshot -r source/@ source/@_backup
 >> # Send temporary snapshot to the backup drive
 >> btrfs send source/@_backup | btrfs receive backup_drive
 >> # Delete temporary snapshot
 >> btrfs subvolume delete source/@_backup
 >> # Move received on backup drive snapshot to its final name
 >> mv backup_drive/@_backup backup_drive/@_backup1
 >> # Send back metadata-only snapshot to source FS
 >> btrfs send --no-data backup_drive/@_backup1 | btrfs receive
 >> source/skinny_snapshots
 >>
 >
 > This creates new subvolume under source/skinny_snapshots with empty 
files. This subvolume is completely unrelated to the original source 
subvolume source/@.
Thank you, got this.
 >
 >> # Incremental backups:
 >> # Create temporary snapshot
 >> btrfs subvolume snapshot -r source/@ source/@_backup
 >> # Send temporary snapshot to the backup drive using metadata-only
 >> snapshot as parent
 >> btrfs send source/@_backup -p source/skinny_snapshots/@_backup1 | btrfs
 >> receive backup_drive
 >
 > This sends difference between "skinny snapshot" with empty files and 
your current filesystem. Which means it sends full content of all files 
currently present on filesystem effectively converting incremental send 
stream into full send stream.
 > Again - you could replace all this voodoo dance with simple sequence 
of full "btrfs send". Your procedure loses all advantages of btrfs data 
sharing between snapshots both during send (you always send full 
content) and on backup storage (because receive side is unaware that 
identical files share the same data).


I thought it will be possible to somehow track changes for ongoing 
incremental backup but also be able to delete files on original FS and 
immideately reclaim free space without losing incremental backup 
ability. I don't use snapshot on original FS as backup, only as parent 
reference for incremental send and would be happy if it will be any way 
to avoid space consumption by this snapshot for deleted files (just to 
keep track "this file should be deleted or overwritten" references).
But it seems the only way to use incremental send|receive requires to 
keep normal snapshot on original FS as parent.

Thank you.

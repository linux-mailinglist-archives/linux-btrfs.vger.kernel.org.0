Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE6E209CC5
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jun 2020 12:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404019AbgFYKYQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jun 2020 06:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403896AbgFYKXy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jun 2020 06:23:54 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D61C061573
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jun 2020 03:23:39 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e18so3095141pgn.7
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jun 2020 03:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=gzdW4JC7YwNpP4u5UuWfAmqHdDaBCnZGNr6ueABujtQ=;
        b=armqyTeLYlKI4T3FTBBvun6t7XV86LNSgBudr2mX3fCJN3uYQ3kesLoL+0BQA3U2Fn
         fmqwfFWw/kUU3fhLyZoehFamOlEFTafDTTgaMoZkHgmyT2NHSlpWktlt33PfBb/O54tY
         pgMutiHpxmFQ821egRne6CqRs/N75TQu9PTpR8ukO3eMbsrenxdycEr8L+v6F/Ce9jPF
         k/Yx29afdKo94McWfs2kj0vnxTzGViZhXBCvORag70ECjV7bM4hvDUDGaJyIkwpqsNxc
         KMrZA5+gyw7iBkAsLWkuvgXrjqmvezYY6zZQrFa9wvP2NJNWiHcyK3v4ILkPbJUL5rhS
         zyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=gzdW4JC7YwNpP4u5UuWfAmqHdDaBCnZGNr6ueABujtQ=;
        b=pxzvbixvTd31qRHK68JaOqmi15aUKrYWJI0rFs17nI4TxAhmnlgVFYEOOGg+USrO9n
         /f5YUquaplzv3Q/Dqjd5QGC3i78XHb+tYW9N6uLJ2smxaWCKY1aRN/+dTpth/Ibl2buH
         Q1qaBR2SZilGIm4jHp1cszqWH70qqV9p2LHYLswYIUjqF6IZO8wpN2XfkhlJBlnVjG2S
         MJTKN5biD4niYe2rFiU8NKelAkDG/ntGxApqYAbXxUDp2vqYMq08xkW6vtZ3xrkqCQ/F
         MMVHNs56C4sz6w5OYAPb8igY/IoM09AfYIECObUNRbzug/ZzwCUaqpjmtf+oRNb5KTZR
         e1Iw==
X-Gm-Message-State: AOAM532SfkSqH2ijdzM8BRGXl8Gxwpu9zMJB8MyR3VUcz9IqoRRp7H5U
        x4ftuVQvqIn/wMLUVmQuNm+tlF/D
X-Google-Smtp-Source: ABdhPJxMZa6Pc+D2l4bfYXHHCejTJudMHixc8JavkyAU0b5Hx4q2RjoztjBjXnjJR6kPjqKoA19iBg==
X-Received: by 2002:a63:4911:: with SMTP id w17mr25286420pga.13.1593080618217;
        Thu, 25 Jun 2020 03:23:38 -0700 (PDT)
Received: from [192.168.178.53] (220-245-192-226.tpgi.com.au. [220.245.192.226])
        by smtp.gmail.com with ESMTPSA id g63sm4607638pje.14.2020.06.25.03.23.36
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 03:23:37 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   DanglingPointer <danglingpointerexception@gmail.com>
Subject: RAID5 scrub 1 or 2 disks at a time instead to speed up
Message-ID: <75eef36f-b85a-9ec3-2d77-df646c536712@gmail.com>
Date:   Thu, 25 Jun 2020 20:23:35 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi All,

I continually get frustrated each time I have a scrub a btrfs RAID5 
array due to the slow rate.
I was wondering if anyone has tried or seriously considered scrubbing 1 
or 2 disks at a time, instead of all disks engaged at the same time 
(perhaps a division check on number of disks before start) to see if it 
is indeed faster?

Zygo Blaxell mentioned the above idea on Feb 6 this year.  Just 
wondering if there's been any serious thought put into the merits of 
that idea?

The array I'm running the scrub on now has 7 disks (5x 2TB and 2x 6TB).  
If it is a question of diminishing returns on speed as the number of 
disks increases; perhaps we say up to 8 disks then do 1 or 2 at a time 
sequentially, then over 8 just do default like right now?

If it is indeed faster then it would make the uptake of btrfs RAID56 a 
lot more friendlier and decrease the amount of flak it gets in the wild.


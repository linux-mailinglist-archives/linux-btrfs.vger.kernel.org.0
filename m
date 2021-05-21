Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348B038CFA2
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 23:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhEUVLx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 17:11:53 -0400
Received: from mail.dubielvitrum.pl ([91.194.229.150]:34635 "EHLO
        naboo.endor.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229503AbhEUVLw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 17:11:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id D3AD39D5DF0;
        Fri, 21 May 2021 23:10:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.149])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pt9FviJOesLU; Fri, 21 May 2021 23:10:24 +0200 (CEST)
Received: from [192.168.55.108] (93.159.186.235.studiowik.net.pl [93.159.186.235])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id DD90D9D5DEE;
        Fri, 21 May 2021 23:10:24 +0200 (CEST)
Subject: Re: Btrfs not using all devices in raid1
To:     Forza <forza@tnonline.net>, linux-btrfs@vger.kernel.org
References: <63123a58-18a4-24ff-3b30-9a0668c167c4@dubiel.pl>
 <89853f6.7deb9c63.179908e0b59@tnonline.net>
From:   Leszek Dubiel <leszek@dubiel.pl>
Message-ID: <efa44798-ff3e-0dc6-06fb-b5cbf6569d40@dubiel.pl>
Date:   Fri, 21 May 2021 23:10:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <89853f6.7deb9c63.179908e0b59@tnonline.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: pl-PL
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> Raid1 means two copies on different devices. This is fulfilled with the previous 3 drives so the  'soft' keyword is not going to help here. 

That's right.



> You can do a full data balance (-dusage=100) to move some data across to the new disk. There is no need to do a metadata balance in this case, unless you want to convert to raid1c3 to have three copies of metadata. 


This is production server, and I don't want to do full balance, because it will hit performance for users.
I hoped that when data gets written to filesysystem BTRFS will choose drive that has most free space, that is /dev/sdc2.

Is there any way to tell BTRFS to use /dev/sdc2?




>  If you do nothing, the filesystem will eventually balance itself as you add abs delete data. 


If I do nothing then /dev/sd{a,b,d}2 would get almost full, and only 
after /dev/sdc2 would be used?




Not using /dev/sdc2 is bad because:

-- maybe this drive is already failed, but nothing is written to it so I 
have no reports of errors

-- other drives get all the data, so if one of them fails, then I will 
have to take longer time to replace it

I would prefer to have all drives EQUAL in Raid1.




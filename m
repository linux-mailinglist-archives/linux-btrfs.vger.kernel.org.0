Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC37985BB
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 22:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfHUUiV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 16:38:21 -0400
Received: from phi.wiserhosting.co.uk ([77.245.66.218]:36428 "EHLO
        phi.wiserhosting.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfHUUiV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 16:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=petezilla.co.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KPITsKkQrz1PSNF37dIAQu7iqHaZomP28ex+fkZwACk=; b=r4gCB5L839yK8B3V4FuL1Hf7lq
        O3toCtml2gR05o2RLMO/yxF5OMQXXIjqubPdj2YXerUktRsGLZHFcZUx6JvxSfkZVFFWaCCIRFdYq
        Xgopc/Z3OcZuW2bFeg1qxVP18PBXaf11az9VUQrCPdZXSqloOumn/N6KLiEJN3ETbcE69GgESycTZ
        0Plk53W5bKnl/gVNcHuL7GoJn1KlGmS+bYDSU1YbzOXf4sxeTZhus8VNp1DvBf4pNmkbl99Zg+9gs
        N1t8GSU/SpuYo5duYxT//t52COrFkYmiSSADsKH7pPnPuaDDpFJLtC6gwUcnLFBngkPltA4h4LOWe
        Ru4b0KWg==;
Received: from cpc75874-ando7-2-0-cust841.15-1.cable.virginm.net ([86.12.75.74]:59460 helo=[172.16.100.107])
        by phi.wiserhosting.co.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <pete@petezilla.co.uk>)
        id 1i0XN2-00EYgz-Nx; Wed, 21 Aug 2019 21:38:18 +0100
Subject: Re: Chasing IO errors. BTRFS: error (device dm-2) in
 btrfs_run_delayed_refs:2907: errno=-5 IO failure
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <fc2b166a-4466-4a5a-ee88-da5e57ee89b6@petezilla.co.uk>
 <CAJCQCtSWi+PUbOWXNwv0guCLRuSgZunWdvRBB4TKMG_X48jHFw@mail.gmail.com>
 <2433d4cb-e7f7-72c5-977b-02f51e9717b3@petezilla.co.uk>
 <e439aafe-8836-b761-3b72-b9215b463c09@gmx.com>
From:   Peter Chant <pete@petezilla.co.uk>
Message-ID: <c593c2ef-044d-32e1-a75d-a2116a5b91a5@petezilla.co.uk>
Date:   Wed, 21 Aug 2019 22:38:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e439aafe-8836-b761-3b72-b9215b463c09@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-0.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - phi.wiserhosting.co.uk
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - petezilla.co.uk
X-Get-Message-Sender-Via: phi.wiserhosting.co.uk: authenticated_id: pete@petezilla.co.uk
X-Authenticated-Sender: phi.wiserhosting.co.uk: pete@petezilla.co.uk
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/21/19 8:29 AM, Qu Wenruo wrote:

>> I'll run the checks shortly.
> 
> Well, check will also report that transid mismatch, and possibly a lot
> of extent tree corruption.
> 


Depends on what is 'a lot', over 400 lines here:

parent transid verify failed on 11000765267968 wanted 2265511 found 2265437
parent transid verify failed on 11000777834496 wanted 2265511 found 2265453
parent transid verify failed on 11001243893760 wanted 2265512 found 2265500
parent transid verify failed on 11000777621504 wanted 2265511 found 2265443
parent transid verify failed on 11001243942912 wanted 2265512 found 2265500
parent transid verify failed on 11001244483584 wanted 2265512 found 2265500
parent transid verify failed on 11000487755776 wanted 2265512 found 2265510
parent transid verify failed on 11001244549120 wanted 2265512 found 2265500
parent transid verify failed on 11001244598272 wanted 2265512 found 2265500
parent transid verify failed on 11000493064192 wanted 2265512 found 2265510
parent transid verify failed on 11000711954432 wanted 2265511 found 2265510
parent transid verify failed on 11000723996672 wanted 2265511 found 2265510
parent transid verify failed on 11001306152960 wanted 2265511 found 2265509
parent transid verify failed on 11000737202176 wanted 2265511 found 2265510
parent transid verify failed on 11000739381248 wanted 2265511 found 2265510
parent transid verify failed on 11000777506816 wanted 2265511 found 2265453
parent transid verify failed on 11000493228032 wanted 2265512 found 2265510
parent transid verify failed on 11001244745728 wanted 2265512 found 2265500
parent transid verify failed on 11001244893184 wanted 2265512 found 2265500
parent transid verify failed on 11000493604864 wanted 2265512 found 2265510
parent transid verify failed on 11000767119360 wanted 2265511 found 2265446
parent transid verify failed on 11000767201280 wanted 2265511 found 2265439
parent transid verify failed on 11000767283200 wanted 2265511 found 2265433
parent transid verify failed on 11000764989440 wanted 2265511 found 2265433
parent transid verify failed on 11000777818112 wanted 2265511 found 2265453
parent transid verify failed on 11001244975104 wanted 2265512 found 2265500
parent transid verify failed on 11001245384704 wanted 2265512 found 2265500
parent transid verify failed on 11000767709184 wanted 2265511 found 2265445
parent transid verify failed on 11000768135168 wanted 2265511 found 2265446
parent transid verify failed on 11000777801728 wanted 2265511 found 2265453
parent transid verify failed on 11001249447936 wanted 2265512 found 2265500
parent transid verify failed on 11001249742848 wanted 2265512 found 2265500
parent transid verify failed on 11001294536704 wanted 2265512 found 2265509
parent transid verify failed on 11001294569472 wanted 2265512 found 2265509
parent transid verify failed on 11001253101568 wanted 2265512 found 2265500
parent transid verify failed on 11001295372288 wanted 2265512 found 2265509
parent transid verify failed on 11000781504512 wanted 2265511 found 2265453
parent transid verify failed on 11000779374592 wanted 2265511 found 2265453
parent transid verify failed on 11000780029952 wanted 2265511 found 2265453
parent transid verify failed on 11000781750272 wanted 2265511 found 2265453
parent transid verify failed on 11000780177408 wanted 2265511 found 2265453
parent transid verify failed on 11000781799424 wanted 2265511 found 2265453
parent transid verify failed on 11000780275712 wanted 2265511 found 2265453
parent transid verify failed on 11000781815808 wanted 2265511 found 2265453
parent transid verify failed on 11000771198976 wanted 2265511 found 2265451
parent transid verify failed on 11000778047488 wanted 2265511 found 2265453
parent transid verify failed on 11000778063872 wanted 2265511 found 2265453
parent transid verify failed on 11000775032832 wanted 2265511 found 2265453
parent transid verify failed on 11000775114752 wanted 2265511 found 2265442
parent transid verify failed on 11000775311360 wanted 2265511 found 2265451
parent transid verify failed on 11001249185792 wanted 2265512 found 2265500
parent transid verify failed on 11001249251328 wanted 2265512 found 2265500
parent transid verify failed on 11000769249280 wanted 2265512 found 2265437
parent transid verify failed on 11000778129408 wanted 2265511 found 2265451
parent transid verify failed on 11000775753728 wanted 2265511 found 2265452
parent transid verify failed on 11000781864960 wanted 2265511 found 2265453
parent transid verify failed on 11000781062144 wanted 2265511 found 2265453
parent transid verify failed on 11000775868416 wanted 2265511 found 2265442
parent transid verify failed on 11000778194944 wanted 2265511 found 2265452
parent transid verify failed on 11000777408512 wanted 2265511 found 2265443
parent transid verify failed on 11000776310784 wanted 2265511 found 2265452
parent transid verify failed on 11000776392704 wanted 2265511 found 2265453
parent transid verify failed on 11000776458240 wanted 2265511 found 2265453
[1/7] checking root items
parent transid verify failed on 11000765284352 wanted 2265511 found 2265437
parent transid verify failed on 11000486051840 wanted 2265512 found 2265510
parent transid verify failed on 11000765382656 wanted 2265511 found 2265437
parent transid verify failed on 11000765448192 wanted 2265511 found 2265448
parent transid verify failed on 11000765464576 wanted 2265511 found 2265437
parent transid verify failed on 11000765513728 wanted 2265511 found 2265439
parent transid verify failed on 11000765562880 wanted 2265511 found 2265439
parent transid verify failed on 11000765579264 wanted 2265511 found 2265445
parent transid verify failed on 11000765612032 wanted 2265511 found 2265439
parent transid verify failed on 11000765628416 wanted 2265511 found 2265439
parent transid verify failed on 11000765693952 wanted 2265511 found 2265439
parent transid verify failed on 11000765775872 wanted 2265511 found 2265439
parent transid verify failed on 11000765792256 wanted 2265511 found 2265439
parent transid verify failed on 11000765841408 wanted 2265511 found 2265439
parent transid verify failed on 11000765874176 wanted 2265511 found 2265439
parent transid verify failed on 11000765972480 wanted 2265511 found 2265445
parent transid verify failed on 11000766021632 wanted 2265511 found 2265447
parent transid verify failed on 11000486477824 wanted 2265512 found 2265510
parent transid verify failed on 11000766136320 wanted 2265511 found 2265437
parent transid verify failed on 11000766169088 wanted 2265511 found 2265439
parent transid verify failed on 11000766349312 wanted 2265511 found 2265445
parent transid verify failed on 11000766595072 wanted 2265511 found 2265437
parent transid verify failed on 11001304416256 wanted 2265511 found 2265509
parent transid verify failed on 11001305972736 wanted 2265511 found 2265509
parent transid verify failed on 11000699371520 wanted 2265511 found 2265510
parent transid verify failed on 11001306595328 wanted 2265511 found 2265509
parent transid verify failed on 11000742772736 wanted 2265511 found 2265510
parent transid verify failed on 11000763285504 wanted 2265511 found 2265439
parent transid verify failed on 11000486871040 wanted 2265512 found 2265510
parent transid verify failed on 11000762761216 wanted 2265511 found 2265446
parent transid verify failed on 11001306890240 wanted 2265511 found 2265509
parent transid verify failed on 11001307332608 wanted 2265511 found 2265509
parent transid verify failed on 11001307676672 wanted 2265511 found 2265509
parent transid verify failed on 11000762810368 wanted 2265511 found 2265437
parent transid verify failed on 11000764448768 wanted 2265511 found 2265446
parent transid verify failed on 11000764481536 wanted 2265511 found 2265433
parent transid verify failed on 11000699240448 wanted 2265511 found 2265510
parent transid verify failed on 11000764710912 wanted 2265511 found 2265446
parent transid verify failed on 11000764825600 wanted 2265511 found 2265437
parent transid verify failed on 11000764891136 wanted 2265511 found 2265433
parent transid verify failed on 11000764907520 wanted 2265511 found 2265444
parent transid verify failed on 11000765120512 wanted 2265511 found 2265444
parent transid verify failed on 11000707203072 wanted 2265511 found 2265510
parent transid verify failed on 11000490459136 wanted 2265512 found 2265510
parent transid verify failed on 11000766726144 wanted 2265511 found 2265437
parent transid verify failed on 11000766742528 wanted 2265511 found 2265437
parent transid verify failed on 11000766791680 wanted 2265511 found 2265437
parent transid verify failed on 11000766824448 wanted 2265511 found 2265437
parent transid verify failed on 11000707809280 wanted 2265511 found 2265510
parent transid verify failed on 11000708661248 wanted 2265511 found 2265510
parent transid verify failed on 11000710070272 wanted 2265511 found 2265510
parent transid verify failed on 11000710152192 wanted 2265511 found 2265510
parent transid verify failed on 11000710250496 wanted 2265511 found 2265510
parent transid verify failed on 11000710348800 wanted 2265511 found 2265510
parent transid verify failed on 11000710496256 wanted 2265511 found 2265510
parent transid verify failed on 11000710529024 wanted 2265511 found 2265510
parent transid verify failed on 11000710758400 wanted 2265511 found 2265510
parent transid verify failed on 11000710889472 wanted 2265511 found 2265510
parent transid verify failed on 11000710922240 wanted 2265511 found 2265510
parent transid verify failed on 11000493146112 wanted 2265512 found 2265510
parent transid verify failed on 11000710938624 wanted 2265511 found 2265510
parent transid verify failed on 11000712069120 wanted 2265511 found 2265510
parent transid verify failed on 11000716148736 wanted 2265511 found 2265510
parent transid verify failed on 11000716574720 wanted 2265511 found 2265510
parent transid verify failed on 11000717410304 wanted 2265511 found 2265510
parent transid verify failed on 11000717443072 wanted 2265511 found 2265510
parent transid verify failed on 11000717508608 wanted 2265511 found 2265510
parent transid verify failed on 11000717754368 wanted 2265511 found 2265510
parent transid verify failed on 11000718196736 wanted 2265511 found 2265510
parent transid verify failed on 11000719474688 wanted 2265511 found 2265510
parent transid verify failed on 11000724389888 wanted 2265511 found 2265510
parent transid verify failed on 11000724488192 wanted 2265511 found 2265510
parent transid verify failed on 11000724570112 wanted 2265511 found 2265510
parent transid verify failed on 11000724766720 wanted 2265511 found 2265510
parent transid verify failed on 11000724963328 wanted 2265511 found 2265510
parent transid verify failed on 11000725061632 wanted 2265511 found 2265510
parent transid verify failed on 11000725078016 wanted 2265511 found 2265510
parent transid verify failed on 11000725225472 wanted 2265511 found 2265510
parent transid verify failed on 11000725274624 wanted 2265511 found 2265510
parent transid verify failed on 11000726503424 wanted 2265511 found 2265510
parent transid verify failed on 11000727044096 wanted 2265511 found 2265510
parent transid verify failed on 11000727617536 wanted 2265511 found 2265510
parent transid verify failed on 11000728125440 wanted 2265511 found 2265510
parent transid verify failed on 11000728289280 wanted 2265511 found 2265510
parent transid verify failed on 11000728305664 wanted 2265511 found 2265510
parent transid verify failed on 11000728338432 wanted 2265511 found 2265510
parent transid verify failed on 11000728354816 wanted 2265511 found 2265510
parent transid verify failed on 11000728698880 wanted 2265511 found 2265510
parent transid verify failed on 11000729190400 wanted 2265511 found 2265510
parent transid verify failed on 11000729501696 wanted 2265511 found 2265510
parent transid verify failed on 11000729600000 wanted 2265511 found 2265510
parent transid verify failed on 11000729747456 wanted 2265511 found 2265510
parent transid verify failed on 11000725356544 wanted 2265511 found 2265510
parent transid verify failed on 11000725405696 wanted 2265511 found 2265510
parent transid verify failed on 11000725471232 wanted 2265511 found 2265510
parent transid verify failed on 11000729796608 wanted 2265511 found 2265510
parent transid verify failed on 11000730714112 wanted 2265511 found 2265510
parent transid verify failed on 11000731172864 wanted 2265511 found 2265510
parent transid verify failed on 11000731697152 wanted 2265511 found 2265510
parent transid verify failed on 11000731729920 wanted 2265511 found 2265510
parent transid verify failed on 11000732237824 wanted 2265511 found 2265510
parent transid verify failed on 11000732598272 wanted 2265511 found 2265510
parent transid verify failed on 11000732778496 wanted 2265511 found 2265510
parent transid verify failed on 11000734203904 wanted 2265511 found 2265510
parent transid verify failed on 11000734318592 wanted 2265511 found 2265510
parent transid verify failed on 11000734728192 wanted 2265511 found 2265510
parent transid verify failed on 11000702025728 wanted 2265511 found 2265510
parent transid verify failed on 11000700141568 wanted 2265511 found 2265510
parent transid verify failed on 11000735039488 wanted 2265511 found 2265510
parent transid verify failed on 11000735662080 wanted 2265511 found 2265510
parent transid verify failed on 11000735711232 wanted 2265511 found 2265510
parent transid verify failed on 11000735793152 wanted 2265511 found 2265510
parent transid verify failed on 11000736415744 wanted 2265511 found 2265510
parent transid verify failed on 11000739250176 wanted 2265511 found 2265510
parent transid verify failed on 11000739315712 wanted 2265511 found 2265510
parent transid verify failed on 11000739430400 wanted 2265511 found 2265510
parent transid verify failed on 11000739463168 wanted 2265511 found 2265510
parent transid verify failed on 11000739479552 wanted 2265511 found 2265510
parent transid verify failed on 11000740003840 wanted 2265511 found 2265510
parent transid verify failed on 11000740298752 wanted 2265511 found 2265510
parent transid verify failed on 11000740937728 wanted 2265511 found 2265510
parent transid verify failed on 11000741953536 wanted 2265511 found 2265510
parent transid verify failed on 11000703320064 wanted 2265511 found 2265510
parent transid verify failed on 11000703795200 wanted 2265511 found 2265510
parent transid verify failed on 11000746377216 wanted 2265511 found 2265510
parent transid verify failed on 11000746442752 wanted 2265511 found 2265510
parent transid verify failed on 11000746557440 wanted 2265511 found 2265510
parent transid verify failed on 11000746606592 wanted 2265511 found 2265510
parent transid verify failed on 11000746721280 wanted 2265511 found 2265510
parent transid verify failed on 11000746770432 wanted 2265511 found 2265510
parent transid verify failed on 11000746835968 wanted 2265511 found 2265510
parent transid verify failed on 11000746852352 wanted 2265511 found 2265510
parent transid verify failed on 11000746934272 wanted 2265511 found 2265510
parent transid verify failed on 11000747212800 wanted 2265511 found 2265510
parent transid verify failed on 11000747294720 wanted 2265511 found 2265510
parent transid verify failed on 11000747458560 wanted 2265511 found 2265510
parent transid verify failed on 11000748097536 wanted 2265511 found 2265510
parent transid verify failed on 11000748195840 wanted 2265511 found 2265510
parent transid verify failed on 11000748228608 wanted 2265511 found 2265510
parent transid verify failed on 11000749244416 wanted 2265511 found 2265510
parent transid verify failed on 11000750047232 wanted 2265511 found 2265510
parent transid verify failed on 11000751538176 wanted 2265511 found 2265510
parent transid verify failed on 11000700846080 wanted 2265511 found 2265510
parent transid verify failed on 11000750620672 wanted 2265511 found 2265510
parent transid verify failed on 11000750702592 wanted 2265511 found 2265510
parent transid verify failed on 11000751767552 wanted 2265511 found 2265510
parent transid verify failed on 11000752160768 wanted 2265511 found 2265510
parent transid verify failed on 11000752275456 wanted 2265511 found 2265510
parent transid verify failed on 11000752340992 wanted 2265511 found 2265510
parent transid verify failed on 11000752717824 wanted 2265511 found 2265510
parent transid verify failed on 11000752848896 wanted 2265511 found 2265510
parent transid verify failed on 11000752865280 wanted 2265511 found 2265510
parent transid verify failed on 11000752963584 wanted 2265511 found 2265510
parent transid verify failed on 11000753389568 wanted 2265511 found 2265510
parent transid verify failed on 11000753471488 wanted 2265511 found 2265510
parent transid verify failed on 11000753553408 wanted 2265511 found 2265510
parent transid verify failed on 11000753668096 wanted 2265511 found 2265510
parent transid verify failed on 11000753799168 wanted 2265511 found 2265510
parent transid verify failed on 11000753848320 wanted 2265511 found 2265510
parent transid verify failed on 11000754012160 wanted 2265511 found 2265510
parent transid verify failed on 11000754061312 wanted 2265511 found 2265510
parent transid verify failed on 11000754143232 wanted 2265511 found 2265510
parent transid verify failed on 11000754159616 wanted 2265511 found 2265510
parent transid verify failed on 11000754208768 wanted 2265511 found 2265510
parent transid verify failed on 11000754241536 wanted 2265511 found 2265510
parent transid verify failed on 11000754454528 wanted 2265511 found 2265510
parent transid verify failed on 11000754520064 wanted 2265511 found 2265510
parent transid verify failed on 11000754618368 wanted 2265511 found 2265510
parent transid verify failed on 11000754651136 wanted 2265511 found 2265510
parent transid verify failed on 11000754700288 wanted 2265511 found 2265510
parent transid verify failed on 11000754765824 wanted 2265511 found 2265510
parent transid verify failed on 11000754798592 wanted 2265511 found 2265510
parent transid verify failed on 11000754978816 wanted 2265511 found 2265510
parent transid verify failed on 11000755060736 wanted 2265511 found 2265510
parent transid verify failed on 11000755093504 wanted 2265511 found 2265510
parent transid verify failed on 11000755240960 wanted 2265511 found 2265510
parent transid verify failed on 11000755306496 wanted 2265511 found 2265510
parent transid verify failed on 11000755322880 wanted 2265511 found 2265510
parent transid verify failed on 11000755699712 wanted 2265511 found 2265510
parent transid verify failed on 11000755798016 wanted 2265511 found 2265510
parent transid verify failed on 11000755896320 wanted 2265511 found 2265510
parent transid verify failed on 11000755912704 wanted 2265511 found 2265510
parent transid verify failed on 11000756027392 wanted 2265511 found 2265510
parent transid verify failed on 11000756076544 wanted 2265511 found 2265510
parent transid verify failed on 11000756142080 wanted 2265511 found 2265510
parent transid verify failed on 11000756174848 wanted 2265511 found 2265510
parent transid verify failed on 11000756453376 wanted 2265511 found 2265510
parent transid verify failed on 11000756518912 wanted 2265511 found 2265510
parent transid verify failed on 11000756568064 wanted 2265511 found 2265510
parent transid verify failed on 11000756600832 wanted 2265511 found 2265510
parent transid verify failed on 11000756912128 wanted 2265511 found 2265510
parent transid verify failed on 11000757207040 wanted 2265511 found 2265510
parent transid verify failed on 11000757551104 wanted 2265511 found 2265510
parent transid verify failed on 11000757370880 wanted 2265511 found 2265510
parent transid verify failed on 11000493260800 wanted 2265512 found 2265510
parent transid verify failed on 11000757731328 wanted 2265511 found 2265510
parent transid verify failed on 11000758157312 wanted 2265511 found 2265510
parent transid verify failed on 11000758288384 wanted 2265511 found 2265510
parent transid verify failed on 11000758337536 wanted 2265511 found 2265510
parent transid verify failed on 11000759025664 wanted 2265511 found 2265510
parent transid verify failed on 11000758452224 wanted 2265511 found 2265510
parent transid verify failed on 11000758468608 wanted 2265511 found 2265510
parent transid verify failed on 11000758632448 wanted 2265511 found 2265510
parent transid verify failed on 11000759140352 wanted 2265511 found 2265510
parent transid verify failed on 11000759189504 wanted 2265511 found 2265510
parent transid verify failed on 11000759255040 wanted 2265511 found 2265510
parent transid verify failed on 11000759304192 wanted 2265511 found 2265510
parent transid verify failed on 11000759336960 wanted 2265511 found 2265510
parent transid verify failed on 11000759762944 wanted 2265511 found 2265444
parent transid verify failed on 11000760221696 wanted 2265511 found 2265432
parent transid verify failed on 11000760254464 wanted 2265511 found 2265432
parent transid verify failed on 11000760303616 wanted 2265511 found 2265444
parent transid verify failed on 11000760401920 wanted 2265511 found 2265444
parent transid verify failed on 11000760483840 wanted 2265511 found 2265444
parent transid verify failed on 11000760500224 wanted 2265511 found 2265442
parent transid verify failed on 11000760631296 wanted 2265511 found 2265444
parent transid verify failed on 11000760909824 wanted 2265511 found 2265432
parent transid verify failed on 11000760942592 wanted 2265511 found 2265439
parent transid verify failed on 11000760958976 wanted 2265511 found 2265444
parent transid verify failed on 11000761106432 wanted 2265511 found 2265432
parent transid verify failed on 11000761335808 wanted 2265511 found 2265444
parent transid verify failed on 11000761352192 wanted 2265511 found 2265444
parent transid verify failed on 11000761516032 wanted 2265511 found 2265444
parent transid verify failed on 11000761532416 wanted 2265511 found 2265444
parent transid verify failed on 11000761597952 wanted 2265511 found 2265444
parent transid verify failed on 11000761614336 wanted 2265511 found 2265444
parent transid verify failed on 11000762155008 wanted 2265511 found 2265445
parent transid verify failed on 11000762433536 wanted 2265511 found 2265444
parent transid verify failed on 11000762335232 wanted 2265511 found 2265445
parent transid verify failed on 11000762580992 wanted 2265511 found 2265446
parent transid verify failed on 11000762695680 wanted 2265511 found 2265445
parent transid verify failed on 11000494047232 wanted 2265512 found 2265510
parent transid verify failed on 11000765071360 wanted 2265511 found 2265444
parent transid verify failed on 11000494276608 wanted 2265512 found 2265510
parent transid verify failed on 11000767102976 wanted 2265511 found 2265439
parent transid verify failed on 11000767152128 wanted 2265511 found 2265448
parent transid verify failed on 11000767217664 wanted 2265511 found 2265439
parent transid verify failed on 11000767250432 wanted 2265511 found 2265448
parent transid verify failed on 11000767692800 wanted 2265511 found 2265444
parent transid verify failed on 11000767758336 wanted 2265511 found 2265446
parent transid verify failed on 11000767807488 wanted 2265511 found 2265450
parent transid verify failed on 11000767856640 wanted 2265511 found 2265448
parent transid verify failed on 11000767873024 wanted 2265511 found 2265444
parent transid verify failed on 11000767938560 wanted 2265511 found 2265433
parent transid verify failed on 11000768102400 wanted 2265511 found 2265446
parent transid verify failed on 11000768118784 wanted 2265511 found 2265444
parent transid verify failed on 11000768249856 wanted 2265511 found 2265439
parent transid verify failed on 11000496242688 wanted 2265512 found 2265510
parent transid verify failed on 11000496308224 wanted 2265512 found 2265510
parent transid verify failed on 11000764596224 wanted 2265511 found 2265437
parent transid verify failed on 11000764661760 wanted 2265511 found 2265437
parent transid verify failed on 11001249759232 wanted 2265512 found 2265500
parent transid verify failed on 11001250086912 wanted 2265512 found 2265500
parent transid verify failed on 11001257312256 wanted 2265512 found 2265500
parent transid verify failed on 11001257394176 wanted 2265512 found 2265500
parent transid verify failed on 11000779407360 wanted 2265511 found 2265453
parent transid verify failed on 11001299206144 wanted 2265512 found 2265509
parent transid verify failed on 11001302827008 wanted 2265512 found 2265500
parent transid verify failed on 11001303973888 wanted 2265512 found 2265500
parent transid verify failed on 11001304055808 wanted 2265512 found 2265509
parent transid verify failed on 11001304317952 wanted 2265512 found 2265500
parent transid verify failed on 11000780079104 wanted 2265511 found 2265453
parent transid verify failed on 11000780210176 wanted 2265511 found 2265453
parent transid verify failed on 11000780308480 wanted 2265511 found 2265453
parent transid verify failed on 11000583602176 wanted 2265512 found 2265420
parent transid verify failed on 11000768348160 wanted 2265511 found 2265439
parent transid verify failed on 11000600363008 wanted 2265512 found 2265420
parent transid verify failed on 11000768872448 wanted 2265511 found 2265447
parent transid verify failed on 11000768987136 wanted 2265511 found 2265439
parent transid verify failed on 11000769003520 wanted 2265511 found 2265450
parent transid verify failed on 11000769019904 wanted 2265511 found 2265439
parent transid verify failed on 11000769052672 wanted 2265511 found 2265439
parent transid verify failed on 11000769085440 wanted 2265511 found 2265439
parent transid verify failed on 11000918310912 wanted 2265512 found 2265488
parent transid verify failed on 11000769167360 wanted 2265511 found 2265439
parent transid verify failed on 11000769282048 wanted 2265511 found 2265450
parent transid verify failed on 11000781144064 wanted 2265511 found 2265453
parent transid verify failed on 11000620744704 wanted 2265512 found 2265420
parent transid verify failed on 11001293258752 wanted 2265512 found 2265509
parent transid verify failed on 11000770297856 wanted 2265511 found 2265444
parent transid verify failed on 11000770428928 wanted 2265511 found 2265444
parent transid verify failed on 11000770445312 wanted 2265511 found 2265444
parent transid verify failed on 11000770576384 wanted 2265511 found 2265439
parent transid verify failed on 11000770592768 wanted 2265511 found 2265444
parent transid verify failed on 11000770625536 wanted 2265511 found 2265445
parent transid verify failed on 11000770756608 wanted 2265511 found 2265444
parent transid verify failed on 11000770772992 wanted 2265511 found 2265445
parent transid verify failed on 11000770805760 wanted 2265511 found 2265439
parent transid verify failed on 11000771100672 wanted 2265511 found 2265444
parent transid verify failed on 11000771117056 wanted 2265511 found 2265449
parent transid verify failed on 11000771149824 wanted 2265511 found 2265452
parent transid verify failed on 11000771166208 wanted 2265511 found 2265439
parent transid verify failed on 11000771428352 wanted 2265511 found 2265444
parent transid verify failed on 11000776638464 wanted 2265511 found 2265453
parent transid verify failed on 11000776769536 wanted 2265511 found 2265452
parent transid verify failed on 11000771444736 wanted 2265511 found 2265444
parent transid verify failed on 11000771690496 wanted 2265511 found 2265452
parent transid verify failed on 11000771756032 wanted 2265511 found 2265451
parent transid verify failed on 11000771952640 wanted 2265511 found 2265442
parent transid verify failed on 11000704778240 wanted 2265512 found 2265423
parent transid verify failed on 11001171886080 wanted 2265512 found 2265500
parent transid verify failed on 11000772034560 wanted 2265511 found 2265453
parent transid verify failed on 11000772116480 wanted 2265511 found 2265452
parent transid verify failed on 11000776802304 wanted 2265511 found 2265452
parent transid verify failed on 11000776818688 wanted 2265511 found 2265452
parent transid verify failed on 11000776867840 wanted 2265511 found 2265452
parent transid verify failed on 11000776900608 wanted 2265511 found 2265451
parent transid verify failed on 11000776916992 wanted 2265511 found 2265453
parent transid verify failed on 11000776933376 wanted 2265511 found 2265451
parent transid verify failed on 11000737415168 wanted 2265512 found 2265438
parent transid verify failed on 11000772395008 wanted 2265511 found 2265452
parent transid verify failed on 11000772427776 wanted 2265511 found 2265447
parent transid verify failed on 11000772575232 wanted 2265511 found 2265444
parent transid verify failed on 11000772640768 wanted 2265511 found 2265444
parent transid verify failed on 11000780488704 wanted 2265511 found 2265453
parent transid verify failed on 11000772739072 wanted 2265511 found 2265442
parent transid verify failed on 11000772837376 wanted 2265511 found 2265444
parent transid verify failed on 11000780505088 wanted 2265511 found 2265453
parent transid verify failed on 11000777064448 wanted 2265511 found 2265452
parent transid verify failed on 11000737841152 wanted 2265512 found 2265438
parent transid verify failed on 11000772968448 wanted 2265511 found 2265452
parent transid verify failed on 11000773001216 wanted 2265511 found 2265452
parent transid verify failed on 11000773115904 wanted 2265511 found 2265451
parent transid verify failed on 11000773148672 wanted 2265511 found 2265442
parent transid verify failed on 11000773181440 wanted 2265511 found 2265444
parent transid verify failed on 11000773197824 wanted 2265511 found 2265453
parent transid verify failed on 11000773312512 wanted 2265511 found 2265453
parent transid verify failed on 11000773345280 wanted 2265511 found 2265452
parent transid verify failed on 11000777162752 wanted 2265511 found 2265452
parent transid verify failed on 11000773967872 wanted 2265511 found 2265442
parent transid verify failed on 11000774148096 wanted 2265511 found 2265447
parent transid verify failed on 11000777228288 wanted 2265511 found 2265452
parent transid verify failed on 11000774344704 wanted 2265511 found 2265452
parent transid verify failed on 11000774377472 wanted 2265511 found 2265447
parent transid verify failed on 11000774524928 wanted 2265511 found 2265442
parent transid verify failed on 11000774557696 wanted 2265511 found 2265445
parent transid verify failed on 11000774574080 wanted 2265511 found 2265445
parent transid verify failed on 11000777310208 wanted 2265511 found 2265452
parent transid verify failed on 11000781029376 wanted 2265511 found 2265453
parent transid verify failed on 11000774639616 wanted 2265511 found 2265452
parent transid verify failed on 11000774770688 wanted 2265511 found 2265452
parent transid verify failed on 11000774819840 wanted 2265511 found 2265439
parent transid verify failed on 11000777359360 wanted 2265511 found 2265452
parent transid verify failed on 13395960053760 wanted 2265296 found 2263090
parent transid verify failed on 13395960053760 wanted 2265296 found 2263090
parent transid verify failed on 13395960053760 wanted 2265296 found 2263090
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=11016181694464 item=83 parent
level=1 child level=1
ERROR: failed to repair root items: Input/output error
Opening filesystem to check...
Checking filesystem on /dev/mapper/data_disk_1
UUID: 159b8826-8380-45be-acb6-0cb992a8dfd7

>> [   99.710315] EDAC amd64: Node 0: DRAM ECC disabled.
>> [   99.710317] EDAC amd64: ECC disabled in the BIOS or no ECC
>> capability, module will not load.
>>                 Either enable ECC checking or force module loading by
>> setting 'ecc_enable_override'.
>>                 (Note that use of the override may cause unknown side
>> effects.)
> Not sure what the ECC part is doing, but it repeats quite some times.
> I'd assume it's unrelated though.
>

Not sure either.  I've not got ECC RAM.  Motherboard is capable I think.



> [...]
>> [  142.507291] BTRFS error (device dm-2): parent transid verify failed
>> on 13395960053760 wanted 2265296 found 2263090
>> [  142.544548] BTRFS error (device dm-2): parent transid verify failed
>> on 13395960053760 wanted 2265296 found 2263090
>> [  142.544561] BTRFS: error (device dm-2) in
>> btrfs_run_delayed_refs:2907: errno=-5 IO failure
> 
> This means, btrfs is trying to read extent tree for CoW, but at that
> time, extent tree is already corrupted, thus it returns -EIO.
> 
> And btrfs_run_delayed_refs just returns error.
> t
> Not sure if it's related to device replace, but anyway the corruption
> just happened.
> The device replace may be an interesting clue, as currently our
> dm-log-writes are mostly focused on single device usage.

Sorry, 'device replace'?  I've not done that lately.  I _may_ have tried
that years back with this file system.  However, iirc it failed as the
new, allegedly same size new disk was possibly slightly smaller.

From the above it looks like it is not a specific hardware failure.


> 
> Then I'd recommend to do regular rescue procedure:
> - Try that skip_bg patchset if possible
>   This provides the best salvage method so far, full subvolume
>   available, although needs out-of-tree patches.
>   https://patchwork.kernel.org/project/linux-btrfs/list/?series=130637
> 

I can give that a go, but not for a while.

I seem to be able to read the file system as is, as it goes read only.
But perhaps 'seems' is the operative word.

> - btrfs-restore
>   The regular unmounted recover, needs extra space. Latest btrfs-progs
>   recommended.

I've got the latest btrfs progs.    if neither of those two work I have
a backup.

So, basically, make a new file system and recover the data to it.  I've
a new disk on the way, so I can create a file system as single and once
I'm happy I've migrated data to it, wipe the old disks and move one  or
two to the new array and rebalance.

> 
> Thanks,
> Qu
> 

Thank you, very much appreciated.

Pete

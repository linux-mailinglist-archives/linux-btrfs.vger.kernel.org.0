Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC1B2D20C6
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 03:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgLHCXd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 21:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbgLHCXd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 21:23:33 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E25AC061749
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 18:22:52 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m5so5071099wrx.9
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 18:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7+IX+98gm/NpqST4FxQVNLTUgPZXvjLYqaw9IpyIFec=;
        b=YzdedKLdw2QsN8J6SFwdLaNsgEGz287xAQ5UHV0Vi08g2SItGJy+TBJaNq8XC6ZVVr
         WjjfE4+CNC77egrT0oEcT3fBq76bx4v/6LeFMXj9+zBxmzylId4/lln5jxZ/nVxeO3st
         Whdyf+CdcqPtN8rCCWDj5ufoy49UCv4POa8qAhZAwA2XMwl78cLpka8t48DLGKaPnO53
         hU3tJJdC+MpVYJ0nRZH+H2wu6r0ZpX+X9d8T6bEORbEfje882vK5wv5xJmQITIQ6xhnR
         6DVjlGvlHysx4Z/QU534ClZmB6llOVrkwqVKUv2liyL6oqd5LRvSrUiXmNbdeD2da+GA
         L+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7+IX+98gm/NpqST4FxQVNLTUgPZXvjLYqaw9IpyIFec=;
        b=Ol8s9u/6POvLTZLVld7HxVJH5JZtfz0bJAmEghoCEBniQifL4WVuKWLiFF53Y7MPx+
         rypbtjYXH/qeIaIOlvScwju3z94jrzS88vC2T+/I0QjajGihINBFF72u1Vrry1FXUcPg
         KxBEVAhxI3Ccs8G8zIeOL8De1QZVN1UnORKbAOfTjyX7HK8NW9qFuHJQRrzUs5p7NUrU
         t1kmU7THWWEt5aIf71O/u+hGUmMjc6fiVVhNJYnOuhWYO4u5gBRLMNCpBMiZjL2eR8G4
         oWzEQlHuPio5D5yHfw+SjVHF8etYI1Lr9YX95xFHZzgUZOIBj8fMUdUo7+nI/jSzkJfw
         /xug==
X-Gm-Message-State: AOAM5317FN46Kkfmx8NoE+PsvtGOrqI118T9Kkoeplqz1kMvfqa+Ukua
        obG+QBd2Dip+HfKPQ8pKEAAQL4vzqihBW5bxuZy5Dw==
X-Google-Smtp-Source: ABdhPJxatbaBYI2HVPelY3fXDHDKAb9/r7BXi4DscsbA78xYyHnXPlUvjbUt+lHD+Qr7/xmjDh0K7gO+A+kwOc+8lXs=
X-Received: by 2002:a5d:65ca:: with SMTP id e10mr22788445wrw.42.1607394170360;
 Mon, 07 Dec 2020 18:22:50 -0800 (PST)
MIME-Version: 1.0
References: <CAAdkh9xzT=wYY3jui3d4xF4kp20tB5EiL-KBJdMK69h1oWO3ig@mail.gmail.com>
 <CAJCQCtTXDufgm=ZYR4K7+-O_g=ztR9DDTUxCM67mKQRPGtWrWQ@mail.gmail.com> <CAAdkh9zzmZcFLjp9Lq+iZUXavGze4dQaNzYfy3vjVGMSMQd-5Q@mail.gmail.com>
In-Reply-To: <CAAdkh9zzmZcFLjp9Lq+iZUXavGze4dQaNzYfy3vjVGMSMQd-5Q@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 7 Dec 2020 19:22:34 -0700
Message-ID: <CAJCQCtQOdNp9ALZ6chnW15HUVwr19UxQhFePG5GrgS39c=XOew@mail.gmail.com>
Subject: Re: data Raid6 with metadata Raid1c3 appears unrecoverable
To:     Marcus Bannerman <m.bannerman@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 7, 2020 at 5:36 PM Marcus Bannerman <m.bannerman@gmail.com> wrote:
>
> Thanks for the reply
>
> > > $ btrfs devices remove /dev/sdX /raid
> > > ERROR: error removing device 'missing': Input/output error
> >
> > There should be kernel messages at this same time.
>
> I just reinstalled the drive, mounted, and attempted the remove. These
> are the lines from dmesg, from mount to remove
>
> [   56.121860] BTRFS info (device sdd): disk space caching is enabled
> [   56.121862] BTRFS info (device sdd): has skinny extents
> [   56.690256] BTRFS info (device sdd): bdev /dev/sde errs: wr
> 15816919, rd 1298069, flush 1, corrupt 4912020, gen 0
> [   56.690257] BTRFS info (device sdd): bdev /dev/sdf errs: wr 0, rd
> 14, flush 0, corrupt 0, gen 0

/dev/sde has lots of problems, but /dev/sdf also has read errors.




> [   97.330998] BTRFS error (device sdd): csum mismatch on free space cache
> [   97.331008] BTRFS warning (device sdd): failed to load free space
> cache for block group 5045543239680, rebuilding it now
> [   97.393155] BTRFS error (device sdd): space cache generation
> (24264) does not match inode (24667)
> [   97.393168] BTRFS warning (device sdd): failed to load free space
> cache for block group 5793941291008, rebuilding it now
> [   98.308137] BTRFS error (device sdd): space cache generation
> (24252) does not match inode (24643)
> [   98.308150] BTRFS warning (device sdd): failed to load free space
> cache for block group 8296833482752, rebuilding it now
> [   99.070440] BTRFS error (device sdd): csum mismatch on free space cache
> [   99.070450] BTRFS warning (device sdd): failed to load free space
> cache for block group 5407394234368, rebuilding it now
> [   99.289148] BTRFS error (device sdd): csum mismatch on free space cache
> [   99.289157] BTRFS warning (device sdd): failed to load free space
> cache for block group 5433164038144, rebuilding it now
> [  100.796253] BTRFS error (device sdd): csum mismatch on free space cache
> [  100.796262] BTRFS warning (device sdd): failed to load free space
> cache for block group 5562013057024, rebuilding it now
> [  101.066260] BTRFS error (device sdd): csum mismatch on free space cache
> [  101.066270] BTRFS warning (device sdd): failed to load free space
> cache for block group 5645764919296, rebuilding it now
> [  101.454895] BTRFS error (device sdd): csum mismatch on free space cache
> [  101.454905] BTRFS warning (device sdd): failed to load free space
> cache for block group 5840112189440, rebuilding it now
> [  101.629161] BTRFS error (device sdd): csum mismatch on free space cache
> [  101.629169] BTRFS warning (device sdd): failed to load free space
> cache for block group 5930306502656, rebuilding it now
> [  101.650788] BTRFS error (device sdd): csum mismatch on free space cache
> [  101.650797] BTRFS warning (device sdd): failed to load free space
> cache for block group 5949633855488, rebuilding it now
> [  101.699260] BTRFS error (device sdd): csum mismatch on free space cache
> [  101.699268] BTRFS warning (device sdd): failed to load free space
> cache for block group 5981846110208, rebuilding it now
> [  101.746130] BTRFS error (device sdd): csum mismatch on free space cache
> [  101.746139] BTRFS warning (device sdd): failed to load free space
> cache for block group 6001173463040, rebuilding it now
> [  101.858844] BTRFS warning (device sdd): failed to load free space
> cache for block group 6059155521536, rebuilding it now
> [  102.613417] io_ctl_check_crc: 1 callbacks suppressed
> [  102.613418] BTRFS error (device sdd): csum mismatch on free space cache
> [  102.613426] BTRFS warning (device sdd): failed to load free space
> cache for block group 6226659246080, rebuilding it now
> [  102.672196] BTRFS error (device sdd): csum mismatch on free space cache
> [  102.672205] BTRFS warning (device sdd): failed to load free space
> cache for block group 6245986598912, rebuilding it now
> [  102.966882] BTRFS error (device sdd): csum mismatch on free space cache
> [  102.966891] BTRFS warning (device sdd): failed to load free space
> cache for block group 6387720519680, rebuilding it now
> [  103.059101] BTRFS error (device sdd): csum mismatch on free space cache
> [  103.059268] BTRFS warning (device sdd): failed to load free space
> cache for block group 6407047872512, rebuilding it now
> [  103.200615] BTRFS error (device sdd): csum mismatch on free space cache
> [  103.200627] BTRFS warning (device sdd): failed to load free space
> cache for block group 6458587480064, rebuilding it now
> [  103.411278] BTRFS error (device sdd): csum mismatch on free space cache
> [  103.411394] BTRFS warning (device sdd): failed to load free space
> cache for block group 6523011989504, rebuilding it now
> [  103.487762] BTRFS error (device sdd): csum mismatch on free space cache
> [  103.487847] BTRFS warning (device sdd): failed to load free space
> cache for block group 6548781793280, rebuilding it now
> [  103.537404] BTRFS error (device sdd): csum mismatch on free space cache
> [  103.537539] BTRFS warning (device sdd): failed to load free space
> cache for block group 6568109146112, rebuilding it now
> [  104.335475] BTRFS error (device sdd): csum mismatch on free space cache
> [  104.335484] BTRFS warning (device sdd): failed to load free space
> cache for block group 6775341318144, rebuilding it now
> [  104.572765] BTRFS error (device sdd): csum mismatch on free space cache
> [  104.572811] BTRFS warning (device sdd): failed to load free space
> cache for block group 6852650729472, rebuilding it now
> [  104.722941] BTRFS warning (device sdd): failed to load free space
> cache for block group 6904190337024, rebuilding it now
> [  105.012282] BTRFS warning (device sdd): failed to load free space
> cache for block group 7007269552128, rebuilding it now
> [  105.046725] BTRFS warning (device sdd): failed to load free space
> cache for block group 7026596904960, rebuilding it now
> [  105.118646] BTRFS warning (device sdd): failed to load free space
> cache for block group 7058809159680, rebuilding it now
> [  105.135507] BTRFS warning (device sdd): failed to load free space
> cache for block group 7065251610624, rebuilding it now
> [  105.200019] BTRFS warning (device sdd): failed to load free space
> cache for block group 7084578963456, rebuilding it now
> [  105.370265] BTRFS warning (device sdd): failed to load free space
> cache for block group 7136118571008, rebuilding it now
> [  105.619125] BTRFS warning (device sdd): failed to load free space
> cache for block group 7252082688000, rebuilding it now
> [  105.639234] BTRFS warning (device sdd): failed to load free space
> cache for block group 7277852491776, rebuilding it now
> [  105.956635] BTRFS warning (device sdd): failed to load free space
> cache for block group 7369120546816, rebuilding it now
> [  106.032840] BTRFS warning (device sdd): failed to load free space
> cache for block group 7407775252480, rebuilding it now
> [  106.048704] BTRFS warning (device sdd): failed to load free space
> cache for block group 7414217703424, rebuilding it now
> [  106.088732] BTRFS warning (device sdd): failed to load free space
> cache for block group 7433545056256, rebuilding it now
> [  106.458199] BTRFS warning (device sdd): failed to load free space
> cache for block group 7633261035520, rebuilding it now
> [  107.161352] BTRFS warning (device sdd): failed to load free space
> cache for block group 8052020346880, rebuilding it now
> [  107.239727] BTRFS warning (device sdd): failed to load free space
> cache for block group 8084232601600, rebuilding it now
> [  107.307782] BTRFS warning (device sdd): failed to load free space
> cache for block group 8116444856320, rebuilding it now
> [  107.333400] BTRFS warning (device sdd): failed to load free space
> cache for block group 8122887307264, rebuilding it now
> [  107.384255] BTRFS warning (device sdd): failed to load free space
> cache for block group 8135772209152, rebuilding it now
> [  107.488565] BTRFS warning (device sdd): failed to load free space
> cache for block group 8161542012928, rebuilding it now
> [  107.541458] BTRFS warning (device sdd): failed to load free space
> cache for block group 8174426914816, rebuilding it now
> [  107.544256] BTRFS warning (device sdd): failed to load free space
> cache for block group 8187311816704, rebuilding it now
> [  107.548007] BTRFS warning (device sdd): failed to load free space
> cache for block group 8200196718592, rebuilding it now
> [  107.550938] BTRFS warning (device sdd): failed to load free space
> cache for block group 8213081620480, rebuilding it now
> [  107.617485] io_ctl_check_crc: 24 callbacks suppressed
> [  107.617486] BTRFS error (device sdd): csum mismatch on free space cache
> [  107.617495] BTRFS warning (device sdd): failed to load free space
> cache for block group 8225966522368, rebuilding it now
> [  107.634058] BTRFS error (device sdd): csum mismatch on free space cache
> [  107.634067] BTRFS warning (device sdd): failed to load free space
> cache for block group 8238851424256, rebuilding it now
> [  107.718044] BTRFS error (device sdd): csum mismatch on free space cache
> [  107.718052] BTRFS warning (device sdd): failed to load free space
> cache for block group 8251736326144, rebuilding it now
> [  107.731397] BTRFS error (device sdd): csum mismatch on free space cache
> [  107.731406] BTRFS warning (device sdd): failed to load free space
> cache for block group 8264621228032, rebuilding it now
> [  107.734864] BTRFS error (device sdd): csum mismatch on free space cache
> [  107.734872] BTRFS warning (device sdd): failed to load free space
> cache for block group 8277506129920, rebuilding it now
> [  108.549300] BTRFS error (device sdd): csum mismatch on free space cache
> [  108.549309] BTRFS warning (device sdd): failed to load free space
> cache for block group 8742436339712, rebuilding it now
> [  108.583067] BTRFS error (device sdd): csum mismatch on free space cache
> [  108.583108] BTRFS warning (device sdd): failed to load free space
> cache for block group 8755321241600, rebuilding it now
> [  108.598565] BTRFS error (device sdd): csum mismatch on free space cache
> [  108.598606] BTRFS warning (device sdd): failed to load free space
> cache for block group 8768206143488, rebuilding it now
> [  108.645502] BTRFS error (device sdd): csum mismatch on free space cache
> [  108.645511] BTRFS warning (device sdd): failed to load free space
> cache for block group 8787533496320, rebuilding it now
> [  108.648045] BTRFS error (device sdd): csum mismatch on free space cache
> [  108.648059] BTRFS warning (device sdd): failed to load free space
> cache for block group 8800418398208, rebuilding it now
> [  108.679565] BTRFS warning (device sdd): failed to load free space
> cache for block group 8806860849152, rebuilding it now
> [  108.713851] BTRFS warning (device sdd): failed to load free space
> cache for block group 8819745751040, rebuilding it now
> [  108.731048] BTRFS warning (device sdd): failed to load free space
> cache for block group 8826188201984, rebuilding it now
> [  108.746154] BTRFS warning (device sdd): failed to load free space
> cache for block group 8839073103872, rebuilding it now
> [  108.761366] BTRFS warning (device sdd): failed to load free space
> cache for block group 8851958005760, rebuilding it now
> [  108.779647] BTRFS warning (device sdd): failed to load free space
> cache for block group 8864842907648, rebuilding it now
> [  108.795735] BTRFS warning (device sdd): failed to load free space
> cache for block group 8871285358592, rebuilding it now
> [  108.799341] BTRFS warning (device sdd): failed to load free space
> cache for block group 8884170260480, rebuilding it now
> [  108.946243] BTRFS warning (device sdd): failed to load free space
> cache for block group 8929267417088, rebuilding it now
> [  108.949000] BTRFS warning (device sdd): failed to load free space
> cache for block group 8935709868032, rebuilding it now
> [  108.967626] BTRFS warning (device sdd): failed to load free space
> cache for block group 8955037220864, rebuilding it now
> [  109.110567] BTRFS warning (device sdd): failed to load free space
> cache for block group 9013019279360, rebuilding it now
> [  109.163173] BTRFS warning (device sdd): failed to load free space
> cache for block group 9038789083136, rebuilding it now
> [  109.187461] BTRFS warning (device sdd): failed to load free space
> cache for block group 9051673985024, rebuilding it now
> [  109.324464] BTRFS warning (device sdd): failed to load free space
> cache for block group 9128983396352, rebuilding it now
> [  109.361759] BTRFS warning (device sdd): failed to load free space
> cache for block group 9154753200128, rebuilding it now
> [  109.364204] BTRFS warning (device sdd): failed to load free space
> cache for block group 9167638102016, rebuilding it now
> [  109.466225] BTRFS warning (device sdd): failed to load free space
> cache for block group 9199850356736, rebuilding it now
> [  109.501946] BTRFS warning (device sdd): failed to load free space
> cache for block group 9219177709568, rebuilding it now
> [  109.538897] BTRFS warning (device sdd): failed to load free space
> cache for block group 9232062611456, rebuilding it now
> [  109.608266] BTRFS warning (device sdd): failed to load free space
> cache for block group 9257832415232, rebuilding it now
> [  109.698564] BTRFS warning (device sdd): failed to load free space
> cache for block group 9316888215552, rebuilding it now
> [  109.742216] BTRFS warning (device sdd): failed to load free space
> cache for block group 9342658019328, rebuilding it now
> [  109.780150] BTRFS warning (device sdd): failed to load free space
> cache for block group 9368427823104, rebuilding it now
> [  109.806257] BTRFS warning (device sdd): failed to load free space
> cache for block group 9381312724992, rebuilding it now
> [  109.832621] BTRFS warning (device sdd): failed to load free space
> cache for block group 9394197626880, rebuilding it now
> [  109.891830] BTRFS warning (device sdd): failed to load free space
> cache for block group 9426409881600, rebuilding it now
> [  109.910897] BTRFS warning (device sdd): failed to load free space
> cache for block group 9439294783488, rebuilding it now
> [  109.994227] BTRFS warning (device sdd): failed to load free space
> cache for block group 9465064587264, rebuilding it now
> [  110.027439] BTRFS warning (device sdd): failed to load free space
> cache for block group 9484391940096, rebuilding it now
> [  110.307199] BTRFS warning (device sdd): failed to load free space
> cache for block group 9632568311808, rebuilding it now
> [  110.401025] BTRFS warning (device sdd): failed to load free space
> cache for block group 9677665468416, rebuilding it now
> [  110.600872] BTRFS warning (device sdd): failed to load free space
> cache for block group 9787187134464, rebuilding it now
> [  111.866668] BTRFS info (device sdd): relocating block group
> 10012672917504 flags data|raid6

This probably just adds to the confusion but doesn't help tell us what's wrong.


>
> [  133.662138] BTRFS warning (device sdd): csum failed root -9 ino 257
> off 5716836352 csum 0x67d3fead expected csum 0x7d7b4cd5 mirror 1
> [  133.662141] BTRFS error (device sdd): bdev /dev/sde errs: wr
> 15816919, rd 1298069, flush 1, corrupt 4912021, gen 0
> [  133.662220] BTRFS warning (device sdd): csum failed root -9 ino 257
> off 5716840448 csum 0x4d36c151 expected csum 0x259ec1b0 mirror 1
> [  133.662221] BTRFS error (device sdd): bdev /dev/sde errs: wr
> 15816919, rd 1298069, flush 1, corrupt 4912022, gen 0
> [  133.662230] BTRFS warning (device sdd): csum failed root -9 ino 257
> off 5716844544 csum 0xac6bee6c expected csum 0x5be7c303 mirror 1
> [  133.662231] BTRFS error (device sdd): bdev /dev/sde errs: wr
> 15816919, rd 1298069, flush 1, corrupt 4912023, gen 0
> [  133.662234] BTRFS warning (device sdd): csum failed root -9 ino 257
> off 5716848640 csum 0x02da0453 expected csum 0xccefe17a mirror 1
> [  133.662235] BTRFS error (device sdd): bdev /dev/sde errs: wr
> 15816919, rd 1298069, flush 1, corrupt 4912024, gen 0
> [  133.662238] BTRFS warning (device sdd): csum failed root -9 ino 257
> off 5716852736 csum 0x32ca34ac expected csum 0x4ab7d92b mirror 1
> [  133.662238] BTRFS error (device sdd): bdev /dev/sde errs: wr
> 15816919, rd 1298069, flush 1, corrupt 4912025, gen 0
> [  133.662242] BTRFS warning (device sdd): csum failed root -9 ino 257
> off 5716856832 csum 0x1e83a4bf expected csum 0xcc87cba3 mirror 1
> [  133.662242] BTRFS error (device sdd): bdev /dev/sde errs: wr
> 15816919, rd 1298069, flush 1, corrupt 4912026, gen 0
> [  133.662245] BTRFS warning (device sdd): csum failed root -9 ino 257
> off 5716860928 csum 0x35b2262f expected csum 0x1d32bf67 mirror 1
> [  133.662246] BTRFS error (device sdd): bdev /dev/sde errs: wr
> 15816919, rd 1298069, flush 1, corrupt 4912027, gen 0
> [  133.662249] BTRFS warning (device sdd): csum failed root -9 ino 257
> off 5716865024 csum 0x3550acbc expected csum 0xd9f6819a mirror 1
> [  133.662249] BTRFS error (device sdd): bdev /dev/sde errs: wr
> 15816919, rd 1298069, flush 1, corrupt 4912028, gen 0
> [  133.662252] BTRFS warning (device sdd): csum failed root -9 ino 257
> off 5716869120 csum 0x06d61bcb expected csum 0x462f1118 mirror 1
> [  133.662253] BTRFS error (device sdd): bdev /dev/sde errs: wr
> 15816919, rd 1298069, flush 1, corrupt 4912029, gen 0
> [  133.662256] BTRFS warning (device sdd): csum failed root -9 ino 257
> off 5716873216 csum 0x84139c44 expected csum 0x7342b580 mirror 1
> [  133.662257] BTRFS error (device sdd): bdev /dev/sde errs: wr
> 15816919, rd 1298069, flush 1, corrupt 4912030, gen 0

Likely a bug, spurious read error. Looks like this:
https://lore.kernel.org/linux-btrfs/20200721005724.GK10769@hungrycats.org/


> So this is a bit awkward. I actually reinstalled to check I hadn't
> somehow messed the btrfs-progs or kernel up. I've got the logs but you
> won't see much else other than what i've pasted above (unless you want
> me to pull the drive and try a remove missing?).

Nope. I think that's enough.

>I've attached what I
> have anyway. I've had some crashes from gnome since reinstall, but I
> think these are GPU related, as they've stopped since I've put the
> nvidia driver in. I don't *think* the raid was mounted at the time.

If it didn't crash the kernel then it's nothing to worry about.
Crashing the DE might adversely affect data being written to the file
system. But it won't wreck the file system itself.


> OK, I've bought a replacement drive, I'm going to try a replace
> tomorrow when it arrives. Hopefully that will let me rebuild, then
> scrub, then I can move over to space_cache=v2. Would you recommend
> clear_cache,nospace_cache while replacing/scrubbing/etc? I'm just
> going to leave the array offline until I try the replace.
> Kind regards,
> Marcus

There's 1298069 read errors reported by Btrfs for /dev/sde which comes
out to under 1G. If it mounts with all drives connected, without the
'degraded' mount option being needed, that is ideal. Even if it's
spitting out a bunch of errors.

I would still use options 'clear_cache,nospace_cache' if for no other
reason but to stop the unnecessary spamming of the journal.

Make sure to (re)identify the correct drive for the current boot, for
use with btrfs replace. Just to be clear, you do not want to use
'btrfs device add' followed by 'btrfs device remove'  = use 'btrfs
replace'.



--
Chris Murphy

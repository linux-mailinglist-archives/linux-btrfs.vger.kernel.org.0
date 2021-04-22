Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0213677E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Apr 2021 05:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhDVDYu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Apr 2021 23:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhDVDYu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Apr 2021 23:24:50 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E22C06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Apr 2021 20:24:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id f6-20020a17090a6546b029015088cf4a1eso192817pjs.2
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Apr 2021 20:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=Wk/vkV7r0i5x4zZupkFrXQPRIRz77cX7E+bEchocKGo=;
        b=ET4Ne5iPlfASon95huFnK7hhsiJZ9zB8es1iAex0feNH1vWPEee2HuNzossgpJVgaV
         KvQCuzjwI+yhZXmFnk4FS0xTPgqtQ2jnp1iYcg/4K1o7+Jrqu98ar7UpFc1T9CAWN/Fq
         X3vVT9Ai6J522vnGrc2h7kFLXtxSkBvNxV1UNZ7OYE5hYUHET9JYCKz78ZMG13UnsD33
         m/+Ul3mQRv0cHe53wD32RewlxAfr3YCyhXSvNy9LpSGBFGZy2lpM6Ec8+U3T/6ACULeg
         HPkn1PEnnVRBnfyxnHSXPg7WCqLkmL4tToAaWySOS2uZu99iWvIbHVsTb/si8U7+8/2Z
         rq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=Wk/vkV7r0i5x4zZupkFrXQPRIRz77cX7E+bEchocKGo=;
        b=BxfE/YW74HMlHXDlUbohHcLy70KVc4WOdzCweL+vwAsIcJBNHQ0h93C9XWON7F93Lf
         ohAetk4PzFzErTCohxDz0bLwtDDob1kGgEv8vxn++xzRYgoFmaiLNLJE9JIyJ7GjedAn
         TlO+5BqV9V8nhmcdMpKbwEI95rsT11V3bzyyJRIwxOPs/WjOfkpiHdlWWQM2V5zBG/Xy
         wqXdJ0tezzZL+wustZykUULzhJBhes75qpjTuJv7oERZ+EeiNcZ9lExxoiCP1t0nkv0h
         +t9DyS9AFduGssuaD70oFscKRCqEvxbgJ7BR40bIH0qAEhqMML3XsXBJnVS4sJsOfV6m
         41wA==
X-Gm-Message-State: AOAM532KOHf/6Vbwmr2bTcdXmMW+7Ensn2klVPPGpw6Ke6QqwI/9EJrC
        Paapl4dN4AQulLx+NFHTjg8=
X-Google-Smtp-Source: ABdhPJwJt24mDrvTfdLf0lhqt2y0oEiO2nAoyCZ7FwgD0x4roJBHevhGKNnUCTyoGAHPuikFPt1Nlw==
X-Received: by 2002:a17:902:ed42:b029:ec:a711:25c7 with SMTP id y2-20020a170902ed42b02900eca71125c7mr1228930plb.58.1619061854656;
        Wed, 21 Apr 2021 20:24:14 -0700 (PDT)
Received: from [192.168.2.53] (108-201-186-146.lightspeed.sntcca.sbcglobal.net. [108.201.186.146])
        by smtp.gmail.com with ESMTPSA id l132sm667639pga.39.2021.04.21.20.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 20:24:13 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Konstantin Svist <fry.kun@gmail.com>
Subject: Restoring a file from damaged btrfs raid1 shard
Message-ID: <9ca589ec-26b1-1b92-fe4a-af9006e516c6@gmail.com>
Date:   Wed, 21 Apr 2021 20:24:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I have a drive which I replaced from a raid1 pair (caused a lot of
command timeouts).

Before I pulled it, I forgot to check if there are any files not
properly stored in the other copy.

The file is quite old, so the recent changes on the partition don't matter


#uname -a

Linux xx 5.11.12-200.fc33.x86_64 #1 SMP Thu Apr 8 02:34:17 UTC 2021
x86_64 x86_64 x86_64 GNU/Linux

# btrfs --version
btrfs-progs v5.10

# mount -oro,degraded /dev/sdb3  /mnt/
mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdb3,
missing codepage or helper program, or other error.

Apr 21 20:21:11 xx kernel: BTRFS info (device sdb3): allowing degraded
mounts
Apr 21 20:21:11 xx kernel: BTRFS info (device sdb3): disk space caching
is enabled
Apr 21 20:21:11 xx kernel: BTRFS info (device sdb3): has skinny extents
Apr 21 20:21:11 xx kernel: BTRFS warning (device sdb3): devid 3 uuid
8c5ca74b-83fd-4625-92f0-ec14ef64b0a8 is missing
Apr 21 20:21:11 xx kernel: BTRFS warning (device sdb3): devid 4 uuid
ff2c7128-b213-402f-a487-fb070ab8e902 is missing
Apr 21 20:21:11 xx kernel: BTRFS info (device sdb3): bdev /dev/sdb3
errs: wr 189563, rd 4799, flush 0, corrupt 2389, gen 0
Apr 21 20:21:11 xx kernel: BTRFS info (device sdb3): bdev (efault) errs:
wr 0, rd 0, flush 0, corrupt 35, gen 0
Apr 21 20:21:11 xx kernel: BTRFS info (device sdb3): bdev (efault) errs:
wr 348, rd 0, flush 0, corrupt 0, gen 0
Apr 21 20:21:11 xx kernel: BTRFS error (device sdb3): parent transid
verify failed on 4883446087680 wanted 5857871 found 5852153
Apr 21 20:21:11 xx kernel: BTRFS error (device sdb3): failed to read
block groups: -5
Apr 21 20:21:11 xx kernel: BTRFS error (device sdb3): open_ctree failed

# btrfs fi show /dev/sdb3
warning, device 3 is missing
warning, device 3 is missing
parent transid verify failed on 4883446087680 wanted 5857871 found 5852153
parent transid verify failed on 4883446087680 wanted 5857871 found 5852153
Ignoring transid failure
leaf parent key incorrect 4883446087680
ERROR: failed to read block groups: Operation not permitted
Label: none  uuid: fef6d003-b7a5-4e9e-9875-5774052ce2ed
    Total devices 3 FS bytes used 614.46GiB
    devid    1 size 929.51GiB used 666.03GiB path /dev/sdb3
    *** Some devices missing


# btrfs-find-root /dev/sdb3
warning, device 3 is missing
warning, device 3 is missing
parent transid verify failed on 4883446087680 wanted 5857871 found 5852153
parent transid verify failed on 4883446087680 wanted 5857871 found 5852153
Ignoring transid failure
leaf parent key incorrect 4883446087680
ERROR: failed to read block groups: Operation not permitted
Superblock thinks the generation is 5857883
Superblock thinks the level is 1
Found tree root at 4883439714304 gen 5857883 level 1
Well block 4883437158400(gen: 5857882 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883434635264(gen: 5857881 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883426295808(gen: 5857880 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883417972736(gen: 5857879 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883409846272(gen: 5857878 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883352633344(gen: 5857877 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883347685376(gen: 5857876 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883343622144(gen: 5857875 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883438944256(gen: 5857870 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883439239168(gen: 5857869 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883377176576(gen: 5857824 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883357188096(gen: 5857788 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883340165120(gen: 5857732 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883371884544(gen: 5857731 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883361087488(gen: 5857730 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883380404224(gen: 5857729 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883374358528(gen: 5857727 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883342721024(gen: 5857718 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883398656000(gen: 5857713 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883346784256(gen: 5857706 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883409584128(gen: 5857704 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883436666880(gen: 5857439 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883436650496(gen: 5857439 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883436290048(gen: 5857439 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883436126208(gen: 5857439 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883387858944(gen: 5857438 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883371753472(gen: 5857437 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883428802560(gen: 5855304 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883428786176(gen: 5855304 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883411075072(gen: 5855303 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883411042304(gen: 5855299 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883388497920(gen: 5855299 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883428999168(gen: 5855293 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883431686144(gen: 5855262 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883417563136(gen: 5855256 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883416678400(gen: 5855256 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883408601088(gen: 5855254 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883394183168(gen: 5855253 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883394166784(gen: 5855253 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883388792832(gen: 5855253 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883431817216(gen: 5852142 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883373441024(gen: 5852073 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883366723584(gen: 5852070 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883363430400(gen: 5778963 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883363758080(gen: 5778927 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883363627008(gen: 5775596 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883363594240(gen: 5775596 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883361841152(gen: 5775596 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883362332672(gen: 5772011 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883362217984(gen: 5772011 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883362168832(gen: 5772011 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883357614080(gen: 5742160 level: 0) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1
Well block 4883344556032(gen: 5701778 level: 1) seems good, but
generation/level doesn't match, want gen: 5857883 level: 1


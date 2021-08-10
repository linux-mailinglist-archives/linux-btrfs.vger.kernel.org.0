Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF5B3E525F
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 06:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbhHJElx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 00:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbhHJElw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 00:41:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDB9C0613D3
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Aug 2021 21:41:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso3511507pjb.1
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Aug 2021 21:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=HYaHeAOZQb77OQ2x0DPbH54WCygkmgR4YKNw7xz88fE=;
        b=mC6FN5P/SepGoa20t4oba9ITsongsOVQRMU/wyRG5XkPucIC57heIsbrIqe7wMqjm4
         Sj37I73LqjFases2y+v+9E9MiFG6ObSSNBy+AxULKSWqbtfOUcU37EaTn54qL7bb2bX+
         XUeMS4+connaN/OIhEqLEB18dqxYSeo3YcMWcyu9AjXjDOv6WuIP3X4FZ+fFGI+GOCGb
         iv3SuE/6h8A7CAK0CRJucR5lOX5xruYDDwfB5Rk8EYi+yI02khyQshJO0+nPaOIbOBJy
         IenPS+vx234i4dPptkQwVH1X6lIWT/jTcI13sM2DOtq42FHDehejAU1MpD3dbcYLxSsM
         8e+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=HYaHeAOZQb77OQ2x0DPbH54WCygkmgR4YKNw7xz88fE=;
        b=s87Bx458ui/PcfexjDjjFpCmyqA/rJgrlKOCjFlcS/DaMRvMdz5XcBMQUO83SsKA9s
         muxmD7PXkIPGdYVgoaxmQ3aUigMZV6HJWH0lzxsMJUFY2oQ+Xc6Db0oe43w83LodmdAX
         0TNdP1ThnJnNFHeQgTkcCxcd6zmEXOciPeUtJsYrGofFOjOuph6oDcvH2f3ELDGLi9qz
         vojwbpxQF4galGGIz7MVCbhRJjdC96Idywbqzjr7HiPVphtBCbnweInY7EapYAW1X/Jg
         687IMW9K0uS7nB2CpyAU6nSi6zIfsEUS8JVDMVglP8uvlB0V6AJzuYN9QXhFDJOjjm3W
         uWeQ==
X-Gm-Message-State: AOAM532ysJaE0maPM/QMUybLDRSDKbztofpC5XVIdoBPOyFx+88A/Igc
        /fwYpiXg+2wYJmCJIfaUL61+oCW3wSlJDQ==
X-Google-Smtp-Source: ABdhPJz2haiw13vFnlFcpogNAneypoNSR+5MXopVZeQIWc1dkL60IOkzlznVwmlhxIv3iuOTX26H6g==
X-Received: by 2002:a65:4c84:: with SMTP id m4mr702938pgt.404.1628570490718;
        Mon, 09 Aug 2021 21:41:30 -0700 (PDT)
Received: from [192.168.2.53] (108-201-186-146.lightspeed.sntcca.sbcglobal.net. [108.201.186.146])
        by smtp.gmail.com with ESMTPSA id 11sm24990161pgh.52.2021.08.09.21.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 21:41:29 -0700 (PDT)
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   Konstantin Svist <fry.kun@gmail.com>
Subject: Trying to recover data from SSD
Message-ID: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
Date:   Mon, 9 Aug 2021 21:41:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Not sure exactly when it stopped working, possibly had a power outage..
I was able to pull most of a snapshot with btrfs restore -s -- but it's
months old and I want the more recent files from.


Testing the SSD for bad sectors, but nothing so far


While trying to mount:
[442587.465598] BTRFS info (device sdb3): allowing degraded mounts
[442587.465602] BTRFS info (device sdb3): disk space caching is enabled
[442587.465603] BTRFS info (device sdb3): has skinny extents
[442587.522301] BTRFS error (device sdb3): bad tree block start, want
952483840 have 0
[442587.522867] BTRFS error (device sdb3): bad tree block start, want
952483840 have 0
[442587.522876] BTRFS error (device sdb3): failed to read block groups: -5
[442587.523520] BTRFS error (device sdb3): open_ctree failed
[442782.661849] BTRFS error (device sdb3): unrecognized mount option
'rootflags=recovery'
[442782.661926] BTRFS error (device sdb3): open_ctree failed

# btrfs-find-root /dev/sdb3
ERROR: failed to read block groups: Input/output error
Superblock thinks the generation is 166932
Superblock thinks the level is 1
Found tree root at 787070976 gen 166932 level 1
Well block 786399232(gen: 166931 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 781172736(gen: 166930 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 778108928(gen: 166929 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 100696064(gen: 166928 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 99565568(gen: 166927 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 97599488(gen: 166926 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 91701248(gen: 166925 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 89620480(gen: 166924 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 86818816(gen: 166923 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 84197376(gen: 166922 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 76398592(gen: 166921 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 72400896(gen: 166920 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 63275008(gen: 166919 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 60080128(gen: 166918 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 58032128(gen: 166917 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 55689216(gen: 166916 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 52264960(gen: 166915 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 49758208(gen: 166914 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 48300032(gen: 166913 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 45350912(gen: 166912 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 40337408(gen: 166911 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 71172096(gen: 166846 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 61210624(gen: 166843 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 55492608(gen: 166840 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 36044800(gen: 166829 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 34095104(gen: 166828 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 33046528(gen: 166827 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 31014912(gen: 166826 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 30556160(gen: 166825 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 777011200(gen: 166822 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 766672896(gen: 166821 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 690274304(gen: 166820 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 175046656(gen: 166819 level: 1) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 766017536(gen: 166813 level: 0) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 765739008(gen: 166813 level: 0) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
Well block 32604160(gen: 152478 level: 0) seems good, but
generation/level doesn't match, want gen: 166932 level: 1
# btrfs check /dev/sdb3
Opening filesystem to check...
checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
bad tree block 952483840, bytenr mismatch, want=952483840, have=0
ERROR: failed to read block groups: Input/output error
ERROR: cannot open file system


# uname -a
Linux fry 5.13.6-200.fc34.x86_64 #1 SMP Wed Jul 28 15:31:21 UTC 2021
x86_64 x86_64 x86_64 GNU/Linux
# btrfs --version
btrfs-progs v5.13.1
# btrfs fi show /dev/sdb3
Label: none  uuid: 44a768e0-28ba-4c6a-8eef-18ffa8c27d1b
    Total devices 1 FS bytes used 171.92GiB
    devid    1 size 472.10GiB used 214.02GiB path /dev/sdb3



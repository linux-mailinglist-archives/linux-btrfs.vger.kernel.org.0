Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA92241481
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 03:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgHKBTC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 21:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgHKBTC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 21:19:02 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2B3C06174A
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 18:19:01 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id o22so8314829qtt.13
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 18:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dallalba.com.ar; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=586u42NIXoMEeijMFhCnfFfg95iokTLTxg5E3cQu2cU=;
        b=NGZYirRd7URtm38VZGileUGdyOXmJ7Fm03EX5AYLlCMo8X3pjLarl0vo1NKl5hM1H0
         w15ag8ijrVhO0y9M90VNTvEUJBFsUXHPScxTwZ3lEBROWHu2JE5nXgANh2PvOvngF79S
         rfckbqJC8a01OH0mC8SxR2cda6teIjLmJ42AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=586u42NIXoMEeijMFhCnfFfg95iokTLTxg5E3cQu2cU=;
        b=NeYFsdwc6XEsvZpmMkq+numr281mubn//GhT7o8K8prpKo5d/1LZphlwCmeex4H+ur
         mUl63aUgqa4hRwfmH0FS35GXY9Td0dni182xd/YKsZHu3bchC6MkFDonqPl64A2aSuAz
         JaTAF8h2k2gSwzIsg7Tkca5rC2J7C05lqXSaI09YUsfBeDrr9sNG9XuJpK1sl/fv4Hvp
         HPZ/YJ/6zZDJgzpdSHu53Fjz2oHO5CQ4jP7ilnGqegfMvfXlkZGIoYMoM8ocxCJYwCcX
         gf3Yp9e1wBKA2OORjkDEMH7oia+3873/AZC+0xKSn2WbIFDD5/h8IwHICwyfDVBOY80I
         yUMQ==
X-Gm-Message-State: AOAM533xdbC4SJgCUmwAQAt2TJzxHExmLIO1Bs2+YOaahk+ZDjLmHg9n
        UpTfCHGLWb1RwpiuMQJul3oJZVmroA==
X-Google-Smtp-Source: ABdhPJxUz0zSebm4fEsgZkB7u3UqaHTq5V9Pyvta1AjmS6gZndo3WfBfIoUDQqJFZMF2bkZwcpvAOQ==
X-Received: by 2002:ac8:4c9a:: with SMTP id j26mr29635786qtv.373.1597108740116;
        Mon, 10 Aug 2020 18:19:00 -0700 (PDT)
Received: from atomica ([2803:9800:a011:8d29:5451:2ccb:2ae2:6404])
        by smtp.gmail.com with ESMTPSA id f92sm6761448qtd.9.2020.08.10.18.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 18:18:59 -0700 (PDT)
Message-ID: <9863afbc619489c98693a4e1d02a38136f5c2ef3.camel@dallalba.com.ar>
Subject: Re: raid10 corruption while removing failing disk
From:   =?UTF-8?Q?Agust=C3=ADn_Dall=CA=BCAlba?= <agustin@dallalba.com.ar>
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Date:   Mon, 10 Aug 2020 22:18:57 -0300
In-Reply-To: <4c967884-2252-a21d-a994-80df64a7e6ef@suse.com>
References: <3dc4d28e81b3336311c979bda35ceb87b9645606.camel@dallalba.com.ar>
         <4c967884-2252-a21d-a994-80df64a7e6ef@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 2020-08-10 at 11:21 +0300, Nikolay Borisov wrote:
> This suggests you are hitting a known problem with reloc roots which
> have been fixed in the latest upstream and lts (5.4) kernels:
> 
> 044ca910276b btrfs: reloc: fix reloc root leak and NULL pointer
> dereference (3 months ago) <Qu Wenruo>
> 707de9c0806d btrfs: relocation: fix reloc_root lifespan and access (7
> months ago) <Qu Wenruo>
> 1fac4a54374f btrfs: relocation: fix use-after-free on dead relocation
> roots (11 months ago) <Qu Wenruo>
> 
> 
> So yes, try to update to latest stable kernel and re-run the device
> remove. Also update your btrfs progs to latest 5.6 version and rerun
> check again (by default it's a read only operations so it shouldn't
> cause any more damage).

I have tried again with the 5.8.0 kernel and btrfs-progs v5.7 (which
I've compiled statically on a different machine and used only for btrfs
device remove and btrfs check). The system still goes read-only when I
attempt to remove the failing drive, but it doesn't oops in this
version.

This version of btrfs check finds many more problems, however the
'checksum verify failed' line looks supicious: instead of `found
BAB1746E wanted A8A48266` it prints `found 0000006E wanted 00000066`
like if the checksums had been truncated to 8 bits before printing.

I still haven't tried disconnecting the failing disk.

Thanks again.

# mount / -o remount,ro
# /root/btrfs.box.static check --force /dev/sda
Opening filesystem to check...
WARNING: filesystem mounted, continuing because of --force
Checking filesystem on /dev/sda
UUID: 4d3acf20-d408-49ab-b0a6-182396a9f27c
[1/7] checking root items
checksum verify failed on 10919566688256 found 0000006E wanted 00000066
checksum verify failed on 10919566688256 found 0000006E wanted 00000066
bad tree block 10919566688256, bytenr mismatch, want=10919566688256, have=17196831625821864417
ERROR: failed to repair root items: Input/output error
[2/7] checking extents
checksum verify failed on 10919566688256 found 0000006E wanted 00000066
checksum verify failed on 10919566688256 found 0000006E wanted 00000066
bad tree block 10919566688256, bytenr mismatch, want=10919566688256, have=17196831625821864417
ref mismatch on [1927970496512 266240] extent item 0, found 1
data backref 1927970496512 parent 10916974444544 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927970496512 parent 10916974444544 owner 0 offset 0 found 1 wanted 0 back 0x4e8429e0
backpointer mismatch on [1927970496512 266240]
ref mismatch on [1927970762752 262144] extent item 0, found 1
data backref 1927970762752 parent 10916974444544 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927970762752 parent 10916974444544 owner 0 offset 0 found 1 wanted 0 back 0x37cee2e0
backpointer mismatch on [1927970762752 262144]
ref mismatch on [1927971024896 262144] extent item 0, found 1
data backref 1927971024896 parent 10916974444544 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927971024896 parent 10916974444544 owner 0 offset 0 found 1 wanted 0 back 0x4ce044a0
backpointer mismatch on [1927971024896 262144]
ref mismatch on [1927971287040 528384] extent item 0, found 1
data backref 1927971287040 parent 10916974444544 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927971287040 parent 10916974444544 owner 0 offset 0 found 1 wanted 0 back 0x4e848680
backpointer mismatch on [1927971287040 528384]
ref mismatch on [1927971815424 790528] extent item 0, found 1
data backref 1927971815424 parent 10916974444544 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927971815424 parent 10916974444544 owner 0 offset 0 found 1 wanted 0 back 0x4076da70
backpointer mismatch on [1927971815424 790528]
ref mismatch on [1927972605952 524288] extent item 0, found 1
data backref 1927972605952 parent 10916974444544 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927972605952 parent 10916974444544 owner 0 offset 0 found 1 wanted 0 back 0x37cee410
backpointer mismatch on [1927972605952 524288]
ref mismatch on [1927973130240 262144] extent item 0, found 1
data backref 1927973130240 parent 10916974444544 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927973130240 parent 10916974444544 owner 0 offset 0 found 1 wanted 0 back 0x4075bde0
backpointer mismatch on [1927973130240 262144]
ref mismatch on [1927973392384 262144] extent item 0, found 1
data backref 1927973392384 parent 10916974444544 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927973392384 parent 10916974444544 owner 0 offset 0 found 1 wanted 0 back 0x426b5430
backpointer mismatch on [1927973392384 262144]
ref mismatch on [1927973654528 262144] extent item 0, found 1
data backref 1927973654528 parent 10916974444544 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927973654528 parent 10916974444544 owner 0 offset 0 found 1 wanted 0 back 0x4076c510
backpointer mismatch on [1927973654528 262144]
ref mismatch on [1927973916672 262144] extent item 0, found 1
data backref 1927973916672 parent 10916974444544 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927973916672 parent 10916974444544 owner 0 offset 0 found 1 wanted 0 back 0x49784810
backpointer mismatch on [1927973916672 262144]
ref mismatch on [1927974178816 262144] extent item 0, found 1
data backref 1927974178816 parent 10916974444544 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927974178816 parent 10916974444544 owner 0 offset 0 found 1 wanted 0 back 0x37ce3520
backpointer mismatch on [1927974178816 262144]
ref mismatch on [1927974440960 262144] extent item 0, found 1
data backref 1927974440960 parent 10917170806784 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927974440960 parent 10917170806784 owner 0 offset 0 found 1 wanted 0 back 0x426b8f30
backpointer mismatch on [1927974440960 262144]
ref mismatch on [1927974703104 262144] extent item 0, found 1
data backref 1927974703104 parent 10916974444544 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927974703104 parent 10916974444544 owner 0 offset 0 found 1 wanted 0 back 0x4076e2c0
backpointer mismatch on [1927974703104 262144]
ref mismatch on [1927974965248 397312] extent item 0, found 1
data backref 1927974965248 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927974965248 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x4076e520
backpointer mismatch on [1927974965248 397312]
ref mismatch on [1927975362560 262144] extent item 0, found 1
data backref 1927975362560 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927975362560 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x4e84d870
backpointer mismatch on [1927975362560 262144]
ref mismatch on [1927975624704 262144] extent item 0, found 1
data backref 1927975624704 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927975624704 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x4ce04a90
backpointer mismatch on [1927975624704 262144]
ref mismatch on [1927975886848 528384] extent item 0, found 1
data backref 1927975886848 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927975886848 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x37ceeec0
backpointer mismatch on [1927975886848 528384]
ref mismatch on [1927976415232 262144] extent item 0, found 1
data backref 1927976415232 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927976415232 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x4076e650
backpointer mismatch on [1927976415232 262144]
ref mismatch on [1927976677376 524288] extent item 0, found 1
data backref 1927976677376 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927976677376 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x37cef120
backpointer mismatch on [1927976677376 524288]
ref mismatch on [1927977201664 528384] extent item 0, found 1
data backref 1927977201664 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927977201664 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x4076e9e0
backpointer mismatch on [1927977201664 528384]
ref mismatch on [1927977730048 262144] extent item 0, found 1
data backref 1927977730048 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927977730048 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x4076eb10
backpointer mismatch on [1927977730048 262144]
ref mismatch on [1927977992192 528384] extent item 0, found 1
data backref 1927977992192 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927977992192 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x37cef250
backpointer mismatch on [1927977992192 528384]
ref mismatch on [1927978520576 262144] extent item 0, found 1
data backref 1927978520576 parent 10918936985600 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927978520576 parent 10918936985600 owner 0 offset 0 found 1 wanted 0 back 0x1f1d8590
backpointer mismatch on [1927978520576 262144]
ref mismatch on [1927978782720 262144] extent item 0, found 1
data backref 1927978782720 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927978782720 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x4076ec40
backpointer mismatch on [1927978782720 262144]
ref mismatch on [1927979044864 262144] extent item 0, found 1
data backref 1927979044864 parent 10916974444544 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927979044864 parent 10916974444544 owner 0 offset 0 found 1 wanted 0 back 0x4076d810
backpointer mismatch on [1927979044864 262144]
ref mismatch on [1927979307008 262144] extent item 0, found 1
data backref 1927979307008 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927979307008 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x4075cc20
backpointer mismatch on [1927979307008 262144]
ref mismatch on [1927979569152 262144] extent item 0, found 1
data backref 1927979569152 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927979569152 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x4075ce80
backpointer mismatch on [1927979569152 262144]
ref mismatch on [1927979831296 262144] extent item 0, found 1
data backref 1927979831296 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927979831296 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x4076f490
backpointer mismatch on [1927979831296 262144]
ref mismatch on [1927980093440 262144] extent item 0, found 1
data backref 1927980093440 parent 10918936985600 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927980093440 parent 10918936985600 owner 0 offset 0 found 1 wanted 0 back 0x26a1ae90
backpointer mismatch on [1927980093440 262144]
ref mismatch on [1927980355584 266240] extent item 0, found 1
data backref 1927980355584 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927980355584 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x4ce11150
backpointer mismatch on [1927980355584 266240]
ref mismatch on [1927980621824 262144] extent item 0, found 1
data backref 1927980621824 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927980621824 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x4075d210
backpointer mismatch on [1927980621824 262144]
ref mismatch on [1927980883968 262144] extent item 0, found 1
data backref 1927980883968 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927980883968 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x426b57c0
backpointer mismatch on [1927980883968 262144]
ref mismatch on [1927981146112 397312] extent item 0, found 1
data backref 1927981146112 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927981146112 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x37ce45c0
backpointer mismatch on [1927981146112 397312]
ref mismatch on [1927981543424 397312] extent item 0, found 1
data backref 1927981543424 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927981543424 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x4ce04e20
backpointer mismatch on [1927981543424 397312]
ref mismatch on [1927981940736 262144] extent item 0, found 1
data backref 1927981940736 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927981940736 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x4ce04cf0
backpointer mismatch on [1927981940736 262144]
ref mismatch on [1927982202880 262144] extent item 0, found 1
data backref 1927982202880 parent 10918936985600 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927982202880 parent 10918936985600 owner 0 offset 0 found 1 wanted 0 back 0x1f1da010
backpointer mismatch on [1927982202880 262144]
ref mismatch on [1927982465024 131072] extent item 0, found 1
data backref 1927982465024 parent 10916974444544 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927982465024 parent 10916974444544 owner 0 offset 0 found 1 wanted 0 back 0x4e84d150
backpointer mismatch on [1927982465024 131072]
ref mismatch on [1927982596096 131072] extent item 0, found 1
data backref 1927982596096 parent 10917135319040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927982596096 parent 10917135319040 owner 0 offset 0 found 1 wanted 0 back 0x497949b0
backpointer mismatch on [1927982596096 131072]
ref mismatch on [1927982727168 262144] extent item 0, found 1
data backref 1927982727168 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927982727168 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x37ce4950
backpointer mismatch on [1927982727168 262144]
ref mismatch on [1927982989312 262144] extent item 0, found 1
data backref 1927982989312 parent 10916975575040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927982989312 parent 10916975575040 owner 0 offset 0 found 1 wanted 0 back 0x37cefe30
backpointer mismatch on [1927982989312 262144]
ref mismatch on [1927983251456 4096] extent item 0, found 1
data backref 1927983251456 parent 10593646477312 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927983251456 parent 10593646477312 owner 0 offset 0 found 1 wanted 0 back 0x37cf9500
backpointer mismatch on [1927983251456 4096]
ref mismatch on [1927983255552 266240] extent item 0, found 1
data backref 1927983255552 parent 10916975722496 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927983255552 parent 10916975722496 owner 0 offset 0 found 1 wanted 0 back 0x4ce11870
backpointer mismatch on [1927983255552 266240]
ref mismatch on [1927983521792 262144] extent item 0, found 1
data backref 1927983521792 parent 10916975722496 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927983521792 parent 10916975722496 owner 0 offset 0 found 1 wanted 0 back 0x49792ad0
backpointer mismatch on [1927983521792 262144]
ref mismatch on [1927983783936 262144] extent item 0, found 1
data backref 1927983783936 parent 10916974444544 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927983783936 parent 10916974444544 owner 0 offset 0 found 1 wanted 0 back 0x4c7a4ea0
backpointer mismatch on [1927983783936 262144]
ref mismatch on [1927984046080 262144] extent item 0, found 1
data backref 1927984046080 parent 10916975722496 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927984046080 parent 10916975722496 owner 0 offset 0 found 1 wanted 0 back 0x49792f90
backpointer mismatch on [1927984046080 262144]
ref mismatch on [1927984308224 262144] extent item 0, found 1
data backref 1927984308224 parent 10916975722496 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927984308224 parent 10916975722496 owner 0 offset 0 found 1 wanted 0 back 0x497930c0
backpointer mismatch on [1927984308224 262144]
ref mismatch on [1927984570368 262144] extent item 0, found 1
data backref 1927984570368 parent 10916975722496 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927984570368 parent 10916975722496 owner 0 offset 0 found 1 wanted 0 back 0x497931f0
backpointer mismatch on [1927984570368 262144]
ref mismatch on [1927984832512 262144] extent item 0, found 1
data backref 1927984832512 parent 10916975722496 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927984832512 parent 10916975722496 owner 0 offset 0 found 1 wanted 0 back 0x40770b20
backpointer mismatch on [1927984832512 262144]
ref mismatch on [1927985094656 262144] extent item 0, found 1
data backref 1927985094656 parent 10916975722496 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927985094656 parent 10916975722496 owner 0 offset 0 found 1 wanted 0 back 0x37ce51a0
backpointer mismatch on [1927985094656 262144]
ref mismatch on [1927985356800 262144] extent item 0, found 1
data backref 1927985356800 parent 10916975722496 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927985356800 parent 10916975722496 owner 0 offset 0 found 1 wanted 0 back 0x49793450
backpointer mismatch on [1927985356800 262144]
ref mismatch on [1927985618944 397312] extent item 0, found 1
data backref 1927985618944 parent 10916975722496 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927985618944 parent 10916975722496 owner 0 offset 0 found 1 wanted 0 back 0x37cf0a10
backpointer mismatch on [1927985618944 397312]
ref mismatch on [1927986016256 528384] extent item 0, found 1
data backref 1927986016256 parent 10916975722496 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927986016256 parent 10916975722496 owner 0 offset 0 found 1 wanted 0 back 0x40771900
backpointer mismatch on [1927986016256 528384]
ref mismatch on [1927986544640 262144] extent item 0, found 1
data backref 1927986544640 parent 10918936985600 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927986544640 parent 10918936985600 owner 0 offset 0 found 1 wanted 0 back 0x33398bc0
backpointer mismatch on [1927986544640 262144]
ref mismatch on [1927986806784 262144] extent item 0, found 1
data backref 1927986806784 parent 10917170806784 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927986806784 parent 10917170806784 owner 0 offset 0 found 1 wanted 0 back 0x426b9780
backpointer mismatch on [1927986806784 262144]
ref mismatch on [1927987068928 262144] extent item 0, found 1
data backref 1927987068928 parent 10916975722496 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927987068928 parent 10916975722496 owner 0 offset 0 found 1 wanted 0 back 0x40771c90
backpointer mismatch on [1927987068928 262144]
ref mismatch on [1927987331072 397312] extent item 0, found 1
data backref 1927987331072 parent 10916975722496 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927987331072 parent 10916975722496 owner 0 offset 0 found 1 wanted 0 back 0x49794030
backpointer mismatch on [1927987331072 397312]
ref mismatch on [1927987728384 262144] extent item 0, found 1
data backref 1927987728384 parent 10916975722496 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927987728384 parent 10916975722496 owner 0 offset 0 found 1 wanted 0 back 0x37ce59f0
backpointer mismatch on [1927987728384 262144]
ref mismatch on [1927987990528 262144] extent item 0, found 1
data backref 1927987990528 parent 10918936985600 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927987990528 parent 10918936985600 owner 0 offset 0 found 1 wanted 0 back 0x4ce33b10
backpointer mismatch on [1927987990528 262144]
ref mismatch on [1927988252672 262144] extent item 0, found 1
data backref 1927988252672 parent 10917135319040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927988252672 parent 10917135319040 owner 0 offset 0 found 1 wanted 0 back 0x426b7050
backpointer mismatch on [1927988252672 262144]
ref mismatch on [1927988514816 262144] extent item 0, found 1
data backref 1927988514816 parent 10917135319040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927988514816 parent 10917135319040 owner 0 offset 0 found 1 wanted 0 back 0x4e83fb50
backpointer mismatch on [1927988514816 262144]
ref mismatch on [1927988776960 262144] extent item 0, found 1
data backref 1927988776960 parent 10917135319040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927988776960 parent 10917135319040 owner 0 offset 0 found 1 wanted 0 back 0x40772c00
backpointer mismatch on [1927988776960 262144]
ref mismatch on [1927989039104 262144] extent item 0, found 1
data backref 1927989039104 parent 10917135319040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927989039104 parent 10917135319040 owner 0 offset 0 found 1 wanted 0 back 0x37ce6f50
backpointer mismatch on [1927989039104 262144]
ref mismatch on [1927989301248 262144] extent item 0, found 1
data backref 1927989301248 parent 10917135319040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927989301248 parent 10917135319040 owner 0 offset 0 found 1 wanted 0 back 0x407731f0
backpointer mismatch on [1927989301248 262144]
ref mismatch on [1927989563392 262144] extent item 0, found 1
data backref 1927989563392 parent 10917135319040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927989563392 parent 10917135319040 owner 0 offset 0 found 1 wanted 0 back 0x49795590
backpointer mismatch on [1927989563392 262144]
ref mismatch on [1927989825536 397312] extent item 0, found 1
data backref 1927989825536 parent 10917135319040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927989825536 parent 10917135319040 owner 0 offset 0 found 1 wanted 0 back 0x426b7b00
backpointer mismatch on [1927989825536 397312]
ref mismatch on [1927990222848 262144] extent item 0, found 1
data backref 1927990222848 parent 10917135319040 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927990222848 parent 10917135319040 owner 0 offset 0 found 1 wanted 0 back 0x407602c0
backpointer mismatch on [1927990222848 262144]
ref mismatch on [1927990484992 262144] extent item 0, found 1
data backref 1927990484992 parent 10917170806784 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927990484992 parent 10917170806784 owner 0 offset 0 found 1 wanted 0 back 0x37cf33a0
backpointer mismatch on [1927990484992 262144]
ref mismatch on [1927990747136 397312] extent item 0, found 1
data backref 1927990747136 parent 10917170806784 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927990747136 parent 10917170806784 owner 0 offset 0 found 1 wanted 0 back 0x106d0350
backpointer mismatch on [1927990747136 397312]
ref mismatch on [1927991144448 262144] extent item 0, found 1
data backref 1927991144448 parent 10917170806784 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927991144448 parent 10917170806784 owner 0 offset 0 found 1 wanted 0 back 0x37ce98e0
backpointer mismatch on [1927991144448 262144]
ref mismatch on [1927991406592 397312] extent item 0, found 1
data backref 1927991406592 parent 10917170806784 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927991406592 parent 10917170806784 owner 0 offset 0 found 1 wanted 0 back 0x426b8350
backpointer mismatch on [1927991406592 397312]
ref mismatch on [1927991803904 262144] extent item 0, found 1
data backref 1927991803904 parent 10917180702720 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927991803904 parent 10917180702720 owner 0 offset 0 found 1 wanted 0 back 0x49796e80
backpointer mismatch on [1927991803904 262144]
ref mismatch on [1927992066048 397312] extent item 0, found 1
data backref 1927992066048 parent 10917170806784 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927992066048 parent 10917170806784 owner 0 offset 0 found 1 wanted 0 back 0x49795b80
backpointer mismatch on [1927992066048 397312]
ref mismatch on [1927992463360 262144] extent item 0, found 1
data backref 1927992463360 parent 10917180702720 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927992463360 parent 10917180702720 owner 0 offset 0 found 1 wanted 0 back 0x497976d0
backpointer mismatch on [1927992463360 262144]
ref mismatch on [1927992725504 262144] extent item 0, found 1
data backref 1927992725504 parent 10917170806784 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927992725504 parent 10917170806784 owner 0 offset 0 found 1 wanted 0 back 0x37ce7c60
backpointer mismatch on [1927992725504 262144]
ref mismatch on [1927992987648 262144] extent item 0, found 1
data backref 1927992987648 parent 10917170806784 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927992987648 parent 10917170806784 owner 0 offset 0 found 1 wanted 0 back 0x497734f0
backpointer mismatch on [1927992987648 262144]
ref mismatch on [1927993249792 262144] extent item 0, found 1
data backref 1927993249792 parent 10917170806784 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927993249792 parent 10917170806784 owner 0 offset 0 found 1 wanted 0 back 0x49796040
backpointer mismatch on [1927993249792 262144]
ref mismatch on [1927993511936 262144] extent item 0, found 1
data backref 1927993511936 parent 10918936985600 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927993511936 parent 10918936985600 owner 0 offset 0 found 1 wanted 0 back 0x4976e700
backpointer mismatch on [1927993511936 262144]
ref mismatch on [1927993774080 397312] extent item 0, found 1
data backref 1927993774080 parent 10917170806784 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927993774080 parent 10917170806784 owner 0 offset 0 found 1 wanted 0 back 0x40760d70
backpointer mismatch on [1927993774080 397312]
ref mismatch on [1927994171392 397312] extent item 0, found 1
data backref 1927994171392 parent 10917170806784 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927994171392 parent 10917170806784 owner 0 offset 0 found 1 wanted 0 back 0x497969c0
backpointer mismatch on [1927994171392 397312]
ref mismatch on [1927994568704 262144] extent item 0, found 1
data backref 1927994568704 parent 10918936985600 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927994568704 parent 10918936985600 owner 0 offset 0 found 1 wanted 0 back 0x21294ae0
backpointer mismatch on [1927994568704 262144]
ref mismatch on [1927994830848 262144] extent item 0, found 1
data backref 1927994830848 parent 10917180702720 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927994830848 parent 10917180702720 owner 0 offset 0 found 1 wanted 0 back 0x49796d50
backpointer mismatch on [1927994830848 262144]
ref mismatch on [1927995092992 262144] extent item 0, found 1
data backref 1927995092992 parent 10917180702720 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927995092992 parent 10917180702720 owner 0 offset 0 found 1 wanted 0 back 0x426b99e0
backpointer mismatch on [1927995092992 262144]
ref mismatch on [1927995355136 524288] extent item 0, found 1
data backref 1927995355136 parent 10917180702720 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927995355136 parent 10917180702720 owner 0 offset 0 found 1 wanted 0 back 0x37cf34d0
backpointer mismatch on [1927995355136 524288]
ref mismatch on [1927995879424 262144] extent item 0, found 1
data backref 1927995879424 parent 10917180702720 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927995879424 parent 10917180702720 owner 0 offset 0 found 1 wanted 0 back 0x4c7a6400
backpointer mismatch on [1927995879424 262144]
ref mismatch on [1927996141568 397312] extent item 0, found 1
data backref 1927996141568 parent 10917180702720 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927996141568 parent 10917180702720 owner 0 offset 0 found 1 wanted 0 back 0x40761820
backpointer mismatch on [1927996141568 397312]
ref mismatch on [1927996538880 262144] extent item 0, found 1
data backref 1927996538880 parent 10917180702720 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927996538880 parent 10917180702720 owner 0 offset 0 found 1 wanted 0 back 0x4ce159c0
backpointer mismatch on [1927996538880 262144]
ref mismatch on [1927996801024 262144] extent item 0, found 1
data backref 1927996801024 parent 10917180702720 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927996801024 parent 10917180702720 owner 0 offset 0 found 1 wanted 0 back 0x497752a0
backpointer mismatch on [1927996801024 262144]
ref mismatch on [1927997063168 262144] extent item 0, found 1
data backref 1927997063168 parent 10917180702720 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927997063168 parent 10917180702720 owner 0 offset 0 found 1 wanted 0 back 0x4ce16340
backpointer mismatch on [1927997063168 262144]
ref mismatch on [1927997325312 262144] extent item 0, found 1
data backref 1927997325312 parent 10917180702720 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927997325312 parent 10917180702720 owner 0 offset 0 found 1 wanted 0 back 0x40761a80
backpointer mismatch on [1927997325312 262144]
ref mismatch on [1927997587456 262144] extent item 0, found 1
data backref 1927997587456 parent 10917180702720 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927997587456 parent 10917180702720 owner 0 offset 0 found 1 wanted 0 back 0x49775d50
backpointer mismatch on [1927997587456 262144]
ref mismatch on [1927997849600 262144] extent item 0, found 1
data backref 1927997849600 parent 10917180702720 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927997849600 parent 10917180702720 owner 0 offset 0 found 1 wanted 0 back 0x497983e0
backpointer mismatch on [1927997849600 262144]
ref mismatch on [1927998111744 397312] extent item 0, found 1
data backref 1927998111744 parent 10917180702720 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927998111744 parent 10917180702720 owner 0 offset 0 found 1 wanted 0 back 0x49775fb0
backpointer mismatch on [1927998111744 397312]
ref mismatch on [1927998509056 262144] extent item 0, found 1
data backref 1927998509056 parent 10917180702720 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927998509056 parent 10917180702720 owner 0 offset 0 found 1 wanted 0 back 0x37d171e0
backpointer mismatch on [1927998509056 262144]
ref mismatch on [1927998771200 397312] extent item 0, found 1
data backref 1927998771200 parent 10917282856960 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927998771200 parent 10917282856960 owner 0 offset 0 found 1 wanted 0 back 0x497989d0
backpointer mismatch on [1927998771200 397312]
ref mismatch on [1927999168512 262144] extent item 0, found 1
data backref 1927999168512 parent 10917282856960 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927999168512 parent 10917282856960 owner 0 offset 0 found 1 wanted 0 back 0x40762530
backpointer mismatch on [1927999168512 262144]
ref mismatch on [1927999430656 262144] extent item 0, found 1
data backref 1927999430656 parent 10916985520128 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927999430656 parent 10916985520128 owner 0 offset 0 found 1 wanted 0 back 0x4ce3bd40
backpointer mismatch on [1927999430656 262144]
ref mismatch on [1927999692800 262144] extent item 0, found 1
data backref 1927999692800 parent 10917282856960 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927999692800 parent 10917282856960 owner 0 offset 0 found 1 wanted 0 back 0x49798e90
backpointer mismatch on [1927999692800 262144]
ref mismatch on [1927999954944 262144] extent item 0, found 1
data backref 1927999954944 parent 10917180702720 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1927999954944 parent 10917180702720 owner 0 offset 0 found 1 wanted 0 back 0x497753d0
backpointer mismatch on [1927999954944 262144]
ref mismatch on [1928000217088 397312] extent item 0, found 1
data backref 1928000217088 parent 10917282856960 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928000217088 parent 10917282856960 owner 0 offset 0 found 1 wanted 0 back 0x49777250
backpointer mismatch on [1928000217088 397312]
ref mismatch on [1928000614400 262144] extent item 0, found 1
data backref 1928000614400 parent 10917282856960 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928000614400 parent 10917282856960 owner 0 offset 0 found 1 wanted 0 back 0x37cf4900
backpointer mismatch on [1928000614400 262144]
ref mismatch on [1928000876544 266240] extent item 0, found 1
data backref 1928000876544 parent 10917282856960 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928000876544 parent 10917282856960 owner 0 offset 0 found 1 wanted 0 back 0x4ce17050
backpointer mismatch on [1928000876544 266240]
ref mismatch on [1928001142784 262144] extent item 0, found 1
data backref 1928001142784 parent 10917180702720 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928001142784 parent 10917180702720 owner 0 offset 0 found 1 wanted 0 back 0x426ba6f0
backpointer mismatch on [1928001142784 262144]
ref mismatch on [1928001404928 262144] extent item 0, found 1
data backref 1928001404928 parent 10917282856960 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928001404928 parent 10917282856960 owner 0 offset 0 found 1 wanted 0 back 0x37d19190
backpointer mismatch on [1928001404928 262144]
ref mismatch on [1928001667072 262144] extent item 0, found 1
data backref 1928001667072 parent 10917282856960 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928001667072 parent 10917282856960 owner 0 offset 0 found 1 wanted 0 back 0x37cea4c0
backpointer mismatch on [1928001667072 262144]
ref mismatch on [1928001929216 397312] extent item 0, found 1
data backref 1928001929216 parent 10917282856960 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928001929216 parent 10917282856960 owner 0 offset 0 found 1 wanted 0 back 0x49799480
backpointer mismatch on [1928001929216 397312]
ref mismatch on [1928002326528 786432] extent item 0, found 1
data backref 1928002326528 parent 10917282856960 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928002326528 parent 10917282856960 owner 0 offset 0 found 1 wanted 0 back 0x4ce172b0
backpointer mismatch on [1928002326528 786432]
ref mismatch on [1928003112960 262144] extent item 0, found 1
data backref 1928003112960 parent 10917282856960 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928003112960 parent 10917282856960 owner 0 offset 0 found 1 wanted 0 back 0x407662f0
backpointer mismatch on [1928003112960 262144]
ref mismatch on [1928003375104 659456] extent item 0, found 1
data backref 1928003375104 parent 10917282856960 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928003375104 parent 10917282856960 owner 0 offset 0 found 1 wanted 0 back 0x49778a10
backpointer mismatch on [1928003375104 659456]
ref mismatch on [1928004034560 262144] extent item 0, found 1
data backref 1928004034560 parent 10917282856960 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928004034560 parent 10917282856960 owner 0 offset 0 found 1 wanted 0 back 0x37d19d70
backpointer mismatch on [1928004034560 262144]
ref mismatch on [1928004296704 262144] extent item 0, found 1
data backref 1928004296704 parent 10917282856960 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928004296704 parent 10917282856960 owner 0 offset 0 found 1 wanted 0 back 0x37ceaab0
backpointer mismatch on [1928004296704 262144]
ref mismatch on [1928004558848 262144] extent item 0, found 1
data backref 1928004558848 parent 10917282856960 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928004558848 parent 10917282856960 owner 0 offset 0 found 1 wanted 0 back 0x37ceabe0
backpointer mismatch on [1928004558848 262144]
ref mismatch on [1928004820992 262144] extent item 0, found 1
data backref 1928004820992 parent 10917282856960 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928004820992 parent 10917282856960 owner 0 offset 0 found 1 wanted 0 back 0x49799cd0
backpointer mismatch on [1928004820992 262144]
ref mismatch on [1928005083136 262144] extent item 0, found 1
data backref 1928005083136 parent 10916985520128 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928005083136 parent 10916985520128 owner 0 offset 0 found 1 wanted 0 back 0x212bbf00
backpointer mismatch on [1928005083136 262144]
ref mismatch on [1928005345280 262144] extent item 0, found 1
data backref 1928005345280 parent 10917292867584 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928005345280 parent 10917292867584 owner 0 offset 0 found 1 wanted 0 back 0x49779850
backpointer mismatch on [1928005345280 262144]
ref mismatch on [1928005607424 262144] extent item 0, found 1
data backref 1928005607424 parent 10917292867584 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928005607424 parent 10917292867584 owner 0 offset 0 found 1 wanted 0 back 0x40762fe0
backpointer mismatch on [1928005607424 262144]
ref mismatch on [1928005869568 397312] extent item 0, found 1
data backref 1928005869568 parent 10917292867584 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928005869568 parent 10917292867584 owner 0 offset 0 found 1 wanted 0 back 0x49779ab0
backpointer mismatch on [1928005869568 397312]
ref mismatch on [1928006266880 266240] extent item 0, found 1
data backref 1928006266880 parent 10917292867584 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928006266880 parent 10917292867584 owner 0 offset 0 found 1 wanted 0 back 0x4ce01190
backpointer mismatch on [1928006266880 266240]
ref mismatch on [1928006533120 262144] extent item 0, found 1
data backref 1928006533120 parent 10917292867584 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928006533120 parent 10917292867584 owner 0 offset 0 found 1 wanted 0 back 0x4ce0b640
backpointer mismatch on [1928006533120 262144]
ref mismatch on [1928006795264 262144] extent item 0, found 1
data backref 1928006795264 parent 10917292867584 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928006795264 parent 10917292867584 owner 0 offset 0 found 1 wanted 0 back 0x4ce0bd60
backpointer mismatch on [1928006795264 262144]
ref mismatch on [1928007057408 262144] extent item 0, found 1
data backref 1928007057408 parent 10917292867584 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928007057408 parent 10917292867584 owner 0 offset 0 found 1 wanted 0 back 0x4c7a7110
backpointer mismatch on [1928007057408 262144]
ref mismatch on [1928007319552 528384] extent item 0, found 1
data backref 1928007319552 parent 10917292867584 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928007319552 parent 10917292867584 owner 0 offset 0 found 1 wanted 0 back 0x40763cf0
backpointer mismatch on [1928007319552 528384]
ref mismatch on [1928007847936 262144] extent item 0, found 1
data backref 1928007847936 parent 10917292867584 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928007847936 parent 10917292867584 owner 0 offset 0 found 1 wanted 0 back 0x4979b820
backpointer mismatch on [1928007847936 262144]
ref mismatch on [1928008110080 262144] extent item 0, found 1
data backref 1928008110080 parent 10916985520128 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928008110080 parent 10916985520128 owner 0 offset 0 found 1 wanted 0 back 0x4ce4c2e0
backpointer mismatch on [1928008110080 262144]
ref mismatch on [1928008372224 262144] extent item 0, found 1
data backref 1928008372224 parent 10917292867584 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928008372224 parent 10917292867584 owner 0 offset 0 found 1 wanted 0 back 0x4ce19190
backpointer mismatch on [1928008372224 262144]
ref mismatch on [1928008634368 262144] extent item 0, found 1
data backref 1928008634368 parent 10917292867584 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928008634368 parent 10917292867584 owner 0 offset 0 found 1 wanted 0 back 0x4ce0c350
backpointer mismatch on [1928008634368 262144]
ref mismatch on [1928008896512 262144] extent item 0, found 1
data backref 1928008896512 parent 10917292867584 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928008896512 parent 10917292867584 owner 0 offset 0 found 1 wanted 0 back 0x4977fd40
backpointer mismatch on [1928008896512 262144]
ref mismatch on [1928009158656 262144] extent item 0, found 1
data backref 1928009158656 parent 10916985520128 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928009158656 parent 10916985520128 owner 0 offset 0 found 1 wanted 0 back 0x4ce4d120
backpointer mismatch on [1928009158656 262144]
ref mismatch on [1928009420800 262144] extent item 0, found 1
data backref 1928009420800 parent 10917292867584 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928009420800 parent 10917292867584 owner 0 offset 0 found 1 wanted 0 back 0x4979be10
backpointer mismatch on [1928009420800 262144]
ref mismatch on [1928009682944 4096] extent item 0, found 1
data backref 1928009682944 parent 10593646477312 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928009682944 parent 10593646477312 owner 0 offset 0 found 1 wanted 0 back 0x37cf93d0
backpointer mismatch on [1928009682944 4096]
ref mismatch on [1928009687040 262144] extent item 0, found 1
data backref 1928009687040 parent 10917292867584 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928009687040 parent 10917292867584 owner 0 offset 0 found 1 wanted 0 back 0x37cebbb0
backpointer mismatch on [1928009687040 262144]
ref mismatch on [1928009949184 262144] extent item 0, found 1
data backref 1928009949184 parent 10917294374912 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928009949184 parent 10917294374912 owner 0 offset 0 found 1 wanted 0 back 0x106d0b10
backpointer mismatch on [1928009949184 262144]
ref mismatch on [1928010211328 262144] extent item 0, found 1
data backref 1928010211328 parent 10917294374912 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928010211328 parent 10917294374912 owner 0 offset 0 found 1 wanted 0 back 0x4c7a7240
backpointer mismatch on [1928010211328 262144]
ref mismatch on [1928010473472 262144] extent item 0, found 1
data backref 1928010473472 parent 10917180702720 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928010473472 parent 10917180702720 owner 0 offset 0 found 1 wanted 0 back 0x49797b90
backpointer mismatch on [1928010473472 262144]
ref mismatch on [1928010735616 397312] extent item 0, found 1
data backref 1928010735616 parent 10917294374912 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928010735616 parent 10917294374912 owner 0 offset 0 found 1 wanted 0 back 0x4ce19d70
backpointer mismatch on [1928010735616 397312]
ref mismatch on [1928011132928 266240] extent item 0, found 1
data backref 1928011132928 parent 10917294374912 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928011132928 parent 10917294374912 owner 0 offset 0 found 1 wanted 0 back 0x4ce0d060
backpointer mismatch on [1928011132928 266240]
ref mismatch on [1928011399168 262144] extent item 0, found 1
data backref 1928011399168 parent 10917294374912 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928011399168 parent 10917294374912 owner 0 offset 0 found 1 wanted 0 back 0x37cf6ca0
backpointer mismatch on [1928011399168 262144]
ref mismatch on [1928011661312 262144] extent item 0, found 1
data backref 1928011661312 parent 10917294374912 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928011661312 parent 10917294374912 owner 0 offset 0 found 1 wanted 0 back 0x40764d90
backpointer mismatch on [1928011661312 262144]
ref mismatch on [1928011923456 262144] extent item 0, found 1
data backref 1928011923456 parent 10917294374912 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928011923456 parent 10917294374912 owner 0 offset 0 found 1 wanted 0 back 0x4ce1a230
backpointer mismatch on [1928011923456 262144]
ref mismatch on [1928012185600 262144] extent item 0, found 1
data backref 1928012185600 parent 10917294374912 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928012185600 parent 10917294374912 owner 0 offset 0 found 1 wanted 0 back 0x4979c790
backpointer mismatch on [1928012185600 262144]
ref mismatch on [1928012447744 262144] extent item 0, found 1
data backref 1928012447744 parent 10917180702720 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928012447744 parent 10917180702720 owner 0 offset 0 found 1 wanted 0 back 0x37d16990
backpointer mismatch on [1928012447744 262144]
ref mismatch on [1928012709888 262144] extent item 0, found 1
data backref 1928012709888 parent 10917294374912 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928012709888 parent 10917294374912 owner 0 offset 0 found 1 wanted 0 back 0x407654b0
backpointer mismatch on [1928012709888 262144]
ref mismatch on [1928012972032 262144] extent item 0, found 1
data backref 1928012972032 parent 10917294374912 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928012972032 parent 10917294374912 owner 0 offset 0 found 1 wanted 0 back 0x37d1fed0
backpointer mismatch on [1928012972032 262144]
ref mismatch on [1928013234176 262144] extent item 0, found 1
data backref 1928013234176 parent 10916985520128 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928013234176 parent 10916985520128 owner 0 offset 0 found 1 wanted 0 back 0x4ce4cff0
backpointer mismatch on [1928013234176 262144]
ref mismatch on [1928013496320 262144] extent item 0, found 1
data backref 1928013496320 parent 10917294456832 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928013496320 parent 10917294456832 owner 0 offset 0 found 1 wanted 0 back 0x37cec790
backpointer mismatch on [1928013496320 262144]
ref mismatch on [1928013758464 262144] extent item 0, found 1
data backref 1928013758464 parent 10916985520128 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928013758464 parent 10916985520128 owner 0 offset 0 found 1 wanted 0 back 0x4ce4c1b0
backpointer mismatch on [1928013758464 262144]
ref mismatch on [1928014020608 262144] extent item 0, found 1
data backref 1928014020608 parent 10917294456832 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928014020608 parent 10917294456832 owner 0 offset 0 found 1 wanted 0 back 0x49782df0
backpointer mismatch on [1928014020608 262144]
ref mismatch on [1928014282752 262144] extent item 0, found 1
data backref 1928014282752 parent 10916985520128 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928014282752 parent 10916985520128 owner 0 offset 0 found 1 wanted 0 back 0x4ce640d0
backpointer mismatch on [1928014282752 262144]
ref mismatch on [1928014544896 262144] extent item 0, found 1
data backref 1928014544896 parent 10917294456832 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928014544896 parent 10917294456832 owner 0 offset 0 found 1 wanted 0 back 0x4c7a2e90
backpointer mismatch on [1928014544896 262144]
ref mismatch on [1928014807040 262144] extent item 0, found 1
data backref 1928014807040 parent 10917294456832 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928014807040 parent 10917294456832 owner 0 offset 0 found 1 wanted 0 back 0x40766090
backpointer mismatch on [1928014807040 262144]
ref mismatch on [1928015069184 262144] extent item 0, found 1
data backref 1928015069184 parent 10917294456832 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928015069184 parent 10917294456832 owner 0 offset 0 found 1 wanted 0 back 0x426b44c0
backpointer mismatch on [1928015069184 262144]
ref mismatch on [1928015331328 528384] extent item 0, found 1
data backref 1928015331328 parent 10872129732608 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928015331328 parent 10872129732608 owner 0 offset 0 found 1 wanted 0 back 0x4ce0e950
backpointer mismatch on [1928015331328 528384]
ref mismatch on [1928015859712 528384] extent item 0, found 1
data backref 1928015859712 parent 10872129732608 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928015859712 parent 10872129732608 owner 0 offset 0 found 1 wanted 0 back 0x49783c30
backpointer mismatch on [1928015859712 528384]
ref mismatch on [1928016388096 528384] extent item 0, found 1
data backref 1928016388096 parent 10872129732608 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928016388096 parent 10872129732608 owner 0 offset 0 found 1 wanted 0 back 0x426b4850
backpointer mismatch on [1928016388096 528384]
ref mismatch on [1928016916480 262144] extent item 0, found 1
data backref 1928016916480 parent 10872129732608 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928016916480 parent 10872129732608 owner 0 offset 0 found 1 wanted 0 back 0x40766b40
backpointer mismatch on [1928016916480 262144]
ref mismatch on [1928017178624 262144] extent item 0, found 1
data backref 1928017178624 parent 10872129732608 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 1928017178624 parent 10872129732608 owner 0 offset 0 found 1 wanted 0 back 0x4c7a4d70
backpointer mismatch on [1928017178624 262144]
owner ref check failed [10919566688256 16384]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
root 257 inode 12842679 errors 1040, bad file extent, some csum missing
root 10463 inode 2159253 errors 1040, bad file extent, some csum missing
root 10463 inode 2159255 errors 1040, bad file extent, some csum missing
root 10463 inode 2159356 errors 1040, bad file extent, some csum missing
root 10463 inode 2159414 errors 1040, bad file extent, some csum missing
root 10464 inode 12842679 errors 1040, bad file extent, some csum missing
root 10531 inode 12842679 errors 1040, bad file extent, some csum missing
root 10594 inode 12842679 errors 1040, bad file extent, some csum missing
root 10622 inode 12842679 errors 1040, bad file extent, some csum missing
root 10653 inode 2159253 errors 1040, bad file extent, some csum missing
root 10653 inode 2159255 errors 1040, bad file extent, some csum missing
root 10653 inode 2159356 errors 1040, bad file extent, some csum missing
root 10653 inode 2159414 errors 1040, bad file extent, some csum missing
root 10667 inode 2159253 errors 1040, bad file extent, some csum missing
root 10667 inode 2159255 errors 1040, bad file extent, some csum missing
root 10667 inode 2159356 errors 1040, bad file extent, some csum missing
root 10667 inode 2159414 errors 1040, bad file extent, some csum missing
root 10668 inode 12842679 errors 1040, bad file extent, some csum missing
root 10825 inode 2159253 errors 1040, bad file extent, some csum missing
root 10825 inode 2159255 errors 1040, bad file extent, some csum missing
root 10825 inode 2159356 errors 1040, bad file extent, some csum missing
root 10825 inode 2159414 errors 1040, bad file extent, some csum missing
root 10826 inode 12842679 errors 1040, bad file extent, some csum missing
root 10854 inode 2159253 errors 1040, bad file extent, some csum missing
root 10854 inode 2159255 errors 1040, bad file extent, some csum missing
root 10854 inode 2159356 errors 1040, bad file extent, some csum missing
root 10854 inode 2159414 errors 1040, bad file extent, some csum missing
root 10855 inode 12842679 errors 1040, bad file extent, some csum missing
root 10915 inode 2159253 errors 1040, bad file extent, some csum missing
root 10915 inode 2159255 errors 1040, bad file extent, some csum missing
root 10915 inode 2159356 errors 1040, bad file extent, some csum missing
root 10915 inode 2159414 errors 1040, bad file extent, some csum missing
root 10916 inode 12842679 errors 1040, bad file extent, some csum missing
root 10924 inode 2159253 errors 1040, bad file extent, some csum missing
root 10924 inode 2159255 errors 1040, bad file extent, some csum missing
root 10924 inode 2159356 errors 1040, bad file extent, some csum missing
root 10924 inode 2159414 errors 1040, bad file extent, some csum missing
root 10925 inode 12842679 errors 1040, bad file extent, some csum missing
root 10948 inode 12842679 errors 1040, bad file extent, some csum missing
root 10971 inode 12842679 errors 1040, bad file extent, some csum missing
root 10975 inode 12842679 errors 1040, bad file extent, some csum missing
root 10978 inode 12842679 errors 1040, bad file extent, some csum missing
root 10996 inode 12842679 errors 1040, bad file extent, some csum missing
root 11002 inode 12842679 errors 1040, bad file extent, some csum missing
root 11006 inode 12842679 errors 1040, bad file extent, some csum missing
root 11011 inode 12842679 errors 1040, bad file extent, some csum missing
root 11028 inode 12842679 errors 1040, bad file extent, some csum missing
root 11142 inode 12842679 errors 1040, bad file extent, some csum missing
root 11187 inode 12842679 errors 1040, bad file extent, some csum missing
root 11188 inode 12842679 errors 1040, bad file extent, some csum missing
root 12277 inode 12842679 errors 1040, bad file extent, some csum missing
root 12278 inode 12842679 errors 1040, bad file extent, some csum missing
root 12279 inode 12842679 errors 1040, bad file extent, some csum missing
root 12280 inode 12842679 errors 1040, bad file extent, some csum missing
root 12281 inode 12842679 errors 1040, bad file extent, some csum missing
ERROR: errors found in fs roots
found 5392046571529 bytes used, error(s) found
total csum bytes: 5236510572
total tree bytes: 8053063680
total fs tree bytes: 1788641280
total extent tree bytes: 420773888
btree space waste bytes: 917733620
file data blocks allocated: 57094123556864
 referenced 5448931557376


Relevant dmesg lines for the removal:
[    2.780304] sd 2:0:0:0: Attached scsi generic sg0 type 0
[    2.780433] sd 2:0:0:0: [sda] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    2.780508] sd 2:0:0:0: [sda] 4096-byte physical blocks
[    2.780595] sd 2:0:0:0: [sda] Write Protect is off
[    2.780650] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.780698] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.791335]  sda:
[    2.792007] sd 2:0:0:0: [sda] Attached SCSI disk
[    3.585553] sd 5:0:0:0: Attached scsi generic sg1 type 0
[    3.586091] sd 5:0:1:0: Attached scsi generic sg2 type 0
[    3.586598] sd 5:0:2:0: Attached scsi generic sg3 type 0
[    3.587345] sd 5:0:3:0: Attached scsi generic sg4 type 0
[    3.588572] sd 5:0:2:0: [sdd] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[    3.588642] sd 5:0:2:0: [sdd] 4096-byte physical blocks
[    3.589282] sd 5:0:3:0: [sde] 7814035055 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    3.589349] sd 5:0:3:0: [sde] 4096-byte physical blocks
[    3.591269] sd 5:0:0:0: [sdb] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[    3.591794] sd 5:0:1:0: [sdc] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[    3.592081] sd 5:0:2:0: [sdd] Write Protect is off
[    3.592136] sd 5:0:2:0: [sdd] Mode Sense: 7f 00 10 08
[    3.592939] sd 5:0:2:0: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    3.593217] sd 5:0:3:0: [sde] Write Protect is off
[    3.593274] sd 5:0:3:0: [sde] Mode Sense: 7f 00 10 08
[    3.594144] sd 5:0:3:0: [sde] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    3.603890] sd 5:0:1:0: [sdc] Write Protect is off
[    3.603947] sd 5:0:1:0: [sdc] Mode Sense: 7f 00 10 08
[    3.606233] sd 5:0:1:0: [sdc] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    3.610693] sd 5:0:0:0: [sdb] Write Protect is off
[    3.610751] sd 5:0:0:0: [sdb] Mode Sense: 7f 00 10 08
[    3.613028] sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    3.622881]  sde:
[    3.630991] sd 5:0:3:0: [sde] Attached SCSI disk
[    3.639546]  sdd:
[    3.646910] sd 5:0:2:0: [sdd] Attached SCSI disk
[    3.653398]  sdc:
[    3.660196]  sdb:
[    3.708399] sd 5:0:1:0: [sdc] Attached SCSI disk
[    3.715218] sd 5:0:0:0: [sdb] Attached SCSI disk
[    5.908498] Btrfs loaded, crc32c=crc32c-generic
[    6.100531] BTRFS: device label Susanita devid 3 transid 4241667 /dev/sdb scanned by btrfs (333)
[    6.100838] BTRFS: device label Susanita devid 6 transid 4241667 /dev/sdc scanned by btrfs (333)
[    6.101405] BTRFS: device label Susanita devid 2 transid 4241667 /dev/sde scanned by btrfs (333)
[    6.101622] BTRFS: device label Susanita devid 5 transid 4241667 /dev/sdd scanned by btrfs (333)
[    6.101931] BTRFS: device label Susanita devid 1 transid 4241667 /dev/sda scanned by btrfs (333)
[    6.118215] process '/bin/fstype' started with executable stack
[    6.176610] BTRFS info (device sda): disk space caching is enabled
[    6.176689] BTRFS info (device sda): has skinny extents
[    6.850895] BTRFS info (device sda): bdev /dev/sdd errs: wr 0, rd 24, flush 0, corrupt 0, gen 0
[   40.273679] BTRFS info (device sda): enabling auto defrag
[   40.273756] BTRFS info (device sda): use lzo compression, level 0
[   40.273824] BTRFS info (device sda): disk space caching is enabled
[ 2192.336693] BTRFS info (device sda): relocating block group 10593404846080 flags metadata|raid10
[ 2239.450909] BTRFS error (device sda): bad tree block start, want 10919566688256 have 10597444141056
[ 2239.481337] BTRFS error (device sda): bad tree block start, want 10919566688256 have 17196831625821864417
[ 2239.481382] BTRFS: error (device sda) in btrfs_run_delayed_refs:2173: errno=-5 IO failure
[ 2239.481388] BTRFS info (device sda): forced readonly
[ 2239.481839] BTRFS error (device sda): bad tree block start, want 10919566688256 have 10597444141056
[ 2239.483125] BTRFS error (device sda): bad tree block start, want 10919566688256 have 17196831625821864417
[ 2239.483166] BTRFS: error (device sda) in btrfs_run_delayed_refs:2173: errno=-5 IO failure


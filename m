Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BAA6C4A0B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 13:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCVMOD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 22 Mar 2023 08:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCVMOC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 08:14:02 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AA236478
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 05:14:00 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id o12so71957764edb.9
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 05:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679487238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lR+d3atE+xifp3eAD9FIBGR4t7oyrYAg2AXynjSFVq4=;
        b=t6ynvFHPSijkjX2hs3J09aWbOZi9Hy6js2SBXaru1qGPuayYBn7HjH7qRF3FUhGp4X
         HJt7CoZnnDwB825WfWXCWtMswzLHkxIcegmZAQo93tBBuenHLeoqRjBBQx/JB4x7dhX2
         0xQ/tyKeEeUO4P7fgiNb3DLY/0nCnLjzYRQSCBl8UzjMpYPIbk4Q3ZruOvNcXDWFw/Ec
         h3oXtPw4ConfYuPiB8KEq6ihUmdZgBEMEVNqxA2tSrArFoCgj/KPHzpy7xhXB+HC22ZZ
         UkMX9r/bPL8Yj8Szqt0sJ28C7Gp6T5EI4OSSGG45KZcm+QCxMEQ34OusSqZWoR42aKqw
         EQDg==
X-Gm-Message-State: AO0yUKXY5hNPJebA1eeI48alSrNXIRtK6F8pEmrrx1/5RCJdLjRt1+wa
        CeF1/DldPbp6TjrpE4B/K/OjHmzgixDnaQ==
X-Google-Smtp-Source: AK7set83xgzn1nlD8IUDr9Dmjjm7XaL8A5lY7VOj5NCYVwmEO+2I1rHAb/78hFoOtNeI5f014IVVtQ==
X-Received: by 2002:a17:906:ce5c:b0:932:b790:932c with SMTP id se28-20020a170906ce5c00b00932b790932cmr6561415ejb.44.1679487238229;
        Wed, 22 Mar 2023 05:13:58 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id n15-20020a170906118f00b0092421bf4927sm7229479eja.95.2023.03.22.05.13.58
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 05:13:58 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id y4so72061159edo.2
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 05:13:58 -0700 (PDT)
X-Received: by 2002:a17:907:a04b:b0:930:f45a:51ce with SMTP id
 gz11-20020a170907a04b00b00930f45a51cemr2983224ejc.9.1679487237888; Wed, 22
 Mar 2023 05:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1679480445.git.wqu@suse.com>
In-Reply-To: <cover.1679480445.git.wqu@suse.com>
From:   Neal Gompa <neal@gompa.dev>
Date:   Wed, 22 Mar 2023 08:13:21 -0400
X-Gmail-Original-Message-ID: <CAEg-Je--pMSdMCM7RbMVh1njMAwpaV9LUbAmFOTmimHKFnfKmQ@mail.gmail.com>
Message-ID: <CAEg-Je--pMSdMCM7RbMVh1njMAwpaV9LUbAmFOTmimHKFnfKmQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] btrfs-progs: convert: follow default v2 cache setting
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 22, 2023 at 6:29 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Although btrfs-convert has followed the new default setting in v5.15
> release, it doesn't work.
>
> The problem is the convert workflow itself (making an temporary btrfs
> first, then sync the inodes) doesn't really create the free space tree
> nor the needed super block flags.
>
> And during the inodes sync phase, we generate v1 cache, causing the
> result btrfs to be v1 cache populated, and cause test case failure for
> subpage testing.
>
>
> This patchset would fix the converted btrfs at the final stage, by
> clearing the existing v1 cache first, then create and populate a valid
> free space tree, with needed super block flags.
>
>
> There seems to be a behavior change in mkfs.ext4 (e2fsprogs 1.47),
> that would create an orphan inode (with fixed ino number 12), and
> btrfs-convert would follow the ext4 to create an orphan in btrfs too,
> causing btrfs check to complain.
>
> So for now, I can not do convert testing due to the newly updated
> e2fsprogs...
>
> Qu Wenruo (2):
>   btrfs-progs: make check/clear-cache.c to be separate from check/main.c
>   btrfs-progs: convert: follow the default free space tree setting
>
>  Makefile            |  2 +-
>  check/clear-cache.c | 84 ++++++++++++++++++++++++---------------------
>  check/clear-cache.h |  8 +++--
>  check/main.c        |  6 ++--
>  convert/main.c      | 23 +++++++++++++
>  5 files changed, 76 insertions(+), 47 deletions(-)
>
> --
> 2.39.2
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>




--
真実はいつも一つ！/ Always, there's only one truth!

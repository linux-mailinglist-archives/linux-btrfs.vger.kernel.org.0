Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B960789AC5
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Aug 2023 03:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjH0BNI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Aug 2023 21:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjH0BNA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Aug 2023 21:13:00 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D2B139
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Aug 2023 18:12:57 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76f0807acb6so31631485a.1
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Aug 2023 18:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693098776; x=1693703576;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jOfkvEfm91SlWkcTpSW50uvMZk5w7pS9ni7I0Vq0k0E=;
        b=Y5HrwhbcgTJQGuuV46qkrMljuBe25hTVN0qn+zliQObX+lch8UcjGJBAsfEaQ0lZYS
         KYPJapOdyJEnxNXDnCrv6juOXWQg415WS7sgkKkq5ElbR8AIxXF7KGs7rsziQoTv7Ban
         3O4K7PU4YgiENUq+d8yNOob/081phBASJ8KinMZ+s5U6urczyQOsRANq2wlRetWgC2YZ
         rB51vxsLmgjEnJIDvWKkb5xpP7VVcmckTMSIGqYNc3ddt6228WOxsILOgFB3CBM77JSX
         Z9fvgP9XBrjH1/O0j3YFpbSbBmrP1CUkxHFrhx5e1iKVs6WhvSq/GeoykubGZakoHsbz
         LrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693098776; x=1693703576;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jOfkvEfm91SlWkcTpSW50uvMZk5w7pS9ni7I0Vq0k0E=;
        b=dyEUUaOK+pX+2Hua8HKBKoQwyAtJlGPlo76vTCh9nfmgZ3iRVrT/zS/UcGZ+gif4R7
         /uilR0fqaEXp1QlMDDpihF0B2OD/WaZrDOmsoxLLHj0ADSUdMnELrX3xmNUoyrq+hHuS
         f85RQrEpeOWjFAIXlyZn+l+ufumuxnZBa0Y9d+LRlQPvhJYB9G5Rz/bWK3ajUOd5bMWV
         8bVmMruI5D79TMEMS703pasm4yASFuyLjaeXOjt26grcUqLFNZTPL9EzvPJbYuSuByiB
         r7HjlwKi+54Ogi/EBPnp5JcZEv4OzhQahuttpJd7QxZ/INglyXDBh8HLzYQUlTxSBnwb
         CTiQ==
X-Gm-Message-State: AOJu0YwxDI9ujlVRhneD31KYGgKWHNP19B0YYyYQCczvpkBBhvzM0eZl
        q/YHaFJRhk3Zi8LezV+c8WE=
X-Google-Smtp-Source: AGHT+IE6EsZswpQLWqLBeVDFRQIdCid2tE2sDIWXVJBHn+XC6ilrl1dEraAp6twnJd/FrxN1npzP5g==
X-Received: by 2002:a05:620a:2224:b0:76c:baf3:ba73 with SMTP id n4-20020a05620a222400b0076cbaf3ba73mr21060556qkh.78.1693098776326;
        Sat, 26 Aug 2023 18:12:56 -0700 (PDT)
Received: from ?IPv6:2603:7081:3406:8f26:cc85:48e1:2259:9b56? (2603-7081-3406-8f26-cc85-48e1-2259-9b56.res6.spectrum.com. [2603:7081:3406:8f26:cc85:48e1:2259:9b56])
        by smtp.gmail.com with ESMTPSA id d22-20020a05620a137600b0076eee688a95sm1472179qkl.0.2023.08.26.18.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 18:12:55 -0700 (PDT)
Message-ID: <7536ccd3d1c3ccc349aa5f0f5e587c21cb773a46.camel@gmail.com>
Subject: Re: btrfs check: root errors 400, nbytes wrong
From:   Cebtenzzre <cebtenzzre@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Date:   Sat, 26 Aug 2023 21:12:52 -0400
In-Reply-To: <04b21f25-a80e-4e1b-a70a-3401ca3c2af2@gmx.com>
References: <4a18c53b36e312b3de3296145984ed74323494ff.camel@gmail.com>
         <04b21f25-a80e-4e1b-a70a-3401ca3c2af2@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 2023-08-24 at 13:40 +0800, Qu Wenruo wrote:
> But it's mostly fine, a btrfs check --repair should be safe if and
> only if those are the only errors.

I ran btrfs check --repair, and it gave me a warning:

Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p2
UUID: 76721faa-8c32-4e70-8a9e-859dece0aec1
[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
No device size related problem found
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
reset nbytes for ino 123827824 root 258
reset nbytes for ino 123827824 root 15685
reset nbytes for ino 123827824 root 15760
reset nbytes for ino 123827824 root 15786
reset nbytes for ino 123827824 root 15814
reset nbytes for ino 123827824 root 15822
reset nbytes for ino 123827824 root 15826
reset nbytes for ino 123827824 root 15830
reset nbytes for ino 123827824 root 15834
reset nbytes for ino 123827824 root 15838
reset nbytes for ino 123827824 root 15842
warning line 3916
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 2405445431302 bytes used, no error found
total csum bytes: 1891078208
total tree bytes: 13012697088
total fs tree bytes: 9898934272
total extent tree bytes: 836861952
btree space waste bytes: 2043135264
file data blocks allocated: 25854472876032
 referenced 2618226024448

This is btrfs-progs v6.3.3. It looks like that would be line 3916 of
check/main.c:

if (!cache_tree_empty(&wc.shared))
	fprintf(stderr, "warning line %d\n", __LINE__);

Is this anything I should be concerned about?

Thanks,
Cebtenzzre
>=20

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737AC60FA6F
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 16:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbiJ0Oci convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 27 Oct 2022 10:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiJ0Och (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 10:32:37 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D695D25A0
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 07:32:36 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id AF3E35BD690; Thu, 27 Oct 2022 10:32:33 -0400 (EDT)
Date:   Thu, 27 Oct 2022 10:32:25 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nemcev Aleksey <Nemcev_Aleksey@inbox.ru>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: compsize reports that filesystem uses zlib compression, while I
 set zstd compression everywhere
Message-ID: <Y1qWeXnMsWh5yYDs@hungrycats.org>
References: <3c352b84-c52a-9e01-1ace-6e984e167753@inbox.ru>
 <eee8a8e1-8e54-4170-af44-a94c524c37ad@app.fastmail.com>
 <fa62c9cb-0fe9-b838-3f69-477dc61dbd45@inbox.ru>
 <Y1nY2FJGYS+iWMcS@hungrycats.org>
 <0f6f1ecb-84d4-4fac-9fcc-5932d5b4f73d@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <0f6f1ecb-84d4-4fac-9fcc-5932d5b4f73d@app.fastmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 27, 2022 at 09:21:53AM -0400, Chris Murphy wrote:
> 
> 
> On Wed, Oct 26, 2022, at 9:03 PM, Zygo Blaxell wrote:
> 
> >> And also it's not possible to specify compression level in defragment - so,
> >> I'll change the level in subvolume properties, defragment with -czstd, and
> >> change the level back.
> >
> > It's not possible to set the level in subvol properties either.  Only the
> > compress= mount option can set the level.
> 
> $ sudo btrfs property set test compression zstd:1
> $ sudo btrfs property get test
> compression=zstd:1
> $ sudo btrfs property set test compression zstd:f
> $ sudo btrfs property get test
> compression=zstd:f
> 
> It's allowing the arbitrary setting of compression values. This is with
> btrfs-progs 6.0. Progs is being too permissive, it shouldn't silently
> set invalid values. But then even with valid values, I'm pretty sure
> right now the kernel ignores the compression properties.

Correct.  You can put whatever you want in the string, but the kernel
only ever looks at fs_info for compress_level, which is set from the
mount options.

e.g. if you mount with 'compress=zlib:5' and you have a file with
btrfs.compression property with 'zstd:7', what you get is zstd compression
with level 5.


> -- 
> Chris Murphy
> 

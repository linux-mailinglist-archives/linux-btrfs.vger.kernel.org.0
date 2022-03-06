Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7356F4CE827
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 02:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiCFBlX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Mar 2022 20:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiCFBlX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Mar 2022 20:41:23 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 995F3F06
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Mar 2022 17:40:32 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 37636235FA6; Sat,  5 Mar 2022 20:40:32 -0500 (EST)
Date:   Sat, 5 Mar 2022 20:40:32 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: status page status - dedupe
Message-ID: <YiQRED8tzbWZPnbH@hungrycats.org>
References: <c16169c5b971fe5dee1e50e07e2c7bb8d2bface4.camel@scientia.org>
 <YiP5l4Rq9AOuiIKt@hungrycats.org>
 <3d8e6c6a2bd08164835b6aa3bf6d4d1d9ed9e5df.camel@scientia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d8e6c6a2bd08164835b6aa3bf6d4d1d9ed9e5df.camel@scientia.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 06, 2022 at 02:38:48AM +0100, Christoph Anton Mitterer wrote:
> Thanks for that elaborate description (and thanks to Qu, too).
> 
> I think that might be be a good addition to
> https://btrfs.wiki.kernel.org/index.php/Deduplication
> 
> 
> Also:
> 
> On Sat, 2022-03-05 at 19:00 -0500, Zygo Blaxell wrote:
> > jdupes can use the safe dedupe ioctl (-B) or very unsafe hardlinks (-
> > H).
> 
> I guess you mean -L ?!

Uhhh, yes.  I don't use either option myself.  ;)

> Thanks,
> Chris.

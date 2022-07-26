Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E126D581BB7
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 23:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbiGZVkY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 17:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGZVkW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 17:40:22 -0400
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F4A624E
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 14:40:19 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id DA56A5BD;
        Tue, 26 Jul 2022 21:40:16 +0000 (UTC)
Date:   Wed, 27 Jul 2022 02:40:15 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Rich Rauenzahn <rrauenza@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Combining two filesystems into single pool
Message-ID: <20220727024015.3e87bb13@nvm>
In-Reply-To: <CAG+QAKUu6TXJqoq=eQczE+CWJCL06bN8oymbSFQVCzXto+fzyQ@mail.gmail.com>
References: <CAG+QAKUu6TXJqoq=eQczE+CWJCL06bN8oymbSFQVCzXto+fzyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 26 Jul 2022 13:32:22 -0700
Rich Rauenzahn <rrauenza@gmail.com> wrote:

> Could I, say, move /A to a subvolume A in itself and then permanently
> "connect" /B as a subvolume B, putting all the disks into a single
> pool?  And then mount the two subvolumes as /A and /B?
> 
> I'd swear I'd seen instructions on how to combine filesystem pools
> before, but I can't find it again.

Check out MergerFS.

Although that adds a FUSE layer on top of both filesystems, which might be
fine for a home media library, but maybe not for some other uses.

-- 
With respect,
Roman

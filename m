Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745FD637F6E
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Nov 2022 20:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiKXTOS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Nov 2022 14:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiKXTOQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Nov 2022 14:14:16 -0500
Received: from manchmal.in-ulm.de (manchmal.in-ulm.de [217.10.9.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBC281581
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Nov 2022 11:14:15 -0800 (PST)
Date:   Thu, 24 Nov 2022 20:14:12 +0100
From:   Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Endless "reclaiming chunk"/"relocating block group"
Message-ID: <1669317166@msgid.manchmal.in-ulm.de>
References: <1666204197@msgid.manchmal.in-ulm.de>
 <Y1Crh/Cz2rcbIayw@hungrycats.org>
 <1666262200@msgid.manchmal.in-ulm.de>
 <Y1FSxogPeNIUfyVn@hungrycats.org>
 <1669313605@msgid.manchmal.in-ulm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669313605@msgid.manchmal.in-ulm.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Stupid typo ...


Christoph Biedl wrote...

> *However*, some additional debug-print statements revealed the generated
> code enters the block that calls btrfs_mark_bg_to_reclaim /even/ /if/
> alloc is
           true,
>                 and reclaim undefined (usually true).

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE0A60BE19
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 01:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiJXXC7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 19:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiJXXCf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 19:02:35 -0400
Received: from len.romanrm.net (len.romanrm.net [IPv6:2001:41d0:1:8b3b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22E0A8786
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 14:23:50 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by len.romanrm.net (Postfix) with SMTP id 689724007E;
        Mon, 24 Oct 2022 21:23:44 +0000 (UTC)
Date:   Tue, 25 Oct 2022 02:23:43 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: WARN_ON in __writeback_inodes_sb_nr when btrfs mounted with
 flushoncommit
Message-ID: <20221025022343.4d979cb3@nvm>
In-Reply-To: <20221024141629.GD5824@twin.jikos.cz>
References: <20221024041713.76aeff42@nvm>
        <20221024123746.7a9d9bfd@nvm>
        <20221024141629.GD5824@twin.jikos.cz>
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

On Mon, 24 Oct 2022 16:16:29 +0200
David Sterba <dsterba@suse.cz> wrote:

> > But not backported to stable series, why not? Seems to be a small and simple
> > fix.
> 
> 5.10 may still be a reasonable target for backport. It does not apply
> cleanly and the 5.10 version tries to do some flushing of subvolume
> trees, which was removed later on, there may be some dependencies too.

Sorry I meant the longterm series. The issue was reported starting with
4.15-rc1, so of these also 4.19 and 5.4 will be affected. Sure, those may or
may not be as important or feasible for a backport, but at least 5.10
hopefully is, as it is the current long-longterm supported until 2026 per the
Releases page on kernel.org, 3 years further than 5.15.

-- 
With respect,
Roman

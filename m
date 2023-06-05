Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D484722D0F
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 18:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjFEQzI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 12:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbjFEQzG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 12:55:06 -0400
X-Greylist: delayed 477 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Jun 2023 09:55:04 PDT
Received: from len.romanrm.net (len.romanrm.net [91.121.86.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79628EE
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 09:55:04 -0700 (PDT)
Received: from nvm (nvm.home.romanrm.net [IPv6:fd39::101])
        by len.romanrm.net (Postfix) with SMTP id E716940176;
        Mon,  5 Jun 2023 16:47:04 +0000 (UTC)
Date:   Mon, 5 Jun 2023 21:47:04 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: How to find/reclaim missing space in volume
Message-ID: <20230605214704.35cf752e@nvm>
In-Reply-To: <20230605162636.GE105809@merlins.org>
References: <20230605162636.GE105809@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_20,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 5 Jun 2023 09:26:36 -0700
Marc MERLIN <marc@merlins.org> wrote:

> I'm confused, the volumes above are snapshots with mostly the same data
> (made within the last 2 hours) and I didn't delete any data in the FS
> (they are mostly identical and used for btfrs send/receive)
> 
> Why do they add up ot 600GB, but btrfs says 847FB is used?

- deleted snapshots that are still in the process of deletion

- deleted files that are still open by running apps

- files in subvolumes other than the currently mounted one (assuming mounting
  a non-root subvolume)

- a huge amount of no longer used metadata chunks (does not apply here,
  considering the fi df output)

- the infamous extent booking peculiarity of Btrfs, assuming you have large
  files that are partially rewritten in-place (such as VM images or databases)

-- 
With respect,
Roman

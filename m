Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FA65F8B00
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Oct 2022 13:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiJILwF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Oct 2022 07:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJILwE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Oct 2022 07:52:04 -0400
X-Greylist: delayed 589 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Oct 2022 04:52:02 PDT
Received: from len.romanrm.net (len.romanrm.net [IPv6:2001:41d0:1:8b3b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD302C10B
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Oct 2022 04:52:01 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by len.romanrm.net (Postfix) with SMTP id 96AC640118;
        Sun,  9 Oct 2022 11:42:06 +0000 (UTC)
Date:   Sun, 9 Oct 2022 16:42:06 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Ochi <ochi@arcor.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: RAID5 on SSDs - looking for advice
Message-ID: <20221009164206.39de4305@nvm>
In-Reply-To: <a502eed4-b164-278a-2e80-b72013bcfc4f@arcor.de>
References: <a502eed4-b164-278a-2e80-b72013bcfc4f@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_40,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, 9 Oct 2022 12:34:57 +0200
Ochi <ochi@arcor.de> wrote:

> 3. Are there any other known issues that come to mind regarding this 
> particular setup, or do you have any other advice?

Keep in mind that Btrfs RAID5/6 are not currently recommended for use:
https://btrfs.readthedocs.io/en/latest/btrfs-man5.html#raid56-status-and-recommended-practices

If the NAS is backed up anyway, I suggest going with directory-level merge of
filesystems, such as MergerFS. If one SSD fails, you will need to restore only
the files which happened to be on that one, not redo the entire thing, as
would be the case with RAID0, Btrfs single profile, or LVM-based large block
device across all three.

Another alternative is mdadm RAID5 with Btrfs on top. But it feels like that
also has its own corner cases when it comes to sudden power losses, which may
result in the "parent transid failed" condition from Btrfs-side (not sure if
the recent PPL in mdadm fixes that).

-- 
With respect,
Roman

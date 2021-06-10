Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908D43A2E42
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 16:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhFJOei (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 10:34:38 -0400
Received: from a4-3.smtp-out.eu-west-1.amazonses.com ([54.240.4.3]:52191 "EHLO
        a4-3.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230329AbhFJOeh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 10:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=vbsgq4olmwpaxkmtpgfbbmccllr2wq3g; d=urbackup.org; t=1623335560;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=GpZzeSNS1nwz1Y3AGLYVZl8D+7EplTqyxpzNsWj4VAs=;
        b=mfgPGy9dQoIMkmdhK7Djh2QlBmqPaf8elC114VAmFoPBEGHy0WVzPPaI6v9TR3hI
        sJn9Fbjv4w+rwtG/X9djnc/DN4oTy7lNFRJkHmx8iPxdC7n4JNcZHm2g6B1I1/ghEFj
        F4OMHutNN4Cd3L+eVDlp0XNz0sT0Ahz3wxyJHtVU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1623335560;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=GpZzeSNS1nwz1Y3AGLYVZl8D+7EplTqyxpzNsWj4VAs=;
        b=CbIAvorv+dSlk4j0/yrUpitXgeuONEEuegVjii9zfmLUnHFDuOujdY42uEv1Zlm4
        p40DGqqlrpbH4SnOSpHjTdlGm0lUlDF6XXqGs2Dni8vSqX9bCIjZ14Wnmff8HPn3YuN
        yVpIP3p5bbBZW/gqnhh3LSkkQKxwSTcZreCepa1E=
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Martin Raiber <martin@urbackup.org>
Subject: Combining nodatasum + compression
Message-ID: <01020179f656e348-b07c8001-7b74-432a-b215-ccc7b17fbfdf-000000@eu-west-1.amazonses.com>
Date:   Thu, 10 Jun 2021 14:32:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2021.06.10-54.240.4.3
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

when btrfs is running on a block device that improves integrity (e.g. 
Ceph), it's usefull to run it with nodatasum to reduce the amount of 
metadata and random IO.

In that case it would also be useful to be able to run it with 
compression combined with nodatasum as well.

I actually found that if nodatasum is specified after compress-force, 
that it doesn't remove reset the compress/nodatasum bit, while the other 
way around it doesn't work.

That combined with

--- linux-5.10.39/fs/btrfs/inode.c.orig 2021-05-31 16:11:03.537017580 +0200
+++ linux-5.10.39/fs/btrfs/inode.c      2021-05-31 16:11:19.461591523 +0200
@@ -408,8 +408,7 @@
   */
  static inline bool inode_can_compress(struct btrfs_inode *inode)
  {
-       if (inode->flags & BTRFS_INODE_NODATACOW ||
-           inode->flags & BTRFS_INODE_NODATASUM)
+       if (inode->flags & BTRFS_INODE_NODATACOW)
                 return false;
         return true;
  }

should do the trick.

The above code was added with the argument that having no checksums with 
compression would damage too much data in case of corruption ( 
https://lore.kernel.org/linux-btrfs/20180515073622.18732-2-wqu@suse.com/ 
). This argument doesn't apply much to single device file systems and 
even less to file systems on Ceph like volumes.


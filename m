Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85C36C50D4
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 17:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCVQda (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 12:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCVQd3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 12:33:29 -0400
X-Greylist: delayed 591 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Mar 2023 09:33:23 PDT
Received: from mail.virtall.com (mail.virtall.com [46.4.129.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A584213DCB
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 09:33:23 -0700 (PDT)
Received: from mail.virtall.com (localhost [127.0.0.1])
        by mail.virtall.com (Postfix) with ESMTP id B45AD1221A444
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 16:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtall.com;
        s=default; t=1679502207;
        bh=X2/52noJrJI2pwCiFM/wv3dFniqSwjw9ZwFYKw7JNHI=;
        h=Date:From:To:Subject;
        b=iwYVnmhsV/jrhzhRmQQ5Eirp5vknsAZHtkErUGEwpjDqEHJygOhPN4JWDs0HrP16l
         +kTHHCclm+khqitwc/627KOMt0Lbu32xxx+ebbl7SiopQrpC5px2A0CUONKWLicKRt
         qLmccTO8fXfU5SsvSQzvGWXb8DIh4TatnMiS/Q8JKEOVqmMnICM0Eid8XB1jG+xCT2
         0X8vPKV/EBlnejdaV3E2LlmgqIU7Ecmmzg4ajxMIvDNh+ypWwowN+kkVQyhIfHdP+Q
         AwymkhP441epFl8LKK6x6z5xEeA6tDGfM+CBQA1CM/LiDUdl/F9+oKu+R4KXHyZDwT
         8j9sYtjU9N0pQ==
X-Fuglu-Suspect: 97467915ab694a278667cd13403edc35
X-Fuglu-Spamstatus: NO
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,PDS_BTC_ID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
        by mail.virtall.com (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 16:23:26 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 22 Mar 2023 17:23:24 +0100
From:   Tomasz Chmielewski <tch@virtall.com>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: btrfs import/export: ERROR: failed to clone extents to ... Invalid
 argument
Message-ID: <c2b83c549943cf6f6173916e4bdb4de7@virtall.com>
X-Sender: tch@virtall.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm unable to export/import from one system to another.

It fails on one volume, usually with an error like:

ERROR: failed to clone extents to 
rootfs/var/log/journal/381f93e4c7d74d4292a3c997191b9a6f/system.journal: 
Invalid argument


If I try again, it might fail in a different location with a different 
error (like, no such file or directory).

Kernels:

- source: 5.15, tried upgrading to 6.2.7, didn't help
- destination: tried two different destinations (different 
servers/filesystems), running kernels 6.1.13 and 6.2.7


Not sure what to provide to debug this further.


Tomasz Chmielewski

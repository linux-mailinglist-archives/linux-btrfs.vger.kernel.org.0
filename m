Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4C21B3E6B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 12:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbgDVK16 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 06:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730966AbgDVK15 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 06:27:57 -0400
X-Greylist: delayed 1752 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Apr 2020 03:27:57 PDT
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C14C03C1A8
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 03:27:57 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jRC9S-0004dr-O5; Wed, 22 Apr 2020 11:58:42 +0200
To:     linux-btrfs@vger.kernel.org
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Subject: RAID 1 | Newbie Question
Message-ID: <be4ee7ea-f032-ee63-2486-030b2f270baa@peter-speer.de>
Date:   Wed, 22 Apr 2020 11:58:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1587551277;97b0a1e9;
X-HE-SMSGID: 1jRC9S-0004dr-O5
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi.
I might be a first time user with btrfs for a new system I will set up.

Just want to make sure: As I read the docs, the note about RAID 1 and 
that there will be no redundant data is true only, if the RAID, which is 
possible, is set up to use only 1 physical device, right?

If RAID 1 using btrfs is defined to use two seperate disk, say /dev/sda2 
and /dev/sdb2, I will have the same redundancy like using md. Is this 
correct?

Thanks,
Steffi

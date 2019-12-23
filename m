Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147431296AA
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2019 14:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfLWNwE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Dec 2019 08:52:04 -0500
Received: from ns211617.ip-188-165-215.eu ([188.165.215.42]:41504 "EHLO
        mx.speed47.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726676AbfLWNwE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Dec 2019 08:52:04 -0500
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Dec 2019 08:52:03 EST
Received: from [10.61.87.69] (unknown [92.184.98.27])
        by box.speed47.net (Postfix) with ESMTPSA id 34B5AF3C
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Dec 2019 14:44:09 +0100 (CET)
Authentication-Results: box.speed47.net; dmarc=fail (p=none dis=none) header.from=lesimple.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lesimple.fr;
        s=mail01; t=1577108649;
        bh=JaEwpKd5UaflQRACXfkYqFHukD8MqTgW4RxaXIX6Xxs=;
        h=From:To:Date:Subject;
        b=4AAsexldPJTqam5IGUYehmELzSJUwbnKtWjRuhqAhsJyoifOLCr7EktULVr5QB3fk
         M7dTD3jaVvf10uHmGjCGwV3DYSCjK3JiCqd6lf0vOtEoO3mTQY9BRW4Bp8PLTs393Y
         bexoDy9J3pBJl8zoauGx3BMXQ7Uw20jaJnenkabE=
From:   =?UTF-8?B?U3TDqXBoYW5lIExlc2ltcGxl?= <stephane_btrfs@lesimple.fr>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date:   Mon, 23 Dec 2019 14:44:07 +0100
Message-ID: <16f33002870.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
User-Agent: AquaMail/1.22.0-1511 (build: 102200004)
Subject: Metadata chunks on ssd?
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello btrfs gurus,

Has this ever been considered to implement a feature so that metadata 
chunks would always be allocated on a given set of disks part of the btrfs 
filesystem?

As metadata use can be intensive and some operations are known to be slow 
(such as backref walking), I'm under the (maybe wrong) impression that 
having a set of small ssd's just for the metadata would give quite a boost 
to a filesystem. Maybe even make qgroups more usable with volumes having 10 
snapshots?

This could just be a preference set on the allocator, so that a 6 disks 
raid1 FS with 4 spinning disks and 2 ssds prefer to allocate metadata on 
the ssd than on the slow drives (and falling back to spinning disks if ssds 
are full, with the possibility to rebalance later).

Would such a feature make sense?

-- 
Stephane.



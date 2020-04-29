Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58401BE641
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Apr 2020 20:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgD2Saj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Apr 2020 14:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2Sai (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Apr 2020 14:30:38 -0400
Received: from wp558.webpack.hosteurope.de (wp558.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8250::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804AEC03C1AE
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Apr 2020 11:30:38 -0700 (PDT)
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1jTrTf-0004nV-8R; Wed, 29 Apr 2020 20:30:35 +0200
To:     linux-btrfs@vger.kernel.org
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Subject: nodatacow questions
Message-ID: <f2e0ca56-c059-978a-2d47-73204b22945b@peter-speer.de>
Date:   Wed, 29 Apr 2020 20:30:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1588185038;c7857661;
X-HE-SMSGID: 1jTrTf-0004nV-8R
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi.
 From the chattr man page:
A file with the 'C' attribute set will not be subject to copy-on-write 
updates. This flag is only supported on file systems which perform 
copy-on-write. (Note: For btrfs, the 'C' flag should be set on new or 
empty files. If it is set on a file which already has data blocks, it is 
undefined when the blocks assigned to the file will be fully stable. If 
the 'C' flag is set on a directory, it will have no effect on the 
directory, but new files created in that directory will have the No_COW 
attribute set.)

Question 1)
If /var/lib/mysql is a own subvolume and chattr +C /var/lib/mysql is set 
and mysql is configured to use one directory for every database, will 
nodatacow apply for a new dir which is created when a new db is created? 
Just asking, because the last sentence of the man above which states 
"...new files created in that directory...". Is a dir a file in the 
context of chattr?

Question 2)
I guess CoW will still happen, if I hold a snapshot of the subvolume 
which will be mounted to /var/lib/mysql. Is this correct?

Question 3)
How to solve this and avoid defragmentation if my assumption in 2) is 
correct?

Thanks,
Steffi

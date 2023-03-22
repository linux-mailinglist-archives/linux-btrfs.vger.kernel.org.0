Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EC36C54AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 20:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCVTO6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 15:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCVTOz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 15:14:55 -0400
X-Greylist: delayed 91 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Mar 2023 12:14:54 PDT
Received: from p-impout004.msg.pkvw.co.charter.net (p-impout004aa.msg.pkvw.co.charter.net [47.43.26.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C44443936
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 12:14:54 -0700 (PDT)
Received: from static.bllue.org ([66.108.6.151])
        by cmsmtp with ESMTP
        id f3tipZLUJjSbrf3tipKo7J; Wed, 22 Mar 2023 19:13:23 +0000
X-Authority-Analysis: v=2.4 cv=B6qqbchM c=1 sm=1 tr=0 ts=641b5353
 a=M990Q3uoC/f4+l9HizUSNg==:117 a=M990Q3uoC/f4+l9HizUSNg==:17
 a=kj9zAlcOel0A:10 a=k__wU0fu6RkA:10 a=_ypfwlbc8MY6Th3_rHkA:9 a=CjuIK1q_8ugA:10
Received: from localhost (localhost.localdomain [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by static.bllue.org (Postfix) with ESMTPS id D1214400070
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 15:13:20 -0400 (EDT)
Date:   Wed, 22 Mar 2023 15:13:20 -0400 (EDT)
From:   kenneth topp <toppk@bllue.org>
To:     linux-btrfs@vger.kernel.org
Subject: block group tree conversion
Message-ID: <e338e8df-b0f4-f25d-0bd7-650d37bd1664@bllue.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Status: No, score=0.4 required=5.0 tests=KHOP_HELO_FCRDNS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-CMAE-Envelope: MS4xfPW6R5Q6rkHFAuU3au1/yAJ2f45mPXqaHesOKPaC/qyJPMqStW+dnusfoCk8BxyL8o13L2RL8Cj4kFMQkyBQg5CK1yLUOzQB+NZ52ktOXjg31ScJHClJ
 32Dsl2ffTUwywsJrLdQLWeP2uPVLiWbeKzc9x+3bTwzQ/FXNT8eza/QG0/EJ9LtIgT0bEpNX5Ztrtw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


I'm reportting my success with converting to blockgroup tree so 
that others may benefit.

running 6.2.7-300.fc38.x86_64 kernel from fedora 38 (in beta), which
a self compiled version of btrfs-progs with --enable-experimental option.

The conversion took around 90 minutes, and the mount time went from around
250 seconds to 5 seconds.

The filesystem is around 600k inodes, 51TB used, and didn't use any 
features like snapshots or compression, and was created with '-O no-holes 
-d single -m raid1' options and is mounted with 
'defaults,noatime,space_cache=v2'.

I hope the experimental flag is dropped soon, so that others can see 
similar mount time improvements.  I can now remove the systemd settings 
override I needed to allow the system to successfully boot up 
(DefaultTimeoutStartSec).

Ken

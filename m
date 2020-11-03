Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2D32A3FDF
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 10:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgKCJVp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 04:21:45 -0500
Received: from smtp105.iad3a.emailsrvr.com ([173.203.187.105]:45020 "EHLO
        smtp105.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbgKCJVp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 04:21:45 -0500
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Nov 2020 04:21:45 EST
X-Auth-ID: a.isaev@rqc.ru
Received: by smtp14.relay.iad3a.emailsrvr.com (Authenticated sender: a.isaev-AT-rqc.ru) with ESMTPSA id D771A2392A
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 04:13:16 -0500 (EST)
From:   Alexey Isaev <a.isaev@rqc.ru>
To:     linux-btrfs@vger.kernel.org
Subject: Restore btrfs partition
Message-ID: <ddaef86e-3487-369d-5528-2e2f0e0e9ba4@rqc.ru>
Date:   Tue, 3 Nov 2020 12:13:15 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ru
X-Classification-ID: bbb5476c-593c-4aca-8055-68367483d28d-1-1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello!

I have accidentally overwritten partition table on hdd with btfs 
filesystem. Is it possible to restore it?
There was only one partition on disk with btrfs.

-- 
Best Regards,
Aleksey Isaev,
RQC


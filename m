Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F7B32B2A6
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Mar 2021 04:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343520AbhCCB6q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Mar 2021 20:58:46 -0500
Received: from mail.knebb.de ([188.68.42.176]:41178 "EHLO mail.knebb.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381972AbhCBVfV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Mar 2021 16:35:21 -0500
Received: by mail.knebb.de (Postfix, from userid 121)
        id 94BEFE38FE; Tue,  2 Mar 2021 22:34:40 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on netcup.knebb.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=1.7 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.2
Received: from [192.168.9.194] (p5de00be0.dip0.t-ipconnect.de [93.224.11.224])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: cvoelker)
        by mail.knebb.de (Postfix) with ESMTPSA id C938DE0C22
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Mar 2021 22:34:39 +0100 (CET)
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   =?UTF-8?Q?Christian_V=c3=b6lker?= <cvoelker@knebb.de>
Subject: Defragmentation vw. Deduplication
Message-ID: <11d7701c-4fd8-9bf1-c10e-755e55dd5e57@knebb.de>
Date:   Tue, 2 Mar 2021 22:31:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

might be a simple question but I did not find a trustable source for this.

BTRFS uses COW which might lead to fragmentation.
So using "btrfs fi defrag -r /mnt" will bring most file extend in a row 
and copy previously deduplicated extends.
Obviously this uses more disk space. This is not what I want, but I need 
to run "defrag" because I initially skipped the "compress=zstd" option 
when mounting. So many files are stored without compression. Therefor I 
neede to do the "defrag".

I am now unsure about the deduplication itself.  How does it work?
I create a file in a directory (ie on Monday). Some days later I create 
a file which has some extents with equal data. Does btrfs recon the 
equal extents and does it doe deduplication then? Or does it only do 
deduplication when ie "cp --reflink" is used?

However as I needed the compression and not the defragmentation is there 
any way to add compression and recreate deduplication later?

Sorry if this is a dumb question.

/KNEBB



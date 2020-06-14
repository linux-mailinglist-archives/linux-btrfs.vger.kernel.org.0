Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0481F88EC
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jun 2020 15:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgFNNWi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Jun 2020 09:22:38 -0400
Received: from mailrelay2-3.pub.mailoutpod1-cph3.one.com ([46.30.212.11]:57393
        "EHLO mailrelay2-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726925AbgFNNWh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Jun 2020 09:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:date:message-id:subject:
         from:to:from;
        bh=Y+U91OF3KQBXKXaqml13BFJilQ4+1dU03WIu2evPdak=;
        b=WcAZ7sVPyR0R54eKdm7Y2gnRjWcFks/wsy/dUK+gxYbzv211YEeAJ4OGaQnBhOS+mrghNrE9Fl59j
         ioPvDaUB9GylwJPpxoblLHiKEdJKbX9gVEEIWubHuhouBzI3maNGfC347aNDkJCT1eIu/zaUEBGg/k
         5LykAmnFMxWDOtUpkwNDWLVn8nXr5/uaZ3XinWcU0FLozM6QnvdnE+rHi6PbiFajQLxv4pf5UsOWGf
         7ieiWFpDcNeNnPMRJLIb1wjjFzRczkJtGDS5enyKs5XYuGnMEpvf6JPpWg3ClnKS4Py3XMr9AYqI3y
         j28AXXisDQQJwA9K5YTFnJjQig7+Hag==
X-HalOne-Cookie: d8bc95d91d426bd2c8d2ef17fb4ea087a4caccfa
X-HalOne-ID: 1c0fe08f-ae42-11ea-8885-d0431ea8a290
Received: from [192.168.0.10] (h-131-138.a357.priv.bahnhof.se [81.170.131.138])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 1c0fe08f-ae42-11ea-8885-d0431ea8a290;
        Sun, 14 Jun 2020 13:22:35 +0000 (UTC)
To:     linux-btrfs Mailinglist <linux-btrfs@vger.kernel.org>
From:   A L <mail@lechevalier.se>
Subject: Should "btrfs filesystem defrag -r" follow symlinks?
Message-ID: <852f6e36-6adc-0455-5c2b-0477b0c72270@lechevalier.se>
Date:   Sun, 14 Jun 2020 15:22:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It is not clear from the man page at 
https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs-filesystem if 
`btrfs filesystem defrag -r` should follow symbolic links or not. 
Perhaps the man-page should mention which behaviour is default.

I did some basic tests and it seems that on my setup it does not follow 
symlinks.
Perhaps improve defragment with an option to follow symlinks and/or 
subvolumes should be added?

Thanks!

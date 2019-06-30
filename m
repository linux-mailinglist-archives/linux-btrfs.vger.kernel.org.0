Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6CD35AFA7
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Jun 2019 12:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfF3Kh2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Jun 2019 06:37:28 -0400
Received: from forward100j.mail.yandex.net ([5.45.198.240]:41688 "EHLO
        forward100j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726531AbfF3Kh2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Jun 2019 06:37:28 -0400
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 Jun 2019 06:37:27 EDT
Received: from mxback3o.mail.yandex.net (mxback3o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1d])
        by forward100j.mail.yandex.net (Yandex) with ESMTP id 7BBD950E0E65
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Jun 2019 13:32:10 +0300 (MSK)
Received: from smtp1j.mail.yandex.net (smtp1j.mail.yandex.net [2a02:6b8:0:801::ab])
        by mxback3o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id HNtKMdIzbf-WA88lQAh;
        Sun, 30 Jun 2019 13:32:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1561890730;
        bh=A8QAWiHPNEQhZ4kRoM2uiA70Hy6ZiM6NLN+E4SeD3sY=;
        h=Subject:To:From:Date:Message-ID;
        b=Kz3o5ajMW0O2Una90pQD+TPtmgL9e6R+q1CTI/rjy3j2IHE3VdFXq6Geb5e9Hhyv6
         9HoBrK91qqkMKKSARdQaV56jqPBC2l+BxoyyxTrWzq4FraAxf0HVeJZ1Wxv1SP68Jt
         CK9l+H/6PmfcnHONDlFeq1x279uKz4kedMNhHkKw=
Authentication-Results: mxback3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id k1gFe12mRL-W97mliXI;
        Sun, 30 Jun 2019 13:32:09 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dark Penguin <darkpenguin@yandex.ru>
To:     linux-btrfs@vger.kernel.org
Subject: Recover a damaged btrfs backup image
Message-ID: <1f678d8a-9f2a-022c-b0f3-98af0e8c7712@yandex.ru>
Date:   Sun, 30 Jun 2019 13:32:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Greetings!

I have a 50-Gb backup of a btrfs subvolume made with 'btrfs send
mysubvolume | pigz > mysubvolume.btrfs.gz'. Later it turned out that the
archive is damaged - there are a few consecutive gzip errors after 1 Gb.
The rest of the file can be recovered with gzip recovery tools.

However, 'btrfs receive' can not continue after encountering this spot.
I have found numerous ways to recover btrfs partitions, but not backup
images. Is there any way to ignore the error and continue with the rest
of files? I'd be happy even if I could only see the contents (metadata?)
- to account for what exactly is lost.


-- 
darkpenguin

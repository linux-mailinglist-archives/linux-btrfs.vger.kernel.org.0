Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D88F678072
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2019 18:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfG1Qgm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Jul 2019 12:36:42 -0400
Received: from mail1.arhont.com ([178.248.108.111]:38562 "EHLO
        mail1.arhont.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfG1Qgm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Jul 2019 12:36:42 -0400
X-Greylist: delayed 509 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Jul 2019 12:36:41 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail1.arhont.com (Postfix) with ESMTP id A35ED360BEF
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Jul 2019 17:28:10 +0100 (BST)
Received: from mail1.arhont.com ([127.0.0.1])
        by localhost (mail1.arhont.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gY_vzKz1IMpr for <linux-btrfs@vger.kernel.org>;
        Sun, 28 Jul 2019 17:28:08 +0100 (BST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail1.arhont.com (Postfix) with ESMTP id 9D619360BF1
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Jul 2019 17:28:08 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail1.arhont.com 9D619360BF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arhont.com;
        s=157CE280-B46F-11E5-BB22-6D46E05691A3; t=1564331288;
        bh=QsA2Cwe3XHesST8wuVjVYvydvltGk88OP92Cro1QyJg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=A2M7MXnTZGuQBvnVhKv7piUy2xSs7oXxjwYW8E7sX0crxh8nV9i7E7s/HqIb7c9JG
         ejHTSVerjpTr2/mAi1V+8oH/fwI/PBFL1v+NiNpggDj1m4nks8+GlcrHgC/3NXSa5e
         zRsAXwsQcIZyEZl9IOXstUutA7yIXwYykER6EpPE=
X-Virus-Scanned: amavisd-new at arhont.com
Received: from mail1.arhont.com ([127.0.0.1])
        by localhost (mail1.arhont.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rvW4j7i2UyFS for <linux-btrfs@vger.kernel.org>;
        Sun, 28 Jul 2019 17:28:08 +0100 (BST)
Received: from mail1.arhont.com (localhost.localdomain [127.0.0.1])
        by mail1.arhont.com (Postfix) with ESMTP id B560F360BEF
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Jul 2019 17:28:07 +0100 (BST)
Date:   Sun, 28 Jul 2019 17:28:06 +0100 (BST)
From:   "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>
To:     linux-btrfs@vger.kernel.org
Message-ID: <1244295486.47.1564331283120.JavaMail.gkos@xpska>
Subject: how to recover data from formatted btrfs partition
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.12_GA_3803 (Zimbra Desktop/7.3.1_13063_Linux)
Thread-Index: WsemtFqvWDEe+P7XPsHhikn57KVObg==
Thread-Topic: how to recover data from formatted btrfs partition
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi list,

I accidentally formatted the existing btrfs partition today with mkfs.btrfs
Partition obviously table remained intact, while all three superblock 0,1,2 correspond to the new btrfs UUID.
The original partition was daily snapshotted and was mounted using "compress-force=lzo,space_cache=v2" so I guess the recovery using photorec would be troublesome.

Is there any chance to recover the data?
Any ideas or advices would be highly appreciated.


yours,
Kos

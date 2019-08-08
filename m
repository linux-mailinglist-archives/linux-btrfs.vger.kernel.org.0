Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9408643E
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2019 16:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbfHHOXv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Aug 2019 10:23:51 -0400
Received: from mail1.arhont.com ([178.248.108.111]:58004 "EHLO
        mail1.arhont.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732375AbfHHOXu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Aug 2019 10:23:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail1.arhont.com (Postfix) with ESMTP id 1469636008C
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2019 15:23:49 +0100 (BST)
Received: from mail1.arhont.com ([127.0.0.1])
        by localhost (mail1.arhont.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3eabkO4TPbAR for <linux-btrfs@vger.kernel.org>;
        Thu,  8 Aug 2019 15:23:46 +0100 (BST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail1.arhont.com (Postfix) with ESMTP id 7999F360BFD
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2019 15:23:46 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail1.arhont.com 7999F360BFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arhont.com;
        s=157CE280-B46F-11E5-BB22-6D46E05691A3; t=1565274226;
        bh=8f1B08lYwt1f1S0kBVc1NEusRnlXjJABBjHeQNYCJT4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=sf5Z+FLeEwW6A8NJ78HrVuh/d5O1KsNchRDoEQeU3sI9uePxS5vqwYMKt8yr4Dlpg
         C343wIPTXIzQfikOwjqcpyhqZf6VkhVIcBH+Ioqsg0kQ+o140O5YejT+h2dZrvoh+o
         +risiu4EmRanp+qXUXH1KbjzqgycEG9/N5Pz3sOc=
X-Virus-Scanned: amavisd-new at arhont.com
Received: from mail1.arhont.com ([127.0.0.1])
        by localhost (mail1.arhont.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id K9LV1A8AJfC1 for <linux-btrfs@vger.kernel.org>;
        Thu,  8 Aug 2019 15:23:46 +0100 (BST)
Received: from mail1.arhont.com (localhost.localdomain [127.0.0.1])
        by mail1.arhont.com (Postfix) with ESMTP id 45F2D360079
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2019 15:23:46 +0100 (BST)
Date:   Thu, 8 Aug 2019 15:23:45 +0100 (BST)
From:   "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>
To:     linux-btrfs@vger.kernel.org
Message-ID: <1625142435.4.1565274221485.JavaMail.gkos@xpska>
In-Reply-To: <1244295486.47.1564331283120.JavaMail.gkos@xpska>
References: <1244295486.47.1564331283120.JavaMail.gkos@xpska>
Subject: Re: how to recover data from formatted btrfs partition
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.12_GA_3803 (Zimbra Desktop/7.3.1_13063_Linux)
Thread-Topic: how to recover data from formatted btrfs partition
Thread-Index: WsemtFqvWDEe+P7XPsHhikn57KVObgqihSNx
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Update to the story. In case anyone ends up in a similar situation as myself.

I managed to successfully restore all the files using UFS Explorer Standard edition. The app has analysed the disk structure found several BTRFS UUID, reconstructed the needed trees and restored the missing data. Can highly recommend it.

Regards,
Konstantin


----- Original Message -----
From: "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>
To: linux-btrfs@vger.kernel.org
Sent: Sunday, 28 July, 2019 6:28:06 PM
Subject: how to recover data from formatted btrfs partition

Hi list,

I accidentally formatted the existing btrfs partition today with mkfs.btrfs
Partition obviously table remained intact, while all three superblock 0,1,2 correspond to the new btrfs UUID.
The original partition was daily snapshotted and was mounted using "compress-force=lzo,space_cache=v2" so I guess the recovery using photorec would be troublesome.

Is there any chance to recover the data?
Any ideas or advices would be highly appreciated.


yours,
Kos

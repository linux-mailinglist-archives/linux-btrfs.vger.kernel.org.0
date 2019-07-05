Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC75E607C2
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 16:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbfGEOW0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 10:22:26 -0400
Received: from a4-15.smtp-out.eu-west-1.amazonses.com ([54.240.4.15]:48546
        "EHLO a4-15.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725497AbfGEOW0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 10:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1562336544;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=PNQ+ZVeVyoKSVKIwPi0iWsM2kB3y0gMV5AhuVL3O0a0=;
        b=E4D9gHc3qVvV6fvRJA2z2MMkBj58/B6vj3gm6avMFtJLaUV8swTiZPqK4b3G0oul
        YzLcQ0N3JWWkYb07nGuMJ5xA6orpGilgX9IHMiwfadJlwMhpx/MsDrnUZqxJ+rD1Tho
        YjNzTPBI8Zz8cQbuyUzV94A2+O8BKbpbITTBQdAY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1562336544;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=PNQ+ZVeVyoKSVKIwPi0iWsM2kB3y0gMV5AhuVL3O0a0=;
        b=LPaiN7ZV/yLKxCc5P10EKVreYBrIBwDonF621bfzQp46a5qKrT0ZE/VlNHjTcdXA
        +i8KvvU2EMO/0wxVwpWS4WsR/gNe4aaEK7w9IM1rki9k4vFlQ13PHQju3mpwGgtnBsh
        ZTOPyxNPPnX6hv1My1OlquS+HMgdxNQBngxja2Dk=
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Martin Raiber <martin@urbackup.org>
Subject: syncfs() returns no error on fs failure
Message-ID: <0102016bc283c774-ca60b6ce-5179-4de8-8df3-80752411b5c0-000000@eu-west-1.amazonses.com>
Date:   Fri, 5 Jul 2019 14:22:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SES-Outgoing: 2019.07.05-54.240.4.15
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I realize this isn't a btrfs specific problem but syncfs() returns no
error even on complete fs failure. The problem is (I think) that the
return value of sb->s_op->sync_fs is being ignored in fs/sync.c. I kind
of assumed it would return an error if it fails to write the file system
changes to disk.

For btrfs there is a work-around of using BTRFS_IOC_SYNC (which I am
going to use now) but that is obviously less user friendly than syncfs().

Regards,
Martin Raiber

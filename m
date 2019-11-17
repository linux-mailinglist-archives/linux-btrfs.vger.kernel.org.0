Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0FCFFB65
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Nov 2019 19:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfKQStb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Nov 2019 13:49:31 -0500
Received: from dc2.fullpliant.org ([213.186.44.166]:45266 "HELO
        dc2.fullpliant.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726067AbfKQStb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Nov 2019 13:49:31 -0500
Date:   Sun, 17 Nov 2019 19:49:07 +0000
From:   Hubert Tonneau <hubert.tonneau@fullpliant.org>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Avoiding BRTFS RAID5 write hole
Message-ID: <copliant/KV8E24Q0/0JGI3HI@copliant.storga.com>
In-Reply-To: <ba3a73e8-d009-48f6-a6b0-e6ba57752798@libero.it>
References: <0JGAX5Q12@briare1.fullpliant.org> <7723feea-c3cd-b1eb-b882-aa782bbc6e2a@libero.it> <hubert_tonneau/4RYCU6X4/0JGEB54@hubert-tonneau.storga.com> <ba3a73e8-d009-48f6-a6b0-e6ba57752798@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Goffredo Baroncelli wrote:
>
> You are suggesting to keep the "hot" data in a RAID1 block group, and write/update the RAID5 block group only when the data is "cold" in the RAID1 cache.

That's it.
Just remove the last word 'cache' because in some cases, the data might also remain as RAID1 forever, as an exemple if the nocow flag is set and the partition has enough free space.

Regards,
Hubert Tonneau

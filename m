Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4443F19B6B2
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Apr 2020 22:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732809AbgDAUDX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Apr 2020 16:03:23 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:38885 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732695AbgDAUDX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Apr 2020 16:03:23 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-16.iol.local with ESMTPA
        id Jja4jhoXwjfNYJja4jCHc2; Wed, 01 Apr 2020 22:03:20 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585771400; bh=ai+4BZFT4LD2KHZiay4Z8v5eKw/pylSNTMHnyCLHs+w=;
        h=From;
        b=WGhEovFbEp/4VrIsQyYs9Xg1h/UsdnPi87VPcewNovOeNCgOyqLIXtWkEglBswbDX
         z4n0u84dkqpMneNmZLXofnp4OcI5zSEhurV+jKSZPBgl6PGKaBMILoQWAVgHFU4MZG
         qWxaClilQ8OzClyiw7T/t+nxfSmc/9OzuQgzjopV1qGETG5BikvMioTRIQGzXlmOhm
         tPYBqJKLPqlMKvO9T/GCQ5E5NB0aSIjy6KmuLkIkcuelcVqQlDl66+CTEF6MOCam29
         H6pZ6NkpDXpdpS3mA6ZqBazt5wwvOr3UMTmXq+F37IIVunaK53HV4dvHMNPLm3zQOm
         lXe0r+l1CTBvg==
X-CNFS-Analysis: v=2.3 cv=av7M9hRV c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=N0wEcwKotpKbd46UzpkA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC] btrfs: ssd_metadata: storing metadata on SSD
Date:   Wed,  1 Apr 2020 22:03:15 +0200
Message-Id: <20200401200316.9917-1-kreijack@libero.it>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCyxby31zbEzQZ1G0lXCPz9fhIFQ/3oLUdzAOKQMWn6MiYgeBYZaRBKp/7jNlmQ6z37gr4uiGLOcHGoU5jVKeKqAlJGGJgciyOlcUOq8hkM1gEQCnsck
 LkMnhCW/sToQ9mCZmZIpVJ8ZX1bUT4EeRGF/Z9KZ1tXwELnSiCR02Dt/75UDaD0yU6Bz/FSNPNo8vQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an RFC; I wrote this patch because I find the idea interesting
even though it adds more complication to the chunk allocator.

The core idea is to store the metadata on the ssd and leave the data
on the rotational disks. BTRFS looks at the rotational flags to
understand the kind of disks.

This new mode is enabled passing the option ssd_metadata at mount
time.
This policy of allocation is the "preferred" one. If this doesn't permit
a chunk allocation, the "classic" one is used.

Some examples: (/dev/sd[abc] are ssd, and /dev/sd[ef] are rotational)

Non striped profile: metadata->raid1, data->raid1
The data is stored on /dev/sd[ef], metadata is stored on /dev/sd[abc].
When /dev/sd[ef] are full, then the data chunk is allocated also on
/dev/sd[abc].

Striped profile: metadata->raid5, data->raid5
raid5 requires 3 disks at minimum, so /dev/sd[ef] are not enough for a
data profile raid5. To allow a data chunk allocation, the data profile raid5
will be stored on all the disks /dev/sd[abcdef].
Instead the metadata profile raid5 will be allocated on /dev/sd[abc],
because these are enough to host this chunk.

NOTE1: I don't touch the mkfs.btrfs program, so the new policy will be
applied only to the next chunk allocation. If you want to allocate
properly the chunk created by mkfs.btrfs, a btrfs balance is required.
NOTE1: I made only few tests. Don't use for valued data

BR
G.Baroncelli




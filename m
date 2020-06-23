Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC27420542A
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 16:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbgFWOKr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 10:10:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32922 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732698AbgFWOKq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 10:10:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id l11so20705543wru.0
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jun 2020 07:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BpHvR6e867eLPhfTklzlEQPE0vSXJ1vGsznpfl3QVYU=;
        b=FN1QZjdxAtddkoFlAeCVNrJWLksABmc2IcIXlwhJQjudlYaGECJL/crk+/1MqUlrSW
         JlWtYF7DeiVPc3tDsCwtWIMyskzqfpD1KLGJk7uFgr1pWZpmNjl8A4Nwf/qX+/ThMndS
         FzMBEzxffYBqnADr8y0gUIcN7cBaNHWgYkH5CxEoauyLPVqeDyOq/Ro2i3tgM+SJbQjG
         REh2w8/zcp/ILgbG+3yhjjZtVhsAeL9+ycuTUhZNNUqXCbIHf3FpOzxAWyBJXFItxJ9L
         TrV0qgFDPGK6W7NvOPcGrZYF0nZGZCEl+w3aGhMvRj6OZ+Xq8GYfvyP6XmK761qdZHXT
         ycCA==
X-Gm-Message-State: AOAM531Tw52k0O+HDmHd8/l66DspEsjjKl6vNnmNYIwCPAQgMA4iQKNW
        +VBMKg2Ead3VEQPYJYV4uck5O8DU
X-Google-Smtp-Source: ABdhPJzdZHFNu8WHWFoSsjHDMbsj967T5wQaMwVat0C5p/mg9cFokjKZ/RP5TFYpAibrBtqjndwClg==
X-Received: by 2002:a5d:52c6:: with SMTP id r6mr24747266wrv.74.1592921444928;
        Tue, 23 Jun 2020 07:10:44 -0700 (PDT)
Received: from NUC.fritz.box ([2001:a62:1515:bd01:f64d:30ff:fe6c:acb5])
        by smtp.gmail.com with ESMTPSA id n1sm22529497wrp.10.2020.06.23.07.10.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2020 07:10:44 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/4] btrfs-progs: get rid of btrfs_raid_profile_table
Date:   Tue, 23 Jun 2020 16:10:15 +0200
Message-Id: <20200623141019.23991-1-jth@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

As promised here's the removal of btrfs_raid_profile_table which helped as a
intermediate step to refactor the raid specific settings in block group
creation in progs.

As Qu remindet me of the outstanding debts this morning, I decided to go ahead
and pay my debt today.

It will not be the last refactoring round in this area though, as the
btrfs-progs side and the kernel side still diverge a lot.

This series passes a full 'make test' run from btrfs-progs.

Johannes Thumshirn (4):
  btrfs-progs: use sub_stripes property from btrfs_raid_attr
  btrfs-progs: use minimal number of stripes from btrfs_raid_attr
  btrfs-progs: remove unused btrfs_raid_profile::max_stripes
  btrfs-progs: remove btrfs_raid_profile_table

 volumes.c | 71 +++++--------------------------------------------------
 1 file changed, 6 insertions(+), 65 deletions(-)

-- 
2.26.2


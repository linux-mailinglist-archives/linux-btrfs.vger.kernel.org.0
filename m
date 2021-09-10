Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C8C40670B
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Sep 2021 08:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhIJGEv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 02:04:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34198 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhIJGEu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 02:04:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8034D223DF
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Sep 2021 06:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631253819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UT3Vweye69KfK8G6RoFRlB2jrerf9e4aq8um0S7ZL3A=;
        b=vC9TUlX2Wvi3gV+FlTgDIfaAtxSXJzTC9kh5fm6u7PpTq7cr4eW5Lv5SHXeNmTFdwEs85G
        Q9E+deHz6niLz1FqbCpbTqUSbqE+6AwbplzAzwX6A1b8Q9WhCRRFyaOXbq3knINLg3bUyM
        ojyTdPF04xWynmszRpaIoLaUV55+TwU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B117613D02
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Sep 2021 06:03:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UIjAHDr1OmFMEwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Sep 2021 06:03:38 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: add educational warning for flipping RO to RW on recevied subvolumes
Date:   Fri, 10 Sep 2021 14:03:33 +0800
Message-Id: <20210910060335.38617-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since we're going to change how kernel handles received subvolume
RO->RW flipping, it is going to cause kernel behavior change for some
incremental send users.

Add extra educational warning to both "btrfs prop set" command and man
page of "btrfs prop".

Qu Wenruo (2):
  btrfs-progs: do extra warning when setting ro false on received
    subvolume
  btrfs-progs: doc: add extra note on flipping read-only on received
    subvolumes

 Documentation/btrfs-property.asciidoc |  6 ++++++
 props.c                               | 21 +++++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.33.0


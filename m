Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED788242DC8
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 19:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHLRCO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 13:02:14 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.222]:26251 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726456AbgHLRCN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 13:02:13 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id C035412FEE55
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Aug 2020 11:37:13 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 5tkXk2dawBD8b5tkXkanjO; Wed, 12 Aug 2020 11:37:13 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VjZzmODbiOjCPuOmV99CmsTy5OPXGxTpWQVEktmlhDM=; b=lDYe2PGI0Xd7xq7ms0NucOY+eI
        hdvmZasXsBapOLRrbMdc0qDzeHIbp2uCVE1TyAR8Q9Xl+1Ocwhi303s9/RZnn6VdX1NCbC0GcgjMO
        t4PHQqtqVelmmYyozRQZGbeCXOuhIqFauZD9H+/m8jSYgGc66GjEkm7ckg7fo3CKT5Y7cBoMHbiqF
        jUffW180gEhmGaRXVoCzZPkiPEYHEopEpH10qzWc4hPW5Wd4X70G7GuHDcQKpBDFhsuS9Y2EnfQIW
        xOqGyjfz4fBLTiybQinRO/zhp0U1q0lMfv1QsNrFdm2/gdHjgLLdRkSDsw1FuuMil8wtIFoZdRVyF
        Nup4Yd5w==;
Received: from [179.185.221.211] (port=55300 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1k5tkX-004J9r-4U; Wed, 12 Aug 2020 13:37:13 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [RFC PATCH 0/8] btrfs: convert to fscontext
Date:   Wed, 12 Aug 2020 13:36:46 -0300
Message-Id: <20200812163654.17080-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.185.221.211
X-Source-L: No
X-Exim-ID: 1k5tkX-004J9r-4U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [179.185.221.211]:55300
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 2
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

These patches aim to convert btrfs to new fscontext API. I used the approach of
creating a new parsing function and then switching to this new function, instead
of creating a huge change patch. Please let me know if you think this is a
better approach.

The most notable changes come form the fact that now we parse the mount options
before having a fs_info, in the same way that David Howells did in his POC[1]
some time ago.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=Q46&id=554cb2019cda83e1aba10bd9eea485afd2ddb983

Marcos Paulo de Souza (8):
  btrfs: fs_context: Add initial fscontext parameters
  btrfs: super: Introduce fs_context ops, init and free functions
  btrfs: super: Introduce btrfs_fc_parse_param and
    btrfs_apply_configuration
  btrfs: super: Introduce btrfs_fc_validate
  btrfs: super: Introduce btrfs_dup_fc
  btrfs: super: Introduce btrfs_mount_root_fc
  btrfs: Convert to fs_context
  btrfs: Remove leftover code from fscontext conversion

 fs/btrfs/ctree.h       |   29 +
 fs/btrfs/dev-replace.c |    2 +-
 fs/btrfs/disk-io.c     |   10 +-
 fs/btrfs/disk-io.h     |    4 +-
 fs/btrfs/super.c       | 1819 +++++++++++++++++++++-------------------
 fs/btrfs/volumes.c     |    6 +-
 6 files changed, 974 insertions(+), 896 deletions(-)

-- 
2.28.0


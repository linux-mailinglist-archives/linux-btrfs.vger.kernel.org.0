Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2FD151151
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgBCUuK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:10 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37352 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgBCUuJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:50:09 -0500
Received: by mail-qk1-f194.google.com with SMTP id 21so15704049qky.4
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/CCJGAmj8zhaN6UFv+rbjnkqAKaxFdKlrvRJCkn7m3c=;
        b=iKgRFdoE7IiXT0Jdkka8F2WXh02sn31TfBhLp1/2LnqCEqUtB8fzHbuwfqw/fE193H
         BswcGV/9VSGp+Fw9lJGpVtDOmK020LUTlndWxGaPtwwM2bxUIY8v+dqSQs4zpK3D9jdx
         KRkmjmVh3NpxndXQhPamUEGO5gwsahnWtOIIRoqdia3rd1vH5PTnsXAsbLPW3Zho2v4y
         5UiHkznzg7J3cuQOutR6qhqddQrL4cHfyHL/LrD7woA9nwsmv3PGd6wCnV/EnbGjgduM
         Gq/hemdsL6/9LxeIOklUyOaAIGT63TzQTWopNYaV7w/nm5imeq/Saa3+IkqQ/9vOv3gu
         oSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/CCJGAmj8zhaN6UFv+rbjnkqAKaxFdKlrvRJCkn7m3c=;
        b=hFLlA447Z1zq7Depibjv0GzdJhqHoJCRdTCwpmTmfJ3nPBvj1/NuqxeZhj9bPGOvwo
         IpgEFHArmVBjgm/TAINO/PWiswS96m9hOg+otk7Co0bRaybiMXSCGyTOIPOUFgrS4CIb
         reCy3N+cEt3Q0YIR7VkWvzYh5uJ6Mp46a8XZzkDCWhNthEXTSJaFOXYJC/Pp3ldx0oU+
         QZHH7ewpRsn0s+3pY63FIg04NiDZE6YlnCdjwHiszC6Tp4kl2eBDQkqSrAcfE0Tet04D
         HhHvFjiTW/x/uuL6/sTILomyIGM8NayJUeQtT9zlo7Faojf/oqiA850ss4ipk4d/UJWS
         0vpA==
X-Gm-Message-State: APjAAAVtQG9yOcXk5KOAH2azcvYUwqeR/SqzG9+A/bTXKVTeWnINyu7k
        tTlPUz/FfR85QvAHSYunyu5mrboWt0EOQw==
X-Google-Smtp-Source: APXvYqxZvG4KiVxjbpMTcuKzYAbGMLcHXwf3RoLrILciLcRVz7fivi6NS5Kmy8GTvORdUrRbGwBMmQ==
X-Received: by 2002:a37:b842:: with SMTP id i63mr25508917qkf.451.1580763007474;
        Mon, 03 Feb 2020 12:50:07 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l6sm10640258qti.10.2020.02.03.12.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:50:06 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 08/24] btrfs: call btrfs_try_granting_tickets when reserving space
Date:   Mon,  3 Feb 2020 15:49:35 -0500
Message-Id: <20200203204951.517751-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have compression on we could free up more space than we reserved,
and thus be able to make a space reservation.  Add the call for this
scenario.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 616d0dd69394..aca4510f1f2d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2899,6 +2899,13 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
 						      space_info, -ram_bytes);
 		if (delalloc)
 			cache->delalloc_bytes += num_bytes;
+
+		/*
+		 * Compression can use less space than we reserved, so wake
+		 * tickets if that happens.
+		 */
+		if (num_bytes < ram_bytes)
+			btrfs_try_granting_tickets(cache->fs_info, space_info);
 	}
 	spin_unlock(&cache->lock);
 	spin_unlock(&space_info->lock);
-- 
2.24.1


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5914D1AF31
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 05:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfEMDkX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 May 2019 23:40:23 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35405 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727202AbfEMDkW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 May 2019 23:40:22 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1290722269;
        Sun, 12 May 2019 23:40:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 12 May 2019 23:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=6OZeOmvLN4Gh7g+920S6IVtrXqWWQEbdwRJ+f8q1zDQ=; b=46ZtCqxW
        DgrN9dwXG4RZ9OKa0Q8eDdGWUeaK/gSUPm2jCgo6oUTP0ffeVl4gZkVxkdusjRK6
        gB/z5li7BiUS35Y6Q0YTsuMx0yo0GPfeuoDJsndABuPKEREpe9MbaXVjbcI5hGzB
        WyDN4j6QNWaLc9YZTs8YbHkFQ2npdnzlMhfVDCnhdsD/iZYE+Wlmgof8BlgTfVrc
        T/7sKka9Hm/kItKMKHGqNdwTZ/qFQxnMR3WSDUTyfnC4m0KbIevyUNsKAf7RZeKz
        NdwBo7lDWyAoA9c4EHg2K1zuoVYZWDSQcso/k+pvIjTSFgZYNPhK69IKeDtRk+DX
        Fb57OklFJGrrkA==
X-ME-Sender: <xms:JefYXOy8b54qRnWazIUoQ6fwKlsric2cQTIDRXV1jve_oNMqVPxxcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleefgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudeirddukeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:JefYXAwYTRCm-re4cdZ3XXmd-H9EJTfPEegGWJR9zt8Khu2zSkUQAA>
    <xmx:JefYXOUPaGBnDhkXYpn6I05MZWbzyvYP18hHSz0QGFi9faSrBWp_Zw>
    <xmx:JefYXHTOXNUB3VHqmrzEhkGrM1dSZFXjbD4Y4AiqZGj5orTyqZPLyA>
    <xmx:JufYXPSX5kjT9fhxPs1L3clixsZiYc-1XyFA4ZvLs442sXZmguiyUQ>
Received: from eros.localdomain (124-169-16-185.dyn.iinet.net.au [124.169.16.185])
        by mail.messagingengine.com (Postfix) with ESMTPA id D96E980060;
        Sun, 12 May 2019 23:40:18 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fs: btrfs: Fix error path kobject memory leak
Date:   Mon, 13 May 2019 13:39:11 +1000
Message-Id: <20190513033912.3436-2-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190513033912.3436-1-tobin@kernel.org>
References: <20190513033912.3436-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If a call to kobject_init_and_add() fails we must call kobject_put()
otherwise we leak memory.

Calling kobject_put() when kobject_init_and_add() fails drops the
refcount back to 0 and calls the ktype release method.

Add call to kobject_put() in the error path of call to
kobject_init_and_add().

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/btrfs/extent-tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c5880329ae37..5e40c8f1e97a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3981,8 +3981,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 				    info->space_info_kobj, "%s",
 				    alloc_name(space_info->flags));
 	if (ret) {
-		percpu_counter_destroy(&space_info->total_bytes_pinned);
-		kfree(space_info);
+		kobject_put(&space_info->kobj);
 		return ret;
 	}
 
-- 
2.21.0


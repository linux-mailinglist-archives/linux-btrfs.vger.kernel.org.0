Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B24A751B2C
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 10:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbjGMINe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 04:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbjGMIMa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 04:12:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB3A2683
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 01:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689235775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=6+sn8tNi3bmcnwePLpu6W4HEdc2Df7nPAm1GrMq7j40=;
        b=QLtDc39twoV7DFr3gPaTwb+OBzMOWulL25Btm3LfTjTcPNDur4vnIQzIiw8p/ch45ModZp
        8pczVjoyzWibAsEdOEwGd9n3VhDENUfDoHACoorM09lM/3/3FzCeZI3FWfj6x1Xxx2j3Oh
        yJNh9Cb8k5OV3b1HOHbxJZ2vHwtqr9o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-dtbmZcudNqO0sfOVCF2Twg-1; Thu, 13 Jul 2023 04:09:34 -0400
X-MC-Unique: dtbmZcudNqO0sfOVCF2Twg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 372A3856506
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 08:09:34 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 90B102166B26
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 08:09:33 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs loses 32-bit application compatibility after a while
Date:   Thu, 13 Jul 2023 10:09:31 +0200
Message-ID: <87cz0w1bd0.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As far as I can tell, btrfs assigns inode numbers sequentially using
this function:

int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
{
	int ret;
	mutex_lock(&root->objectid_mutex);

	if (unlikely(root->free_objectid >= BTRFS_LAST_FREE_OBJECTID)) {
		btrfs_warn(root->fs_info,
			   "the objectid of root %llu reaches its highest value",
			   root->root_key.objectid);
		ret = -ENOSPC;
		goto out;
	}

	*objectid = root->free_objectid++;
	ret = 0;
out:
	mutex_unlock(&root->objectid_mutex);
	return ret;
}

Even after deletion of the object, inode numbers are never reused.

This is a problem because after creating and deleting two billion files,
the 31-bit inode number space is exhausted.  (Not sure if negative inode
numbers are a thing, so there could be one extra bit.)  From that point
onwards, future files will end up with an inode number that cannot be
represented with the non-LFS interfaces (stat, getdents, etc.), causing
system calls to fail with EOVERFLOW.

For ABI reasons, we can't switch everything to 64-bit ino_t and LFS
interfaces.  (If we could recompile, we wouldn't still be using 32-bit
software.)

So far, we have seen this on our 32-bit Koji builders, which create and
delete many, many files.  But I suspect end users will encounter it
eventually, too.

It seems to me that the on-disk format already allows range searches on
inode numbers (see btrfs_init_root_free_objectid), so maybe this could
be used to find a sufficiently large unused range to allocate from.

Thanks,
Florian


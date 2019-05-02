Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8BE21211E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2019 19:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfEBReu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 May 2019 13:34:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45634 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfEBRet (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 May 2019 13:34:49 -0400
Received: by mail-io1-f68.google.com with SMTP id e8so2876926ioe.12;
        Thu, 02 May 2019 10:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=2CcPxb2C1RD8skQYG5/aPu30Ko1ajsjTfrv46WpisqI=;
        b=pUcPnxxMpboqsl0DnnCKyfxXhc+Ju34Ex6IxNulCB2V8gIBk4Z6WikMHKUI6RbMw2/
         +B1uaIq/My7DQE9yln36akCU7M78apGBz5vyUXyLvitYcy52iZtpXXhA4lXBDItXclm/
         h4px6LFiGmvEeYlISVpctg8/UXzDdp0N5UAEU9asQxb2KnrUPnhjFMmg83kf2Of3/V2/
         pqlsnFiRagqIMBAT5/7i/THqxLpp9c3/eM8u2B0MfmOnxr4J13gwaDvDWoqNF8p7OCGs
         AC3suog2DW8SGAskQEdtIkA6bRYutD706Ml8wl7H8REhbbHXQb/QFV1kf4UmlmH+fX81
         4p/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=2CcPxb2C1RD8skQYG5/aPu30Ko1ajsjTfrv46WpisqI=;
        b=ShsHcxtjcdio1q45Fvonv3vzCMYgZVN7UUK+uogAbzoJhkBsZ+pnXucSFKOFaGi6ub
         lTQeO+EGwsm4Bd08LHb+yzOw49fe16LNY7aaTskPjIPm3WKYZ8x5wp+48E1VJr7lxtsa
         sULzDbvbpwDAQXwZGP2PDpcifrdC+SZj6WqUVeU3RWvJvIuyHBWl0SbzOYEQLqG8YlE/
         9LdQo6Dbzt2NGrW5n8Jx3UyCOq6gB4gRckv+8ske1QYu+859EZuwjO3U7+cwg6wPWX86
         0bffjwvCnphpLjtIZa1wQoLpC/AIQpk1lR6LBHx3KuhWl3ALBe81v9AaSyoER9ByShyq
         7+Iw==
X-Gm-Message-State: APjAAAVtxsQBMdep8lByzayPQEBQwanoTMAVhqNOKAetToh+Czb9Qeqo
        Hn5MjYswECXLuA93lVWyWvfqz4GiRUQ=
X-Google-Smtp-Source: APXvYqx6SrP8/++xoGglIQuLcit+fmbzIuZ56KH2b+ep4v2HFjsR6MFF3Afq993aQcqeNSAYBHA60w==
X-Received: by 2002:a05:6602:55:: with SMTP id z21mr3458329ioz.101.1556818488067;
        Thu, 02 May 2019 10:34:48 -0700 (PDT)
Received: from ubu (2600-6c48-437f-c81d-b1d9-7ff0-b1de-5362.dhcp6.chtrptr.net. [2600:6c48:437f:c81d:b1d9:7ff0:b1de:5362])
        by smtp.gmail.com with ESMTPSA id l1sm16146729iop.67.2019.05.02.10.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 10:34:46 -0700 (PDT)
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: sysfs: Replace default_attrs in ktypes with groups
Date:   Thu,  2 May 2019 13:34:45 -0400
Message-Id: <20190502173445.5308-1-kimbrownkd@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The kobj_type default_attrs field is being replaced by the
default_groups field. Replace the default_attrs fields in
btrfs_raid_ktype and space_info_ktype with default_groups.

Change "raid_attributes" to "raid_attrs", and use the ATTRIBUTE_GROUPS
macro to create raid_groups and space_info_groups.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---

This patch depends on a patch in the driver-core tree: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=driver-core-next&id=aa30f47cf666111f6bbfd15f290a27e8a7b9d854

GregKH can take this patch through the driver-core tree, or this patch
can wait a release cycle and go through the subsystem's tree, whichever
the subsystem maintainer is more comfortable with.


 fs/btrfs/sysfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 5a5930e3d32b..ae0ad84a11aa 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -303,11 +303,12 @@ static ssize_t raid_bytes_show(struct kobject *kobj,
 	return snprintf(buf, PAGE_SIZE, "%llu\n", val);
 }
 
-static struct attribute *raid_attributes[] = {
+static struct attribute *raid_attrs[] = {
 	BTRFS_ATTR_PTR(raid, total_bytes),
 	BTRFS_ATTR_PTR(raid, used_bytes),
 	NULL
 };
+ATTRIBUTE_GROUPS(raid);
 
 static void release_raid_kobj(struct kobject *kobj)
 {
@@ -317,7 +318,7 @@ static void release_raid_kobj(struct kobject *kobj)
 struct kobj_type btrfs_raid_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops,
 	.release = release_raid_kobj,
-	.default_attrs = raid_attributes,
+	.default_groups = raid_groups,
 };
 
 #define SPACE_INFO_ATTR(field)						\
@@ -364,6 +365,7 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, total_bytes_pinned),
 	NULL,
 };
+ATTRIBUTE_GROUPS(space_info);
 
 static void space_info_release(struct kobject *kobj)
 {
@@ -375,7 +377,7 @@ static void space_info_release(struct kobject *kobj)
 struct kobj_type space_info_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops,
 	.release = space_info_release,
-	.default_attrs = space_info_attrs,
+	.default_groups = space_info_groups,
 };
 
 static const struct attribute *allocation_attrs[] = {
-- 
2.17.1


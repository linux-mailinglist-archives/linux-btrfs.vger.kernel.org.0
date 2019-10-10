Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F91D2234
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 10:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733010AbfJJIAw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 04:00:52 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21351 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727123AbfJJIAw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 04:00:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570694424; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=bNaGmccAeLO5ooOgCAKRQ5Z+PkDuGES12n68UjxmG/kcdgDbf+oZR7maL4TqGwyTTfxIeIKWWwwSoX47u6tFU72g4s1YumsvdorVa05hzDF9A21IRWIf9hEPOEVYPqAMudxlLyTHWMJ6PT8DDq14lFe6ntJqAwxcUEvAXUQs1/A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1570694424; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=KD8s6EG+3msRPb2k/lJMTJAg2Ox62LgEP5VZzaP40Vk=; 
        b=pL4wfm0VWumcO4Ai2JPpPDp1ZsD4tmBw3LnJ89nqL7b1PoFdUcEJXROsBSpguUgsgn6ZB0CVYWRFyjd/4/ARE4q5Oe+J39Cg7vItd7fmHq5AUcB7cBz5xYmU7QqaqMFmlFqjBmMuVIWXv3gdOsPBgHF0V5aVDarZZBaKLNTunE0=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1570694424;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=770; bh=KD8s6EG+3msRPb2k/lJMTJAg2Ox62LgEP5VZzaP40Vk=;
        b=PSwf+ZqybHWw7Z3iyNPDBy/SDwXZy+pcJYiwnFrCG7eUarOx6GbzxsYhE6zM2rjR
        uJqEu/JKS5uBDiBzF1fNtW6NoIljxZkMiRQ6TC6/XhcVkFfCQmK4v++OuOYv7fDa1sO
        sSZePXn+yvrWJGK35yyLqAicVtFtujBZqnoqtoV4=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 157069442137490.6293566743011; Thu, 10 Oct 2019 16:00:21 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191010075958.28346-1-cgxu519@mykernel.net>
Subject: [PATCH v2 1/3] btrfs: remove unnecessary hash_init()
Date:   Thu, 10 Oct 2019 15:59:56 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DEFINE_HASHTABLE itself has already included initialization code,
we don't have to call hash_init() again, so remove it.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
v1->v2:
- Modify change log to explain why hash_init() is not needed.

 fs/btrfs/props.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index 1e664e0b59b8..68508db3dc65 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -437,8 +437,6 @@ void __init btrfs_props_init(void)
 {
 =09int i;
=20
-=09hash_init(prop_handlers_ht);
-
 =09for (i =3D 0; i < ARRAY_SIZE(prop_handlers); i++) {
 =09=09struct prop_handler *p =3D &prop_handlers[i];
 =09=09u64 h =3D btrfs_name_hash(p->xattr_name, strlen(p->xattr_name));
--=20
2.20.1




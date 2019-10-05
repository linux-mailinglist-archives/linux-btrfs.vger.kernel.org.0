Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2484CC826
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Oct 2019 07:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfJEFdp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Oct 2019 01:33:45 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21657 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbfJEFdo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 5 Oct 2019 01:33:44 -0400
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Oct 2019 01:33:43 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1570252680; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=hsHpoQgZb04KhJFSWPIWY4TEAiUDIY3NNKLpIxkMyPIzlAk07InQr08neC0sXSYfZWncVv9tFI/49EjE7/k5By4QrJWaWRCrpnLg/BBOqmoiCvAy16HdUoyPuk2gYqgv4IbEG57aaAZroRZVXiWKDJe3LBSUkjAOjASbeKX6Ba0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1570252680; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=PpZpsclsUorTE1vSJjbjRH38NgJ0hwLkChLs9j2SfSg=; 
        b=lPXLQG6mVwtuIS+n0yPezyZNAgMsFMKgkRDFscV4B3XFtgB1Z8zmUZhJUPYXfEz4KRMEGooPNGua9h8nGp+SGB0BSuorhOguB/iiI+EPH0s0PWLbNHQovdIHK1wAfgFcIHFcEgAEVtOFiKJDGs05mDbxYph4wS2VTQ753qxyspA=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1570252680;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=641; bh=PpZpsclsUorTE1vSJjbjRH38NgJ0hwLkChLs9j2SfSg=;
        b=dTYb7/+i52RZIF8NzDshqihmzvcoS6ePWCX7cCqA5UMLo7Pi+iqBURLpEuBmIi9W
        7ZUd0OsilndrzpUZILUQaEWC+Hs+QGAqgwQO+zAltLXQ+u5x97NbXSoNJKfKvZkTY5Y
        NisuaYqBWyyzgI+W4QLUhbeHhwxPx6clxOrEiuRo=
Received: from localhost.localdomain (116.30.195.234 [116.30.195.234]) by mx.zoho.com.cn
        with SMTPS id 1570252677250448.9482086126976; Sat, 5 Oct 2019 13:17:57 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191005051736.29857-1-cgxu519@mykernel.net>
Subject: [PATCH 1/3] btrfs: remove unnecessary hash_init()
Date:   Sat,  5 Oct 2019 13:17:34 +0800
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

hash_init() is not necessary in btrfs_props_init(),
so remove it.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
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
2.21.0




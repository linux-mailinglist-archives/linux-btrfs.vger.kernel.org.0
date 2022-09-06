Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25B05AE3DD
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 11:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbiIFJJQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 05:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiIFJJP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 05:09:15 -0400
X-Greylist: delayed 487 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Sep 2022 02:09:14 PDT
Received: from kyoto-arc.or.jp (ns.kyoto-arc.or.jp [202.252.247.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F70D48E9F
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Sep 2022 02:09:14 -0700 (PDT)
Received: from [192.168.2.28] ([202.252.247.10]:25604)
        by kyoto-arc.or.jp with [XMail ESMTP Server]
        id <S167E5C> for <linux-btrfs@vger.kernel.org> from <kengo@kyoto-arc.or.jp>;
        Tue, 6 Sep 2022 18:01:03 +0900
Mime-Version: 1.0
X-Sender: kengo@ms.kyoto-arc.or.jp
X-Mailer: QUALCOMM MacOS Classic Eudora Version 6J Jr6
Message-Id: <p0600104adf3cb2552d24@kyoto-arc.or.jp>
In-Reply-To: <9c295a8c-5167-116e-4fae-d548f1deb3b2@zoho.com>
References: <fb056073-5bd6-6143-9699-4a5af1bd496d@zoho.com><655f97cc-64e6-9f57-5394-58
 f9c3b83a6f@gmx.com><40b209eb-9048-da0c-e776-5e143ab38571@zoho.com><72a78cc
 0-4524-47e7-803c-7d094b8713ee@gmx.com><00984321-3006-764d-c29e-1304f89652a
 e@zoho.com><18300547-1811-e9da-252e-f9476dca078c@gmx.com><4691b710-3d71-bd
 26-d00a-66cc398f57c5@zoho.com><7553372e-1485-63ae-d3f1-e9e0a318b2f6@gmx.co
 m> <9c295a8c-5167-116e-4fae-d548f1deb3b2@zoho.com>
Date:   Tue, 6 Sep 2022 17:59:21 +0900
To:     linux-btrfs@vger.kernel.org
From:   "Kengo.M" <kengo@kyoto-arc.or.jp>
Subject: delete whole file system
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi folks

I made raid5 file system by btrfs like below

sudo mkfs.btrfs -L raid5.btrfs -d raid5 -m raid1 -f /dev/sda /dev/sdb 
/dev/sdc /dev/sdd /dev/sde

And mount /mnt/raid5.btrfs

sudo btrfs filesystem show

Label: 'raid5.btrf'  uuid: 23a34a45-8f5e-40f5-8cda-xxxxxxxxxxxx
         Total devices 5 FS bytes used 128.00KiB
         devid    1 size 2.73TiB used 1.13GiB path /dev/sda
         devid    2 size 2.73TiB used 1.13GiB path /dev/sdb
         devid    3 size 2.73TiB used 1.13GiB path /dev/sdc
         devid    4 size 2.73TiB used 1.13GiB path /dev/sdd
         devid    5 size 2.73TiB used 1.13GiB path /dev/sde


So,I want to delete this file system.

btrfs device delete /dev/sda /mnt/raid5.btrfs

But delete /dev/sda only.

Please Someone tell me how to delete whole this file system.

BRD

Kengo.m

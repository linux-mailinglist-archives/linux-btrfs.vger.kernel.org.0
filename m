Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002C35B6470
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 02:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiIMACc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 20:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiIMACb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 20:02:31 -0400
Received: from kyoto-arc.or.jp (ns.kyoto-arc.or.jp [202.252.247.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD252F3B9
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 17:02:25 -0700 (PDT)
Received: from [192.168.2.41] ([202.252.247.10]:7957)
        by kyoto-arc.or.jp with [XMail ESMTP Server]
        id <S1685A1> for <linux-btrfs@vger.kernel.org> from <kengo@kyoto-arc.or.jp>;
        Tue, 13 Sep 2022 09:02:20 +0900
Mime-Version: 1.0
X-Sender: kengo@ms.kyoto-arc.or.jp
X-Mailer: QUALCOMM MacOS Classic Eudora Version 6J Jr6
Message-Id: <p06001014df4577e8554b@kyoto-arc.or.jp>
Date:   Tue, 13 Sep 2022 09:00:38 +0900
To:     linux-btrfs@vger.kernel.org
From:   "Kengo.M" <kengo@kyoto-arc.or.jp>
Subject: scrub results by email
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi folks

I would like to send results of btrfs scrub by email.
How are you all doing?

If finish "btrfs scrub start" then continue execute "btrfs scrub status"

Like this

btrfs scrub start /mnt/test.btrfs
btrfs scrub status /mnt/test.btrfs | mail -s "scrub results" foo@baa.com

BRD

Kengo

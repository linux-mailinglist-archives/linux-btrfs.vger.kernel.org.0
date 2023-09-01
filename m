Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662967902D7
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Sep 2023 22:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242521AbjIAUcX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Sep 2023 16:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238409AbjIAUcW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Sep 2023 16:32:22 -0400
X-Greylist: delayed 46423 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Sep 2023 13:32:19 PDT
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A48E7E
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Sep 2023 13:32:19 -0700 (PDT)
Date:   Fri, 01 Sep 2023 20:32:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1693600336; x=1693859536;
        bh=lw9yicdz0KUGPQRGp5Eog8nx3hgz+pYkBQSnDlCbzi0=;
        h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=MyrDnaP92KhTvjnpoBIooxaxuWyD0RX0PC0lAjHvzKMPBXi50KHf+ie+EiVfGmecW
         m591s2r9BsogjqVC+Oir3PcLOVq800j/w4z4xWnKuqjGsg60BcTnt3aS2vaC/69upr
         SWAHjzKDIjTYMBpQa3VEXzlvLy68KJV7aP2A2kyuCL4/5PCqQHpsoe+ej1bNk63sYq
         jff0Q18SJbZN7bLv5zejpY+8rLSZO/J0texL1qWojLROzlhAPV/u1pbIGGLbOlXHpF
         Und6jOKvskXbKiFloDugT6NUk9UO+H0tVUNMPaOpE6NBxR9iftzZjGn4geemBfzwKb
         HfdwdDZXqOzpQ==
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   notrandom98234 <notrandom98234@protonmail.com>
Subject: Re: Corrupted after multiple forceful shutdowns
Message-ID: <LuEE1I-3MHi2t3VMlpKKPCBNlfkqenbbFfZLhEum4QTP0J9pQBKVuYJQP9zJPnOnaKANpJ197S4NygsMibFoaA9X--4JESqunpQW8ZR7Q34=@protonmail.com>
In-Reply-To: <UwXYhs4amR33Eh6Hct6Rq0cpIRr0-Tjg4HvlpD1V9Q_6e9IhXcxxhbz6BUIrabFawS6wduY0Z6HgJSo9CEj1Vy1sIRugFRvLCDA43OUao3s=@protonmail.com>
References: <UwXYhs4amR33Eh6Hct6Rq0cpIRr0-Tjg4HvlpD1V9Q_6e9IhXcxxhbz6BUIrabFawS6wduY0Z6HgJSo9CEj1Vy1sIRugFRvLCDA43OUao3s=@protonmail.com>
Feedback-ID: 33659913:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Testdisk does find btrfs where it should be in the disk, but I don't think =
I can repair that if btrfs doesn't even think it's there.

nixos btrfs-progs v6.3.3
kubuntu live btrfs-progs v5.16.2

uname -a:
Linux localhost 6.4.7/zen1 #1-NixOS ZEN SMP PREEMPT_DYNAMIC Tue Jan 1 00:00=
:00 UTC 1980 x86_64 GNU/Linux

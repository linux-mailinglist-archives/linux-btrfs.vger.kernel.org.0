Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E1C790940
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Sep 2023 20:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjIBSvL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Sep 2023 14:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjIBSvK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 Sep 2023 14:51:10 -0400
X-Greylist: delayed 313 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Sep 2023 11:51:04 PDT
Received: from len.romanrm.net (len.romanrm.net [91.121.86.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71717DD
        for <linux-btrfs@vger.kernel.org>; Sat,  2 Sep 2023 11:51:04 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by len.romanrm.net (Postfix) with SMTP id 9EF7C4013F;
        Sat,  2 Sep 2023 18:45:49 +0000 (UTC)
Date:   Sat, 2 Sep 2023 23:45:40 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     notrandom98234 <notrandom98234@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Corrupted after multiple forceful shutdowns
Message-ID: <20230902234540.48021d91@nvm>
In-Reply-To: <eLb7l_dsyZ22sxuyFDBSxKtxRrxVjT-OubDEVRqQwFHPNiNGbQF5WcoFVbn27A03PzyYZFQ3BbvT8WcpaKIJ9-tRBZd9jzj1JVz0KPlrK7A=@protonmail.com>
References: <UwXYhs4amR33Eh6Hct6Rq0cpIRr0-Tjg4HvlpD1V9Q_6e9IhXcxxhbz6BUIrabFawS6wduY0Z6HgJSo9CEj1Vy1sIRugFRvLCDA43OUao3s=@protonmail.com>
        <LuEE1I-3MHi2t3VMlpKKPCBNlfkqenbbFfZLhEum4QTP0J9pQBKVuYJQP9zJPnOnaKANpJ197S4NygsMibFoaA9X--4JESqunpQW8ZR7Q34=@protonmail.com>
        <eLb7l_dsyZ22sxuyFDBSxKtxRrxVjT-OubDEVRqQwFHPNiNGbQF5WcoFVbn27A03PzyYZFQ3BbvT8WcpaKIJ9-tRBZd9jzj1JVz0KPlrK7A=@protonmail.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 02 Sep 2023 18:29:23 +0000
notrandom98234 <notrandom98234@protonmail.com> wrote:

> Is it possible to recover the files even if it's without the directory
> structure? My data is most probably intact and I only have to recover some
> files..

Check out "btrfs restore"

https://man7.org/linux/man-pages/man8/btrfs-restore.8.html

-- 
With respect,
Roman

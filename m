Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C296A790933
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Sep 2023 20:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjIBS3t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Sep 2023 14:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjIBS3s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 Sep 2023 14:29:48 -0400
Received: from mail-4027.protonmail.ch (mail-4027.protonmail.ch [185.70.40.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0584510E0
        for <linux-btrfs@vger.kernel.org>; Sat,  2 Sep 2023 11:29:40 -0700 (PDT)
Date:   Sat, 02 Sep 2023 18:29:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1693679378; x=1693938578;
        bh=LIx+crWofbuIre6+gfPxfVO0ZNz9uUpFFemUv1bdd9g=;
        h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Ui9PdzV37mS73IKbdpETR/QeWXycn56/eMB+n0R/xPmJT6Ak09qnabtPaFSHSJke1
         sJrmplNomaNd93UxpFQ3+vo4Lx7zYnPDJFDqn+1Ikd1Q04jWDDAEZzApsqQhnbnNJ/
         dcCKpB0gJSfolTXGfWg8VxUC/pOUNKCqx717Cays+byhz5gvClOkGnvwErgbn/9NAM
         sNH6iJDXqepOWP5Ws4KIjWwEZnOWORCdfrPxPNhlk/E1b1ZRmfHYq1PoVXbPmR550t
         E4wR8wRJgfsWOqgwVCGBsoM8FdGchSDl0AN2AA/Xro2WwilvAm0G7igvPAlmBE4JpG
         rPrsol5+5W66A==
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   notrandom98234 <notrandom98234@protonmail.com>
Subject: Re: Corrupted after multiple forceful shutdowns
Message-ID: <eLb7l_dsyZ22sxuyFDBSxKtxRrxVjT-OubDEVRqQwFHPNiNGbQF5WcoFVbn27A03PzyYZFQ3BbvT8WcpaKIJ9-tRBZd9jzj1JVz0KPlrK7A=@protonmail.com>
In-Reply-To: <LuEE1I-3MHi2t3VMlpKKPCBNlfkqenbbFfZLhEum4QTP0J9pQBKVuYJQP9zJPnOnaKANpJ197S4NygsMibFoaA9X--4JESqunpQW8ZR7Q34=@protonmail.com>
References: <UwXYhs4amR33Eh6Hct6Rq0cpIRr0-Tjg4HvlpD1V9Q_6e9IhXcxxhbz6BUIrabFawS6wduY0Z6HgJSo9CEj1Vy1sIRugFRvLCDA43OUao3s=@protonmail.com> <LuEE1I-3MHi2t3VMlpKKPCBNlfkqenbbFfZLhEum4QTP0J9pQBKVuYJQP9zJPnOnaKANpJ197S4NygsMibFoaA9X--4JESqunpQW8ZR7Q34=@protonmail.com>
Feedback-ID: 33659913:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Is it possible to recover the files even if it's without the directory stru=
cture? My data is most probably intact and I only have to recover some file=
s..

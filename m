Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71516F4CBB
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 00:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjEBWBP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 18:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjEBWBO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 18:01:14 -0400
X-Greylist: delayed 1437 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 May 2023 15:01:13 PDT
Received: from mail.fsf.org (mail.fsf.org [IPv6:2001:470:142::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134601980
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fsf.org;
        s=mail-fsf-org; h=MIME-Version:In-reply-to:Date:Subject:To:From:References;
         bh=NAzDzuU1euIqJGGNUni86k03awi1GbywIRcuPBN2/SE=; b=f9bl4HgKoiX7fTOr+0X3jrx5e
        sTACsGVVYafUjgQPQi1yjmVjQcTiReelqhO+MtB73qYNp3Uc8ID8QY3R4CVDQp85Md+bUe4DyQ3bR
        LaW30vStvmercx+JYOART589FUq0Koo03LgAVK9Su9KYjc6ui9gULs36i9yh3T65+//IFJga9vcZP
        FD9LBjrWTUnvJah4z8HcYW85mJnJMbCXPbwr/61P63vXGSW7/gqAxtBgr+Csq1HHeSXzlDQMe6UNg
        3b5weOiOnW6b3OOR17PP8WaLatbBWD5DaFlovj8Miq+T1q0Smosamwq/DQyC5hSNZSrNhoqR22vIC
        0EyOrZEzQ==;
References: <87mt5y4uyj.fsf@fsf.org>
 <c5a798e3-4b58-a074-01a4-def09f136d38@gmail.com> <87cz67nhv6.fsf@fsf.org>
 <5133a57c-09f8-4cd0-633c-4ea921fe2a41@gmail.com>
User-agent: mu4e 1.9.0; emacs 29.0.50
From:   Ian Kelling <iank@fsf.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs receive: ERROR: clone: did not find source subvol (user
 error, not a bug)
Date:   Tue, 02 May 2023 17:22:54 -0400
In-reply-to: <5133a57c-09f8-4cd0-633c-4ea921fe2a41@gmail.com>
Message-ID: <87a5ymct4o.fsf@fsf.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Upon further investigation, I'm pretty sure there was an error on my
end, nothing wrong with btrfs. A cronjob was creating a snapshot on the
wrong host with a name that lead me to think it was from a different
host. Thank you everyone for the help.

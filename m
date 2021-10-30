Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AFE4409FF
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Oct 2021 17:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhJ3Piu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Oct 2021 11:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhJ3Pit (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Oct 2021 11:38:49 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AE7C061570
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Oct 2021 08:36:19 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HhNgL3rmnzQjx8;
        Sat, 30 Oct 2021 17:36:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duxsco.de; s=MBO0001;
        t=1635608172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XkbPhADIaWnjBSdOeqlkvB3ndFttv3wTVgtr2Hbk+rU=;
        b=S7+JINAjCwhX9uFeLbf8W+3LrNBAE4ngGl4J2WlL/I8QnKtKah/8YHNwfygYm0fISX3q6I
        6UABnSYhkmh6hqELwiQUx1iOeJFn9lWGN+xoTzkmWPvA+ommwcpmkEaqgNmuHjzp0NDETJ
        68ni2QmW1gU6oIhgJJtuTa9/Fn1M+EiG80SglcOrN3H4FjvvviTfdolF0dnJdEMMM1XfKs
        GXXY7L/hYYSmCBGkn419LhkL5Bm8ME7/jh1AnAb9y+MGbpCoa4fouDx9gujYSQkA8rPScJ
        i/dmqJ9PmjQ7DtrhrfY29WFctg9QIfa6qWhksJkeo/dAQSkiCcVQ3LfmkSxNPw==
Message-ID: <a83899eaf5e747ec1b007b890d8550958d8760bb.camel@duxsco.de>
Subject: Re: Btrfs failing to make incremental backups
From:   David Sardari <d@duxsco.de>
To:     Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
Date:   Sat, 30 Oct 2021 17:36:05 +0200
In-Reply-To: <d73a72b5-7b53-4ff3-f9b7-1a098868b967@gmail.com>
References: <58d81c70b2c7de2faa209b56ba18143b5bfb6e2a.camel@duxsco.de>
         <3574af93-d40d-1502-3c8b-5c71c2ee1abd@gmail.com>
         <8d2d6b96071b9f50c2a509c71a0eb34fd20b4349.camel@duxsco.de>
         <9eefd0b24436350452e993dce3cf02c4f6284b71.camel@duxsco.de>
         <d73a72b5-7b53-4ff3-f9b7-1a098868b967@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 58343182F
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for the info, I keep that in mind. For me the content of
"${SRC}" and "${DST}" is of no relevance. They just should point out
what we are dealing with: source or destination side

On Sat, 2021-10-30 at 18:02 +0300, Andrei Borzenkov wrote:
> 
> Please understand that mailing list is not a web forum where you can
> scroll up and see previous posts. You previous mail may not be
> available
> when reading so context is lost.
> 
> > bash-5.1# btrfs subvolume show "${DST}/@2021-10-30-095620_files"
> 

OK, I interpreted your message wrongly. You were asking for "involved"
snapshots and I assumed those involved in the "buggy" "btrfs
send/receive" command.

I decided to start with new subvolumes (btrfs subvolume create
@files_new; cp -av --reflink @files/ @files_new/; btrfs subvolume
delete @files; mv @files_new @files). Thereafter, I test again.

> I asked you to show this information for all snapshots that you have
> listed on github for a reason. You so far only provided two source
> snapshots and one received snapshot.
> 
> Anyway, your two source snapshots show the same received UUID which
> confirms what I suspected. It means that every snapshot on
> destination
> will have the same received UUID as well and "btrfs receive" will use
> the wrong snapshot as base to apply change stream.
> 
> The same problem was discussed just recently and pops up with
> regrettable frequency.
> 
> https://lore.kernel.org/linux-btrfs/CAL3q7H5y6z7rRu-ZsZe_WXeHteWx1edZi+L3-UL0aa0oYg+qQA@mail.gmail.com/
> 


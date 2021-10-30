Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F7B440B71
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Oct 2021 21:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhJ3TTs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Oct 2021 15:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhJ3TTr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Oct 2021 15:19:47 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38874C061570
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Oct 2021 12:17:17 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [80.241.60.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HhTZL0CTBzQjgN;
        Sat, 30 Oct 2021 21:17:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duxsco.de; s=MBO0001;
        t=1635621432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dt5j6E39G4l0iMOfg8FN4+//dhkAtLv7htpaXyFi6ZM=;
        b=nvBek84yrNrijPN05QbyDqyvvpZTx8tBksC8L8hj2Nd0PGE6hzjqrdybLTAf4zz0w52L4c
        +TbBmmIk7nGDVVm9np5umBuLhr4mwiOApWIa+7+oIePaCs/BUVvkfHGHTyCnz9trJGZZIb
        WWyF41O5L9MpU2mscJuBPcAt0Ok3P5kl1aqG4+6fiQd2tchcSMoGndmbn8ztHvx7pLyEyq
        N8ywTNXo4hVEUDYd5GlSr5O7CDeS2t3hrcfOdG00AG2/BLyXuIIYv7KJBVFA2LehiTVM0f
        KBze9NSwi2ZnxJ47ID8xRs7MD6noHSlqNQnHjauD5+mD/E1rm3vBU8iuN2h4+g==
Message-ID: <c3212facb413379cfc216d481f97939132051093.camel@duxsco.de>
Subject: Re: Btrfs failing to make incremental backups
From:   David Sardari <d@duxsco.de>
To:     Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
Date:   Sat, 30 Oct 2021 21:17:08 +0200
In-Reply-To: <a83899eaf5e747ec1b007b890d8550958d8760bb.camel@duxsco.de>
References: <58d81c70b2c7de2faa209b56ba18143b5bfb6e2a.camel@duxsco.de>
         <3574af93-d40d-1502-3c8b-5c71c2ee1abd@gmail.com>
         <8d2d6b96071b9f50c2a509c71a0eb34fd20b4349.camel@duxsco.de>
         <9eefd0b24436350452e993dce3cf02c4f6284b71.camel@duxsco.de>
         <d73a72b5-7b53-4ff3-f9b7-1a098868b967@gmail.com>
         <a83899eaf5e747ec1b007b890d8550958d8760bb.camel@duxsco.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5A61E1319
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

That seems to have solved the issue. Ticket closed :) Thanks a lot

-- 
My GnuPG public key:
gpg --auto-key-locate clear,dane --locate-external-key <MyMailAddress>

On Sat, 2021-10-30 at 17:36 +0200, David Sardari wrote:
> I decided to start with new subvolumes (btrfs subvolume create
> @files_new; cp -av --reflink @files/ @files_new/; btrfs subvolume
> delete @files; mv @files_new @files). Thereafter, I test again.


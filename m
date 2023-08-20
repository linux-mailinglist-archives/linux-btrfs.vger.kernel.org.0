Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4FF781EDF
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Aug 2023 18:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjHTQvE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Aug 2023 12:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjHTQvD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Aug 2023 12:51:03 -0400
X-Greylist: delayed 915 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 20 Aug 2023 09:47:07 PDT
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81AF199E
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Aug 2023 09:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1692549102; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=WoM3hyHgKBqY6c7Xi6XuIfBRYLhXnKHc6krHfYM9/Qo2y5esgyhOhplD3D0t/mE8mUK6882Ydy7KEq+z+1NhLoUEK6HrtGHN72hT62Lpzdk4j6HIz2thLb4sypgyvf2iCuYmSrowQcb9/1KTtDk+j/VXXuNlnK/BKQye3BMDYwE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1692549102; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=wCmvHhpH1QHYtE4e51jTIyGgq3B1rCQqxD6tC3RgGPY=; 
        b=eHxPx9qL39haNaY15FOS30bIk3+2ynlyc4D2uqyuowzrVvVqFlEeRX60qDTp1qCDP6bJeaswPa2IIJmo+LAk/j2x9oKVMjmXx6zpA6CKMjfIJlwNgkze+zPwXdwB3EZ2QzPoC0+5jIVZrsHCm2b0kCP80XVvPDFkeO34tsCY8NE=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1692549102;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=wCmvHhpH1QHYtE4e51jTIyGgq3B1rCQqxD6tC3RgGPY=;
        b=WbK7eOXB9lEIgsDRB3qGJoRFIVeOwT36QZeeqo/ulip4HmvIH3O1sVKVcbfkUDsC
        mlyTfEsXsz9SceTI/wklBwigvZv1zIbkV1YGrXidxhM6noQbQ/XK6YSVQxVi1Obt96v
        ZqCUIy0IDJaLSecU2H2BuTxYo11xbkcTr9BfpDTY=
Received: from kampyooter.. (110.226.17.164 [110.226.17.164]) by mx.zoho.in
        with SMTPS id 1692549100420336.8832797080445; Sun, 20 Aug 2023 22:01:40 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     syzbot+d6443e1f040e8d616e7b@syzkaller.appspotmail.com
Cc:     linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org
Message-ID: <20230820163131.205263-1-code@siddh.me>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_cancel_balance
Date:   Sun, 20 Aug 2023 22:01:31 +0530
X-Mailer: git-send-email 2.40.1
In-Reply-To: <000000000000672c810601db3e84@google.com>
References: <000000000000672c810601db3e84@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Cannot reproduce with the repro locally, check on upstream again.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master


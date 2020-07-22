Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562B822950D
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 11:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbgGVJgc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 05:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgGVJgc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 05:36:32 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC46BC0619DC
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 02:36:31 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 9478C9C3F4; Wed, 22 Jul 2020 10:36:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1595410588;
        bh=4EHGmOu1SOYMCYx+ZtKH3ArPHZaYhEcdrZnrlD4UWCo=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=aRH2I0TiKAMU6fL4GofBoJTGpkpT5cA8muJSEJm/doBA86o22GcbqO4CYUj2jzbgS
         6QE1ff1ez5Uqj1h/vv+Sp2XdQ6fP9X9WWEZhfIyXbFLeplHzpB4oaTreiKOh9pldI/
         5oNTqEt7zowvurAIy2/y5i1n28rn1HLH+NGFP4fpxh2oECJddT7jLFRQgEsXeJGs95
         YDMH8GOKSuBNHx52sdzwPTPDenUDsv4RAImOwoh/3dYQjRUwpNyMCZqXtMmwuaA6FQ
         HE3NWwTNFuSGFas08cyW/RTNj0a5EVFqdEEqLnVB1WeO4OAMaR0aencufNFF3fMW7y
         Pc582HQrRXgSQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 7C88E9C36A;
        Wed, 22 Jul 2020 10:36:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1595410583;
        bh=4EHGmOu1SOYMCYx+ZtKH3ArPHZaYhEcdrZnrlD4UWCo=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=EK2/TgrXrFVTDIOWpQtCVujPIYVf7R+1DP6jZq2J3xR1i1xPprJPyW2vgtfJJ+X51
         jrwuvSQXq3ESZkXWOBb3F+cc8uERjSRWYkZKTClaKaeQ6jlBN70jH9aOs1TexEd++D
         BRH7Ev4eeHFu4snlW6CVU19ESHZA80CB85MWxFStFxNUJhMr46BtySwIZZft8IgcFF
         cAGnxC26Buspc3Lj+bAa2P9tl3sTu0ILKrEC/jhEBSvV6gQro4eh5R/K1yic5BBAIV
         2htgS5gW+B63iD2wmjAaD9tvmsNTwAZ1VftffE3aXnz4M2p8XA+B/zcWydXExnknHK
         xBN0gM2Wc8Phw==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id A464813A32A;
        Wed, 22 Jul 2020 10:36:22 +0100 (BST)
Subject: Re: [PATCH][v2] btrfs: introduce rescue=onlyfs
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200721151057.9325-1-josef@toxicpanda.com>
 <cd1ec35d-e9ac-6cee-e0af-d1ecdc111e1e@gmx.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <b36ef7ea-fff2-6828-a6dc-4abcb4f2afff@cobb.uk.net>
Date:   Wed, 22 Jul 2020 10:36:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cd1ec35d-e9ac-6cee-e0af-d1ecdc111e1e@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/07/2020 00:05, Qu Wenruo wrote:
> 
> 
> On 2020/7/21 下午11:10, Josef Bacik wrote:
...
>> -	skip_sum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM;
>> +	skip_sum = (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
>> +		btrfs_test_opt(fs_info, ONLYFS);
> 
> This means, if onlyfs is spcified, csum is completely skipped even it
> matches.
> 
> I'm not yet determined whether it's preferred.
> 
> On one hand, even at recovery, user may want csum verification to detect
> bad copy if possible, but on the other hand, since user is doing data
> salvage, bothering csum could only lead to extra error.

If we are using this option then something very bad has happened to the
filesystem. It would be useful to the user to know whether the checksum
on the file being read is valid or not as a failed checksum will be a
hint that the BAD THING has affected this file (maybe some extent got
incorrectly overwritten by the content of another file, for example). It
would tell the user that they may want to check the file in some other
way or, at least, not rely on its contents.

On the other hand, it may be that the file contents are fine, but the
checksum has been corrupted, so it should also be possible the retrieve
the contents anyway.

Of course, in the face of unknown filesystem corruption, a valid
checksum does not guarantee that the file is uncorrupted. But a bad
checksum gives a strong hint that the file needs additional checking.

I don't particularly care how the user finds out that the checksum is
bad. In my earlier mail, I suggested that this option does not imply
nodatasum and that the user has to specify nodatasum if that is what
they want. However, I would also be happy with (for example) a warning
in the logs if the checksum is not valid.

By the way, is it possible to do a scrub while the filesystem is mounted
with this option? What would happen, in that case, for either real bad
sectors or checksum errors caused by the filesystem corruption?

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973852284C9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 18:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgGUQFy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 12:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgGUQFx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 12:05:53 -0400
X-Greylist: delayed 529 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Jul 2020 09:05:53 PDT
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875AAC061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 09:05:53 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 176A79C426; Tue, 21 Jul 2020 16:56:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1595347017;
        bh=BNqBMdUlVy7bRessxRQef4u7AoSY6o0wHxU5NsXSHyc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=KTeq+hdmB+C6bE9cP6LvsaWCvGfyp5IADPw5Ks0RoaFbSaCm1pz5p+x/np6d/WmWa
         s164qqcE1p3KNJ9nKe/FDIEnfbpJqEcDwgjRmyq/d/DhohqI2bTZ3+jLSwokdj3IJG
         N98k/PC8YAWtVlg9XMk02dNXZZ3qtBotYJlua0KB9v+g4vjV9YPOpyMII5NgyhJnLJ
         h5GvzutcCIfNNZsxXqgbWp7nz8ehCz95n1kmhdrli01PRTZGMEHSV53F0r5TVx4xzG
         NdEyWJF2ITptuyIVlnig1MyXcxi9Ah6LTswvSI+PnF6Ema4TGwvrhXepSVup+AyKnH
         yAa9qSLwrCPyA==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id DED5E9BC69;
        Tue, 21 Jul 2020 16:56:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1595347016;
        bh=BNqBMdUlVy7bRessxRQef4u7AoSY6o0wHxU5NsXSHyc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=sZOr+NUeFgOF00BKQdIQroWX+y0Tgr32T45BxuP78fDWgiYl3vUc3o1jBRS1lRCPO
         e/Nlq2/C5dpisZRp7tVpaETuRHnt8CtN7AbdvKyFBwIzqM/aeOcSVAsK6/wHAVV2Pe
         VGVvs/zV9WWBMmP9Q8n7bYJ2YDFPdEneo6hsvc6jiqz4LicLQDG6Ib45uSWje9kMLB
         ahdTAafCXjye8I9FK9sGHzEyy+ZIM0YjV/Em9W1sjCor9uOYheP1CtRz/6Y2k4GIwl
         2369jtSarnizSe2nhPq5LQvNaaxhcefhtt78RtuDTg63I7ICuwTzS1YhIT7yTAE0Xx
         MmAd7hgXkmvLA==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 8300D139D8B;
        Tue, 21 Jul 2020 16:56:55 +0100 (BST)
Subject: Re: [PATCH][v2] btrfs: introduce rescue=onlyfs
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200721151057.9325-1-josef@toxicpanda.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <69cf9558-5390-8d14-21b2-51f4c82eeed7@cobb.uk.net>
Date:   Tue, 21 Jul 2020 16:56:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200721151057.9325-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/07/2020 16:10, Josef Bacik wrote:
> One of the things that came up consistently in talking with Fedora about
> switching to btrfs as default is that btrfs is particularly vulnerable
> to metadata corruption.  If any of the core global roots are corrupted,
> the fs is unmountable and fsck can't usually do anything for you without
> some special options.
> 
> Qu addressed this sort of with rescue=skipbg, but that's poorly named as
> what it really does is just allow you to operate without an extent root.
> However there are a lot of other roots, and I'd rather not have to do
> 
> mount -o rescue=skipbg,rescue=nocsum,rescue=nofreespacetree,rescue=blah
> 
> Instead take his original idea and modify it so it just works for
> everything.  Turn it into rescue=onlyfs, and then any major root we fail
> to read just gets left empty and we carry on.

Am I the only one who dislikes the name? "onlyfs" does not seem at all
meaningful to me, as a system manager - the people it is apparently
aimed at. I really don't understand what it is supposed to mean and it
sounds like some developer debugging option or something.

If it means "only filesystem" that doesn't make sense to me - the whole
thing is the filesystem. I guess "only data" might be more meaningful
but if the aim is to turn on as much recovery as possible to help the
user to save their data then why not just say so?

Something like "rescue=max", "rescue=recoverymode", "rescue=dataonly",
"rescue=ignoreallerrors" or "rescue=emergency" might be more meaningful.


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB071CCAC7
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 May 2020 14:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgEJMPz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 May 2020 08:15:55 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:36610 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgEJMPz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 May 2020 08:15:55 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 12FA99C3DD; Sun, 10 May 2020 13:15:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1589112953;
        bh=oDYcu0d1a+jhxvv4E7qcIR5w0OfdI+t/Hp+Bkxf+1GY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FSTmOCA8P2a52CQDGLnjRmvOI2ezVHqvPH5VKgNXICl8dnH+jgBYPJqK5d6NcE6ur
         zBWrakpGJmVzMrCj+JmRFE2WcH5J/AxNkpq/dIFrtCLFJABhHBYULQGG0qy4TT7Nns
         7ORjrrGykHU8XtL5CEK9QddL3bwz3OF8R5LsCK7aMVKAaRCd7Zj8UQa05EDk3BqGtK
         fWxqKun5y1rbukPBSyDFeLF2qrptx/VktR74dvEGXHCWz1LZzgDuG/HuOugRsovbiL
         DHtrpiJTQAPYe57NaSPT+b/xsLP8rD+kgOkqDJtt5t9rSaOaZhsJd72DOKKjKXh7a8
         mhpNyaaIFYXhw==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id B1DD19B9D5;
        Sun, 10 May 2020 13:15:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1589112947;
        bh=oDYcu0d1a+jhxvv4E7qcIR5w0OfdI+t/Hp+Bkxf+1GY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gMiMGmQ+Xc3BckJQvSl2WoMUai6NwD+gpD6lDVEv6da4u5bcKxlcih61oiRyPd389
         zzC0PcLaE2XDA/M7yYLy2lm2cIJM9t60L8DZ+hdKrl093gz3hCrynMUvkl1cJniBkv
         oxqijVOCxA3WdWQMTwOr6ltsXgK/6RfXNB/nIm2AO3JJp/ad9//twYzBmAvZEKd4LX
         GX1+4jFjnUrx7mIvv/bwYH4cMTQZGV7EOXy/idc10Tf9DAoFgtC47zaWZPZs3Vt5Nd
         SXJZlaQgawCw4sTtz0xwFWPi+gBNWAgXgltkrq8NDhi2GRDpH/pqhFyB+VavqJjMkK
         LyFxeyTvj3E4g==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id E7F611020E3;
        Sun, 10 May 2020 13:15:46 +0100 (BST)
Subject: Re: Exploring referenced extents
To:     Steven Davies <btrfs-list@steev.me.uk>
Cc:     linux-btrfs@vger.kernel.org
References: <c9a53b726880c5d7dc8092c2078e23a5@steev.me.uk>
 <d89caa53-a3b6-5c4e-a577-a89490064a40@cobb.uk.net>
 <d52ff5969b6026285729bb12d3533dfb@steev.me.uk>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <998f31cf-6fe8-a753-b6b9-e357cd534e8f@cobb.uk.net>
Date:   Sun, 10 May 2020 13:15:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d52ff5969b6026285729bb12d3533dfb@steev.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/05/2020 12:07, Steven Davies wrote:
> The original goal for my script was to answer the question "why does
> qgroups show this snapshot has so much exclusive data?". I keep a record
> of the qgroups reported exclusive sizes over time and occasionally check
> whether backups or snapshotting need to be reconfigured. I figured that
> a list of files and their exclusive extent sizes would show what is
> contributing the most to the exclusive data shown by qgroups.

Ah. In my case I have found the notion of "exclusive" to be useless. I
don't use qgroups but I have on-disk snapshots of pretty much every
subvolume so nothing is really exclusive.

However, I do like to be able to answer questions like "if I was to
remove these three old snapshots, how much space would be freed", and
the other examples in the README for my scripts.

Still, I am very interested to see how you get on -- my scripts only use
FIEMAP today (effectively, using filefrag(8)).

I am seriously considering, after I switch to using the Python library,
building a userspace database of extent usage for files and directory
trees so that the queries can be fast. The challenge, then, is to
maintain it. It would, again, be very much like a usermode version of
qgroups.

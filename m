Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32AEA490A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2019 21:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfFQTz3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jun 2019 15:55:29 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:41858 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbfFQTz3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jun 2019 15:55:29 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id ABF41142BC3; Mon, 17 Jun 2019 20:55:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1560801327;
        bh=rah/SN71I6JmJ1qCh7BOjxgQegfKXXq0PDmRXeB54/Y=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=KKz/hrJQkmeDMs8pZ+/4pWAFLMy8ZjqXsHmEFNQpxu7xc7NYZRumm/EoEx5uUdEeU
         Z3HWOJSdqqnWRJ3LJqB8mpbI6etm6VrybHuUEmBoR1As/Bgve9bvKw2fSS8PdwniRl
         QFZm/ApNZpAi5QuGd0Ib4o7S/asrOg+LOSW4OV9bPmwX0iMx5O3ihme/TvNGsjlqEG
         L61vmasCIA8JXkrOFoUvu06jRw4DjLn0h6exkPHiTrBbwz/trlat+XhQB9Qe5JJAOs
         xn5593ceiRXKmnV6v7xARa5EWd7ELGDllWzX3/xN+SlrUuGACbYYe9L+BRbSo7wKGc
         WiELWxXSXsqtQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 53F1D142BC2
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2019 20:55:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1560801327;
        bh=rah/SN71I6JmJ1qCh7BOjxgQegfKXXq0PDmRXeB54/Y=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=KKz/hrJQkmeDMs8pZ+/4pWAFLMy8ZjqXsHmEFNQpxu7xc7NYZRumm/EoEx5uUdEeU
         Z3HWOJSdqqnWRJ3LJqB8mpbI6etm6VrybHuUEmBoR1As/Bgve9bvKw2fSS8PdwniRl
         QFZm/ApNZpAi5QuGd0Ib4o7S/asrOg+LOSW4OV9bPmwX0iMx5O3ihme/TvNGsjlqEG
         L61vmasCIA8JXkrOFoUvu06jRw4DjLn0h6exkPHiTrBbwz/trlat+XhQB9Qe5JJAOs
         xn5593ceiRXKmnV6v7xARa5EWd7ELGDllWzX3/xN+SlrUuGACbYYe9L+BRbSo7wKGc
         WiELWxXSXsqtQ==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id F27DB6BC26;
        Mon, 17 Jun 2019 20:55:26 +0100 (BST)
Subject: Re: [PATCH RFC] btrfs-progs: scrub: Correct tracking of last_physical
 across scrub cancel/resume
To:     "Graham R. Cobb" <g.btrfs@cobb.uk.net>, linux-btrfs@vger.kernel.org
References: <20190607235501.26637-1-g.btrfs@cobb.uk.net>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <2c415510-8d46-065d-6b38-b8514a8ffcc1@cobb.uk.net>
Date:   Mon, 17 Jun 2019 20:55:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607235501.26637-1-g.btrfs@cobb.uk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/06/2019 00:55, Graham R. Cobb wrote:
> When a scrub completes or is cancelled, statistics are updated for reporting
> in a later btrfs scrub status command. Most statistics (such as bytes scrubbed)
> are additive so scrub adds the statistics from the current run to the
> saved statistics.
> 
> However, the last_physical statistic is not additive. The value from the
> current run should replace the saved value. The current code incorrectly
> adds the last_physical from the current run to the saved value.
> 
> This bug not only affects user status reporting but also has the effect that
> subsequent resumes start from the wrong place and large amounts of the
> filesystem are not scrubbed.
> 
> This patch changes the saved last_physical to track the last reported value
> from the kernel.
> 
> Signed-off-by: Graham R. Cobb <g.btrfs@cobb.uk.net>

No comments received on this RFC PATCH. I will resubmit it shortly as a
non-RFC PATCH, with a slightly improved summary and changelog.

Graham

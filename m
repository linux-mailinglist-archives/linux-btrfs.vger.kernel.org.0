Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3274B2E8411
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Jan 2021 16:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbhAAPZv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Jan 2021 10:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbhAAPZu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Jan 2021 10:25:50 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABD8C061573
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Jan 2021 07:25:09 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 19CFE9C3AA; Fri,  1 Jan 2021 15:24:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1609514663;
        bh=vVwOlnK2wshWTaNG6WHYSKZdkkUy7HpGFofKTK0mxvM=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=VeH6iWk057MASXT7AOLw1HHb6FKUiRou33qnmQn2oh4POaKgbbdePahpmsNeX+dCP
         UCVKIEmewgKEgX/3K/dH6W93YLtgXJF+6YLI0pIdnBoX2zxavnwvZzvbvqpDSd3WTx
         wk8XnwLxGMhmmUfZFWEiXTJOdZnFCGlgqU4RZXlzyhHRhwk6HEW4lbBQRwxGgYgR1D
         ToBvPuuIYYtXAd3uIaG/Gw+USxpFbPvO32zhwqC7cMEjNN6BJGvvdfAyowQ/7mVYwi
         yNlIAAEPC6er8haIZNzP9LSWvHCIqvGaR8zjKAqNiTP8xvcUqUugeuVs66wclhZbrt
         FGIUYiEyXm1Pg==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-5.7 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 648409BBB5;
        Fri,  1 Jan 2021 15:24:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1609514658;
        bh=vVwOlnK2wshWTaNG6WHYSKZdkkUy7HpGFofKTK0mxvM=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=PhwuiufLuaHvm7KaGdR6X8Op0KKWOY8sA3PR/IUPOoD/SoU0gOrIl9HPMrQSxoXS9
         m0AGMnz2qNvebCqIuMRmN1Fg0mIiVEKwP78j2EM/T1tY/7NHc8CzUFo6q1uF1pi4tk
         4Y0QCZHVSpAMOMSG+M0gJKxKsSm0SzWHNnBrInAGBv/dWV2nGZy8OUdfkn0kzw5zB7
         hiWmoF66cvHZTT6IMK6a1y3HvdIJlSfdgAa9sxhm96qZcj9ngBBdmYlyXfOQoCiTKR
         nxUL0jL4jYFikURVFqzW+4zgMhNSUqVPJfwq7WAtbuwmOsp9U8cRKrYJk0vVR9nTIS
         afYwDnaX8+xBw==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 90FFA1C47E8;
        Fri,  1 Jan 2021 15:24:16 +0000 (GMT)
Subject: Re: synchronize a btrfs snapshot via network with resume support?
To:     Cedric.dewijs@eclipso.eu, linux-btrfs@vger.kernel.org
References: <cf2aa5f977e099ba237eb1e9b1fa4fe8@mail.eclipso.de>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <4a1ddc37-09e4-5dbb-fd2d-ea366d436450@cobb.uk.net>
Date:   Fri, 1 Jan 2021 15:24:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cf2aa5f977e099ba237eb1e9b1fa4fe8@mail.eclipso.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/01/2021 14:42, Cedric.dewijs@eclipso.eu wrote:
...
> I'm looking for a program that can synchronize a btrfs snapshot via a network, and supports resuming of interrupted transfers.

Not an answer to your question... the way I would solve your problem is
to do the "btrfs send" to a local file on master, reliably transfer the
file, then do the "btrfs receive" on slave from the file. Reliable file
transfer programs exist (you can even just use rsync --inplace if I
remember correctly).

Unfortunately, that requires that you have enough space on both ends to
store the btrfs-send file.

> 
> Buttersink [1] claims it can do Resumable, checksummed multi-part uploads to S3 as a back-end, but not between two PC's via ssh.

I don't use Buttersink. But if it can do that without storing the file
locally on either end (which I would be slightly surprised about) then
it sounds like that might be the way to do it: essentially you would be
paying AWS for the temporary filespace needed.

Graham

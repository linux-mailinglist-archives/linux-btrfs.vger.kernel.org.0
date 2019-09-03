Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE154A66D8
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 12:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfICKyX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Sep 2019 06:54:23 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:51590 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbfICKyX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Sep 2019 06:54:23 -0400
Received: from tux.wizards.de (pD9EBF359.dip0.t-ipconnect.de [217.235.243.89])
        by mail02.iobjects.de (Postfix) with ESMTPSA id CE91141601CA;
        Tue,  3 Sep 2019 12:54:21 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id 886A0EEBB33;
        Tue,  3 Sep 2019 12:54:21 +0200 (CEST)
Subject: Re: docbook45 is gone
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20190903081704.GA6277@angband.pl>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <78212bc9-4799-d5b2-a230-789d2115a3a9@applied-asynchrony.com>
Date:   Tue, 3 Sep 2019 12:54:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903081704.GA6277@angband.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/3/19 10:17 AM, Adam Borowski wrote:
> Hi!
> I'm afraid that asciidoctor 2.0 dropped support for docbook45.  The
> explanation given is here:
> https://github.com/asciidoctor/asciidoctor/issues/3005
> 
> This makes btrfs-progs fail to build unless docs are off, with:
> asciidoctor: FAILED: missing converter for backend 'docbook45'. Processing aborted.
> 
> Naively bumping the backend to docbook5 makes the output fail to pass
> validation.
> 
> I don't know a thing about docbook nor asciidoc, thus I can't fix this
> myself.  kdave: you did the conversion, could you save us now?

There is a migration guide to DocBook v5.0:
https://docbook.org/docs/howto/howto.html

The changes look mostly search&replace-able, which is why there is
also an xsl to directly perform this conversion.

Hope this helps.

-h

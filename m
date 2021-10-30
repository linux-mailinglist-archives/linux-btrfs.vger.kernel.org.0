Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431F24407FD
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Oct 2021 10:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhJ3IUu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 30 Oct 2021 04:20:50 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:21034 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJ3IUu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Oct 2021 04:20:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 520013F6EE;
        Sat, 30 Oct 2021 10:18:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Yx7VJscd3cYj; Sat, 30 Oct 2021 10:18:18 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id A1C4D3F6E9;
        Sat, 30 Oct 2021 10:18:18 +0200 (CEST)
Received: from [192.168.0.126] (port=45612)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1mgjZC-000GC1-5s; Sat, 30 Oct 2021 10:18:18 +0200
Date:   Sat, 30 Oct 2021 10:18:17 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     Adam Borowski <kilobyte@angband.pl>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <4ec3373.df69821b.17cd047293f@tnonline.net>
In-Reply-To: <YXwgRuMiS2OFYP8+@angband.pl>
References: <20211029155346.19985-1-dsterba@suse.com> <YXwgRuMiS2OFYP8+@angband.pl>
Subject: Re: Btrfs progs pre-release 5.15-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Adam Borowski <kilobyte@angband.pl> -- Sent: 2021-10-29 - 18:24 ----

> On Fri, Oct 29, 2021 at 05:53:46PM +0200, David Sterba wrote:
>> The noticeable changes are in the mkfs defaults:
>> 
>>   * no-holes
>>   * free-space-tree
>       ^^^^^^^^^^^^^^^
>>   * DUP for metadata unconditionally
> 
> \o/ !!!
> 

I'd like to say that the new docs format over at readthedocs is really nice too! 

Well done! 

> -- 
> ⢀⣴⠾⠻⢶⣦⠀
> ⣾⠁⢠⠒⠀⣿⡁
> ⢿⡄⠘⠷⠚⠋⠀ An imaginary friend squared is a real enemy.
> ⠈⠳⣄⠀⠀⠀⠀



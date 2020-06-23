Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9493F205094
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 13:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732225AbgFWLVk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 07:21:40 -0400
Received: from smtp.sws.net.au ([46.4.88.250]:59774 "EHLO smtp.sws.net.au"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732189AbgFWLVk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 07:21:40 -0400
Received: from liv.localnet (unknown [103.75.204.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: russell@coker.com.au)
        by smtp.sws.net.au (Postfix) with ESMTPSA id B042B14894;
        Tue, 23 Jun 2020 21:21:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
        s=2008; t=1592911298;
        bh=Da3KsZj9BJEN7mxOp38Rr/lVl/D7yaEBXuvsLdlaP0g=; l=1450;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yKBDUkAXKQnOXfrXFNW28yLHRGQJywSgWjCzvsoDOnTbR0mqSWsFo9hU8gtfJUlie
         12em0WpuVP4A9XyqQcxffTO8JXUgIegn9eKEecPEk9Et9MZ5Qz2cAFjxLG8Keh/lzk
         Xmta9YtdPCjW+w+LqoeUCjFrHWJoqcTpVWEqUQdY=
From:   Russell Coker <russell@coker.com.au>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs dev sta not updating
Date:   Tue, 23 Jun 2020 21:21:33 +1000
Message-ID: <2562478.diVjGI8Sbc@liv>
In-Reply-To: <00ce925f-e8bb-be84-40bb-25fd215891e6@suse.com>
References: <4857863.FCrPRfMyHP@liv> <6248217.VoG1EAXHid@liv> <00ce925f-e8bb-be84-40bb-25fd215891e6@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tuesday, 23 June 2020 9:13:04 PM AEST Nikolay Borisov wrote:
> > # btrfs fi usa .
> > Overall:
> > Device size:                  62.50GiB
> > Device allocated:             19.02GiB
> > Device unallocated:           43.48GiB
> > Device missing:                  0.00B
> > Used:                         16.26GiB
> > Free (estimated):             44.25GiB      (min: 22.51GiB)
> > Data ratio:                       1.00
> > Metadata ratio:                   2.00
> > Global reserve:               17.06MiB      (used: 0.00B)
> > 
> > Data,single: Size:17.01GiB, Used:16.23GiB (95.43%)
> > /dev/sdc1      17.01GiB
> > 
> > Metadata,DUP: Size:1.00GiB, Used:17.19MiB (1.68%)
> > /dev/sdc1       2.00GiB
> > 
> > System,DUP: Size:8.00MiB, Used:16.00KiB (0.20%)
> > /dev/sdc1      16.00MiB
> > 
> > Unallocated:
> > /dev/sdc1      43.48GiB
> 
> Do you use compression on this filesystem i.e have you mounted with
> -ocompression= option ?

No, used the default mount with the Debian build of kernel 5.6.14.  Everything 
was pretty much default with it.  Made a filesystem, copied a bunch of large 
files to it, tried to read it, got problems.

It was a storage device I suspected of having errors, copying files to/from it 
with BTRFS is a good way of exposing errors.
 
> Based on this data alone it's evident that you don't really have mirrors
> of the data, in this case having experienced the checksum errors should
> have indeed resulted in error counters being incremented. I'll look into
> this.

Thanks.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/




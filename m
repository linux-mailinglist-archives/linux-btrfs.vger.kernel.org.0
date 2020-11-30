Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF112C8AFE
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 18:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgK3R3i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 30 Nov 2020 12:29:38 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:37620 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgK3R3i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 12:29:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id AFA023FBEE;
        Mon, 30 Nov 2020 18:28:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VPoQca0qs3Oh; Mon, 30 Nov 2020 18:28:11 +0100 (CET)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id EA5AC3FC0E;
        Mon, 30 Nov 2020 18:28:10 +0100 (CET)
Received: from [2a00:801:235:3f71::7a2c:d33d] (port=47348 helo=m5-240-163-184.cust.tele2.se)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.93.0.4)
        (envelope-from <system@lechevalier.se>)
        id 1kjmyb-000I9O-I9; Mon, 30 Nov 2020 18:28:37 +0100
Date:   Mon, 30 Nov 2020 18:28:33 +0100 (GMT+01:00)
From:   sys <system@lechevalier.se>
To:     Hugo Mills <hugo@carfax.org.uk>, Josef Bacik <josef@toxicpanda.com>
Cc:     Roman Mamedov <rm@romanrm.net>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Message-ID: <ca5d9e2.92cebc91.1761a32ec87@lechevalier.se>
In-Reply-To: <20201130150409.GH1908@savella.carfax.org.uk>
References: <a3cd057e747862eb7027ac6318bd26c6c36e0c49.1606743972.git.josef@toxicpanda.com> <20201130190805.48779810@natsu> <b92d0141-f68f-ce96-8099-e145ebc6f594@toxicpanda.com> <20201130150409.GH1908@savella.carfax.org.uk>
Subject: Re: [PATCH] btrfs: do not allow -o compress-force to override
 per-inode settings
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Hugo Mills <hugo@carfax.org.uk> -- Sent: 2020-11-30 - 16:04 ----

> On Mon, Nov 30, 2020 at 09:50:13AM -0500, Josef Bacik wrote:
>> On 11/30/20 9:08 AM, Roman Mamedov wrote:
>> > On Mon, 30 Nov 2020 08:46:21 -0500
>> > Josef Bacik <josef@toxicpanda.com> wrote:
>> > 
>> > > However some time later we got chattr -c, which is a user way of
>> > > indicating that the file shouldn't be compressed.  This is at odds with
>> > > -o compress-force.  We should be honoring what the user wants, which is
>> > > to disable compression.
>> > 
>> > But chattr -c only removes the previously set chattr +c. There's no
>> > "negative-c" to be forced by user in attributes. And +c is already unset on all
>> > files by default. Unless I'm missing something? Thanks
>> > 
>> 
>> The thing you're missing is that when we do chattr -c we're setting
>> NOCOMPRESS on the file.  The thing that I'm missing is what exactly we're
>> trying to allow.  If chattr -c is supposed to just be the removal of +c,
>> then btrfs is doing the wrong thing by setting NOCOMPRESS.  We also do the
>> same thing when we clear a btrfs.compression property.
> 
>    If I'm understanding this right, there's more than two states
> here. There's a "default", and there's two "force" options -- forcing
> nocompress, and forcing/allowing compression. If there's no c flag
> set, the file could be in one of two states: default behaviour
> (presumably defined by the value of the mount options), and
> NOCOMPRESS. How do I tell which it is?

 Fsattr (chattr/lsattr) seem to have been a simplified way of exposing the compression xattr to users, wasn't it? Could it not be better to promote the use of btrfs.compression xattrs instead? 

> 
>> I guess the question is what do we want?  Do we want to only allow the user
>> to indicate we want compression, or do we want to allow them to also
>> indicate that they don't want compression? 

I think it is a good thing to have the three options, but we may need to drop the use of chattr/lsattr and go with only xattrs. 

Thanks, 
Forza 

 If we don't want to enable them
>> to disable compression for a file, then this patch needs to be thrown away,
>> but then we also need to fix up all the places we set NOCOMPRESS when we
>> clear these flags.  Thanks,
> 
>    Hugo.
> 
> -- 
> Hugo Mills             | The last man on Earth sat in a room. Suddenly, there
> hugo@... carfax.org.uk | was a knock at the door.
> http://carfax.org.uk/  |
> PGP: E2AB1DE4          |                                        Frederic Brown



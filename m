Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5BDE4AA8
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 14:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503925AbfJYMAl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 08:00:41 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:38484 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503870AbfJYMAk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 08:00:40 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id B4C10142BC6; Fri, 25 Oct 2019 13:00:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1572004838;
        bh=z2R3/wIjiAroIpaPZgutujimo2VOUGI1UeGM8irz3r4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=itZaNIUoqPBmrxSnwJZzuFFOo/xNHr8vyEcQ13myAJUUEJiUq+hupVmACeQLCvUe0
         dqdQr4uCGnvjWEpvNgL568fx/r6DbEDZQVyWHbru+Sh3OM4KXSP/xylqAAnjA84Ch5
         4TpbusdpHH8MvYWha4Lq2QPozsZTt3Qit+1aeFPcARJ57HqMXyReHywlD/Nw1hGktK
         6zfstxNgT32uCiVS/7H8T817Zw7kMHLsab7Tpmfk5wQMKt8ukZM9vNsFxzap+uFfOh
         e31r0w5fJrvYgK6l2XBHsvFa4X82l32JOI/3Sf7SzX+E7eNfx6S4qY2dODwcnLhezv
         l4VaPhnsw1Fxw==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 7C289142BC2;
        Fri, 25 Oct 2019 13:00:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1572004834;
        bh=z2R3/wIjiAroIpaPZgutujimo2VOUGI1UeGM8irz3r4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HGzvs+NpNISdIKghIq+lbOyvMUu0YxoxAVLNxpm3Q2LyBrA1I6eblDVSPfUYfz8Yw
         xyYVcuzrPu84uKTqlQKnrne3jJ8RXbkb8087XCq0uhy3nQRaYol/K5KICao+fy3N5Z
         T+17p8FCDbL9y056p+NCL4l/kutkgXgUsa96Dk3lMj2zzUZeOeo4wiMlSLG9aYuDhU
         AL1upwBfz5YYpkzf5t7Wf9AZIvue0zBJWD79RyZMc+SEX8gsXcL98F5wArtxJDqtah
         BiQTh4Y4rh6h2gVIguzlabMj2iZX0N3BhqMzNLMBfxjpXt9a+v3Go3SCkyYa1OuWjM
         0PpA6+OPg0mAg==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 9A5CE5F45F;
        Fri, 25 Oct 2019 13:00:33 +0100 (BST)
Subject: Re: [PATCH 5/5] btrfs: ioctl: Call btrfs_vol_uevent on subvolume
 deletion
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, mpdesouza@suse.com
References: <20191024023636.21124-1-marcos.souza.org@gmail.com>
 <20191024023636.21124-6-marcos.souza.org@gmail.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <dcfbad52-6e5b-a9cc-e1a7-6b3db8e26e7c@cobb.uk.net>
Date:   Fri, 25 Oct 2019 13:00:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024023636.21124-6-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/10/2019 03:36, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Since the function btrfs_ioctl_snap_destroy is used for deleting both
> subvolumes and snapshots it was needed call btrfs_is_snapshot,
> which checks a giver btrfs_root and returns true if it's a snapshot.
> The current code is interested in subvolumes only.

To me, as a user, a snapshot *is* a subvolume. I don't even know what
"is a snapshot" means. Does it mean "was created using the btrfs
subvolume snapshot command"? Does it matter whether the snapshot has
been modified? Whether the originally snapshot subvolume still exists?
Or what?

I note that the man page for "btrfs subvolume" says "A snapshot is a
subvolume like any other, with given initial content.". And I certainly
have some subvolumes which are being used as normal parts of the
filesystem, which were originally created as snapshots (for various
reasons, including reverting changes and going back to an earlier
snapshot, or an easy way to make sure that large common files are
actually sharing blocks).

I would expect this event would be generated for any subvolume deletion.
If it is useful to distinguish subvolumes originally created as
snapshots in some way then export another flag (named to make it clear
what it really indicates, such as BTRFS_VOL_FROM_SNAPSHOT). I don't know
your particular purpose, but my guess is that a more useful flag might
actually be BTRFS_VOL_FROM_READONLY_SNAPSHOT.

Graham

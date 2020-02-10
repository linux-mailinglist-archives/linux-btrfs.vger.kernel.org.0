Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58FEF157FBE
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 17:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgBJQ03 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 11:26:29 -0500
Received: from zaphod.cobb.me.uk ([213.138.97.131]:54048 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbgBJQ03 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 11:26:29 -0500
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 262F39BC9E; Mon, 10 Feb 2020 16:26:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1581351987;
        bh=46irzY79YQiwUlKUQ0qzcQjt69LhfguidkiaSjdA21w=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=V/7YPI1BD0OKN4kogBnYs2aL8ZVxcdBGlo8nsMBuaXx4Z069xPa5wEKRw/oLLnexV
         VreRRii1/LGatc97C1UFUGU5itORQkcc4u4ZXdKERh1eMvDwIwRyTU2B/ff+y8nVKe
         K+YOQldJ+XXJnRgOJcJ6fSxATAOEbCzh8Dar5s/dKKJQ+AUWIDf4FRmzopSkDjw8La
         HKmy2A2gBhFt/249VEd1Uxe6fiJQzTqKdwnyzUMtvknW1SDW/UWy3p+3g6OfW4d0KO
         RIkfdupHl7wvAfg7jMVdI6t1/TBpCZEctpCOSvcxuol+12PEDB9IIHzTn3fJkPmnx2
         OsVgWp9+ObGXg==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id A51CD9BC02;
        Mon, 10 Feb 2020 16:26:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1581351982;
        bh=46irzY79YQiwUlKUQ0qzcQjt69LhfguidkiaSjdA21w=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=HGaR93Rvu7NSDLb6Jl2+wPKMJkpEHH/mE//Qp9sQM/ApOEqpNz6RwtXulP3Chtbg3
         kOiNabEIl885ffQxjgG6DOAH00QVDmNg5u9Pzaxqy10NV1w/0YOcIQJxFOuHczZ4cw
         6ZQJvebl3eO2QKWfVs2DfU0GRU8fXRwCtmVCs8JSCPsz+Y0XNwy2IQsfWa4YSQC3MU
         bfy2xYUXjQlLJ8b5ABPhbFZszqvwrdIMRILA8WuNk4n6zpROKSn04IBGt4vX6owMSc
         BoNEk9CqUl2yoq+BrjIPrUONz4n0u1zchSOHVQsGGDhG0gjgX+qAf8q9rQxhswpYYU
         714xPyF8rJm6Q==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 5E430C313F;
        Mon, 10 Feb 2020 16:26:22 +0000 (GMT)
Subject: Re: [PATCH] btrfs: Doc: Fix the wrong doc about `btrfs filesystem
 sync`
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <20200210090201.29979-1-wqu@suse.com>
 <20200210160929.GJ2654@twin.jikos.cz>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <49498052-99f8-25b6-1db4-569ebc4658b7@cobb.uk.net>
Date:   Mon, 10 Feb 2020 16:26:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200210160929.GJ2654@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/02/2020 16:09, David Sterba wrote:
> On Mon, Feb 10, 2020 at 05:02:01PM +0800, Qu Wenruo wrote:
>> Since commit ecd4bb607f35 ("btrfs-progs: docs: enhance btrfs-filesystem
>> manual page"), the man page of `btrfs filesystem` shows `sync`
>> subcommand will wait for all existing orphan subvolumes to be dropped.
> 
> But this is not what the docs say, nor what the ioctl claims to do.
> 
> 'trigger cleaning of deleted subvolumes' means that it just starts the
> process in some way (eg. by waking up the cleaner kthread that does the
> actual cleaning).
> 
> For waiting on the subvolumes there's 'btrfs subvol sync' and that works
> as expected.

I agree. The original wording may be unclear (particularly so for users
who may have limited English and be confused by the use of "trigger"),
but it does seem to be different from sync(1) and the proposed change is
worse.

How about:

Force a sync of the filesystem at 'path', similar to the `sync`(1)
command. In addition, it starts cleaning of deleted subvolumes. To wait
for subvolume deletion to complete use the `btrfs subvolume sync` command.

SEE ALSO
 btrfs-subvolume(8)

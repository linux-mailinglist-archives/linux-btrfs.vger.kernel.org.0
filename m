Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07FE3D7C35
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 19:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbhG0ReJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 13:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhG0ReI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 13:34:08 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4336C061757
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 10:34:08 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 901049C2B4; Tue, 27 Jul 2021 18:34:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1627407243;
        bh=uk4FJW8dGWeq4mkyYc3Uood1NbjI5HNG4df2LnWquhE=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=ZWlU/NfBHmSyhc/ki3+Djd12NXIIZN0mLBn+DT3itcFUO/dX296Iv0wiIv8IJskTU
         83QNmrds7ezgzO6kNcXVvDCoR6dwAcehWxHhsjZL03uMqzFIh9QAks9J6jWxooR04R
         am88CW/K7SpoJPsqbTglxjVFwXDHS3dGc0W3iteksKECVbpc2TaY2GasR1NRRiFQQk
         LvSl9sW7f0rp1e9JVv1oHxkZCC9ZZ3TmuGRcAshpqN1Jj9rVzgOVorQy3ZxjqTJCHg
         YE+mwTvr20vzzV3nJZ0EEzhQQfxrCVE/QWSbxcdFDMBy9dkkI8Rfv9vqYjRqKp8Y3n
         6/89SRc4zCrcQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-2.7 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED,URIBL_SBL,
        URIBL_SBL_A autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 4477D9BBB8;
        Tue, 27 Jul 2021 18:34:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1627407240;
        bh=uk4FJW8dGWeq4mkyYc3Uood1NbjI5HNG4df2LnWquhE=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=N3buxth13Y9Wo3kHHRvGr/wo6Xn6kjGS/eSM8OGOXTlyB3CT6zVyuiW80fwYR/qpZ
         +8X4S1lDgHqv/VrEgzGUfbzpRLs47xIdBvdGFeIv+W6t7I1NZIB1O4tdGSY1O6h3OB
         sCuGWOYvFACYDfbIIyl09AeTcZEx7DoC9VQQUdjFZ6+PjLDmiDehxM1QGxP4jf6K2Y
         /xBgg/QLDucxyoM982uil7YN9Gn/c1HrXUL7bBPgKfsBD/mdtZsJSlFE/0Mz+SBW32
         +TUtkjnaAX6Kd9WEZRL2yGGt+uwBEqm9XBgERX6c8uLuWdWFR4AjzM5e2aPjkLlJCZ
         KPOljyeOtVAtQ==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id CBA45274FBD;
        Tue, 27 Jul 2021 18:33:59 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Dave T <davestechshop@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB4EspQpmK-uK_5bC2iXdx4X-SxsOrF9DC9dF6g0jqrJpA@mail.gmail.com>
Subject: Re: reorganizing my snapshots: how to move a readonly snapshot?
 (btrbk)
Message-ID: <d6444a8d-f232-0744-1bcc-34457f0fcc3e@cobb.uk.net>
Date:   Tue, 27 Jul 2021 18:33:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGdWbB4EspQpmK-uK_5bC2iXdx4X-SxsOrF9DC9dF6g0jqrJpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 27/07/2021 17:47, Dave T wrote:
> I'm using btrbk to create regular snapshots. I see a way I can improve
> the organization of my snapshots now that I have more experience with
> this tool, but it requires moving existing snapshots to a different
> directory.
> 
> I would prefer to avoid re-creating the full initial snapshot in the
> new location and I would prefer to avoid losing the existing
> incremental snapshots. I also want to preserve the existing parent
> relationships used by my snapshot tools (mainly btrbk).
> 
> I'm thinking about using the solution mentioned here:
> https://unix.stackexchange.com/a/149933
> 
>> To set a snapshot to read-write, you do something like this:
>> btrfs property set -ts /path/to/snapshot ro false
> 
> My plan would be to change the ro property to false, move the
> snapshots, reset the ro property to true, and change my btrbk.conf to
> match the new path.
> 
> What are the caveats in this plan?

I believe that setting snapshots read-write and then back to ro is not
recommended and is unsupported. It may work but I am sure I have seen
reports of problems with send/receive when snapshots have been made rw,
changed and then set ro again.

I recommend using the btrbk archive feature to move your existing
snapshots and then start building on top of those. I think I did exactly
this a long time ago when I was in a similar position of wanting to move
my btrbk setup.

Graham

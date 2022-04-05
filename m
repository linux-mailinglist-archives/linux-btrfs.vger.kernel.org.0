Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E504F5440
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 06:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391283AbiDFEqk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 00:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1587877AbiDFAKn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 20:10:43 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D12DA0BE
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 15:36:01 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id ED1FFC01D; Wed,  6 Apr 2022 00:35:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1649198157; bh=c4O6il5kWGpFyEaqDcisvmQ+DmfAGO+9GMA9Ik3IrUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DtJoEWmqMWVAc4LPYte//euyvyEM+G8UDkoxqi454ebX9p8DnfUdADA1TwB05Vec0
         FU6gJGGr5btOBF4SPRxqFU5KUR1duAXGeVIh/9vb1lCxdd3o8pvDKWpT8Zd/MJOjfy
         qGVNodViZ/CBKdPENTFeSBhrHyAGVllDux4jkc3GMhg1l5kvS3emOlOER77pp6QGyZ
         L+HZQfCuDoZMd7LROfdN7xWvivPBh7I5sQFJTl/rg6DXo5oWRCDnYFaV3lGktJud+b
         DsHGVclNrjZBlQAZ+IhP2INh6gOqx2VBFwutHJdtR1OdiMvnnd1r2IT8TWRF3HKVO7
         GyyK5ghkR+Z1g==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 066F6C009;
        Wed,  6 Apr 2022 00:35:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1649198157; bh=c4O6il5kWGpFyEaqDcisvmQ+DmfAGO+9GMA9Ik3IrUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DtJoEWmqMWVAc4LPYte//euyvyEM+G8UDkoxqi454ebX9p8DnfUdADA1TwB05Vec0
         FU6gJGGr5btOBF4SPRxqFU5KUR1duAXGeVIh/9vb1lCxdd3o8pvDKWpT8Zd/MJOjfy
         qGVNodViZ/CBKdPENTFeSBhrHyAGVllDux4jkc3GMhg1l5kvS3emOlOER77pp6QGyZ
         L+HZQfCuDoZMd7LROfdN7xWvivPBh7I5sQFJTl/rg6DXo5oWRCDnYFaV3lGktJud+b
         DsHGVclNrjZBlQAZ+IhP2INh6gOqx2VBFwutHJdtR1OdiMvnnd1r2IT8TWRF3HKVO7
         GyyK5ghkR+Z1g==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 90d0f19a;
        Tue, 5 Apr 2022 22:35:53 +0000 (UTC)
Date:   Wed, 6 Apr 2022 07:35:38 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: Re: [RFC PATCH] btrfs-progs: prop: add datacow inode property
Message-ID: <YkzEOswx7te3B6uC@codewreck.org>
References: <20220324042235.1483914-1-asmadeus@codewreck.org>
 <YkPuYyoV6LRWJdbS@codewreck.org>
 <85af4827-0a21-80d4-5d60-43e0e398a4e2@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85af4827-0a21-80d4-5d60-43e0e398a4e2@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for the reply!!

Nikolay Borisov wrote on Tue, Apr 05, 2022 at 05:21:06PM +0300:
> On 30.03.22 г. 8:45 ч., Dominique Martinet wrote:
> > If you just say 'no' I'll bite the bullet and install e2fsprogs just for
> > btrfs and document the command, but as things stand my users (embedded
> > device developpers) have no way of disabling cow for e.g. database
> > workloads and that's not really good long-term.
> 
> Just my 2 cents: I think we should strive to rely as much as possible on the
> generic infrastructure where we can. The nocow options is one such case. The
> way I see it btrfs property is used to manage features which are indeed
> specific to btrfs and have no generic alternative.

That's not what the man page says:

       btrfs property provides an unified and user-friendly method
       to tune different btrfs properties instead of using the
       traditional method like chattr(1) or lsattr(1).

I appreciate not wanting to duplicate code however, but documentation
should be adjusted if that is what we want to do.


> What's more I don't see how 'chattr +C /some/path' can be considered
> 'complex' to teach someone, plus chattr is a standard linux utility.

Well, '+C' is harder to remember than 'datacow', so in that sense yes it
is more complex to teach someone from that regard.

My users are mostly windows users who barely ever used linux, and I'm
throwing a listing of command they should use in which conditions in our
product manual, so it's much more coherent to have a group of 'btrfs
property set' commands where I explain ro/compression/datacow together
than resort to 'chattr' on one.

Yes, there are other generic chattr commands that work on btrfs (append
only, immutable come to mind immediately), but compression and datacow
are historically handled differently for btrfs... Admittedly not a very
good reason, the above and manual page paragraph I quoted are more
important to me.
(Speaking of which if the mountpoint has compress=smth, lsattr doesn't
list +c and `btrfs property set x compression none` doesn't seem to
cancel it, so I see no way of disabling compression on a single file in
that case on 5.17.1 -- didn't that use to work?)



Another reason for me would be that, on alpine linux, chattr is packaged
as part of e2fsprogs-extra, which grows my root filesystem by a whole
2MB.

This might not seem much, but when I have to make everything fit in
<200MB every bit counts. Adding a new flag here doesn't increase the
size of the system much.
(busybox has a chattr implementation, but for some reason it's not
enabled on alpine linux -- I'll request to consider enabling it after
checking how big it is if this isn't wanted here)


Thanks,
-- 
Dominique

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722A8519C7E
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 12:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241026AbiEDKGd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 06:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiEDKGc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 06:06:32 -0400
Received: from ssl1.xaq.nl (ssl1.xaq.nl [45.83.234.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E5C27FDD
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 03:02:56 -0700 (PDT)
Received: from kakofonix.xaq.nl (kakofonix.utr.xaq.nl [192.168.64.105])
        by ssl1.xaq.nl (Postfix) with ESMTPSA id 8B64E81B3F
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 12:02:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucassen.org;
        s=202104; t=1651658574;
        bh=rzfg1Md5jwW2spaWz95U4UsKFv8PI+qSO0VxWYplhds=;
        h=Date:From:To:Subject:In-Reply-To:References:Reply-To;
        b=q00+ivOsiRiKGkwtB3EK6lXlguwOmt0mIhxWthyqGQZxq8ErGzJV6IOQA/UWbCPqA
         Ew+D1rx88OM3heU4q3oWiBtizWvtr+KMEREHAqqHPoqqHvNWd4aTeGcxZM3FabrDdW
         +e3mxlg6OV5wjkN6Zp8FcagXIAn5+y58G1ohLWhKLpF6Cc6win/J/aPhIfOy+cECwP
         nU6uH5RqRMHkF8cirbHoh0iej5g1KeYQX0XlyVLZwy1v1fxP8aE1t61jFd89P0aBkU
         3MzxUHGj//a7+77kaSrg/nh75EcedWFFjItpoBHt1ooD/1QFnLKWVPehaxPe5C4W+L
         RVLLUjv0DwBbg==
Date:   Wed, 4 May 2022 12:02:54 +0200
From:   richard lucassen <mailinglists@lucassen.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Debian Bullseye install btrfs raid1
Message-Id: <20220504120254.7fae6033bee9e63ed002bea9@lucassen.org>
In-Reply-To: <c0a5db9f-2631-9177-929c-9e76a9c67ec5@suse.com>
References: <20220504112315.71b41977e071f43db945687c@lucassen.org>
        <c0a5db9f-2631-9177-929c-9e76a9c67ec5@suse.com>
Reply-To: linux-btrfs@vger.kernel.org
Organization: XAQ Systems
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 4 May 2022 12:27:29 +0300
Nikolay Borisov <nborisov@suse.com> wrote:

> > Question: is this newbie trying to set up an impossible config or
> > have I missed something crucial somewhere?
> 
> That's the default behavior, the reasoning is if you are missing one 
> device of a raid1 your data is at-risk in case the 2nd device fails.
> You can override this behavior by mounting in degraded mode, that is
> mount -odegraded

Another thing: sda3/sdb3 is the root fs, so I need to tell grub that
it's ok to mount a degraded array (one or another way, don't know
if it's possible, I'm not a grub guru). Adding it to fstab makes
no sense as there is no fstab at that time.

OTOH, when using md devices, the / fs is mounted as Degraded Array and
the remaining device remembers that this had happened. If the second
disk is replaced I have to add it manually using mdadm. The first disk
is "master". Using md the system boots and mounts / and thus all tools
are available to repair the array.

The wiki explains how to repair an array, but when the array is the
root fs you will have a problem.

So, what should I do when the / fs is degraded?

R.

-- 
richard lucassen
https://contact.xaq.nl/

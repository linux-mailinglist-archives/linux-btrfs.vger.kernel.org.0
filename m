Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44DE21B461
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 12:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfEMK5y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 06:57:54 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:53061 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728114AbfEMK5y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 06:57:54 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E7996499;
        Mon, 13 May 2019 06:57:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 13 May 2019 06:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=J
        QftPFBpexu4d8C8fzDQ8C49x4SU+NTGu5TVTjmRWIs=; b=izXUlhxc/wDyXZeMJ
        uXsrq48nZKVQLheHQMuG6o6KwYivrD1B4zTXtWZbrO/Z3uS789PhaN+Bji3DNWcf
        iz8uQ95fJnI2dhehT3uE21FOnSNXtJu0CipF4BKZvRXxkNQOBUvmtlYlDJouEE+0
        k4+b51AQdQuMqlqaaZ6dMCYVgp+C2Gmc/S01unRusmLLaP0XZ2Z0TA+vbVHcTsUr
        wuKqyNL8EIYjvAPLdxbMn37p4GKhdF3hoNapjg0mI6+DvFhwQ2j8cluMZYdSqLNY
        rF06PafWjXpcYuOlaKq4wiFgTv251eqZVHSeYFAjItM/TFzbgmTJ/Bs+57hKZhAR
        oDJpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=JQftPFBpexu4d8C8fzDQ8C49x4SU+NTGu5TVTjmRW
        Is=; b=ntAHxh8nfe76KiEWgBX4wGzJrUm7F7uywHiR7PAy0G4uwKzvsYG+RFpYt
        Qdn/7J4Jnfymns4DY+DNEjnJ6qTTn0hi8YZa5Ey7ESs27oUgNEvZkq8vjoBkivaY
        ortUfh6wo/SYzSBwjhM4ewm2E9o2gSePzo6PB64qerf9PoXCfZkBKirhQsUz7ACG
        pOS+LTKrSga+yWFSwoOhs5VRqOHueFgnqWS2oyunEEusvTA9MTh7MIvLXR/fB6cB
        mahsEevoDY9O6onSGW9B1qovGKWn0+lKngLevih93EhGZWb/WdJNax8X7v3j3nyC
        keFi7Qj2LgiyHsuzUXnYzHSimxYvg==
X-ME-Sender: <xms:sE3ZXEkWLei9g1hq4tUp5a1IuAF_M9Nbnv6ZJACogWAgeOB_VnEnNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleeggdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtugfgjgfofgesthekredt
    oferjeenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvdegrdduieelrdduiedrudekheenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:sE3ZXJqqKmb34iqwy9XBdB84uXy1NUcK7049qgh7NkJe79gsKrCb0A>
    <xmx:sE3ZXEsV28zaBOFqSlO_Pkc026qR5kO1fRE7wPoFeTLzF3ptOjq9xQ>
    <xmx:sE3ZXJKJLqzAC4byab5ghQda398_GzYYurBQ43BwHaGSp8tflGfZXw>
    <xmx:sE3ZXDkZt4jg7yQdl0CX6M9oVSkpkS1ZnjleSonWm3gDHLqy2UtFrg>
Received: from localhost (124-169-16-185.dyn.iinet.net.au [124.169.16.185])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3E18080061;
        Mon, 13 May 2019 06:57:50 -0400 (EDT)
Date:   Mon, 13 May 2019 20:57:20 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: btrfs: Don't leak memory when failing add fsid
Message-ID: <20190513105720.GB15053@eros.localdomain>
References: <20190513033912.3436-1-tobin@kernel.org>
 <20190513033912.3436-3-tobin@kernel.org>
 <3473fcfa-88cf-b372-3beb-69d59320d50a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3473fcfa-88cf-b372-3beb-69d59320d50a@suse.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 13, 2019 at 09:04:49AM +0300, Nikolay Borisov wrote:
> 
> 
> On 13.05.19 г. 6:39 ч., Tobin C. Harding wrote:
> > A failed call to kobject_init_and_add() must be followed by a call to
> > kobject_put().  Currently in the error path when adding fs_devices we
> > are missing this call.  This could be fixed by calling
> > btrfs_sysfs_remove_fsid() if btrfs_sysfs_add_fsid() returns an error or
> > by adding a call to kobject_put() directly in btrfs_sysfs_add_fsid().
> > Here we choose the second option because it prevents the slightly
> > unusual error path handling requirements of kobject from leaking out
> > into btrfs functions.
> > 
> > Add a call to kobject_put() in the error path of kobject_add_and_init().
> > This causes the release method to be called if kobject_init_and_add()
> > fails.  open_tree() is the function that calls btrfs_sysfs_add_fsid()
> > and the error code in this function is already written with the
> > assumption that the release method is called during the error path of
> > open_tree() (as seen by the call to btrfs_sysfs_remove_fsid() under the
> > fail_fsdev_sysfs label).
> 
> I'm not familiar with the internals of kobject but
> btrfs_sysfs_remove_fsid calls __btrfs_sysfs_remove_fsid which in turn
> does kobject_del followed by kobject_put so its sequence is not exactly
> identical with your change. Presumably kobject_del is only required if
> you want to dispose of successfully registered sysfs node. This implies
> that __btrfs_sysfs_remove_fsid is actually broken when it comes to
> handling failed sysfs_add_fsid?

kobject_del() is not technically required in __btrfs_sysfs_remove_fsid()
since if kobject_put() drops the reference count to 0 and kobject_del()
has not been called then the kobject infrastructure will call
kobject_del() for us (and we get a pr_debug() message).  The code
sequence is correct although not _exactly_ written as the kobject
authors intended (I am not one of those authors, I'm just learning).

Thanks for looking at this.

	Tobin

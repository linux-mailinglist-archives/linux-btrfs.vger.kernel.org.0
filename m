Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB99C28B56C
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Oct 2020 15:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgJLNDB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Oct 2020 09:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgJLNDB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Oct 2020 09:03:01 -0400
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1769C0613D0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Oct 2020 06:03:00 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1kRxUz-0006EU-N8; Mon, 12 Oct 2020 14:04:21 +0100
Date:   Mon, 12 Oct 2020 14:04:21 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Zhang Boyang <zhangboyang.id@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [discuss] GUI for "btrfs inspect-internal"?
Message-ID: <20201012130421.GB21246@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Zhang Boyang <zhangboyang.id@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <37457d69-df20-7280-0707-c5e69dabb48d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37457d69-df20-7280-0707-c5e69dabb48d@gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 12, 2020 at 07:33:52PM +0800, Zhang Boyang wrote:
> Hello all,
> 
> I'm a learner of btrfs, I found "btrfs inspect-internal" is very useful.
> However it's seems not user friendly. For example, if I want view
> EXTENT_DATA for some inode, I need to walk through root to leaf (I'm not
> sure), which is a boring task.
> 
> I want to develop a GUI for "btrfs inspect-internal". Basically it will
> communicate with "btrfs inspect-internal" CLI using pipes.
> 
> +------------------------+
> | btrfs inspect-internal |
> +------------------------+
>            | pipe
>  +---------------------+                   +---------------+
>  |    backend server   |-------------------|  web browser  |
>  | maybe: python+flask |       http        |     (GUI)     |
>  +---------------------+                   +---------------+
> 
> 
> The GUI will include features like "click block offset to jump", "view
> history", "jump to inode", etc.
> 
> Do you think this is a good idea? Comments are welcome.

   This is certainly something I've considered doing. I'd say a few
points to think about (having done so myself):

 - Make sure that the "GUI" on the browser side works in plain text
   mode with lynx or links or similar. This is likely to be useful as
   a diagnostic tool, possibly in environments with no network or
   desktop to support a graphical JS-enabled browser.

 - Think carefully about the URI structure for your server. Every
   individual item in the filesystem (metadata block, inode, tree,
   tree entry, extent, ...) should have its own unique URI, and you
   should be able to do the navigation between these things.

 - Filesystems being investigated like this are more likely than not
   going to be broken in some way. Make sure your code is robust to
   that.

 - Piping direct from inspect-internal is maybe not the best approach,
   as you'll be spending quite a lot of time parsing text from it. For
   a mountable filesystem, using something like python-btrfs to access
   the search ioctls might be a better approach; for a filesystem
   that's not mountable, you're going to have to hit the block device
   directly.

 - Due to the above, consider writing your code to separate the
   presentation mechanism from the metadata-reading mechanism, so that
   it's easier to switch out one FS-reader for another.

   Hugo.

-- 
Hugo Mills             | In the future, terrorists won't be carrying their ID
hugo@... carfax.org.uk | cards. They'll be carrying yours.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                          Henry Porter, Suspect Nation

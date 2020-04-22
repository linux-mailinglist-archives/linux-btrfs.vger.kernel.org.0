Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182311B3702
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 07:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgDVFyc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 01:54:32 -0400
Received: from magic.merlins.org ([209.81.13.136]:57442 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgDVFyb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 01:54:31 -0400
Received: from svh-gw.merlins.org ([173.11.111.145]:53686 helo=saruman.merlins.org)
        by mail1.merlins.org with esmtps 
        (Cipher TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.92 #3)
        id 1jR8L1-0003sk-VH; Tue, 21 Apr 2020 22:54:23 -0700
Received: from merlin by saruman.merlins.org with local (Exim 4.80)
        (envelope-from <marc@merlins.org>)
        id 1jR8L1-00047l-LH; Tue, 21 Apr 2020 22:54:23 -0700
Date:   Tue, 21 Apr 2020 22:54:23 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: 5.4.20: cannot mount device that blipped off the bus: duplicate
 device fsid:devid for
Message-ID: <20200422055423.GB21716@merlins.org>
References: <1aaae706-0029-be4f-9f6f-194b03087b35@suse.com>
 <20200325201455.GO29461@merlins.org>
 <a9dd1b1a-b38e-a0f4-91e1-b89063e8ae1e@oracle.com>
 <20200326013007.GS15123@merlins.org>
 <0d2ea8e2-cbe8-ca64-d0d4-fa70b8cad8b1@oracle.com>
 <20200326042624.GT15123@merlins.org>
 <20200414003854.GA6639@merlins.org>
 <07166dd6-4554-a545-9774-a622890095a7@oracle.com>
 <20200420145659.GA26389@merlins.org>
 <0333488d-79d1-7252-cfce-df12ddb424ea@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0333488d-79d1-7252-cfce-df12ddb424ea@oracle.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 173.11.111.145
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 21, 2020 at 03:33:24PM +0800, Anand Jain wrote:
> 
> Marc,
> 
>  Could you please use the kernel patch (sent to the list or at
>  git@github.com:asj/btrfs-boilerplate.git boilerplate-v5.6) it can dump

Thanks.
Since it might not be super obvious to someone else how to get it, 
the actual patch is:
https://github.com/asj/btrfs-boilerplate/commit/f6874237fbe66c281b5bf84ead41983fb43ed9b9

or wget https://github.com/asj/btrfs-boilerplate/commit/f6874237fbe66c281b5bf84ead41983fb43ed9b9.patch

> $ cat /proc/fs/btrfs/devlist

I patched this in my 5.6 kernel, installed, rebooted, and I can confirm
it's working.

I'll report back in due time :)

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

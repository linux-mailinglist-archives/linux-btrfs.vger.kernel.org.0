Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3B642BCF3
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 12:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhJMKjQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 06:39:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:32956 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhJMKjP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 06:39:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4C56C201D9;
        Wed, 13 Oct 2021 10:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634121427;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pKSluFKkBVAA18SsOSV/5ZcwBta2nEJU0AbYjAs4tzY=;
        b=rdlnNv68JbUC/Zvmr8dCrT5cdmSpFH4VFGJ70jtcmFgv8Td5dHpC6ZP5yDqFFi2VIK/4C/
        jSOrPwTCnGuy5bO9rodO2Fl8LcC+4rEYdBYptjQbMFo8dr6dLbHc6TjrMyBjVI2m9QEvf4
        Iu78F7X+ZH85yb9o+VYwQcVtVSUDr/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634121427;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pKSluFKkBVAA18SsOSV/5ZcwBta2nEJU0AbYjAs4tzY=;
        b=D2JcCHU8MiUK2y+4Z7VzWk8qoMCc6NOkhBZGmhPuo3N7NT9dSFr9xd1/k4uOH9To8xIKzX
        cifviSva3MlGf6CA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1139AA3B89;
        Wed, 13 Oct 2021 10:37:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F4050DA7A3; Wed, 13 Oct 2021 12:36:42 +0200 (CEST)
Date:   Wed, 13 Oct 2021 12:36:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qing Wang <wangqing@vivo.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: replace snprintf in show functions with sysfs_emit
Message-ID: <20211013103642.GC9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Qing Wang <wangqing@vivo.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1634095717-4480-1-git-send-email-wangqing@vivo.com>
 <6f03e790-6f21-703f-c761-a034575f465e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f03e790-6f21-703f-c761-a034575f465e@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 13, 2021 at 03:51:33PM +0800, Anand Jain wrote:
> On 13/10/2021 11:28, Qing Wang wrote:
> > coccicheck complains about the use of snprintf() in sysfs show functions.
> 
> It looks like the reason is snprintf() unaware of the PAGE_SIZE 
> max_limit of the buf.
> 
> > Fix the following coccicheck warning:
> > fs/btrfs/sysfs.c:335:8-16: WARNING: use scnprintf or sprintf.
> 
> Hm. We use snprintf() at quite a lot more places in sysfs.c and, I don't 
> see them getting this fix. Why?

I guess the patch is only addressing the warning for snprintf, reading
the sources would show how many more conversions could have been done of
scnprintf calls.

> > Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> Below commit has added it. Nice.
> 
> commit 2efc459d06f1630001e3984854848a5647086232
> Date:   Wed Sep 16 13:40:38 2020 -0700
> 
>      sysfs: Add sysfs_emit and sysfs_emit_at to format sysfs out

The conversion to the standard helper is good, but should be done
in the entire file.

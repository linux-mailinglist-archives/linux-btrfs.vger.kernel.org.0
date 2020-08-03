Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4965523A0B1
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 10:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgHCIM0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 04:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgHCIM0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Aug 2020 04:12:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24B7D2065E;
        Mon,  3 Aug 2020 08:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596442344;
        bh=RKalgdiYlR+G0pvUtSEnO+u1nBVfhaI4/jDMjgGDEWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=azvxcqEaIVIboo52XNzP9zs6V6Pcoh9pK5mQ/fTB2/sef6cbFsLw3tuOS6+9Cmm8G
         S6thU+2qlTL6nwSDlHCSOVKjA5S1FSkbzwwmtUreuKz1MF4EeyNxqrw7fPOhAS/F2H
         v9WBGz+V92wJl30PSn/+3HLbC5vzptiRHq2JJyGc=
Date:   Mon, 3 Aug 2020 10:12:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <guenter@roeck-us.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] kobject: Avoid premature parent object freeing in
 kobject_cleanup()
Message-ID: <20200803081205.GA493272@kroah.com>
References: <1908555.IiAGLGrh1Z@kreacher>
 <d1e90fa3-d978-90ae-a015-288139be3450@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1e90fa3-d978-90ae-a015-288139be3450@gmx.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 03, 2020 at 02:31:23PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/6/5 上午1:46, Rafael J. Wysocki wrote:
> > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > 
> > If kobject_del() is invoked by kobject_cleanup() to delete the
> > target kobject, it may cause its parent kobject to be freed
> > before invoking the target kobject's ->release() method, which
> > effectively means freeing the parent before dealing with the
> > child entirely.
> > 
> > That is confusing at best and it may also lead to functional
> > issues if the callers of kobject_cleanup() are not careful enough
> > about the order in which these calls are made, so avoid the
> > problem by making kobject_cleanup() drop the last reference to
> > the target kobject's parent at the end, after invoking the target
> > kobject's ->release() method.
> > 
> > [ rjw: Rewrite the subject and changelog, make kobject_cleanup()
> >   drop the parent reference only when __kobject_del() has been
> >   called. ]
> > 
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> > Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > Hi Greg,
> > 
> > This is a replacement for commit 4ef12f719802 ("kobject: Make sure the parent
> > does not get released before its children"), that you reverted, because it
> > broke things and the reason why was that it was incorrect.
> > 
> > Namely, it called kobject_put() on the target kobject's parent in
> > kobject_cleanup() unconditionally, but it should only call it after
> > invoking __kobject_del() on the target kobject.
> > 
> > That problem is fixed in this patch and a functionally equivalent patch has
> > been tested by Guenter without issues.
> > 
> > The underlying issue addressed by the reverted commit is still there and
> > it may show up again even though the test that triggered it originally was
> > fixed in the meantime.  IMO it is worth fixing even though it may not be
> > readily visible in the current kernel, so please consider this one for
> > applying.
> > 
> > Cheers!
> > 
> > ---
> >  lib/kobject.c |   33 +++++++++++++++++++++++----------
> >  1 file changed, 23 insertions(+), 10 deletions(-)
> > 
> > Index: linux-pm/lib/kobject.c
> > ===================================================================
> > --- linux-pm.orig/lib/kobject.c
> > +++ linux-pm/lib/kobject.c
> > @@ -599,14 +599,7 @@ out:
> >  }
> >  EXPORT_SYMBOL_GPL(kobject_move);
> >  
> > -/**
> > - * kobject_del() - Unlink kobject from hierarchy.
> > - * @kobj: object.
> > - *
> > - * This is the function that should be called to delete an object
> > - * successfully added via kobject_add().
> > - */
> > -void kobject_del(struct kobject *kobj)
> > +static void __kobject_del(struct kobject *kobj)
> >  {
> >  	struct kernfs_node *sd;
> >  	const struct kobj_type *ktype;
> > @@ -625,9 +618,23 @@ void kobject_del(struct kobject *kobj)
> >  
> >  	kobj->state_in_sysfs = 0;
> >  	kobj_kset_leave(kobj);
> > -	kobject_put(kobj->parent);
> >  	kobj->parent = NULL;
> >  }
> > +
> > +/**
> > + * kobject_del() - Unlink kobject from hierarchy.
> > + * @kobj: object.
> > + *
> > + * This is the function that should be called to delete an object
> > + * successfully added via kobject_add().
> > + */
> > +void kobject_del(struct kobject *kobj)
> > +{
> > +	struct kobject *parent = kobj->parent;
> > +
> > +	__kobject_del(kobj);
> > +	kobject_put(parent);
> 
> Could you please add an extra check on kobj before accessing kobj->parent?

Sure, please just send a patch for this.

thanks,

greg k-h

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 453AE11D627
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 19:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbfLLSrk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 13:47:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47717 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728173AbfLLSrj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 13:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576176458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LxLk3eg2Es8W+l1JQOAktx5N9PKbv0TgxxD+ocFBGR4=;
        b=ctDyjL3iR6iAUFwLbYYnZf2HbAbVTfAq6QBOToodLwEZlBzux51rbVe+2beA6Z1aQdA1Ry
        OTZ+cHVlujH/N/0OF11KipQLkVjgUAPHuCnvOe+EZeH+ubn08TD9OssL3NERHizh3jvGed
        n5aWZnNlBNTUEWVXd1QQRS6zpTKiwcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-0m2MbMipPEa_1LIDDeuPmw-1; Thu, 12 Dec 2019 13:47:30 -0500
X-MC-Unique: 0m2MbMipPEa_1LIDDeuPmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A668E1800D63;
        Thu, 12 Dec 2019 18:47:28 +0000 (UTC)
Received: from treble (ovpn-123-178.rdu2.redhat.com [10.10.123.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F7645C219;
        Thu, 12 Dec 2019 18:47:27 +0000 (UTC)
Date:   Thu, 12 Dec 2019 12:47:25 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Dec 6 (objtool, lots in btrfs)
Message-ID: <20191212184725.db3ost7rcopotr5u@treble>
References: <20191206135406.563336e7@canb.auug.org.au>
 <cd4091e4-1c04-a880-f239-00bc053f46a2@infradead.org>
 <20191211134929.GL3929@twin.jikos.cz>
 <c751bc1a-505c-5050-3c4c-c83be81b4e48@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c751bc1a-505c-5050-3c4c-c83be81b4e48@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 11, 2019 at 08:21:38AM -0800, Randy Dunlap wrote:
> [oops, forgot to add Josh and PeterZ]
> 
> On 12/11/19 5:49 AM, David Sterba wrote:
> > On Fri, Dec 06, 2019 at 08:17:30AM -0800, Randy Dunlap wrote:
> >> On 12/5/19 6:54 PM, Stephen Rothwell wrote:
> >>> Hi all,
> >>>
> >>> Please do not add any material for v5.6 to your linux-next included
> >>> trees until after v5.5-rc1 has been released.
> >>>
> >>> Changes since 20191204:
> >>>
> >>
> >> on x86_64:
> >>
> >> fs/btrfs/ctree.o: warning: objtool: btrfs_search_slot()+0x2d4: unreachable instruction
> > 
> > Can somebody enlighten me what is one supposed to do to address the
> > warnings? Function names reported in the list contain our ASSERT macro
> > that conditionally calls BUG() that I believe is what could cause the
> > unreachable instructions but I don't see how.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/btrfs/ctree.h#n3113
> > 
> > __cold
> > static inline void assfail(const char *expr, const char *file, int line)
> > {
> > 	if (IS_ENABLED(CONFIG_BTRFS_ASSERT)) {
> > 		pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
> > 		BUG();
> > 	}
> > }
> > 
> > #define ASSERT(expr)	\
> > 	(likely(expr) ? (void)0 : assfail(#expr, __FILE__, __LINE__))
> > 

Randy, can you share one of the btrfs .o files?  I'm not able to
recreate.

-- 
Josh


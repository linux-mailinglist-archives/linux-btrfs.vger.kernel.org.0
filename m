Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C6B37160B
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 15:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhECNiI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 09:38:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:36896 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233550AbhECNiH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 May 2021 09:38:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 34E1CB08C;
        Mon,  3 May 2021 13:37:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C8051DA783; Mon,  3 May 2021 15:34:47 +0200 (CEST)
Date:   Mon, 3 May 2021 15:34:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>
Subject: Re: [PATCH] btrfs: fix unmountable seed device after fstrim
Message-ID: <20210503133447.GH7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        fdmanana@gmail.com, linux-btrfs <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>
References: <c7715d09a67f212e0ecb5fea2d598513912092f4.1619443900.git.anand.jain@oracle.com>
 <d6fcae756c5ce47da3527e5db4760d676420d950.1619783910.git.anand.jain@oracle.com>
 <CAL3q7H4Nt6Z5B5ZtqFgjR-=hDH+RhZe0XrWE27zvFpq90VNpMQ@mail.gmail.com>
 <8a545d8d-0bdd-4cf5-1a65-fbdbeecb9b33@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a545d8d-0bdd-4cf5-1a65-fbdbeecb9b33@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 30, 2021 at 08:48:56PM +0800, Anand Jain wrote:
> On 30/4/21 8:14 pm, Filipe Manana wrote:
> > On Fri, Apr 30, 2021 at 1:03 PM Anand Jain <anand.jain@oracle.com> wrote:
> > 
> > The fix looks good. Don't feel forced to address the style comments
> > above, consider them more a recommendation for the future.
> > 
> 
> Yep. Thanks.
>   Also, I have missed the re-roll count and its log here.
>   I will just mention that here.
>      v2:
>         Fix commit changelog.
>         Drop a code comment.
> If David needs, I don't mind resending with these changes.

Not needed, I'm often adjusting changelog formatting so I'd do the
suggested fixups anyway. Patch added to misc-next, thanks.

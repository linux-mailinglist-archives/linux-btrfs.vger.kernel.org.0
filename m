Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACDA3ABDA8
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jun 2021 22:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhFQUpM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Jun 2021 16:45:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53274 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhFQUpM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Jun 2021 16:45:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A6F0021AE5;
        Thu, 17 Jun 2021 20:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623962583;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OGEp0cDQadP0R2dzXlH4D/NolWpubUGq8lT4saxX5Sk=;
        b=ZIv5mGaSJhkPmbf8t9Fpq8IGtpn4ZyERIB15b+3O429fk7hyDgTc4CN23oClHNiXK7QmO4
        KiN2gbebFL8ZkikcAv8bsgANUvSqKw/+UvGllYp1yRyWojBoGWtno8GrMOFhEgY3ScV5kg
        zw3SliG1HPC4P9gK4h+RMmnRuV2r5FA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623962583;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OGEp0cDQadP0R2dzXlH4D/NolWpubUGq8lT4saxX5Sk=;
        b=rIkWCo8R5R9SJkaaZYHKfbqp5kxJB2pEz5GvTBtKzZcaC9qwXV95YxVyiITwrSkfxFJcZx
        6LMgGhP9L05FW+DQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9D083A3B85;
        Thu, 17 Jun 2021 20:43:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 65A43DAF4C; Thu, 17 Jun 2021 22:40:15 +0200 (CEST)
Date:   Thu, 17 Jun 2021 22:40:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 00/30] btrfs: add data write support for subpage
Message-ID: <20210617204015.GA28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210531085106.259490-1-wqu@suse.com>
 <55ba3489-98de-3a69-8912-3a32e73ffca4@oracle.com>
 <a1a2aebb-759d-35a2-ade0-3a0119346166@gmx.com>
 <b1eed283-af02-8052-40f4-b671ee17ac6f@oracle.com>
 <d973de78-ae22-b3b6-be6f-b023a60ee90e@gmx.com>
 <c385d55b-c77c-b831-03ac-d4b4c8a6243c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c385d55b-c77c-b831-03ac-d4b4c8a6243c@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 08, 2021 at 07:11:03PM +0800, Anand Jain wrote:
> 
> Thanks for clarifying. I wasted too much time figuring out what's wrong 
> with my setup. It wasn't explicit in the cover letter.
> In that case, there is no regression in this set (plus with a bug fix 
> patch as below). My Apologies to send this late:
> 
>   Tested-by: Anand Jain <anand.jain@oracle.com> [aarch64]

Thanks for testing, I've updated the patches with the tag.

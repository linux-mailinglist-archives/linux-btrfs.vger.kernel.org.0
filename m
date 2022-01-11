Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC1F48B186
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 17:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349780AbiAKQDO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 11:03:14 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56906 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240042AbiAKQDN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 11:03:13 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B326D1F3B8;
        Tue, 11 Jan 2022 16:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641916992;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ldu4A3pYDTTJc5H5rWr6FAJHyMfjBagZNjgGZhXdbTA=;
        b=t3zXmCvwNDjtMug4qnlFXke8zWRlrtb6jFOk9jhtGBctvWYiCB69IPHlLT+B/B2CjKckC5
        Cpg661tqOvEkfORvHvqedarIwTerhMc5TC1i/5dlFWujQZ0GLN5+Sj+6bKVzfOOnL5KLo0
        DiznXBoQh9vh8PAg1QcaC71ogxiLUzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641916992;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ldu4A3pYDTTJc5H5rWr6FAJHyMfjBagZNjgGZhXdbTA=;
        b=kQWhzX+IwK7Hp+k3FdsQ5gmHFRogW8rDBU42Bzn2mOMxan4X4twofMEBug/KXXdv/yfgDc
        ZDmkjycSURdaRsBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AAC9EA3B83;
        Tue, 11 Jan 2022 16:03:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BAEBBDA7A9; Tue, 11 Jan 2022 17:02:39 +0100 (CET)
Date:   Tue, 11 Jan 2022 17:02:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Remi Gauvin <remi@georgianit.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Case for "datacow-forced" option
Message-ID: <20220111160239.GQ14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>,
        Remi Gauvin <remi@georgianit.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <42e747ca-faf1-ed7c-9823-4ab333c07104@georgianit.com>
 <CAJCQCtR6_65_38PFp49_0HuH5-zd5Sf7C-B8tyYQ4oGNKNg0-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtR6_65_38PFp49_0HuH5-zd5Sf7C-B8tyYQ4oGNKNg0-A@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 09, 2022 at 09:37:52AM -0700, Chris Murphy wrote:
> On Fri, Jan 7, 2022 at 6:30 PM Remi Gauvin <remi@georgianit.com> wrote:
> I know that zoned disallows nodatacow, but I have no idea what happens
> to files being copied over with file attribute C. Does the entire copy
> fail or just an error when trying to set chattr +C on the file while
> it's still zero length.

If it's plain copy, ther'es no difference, but if it's based on reflink
then the new file will be created without the +C flag and reflink won't
work, leaving a 0 size file.

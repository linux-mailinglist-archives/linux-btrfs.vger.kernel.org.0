Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC54E13DCE0
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 15:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgAPOCn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 09:02:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:47012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgAPOCn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 09:02:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DC6AEB133;
        Thu, 16 Jan 2020 14:02:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 09B0DDA791; Thu, 16 Jan 2020 15:02:27 +0100 (CET)
Date:   Thu, 16 Jan 2020 15:02:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Scrub resume regression
Message-ID: <20200116140227.GV3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>,
        linux-btrfs@vger.kernel.org
References: <d0a97688-78be-08de-ca7d-bcb4c7fb397e@cobb.uk.net>
 <20200115125134.GN3929@twin.jikos.cz>
 <5aa23833-d1e2-fe6f-7c6e-f366d3eccbe3@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5aa23833-d1e2-fe6f-7c6e-f366d3eccbe3@applied-asynchrony.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 15, 2020 at 02:10:42PM +0100, Holger Hoffstätte wrote:
> On 1/15/20 1:51 PM, David Sterba wrote:
> >> It is important that scrub always returns the stats, even when it
> >> returns an error. This is critical for cancel, as that is how
> >> cancel/resume works, but it should also apply in case of other errors so
> >> that the user can see how much of the scrub was done before the fatal error.
> > 
> > That's something we need to document in code and perhaps in the manual
> > pages too.
> 
> Isn't the real problem that cancel does not actually mean cancel,
> but rather also implies "..and maybe continue"? IMHO cancel should cancel
> (and say how much work was performed), while the intention to resume should
> be called e.g. "pause". This makes the behaviour clear and prevents
> accidental semantic overlap.

We can add 'pause', but for backward compatibility, cancel has to stay
as is. I personally think that saving the last position after cancel is
not a big deal. With 'pause' it will be less confusing for users and
will have also parity with balance commands.

start - pause - resume
start - cancel

One difference is that cancelling balance will also delete the state
(stored inside the filesystem metadata). If scrub start follows cancel,
the state is reset at the beginning. I'm not sure if adding an extra
option eg. 'scrub cancel --reset' is worth.

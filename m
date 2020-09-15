Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3497926AC0C
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 20:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgIOSer convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 15 Sep 2020 14:34:47 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42888 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgIOSel (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 14:34:41 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id F0D9A8050A0; Tue, 15 Sep 2020 14:34:38 -0400 (EDT)
Date:   Tue, 15 Sep 2020 14:34:38 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     dsterba@suse.cz, A L <mail@lechevalier.se>,
        linux-btrfs@vger.kernel.org
Subject: Re: Changes in 5.8.x cause compsize/bees failure
Message-ID: <20200915183438.GG5890@hungrycats.org>
References: <632b888d-a3c3-b085-cdf5-f9bb61017d92@lechevalier.se>
 <20200915081725.GH1791@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200915081725.GH1791@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 15, 2020 at 10:17:25AM +0200, David Sterba wrote:
> On Sat, Sep 12, 2020 at 07:13:21PM +0200, A L wrote:
> > I noticed that in (at least 5.8.6 and 5.8.8) there is some change in 
> > Btrfs kernel code that cause them to fail.
> > 
> > For example compsize now often/usually fails with: "Regular extent's 
> > header not 53 bytes (0) long?!?"
> > 
> > Bees is having plenty of errors too, and does not succeed to read any 
> > files (hash db is always empty). Perhaps this is an unrelated problem?
> 
> The fix is now in stable queue, to be released in 5.8.10. Thanks for the
> report!

And hopefully 5.4?  5.4.64 is also affected (and also fixed by Filipe's
patch).
